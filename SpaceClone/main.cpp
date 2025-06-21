//Simple Space Invaders Clone game
//Written by Andy P.
//Copyright (c) 2025
//Using Raylib 5.5

#include <iostream>
#include <time.h>

#include <raylib.h>


const int WIDTH = 1024;
const int HEIGHT = 720;

const int PLAYER_SPEED = 10;
const int BULLET_SPEED = 10;
const float ALIEN_SPEED = 0.1f;

const int MAX_PARTICLES = 100;

typedef struct PARTICLE
{
	Vector2 position;
	Vector2 velocity;
	float lifetime;
	float size;
	Color color;
}PARTICLE;

typedef struct ParticleSystem
{
	PARTICLE* particles;
	int maxParticles;
	int activeParticles;
}ParticleSystem;

typedef struct PLAYER
{
	Vector2 position;
	float width, height;
	long score;
}PLAYER;

typedef struct BULLET
{
	Vector2 position;
	bool active;
	float speed;
}BULLET;

typedef struct ALIEN
{
	Vector2 position;
	bool active;
	float width, height;
	int points;
}ALIEN;

PLAYER Player;

ALIEN Aliens[30] = {};
int alienCount = 0;

void CreateAlien();
void DoAlien();

void InitParticle(ParticleSystem* ps, int maxParticles);
void UpdateParticles(ParticleSystem* ps);
void DrawParticles(ParticleSystem* ps);
void SpawnGoo(ParticleSystem* ps, Vector2 position);
void UpdateParticle(PARTICLE* particle);


int main()
{
	InitWindow(WIDTH, HEIGHT, "Space Invaders Clone");
	SetTargetFPS(60);

	srand((unsigned int)time(NULL));

	Player = { {WIDTH / 2 - 20, HEIGHT - 50}, 40,20 };
	Player.score = 0;

	BULLET Bullets[10] = { 0 };
	int bulletIndex = 0;

	CreateAlien();

	ParticleSystem gooSystem;
	InitParticle(&gooSystem, MAX_PARTICLES);

	while (!WindowShouldClose())
	{
		if (IsKeyDown(KEY_LEFT) && Player.position.x > 0)
		{
			Player.position.x -= PLAYER_SPEED;
		}

		if (IsKeyDown(KEY_RIGHT) && Player.position.x < WIDTH - Player.width)
		{
			Player.position.x += PLAYER_SPEED;
		}

		
		for (int i = 0; i < 10; i++)
		{
			if (Bullets[i].active)
			{
				Bullets[i].position.y -= Bullets[i].speed;
				if (Bullets[i].position.y < 0)
				{
					Bullets[i].active = false;
				}
			}
		}

		if (IsKeyPressed(KEY_SPACE))
		{
			for (int i = 0; i < 10; i++)
			{
				if (!Bullets[i].active)
				{
					Bullets[i].position = { Player.position.x + Player.width / 2 - 5, Player.position.y };
					Bullets[i].active = true;
					Bullets[i].speed = BULLET_SPEED;
					break;
				}
			}
		}

		for (int i = 0; i < alienCount; i++)
		{
			if (Aliens[i].active)
			{
				Aliens[i].position.y += ALIEN_SPEED;
			}
		}

		
			for (int i = 0; i < 10; i++)
			{
				if (Bullets[i].active)
				{
					for (int j = 0; j < alienCount; j++)
					{
						if (Aliens[j].active && CheckCollisionCircleRec(Bullets[i].position, 5, { Aliens[j].position.x,Aliens[j].position.y,Aliens[j].width,Aliens[j].height }))
						{
							SpawnGoo(&gooSystem, Aliens[j].position);
							Bullets[i].active = false;
							Aliens[j].active = false;
							Player.score += Aliens->points;
						}
					}
				}
			}
		

		if (alienCount <= 0)
		{
			CreateAlien();
		}

		UpdateParticles(&gooSystem);

		BeginDrawing();

		ClearBackground(BLACK);

		DrawText(TextFormat("Score: %04i", Player.score), 1, 1, 20, YELLOW);

		DrawRectangleV(Player.position, { Player.width,Player.height }, BLUE);

		for (int i = 0; i < 10; i++)
		{
			if (Bullets[i].active)
			{
				DrawRectangleV(Bullets[i].position, { 10,20 }, YELLOW);
			}
		}

		for (int i = 0; i < alienCount; i++)
		{
			if (Aliens[i].active)
			{
				DrawRectangleV(Aliens[i].position, { Aliens[i].width,Aliens[i].height }, GREEN);
			}

			if (!Aliens[i].active)
			{
				DrawParticles(&gooSystem);
			}
		}

		EndDrawing();
	}

	free(gooSystem.particles);
	CloseWindow();

	return 0;
}

void CreateAlien()
{
	for (int i = 0; i < 5; i++)
	{
		for (int j = 0; j < 6; j++)
		{
			Aliens[alienCount].position = { (float)300 + j * 60, (float)50 + i * 40 };
			Aliens[alienCount].active = true;
			Aliens[alienCount].width = 40;
			Aliens[alienCount].height = 30;
			Aliens[alienCount].points = 10;
			alienCount++;
		}
	}
}

void DoAlien()
{
	for (int i = 0; i < alienCount; i++)
	{
		if (Aliens[i].active)
		{
			Aliens[i].position.y += ALIEN_SPEED;
		}
	}
}

void InitParticle(ParticleSystem* ps, int maxParticles)
{
	ps->maxParticles = maxParticles;
	ps->activeParticles = 0;
	ps->particles = (PARTICLE*)malloc(sizeof(PARTICLE) * maxParticles);
}

void UpdateParticles(ParticleSystem* ps)
{
	for (int i = 0; i < ps->activeParticles; i++)
	{
		PARTICLE* p = &ps->particles[i];
		UpdateParticle(p);

		if (p->lifetime <= 0.0f)
		{
			*p = ps->particles[ps->activeParticles - 1];
			ps->activeParticles--;
			i--;
		}
	}
}

void UpdateParticle(PARTICLE* particle)
{
	particle->position.x += particle->velocity.x;
	particle->position.y += particle->velocity.y;

	particle->lifetime -= 0.02f;
	particle->size = (particle->lifetime / 1.0f) * 5.0f;
	particle->color.a = (unsigned char)(particle->lifetime * 255);

	if (particle->lifetime < 0.0f)
	{
		particle->lifetime = 0.0f;
	}
}

void DrawParticles(ParticleSystem* ps)
{
	for (int i = 0; i < ps->activeParticles; i++)
	{
		PARTICLE* p = &ps->particles[i];
		DrawCircleV(p->position, p->size, p->color);
	}
}

void SpawnGoo(ParticleSystem* ps, Vector2 position)
{
	int numParticles = 60;
	for (int i = 0; i < numParticles; i++)
	{
		if (ps->activeParticles < ps->maxParticles)
		{
			PARTICLE* p = &ps->particles[ps->activeParticles];
			p->position = position;
			p->velocity.x = ((float)(rand() % 200 - 100)) / 100.0f;
			p->velocity.y = ((float)(rand() % 200 - 100)) / 100.0f;
			p->lifetime = (float)(rand() % 100) / 100.0f + 0.5f;
			p->size = 4.0f;
			p->color = { 0,255,0255 };

			ps->activeParticles++;
		}
	}
}
