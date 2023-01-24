
CREATE TABLE banka (
    nazb VARCHAR2(16 BYTE) NOT NULL,
    sedb VARCHAR2(16 BYTE) NOT NULL,
    rvb  DATE NOT NULL
);

ALTER TABLE banka ADD CONSTRAINT banka_pk PRIMARY KEY ( nazb );

CREATE TABLE direktor (
    idr    INTEGER NOT NULL,
    imed   VARCHAR2(32 CHAR) NOT NULL,
    platad NUMBER NOT NULL,
    idr2   INTEGER
);

ALTER TABLE direktor ADD CONSTRAINT direktor_pk PRIMARY KEY ( idr );

CREATE TABLE domacav (
    idkr INTEGER NOT NULL,
    imvd VARCHAR2(32 CHAR) NOT NULL,
    pkdv NUMBER NOT NULL
);

ALTER TABLE domacav ADD CONSTRAINT domacav_pk PRIMARY KEY ( idkr );

CREATE TABLE ekspozitura (
    ide  INTEGER NOT NULL,
    loke VARCHAR2(16 BYTE) NOT NULL,
    nazb VARCHAR2(16 BYTE) NOT NULL
);

ALTER TABLE ekspozitura ADD CONSTRAINT ekspozitura_pk PRIMARY KEY ( ide,
                                                                    nazb );

CREATE TABLE kancelarija (
    brk   INTEGER NOT NULL,
    kvk   NUMBER NOT NULL,
    svrha VARCHAR2(11) NOT NULL
);

ALTER TABLE kancelarija
    ADD CONSTRAINT ch_inh_kancelarija CHECK ( svrha IN ( 'Kancelarija', 'Kkk', 'Skk' ) );

ALTER TABLE kancelarija ADD CONSTRAINT kancelarija_pk PRIMARY KEY ( brk );

CREATE TABLE kkk (
    brk  INTEGER NOT NULL,
    rbkk VARCHAR2(16 BYTE) NOT NULL,
    brkk INTEGER NOT NULL
);

ALTER TABLE kkk ADD CONSTRAINT kkk_pk PRIMARY KEY ( brk );

CREATE TABLE klijent (
    zrk  VARCHAR2(16 BYTE) NOT NULL,
    imek VARCHAR2(32 CHAR) NOT NULL,
    przk VARCHAR2(32 CHAR) NOT NULL,
    ide  INTEGER,
    nazb VARCHAR2(16 BYTE)
);

ALTER TABLE klijent ADD CONSTRAINT klijent_pk PRIMARY KEY ( zrk );

CREATE TABLE kredit (
    idkr      INTEGER NOT NULL,
    dok       DATE NOT NULL,
    uk        NUMBER NOT NULL,
    tipvalute VARCHAR2(7) NOT NULL,
    idr       INTEGER NOT NULL
);

ALTER TABLE kredit
    ADD CONSTRAINT ch_inh_kredit CHECK ( tipvalute IN ( 'DomacaV', 'Kredit', 'StranaV' ) );

ALTER TABLE kredit ADD CONSTRAINT kredit_pk PRIMARY KEY ( idkr );

CREATE TABLE obracunavanje (
    brk  INTEGER NOT NULL,
    idkr INTEGER NOT NULL
);

ALTER TABLE obracunavanje ADD CONSTRAINT obracunavanje_pk PRIMARY KEY ( brk,
                                                                        idkr );

CREATE TABLE obradjivanje (
    brk  INTEGER NOT NULL,
    idkr INTEGER NOT NULL
);

ALTER TABLE obradjivanje ADD CONSTRAINT obradjivanje_pk PRIMARY KEY ( brk,
                                                                      idkr );

CREATE TABLE obzb (
    idr    INTEGER NOT NULL,
    imeo   VARCHAR2(32 CHAR) NOT NULL,
    smenao VARCHAR2(16 BYTE) NOT NULL,
    ide    INTEGER,
    nazb   VARCHAR2(16 BYTE)
);

ALTER TABLE obzb ADD CONSTRAINT obzb_pk PRIMARY KEY ( idr );

