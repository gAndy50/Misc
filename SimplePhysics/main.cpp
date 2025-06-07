#include <iostream>
#include <vector>
#include <list>

#include <raylib.h>
#include <box2d/box2d.h>

#include <assert.h>

int Width = 1624;
int Height = 720;

#define GROUND_SIZE 14
#define BOXES 16

typedef struct Object
{
	b2BodyId bodyID;
	b2Vec2 extent;
	Texture tex;
}Object;

void DrawObject(Object* object)
{
	b2Vec2 p = b2Body_GetWorldPoint(object->bodyID, {-object->extent.x,-object->extent.y});
	b2Rot rotation = b2Body_GetRotation(object->bodyID);
	float rads = b2Rot_GetAngle(rotation);

	Vector2 ps = { p.x,p.y };
	DrawTextureEx(object->tex, ps, RAD2DEG * rads, 1.0f, WHITE);
}

int main()
{
	InitWindow(Width, Height, "Playground Physics");
	SetTargetFPS(60);

	float lengthPerUnitsMeter = 100.0f;
	b2SetLengthUnitsPerMeter(lengthPerUnitsMeter);

	b2WorldDef worldDef = b2DefaultWorldDef();

	worldDef.gravity.y = 10.0f * lengthPerUnitsMeter;
	b2WorldId worldID = b2CreateWorld(&worldDef);

	b2World_EnableContinuous(worldID, true);

	Texture groundTex = LoadTexture("ground.png");
	Texture boxTex = LoadTexture("box.png");

	b2Vec2 groundExtent = { 0.5f * groundTex.width, 0.5f * groundTex.height };
	b2Vec2 boxExtent = { 0.5f * boxTex.width, 0.5f * boxTex.height };

	b2Polygon groundPoly = b2MakeBox(groundExtent.x, groundExtent.y);
	b2Polygon boxPoly = b2MakeBox(boxExtent.x, boxExtent.y);

	float rad = 20.0f;
	b2BodyDef circleDef = b2DefaultBodyDef();
	circleDef.position = { 500.f, 1.0f }; //change value to change where ball appears according to x,y position
	circleDef.type = b2_dynamicBody;
	b2BodyId circleId = b2CreateBody(worldID, &circleDef);
	b2Circle circle = { { 0.0f,0.0f },rad };
	b2ShapeDef circleShapeDef = b2DefaultShapeDef();
	circleShapeDef.density = 1.0f;
	b2ShapeId circleID = b2CreateCircleShape(circleId, &circleShapeDef, &circle);
	b2Shape_SetRestitution(circleID, 0.8f); //change value to increase/decrease how bouncy ball is

	float rad2 = 20.0f;
	b2BodyDef circleDef2 = b2DefaultBodyDef();
	circleDef2.position = { 800.0f, 1.0f }; //same as with ball 1
	circleDef2.type = b2_dynamicBody;
	b2BodyId circleId2 = b2CreateBody(worldID, &circleDef2);
	b2Circle circle2 = { {0.0f,0.0},rad2 };
	b2ShapeDef circleShapeDef2 = b2DefaultShapeDef();
	circleShapeDef2.density = 1.0f;
	b2ShapeId circleID2 = b2CreateCircleShape(circleId2, &circleShapeDef2, &circle2);
	b2Shape_SetRestitution(circleID2, 1.5f); //same as with ball 1

	Object groundObjects[GROUND_SIZE] = { 0 };
	for (int i = 0; i < GROUND_SIZE; ++i)
	{
		Object* object = groundObjects + i;
		b2BodyDef bodyDef = b2DefaultBodyDef();
		bodyDef.position = { (2.0f * i + 2.0f) * groundExtent.x, Height - groundExtent.y - 100.0f };

		object->bodyID = b2CreateBody(worldID, &bodyDef);
		object->extent = groundExtent;
		object->tex = groundTex;
		b2ShapeDef shapeDef = b2DefaultShapeDef();
		b2CreatePolygonShape(object->bodyID, &shapeDef, &groundPoly);
	}

	Object boxObjects[BOXES] = { 0 }; //box objects was corrupted error
	int boxIndex = 0;
	for (int i = 0; i < 4; ++i)
	{
			float y = Height - groundExtent.y - 100.0f - (2.5f * i + 2.0f) * boxExtent.y - 20.0f;

			for (int j = 0; j < 4; ++j)
			{
				float x = 0.5f * Width + (3.0f * j - i - 3.0f) * boxExtent.x;
				assert(boxIndex < BOXES); //causes program to abort

				Object* object = boxObjects + boxIndex;
				b2BodyDef bodyDef = b2DefaultBodyDef();
				bodyDef.type = b2_dynamicBody;
				bodyDef.gravityScale = 0.3f;
				bodyDef.position = { x, y };
				object->bodyID = b2CreateBody(worldID, &bodyDef);
				object->tex = boxTex;
				object->extent = boxExtent;
				b2ShapeDef shapeDef = b2DefaultShapeDef();
				b2CreatePolygonShape(object->bodyID, &shapeDef, &boxPoly);
			
				boxIndex += 1;
				
			}
	}

	bool Paused = false;

	while (!WindowShouldClose())
	{
		if (IsKeyPressed(KEY_P))
		{
			Paused = !Paused;
		}


		if (Paused == true)
		{
			float deltaTime = GetFrameTime();
			b2World_Step(worldID, deltaTime, 4);
		}

		BeginDrawing();

		ClearBackground(BLACK);

		DrawFPS(1, 1);

		for (int i = 0; i < GROUND_SIZE; ++i)
		{
			DrawObject(groundObjects + i);
		}

		for (int i = 0; i < BOXES; ++i)
		{
			DrawObject(boxObjects + i);
		}

		//ball 1 is red
		b2Vec2 cirPos = b2Body_GetPosition(circleId);
		DrawCircle(cirPos.x, cirPos.y, rad, RED);

		//ball 2 is blue
		b2Vec2 cirPos2 = b2Body_GetPosition(circleId2);
		DrawCircle(cirPos2.x, cirPos2.y, rad2, BLUE);

		EndDrawing();
	}

	UnloadTexture(groundTex);
	UnloadTexture(boxTex);

	b2DestroyWorld(worldID);

	CloseWindow();

	return 0;
}