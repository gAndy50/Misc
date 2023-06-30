#include <iostream>

#include <irrlicht.h>

#include <btBulletDynamicsCommon.h>
#include <BulletSoftBody/btSoftRigidDynamicsWorld.h>
#include <BulletSoftBody/btSoftBodyHelpers.h>
#include <BulletSoftBody/btDeformableBodySolver.h>
#include <BulletSoftBody/btDeformableMultiBodyDynamicsWorld.h>
#include <BulletSoftBody/btSoftBodyRigidBodyCollisionConfiguration.h>

using namespace irr;
using namespace core;
using namespace video;
using namespace scene;
using namespace io;
using namespace gui;

//Event class for input handling
class InputEventHandler : public IEventReceiver
{
public:
	virtual bool OnEvent(const SEvent& event)
	{
		if (event.EventType == irr::EET_KEY_INPUT_EVENT)
		{
			KeyIsDown[event.KeyInput.Key] = event.KeyInput.PressedDown;

			return false;
		}
	}

	virtual bool IsKeyDown(EKEY_CODE keyCode) const
	{
		bool ret = KeyIsDown[keyCode];
		return ret;
	}

	virtual void Reset(EKEY_CODE keyCode)
	{
		KeyIsDown[keyCode] = false;
	}

	InputEventHandler()
	{
		for (u32 i = 0; i < KEY_KEY_CODES_COUNT; ++i)
		{
			KeyIsDown[i] = false;
		}
	}

private:
	bool KeyIsDown[KEY_KEY_CODES_COUNT];
};

btDefaultCollisionConfiguration* collisionConfig;
btCollisionDispatcher* dispatcher;
btBroadphaseInterface* broadphase;
btSequentialImpulseConstraintSolver* solver;
btDiscreteDynamicsWorld* world;

btSoftBodyWorldInfo softBodyWorld;
btDeformableBodySolver* deform_solver;
btDeformableMultiBodyDynamicsWorld* deform_world;
btDeformableMultiBodyConstraintSolver* deform_sol;

btAlignedObjectArray<btCollisionShape*> collide_shapes;

int lastFPS = -1;
ISceneManager* Smgr;
IVideoDriver* Driver;
btSoftBody* cloth;

void InitPhysics();
void ExitPhysics();
void StepPhysics(float timeStep);

void PhysicsGround();
void AddBox(ISceneManager* Smgr, IVideoDriver* Driver);
void AddSphere(ISceneManager* Smgr, IVideoDriver* Driver);

void DrawPhysicsObjects();
void DrawSoftBodies();
void DrawDeformPhysics();

void addChain(int chainCount, const btVector3& suspensionPoint, ISceneManager* Smgr, IVideoDriver* Driver);

//void addSoftBody(const btScalar s, const int numX, const int numY, const int fixed = 3);

void ShootBox(ISceneManager* Smgr, IVideoDriver* Driver, vector3df& position, vector3df& lookat);
void ShootSphere(ISceneManager* Smgr, IVideoDriver* Driver, vector3df& position, vector3df& lookat);

btBoxShape* createBoxShape(const btVector3& halfExtents)
{
	btBoxShape* box = new btBoxShape(halfExtents);
	return box;
}

btSphereShape* createSphereShape(btScalar radius)
{
	btSphereShape* sphere = new btSphereShape(radius);
	return sphere;
}

btRigidBody* createRigidBody(btDiscreteDynamicsWorld* world, float mass, const btTransform& transform, btCollisionShape* shape, const btVector4& color = btVector4(1, 0, 0, 1))
{
	btAssert((!shape || shape->getShapeType() != INVALID_SHAPE_PROXYTYPE));

	bool isDynamic = (mass != 0.f);

	btVector3 localInertia(0, 0, 0);
	if (isDynamic)
		shape->calculateLocalInertia(mass, localInertia);

#define USE_MOTIONSTATE 1
#ifdef USE_MOTIONSTATE
	btDefaultMotionState* motionState = new btDefaultMotionState(transform);
	
	btRigidBody::btRigidBodyConstructionInfo info(mass, motionState, shape, localInertia);

	btRigidBody* body = new btRigidBody(info);
#else
	btRigidBody* body = new btRigidBody(mass, 0, shape, localInertia);
#endif

	body->setUserIndex(-1);
	world->addRigidBody(body);
	return body;
}

