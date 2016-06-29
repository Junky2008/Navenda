public class Column
{
	private int Id;
	private GLib.List<Item> Items;
	private string Name;
	private Gtk.Label ItemHeader;
	private Vector2 Location;
	private Vector2 Size;
	private SelectedItemManager SelectedColumn;
	private SelectedItemManager SelectedItem;
	private MovementManager MovementManager;

	public Column(string name, Gtk.Layout layout, Vector2 size, SelectedItemManager selectedColumn, MovementManager movementManager)
	{
		Id = 0;
		MovementManager = movementManager;
		SelectedColumn = selectedColumn;
		SelectedItem = new SelectedItemManager();
		Name = name;
		Size = size;
		Location = new Vector2(0, 0);
		ItemHeader = new Gtk.Label(name);
		ItemHeader.get_style_context().add_class("HeaderLabel");
		var user = GLib.Environment.get_variable("USER");
		var path = "/home/" + user + "/" + name;
		stdout.printf ("path: %s\n", path);

		GLib.Dir d;

		try
		{
			d = GLib.Dir.open(path);
                        while ( ( name = d.read_name( ) ) != null )
                        {
                            string file = GLib.Path.build_filename( path, name );
                            stdout.printf ("file: %s\n", file);
                            addItem(new Item(name, file, layout, size, SelectedItem));
                        }
		}
		catch(GLib.FileError e)
		{

		}

		layout.add(ItemHeader);
		update();
	}

	public void addItem(Item item)
	{
		item.setId((int)Items.length() + 1);
		SelectedItem.setMax((int)Items.length());
		Items.append(item);
		item.update();
	}

	public void calculateLocation()
	{
		int id = Id - selectedColumn.getSelected();
		Location.set((Size.getX() / 5) * id, (Size.getY() / 6));
	}

	public void update()
	{
		draw();
	}

	public void updateItems()
	{
		for(int i = 0; i < Items.length(); i++)
		{
			Items.nth_data(i).update();
		}
	}

	public void next()
	{
		SelectedItem.next();
		updateItems();
	}

	public void previous()
	{
		SelectedItem.previous();
		updateItems();
	}

	public void setId(int id)
	{
		Id = id;
	}

	public void draw()
	{
		var fromLocation = new Vector2(Location.getX(), Location.getY());
		calculateLocation();
		var targetLocation = new Vector2(Location.getX(), Location.getY());
		int id = Id - selectedColumn.getSelected();
		ItemHeader.get_style_context().remove_class("Selected");
		if(id == 1)
		{
			ItemHeader.get_style_context().add_class("Selected");
		}

		MovementManager.addMovement(new Movement(layout, ItemHeader, fromLocation, targetLocation, 500));
		//layout.move(ItemHeader, Location.getX(), Location.getY());

		for(int i = 0; i < Items.length(); i++)
		{
			if(id == 1)
			{
				Items.nth_data(i).show();
			}
			else
			{
				Items.nth_data(i).hide();
			}
		}
	}

	public Item getActiveItem()
	{
		return Items.nth_data(SelectedItem.getSelected());
	}
}
