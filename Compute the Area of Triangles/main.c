#include <stdio.h>
#include <stdlib.h>
#include <math.h>

/*
this a program to calculate the area of a triangle
inputs are 6 integers which are indicated to three coordinate
for example: 0 0 0 1 1 0, means (0, 0) (0, 1) (1, 0)
*/

struct Point2D{
    int x;
    int y;
};

struct Triangle{
    double a;
    double b;
    double c;
    double Area;
};


double calDist(struct Point2D temp, struct Point2D temp2){
    double dist;
    dist = sqrt(pow((temp2.x-temp.x), 2)+ pow((temp2.y-temp.y), 2));
    return dist;
}

double calArea(struct Triangle temp){
    double area;
    double s = (temp.a+temp.b+temp.c)/2;
    area = sqrt(s*(s-temp.a)*(s-temp.b)*(s-temp.c));
    return area;
}

int main()
{
    int input[6] = {0};
    for(int i = 0; i < 6; ++i){
        scanf("%d", &input[i]);
    }

    struct Point2D point1 = {input[0], input[1]};
    struct Point2D point2 = {input[2], input[3]};
    struct Point2D point3 = {input[4], input[5]};


    struct Triangle example;
    example.a = calDist(point1, point2);
    example.b = calDist(point2, point3);
    example.c = calDist(point3, point1);
    example.Area = calArea(example);

    printf("%.3lf\n", example.Area);

    return 0;
}
