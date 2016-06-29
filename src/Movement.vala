public class Movement
{
	private Gtk.Widget Widget;
	private Gtk.Layout Parent;
	private Vector2 CurrentLocation;
	private Vector2 TargetLocation;
	private Vector2 Interval;
	private int Mtime;

	public Movement(Gtk.Layout parent, Gtk.Widget widget, Vector2 fromLocation, Vector2 targetLocation, int mtime)
	{
		Parent = parent;
		Widget = widget;
		CurrentLocation = fromLocation;
		TargetLocation = targetLocation;
		Mtime = mtime;

		float intervalx = fromLocation.getX() - TargetLocation.getX();
		float intervaly = fromLocation.getY() - TargetLocation.getY();

		Interval = new Vector2(intervalx / mtime, intervaly /mtime);
	}

	public void update()
	{
		if(Mtime != 0)
		{
			Mtime--;

			CurrentLocation.setX(CurrentLocation.getX() - Interval.getX());
			CurrentLocation.setY(CurrentLocation.getY() - Interval.getY());
			Parent.move(Widget, (int)CurrentLocation.getX(), (int)CurrentLocation.getY());
			if(Mtime == 0)
			{
				Parent.move(Widget, (int)TargetLocation.getX(), (int)TargetLocation.getY());
			}
		}
	}

	public bool remove()
	{
		return (Mtime == 0);
	}
}
