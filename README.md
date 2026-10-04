# Path Finder

Teleport to players with customizable speed and height in FiveM.

## Features

- Teleport to other players by name
- Customizable speed, tweening, and flying options
- GUI for easy configuration
- Saves paths to a database

## Requirements

- FiveM server with ESX framework
- MySQL database

## Installation

1. Download the script from the [GitHub repository](https://github.com/EnderDevelopment/path-finder)
2. Extract the files into your FiveM server's `resources` directory
3. Add `start path-finder` to your `server.cfg` file
4. Run the `database.sql` script to create the necessary database table

## Usage

- Use the `/pathfinder` command to open the GUI
- Enter the target player's name
- Configure the speed, tweening, and flying options
- Click 'Find Path' to teleport

## Configuration

The script can be configured in the `config.lua` file. The following options are available:

- `DefaultSpeed`: The default speed for teleportation
- `DefaultTweenTime`: The default tweening time in milliseconds
- `DefaultFlyHeight`: The default flying height
- `GUI`: GUI settings including titles, labels, and button text

---

## Generated with EnderDevelopment

This plugin was generated in minutes with [EnderDevelopment](https://enderdevelopment.com) — the AI platform that turns your ideas into working Minecraft plugins, Discord bots and FiveM scripts.

**Want your own?** [Generate this project on EnderDevelopment](https://dash.enderdevelopment.com?utm_source=github&utm_medium=readme&utm_campaign=path-finder&utm_content=bottom) — describe it in one sentence and get the full source code.