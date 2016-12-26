#include <cstdio>

// This is the function we will later import to R
int fibCpp(const int n) {
  if(n == 0){
    return(0);
  } else if(n == 1){
    return(1);
  } else {
    return(fibCpp(n-1) + fibCpp(n-2));
  }
}

// Main function, required for C++
int main(void){
  int n; // Variables have to be initialized
  int z;
  printf("Write an integer greater or equal than 0:\n");
  scanf("%d", &n); // Assigns an user inputted digit to n
                   // Here %d is a formatted digit
  z = fibCpp(n); // Call the function we created previously
  printf("%d\n", z); 
}
