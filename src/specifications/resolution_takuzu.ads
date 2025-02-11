with Grille;     use Grille;
with Coordonnee; use Coordonnee;
with Chiffre;    use Chiffre;
with Rangee;     use Rangee;

package Resolution_Takuzu is

   -- Règle 1 : complète la lignes l qui a déjà 4 UN ou 4 ZERO
   procedure CompleterLigne_Regle1
     (G : in out Type_Grille; L : in Integer);

   -- Règle 1 : complète la colonne Col qui a déjà 4 UN ou 4 ZERO
   procedure CompleterColonne_Regle1
     (G : in out Type_Grille; Col : in Integer);

   -- Règle 2 : complète la ligne number_L avec la règle :
   		-- Pas plus de deux même chiffre à la suite
   procedure CompleterLigne_Regle2
     (G : in out Type_Grille; number_L : in Integer);

   -- Règle 2 : complète la colonne number_C avec la règle :
   		-- Pas plus de deux même chiffre à la suite
   procedure CompleterColonne_Regle2
     (G : in  out Type_Grille; number_C : in Integer);

   -- Renvoie VRAI si la règle 1 a bien été respecté dans la grille G, FAUX sinon
   -- Règle 1 : Il doit y avoir autant de 1 que de 0 sur une ligne ou une colonne
   function Verif_Regle1 (G : in Type_Grille) return Boolean;

   -- Renvoie VRAI si la règle 2 a bien été respecté dans la grille G, FAUX sinon
   -- Règle 2 : Pas plus de deux même chiffre à la suite sur une ligne ou une colonne
   function Verif_Regle2 (G : in Type_Grille) return Boolean;

   -- Renvoie VRAI si la règle 3 a bien été respecté dans la grille G, FAUX sinon
   -- Règle 3 : Il ne doit pas y avoir 2 lignes identiques ni 2 colonnes identiques
   function Verif_Regle3 (G : in Type_Grille) return Boolean;

   -- Resoud une grille G en utilisant seulement la propagation de contraintes
   -- La grille en sortie n'est pas forcément résolue
   procedure ResoudreTakuzu_PropagationContraintes
     (G : in out Type_Grille);

   -- Resoud une Grille G en utilisant le backtracking
   procedure ResoudreTakuzu_Backtracking
     (G : in out Type_Grille);

   -- si la solution a ete trouve pour la grille g, alors Trouve est a VRAI et
   -- la grille est complete sinon Trouve est a FAUX et la grille n'a aucune
   -- valeur significative parcours la grille
   procedure ResoudreTakuzu (G : in out Type_Grille; Trouve : out Boolean);

   type TakuzuModifie is record
      Grille : Type_Grille;
      Coordonnee : Type_Coordonnee;
   end record;

end Resolution_Takuzu;
