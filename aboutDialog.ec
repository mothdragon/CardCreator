import "ecere"

class AboutDialog : Window
{
   autoCreate = false;
   caption = "About POKéMON Card Creator";
   background = formColor;
   borderStyle = sizable;
   hasClose = true;
   size = { 504, 288 };
   anchor = { horz = -79, vert = -59 };

   Button button1 {
      this, caption = "OK", size = { 114, 29 }, position = { 176, 208 };
      bool NotifyClicked(Button button, int x, int y, Modifiers mods) { Destroy(0); return true; }
   };
   Label label4 { this, caption = "POKéMON Energy Symbols by: Karite-Kita-Neko(AKA Alex Bowen)", font = { "Tahoma", 10.25f }, position = { 48, 104 } };
   Label label5 { this, caption = "http://karite-kita-neko.deviantart.com", font = { "Tahoma", 10.25f }, position = { 240, 120 } };
   Label label3 { this, caption = "Coded in EC", font = { "Tahoma", 10.25f }, size = { 76, 21 }, position = { 200, 72 } };
   Label label1 { this, caption = "Written By: W. Charlie Griffin", font = { "Tahoma", 10.25f }, size = { 180, 21 }, position = { 144, 48 } };
   Label label2 { this, caption = "POKéMON Card Creator v 0.19", font = { "Tahoma", 20.25f }, size = { 372, 29 }, position = { 64, 8 } };
}




