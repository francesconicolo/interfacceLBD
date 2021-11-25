CREATE OR REPLACE package PackageStanze as

procedure visualizzaSale (idSessione IN int default 0);
procedure visualizzaAmbientiServizio (idSessione IN int default 0);
PROCEDURE formSala (
        modifica IN NUMBER default 0,
        varSalaMuseo IN NUMBER default NULL,
        varSalaNome VARCHAR2 default NULL,
        varSalaDimensione NUMBER default NULL,
        varSalaTipo NUMBER default NULL,
        varSalaOpere NUMBER default NULL
        );
PROCEDURE inserisciSala (
        selectMusei IN musei.idmuseo%TYPE,
        nomeSala       IN  VARCHAR2,
        dimSala            IN  NUMBER,
        tipoSalaform         IN  NUMBER,
        nOpereform           IN NUMBER
    );
procedure formAmbienteServizio (
        modifica IN NUMBER default 0,
        varASMuseo IN NUMBER default NULL,
        varASNome VARCHAR2 default NULL,
        varASDimensione NUMBER default NULL,
        varASTipo VARCHAR2 default NULL
    );
PROCEDURE inserisciAmbienteServizio (
        selectMusei IN musei.idmuseo%TYPE,
        nomeSala       IN  VARCHAR2,
        dimSala            IN  NUMBER,
        tipoAmbienteForm   IN VARCHAR2
    );
end PackageStanze;