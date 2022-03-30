view: farm {
  derived_table: {
    sql: SELECT
      users.city  AS "city",users.id AS "id",users.city AS "city",users.age AS "age",
      COUNT(DISTINCT orders.id ) OVER(PARTITION BY users.city) AS "count"
    FROM public.order_items  AS order_items
    LEFT JOIN public.orders  AS orders ON order_items.order_id = orders.id
    LEFT JOIN public.users  AS users ON orders.user_id = users.id
    GROUP BY 1,2,3,4
    ORDER BY 2 DESC
       ;;

  }
  dimension: id {
    type: number
    sql: $(${TABLE}.id ;;
  }
  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: users_gender {
    type: string
    sql: $(${TABLE}.gender ;;
  }

  dimension: users_count {
    type: number
    sql: ${TABLE}."users.count" ;;
  }
  dimension: age {
    type: number
    sql: $(${TABLE}.age ;;
  }
  dimension: city {
    type: number
    sql: $(${TABLE}.city;;
  }

  set: detail {
    fields: [users_gender, users_count]
  }
}
