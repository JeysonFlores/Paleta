
public class Lightning.Widgets.FormatStack : Gtk.Box {

    private Gtk.StackSwitcher stack_switcher;
    private Gtk.Stack stack;
    private Gtk.Label title;
    private Gtk.Button copy_button;
    public Lightning.ExtRGBA current_color;

    public FormatStack () {
        Object(
            orientation: Gtk.Orientation.VERTICAL
        );
    }

    construct {

        stack = new Gtk.Stack ();

        var hex_label = new Gtk.Label ("#3F92AA");
        var rgb_label = new Gtk.Label ("rgb(211, 32, 128)");
        var gdk_label = new Gtk.Label ("Gdk.RGBA(211, 32, 128, 1)");
        var java_label = new Gtk.Label ("new Color(211, 32, 128)");

        stack.add_titled (hex_label, "Hex", "Hex");
        stack.add_titled (rgb_label, "RGB", "RGB");
        stack.add_titled (gdk_label, "GDK", "GDK");
        stack.add_titled (java_label, "Java", "Java");

        var header_box = new Gtk.Box(orientation = Gtk.Orientation.HORIZONTAL, 0);

        title = new Gtk.Label ("Hex");
        title.get_style_context ().add_class ("h4");

        copy_button = new Gtk.Button.from_icon_name ("java-symbolic", Gtk.IconSize.BUTTON);

        stack_switcher = new Gtk.StackSwitcher ();
        stack_switcher.stack = stack;

        header_box.pack_start (stack_switcher, false, false, 0);
        header_box.pack_start (title, false, false, 0);
        header_box.pack_start (copy_button, false, false, 0);

        pack_start (header_box, false, false, 0);
        pack_start (stack, false, false, 0);


    }
}
