# Relatório de Validação — Camada Bronze

## Volumes

| Tabela                            | Linhas  | Colunas |
|-----------------------------------|---------|---------|
| customers                         | 99.441  | 5       |
| geolocation                       | 1.000.163| 5      |
| order_items                       | 112.650 | 7       |
| order_payments                    | 103.886 | 5       |
| orders                            | 99.441  | 8       |
| products                          | 32.951  | 9       |
| sellers                           | 3.095   | 4       |
| product_category_name_translation | 71      | 2       |

## Problemas Identificados

### Tipos de dados incorretos
| Tabela      | Coluna                      | Tipo Atual | Tipo Esperado |
|-------------|-----------------------------|------------|---------------|
| orders      | order_purchase_timestamp    | string     | datetime      |
| orders      | order_approved_at           | string     | datetime      |
| orders      | order_delivered_carrier_date| string     | datetime      |
| orders      | order_delivered_customer_date| string    | datetime      |
| orders      | order_estimated_delivery_date| string    | datetime      |
| order_items | shipping_limit_date         | string     | datetime      |
| products    | product_photos_qty          | float      | int           |
| products    | product_name_lenght         | float      | int           |
| products    | product_description_lenght  | float      | int           |
| customers   | customer_zip_code_prefix    | int        | string        |
| sellers     | seller_zip_code_prefix      | int        | string        |

### Nulos identificados
| Tabela   | Coluna                        | Nulos | Hipótese                        |
|----------|-------------------------------|-------|---------------------------------|
| orders   | order_approved_at             | 160   | Pedidos cancelados antes do pagamento |
| orders   | order_delivered_carrier_date  | 1.783 | Pedidos em trânsito ou cancelados |
| orders   | order_delivered_customer_date | 2.965 | Pedidos em trânsito ou cancelados |
| products | product_category_name         | 610   | Produtos sem categoria cadastrada |
| products | product_name_lenght           | 610   | Relacionado aos sem categoria   |
| products | product_weight_g              | 2     | Erro de cadastro                |

## Decisões
- Nenhuma transformação aplicada na camada Bronze
- Todos os problemas serão tratados na camada Silver via SQL
- Data de referência para análises: order_purchase_timestamp