MODULE StringList;
(* Oberon implementation without methods *)
IMPORT Files, Out, Strings, S := lDefs, List, strutils;

TYPE 

      TObject* = S.TObject;
  TObjectDesc* = S.TObjectDesc;
       pstring* = S.pstring;
       pstrings* = POINTER TO ARRAY OF pstring;
   
  TString* = POINTER TO TStringDesc;
  
  TStringDesc =RECORD (S.TObjectDesc)
      str* : pstring
  END;
   
     Node* = List.Node;
 NodeDesc* = List.NodeDesc;

      TList* = List.TList;

      TStringList* = POINTER TO TStringListDesc;

      TStringListDesc* = RECORD (List.TListDesc)
	 IndexOf* : PROCEDURE (VAR l : TStringList; s : ARRAY OF CHAR) : LONGINT;
       AddString* : PROCEDURE (l : TStringList; s : ARRAY OF CHAR) : LONGINT;
    AppendString* : PROCEDURE (l : TStringList; s : ARRAY OF CHAR);
       GetString* : PROCEDURE (l : TStringList; i: LONGINT): pstring;
       Dump*      : PROCEDURE (l : TStringList; name: ARRAY OF CHAR);
      END;

 PROCEDURE Copy*(VAR s, d: TString);
 BEGIN
   IF s.str # NIL THEN
     NEW(d);
     NEW(d.str, Strings.Length(s.str^)+1);
     COPY(s.str^, d.str^)
   END
 END Copy;

 PROCEDURE TStringFromString*(VAR s: ARRAY OF CHAR; VAR d: TString);
 BEGIN
   NEW(d);
   NEW(d.str, Strings.Length(s)+1);
   COPY(s, d.str^)
 END TStringFromString;

 PROCEDURE IndexOf*(VAR l : TStringList; s : ARRAY OF CHAR): LONGINT;
 VAR
   i : LONGINT;
   found : BOOLEAN;
   e : Node;
 BEGIN
   found := FALSE;
   NEW(e);
   e := l.First;
   i := 0;
    
   REPEAT
     IF strutils.Compare (s, e.obj(TString).str^) = strutils.equal THEN
       found := TRUE;	  
     ELSE
       e := e.next;       
       INC(i);
     END;
   UNTIL found OR (i = l.Count);
   IF found THEN
     RETURN i
   ELSE
     RETURN -1
   END
 END IndexOf;

 PROCEDURE GetString*(l : TStringList; i: LONGINT ): pstring;
 VAR
   e: Node;
   p: pstring;
 BEGIN
   e := l.Get(l, i);
   p := e.obj(TString).str;
   RETURN p
 END GetString;

 PROCEDURE AddString* (l : TStringList; s : ARRAY OF CHAR) : LONGINT;
    VAR str : TString;
    i : LONGINT;
 BEGIN
    NEW(str);
    NEW(str.str, Strings.Length(s)+1);
    COPY (s, str^.str^); (*str^.str^ := s;*)
    i := l.Add (l, str);
    RETURN i
 END AddString;
 
 PROCEDURE AppendString*(l : TStringList; s : ARRAY OF CHAR);
 VAR
   str : TString;
 BEGIN
    NEW(str);
    NEW(str.str, Strings.Length(s)+1);
    COPY (s, str^.str^); (*str^.str^ := s;*)
    l.Append (l, str);
 END AppendString;

PROCEDURE DumpOut*(VAR s : TStringList);
VAR e : Node;
    i : INTEGER;
BEGIN
   NEW(e);
   i := 0;
   REPEAT
      e := s.Get(s, i);
      IF e # NIL THEN Out.String (e.obj(TString).str^); Out.Ln END;
      (*Out.String (e.string); Out.Ln;*)
      INC(i);
   UNTIL i = s.Count;
END DumpOut;

 PROCEDURE Dump*(l: TStringList; name: ARRAY OF CHAR);
 VAR
   F : Files.File;
   R : Files.Rider;
   e : Node;
   i : INTEGER;
   eol: ARRAY 1 OF CHAR;
 BEGIN
   eol[0] := 0AX;
   F := Files.New(name); 
   Files.Set(R, F, 0);
   NEW(e);
   i := 0;
   REPEAT
     e := l.Get(l, i);
     IF e # NIL THEN
       Files.WriteBytes(R, e.obj(TString).str^, Strings.Length(e.obj(TString).str^));
       Files.WriteBytes(R, eol, 1);
     END;
     INC(i)
   UNTIL i = l.Count;
   Files.Register(F);
 END Dump;

 PROCEDURE Create* () : TStringList;
    VAR l : TStringList;
 BEGIN
    NEW(l);
    l.First   := NIL;
    l.Last    := NIL;
    l.Count   := 0;
    l.Add     := List.Add;
    l.Append  := List.Append;
    l.AppendList  := List.AppendList;
    l.Dump    := Dump;
    l.Clear   := List.Clear;
    l.Free    := List.Free;
    l.Insert  := List.Insert;
    l.Delete  := List.Delete;
    l.Empty   := List.Empty;
    l.Get     := List.Get;
    l.res     := TRUE;
  l.AddString := AddString;
l.AppendString:= AppendString;
  l.GetString := GetString;
    l.IndexOf := IndexOf;
    RETURN(l);
 END Create;

PROCEDURE StringListTopstrings*(VAR s: TStringList; VAR d: pstrings);
VAR
  e  : Node;
  i  : INTEGER;
BEGIN
  NEW(d, s.Count);
  i := 0;
  REPEAT
    e := s.Get(s, i);
    d[i] := e.obj(TString).str;
    INC(i)
  UNTIL i = s.Count;
END StringListTopstrings;

END StringList.
