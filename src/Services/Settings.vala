
namespace Paleta.Services {

    public class Settings : Granite.Services.Settings {
    
        private static Settings? instance = null;

        public int window_x { get; set; }
        public int window_y { get; set; }
        public int color_format_index { get; set; }
        public string[] color_history { get; set; }
        public int zoomlevel { get; set; }

        public static Settings get_instance () {
            if (instance == null) {
                instance = new Settings ();
            }

            return instance;
        }

        private Settings () {
            base ("com.github.jeysonflores.paleta");
        }
    }
}

