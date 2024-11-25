using CandidateService as service from '../../srv/services';
annotate service.Candidates with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : '{i18n>Voornaam}',
                Value : firstName,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Achternaam',
                Value : lastName,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Geboortedatum',
                Value : birthDate,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Woonplaats',
                Value : city,
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>Emailadres}',
                Value : email,
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>Afdeling}',
                Value : department_code,
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>ContractType}',
                Value : contractType_code,
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>Voorkeurstaal}',
                Value : preferredLanguage_code,
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>Startdatum}',
                Value : startDate,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Anciënniteit (in jaren)',
                Value : seniority,
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>Status}',
                Value : status_code,
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : '{i18n>AlgemeneInformatie}',
            Target : '@UI.FieldGroup#GeneratedGroup',
        },
        {
            $Type : 'UI.CollectionFacet',
            Label : '{i18n>Details}',
            ID : 'i18nDetails',
            Facets : [
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : '{i18n>Leidinggevende}',
                    ID : 'Form',
                    Target : '@UI.FieldGroup#Form',
                },
            ],
        },
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : firstName,
        },
        {
            $Type : 'UI.DataField',
            Value : lastName,
        },
        {
            $Type : 'UI.DataField',
            Value : seniority,
            Label : '{i18n>Ancinniteit}',
        },
        {
            $Type : 'UI.DataField',
            Value : status_code,
            Label : '{i18n>Status}',
            Criticality : status.criticality,
            CriticalityRepresentation : #WithIcon,
        },
        {
            $Type : 'UI.DataField',
            Value : department_code,
            Label : '{i18n>Afdeling}',
        },
        {
            $Type : 'UI.DataField',
            Value : contractType_code,
            Label : '{i18n>ContractType}',
        },
    ],
    UI.SelectionFields : [
        firstName,
        lastName,
        email,
        status.descr,
        reportsTo.name,
        contractType.descr,
    ],
    UI.HeaderInfo : {
        TypeName : '{i18n>KandidaatManagementApplicatie}',
        TypeNamePlural : '',
        Description : {
            $Type : 'UI.DataField',
            Value : firstName,
        },
        TypeImageUrl : 'sap-icon://person-placeholder',
    },
    UI.FieldGroup #Form : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : reportsTo.name,
                Label : '{i18n>Naam}',
            },
            {
                $Type : 'UI.DataField',
                Value : reportsTo.email,
                Label : '{i18n>Emailadres}',
            },
            {
                $Type : 'UI.DataField',
                Value : reportsTo.department_code,
                Label : '{i18n>Afdeling}',
            },
        ],
    },
);

annotate service.Candidates with {
    department @(
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Departments',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : department_code,
                    ValueListProperty : 'code',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'description',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'maxRound1',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'maxRound2',
                },
            ],
        },
        Common.Text : department.description,
    )
};

annotate service.Candidates with {
    reportsTo @Common.ValueList : {
        $Type : 'Common.ValueListType',
        CollectionPath : 'Employees',
        Parameters : [
            {
                $Type : 'Common.ValueListParameterInOut',
                LocalDataProperty : reportsTo_ID,
                ValueListProperty : 'ID',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'name',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'email',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'department_code',
            },
        ],
    }
};

annotate service.Candidates with {
    firstName @Common.Label : '{i18n>Voornaam}'
};

annotate service.Candidates with {
    lastName @Common.Label : '{i18n>Achternaam}'
};

annotate service.Candidates with {
    email @Common.Label : '{i18n>Email}'
};

annotate service.Employees with {
    name @Common.Label : '{i18n>RapporteertNaar}'
};

annotate service.Status with {
    descr @(
        Common.Label : '{i18n>Status}',
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Status',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : descr,
                    ValueListProperty : 'descr',
                },
            ],
        },
        Common.ValueListWithFixedValues : true,
    )
};

annotate service.ContractTypes with {
    descr @(
        Common.Label : '{i18n>ContractType}',
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'ContractTypes',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : descr,
                    ValueListProperty : 'descr',
                },
            ],
        },
        Common.ValueListWithFixedValues : true,
    )
};

annotate service.Candidates with {
    status @(Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Status',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : status_code,
                    ValueListProperty : 'descr',
                },
            ],
        },
        Common.ValueListWithFixedValues : true
)};

annotate service.Languages with {
    descr @Common.Text : code
};

annotate service.Candidates with {
    preferredLanguage @(Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Languages',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : preferredLanguage_code,
                    ValueListProperty : 'descr',
                },
            ],
        },
        Common.ValueListWithFixedValues : true,
        Common.Text : {
            $value : preferredLanguage.descr,
            ![@UI.TextArrangement] : #TextFirst
        },
)};

annotate service.Languages with {
    name @Common.Text : descr
};

annotate service.Employees with {
    department @(
        Common.Text : department.description,
        UI.MultiLineText : true,
    )
};

