CREATE TABLE aeronaves (
    id SERIAL PRIMARY KEY,
    modelo VARCHAR(100) NOT NULL,
    codigo_cauda VARCHAR(10) UNIQUE NOT NULL,
    capacidade INTEGER NOT NULL CHECK (capacidade > 0)
);

CREATE TABLE pilotos (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    codigo_anac CHAR(6) UNIQUE NOT NULL,
    horas_voo INTEGER DEFAULT 0 CHECK (horas_voo >= 0)
);

CREATE TABLE voos (
    id SERIAL PRIMARY KEY,
    aeronave_id INTEGER NOT NULL REFERENCES aeronaves(id),
    piloto_id INTEGER NOT NULL REFERENCES pilotos(id),
    numero_voo VARCHAR(20) NOT NULL,
    origem VARCHAR(100) NOT NULL,
    destino VARCHAR(100) NOT NULL,
    data_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    status VARCHAR(20) DEFAULT 'Agendado'
        CHECK (status IN ('Agendado', 'Em Voo', 'Concluido', 'Cancelado'))
);

CREATE TABLE passageiros (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf CHAR(11) UNIQUE NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL
);

CREATE TABLE passagens (
    id SERIAL PRIMARY KEY,
    voo_id INTEGER NOT NULL REFERENCES voos(id),
    passageiro_id INTEGER NOT NULL REFERENCES passageiros(id),
    assento VARCHAR(4) NOT NULL,
    classe VARCHAR(20) DEFAULT 'Economica'
        CHECK (classe IN ('Economica', 'Executiva')),
    valor DECIMAL(10,2) NOT NULL CHECK (valor > 0)
);

INSERT INTO aeronaves (modelo, codigo_cauda, capacidade) VALUES
('Boeing 737-800', 'ABC-123', 189),
('Airbus A320', 'DEF-456', 180),
('Embraer E195', 'GHI-789', 132),
('Boeing 787-9', 'JKL-012', 296),
('Airbus A350', 'MNO-345', 325);

INSERT INTO pilotos (nome, codigo_anac, horas_voo) VALUES
('Carlos Silva', 'ANAC01', 2500),
('João Santos', 'ANAC02', 3200),
('Pedro Oliveira', 'ANAC03', 1800),
('Lucas Souza', 'ANAC04', 4100),
('Marcos Costa', 'ANAC05', 1500);

INSERT INTO passageiros (nome, cpf, email) VALUES
('Nicolas Silva', '12345678901', 'nicolas@email.com'),
('Gabriel Santos', '23456789012', 'gabriel@email.com'),
('Lucas Oliveira', '34567890123', 'lucas@email.com'),
('Matheus Souza', '45678901234', 'matheus@email.com'),
('Rafael Costa', '56789012345', 'rafael@email.com');

INSERT INTO voos 
(aeronave_id, piloto_id, numero_voo, origem, destino, data_hora, status) VALUES
(1, 1, 'BR101', 'Florianopolis', 'Sao Paulo', '2026-10-05 08:30:00', 'Agendado'),
(2, 2, 'BR202', 'Sao Paulo', 'Rio de Janeiro', '2026-10-05 10:00:00', 'Em Voo'),
(3, 3, 'BR303', 'Curitiba', 'Porto Alegre', '2026-10-06 14:00:00', 'Concluido'),
(4, 4, 'BR404', 'Brasilia', 'Salvador', '2026-10-07 16:30:00', 'Cancelado'),
(5, 5, 'BR505', 'Recife', 'Fortaleza', '2026-10-08 19:00:00', 'Agendado');

INSERT INTO passagens 
(voo_id, passageiro_id, assento, classe, valor) VALUES
(1, 1, '12A', 'Economica', 450.00),
(2, 2, '08B', 'Economica', 520.00),
(3, 3, '03C', 'Executiva', 950.00),
(4, 4, '02A', 'Executiva', 1200.00),
(5, 5, '15D', 'Economica', 380.00);