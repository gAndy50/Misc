#include <iostream>
#include <vector>

#include <irrlicht.h>

#include <btBulletDynamicsCommon.h>

#include <BulletSoftBody/btSoftRigidDynamicsWorld.h>
#include <BulletSoftBody/btSoftBodyHelpers.h>
#include <BulletSoftBody/btSoftBodyRigidBodyCollisionConfiguration.h>

using namespace irr;
using namespace core;
using namespace video;
using namespace io;
using namespace scene; 
using namespace gui;

class InputHandler : public IEventReceiver
{
public:
	virtual bool OnEvent(const SEvent& event)
	{
		if (event.EventType == EET_KEY_INPUT_EVENT)
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

	InputHandler()
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

btAlignedObjectArray<btCollisionShape*> collide_shapes;

int lastFPS = -1;
ISceneManager* Smgr;
IVideoDriver* Driver;
IGUIEnvironment* Env;

class PhysicsM
{
public:
	PhysicsM();
	~PhysicsM();

	void InitSoftPhysics();
	void InitPhysics();
	void StepPhysics(float timeStep);
	void createGroundPhysics(float xRes, float zRes,const btVector3& pos, void* attachedNode);
	void createVehicle();
	void destroyPhysics();
	void updateVehicle();
	void updatePhysics();
	void moveForward();
	void moveBackward();
	void turnLeft();
	void turnRight();
	void setWheelRadius(float radius);
	void setWheelWidth(float width);
	void setChassisSize(const btVector3& size);
	void setAttachedChassisNode(void* chassisAttachedNode) { this->chassisAttachedNode = chassisAttachedNode; }
	void setMaxEnginePower(float power) { maxEngineForce = power; }

	void setAttachedWheelNodes(void* wheel_1_AttachedNode, void* wheel_2_AttachedNode,
		void* wheel_3_AttachedNode, void* wheel_4_AttachedNode)
	{
		this->wheel_1_AttachedNode = wheel_1_AttachedNode;
		this->wheel_2_AttachedNode = wheel_2_AttachedNode;
		this->wheel_3_AttachedNode = wheel_3_AttachedNode;
		this->wheel_4_AttachedNode = wheel_4_AttachedNode;
	}

	void createPhysicsBoxFromEye(vector3df& position, vector3df& lookat, void* attachedNode);

private:
	btRigidBody* localCreateRigidBody(btScalar mass, const btTransform& startTransform, btCollisionShape* shape);

	void* chassisAttachedNode;

	void* wheel_1_AttachedNode;
	void* wheel_2_AttachedNode;
	void* wheel_3_AttachedNode;
	void* wheel_4_AttachedNode;

	btRigidBody* carChassis;
	btRigidBody* groundBody;
	int wheelInstances[4];
	btRaycastVehicle::btVehicleTuning tuning;
	btVehicleRaycaster* vehicleRayCaster;
	btRaycastVehicle* vehicle;
	btCollisionShape* wheelShape;

	int CUBE_HALF_EXTENTS;
	int rightIndex;
	int upIndex;
	int forwardIndex;
	btVector3 wheelDirectionCS0;
	btVector3 wheelAxleCS;
	btVector3 chassisSize;

	bool moveForwardRequested, movebackwardRequested;

	float	gEngineForce;

	float	defaultBreakingForce;
	float	gBreakingForce;

	float	maxEngineForce;//this should be engine/velocity dependent
	float	maxBreakingForce;

	float	gVehicleSteering;
	float	steeringIncrement;
	float	steeringClamp;
	float	wheelRadius;
	float	wheelWidth;
	float	wheelFriction;//BT_LARGE_FLOAT;
	float	suspensionStiffness;
	float	suspensionDamping;
	float	suspensionCompression;
	float	rollInfluence;//1.0f;


	btScalar suspensionRestLength;
};

PhysicsM::PhysicsM(void) : vehicle(nullptr), wheelShape(nullptr), vehicleRayCaster(nullptr)
{
	rightIndex = 0;
	upIndex = 1;
	forwardIndex = 2;
	wheelDirectionCS0 = btVector3(0, -1, 0);
	wheelAxleCS = btVector3(-1, 0, 0);

	gEngineForce = 0.f;
	gBreakingForce = 100.f;

	defaultBreakingForce = 10.f;

	maxEngineForce = 400.f;
	maxBreakingForce = 33.f;

	gVehicleSteering = 0.f;
	steeringIncrement = 0.05f;
	steeringClamp = 0.4f;
	wheelRadius = 0.5f;
	wheelWidth = 0.4f;
	wheelFriction = 400;
	suspensionStiffness = 20.f;
	suspensionDamping = 2.3f;
	suspensionCompression = 4.4f;
	rollInfluence = 0.1f;

	chassisSize = btVector3(1.f, 0.5f, 2.f);
	suspensionRestLength = btScalar(1.1);

	CUBE_HALF_EXTENTS = 1;

	this->chassisAttachedNode = nullptr;
	this->wheel_1_AttachedNode = nullptr;
	this->wheel_2_AttachedNode = nullptr;
	this->wheel_3_AttachedNode = nullptr;
	this->wheel_4_AttachedNode = nullptr;
}

PhysicsM::~PhysicsM(void)
{

}

void PhysicsM::InitPhysics()
{
	collisionConfig = new btDefaultCollisionConfiguration();
	dispatcher = new btCollisionDispatcher(collisionConfig);

	broadphase = new btDbvtBroadphase();

	solver = new btSequentialImpulseConstraintSolver;

	world = new btDiscreteDynamicsWorld(dispatcher, broadphase, solver, collisionConfig);

	world->setGravity(btVector3(0, -10, 0));
}

void PhysicsM::destroyPhysics()
{
	if (world)
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
	}

	for (int j = 0; j < collide_shapes.size(); j++)
	{
		btCollisionShape* shape = collide_shapes[j];
		delete shape;
	}
	collide_shapes.clear();

	delete world;
	world = 0;

	delete vehicleRayCaster;
	vehicleRayCaster = 0;

	delete vehicle;
	vehicle = 0;

	delete wheelShape;
	wheelShape = 0;

	delete solver;
	solver = 0;

	delete broadphase;
	broadphase = 0;

	delete dispatcher;
	dispatcher = 0;

	delete collisionConfig;
	collisionConfig = 0;
}

void PhysicsM::StepPhysics(float timeStep)
{
	if (vehicle)
	{
		int wheelIndex = 2;
		vehicle->applyEngineForce(gEngineForce, wheelIndex);
		vehicle->setBrake(gEngineForce, wheelIndex);
		wheelIndex = 3;
		vehicle->applyEngineForce(gEngineForce, wheelIndex);
		vehicle->setBrake(gBreakingForce, wheelIndex);

		wheelIndex = 0;
		vehicle->setSteeringValue(gVehicleSteering, wheelIndex);
		wheelIndex = 1;
		vehicle->setSteeringValue(gVehicleSteering, wheelIndex);

		if (moveForwardRequested)
		{
			gEngineForce -= 80 * timeStep;
			if (gEngineForce < 0)
			{
				gEngineForce = 0;
				gBreakingForce = maxBreakingForce;
			}
			else
			{
				gEngineForce += 80 * timeStep;
				if (gEngineForce > 0)
				{
					gEngineForce = 0;
					gBreakingForce = maxBreakingForce;
				}
			}
		}
	}

	world->stepSimulation(timeStep, 2);
}

void PhysicsM::createGroundPhysics(float xRes, float zRes,const btVector3& pos, void* attachedNode)
{
	btCollisionShape* groundShape = new btBoxShape(btVector3(btScalar(xRes), btScalar(0.5), btScalar(zRes)));

	collide_shapes.push_back(groundShape);

	btTransform groundTransform;
	groundTransform.setIdentity();
	groundTransform.setOrigin(pos);

	btScalar mass(0.);

	bool isDynamic = (mass != 0.f);

	btVector3 localInertia(0, 0, 0);
	if (isDynamic)
		groundShape->calculateLocalInertia(mass, localInertia);

	btDefaultMotionState* MotionState = new btDefaultMotionState(groundTransform);
	btRigidBody::btRigidBodyConstructionInfo info(mass, MotionState, groundShape, localInertia);
	btRigidBody* body = new btRigidBody(info);

	body->setUserPointer(attachedNode);
	body->setUserIndex(5);
	body->setFriction(1);
	groundBody = body;

	world->addRigidBody(body);
}

void PhysicsM::createVehicle()
{
	int upAxis = 1;

	world->getSolverInfo().m_minimumSolverBatchSize = 128;
	world->getSolverInfo().m_globalCfm = 0.00001;

	btTransform tr;
	tr.setIdentity();
	tr.setOrigin(btVector3(0, 0, 0));

	CUBE_HALF_EXTENTS = chassisSize.x();
	btCollisionShape* chassisShape = new btBoxShape(chassisSize);
	collide_shapes.push_back(chassisShape);

	btCompoundShape* compound = new btCompoundShape();
	collide_shapes.push_back(compound);
	btTransform localTrans;
	localTrans.setIdentity();
	localTrans.setOrigin(btVector3(0, 1, 0));

	compound->addChildShape(localTrans, chassisShape);
	{
		btCollisionShape* suppShape = new btBoxShape(btVector3(CUBE_HALF_EXTENTS, 12.f, 2.5));
		btTransform suppLocalTrans;
		suppLocalTrans.setIdentity();
		suppLocalTrans.setOrigin(btVector3(0, 0.50, chassisSize.z() / 2 - 2.5));
		compound->addChildShape(suppLocalTrans, suppShape);
	}

	tr.setOrigin(btVector3(0, -30.f, 100));

	carChassis = localCreateRigidBody(450, tr, compound);
	carChassis->setUserPointer(chassisAttachedNode);

	wheelShape = new btCylinderShapeX(btVector3(wheelWidth, wheelRadius, wheelRadius));

	{
		vehicleRayCaster = new btDefaultVehicleRaycaster(world);
		vehicle = new btRaycastVehicle(tuning, carChassis, vehicleRayCaster);

		carChassis->setActivationState(DISABLE_DEACTIVATION);

		world->addVehicle(vehicle);

		float connectionHeight = -7.0f;

		bool isFrontWheel = true;

		vehicle->setCoordinateSystem(rightIndex, upIndex, forwardIndex);

		btVector3 connectionPointCS0(CUBE_HALF_EXTENTS - (0.3 * wheelWidth), connectionHeight, 2 * CUBE_HALF_EXTENTS - wheelRadius);

		vehicle->addWheel(connectionPointCS0, wheelDirectionCS0, wheelAxleCS, suspensionRestLength, wheelRadius, tuning, isFrontWheel);
		connectionPointCS0 = btVector3(-CUBE_HALF_EXTENTS + (0.3 * wheelWidth), connectionHeight, 2 * CUBE_HALF_EXTENTS - wheelRadius);

		vehicle->addWheel(connectionPointCS0, wheelDirectionCS0, wheelAxleCS, suspensionRestLength, wheelRadius, tuning, isFrontWheel);
		connectionPointCS0 = btVector3(-CUBE_HALF_EXTENTS + (0.3 * wheelWidth), connectionHeight, -2 * CUBE_HALF_EXTENTS + wheelRadius);
		isFrontWheel = false;
		vehicle->addWheel(connectionPointCS0, wheelDirectionCS0, wheelAxleCS, suspensionRestLength, wheelRadius, tuning, isFrontWheel);
		connectionPointCS0 = btVector3(CUBE_HALF_EXTENTS - (0.3 * wheelWidth), connectionHeight, -2 * CUBE_HALF_EXTENTS + wheelRadius);
		vehicle->addWheel(connectionPointCS0, wheelDirectionCS0, wheelAxleCS, suspensionRestLength, wheelRadius, tuning, isFrontWheel);

		for (int i = 0; i < vehicle->getNumWheels(); i++)
		{
			btWheelInfo& wheel = vehicle->getWheelInfo(i);
			wheel.m_suspensionStiffness = suspensionStiffness;
			wheel.m_wheelsDampingRelaxation = suspensionDamping;
			wheel.m_wheelsDampingCompression = suspensionCompression;
			wheel.m_frictionSlip = wheelFriction;
			wheel.m_rollInfluence = rollInfluence;
			wheel.m_raycastInfo.m_groundObject = groundBody;

		}
	}
}

void PhysicsM::updateVehicle() {
	if (vehicle) {
		std::vector<void*> allWheels;
		allWheels.push_back(wheel_1_AttachedNode);
		allWheels.push_back(wheel_2_AttachedNode);
		allWheels.push_back(wheel_3_AttachedNode);
		allWheels.push_back(wheel_4_AttachedNode);

		for (int i = 0; i < vehicle->getNumWheels(); i++)
		{
			//synchronize the wheels with the (interpolated) chassis worldtransform
			vehicle->updateWheelTransform(i, true);

			btTransform tr = vehicle->getWheelInfo(i).m_worldTransform;
			btVector3 pos = tr.getOrigin();
			btQuaternion orn = tr.getRotation();
			quaternion q1(0, 0, 1, PI / 4);
			quaternion q(orn.getX(), orn.getY(), orn.getZ(), orn.getW());

			vector3df Euler;
			q.toEuler(Euler);
			Euler *= RADTODEG;
			//m_vehicle->getWheelInfo(i).m_raycastInfo.m_groundObject = groundBody;
			void* wheel = allWheels.at(i);
			ISceneNode* node = reinterpret_cast<ISceneNode*>(wheel);
			if (node) {
				node->setPosition(vector3df(pos.x(), pos.y(), pos.z()));
				node->setRotation(Euler);

			}


		}
	}
}

void PhysicsM::updatePhysics()
{
	int numOfObjects = world->getNumCollisionObjects();
	for (int j = numOfObjects - 1; j >= 0; j--)
	{
		btCollisionObject* obj = world->getCollisionObjectArray()[j];
		btRigidBody* body = btRigidBody::upcast(obj);
		btTransform trans;
		if (body && body->getMotionState())
		{
			body->getMotionState()->getWorldTransform(trans);

			ISceneNode* cube = reinterpret_cast<ISceneNode*>(body->getUserPointer());
			if (cube != NULL) {//update cubes only
				btVector3 origin = trans.getOrigin();
				//update rotation
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

void PhysicsM::moveForward()
{
	gEngineForce = maxEngineForce;
	gBreakingForce = 0.f;
	moveForwardRequested = true;
}

void PhysicsM::moveBackward()
{
	gEngineForce = -maxEngineForce;
	gBreakingForce = 0.f;
	moveForwardRequested = false;
	movebackwardRequested = true;
}

void PhysicsM::turnRight()
{
	gVehicleSteering += steeringIncrement;
	if (gVehicleSteering > steeringClamp)
		gVehicleSteering = steeringClamp;
}

void PhysicsM::turnLeft()
{
	gVehicleSteering -= steeringIncrement;
	if (gVehicleSteering < -steeringClamp)
		gVehicleSteering = -steeringClamp;
}

void PhysicsM::setWheelRadius(float radius)
{
	this->wheelRadius = radius;
}

void PhysicsM::setWheelWidth(float width)
{
	this->wheelWidth = width;
}

void PhysicsM::setChassisSize(const btVector3& size)
{
	this->chassisSize = size;
}

void PhysicsM::createPhysicsBoxFromEye(vector3df& position, vector3df& lookat, void* attachedNode)
{
	btCollisionShape* colShape = new btBoxShape(btVector3(5, 5, 5));
	collide_shapes.push_back(colShape);

	btTransform Transform;
	Transform.setIdentity();

	btScalar mass(66.f);

	bool isDynamic = (mass != 0.f);

	btVector3 localInertia(0, 0, 0);
	if (isDynamic)
		colShape->calculateLocalInertia(mass, localInertia);

	Transform.setOrigin(btVector3(position.X, position.Y, position.Z));
	btQuaternion quat(btVector3(0.4, .02, 1), 67);
	Transform.setRotation(quat);

	btDefaultMotionState* motionState = new btDefaultMotionState(Transform);
	btRigidBody::btRigidBodyConstructionInfo info(mass, motionState, colShape, localInertia);
	btRigidBody* body = new btRigidBody(info);
	body->setUserIndex(10);
	body->setDamping(0.01, 0.01);

	body->setUserPointer(attachedNode);
	body->setFriction(1);
	btVector3 force(lookat.X, lookat.Y, lookat.Z);

	world->addRigidBody(body);
	body->applyImpulse(1350 * force, btVector3(0., 0., 0.));
}

btRigidBody* PhysicsM::localCreateRigidBody(btScalar mass, const btTransform& startTransform, btCollisionShape* shape)
{
	btAssert((!shape || shape->getShapeType() != INVALID_SHAPE_PROXYTYPE));

	//rigidbody is dynamic if and only if mass is non zero, otherwise static
	bool isDynamic = (mass != 0.f);

	btVector3 localInertia(0, 0, 0);
	if (isDynamic)
		shape->calculateLocalInertia(mass, localInertia);

	//using motionstate is recommended, it provides interpolation capabilities, and only synchronizes 'active' objects

#define USE_MOTIONSTATE 1
#ifdef USE_MOTIONSTATE
	btDefaultMotionState* myMotionState = new btDefaultMotionState(startTransform);

	btRigidBody::btRigidBodyConstructionInfo cInfo(mass, myMotionState, shape, localInertia);

	btRigidBody* body = new btRigidBody(cInfo);
	//body->setContactProcessingThreshold(m_defaultContactProcessingThreshold);

#else
	btRigidBody* body = new btRigidBody(mass, 0, shape, localInertia);
	body->setWorldTransform(startTransform);
#endif//
	body->setUserIndex(55);
	world->addRigidBody(body);
	return body;
}

ICameraSceneNode* Cam;

void shootBox(PhysicsM& p)
{
	ISceneNode* cube = Smgr->addCubeSceneNode(10.0f, NULL, -1, vector3df(0, 3, 10));
	cube->setMaterialType(EMT_SOLID);
	cube->setMaterialTexture(0, Driver->getTexture("D:/Github/Irrlicht-1.8.5/media/wall.bmp"));
	cube->setMaterialFlag(EMF_LIGHTING, false);

	vector3df lookat = Cam->getTarget();
	vector3df pose = Cam->getPosition();
	p.createPhysicsBoxFromEye(pose, (lookat - pose).normalize(), cube);
}

ISceneNode* createWheel()
{
	IAnimatedMesh* m = Smgr->getMesh("D:/Github/irrlicht-1.8.5./media/wheel.dae");
	IAnimatedMeshSceneNode* animMod = Smgr->addAnimatedMeshSceneNode(m);
	animMod->setMaterialTexture(0, Driver->getTexture("D:/Github/irrlicht-1.8.5/media/texture_tire1.jpg"));
	animMod->setMaterialFlag(EMF_LIGHTING, false);

	return animMod;
}

ISceneNode* createChassis()
{
	IMeshSceneNode* chassis = Smgr->addCubeSceneNode(20, NULL, -1, vector3df(0, 0, 0), vector3df(0, 0, 0),
		vector3df(1, 0.25, 2));
	chassis->setMaterialTexture(0, Driver->getTexture("D:/Github/irrlicht-1.8.5/media/wall.bmp"));
	chassis->setMaterialFlag(EMF_LIGHTING, false);

	IMeshSceneNode* chassisCab = Smgr->addCubeSceneNode(5, chassis, -1, vector3df(0, 30, 4), vector3df(0, 0, 0),
		vector3df(3.5, 10, 1));
	chassisCab->setMaterialTexture(0, Driver->getTexture("D:/Github/irrlicht-1.8.5/media/wall.bmp"));
	chassisCab->setMaterialFlag(EMF_LIGHTING, false);

	return chassis;
}

int main(int argc, char* argv[])
{
	PhysicsM pM;
	pM.InitPhysics();

	InputHandler receiver;
	IrrlichtDevice* Device = createDevice(EDT_OPENGL, dimension2d<u32>(1024, 720), 32, false, false, false, &receiver);

	if (!Device)
	{
		return 1;
	}

	Driver = Device->getVideoDriver();
	Smgr = Device->getSceneManager();
	Env = Device->getGUIEnvironment();

	Cam = Smgr->addCameraSceneNodeFPS(NULL, 20.f, 0.02f);
	Cam->setPosition(vector3df(0, -30, -20));

	IAnimatedMesh* hillPlaneMesh = Smgr->addHillPlaneMesh("myHill",
		dimension2d<f32>(30, 30),
		dimension2d<u32>(10, 10), 0, 0,
		dimension2d<f32>(0, 0),
		dimension2d<f32>(10, 10));

	ISceneNode* planeNode = Smgr->addAnimatedMeshSceneNode(hillPlaneMesh);
	planeNode->setMaterialTexture(0, Driver->getTexture("D:/Github/irrlicht-1.8.5/media/stones.jpg"));
	planeNode->setMaterialFlag(EMF_LIGHTING, false);
	planeNode->setPosition(vector3df(0, -50, 150));

	pM.createGroundPhysics(30 * 10 / 2, 30 * 10 / 2, btVector3(0, -50, 150), planeNode);

	pM.setWheelRadius(3.5f);
	pM.setWheelWidth(2.2f);
	ISceneNode* chassis = createChassis();

	pM.setChassisSize(btVector3(10, 2.5f, 20));
	pM.setAttachedChassisNode(chassis);

	ISceneNode* wheel1 = createWheel();
	ISceneNode* wheel2 = createWheel();
	ISceneNode* wheel3 = createWheel();
	ISceneNode* wheel4 = createWheel();
	pM.setAttachedWheelNodes(wheel1, wheel2, wheel3, wheel4);
	pM.setMaxEnginePower(1000);
	pM.createVehicle();

	u32 then = Device->getTimer()->getTime();
	while (Device->run() && Driver)
	{
		const u32 now = Device->getTimer()->getTime();

		Driver->beginScene(true, true, SColor(255, 0, 0, 255));
		Smgr->drawAll();
		Env->drawAll();

		Driver->endScene();

		if (receiver.IsKeyDown(KEY_ESCAPE))
			break;

		if (receiver.IsKeyDown(KEY_KEY_W))
		{
			pM.moveForward();
			//receiver.Reset(KEY_KEY_W); //If not commented, vehicle will not go forward
		}

		if (receiver.IsKeyDown(KEY_KEY_S))
		{
			pM.moveBackward();
			receiver.Reset(KEY_KEY_S);
		}

		if (receiver.IsKeyDown(KEY_KEY_A))
		{
			pM.turnLeft();
			receiver.Reset(KEY_KEY_A);
		}

		if (receiver.IsKeyDown(KEY_KEY_D))
		{
			pM.turnRight();
			receiver.Reset(KEY_KEY_D);
		}

		if (receiver.IsKeyDown(KEY_SPACE))
		{
			shootBox(pM);
			receiver.Reset(KEY_SPACE);
		}

		int fps = Driver->getFPS();
		if (lastFPS != fps)
		{
			stringw str = L"Irrlicht Vehicle Bullet Physics [";
			str += Driver->getName();
			str += "] FPS:";
			str += fps;
			Device->setWindowCaption(str.c_str());
			lastFPS = fps;
		}

		const f32 frameDeltaTime = (f32)(now - then) / 1000.f;
		pM.StepPhysics(frameDeltaTime);
		pM.updatePhysics();
		pM.updateVehicle();
		then = now;
	}

	pM.destroyPhysics();

	Device->drop();

	return 0;
}
