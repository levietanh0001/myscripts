VAR="global variable"

function foo {
    local VAR="local variable"
    echo $VAR
}

echo $VAR
foo
echo $VAR