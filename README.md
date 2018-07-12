# OsalvadorCodeGenerators

OsalvadorCodeGenerators is a web application for source code generation from database given the definition (DML) of table and automatically create Java Code (JPA Entity, JavaBean, View Model, JdbcTemplate DAO...) from these tables.

The generator is defined in templates of [tePLSQL](https://github.com/osalvador/tePLSQL) (JSP and PSP like syntaxt (<%%>)) and the result is shown on the screen and can be downloaded. The web application has been developed with APEX at [apex.oracle.com](apex.oracle.com). Currently I have included the templates that I usually use in my work, but the templates are easily customizable.


## Online Code Generator Web Application

The aplication on APEX: [Osalvador Live Code Generators](https://apex.oracle.com/pls/apex/f?p=48301:1:12897536116802:::::)

## Demos

#### Java POJO Generator

The template: [pojo.teplsql](./templates/pojo.teplsql)

![](./images/javaPOJOGenerator.gif)

#### Java Bean Generator

The template: [bean.teplsql](./templates/bean.teplsql)

![](./images/javaBeanGenerator.gif)

#### Java JPA Entity Generator

The template: [jpa-entity.teplsql](./templates/jpa-entity.teplsql)

![](./images/javaJPAEntityGenerator.gif)

#### JdbcTemplate DAO Generator

The Interface template: [jdbctemplate-dao-interface.teplsql](./templates/jdbctemplate/jdbctemplate-dao-interface.teplsql)

The Interface Implementation template: [jdbctemplate-dao-implement.teplsql](./templates/jdbctemplate/jdbctemplate-dao-implement.teplsql)

![](./images/JDBCTemplateGenerator.gif)

## Why another code generator?

I usually use this type of code generators to create models, entities or DTOs based on database tables. The problem with these code generators is that they require instrumentation (installation and configuration) and a learning curve that is sometimes greater than the time they saved. In addition these generators are used occasionally, having to re-read the documentation again.

With a web application we save all these previous steps and focus on what really matters to us, get the boring part of our project, generating these classes.

I am also working on the generation of complete applications based on SpringBoot.

## Roadmap

- Enable the ability to upload a complete DML script with multiple tables.
- More templates:
	- Custom templates
	- Spring boot RestFull app
	- Complete JEE CRUD app
	- C# POCO
- MySQL and Postgres DDL syntax compatibility. 

## SQL Data Type to Java Mapping Classes

| SQL Data Type | Java Mapping | 
| ------------- | ------------ | 
| `VARCHAR2`          | `String`
| `CHAR`              | `String`
| `CHARACTER`         | `String`
| `LONG`              | `String`
| `STRING`            | `String`
| `VARCHAR`           | `String`
| `RAW`               | `byte[]`
| `LONG RAW`          | `byte[]`
| `BINARY_INTEGER`    | `int`
| `NATURAL`           | `int`
| `NATURALN`          | `int`
| `PLS_INTEGER`       | `int`
| `POSITIVE`          | `int`
| `POSITIVEN`         | `int`
| `SIGNTYPE`          | `int`
| `INT`               | `int`
| `INTEGER`           | `int`
| `SMALLINT`          | `int`
| `DEC`               | `BigDecimal`
| `DECIMAL`           | `BigDecimal`
| `NUMBER`            | `BigDecimal`
| `NUMERIC`           | `BigDecimal`
| `DOUBLE PRECISION`  | `double`
| `FLOAT`             | `double`
| `REAL`              | `float`
| `DATE`              | `Timestamp`
| `TIMESTAMP` 		 | `Timestamp`
| `INTERVAL` 		 | `String`
| `ROWID`            | `RowId`
| `UROWID`           | `RowId`
| `CLOB`             | `Clob`
| `BLOB`             | `Blob`
| `XMLTYPE`          | `String`








