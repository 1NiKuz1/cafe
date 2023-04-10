-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Апр 10 2023 г., 14:03
-- Версия сервера: 8.0.30
-- Версия PHP: 8.1.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `dfbzvcir_m2`
--

-- --------------------------------------------------------

--
-- Структура таблицы `menus`
--

CREATE TABLE `menus` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` double(8,2) NOT NULL,
  `menu_category_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `menus`
--

INSERT INTO `menus` (`id`, `name`, `description`, `price`, `menu_category_id`, `created_at`, `updated_at`) VALUES
(1, 'Laborum molestias sed voluptatem modi minus consequuntur expedita.', 'Omnis quia fugiat in quae odit mollitia. Eos et labore dolorum voluptas sed est. Ducimus reprehenderit nulla sapiente. Eius autem ratione perferendis quis. Libero ea quia ullam vero. Dolores nostrum sit accusantium quae.', 1778.00, 1, '2021-04-03 04:23:07', '2021-04-03 04:23:07'),
(2, 'Aperiam autem qui sunt quibusdam qui.', 'Inventore vel consequuntur enim. Aliquam maiores dolorem voluptatibus dolores omnis accusamus nisi. Quos amet asperiores saepe et saepe. Nesciunt qui suscipit accusantium eius eaque officiis. Et sed qui placeat sed veniam.', 1507.00, 2, '2021-04-03 04:23:07', '2021-04-03 04:23:07'),
(3, 'Et vel consequatur maiores eaque autem quia aliquid.', 'In atque inventore corrupti. Perspiciatis dolorem et aut qui. Aut commodi non delectus ipsam recusandae. Et quisquam minus nemo id dolorem quia iste. Eveniet eaque sequi ut earum qui ullam.', 364.00, 1, '2021-04-03 04:23:07', '2021-04-03 04:23:07'),
(4, 'Sequi est accusamus nobis aut.', 'Est molestiae dolores voluptatem eos. Libero sit ut amet soluta voluptas. Esse soluta accusantium voluptatibus. Maiores ullam pariatur et quidem sed nulla quisquam.', 1955.00, 3, '2021-04-03 04:23:07', '2021-04-03 04:23:07'),
(5, 'Delectus ut eius et.', 'Sit libero unde sint reprehenderit. Impedit suscipit soluta eos necessitatibus quasi quia sed. Iure ea natus eveniet voluptates illo minus. Nisi ullam sed sit consequatur nulla illo. Aut cum dolorum consequatur veniam.', 1049.00, 3, '2021-04-03 04:23:07', '2021-04-03 04:23:07'),
(6, 'Fugit vel hic in aut sed velit aut.', 'Nulla neque et nobis vitae neque. Vitae harum sint explicabo et eum. Neque architecto aut odit quasi esse ipsa incidunt fugit.', 1475.00, 2, '2021-04-03 04:23:07', '2021-04-03 04:23:07'),
(7, 'Blanditiis excepturi rem ipsum expedita delectus consectetur.', 'Dolor sit impedit mollitia optio reprehenderit. Fugiat laboriosam vero dolorum expedita temporibus adipisci eius.', 1535.00, 1, '2021-04-03 04:23:07', '2021-04-03 04:23:07'),
(8, 'Et consequatur sequi eum omnis blanditiis ut sed.', 'Voluptas et dolores officiis laborum. Illum sint nesciunt omnis. Quia autem maxime quo illo. Corporis recusandae fugiat odit ullam.', 226.00, 3, '2021-04-03 04:23:07', '2021-04-03 04:23:07'),
(9, 'Voluptas nemo rerum sapiente qui.', 'Voluptatum est fuga qui sunt accusamus aspernatur voluptatum facere. Doloremque illo perspiciatis est suscipit. Labore itaque id dolorum ab. Maxime ea aut aut autem et laboriosam. Velit id id voluptatem.', 415.00, 2, '2021-04-03 04:23:07', '2021-04-03 04:23:07'),
(10, 'Expedita est quibusdam quo quidem facere nobis.', 'Aliquam enim provident qui sunt. Beatae perferendis suscipit rem ratione architecto magni aut. Eum quis explicabo praesentium molestiae sint perspiciatis.', 1212.00, 1, '2021-04-03 04:23:07', '2021-04-03 04:23:07');

-- --------------------------------------------------------

--
-- Структура таблицы `menu_categories`
--

CREATE TABLE `menu_categories` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `menu_categories`
--

INSERT INTO `menu_categories` (`id`, `name`) VALUES
(1, 'Основные блюда'),
(2, 'Напитки'),
(3, 'Десерты');

-- --------------------------------------------------------

