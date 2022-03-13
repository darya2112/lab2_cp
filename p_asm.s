.data                   /* блок программы с данными */


mass:                   /* метка (адрес) начала массива */
	.byte 9, 123, 95, 22, 91, 52, 251, 1, 30, 76
mass_end:               /* метка (адрес) конца массива */

print_format:           /* формат вывода для printf */
    .string "Sum of all array elements: %d\n"

.text                   /* блок программы с командами (основная часть программы) */

.global main            /* говорим, чтобы при запуске программы он начинал с main */
.type main, @function   /* указываем, что main - функция */

/*
eax - адрес текущего элемента массива
ebx - значение текущего элемента массива
ecx - номер текущего элемента массива (с 0 по 9, так как всего 10 элементов)
edx - промежуточное, нужно для проверки четности

esi - хранит сумму
*/

main:                       /* ИНИЦИАЛИЗАЦИЯ ДАННЫХ */
    movl $mass, %eax        /* записываем первый адрес массива в eax */
    xorl %ecx, %ecx         /* обнуляем счетчик элементов массива */
    xorl %esi, %esi         /* обнуляем сумму */
    xorl %ebx, %ebx

start:                      /* ЦИКЛ, КОТОРЫЙ ОБРАБАТЫВАЕТ МАССИВ ПО ЗАДАНИЮ */
    movb (%eax), %bl         /* записываем в ebx значение по адресу eax */

    movl %ecx, %edx         /* записываем в edx номер текущего элемента (номер хранится в ecx) */
    and $1, %edx            /* проверяем последний бит (если стоит в 1, то значение нечет)
                               ПРИМЕР РАБОТЫ:
                               1 and 5 => 1 and 101 (перевели 5 в двоичную систему) =>
                               => 001 and 101 (добавили к 1 нули, которые не испортят программу,
                               а лишь помогут нам лучше работать) => 001
                            */
    cmpl $1, %edx           /* сравниваем 1 c полученным результатом*/
    jne chet                /* если не совпадает, то прыгаем на chet */

nechet:                     /* РАБОТА С НЕЧЕТ ЧИСЛАМИ */
    or $0x10, %bl           /* установка четвертого бита в 0 (0x10 = 0001 0000) */
    jmp check_end_mass      /* прыгаем на check_end_mass */

chet:                       /* РАБОТА С ЧЕТНЫМИ ЧИСЛАМИ */
    and $0xDF, %bl          /* установка пятого бита в 0 (0xDF = 1101 1111) */

check_end_mass:             /* ПРОВЕРКА НА КОНЕЦ МАССИВА */
    movb %bl, (%eax)        /* перезаписываем старое значение массива новым */
    addl %ebx, %esi         /* прибавляем к сумме новое значение */
    inc %eax                /* увеличиваем адресс массива на 1 (числа в массиве = 1 байту,
                               поэтому и увеличиваем всего на 1 */
    inc %ecx                /* увеличить значение номера текущего элемента */

    cmpl $mass_end, %eax    /* если адресс текущего эоемента (eax)
                               не совпадает с концом массива (mass_end) */
    jne start               /* повторяем действие */


                            /* ВЫВОД МАССИВА НА ЭКРАН */
    pushl %esi              /* помещаем в стэк текущее значение элемента массива */
    pushl $print_format     /* помещаем в стэк формат вывода */
    call printf             /* вызываем функцию printf из библиотеки С */
    addl $8, %esp           /* обнуляем последние 2 значения стэка (объяснинть лично) */

    movl $1, %eax           /* 1 - код, означающая ВОЗВРАТ ЗНАЧЕНИЯ */
    movl $0, %ebx           /* 0 - возвращаемое значение */
    int $0x80               /* вызвать возврат значения */
