//Uses Raylib for graphics
//Uses Bullet 3D for physics
//Written by Andy P.

#include "src/btBulletDynamicsCommon.h"
#include "src/btBulletCollisionCommon.h"

#include "raylib.h"

#include <vector>

btDefaultCollisionConfiguration* collisionConfig;
btCollisionDispatcher* dispatcher;
btBroadphaseInterface* broadphase;
btSequentialImpulseConstraintSolver* solver;
btDiscreteDynamicsWorld* world;

btAlignedObjectArray<btCollisionShape*> collision_shapes;

enum SHAPETYPE
{
	CUBE,
	SPHERE
};

enum PHYSICSTYPE
{
	STATIC,
	DYNAMIC
};

class PhysicsObject
{
	private:
		btRigidBody* body;
		btCollisionShape* b_shape;
		Model model;

	public:
		Color color;

		PhysicsObject(Vector3 position = { 0,0,0 }, Vector3 rotation = { 0,0,0 }, Vector3 size = { 0,0,0 },
					 SHAPETYPE shape = CUBE, PHYSICSTYPE type = STATIC, float mass = 0, Color color=WHITE)
		{
			this->color = color;

			if (shape == CUBE)
			{
				b_shape = new btBoxShape(btVector3(btScalar(size.x / 2.0), btScalar(size.y / 2.0), btScalar(size.z / 2.0)));
				model = LoadModelFromMesh(GenMeshCube(size.x, size.y, size.z));
			}
			else if (shape == SPHERE)
			{
				b_shape = new btSphereShape(btScalar(size.x));

				model = LoadModelFromMesh(GenMeshSphere(size.x, 8, 16));
			}

			collision_shapes.push_back(b_shape);

			btTransform transform;
			transform.setIdentity();
			transform.setOrigin(btVector3(position.x, position.y, position.z));
			transform.setRotation(btQuaternion(btScalar(rotation.z), btScalar(rotation.y), btScalar(rotation.x)));

			btScalar object_mass(mass);

			btVector3 local_inertia(0, 0, 0);
			if (type == DYNAMIC || mass != 0.0)
			{
				b_shape->calculateLocalInertia(mass, local_inertia);
			}

			btDefaultMotionState* motion = new btDefaultMotionState(transform);

			btRigidBody::btRigidBodyConstructionInfo rb_info(object_mass, motion, b_shape, local_inertia);
			body = new btRigidBody(rb_info);

			world->addRigidBody(body);
		}

		void render()
		{
			const float radian_scale = 57.296;
			btTransform trans;

			if (body && body->getMotionState())
			{
				body->getMotionState()->getWorldTransform(trans);
			}
			else
			{
				return;
			}

			Vector3 position = { float(trans.getOrigin().getX()), float(trans.getOrigin().getY()), float(trans.getOrigin().getZ()) };

			btQuaternion quat = trans.getRotation();

			Vector3 axis = { float(quat.getAxis().getX()), float(quat.getAxis().getY()), float(quat.getAxis().getZ()) };
			float angle = float(quat.getAngle()) * radian_scale;

			DrawModelEx(model, position, axis, angle, { 1,1,1 }, color);
			DrawModelWiresEx(model, position, axis, angle, { 1,1,1 }, { (unsigned char)(color.r / 2), (unsigned char)(color.g / 2), (unsigned char)(color.b / 2), color.a });
		}

		void unload()
		{
			UnloadModel(model);
		}
};

int main(int argc, char* argv[])
{
	const int WIDTH = 1200;
	const int HEIGHT = 720;
	const int FPS = 60;

	SetConfigFlags(FLAG_MSAA_4X_HINT);
	InitWindow(WIDTH, HEIGHT, "Raylib Physics Test");

	Camera3D camera = { 0 };
	camera.position = { 10.0f,5.0f,10.0f };
	camera.target = { 0.0f,0.0f,0.0f };
	camera.up = { 0.0f,1.0f,0.0f };
	camera.fovy = 60.0f;
	camera.projection = CAMERA_PERSPECTIVE;

	SetTargetFPS(FPS);

	collisionConfig = new btDefaultCollisionConfiguration();
	dispatcher = new btCollisionDispatcher(collisionConfig);
	broadphase = new btDbvtBroadphase();
	solver = new btSequentialImpulseConstraintSolver();
	world = new btDiscreteDynamicsWorld(dispatcher, broadphase, solver, collisionConfig);

	world->setGravity(btVector3(0, -10, 0));

	std::vector<PhysicsObject> objects;
	objects = { PhysicsObject({0,0,0}, {0,0,0},{10,0,8.8}, CUBE,STATIC,0.0,GRAY) };

	for (size_t i = 0; i < 100; i++)
	{
			const std::vector<Color> colors {RED,GREEN,BLUE};

			objects.push_back(
				(PhysicsObject(
					{ (float)GetRandomValue(-5,5), (float)GetRandomValue(10,15), (float)GetRandomValue(-5,5) },
					{ (float)GetRandomValue(-3,3), (float)GetRandomValue(-3,3), (float)GetRandomValue(-3,3) },
					{ (float)GetRandomValue(1,3), (float)GetRandomValue(1,3), (float)GetRandomValue(1,3) },
					(SHAPETYPE)GetRandomValue(0, 1),
					DYNAMIC, 1.0,
					colors[GetRandomValue(0, colors.size() - 1)]
				))
			);
	}


	while (!WindowShouldClose())
	{
			UpdateCamera(&camera, CAMERA_ORBITAL);

			if (IsMouseButtonPressed(MOUSE_LEFT_BUTTON))
			{
				objects.push_back(PhysicsObject({ GetMousePosition().x,GetMousePosition().y,1 }, { -3,3,0 }, { 1,1,1 }, SPHERE, DYNAMIC, 0.5, MAGENTA));
			}

			if (IsKeyPressed(KEY_Z))
			{
				objects.push_back(PhysicsObject({ -1,10,1 }, { -1,1,0 }, { 1,1,1 }, CUBE, DYNAMIC, 0.5, GREEN));
			}

			if (IsKeyPressed(KEY_X))
			{
				objects.push_back(PhysicsObject({ 1,10,1 }, { 1,1,1 }, { 1,1,1 }, SPHERE, DYNAMIC, 0.5, GRAY));
			}

			world->stepSimulation(1.0 / float(FPS), 10);

		BeginDrawing();

		ClearBackground(BLACK);

		BeginMode3D(camera);

		for (auto& object : objects)
		{
			object.render();
		}

		DrawGrid(10, 1.0);

		EndMode3D();

		DrawFPS(1, 1);

		EndDrawing();
	}

	for (int i = world->getNumCollisionObjects() - 1; i >= 0; i--)
	{
		btCollisionObject* obj = world->getCollisionObjectArray()[i];
		btRigidBody* body = btRigidBody::upcast(obj);
		if (body && body->getMotionState())
		{
			delete body->getMotionState();
		}
		world->removeCollisionObject(obj);
		delete obj;
	}

	for (int i = 0; i < collision_shapes.size(); i++)
	{
		btCollisionShape* shape = collision_shapes[i];
		collision_shapes[i] = 0;
		delete shape;
	}

	for (auto& object : objects)
	{
		object.unload();
	}

	delete world;
	delete solver;
	delete broadphase;
	delete dispatcher;
	delete collisionConfig;

	CloseWindow();

	return 0;
}
