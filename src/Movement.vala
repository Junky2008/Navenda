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

	public Vector2 getTarget()
	{
		return TargetLocation;
	}

	public int getMtime()
	{
		return Mtime;
	}

	public Gtk.Widget getWidget()
	{
		return Widget;
	}

	public void update()
	{
		if(Mtime != 0)
		{
			Mtime--;

			CurrentLocation.setX(CurrentLocation.getX() - Interval.getX());
			CurrentLocation.setY(CurrentLocation.getY() - Interval.getY());
			//stdout.printf("from: %d, to: %d, int: %f\n", (int)CurrentLocation.getX(), (int)TargetLocation.getX(), Interval.getX());
			Parent.move(Widget, (int)CurrentLocation.getX(), (int)CurrentLocation.getY());
			if(Mtime == 0)
			{
				Parent.move(Widget, (int)TargetLocation.getX(), (int)TargetLocation.getY());
			}
		}
	}

	public void updateMovment(Movement newMovement)
	{
		TargetLocation = newMovement.getTarget();
		Mtime = newMovement.getMtime();

		float intervalx = CurrentLocation.getX() - TargetLocation.getX();
		float intervaly = CurrentLocation.getY() - TargetLocation.getY();

		//stdout.printf("%f, %f, cur: %f, %f, tar: %f, %f\n", intervalx, intervaly, CurrentLocation.getX(), CurrentLocation.getY(), TargetLocation.getX(), TargetLocation.getY());

		Interval.set(intervalx / Mtime, intervaly / Mtime);
	}

	public bool remove()
	{
		return (Mtime == 0);
	}
}
