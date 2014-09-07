import "ecere"

static FileFilter imgFilters[] =
{
   { "Image Files (*.jpg, *.jpeg, *.bmp, *.pcx, *.png, *.gif)", "jpg, jpeg, bmp, pcx, png, gif" },
   { "All files", null }
};

static FileType imgTypes[] =
{
   { "Image Files", "jpg, jpeg, bmp, pcx, png, gif", always }
};

public enum ElTypes
{
   Colorless, Darkness, Dragon, Fairy, Fighting, Fire, Grass, Lightning, Metal, Psychic, Water
};

public enum EvoStages
{
   Basic, One, Two
};

class AttribDialog : Window
{
   autoCreate = false;
   caption = "Edit POKéMON Attributes";
   background = formColor;
   borderStyle = sizable;
   hasClose = true;
   size = { 504, 288 };
   anchor = { horz = -79, vert = -59 };



   ElTypes pkmnType;
   EvoStages pkmnEvo;

   Button btnOK {
      this, caption = "OK", size = { 98, 29 }, position = { 136, 216 };
      bool NotifyClicked(Button button, int x, int y, Modifiers mods) { Destroy(DialogResult::ok); return true; }
   };
   Button btnCancel {
      this, caption = "Cancel", size = { 100, 29 }, position = { 248, 216 };
      bool NotifyClicked(Button button, int x, int y, Modifiers mods) { Destroy(0); return false; }
   };
   EditBox ebPkmnImage { this, caption = "editBox1", size = { 238, 19 }, position = { 192, 184 } };
   Button btnPkmnImageBrowse {
      this, caption = "...", size = { 26, 21 }, position = { 432, 184 };
      bool NotifyClicked(Button button, int x, int y, Modifiers mods)
      {
         imgPickDialog.Modal();
         if(imgPickDialog.Modal() == ok) // open the file dialog box, and wait for confirmation that all is okay.
         {
            ebPkmnImage.contents = imgPickDialog.filePath; // display the selected directory in the edit box
         }
         return true;

      }
   };
   Label lblPkmnImage { this, caption = "Choose the image for your POKéMON:", position = { 8, 184 } };
   DropBox dbPkmnRetCost { this, size = { 56, 24 }, position = { 328, 128 } };
   Label lblPkmnComments { this, caption = "Comments:", position = { 8, 80 } };
   EditBox ebPkmnComments { this, caption = "editBox1", size = { 294, 59 }, position = { 8, 96 } };
   Label lblPkmnIllus { this, caption = "Illustrator:", position = { 8, 160 } };
   EditBox ebPkmnIllus { this, caption = "editBox1", size = { 238, 19 }, position = { 64, 160 } };
   Label lblPkmnRetCost { this, caption = "Retreat Cost:", position = { 328, 112 } };
   Label lblPkmnRes { this, caption = "Resistance:", position = { 328, 72 } };
   DropBox dbPkmnResEl {
      this, size = { 88, 24 }, position = { 328, 88 };
   };
//   DataRow row = dbPkmnResEl.AddString($"(none)");
//   SavingDataBox dbPkmnResEl {
//      this, size = { 88, 24 }, position = { 328, 88 };
//      data = &pkmnType, type = class(ElTypes);
//   };
   DropBox dbPkmnResAmt { this, size = { 56, 24 }, position = { 424, 88 } };

   Label lblPkmnWeak { this, caption = "Weakness:", position = { 328, 32 } };
   DropBox dbPkmnWeakEl {
      this, size = { 88, 24 }, position = { 328, 48 };
   };
   DropBox dbPkmnWeakAmt { this, caption = "dropBox1", size = { 56, 24 }, position = { 424, 48 } };
   Label lblPkmnEl { this, caption = "Choose an element type:", position = { 184, 32 } };
   Label lblPkmnEvo { this, caption = "Choose the stage of evolution:", position = { 8, 32 } };
   DropBox dbPkmnEvo { this, size = { 152, 24 }, position = { 8, 48 } };
//      bool NotifySelect(DropBox control, DataRow row, Modifiers mods)
//      {
//         fileFilter = (int)(row ? row.tag : 0);
//         ListFiles();
//         return true;
//      }
//   }

