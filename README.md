# Geography Explorer 🌍

An interactive educational game built in MATLAB that helps users learn about European countries through an engaging, click-based map interface.

<img width="581" height="589" alt="image" src="https://github.com/user-attachments/assets/27599bad-ef32-4ce6-86d7-aa593ce03b82" />


## 📋 Table of Contents
- [Overview](#overview)
- [Features](#features)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [How to Play](#how-to-play)
- [Project Structure](#project-structure)
- [Game Mechanics](#game-mechanics)
- [Data Structure](#data-structure)
- [Contributing](#contributing)
- [Authors](#authors)
- [License](#license)
- [Acknowledgments](#acknowledgments)

## 🎮 Overview

Geography Explorer is an interactive learning tool designed to make geography education fun and engaging. Players explore a map of Europe, clicking on countries to learn detailed information including capitals, populations, languages, and interesting facts. The game tracks progress and awards achievements as players expand their geographical knowledge.

<img width="858" height="830" alt="image" src="https://github.com/user-attachments/assets/5fba367a-c38c-4423-8153-8f21a8045ac8" />


## ✨ Features

- **Interactive Map Interface**: Click directly on countries using advanced color-mask detection technology
- **Comprehensive Country Data**: Learn about 51 European countries and territories
- **Progress Tracking**: Monitor your exploration journey with statistics
- **Achievement System**: Earn badges and rank titles as you learn
- **Retro-Style UI**: Nostalgic pixel art interface using sprite-based graphics
- **Educational Content**: Detailed information about each country including:
  - Capital cities
  - Population statistics
  - Official languages
  - Currency information
  - Interesting cultural facts

<img width="634" height="638" alt="image" src="https://github.com/user-attachments/assets/cde64607-08a2-4ca4-a065-120a481f1eb2" />


## 🔧 Prerequisites

- **MATLAB** (R2019b or later recommended)
- **Required Toolboxes**:
  - Image Processing Toolbox (for map image handling)
  - (No additional toolboxes required - uses base MATLAB functions)
- **Operating System**: Windows, macOS, or Linux

## 📥 Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/yourusername/geography-explorer.git
   cd geography-explorer
   ```

2. **Verify file structure**:
   Ensure all required files are present:
   - `GeographyExplorer_Main.m` (main script)
   - `europe_map.png` (display map)
   - `europe_mask.png` (color-coded detection map)
   - `europe_mask_legend.png` (reference for mask colors)
   - `gameData.xlsx` (country information database)
   - `retro_pack.png` (sprite sheet for UI)
   - All function files (`.m` files)

3. **Open MATLAB**:
   - Launch MATLAB
   - Navigate to the project directory
   - Ensure the directory is added to the MATLAB path

4. **Run the game**:
   ```matlab
   GeographyExplorer_Main
   ```

<img width="649" height="492" alt="image" src="https://github.com/user-attachments/assets/c41d81d4-6837-4734-b005-9cdd478f7f75" />


## 🎯 How to Play

### Starting the Game

1. Run `GeographyExplorer_Main.m` in MATLAB
2. Wait for the game to load country data
3. The main menu will appear with three options

### Main Menu Options

1. **Start Learning** (Option 1)
   - Opens the interactive map of Europe
   - Click on any country to view its information
   - Your progress is automatically saved

2. **View Progress** (Option 2)
   - See how many countries you've explored
   - Check your current rank title
   - View earned badges

3. **Exit Game** (Option 3)
   - Displays a thank you message
   - Closes the application

<img width="884" height="652" alt="image" src="https://github.com/user-attachments/assets/d3360c32-3060-4ec3-a136-d0b1f1f18040" />


### Exploring Countries

1. Click on any country on the interactive map
2. A detailed information screen appears showing:
   - Country name and flag emoji
   - Capital city
   - Population
   - Language(s)
   - Currency
   - Fun fact
3. Choose your next action:
   - **Next Country**: Randomly select another country
   - **Back to Map**: Return to the map view
   - **Main Menu**: Return to the main menu

### Navigation Tips

- Look for the "Main Menu" button in the bottom-right of the map screen
- The map displays your progress counter in the top-right corner
- Countries are color-coded but appear as a standard map for easy identification

## 📁 Project Structure

```
geography-explorer/
│
├── GeographyExplorer_Main.m          # Main driver script
├── displayMainMenu.m                  # Main menu display function
├── displayInteractiveMap.m            # Interactive map with click detection
├── displayCountryInfo.m               # Country information display
├── displayProgressScreen.m            # Progress and achievements screen
├── loadCountryData.m                  # Excel data loading function
├── updateUserProgress.m               # Progress tracking logic
├── buildCountryColorMap.m             # Color-to-country mapping
├── simpleGameEngine.m                 # Sprite-based graphics engine
│
├── gameData.xlsx                      # Country information database
├── countryMapping.mat                 # Pre-built color mapping data
│
├── europe_map.png                     # Display map (visual)
├── europe_mask.png                    # Detection map (color-coded)
├── europe_mask_legend.png             # Color reference guide
├── retro_pack.png                     # Sprite sheet for UI elements
│
├── Archive/                           # Previous versions and backups
│   ├── buildCountryColorMap.m
│   ├── setupCountryMapping.m
│   ├── europe_map.png
│   └── OGeurope_map.png
│
├── html/                              # MATLAB-generated documentation
│   ├── GeographyExplorer_Main.pdf
│   └── displayInteractiveMap.pdf
│
├── README.md                          # This file
├── LICENSE                            # MIT License
└── .gitignore                         # Git ignore rules
```

## 🎲 Game Mechanics

### Color Mask Detection System

The game uses a sophisticated color-mask detection system for accurate country selection:

1. **Display Map** (`europe_map.png`): A clean, visually appealing map shown to the player
2. **Mask Map** (`europe_mask.png`): An invisible technical map where each country has a unique RGB color
3. **Color Mapping**: Each RGB color is mapped to a specific country ID (1-51)

When you click on the display map:
- The same coordinates are checked on the mask map
- The RGB color at that pixel is identified
- The color is matched to a country using `buildCountryColorMap()`
- The corresponding country information is displayed

<img width="1918" height="953" alt="image" src="https://github.com/user-attachments/assets/52835a19-e5e9-4370-827f-5f78bf2b5826" />

<img width="943" height="376" alt="image" src="https://github.com/user-attachments/assets/8d85ba12-cf1d-4511-b206-71cd489ff9b3" />


### Progress System

- **Countries Explored**: Tracks visited countries (out of 51)
- **Rank Titles**: Earned based on exploration milestones
  - New Explorer (0 countries)
  - Junior Explorer (10+ countries)
  - Senior Explorer (25+ countries)
  - Master Explorer (40+ countries)
  - Europe Expert (all 51 countries)
- **Badges**: Special achievements for completing regions or reaching milestones

### Data Flow

```
GeographyExplorer_Main.m
    ↓
loadCountryData() → Loads gameData.xlsx
    ↓
displayMainMenu() → Player chooses action
    ↓
displayInteractiveMap() → Player clicks country
    ↓
buildCountryColorMap() → Identifies clicked country
    ↓
displayCountryInfo() → Shows country details
    ↓
updateUserProgress() → Updates statistics
    ↓
(Loop continues until exit)
```

## 📊 Data Structure

### Excel File Format (`gameData.xlsx`)

The `gameData.xlsx` file contains country information with the following columns:

| Column | Description | Example |
|--------|-------------|---------|
| Country | Country name | "France" |
| Capital | Capital city | "Paris" |
| Population | Population count | "67,000,000" |
| Language | Official language(s) | "French" |
| Currency | Official currency | "Euro (EUR)" |
| Fun_Fact | Interesting trivia | "Home to the Eiffel Tower" |

### Country Data Structure (MATLAB)

```matlab
countryData(i).name = 'France';
countryData(i).capital = 'Paris';
countryData(i).population = '67,000,000';
countryData(i).language = 'French';
countryData(i).currency = 'Euro (EUR)';
countryData(i).funFact = 'Home to the Eiffel Tower';
```

## 🤝 Contributing

Contributions are welcome! Here are some ways you can help:

### How to Contribute

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

### Ideas for Contributions

- Add more countries or regions (Asia, Africa, Americas)
- Implement a quiz mode to test knowledge
- Add audio pronunciations for country names
- Create difficulty levels
- Add multiplayer functionality
- Implement a scoring system
- Add more detailed statistics and graphs
- Create a mobile-compatible version
- Add localization for different languages

### Code Style

- Follow MATLAB coding best practices
- Include clear comments explaining complex logic
- Use descriptive variable names
- Add function documentation headers
- Test thoroughly before submitting

## 👥 Authors

- **Mustafa Elshikh** - *Lead Developer*
- **Ava Price** - *Co-Developer*

**Course**: ENGR 1181  
**Date**: December 2024  
**Institution**: [Your Institution Name]

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Built as part of ENGR 1181 coursework
- Simple Game Engine adapted for sprite-based graphics
- Map images created/adapted for educational purposes
- Country data compiled from public sources
- Thanks to all contributors and testers

## 🐛 Known Issues

- None currently reported

## 📞 Support

If you encounter any issues or have questions:

1. Check the [Issues](https://github.com/yourusername/geography-explorer/issues) page
2. Create a new issue with detailed information
3. Contact the authors through the repository

## 🔮 Future Enhancements

- [ ] Add sound effects and background music
- [ ] Implement a timed challenge mode
- [ ] Create detailed statistical analysis of user performance
- [ ] Add comparison mode between countries
- [ ] Include historical information about countries
- [ ] Add flag recognition game mode
- [ ] Implement cloud save functionality
- [ ] Create a leaderboard system

---

**Happy Exploring! 🗺️**

*Learn geography the fun way - one click at a time!*

