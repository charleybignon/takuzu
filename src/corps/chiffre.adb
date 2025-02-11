pragma Ada_2012;
package body Chiffre is

   -------------------
   -- ValeurChiffre --
   -------------------

   function ValeurChiffre (C : in Type_Chiffre) return Integer is
   begin
      return Integer( C );
   end ValeurChiffre;

   -----------------
   -- EstInconnue --
   -----------------

   function EstInconnue (C : in Type_Chiffre) return Boolean is
   begin
      if C = INCONNU then
         return True;
      end if;
      return False;
   end EstInconnue;

   ----------------
   -- Complement --
   ----------------

   function Complement (C : in Type_Chiffre) return Type_Chiffre is
   begin
      if C = INCONNU then
         raise VALEUR_INCONNUE;
      end if;
      if C = UN then
         return ZERO;
      end if;
      return UN;
   end Complement;

   ---------
   -- "=" --
   ---------

   function "=" (c1 : in Type_Chiffre; c2 : in Type_Chiffre) return Boolean is
   begin
      return ( ValeurChiffre(c1) = ValeurChiffre(c2) );
   end "=";

end Chiffre;
