//Simple physics project using SFML 2 and Box 2D
#include <stdlib.h>
#include <stdio.h>

#include <iostream>
#include <sstream>
#include <string>

#include <SFML\System.hpp>
#include <SFML\Graphics.hpp>
#include <SFML\Window.hpp>
#include <SFML\Audio.hpp>
#include <SFML\Network.hpp>

#include <Box2D\Box2D.h>

using namespace std;

#define PTM_RATIO 32.0

//methods
void Init();
void DrawGame();
void GameLoop();
void Shutdown();

//globals
bool GameRunning = true;
sf::RenderWindow GameWin;

sf::RectangleShape box;
sf::RectangleShape box2;
sf::RectangleShape ground;
sf::RectangleShape wall;
sf::RectangleShape wall2;

b2Vec2 gravity(0.0f,9.8f);
b2World* World;

b2Body* groundBody;
b2BodyDef groundBodyDef;
b2Body* wallBody;
b2BodyDef wallBodyDef;
b2Body* wallBody2;
b2BodyDef wallBodyDef2;

b2Body* Body;
b2BodyDef ballBodyDef;
b2Vec2 ballVector;

b2PolygonShape groundBox;
b2FixtureDef boxShapeDef;

b2PolygonShape wallBox;
b2FixtureDef wallBoxDef;

b2PolygonShape wallBox2;
b2FixtureDef wallBoxDef2;

b2Body* Body2;
b2BodyDef ballBodyDef2;
b2Vec2 ballVector2;

b2PolygonShape dynamicBox;
b2FixtureDef fixtureDef;
b2PolygonShape dynamicBox2;
b2FixtureDef fixtureDef2;

float timeStep;
int32 velIter, posIter;

bool Paused = true;

sf::Font font;
sf::Text PauseText;

string pauseText; 

int main(int argc, char* argv[])
{
	Init();

	GameLoop();

	Shutdown();

	return EXIT_SUCCESS;
}

