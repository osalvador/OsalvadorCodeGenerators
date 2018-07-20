create or replace PACKAGE swaggerGenWeb
AS
   FUNCTION create_swagger (p_tablename       VARCHAR2                       
                       , p_columns         VARCHAR2
                       , p_primary         VARCHAR2
                       , p_template        VARCHAR2)
      RETURN CLOB;
END swaggerGenWeb;
