CREATE OR REPLACE PACKAGE BODY PackageStanze as
    
    ---SALE---
    
    PROCEDURE visualizzaSale (idSessione IN int default 0) is 
    museosel musei.nome%TYPE;
    BEGIN
        modGUI1.ApriPagina('Sale', idSessione);
        modGUI1.Header(idSessione);
        htp.br;htp.br;htp.br;htp.br;
        modGUI1.ApriDiv('class="w3-center"');
            htp.prn('<h1>Sale</h1>'); --TITOLO
            if (idSessione=1)
            then
                modGUI1.Collegamento('Aggiungi','packagestanze.formSala','w3-btn w3-round-xxlarge w3-black'); /*bottone che rimanda alla procedura inserimento solo se la sessione è 1*/
            END if;
        modGUI1.ChiudiDiv;
        htp.br;
        modGUI1.ApriDiv('class="w3-row w3-container"');
        --INIZIO LOOP DELLA VISUALIZZAZIONE
            FOR sala IN (SELECT * FROM sale NATURAL JOIN stanze ORDER BY idstanza) LOOP
                modGUI1.ApriDiv('class="w3-col l4 w3-padding-large w3-center"');
                    modGUI1.ApriDiv('class="w3-card-4"');
                    htp.prn('<img src="https://www.23bassi.com/wp-content/uploads/2019/03/vuota-web.jpg" alt="Alps" style="width:100%">');
                            modGUI1.ApriDiv('class="w3-container w3-center"');
                            --INIZIO DESCRIZIONI
                                SELECT nome INTO museosel FROM MUSEI WHERE (musei.idmuseo=sala.museo);
                                htp.prn('<p><b>Museo: </b>'|| museosel ||'</p>');
                                htp.prn('<h2><b>'|| sala.nome||'</b></h2>');
                                htp.prn('<h4>Tipo '|| sala.tiposala||'</h4>');
                                htp.prn('<p>Dim: '||sala.dimensione || 'mq / ');
                                htp.prn('Max opere: '|| sala.numopere||'</p>');

                            --FINE DESCRIZIONI
                            modGUI1.ChiudiDiv;
                            
                            if(idSessione=1) then --Bottoni visualizzati in base alla sessione 
                               modGUI1.Collegamento('Modifica','packagestanze.formSala?modifica=1&varSalaMuseo='||sala.museo||'&varSalaNome='||sala.nome||'&varSalaDimensione='||sala.dimensione||'&varSalaTipo='||sala.tiposala||'&varSalaOpere='||sala.numopere,'w3-button w3-green');
                               modGUI1.Collegamento('Rimuovi','packagestanze.rimuoviSala?idSalDel='||sala.idstanza,'w3-button w3-red w3-margin');
                            END if;

                    modGUI1.ChiudiDiv;
                modGUI1.ChiudiDiv;
            END LOOP;
        --FINE LOOP
        modGUI1.chiudiDiv;  
    END;

    PROCEDURE formSala (
        modifica IN NUMBER default 0,
        varSalaMuseo IN NUMBER default NULL,
        varSalaNome VARCHAR2 default NULL,
        varSalaDimensione NUMBER default NULL,
        varSalaTipo NUMBER default NULL,
        varSalaOpere NUMBER default NULL
        ) is
        NomeMuseo MUSEI.Nome%TYPE;
        varIdMuseo MUSEI.IdMuseo%TYPE;
    BEGIN
        modGUI1.ApriPagina();
        modGUI1.Header();
        
        modGUI1.ApriDiv('style="margin-top: 110px"');
            htp.prn('<h1 class="w3-center">Inserimento sala</h1>');
                modGUI1.ApriDivCard;
                    if (modifica=0)
                    then
                        modGUI1.ApriForm('packagestanze.inseriscisala',NULL,'w3-container');
                    else
                        modGUI1.ApriForm('packagestanze.modificasala',NULL,'w3-container');
                    end if;

                            ----CAMPI STANZA----
                            modGUI1.Label('Museo:');
                            modGUI1.SelectOpen('selectMusei');
                                for museo in (select IdMuseo from MUSEI)
                                loop
                                    select IdMuseo, Nome into varIdMuseo, NomeMuseo
                                    from MUSEI
                                    where IdMuseo = museo.IdMuseo;
                                    if (museo.idmuseo=VarSalaMuseo)
                                    then
                                        modGUI1.SelectOption(varIdMuseo,NomeMuseo,1);
                                    else
                                        modGUI1.SelectOption(varIdMuseo,NomeMuseo);
                                    END if;
                                END loop;
                            modGUI1.SelectClose;
                            htp.br;
                            modGUI1.Label('Nome sala:');
                            modGUI1.InputText('nomeSala',NULL,NULL,varSalaNome);
                            htp.br;
                            modGUI1.Label('Dimensione sala:');
                            modGUI1.InputNumber('idDimSala','dimSala',NULL,varSalaDimensione);
                            htp.br;
                            ----CAMPI SALA----
                            modGUI1.Label('Tipo sala:');
                            if(varSalaTipo=0)
                                then
                                    modGUI1.InputRadioButton('Tipo 0 ','tipoSalaform','0',1);
                                    modGUI1.InputRadioButton('Tipo 1 ','tipoSalaform','1');
                                else
                                    modGUI1.InputRadioButton('Tipo 0 ','tipoSalaform','0');
                                    modGUI1.InputRadioButton('Tipo 1 ','tipoSalaform','1',1);
                            END if;
                            htp.br;
                            modGUI1.Label('Numero Opere: ');
                            modGUI1.InputNumber('idnOpere','nOpereform',NULL,varSalaOpere);
                            htp.br;
                            modGUI1.InputReset;
                            if (modifica=0)
                            then
                                modGUI1.InputSubmit('Aggiungi');
                            else
                                modGUI1.InputSubmit('Modifica');
                            END if;

                    modGUI1.ChiudiForm;
                modGUI1.ChiudiDiv;
        modGUI1.ChiudiDiv();
    END;


    PROCEDURE inserisciSala (
        selectMusei IN musei.idmuseo%TYPE,
        nomeSala       IN  VARCHAR2,
        dimSala            IN  NUMBER,
        tipoSalaform         IN  NUMBER,
        nOpereform           IN NUMBER
    ) IS
        idstanzacreata sale.idstanza%TYPE;
    
    BEGIN    	
        idstanzacreata := idstanzaseq.nextval;
        INSERT INTO STANZE (
            idstanza,
            nome,
            dimensione,
            museo,
            eliminato
        ) VALUES (
            idstanzacreata,
            nomeSala,
            dimSala,
            selectMusei,
            0
        );
        INSERT INTO SALE (
            idstanza,
            tiposala,
            numopere,
            eliminato    
        ) VALUES (
            idstanzacreata,
            tipoSalaForm,
            nOpereform,
            0
        );
        htp.prn('DONE');
    END;


    ---AMBIENTI DI SERVIZIO---
    
    PROCEDURE visualizzaAmbientiServizio (idSessione IN int default 0) is 
    museosel musei.nome%TYPE;
    BEGIN
        modGUI1.ApriPagina('Ambienti di servizio', idSessione);
        modGUI1.Header(idSessione);
        htp.br;htp.br;htp.br;htp.br;
        modGUI1.ApriDiv('class="w3-center"');
            htp.prn('<h1>Ambienti di servizio</h1>'); --TITOLO
            if (idSessione=1)
            then
                modGUI1.Collegamento('Aggiungi','packagestanze.formAmbienteServizio','w3-btn w3-round-xxlarge w3-black'); /*bottone che rimanda alla procedura inserimento solo se la sessione è 1*/
            END if;
        modGUI1.ChiudiDiv;
        htp.br;
        modGUI1.ApriDiv('class="w3-row w3-container"');
        --INIZIO LOOP DELLA VISUALIZZAZIONE
            FOR AmbS IN (SELECT * FROM ambientidiservizio NATURAL JOIN stanze ORDER BY idstanza) LOOP
                modGUI1.ApriDiv('class="w3-col l4 w3-padding-large w3-center"');
                    modGUI1.ApriDiv('class="w3-card-4"');
                    htp.prn('<img src="https://cdn.pixabay.com/photo/2016/10/22/15/32/water-1761027__480.jpg" alt="Alps" style="width:100%">');
                            modGUI1.ApriDiv('class="w3-container w3-center"');
                            --INIZIO DESCRIZIONI
                                SELECT nome INTO museosel FROM MUSEI WHERE (musei.idmuseo=AmbS.museo);
                                htp.prn('<p><b>Museo: </b>'|| museosel ||'</p>');
                                htp.prn('<h2><b>'|| AmbS.nome||'</b></h2>');
                                htp.prn('<h4>'|| AmbS.tipoambiente||'</h4>');
                                htp.prn('<p>Dim: '||AmbS.dimensione || 'mq</p>');

                            --FINE DESCRIZIONI
                            modGUI1.ChiudiDiv;
                            
                            if(idSessione=1) then --Bottoni visualizzati in base alla sessione 
                                modGUI1.Collegamento('Modifica','packagestanze.formAmbienteServizio?modifica=1&varASMuseo='||AmbS.museo||'&varASNome='||AmbS.nome||'&varASDimensione='||AmbS.dimensione||'&varASTipo='||AmbS.tipoambiente,'w3-button w3-green');
                                modGUI1.Collegamento('Rimuovi','packagestanze.rimuoviAmbienteServizio?idAS='||AmbS.idstanza, 'w3-button w3-red w3-margin');
                            END if;

                    modGUI1.ChiudiDiv;
                modGUI1.ChiudiDiv;
            END LOOP;
        --FINE LOOP
        modGUI1.chiudiDiv;  
    END;
    
    

    PROCEDURE formAmbienteServizio (
        modifica IN NUMBER default 0,
        varASMuseo IN NUMBER default NULL,
        varASNome VARCHAR2 default NULL,
        varASDimensione NUMBER default NULL,
        varASTipo VARCHAR2 default NULL
    ) is
        NomeMuseo MUSEI.Nome%TYPE;
        varIdMuseo MUSEI.IdMuseo%TYPE;
    BEGIN
        modGUI1.ApriPagina();
        modGUI1.Header();
        modGUI1.ApriDiv('style="margin-top: 110px"');
            htp.prn('<h1 class="w3-center">Inserimento ambiente di servizio</h1>');
                modGUI1.ApriDivCard;
                    if (modifica=0)
                    then
                    modGUI1.ApriForm('packagestanze.inserisciambienteservizio',NULL,'w3-container');
                    else 
                    modGUI1.ApriForm('packagestanze.modificaambienteservizio',NULL,'w3-container');
                    end if;
                            ----CAMPI STANZA----
                            modGUI1.Label('Museo:');
                            modGUI1.SelectOpen('selectMusei');
                                for museo in (select IdMuseo from MUSEI)
                                loop
                                    select IdMuseo, Nome into varIdMuseo, NomeMuseo
                                    from MUSEI
                                    where IdMuseo = museo.IdMuseo;                                    
                                    if (museo.idmuseo=VarASMuseo)
                                    then
                                        modGUI1.SelectOption(varIdMuseo,NomeMuseo,1);
                                    else
                                        modGUI1.SelectOption(varIdMuseo,NomeMuseo);
                                    END if;
                                END loop;
                            modGUI1.SelectClose;
                            htp.br;
                            modGUI1.Label('Nome ambiente di servizio:');
                            modGUI1.InputText('nomeSala',NULL,NULL,varASNome);
                            htp.br;
                            modGUI1.Label('Dimensione sala:');
                            modGUI1.InputNumber('idDimSala','dimSala',NULL,varASDimensione);
                            htp.br;
                            ----CAMPI AMBIENTE SERVIZIO----
                            modGUI1.Label('Tipo Ambiente:');
                            modGUI1.InputText('tipoAmbienteform',NULL,NULL,varASTipo);
                            htp.br;
                            modGUI1.InputReset;
                            if (varASNome=NULL)
                            then
                                modGUI1.InputSubmit('Aggiungi');
                            else
                                modGUI1.InputSubmit('Modifica');
                            END if;

                    modGUI1.ChiudiForm;
                modGUI1.ChiudiDiv;
        modGUI1.ChiudiDiv();
    END;

    PROCEDURE inserisciAmbienteServizio (
        selectMusei IN musei.idmuseo%TYPE,
        nomeSala       IN  VARCHAR2,
        dimSala            IN  NUMBER,
        tipoAmbienteForm   IN VARCHAR2
    ) IS
        idstanzacreata sale.idstanza%TYPE;
    
    BEGIN
    	
        idstanzacreata := idstanzaseq.nextval;


        INSERT INTO STANZE (
            idstanza,
            nome,
            dimensione,
            museo,
            eliminato
        ) VALUES (
            idstanzacreata,
            nomeSala,
            dimSala,
            selectMusei,
            0
        );
        INSERT INTO AMBIENTIDISERVIZIO (
            idstanza,
            tipoambiente,
            eliminato    
        ) VALUES (
            idstanzacreata,
            tipoAmbienteForm,
            0
        );
        htp.prn('DONE');
    END;

END PackageStanze;

--TO ASK
--Il campo eliminato è presente sia in stanza che nelle sue sottoclassi
--Tipo sala 0 esclusiva o no?