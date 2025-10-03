
#!/bin/bash
# Script di setup per ambiente Reti Logiche nel DevContainer

set -e

COURSE_DIR="/workspace/reti_logiche"
ZIP_URL="https://docenti.ing.unipi.it/~a080368/Teaching/RetiLogiche/pdf/Ambienti/linux.zip"
ZIP_FILE="linux.zip"

echo ">>> Creazione cartella $COURSE_DIR..."
mkdir -p "$COURSE_DIR"

# Scarica lo zip ufficiale se non già presente
if [ ! -f "$ZIP_FILE" ]; then
    echo ">>> Scarico l'ambiente ufficiale da $ZIP_URL..."
    wget -O "$ZIP_FILE" "$ZIP_URL"
else
    echo ">>> Trovato $ZIP_FILE in locale."
fi

# Estrazione
echo ">>> Estraggo $ZIP_FILE in $COURSE_DIR..."
unzip -o "$ZIP_FILE" -d "$COURSE_DIR"

cd "$COURSE_DIR"

# Test assembler
if [ -f "test-ambiente.s" ]; then
    echo ">>> Compilo ed eseguo test-ambiente.s..."
    nasm -f elf32 test-ambiente.s -o test-ambiente.o
    gcc -m32 test-ambiente.o -o test-ambiente
    ./test-ambiente || echo "Attenzione: test-ambiente.s non ha stampato 'Ok.'"
fi

# Test Verilog
if [ -f "test-ambiente.v" ]; then
    echo ">>> Compilo ed eseguo test-ambiente.v..."
    iverilog -o test-ambiente.vvp test-ambiente.v
    vvp test-ambiente.vvp || echo "Attenzione: test-ambiente.v non ha stampato 'Ok.'"
fi

echo ">>> Setup completato!"
