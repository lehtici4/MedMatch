-- Dados demonstrativos para apresentação
-- 3 médicos por especialidade

INSERT INTO medicos (id, nome, email_profissional, telefone_profissional, especialidade_id, crm)
SELECT 1, 'Dra. Ana Cardoso', 'ana.cardoso@medmatch.local', '(41) 99999-1001', id, 'CRM-PR-1001'
FROM especialidades WHERE nome = 'Cardiologia'
ON DUPLICATE KEY UPDATE nome = VALUES(nome), email_profissional = VALUES(email_profissional), telefone_profissional = VALUES(telefone_profissional), especialidade_id = VALUES(especialidade_id), crm = VALUES(crm);

INSERT INTO medicos (id, nome, email_profissional, telefone_profissional, especialidade_id, crm)
SELECT 2, 'Dr. Bruno Mendes', 'bruno.mendes@medmatch.local', '(41) 99999-1002', id, 'CRM-PR-1002'
FROM especialidades WHERE nome = 'Cardiologia'
ON DUPLICATE KEY UPDATE nome = VALUES(nome), email_profissional = VALUES(email_profissional), telefone_profissional = VALUES(telefone_profissional), especialidade_id = VALUES(especialidade_id), crm = VALUES(crm);

INSERT INTO medicos (id, nome, email_profissional, telefone_profissional, especialidade_id, crm)
SELECT 3, 'Dra. Carla Nogueira', 'carla.nogueira@medmatch.local', '(41) 99999-1003', id, 'CRM-PR-1003'
FROM especialidades WHERE nome = 'Cardiologia'
ON DUPLICATE KEY UPDATE nome = VALUES(nome), email_profissional = VALUES(email_profissional), telefone_profissional = VALUES(telefone_profissional), especialidade_id = VALUES(especialidade_id), crm = VALUES(crm);

INSERT INTO medicos (id, nome, email_profissional, telefone_profissional, especialidade_id, crm)
SELECT 4, 'Dra. Daniela Rocha', 'daniela.rocha@medmatch.local', '(41) 99999-1004', id, 'CRM-PR-1004'
FROM especialidades WHERE nome = 'Dermatologia'
ON DUPLICATE KEY UPDATE nome = VALUES(nome), email_profissional = VALUES(email_profissional), telefone_profissional = VALUES(telefone_profissional), especialidade_id = VALUES(especialidade_id), crm = VALUES(crm);

INSERT INTO medicos (id, nome, email_profissional, telefone_profissional, especialidade_id, crm)
SELECT 5, 'Dr. Eduardo Lima', 'eduardo.lima@medmatch.local', '(41) 99999-1005', id, 'CRM-PR-1005'
FROM especialidades WHERE nome = 'Dermatologia'
ON DUPLICATE KEY UPDATE nome = VALUES(nome), email_profissional = VALUES(email_profissional), telefone_profissional = VALUES(telefone_profissional), especialidade_id = VALUES(especialidade_id), crm = VALUES(crm);

INSERT INTO medicos (id, nome, email_profissional, telefone_profissional, especialidade_id, crm)
SELECT 6, 'Dra. Fernanda Alves', 'fernanda.alves@medmatch.local', '(41) 99999-1006', id, 'CRM-PR-1006'
FROM especialidades WHERE nome = 'Dermatologia'
ON DUPLICATE KEY UPDATE nome = VALUES(nome), email_profissional = VALUES(email_profissional), telefone_profissional = VALUES(telefone_profissional), especialidade_id = VALUES(especialidade_id), crm = VALUES(crm);

INSERT INTO medicos (id, nome, email_profissional, telefone_profissional, especialidade_id, crm)
SELECT 7, 'Dr. Gustavo Ferreira', 'gustavo.ferreira@medmatch.local', '(41) 99999-1007', id, 'CRM-PR-1007'
FROM especialidades WHERE nome = 'Ortopedia'
ON DUPLICATE KEY UPDATE nome = VALUES(nome), email_profissional = VALUES(email_profissional), telefone_profissional = VALUES(telefone_profissional), especialidade_id = VALUES(especialidade_id), crm = VALUES(crm);

