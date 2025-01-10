using hr.candidates as m from '../db/schema';

service CandidateService {
   entity Candidates as projection on m.Candidates;
    entity Departments as projection on m.Departments;
    entity Employees as projection on m.Employees;
    entity Languages as projection on m.Languages;
    entity ContractType as projection on m.ContractType;
    entity Status as projection on m.Status;

    action TriggerBusinessProcess(Context: BusinessProcessContext) returns String; 
    type BusinessProcessContext{}
}
