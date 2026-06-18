-- Seed local de demonstração
-- Recarrega horários limpos para testes manuais no Docker Compose.

DELETE FROM consultas;
DELETE FROM horarios;

INSERT INTO horarios (medico_id, data_hora, disponivel)
SELECT med.id,
       DATE_ADD(
         DATE_ADD(CURDATE(), INTERVAL med.id DAY),
         INTERVAL slot.hora HOUR
       ) AS data_hora,
       TRUE AS disponivel
FROM (
  SELECT 1 AS id UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL
  SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL
  SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9 UNION ALL
  SELECT 10 UNION ALL SELECT 11 UNION ALL SELECT 12 UNION ALL
  SELECT 13 UNION ALL SELECT 14 UNION ALL SELECT 15
) med
CROSS JOIN (
  SELECT 8 AS hora UNION ALL SELECT 9 UNION ALL SELECT 10
) slot;
