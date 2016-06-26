public class Item
{
	private int Id;
	private string Name;
	private string Filename;
	private Gtk.Layout Layout;
	private Vector2 Size;
	private Vector2 Location;
	private Gtk.Label ItemTitle;
	private Gtk.Label ItemSubText;

	public Item(int id, string name, string filename, Gtk.Layout layout, Vector2 size)
	{
		Id = id;
		Name = name;
		Filename = filename;
		Layout = layout;
		Size = size;

		ItemTitle = new Gtk.Label(Name);
		ItemTitle.get_style_context().add_class("ItemTitle");
		ItemSubText = new Gtk.Label(filename);
		ItemSubText.get_style_context().add_class("ItemSubText");

		layout.add(ItemTitle);
		layout.add(ItemSubText);

		calculateLocation();
		draw();
	}

	public void calculateLocation()
	{
		ItemSubText.set_opacity(0);
		if(Id > 1)
		{
			Location = new Vector2((size.getX() / 5) + 20, (size.getY() / 6) + (Id * 150) + 150);
		}
		else if(Id == 1)
		{
			Location = new Vector2((size.getX() / 5) + 20, (size.getY() / 6) + (Id * 150));
		ItemSubText.set_opacity(1);
		}
		else
		{
			Location = new Vector2((size.getX() / 5) + 20, (size.getY() / 6) + (Id * 150) - 150);
		}
	}

	public void draw()
	{
		Layout.move(ItemTitle, Location.getX(), Location.getY());
		Layout.move(ItemSubText, Location.getX(), Location.getY() + 75);
	}

	public void hide()
	{
		ItemTitle.set_opacity(0);
		ItemSubText.set_opacity(0);
	}

	public void show()
	{
		ItemTitle.set_opacity(1);
		if(Id == 1)
		{
			ItemSubText.set_opacity(1);
		}
	}

	public void idUp()
	{
		Id++;
		calculateLocation();
		draw();
	}

	public void idDown()
	{
		Id--;
		calculateLocation();
		draw();
	}

}
