import "ecere"

class A2Dialog : Window
{
   caption = "Edit POKéMONs Second Attack";
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
   Label lblA2Cost4 { this, caption = $"Four:", position = { 8, 248 } };
   DropBox dbA2Cost4 { this, caption = $"dropBox4", position = { 40, 240 } };
   Label lblA2Cost3 { this, caption = $"Three:", position = { 8, 216 } };
   DropBox dbA2Cost3 { this, caption = $"dropBox3", position = { 40, 208 } };
   Label lblA2Cost2 { this, caption = $"Two:", position = { 8, 184 } };
   DropBox dbA2Cost2 { this, caption = $"dropBox2", position = { 40, 176 } };
   Label lblA2Cost1 { this, caption = $"One:", position = { 8, 152 } };
   Label label1 { this, caption = $"Attack Cost:", position = { 8, 128 } };
   DropBox dbA2Cost1 { this, caption = $"dropBox1", position = { 40, 144 } };
   Label lblA2Name { this, caption = $"Attack Name:", position = { 8, 8 } };
   EditBox ebA2Name { this, caption = $"editBox1", size = { 142, 19 }, position = { 80, 8 } };
   Label lblA2Dmg { this, caption = $"Attack Damage:", position = { 8, 32 } };
   EditBox ebA2Dmg { this, caption = $"editBox2", size = { 46, 19 }, position = { 88, 32 } };
   Label lblA2Desc { this, caption = $"Attack Description:", position = { 8, 56 } };
   EditBox ebA2Desc { this, caption = $"editBox1", size = { 214, 51 }, position = { 8, 72 }, multiLine = true };

   A2Dialog()
   {
      // Load the Element Types for the Cost1 dropBox
      dbA2Cost1.AddString("(none)").tag = 1;
      dbA2Cost1.AddString("Colorless").tag = 2;
      dbA2Cost1.AddString("Darkness").tag = 3;
      dbA2Cost1.AddString("Dragon").tag = 4;
      dbA2Cost1.AddString("Fairy").tag = 5;
      dbA2Cost1.AddString("Fighting").tag = 6;
      dbA2Cost1.AddString("Fire").tag = 7;
      dbA2Cost1.AddString("Grass").tag = 8;
      dbA2Cost1.AddString("Lightning").tag = 9;
      dbA2Cost1.AddString("Metal").tag = 10;
      dbA2Cost1.AddString("Psychic").tag = 11;
      dbA2Cost1.AddString("Water").tag = 12;

      // Load the Element Types for the Cost2 dropBox
      dbA2Cost2.AddString("(none)").tag = 1;
      dbA2Cost2.AddString("Colorless").tag = 2;
      dbA2Cost2.AddString("Darkness").tag = 3;
      dbA2Cost2.AddString("Dragon").tag = 4;
      dbA2Cost2.AddString("Fairy").tag = 5;
      dbA2Cost2.AddString("Fighting").tag = 6;
      dbA2Cost2.AddString("Fire").tag = 7;
      dbA2Cost2.AddString("Grass").tag = 8;
      dbA2Cost2.AddString("Lightning").tag = 9;
      dbA2Cost2.AddString("Metal").tag = 10;
      dbA2Cost2.AddString("Psychic").tag = 11;
      dbA2Cost2.AddString("Water").tag = 12;

      // Load the Element Types for the Cost3 dropBox
      dbA2Cost3.AddString("(none)").tag = 1;
      dbA2Cost3.AddString("Colorless").tag = 2;
      dbA2Cost3.AddString("Darkness").tag = 3;
      dbA2Cost3.AddString("Dragon").tag = 4;
      dbA2Cost3.AddString("Fairy").tag = 5;
      dbA2Cost3.AddString("Fighting").tag = 6;
      dbA2Cost3.AddString("Fire").tag = 7;
      dbA2Cost3.AddString("Grass").tag = 8;
      dbA2Cost3.AddString("Lightning").tag = 9;
      dbA2Cost3.AddString("Metal").tag = 10;
      dbA2Cost3.AddString("Psychic").tag = 11;
      dbA2Cost3.AddString("Water").tag = 12;

      // Load the Element Types for the Cost4 dropBox
      dbA2Cost4.AddString("(none)").tag = 1;
      dbA2Cost4.AddString("Colorless").tag = 2;
      dbA2Cost4.AddString("Darkness").tag = 3;
      dbA2Cost4.AddString("Dragon").tag = 4;
      dbA2Cost4.AddString("Fairy").tag = 5;
      dbA2Cost4.AddString("Fighting").tag = 6;
      dbA2Cost4.AddString("Fire").tag = 7;
      dbA2Cost4.AddString("Grass").tag = 8;
      dbA2Cost4.AddString("Lightning").tag = 9;
      dbA2Cost4.AddString("Metal").tag = 10;
      dbA2Cost4.AddString("Psychic").tag = 11;
      dbA2Cost4.AddString("Water").tag = 12;
   }
}