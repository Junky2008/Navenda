public class Column
{
	private int Id;
	private GLib.List<Item> Items;
	private string Name;
	private Gtk.Label ItemHeader;
	private Vector2 Location;
	private Vector2 Size;

	public Column(int id, string name, Gtk.Layout layout, Vector2 size)
	{
		setId(id);
		Name = name;
		Size = size;
		ItemHeader = new Gtk.Label(name);
		ItemHeader.get_style_context().add_class("HeaderLabel");
		var user = GLib.Environment.get_variable("USER");
		var path = "/home/" + user + "/" + name;
		stdout.printf ("path: %s\n", path);

		GLib.Dir d;

		try
		{
			d = GLib.Dir.open(path);
			var itemId = 1;
                        while ( ( name = d.read_name( ) ) != null )
                        {
                            string file = GLib.Path.build_filename( path, name );
                            stdout.printf ("file: %s\n", file);
                            Items.append(new Item(itemId, name, file, layout, size));
                            itemId++;
                        }
		}
		catch(GLib.FileError e)
		{

		}

		layout.add(ItemHeader);
		Location = new Vector2((Size.getX() / 5) * Id, (Size.getY() / 6));
		draw();
	}

	public void idUp()
	{
		Id++;
		Location.set((Size.getX() / 5) * Id, (Size.getY() / 6));
		draw();
	}

	public void idDown()
	{
		Id--;
		Location.set((Size.getX() / 5) * Id, (Size.getY() / 6));
		draw();
	}

	public void itemIdUp()
	{
		for(int i = 0; i < Items.length(); i++)
		{
			Items.nth_data(i).idUp();
		}
	}

	public void itemIdDown()
	{
		for(int i = 0; i < Items.length(); i++)
		{
			Items.nth_data(i).idDown();
		}
	}

	public void setId(int id)
	{
		Id = id;
	}

	public int getId()
	{
		return Id;
	}

	public void draw()
	{
		ItemHeader.get_style_context().remove_class("Selected");
		if(Id == 1)
		{
			ItemHeader.get_style_context().add_class("Selected");
		}
		layout.move(ItemHeader, Location.getX(), Location.getY());
		for(int i = 0; i < Items.length(); i++)
		{
			if(Id == 1)
			{
				Items.nth_data(i).show();
			}
			else
			{
				Items.nth_data(i).hide();
			}
		}
	}

	public void addItem(Item item)
	{
		Items.append(item);
	}
}
