
/*
* AstroTinker Bot (AB): Task 1B Path Planner
*
* This program computes the valid path from the start point to the end point.
* Make sure you don't change anything outside the "Add your code here" section.
* Updated memory addresses for Task 2B
*/

#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>

#ifdef __linux__ // for host pc

    #include <stdio.h>

    void _put_byte(char c) { putchar(c); }

    void _put_str(char *str) {
        while (*str) {
            _put_byte(*str++);
        }
    }

    void print_output(uint8_t num) {
        if (num == 0) {
            putchar('0'); // if the number is 0, directly print '0'
            _put_byte('\n');
            return;
        }

        if (num < 0) {
            putchar('-'); // print the negative sign for negative numbers
            num = -num;   // make the number positive for easier processing
        }

        // convert the integer to a string
        char buffer[20]; // assuming a 32-bit integer, the maximum number of digits is 10 (plus sign and null terminator)
        uint8_t index = 0;

        while (num > 0) {
            buffer[index++] = '0' + num % 10; // convert the last digit to its character representation
            num /= 10;                        // move to the next digit
        }

        // print the characters in reverse order (from right to left)
        while (index > 0) { putchar(buffer[--index]); }
        _put_byte('\n');
    }

    void _put_value(uint8_t val) { print_output(val); }

#else  // for the test device

    void _put_value(uint8_t val) { }
    void _put_str(char *str) { }

#endif

/*
Functions Usage

instead of using printf() function for debugging,
use the below function calls to print a number, string or a newline

for newline: _put_byte('\n');
for string:  _put_str("your string here");
for number:  _put_value(your_number_here);

Examples:
        _put_value(START_POINT);
        _put_value(END_POINT);
        _put_str("Hello World!");
        _put_byte('\n');

*/

// main function
int main(int argc, char const *argv[]) {

    #ifdef __linux__

        const uint8_t START_POINT   = atoi(argv[1]);
        const uint8_t END_POINT     = atoi(argv[2]);
        uint8_t NODE_POINT          = 0;
        uint8_t CPU_DONE            = 0;

    #else
        // Address value of variables are updated for RISC-V Implementation
        #define START_POINT         (* (volatile uint8_t * ) 0x02000000)
        #define END_POINT           (* (volatile uint8_t * ) 0x02000004)
        #define NODE_POINT          (* (volatile uint8_t * ) 0x02000008)
        #define CPU_DONE            (* (volatile uint8_t * ) 0x0200000c)

    #endif

    // array to store the planned path
    uint8_t path_planned[32];
    // index to keep track of the path_planned array
    uint8_t idx = 1;

    // ############# Add your code here #############
     uint8_t nbr[31][4]={{1,0,0,0},{29,2,0,0},{8,3,1,0},{4,2,0,0},{6,5,3,0},{4,0,0,0},
   {7,4,0,0},{8,6,0,0},{12,9,7,2},{11,10,8,0},{9,0,0,0},{9,0,0,0},
   {13,8,0,0},{14,12,0,0},{16,15,13,0},{14,0,0,0},{18,17,14,0},{16,0,0,0},
   {19,16,0,0},{20,18,0,0},{29,24,21,19},{23,22,20,0},{21,0,0,0},{21,0,0,0},
   {25,20,0,0},{26,24,0,0},{28,27,25,0},{26,0,0,0},{29,26,0,0},{28,20,1,0},
   };

    uint8_t  b,c=0,reverse_path_planned[32];

   if(START_POINT<END_POINT+1){
       path_planned[0]=START_POINT;
       b=START_POINT;
       while(b!=END_POINT){
        c=0;
        if(b==9 && END_POINT>=12){
         path_planned[idx]=8;    
        }else if(b==21 && END_POINT>=24){
          path_planned[idx]=20; 
        }else{
        while(1){
        if(nbr[b][c]<END_POINT+1){
        path_planned[idx]=nbr[b][c];
        break;
        }
        c++;
       }
     }
       b=path_planned[idx];
       idx++;
       }
   } else{
    uint8_t a;
    reverse_path_planned[0]=END_POINT;
       b=END_POINT;
       while(b!=START_POINT){
        c=0;
         if(b==9 && START_POINT>=12){
         reverse_path_planned[idx]=8;    
        }else if(b==21 && START_POINT>=24){
          reverse_path_planned[idx]=20; 
        }else{
        while(1){
        if(nbr[b][c]<START_POINT+1){
        reverse_path_planned[idx]=nbr[b][c];
        break;
        }
        c++;
       }
    }
       b=reverse_path_planned[idx];
       idx++;
       }
       a=idx;
       for(int i=a-1;i>=0;i--){
        path_planned[a-1-i]=reverse_path_planned[i];
       }
   }
    // ##############################################

    // the node values are written into data memory sequentially.
    for (int i = 0; i < idx; ++i) {
        NODE_POINT = path_planned[i];
    }
    // Path Planning Computation Done Flag
    CPU_DONE = 1;

    #ifdef __linux__    // for host pc

        _put_str("######### Planned Path #########\n");
        for (int i = 0; i < idx; ++i) {
            _put_value(path_planned[i]);
        }
        _put_str("################################\n");

    #endif

    return 0;
}