void addSoftBody(const btScalar& s, const int numX, const int numY, const int fixed = 3)
{
	cloth = btSoftBodyHelpers::CreatePatch(softBodyWorld,
		btVector3(-s / 2, s + 1, 0),
		btVector3(+s / 2, s + 1, 0),
		btVector3(-s / 2, s + 1, +s),
		btVector3(+s / 2, s + 1, +s),
		numX, numY, fixed, true);

	cloth->getCollisionShape()->setMargin(0.0001f);
	btSoftBody::Material* pm = cloth->appendMaterial();
	pm->m_kLST = 0.004;
	pm->m_kAST = 0.004;
	pm->m_kVST = 0.004;
	cloth->generateBendingConstraints(2, pm);
	cloth->setTotalMass(39);
	cloth->m_cfg.kKHR = 1;
	cloth->m_cfg.kCHR = 1;
	cloth->m_cfg.kDF = 3;
	cloth->m_cfg.collisions = btSoftBody::fCollision::SDF_RD;
	cloth->m_cfg.collisions |= btSoftBody::fCollision::SDF_RDF;
	cloth->m_cfg.collisions |= btSoftBody::fCollision::VF_DD;

	cloth->m_cfg.piterations = 2;
	cloth->m_cfg.kDP = 0.0008f;
	cloth->m_cfg.kLF = 0.008;
	cloth->m_cfg.kDG = 0.0006;
	cloth->m_cfg.kKHR = 1;
	cloth->m_cfg.kCHR = 1;
	cloth->m_cfg.kDF = 3;
	cloth->m_cfg.collisions = btSoftBody::fCollision::SDF_RD;
	cloth->m_cfg.collisions |= btSoftBody::fCollision::SDF_RDF;
	cloth->m_cfg.collisions |= btSoftBody::fCollision::VF_DD;
	cloth->m_cfg.aeromodel = btSoftBody::eAeroModel::V_TwoSidedLiftDrag;
	cloth->m_cfg.collisions = btSoftBody::fCollision::CL_SS + btSoftBody::fCollision::CL_RS;

	cloth->generateClusters(30e7);

	cloth->setWindVelocity(btVector3(20, -90.0, -9.0));

	((btSoftRigidDynamicsWorld*)world)->addSoftBody(cloth);

	IAnimatedMesh* hillPlaneMesh = Smgr->addHillPlaneMesh("Curtain",
		core::dimension2d<f32>(4, 4),
		core::dimension2d<u32>(numX - 1, numY - 1), 0, 0,
		core::dimension2d<f32>(0, 0),
		core::dimension2d<f32>(10, 10));

	ISceneNode* Node = Smgr->addAnimatedMeshSceneNode(hillPlaneMesh);
	Node->setMaterialTexture(0, Driver->getTexture("media/wall.bmp"));
	Node->setMaterialFlag(video::EMF_LIGHTING, false);
	Node->setMaterialFlag(video::EMF_BACK_FACE_CULLING, false);
	Node->setPosition(core::vector3df(0, -40, 0));

	cloth->setUserPointer(hillPlaneMesh);
	IMeshBuffer* buffer = hillPlaneMesh->getMeshBuffer(0);
}

