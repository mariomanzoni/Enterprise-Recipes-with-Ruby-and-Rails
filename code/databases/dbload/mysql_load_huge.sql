LOAD DATA LOCAL INFILE 'huge_file.csv' 
INTO TABLE locations
FIELDS TERMINATED BY ';' 
LINES TERMINATED BY '\n' 
IGNORE 1 LINES
(label, street, postal_code, city, country);     
