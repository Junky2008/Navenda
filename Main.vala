GLib.List<Column> columns;
Gtk.Layout layout;
Vector2 size;
SelectedItemManager selectedColumn;
MovementManager movementManager;

int main(string[] args)
{
	Gtk.init(ref args);

	selectedColumn = new SelectedItemManager();
	movementManager = new MovementManager();
	try
	{
		unowned Thread<void*> movementThread = Thread.create<void*> (movementManager.run, true);
	}
	catch (ThreadError e)
	{
        	stderr.printf ("%s\n", e.message);
		return 1;
	}

	var window = new Gtk.Window();
	window.destroy.connect(Gtk.main_quit);
	layout = new Gtk.Layout();

	window.add(layout);

	window.show_all();
        window.fullscreen();


	var defaultScreen = Gdk.Screen.get_default();

        stdout.printf("height: %d, width: %d\n", defaultScreen.get_height(), defaultScreen.get_width());
	size = new Vector2(defaultScreen.get_height(), defaultScreen.get_width());

	addColumn(new Column("Videos", layout, size, selectedColumn, movementManager));
	addColumn(new Column("Music", layout, size, selectedColumn, movementManager));
	addColumn(new Column("Pictures", layout, size, selectedColumn, movementManager));

	new Style(window);

	window.show_all();
	window.key_press_event.connect(on_key_pressed);
	Gtk.main();

	return 0;
}

void addColumn(Column column)
{
	column.setId((int)columns.length() + 1);
	selectedColumn.setMax((int)columns.length());
	columns.append(column);
	column.update();
}

Column getActiveColumn()
{
	return columns.nth_data(selectedColumn.getSelected());
}

bool on_key_pressed (Gtk.Widget source, Gdk.EventKey key)
{
        if (key.str == "q")
        {
            Gtk.main_quit ();
        }
        else if (key.str == "d")
        {
        	selectedColumn.next();
        }
        else if (key.str == "a")
        {
        	selectedColumn.previous();
        }
        else if (key.str == "s")
        {
        	getActiveColumn().next();
        }
        else if (key.str == "w")
        {
        	getActiveColumn().previous();
        }
        else if (key.str == "f")
        {
        	Item activeItem = getActiveColumn().getActiveItem();
        	stdout.printf("Active ItemText = %s\n", activeItem.getSubText());
        }
        else
        {
        	stdout.printf("Key %s pressed\n", key.str);
        }


        for(int i = 0; i < columns.length(); i++)
        {
        	columns.nth_data(i).update();
        }

        return false;
}
