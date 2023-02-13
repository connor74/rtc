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
    con_str = "..."
    conn = psycopg2.connect(con_str)
    df = pd.read_sql(sql=query, con=conn)
    with pd.ExcelWriter("result.xlsx", engine='xlsxwriter') as writer:
        df.to_excel(writer, sheet_name='Sheet1', index=False)

        workbook = writer.book
        worksheet = writer.sheets['Sheet1']

        dt_format = workbook.add_format({'num_format': 'yyyy-mm-dd'})

        worksheet.set_column('A:A', None, dt_format)
        
to_excell(query)
