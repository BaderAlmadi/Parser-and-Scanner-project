#!/bin/bash
echo "=== Comprehensive Parser Test Suite ==="
echo ""

# Build the parser first
echo "1. Building parser..."
./build.sh > /dev/null 2>&1
if [ ! -f "parser" ]; then
    echo "❌ ERROR: Could not build parser. Stopping tests."
    exit 1
fi
echo "✅ Parser built successfully."
echo ""

# Test 1: Simple assignment (basic functionality)
echo "2. Test 1: Simple Assignment"
cat > test1.txt << 'EOF'
x := 5
write x
EOF
echo "   Program:" && cat test1.txt
echo -n "   Result: "
./parser < test1.txt && echo "   ✅ PASS" || echo "   ❌ FAIL"
echo ""

# Test 2: If statement (REQUIRED feature)
echo "3. Test 2: If Statement"
cat > test2.txt << 'EOF'
if 5 > 3 then
    write 1
else
    write 0
end
EOF
echo "   Program:" && cat test2.txt
echo -n "   Result: "
./parser < test2.txt && echo "   ✅ PASS" || echo "   ❌ FAIL"
echo ""

# Test 3: While loop (REQUIRED feature)
echo "4. Test 3: While Loop"
cat > test3.txt << 'EOF'
i := 0
while i < 3 do
    write i
    i := i + 1
end
EOF
echo "   Program:" && cat test3.txt
echo -n "   Result: "
./parser < test3.txt && echo "   ✅ PASS" || echo "   ❌ FAIL"
echo ""

# Test 4: Complex nested structure
echo "5. Test 4: Nested If-While"
cat > test4.txt << 'EOF'
read n
sum := 0
i := 0
while i < n do
    read x
    if x > 0 then
        sum := sum + x
    else
        write 0
    end
    i := i + 1
end
write sum
EOF
echo "   Program:" && cat test4.txt
echo -n "   Result: "
./parser < test4.txt && echo "   ✅ PASS" || echo "   ❌ FAIL"
echo ""

# Test 5: Error messages (REQUIRED feature)
echo "6. Test 5: Error Handling"
cat > test5.txt << 'EOF'
x = 5 + 3  # Missing : before =
if x then  # Missing condition
    y := 10
end
EOF
echo "   Program:" && cat test5.txt
echo "   Expected: Should show clear error messages"
echo -n "   Result: "
./parser < test5.txt 2>&1 && echo "   ❌ FAIL (should error)" || echo "   ✅ PASS (correctly errored)"
echo ""

echo "=== Test Summary ==="
echo "All required features tested:"
echo "1. Basic assignment ✓"
echo "2. If statements ✓"
echo "3. While loops ✓"
echo "4. Nested structures ✓"
echo "5. Error messages ✓"
echo ""
