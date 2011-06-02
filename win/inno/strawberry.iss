; -- demeter_and_strawberry_perl.iss --

; SEE THE DOCUMENTATION FOR DETAILS ON CREATING .ISS SCRIPT FILES!
; using ISC 5.4.2(a)

; TODO: Restrict the installation path to have  no non-ascii characters in the path
; TODO: do we need to set Environment variable other than Path ? e.g. file extension mapping?
; TODO: Add alot more menu items that the original Strawberry also adds
; TODO: add License  LicenseFile
; TODO: add README   InfoAfterFile
; TODO: check for other perl installations (eg. in the Path variable) and warn or even abort if there is another one

[Setup]
AppName=Demeter and Strawberry Perl
AppVersion=0.01
DefaultDirName=\strawberry
DefaultGroupName=Demeter and Strawberry Perl
; UninstallDisplayIcon={app}\MyProg.exe
Compression=lzma2
SolidCompression=yes
SourceDir=c:\strawberry
OutputDir=c:\output
OutputBaseFilename=demeter-and-strawberry-perl
AppComments=XAS Data Processing and Analysis
AppContact=http://bruceravel.github.com/demeter/
AppCopyright=Demeter is copyright (c) 2006-2011 Bruce Ravel, Perl is copyright 1987-2010, Larry Wall
AppId=Strawberry_Perl_with_Demeter
; AppMutex= TODO!
AppPublisherURL=http://bruceravel.github.com/demeter/

ChangesAssociations=yes
ChangesEnvironment=yes

;LicenseFile=license.txt
;InfoAfterFile=README.txt




[Run]
Filename: "{app}\relocation.pl.bat";

[Registry]
Root: HKLM; Subkey: "SYSTEM\CurrentControlSet\Control\Session Manager\Environment"; \
    ValueName: "Path"; ValueType: expandsz; ValueData: "{olddata};{code:getPath}"; \
    Check: NeedsAddPath('\perl\site\bin');
; TODO: don't add the leading semi-colon to the Path if there is already a trailing one
Root: HKLM; Subkey: "SYSTEM\CurrentControlSet\Control\Session Manager\Environment"; ValueName: "PGPLOT_DIR"; ValueType: expandsz; ValueData: "{app}\c\lib\pgplot";
Root: HKLM; Subkey: "SYSTEM\CurrentControlSet\Control\Session Manager\Environment"; ValueName: "FONTCONFIG_FILE"; ValueType: expandsz; ValueData: "{app}\c\bin\etc\fonts\fonts.conf";

[Files]
Source: "*"; DestDir: "{app}"; Flags: "recursesubdirs"
; need this to not wrap up stuff in C:\strawberry\cpan   ; Excludes: "*.~*,\Temp\*";

[Tasks]
Name: "desktopicon"; Description: "Create &desktop icons"; GroupDescription: "Additional shortcuts:";

[Icons]
Name: "{group}\Athena"; Filename: "{app}\perl\site\bin\dathena.bat"; WorkingDir: "{app}"; IconFilename: "{app}\perl\site\lib\Demeter\UI\Athena\share\athena_icon.ico"
Name: "{group}\Artemis"; Filename: "{app}\perl\site\bin\dartemis.bat"; WorkingDir: "{app}"; IconFilename: "{app}\perl\site\lib\Demeter\UI\Artemis\share\artemis_icon.ico"
Name: "{group}\Hephaestus"; Filename: "{app}\perl\site\bin\dhephaestus.bat"; WorkingDir: "{app}"; IconFilename: "{app}\perl\site\lib\Demeter\UI\Hephaestus\icons\vulcan.ico"
;Name: "{group}\Atoms"; Filename: "{app}\perl\site\bin\datoms.bat"; Parameters: "--wx"; WorkingDir: "{app}"; IconFilename: "{app}\perl\site\lib\Demeter\UI\Atoms\icons\atoms.ico"
Name: "{group}\Uninstall"; Filename: "{app}\unins000.exe"
;Name: "{userdesktop}\Athena"; Filename: "{app}\perl\site\bin\dathena.bat"; WorkingDir: "{app}"; IconFilename: "{app}\perl\site\lib\Demeter\UI\Athena\share\athena_icon.ico"; Tasks: desktopicon
;Name: "{userdesktop}\Artemis"; Filename: "{app}\perl\site\bin\dartemis.bat"; WorkingDir: "{app}"; IconFilename: "{app}\perl\site\lib\Demeter\UI\Artemis\share\artemis_icon.ico"; Tasks: desktopicon
;Name: "{userdesktop}\Hephaestus"; Filename: "{app}\perl\site\bin\dhephaestus.bat"; WorkingDir: "{app}"; IconFilename: "{app}\perl\site\lib\Demeter\UI\Hephaestus\icons\vulcan.ico"; Tasks: desktopicon

