# Topdown Zombie Shooter

A simple 2D zombie shooter game built with LÖVE2D framework.

## Description

This is a top-down shooter game where you control a player character who must survive waves of zombies. The zombies will continuously spawn from the edges of the screen and move towards the player. The player can shoot bullets to destroy the zombies.

## Features

- Player movement using WASD keys
- Mouse-controlled aiming and shooting
- Zombie enemies that chase the player
- Score tracking
- Two-hit player health system (player turns red when injured)
- Increased player speed when injured
- Zombies spawn from the edges of the screen
- Game states: Start, Play, and Game Over

## How to Play

1. Start the game by clicking anywhere on the start screen.
2. Control the player with the following keys:
   - `W` - Move up
   - `A` - Move left
   - `S` - Move down
   - `D` - Move right
3. Aim with your mouse and left-click to shoot.
4. Survive as long as possible and shoot zombies to increase your score.
5. If you get hit once, you become injured (turn red) and move faster.
6. If you get hit while injured, the game ends.
7. After game over, click anywhere to return to the start screen.

## Technical Details

The game is built using the LÖVE2D framework, which is a free 2D game engine that uses the Lua programming language.

Key technical features:

- Frame rate independent movement using delta time
- Dynamic zombie spawning system
- Collision detection between game entities
- Game state management
- Graphical feedback for player state

## Requirements

- LÖVE2D engine (version 11.0+ recommended)

## Running the Game

1. Install LÖVE2D from [love2d.org](https://love2d.org/)
2. Clone or download this repository
3. Either:
   - Drag the folder onto the LÖVE2D application
   - Run `love path/to/topdown-shooter` in the terminal
