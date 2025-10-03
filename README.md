# DevContainer per Reti Logiche

DevContainer per il corso di **Reti Logiche**.
È pensato per funzionare anche su **Apple Silicon** (tramite Docker Desktop) e su **Linux/Windows** senza bisogno di WSL/UTM.

---

## Requisiti

* Docker Desktop (su Mac/Windows) o Docker su Linux
* Visual Studio Code
* Estensione Dev Containers in VSCode

---

## Istruzioni rapide

1. Clona questa repo:

   ```bash
   git clone https://github.com/MartyMcFly2905/devcontainer_reti.git
   cd devcontainer_reti
   ```
2. Apri la cartella in VSCode.
3. Premi **F1** → “Dev Containers: Reopen in Container”.
4. Attendi la build (ci mette qualche minuto la prima volta).

---

## Setup Reti Logiche

L'ambiente per Reti Logiche viene configurato **automaticamente** la prima volta che il container viene creato.

Lo script `setup_reti.sh` esegue i seguenti passaggi:

1.  Scarica l'archivio ufficiale fornito dal docente.
2.  Estrae i file necessari in `/workspace/reti_logiche/`.
3.  Crea i file `./Assemble.sh` e `debug.sh`.

Al termine della build, troverai la cartella `reti_logiche/linux` pronta nel tuo workspace.

### Test

Per testare, deve restituire `Tutto OK`:

```
#nella cartella reti_logiche/linux

./Assemble.sh demo/demo1.s

./demo/demo1
```

Per il debug: `./debug.sh demo/demo1`.

>All'esame i duali sono `./Assemble.ps1` e `./Debug.ps1`

---

## Note

* Il container include già `nasm`, `gcc-multilib`, `gdb`, `iverilog`, `gtkwave`.
* Estensioni VSCode sono installate automaticamente.
