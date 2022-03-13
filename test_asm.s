.data /*Модуль данных*/

print:  /*Метка,указывающая адрес начала данных*/
    .string "Test program ASM\n" /*Записываем строку в память компьютера (1 символ  занимает 1 байт)*/
    .set len_print, . - print - 1 /*Определяем длину выводимой строки */


.text /*Хранится исполняемый код*/

.global main /*Точка входа  в программу */
.type main, @function


main:  
    movl $4, %eax /*Системный вызов № 4-sys_write.Поместить код  системного вызова в регитср  eax */
    movl $1, %ebx /*Поток №1 -stdiut (стнадратный вывод).Поместить номер потока в регистр ebx */
    movl $print, %ecx /* Помещаем метку-адреса начала данных в регистр  есх (то есть указываем на выводимую строку)*/
    movl $len_print, %edx /*Помещаем метку-отвечающую за длину вывода строки в регитср edx.*/

    int $0x80  /*Прерывание, то есть  к процессору обращемся с кодом 80.Вызываем прерывание и возникает у процессора вопрс:а что жальше?
                Процессор смотрит на значения в двух первых регистрах, по коду ассемблера-вывод ссобщения,а что выводить?
                 Смотрим в регистре в есх адрес на выводимую строку ,а в регистре edх-длину выводимой строки*/

    movl $1, %eax /*Системный вызов №1-sys exit.Помещаем в регитср eax номер системного вызова  1(закрытие программы)у*/
    movl $0, %ebx /*ВЫход с кодом 0.Помещаем в регистр значение 0-код ошибки,которая будет возвращео.(можно заменить на исключающее или (если сопадают то 0)*/
    int $0x80 /*Прерывание,к процессору обращемся с кодом 80.Процессор смотрит на значения  регитсров и выполнеят действия- закрытие программы с кодом 0ы*/