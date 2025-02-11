pragma Ada_2012;
with Ada.Text_IO; use Ada.Text_IO;
with Grille;     use Grille;
with Coordonnee; use Coordonnee;
with Chiffre;    use Chiffre;
with Rangee;     use Rangee;
with TAD_Pile;   -- use TAD_Pile;
with Pile_Takuzu; use Pile_Takuzu;

package body Resolution_Takuzu is

   ---------------------------------
   -- CompleterLigne avec Regle 1 --
   ---------------------------------

   procedure CompleterLigne_Regle1
     (G : in out Type_Grille; L : in Integer)
   is
      R : Type_Rangee;
      cord : Type_Coordonnee;
   begin
      -- On commence par extraire la ligne que nous voulons compléter
      R := extraireLigne( G, L );
      -- On regarde si l'on peut la compléter avec des 0
      if nombreChiffresDeValeur( R, UN ) = Taille(G)/2 then
         -- On parcourt la ligne case par case
         for i in 1..Taille(G) loop
            -- On construit les coordonnées de la case courante
            cord := ConstruireCoordonnees( L, i );
            if estCaseVide( G, cord ) then
               G := FixerChiffre( G, cord, ZERO );
            end if;
         end loop;
      end if;
      -- On regarde si l'on peut la compléter avec des 1
      if nombreChiffresDeValeur( R, ZERO ) = Taille(G)/2 then
         for i in 1..Taille(G) loop
            cord := ConstruireCoordonnees( L, i );
            if estCaseVide( G, cord ) then
               G := FixerChiffre( G, cord, UN );
            end if;
         end loop;
      end if;
   end CompleterLigne_Regle1;


   -----------------------------------
   -- CompleterColonne avec Regle 1 --
   -----------------------------------

   procedure CompleterColonne_Regle1
     (G : in out Type_Grille; Col : in Integer)
   is
      R : Type_Rangee;
      cord : Type_Coordonnee;
   begin
      -- On commence par extraire la ligne que nous voulons compléter
      R := extraireColonne( G, Col );
      -- On regarde si l'on peut la compléter avec des 0
      if nombreChiffresDeValeur( R, UN ) = Taille(G)/2 then
         -- On parcourt la colonne case par case
         for i in 1..Taille(G) loop
            -- On construit les coordonnées de la case courante
            cord := ConstruireCoordonnees( i, Col );
            if estCaseVide( G, cord ) then
               G := FixerChiffre( G, cord, ZERO );
            end if;
         end loop;
      end if;
      -- On regarde si l'on peut la compléter avec des 1
      if nombreChiffresDeValeur( R, ZERO ) = Taille(G)/2 then
         for i in 1..Taille(G) loop
            cord := ConstruireCoordonnees( i, Col );
            if estCaseVide( G, cord ) then
               G := FixerChiffre( G, cord, UN );
            end if;
         end loop;
      end if;
   end CompleterColonne_Regle1;


   ---------------------------------
   -- CompleterLigne avec Regle 2 --
   ---------------------------------

   procedure CompleterLigne_Regle2
     (G : in out Type_Grille; number_L : in Integer) is
      L : Type_Rangee; -- ligne à compléter
      cord : Type_Coordonnee;
   begin
      L := extraireLigne( G, number_L );
      -- On parcourt la ligne case par case
      for i in 1..Taille(G) loop
         cord := ConstruireCoordonnees( number_L,i );
         -- Ssi la case est vide on regarde si on peut la remplir
         if estCaseVide( G, cord ) then
            -- Deux chiffres à la droite
            if SontDeuxChiffresDeDroiteEgaux( L, i ) then
               G := FixerChiffre( G, cord, Complement( chiffreDeDroite( L, i ) ) );
            -- Deux chiffres à la gauche
            elsif SontDeuxChiffresDeGaucheEgaux( L, i ) then
               G := FixerChiffre( G, cord, Complement( chiffreDeGauche( L, i ) ) );
            -- Deux chifffres adjacents
            elsif chiffreDeGauche( L, i ) = chiffreDeDroite( L, i ) and chiffreDeDroite( L, i ) /= INCONNU then
               G := FixerChiffre( G, cord, Complement( chiffreDeGauche( L, i ) ) );
            end if;
         end if;
      end loop;
   end CompleterLigne_Regle2;


   -----------------------------------
   -- CompleterColonne avec Regle 2 --
   -----------------------------------

   procedure CompleterColonne_Regle2
     (G : in out Type_Grille; number_C : in Integer) is
      C : Type_Rangee; -- colonne à compléter
      cord : Type_Coordonnee;
   begin
      C := extraireColonne( G, number_C );
      -- On parcourt la colonne case par case
      for i in 1..Taille(G) loop
         cord := ConstruireCoordonnees( i,number_C );
         -- Ssi la case est vide on regarde si on peut la remplir
         if estCaseVide( G, cord ) then
            -- Deux chiffres à la droite
            if SontDeuxChiffresDeDroiteEgaux( C, i ) then
               G := FixerChiffre( G, cord, Complement( chiffreDeDroite( C, i ) ) );
            -- Deux chiffres à la gauche
            elsif SontDeuxChiffresDeGaucheEgaux( C, i ) then
               G := FixerChiffre( G, cord, Complement( chiffreDeGauche( C, i ) ) );
            -- Deux chiffres adjacents
            elsif chiffreDeGauche( C, i ) = chiffreDeDroite( C, i ) and chiffreDeDroite( C, i ) /= INCONNU then
               G := FixerChiffre( G, cord, Complement( chiffreDeGauche( C, i ) ) );
            end if;
         end if;
      end loop;
   end CompleterColonne_Regle2;


   ------------------
   -- Verif_Regle1 --
   ------------------

   function Verif_Regle1 (G : in Type_Grille) return Boolean is
      L : Type_Rangee;
      C : Type_Rangee;
      t : Integer; -- taille de la grille
   begin
      t := Taille(G);
      for i in 1..t loop
         L := extraireLigne( G, i );
         C := extraireColonne( G, i );
         -- On vérifie qu'aucune ligne ou colonne n'ai un nombre de 0 ou de 1
         -- superieur à la moitié de la taille de la grille
         if nombreChiffresDeValeur(L, UN) > t/2
           or nombreChiffresDeValeur(L, ZERO) > t/2
           or nombreChiffresDeValeur(C, UN) > t/2
           or nombreChiffresDeValeur(C, ZERO) > t/2
         then
            return False;
         end if;
      end loop;
      return True;
   end Verif_Regle1;


   ------------------
   -- Verif_Regle2 --
   ------------------

   function Verif_Regle2 (G : in Type_Grille) return Boolean is
      L, C : Type_Rangee;
      caseG : Type_Chiffre; -- case courante
   begin
      -- On parcourt la grille ligne par ligne et colonne par colonne
      for i in 1..Taille(G) loop
         L := extraireLigne(G ,i);
         C := extraireColonne(G, i);
         -- On parcourt la ligne i et la colonne i case par case
         for j in 1..Taille(G) loop
            -- LIGNE
            caseG := ObtenirChiffre(L, j);
            -- On renvoie faux si on trouve 3 chiffres identiques à la suite
            if caseG/=INCONNU and then
              ( ( SontDeuxChiffresDeDroiteEgaux(L, j) and caseG=chiffreDeDroite(L, j) )
              or ( SontDeuxChiffresDeGaucheEgaux(L, j) and caseG=chiffreDeGauche(L, j) )
              or ( caseG=chiffreDeGauche(L, j) and caseG=chiffreDeDroite(L, j) ) )
            then
               return False;
            end if;
            -- COLONNE
            caseG := ObtenirChiffre(C, j);
            -- On renvoie faux si on trouve 3 chiffres identiques à la suite
            if caseG/=INCONNU and then
              ( ( SontDeuxChiffresDeDroiteEgaux(C, j) and caseG=chiffreDeDroite(C, j) )
              or ( SontDeuxChiffresDeGaucheEgaux(C, j) and caseG=chiffreDeGauche(C, j) )
              or ( caseG=chiffreDeGauche(C, j) and caseG=chiffreDeDroite(C, j) ) )
            then
               return False;
            end if;
         end loop;
      end loop;
      return True;
   end Verif_Regle2;


   ------------------
   -- Verif_Regle3 --
   ------------------

   function Verif_Regle3 (G : in Type_Grille) return Boolean is
      L1, L2 : Type_Rangee;
      C1, C2 : Type_Rangee;
   begin
      -- On parcourt une première fois la grille ligne par ligne et colonne par colonne
      for i in 1..Taille(G)-1 loop
         L1 := extraireLigne(G, i);
         C1 := extraireColonne(G, i);
         -- On parcourt une seconde fois la grille ligne par ligne et colonne par colonne
         for j in i+1..Taille(G) loop
            L2 := extraireLigne(G, j);
            C2 := extraireColonne(G, j);
            -- On compare les deux lignes ainsi que les deux colonnes ssi les deux sont pleines
            if ( (EstRemplie(L1) and EstRemplie(L2))and then L1=L2 )
              or ( (EstRemplie(C1) and EstRemplie(C2)) and then C1=C2 )
            then
               return False;
            end if;
         end loop;
      end loop;
      return True;
   end Verif_Regle3;



   -------------------------------------------
   -- ResoudreTakuzu PropagationContraintes --
   -------------------------------------------

   procedure ResoudreTakuzu_PropagationContraintes
     ( G : in out Type_Grille ) is
      nbr_Chiffre_Debut : Integer := 0; -- Nombre de chiffres connus avant les modifications
      nbr_Chiffre_Fin : Integer := 1; -- Nombre de chiffres connus après les modifications
   begin
       -- Tant qu'il reste des modifications à faire
      while nbr_Chiffre_Debut /= nbr_Chiffre_Fin loop
         nbr_Chiffre_Debut := NombreChiffresConnus(G);
         -- On parcourt le tableau ligne par ligne et colonne par colonne car nbr colonne = nbr ligne
         for i in 1..Taille(G) loop
            -- On commence par la seconde règle
            CompleterLigne_Regle2( G, i );
            CompleterColonne_Regle2( G, i );
            -- Puis on teste la première règle
            CompleterLigne_Regle1( G, i );
            CompleterColonne_Regle1( G, i );
         end loop;
         nbr_Chiffre_Fin := NombreChiffresConnus(G);
      end loop;
   end ResoudreTakuzu_PropagationContraintes;


   ---------------------------------
   -- ResoudreTakuzu Backtracking --
   ---------------------------------


   procedure ResoudreTakuzu_Backtracking
     (G : in out Type_Grille) is
      cord : Type_Coordonnee;
      comp : Type_Chiffre;
      TM : TakuzuModifie;
      Pile : Type_Pile;
      i, j : Integer;
   begin
      Pile := construirePile;
      TM.Grille := G;
      TM.Coordonnee := ConstruireCoordonnees(0,0);
      Pile := empiler(Pile, TM);
      i := 1;
      -- On parcourt la grille case par case
      while i <= Taille(G) loop
         j := 1;
         while j <= Taille(G) loop
            cord := ConstruireCoordonnees(i, j);
            if estCaseVide(G, cord) then
               -- On essaye avec le chiffre UN
               TM.Grille := FixerChiffre( TM.Grille, cord, ZERO );
               TM.Coordonnee := cord;
               Pile := empiler( Pile, TM );
               -- Si une des règles n'est pas respectée, on essaye avec le chiffre ZERO
               if not Verif_Regle1(TM.Grille) or not Verif_Regle2(TM.Grille) or not Verif_Regle3(TM.Grille) then
                  TM.Grille := ViderCase( TM.Grille, cord );
                  TM.Grille := FixerChiffre( TM.Grille, cord, UN );
                  Pile := empiler( Pile, TM );
                  -- Si une regle n'est toujours pas respecté
                  if not Verif_Regle1(TM.Grille) or not Verif_Regle2(TM.Grille) or not Verif_Regle3(TM.Grille) then
                     -- On depile tant que l'on a essayer les deux chiffres
                     while dernier(Pile).Coordonnee = avantDernier(Pile).Coordonnee loop
                        Pile := depiler(Pile);
                        Pile := depiler(Pile);
                     end loop;
                     -- On change le chiffre qui pose problème
                     TM := dernier(Pile);
                     comp := Complement( ObtenirChiffre( TM.Grille, TM.Coordonnee ) );
                     TM.Grille := ViderCase( TM.Grille, TM.Coordonnee );
                     TM.Grille := FixerChiffre( TM.Grille, TM.Coordonnee, comp );
                     Pile := empiler(Pile, TM);
                     -- On revient à la case qui posait problème
                     i := ObtenirLigne( TM.Coordonnee );
                     j := ObtenirColonne( TM.Coordonnee );
                  end if;
               end if;
            end if;
            j := j + 1;
         end loop;
         i := i + 1;
      end loop;
      G := dernier(Pile).Grille;
   end ResoudreTakuzu_Backtracking;

   --------------------
   -- ResoudreTakuzu --
   --------------------

   procedure ResoudreTakuzu (G : in out Type_Grille; Trouve : out Boolean) is
   begin
      -- On applique pour commencer la propagation de contraintes
      ResoudreTakuzu_PropagationContraintes( G );
      trouve := EstRemplie(G);
      -- Si la grille n'est pas résolue, on utilise le backtracking
      if not trouve then
         ResoudreTakuzu_Backtracking(G);
      end if;
      trouve := EstRemplie(G);
   end ResoudreTakuzu;

end Resolution_Takuzu;
