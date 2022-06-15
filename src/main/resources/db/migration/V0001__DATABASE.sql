DROP TABLE IF EXISTS tb_users CASCADE;
DROP TABLE IF EXISTS tb_user_type CASCADE;

DROP TABLE IF EXISTS tb_restaurant CASCADE;
DROP TABLE IF EXISTS tb_restaurant_type CASCADE;

DROP TABLE IF EXISTS tb_state CASCADE;
DROP TABLE IF EXISTS tb_city CASCADE;
DROP TABLE IF EXISTS tb_district CASCADE;
DROP TABLE IF EXISTS tb_address CASCADE;

DROP TABLE IF EXISTS tb_item CASCADE;
DROP TABLE IF EXISTS tb_item_image CASCADE;

DROP TABLE IF EXISTS tb_order CASCADE;
DROP TABLE IF EXISTS tb_order_item CASCADE;
DROP TABLE IF EXISTS tb_order_status CASCADE;


CREATE TABLE IF NOT EXISTS tb_role(
	id BIGSERIAL PRIMARY KEY,
	description VARCHAR(55) NOT NULL,
	
	created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  	updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE TABLE IF NOT EXISTS tb_users (
	id BIGSERIAL PRIMARY KEY,
	id_user_type BIGINT NOT NULL,
	name VARCHAR(55) NOT NULL,
	last_name VARCHAR(55) NOT NULL,
	email VARCHAR(55) NOT NULL,
	phone VARCHAR(12) NOT NULL,
	password VARCHAR(200) NOT NULL,
	active boolean NOT NULL,
	
	created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  	updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
	
	CONSTRAINT fk_user_has_type
		FOREIGN KEY(id_user_type) REFERENCES tb_role(id)
			ON DELETE CASCADE
			ON UPDATE CASCADE
);
CREATE TABLE IF NOT EXISTS tb_restaurant_type(
	id BIGSERIAL PRIMARY KEY,
	description VARCHAR(55) NOT NULL
);
CREATE TABLE IF NOT EXISTS tb_restaurant(
	id BIGSERIAL PRIMARY KEY,
	id_restaurant_type BIGINT NOT NULL,
	id_restaurant_address BIGINT NOT NULL,
	name VARCHAR(55) NOT NULL,
	
	created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  	updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
	
	CONSTRAINT restaurant_has_type
		FOREIGN KEY(id_restaurant_type) REFERENCES tb_restaurant_type(id)
);
CREATE TABLE IF NOT EXISTS tb_state(
	id BIGSERIAL PRIMARY KEY,
	name VARCHAR(55) NOT NULL
);
CREATE TABLE IF NOT EXISTS tb_city(
	id BIGSERIAL PRIMARY KEY,
	id_state BIGINT NOT NULL,
	name VARCHAR(55) NOT NULL,
	
	CONSTRAINT city_has_state
		FOREIGN KEY(id_state) REFERENCES tb_state(id)
		ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE IF NOT EXISTS tb_district(
	id BIGSERIAL PRIMARY KEY,
	id_city BIGINT NOT NULL,
	name VARCHAR(55) NOT NULL,
	
	CONSTRAINT district_has_city
		FOREIGN KEY(id_city) REFERENCES tb_city(id)
		ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE IF NOT EXISTS tb_address(
	id BIGSERIAL PRIMARY KEY,
	id_district BIGINT NOT NULL,
	postcode BIGINT  NOT NULL,
	street VARCHAR(55)  NOT NULL,
	number INTEGER NOT NULL,
	reference text,
	
	CONSTRAINT address_has_district
		FOREIGN KEY(id_district) REFERENCES tb_district(id)
		ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE IF NOT EXISTS tb_order_status(
	id BIGSERIAL PRIMARY KEY,
	description varchar(55) NOT NULL
);
CREATE TABLE IF NOT EXISTS tb_order(
	id BIGSERIAL PRIMARY KEY,
	sub_total NUMERIC (12,2) NOT NULL,
	shipping_price NUMERIC (12,2) NOT NULL,
	total_value NUMERIC (12,2) NOT NULL,
	confirmation_date TIMESTAMPTZ,
	
	id_order_status INTEGER NOT NULL,
	id_restaurant BIGINT NOT NULL,
	
	created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  	updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
	
	CONSTRAINT fk_order_has_status FOREIGN KEY (id_order_status) REFERENCES tb_order_status(id) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_order_has_restaurant FOREIGN KEY (id_restaurant) REFERENCES tb_restaurant(id) ON DELETE CASCADE ON UPDATE CASCADE
);
-- INSERT INTO tb_order_item(quantity, unit_price, total_price, description)
CREATE TABLE IF NOT EXISTS tb_item(
	id BIGSERIAL PRIMARY KEY,
	id_restaurant BIGINT NOT NULL,
	
	name bigint NOT NULL,
	description TEXT NOT NULL,
	price NUMERIC(12,2) NOT NULL,
	
	created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  	updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
	
	CONSTRAINT product_has_restaurant FOREIGN KEY(id_restaurant) REFERENCES tb_restaurant(id)
			ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE IF NOT EXISTS tb_item_image(
	id BIGSERIAL PRIMARY KEY,
	id_item BIGINT NOT NULL,
	img_url VARCHAR(200) NOT NULL,
	media_type VARCHAR(10) NOT NULL,
	size FLOAT NOT NULL,
	
	CONSTRAINT item_image_has_item FOREIGN KEY(id_item) REFERENCES tb_item(id)
	ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE IF NOT EXISTS tb_order_item(
	id BIGSERIAL PRIMARY KEY,
	id_product BIGINT NOT NULL,
	id_order BIGINT NOT NULL,
	quantity bigint NOT NULL,
	total_price NUMERIC(12,2) NOT NULL,
	description TEXT,
	
	created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  	updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
	
	CONSTRAINT order_item_has_item
		FOREIGN KEY(id_product) REFERENCES tb_item(id)
	ON DELETE CASCADE ON UPDATE CASCADE,
	
	CONSTRAINT order_item_has_order
		FOREIGN KEY(id_order) REFERENCES tb_order(id)
);
-- APPLIYNG CONCEPT OF SOFT DELETE
-- FIRST, I CREATED A EMPTY TABLE WITH USERS COLUMNS
DROP TABLE IF EXISTS tb_deleted_users;
CREATE TABLE IF NOT EXISTS tb_deleted_users AS TABLE tb_users WITH NO DATA;
-- AND I CREATED A FUNCTION TO MODE DELETED USERS TO TABLE
CREATE OR REPLACE FUNCTION fc_move_deleted_users() RETURNS TRIGGER AS $$
	BEGIN
		INSERT INTO tb_deleted_users VALUES((OLD).*);
		RETURN OLD;
	END;
$$ LANGUAGE plpgsql;
-- AND I CREATED A TRIGGER THAT WILL CALLS AFTER A USER BE DELETED
CREATE TRIGGER trigger_move_deleted_users
	BEFORE DELETE ON tb_users
		FOR EACH ROW
		EXECUTE PROCEDURE fc_move_deleted_users();
-- timestamp function and trigger
CREATE OR REPLACE FUNCTION fc_set_timestamp() RETURNS TRIGGER AS $$
  BEGIN
      NEW.updated_at = now();
      RETURN NEW;
  END;
  $$ language 'plpgsql';
 
CREATE TRIGGER trigger_set_timestamp 
	BEFORE UPDATE ON tb_users
	FOR EACH ROW EXECUTE PROCEDURE fc_set_timestamp();