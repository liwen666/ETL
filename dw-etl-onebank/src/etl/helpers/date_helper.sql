
---------------------------------------------------------------
--
-- 函数名称：to_int_mth
-- 函数描述：日期转月份转整型
--     参数：indate，日期型
--   返回值：整数类型年月
--   创建人：**
--
---------------------------------------------------------------
CREATE OR REPLACE FUNCTION "to_int_mth"("indate" date)
    RETURNS "pg_catalog"."int4" AS $BODY$
  DECLARE
  BEGIN
   RETURN to_char(inDate, 'YYYYMM')::INTEGER;
  END;
  $BODY$
  LANGUAGE plpgsql VOLATILE
COST 100;


---------------------------------------------------------------
--
-- 函数名称：to_int_date
-- 函数描述：日期转整型
--     参数：indate，日期型
--   返回值：整数类型日期
--   创建人：**
--
---------------------------------------------------------------
CREATE OR REPLACE FUNCTION "to_int_date"("indate" date)
    RETURNS "pg_catalog"."int4" AS $BODY$
    DECLARE
    BEGIN
     RETURN to_char(inDate, 'YYYYMMDD')::INTEGER;
    END;
    $BODY$
    LANGUAGE plpgsql VOLATILE
COST 100;



---------------------------------------------------------------
--
-- date_add_by_day
-- 函数描述：日期计算，按天
--     参数：biz_date，业务日期
--          num_of_days，天数
--   返回值：整数类型日期
--   创建人：**
--
---------------------------------------------------------------
CREATE OR REPLACE FUNCTION "date_add_by_day"("biz_date" int4, "num_of_days" int4)
RETURNS "pg_catalog"."int4" AS $BODY$
DECLARE
    res_date int;
    sql_stmt varchar;
BEGIN
    sql_stmt = 'SELECT to_int_date((to_date(' || biz_date || '::text, ''YYYYMMDD'') + interval ''' || num_of_days || ' day'')::DATE)';

    EXECUTE sql_stmt INTO res_date;
    
    RETURN res_date;
END;
$BODY$
LANGUAGE plpgsql VOLATILE
COST 100;



---------------------------------------------------------------
--
-- 函数名称：to_int_mth
-- 函数描述：整数日期转月份转整型
--     参数：indate，整型
--   返回值：整数类型年月
--   创建人：**
--
--------------------------------------------------------------- 
CREATE OR REPLACE FUNCTION "to_int_mth"("indate" int4)
  RETURNS "pg_catalog"."int4" AS $BODY$
  DECLARE
  BEGIN
     RETURN substr(inDate::VARCHAR, 1, 6)::INTEGER;
  END;
  $BODY$
  LANGUAGE plpgsql VOLATILE
COST 100;


---------------------------------------------------------------
--
-- 函数名称：isleapyear
-- 函数描述：闰年
--     参数：iyear，整型
--   返回值：布尔
--   创建人：**
--
--------------------------------------------------------------- 
CREATE OR REPLACE FUNCTION "isleapyear"("iyear" int4)
  RETURNS "pg_catalog"."bool" AS $BODY$
  BEGIN
    RETURN ((iYear % 4) = 0 AND ((iYear % 100) <> 0 OR (iYear % 400) = 0));
  END;
  $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;


---------------------------------------------------------------
--
-- 函数名称：ismonthlastday
-- 函数描述：每个月的最后一天是哪天（日期）
--     参数：idate，日期型
--   返回值：整数型日期
--   创建人：**
--
---------------------------------------------------------------
  CREATE OR REPLACE FUNCTION "ismonthlastday"("idate" date)
  RETURNS "pg_catalog"."bool" AS $BODY$
    DECLARE
     dateYear INT;
     dateMth INT;
     dateDay INT;
         maxDay INT;
    BEGIN
    dateYear = EXTRACT(year FROM iDate);
    dateMth = EXTRACT(month FROM iDate);
    dateDay = EXTRACT(day FROM iDate);

    IF dateMth = 2 THEN
          IF isLeapYear(dateYear) THEN
                maxDay = 29;
            ELSE
                maxDay = 28;
            END IF;
        ELSEIF dateMth = 4 OR dateMth = 6 OR dateMth = 9  OR dateMth = 11  THEN
            maxDay = 30;
        ELSE
            maxDay = 31;
        END IF;


    RETURN (dateDay = maxDay);
  END;
   $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;


