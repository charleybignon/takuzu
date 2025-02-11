pragma Ada_2012;
with rangee; use rangee;

package body Grille is

   ----------------------
   -- ConstruireGrille --
   ----------------------

   function ConstruireGrille (T : Integer) return Type_Grille is
      G : Type_Grille;
   begin
      if t<4 or t>TAILLE_MAX or ( t mod 2 /= 0 ) then
         raise TAILLE_GRILLE_INVALIDE;
      end if;
      for i in 1..T loop
         for j in 1..T loop
            G.G(i, j) := INCONNU;
         end loop;
      end loop;
      G.Taille := T;
      return G;
   end ConstruireGrille;

   ------------
   -- Taille --
   ------------

   function Taille (G : in Type_Grille) return Integer is
   begin
      return G.Taille;
   end Taille;

   -----------------
   -- estCaseVide --
   -----------------

   function estCaseVide
     (G : in Type_Grille; C : in Type_Coordonnee) return Boolean
   is
   begin
      if G.G ( ObtenirLigne(C), ObtenirColonne(C) ) = INCONNU then
         return True;
      end if;
      return False;
   end estCaseVide;

   --------------------
   -- ObtenirChiffre --
   --------------------

   function ObtenirChiffre
     (G : in Type_Grille; C : in Type_Coordonnee) return Type_Chiffre
   is
   begin
      if estCaseVide( G, C ) then
         raise CASE_VIDE;
      end if;
      return G.G ( ObtenirLigne(C), ObtenirColonne(C) );
   end ObtenirChiffre;

   --------------------------
   -- NombreChiffresConnus --
   --------------------------

   function NombreChiffresConnus (G : in Type_Grille) return Integer is
      cpt : Integer := 0;
   begin
      for i in 1..G.Taille loop
         for j in 1..G.Taille loop
            if G.G(i,j) /= INCONNU then
               cpt := cpt + 1;
            end if;
         end loop;
      end loop;
      return cpt;
   end NombreChiffresConnus;

   ----------------
   -- EstRemplie --
   ----------------

   function EstRemplie (G : in Type_Grille) return Boolean is
   begin
      return NombreChiffresConnus(G) = G.Taille**2;
   end EstRemplie;

   -------------------
   -- extraireLigne --
   -------------------

   function extraireLigne
     (G : in Type_Grille; L : in Integer) return Type_Rangee
   is
      R : Type_Rangee;
   begin
      R := ConstruireRangee( G.Taille );
      for i in 1..G.Taille loop
         R := AjouterChiffre( R, i, G.G(L, i) );
      end loop;
      return R;
   end extraireLigne;

   ---------------------
   -- extraireColonne --
   ---------------------

   function extraireColonne
     (G : in Type_Grille; C : in Integer) return Type_Rangee
   is
      R : Type_Rangee;
   begin
      R := ConstruireRangee( G.Taille );
      for i in 1..G.Taille loop
         R := AjouterChiffre( R, i, G.G(i, C) );
      end loop;
      return R;
   end extraireColonne;

   ------------------
   -- FixerChiffre --
   ------------------

   function FixerChiffre
     (G : in Type_Grille; C : in Type_Coordonnee; V : in Type_Chiffre)
      return Type_Grille
   is
      G_result : Type_Grille;
   begin
      if G.G( ObtenirLigne(C), ObtenirColonne(C) ) /= INCONNU then
         raise FIXER_CHIFFRE_NON_NUL;
      end if;
      G_result := G;
      G_result.G( ObtenirLigne(C), ObtenirColonne(C) ) := V;
      return G_result;
   end FixerChiffre;

   ---------------
   -- ViderCase --
   ---------------

   function ViderCase
     (G : in Type_Grille; C : in Type_Coordonnee) return Type_Grille
   is
      G_result : Type_Grille;
   begin
      if G.G( ObtenirLigne(C), ObtenirColonne(C) ) = INCONNU then
         raise VIDER_CASE_VIDE;
      end if;
      G_result := G;
      G_result.G( ObtenirLigne(C), ObtenirColonne(C) ) := INCONNU;
      return G_result;
   end ViderCase;

end Grille;