ALTER TABLE obzb ADD CONSTRAINT obzb_pkv1 UNIQUE ( imeo );

CREATE TABLE postavljen (
    ide  INTEGER NOT NULL,
    nazb VARCHAR2(16 BYTE) NOT NULL,
    brk  INTEGER NOT NULL,
    idr  INTEGER NOT NULL
);

ALTER TABLE postavljen
    ADD CONSTRAINT postavljen_pk PRIMARY KEY ( ide,
                                               nazb,
                                               brk,
                                               idr );

CREATE TABLE radnik (
    idr    INTEGER NOT NULL,
    brtel  VARCHAR2(16 BYTE) NOT NULL,
    vrstar VARCHAR2(8) NOT NULL,
    nazb   VARCHAR2(16 BYTE) NOT NULL
);

ALTER TABLE radnik
    ADD CONSTRAINT ch_inh_radnik CHECK ( vrstar IN ( 'Direktor', 'Obzb', 'Radnik', 'Referent' ) );

ALTER TABLE radnik ADD CONSTRAINT radnik_pk PRIMARY KEY ( idr );

CREATE TABLE referent (
    idr  INTEGER NOT NULL,
    imer VARCHAR2(32 CHAR) NOT NULL,
    rs   NUMBER NOT NULL
);

ALTER TABLE referent ADD CONSTRAINT referent_pk PRIMARY KEY ( idr );

CREATE TABLE sadrzi (
    ide  INTEGER NOT NULL,
    nazb VARCHAR2(16 BYTE) NOT NULL,
    brk  INTEGER NOT NULL
);

ALTER TABLE sadrzi
    ADD CONSTRAINT sadrzi_pk PRIMARY KEY ( ide,
                                           nazb,
                                           brk );

CREATE TABLE skk (
    brk  INTEGER NOT NULL,
    rbsk VARCHAR2(16 BYTE) NOT NULL,
    brsk INTEGER NOT NULL
);

ALTER TABLE skk ADD CONSTRAINT skk_pk PRIMARY KEY ( brk );

CREATE TABLE stranav (
    idkr INTEGER NOT NULL,
    imvs VARCHAR2(32 CHAR) NOT NULL,
    pksv INTEGER NOT NULL
);

ALTER TABLE stranav ADD CONSTRAINT stranav_pk PRIMARY KEY ( idkr );

CREATE TABLE zahteva (
    zrk  VARCHAR2(16 BYTE) NOT NULL,
    idkr INTEGER NOT NULL
);

ALTER TABLE zahteva ADD CONSTRAINT zahteva_pk PRIMARY KEY ( zrk,
                                                            idkr );

ALTER TABLE direktor
    ADD CONSTRAINT direktor_direktor_fk FOREIGN KEY ( idr2 )
        REFERENCES direktor ( idr );

ALTER TABLE direktor
    ADD CONSTRAINT direktor_radnik_fk FOREIGN KEY ( idr )
        REFERENCES radnik ( idr );

ALTER TABLE domacav
    ADD CONSTRAINT domacav_kredit_fk FOREIGN KEY ( idkr )
        REFERENCES kredit ( idkr );

ALTER TABLE ekspozitura
    ADD CONSTRAINT ekspozitura_banka_fk FOREIGN KEY ( nazb )
        REFERENCES banka ( nazb );

ALTER TABLE kkk
    ADD CONSTRAINT kkk_kancelarija_fk FOREIGN KEY ( brk )
        REFERENCES kancelarija ( brk );

ALTER TABLE klijent
    ADD CONSTRAINT klijent_ekspozitura_fk FOREIGN KEY ( ide,
                                                        nazb )
        REFERENCES ekspozitura ( ide,
                                 nazb );

ALTER TABLE kredit
    ADD CONSTRAINT kredit_referent_fk FOREIGN KEY ( idr )
        REFERENCES referent ( idr );

ALTER TABLE obracunavanje
    ADD CONSTRAINT obracunavanje_kkk_fk FOREIGN KEY ( brk )
        REFERENCES kkk ( brk );

ALTER TABLE obracunavanje
    ADD CONSTRAINT obracunavanje_stranav_fk FOREIGN KEY ( idkr )
        REFERENCES stranav ( idkr );

