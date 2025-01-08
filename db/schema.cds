using {
    cuid,
    managed,
    sap.common.CodeList
} from '@sap/cds/common';

namespace hr.candidates;

entity Candidates : cuid, managed {
    firstName         : String(50);
    lastName          : String(50);
    birthDate         : Date;
    city              : String(100);
    email             : String(100);
    department        : Association to Departments;
    contractType      : Association to ContractType;
    reportsTo         : Association to Employees;
    preferredLanguage : Association to Languages;
    startDate         : Date;
    seniority         : Integer;
    status            : Association to Status default 'I';
}

// Entity voor Afdelingen
entity Departments : cuid, managed {
    code        : String(10);
    description : String(100);
    maxRound   : Integer;
    
}

// Entity voor Contracttypen (gebruikt als codelijst)
entity ContractType : cuid, managed {
    code        : String(10);
    description : String(100)

}


// Entity voor Medewerkers
entity Employees : cuid, managed {
    name       : String(100);
    email      : String(100);
    department : Association to one Departments;
}

entity Languages : cuid, managed {
    code        : String(10);
    description : String(100)
}


entity Status : CodeList {
    key code        : String enum {
            submitted = 'I';
            approved  = 'G';
            rejected  = 'A';


        };
        criticality : Integer;
}