void Init()
{
	GameWin.create(sf::VideoMode(800, 600, 32), "Physics Test - [SFML & Box2D]");

	if (!font.loadFromFile("arial.ttf"))
	{
		exit(0);
	}

	PauseText.setFont(font);

	pauseText = to_string(Paused);

	PauseText.setCharacterSize(10);
	PauseText.setString("PAUSED:" + pauseText);
	PauseText.setPosition(sf::Vector2f(700, 10));
	PauseText.setFillColor(sf::Color::Yellow);
	
	box.setPosition(sf::Vector2f(15, 5));
	box.setSize(sf::Vector2f(10, 10));
	box.setFillColor(sf::Color(255, 0, 0));

	box2.setPosition(sf::Vector2f(50, 5));
	box2.setSize(sf::Vector2f(15, 15));
	box2.setFillColor(sf::Color(0, 255, 0));

	ground.setPosition(sf::Vector2f(0, 540));
	ground.setSize(sf::Vector2f(800, 560));
	ground.setFillColor(sf::Color(0, 0,255));

	wall.setPosition(sf::Vector2f(1, 1));
	wall.setSize(sf::Vector2f(10, 580));
	wall.setFillColor(sf::Color(0, 0, 255));

	wall2.setPosition(sf::Vector2f(790, 1));
	wall2.setSize(sf::Vector2f(10, 580));
	wall2.setFillColor(sf::Color(0, 0, 255));

	World = new b2World(gravity);
	World->SetGravity(gravity);

	groundBodyDef.type = b2_staticBody;
	groundBodyDef.position.Set(0, 540);
	groundBody = World->CreateBody(&groundBodyDef);

	wallBodyDef.type = b2_staticBody;
	wallBodyDef.position.Set(10, 580);
	wallBody = World->CreateBody(&wallBodyDef);

	wallBodyDef2.type = b2_staticBody;
	wallBodyDef2.position.Set(790, 1);
	wallBody2 = World->CreateBody(&wallBodyDef2);

	ballBodyDef.type = b2_dynamicBody;
	ballVector.Set(10, 10);
	ballBodyDef.angularVelocity = 0.0f;
	ballBodyDef.linearVelocity = ballVector;

	ballBodyDef2.type = b2_dynamicBody;
	ballVector2.Set(15, 15);
	ballBodyDef2.angularVelocity = 0.0f;
	ballBodyDef2.linearVelocity = ballVector2;

	ballBodyDef.position.Set(15, 0);
	ballBodyDef.awake = true;
	Body = World->CreateBody(&ballBodyDef);

	ballBodyDef2.position.Set(30, 0);
	ballBodyDef2.awake = true;
	Body2 = World->CreateBody(&ballBodyDef2);

	boxShapeDef.shape = &groundBox;
	boxShapeDef.density = 2.0f;
	boxShapeDef.restitution = 0.5f;
	groundBox.SetAsBox(800, 0);

	groundBody->CreateFixture(&groundBox, 0);

	wallBoxDef.shape = &wallBox;
	wallBoxDef.density = 2.0f;
	wallBoxDef.restitution = 0.5f;
	wallBox.SetAsBox(1, 600);

	wallBody->CreateFixture(&wallBox, 0);

	wallBoxDef2.shape = &wallBox2;
	wallBoxDef2.density = 2.0f;
	wallBoxDef2.restitution = 0.5f;
	wallBox2.SetAsBox(1, 600);

	wallBody2->CreateFixture(&wallBox2, 0);

	dynamicBox.SetAsBox(10.0f, 10.0f);

	dynamicBox2.SetAsBox(10.0f, 10.0f);

	fixtureDef.shape = &dynamicBox;
	fixtureDef.density = 2.0f;
	fixtureDef.friction = 1.5f;
	fixtureDef.restitution = 0.9f;

	Body->CreateFixture(&fixtureDef);

	fixtureDef2.shape = &dynamicBox2;
	fixtureDef2.density = 5.0f;
	fixtureDef2.friction = 5.0f;
	fixtureDef2.restitution = 1.0f;

	Body2->CreateFixture(&fixtureDef2);

	timeStep = 1.0f / 600.0f;
	velIter = 1;
	posIter = 1;

	World->Step(timeStep, velIter, posIter);

	b2Vec2 pos = Body->GetPosition();
	float angle = Body->GetAngle();

	box.setPosition(pos.x, pos.y);
	box.setRotation(angle);

	b2Vec2 pos2 = Body2->GetPosition();
	float angle2 = Body2->GetAngle();

	box2.setPosition(pos2.x, pos2.y);
	box2.setRotation(angle2);
}

void GameLoop()
{
	while (GameRunning)
	{
		sf::Event Event;

		while (GameWin.pollEvent(Event))
		{
			if (Event.type == sf::Event::Closed)
			{
				GameWin.close();
				GameRunning = false;
			}

			if (Event.type == sf::Event::KeyPressed)
			{
				if (Event.key.code == sf::Keyboard::Escape)
				{
					GameWin.close();
					GameRunning = false;
				}

				if (Event.key.code == sf::Keyboard::P && Paused == true)
				{
					Paused = false;
				}
				else if (Event.key.code == sf::Keyboard::P && Paused == false)
				{
					Paused = true;
				}
			}

			if (Event.type == sf::Event::KeyReleased)
			{
				
			}
		}

		if(!Paused)
		World->Step(timeStep, velIter, posIter);

		b2Vec2 pos = Body->GetPosition();
		float angle = Body->GetAngle();

		box.setPosition(pos.x, pos.y);
		box.setRotation(angle);

		b2Vec2 pos2 = Body2->GetPosition();
		float angle2 = Body2->GetAngle();

		box2.setPosition(pos2.x, pos2.y);
		box2.setRotation(angle2);

		DrawGame();
	}
}

void Shutdown()
{
	World->DestroyBody(Body);
	World->DestroyBody(Body2);
	World->DestroyBody(groundBody);
	World->DestroyBody(wallBody);
	World->DestroyBody(wallBody2);

	delete World;
}

void DrawGame()
{
	GameWin.clear();

	GameWin.draw(PauseText);
	
	GameWin.draw(ground);

	GameWin.draw(wall);
	GameWin.draw(wall2);

	GameWin.draw(box);
	GameWin.draw(box2);

	GameWin.display();
}
