/* narnia0 */
#include <stdio.h> 
#include <stdlib.h> 

int main(){ 
       long val=0x41414141; 
       char buf[20]; 

       printf("Correct val's value from 0x41414141 -> 0xdeadbeef!\n"); 
       printf("Here is your chance: "); 
       scanf("%24s",&buf); 

       printf("buf: %s\n",buf); 
       printf("val: 0x%08x\n",val); 

       if(val==0xdeadbeef) 
               system("/bin/sh"); 
       else { 
               printf("WAY OFF!!!!\n"); 
               exit(1); 
       } 

       return 0; 
}
