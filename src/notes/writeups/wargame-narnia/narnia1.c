/* narnia1 */
#include <stdio.h> 

int main(){ 
       int (*ret)(); 

       if(getenv("EGG")==NULL){     
               printf("Give me something to execute at the env-variable EGG\n"); 
               exit(1); 
       } 

       printf("Trying to execute EGG!\n"); 
       ret = getenv("EGG"); 
       ret(); 

       return 0; 
}
