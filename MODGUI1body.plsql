CREATE OR REPLACE PACKAGE BODY modGUI1 as

    procedure ApriPagina(titolo varchar2 default 'Senza titolo', idSessione int default 0) is
    begin
        htp.htmlOpen;
        htp.headOpen;
        htp.prn('<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css"> ');
        htp.title(titolo);
        htp.headClose;
    end ApriPagina;

    procedure Header (idSessione int default 0) is /*Testata pagina che include tendina ☰ e banner utente */
    begin
    modGUI1.ApriDiv('class="w3-dropdown w3-bar w3-top w3-black w3-large"');
        htp.prn('<button onclick="myFunction()" class="w3-button w3-hover-white w3-black w3-xxxlarge">☰</button>');
        modGUI1.ApriDiv('id="Demo" class="w3-dropdown-content w3-bar-block w3-black w3-sidebar" style="width:20%"');
            modGUI1.Collegamento('HOME','Home?idSessione='|| idSessione,'w3-bar-item w3-button');
            if (idSessione!=0)
            then
            modGUI1.Collegamento('Musei','MuseiHome?idSessione='|| idSessione,'w3-bar-item w3-button');
            modGUI1.Collegamento('Campi Estivi','CampiEstiviHome?idSessione='|| idSessione,'w3-bar-item w3-button');
            end if;
        modGUI1.ChiudiDiv;
        modGUI1.BannerUtente(idSessione);
    modGUI1.ChiudiDiv;
    htp.prn('
        <script>
            function myFunction() {
                var x = document.getElementById("Demo");
                if (x.className.indexOf("w3-show") == -1) {
                    x.className += " w3-show w3-animate-left";
                }else{
                    x.className = x.className.replace(" w3-show", "");
                }
            }
        </script>
    ');   
    end Header;

    procedure BannerUtente (idSessione int default 0) is /*Banner Log-In o utente */
    begin
    if (idSessione = 0) then
        modGUI1.ApriDiv('class="w3-container w3-right w3-large"');
            htp.prn('
                <button onclick="document.getElementById(''id01'').style.display=''block''" class="w3-margin w3-button w3-black w3-hover-white w3-large">LOG IN</button>
            ');
        modGUI1.chiudiDiv;
        modGUI1.Login;
    else
    modGUI1.ApriDiv('class="w3-container w3-right w3-large"');
        htp.prn('
            Mario Rossi
            <img src="https://www.sologossip.it/wp-content/uploads/2020/12/clementino-sologossip.jpg" class="w3-margin" style:"width=50px; height=50px;">
        ');
    modGUI1.ChiudiDiv;
    end if;
    end BannerUtente;


    procedure Login is /*Form popup per accesso utente */
    begin
    modGUI1.ApriDiv('id="id01" class="w3-modal"');
        modGUI1.ApriDiv('class="w3-modal-content w3-card-4 w3-animate-zoom" style="max-width:600px"');
            modGUI1.ApriDiv('class="w3-center"');
                htp.br;
                htp.prn('<span onclick="document.getElementById(''id01'').style.display=''none''" class="w3-button w3-xlarge w3-red w3-display-topright" title="Close Modal">X</span>
                        <img src="https://termoidraulicabassini.it/wp-content/uploads/2015/12/utente.png" alt="Avatar" style="width:30%" class="w3-circle w3-margin-top">');
            modGUI1.ChiudiDiv;
                modGUI1.ApriForm('Prova',NULL,'w3-container');
                    modGUI1.ApriDiv('class="w3-section"');
                        modGUI1.Label('Username:');
                        modGUI1.InputText('username','Enter Username',1);
                        htp.br;
                        modGUI1.Label ('Password:');
                        modGUI1.InputText('password','Enter Password',1);
                        htp.prn('<button class="w3-button w3-block w3-black w3-section w3-padding" type="submit">Login</button>');
                    modGUI1.ChiudiDiv;
                modGUI1.ChiudiForm;
        modGUI1.ChiudiDiv;
    modGUI1.ChiudiDiv;
    end Login;

    procedure Bottone (colore varchar2, text varchar2 default 'myButton') is /*Bottone(colore,testo) - specificare colore in inglese - testo contenuto nel bottone*/
    begin
        htp.prn ('<button class="w3-button '|| colore ||' w3-margin">'||text||'</button>');
    end Bottone;

    procedure ApriDiv (attributi varchar2 default '') is /*attributi -> parametri stile*/
    begin
        htp.prn('<div '|| attributi ||'>');
    end ApriDiv;

    procedure ChiudiDiv is
    begin
        htp.prn('</div>');
    end ChiudiDiv;

    procedure Collegamento(testo varchar2, indirizzo varchar2, classe varchar2 default '') is /*LINK, testo -> testo cliccabile, Indirizzo -> pagina di destinazione, classe -> parametri di stile*/
    begin
      htp.prn('<a href="' || Costanti.server || Costanti.radice || indirizzo ||'" class="'|| classe ||'">' || testo || '</a>');
    end Collegamento;

    procedure ApriForm(azione varchar2, nome varchar2 default 'myForm', classe varchar2 default '') is /*azione -> pagina di destinazione, nome -> nome form, classe -> parametri di stile*/
    begin
      htp.print('<form name="'|| nome || '" action="'|| Costanti.radice || azione || '" method="GET" class="' || classe || '">');
    end ApriForm;

    procedure ChiudiForm is
    begin
      htp.print('</form>');
    end ChiudiForm;

    procedure InputText (nome varchar2, placeholder varchar2 default '', required int default 0) is /*Casella di input testuale, nome -> nome casella, placeholder -> testo visualizzato quando vuota, required -> vincolo di NOT NULL*/
    begin
    htp.prn('<input class="w3-input w3-round-xlarge w3-border" type="text" name="'|| nome ||'" placeholder="'|| placeholder ||'"');
    if (required = 0)
    then
        htp.prn('>');
    else
        htp.prn(' required>');
    end if;
    end InputText;

    procedure InputTextArea (nome varchar2, placeholder varchar2 default '', required int default 0) is /*Casella di input testuale più grande, nome -> nome casella, placeholder -> testo visualizzato quando vuota, required -> vincolo di NOT NULL*/
    begin
    htp.prn('<textarea class="w3-input w3-round-xlarge w3-border" style="resize:none; height:40%" name="'|| nome ||'" placeholder="'|| placeholder ||'"');
    if (required = 0)
    then
        htp.prn('></textarea>');
    else
        htp.prn('required></textarea>');
    end if;
    end InputTextArea;

    procedure Label (testo varchar2) is /*Etichetta utilizzabile prima di un input*/
    begin
        htp.prn('<label style="color:black"><b>'|| testo ||'</b></label>');
    end Label;

    procedure InputImage (id varchar2, nome varchar2 ) is
    begin
        htp.prn('<input type="file" id="'||id||'" name="'||nome||'" accept="image/png, image/jpeg">');
    end InputImage;

    procedure InputSubmit (testo varchar2 default 'Submit') is /*Bottone per invio del form*/
    begin
        htp.prn('<button class="w3-button w3-black w3-large">'|| testo ||'</button>');
    end InputSubmit;

    procedure InputDate (id varchar2, nome varchar2) is /*Input di tipo calendario*/
    begin
        htp.prn('<input class="w3-margin w3-round-large" type="date" id="'|| id ||'" name="'|| nome ||'" value="2020-09-09" min="2020-01-01" max="2030-12-31" required>');
    end InputDate;

    procedure InputTime (id varchar2, nome varchar2) is /*Input di tipo orario*/
    begin
        htp.prn('<input type="time" id="'|| id ||'" name="'|| nome ||'" min="09:00" max="18:00" required>');
    end InputTime;

    procedure SelectOpen(nome varchar2 default 'mySelect') is
    begin
        htp.prn('<select class="w3-select w3-border w3-round" style="max-width:150px;" name="'|| nome ||'">');
    end SelectOpen;

    procedure SelectOption(valore int, testo varchar2 default 'Opzione') is
    begin
        htp.prn('<option value="' ||valore|| '">'|| testo ||'</option>');
    end SelectOption;

    procedure SelectClose is
    begin
        htp.prn('</select>');
    end SelectClose;
    
    procedure InputRadioButton (testo varchar2, nome varchar2, valore varchar2, checked int default 0, disabled int default 0) is
    begin    
        htp.print('<input class="w3-radio" type="radio" name="'|| nome ||'" value="'|| valore ||'"');
        if (checked=1)
        then
            htp.prn(' checked');
        end if;
        if (disabled=1)
        then 
            htp.prn(' disabled');
        end if;
        htp.prn('>');
        htp.prn(testo);
    end InputRadioButton;

    procedure InputCheckbox (testo varchar2, nome varchar2, checked int default 0, disabled int default 0) is
    begin    
        htp.print('<input class="w3-check" type="checkbox" name="'|| nome ||'"');
        if (checked=1)
        then
            htp.prn(' checked');
        end if;
        if (disabled=1)
        then 
            htp.prn(' disabled');
        end if;
        htp.prn('>');
        htp.prn(testo);
    end InputCheckbox;

end modGUI1;