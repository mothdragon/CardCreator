import "ecere"
import "attribDialog"
import "aboutDialog"
import "a1Dialog"
import "a2Dialog"

#define MAX_NAME_SIZE 24

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
   isDocument = true;

   BitmapResource pkmnImage { window = this };
   BitmapResource pkmnEvFrmImage { window = this };

   Menu fileMenu { menu, "File", f };
   MenuItem openItem
   {
      fileMenu, "Open", o, ctrlO;

      bool NotifySelect(MenuItem selection, Modifiers mods)
      {
         if(openDialog.Modal() == ok)
         {
            OnLoadFile(openDialog.filePath);
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

   bool OnSaveFile(const char * fileName)
   {
      File f = FileOpen(fileName, write);
      if(f)
      {
         f.Put(cardBack.fileName);
         f.Put(cardPkmn);
         f.Put(cardPkmnEvFrm);
         f.Put(cardEvo);
         f.Put(cardEl);
         f.Put(cardWeak);
         f.Put(cardWeakAmt);
         f.Put(cardRes);
         f.Put(cardResAmt);
         f.Put(cardRetCost1);
         f.Put(cardRetCost2);
         f.Put(cardRetCost3);
         f.Put(cardRetCost4);
         f.Write(lblPkmnName.caption, 1, MAX_NAME_SIZE);
         f.Put(lblPkmnHP.caption);
         f.Put(lblPkmnHPAmt.caption);
         f.Put(lblA1Name.caption);
         f.Put(a1Cost1);
         f.Put(a1Cost2);
         f.Put(a1Cost3);
         f.Put(a1Cost4);
         f.Put(lblA1Dmg.caption);
         f.Put(ebA1Desc.contents);
         f.Put(lblA2Name.caption);
         f.Put(a2Cost1);
         f.Put(a2Cost2);
         f.Put(a2Cost3);
         f.Put(a2Cost4);
         f.Put(lblA2Dmg.caption);
         f.Put(ebA2Desc.contents);
         f.Put(lblIllus.caption);
         modifiedDocument = false;
      }
      delete f;
      return true;
   }
   bool OnLoadFile(const char * fileName)
   {
      char TempName[MAX_NAME_SIZE];
      File f = FileOpen(fileName, read);
//      MessageBox(0, "Hello World!");
      if(f)
      {
         f.Get(cardBack);
//         MessageBox(0, cardBack
         f.Get(cardPkmn);
         f.Get(cardPkmnEvFrm);
         f.Get(cardEvo);
         f.Get(cardEl);
         f.Get(cardWeak);
         f.Get(cardWeakAmt);
         f.Get(cardRes);
         f.Get(cardResAmt);
         f.Get(cardRetCost1);
         f.Get(cardRetCost2);
         f.Get(cardRetCost3);
         f.Get(cardRetCost4);
//         f.Read(lblPkmnName);
         f.Read(TempName, 1, sizeof(TempName));
         lblPkmnName.caption = TempName;
         f.Get(lblPkmnHP);
         f.Get(lblPkmnHPAmt);
         f.Get(lblA1Name);
         f.Get(a1Cost1);
         f.Get(a1Cost2);
         f.Get(a1Cost3);
         f.Get(a1Cost4);
         f.Get(lblA1Dmg);
         f.Get(ebA1Desc);
         f.Get(lblA2Name);
         f.Get(a2Cost1);
         f.Get(a2Cost2);
         f.Get(a2Cost3);
         f.Get(a2Cost4);
         f.Get(lblA2Dmg);
         f.Get(ebA2Desc);
         f.Get(lblIllus);
         modifiedDocument = false;
         Update(null);
      }
      delete f;
      return true;
   }
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

            pkmnEvFrmImage.fileName = attribDialog.ebPkmnEvImg.contents; // get the image filename from the dialog box
//Note: something about the following commented lines causes the program to stay in memory
// so we can't even compile a new one...
//            delete cardPkmn.image; // erase the old image so there's no memory conflicts
            AddResource(pkmnEvFrmImage); // Add the Bitmap to our list of resources so it can be used
//            RemoveResource(cardPkmn.image); // Remove the old bitmap so we're not hogging memory
            cardPkmnEvFrm.image = pkmnEvFrmImage; // assign the new image to be displayed on the card.

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
                  fColor = black;
                  break;
               }
               case 2:
               {
                  cardBack.image = { ":Card Base darkness.png" };
                  cardEl.image = { ":Darkness.png" };
                  fColor = white;
                  break;
               }
               case 3:
               {
                  cardBack.image = { ":Card Base dragon.png" };
                  cardEl.image = { ":Dragon.png" };
                  fColor = black;
                  break;
               }
               case 4:
               {
                  cardBack.image = { ":Card Base fairy.png" };
                  cardEl.image = { ":fairy.png" };
                  fColor = black;
                  break;
               }
               case 5:
               {
                  cardBack.image = { ":Card Base fighting.png" };
                  cardEl.image = { ":Fighting.png" };
                  fColor = black;
                  break;
               }
               case 6:
               {
                  cardBack.image = { ":Card Base fire.png" };
                  cardEl.image = { ":Fire.png" };
                  fColor = black;
                  break;
               }
               case 7:
               {
                  cardBack.image = { ":Card Base grass.png" };
                  cardEl.image = { ":Grass.png" };
                  fColor = black;
                  break;
               }
               case 8:
               {
                  cardBack.image = { ":Card Base lightning.png" };
                  cardEl.image = { ":Lightning.png" };
                  fColor = black;
                  break;
               }
               case 9:
               {
                  cardBack.image = { ":Card Base metal.png" };
                  cardEl.image = { ":Metal.png" };
                  fColor = black;
                  break;
               }
               case 10:
               {
                  cardBack.image = { ":Card Base psychic.png" };
                  cardEl.image = { ":Psychic.png" };
                  fColor = black;
                  break;
               }
               case 11:
               {
                  cardBack.image = { ":Card Base water.png" };
                  cardEl.image = { ":Water.png" };
                  fColor = black;
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
      bool NotifySelect(MenuItem selection, Modifiers mods)
      {
         if(a2Dialog.Modal() == ok)
         {
            lblA2Name.caption = a2Dialog.ebA2Name.contents;
            lblA2Dmg.caption = a2Dialog.ebA2Dmg.contents;
            ebA2Desc.contents = a2Dialog.ebA2Desc.contents;
            switch(a2Dialog.dbA2Cost1.currentRow.tag)
            {
               case 1:
               {
                  a2Cost1.image = null;
                  a2Cost2.image = null;
                  a2Cost3.image = null;
                  a2Cost4.image = null;
                  break;
               }
               case 2:
               {
                  a2Cost1.image = { ":Colorless.png" };
                  break;
               }
               case 3:
               {
                  a2Cost1.image = { ":Darkness.png" };
                  break;
               }
               case 4:
               {
                  a2Cost1.image = { ":Dragon.png" };
                  break;
               }
               case 5:
               {
                  a2Cost1.image = { ":fairy.png" };
                  break;
               }
               case 6:
               {
                  a2Cost1.image = { ":Fighting.png" };
                  break;
               }
               case 7:
               {
                  a2Cost1.image = { ":Fire.png" };
                  break;
               }
               case 8:
               {
                  a2Cost1.image = { ":Grass.png" };
                  break;
               }
               case 9:
               {
                  a2Cost1.image = { ":Lightning.png" };
                  break;
               }
               case 10:
               {
                  a2Cost1.image = { ":Metal.png" };
                  break;
               }
               case 11:
               {
                  a2Cost1.image = { ":Psychic.png" };
                  break;
               }
               case 12:
               {
                  a2Cost1.image = { ":Water.png" };
                  break;
               }
            }
            switch(a2Dialog.dbA2Cost2.currentRow.tag)
            {
               case 1:
               {
                  a2Cost2.image = null;
                  a2Cost3.image = null;
                  a2Cost4.image = null;
                  break;
               }
               case 2:
               {
                  a2Cost2.image = { ":Colorless.png" };
                  break;
               }
               case 3:
               {
                  a2Cost2.image = { ":Darkness.png" };
                  break;
               }
               case 4:
               {
                  a2Cost2.image = { ":Dragon.png" };
                  break;
               }
               case 5:
               {
                  a2Cost2.image = { ":fairy.png" };
                  break;
               }
               case 6:
               {
                  a2Cost2.image = { ":Fighting.png" };
                  break;
               }
               case 7:
               {
                  a2Cost2.image = { ":Fire.png" };
                  break;
               }
               case 8:
               {
                  a2Cost2.image = { ":Grass.png" };
                  break;
               }
               case 9:
               {
                  a2Cost2.image = { ":Lightning.png" };
                  break;
               }
               case 10:
               {
                  a2Cost2.image = { ":Metal.png" };
                  break;
               }
               case 11:
               {
                  a2Cost2.image = { ":Psychic.png" };
                  break;
               }
               case 12:
               {
                  a2Cost2.image = { ":Water.png" };
                  break;
               }
            }
            switch(a2Dialog.dbA2Cost3.currentRow.tag)
            {
               case 1:
               {
                  a2Cost3.image = null;
                  a2Cost4.image = null;
                  break;
               }
               case 2:
               {
                  a2Cost3.image = { ":Colorless.png" };
                  break;
               }
               case 3:
               {
                  a2Cost3.image = { ":Darkness.png" };
                  break;
               }
               case 4:
               {
                  a2Cost3.image = { ":Dragon.png" };
                  break;
               }
               case 5:
               {
                  a2Cost3.image = { ":fairy.png" };
                  break;
               }
               case 6:
               {
                  a2Cost3.image = { ":Fighting.png" };
                  break;
               }
               case 7:
               {
                  a2Cost3.image = { ":Fire.png" };
                  break;
               }
               case 8:
               {
                  a2Cost3.image = { ":Grass.png" };
                  break;
               }
               case 9:
               {
                  a2Cost3.image = { ":Lightning.png" };
                  break;
               }
               case 10:
               {
                  a2Cost3.image = { ":Metal.png" };
                  break;
               }
               case 11:
               {
                  a2Cost3.image = { ":Psychic.png" };
                  break;
               }
               case 12:
               {
                  a2Cost3.image = { ":Water.png" };
                  break;
               }
            }
            switch(a2Dialog.dbA2Cost4.currentRow.tag)
            {
               case 1:
               {
                  a2Cost4.image = null;
                  break;
               }
               case 2:
               {
                  a2Cost4.image = { ":Colorless.png" };
                  break;
               }
               case 3:
               {
                  a2Cost4.image = { ":Darkness.png" };
                  break;
               }
               case 4:
               {
                  a2Cost4.image = { ":Dragon.png" };
                  break;
               }
               case 5:
               {
                  a2Cost4.image = { ":fairy.png" };
                  break;
               }
               case 6:
               {
                  a2Cost4.image = { ":Fighting.png" };
                  break;
               }
               case 7:
               {
                  a2Cost4.image = { ":Fire.png" };
                  break;
               }
               case 8:
               {
                  a2Cost4.image = { ":Grass.png" };
                  break;
               }
               case 9:
               {
                  a2Cost4.image = { ":Lightning.png" };
                  break;
               }
               case 10:
               {
                  a2Cost4.image = { ":Metal.png" };
                  break;
               }
               case 11:
               {
                  a2Cost4.image = { ":Psychic.png" };
                  break;
               }
               case 12:
               {
                  a2Cost4.image = { ":Water.png" };
                  break;
               }
            }
         }
         return true;
      }
   };
   AttribDialog attribDialog {};
   AboutDialog aboutDialog {};
   A1Dialog a1Dialog {};
   A2Dialog a2Dialog {};
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
// Why doesn't fColor change with Darkness type?
   Color fColor { 0x000000 };
   Picture cardBack { this, position = { 32, 32 }, size = { 387, 557 }, image = { ":Card Base colorless.png" }};
   Picture cardPkmn { this, position = { 53, 77 }, size = { 347, 230} };

   Picture cardPkmnEvFrm {this, position = { 30, 50 }, size = { 100, 70 } };

   Picture cardEvo { this, position = { 16, 16 }, image = { ":basic.png" }};
   Picture cardEl { this, position = { 380, 38 }, size = { 30, 30 }, image = { ":Colorless.png" }};
   Picture cardWeak { this, position = { 52, 529 }, size = { 19, 19 }, image = null };
   Label cardWeakAmt { this, caption = "", foreground = fColor, font = { "Arial", 12.0f, bold = true }, position = { 73, 530 } };
   Picture cardRes { this, position = { 128, 529 }, size = { 19, 19 }, image = null };
   Label cardResAmt { this, caption = "", foreground = fColor, font = { "Arial", 12.0f, bold = true }, position = { 149, 530 } };
   Picture cardRetCost1 { this, position = { 90, 560 }, size = { 19, 19 }, image = {":Colorless.png"} };
   Picture cardRetCost2 { this, position = { 115, 560 }, size = { 19, 19 }, image = {":Colorless.png"} };
   Picture cardRetCost3 { this, position = { 140, 560 }, size = { 19, 19 }, image = {":Colorless.png"} };
   Picture cardRetCost4 { this, position = { 165, 560 }, size = { 19, 19 }, image = {":Colorless.png"} };
   Label lblPkmnName { this, caption = "Purple Monkey", foreground = fColor, font = { "Arial", 15.0f, bold = true }, position = { 118, 40 } };
   Label lblPkmnHP { this, caption = "HP", foreground = fColor, font = { "Tahoma", 10.0f, bold = true }, position = { 325, 53 } };
   Label lblPkmnHPAmt { this, caption = "30", foreground = fColor, font = { "Arial", 15.0f, bold = true }, position = { 343, 47} };
   Label lblA1Name { this, caption = "Slap", foreground = fColor, font = { "Arial", 17.0f, bold = true }, position = { 156, 337 } };
   Picture a1Cost1 { this, position = { 36, 336 }, size = { 30, 30 }, image = {":Colorless.png"} };
   Picture a1Cost2 { this, position = { 64, 336 }, size = { 30, 30 }, image = {":Colorless.png"} };
   Picture a1Cost3 { this, position = { 92, 336 }, size = { 30, 30 }, image = {":Colorless.png"} };
   Picture a1Cost4 { this, position = { 120, 336 }, size = { 30, 30 }, image = {":Colorless.png"} };
   Label lblA1Dmg { this, caption = "10+", foreground = fColor, font = { "Arial", 17.0f, bold = true }, position = { 365, 337 } };
   EditBox ebA1Desc{ this, background = formColor, 0, borderStyle = none, inactive = true, foreground = fColor, font = { "Arial", 10 }, size = { 369, 67 }, position = { 36, 365 }, scrollArea = { 1576, 67 }, readOnly = true, true, noCaret = true, noSelect = true, wrap = true, contents = "Slap does 10 damage to your opponents Defending Pokemon, as well as 10 damage to each of your opponents benched Pokemon. If your opponent has no benched pokemon, this attack does 20 damage to the opponents Defending Pokemon. Need to make this even longer for testing ;)" };
   Label lblA2Name { this, caption = "Slap", foreground = fColor, font = { "Arial", 17.0f, bold = true }, position = { 156, 425 } };
   Picture a2Cost1 { this, position = { 36, 424 }, size = { 30, 30 }, image = {":Colorless.png"} };
   Picture a2Cost2 { this, position = { 64, 424 }, size = { 30, 30 }, image = {":Colorless.png"} };
   Picture a2Cost3 { this, position = { 92, 424 }, size = { 30, 30 }, image = {":Colorless.png"} };
   Picture a2Cost4 { this, position = { 120, 424 }, size = { 30, 30 }, image = {":Colorless.png"} };
   Label lblA2Dmg { this, caption = "10+", foreground = fColor, font = { "Arial", 17.0f, bold = true }, position = { 365, 425 } };
   EditBox ebA2Desc{ this, background = formColor, 0, borderStyle = none, inactive = true, foreground = fColor, font = { "Arial", 10 }, size = { 369, 67 }, position = { 36, 453 }, scrollArea = { 1576, 67 }, readOnly = true, true, noCaret = true, noSelect = true, wrap = true, contents = "Slap does 10 damage to your opponents Defending Pokemon, as well as 10 damage to each of your opponents benched Pokemon. If your opponent has no benched pokemon, this attack does 20 damage to the opponents Defending Pokemon. Need to make this even longer for testing ;)" };

   Label lblIllus { this, caption = "Illus. Charlie Griffin", foreground = fColor, font = { "Arial", 7.0f, italic = true  }, position = { 265, 570 }};
}

MainWin mainWin {};




