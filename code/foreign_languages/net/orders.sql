SET SERVEROUTPUT ON
-- START:create_orders
CREATE TABLE orders (
  id         NUMBER(10) NOT NULL PRIMARY KEY,
  product    VARCHAR2(100),
  state      VARCHAR2(30),
  created_at DATE
);
-- END:create_orders
/
INSERT INTO orders VALUES(1, 'Beer', 'open', SYSDATE);
INSERT INTO orders VALUES(2, 'Ruby Book', 'closed', SYSDATE);
INSERT INTO orders VALUES(3, 'ACME Tools', 'open', SYSDATE);
INSERT INTO orders VALUES(4, 'Foo Bar', 'closed', SYSDATE);
INSERT INTO orders VALUES(5, '---', 'open', SYSDATE);
INSERT INTO orders VALUES(6, '---', 'open', SYSDATE);
INSERT INTO orders VALUES(7, '---', 'open', SYSDATE);
INSERT INTO orders VALUES(8, '---', 'open', SYSDATE);
INSERT INTO orders VALUES(9, '---', 'open', SYSDATE);
INSERT INTO orders VALUES(10, '---', 'open', SYSDATE);
INSERT INTO orders VALUES(11, '---', 'open', SYSDATE);
INSERT INTO orders VALUES(12, '---', 'open', SYSDATE);
INSERT INTO orders VALUES(13, '---', 'open', SYSDATE);
INSERT INTO orders VALUES(14, '---', 'open', SYSDATE);
INSERT INTO orders VALUES(15, '---', 'open', SYSDATE);
INSERT INTO orders VALUES(16, '---', 'open', SYSDATE);
INSERT INTO orders VALUES(17, '---', 'open', SYSDATE);
INSERT INTO orders VALUES(18, '---', 'closed', SYSDATE);
INSERT INTO orders VALUES(19, '---', 'closed', SYSDATE);
INSERT INTO orders VALUES(20, '---', 'closed', SYSDATE);
INSERT INTO orders VALUES(21, '---', 'closed', SYSDATE);
INSERT INTO orders VALUES(22, '---', 'closed', SYSDATE);
INSERT INTO orders VALUES(23, '---', 'closed', SYSDATE);
INSERT INTO orders VALUES(24, '---', 'closed', SYSDATE);
INSERT INTO orders VALUES(25, '---', 'closed', SYSDATE);
INSERT INTO orders VALUES(26, '---', 'closed', SYSDATE);
INSERT INTO orders VALUES(27, '---', 'closed', SYSDATE);
EXIT;