ALTER TABLE obradjivanje
    ADD CONSTRAINT obradjivanje_domacav_fk FOREIGN KEY ( idkr )
        REFERENCES domacav ( idkr );

ALTER TABLE obradjivanje
    ADD CONSTRAINT obradjivanje_skk_fk FOREIGN KEY ( brk )
        REFERENCES skk ( brk );

ALTER TABLE obzb
    ADD CONSTRAINT obzb_ekspozitura_fk FOREIGN KEY ( ide,
                                                     nazb )
        REFERENCES ekspozitura ( ide,
                                 nazb );

ALTER TABLE obzb
    ADD CONSTRAINT obzb_radnik_fk FOREIGN KEY ( idr )
        REFERENCES radnik ( idr );

ALTER TABLE postavljen
    ADD CONSTRAINT postavljen_radnik_fk FOREIGN KEY ( idr )
        REFERENCES radnik ( idr );

ALTER TABLE postavljen
    ADD CONSTRAINT postavljen_sadrzi_fk FOREIGN KEY ( ide,
                                                      nazb,
                                                      brk )
        REFERENCES sadrzi ( ide,
                            nazb,
                            brk );

ALTER TABLE radnik
    ADD CONSTRAINT radnik_banka_fk FOREIGN KEY ( nazb )
        REFERENCES banka ( nazb );

ALTER TABLE referent
    ADD CONSTRAINT referent_radnik_fk FOREIGN KEY ( idr )
        REFERENCES radnik ( idr );

ALTER TABLE sadrzi
    ADD CONSTRAINT sadrzi_ekspozitura_fk FOREIGN KEY ( ide,
                                                       nazb )
        REFERENCES ekspozitura ( ide,
                                 nazb );

ALTER TABLE sadrzi
    ADD CONSTRAINT sadrzi_kancelarija_fk FOREIGN KEY ( brk )
        REFERENCES kancelarija ( brk );

ALTER TABLE skk
    ADD CONSTRAINT skk_kancelarija_fk FOREIGN KEY ( brk )
        REFERENCES kancelarija ( brk );

ALTER TABLE stranav
    ADD CONSTRAINT stranav_kredit_fk FOREIGN KEY ( idkr )
        REFERENCES kredit ( idkr );

ALTER TABLE zahteva
    ADD CONSTRAINT zahteva_klijent_fk FOREIGN KEY ( zrk )
        REFERENCES klijent ( zrk );

ALTER TABLE zahteva
    ADD CONSTRAINT zahteva_kredit_fk FOREIGN KEY ( idkr )
        REFERENCES kredit ( idkr );

CREATE OR REPLACE TRIGGER arc_fkarc_3_obzb BEFORE
    INSERT OR UPDATE OF idr ON obzb
    FOR EACH ROW
DECLARE
    d VARCHAR2(8);
BEGIN
    SELECT
        a.vrstar
    INTO d
    FROM
        radnik a
    WHERE
        a.idr = :new.idr;

    IF ( d IS NULL OR d <> 'Obzb' ) THEN
        raise_application_error(-20223, 'FK Obzb_Radnik_FK in Table Obzb violates Arc constraint on Table Radnik - discriminator column VRSTAR doesn''t have value ''Obzb'''
        );
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/

CREATE OR REPLACE TRIGGER arc_fkarc_3_direktor BEFORE
    INSERT OR UPDATE OF idr ON direktor
    FOR EACH ROW
DECLARE
    d VARCHAR2(8);
BEGIN
    SELECT
        a.vrstar
    INTO d
    FROM
        radnik a
    WHERE
        a.idr = :new.idr;

    IF ( d IS NULL OR d <> 'Direktor' ) THEN
        raise_application_error(-20223, 'FK Direktor_Radnik_FK in Table Direktor violates Arc constraint on Table Radnik - discriminator column VRSTAR doesn''t have value ''Direktor'''
        );
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/

CREATE OR REPLACE TRIGGER arc_fkarc_3_referent BEFORE
    INSERT OR UPDATE OF idr ON referent
    FOR EACH ROW
DECLARE
    d VARCHAR2(8);
