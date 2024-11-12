<h1 align="center">[ $METACORTEX ]</h1>
<p align="center">The configuration files for my systems.</p>
![Static Badge](https://img.shields.io/badge/NixOS-badge?style=flat-square&logo=nixos&logoColor=%23ffffff&logoSize=auto&labelColor=7ebae4&color=7ebae4&link=https%3A%2F%2Fnixos.org)


There are some devices in my "Metacortex". All of them running NixOS (latest stable release) and use the Dracula Colors. I use a ThinkPad T470 (MC-IF-00) as my daily driver to manage all the Servers and do other stuff. The MC-IF-02 is a ThinkCentre that is my local server for git, keyboard-firmwares and other code. 

<p align="center">
  <img src="/img/screenshot01.png" width="600" />
</p>

<p align="center">
  <img src="/img/screenshot02.png" width="600" />
</p>

### SYSTEMS:
#### LOCAL:

<table>
    <tbody>
        <tr>
            <th>NAME</th>
            <th>CODENAME</th>
            <th>DEVICE</th>
            <th>MODULES</th>
        </tr>
        <tr>
            <td>MC-IF-00</td>
            <td>Frohike</td>
            <td>ThinkPad T470</td>
            <td><ul>
                    <li>configuration.nix</li>
                    <li>zsh.nix</li>
                    <li>nixvim.nix</li>
                    <li>qmk.nix</li>
                    <li>syncthing.nix</li>
                    <li>tmux.nix</li>
                </ul>
            </td>
        </tr>
        <tr>
            <td>MC-IF-02</td>
            <td>Skinner</td>
            <td>ThinkCentre</td>
            <td><ul>
                    <li>zsh.nix</li>
                    <li></li>
                    <li></li>
                    <li></li>
                    <li></li>
                </ul>
            </td>
        </tr>
    </tbody>
</table>



#### SERVER:
[MC-EX-00] - Webserver

[MC-EX-03] - Matrixserver

[MC-EX-04] - Nextcloud Server

