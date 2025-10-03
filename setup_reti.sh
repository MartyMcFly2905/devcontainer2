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

cd "$COURSE_DIR/linux"

# Crea assemble.sh
echo ">>> Creazione assemble.sh..."
cat > assemble.sh << 'EOF'
#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Usage: $0 <file.s>"
    exit 1
fi

sourceFile=$1
name=$(basename "$sourceFile" .s)

gcc -m32 -o "${sourceFile%.s}" -Wa,-a -Wa,--defsym,LINUX=1 -g ./files/main.c "$sourceFile" ./files/utility.s

if [ $? -eq 0 ]; then
    echo "Compiled successfully: ${sourceFile%.s}"
else
    echo "Compilation failed"
    exit 1
fi
EOF

# Crea debug.sh
echo ">>> Creazione debug.sh..."
cat > debug.sh << 'EOF'
#!/bin/bash

[ $# -eq 0 ] && echo "Usage: $0 <executable>" && exit 1
[ ! -f "$1" ] && echo "Error: File '$1' not found" && exit 1

# Usa SEMPRE gdb_startup se esiste
if [ -f "./files/gdb_startup" ]; then
    echo "=== GDB DEBUG (with startup) ==="
    echo "File: $1"
    gdb -x "./files/gdb_startup" "$1"
else
    echo "=== GDB DEBUG (manual) ==="
    echo "File: $1"
    echo "Type 'run' to start"
    gdb -ex "break main" -ex "run" "$1"
fi
EOF

# Rendi eseguibili gli script
chmod +x assemble.sh debug.sh

echo ">>> Setup completato!"
echo ">>> Script creati: assemble.sh, debug.sh"