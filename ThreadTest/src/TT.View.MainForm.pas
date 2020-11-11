unit TT.View.MainForm;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,

  OtlCommon,
  OtlCollections,
  OtlTask,
  OtlParallel;

type
  TMainForm = class(TForm)
    ListMemo: TMemo;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FSr: TSearchRec;
    FFindTask: IOmniParallelTask;
    procedure FindFiles;
    function GetFileAttrs: Integer;
  public
    { Public declarations }
  end;

procedure SleepAndProcess(ATimeout: Cardinal = 50);

var
  MainForm: TMainForm;

implementation

procedure SleepAndProcess(ATimeout: Cardinal = 50);
begin
  Sleep(ATimeout);
  Application.ProcessMessages;
end;

{$R *.dfm}

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //FFindTask._Release;
  FindClose(FSr);
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  ListMemo.Lines.Clear;

  FFindTask := Parallel.ParallelTask.Execute(FindFiles).NoWait;
end;

procedure TMainForm.FindFiles;
begin
  FindFirst('..\files\*.txt', GetFileAttrs, FSr);
  with ListMemo.Lines do
    while True do
    begin
      if FindNext(FSr) = 0 then
        Add(FSr.Name);
      SleepAndProcess;
    end;
end;

function TMainForm.GetFileAttrs: Integer;
begin
  Result := faReadOnly + faHidden + faSysFile + faVolumeID + faDirectory
    + faArchive + faAnyFile;
end;

end.
