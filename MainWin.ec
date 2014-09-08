import "ecere"
import "attribDialog"
import "aboutDialog"

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
   saveDialog = fileSaveDialog;

   Menu editMenu { menu, "Edit", e };
   MenuItem PokeItem
   {
      editMenu, "Edit POKéMON Attributes...", p, ctrlP;
      bool NotifySelect(MenuItem selection, Modifiers mods)
      {
         if(attribDialog.Modal() == ok)
         {
            lblPkmnName.caption = attribDialog.ebPkmnName.contents; // change the Pokemon's name
            lblPkmnHP.caption = PrintString(attribDialog.ebPkmnHP.contents, " HP"); // change the Pokemon's HP

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
            //if (attribDialog.ebPkmnIllus.contents)
            lblIllus.caption = ("Illus. ", attribDialog.ebPkmnIllus.contents);
         }
         return true;
      }
   };
   MenuItem Attack1Item
   {
      editMenu, "Edit POKéMON's First Attack...", 1, ctrl1;
   };
   MenuItem Attack2Item
   {
      editMenu, "Edit POKéMON's Second Attack...", 2, ctrl2;
   };

   AttribDialog attribDialog {};

   AboutDialog aboutDialog {};

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

   Label lblPkmnName { this, caption = "Purple Monkey", font = { "Tahoma", 15.0f }, position = { 120, 40 } };
   Label lblPkmnHP { this, caption = "30 HP", font = { "Tahoma", 15.0f }, position = { 325, 45 } };

   Label lblIllus { this, caption = "Illus. Charlie Griffin", font = { "Arial", 7.0f, italic = true  }, position = { 265, 570 }};

}

MainWin mainWin {};