int main(int argc, char* argv[])
{
	InputEventHandler receiver;
	IrrlichtDevice* Device = createDevice(video::EDT_DIRECT3D9, dimension2d<u32>(1024, 720), 32, false, false, false, &receiver);

	if (!Device)
		return 1;

	 Driver = Device->getVideoDriver();
	 Smgr = Device->getSceneManager();
	gui::IGUIEnvironment* Env = Device->getGUIEnvironment();

	InitPhysics();

	PhysicsGround();

	ICameraSceneNode* Camera;

	Device->setWindowCaption(L"Irrlicht Bullet Physics");

	//The ground
	IAnimatedMesh* hillPlaneMesh = Smgr->addHillPlaneMesh("myHill", dimension2d<f32>(30, 30), dimension2d<u32>(10, 10), 0, 0, dimension2d<f32>(0, 0), dimension2d<f32>(10, 10));
	ISceneNode* planeNode = Smgr->addAnimatedMeshSceneNode(hillPlaneMesh);
	planeNode->setMaterialTexture(0, Driver->getTexture("D:/Github/irrlicht-1.8.5/media/stones.jpg"));
	planeNode->setMaterialFlag(video::EMF_LIGHTING, false);
	planeNode->setPosition(core::vector3df(0, -55, 0));

	Camera = Smgr->addCameraSceneNodeFPS(0, 20.0f, 0.02f);
	Camera->setPosition(vector3df(0, 10, -200));
	Device->getCursorControl()->setVisible(true);

	u32 then = Device->getTimer()->getTime();

	while (Device->run() && Driver)
	{
		const u32 now = Device->getTimer()->getTime();
		DrawPhysicsObjects();
		DrawSoftBodies();

		if (receiver.IsKeyDown(KEY_ESCAPE))
			break;

		if (receiver.IsKeyDown(KEY_KEY_Z))
		{
			AddBox(Smgr, Driver);
			receiver.Reset(KEY_KEY_Z);
		}

		if (receiver.IsKeyDown(KEY_KEY_X))
		{
			AddSphere(Smgr, Driver);
			receiver.Reset(KEY_KEY_X);
		}

		if (receiver.IsKeyDown(KEY_KEY_C))
		{
			vector3df lookat = Camera->getTarget();
			vector3df pose = Camera->getPosition();
			ShootBox(Smgr, Driver, pose, (lookat - pose).normalize());
			receiver.Reset(KEY_KEY_C);
		}

		if (receiver.IsKeyDown(KEY_KEY_H))
		{
			addChain(10, btVector3(10 + (-30 + rand() % 100), 10, 20 + (10 + rand() % 30)), Smgr, Driver);
			receiver.Reset(KEY_KEY_H);
		}

		if (receiver.IsKeyDown(KEY_KEY_A))
		{
			receiver.Reset(KEY_KEY_C);
			if (!cloth)
				addSoftBody(4 * 20, 20, 20);
		}

		if (receiver.IsKeyDown(KEY_KEY_W))
		{
			if (cloth)
				if (cloth->getWindVelocity().x() == 0)
					cloth->setWindVelocity(btVector3(25, -90.0, -29.0));
				else
					cloth->setWindVelocity(btVector3(0., 0.0, 0.0));

			receiver.Reset(KEY_KEY_W);
		}

		if (receiver.IsKeyDown(KEY_KEY_V))
		{
			vector3df lookat = Camera->getTarget();
			vector3df pose = Camera->getPosition();
			ShootSphere(Smgr, Driver, pose, (lookat - pose).normalize());
			receiver.Reset(KEY_KEY_V);
		}

		Driver->beginScene(true, true, video::SColor(255, 0, 0, 255));
		Smgr->drawAll();
		Env->drawAll();

		Driver->endScene();

		int fps = Driver->getFPS();
		if (lastFPS != fps)
		{
			stringw str = L"Irrhct Bullet Physics [";
			str += Driver->getName();
			str += "] FPS:";
			str += fps;
			Device->setWindowCaption(str.c_str());
			lastFPS = fps;
		}
		const f32 frameDeltaTime = (f32)(now - then) / 1000.f;
		//Step physics
		StepPhysics(frameDeltaTime);
		then = now;
	}

	Device->drop();

	ExitPhysics();

	return 0;
}

void InitPhysics()
{
	collisionConfig = new btSoftBodyRigidBodyCollisionConfiguration();
	dispatcher = new btCollisionDispatcher(collisionConfig);
	broadphase = new btDbvtBroadphase();
	solver = new btSequentialImpulseConstraintSolver();
	world = new btSoftRigidDynamicsWorld(dispatcher, broadphase, solver, collisionConfig);
	
	world->setGravity(btVector3(0, -10, 0));
	world->getDispatchInfo().m_enableSPU = true;

	deform_solver = new btDeformableBodySolver();
	deform_sol = new btDeformableMultiBodyConstraintSolver();
	deform_sol->setDeformableSolver(deform_solver);

	deform_world = new btDeformableMultiBodyDynamicsWorld(dispatcher, broadphase, deform_sol, collisionConfig, deform_solver);

	softBodyWorld.m_broadphase = broadphase;
	softBodyWorld.m_dispatcher = dispatcher;
	softBodyWorld.m_gravity = world->getGravity();
	softBodyWorld.m_sparsesdf.Initialize();
}

