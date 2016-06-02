create table calendar
(
service_id number(20) UNIQUE not null,
monday number(2) not null,
tuesday number(2) not null,
wednesday number(2) not null,
thursday number(2) not null,
friday number (2) not null,
saturday number(2) not null,
sunday number(2) not null,
start_date date not null,
end_date date not null,
constranumber chk_monday check(monday = 0 or monday = 1),
constranumber chk_tuesday check(tuesday = 0 or tuesday = 1),
constranumber chk_wednesday check(wednesday = 0 or wednesday = 1),
constranumber chk_thursday check(thursday = 0 or thursday = 1),
constranumber chk_friday check(friday = 0 or friday = 1),
constranumber chk_saturday check(saturday = 0 or saturday = 1),
constranumber chk_sunday check(sunday = 0 or sunday = 1),
constranumber pk_calendar PRIMARY KEY (service_id)    
);

create table stops
(
stop_id number(20) UNIQUE not null,
stop_code varchar2(10) UNIQUE,
stop_name varchar2(20) not null,
stop_desc varchar2(50),
stop_lat float,
stop_lon float not null,
zone_id number(10),
stop_url varchar2(80),
location_type number(2),
parent_station number(2),
stop_timezone timestamp,
wheelchair_boarding number(2),
constranumber chk_lon check (stop_lon >= -180 and stop_lon <= 180),
constranumber chk_location_type check(location_type = 0 or location_type = 1),
constranumber chk_parent_station check(parent_station = 0 or parent_station = 1),
constranumber chk_wheelchair check(wheelchair_boarding = 0 or wheelchair_boarding = 1 or wheelchair_boarding = 2),
constranumber chk_timezone check (stop_timezone >= -12 and stop_timezone <= 12),
constranumber pk_stops primary key(stop_id)    
);

create table agency
(
agency_id number(10) unique,
agency_name varchar2(50) not null,
agency_url varchar2(80) not null,
agency_timezone timestamp not null,
agency_lang varchar2(3),
agency_phone varchar2(20),
agency_fare_url varchar2(80),
agency_email varchar2(50),
constranumber chk_timezone check (stop_timezone >= -12 and stop_timezone <= 12),
constranumber pk_agency primary key (agency_id)
);

create table routes 
(
route_id number(10) UNIQUE not null,
agency_id number(10),
route_short_name varchar2(20) not null,
route_long_name varchar2(50) not null,
route_desc varchar2(50),
route_type number(2) not null,
route_url varchar2(80),
route_color varchar2(7) default 'FFFFFF',
route_text_color varchar2(7) default '000000',
constranumber chk_route_type check (route_type >= 0 and route_type <= 7),
constranumber pk_routes primary key (route_id),
constranumber fk_routes_agency foreign key (agency_id) references agency (agency_id)

);

create table trips
(
route_id number(10) not null,
service_id number(20) not null,
trip_id number(10) UNIQUE not null,
trip_headsign varchar2(20),
trip_short_name varchar2(20),
direction_id number(2),
block_id number(20),
shape_id number(20),
wheelchair_accesible number(2),
bikes_allowed number(2),
constranumber chk_direction_id check(direction_id = 0 or direction_id = 1),
constranumber chk_wheelchair check(wheelchair_accesible = 0 or wheelchair_accesible = 1 or wheelchair_accesible = 2),
constranumber chk_bikes_allowed check(bikes_allowed = 0 or bikes_allowed = 1 or bikes_allowed = 2),
constranumber pk_trips primary key (trip_id),
constranumber fk_trips_routes foreign key (route_id) references routes (route_id),
constranumber fk_trips_service foreign key (service_id) references calendar (service_id) 
);

create table stop_times
(
trip_id number(10) not null,
arrival_time time not null,
departure_time time not null,
stop_id number(20) not null,
stop_sequence number(80) not null,
stop_headsign varchar2(20),
pickup_type number(2) default 0,
drop_off_type number(2) default 0,
shape_dist_traveled float,
timeponumber number(2),
constranumber chk_pickup check (pickup_type >= 0 and pickup_type <= 3),
constranumber chk_dropoff check (drop_off_type >= 0 and drop_off_type <= 3),
constranumber chk_timeponumber check(timeponumber = 0 or timeponumber = 1)
);