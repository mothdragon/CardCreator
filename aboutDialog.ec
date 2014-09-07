import "ecere"

class LinkLabel : Label
{
   char * url;
   public property const char * url
   {
      set { delete url; url = CopyString(value); }
      get { return url; }
   }
   ~LinkLabel() { delete url; }
   font = { "Arial", 10, bold = true, underline = true };
   foreground = blue;
   cursor = ((GuiApplication)__thisModule.application).GetCursor(hand);

   bool OnLeftButtonDown(int x, int y, Modifiers mods)
   {
      if(url) ShellOpen(url);
      return true;
   }
};

class AboutDialog : Window
{
   caption = "About POKéMON Card Creator";
   background = formColor;
   borderStyle = sizable;
   hasClose = true;
   size = { 504, 288 };
   anchor = { horz = -79, vert = -59 };
   autoCreate = false;

   Button button1 {
      this, caption = "OK", size = { 114, 29 }, position = { 176, 208 };
      bool NotifyClicked(Button button, int x, int y, Modifiers mods) { Destroy(0); return true; }
   };
   Label label4 { this, caption = "POKéMON Energy Symbols by: Karite-Kita-Neko(AKA Alex Bowen)", font = { "Tahoma", 10.25f }, position = { 48, 104 } };
   LinkLabel { this, caption = "http://karite-kita-neko.deviantart.com", position = { 240, 120 } };
   Label label3 { this, caption = "Coded in eC", font = { "Tahoma", 10.25f }, size = { 76, 21 }, position = { 144, 72 } };
   LinkLabel { this, caption = "www.ecere.com", position = { 224, 72 } };
   Label label1 { this, caption = "Written By: W. Charlie Griffin", font = { "Tahoma", 10.25f }, size = { 180, 21 }, position = { 144, 48 } };
   Label label2 { this, caption = "POKéMON Card Creator v 0.19", font = { "Tahoma", 20.25f }, size = { 372, 29 }, position = { 64, 8 } };
}





