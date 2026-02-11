<!-- Improved compatibility of back to top link: See: https://github.com/othneildrew/Best-README-Template/pull/73 -->
<a id="readme-top"></a>
<!--
*** Thanks for checking out the Best-README-Template. If you have a suggestion
*** that would make this better, please fork the repo and create a pull request
*** or simply open an issue with the tag "enhancement".
*** Don't forget to give the project a star!
*** Thanks again! Now go create something AMAZING! :D
-->

<!-- PROJECT LOGO -->
<div align="center">
  <h3 align="center">Combat Framework Plugin</h3>
  <p align="center">
    Universal combat framework designed for Unreal Engine projects 
    <br />
    Supports Unreal Engine versions 5.0 and up
    <br />
    <a href="https://www.youtube.com/@CRYFALLPRODUCTIONS ">YouTube</a>
    &middot;
    <a href="https://github.com/othneildrew/Best-README-Template/issues/new?labels=bug&template=bug-report---.md">Report Bug</a>
    &middot;
    <a href="https://github.com/othneildrew/Best-README-Template/issues/new?labels=enhancement&template=feature-request---.md">Request Feature</a>
  </p>
</div>

<!-- ABOUT THE PROJECT -->
## About The Project

Originally an internal project, the shift to publicize this plugin was made to enahnce the indie action RPG landscape. Smart, modular 
development practices enable any game developer to maximize this plugin's features without affecting already-existing mechanics. This plugin
aims to support the following genres:

* Souls
* Action/Adventure games
* Hack N' Slashes

### Installation

_Below is an example on how to utilize this plugin_
1. Ensure the following software is installed and configured on your local system:
   * [Visual Studio IDE](https://visualstudio.microsoft.com/downloads/)
   * [Epic Games Launcher](https://www.unrealengine.com/en-US/download/)

2. Clone the repository
   ```sh
   git clone https://github.com/nathan-adotey/UE-Combat-Framework-Plugin.git
   ```

3. Integrate the plugin into an Unreal Engine project
   * Navigate to your project and create a Plugins folder if one has not been created yet
   * Create a subfolder within the Plugins directory
   * Copy the plugin contents into the newly created subfolder

4. Rebuild your project solution (if necessary)
   _Do this step only if you already have an existing project solution (i.e. if you have existing C++ source code)
   * Right click the .uproject file and select "Generate Visual Studio project files"
   * Once completed, open the newly created .sln file
   * Navigate to the top of the IDE and press build
   * Resolve compilation errors and debug your project (the plugin should be enabled automatically once the editor is loaded)
   
<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- ROADMAP -->
## Roadmap

- [x] Inventory
- [x] HUD
- [x] Player Stats
- [ ] Save management system
- [ ] AI
- [ ] World partitioning
- [ ] Updated YouTube presentation demos
- [ ] AWS CI/CD Integration
- [ ] Steam API
- [x] Combat mechanics
    - [x] Ground Combos
    - [x] Aerial Combos
    - [ ] Transformations
    - [ ] Projectiles
<p align="right">(<a href="#readme-top">back to top</a>)</p>