BEGIN
    SELECT
        a.vrstar
    INTO d
    FROM
        radnik a
    WHERE
        a.idr = :new.idr;

    IF ( d IS NULL OR d <> 'Referent' ) THEN
        raise_application_error(-20223, 'FK Referent_Radnik_FK in Table Referent violates Arc constraint on Table Radnik - discriminator column VRSTAR doesn''t have value ''Referent'''
        );
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/

CREATE OR REPLACE TRIGGER arc_fkarc_2_domacav BEFORE
    INSERT OR UPDATE OF idkr ON domacav
    FOR EACH ROW
DECLARE
    d VARCHAR2(7);
BEGIN
    SELECT
        a.tipvalute
    INTO d
    FROM
        kredit a
    WHERE
        a.idkr = :new.idkr;

    IF ( d IS NULL OR d <> 'DomacaV' ) THEN
        raise_application_error(-20223, 'FK DomacaV_Kredit_FK in Table DomacaV violates Arc constraint on Table Kredit - discriminator column TIPVALUTE doesn''t have value ''DomacaV'''
        );
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/

CREATE OR REPLACE TRIGGER arc_fkarc_2_stranav BEFORE
    INSERT OR UPDATE OF idkr ON stranav
    FOR EACH ROW
DECLARE
    d VARCHAR2(7);
BEGIN
    SELECT
        a.tipvalute
    INTO d
    FROM
        kredit a
    WHERE
        a.idkr = :new.idkr;

    IF ( d IS NULL OR d <> 'StranaV' ) THEN
        raise_application_error(-20223, 'FK StranaV_Kredit_FK in Table StranaV violates Arc constraint on Table Kredit - discriminator column TIPVALUTE doesn''t have value ''StranaV'''
        );
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/

CREATE OR REPLACE TRIGGER arc_fkarc_1_skk BEFORE
    INSERT OR UPDATE OF brk ON skk
    FOR EACH ROW
DECLARE
    d VARCHAR2(11);
BEGIN
    SELECT
        a.svrha
    INTO d
    FROM
        kancelarija a
    WHERE
        a.brk = :new.brk;

    IF ( d IS NULL OR d <> 'Skk' ) THEN
        raise_application_error(-20223, 'FK Skk_Kancelarija_FK in Table Skk violates Arc constraint on Table Kancelarija - discriminator column SVRHA doesn''t have value ''Skk'''
        );
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/

CREATE OR REPLACE TRIGGER arc_fkarc_1_kkk BEFORE
    INSERT OR UPDATE OF brk ON kkk
    FOR EACH ROW
DECLARE
    d VARCHAR2(11);
BEGIN
    SELECT
        a.svrha
    INTO d
    FROM
        kancelarija a
    WHERE
        a.brk = :new.brk;

    IF ( d IS NULL OR d <> 'Kkk' ) THEN
        raise_application_error(-20223, 'FK Kkk_Kancelarija_FK in Table Kkk violates Arc constraint on Table Kancelarija - discriminator column SVRHA doesn''t have value ''Kkk'''
        );
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/

INSERT INTO BANKA (NAZB, SEDB, RVB)
VALUES ('Rajhfajzen', 'Beograd', TO_DATE('2024-01-11','YYYY-MM-DD'));
INSERT INTO BANKA (NAZB, SEDB, RVB)
VALUES ('KreditKom', 'London', TO_DATE('2024-02-11','YYYY-MM-DD'));
INSERT INTO BANKA (NAZB, SEDB, RVB)
VALUES ('OprBanka', 'Novi Sad', TO_DATE('2024-03-11','YYYY-MM-DD'));
INSERT INTO BANKA (NAZB, SEDB, RVB)
VALUES ('KreditBanka', 'Atina', TO_DATE('2024-04-11','YYYY-MM-DD'));
INSERT INTO BANKA (NAZB, SEDB, RVB)
VALUES ('RandomBanka', 'Pariz', TO_DATE('2024-05-12','YYYY-MM-DD'));
INSERT INTO BANKA (NAZB, SEDB, RVB)
VALUES ('Nova', 'Kragujevac', TO_DATE('2024-06-11','YYYY-MM-DD'));
INSERT INTO BANKA (NAZB, SEDB, RVB)
VALUES ('Stara', 'Kragujevac', TO_DATE('2024-07-11','YYYY-MM-DD'));
INSERT INTO BANKA (NAZB, SEDB, RVB)
VALUES ('DDO', 'Mikonos', TO_DATE('2024-08-12','YYYY-MM-DD'));
INSERT INTO BANKA (NAZB, SEDB, RVB)
VALUES ('DDR', 'NS', TO_DATE('2024-09-11','YYYY-MM-DD'));

