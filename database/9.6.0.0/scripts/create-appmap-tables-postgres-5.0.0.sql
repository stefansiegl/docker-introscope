
CREATE TABLE APPLICATION_SERVER
(
  HOSTNAME character varying(200),
  V4IP_ADDRESS character varying(20),
  V4I6_ADDRESS character varying(50),
  MAC_ADDRESS character varying(50),
  ID bigserial NOT NULL,
  NAME character varying(200) NOT NULL,
  USER_NAME character varying(200) NOT NULL,
  CREATION_DATE timestamp with time zone NOT NULL,
  UPDATE_DATE timestamp with time zone NOT NULL,
  VERSION character varying(100),
  TYPE character varying(200),
  CONSTRAINT APPLICATION_SERVER_PKEY PRIMARY KEY (ID)
);



CREATE TABLE AGENT
(
  NAME character varying(200) NOT NULL, -- Name of the Introscope agent
  CREATION_DATE timestamp with time zone NOT NULL,
  UPDATE_DATE timestamp with time zone NOT NULL,
  USER_NAME character varying(200),
  ID bigserial NOT NULL,
  APPLICATION_SERVER_ID bigint NOT NULL,
  CONSTRAINT AGENT_PKEY PRIMARY KEY (ID)
  
);




CREATE TABLE OWNER
(
  ID bigserial NOT NULL,
  NAME character varying(200) NOT NULL,
  USER_NAME character varying(200) NOT NULL,
  TRANSACTION_ID numeric,
  TYPE character varying(30) NOT NULL, 
  PARENT_ID bigint,
  CREATION_DATE timestamp with time zone NOT NULL,
  UPDATE_DATE timestamp with time zone NOT NULL,
  CONSTRAINT ID PRIMARY KEY (ID)
 

);



CREATE TABLE VERTEX_TYPE
(
  NAME character varying(200) NOT NULL,
  CREATION_DATE timestamp with time zone NOT NULL,
  UPDATE_DATE timestamp with time zone NOT NULL,
  USER_NAME character varying(200) NOT NULL,
  ID serial NOT NULL,
  CONSTRAINT VERTEX_TYPE_PKEY PRIMARY KEY (ID)
);




CREATE TABLE VERTEX
(
  NAME character varying(200) NOT NULL,
  VERTEX_TYPE_ID integer NOT NULL,
  UNIQUE_ID bigint NOT NULL,
  ABSTRACTION_LEVEL character varying(10) NOT NULL,
  HIERARCHY_LEVEL character varying(200) NOT NULL,
  PROPERTIES oid,
  CREATION_DATE timestamp with time zone NOT NULL,
  UPDATE_DATE timestamp with time zone NOT NULL,
  USER_NAME character varying(200) NOT NULL,
  APPLICATION_SERVER_ID bigint,
  PARENT_ID bigint ,
  ID bigserial NOT NULL,
  CONSTRAINT VERTEX_PKEY PRIMARY KEY (ID)
  
);


CREATE TABLE METRIC_PATH
(
  ID bigserial NOT NULL,
  METRIC_PATH character varying(1000) NOT NULL,
  VERTEX_ID bigint NOT NULL,
  CREATION_DATE timestamp with time zone NOT NULL,
  UPDATE_DATE timestamp with time zone NOT NULL,
  USER_NAME character varying(200) NOT NULL,
  CONSTRAINT METRIC_PATH_PKEY PRIMARY KEY (ID)
  
);


CREATE TABLE EDGE
(
  ID bigserial NOT NULL,
  HEAD_VERTEX_ID bigint NOT NULL,
  TAIL_VERTEX_ID bigint NOT NULL,
  OWNER_ID bigint NOT NULL,
  HEAD_OWNER_ID bigint, 
  TAIL_OWNER_ID bigint, 
  PROPERTIES oid,
  CREATION_DATE timestamp with time zone NOT NULL,
  UPDATE_DATE timestamp with time zone NOT NULL,
  USER_NAME character varying(200) NOT NULL,
  CONSTRAINT EDGE_PKEY PRIMARY KEY (ID)
 
);
