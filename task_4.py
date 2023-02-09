import pandas as pd
import psycopg2


query = """
    WITH last_date AS (
        SELECT MAX("date") AS dt
        FROM rtk.test_sql_py 
        WHERE "date" < '2022-07-04' -- CURRENT_DATE
    )
    SELECT *
    FROM rtk.test_sql_py tsp 
    JOIN last_date ld ON tsp."date" = ld.dt;
"""

def to_excell(query: str) -> pd.DataFrame:
    con_str = "host=192.168.0.129 dbname=pgdata user=dbadmpg password=-oX(PFEy2,6B"
    conn = psycopg2.connect(con_str)
    data = pd.read_sql(sql=query, con=conn)
    with pd.ExcelWriter("result.xlsx", engine='xlsxwriter') as writer:
        data.to_excel(writer, sheet_name='Sheet1', index=False)
