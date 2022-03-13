#include <stdio.h>

int main()
{
	unsigned char mass[10] = {9, 123, 95, 22, 91, 52,251, 1, 30, 76};  /*Массив из 10 элементов*/
    int sum = 0;  /*Обнулили счетчик для суммы массива*/

    for (int i = 0; i < 10; i++) /*Цикл*/
    {
        if (i % 2 != 0)  /*Нечетное значение индекса*/
            mass[i] = mass[i] | 0b00010000; /*Логичесское ИЛИ  в 4-бите всех нечтных байтов массива устанавдиваем 1*/
        else /*Четное*/
            mass[i] = mass[i] & 0b11011111; /*Логическое И в 5 бите всех четных устанавлмваем 0*/

        sum += mass[i];  /*Суммируем элеменьы полученного массива*/
    }

        printf("Sum of all array elements: %d\n", sum);

    return 0;
}
