using { cuid, managed, sap.common.CodeList } from '@sap/cds/common';
namespace hr.candidates; 

entity Candidates {
    key ID              : UUID;
    firstName           : String(50);
    lastName            : String(50);
    birthDate           : Date;
    city                : String(100);
    email               : String(100);
    department          : Association to Departments;
    contractType        : Association to ContractType;
    reportsTo           : Association to Employees;
    preferredLanguage   : Association to Languages; 
    startDate           : Date;
    seniority           : Integer;
    status              : Association to Status
        @UI.LineItem: [
            {
                Value: status.text,
                Icon: 'criticalityIcon',
                Criticality: status.criticality,
                Label: 'Status'
            }
        ];
}

// Entity voor Afdelingen
entity Departments : managed {
    key code            : String(10);
    description         : String(100);
    maxRound1           : Integer;
    maxRound2           : Integer;
}

// Entity voor Contracttypen (gebruikt als codelijst)
entity ContractType : CodeList {
    key code            : String enum {
        fulltime ='Full Time';
        fourfifth ='4/5'; 
        treefifth='3/5';
        half = 'Halftijds';
        intern= 'Stage';
    }
}

// Entity voor Medewerkers
entity Employees : cuid, managed {
    name                : String(100);
    email               : String(100);
    department          : Association to one Departments;
}

entity Languages : CodeList {
    key code            : String enum {
        english= 'EN'; 
        dutch='NL';
        german= 'DE';
        french ='FR'
        
        
    }
}

entity Status : CodeList {
    key code : String(10);
    text: String(50);
    criticality: Integer;
}