import pandas as pd
from sqlalchemy import create_engine
from dotenv import load_dotenv
import os

load_dotenv()


# conexão com o banco
engine = create_engine(
    f"mssql+pyodbc://{os.getenv('DB_USER')}:{os.getenv('DB_PASSWORD')}"
    f"@{os.getenv('DB_SERVER')},{os.getenv('DB_PORT')}/{os.getenv('DB_NAME')}"
    f"?driver=ODBC+Driver+18+for+SQL+Server&TrustServerCertificate=yes"
)



#caminho do arquivo
BASE_PATH = '../../data/raw/'

arquivos = [
    'olist_customers_dataset.csv',
    'olist_geolocation_dataset.csv',
    'olist_order_items_dataset.csv',
    'olist_order_payments_dataset.csv',
    'olist_orders_dataset.csv',
    'olist_products_dataset.csv',
    'olist_sellers_dataset.csv',
    'product_category_name_translation.csv'
]


for arquivo in arquivos:
    try:
        #1 extrai o nome da tabela
        nome_tabela = arquivo.replace("olist_", "").replace("_dataset.csv","").replace(".csv","")

        #2 lê o csv
        df = pd.read_csv(BASE_PATH + arquivo)

        #3 validação dos dados
        print(f"\n----------- tabela: {nome_tabela} -----------")
        
        print("\nQuantidade de linhas e colunas:")
        print(df.shape)

        print("\nTipo de dado por coluna:")
        print(df.dtypes)

        print("\nSoma de nulos por coluna: ")
        print(df.isnull().sum())

        #4 Carrega no banco
        df.to_sql(
            name=nome_tabela,
            con=engine,
            schema='bronze',
            if_exists='replace',
            index=False
        )

        #5 Reconcilia volumes
        
        #linhas do csv
        linhas_csv = df.shape[0]

        #linhas do banco
        linhas_banco = pd.read_sql(f"SELECT COUNT(*) total FROM bronze.{nome_tabela}", engine)['total'][0]

        #comparação
        if (linhas_csv == linhas_banco):
            print(f"Linhas OK. {linhas_csv} linhas.")
        else:
            print(f"Linhas faltantes. {linhas_csv - linhas_banco} linhas.")



        print(f"\n {nome_tabela} processado com sucesso!")
    except Exception as e:
        print(f"Erro ao processar {arquivo}: {e}")





