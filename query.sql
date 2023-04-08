# Список водителей, работающих на 219 маршруте с указанием графика их работы
SELECT driver.driver_id AS Номер_водителя, passport AS Паспорт_водителя, time1 AS Начало_смены, time2 AS Конец_смены
FROM driver
JOIN driver_bus db on driver.driver_id = db.driver_id
JOIN schedule USING(schedule_id)
JOIN route USING(route_id)
WHERE route_number = 219;

# Какие автобусы обслуживают 235 маршрут
SELECT bus_id AS Номер_автобуса_в_системе, reg_number AS Номер_государственной_регистрации_автобуса
FROM bus
JOIN route USING(route_id)
WHERE route_number = 235;

# Какие маршруты начинаются в пункте JSC_UEC-Klimov
SELECT route_number AS Номер_маршрута
FROM route
WHERE starting_point LIKE 'JSC_UEC-Klimov';
# Какие маршруты заканчиваются в пункте Artseulovskaya_Alley
SELECT route_number AS Номер_маршрута
FROM route
WHERE destination LIKE 'Artseulovskaya_Alley';

# Когда начинается и заканчивается движение автобусов на каждом маршруте
SELECT route_number AS Номер_маршрута, start_time AS Начало_движения_автобусов, end_time AS Конец_движения_автобусов
FROM route;

# Какова протяженность 127 маршрута
SELECT route_number AS Номер_маршрута, duration AS Протяженность_маршрута
FROM route
WHERE route_number = 127;

# Какова общая протяженность маршрутов, обслуживаемых автопарком
SELECT SEC_TO_TIME(SUM(TIME_TO_SEC(duration))) AS Общая_протяженность_маршрутов
FROM route;

# Изменение данных в таблице автобусов и таблице водителей
UPDATE bus
SET bus_status = 'Неисправен'
WHERE bus_id = 1;
UPDATE driver
SET driver_status = 'Болеет'
WHERE driver_id = 5;

# Какие автобусы не вышли на линию, и по какой причине
SELECT bus.bus_id AS Номер_автобуса_в_системе, reg_number AS Номер_государственной_регистрации_автобуса,
       IF(bus_status NOT LIKE 'Работает', 'Да', 'Нет') AS Неисправность_автобуса,
       IF(driver_status NOT LIKE 'Здоров', 'Да', 'Нет') AS Отсутствие_водителя
FROM bus
JOIN driver_bus db on bus.bus_id = db.bus_id
JOIN driver d on db.driver_id = d.driver_id
WHERE bus_status NOT LIKE 'Работает' OR driver_status NOT LIKE 'Здоров';

# Изменение данных в таблице автобусов и таблице водителей
UPDATE bus
SET bus_status = 'Работает'
WHERE bus_id = 1;
UPDATE driver
SET driver_status = 'Здоров'
WHERE driver_id = 5;
