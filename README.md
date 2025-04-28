## 🎮 Snake Game in Assembly

This project is a classic **Snake Game** written in **x86 Assembly Language**. It demonstrates low-level programming concepts and direct interaction with hardware, such as video memory and keyboard interrupts.

### ✨ Features

- **Classic Snake Gameplay**: Control the snake to eat fruits and grow longer.
- **Game Modes**:
  - **Portal Mode**: Snake wraps around the screen edges.
  - **Wall Mode**: Snake collides with the screen edges.
- **Custom Graphics**: Uses sprites for the snake, fruits, and background.
- **Keyboard Controls**: Use `I`, `J`, `K`, and `L` to move the snake.
- **Score Display**: Tracks and displays the snake's length.

### 🎯 How to Play

1. **Run the Game**: Execute the `.COM` file (e.g., `Snake.COM`) in a DOS environment or an emulator like **DOSBox**.
2. **Select Mode**:
   - Press `1` for Portal Mode.
   - Press `2` for Wall Mode.
3. **Control the Snake**:
   - `I` - Move Up
   - `J` - Move Left
   - `K` - Move Down
   - `L` - Move Right
4. **Objective**: Eat the fruits to grow the snake. Avoid colliding with yourself or the walls (in Wall Mode).

### ⚙️ Requirements

- **DOS Environment**: Use a real DOS system or an emulator like **DOSBox**.
- **Assembler**: Use **NASM** to assemble the `.ASM` files into `.COM` files.

### 📂 File Structure

- **Snake.asm**: Main game logic and functions.
- **Snake.COM**: Compiled executable for the game.

### 🛠️ How to Compile

1. Install **NASM** (Netwide Assembler).
2. Open a terminal or command prompt.
3. Assemble the `.ASM` file:
   
   ```bash
   nasm Snake.asm -o Snake.COM