void PhysicsGround()
{
	btCollisionShape* groundShape = new btBoxShape(btVector3(btScalar(150.), btScalar(1.), btScalar(150.)));

	collide_shapes.push_back(groundShape);

	btTransform transform;
	transform.setIdentity();
	transform.setOrigin(btVector3(0, -56, 0));

	btScalar mass(0.);

	bool isDynamic = (mass != 0.f);

	btVector3 localInertia(0, 0, 0);
	if (isDynamic)
		groundShape->calculateLocalInertia(mass, localInertia);

	btDefaultMotionState* motionState = new btDefaultMotionState(transform);
	btRigidBody::btRigidBodyConstructionInfo info(mass, motionState, groundShape, localInertia);
	btRigidBody* body = new btRigidBody(info);
	body->setUserIndex(5);
	body->setFriction(1);

	world->addRigidBody(body);
}

void AddBox(ISceneManager* Smgr, IVideoDriver* Driver)
{
	btCollisionShape* Shape = createBoxShape(btVector3(5, 5, 5));
	collide_shapes.push_back(Shape);

	btTransform transform;
	transform.setIdentity();

	btScalar mass(3.f);

	transform.setOrigin(btVector3(rand() % 10, rand() % 40, rand() % 20));
	btQuaternion quat(btVector3(0.4, .02, .1), 67);
	transform.setRotation(quat);

	btRigidBody* body = createRigidBody(world, mass, transform, Shape);
	body->setFriction(1);
	body->setUserIndex(10);

	IMeshSceneNode* cubeNode = Smgr->addCubeSceneNode(10.0f, NULL, -1, vector3df(0, 3, 10));
	cubeNode->setMaterialType(EMT_SOLID);
	cubeNode->setMaterialTexture(0, Driver->getTexture("D:/Github/irrlicht-1.8.5/media/wall.jpg"));
	cubeNode->setMaterialFlag(video::EMF_LIGHTING, false);
	cubeNode->setVisible(false);

	body->setUserPointer(cubeNode);
}

void AddSphere(ISceneManager* Smgr, IVideoDriver* Driver)
{
	btCollisionShape* Shape = createSphereShape(btScalar(5));
	collide_shapes.push_back(Shape);

	btTransform transform;
	transform.setIdentity();

	btScalar mass(10.f);

	transform.setOrigin(btVector3(rand() % 5, rand()% 40,rand() % 20));
	btQuaternion quat(btVector3(0.4, .02, .1), 67);
	transform.setRotation(quat);

	btRigidBody* body = createRigidBody(world, mass, transform, Shape);
	body->setFriction(2);
	body->setUserIndex(10);

	IMeshSceneNode* sphereNode = Smgr->addSphereSceneNode(10.0f, 32);
	sphereNode->setMaterialType(video::EMT_TRANSPARENT_ADD_COLOR);
	sphereNode->setMaterialTexture(0, Driver->getTexture("D:/Github/irrlicht-1.8.5/media/water.jpg"));
	sphereNode->setMaterialFlag(video::EMF_LIGHTING, false);
	sphereNode->setVisible(false);

	body->setUserPointer(sphereNode);
}

