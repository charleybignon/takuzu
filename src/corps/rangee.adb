pragma Ada_2012;
package body Rangee is

   ----------------------
   -- ConstruireRangee --
   ----------------------

   function ConstruireRangee (T : in Integer) return Type_Rangee is
      R : Type_Rangee;
   begin
      for i in 1..T loop
         R.R(i) := INCONNU;
      end loop;
      R.Taille := T;
      return R;
   end ConstruireRangee;

   -------------
   -- EstVide --
   -------------

   function EstVide (R : in Type_Rangee) return Boolean is
   begin
      for i in 1..R.Taille loop
         if R.R(i) /= INCONNU then
            return False;
         end if;
      end loop;
      return True;
   end EstVide;

   ----------------
   -- EstRemplie --
   ----------------

   function EstRemplie (R : in Type_Rangee) return Boolean is
   begin
      for i in 1..R.Taille loop
         if R.R(i) = INCONNU then
            return False;
         end if;
      end loop;
      return True;
   end EstRemplie;

   ------------
   -- Taille --
   ------------

   function Taille (R : in Type_Rangee) return Integer is
   begin
      return R.Taille;
   end Taille;

   --------------------
   -- ObtenirChiffre --
   --------------------

   function ObtenirChiffre
     (R : in Type_Rangee; I : in Integer) return Type_Chiffre
   is
   begin
      if i<1 or i>R.Taille then
         raise TRANCHE_INVALIDE;
      end if;
      return R.R(I);
   end ObtenirChiffre;

   --------------------------
   -- nombreChiffresConnus --
   --------------------------

   function nombreChiffresConnus (R : in Type_Rangee) return Integer is
      cpt : Integer := 0;
   begin
      for i in 1..R.Taille loop
         if R.R(i) /= INCONNU then
            cpt := cpt + 1;
         end if;
      end loop;
      return cpt;
   end nombreChiffresConnus;

   ----------------------------
   -- nombreChiffresDeValeur --
   ----------------------------

   function nombreChiffresDeValeur
     (R : in Type_Rangee; V : in Type_Chiffre) return Integer
   is
      cpt : Integer := 0;
   begin
      for i in 1..R.Taille loop
         if R.R(i) = V then
            cpt := cpt + 1;
         end if;
      end loop;
      return cpt;
   end nombreChiffresDeValeur;

   ---------------------
   -- chiffreDeDroite --
   ---------------------

   function chiffreDeDroite
     (E : in Type_Rangee; I : in Integer) return Type_Chiffre
   is
   begin
      if I<1 or I>E.Taille then
         raise TRANCHE_INVALIDE;
      end if;
      if I=E.Taille then
         return INCONNU;
      else
         return E.R(I+1);
      end if;
   end chiffreDeDroite;

   ---------------------
   -- chiffreDeGauche --
   ---------------------

   function chiffreDeGauche
     (E : in Type_Rangee; I : in Integer) return Type_Chiffre
   is
   begin
      if I<1 or I>E.Taille then
         raise TRANCHE_INVALIDE;
      end if;
      if I=1 then
         return INCONNU;
      else
         return E.R(I-1);
      end if;

   end chiffreDeGauche;

   -----------------------------------
   -- SontDeuxChiffresDeDroiteEgaux --
   -----------------------------------

   function SontDeuxChiffresDeDroiteEgaux
     (E : in Type_Rangee; I : in Integer) return Boolean
   is
   begin
      if I<1 or I>E.Taille then
         raise TRANCHE_INVALIDE;
      end if;
      if I>E.Taille-2 then
         return False;
      elsif chiffreDeDroite( E, I )=INCONNU or chiffreDeDroite( E, I + 1 )=INCONNU then
         return False;
      end if;
      return chiffreDeDroite( E, I ) = chiffreDeDroite( E, I + 1 );
   end SontDeuxChiffresDeDroiteEgaux;

   -----------------------------------
   -- SontDeuxChiffresDeGaucheEgaux --
   -----------------------------------

   function SontDeuxChiffresDeGaucheEgaux
     (E : in Type_Rangee; I : in Integer) return Boolean
   is
   begin
      if I<1 or I>E.Taille then
         raise TRANCHE_INVALIDE;
      end if;
      if I<3 then
         return False;
      elsif chiffreDeGauche( E, I )=INCONNU or chiffreDeGauche( E, I - 1 )=INCONNU then
         return False;
      end if;
   return chiffreDeGauche( E, I ) = chiffreDeGauche( E, I - 1 );
   end SontDeuxChiffresDeGaucheEgaux;

   --------------------
   -- AjouterChiffre --
   --------------------

   function AjouterChiffre
     (R : in Type_Rangee; I : in Integer; C : in Type_Chiffre)
      return Type_Rangee
   is
      r1 : Type_Rangee;
   begin
      if I<1 or I>R.Taille then
         raise TRANCHE_INVALIDE;
      end if;
      r1 := R;
      r1.R(I) := C;
      return r1;
   end AjouterChiffre;

   --------------------
   -- RetirerChiffre --
   --------------------

   function RetirerChiffre
     (R : in Type_Rangee; I : in Integer) return Type_Rangee
   is
      r1 : Type_Rangee := R;
   begin
      if I<1 or I>R.Taille then
         raise TRANCHE_INVALIDE;
      end if;
      r1.R(I) := INCONNU;
      return r1;
   end RetirerChiffre;

   -----------
   --  "="  --
   -----------

   --  function "="
   --    (R1 : in Type_Rangee; R2 : in Type_Rangee) return Boolean is
   --  begin
   --     if R1.Taille /= R2.Taille then
   --        raise TAILLE_INVALIDE;
   --     end if;
   --     if not EstRemplie(R1) or not EstRemplie(R2) then
   --        raise RANGEE_NON_PLEINE;
   --     end if;
   --     for i in 1..R1.Taille loop
   --        if R1.R(i) /= R2.R(i) then
   --           return False;
   --        end if;
   --     end loop;
   --     return True;
   --  end "=";

   end Rangee;
