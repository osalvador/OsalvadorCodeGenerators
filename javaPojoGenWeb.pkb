create or replace PACKAGE BODY javaPojoGenWeb
AS
   l_tapigen_rt   tapi_h_tapigen.h_tapigen_rt;

   PROCEDURE save_error (p_sqlerrm VARCHAR2)
   AS
      PRAGMA AUTONOMOUS_TRANSACTION;
   BEGIN
      l_tapigen_rt.error := p_sqlerrm;

      tapi_h_tapigen.upd (l_tapigen_rt);
      COMMIT;
   END save_error;

   FUNCTION create_pojo (p_tablename       VARCHAR2                       
                       , p_columns         VARCHAR2
                       , p_primary         VARCHAR2
                       , p_template        VARCHAR2)
      RETURN CLOB
   AS
      l_sql                VARCHAR2 (32767);
      l_pojo_code          CLOB;
      l_dummy              VARCHAR2 (200);
      l_raise_exceptions   BOOLEAN := FALSE;
   BEGIN
      --Save data
      l_tapigen_rt.id := h_tapigen_seq.nextval;
      l_tapigen_rt.session_id := null;
      l_tapigen_rt.table_name := p_tablename;
      l_tapigen_rt.table_pks := p_primary;

      l_tapigen_rt.audit_created_by := p_template;

      tapi_h_tapigen.ins (l_tapigen_rt);
      COMMIT;


      /**
      * Validations
      */
      BEGIN
         l_dummy     := sys.dbms_assert.simple_sql_name (p_tablename);
      EXCEPTION
         WHEN OTHERS
         THEN
            save_error ('Invalid table name: ' || sqlerrm);

            RETURN 'Invalid table name: ' || sqlerrm;
      END;

      /**
      * Create table
      */
      l_sql       := 'CREATE TABLE ' || p_tablename || '(' || p_columns || ')';

      l_tapigen_rt.table_sql := l_sql;
      tapi_h_tapigen.upd (l_tapigen_rt);
      COMMIT;

      BEGIN
         EXECUTE IMMEDIATE l_sql;
      EXCEPTION
         WHEN OTHERS
         THEN
            IF sqlcode = -00955
            THEN
               save_error ('Table "' || p_tablename || '" is already used by an existing object');
               RETURN 'Table "' || p_tablename || '" is already used by an existing object';
            ELSE
               save_error ('Invalid Columns Definitions: ' || sqlerrm);
               RETURN 'Invalid Columns Definitions: ' || sqlerrm;
            END IF;
      END;

      /**
      * Creaate primary key
      */
      l_sql       :=
            'ALTER TABLE '
         || p_tablename
         || ' ADD (CONSTRAINT '
         || p_tablename
         || '_PK PRIMARY KEY ('
         || p_primary
         || '))';

      BEGIN
         EXECUTE IMMEDIATE l_sql;
      EXCEPTION
         WHEN OTHERS
         THEN
            save_error ('Invalid Primary Key Columns: ' || sqlerrm);

            EXECUTE IMMEDIATE 'DROP TABLE ' || p_tablename;

            RETURN 'Invalid Primary Key Columns: ' || sqlerrm;
      END;

      /**
      * Create POJO
      */
      BEGIN

          l_pojo_code   := javapojogen.create_java_pojo(p_table_name => p_tablename, p_template => p_template);

      EXCEPTION
         WHEN OTHERS
         THEN
            save_error ('Error creating Code: ' || sqlerrm);

            EXECUTE IMMEDIATE 'DROP TABLE ' || p_tablename;

            RETURN sqlerrm;
      END;

      BEGIN
         EXECUTE IMMEDIATE 'DROP TABLE ' || p_tablename;
      EXCEPTION
         WHEN OTHERS
         THEN
            NULL;
      END;

      RETURN l_pojo_code;
   EXCEPTION
      WHEN OTHERS
      THEN
         BEGIN
            EXECUTE IMMEDIATE 'DROP TABLE ' || p_tablename;
         EXCEPTION
            WHEN OTHERS
            THEN
               NULL;
         END;

         save_error ('WHEN OTHERS: ' || sqlerrm);

         RETURN sqlerrm;
   END;
END javaPojoGenWeb; 