
generic
   type T is private;

package TAD_Pile is

   TAILLE_MAX : constant := 255;
   type Type_Pile is private ;

   PILE_VIDE : exception;
   PILE_PLEINE : exception;
   INDICE_INVALIDE : exception;

   -- construit une pile vide
   function construirePile return Type_Pile;

   -- retourne VRAI si une pile est vide
   function estVide (pile : in Type_Pile) return Boolean;

   -- retourne l'element le plus récent de la pile
   -- necessite pile.nb_elements > 0
   -- leve l'exception PILE_VIDE si pile.nb_elements <= 0
   function dernier (pile : in Type_Pile) return T;

   -- retourne l'avant dernier element de la pile
   -- necessite pile.nb_elements > 1
   -- leve l'exception PILE_VIDE si pile.nb_elements <= 0
   -- leve l'exception INDICE_INVALIDE si pile.nb_elements = 1
   function avantDernier (pile : in Type_Pile) return T;

   -- ajoute un élément à la pile
   -- necessite pile.nb_elements < TAILLE_MAX
   -- leve l'exception PILE_PLEINE si pile.nb_elements >= TAILLE_MAX
   function empiler (pile : in Type_Pile ; e : in T) return Type_Pile;

   -- supprime l'element le plus recent de la pile
   -- necessite pile.nb_elements > 0
   -- leve l'exception PILE_VIDE si pile.nb_elements <= 0
   function depiler (pile : in Type_Pile) return Type_Pile;

private

   type Tableau is array (1 .. TAILLE_MAX) of T;

   type Type_Pile is record
      elements          : Tableau;
      nb_elements       : Integer   := 0;
   end record;

end TAD_Pile;
