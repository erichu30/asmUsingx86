#include <stdio.h>
#include <stdlib.h>

int main(void)
{
    int i, input, cnt = 0;
    while(scanf("%d",&input)!=EOF)
    {
        if(input < 0 ){
            break;
        }

        if(input==1)
        {
            printf("\n");
            continue;
        }

        for(i = 2;i <= input; i++){

            while(input % i == 0){
                input = input / i;
                cnt++;
            }

            if(cnt > 0){
                if(input == 1 && cnt == 1){
                    printf("%d\n",i);
                }else if(input == 1 && cnt != 1){
                    printf("%d^%d\n", i, cnt);
                }else if(input != 1. && cnt == 1){
                    printf("%d * ",i);
                }else if(input != 1 && cnt != 1){
                    printf("%d^%d * ", i, cnt);
                }

                cnt = 0;
            }
        }
    }
    return 0;
}
