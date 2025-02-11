pragma Ada_2012;
package body Coordonnee is

   ---------------------------
   -- ConstruireCoordonnees --
   ---------------------------

   function ConstruireCoordonnees
     (Ligne, Colonne : in Integer) return Type_Coordonnee
   is
      crd : Type_Coordonnee;
   begin
      crd.Ligne := Ligne;
      crd.Colonne := Colonne;
      return crd;
   end ConstruireCoordonnees;

   ------------------
   -- ObtenirLigne --
   ------------------

   function ObtenirLigne (C : in Type_Coordonnee) return Integer is
   begin
      return C.Ligne;
   end ObtenirLigne;

   --------------------
   -- ObtenirColonne --
   --------------------

   function ObtenirColonne (C : in Type_Coordonnee) return Integer is
   begin
      return C.Colonne;
   end ObtenirColonne;

   ----------
   -- Haut --
   ----------

   function Haut (C : in Type_Coordonnee) return Type_Coordonnee is
      Result : Type_Coordonnee;
   begin
      Result.Ligne := C.Ligne - 1;
      Result.Colonne := C.Colonne;
      return Result;
   end Haut;

   ----------
   -- Bas --
   ----------

   function Bas (C : in Type_Coordonnee) return Type_Coordonnee is
      Result : Type_Coordonnee;
   begin
      Result.Ligne := C.Ligne + 1;
      Result.Colonne := C.Colonne;
      return Result;
   end Bas;

   ------------
   -- Droite --
   ------------

   function Droite (C : in Type_Coordonnee) return Type_Coordonnee is
      Result : Type_Coordonnee;
   begin
      Result.Ligne := C.Ligne;
      Result.Colonne := C.Colonne + 1;
      return Result;
   end Droite;

   ------------
   -- Gauche --
   ------------

   function Gauche (C : in Type_Coordonnee) return Type_Coordonnee is
      Result : Type_Coordonnee;
   begin
      Result.Ligne := C.Ligne;
      Result.Colonne := C.Colonne - 1;
      return Result;
   end Gauche;


end Coordonnee;
