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
            char extension[MAX_EXTENSION]; // create space to store the file extension for the image
            File fPkmnImage; // name our image file variable

            lblPkmnName.caption = attribDialog.ebPkmnName.contents; // change the Pokemon's name
// To Do: Add the "HP" to the end of the number so it's displayed properly
            lblPkmnHP.caption = attribDialog.ebPkmnHP.contents; // change the Pokemon's HP

            //Update the Pokemon image
            pkmnImage.fileName = attribDialog.ebPkmnImage.contents; // get the image filename from the dialog box
//Note: something about the following commented lines causes the program to stay in memory
// so we can't even compile a new one...
//            delete cardPkmn.image; // erase the old image so there's no memory conflicts
            AddResource(pkmnImage); // Add the Bitmap to our list of resources so it can be used
//            RemoveResource(cardPkmn.image); // Remove the old bitmap so we're not hogging memory
            cardPkmn.image = pkmnImage; // assign the new image to be displayed on the card.
//            switch attribDialog.dbPkmnEvo.DataRow
//            {
//               case 1:
//               {
//                  break;
//               }
//               case 2:
//               {
//                  break;
//               }
//               case 3:
//               {
//                  break;
//               }
//            }
         }
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
      }

   };


   Picture cardBack { this, position = { 32, 32 }, size = { 387, 557 }, image = { ":Card Base colorless.png" }};
   Picture cardEvo { this, position = { 16, 16 }, image = { ":basic.png" }};
   Picture cardEl { this, position = { 380, 38 }, size = { 30, 30 }, image = { ":Colorless.png" }};
   Picture cardPkmn {this, position = { 53, 77 }, size = { 347, 230} };

   Label lblPkmnName { this, caption = "Purple Monkey", font = { "Tahoma", 15.0f }, position = { 120, 40 } };
   Label lblPkmnHP { this, caption = "30 HP", font = { "Tahoma", 15.0f }, position = { 325, 45 } };

   Label lblIllus { this, caption = "Illus. Charlie Griffin", font = { "Arial", 7.0f, italic = true  }, position = { 265, 570 }};

}

MainWin mainWin {};




