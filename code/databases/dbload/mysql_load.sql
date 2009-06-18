LOAD DATA LOCAL INFILE 'data.csv' 
INTO TABLE locations
FIELDS TERMINATED BY ';' 
LINES TERMINATED BY '\n' 
IGNORE 1 LINES
(label, street, postal_code, city, country);     
