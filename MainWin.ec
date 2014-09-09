import "ecere"
import "attribDialog"
import "aboutDialog"
import "a1Dialog"

static FileFilter pkcFilters[] =
{
   { "POKéMON Card Creator Files (*.pkc)", "pkc" },
   { "All files", null }
};

static FileType pkcTypes[] = {{ "POKéMON Card Creator Files", "pkc", always }};

class MainWin : Window
{
   caption = "POKéMON Card Creator";
   background = black;
   borderStyle = sizable;
   hasMaximize = true;
   hasMinimize = true;
   hasClose = true;
   hasMenuBar = true;
   clientSize = { 450, 616 };

   BitmapResource pkmnImage { window = this };
   Menu fileMenu { menu, "File", f };
   MenuItem openItem
   {
      fileMenu, "Open", o, ctrlO;

      bool NotifySelect(MenuItem selection, Modifiers mods)
      {
         if(openDialog.Modal() == ok)
         {
            File f = FileOpen(openDialog.filePath, read);
            if(f)
            {
               fileName = openDialog.filePath;
               //editBox.Load(f);  //editBox = the content to load...
               delete(f);
            }
         }
         return true;
      }
   };
   MenuDivider { fileMenu };
   MenuItem saveItem { fileMenu, "Save", s, ctrlS, NotifySelect = MenuFileSave };
   MenuItem saveItemAs { fileMenu, "Save As...", a, NotifySelect = MenuFileSaveAs };
   MenuDivider { fileMenu };
   MenuItem exitItem { fileMenu, "Exit", x, altF4, NotifySelect = MenuFileExit };
   MenuPlacement { menu, "Edit", e };
   FileDialog fileSaveDialog
   {
      master = this, type = save, text = "Save File...",
      types = pkcTypes, sizeTypes = sizeof(pkcTypes), filters = pkcFilters, sizeFilters = sizeof(pkcFilters)
   };
   FileDialog openDialog
   {
      master = this, type = open, text = "Load File...",
      types = pkcTypes, sizeTypes = sizeof(pkcTypes), filters = pkcFilters, sizeFilters = sizeof(pkcFilters)
   };
   Menu editMenu { menu, "Edit", e };
   MenuItem PokeItem
   {
      editMenu, "Edit POKéMON Attributes...", p, ctrlP;
      bool NotifySelect(MenuItem selection, Modifiers mods)
      {
         if(attribDialog.Modal() == ok)
         {
            lblPkmnName.caption = attribDialog.ebPkmnName.contents; // change the Pokemon's name
            lblPkmnHPAmt.caption = attribDialog.ebPkmnHP.contents; // change the Pokemon's HP

            //Update the Pokemon image
            pkmnImage.fileName = attribDialog.ebPkmnImage.contents; // get the image filename from the dialog box
//Note: something about the following commented lines causes the program to stay in memory
// so we can't even compile a new one...
//            delete cardPkmn.image; // erase the old image so there's no memory conflicts
            AddResource(pkmnImage); // Add the Bitmap to our list of resources so it can be used
//            RemoveResource(cardPkmn.image); // Remove the old bitmap so we're not hogging memory
            cardPkmn.image = pkmnImage; // assign the new image to be displayed on the card.

            // Change the Evolution of the card
            switch(attribDialog.dbPkmnEvo.currentRow.tag)
            {
               case 1:
               { cardEvo.image = { ":basic.png" }; break; }
               case 2:
               { cardEvo.image = { ":stage1.png" }; break; }
               case 3:
               { cardEvo.image = { ":stage2.png" }; break; }
            }
            // Change the type of the card
            switch(attribDialog.dbPkmnEl.currentRow.tag)
            {
               case 1:
               {
                  cardBack.image = { ":Card Base colorless.png" };
                  cardEl.image = { ":Colorless.png" };
                  break;
               }
               case 2:
               {
                  cardBack.image = { ":Card Base darkness.png" };
                  cardEl.image = { ":Darkness.png" };
                  break;
               }
               case 3:
               {
                  cardBack.image = { ":Card Base dragon.png" };
                  cardEl.image = { ":Dragon.png" };
                  break;
               }
               case 4:
               {
                  cardBack.image = { ":Card Base fairy.png" };
                  cardEl.image = { ":fairy.png" };
                  break;
               }
               case 5:
               {
                  cardBack.image = { ":Card Base fighting.png" };
                  cardEl.image = { ":Fighting.png" };
                  break;
               }
               case 6:
               {
                  cardBack.image = { ":Card Base fire.png" };
                  cardEl.image = { ":Fire.png" };
                  break;
               }
               case 7:
               {
                  cardBack.image = { ":Card Base grass.png" };
                  cardEl.image = { ":Grass.png" };
                  break;
               }
               case 8:
               {
                  cardBack.image = { ":Card Base lightning.png" };
                  cardEl.image = { ":Lightning.png" };
                  break;
               }
               case 9:
               {
                  cardBack.image = { ":Card Base metal.png" };
                  cardEl.image = { ":Metal.png" };
                  break;
               }
               case 10:
               {
                  cardBack.image = { ":Card Base psychic.png" };
                  cardEl.image = { ":Psychic.png" };
                  break;
               }
               case 11:
               {
                  cardBack.image = { ":Card Base water.png" };
                  cardEl.image = { ":Water.png" };
                  break;
               }
            }
            switch(attribDialog.dbPkmnWeakEl.currentRow.tag)
            {
               case 1:
               {
                  cardWeak.image = null;
                  break;
               }
               case 2:
               {
                  cardWeak.image = {":Darkness.png"};
                  break;
               }
               case 3:
               {
                  cardWeak.image = {":Dragon.png"};
                  break;
               }
               case 4:
               {
                  cardWeak.image = {":fairy.png"};
                  break;
               }
               case 5:
               {
                  cardWeak.image = {":Fighting.png"};
                  break;
               }
               case 6:
               {
                  cardWeak.image = {":Fire.png"};
                  break;
               }
               case 7:
               {
                  cardWeak.image = {":Grass.png"};
                  break;
               }
               case 8:
               {
                  cardWeak.image = {":Lightning.png"};
                  break;
               }
               case 9:
               {
                  cardWeak.image = {":Metal.png"};
                  break;
               }
               case 10:
               {
                  cardWeak.image = {":Psychic.png"};
                  break;
               }
               case 11:
               {
                  cardWeak.image = {":Water.png"};
                  break;
               }
            }
            switch(attribDialog.dbPkmnWeakAmt.currentRow.tag)
            {
               case 1:
               {
                  cardWeakAmt.caption = "";
                  break;
               }
               case 2:
               {
                  cardWeakAmt.caption = "+10";
                  break;
               }
               case 3:
               {
                  cardWeakAmt.caption = "+20";
                  break;
               }
               case 4:
               {
                  cardWeakAmt.caption = "+30";
                  break;
               }
               case 5:
               {
                  cardWeakAmt.caption = "+40";
                  break;
               }
               case 6:
               {
                  cardWeakAmt.caption = "x2";
                  break;
               }
            }
            switch(attribDialog.dbPkmnResEl.currentRow.tag)
            {
               case 1:
               {
                  cardRes.image = null;
                  break;
               }
               case 2:
               {
                  cardRes.image = {":Darkness.png"};
                  break;
               }
               case 3:
               {
                  cardRes.image = {":Dragon.png"};
                  break;
               }
               case 4:
               {
                  cardRes.image = {":fairy.png"};
                  break;
               }
               case 5:
               {
                  cardRes.image = {":Fighting.png"};
                  break;
               }
               case 6:
               {
                  cardRes.image = {":Fire.png"};
                  break;
               }
               case 7:
               {
                  cardRes.image = {":Grass.png"};
                  break;
               }
               case 8:
               {
                  cardRes.image = {":Lightning.png"};
                  break;
               }
               case 9:
               {
                  cardRes.image = {":Metal.png"};
                  break;
               }
               case 10:
               {
                  cardRes.image = {":Psychic.png"};
                  break;
               }
               case 11:
               {
                  cardRes.image = {":Water.png"};
                  break;
               }
            }
            switch(attribDialog.dbPkmnResAmt.currentRow.tag)
            {
               case 1:
               {
                  cardResAmt.caption = "";
                  break;
               }
               case 2:
               {
                  cardResAmt.caption = "-10";
                  break;
               }
               case 3:
               {
                  cardResAmt.caption = "-20";
                  break;
               }
               case 4:
               {
                  cardResAmt.caption = "-30";
                  break;
               }
               case 5:
               {
                  cardResAmt.caption = "-40";
                  break;
               }
            }
            switch(attribDialog.dbPkmnRetCost.currentRow.tag)
            {
               case 1:
               {
                  cardRetCost1.image = null;
                  cardRetCost2.image = null;
                  cardRetCost3.image = null;
                  cardRetCost4.image = null;
                  break;
               }
               case 2:
               {
                  cardRetCost1.image = {":Colorless.png"};
                  cardRetCost2.image = null;
                  cardRetCost3.image = null;
                  cardRetCost4.image = null;
                  break;
               }
               case 3:
               {
                  cardRetCost1.image = {":Colorless.png"};
                  cardRetCost2.image = {":Colorless.png"};
                  cardRetCost3.image = null;
                  cardRetCost4.image = null;
                  break;
               }
               case 4:
               {
                  cardRetCost1.image = {":Colorless.png"};
                  cardRetCost2.image = {":Colorless.png"};
                  cardRetCost3.image = {":Colorless.png"};
                  cardRetCost4.image = null;
                  break;
               }
               case 5:
               {
                  cardRetCost1.image = {":Colorless.png"};
                  cardRetCost2.image = {":Colorless.png"};
                  cardRetCost3.image = {":Colorless.png"};
                  cardRetCost4.image = {":Colorless.png"};
                  break;
               }
            }
            lblIllus.caption = PrintString("Illus. ", attribDialog.ebPkmnIllus.contents);
         }
         return true;
      }
   };
   MenuItem Attack1Item
   {
      editMenu, "Edit POKéMON's First Attack...", 1, ctrl1;
      bool NotifySelect(MenuItem selection, Modifiers mods)
      {
         if(a1Dialog.Modal() == ok)
         {
            lblA1Name.caption = a1Dialog.ebA1Name.contents;
            lblA1Dmg.caption = a1Dialog.ebA1Dmg.contents;
            ebA1Desc.contents = a1Dialog.ebA1Desc.contents;
            switch(a1Dialog.dbA1Cost1.currentRow.tag)
            {
               case 1:
               {
                  a1Cost1.image = null;
                  a1Cost2.image = null;
                  a1Cost3.image = null;
                  a1Cost4.image = null;
                  break;
               }
               case 2:
               {
                  a1Cost1.image = { ":PokeBody.png" };
                  a1Cost1.size = { 115, 30 };
                  a1Cost2.image = null;
                  a1Cost3.image = null;
                  a1Cost4.image = null;
                  break;
               }
               case 3:
               {
                  a1Cost1.image = { ":PokePower.png" };
                  a1Cost1.size = { 115, 30 };
                  a1Cost2.image = null;
                  a1Cost3.image = null;
                  a1Cost4.image = null;
                  break;
               }
               case 4:
               {
                  a1Cost1.image = { ":Colorless.png" };
                  a1Cost1.size = { 30, 30 };
                  break;
               }
               case 5:
               {
                  a1Cost1.image = { ":Darkness.png" };
                  a1Cost1.size = { 30, 30 };
                  break;
               }
               case 6:
               {
                  a1Cost1.image = { ":Dragon.png" };
                  a1Cost1.size = { 30, 30 };
                  break;
               }
               case 7:
               {
                  a1Cost1.image = { ":fairy.png" };
                  a1Cost1.size = { 30, 30 };
                  break;
               }
               case 8:
               {
                  a1Cost1.image = { ":Fighting.png" };
                  a1Cost1.size = { 30, 30 };
                  break;
               }
               case 9:
               {
                  a1Cost1.image = { ":Fire.png" };
                  a1Cost1.size = { 30, 30 };
                  break;
               }
               case 10:
               {
                  a1Cost1.image = { ":Grass.png" };
                  a1Cost1.size = { 30, 30 };
                  break;
               }
               case 11:
               {
                  a1Cost1.image = { ":Lightning.png" };
                  a1Cost1.size = { 30, 30 };
                  break;
               }
               case 12:
               {
                  a1Cost1.image = { ":Metal.png" };
                  a1Cost1.size = { 30, 30 };
                  break;
               }
               case 13:
               {
                  a1Cost1.image = { ":Psychic.png" };
                  a1Cost1.size = { 30, 30 };
                  break;
               }
               case 14:
               {
                  a1Cost1.image = { ":Water.png" };
                  a1Cost1.size = { 30, 30 };
                  break;
               }
            }
            switch(a1Dialog.dbA1Cost2.currentRow.tag)
            {
               case 1:
               {
                  a1Cost2.image = null;
                  a1Cost3.image = null;
                  a1Cost4.image = null;
                  break;
               }
               case 2:
               {
                  a1Cost2.image = { ":Colorless.png" };
                  break;
               }
               case 3:
               {
                  a1Cost2.image = { ":Darkness.png" };
                  break;
               }
               case 4:
               {
                  a1Cost2.image = { ":Dragon.png" };
                  break;
               }
               case 5:
               {
                  a1Cost2.image = { ":fairy.png" };
                  break;
               }
               case 6:
               {
                  a1Cost2.image = { ":Fighting.png" };
                  break;
               }
               case 7:
               {
                  a1Cost2.image = { ":Fire.png" };
                  break;
               }
               case 8:
               {
                  a1Cost2.image = { ":Grass.png" };
                  break;
               }
               case 9:
               {
                  a1Cost2.image = { ":Lightning.png" };
                  break;
               }
               case 10:
               {
                  a1Cost2.image = { ":Metal.png" };
                  break;
               }
               case 11:
               {
                  a1Cost2.image = { ":Psychic.png" };
                  break;
               }
               case 12:
               {
                  a1Cost2.image = { ":Water.png" };
                  break;
               }
            }
            switch(a1Dialog.dbA1Cost3.currentRow.tag)
            {
               case 1:
               {
                  a1Cost3.image = null;
                  a1Cost4.image = null;
                  break;
               }
               case 2:
               {
                  a1Cost3.image = { ":Colorless.png" };
                  break;
               }
               case 3:
               {
                  a1Cost3.image = { ":Darkness.png" };
                  break;
               }
               case 4:
               {
                  a1Cost3.image = { ":Dragon.png" };
                  break;
               }
               case 5:
               {
                  a1Cost3.image = { ":fairy.png" };
                  break;
               }
               case 6:
               {
                  a1Cost3.image = { ":Fighting.png" };
                  break;
               }
               case 7:
               {
                  a1Cost3.image = { ":Fire.png" };
                  break;
               }
               case 8:
               {
                  a1Cost3.image = { ":Grass.png" };
                  break;
               }
               case 9:
               {
                  a1Cost3.image = { ":Lightning.png" };
                  break;
               }
               case 10:
               {
                  a1Cost3.image = { ":Metal.png" };
                  break;
               }
               case 11:
               {
                  a1Cost3.image = { ":Psychic.png" };
                  break;
               }
               case 12:
               {
                  a1Cost3.image = { ":Water.png" };
                  break;
               }
            }
            switch(a1Dialog.dbA1Cost4.currentRow.tag)
            {
               case 1:
               {
                  a1Cost4.image = null;
                  break;
               }
               case 2:
               {
                  a1Cost4.image = { ":Colorless.png" };
                  break;
               }
               case 3:
               {
                  a1Cost4.image = { ":Darkness.png" };
                  break;
               }
               case 4:
               {
                  a1Cost4.image = { ":Dragon.png" };
                  break;
               }
               case 5:
               {
                  a1Cost4.image = { ":fairy.png" };
                  break;
               }
               case 6:
               {
                  a1Cost4.image = { ":Fighting.png" };
                  break;
               }
               case 7:
               {
                  a1Cost4.image = { ":Fire.png" };
                  break;
               }
               case 8:
               {
                  a1Cost4.image = { ":Grass.png" };
                  break;
               }
               case 9:
               {
                  a1Cost4.image = { ":Lightning.png" };
                  break;
               }
               case 10:
               {
                  a1Cost4.image = { ":Metal.png" };
                  break;
               }
               case 11:
               {
                  a1Cost4.image = { ":Psychic.png" };
                  break;
               }
               case 12:
               {
                  a1Cost4.image = { ":Water.png" };
                  break;
               }
            }
         }
         return true;
      }
   };
   MenuItem Attack2Item
   {
      editMenu, "Edit POKéMON's Second Attack...", 2, ctrl2;
   };
   AttribDialog attribDialog {};
   AboutDialog aboutDialog {};
   A1Dialog a1Dialog {};
   Menu helpMenu { menu, "Help", h };
   MenuItem AboutItem
   {
      helpMenu, "About...", a, ctrlA;
      bool NotifySelect(MenuItem selection, Modifiers mods)
      {
         aboutDialog.Modal();
         return true;
      }
   };
   Picture cardBack { this, position = { 32, 32 }, size = { 387, 557 }, image = { ":Card Base colorless.png" }};
   Picture cardEvo { this, position = { 16, 16 }, image = { ":basic.png" }};
   Picture cardEl { this, position = { 380, 38 }, size = { 30, 30 }, image = { ":Colorless.png" }};
   Picture cardPkmn { this, position = { 53, 77 }, size = { 347, 230} };
   Picture cardWeak { this, position = { 52, 529 }, size = { 19, 19 }, image = null };
   Label cardWeakAmt { this, caption = "", font = { "Arial", 12.0f, bold = true }, position = { 73, 530 } };
   Picture cardRes { this, position = { 128, 529 }, size = { 19, 19 }, image = null };
   Label cardResAmt { this, caption = "", font = { "Arial", 12.0f, bold = true }, position = { 149, 530 } };
   Picture cardRetCost1 { this, position = { 90, 560 }, size = { 19, 19 }, image = {":Colorless.png"} };
   Picture cardRetCost2 { this, position = { 115, 560 }, size = { 19, 19 }, image = {":Colorless.png"} };
   Picture cardRetCost3 { this, position = { 140, 560 }, size = { 19, 19 }, image = {":Colorless.png"} };
   Picture cardRetCost4 { this, position = { 165, 560 }, size = { 19, 19 }, image = {":Colorless.png"} };
   Label lblPkmnName { this, caption = "Purple Monkey", font = { "Arial", 15.0f, bold = true }, position = { 118, 40 } };
   Label lblPkmnHP { this, caption = "HP", font = { "Tahoma", 10.0f, bold = true }, position = { 325, 53 } };
   Label lblPkmnHPAmt { this, caption = "30", font = { "Arial", 15.0f, bold = true }, position = { 343, 47} };
   Label lblA1Name { this, caption = "Slap", font = { "Arial", 17.0f, bold = true }, position = { 156, 337 } };
   Picture a1Cost1 { this, position = { 36, 336 }, size = { 30, 30 }, image = {":Colorless.png"} };
   Picture a1Cost2 { this, position = { 64, 336 }, size = { 30, 30 }, image = {":Colorless.png"} };
   Picture a1Cost3 { this, position = { 92, 336 }, size = { 30, 30 }, image = {":Colorless.png"} };
   Picture a1Cost4 { this, position = { 120, 336 }, size = { 30, 30 }, image = {":Colorless.png"} };
   Label lblA1Dmg { this, caption = "10+", font = { "Arial", 17.0f, bold = true }, position = { 365, 337 } };
   EditBox ebA1Desc{ this, background = formColor, 0, borderStyle = none, inactive = true, font = { "Arial", 11 }, size = { 369, 67 }, position = { 36, 365 }, scrollArea = { 1576, 67 }, readOnly = true, true, noCaret = true, noSelect = true, wrap = true, contents = "Slap does 10 damage to your opponents Defending Pokemon, as well as 10 damage to each or your opponents benched Pokemon. If your opponent has no benched pokemon, this attack does 20 damage to the opponents Defending Pokemon." };
//   Label lblA1Desc{ this, font = { "Arial", 11 }, position = { 36, 365 }, scrollArea = { 1576, 19 }, multiLine = true, wrap = true, contents = "Slap does 10 damage to your opponents Defending Pokemon, as well as 10 damage to each or your opponents benched Pokemon. If your opponent has no benched pokemon, this attack does 20 damage to the opponents Defending Pokemon." };
   Label lblIllus { this, caption = "Illus. Charlie Griffin", font = { "Arial", 7.0f, italic = true  }, position = { 265, 570 }};
}

MainWin mainWin {};




