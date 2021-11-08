CREATE OR REPLACE PACKAGE BODY "FNICOLO".WebPages as

procedure BodyHome (idSessione varchar2 default 0) is
    begin
    htp.htmlOpen;
    htp.headOpen;
    htp.prn('<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css"> ');
    htp.headClose;
    modGUI.Header(idSessione);
    if (idSessione=1)
    then
        modGUI.ApriDiv('style:"height:90%;"');
            modGUI.ApriDiv;
                htp.prn('
                    <a href="'||Costanti.server || Costanti.radice||'MuseiHome?idSessione='|| idSessione ||'">
                    <img src="https://www.artribune.com/wp-content/uploads/2020/06/Museo-del-Prado-sala-24.jpg" style="width:50%; height:100%;" class="w3-opacity w3-hover-opacity-off w3-left">
                    </a>
                    <a href="'||Costanti.server || Costanti.radice||'CampiestiviHome?idSessione='|| idSessione ||'">
                    <img src="https://www.baritoday.it/~media/horizontal-hi/70029796349612/sc18nature-walk-2.jpg" style="width:50%; height:100%;" class="w3-opacity w3-hover-opacity-off w3-right">
                    </a>
                ');
            modGUI.ChiudiDiv;
        modGUI.chiudiDiv;
    else
        modGUI.ApriDiv('style:"height:90%;"');
            modGUI.ApriDiv;
                htp.prn('

                    <img src="https://www.artribune.com/wp-content/uploads/2020/06/Museo-del-Prado-sala-24.jpg" onclick="document.getElementById(''id01'').style.display=''block''" style="width:50%; height:100%;" class="w3-opacity w3-hover-opacity-off w3-left">

                    <img src="https://www.baritoday.it/~media/horizontal-hi/70029796349612/sc18nature-walk-2.jpg" onclick="document.getElementById(''id01'').style.display=''block''" style="width:50%; height:100%;" class="w3-opacity w3-hover-opacity-off w3-right">

                ');
            modGUI.ChiudiDiv;
        modGUI.chiudiDiv;
    end if;
    end BodyHome;

    procedure MuseiHome (idSessione int default 0) is
    begin
        htp.prn('<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css"> ');
        modGUI.Header(idSessione);

        htp.br;htp.br;htp.br;htp.br;htp.br;htp.br;
        modGUI.ApriDiv('class="w3-center"');
            htp.prn('<h1>Musei</h1>');
        modGUI.ChiudiDiv;
        htp.br;
        modGUI.ApriDiv('class="w3-row w3-container"');
        if (idSessione=1)
        then

                modGUI.ApriDiv('class="w3-col l4 w3-padding-large w3-center"');
                    modGUI.ApriDiv('class="w3-card-4" style="height:420px;"');
                    htp.br;
                    modGUI.InputImage('ImmMuseo','ImmMuseo');
                            modGUI.ApriDiv('class="w3-container w3-margin w3-center"');
                                modGUI.ApriForm('InserisciMuseo','InserisciMuseo');
                                    modGUI.Label('Nome:');
                                    modGUI.InputText('nomeMuseo','Inserisci il nome del museo...', 1);
                                    modGUI.Label('Descrizione:');
                                    htp.br;
                                    modGUI.InputTextArea('desMuseo','Inserisci la descrizione del museo...', 1);
                                    htp.br;
                                    modGUI.InputSubmit('Aggiungi');
                                modGUI.ChiudiForm;
                            modGUI.ChiudiDiv;

                    modGUI.ChiudiDiv;
                modGUI.ChiudiDiv;


        end if;

            FOR k IN 1..10 LOOP
                modGUI.ApriDiv('class="w3-col l4 w3-padding-large w3-center"');
                    modGUI.ApriDiv('class="w3-card-4"');
                    htp.prn('<img src="https://cdn.pixabay.com/photo/2016/10/22/15/32/water-1761027__480.jpg" alt="Alps" style="width:100%">');
                            modGUI.ApriDiv('class="w3-container w3-center"');
                                htp.prn('<p>Museo '|| k ||'</p>');
                            modGUI.ChiudiDiv;
                            if(idSessione=1) then
                               modGUI.Bottone('w3-black','Visualizza');
                               modGUI.Bottone('w3-green','Modifica');
                               modGUI.Bottone('w3-red','Rimuovi');
                            else
                            modGUI.Bottone('w3-black','Visualizza');
                            end if;
                    modGUI.ChiudiDiv;
                modGUI.ChiudiDiv;
            END LOOP;
        modGUI.chiudiDiv;
    end MuseiHome;

    procedure CampiEstiviHome (idSessione int default 0) is
    begin
        htp.prn('<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css"> ');
        modGUI.Header(idSessione);

        htp.br;htp.br;htp.br;htp.br;htp.br;htp.br;
        modGUI.ApriDiv('class="w3-center"');
            htp.prn('<h1>Campi estivi</h1>');
        modGUI.ChiudiDiv;
        htp.br;
        modGUI.ApriDiv('class="w3-container" style="width:100%"');
        if(idSessione=1)
        then
        modGUI.ApriForm('AggiuntaCampo','campoEstivo',NULL);
            modGUI.ApriDiv('class="w3-row w3-container w3-border w3-round-small w3-padding-large w3-hover-light-grey" style="width:100%"');
                    modGUI.ApriDiv('class="w3-container w3-cell" style="width:500px; height:300px;"');
                        htp.br;htp.br;htp.br;htp.br;htp.br;htp.br;
                        modGUI.InputImage('imgEstivo','imgEstivo');
                    modGUI.ChiudiDiv;
                    modGUI.ApriDiv('class="w3-container w3-cell w3-cell-middle" style="width:1120px; height:300px"');
                        modGUI.Label('Titolo:');
                        modGUI.InputText('titoloEstivo','Inserisci il titolo del campo estivo...',1);
                        modGUI.Label('Descrizione:');
                        modGUI.InputTextArea('desEstivo','Inserisci la descrizione del campo estivo...',1);
                        htp.prn('<b>Partenza:</b>');
                        modGUI.InputDate('dataEstivoInizio','DataInizio');
                        htp.prn('<b>Ritorno:</b>');
                        modGUI.InputDate('dataEstivoFine','DataFine');
                    modGUI.ChiudiDiv;
                    modGUI.ApriDiv('class="w3-container w3-cell w3-cell-middle"');
                        modGUI.InputSubmit('Aggiungi');
                    modGUI.ChiudiDiv;
            modGUI.chiudiDiv;
        modGUI.ChiudiForm;
            htp.br;
            htp.br;
        end if;
            FOR k IN 1..10
            LOOP
            modGUI.ApriDiv('class="w3-row w3-container w3-border w3-round-small w3-padding-large w3-hover-light-grey" style="width:100%"');
                    modGUI.ApriDiv('class="w3-container w3-cell"');
                        htp.prn('<img src="https://cdn.pixabay.com/photo/2016/10/22/15/32/water-1761027__480.jpg" alt="Alps" style="width:500px; height:300px;">');
                    modGUI.ChiudiDiv;
                    modGUI.ApriDiv('class="w3-container w3-cell w3-border-right w3-cell-middle" style="width:1120px; height:300px"');
                        htp.prn('<h5>Campo estivo A</h5>');
                        htp.prn('<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus eget erat at velit bibendum lobortis. Integer commodo sed libero blandit scelerisque. Cras tristique justo in nibh pharetra, hendrerit eleifend orci volutpat. Sed sed dapibus mauris, ut cursus nibh. Maecenas cursus dolor eu arcu tincidunt condimentum. Etiam cursus tellus purus, vel feugiat mi maximus sit amet. Pellentesque id faucibus nulla. Nam quis feugiat est, non interdum dui. Fusce venenatis vitae diam vitae tincidunt. Vestibulum dictum, quam vitae molestie vehicula, leo urna blandit mauris, ut efficitur mi purus venenatis turpis. </p>');
                        htp.prn('<p>Orario: 9:00 - 18:00</p>');
                    modGUI.ChiudiDiv;
                    modGUI.ApriDiv('class="w3-container w3-cell w3-cell-middle"');
                        if(idSessione=1) then
                                        modGUI.Bottone('w3-black','Visualizza');
                                        htp.br;
                                        modGUI.Bottone('w3-green','Modifica');
                                        htp.br;
                                        modGUI.Bottone('w3-red','Elimina');
                            else
                                modGUI.Bottone('w3-black','Visualizza');
                            end if;
                    modGUI.ChiudiDiv;
            modGUI.chiudiDiv;
            htp.br;
            htp.br;
            END LOOP;
        modGUI.chiudiDiv;
    end CampiEstiviHome;

end WebPages;