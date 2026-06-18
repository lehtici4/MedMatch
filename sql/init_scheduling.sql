-- scheduling-db: usado por scheduling_service
CREATE TABLE IF NOT EXISTS horarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    medico_id INT NOT NULL,
    data_hora DATETIME NOT NULL,
    disponivel BOOLEAN NOT NULL DEFAULT TRUE,
    UNIQUE KEY uq_medico_horario (medico_id, data_hora)
);

CREATE TABLE IF NOT EXISTS consultas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    paciente_id INT NOT NULL,
    medico_id INT NOT NULL,
    horario_id INT NOT NULL,
    status ENUM('agendada', 'confirmada', 'concluida', 'cancelada', 'falta') NOT NULL DEFAULT 'agendada',
    observacoes TEXT NULL,
    criado_em DATETIME NOT NULL DEFAULT NOW(),
    atualizado_em DATETIME NULL,
    FOREIGN KEY (horario_id) REFERENCES horarios(id)
);

-- === MEDMATCH_DEMO_SCHEDULING_SEED ===
-- Horários demonstrativos dinâmicos
-- Gera 3 horários futuros para cada médico demo.
-- Usamos CURDATE() para evitar datas fixas antigas ou artificiais.

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
) slot
WHERE NOT EXISTS (
  SELECT 1
  FROM horarios h
  WHERE h.medico_id = med.id
    AND h.data_hora = DATE_ADD(
      DATE_ADD(CURDATE(), INTERVAL med.id DAY),
      INTERVAL slot.hora HOUR
    )
);