--
-- Структура таблицы `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2021_03_23_141635_create_tables_table', 1),
(2, '2021_03_23_142356_create_roles_table', 1),
(3, '2021_03_23_142815_create_menu_categories_table', 1),
(4, '2021_03_23_143222_create_users_table', 1),
(5, '2021_03_23_152629_create_work_shifts_table', 1),
(6, '2021_03_23_153122_create_shift_workers_table', 1),
(7, '2021_03_23_154221_create_menus_table', 1),
(8, '2021_03_23_154834_create_status_orders_table', 1),
(9, '2021_03_23_154955_create_orders_table', 1),
(10, '2021_03_23_155313_create_order_menus_table', 1);

-- --------------------------------------------------------

--
-- Структура таблицы `orders`
--

CREATE TABLE `orders` (
  `id` bigint UNSIGNED NOT NULL,
  `number_of_person` int DEFAULT NULL,
  `table_id` bigint UNSIGNED NOT NULL,
  `shift_worker_id` bigint UNSIGNED NOT NULL,
  `status_order_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `orders`
--

INSERT INTO `orders` (`id`, `number_of_person`, `table_id`, `shift_worker_id`, `status_order_id`, `created_at`, `updated_at`) VALUES
(1, 1, 9, 3, 3, NULL, '2023-03-23 08:08:50'),
(2, 10, 2, 2, 3, NULL, '2023-03-23 08:10:09'),
(36, 3, 1, 19, 5, '2023-03-24 04:36:27', '2023-03-24 04:38:58'),
(37, 8, 8, 19, 3, '2023-03-24 04:40:00', '2023-03-24 04:40:34');

-- --------------------------------------------------------

--
-- Структура таблицы `order_menus`
--

