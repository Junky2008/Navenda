public class Style
{
        private string css = """
            .HeaderLabel
            {
            	font-size: 6em;
            }
            .ItemTitle
            {
            	font-size: 5em;
            }
            .ItemSubText
            {
            	font-size: 4em;
            }
            .Selected
            {
            	text-shadow: 0 0 10px #000000;
            }
        """;

	public Style(Gtk.Window window)
	{
		var provider = new Gtk.CssProvider();
		try
		{
 			provider.load_from_data(this.css, this.css.length);
                        var screen = window.get_screen();
			Gtk.StyleContext.add_provider_for_screen(screen, provider, Gtk.STYLE_PROVIDER_PRIORITY_USER);
  		}
		catch (GLib.Error e)
		{
			print ("Could not load CSS. %s\n", e.message);
		}
        }
}
