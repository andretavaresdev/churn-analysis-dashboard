SELECT * FROM (
    SELECT 
        CUSTOMER_ID,
        CONTRACT,
        PAYMENT_METHOD,
		
        -- Categorização do nível de suporte com base no número de chamados
        CASE 
            WHEN SUPPORT_CALLS <= 2 THEN 'Baixo (0-2)'
            WHEN SUPPORT_CALLS BETWEEN 3 AND 5 THEN 'Médio (3-5)'
            ELSE 'Alto (6+)'
        END AS NIVEL_SUPORTE,
		
        -- Regra para facilitar ordenação de nível de suporte no Power BI
        CASE 
            WHEN SUPPORT_CALLS <= 2 THEN 3
            WHEN SUPPORT_CALLS BETWEEN 3 AND 5 THEN 2
            ELSE 1 
        END AS ORDEM_SUPORTE,
		
        -- Categorização por tempo de permanência
        CASE 
            WHEN TENURE <= 24 THEN 'Novo (0-24 m)'
            WHEN TENURE BETWEEN 25 AND 48 THEN 'Médio (25-48 m)'
            ELSE 'Antigo (49 meses +)'
        END AS TEMPO_DE_CASA,
		
        -- Regra para facilitar ordenação de tempo de casa no Power BI
        CASE 
            WHEN TENURE <= 24 THEN 3
            WHEN TENURE BETWEEN 25 AND 48 THEN 2
            ELSE 1
        END AS ORDEM_TEMPO,
		
        -- Tratamento de tipo para garantir que o churn seja interpretado como número e não FALSE ou TRUE no Power BI.
        CAST(CHURN AS INT) AS CHURN
    FROM CUSTOMER
) AS CATEGORIAS