   DropBox dbPkmnEl {
      this, size = { 120, 24 }, position = { 184, 48 };
//      data = &pkmnType, type = class(ElTypes);
   };
   Label lblPkmnName { this, caption = "Name your POKéMON:", position = { 8, 8 } };
   EditBox ebPkmnName { this, caption = "editBox1", size = { 182, 19 }, position = { 120, 8 } };
   Label lblPkmnHP { this, caption = "POKéMONs HP:", position = { 320, 8 } };
   EditBox ebPkmnHP { this, caption = "editBox1", position = { 400, 8 } };;
   FileDialog imgPickDialog
   {
      master = this, type = open, text = "Select the image for your POKéMON",
      types = imgTypes, sizeTypes = sizeof(imgTypes), filters = imgFilters, sizeFilters = sizeof(imgFilters)
   };

   AttribDialog()
   {
      // Load the different Evolutions to the Evolution dropBox
      dbPkmnEvo.AddString("Basic").tag = 1;
      dbPkmnEvo.AddString("Stage 1").tag = 2;
      dbPkmnEvo.AddString("Stage 2").tag = 3;

      dbPkmnEl.AddString("Colorless").tag = 1;
      dbPkmnEl.AddString("Darkness").tag = 2;
      dbPkmnEl.AddString("Dragon").tag = 3;
      dbPkmnEl.AddString("Fairy").tag = 4;
      dbPkmnEl.AddString("Fighting").tag = 5;
      dbPkmnEl.AddString("Fire").tag = 6;
      dbPkmnEl.AddString("Grass").tag = 7;
      dbPkmnEl.AddString("Lightning").tag = 8;
      dbPkmnEl.AddString("Metal").tag = 9;
      dbPkmnEl.AddString("Psychic").tag = 10;
      dbPkmnEl.AddString("Water").tag = 11;

      // Load the various Retreat Costs
      dbPkmnRetCost.AddString("0").tag = 1;
      dbPkmnRetCost.AddString("1").tag = 2;
      dbPkmnRetCost.AddString("2").tag = 3;
      dbPkmnRetCost.AddString("3").tag = 4;
      dbPkmnRetCost.AddString("4").tag = 5;

      // Load the Element Types to the Resistant dropBox
      dbPkmnResEl.AddString("(none)").tag = 1;
      dbPkmnResEl.AddString("Colorless").tag = 2;
      dbPkmnResEl.AddString("Darkness").tag = 3;
      dbPkmnResEl.AddString("Dragon").tag = 4;
      dbPkmnResEl.AddString("Fairy").tag = 5;
      dbPkmnResEl.AddString("Fighting").tag = 6;
      dbPkmnResEl.AddString("Fire").tag = 7;
      dbPkmnResEl.AddString("Grass").tag = 8;
      dbPkmnResEl.AddString("Lightning").tag = 9;
      dbPkmnResEl.AddString("Metal").tag = 10;
      dbPkmnResEl.AddString("Psychic").tag = 11;
      dbPkmnResEl.AddString("Water").tag = 12;

      //Load the amount of resistance to the resistant dropbox
      dbPkmnResAmt.AddString("(none)").tag = 1;
      dbPkmnResAmt.AddString("+10").tag = 2;
      dbPkmnResAmt.AddString("+20").tag = 3;
      dbPkmnResAmt.AddString("+30").tag = 4;
      dbPkmnResAmt.AddString("+40").tag = 5;
      dbPkmnResAmt.AddString("x2").tag = 6;

      // Load the Element Types to the Weakness dropBox
      dbPkmnWeakEl.AddString("(none)").tag = 1;
      dbPkmnWeakEl.AddString("Colorless").tag = 2;
      dbPkmnWeakEl.AddString("Darkness").tag = 3;
      dbPkmnWeakEl.AddString("Dragon").tag = 4;
      dbPkmnWeakEl.AddString("Fairy").tag = 5;
      dbPkmnWeakEl.AddString("Fighting").tag = 6;
      dbPkmnWeakEl.AddString("Fire").tag = 7;
      dbPkmnWeakEl.AddString("Grass").tag = 8;
      dbPkmnWeakEl.AddString("Lightning").tag = 9;
      dbPkmnWeakEl.AddString("Metal").tag = 10;
      dbPkmnWeakEl.AddString("Psychic").tag = 11;
      dbPkmnWeakEl.AddString("Water").tag = 12;

      // Load the amount of Weakness to the Weakness dropbox
      dbPkmnWeakAmt.AddString("(none)").tag = 1;
      dbPkmnWeakAmt.AddString("+10").tag = 2;
      dbPkmnWeakAmt.AddString("+20").tag = 3;
      dbPkmnWeakAmt.AddString("+30").tag = 4;
      dbPkmnWeakAmt.AddString("+40").tag = 5;
      dbPkmnWeakAmt.AddString("x2").tag = 6;
   }

}

