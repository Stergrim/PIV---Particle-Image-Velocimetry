# Цифровая трассерная визуализация <br> (PIV – Particle image velocimetry)
В репозитории представлена реализация метода кросскорреляции для определения
локальных смещений оптического потока. Основная область применения – это измерения
жидких и газообразных потоков (PIV), измерения деформации твердых тел
(Digital Image Correlation) и восстановление 3d-формы поверхности объекта при
стереосъемке (стереозрение).

## Каталоги в этом репозитории
>**demos**: демонстрация проекта на примерах и результаты измерения точности <br>
>**matlab**: код проекта, описание методов и функциональная схема

## Запуск
Пример запуска проекта находится в скрипте [main](/matlab/main.m).
Описание модулей в [readme каталога matlab](/matlab/README.md).
В `main` приведены примеры различных сценариев обработки.
В зависимости от задачи можно индивидуально собирать процесс
обработки (сценарий) для формирования оптимального решения.

## Описание проекта
Основная идея этого проекта – это создание модульной основы (скелета)
для разработки собственных решений на основе метода кросскорреляционной
обработки. Текущая реализация уступает в точности проекту [**OpenPIV**](https://openpiv.readthedocs.io/en/latest/index.html),
но имеет более гибкую настройку. **OpenPIV** ограничен размерами окон опроса
степени **2** и не позволяет настраивать отдельно параметры на каждой итерации.
Возможно в большинстве приложений не требуется большего, но текущий проект
предлагает большую свободу в настройки сценария обработки как в
количестве проходов, так и параметрах на каждой итерации. Применять
проект изначально предполагалось не только для измерения потоков

<p float="left">
<img src="/demos/VortexPair.gif" width="300" />
<img src="/demos/example_1.png" width="300" />
</p>

но и для задач стереозрения. Изображения для задачи стереозрения получены на
[стенде, имитирующем деформацию поверхности крыла летательного аппарата](https://github.com/Stergrim/Recalibration-of-a-stereo-pair-based-on-a-reprojection-error/tree/main)
(или из [магистерской работы страница 74 рисунок 36](/demos/DiplomMaster.pdf)).

<p float="left">
<img src="/demos/SheetSurface.gif" width="300" />
<img src="/demos/example_2.png" width="340" /> 
</p>

Для удобной визуализации результатов написан простой пользовательский интерфейс
[show](/matlab/show.m) с различными параметрами отображения

<p float="left">
<img src="/demos/example_3.png" width="640" />
</p>

Достигнуть точность сравнимой с **OpenPIV** возможно, если переработать
модули `resize`(`multigrid`), `deform_images`(`deform`), `validate_outliers`,
`interpolate` и `smoothing`. В этих методах используется простые обработки на
основе встроенных функций в ***Matlab***. Это сделано с целью более простого
понимания процесса обработки в проекте. Возможно относительная простота и
модульность проекта позволит использовать его в качестве не только основы
(скелета) для других решений, но и в образовательных целях. <br>
Пример точности **OpenPIV** приведен в скрипте [test_processing](/matlab/test_processing.m)
в переменных `mean_target` и `max_target`. Также в каталоге [openpiv_data](/demos/openpiv_data)
есть примеры обработки **OpenPIV** с визуализацией как из python,
так и из ***Matlab***. Обработка осуществлена 3-ёх проходным методом с деформацией
окна опроса с размерами окон опроса **32, 16, 8** пикселей. <br>
В [readme каталога demos](/demos/README.md) приведено сравнение точности
для 5-ти различных сценариев на примере [датасета для PIV](https://github.com/abrosua/cai-piv_dataset).

## Замечания
Этот проект не отличается высокой надежностью. Добиться ошибки выполнения довольно
просто, например, после метода `smoothing` поставить `subpixel_peak`, т.к.
`subpixel_peak` не обрабатывает дробные смещения, или в методе `pass` на первом
проходе задать параметр `‘type_pass’ = ‘next’` и тому подобное. Проектом можно
пользоваться как готовой программой, но в первую очередь он рассчитан на программистов,
которые могут использовать его как основу для разработки собственных решений. <br>
По поводу обработки границ изображения. Отказался от расширения изображения для
расчета векторов до границы. На данный момент ближайший вектор к границе
находится на расстоянии половины окна опроса последнего прохода. <br>
Буду рад аргументированной критике и советам по улучшению проекта.
