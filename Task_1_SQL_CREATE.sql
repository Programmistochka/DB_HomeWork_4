CREATE TABLE IF NOT EXISTS genres (
	genre_id SERIAL PRIMARY KEY,
	name VARCHAR(80) NOT NULL	
); 

CREATE TABLE IF NOT EXISTS performers (
	performer_id SERIAL PRIMARY KEY,
	name VARCHAR(80) NOT NULL	
); 

CREATE TABLE IF NOT EXISTS genres_performers (
	id_gp SERIAL PRIMARY KEY,
	genre_id INTEGER NOT NULL REFERENCES genres(genre_id),
	performer_id INTEGER NOT NULL REFERENCES performers(performer_id)
);

CREATE TABLE IF NOT EXISTS albums (
	album_id SERIAL PRIMARY KEY,
	name VARCHAR(120) NOT NULL,	
	album_year INTEGER NOT null, check (album_year > 1990)
);

CREATE TABLE IF NOT EXISTS performers_albums (
	id_pa SERIAL PRIMARY KEY,
	performer_id INTEGER NOT NULL REFERENCES performers(performer_id),
	album_id INTEGER NOT NULL REFERENCES albums(album_id)
);

CREATE TABLE IF NOT EXISTS tracks (
	track_id SERIAL PRIMARY KEY,
	name VARCHAR(120) NOT NULL,
	duration TIME NOT NULL,
    album_id INTEGER NOT NULL REFERENCES albums(album_id)
);

CREATE TABLE IF NOT EXISTS collections (
	collection_id SERIAL PRIMARY KEY,
	name VARCHAR(120) NOT NULL,
	collect_year INTEGER NOT NULL CHECK (collect_year > 1990)
);

CREATE TABLE IF NOT EXISTS tracks_collections (
	id_tc SERIAL PRIMARY KEY,
	track_id INTEGER NOT NULL REFERENCES tracks(track_id),
	collection_id INTEGER NOT NULL REFERENCES collections(collection_id)
);