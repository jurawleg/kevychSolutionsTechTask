Привіт, ревьювер!

1. Стрінги, іконки та колори не виносив в окремий модуль чи файл, чи взагалі - бо їх тут мало, апка теж маленька, часу не було. Але при наступній ітерації винесеться, так як планувалось допиляти сторінку з сеттінгами, профайл юзера та інші штуки.

2. Нетворк лейєр - примітивний, бо смикається небагато ендпойнтів, та й не хотів городити город з комбайном та канцеллябельними тасками. 
    Не було змісту, в апці 2,5 мережевих виклики на життєвий цикл.
    
3. Код в основних скрінах (список на 16 айтемів та сьорчшит) - можна та треба рефакторити, щоб виглядало чистіше та читабельніше.

4. Довелось взяти оцю апішку, бо на 16 айтемів запропонована апішка - вже платна. Також довелось нагородити конвертацію моделей, бо така вже в них структура. Зробив конвертацію просто методом в вьюмоделі, бо не бачив змісту на повноцінний Адаптер ))

5. Треба імплементнути кеш для локацій, які вже шукались. Там діла на 15 хвилин, зроблю це за вівторок.

6. Чекаю відгуків на пошту або в гіток.
