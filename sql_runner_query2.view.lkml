view: sql_runner_query2 {
  derived_table: {
    sql: SELECT
          "users"."gender" AS "users.gender",
          COUNT(DISTINCT users.id ) AS "users.count"
      FROM
          "public"."orders" AS "orders"
          LEFT JOIN "public"."users" AS "users" ON "orders"."user_id" = "users"."id"
      WHERE ((( "orders"."created_at" ) >= (TIMESTAMP '2016-02-03') AND ( "orders"."created_at" ) < (TIMESTAMP '2016-04-06')))
      GROUP BY
          1
      ORDER BY
          2 DESC
      LIMIT 500
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: users_gender {
    type: string
    sql: ${TABLE}."users.gender" ;;
  }

  dimension: users_count {
    type: number
    sql: ${TABLE}."users.count" ;;
  }

  set: detail {
    fields: [users_gender, users_count]
  }
}
