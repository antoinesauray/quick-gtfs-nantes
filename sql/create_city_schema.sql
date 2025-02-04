REVOKE SELECT ON spatial_ref_sys, geometry_columns FROM var_name;
DROP EXTENSION postgis;
DROP schema var_name cascade;
DROP OWNED BY var_name;
DROP USER var_name;
CREATE USER var_name PASSWORD 'var_name';
CREATE SCHEMA var_name authorization var_name;
CREATE EXTENSION postgis;
GRANT SELECT ON spatial_ref_sys, geometry_columns TO var_name;


DROP TABLE var_name.GTFS_AGENCY;
DROP TABLE var_name.GTFS_ROUTES;
DROP TABLE var_name.GTFS_STOPS;
DROP TABLE var_name.GTFS_TRIPS;

DROP TABLE var_name.GTFS_STOP_TIMES;
DROP TABLE var_name.GTFS_SHAPES;
DROP TABLE var_name.GTFS_CALENDAR;
DROP TABLE var_name.GTFS_CALENDAR_DATES;
DROP TABLE var_name.GTFS_TRANSFERS;

/*
agency_id,agency_name,agency_url,agency_timezone,agency_lang,agency_phone
MTA NYCT,MTA New York City Transit, http://www.mta.info,America/New_York,en,718-330-1234
*/

CREATE TABLE var_name.GTFS_AGENCY
(
agency_id VARCHAR(10),
agency_name VARCHAR(50),
agency_url VARCHAR(100),
agency_timezone VARCHAR(50),
agency_lang VARCHAR(2),
agency_phone VARCHAR(20)
);

/*
routes.txt
route_id,agency_id,route_short_name,route_long_name,route_desc,route_type,route_url,route_color,route_text_color
1,MTA NYCT,1,Broadway - 7 Avenue Local,"Trains operate between 242 St in the Bronx and South Ferry in Manhattan, most times",1,http://www.mta.info/nyct/service/pdf/t1cur.pdf,EE352E,
*/

CREATE TABLE var_name.GTFS_ROUTES
(
route_id VARCHAR(10),
agency_id NUMERIC(3),
route_short_name VARCHAR(10),
route_long_name VARCHAR(100),
route_desc VARCHAR(100),
route_type NUMERIC(3),
route_url VARCHAR(100),
route_color VARCHAR(8),
route_text_color VARCHAR(8)
);
/*
stops.txt
stop_id,stop_code,stop_name,stop_desc,stop_lat,stop_lon,zone_id,stop_url,location_type,parent_station
101,,Van Cortlandt Park - 242 St,,40.889248,-73.898583,,,1,
*/

CREATE TABLE var_name.GTFS_STOPS
( 
stop_id VARCHAR(15),
stop_code VARCHAR(15),
stop_name VARCHAR(100),
stop_desc VARCHAR(100),
stop_lat NUMERIC(38,8),
stop_lon NUMERIC(38,8),
zone_id NUMERIC(5),
stop_url VARCHAR(100),
location_type NUMERIC(2),
parent_station VARCHAR(15),
wheelchair_boarding NUMERIC(1) DEFAULT 0
);

/*
trips.txt
route_id,service_id,trip_id,trip_headsign,direction_id,block_id,shape_id
1,A20130803WKD,A20130803WKD_000800_1..S03R,SOUTH FERRY,1,,1..S03R
*/
CREATE TABLE var_name.GTFS_TRIPS
(
route_id VARCHAR(10),
service_id VARCHAR(25),
trip_id VARCHAR(33),
trip_headsign VARCHAR(50),
trip_short_name VARCHAR(50),
direction_id NUMERIC(2),
block_id NUMERIC(10),
shape_id VARCHAR(7)
);


/*
stop_times.txt
trip_id,arrival_time,departure_time,stop_id,stop_sequence,stop_headsign,pickup_type,drop_off_type,shape_dist_traveled
A20130803WKD_000800_1..S03R,00:08:00,00:08:00,101S,1,,0,0,
*/

CREATE TABLE var_name.GTFS_STOP_TIMES
(
trip_id VARCHAR(33),
arrival_time VARCHAR(8),
departure_time VARCHAR(8), 
stop_id VARCHAR(15),
stop_sequence NUMERIC(10),
stop_headsign VARCHAR(30),
pickup_type VARCHAR(100),
drop_off_type VARCHAR(100)
);

/*
shapes.txt
shape_id,shape_pt_lat,shape_pt_lon,shape_pt_sequence,shape_dist_traveled
4..N06R,40.668897,-73.932942,0,
*/

CREATE TABLE var_name.GTFS_SHAPES
(
shape_id VARCHAR(7),
shape_pt_lat NUMERIC,
shape_pt_lon NUMERIC,
shape_pt_sequence NUMERIC(8),
shape_dist_traveled NUMERIC
);

/*
calendar_dates.txt
service_id,date,exception_type
*/

CREATE TABLE var_name.GTFS_CALENDAR_DATES
(
service_id VARCHAR(25),
exception_date DATE,
exception_type VARCHAR(10)
);

/*
calendar.txt
service_id,monday,tuesday,wednesday,thursday,friday,saturday,sunday,start_date,end_date
A20130803WKD,1,1,1,1,1,0,0,20130803,20141231
*/

CREATE TABLE var_name.GTFS_CALENDAR
(
service_id VARCHAR(25),
monday NUMERIC(1),
tuesday NUMERIC(1),
wednesday NUMERIC(1),
thursday NUMERIC(1),
friday NUMERIC(1),
saturday NUMERIC(1),
sunday NUMERIC(1),
start_date DATE,
end_date DATE
);

/*
transfers.txt
from_stop_id,to_stop_id,transfer_type,min_transfer_time
101,101,2,180
*/

CREATE TABLE var_name.GTFS_TRANSFERS
(
from_stop_id NUMERIC(10),
to_stop_id NUMERIC(10),
transfer_type NUMERIC(3),
min_transfer_time NUMERIC(6)
); 

CREATE TABLE var_name.GTFS_TRIPS (
    route_id character varying NOT NULL,
    service_id character varying NOT NULL,
    trip_id character varying NOT NULL,
    trip_headsign character varying,
    trip_short_name character varying,
    direction_id integer,
    block_id character varying,
    shape_id character varying,
    --custom for CTA
    wheelchair_accessible varchar,
    direction varchar
);

CREATE TABLE var_name.SUBSCRIPTIONS(
    p int not null references public.persons(id),
    route_id VARCHAR(10) NOT NULL,
    stop_id VARCHAR(15) NOT NULL
);

GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA nantes TO nantes;