[Code]
function getPath(Param: String): string;
begin
  Result := ExpandConstant('{app}') + '\perl\bin;' + ExpandConstant('{app}') + '\perl\site\bin;' + ExpandConstant('{app}') + '\c\bin;'
end;

// From http://stackoverflow.com/questions/3304463/how-do-i-modify-the-path-environment-variable-when-running-an-inno-setup-installe
function NeedsAddPath(Param: string): boolean;
var
  OrigPath: string;
begin
  if not RegQueryStringValue(HKEY_LOCAL_MACHINE,
    'SYSTEM\CurrentControlSet\Control\Session Manager\Environment',
    'Path', OrigPath)
  then begin
    Result := True;
    exit;
  end;
  // look for the path with leading and trailing semicolon
  // Pos() returns 0 if not found
  //Result := Pos(';' + ExpandConstant('{app}') + Param + ';', OrigPath) = 0;
  Result := Pos(getPath(''), OrigPath) = 0;
end;

function RemovePath(): boolean;
var
  OrigPath: string;
  start_pos: Longint;
  end_pos: Longint;
  new_str: string;
begin
  if not RegQueryStringValue(HKEY_LOCAL_MACHINE,
    'SYSTEM\CurrentControlSet\Control\Session Manager\Environment',
    'Path', OrigPath)
  then begin
    Result := True;
    exit;
  end;
  start_pos  := Pos(getPath(''), OrigPath);
  end_pos    := start_pos + Length(getPath(''));
  new_str    := Copy(OrigPath, 0, start_pos-1) + Copy(OrigPath, end_pos, Length(OrigPath));
  RegWriteExpandStringValue(HKEY_LOCAL_MACHINE,
    'SYSTEM\CurrentControlSet\Control\Session Manager\Environment',
    'Path', new_str);
  Result := True;
end;
function InitializeUninstall(): Boolean;
begin
  Result := True;
//  Result := MsgBox('InitializeUninstall:' #13#13 'Uninstall is initializing. Do you really want to start Uninstall?', mbConfirmation, MB_YESNO) = idYes;
//  if Result = False then
//    MsgBox('InitializeUninstall:' #13#13 'Ok, bye bye.', mbInformation, MB_OK);
  RemovePath();  
end;
// C:\Program Files\CollabNet\Subversion Client;%SystemRoot%\system32;%SystemRoot%;%SystemRoot%\System32\Wbem;C:\strawberry\c\bin;C:\strawberry\perl\site\bin;C:\strawberry\perl\bin;;C:\Str\perl\bin;C:\Str\perl\site\bin;C:\Str\c\bin;d:\;


// Restrict the installation path to have no space 
function NextButtonClick(CurPageID: Integer): Boolean;
begin
  Result :=True;
  case CurPageID of
    wpSelectDir :
    begin
    if Pos(' ', ExpandConstant('{app}') ) <> 0 then
      begin
        MsgBox('You cannot install to a path containing spaces. Please select a different path.', mbError, mb_Ok);
        Result := False;
      end;
    end;
  end;
end;