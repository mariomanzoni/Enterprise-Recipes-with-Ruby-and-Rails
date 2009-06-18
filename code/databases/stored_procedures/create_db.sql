SET SERVEROUTPUT ON
-- START:create_objects
CREATE TABLE customer (
  id            NUMBER(10) NOT NULL PRIMARY KEY,
  forename      VARCHAR2(60),
  surname       VARCHAR2(60),
  date_of_birth DATE
);

CREATE SEQUENCE customer_id;
-- END:create_objects

-- START:create_function
CREATE OR REPLACE FUNCTION add_customer(
  forename      IN VARCHAR2,
  surname       IN VARCHAR2,
  date_of_birth IN DATE
)
RETURN PLS_INTEGER
IS
  l_customer_id PLS_INTEGER;
BEGIN
  INSERT INTO customer
  VALUES (customer_id.NEXTVAL, forename, surname, date_of_birth)
  RETURNING id INTO l_customer_id;
  RETURN l_customer_id;
END add_customer;
-- END:create_function
/

DECLARE
  new_id PLS_INTEGER;
  
BEGIN
  new_id := add_customer('Maik', 'Schmidt', TO_DATE('1972-09-30', 'YYYY-MM-DD'));
  DBMS_OUTPUT.PUT_LINE('ID: ' || new_id);
END;
/

EXIT;
