create or replace PACKAGE javaPojoGenWeb
AS
   FUNCTION create_pojo (p_tablename       VARCHAR2                       
                       , p_columns         VARCHAR2
                       , p_primary         VARCHAR2
                       , p_template        VARCHAR2)
      RETURN CLOB;
END;
