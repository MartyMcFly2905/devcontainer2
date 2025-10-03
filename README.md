# DevContainer per Reti Logiche e Calcolatori (UniPi)

Questo DevContainer funziona sia per il corso di **Reti Logiche** che per **Calcolatori Elettronici**.
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
   git clone https://github.com/MartyMcFly2905/devcontainer-reti-calcolatori.git
   cd reti-logiche-devcontainer
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
3.  Esegue un test di compilazione per Assembly e Verilog per assicurarsi che tutto funzioni.

Al termine della build, troverai la cartella `reti_logiche` pronta nel tuo workspace.

---

## Test ambiente

### Assembly

```bash
cd /workspace/reti_logiche
nasm -f elf32 test-ambiente.s -o test-ambiente.o
gcc -m32 test-ambiente.o -o test-ambiente
./test-ambiente
```

Output atteso:

```
Ok.
```

### Verilog

```bash
iverilog -o test-ambiente.vvp test-ambiente.v
vvp test-ambiente.vvp
```

Output atteso:

```
Ok.
```

---

## Debug Assembly

Compilazione con simboli:

```bash
nasm -f elf32 -g -F dwarf test-ambiente.s -o test-ambiente.o
gcc -m32 test-ambiente.o -o test-ambiente
gdb ./test-ambiente
```

Poi usa `break`, `run`, `stepi` per debug step-by-step.

---

## Note

* Il container include già `nasm`, `gcc-multilib`, `gdb`, `iverilog`, `gtkwave`.
* Per Calcolatori, contiene anche `libce` e `qemu-ce`.
* Estensioni VSCode (Assembly, Verilog, C/C++, PDF) sono installate automaticamente.