void addChain(int chainCount, const btVector3& suspensionPoint, ISceneManager* Smgr, IVideoDriver* Driver)
{
	btBoxShape* Shape = createBoxShape(btVector3(4, 4, 1));

	collide_shapes.push_back(Shape);

	btTransform transform;
	transform.setIdentity();

	btScalar mass(1.f);

	bool isDynamic = (mass != 0.f);

	btVector3 localInertia(0, 0, 0);
	if (isDynamic)
		Shape->calculateLocalInertia(mass, localInertia);

	btAlignedObjectArray<btRigidBody*> boxes;
	int lastBox = chainCount - 1;
	for (int i = 0; i < chainCount; ++i)
	{
		transform.setOrigin(btVector3(btScalar(suspensionPoint.x()), btScalar(suspensionPoint.y() + i * 2), btScalar(suspensionPoint.z())));
		boxes.push_back(createRigidBody(world, (i == lastBox) ? 0 : mass, transform, Shape));

		IMeshSceneNode* Node = Smgr->addCubeSceneNode(8.0f, NULL, -1, vector3df(0, 0, 0), vector3df(0, 0, 0), vector3df(1, 1, 0.25f));
		Node->setMaterialType(EMT_SOLID);
		Node->setMaterialTexture(0, Driver->getTexture("D:/Github/irrlicht-1.8.5/media/wall.jpg"));
		Node->setMaterialFlag(video::EMF_LIGHTING, false);
		boxes[i]->setUserPointer(Node);
	}

	for (int i = 0; i < chainCount - 1; ++i)
	{
		btRigidBody* b1 = boxes[i];
		btRigidBody* b2 = boxes[i + 1];

		btPoint2PointConstraint* leftSpring = new btPoint2PointConstraint(*b1, *b2, btVector3(-2, 4, 0), btVector3(-2, -4,0));

		world->addConstraint(leftSpring);

		btPoint2PointConstraint* rightSpring = new btPoint2PointConstraint(*b1, *b2, btVector3(2, 4, 0), btVector3(2, -4, 0));

		world->addConstraint(rightSpring);
	}
}

void ShootBox(ISceneManager* Smgr, IVideoDriver* Driver, vector3df& position, vector3df& lookat)
{
	btCollisionShape* Shape = new btBoxShape(btVector3(5, 5, 5));
	collide_shapes.push_back(Shape);

	btTransform transform;
	transform.setIdentity();

	btScalar mass(6.f);

	bool isDynamic = (mass != 0.f);

	btVector3 localInertia(0, 0, 0);
	if (isDynamic)
		Shape->calculateLocalInertia(mass, localInertia);

	transform.setOrigin(btVector3(position.X, position.Y, position.Z));
	btQuaternion quat(btVector3(0.4, .02, .1), 67);
	transform.setRotation(quat);

	btDefaultMotionState* motionState = new btDefaultMotionState(transform);
	btRigidBody::btRigidBodyConstructionInfo info(mass, motionState, Shape, localInertia);
	btRigidBody* body = new btRigidBody(info);
	body->setUserIndex(10);
	body->setDamping(0.01, 0.01);

	ISceneNode* Node = Smgr->addCubeSceneNode(10.0f, NULL, -1, vector3df(0, 3, 10));
	Node->setMaterialType(EMT_SOLID);
	Node->setMaterialTexture(0, Driver->getTexture("D:/Github/irrlicht-1.8.5/media/wall.jpg"));
	Node->setMaterialFlag(video::EMF_LIGHTING, false);
	Node->setVisible(false);

	body->setUserPointer(Node);
	body->setFriction(1);
	btVector3 force(lookat.X, lookat.Y, lookat.Z);

	world->addRigidBody(body);
	body->applyImpulse(250 * force, btVector3(0., 0., 0.0));
}