CREATE TABLE `order_menus` (
  `id` bigint UNSIGNED NOT NULL,
  `menu_id` bigint UNSIGNED NOT NULL,
  `order_id` bigint UNSIGNED NOT NULL,
  `count` int NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `roles`
--

CREATE TABLE `roles` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `roles`
--

INSERT INTO `roles` (`id`, `name`, `code`) VALUES
(1, 'Администратор', 'admin'),
(2, 'Официант', 'waiter'),
(3, 'Повар', 'cook');

-- --------------------------------------------------------

--
-- Структура таблицы `shift_workers`
--

CREATE TABLE `shift_workers` (
  `id` bigint UNSIGNED NOT NULL,
  `work_shift_id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `shift_workers`
--

INSERT INTO `shift_workers` (`id`, `work_shift_id`, `user_id`, `created_at`, `updated_at`) VALUES
(1, 1, 1, NULL, NULL),
(2, 1, 2, NULL, NULL),
(3, 1, 3, NULL, NULL),
(4, 2, 1, NULL, NULL),
(5, 2, 2, NULL, NULL),
(6, 2, 3, NULL, NULL),
(7, 3, 1, NULL, NULL),
(8, 3, 2, NULL, NULL),
(9, 3, 3, NULL, NULL),
(18, 10, 16, '2023-03-24 04:34:51', '2023-03-24 04:34:51'),
(19, 10, 17, '2023-03-24 04:34:55', '2023-03-24 04:34:55'),
(20, 10, 18, '2023-03-24 04:34:59', '2023-03-24 04:34:59');

-- --------------------------------------------------------

--
-- Структура таблицы `status_orders`
--

CREATE TABLE `status_orders` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `status_orders`
--

INSERT INTO `status_orders` (`id`, `name`, `code`) VALUES
(1, 'Принят', 'taken'),
(2, 'Готовится', 'preparing'),
(3, 'Готов', 'ready'),
(4, 'Оплачен', 'paid-up'),
(5, 'Отменен', 'canceled');

-- --------------------------------------------------------

--
-- Структура таблицы `tables`
--

CREATE TABLE `tables` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `capacity` smallint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `tables`
--

INSERT INTO `tables` (`id`, `name`, `capacity`) VALUES
(1, 'Столик №1', 9),
(2, 'Столик №2', 2),
(3, 'Столик №3', 4),
(4, 'Столик №4', 7),
(5, 'Столик №5', 2),
(6, 'Столик №6', 2),
(7, 'Столик №7', 2),
(8, 'Столик №8', 3),
(9, 'Столик №9', 8),
(10, 'Столик №10', 5);

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `surname` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `patronymic` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `login` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `photo_file` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `api_token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('working','fired') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'working',
  `role_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`id`, `name`, `surname`, `patronymic`, `login`, `password`, `photo_file`, `api_token`, `status`, `role_id`, `created_at`, `updated_at`) VALUES
(1, 'Hosea', 'Cecile', 'Carmen', 'admin', 'admin', NULL, NULL, 'working', 1, '2021-04-03 04:23:07', '2023-03-28 12:02:32'),
(2, 'Trace', 'Tremayne', 'Austin', 'waiter', 'waiter', NULL, NULL, 'working', 2, '2021-04-03 04:23:07', '2023-03-24 04:31:00'),
(3, 'Earline', 'Mckenzie', 'Alayna', 'cook', 'cook', NULL, NULL, 'working', 3, '2021-04-03 04:23:07', '2023-03-24 04:16:25'),
(16, 'Jhon', NULL, NULL, 'admin1', 'admin1', NULL, NULL, 'working', 1, '2023-03-24 04:32:38', '2023-03-24 04:35:23'),
(17, 'Meryc', NULL, NULL, 'waiter2', 'waiter2', NULL, NULL, 'working', 2, '2023-03-24 04:33:09', '2023-03-24 04:40:08'),
(18, 'Tommy', NULL, NULL, 'cook1', 'cook1', NULL, NULL, 'working', 3, '2023-03-24 04:33:39', '2023-03-24 04:40:37');

-- --------------------------------------------------------

--
-- Структура таблицы `work_shifts`
--

CREATE TABLE `work_shifts` (
  `id` bigint UNSIGNED NOT NULL,
  `start` datetime NOT NULL,
  `end` datetime NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `work_shifts`
--

INSERT INTO `work_shifts` (`id`, `start`, `end`, `active`, `created_at`, `updated_at`) VALUES
(1, '2021-04-19 08:00:00', '2021-04-19 18:00:00', 0, NULL, '2023-03-24 04:34:18'),
(2, '2021-04-20 08:00:00', '2021-04-20 18:00:00', 0, NULL, '2023-03-24 04:34:20'),
(3, '2021-04-21 08:00:00', '2021-04-21 18:00:00', 0, NULL, '2023-03-17 15:31:07'),
(10, '2023-03-24 10:34:00', '2023-03-24 11:34:00', 1, '2023-03-24 04:34:38', '2023-03-24 04:34:46');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `menus`
--
ALTER TABLE `menus`
  ADD PRIMARY KEY (`id`),
  ADD KEY `menus_menu_category_id_foreign` (`menu_category_id`);

--
-- Индексы таблицы `menu_categories`
--
ALTER TABLE `menu_categories`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `orders_table_id_foreign` (`table_id`),
  ADD KEY `orders_shift_worker_id_foreign` (`shift_worker_id`),
  ADD KEY `orders_status_order_id_foreign` (`status_order_id`);

--
-- Индексы таблицы `order_menus`
--
ALTER TABLE `order_menus`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_menus_menu_id_foreign` (`menu_id`),
  ADD KEY `order_menus_order_id_foreign` (`order_id`);

--
-- Индексы таблицы `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_code_unique` (`code`);

--
-- Индексы таблицы `shift_workers`
--
ALTER TABLE `shift_workers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `shift_workers_work_shift_id_foreign` (`work_shift_id`),
  ADD KEY `shift_workers_user_id_foreign` (`user_id`);

--
-- Индексы таблицы `status_orders`
--
ALTER TABLE `status_orders`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `tables`
--
ALTER TABLE `tables`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_login_unique` (`login`),
  ADD KEY `users_role_id_foreign` (`role_id`);

--
-- Индексы таблицы `work_shifts`
--
ALTER TABLE `work_shifts`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `menus`
--
ALTER TABLE `menus`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT для таблицы `menu_categories`
--
ALTER TABLE `menu_categories`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT для таблицы `orders`
--
ALTER TABLE `orders`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT для таблицы `order_menus`
--
ALTER TABLE `order_menus`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

--
-- AUTO_INCREMENT для таблицы `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `shift_workers`
--
ALTER TABLE `shift_workers`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT для таблицы `status_orders`
--
ALTER TABLE `status_orders`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `tables`
--
ALTER TABLE `tables`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT для таблицы `work_shifts`
--
ALTER TABLE `work_shifts`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `menus`
--
ALTER TABLE `menus`
  ADD CONSTRAINT `menus_menu_category_id_foreign` FOREIGN KEY (`menu_category_id`) REFERENCES `menu_categories` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_shift_worker_id_foreign` FOREIGN KEY (`shift_worker_id`) REFERENCES `shift_workers` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `orders_status_order_id_foreign` FOREIGN KEY (`status_order_id`) REFERENCES `status_orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `orders_table_id_foreign` FOREIGN KEY (`table_id`) REFERENCES `tables` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `order_menus`
--
ALTER TABLE `order_menus`
  ADD CONSTRAINT `order_menus_menu_id_foreign` FOREIGN KEY (`menu_id`) REFERENCES `menus` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_menus_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `shift_workers`
--
ALTER TABLE `shift_workers`
  ADD CONSTRAINT `shift_workers_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `shift_workers_work_shift_id_foreign` FOREIGN KEY (`work_shift_id`) REFERENCES `work_shifts` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