INSERT INTO EKSPOZITURA(IDE, LOKE, NAZB)
VALUES(1, 'Leva Ulica', 'Rajhfajzen');
INSERT INTO EKSPOZITURA(IDE, LOKE, NAZB)
VALUES(2, 'Bul Oslb', 'KreditKom');
INSERT INTO EKSPOZITURA(IDE, LOKE, NAZB)
VALUES(3, 'Bez broja', 'OprBanka');
INSERT INTO EKSPOZITURA(IDE, LOKE, NAZB)
VALUES(4, 'Random', 'KreditBanka');
INSERT INTO EKSPOZITURA(IDE, LOKE, NAZB)
VALUES(5, 'VVVV', 'KreditBanka');
INSERT INTO EKSPOZITURA(IDE, LOKE, NAZB)
VALUES(6, 'Leva Ulica', 'OprBanka');


INSERT INTO KLIJENT(ZRK, IMEK, PRZK, IDE, NAZB)
VALUES('4444333', 'Pera', 'Peric', 6, 'OprBanka');
INSERT INTO KLIJENT(ZRK, IMEK, PRZK, IDE, NAZB)
VALUES('421-432', 'Zika', 'Zikic', 5, 'KreditBanka');
INSERT INTO KLIJENT(ZRK, IMEK, PRZK, IDE, NAZB)
VALUES('15-555-3', 'Jovica', 'Jovic', 1, 'Rajhfajzen');



INSERT INTO KANCELARIJA(BRK, KVK, SVRHA)
VALUES(33, 55, 'Skk');
INSERT INTO KANCELARIJA(BRK, KVK, SVRHA)
VALUES(18, 65, 'Skk');
INSERT INTO KANCELARIJA(BRK, KVK, SVRHA)
VALUES(12, 44, 'Kkk');
INSERT INTO KANCELARIJA(BRK, KVK, SVRHA)
VALUES(22, 42, 'Kkk');

INSERT INTO SKK(BRK, RBSK, BRSK)
VALUES(33, 'Prvi', 44);
INSERT INTO SKK(BRK, RBSK, BRSK)
VALUES(18, 'drugi', 64);

INSERT INTO KKK(BRK, RBKK, BRKK)
VALUES(12, 'osmi', 88);
INSERT INTO KKK(BRK, RBKK, BRKK)
VALUES(22, 'deveti', 99);



INSERT INTO SADRZI(IDE,NAZB,BRK)
VALUES(1, 'Rajhfajzen', 33);
INSERT INTO SADRZI(IDE,NAZB,BRK)
VALUES(3, 'OprBanka', 12);
INSERT INTO SADRZI(IDE,NAZB,BRK)
VALUES(4, 'KreditBanka', 18);


INSERT INTO RADNIK(IDR, BRTEL, VRSTAR, NAZB)
VALUES(1, '555333', 'Direktor', 'Rajhfajzen');
INSERT INTO RADNIK(IDR, BRTEL, VRSTAR, NAZB)
VALUES(2, '5554444', 'Direktor', 'KreditKom');
INSERT INTO RADNIK(IDR, BRTEL, VRSTAR, NAZB)
VALUES(3, '552233', 'Referent', 'OprBanka');
INSERT INTO RADNIK(IDR, BRTEL, VRSTAR, NAZB)
VALUES(4, '55534', 'Referent', 'RandomBanka');
INSERT INTO RADNIK(IDR, BRTEL, VRSTAR, NAZB)
VALUES(5, '212233', 'Obzb', 'Nova');
INSERT INTO RADNIK(IDR, BRTEL, VRSTAR, NAZB)
VALUES(6, '11534', 'Obzb', 'Stara');
INSERT INTO RADNIK(IDR, BRTEL, VRSTAR, NAZB)
VALUES(33, '11243', 'Referent', 'DDO');
INSERT INTO RADNIK(IDR, BRTEL, VRSTAR, NAZB)
VALUES(44, '99999', 'Referent', 'DDR');

