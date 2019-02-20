unit SDIMAIN;

interface

uses Winapi.Windows, System.Classes, Vcl.Graphics, Vcl.Forms, Vcl.Controls,
  Vcl.Menus, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.ImgList, Vcl.StdActns, Vcl.ActnList, Vcl.ToolWin, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.DBCtrls, Data.Win.ADODB, System.ImageList, System.Actions,
  SysUtils;

type
  TSDIAppForm = class(TForm)
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    ToolBar1: TToolBar;
    ToolButton9: TToolButton;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ActionList1: TActionList;
    FileNew1: TAction;
    FileOpen1: TAction;
    FileSave1: TAction;
    FileSaveAs1: TAction;
    FileExit1: TAction;
    EditCut1: TEditCut;
    EditCopy1: TEditCopy;
    EditPaste1: TEditPaste;
    HelpAbout1: TAction;
    sbDbGrid: TStatusBar;
    ImageList1: TImageList;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    FileNewItem: TMenuItem;
    FileOpenItem: TMenuItem;
    FileSaveItem: TMenuItem;
    FileSaveAsItem: TMenuItem;
    N1: TMenuItem;
    FileExitItem: TMenuItem;
    Edit1: TMenuItem;
    CutItem: TMenuItem;
    CopyItem: TMenuItem;
    PasteItem: TMenuItem;
    Help1: TMenuItem;
    HelpAboutItem: TMenuItem;
    ADOConnection1: TADOConnection;
    ADODataSet1: TADODataSet;
    DataSource1: TDataSource;
    ADODataSet1ID: TAutoIncField;
    ADODataSet1firstName: TWideStringField;
    ADODataSet1lastName: TWideStringField;
    ADODataSet1businessName: TWideStringField;
    ADODataSet1department: TWideStringField;
    ADODataSet1title: TWideStringField;
    ADODataSet1phone1: TWideStringField;
    ADODataSet1phone2: TWideStringField;
    ADODataSet1mobile1: TWideStringField;
    ADODataSet1mobile2: TWideStringField;
    ADODataSet1address: TWideStringField;
    ADODataSet1email1: TWideStringField;
    ADODataSet1email2: TWideStringField;
    ADODataSet1website1: TWideStringField;
    ADODataSet1website2: TWideStringField;
    ADODataSet1comments: TWideMemoField;
    DBNavigator1: TDBNavigator;
    ImageList2: TImageList;
    pnlSearch: TPanel;
    eFirst: TEdit;
    eLast: TEdit;
    eBusiness: TEdit;
    eDept: TEdit;
    ePhone: TEdit;
    eAddress: TEdit;
    bbFirst: TBitBtn;
    bbLast: TBitBtn;
    bbBusiness: TBitBtn;
    bbDept: TBitBtn;
    bbPhone: TBitBtn;
    bbAddress: TBitBtn;
    pnlDbGrid: TPanel;
    DBGrid1: TDBGrid;
    procedure FileNew1Execute(Sender: TObject);
    procedure FileOpen1Execute(Sender: TObject);
    procedure FileSave1Execute(Sender: TObject);
    procedure FileExit1Execute(Sender: TObject);
    procedure HelpAbout1Execute(Sender: TObject);
    procedure ADODataSet1AfterScroll(DataSet: TDataSet);
    procedure ADODataSet1BeforeEdit(DataSet: TDataSet);
    procedure ADODataSet1AfterEdit(DataSet: TDataSet);
    procedure bbSort_Click(Sender: TObject);
    procedure eFirstChange(Sender: TObject);
    procedure eLastChange(Sender: TObject);
    procedure eBusinessChange(Sender: TObject);
    procedure eDeptChange(Sender: TObject);
    procedure ePhoneChange(Sender: TObject);
    procedure eAddressChange(Sender: TObject);
  private
    { Private declarations }
    procedure ClearEdits;
    procedure WhiteEdits;
    procedure SortColumnMod(DataSet: TADODataSet; IndexFieldName: string;
      PushButton: TBitBtn); overload;
    procedure SortColumnMod(DataTable: TADOTable; IndexFieldName: string;
      PushButton: TBitBtn); overload;
    procedure SortButtonClear;
    procedure TEditChange(filterText: string);

  public
    { Public declarations }
  end;