---------------------------------------------------------------
--
-- 函数名称：ismonthlastday
-- 函数描述：每个月的最后一天是哪天（整数）
--     参数：idate，整型
--   返回值：整数型日期
--   创建人：**
--
--------------------------------------------------------------- 
CREATE OR REPLACE FUNCTION "ismonthlastday"("idate" int4)
  RETURNS "pg_catalog"."bool" AS $BODY$
    DECLARE
     dateYear INT;
     dateMth INT;
     dateDay INT;
         maxDay INT;
    BEGIN
    dateYear = substr(iDate::VARCHAR, 1, 4)::INTEGER;
    dateMth = substr(iDate::VARCHAR, 5, 2)::INTEGER;
    dateDay = substr(iDate::VARCHAR, 7, 2)::INTEGER;

--     RAISE NOTICE 'isLeapYear %:% ', dateMth, dateDay;

    IF dateMth = 2 THEN
          IF isLeapYear(dateYear) THEN
                maxDay = 29;
            ELSE
                maxDay = 28;
            END IF;
        ELSIF dateMth = 4 OR dateMth = 6 OR dateMth = 9  OR dateMth = 11  THEN
            maxDay = 30;
        ELSE
            maxDay = 31;
        END IF;

--     RAISE NOTICE 'maxDay %', maxDay;

    RETURN (dateDay = maxDay);
  END;
   $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;


---------------------------------------------------------------
--
-- 函数名称：datediff
-- 函数描述：计算两个整数日期之间的间隔（年、月、日）
--     参数：field，文本（枚举）：year, month, day
--              start_date，整型  
--              end_date，整型
--   返回值：整数类型年、月、日
--   创建人：**
--
---------------------------------------------------------------
  CREATE OR REPLACE FUNCTION "datediff"("field" text, "start_date" int4, "end_date" int4)
  RETURNS "pg_catalog"."int4" AS $BODY$
    DECLARE
        year_diff int;
        mth_diff int;
   BEGIN
       IF field = 'year' THEN
           RETURN int_date_part(field, start_date) - int_date_part(field, end_date);
       ELSEIF field = 'month' THEN
         year_diff = int_date_part('year', start_date) - int_date_part('year', end_date);
             mth_diff = int_date_part('month', start_date) - int_date_part('month', end_date);
           RETURN year_diff * 12 + mth_diff;
       ELSE
           RETURN to_date(start_date::TEXT,'YYYYMMDD') - to_date(end_date::TEXT,'YYYYMMDD');
       END IF;
   END;
   $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;



---------------------------------------------------------------
--
-- 函数名称：datediff
-- 函数描述：计算两个整数日期之间的间隔（年、月、日）
--     参数：field，文本（枚举）：year, month, day
--              start_date，整型  
--              end_date，整型
--   返回值：整数类型年、月、日
--   创建人：**
--
---------------------------------------------------------------
  CREATE OR REPLACE FUNCTION "datediff"("field" text, "start_date" timestamp, "end_date" timestamp)
  RETURNS "pg_catalog"."int4" AS $BODY$
    DECLARE
        year_diff int;
        mth_diff int;
   BEGIN
       IF field = 'year' THEN
           RETURN int_date_part(field, start_date) - int_date_part(field, end_date);
       ELSEIF field = 'month' THEN
         year_diff = int_date_part('year', start_date) - int_date_part('year', end_date);
             mth_diff = int_date_part('month', start_date) - int_date_part('month', end_date);
           RETURN year_diff * 12 + mth_diff;
       ELSE
           RETURN to_date(start_date::TEXT,'YYYYMMDD') - to_date(end_date::TEXT,'YYYYMMDD');
       END IF;
   END;
   $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;


