program text3d;

{$mode objfpc}{$H+}

uses
 {$IFDEF UNIX}
  cthreads,
     {$ENDIF} {$IFDEF HASAMIGA}
  athreads,
     {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms,
  Unit1,
  ATStringProc_HtmlColor { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource := True;
  Application.Scaled := True;
  Application.Initialize;
  Application.CreateForm(Tfrmmain, frmmain);
  Application.Run;
end.
