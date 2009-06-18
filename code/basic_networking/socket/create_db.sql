DROP TABLE IF EXISTS service_infos;

CREATE TABLE service_infos (
  name      VARCHAR(256) NOT NULL,
  version   VARCHAR(16)  NOT NULL,
  host      VARCHAR(128) NOT NULL,
  port      INTEGER      NOT NULL,
  instances INTEGER      NOT NULL DEFAULT 1
);

INSERT INTO service_infos values ('billing', '2.13', 'prodhost', 4711, 2);
INSERT INTO service_infos values ('order', '8.01', 'staginghost', 11223, 5);
