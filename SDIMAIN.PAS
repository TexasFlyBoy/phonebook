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
  private
    { Private declarations }
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

procedure TSDIAppForm.ADODataSet1AfterScroll(DataSet: TDataSet);
begin
    sbDbGrid.Panels[0].Text := 'Record ' + IntToStr(DataSet.RecNo) + ' of ' + IntToStr(DataSet.RecordCount);
end;

procedure TSDIAppForm.FileExit1Execute(Sender: TObject);
begin
  Close;
end;

procedure TSDIAppForm.HelpAbout1Execute(Sender: TObject);
begin
  AboutBox.ShowModal;
end;

end.
