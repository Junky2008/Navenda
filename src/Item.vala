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
	private SelectedItemManager SelectedItem;

	public Item(string name, string filename, Gtk.Layout layout, Vector2 size, SelectedItemManager selectedItem)
	{
		Name = name;
		SelectedItem = selectedItem;
		Filename = filename;
		Layout = layout;
		Size = size;

		ItemTitle = new Gtk.Label(Name);
		ItemTitle.get_style_context().add_class("ItemTitle");
		ItemSubText = new Gtk.Label(filename);
		ItemSubText.get_style_context().add_class("ItemSubText");

		layout.add(ItemTitle);
		layout.add(ItemSubText);
	}

	public string getSubText()
	{
		return Filename;
	}

	public void setId(int id)
	{
		Id = id;
	}

	public void calculateLocation()
	{
		int id = Id - SelectedItem.getSelected();
		ItemSubText.set_opacity(0);
		if(id > 1)
		{
			Location = new Vector2((size.getX() / 5) + 20, (size.getY() / 6) + (id * 150) + 150);
		}
		else if(id == 1)
		{
			Location = new Vector2((size.getX() / 5) + 20, (size.getY() / 6) + (id * 150));
			ItemSubText.set_opacity(1);
		}
		else
		{
			Location = new Vector2((size.getX() / 5) + 20, (size.getY() / 6) + (id * 150) - 150);
		}
	}

	public void draw()
	{
		Layout.move(ItemTitle, (int)Location.getX(), (int)Location.getY());
		Layout.move(ItemSubText, (int)Location.getX(), (int)Location.getY() + 75);
	}

	public void hide()
	{
		ItemTitle.set_opacity(0);
		ItemSubText.set_opacity(0);
	}

	public void show()
	{
		int id = Id - SelectedItem.getSelected();
		ItemTitle.set_opacity(1);
		if(id == 1)
		{
			ItemSubText.set_opacity(1);
		}
	}

	public void update()
	{
		calculateLocation();
		draw();
	}

}
