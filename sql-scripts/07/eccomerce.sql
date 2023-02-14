CREATE DATABASE if not EXISTS 'ogabe';

use 'ogabe';

--coupon

CREATE TABLE
    `coupon` (
        `coupon_id` BIGINT AUTO_INCREMENT PRIMARY KEY,
        `coupon_code` VARCHAR(255) NOT NULL UNIQUE,
        `coupon_discount_amount` INT NOT NULL,
        `coupon_quantity` INT NOT NULL,
        `used_coupon_quantity` INT NOT NULL,
        `coupon_create_date` DATETIME NOT NULL,
        `coupon_start_date` DATE NOT NULL,
        `coupon_expiration_date` DATE NOT NULL,
        `coupon_min_purchase_amount` INT NOT NULL,
        `coupon_name` VARCHAR(255) NOT NULL,
        `coupon_vip_level` INT NOT NULL
    ) ENGINE = InnoDB AUTO_INCREMENT = 1 DEFAULT CHARSET = latin1;

CREATE TABLE
    `product_coupon` (
        `product_coupon_id` BIGINT AUTO_INCREMENT PRIMARY KEY,
        `product_id` BIGINT NOT NULL,
        `coupon_id` BIGINT NOT NULL,
        FOREIGN KEY (`product_id`) REFERENCES `product`(`product_id`),
        FOREIGN KEY (`coupon_id`) REFERENCES `coupon`(`coupon_id`)
    ) ENGINE = InnoDB AUTO_INCREMENT = 1 DEFAULT CHARSET = latin1;

--商城

-- I cancelled the creation of the `order_status` table because it is not used in the

-- `order` table.

-- CREATE TABLE

--     `order_status` (

--         `order_status_id` BIGINT AUTO_INCREMENT PRIMARY KEY,

--         `status_name` VARCHAR(255) NOT NULL

--     ) ENGINE = InnoDB AUTO_INCREMENT = 1 DEFAULT CHARSET = latin1;

CREATE TABLE
    `order` (
        `order_id` BIGINT AUTO_INCREMENT PRIMARY KEY,
        `user_id` BIGINT NOT NULL,
        `order_date` DATETIME NOT NULL,
        `order_man` INT NOT NULL,
        `order_address` VARCHAR(255) NOT NULL,
        `order_contact` VARCHAR(20) NOT NULL,
        `coupon_code` VARCHAR(255) NOT NULL,
        `order_status` ENUM(
            'Pending',
            'Processing',
            'Completed',
            'Cancelled'
        ) NOT NULL DEFAULT 'Pending' FOREIGN KEY (`user_id`) REFERENCES `user`(`user_id`),
        FOREIGN KEY (`coupon_code`) REFERENCES `coupon`(`coupon_code`),
        --FOREIGN KEY (`order_status_id`) REFERENCES `order_status`(`order_status_id`)
    ) ENGINE = InnoDB AUTO_INCREMENT = 1 DEFAULT CHARSET = latin1;

CREATE TABLE
    `order_detail` (
        `order_detail_id` BIGINT AUTO_INCREMENT PRIMARY KEY,
        `order_id` BIGINT NOT NULL,
        `product_id` BIGINT NOT NULL,
        `order_qty` INT NOT NULL,
        `order_price` DECIMAL(10, 2) NOT NULL,
        FOREIGN KEY (`order_id`) REFERENCES `order`(`order_id`),
        FOREIGN KEY (`product_id`) REFERENCES `product`(`product_id`)
    ) ENGINE = InnoDB AUTO_INCREMENT = 1 DEFAULT CHARSET = latin1;

CREATE TABLE
    `product` (
        `product_id` BIGINT AUTO_INCREMENT PRIMARY KEY,
        `product_name` VARCHAR(255) NOT NULL,
        `product_create_date` DATE NOT NULL,
        `product_context` TEXT NOT NULL,
        `product_stock` INT NOT NULL,
        `product_type_id` BIGINT NOT NULL,
        `product_shelves_status` ENUM('On', 'Off') NOT NULL DEFAULT 'On',
        FOREIGN KEY (`product_type_id`) REFERENCES `product_type`(`product_type_id`)
    ) ENGINE = InnoDB AUTO_INCREMENT = 1 DEFAULT CHARSET = latin1;

CREATE TABLE
    `product_type` (
        `product_type_id` BIGINT AUTO_INCREMENT PRIMARY KEY,
        `product_type_name` VARCHAR(255) NOT NULL
    ) ENGINE = InnoDB AUTO_INCREMENT = 1 DEFAULT CHARSET = latin1;

CREATE TABLE
    `product_picture` (
        `product_picture_id` BIGINT AUTO_INCREMENT PRIMARY KEY,
        `product_id` BIGINT NOT NULL,
        `product_image` BLOB NOT NULL,
        FOREIGN KEY (`product_id`) REFERENCES `product`(`product_id`)
    ) ENGINE = InnoDB AUTO_INCREMENT = 1 DEFAULT CHARSET = latin1;

CREATE TABLE
    `cart` (
        `cart_id` BIGINT AUTO_INCREMENT PRIMARY KEY,
        `user_id` BIGINT NOT NULL,
        `product_id` BIGINT NOT NULL,
        `quantity` INT NOT NULL,
        FOREIGN KEY (`user_id`) REFERENCES `user`(`user_id`),
        FOREIGN KEY (`product_id`) REFERENCES `product`(`product_id`)
    ) ENGINE = InnoDB AUTO_INCREMENT = 1 DEFAULT CHARSET = latin1;

--vip LEVEL

CREATE TABLE
    `vip_level` (
        `vip_level_id` BIGINT AUTO_INCREMENT PRIMARY KEY,
        `vip_level_name` VARCHAR(255) NOT NULL,
        `min_spending_amount` INT NOT NULL
    ) ENGINE = InnoDB AUTO_INCREMENT = 1 DEFAULT CHARSET = latin1;

CREATE TABLE
    `user_vip_level` (
        `user_id` BIGINT NOT NULL,
        `vip_level_id` BIGINT NOT NULL,
        PRIMARY KEY (`user_id`, `vip_level_id`),
        FOREIGN KEY (`user_id`) REFERENCES `user`(`user_id`),
        FOREIGN KEY (`vip_level_id`) REFERENCES `vip_level`(`vip_level_id`)
    ) ENGINE = InnoDB DEFAULT CHARSET = latin1;