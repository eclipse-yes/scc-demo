int main()
{
    int a = 50; int sum = 0;
    // outer loop
    for (int i = 0; i < a * 2; i = i + 1) {
        // inner loop
        for (int j = 0; j < a ; j = j + 1) { 
            if (j < a / 2 && j % 2 != 0 ) { 
                sum = sum + i * j / 2 + i * j; 
            } else { 
                while (sum > j || ! sum % 2 == 1) { 
                    sum = sum - 3 / 2; 
                } 
            } 
        } 
    }
    // print the value of `sum` 
    printf(sum);
    return 0; 
}
