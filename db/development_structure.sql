CREATE TABLE "authors" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "first_name" varchar(255), "last_name" varchar(255), "created_at" datetime, "updated_at" datetime);
CREATE TABLE "authors_books" ("author_id" integer NOT NULL, "book_id" integer NOT NULL);
CREATE TABLE "books" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "title" varchar(255) NOT NULL, "publisher_id" integer NOT NULL, "published_at" datetime, "isbn" varchar(13), "blurb" text, "page_count" integer, "price" float, "cover_image" varchar(255));
CREATE TABLE "publishers" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255) NOT NULL, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "schema_migrations" ("version" varchar(255) NOT NULL);
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
INSERT INTO schema_migrations (version) VALUES ('20111011171318');

INSERT INTO schema_migrations (version) VALUES ('20111018080025');

INSERT INTO schema_migrations (version) VALUES ('20111019174235');

INSERT INTO schema_migrations (version) VALUES ('20111028222435');