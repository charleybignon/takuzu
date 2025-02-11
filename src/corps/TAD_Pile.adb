pragma Ada_2012;
package body TAD_Pile is

   --------------------
   -- construirePile --
   --------------------

   function construirePile return Type_Pile is
      P : Type_Pile;
   begin
      return P;
   end construirePile;

   -------------
   -- estVide --
   -------------

   function estVide (pile : in Type_Pile) return Boolean is
   begin
      return pile.nb_elements = 0;
   end estVide;

   -------------
   -- dernier --
   -------------

   function dernier (pile : in Type_Pile) return T is
   begin
      if pile.nb_elements <= 0 then
         raise PILE_VIDE;
      end if;
      return pile.elements( pile.nb_elements );
   end dernier;

   ------------------
   -- avantDernier --
   ------------------

   function avantDernier (pile : in Type_Pile) return T is
   begin
      if pile.nb_elements <= 0 then
         raise PILE_VIDE;
      end if;
      if pile.nb_elements = 1 then
         raise INDICE_INVALIDE;
      end if;
      return pile.elements( pile.nb_elements - 1 );
   end avantDernier;

   -------------
   -- empiler --
   -------------

   function empiler (pile : in Type_Pile; e : in T) return Type_Pile is
      P : Type_Pile;
   begin
      if pile.nb_elements >= TAILLE_MAX then
         raise PILE_PLEINE;
      end if;
      p := pile;
      P.nb_elements := P.nb_elements + 1;
      P.elements( P.nb_elements ) := e;
      return P;
   end empiler;

   -------------
   -- depiler --
   -------------

   function depiler (pile : in Type_Pile) return Type_Pile is
      P : Type_Pile;
   begin
      if pile.nb_elements <= 0 then
         raise PILE_VIDE;
      end if;
      P := pile;
      P.nb_elements := P.nb_elements - 1;
      return P;
   end depiler;

end TAD_Pile;
