view: farm {
  derived_table: {
    sql: SELECT
          "users"."id" AS "users.id","users"."gender" AS "users.gender","users"."age" AS "users.age","users"."city" AS "users.city",
          count(distinct user.id) OVER(PARTITION BY users.city) AS "users.count"
      FROM
          "public"."users" AS "users"

      GROUP BY
          1
      ORDER BY
          2 DESC
       ;;

  }
  dimension: id {
    type: number
    sql: ${TABLE}."users.id" ;;
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
  dimension: age {
    type: number
    sql: ${TABLE}."users.age" ;;
  }
  dimension: city {
    type: number
    sql: ${TABLE}."users.city" ;;
  }

  set: detail {
    fields: [users_gender, users_count]
  }
}
