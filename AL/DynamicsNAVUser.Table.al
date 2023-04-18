table 88888 "PTE Dynamics NAV User"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Full Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Activated in Business Central"; Boolean)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = exist(User where("Full Name" = field("Full Name")));
        }
    }

    keys
    {
        key(PK; "Full Name")
        {
            Clustered = true;
        }
    }

    procedure AssignPermission()
    var
        User: Record User;
        AccessControl: Record "Access Control";
        NAVPermissionSet: Record "PTE Dynamics NAV Perm. Set";
        PermissionSetBuffer: Record "Permission Set Buffer" temporary;
    begin
        PermissionSetBuffer.FillRecordBuffer();
        User.SetRange("Full Name", Rec."Full Name");
        User.FindFirst();
        NAVPermissionSet.SetRange("Full Name", Rec."Full Name");
        NAVPermissionSet.FindSet();
        repeat
            PermissionSetBuffer.SetRange("Role ID", NAVPermissionSet."Permission Set");
            if PermissionSetBuffer.FindFirst() then begin
                AccessControl."User Security ID" := User."User Security ID";
                AccessControl."Role ID" := NAVPermissionSet."Permission Set";
                AccessControl."Company Name" := '';
                AccessControl."App ID" := PermissionSetBuffer."App ID";
                AccessControl.Insert();
            end;
        until NAVPermissionSet.Next() = 0;
    end;

    procedure ReadFromCSV()
    var
        TempBlob: Codeunit "Temp Blob";
        InsStr: InStream;
        Permissions: List of [Text];
        FileName, UserWithPermissions : Text;
    begin
        TempBlob.CreateInStream(InsStr);
        UploadIntoStream('Select file', '', '', FileName, InsStr);
        while not InsStr.EOS do begin
            InsStr.ReadText(UserWithPermissions);
            Permissions := UserWithPermissions.Split(';');
            "Full Name" := Permissions.Get(1);
            if "Full Name" <> '' then
                if Insert() then
                    CreatePermissions(Permissions);
        end;
    end;

    local procedure CreatePermissions(Permissions: List of [Text])
    var
        NAVPermissionSet: Record "PTE Dynamics NAV Perm. Set";
        Permission: Text;
    begin
        if Permissions.Get(1) = '' then
            exit;
        foreach Permission in Permissions do
            if Permission <> Permissions.Get(1) then begin
                NAVPermissionSet."Full Name" := "Full Name";
                NAVPermissionSet."Permission Set" := Permission;
                if NAVPermissionSet.Insert() then;
            end;
    end;
}