void ShootSphere(ISceneManager* Smgr, IVideoDriver* Driver, vector3df& position, vector3df& lookat)
{
	btCollisionShape* Shape = createSphereShape(btScalar(5));
	collide_shapes.push_back(Shape);

	btTransform transform;
	transform.setIdentity();

	btScalar mass(6.f);

	bool isDynamic = (mass != 0.f);

	btVector3 localInertia(0, 0, 0);
	if (isDynamic)
		Shape->calculateLocalInertia(mass, localInertia);

	transform.setOrigin(btVector3(position.X, position.Y, position.Z));
	btQuaternion quat(btVector3(0.4, .02, .1), 67);
	transform.setRotation(quat);

	btDefaultMotionState* motionState = new btDefaultMotionState(transform);
	btRigidBody::btRigidBodyConstructionInfo info(mass, motionState, Shape, localInertia);
	btRigidBody* body = new btRigidBody(info);
	body->setUserIndex(10);
	body->setDamping(0.01, 0.01);

	IMeshSceneNode* sphereNode = Smgr->addSphereSceneNode(10.0f, 32);
	sphereNode->setMaterialType(EMT_SOLID);
	sphereNode->setMaterialTexture(0, Driver->getTexture("D:/Github/irrlicht-1.8.5/media/water.jpg"));
	sphereNode->setMaterialFlag(video::EMF_LIGHTING, false);
	sphereNode->setVisible(false);

	body->setUserPointer(sphereNode);
	body->setFriction(1);
	btVector3 force(lookat.X, lookat.Y, lookat.Z);

	world->addRigidBody(body);
	body->applyImpulse(350 * force, btVector3(0., 0., 0.0));
}

void DrawSoftBodies()
{
	btSoftRigidDynamicsWorld* softWorld = ((btSoftRigidDynamicsWorld*)world);
	btSoftBodyArray sarray = softWorld->getSoftBodyArray();
	if (sarray.size() > 0)
	{
		btSoftBody* psb = (btSoftBody*)sarray[0];
		if (psb)
		{
			IAnimatedMesh* plane = (IAnimatedMesh*)psb->getUserPointer();
			IMeshBuffer* buffer = plane->getMeshBuffer(0);

			for (int i = 0; i < buffer->getVertexCount(); i++)
			{
				const btSoftBody::Node& n = psb->m_nodes[i];
				btVector3 pos = n.m_x;
				btVector3 normal = n.m_n;

				buffer->getPosition(i).X = pos.x();
				buffer->getPosition(i).Y = pos.y();
				buffer->getPosition(i).Z = pos.z();

				buffer->getNormal(i).X = normal.x();
				buffer->getNormal(i).Y = normal.y();
				buffer->getNormal(i).Z = normal.z();
			}
		}
	}
}

void DrawDeformPhysics()
{
	for (int i = 0; i < deform_world->getSoftBodyArray().size(); i++)
	{
		btSoftBody* psb = (btSoftBody*)deform_world->getSoftBodyArray()[i];
	}
}

void DrawPhysicsObjects()
{
	int numObjects = world->getNumCollisionObjects();

	for (int j = numObjects - 1; j >= 0; j--)
	{
		btCollisionObject* obj = world->getCollisionObjectArray()[j];
		btRigidBody* body = btRigidBody::upcast(obj);
		btTransform trans;
		if (body && body->getMotionState())
		{
			body->getMotionState()->getWorldTransform(trans);

			ISceneNode* cube = reinterpret_cast<ISceneNode*>(body->getUserPointer());
			if (cube != NULL)
			{
				btVector3 origin = trans.getOrigin();
				btQuaternion rot = trans.getRotation();
				quaternion q(rot.getX(), rot.getY(), rot.getZ(), rot.getW());
				vector3df Euler;
				q.toEuler(Euler);
				Euler *= RADTODEG;

				cube->setPosition(vector3df(origin.getX(), origin.getY(), origin.getZ()));
				cube->setRotation(Euler);
				cube->setVisible(true);
			}
		}
		else
		{
			trans = obj->getWorldTransform();
		}
	}
}

void StepPhysics(float timeStep)
{
	world->stepSimulation(timeStep * 2, 10);
}

void ExitPhysics()
{
	int i;
	for (i = world->getNumConstraints() - 1; i >= 0; i--)
	{
		world->removeConstraint(world->getConstraint(i));
	}

	for (i = world->getNumCollisionObjects() - 1; i >= 0; i--)
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

	for (int j = 0; j < collide_shapes.size(); j++)
	{
		btCollisionShape* shape = collide_shapes[j];
		collide_shapes[j] = 0;
		delete shape;
	}

	delete world;
	world = 0;
	delete solver;
	solver = 0;
	delete broadphase;
	broadphase = 0;
	delete dispatcher;
	dispatcher = 0;
	delete collisionConfig;
	collisionConfig = 0;

	delete deform_solver;

	collide_shapes.clear();
}
