#!/bin/bash

echo "=== Simple Language Parser Build ==="
echo ""

# --- 1. Setup and Cleanup ---
cd "/c/Users/B/OneDrive/Desktop" || exit
echo "Cleaning old files..."
rm -f parser parser.exe Parser2.0.tab.c Parser2.0.tab.h Scanner2.0.yy.c lex.yy.c *.o

# --- 2. Generate Parser and Scanner ---
echo "Generating parser with Bison..."
bison -d Parser2.0.y -o Parser2.0.tab.c
if [ $? -ne 0 ]; then
    echo "[ERROR] Bison failed. Check Parser2.0.y for syntax errors."
    exit 1
fi

echo "Generating scanner with Flex..."
flex -o Scanner2.0.yy.c Scanner2.0.l
if [ $? -ne 0 ]; then
    echo "[ERROR] Flex failed. Check Scanner2.0.l for syntax errors."
    exit 1
fi

# --- 3. Compile ---
echo "Compiling with GCC..."
gcc -o parser Parser2.0.tab.c Scanner2.0.yy.c
if [ $? -ne 0 ]; then
    echo "[ERROR] Compilation failed."
    exit 1
fi

# --- 4. Test ---
echo ""
echo "[SUCCESS] Build complete! Testing with a simple program..."
cat > test.txt << 'EOF'
x := 5
write x
EOF

echo "Program:"
cat test.txt
echo ""
echo "Output:"
./parser < test.txt