#include <stdio.h>

extern int isPrime(int n);
extern void asmMain();

int main()
{
	asmMain();
	return 0;
}

int isPrime(int n)
{
	int number;
	int IsPrime = 0;
	if (n == 1 || n == 0) {
		return 0;
	}
	for (number = 2; number <= n/2; number++) {
		if (n % number == 0) {
			IsPrime++;
		}
	}

	if (IsPrime == 0) {
		return 1;
	}
	else
		return 0;
}
