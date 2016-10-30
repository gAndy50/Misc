using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using SDL2;

namespace SDLSharpFun
{
    public class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Press ESC to exit");
            Console.WriteLine("Press w to change screen to red.");
            Console.WriteLine("Press s to change screen to green.");
            Console.WriteLine("Press a to change screen to blue.");

            int Width = 800;
            int Height = 600;
            bool GameRunning = true;

            SDL.SDL_Init(SDL.SDL_INIT_EVERYTHING);
           
            SDL.SDL_Event e;
            SDL.SDL_Rect rect;

            IntPtr win = SDL.SDL_CreateWindow("SDL Win", SDL.SDL_WINDOWPOS_CENTERED, SDL.SDL_WINDOWPOS_CENTERED, Width, Height, SDL.SDL_WindowFlags.SDL_WINDOW_SHOWN);
            IntPtr ren = SDL.SDL_CreateRenderer(win, -1, SDL.SDL_RendererFlags.SDL_RENDERER_PRESENTVSYNC);

            rect.x = 0;
            rect.y = 0;
            rect.w = 320;
            rect.h = 240;

            while(GameRunning)
            {
                while (SDL.SDL_PollEvent(out e) == 1)
                {
                    if (e.type == SDL.SDL_EventType.SDL_QUIT)
                    {
                        GameRunning = false;
                    }

                    if(e.type == SDL.SDL_EventType.SDL_KEYDOWN)
                    {
                        if(e.key.keysym.sym == SDL.SDL_Keycode.SDLK_ESCAPE)
                        {
                            GameRunning = false;
                        }

                        if(e.key.keysym.sym == SDL.SDL_Keycode.SDLK_w)
                        {
                            SDL.SDL_SetRenderDrawColor(ren, 255, 0, 0, 0);
                            SDL.SDL_RenderFillRect(ren, ref rect);
                        }
                        else if(e.key.keysym.sym == SDL.SDL_Keycode.SDLK_s)
                        {
                            SDL.SDL_SetRenderDrawColor(ren, 0, 255, 0, 0);
                            SDL.SDL_RenderFillRect(ren, ref rect);
                        }
                        else if (e.key.keysym.sym == SDL.SDL_Keycode.SDLK_a)
                        {
                            SDL.SDL_SetRenderDrawColor(ren, 0,0, 255, 0);
                            SDL.SDL_RenderFillRect(ren, ref rect);
                        }
                    }

                }

                SDL.SDL_RenderClear(ren);

                SDL.SDL_RenderPresent(ren);
            }

            SDL.SDL_DestroyWindow(win);
            SDL.SDL_DestroyRenderer(ren);

            SDL.SDL_Quit();
        }
    }
}
