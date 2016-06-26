GLib.List<Column> columns;
Gtk.Layout layout;
Vector2 size;

int main(string[] args)
{
	Gtk.init(ref args);

	var builder = new Gtk.Builder();

	try
	{
		/* Getting the glade file */
		builder.add_from_file("../src/MainWindow.glade");
	}
	catch(GLib.Error e)
	{
		Gtk.main_quit();
	}
	builder.connect_signals(null);

	var window = builder.get_object("MainWindow") as Gtk.Window;
	window.destroy.connect(Gtk.main_quit);
	layout = builder.get_object("MainLayout") as Gtk.Layout;

	window.show_all();
        window.fullscreen();


	var defaultScreen = Gdk.Screen.get_default();

        stdout.printf("height: %d, width: %d\n", defaultScreen.get_height(), defaultScreen.get_width());
	size = new Vector2(defaultScreen.get_height(), defaultScreen.get_width());

	columns.append(new Column(1, "Videos", layout, size));
	columns.append(new Column(2, "Music", layout, size));
	columns.append(new Column(3, "Pictures", layout, size));

	new Style(window);

	window.show_all();
	window.key_press_event.connect(on_key_pressed);
	Gtk.main();

	return 0;
}

Column getActiveColumn()
{
	for(int i = 0; i < columns.length(); i++)
	{
		if(columns.nth_data(i).getId() == 1)
		{
			return columns.nth_data(i);
		}
	}
	return null;
}

bool on_key_pressed (Gtk.Widget source, Gdk.EventKey key)
{
        if (key.str == "q")
        {
            Gtk.main_quit ();
        }
        if (key.str == "d")
        {
		for(int i = 0; i < columns.length(); i++)
		{
			columns.nth_data(i).idDown();
		}
        }
        else if (key.str == "a")
        {
		for(int i = 0; i < columns.length(); i++)
		{
			columns.nth_data(i).idUp();
		}
        }
        else if (key.str == "s")
        {
        	var activeColumn = getActiveColumn();
        	if(activeColumn != null)
        	{
        		activeColumn.itemIdDown();
        	}
        }
        else if (key.str == "w")
        {
        	var activeColumn = getActiveColumn();
        	if(activeColumn != null)
        	{
        		activeColumn.itemIdUp();
        	}
        }

        return false;
}
