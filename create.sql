CREATE TABLE IF NOT EXISTS order_track_user(
    otu_id INT UNSIGNED UNIQUE AUTO_INCREMENT NOT NULL,
    otu_user_name VARCHAR(32) NOT NULL UNIQUE,
    otu_password VARCHAR(32) NOT NULL,
    otu_name VARCHAR(128) NOT NULL,
    otu_role SMALLINT NOT NULL,
    otu_is_active BOOLEAN NOT NULL,
    otu_change_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    otu_create_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY(otu_id)
)ENGINE = MYISAM CHARACTER SET utf8mb4;

CREATE TABLE IF NOT EXISTS order_track_order(
    oto_id INT UNSIGNED UNIQUE AUTO_INCREMENT NOT NULL,
    oto_customer VARCHAR(128) NOT NULL,
    oto_weight DECIMAL(10,2) NOT NULL,
    oto_total_price DECIMAL(10,2) NOT NULL,
    oto_trans_price DECIMAL(10,2) NOT NULL,
    oto_package_price DECIMAL(10,2) NOT NULL,
    oto_status SMALLINT NOT NULL,
    oto_order_time TIMESTAMP NOT NULL,
    oto_finish_time TIMESTAMP NOT NULL,
    oto_change_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    oto_create_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY(oto_id),
    FOREIGN KEY(oto_customer)
        REFERENCES order_user(otu_name)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
)ENGINE = MYISAM CHARACTER SET utf8mb4;

CREATE TABLE IF NOT EXISTS order_track_order_detail(
    otod_id INT UNSIGNED UNIQUE AUTO_INCREMENT NOT NULL,
    otod_order_id INT NOT NULL,
    otod_product_id INT NOT NULL,
    otod_package_id INT NOT NULL,
    otod_package_count INT NOT NULL,
    otod_total_price DECIMAL(10,2) NOT NULL,
    otod_trans_price DECIMAL(10,2) NOT NULL,
    otod_package_price DECIMAL(10,2) NOT NULL,
    otod_is_finish BOOLEAN NOT NULL,
    otod_change_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    otod_create_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY(otod_id),
    FOREIGN KEY(otod_order_id)
        REFERENCES order_track_order(oto_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    FOREIGN KEY(otod_package_id)
        REFERENCES order_track_package(otp_id)
        ON DELETE RESTRICT
        ON UPDATE NO ACTION,
    FOREIGN KEY(otod_product_id)
        REFERENCES order_track_product(otpr_id)
        ON DELETE RESTRICT
        ON UPDATE NO ACTION
)ENGINE = MYISAM CHARACTER SET utf8mb4;

CREATE TABLE IF NOT EXISTS order_track_package(
    otp_id INT UNSIGNED UNIQUE AUTO_INCREMENT NOT NULL,
    otp_name VARCHAR(128) NOT NULL UNIQUE,
    otp_type SMALLINT NOT NULL,
    otp_price DECIMAL(10,2) NOT NULL,
    otp_stock INT NOT NULL,
    otp_is_active BOOLEAN NOT NULL,
    otp_change_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    otp_create_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY(otp_id)
)ENGINE = MYISAM CHARACTER SET utf8mb4;

CREATE TABLE IF NOT EXISTS order_track_product(
    otpr_id INT UNSIGNED UNIQUE AUTO_INCREMENT NOT NULL,
    otpr_name VARCHAR(128) NOT NULL UNIQUE,
    otpr_price DECIMAL(10,2) NOT NULL,
    otpr_is_active BOOLEAN NOT NULL,
    otpr_change_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    otpr_create_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY(otpr_id)
)ENGINE = MYISAM CHARACTER SET utf8mb4;

CREATE TABLE IF NOT EXISTS order_track_transport(
    ott_id INT UNSIGNED UNIQUE AUTO_INCREMENT NOT NULL,
    ott_plate VARCHAR(8) NOT NULL,
    ott_order_id INT NOT NULL,
    ott_order_detail_id INT NOT NULL,
    ott_count INT NOT NULL,
    ott_weight DECIMAL(10,2) NOT NULL,
    ott_price DECIMAL(10,2) NOT NULL,
    ott_type TINYINT NOT NULL,
    ott_isactive BOOLEAN NOT NULL,
    ott_change_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    ott_create_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY(ott_id),
    FOREIGN KEY(ott_order_id, ott_order_detail_id)
        REFERENCES order_track_order_detail(otod_order_id, otod_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
)ENGINE = MYISAM CHARACTER SET utf8mb4;

CREATE TABLE IF NOT EXISTS order_track_work_record(
    otwr_id INT UNSIGNED UNIQUE AUTO_INCREMENT NOT NULL,
    otwr_name VARCHAR(32) NOT NULL UNIQUE,
    otwr_order_detail_id INT NOT NULL,
    otwr_type SMALLINT NOT NULL,
    otwr_workload INT NOT NULL,
    otwr_start_time TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00',
    otwr_finish_time TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00',
    PRIMARY KEY(otwr_id),
    FOREIGN KEY(otwr_name)
        REFERENCES order_user(otu_name)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    FOREIGN KEY(otwr_order_detail_id)
        REFERENCES order_track_order_detail(otod_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
)ENGINE = MYISAM CHARACTER SET utf8mb4;

-- CREATE TABLE IF NOT EXISTS order_track_extra(
--     ote_id INT UNSIGNED UNIQUE AUTO_INCREMENT NOT NULL,
--     ote_name VARCHAR(128) NOT NULL UNIQUE,
--     ote_price DECIMAL(5,2) NOT NULL,
--     ote_is_active BOOLEAN NOT NULL,
--     PRIMARY KEY(ote_id)
-- )ENGINE = MYISAM CHARACTER SET utf8mb4;
