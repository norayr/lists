MODULE TestStrutils;
IMPORT Out, strutils;

PROCEDURE tstExtractWord(i: INTEGER; s: strutils.string; ch: CHAR);
VAR
  ps: strutils.pstring;
BEGIN
  Out.String("strutils.ExtractWord(");
  Out.Int(i, 0);
  Out.String(", '");
  Out.String(s);
  Out.String("', '");
  Out.Char(ch);
  Out.String("') is ");
  ps := strutils.ExtractWord(i, s, ch);
  Out.String(ps^); Out.Ln;
END tstExtractWord;


PROCEDURE test;
VAR
  s0, s1: strutils.string;
  ps0, ps1: strutils.pstring;
  pstrs0 : strutils.pstrings;
  ch: CHAR;
  i : INTEGER;
BEGIN
  s0 := "manush";
  IF strutils.contains(s0, "manush") THEN
    Out.String("contains!"); Out.Ln;
  ELSE
    Out.String("doesn't contain."); Out.Ln;
  END;
  strutils.dumpChars(s0); Out.Ln;
  s0 := "aoeu,htns";
  ch := ",";
  i  := 2;
  Out.String("strutils.Pos('");
  Out.Char(ch); 
  Out.String("', '");
  Out.String(s0);
  Out.String("', ");
  Out.Int(i, 0);
  Out.String("); is ");
  i := strutils.Pos(ch, s0, i);
  Out.Int(i, 0); Out.Ln;

  s0 := "aoe#;,.#yes#snthd#,,,";
  ch := '#';
  i  := 1; tstExtractWord(i, s0, ch);
  i  := 3; tstExtractWord(i, s0, ch);
  i  := 5; tstExtractWord(i, s0, ch);
  
  Out.String("strutils.tokenize('");
  Out.String(s0);
  Out.String("', '");
  Out.Char(ch);
  Out.String("') is"); Out.Ln;
  pstrs0 := strutils.tokenize(s0, ch);
  FOR i := 0 TO SHORT(LEN(pstrs0^)-1) DO
    Out.String(pstrs0^[i]^); Out.Ln
  END;

END test;

BEGIN
  test
END TestStrutils.
