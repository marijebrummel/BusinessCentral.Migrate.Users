table 88890 "PTE Dynamics NAV Perm. Set"
{
    DataClassification = ToBeClassified;
    Caption = 'Dynamics NAV Permission Set';

    fields
    {
        field(1; "Full Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Permission Set"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Exists in Business Central"; Boolean)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = exist("Aggregate Permission Set" where("Role ID" = field("Permission Set")));
        }
    }

    keys
    {
        key(PK; "Full Name", "Permission Set")
        {
            Clustered = true;
        }
    }


}