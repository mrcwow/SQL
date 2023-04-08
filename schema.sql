# создание базы данных
CREATE DATABASE bus_park_dispatcher;
USE bus_park_dispatcher;

# тип автобуса
CREATE TABLE type (
    type_id INT PRIMARY KEY AUTO_INCREMENT,
    type VARCHAR(100),
    capacity INT
);
# заполнение таблицы типов автобуса данными
INSERT INTO type(type, capacity)
VALUES ('Маленький', 41),
       ('Средний', 107),
       ('Большой', 149),
       ('Особо большой', 162),
       ('Крупный', 169);

# график работы
CREATE TABLE schedule (
    schedule_id INT PRIMARY KEY AUTO_INCREMENT,
    time1 TIME,
    time2 TIME
);
# заполнение таблицы графика работы данными
INSERT INTO schedule(time1, time2)
VALUES ('05:00:00', '09:00:00'),
       ('09:00:00', '13:00:00'),
       ('13:00:00', '17:00:00'),
       ('17:00:00', '21:00:00'),
       ('21:00:00', '01:00:00');

# стаж и класс
CREATE TABLE exp_class (
    exp_class_id INT PRIMARY KEY AUTO_INCREMENT,
    experience INT,
    class VARCHAR(100)
);
# заполнение таблицы стажа и класса данными
INSERT INTO exp_class(experience, class)
VALUES (1, 'Новичок'),
       (3, 'Опытный'),
       (5, 'Опытный'),
       (6, 'Практичный'),
       (7, 'Мастер своего дела');

# оклады
CREATE TABLE salary_exp_class (
    exp_class_id INT PRIMARY KEY AUTO_INCREMENT,
    amount INT,
    FOREIGN KEY (exp_class_id) REFERENCES exp_class (exp_class_id) ON DELETE CASCADE
);
# заполнение таблицы окладов данными
INSERT INTO salary_exp_class(amount)
VALUES (35000),
       (50000),
       (70000),
       (90000),
       (100000);

# маршруты
CREATE TABLE route (
    route_id INT PRIMARY KEY AUTO_INCREMENT,
    route_number INT,
    starting_point VARCHAR(100),
    destination VARCHAR(100),
    start_time TIME,
    end_time TIME,
    interval_time TIME,
    duration TIME
);
# заполнение таблицы маршрутов данными
INSERT INTO route(route_number, starting_point, destination, start_time, end_time, interval_time, duration)
VALUES (219, 'Udelnaya', 'Pionerskaya', '05:31:00', '00:31:00', '00:15:00', '00:10:00'),
       (127, 'Kolomyagi', 'Artseulovskaya_Alley', '05:21:00', '00:31:00', '00:07:00', '00:37:00'),
       (171, 'JSC_UEC-Klimov', 'Shavrova', '06:06:00', '00:10:00', '00:12:00', '00:40:00'),
       (235, 'Staraya Derevnya Metro Station', 'Zemsky Lane', '05:31:00', '00:01:00', '00:14:00', '00:52:00'),
       (285, 'Friendly Avenue', 'Rusakovskaya Street', '06:01:00', '00:01:00', '00:08:00', '00:15:00');

# автобусы
CREATE TABLE bus (
    bus_id INT PRIMARY KEY AUTO_INCREMENT,
    reg_number INT,
    bus_status VARCHAR(100),
    type_id INT,
    route_id INT,
    FOREIGN KEY (type_id) REFERENCES type (type_id) ON DELETE SET NULL,
    FOREIGN KEY (route_id) REFERENCES route (route_id) ON DELETE SET NULL
);
# заполнение таблицы автобусов данными
INSERT INTO bus(reg_number, bus_status, type_id, route_id)
VALUES (111, 'Работает', 1, 1),
       (222, 'Работает', 2, 2),
       (333, 'Работает', 2, 3),
       (444, 'Работает', 3, 4),
       (445, 'Работает', 1, 5);

# водители
CREATE TABLE driver (
    driver_id INT PRIMARY KEY AUTO_INCREMENT,
    passport INT UNSIGNED,
    driver_status VARCHAR(100),
    route_id INT,
    schedule_id INT,
    exp_class_id INT,
    FOREIGN KEY (route_id) REFERENCES route (route_id) ON DELETE SET NULL,
    FOREIGN KEY (schedule_id) REFERENCES schedule (schedule_id) ON DELETE SET NULL,
    FOREIGN KEY (exp_class_id) REFERENCES exp_class (exp_class_id) ON DELETE SET NULL
);
# заполнение таблицы водителей данными
INSERT INTO driver(passport, driver_status, route_id, schedule_id, exp_class_id)
VALUES (4000356789, 'Здоров', 3, 1, 2),
       (3000867321, 'Здоров', 5, 1, 1),
       (4011789009, 'Здоров', 1, 3, 1),
       (4005328742, 'Здоров', 2, 3, 2),
       (4014938049, 'Здоров', 4, 2, 3);

# водители и автобусы
CREATE TABLE driver_bus (
    driver_id INT,
    bus_id INT,
    FOREIGN KEY (driver_id) REFERENCES driver (driver_id) ON DELETE SET NULL,
    FOREIGN KEY (bus_id) REFERENCES bus (bus_id) ON DELETE SET NULL
);
# заполнение таблицы водителей и автобусов данными
INSERT INTO driver_bus(driver_id, bus_id)
VALUES (1, 3),
       (2, 5),
       (3, 1),
       (4, 2),
       (5, 4);