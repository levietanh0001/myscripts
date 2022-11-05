#!/bin/bash
function function_A {
        echo $1
}
function function_B {
        echo $1.
}
function function_C {
        echo $1
}
function function_D {
        echo $1
}

function_A "Salute from function A"
function_B "Hello from function B"
function_C "Greetings from function C"
function_D "Good day from function D"