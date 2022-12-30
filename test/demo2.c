int main() { 
    int a = 1, b = 1; int c;
    // Fibonacci
    for (int i = 2; i < 20; i = i + 1) {
        c = a; a = a + b; b = c;
    }
    printf(a);
    printf(b);
    return 0;
}