INSERT INTO DIREKTOR(IDR, IMED, PLATAD, IDR2)
VALUES(1, 'Jovan', 5000, 1);
INSERT INTO DIREKTOR(IDR, IMED, PLATAD, IDR2)
VALUES(2, 'Stojan', 9000, 2);
INSERT INTO REFERENT(IDR, IMER, RS)
VALUES(3,'Pera', 6);
INSERT INTO REFERENT(IDR, IMER, RS)
VALUES(4,'Jovan', 10);
INSERT INTO OBZB(IDR, IMEO, SMENAO, IDE, NAZB)
VALUES(5, 'Jovica', 'prva', 1, 'Rajhfajzen');
INSERT INTO OBZB(IDR, IMEO, SMENAO, IDE, NAZB)
VALUES(6, 'Djetic', 'treca', 3, 'OprBanka');
INSERT INTO REFERENT(IDR, IMER, RS)
VALUES(33,'Stojan', 15);
INSERT INTO REFERENT(IDR, IMER, RS)
VALUES(44,'BalkanBoy', 10);

INSERT INTO POSTAVLJEN(IDR, IDE, NAZB, BRK)
VALUES(1, 1, 'Rajhfajzen',33); 
INSERT INTO POSTAVLJEN(IDR, IDE, NAZB, BRK)
VALUES(33, 3, 'OprBanka',12); 
INSERT INTO POSTAVLJEN(IDR, IDE, NAZB, BRK)
VALUES(3, 3, 'OprBanka',12); 
INSERT INTO POSTAVLJEN(IDR, IDE, NAZB, BRK)
VALUES(2, 1, 'Rajhfajzen',33); 
INSERT INTO POSTAVLJEN(IDR, IDE, NAZB, BRK)
VALUES(33, 4, 'KreditBanka',18); 



INSERT INTO KREDIT(IDKR, DOK, UK, TIPVALUTE, IDR)
VALUES(121, TO_DATE('2023-03-11','YYYY-MM-DD'),66333, 'StranaV', 4);
INSERT INTO KREDIT(IDKR, DOK, UK, TIPVALUTE, IDR)
VALUES(444, TO_DATE('2023-06-11','YYYY-MM-DD'),4412, 'DomacaV', 44);
INSERT INTO KREDIT(IDKR, DOK, UK, TIPVALUTE, IDR)
VALUES(122, TO_DATE('2023-08-11','YYYY-MM-DD'),555444, 'StranaV', 3);
INSERT INTO KREDIT(IDKR, DOK, UK, TIPVALUTE, IDR)
VALUES(555, TO_DATE('2023-07-11','YYYY-MM-DD'),1234, 'DomacaV', 33);

INSERT INTO STRANAV(IDKR,IMVS,PKSV)
VALUES(121,'Dolari', 0);
INSERT INTO STRANAV(IDKR,IMVS,PKSV)
VALUES(122,'Evri', 117);

INSERT INTO DOMACAV(IDKR,IMVD,PKDV)
VALUES(444, 'Dinar', 100);
INSERT INTO DOMACAV(IDKR,IMVD,PKDV)
VALUES(555, 'Opet Dinar', 110);

INSERT INTO ZAHTEVA(ZRK, IDKR)
VALUES('4444333', 121);
INSERT INTO ZAHTEVA(ZRK, IDKR)
VALUES('421-432', 122);

INSERT INTO OBRADJIVANJE(BRK, IDKR)
VALUES(33, 444);
INSERT INTO OBRADJIVANJE(BRK, IDKR)
VALUES(18, 555);

INSERT INTO OBRACUNAVANJE(BRK, IDKR)
VALUES(12,121);
INSERT INTO OBRACUNAVANJE(BRK, IDKR)
VALUES(12,122);