var
  SDIAppForm: TSDIAppForm;

implementation

uses About;

{$R *.dfm}

procedure TSDIAppForm.FileNew1Execute(Sender: TObject);
begin
  { Do nothing }
end;

procedure TSDIAppForm.FileOpen1Execute(Sender: TObject);
begin
  OpenDialog.Execute;
end;

procedure TSDIAppForm.FileSave1Execute(Sender: TObject);
begin
  SaveDialog.Execute;
end;

procedure TSDIAppForm.ADODataSet1AfterEdit(DataSet: TDataSet);
begin
  DBGrid1.Options := DBGrid1.Options + [dgRowSelect] - [dgEditing];
end;

procedure TSDIAppForm.ADODataSet1AfterScroll(DataSet: TDataSet);
begin
    sbDbGrid.Panels[0].Text := 'Record ' + IntToStr(DataSet.RecNo) + ' of ' + IntToStr(DataSet.RecordCount);
end;


procedure TSDIAppForm.ADODataSet1BeforeEdit(DataSet: TDataSet);
begin
  DBGrid1.Options := DBGrid1.Options - [dgRowSelect] + [dgEditing];
end;

//********************************************************************************}


procedure TSDIAppForm.SortColumnMod(DataSet: TADODataSet; IndexFieldName: string;
  PushButton: TBitBtn);
begin
  DataSet.Filtered := False;
  DataSet.Filter := '';
  DataSet.Active := False;
  PushButton.Glyph.Assign(nil);
  if ((PushButton.Tag Mod 2) = 1) then
  begin
    DataSet.IndexFieldNames := IndexFieldName + ' ASC';
    ImageList2.GetBitmap(1, PushButton.Glyph);
    PushButton.Tag := PushButton.Tag - 1;
  end
  else
  begin
    DataSet.IndexFieldNames := IndexFieldName + ' DESC';
    ImageList2.GetBitmap(0, PushButton.Glyph);
    PushButton.Tag := PushButton.Tag + 1;
  end;
  DataSet.Filtered := True;
  DataSet.Active := True;
  sbDbGrid.Panels[1].Text := DataSet.IndexFieldNames;
end;

procedure TSDIAppForm.SortColumnMod(DataTable: TADOTable; IndexFieldName: string;
  PushButton: TBitBtn);
begin
  DataTable.Filtered := False;
  PushButton.Glyph.Assign(nil);
  if ((PushButton.Tag Mod 2) = 1) then
  begin
    DataTable.IndexFieldNames := IndexFieldName + ' ASC';
    ImageList2.GetBitmap(1, PushButton.Glyph);
    PushButton.Tag := PushButton.Tag - 1; // := 0;
  end
  else
  begin
    DataTable.IndexFieldNames := IndexFieldName + ' DESC';
    ImageList2.GetBitmap(0, PushButton.Glyph);
    PushButton.Tag := PushButton.Tag + 1; // := 1;
  end;
  DataTable.Filtered := True;
  sbDbGrid.Panels[1].Text := DataTable.IndexFieldNames;
end;

{ ----------------------------------------------------------------------+
  bbSort_Click(Sender: TObject):
  This is a generic procedure to apply a sort criterium to a
  TAdoDataSet. It takes the following arguments:

  TObject: The object is the speedButton that was pressed. The tag is
  an even/odd number combination designating the field to be sorted.;

  Notice that the sort is toggled between ASCENDING and DESCENDING
  by use of the TAG property of the TSpeedButton.
+----------------------------------------------------------------------- }
procedure TSDIAppForm.bbSort_Click(Sender: TObject);
var
  sortButton: Integer;
begin
  sortButton := TSpeedButton(Sender).Tag;
  SortButtonClear;
  case sortButton of
    0, 1: SortColumnMod(ADODataSet1, 'firstName', Sender as TBitBtn);
    2, 3: SortColumnMod(ADODataSet1, 'lastName', Sender as TBitBtn);
    4, 5: SortColumnMod(ADODataSet1, 'businessName', Sender as TBitBtn);
    6, 7: SortColumnMod(ADODataSet1, 'department', Sender as TBitBtn);
    8, 9: SortColumnMod(ADODataSet1, 'phone1', Sender as TBitBtn);
    10, 11: SortColumnMod(ADODataSet1, 'address', Sender as TBitBtn);
  end;
