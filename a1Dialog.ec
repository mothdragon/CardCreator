import "ecere"

class A1Dialog : Window
{
   caption = "Edit POKéMONs First Attack";
   background = formColor;
   borderStyle = sizable;
   hasClose = true;
   size = { 248, 304 };
   anchor = { horz = -95, vert = -51 };
   autoCreate = false;

   Button btnOK
   {
      this, caption = $"OK", size = { 66, 29 }, position = { 160, 192 };
      bool NotifyClicked(Button button, int x, int y, Modifiers mods) { Destroy(DialogResult::ok); return true; }
   };

   Button btnCancel
   {
      this, caption = $"Cancel", size = { 68, 29 }, position = { 160, 232 };
      bool NotifyClicked(Button button, int x, int y, Modifiers mods) { Destroy(0); return false; }
   };
   Label lblA1Cost4 { this, caption = $"Four:", position = { 8, 248 } };
   DropBox dbA1Cost4 { this, caption = $"dropBox4", position = { 40, 240 } };
   Label lblA1Cost3 { this, caption = $"Three:", position = { 8, 216 } };
   DropBox dbA1Cost3 { this, caption = $"dropBox3", position = { 40, 208 } };
   Label lblA1Cost2 { this, caption = $"Two:", position = { 8, 184 } };
   DropBox dbA1Cost2 { this, caption = $"dropBox2", position = { 40, 176 } };
   Label lblA1Cost1 { this, caption = $"One:", position = { 8, 152 } };
   Label label1 { this, caption = $"Attack Cost:", position = { 8, 128 } };
   DropBox dbA1Cost1 { this, caption = $"dropBox1", position = { 40, 144 } };
   Label lblA1Name { this, caption = $"Attack Name:", position = { 8, 8 } };
   EditBox ebA1Name { this, caption = $"editBox1", size = { 142, 19 }, position = { 80, 8 } };
   Label lblA1Dmg { this, caption = $"Attack Damage:", position = { 8, 32 } };
   EditBox ebA1Dmg { this, caption = $"editBox2", size = { 46, 19 }, position = { 88, 32 } };
   Label lblA1Desc { this, caption = $"Attack Description:", position = { 8, 56 } };
   EditBox ebA1Desc { this, caption = $"editBox1", size = { 214, 51 }, position = { 8, 72 }, multiLine = true };

   A1Dialog()
   {
      // Load the Element Types for the Cost1 dropBox
      dbA1Cost1.AddString("(none)").tag = 1;
      dbA1Cost1.AddString("Poké-Body").tag = 2;
      dbA1Cost1.AddString("Poké-Power").tag = 3;
      dbA1Cost1.AddString("Colorless").tag = 4;
      dbA1Cost1.AddString("Darkness").tag = 5;
      dbA1Cost1.AddString("Dragon").tag = 6;
      dbA1Cost1.AddString("Fairy").tag = 7;
      dbA1Cost1.AddString("Fighting").tag = 8;
      dbA1Cost1.AddString("Fire").tag = 9;
      dbA1Cost1.AddString("Grass").tag = 10;
      dbA1Cost1.AddString("Lightning").tag = 11;
      dbA1Cost1.AddString("Metal").tag = 12;
      dbA1Cost1.AddString("Psychic").tag = 13;
      dbA1Cost1.AddString("Water").tag = 14;

      // Load the Element Types for the Cost2 dropBox
      dbA1Cost2.AddString("(none)").tag = 1;
      dbA1Cost2.AddString("Colorless").tag = 2;
      dbA1Cost2.AddString("Darkness").tag = 3;
      dbA1Cost2.AddString("Dragon").tag = 4;
      dbA1Cost2.AddString("Fairy").tag = 5;
      dbA1Cost2.AddString("Fighting").tag = 6;
      dbA1Cost2.AddString("Fire").tag = 7;
      dbA1Cost2.AddString("Grass").tag = 8;
      dbA1Cost2.AddString("Lightning").tag = 9;
      dbA1Cost2.AddString("Metal").tag = 10;
      dbA1Cost2.AddString("Psychic").tag = 11;
      dbA1Cost2.AddString("Water").tag = 12;

      // Load the Element Types for the Cost3 dropBox
      dbA1Cost3.AddString("(none)").tag = 1;
      dbA1Cost3.AddString("Colorless").tag = 2;
      dbA1Cost3.AddString("Darkness").tag = 3;
      dbA1Cost3.AddString("Dragon").tag = 4;
      dbA1Cost3.AddString("Fairy").tag = 5;
      dbA1Cost3.AddString("Fighting").tag = 6;
      dbA1Cost3.AddString("Fire").tag = 7;
      dbA1Cost3.AddString("Grass").tag = 8;
      dbA1Cost3.AddString("Lightning").tag = 9;
      dbA1Cost3.AddString("Metal").tag = 10;
      dbA1Cost3.AddString("Psychic").tag = 11;
      dbA1Cost3.AddString("Water").tag = 12;

      // Load the Element Types for the Cost4 dropBox
      dbA1Cost4.AddString("(none)").tag = 1;
      dbA1Cost4.AddString("Colorless").tag = 2;
      dbA1Cost4.AddString("Darkness").tag = 3;
      dbA1Cost4.AddString("Dragon").tag = 4;
      dbA1Cost4.AddString("Fairy").tag = 5;
      dbA1Cost4.AddString("Fighting").tag = 6;
      dbA1Cost4.AddString("Fire").tag = 7;
      dbA1Cost4.AddString("Grass").tag = 8;
      dbA1Cost4.AddString("Lightning").tag = 9;
      dbA1Cost4.AddString("Metal").tag = 10;
      dbA1Cost4.AddString("Psychic").tag = 11;
      dbA1Cost4.AddString("Water").tag = 12;
   }
}