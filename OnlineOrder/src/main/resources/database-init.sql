-- ===========================================
-- Drop existing tables
-- ===========================================
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS menu_items;
DROP TABLE IF EXISTS restaurants;
DROP TABLE IF EXISTS carts;
DROP TABLE IF EXISTS authorities;
DROP TABLE IF EXISTS customers;

-- ===========================================
-- customers table
-- ===========================================
CREATE TABLE customers (
                           id SERIAL PRIMARY KEY NOT NULL,
                           email TEXT UNIQUE NOT NULL,
                           enabled BOOLEAN DEFAULT TRUE NOT NULL,
                           password TEXT NOT NULL,
                           first_name TEXT,
                           last_name TEXT
);

-- ===========================================
-- carts table
-- ===========================================
CREATE TABLE carts (
                       id SERIAL PRIMARY KEY NOT NULL,
                       customer_id INTEGER UNIQUE NOT NULL,
                       total_price NUMERIC NOT NULL,
                       CONSTRAINT fk_customer FOREIGN KEY (customer_id)
                           REFERENCES customers (id) ON DELETE CASCADE
);

-- ===========================================
-- restaurants table
-- ===========================================
CREATE TABLE restaurants (
                             id SERIAL PRIMARY KEY NOT NULL,
                             name TEXT NOT NULL,
                             address TEXT,
                             image_url TEXT,
                             phone TEXT
);

-- ===========================================
-- menu_items table
-- ===========================================
CREATE TABLE menu_items (
                            id SERIAL PRIMARY KEY NOT NULL,
                            restaurant_id INTEGER NOT NULL,
                            name TEXT NOT NULL,
                            price NUMERIC NOT NULL,
                            description TEXT,
                            image_url TEXT,
                            CONSTRAINT fk_restaurant FOREIGN KEY (restaurant_id)
                                REFERENCES restaurants (id) ON DELETE CASCADE
);

-- ===========================================
-- order_items table
-- ===========================================
CREATE TABLE order_items (
                             id SERIAL PRIMARY KEY NOT NULL,
                             menu_item_id INTEGER NOT NULL,
                             cart_id INTEGER NOT NULL,
                             price NUMERIC NOT NULL,
                             quantity INTEGER NOT NULL,
                             CONSTRAINT fk_cart FOREIGN KEY (cart_id)
                                 REFERENCES carts (id) ON DELETE CASCADE,
                             CONSTRAINT fk_menu_item FOREIGN KEY (menu_item_id)
                                 REFERENCES menu_items (id) ON DELETE CASCADE
);

-- ===========================================
-- authorities table
-- ===========================================
CREATE TABLE authorities (
                             id SERIAL PRIMARY KEY NOT NULL,
                             email TEXT NOT NULL,
                             authority TEXT NOT NULL,
                             CONSTRAINT fk_customer FOREIGN KEY (email)
                                 REFERENCES customers (email) ON DELETE CASCADE
);

-- ===========================================
-- Sample data for restaurants
-- ===========================================
INSERT INTO restaurants (name, address, image_url, phone)
VALUES
    ('Burger King', '773 N Mathilda Ave, Sunnyvale, CA 94085',
     'https://img.cdn4dd.com/cdn-cgi/image/fit=contain,width=1920,format=auto,quality=50/https://cdn.doordash.com/media/store/header/2170171.png',
     '(408) 736-0101'),
    ('SGD Tofu House', '3450 El Camino Real #105, Santa Clara, CA 95051',
     'https://img.cdn4dd.com/cdn-cgi/image/fit=contain,width=1920,format=auto,quality=50/https://cdn.doordash.com/media/store/header/2151799.jpg',
     '(408) 261-3030'),
    ('Fashion Wok', '163 S Murphy Ave, Sunnyvale, CA 94086',
     'https://img.cdn4dd.com/cdn-cgi/image/fit=contain,width=1920,format=auto,quality=50/https://cdn.doordash.com/media/store/header/2273997.jpg',
     '(408) 739-8866');