end;

{ ----------------------------------------------------------------------+
  SortButtonClear:
  Remove the glyphs from all the bitbuttons
  +----------------------------------------------------------------------- }
procedure TSDIAppForm.SortButtonClear;
begin
  bbFirst.Glyph.Assign(nil);
  bbLast.Glyph.Assign(nil);
  bbBusiness.Glyph.Assign(nil);
  bbDept.Glyph.Assign(nil);
  bbPhone.Glyph.Assign(nil);
  bbAddress.Glyph.Assign(nil);
end;

{ ----------------------------------------------------------------------+
  TeditChange:
  This procedure is called when the user changes the search TEdit
  boxes. It changes the filters to the dbGrid. It also updates the
  status bars.
+----------------------------------------------------------------------- }
procedure TSDIAppForm.TEditChange(filterText: string);
var
  numOfRecords: Integer;
begin
  if (length(filterText) = 0) then
  begin
    ADODataSet1.Filter := '';
    ADODataSet1.Filtered := True;
    ADODataSet1.Filter := '';
    ADODataSet1.Filtered := True;
  end
  else
  begin
    ADODataSet1.Filtered := False;
    ADODataSet1.Filter := filterText;
    ADODataSet1.Filtered := True;
  end;
  sbDbGrid.Panels[0].Text := filterText;
  numOfRecords := ADODataSet1.RecordCount;
  sbDbGrid.Panels[1].Text := 'Record Count: ' + IntToStr(numOfRecords);
end;



//********************************************************************

procedure TSDIAppForm.ClearEdits;
begin
  eFirst.Text    := '';
  eLast.Text     := '';
  eBusiness.Text := '';
  eDept.Text     := '';
  ePhone.Text    := '';
  eAddress.Text  := '';
end;

procedure TSDIAppForm.eAddressChange(Sender: TObject);
var
  filterText: string;
begin
  filterText := '';
  if (length(eAddress.Text) > 0) then
    filterText := 'address like ' + '''' + eAddress.Text +
      '%' + '''';
  TEditChange(filterText);
end;

procedure TSDIAppForm.eBusinessChange(Sender: TObject);
var
  filterText: string;
begin
  filterText := '';
  if (length(eBusiness.Text) > 0) then
    filterText := 'businessName like ' + '''' + eBusiness.Text +
      '%' + '''';
  TEditChange(filterText);
end;

procedure TSDIAppForm.eDeptChange(Sender: TObject);
var
  filterText: string;
begin
  filterText := '';
  if (length(eDept.Text) > 0) then
    filterText := 'department like ' + '''' + eDept.Text +
      '%' + '''';
  TEditChange(filterText);
end;

procedure TSDIAppForm.eFirstChange(Sender: TObject);
var
  filterText: string;
begin
  filterText := '';
  if (length(eFirst.Text) > 0) then
    filterText := 'firstName like ' + '''' + eFirst.Text +
      '%' + '''';
  TEditChange(filterText);
end;

procedure TSDIAppForm.eLastChange(Sender: TObject);
var
  filterText: string;
begin
  filterText := '';
  if (length(eLast.Text) > 0) then
    filterText := 'lastName like ' + '''' + eLast.Text +
      '%' + '''';
  TEditChange(filterText);
end;

procedure TSDIAppForm.ePhoneChange(Sender: TObject);
var
  filterText: string;
begin
  filterText := '';
  if (length(ePhone.Text) > 0) then
    filterText := 'phone1 like ' + '''' + ePhone.Text +
      '%' + '''';
  TEditChange(filterText);
end;

procedure TSDIAppForm.FileExit1Execute(Sender: TObject);
begin
  Close;
end;

procedure TSDIAppForm.HelpAbout1Execute(Sender: TObject);
begin
  AboutBox.ShowModal;
end;

procedure TSDIAppForm.WhiteEdits;
begin
  eFirst.Color    := clWindow;
  eLast.Color     := clWindow;
  eBusiness.Color := clWindow;
  eDept.Color     := clWindow;
  ePhone.Color    := clWindow;
  eAddress.Color  := clWindow;
end;

end.