INSERT INTO medicos (id, nome, email_profissional, telefone_profissional, especialidade_id, crm)
SELECT 8, 'Dra. Helena Martins', 'helena.martins@medmatch.local', '(41) 99999-1008', id, 'CRM-PR-1008'
FROM especialidades WHERE nome = 'Ortopedia'
ON DUPLICATE KEY UPDATE nome = VALUES(nome), email_profissional = VALUES(email_profissional), telefone_profissional = VALUES(telefone_profissional), especialidade_id = VALUES(especialidade_id), crm = VALUES(crm);

INSERT INTO medicos (id, nome, email_profissional, telefone_profissional, especialidade_id, crm)
SELECT 9, 'Dr. Igor Batista', 'igor.batista@medmatch.local', '(41) 99999-1009', id, 'CRM-PR-1009'
FROM especialidades WHERE nome = 'Ortopedia'
ON DUPLICATE KEY UPDATE nome = VALUES(nome), email_profissional = VALUES(email_profissional), telefone_profissional = VALUES(telefone_profissional), especialidade_id = VALUES(especialidade_id), crm = VALUES(crm);

INSERT INTO medicos (id, nome, email_profissional, telefone_profissional, especialidade_id, crm)
SELECT 10, 'Dra. Juliana Pereira', 'juliana.pereira@medmatch.local', '(41) 99999-1010', id, 'CRM-PR-1010'
FROM especialidades WHERE nome = 'Pediatria'
ON DUPLICATE KEY UPDATE nome = VALUES(nome), email_profissional = VALUES(email_profissional), telefone_profissional = VALUES(telefone_profissional), especialidade_id = VALUES(especialidade_id), crm = VALUES(crm);

INSERT INTO medicos (id, nome, email_profissional, telefone_profissional, especialidade_id, crm)
SELECT 11, 'Dr. Lucas Ribeiro', 'lucas.ribeiro@medmatch.local', '(41) 99999-1011', id, 'CRM-PR-1011'
FROM especialidades WHERE nome = 'Pediatria'
ON DUPLICATE KEY UPDATE nome = VALUES(nome), email_profissional = VALUES(email_profissional), telefone_profissional = VALUES(telefone_profissional), especialidade_id = VALUES(especialidade_id), crm = VALUES(crm);

INSERT INTO medicos (id, nome, email_profissional, telefone_profissional, especialidade_id, crm)
SELECT 12, 'Dra. Mariana Costa', 'mariana.costa@medmatch.local', '(41) 99999-1012', id, 'CRM-PR-1012'
FROM especialidades WHERE nome = 'Pediatria'
ON DUPLICATE KEY UPDATE nome = VALUES(nome), email_profissional = VALUES(email_profissional), telefone_profissional = VALUES(telefone_profissional), especialidade_id = VALUES(especialidade_id), crm = VALUES(crm);

INSERT INTO medicos (id, nome, email_profissional, telefone_profissional, especialidade_id, crm)
SELECT 13, 'Dr. Rafael Souza', 'rafael.souza@medmatch.local', '(41) 99999-1013', id, 'CRM-PR-1013'
FROM especialidades WHERE nome = 'Clinica Geral'
ON DUPLICATE KEY UPDATE nome = VALUES(nome), email_profissional = VALUES(email_profissional), telefone_profissional = VALUES(telefone_profissional), especialidade_id = VALUES(especialidade_id), crm = VALUES(crm);

INSERT INTO medicos (id, nome, email_profissional, telefone_profissional, especialidade_id, crm)
SELECT 14, 'Dra. Sofia Almeida', 'sofia.almeida@medmatch.local', '(41) 99999-1014', id, 'CRM-PR-1014'
FROM especialidades WHERE nome = 'Clinica Geral'
ON DUPLICATE KEY UPDATE nome = VALUES(nome), email_profissional = VALUES(email_profissional), telefone_profissional = VALUES(telefone_profissional), especialidade_id = VALUES(especialidade_id), crm = VALUES(crm);

INSERT INTO medicos (id, nome, email_profissional, telefone_profissional, especialidade_id, crm)
SELECT 15, 'Dr. Thiago Barbosa', 'thiago.barbosa@medmatch.local', '(41) 99999-1015', id, 'CRM-PR-1015'
FROM especialidades WHERE nome = 'Clinica Geral'
ON DUPLICATE KEY UPDATE nome = VALUES(nome), email_profissional = VALUES(email_profissional), telefone_profissional = VALUES(telefone_profissional), especialidade_id = VALUES(especialidade_id), crm = VALUES(crm);
