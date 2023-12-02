MODULE List;
(* Oberon implementation without methods *)

TYPE
     TObject* = POINTER TO TObjectDesc;
 TObjectDesc* = RECORD
   END;

        Node* = POINTER TO NodeDesc;
    NodeDesc* = RECORD
         obj* : TObject;
        next* : Node;
        prev* : Node;
    END;

       TList* = POINTER TO TListDesc;

   TListDesc* = RECORD (TObjectDesc)
      Create* : PROCEDURE () : TList;
        Free* : PROCEDURE (l : TList);
       Clear* : PROCEDURE (l : TList);
         Add* : PROCEDURE (l : TList; s : TObject) : LONGINT;
      Append* : PROCEDURE (l : TList; s : TObject);
  AppendList* : PROCEDURE (src, dst : TList);
      Insert* : PROCEDURE (l : TList; i : LONGINT; s : TObject);
      Delete* : PROCEDURE (l : TList; i : LONGINT);
  DeleteNode* : PROCEDURE (l : TList; n : Node): BOOLEAN;
       Empty* : PROCEDURE (l : TList) : BOOLEAN;
         Get* : PROCEDURE (l : TList; k : LONGINT) : Node;
First*, Last* : Node;
         res* : BOOLEAN;
       Count* : LONGINT;
   END;

 PROCEDURE Add* ( l : TList; s : TObject) : LONGINT;
 VAR
   e : Node;
 BEGIN
    l.res := FALSE;
    NEW(e);
    e.obj := s;
    e.prev := NIL;
    e.next := NIL;
    IF l.First = NIL THEN
       l.First := e;
       e.prev  := NIL
    ELSE
       e.prev := l.Last;
       l.Last.next := e;
    END;
    l.Last := e;
    l.Last.next := NIL;
    INC(l.Count);
    l.res := TRUE;
    RETURN (l.Count - 1);
 END Add;

 PROCEDURE Append* (l : TList; s : TObject);
 VAR e : Node;
 BEGIN
    l.res := FALSE;
    NEW(e);
    e.obj := s;
    e.prev := NIL;
    e.next := NIL;
    IF l.First = NIL THEN
       l.First := e;
       e.prev  := NIL;
    ELSE
       e.prev := l.Last;
       l.Last.next := e;
    END;
    l.Last := e;
    l.Last.next := NIL;
    INC(l.Count);
    l.res := TRUE
 END Append;

 PROCEDURE AppendList* (s, l : TList);
 VAR e : Node;
     i : LONGINT;
 BEGIN
   l.res := FALSE;
   IF s # NIL THEN
     i := 0;
     REPEAT
       e := s.Get(s, i);
       IF e # NIL THEN
         l.Append(l, e.obj);
       END;
       INC(i);
     UNTIL (i = s.Count) OR (e = NIL);
   END
 END AppendList;



 PROCEDURE Insert*(l : TList; i : LONGINT; s : TObject);
 VAR
   e, u, p : Node;
         j : LONGINT;
 BEGIN
    l.res := FALSE;
    NEW(e);
    e.obj := s;
    NEW(u); NEW(p);
    IF i = 0 THEN
       e.next := l.First;
       e.prev := NIL;
       l.First := e;
    ELSE
       j := 0;
       u := l.First;
       WHILE j # i DO
          p := u;
          u := u.next;
          INC(j);
       END;
       e.prev := p;
       p.next := e;
       e.next := u;
    END;
    l.res := TRUE;
    INC(l.Count);
 END Insert;

 PROCEDURE Clear*(l : TList);
 BEGIN
    l.First   := NIL;
    l.Last    := NIL;
    l.Count   := 0;
 END Clear;

 PROCEDURE Free*(l : TList);

 BEGIN

 END Free;

 PROCEDURE Get*(l : TList; k : LONGINT) : Node;
 VAR i : LONGINT;
     e : Node;
 BEGIN
    NEW(e);
    e := NIL;
    l.res := FALSE;
    IF (k < l.Count) & (k >= 0)  THEN
       i := 0;
       e := l.First;
       WHILE i # k DO
          IF e # NIL THEN e := e.next END;
    INC(i);
       END;
       l.res := TRUE
    END;
    RETURN e;
 END Get;

 PROCEDURE Delete* (l : TList; k : LONGINT);
 VAR i : LONGINT;
     e, p : Node;
 BEGIN
    l.res := FALSE;
    IF (k >= 0) & (k < l.Count) THEN
       NEW(p); NEW(e);
       e := l.First;
       p := l.First;
       IF k = 0 THEN
          l.First := l.First.next
       ELSE
          i := 0;
          WHILE i # k DO
             p := e;
       e := e.next;
       INC(i);
          END;
          IF e.next # NIL THEN p.next := e.next ELSE p.next := NIL END;
       END;
       DEC(l.Count);
       l.res := TRUE;
    END;
 END Delete;

PROCEDURE DeleteNode*(l: TList; n: Node):BOOLEAN;
VAR
	current: Node;
	result: BOOLEAN;
BEGIN
    result := FALSE;
	current := l.First;
	REPEAT
         IF current = n THEN
               IF current.prev = NIL THEN
                  l.First := current.next
               ELSE
                  current.prev.next := current.next
               END;
               IF current.next = NIL THEN
                  l.Last := current.prev
               ELSE
                  current.next.prev := current.prev
               END;
               DEC(l.Count);
               result := TRUE;
         END;
      current := current.next
    UNTIL result OR (current = NIL);
      RETURN result;
END DeleteNode;

PROCEDURE Empty* (l : TList) : BOOLEAN;
 BEGIN
    RETURN l.First = NIL
 END Empty;

 PROCEDURE Create* () : TList;
 VAR l : TList;
 BEGIN
    NEW(l);
    l.First   := NIL;
    l.Last    := NIL;
    l.Count   := 0;
    l.Add     := Add;
    l.Append  := Append;
    l.AppendList  := AppendList;
    l.Clear   := Clear;
    l.Free    := Free;
    l.Insert  := Insert;
    l.Delete  := Delete;
l.DeleteNode  := DeleteNode;
    l.Empty   := Empty;
    l.Get     := Get;
    l.res     := TRUE;
    RETURN(l);
 END Create;

(* PROCEDURE Delete* (VAR l : StringList; VAR e : Str);
 BEGIN
    e := l.First;
    l.First := l.First.next;
    IF l.First = NIL THEN l.Last := NIL END;
 END Delete;
*)

END List.