-- ===========================================
-- Sample data for menu_items
-- ===========================================
INSERT INTO menu_items (description, image_url, name, price, restaurant_id)
VALUES
    ('Made with white meat chicken, our Chicken Fries are coated in a light crispy breading seasoned with savory spices and herbs.',
     'https://img.cdn4dd.com/cdn-cgi/image/fit=contain,width=300,format=auto,quality=50/https://cdn.doordash.com/media/photos/1493436f-c5ab-47af-bacd-7b73ab60a24b-retina-large.jpg',
     'Chicken Fries - 9 Pc', 4.89, 1),

    ('Our Whopper Sandwich is a 1/4 lb of savory flame-grilled beef topped with juicy tomatoes, fresh lettuce, creamy mayonnaise, ketchup, crunchy pickles, and sliced white onions on a soft sesame seed bun.',
     'https://img.cdn4dd.com/cdn-cgi/image/fit=contain,width=300,format=auto,quality=50/https://cdn.doordash.com/media/photos/8f78ba69-681b-4670-a0fb-b71320ad9e79-retina-large.jpg',
     'Whopper Meal', 10.59, 1),

    ('Our Impossible Whopper Sandwich features a savory flame-grilled patty made from plants topped with juicy tomatoes, fresh lettuce, creamy mayonnaise, ketchup, crunchy pickles, and sliced white onions on a soft sesame seed bun.',
     'https://img.cdn4dd.com/cdn-cgi/image/fit=contain,width=1920,format=auto,quality=50/https://cdn.doordash.com/media/photos/530c55cf-4d2d-41a2-a6f0-9762aaa8ee8e-retina-large.jpg',
     'Impossible Whopper', 7.99, 1),

    ('Say hello to our HERSHEY''S Sundae Pie. One part crunchy chocolate crust and one part chocolate creme filling, garnished with a delicious topping and real HERSHEY''S Chocolate Chips.',
     'https://img.cdn4dd.com/cdn-cgi/image/fit=contain,width=1920,format=auto,quality=50/https://cdn.doordash.com/media/photos/b0816f0d-9e60-4868-b517-1a8d8eda42ca-retina-large.jpg',
     'HERSHEY''S Sundae Pie', 3.09, 1),

    ('Our Double Whopper Sandwich is a pairing of two 1/4 lb savory flame-grilled beef patties topped with juicy tomatoes, fresh lettuce, creamy mayonnaise, ketchup, crunchy pickles, and sliced white onions on a soft sesame seed bun.',
     'https://img.cdn4dd.com/cdn-cgi/image/fit=contain,width=1920,format=auto,quality=50/https://cdn.doordash.com/media/photos/93bd7958-e457-d3a8-938d-5184f48c2687-retina-large.jpg',
     'Double Whopper Meal', 11.69, 1),

    ('Our Original Chicken Sandwich is lightly breaded and topped with a simple combination of shredded lettuce and creamy mayonnaise on a sesame seed bun.',
     'https://img.cdn4dd.com/cdn-cgi/image/fit=contain,width=1920,format=auto,quality=50/https://cdn.doordash.com/media/photos/31d5862c-06ee-42ad-bc44-b7db35a42547-retina-large.jpg',
     'Spicy Crispy Chicken Sandwich', 6.09, 1),

    ('Our Bacon King Sandwich features two 1/4 lb savory flame-grilled beef patties, topped with a hearty portion of thick-cut smoked bacon, melted American cheese and topped with ketchup and creamy mayonnaise all on a soft sesame seed bun.',
     'https://img.cdn4dd.com/cdn-cgi/image/fit=contain,width=1920,format=auto,quality=50/https://cdn.doordash.com/media/photos/3e81754f-f4e9-4e9d-bf80-8a1eb5012032-retina-large.jpg',
     'Bacon King Sandwich Meal', 12.19, 1),

    ('Tofu boiled with your choice of meat and mushrooms. Served with your choice of side and an assortment of kimchi dishes.',
     'https://img.cdn4dd.com/cdn-cgi/image/fit=contain,width=1920,format=auto,quality=50/https://cdn.doordash.com/media/photos/3a4d835f-bad7-441f-96af-c43dcfe63c6d-retina-large.jpg',
     'Classic OREO Shake', 3.99, 2),

    ('Tofu boiled with beef, shrimp, and clams. Served with your choice of side and an assortment of kimchi dishes.',
     'https://img.cdn4dd.com/cdn-cgi/image/fit=contain,width=1920,format=auto,quality=50/https://cdn.doordash.com/media/photos/37ad1974-1395-4e5c-86ff-fd12f0f8c58b-retina-large.jpg',
     'Combination Soft Tofu', 17.06, 2),

    ('Squid, clam, imitation crab, and grilled onions fried in batter.',
     'https://img.cdn4dd.com/cdn-cgi/image/fit=contain,width=1920,format=auto,quality=50/https://cdn.doordash.com/media/photos/68bc8289-1950-4b4f-823d-12f33943a5fe-retina-large.jpg',
     'Seafood Soft Tofu', 17.06, 2),

    ('Tofu boiled with dumplings, rice cake, and beef. Served with your choice of side and an assortment of kimchi dishes.',
     'https://img.cdn4dd.com/cdn-cgi/image/fit=contain,width=1920,format=auto,quality=50/https://cdn.doordash.com/media/photos/6340c369-2485-4640-aefc-ac9048480844-retina-large.jpg',
     'Beef Short Ribs', 29.36, 2);

