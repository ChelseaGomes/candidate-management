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
                Label : '{i18n>Achernaam}',
                Value : lastName,
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>Geboortedatum}',
                Value : birthDate,
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>Woonplaats}',
                Value : city,
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>Email}',
                Value : email,
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : '{i18n>AlgemeneInformatie1}',
            Target : '@UI.FieldGroup#GeneratedGroup',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>DetailsKandidaat}',
            ID : 'i18nDetailsKandidaat',
            Target : '@UI.FieldGroup#i18nDetailsKandidaat',
        },
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Label : '{i18n>Voornaam}',
            Value : firstName,
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>Achternaam}',
            Value : lastName,
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>Geboortedatum}',
            Value : birthDate,
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>Woonplaats}',
            Value : city,
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>Email}',
            Value : email,
        },
        {
            $Type : 'UI.DataField',
            Value : status_code,
            Label : 'Status',
            Criticality : status.criticality,
            CriticalityRepresentation : #WithIcon,
        },
    ],
    UI.SelectionPresentationVariant #table : {
        $Type : 'UI.SelectionPresentationVariantType',
        PresentationVariant : {
            $Type : 'UI.PresentationVariantType',
            Visualizations : [
                '@UI.LineItem',
            ],
        },
        SelectionVariant : {
            $Type : 'UI.SelectionVariantType',
            SelectOptions : [
            ],
        },
    },
    UI.SelectionFields : [
        firstName,
        lastName,
        email,
        status.descr,
        reportsTo_ID,
        contractType_ID,
    ],
    UI.HeaderInfo : {
        Title : {
            $Type : 'UI.DataField',
            Value : firstName,
        },
        TypeName : '',
        TypeNamePlural : '',
        Description : {
            $Type : 'UI.DataField',
            Value : department.description,
        },
        ImageUrl : contractType.description,
        TypeImageUrl : 'sap-icon://person-placeholder',
    },
    UI.FieldGroup #i18nDetailsKandidaat : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : department_ID,
                Label : '{i18n>Afdeling}',
            },
            {
                $Type : 'UI.DataField',
                Value : contractType_ID,
            },
            {
                $Type : 'UI.DataField',
                Value : reportsTo_ID,
            },
            {
                $Type : 'UI.DataField',
                Value : preferredLanguage_ID,
                Label : '{i18n>Voorkeurstaal}',
            },
            {
                $Type : 'UI.DataField',
                Value : startDate,
                Label : '{i18n>Startdatum}',
            },
            {
                $Type : 'UI.DataField',
                Value : seniority,
                Label : '{i18n>AncinniteitInJaren}',
            },
        ],
    },
    UI.SelectionPresentationVariant #table1 : {
        $Type : 'UI.SelectionPresentationVariantType',
        PresentationVariant : {
            $Type : 'UI.PresentationVariantType',
            Visualizations : [
                '@UI.LineItem',
            ],
            SortOrder : [
                {
                    $Type : 'Common.SortOrderType',
                    Property : createdAt,
                    Descending : true,
                },
            ],
        },
        SelectionVariant : {
            $Type : 'UI.SelectionVariantType',
            SelectOptions : [
            ],
        },
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
                    LocalDataProperty : department_ID,
                    ValueListProperty : 'ID',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'code',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'description',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'maxRound',
                },
            ],
        Label : '{i18n>Afdeling}',
        },
        Common.ValueListWithFixedValues : false,
        Common.Text : {
            $value : department.description,
            ![@UI.TextArrangement] : #TextOnly,
        },
    )
};

annotate service.Candidates with {
    contractType @(
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'ContractType',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : contractType_ID,
                    ValueListProperty : 'ID',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'description',
                },
            ],
            Label : '{i18n>Contracttype}',
        },
        Common.Label : '{i18n>ContractType}',
        Common.ValueListWithFixedValues : true,
        Common.Text : {
            $value : contractType.description,
            ![@UI.TextArrangement] : #TextOnly,
        },
    )
};

annotate service.Candidates with {
    reportsTo @(
        Common.ValueList : {
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
                    ValueListProperty : 'department/description',
                },
            ],
            Label : '{i18n>RapporteertNaar}',
        },
        Common.Label : '{i18n>RapporteertNaar}',
        Common.ValueListWithFixedValues : true,
        Common.Text : {
            $value : reportsTo.name,
            ![@UI.TextArrangement] : #TextOnly,
        },
    )
};

annotate service.Candidates with {
    preferredLanguage @(
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Languages',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : preferredLanguage_ID,
                    ValueListProperty : 'ID',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'code',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'description',
                },
            ],
        },
        Common.Text : {
            $value : preferredLanguage.description,
            ![@UI.TextArrangement] : #TextOnly
        },
    )
};

annotate service.Candidates with {
    status @(Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Candidates',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : status_code,
                    ValueListProperty : 'status_code',
                },
            ],
            Label : '{i18n>Status}',
        },
        Common.ValueListWithFixedValues : true,
        Common.Label : '{i18n>Status}',
        Common.Text : status.descr,
)};

annotate service.Candidates with {
    firstName @(
        Common.Label : '{i18n>Voornaam}',
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Candidates',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : firstName,
                    ValueListProperty : 'firstName',
                },
            ],
            Label : '{i18n>Voornaam}',
        },
        Common.ValueListWithFixedValues : false,
    )
};

annotate service.Candidates with {
    lastName @(
        Common.Label : '{i18n>Achternaam}',
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Candidates',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : lastName,
                    ValueListProperty : 'lastName',
                },
            ],
            Label : '{i18n>Achternaam}',
        },
        Common.ValueListWithFixedValues : false,
    )
};

annotate service.Candidates with {
    email @(
        Common.Label : '{i18n>Email}',
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Candidates',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : email,
                    ValueListProperty : 'email',
                },
            ],
            Label : '{i18n>Email}',
        },
        Common.ValueListWithFixedValues : false,
    )
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
            Label : '{i18n>Status}',
        },
        Common.ValueListWithFixedValues : true,
    )
};

annotate service.Status with {
    name @Common.Text : {
        $value : descr,
        ![@UI.TextArrangement] : #TextOnly
    }
};

annotate service.Employees with {
    ID @Common.Text : {
        $value : name,
        ![@UI.TextArrangement] : #TextOnly,
    }
};

annotate service.ContractType with {
    ID @Common.Text : {
        $value : description,
        ![@UI.TextArrangement] : #TextOnly
    }
};

annotate service.Status with {
    code @Common.Text : {
        $value : descr,
        ![@UI.TextArrangement] : #TextOnly,
    }
};

annotate service.Departments with {
    ID @Common.Text : {
        $value : description,
        ![@UI.TextArrangement] : #TextOnly,
    }
};

