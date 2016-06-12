import sys
import direct.directbase.DirectStart

from direct.showbase.DirectObject import DirectObject
from direct.showbase.InputStateGlobal import inputState

from panda3d.core import *
from panda3d.bullet import *

class Game(DirectObject):

    def __init__(self):
        base.setBackgroundColor(0,0,0)
        base.setFrameRateMeter(True)

        base.cam.setPos(10,-30,20)
        base.cam.lookAt(0,0,5)

        self.accept('escape', self.doExit)
        self.accept('r', self.doReset)
        self.accept('a', self.dropCubes)
        self.accept('s', self.dropSpheres)

        taskMgr.add(self.update, 'updateWorld')

        self.setup()

    def doExit(self):
        self.cleanup()
        self.exit(1)

    def doReset(self):
        self.cleanup()
        self.setup()

    def update(self,task):
        dt = globalClock.getDt()

        #self.processInput(dt)
        self.world.doPhysics(dt,10,0.008)

        return task.cont

    def cleanup(self):
        self.world = None
        self.worldNP.removeNode()

    def setup(self):
        self.worldNP = render.attachNewNode('World')
        
        self.world = BulletWorld()
        self.world.setGravity(Vec3(0,0,-9.81))

        shape = BulletPlaneShape(Vec3(0,0,1),0)

        np = self.worldNP.attachNewNode(BulletRigidBodyNode('Ground'))
        np.node().addShape(shape)
        np.setPos(0,0,-1)

        self.world.attachRigidBody(np.node())

    def dropCubes(self):
        self.model = loader.loadModel('models/box.egg')
        self.model.setPos(-0.5,-0.5,-0.5)
        self.model.flattenLight()
        shape = BulletBoxShape(Vec3(0.5,0.5,0.5))
        for i in range(100):
           np = self.worldNP.attachNewNode(BulletRigidBodyNode('Box'))
           np.node().addShape(shape)
           np.setPos(0,0,2)
           np.node().setMass(1.0)

           self.world.attachRigidBody(np.node())
           self.model.copyTo(np) 

    def dropSpheres(self):
        self.model = loader.loadModel('models/teapot.egg')
        self.model.setPos(-0.5)
        self.model.flattenLight()
        shape = BulletSphereShape(0.5)
        for i in range(20):
            np = self.worldNP.attachNewNode(BulletRigidBodyNode('Sphere'))
            np.node().addShape(shape)
            np.setPos(0,0,2)
            np.node().setMass(0.5)

            self.world.attachRigidBody(np.node())
            self.model.copyTo(np)
        

game = Game()
run()
