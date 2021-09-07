
public class Lightning.Widgets.FormatStack : Gtk.Box {

    private Granite.Widgets.ModeButton navigation;
    private Gtk.Stack stack;
    private Gtk.Button copy_button;
    public Lightning.ExtRGBA current_color;

    public FormatStack () {
        Object(
            orientation: Gtk.Orientation.VERTICAL
        );
    }

    construct {

        navigation = new Granite.Widgets.ModeButton ();
        navigation.append_icon ("css-symbolic", Gtk.IconSize.BUTTON);
        navigation.append_icon ("ionicons-color-filter-symbolic", Gtk.IconSize.BUTTON);
        navigation.append_icon ("ionicons-cube-symbolic", Gtk.IconSize.BUTTON);
        navigation.append_icon ("java-symbolic", Gtk.IconSize.BUTTON);
        navigation.append_icon ("android-symbolic", Gtk.IconSize.BUTTON);
        navigation.append_icon ("flutter-symbolic", Gtk.IconSize.BUTTON);
        navigation.set_active (0);
        navigation.can_focus = false;
        navigation.get_style_context ().remove_class("linked");
        navigation.get_style_context ().add_class("formatbox-nav");

        navigation.mode_changed.connect ((widget) => {
            on_navigation_changed ();
        });

        stack = new Gtk.Stack ();

        var hex_label = new Gtk.Label ("#3F92AA");
        var rgb_label = new Gtk.Label ("rgb(211, 32, 128)");
        var gdk_label = new Gtk.Label ("Gdk.RGBA(211, 32, 128, 1)");
        var java_label = new Gtk.Label ("new Color(211, 32, 128)");
        var android_label = new Gtk.Label ("Color.rgb(211, 32, 128)");
        var flutter_label = new Gtk.Label ("Color(0xffffffff)");

        hex_label.get_style_context ().add_class ("formatbox-label");
        rgb_label.get_style_context ().add_class ("formatbox-label");
        gdk_label.get_style_context ().add_class ("formatbox-label");
        java_label.get_style_context ().add_class ("formatbox-label");
        android_label.get_style_context ().add_class ("formatbox-label");
        flutter_label.get_style_context ().add_class ("formatbox-label");

        stack.add_titled (hex_label, "Hex", "Hex");
        stack.add_titled (rgb_label, "RGB", "RGB");
        stack.add_titled (gdk_label, "GDK", "GDK");
        stack.add_titled (java_label, "Java", "Java");
        stack.add_titled (android_label, "Android", "Android");
        stack.add_titled (flutter_label, "Flutter", "Flutter");
        stack.get_style_context ().add_class ("formatbox-stack");

        copy_button = new Gtk.Button.from_icon_name ("edit-copy-symbolic", Gtk.IconSize.BUTTON) {
            can_focus = false
        };
        copy_button.get_style_context ().add_class ("formatbox-copybutton");

        var content_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
        content_box.pack_start (stack, false, false, 0);
        content_box.pack_start (copy_button, false, false, 0);
        content_box.get_style_context ().add_class ("formatbox-content");
        

        pack_start (navigation, false, false, 0);
        pack_start (content_box, false, false, 0);

        get_style_context ().add_class ("formatbox");
    }

    public void on_navigation_changed () {
        if(navigation.selected == 0)
                stack.visible_child_name = "Hex";

        if(navigation.selected == 1)
            stack.visible_child_name = "RGB";

        if(navigation.selected == 2)
            stack.visible_child_name = "GDK";

        if(navigation.selected == 3)
            stack.visible_child_name = "Java";

        if(navigation.selected == 4)
            stack.visible_child_name = "Android";

        if(navigation.selected == 5)
            stack.visible_child_name = "Flutter";
    }

    public void update_color () {

    }
}
