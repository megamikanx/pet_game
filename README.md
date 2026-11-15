# PetFinder

A 2D puzzle game made in Godot 4. Clients have lost their pets in a crowded pen. You listen to each client describe their pet's personality, pack a bag of items based on those clues, then use the items to work out which animal in the pen is theirs.

**▶ [Play PetFinder on itch.io](https://paprikomo.itch.io/pet-finder)**

## How to Play

Each stage has three phases:

1. **Clue**: The client describes their pet through a series of speech bubbles. Click to move through the dialogue.
2. **Packing**: Choose exactly **5 items** from the desk to put in your bag (click an item to pack or unpack it). Hover over an item to see what it is. The clue sheet on screen reminds you what the client said.
3. **Pen**: A pen full of near-identical pets (15–20 per stage). Drag items from your bag into the pen. Each pet reacts depending on whether it likes or dislikes the item: it might run away, bounce, change speed or grow. When you think you've found the right pet, drag it into the collection area and press **Submit**.

- Each item in your bag can be used **3 times**.
- You get **3 wrong guesses** per stage. If you run out, you go back to stage select.
- Clearing a stage unlocks the next one, and the pet is added to your **Catalogue**.

### Controls

| Input | Action |
| --- | --- |
| Left mouse button | Select, drag and drop |
| `Esc` | Quit the game |

## Features

- 6 stages, each with its own client, pet and pen (stage 6 is unlocked after clearing the first five)
- 15 items, including Beer, Bath, Water, Burger, Money, Squishy, Energy Drink, Protein Bar, Bucket of Slop, Carcass, Flower, Plushie, Top Hat, Yakult and Speaker
- An intro motion comic
- A catalogue of the pets you have found
- Music and sound effects

## Getting Started

### Playing online

The game is published on itch.io: **https://paprikomo.itch.io/pet-finder**. You don't need to install anything to play it there.

### Requirements

- [Godot Engine 4.x](https://godotengine.org/download) (the project was made with 4.7, Forward+ renderer)

### Running from source

```bash
git clone https://github.com/megamikanx/pet_game.git
```

1. Open Godot and choose **Import**, then select `project.godot` in the cloned folder.
2. Press **F5** (or the Play button) to run the game from the title screen.

### Exporting

Export presets are included for **Windows**, **macOS** and **Web (HTML5)**. Go to **Project → Export**, pick a preset and export. The preset paths point to a folder outside the repo (`../../GodotGames/PetFinder/`), so you may want to change them to suit your machine.

## Project Structure

```
pet_game/
├── project.godot          # Godot project config (autoloads, input map, display)
├── export_presets.cfg     # Windows / macOS / Web export presets
├── music/                 # Background music and sound effects
├── scenes/
│   ├── title_screen.tscn  # Entry point
│   ├── main_menu.tscn     # Pause/menu screen
│   ├── catalogue.tscn     # Collected pets
│   ├── spawning.tscn      # The pen (main gameplay)
│   ├── pet_scene.tscn     # Single pet
│   ├── item_scene.tscn    # Single placeable item
│   ├── stages/            # Stage select, clue and packing phases
│   └── story/             # Intro motion comic
├── scripts/
│   ├── global.gd          # Autoload: game progress, unlocked/cleared stages, captured pets
│   ├── stageLoadedInfo.gd # Autoload: data for the current stage
│   ├── audio_manager.gd   # Autoload: music and SFX
│   ├── background.gd      # Autoload: switches backgrounds between scenes
│   ├── info_scripts/      # Stage data resources (stageinfo1–6.tres) and GameStats.tres
│   ├── item_scripts/      # Item base class and one script per item
│   └── stage_scripts/     # Pen gameplay: pets, spawner, bag, slots, collection
└── sprites/               # Art assets
```

## Customising

- **Difficulty**: Change `Health` (wrong guesses allowed) and `MaxItemUsages` (uses per item) in [scripts/info_scripts/GameStats.tres](scripts/info_scripts/GameStats.tres).
- **Stages**: Each stage is an `Info_Stage` resource in [scripts/info_scripts/](scripts/info_scripts/). It sets the number of pets, textures, client dialogue and the target pet's item likes and dislikes (`answer_personality`).
- **Items**: Item stats (sprite, radius, priority) are in [scripts/item_scripts/item_info.gd](scripts/item_scripts/item_info.gd). Each item's effect on a pet is defined in its own script by extending `Item` and implementing `cause_afflication()` and `get_preference()`.