---------------------------------------------------------------
--
-- 函数名称：datediff
-- 函数描述：计算两个时间戳之间的间隔（年、月、日、小时、分钟、秒）
--     参数：field，文本（枚举）：year, month, day，hour，minute，second
--              start_date，时间戳  
--              end_date，时间戳
--   返回值：整数类型年、月、日、小时、分钟、秒
--   创建人：**
--
---------------------------------------------------------------
CREATE OR REPLACE FUNCTION "datediff"("field" varchar, "start_date" TIMESTAMPTZ, "end_date" TIMESTAMPTZ)
RETURNS "pg_catalog"."int4" AS $BODY$
  DECLARE
      year_diff int;
      mth_diff int;
      day_diff int;
      hour_diff int;
      minute_diff int;
 BEGIN
     IF field = 'year' THEN
         RETURN DATE_PART('year', end_date) - DATE_PART('year', start_date);
     ELSEIF field = 'month' THEN
         year_diff = DATE_PART('year', end_date) - DATE_PART('year', start_date);
         mth_diff = DATE_PART('month', end_date) - DATE_PART('month', start_date);
         RETURN year_diff * 12 + mth_diff;
     ELSEIF field = 'day' THEN
         RETURN DATE_PART('day', end_date - start_date);
     ELSEIF field = 'hour' THEN
         day_diff = DATE_PART('day', end_date - start_date);

         RETURN day_diff * 24 + DATE_PART('hour', end_date - start_date);
     ELSEIF field = 'minute' THEN
         day_diff = DATE_PART('day', end_date - start_date);
         hour_diff = day_diff * 24 + DATE_PART('hour', end_date - start_date);

         RETURN hour_diff * 60 + DATE_PART('minute', end_date - start_date);
     ELSEIF field = 'second' THEN
         day_diff = DATE_PART('day', end_date - start_date);
         hour_diff = day_diff * 24 + DATE_PART('hour', end_date - start_date);
         minute_diff = hour_diff * 60 + DATE_PART('minute', end_date - start_date);

         RETURN minute_diff * 60 + DATE_PART('second', end_date - start_date);
     ELSE
         RETURN DATE_PART('day', end_date - start_date);
     END IF;
 END;
 $BODY$
LANGUAGE plpgsql VOLATILE
COST 100;

---------------------------------------------------------------
--
-- 函数名称：int_date_part
-- 函数描述：取年、月、日
--     参数：field，文本  in_date，整型
--   返回值：整数类型年、月、日
--   创建人：**
--
--------------------------------------------------------------- 
  CREATE OR REPLACE FUNCTION "int_date_part"("field" text, "in_date" int4)
  RETURNS "pg_catalog"."int4" AS $BODY$
   BEGIN
       IF field = 'year' THEN
           RETURN substr(in_date::TEXT, 1, 4)::INTEGER;
       ELSEIF field = 'month' THEN
           RETURN substr(in_date::TEXT, 5, 2)::INTEGER;
       ELSEIF field = 'day' THEN
           RETURN substr(in_date::TEXT, 7, 2)::INTEGER;
         ELSE
           RETURN in_date;
         END IF;
   END;
   $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
  
  
 ---------------------------------------------------------------
--
-- 函数名称：int_mth_add
-- 函数描述：整数月份转日期月份转整数月份
--     参数：in_mth numeric, 1 numeric
--   返回值：整数类型年月
--   创建人：**
--
---------------------------------------------------------------  
CREATE OR REPLACE FUNCTION "int_mth_add"("in_mth" numeric, "n" numeric)
  RETURNS "pg_catalog"."numeric" AS $BODY$
  DECLARE 
     i int;
     s_in_mth int;        
 BEGIN
  s_in_mth = in_mth;
  IF n > 0 THEN
    FOR i IN 1 .. n 
     LOOP
     s_in_mth = to_int_mth((to_date(s_in_mth::text || '01' , 'YYYYMMDD') + interval '1 month')::DATE);
     END LOOP;
  END IF;
   RETURN s_in_mth;
 END;
  $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
  

  CREATE OR REPLACE FUNCTION "int_date_part"("field" text, "in_date" int4)
  RETURNS "pg_catalog"."int4" AS $BODY$
   BEGIN
     IF field = 'year' THEN
       RETURN substr(in_date::TEXT, 1, 4)::INTEGER;
     ELSEIF field = 'month' THEN
       RETURN substr(in_date::TEXT, 5, 2)::INTEGER;
     ELSEIF field = 'day' THEN
       RETURN substr(in_date::TEXT, 7, 2)::INTEGER;
     ELSE
       RETURN in_date;
     END IF;
   END;
   $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
