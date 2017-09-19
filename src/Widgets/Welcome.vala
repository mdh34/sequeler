/*
* Copyright (c) 2011-2017 Alecaddd (http://alecaddd.com)
*
* This program is free software; you can redistribute it and/or
* modify it under the terms of the GNU General Public
* License as published by the Free Software Foundation; either
* version 2 of the License, or (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
* General Public License for more details.
*
* You should have received a copy of the GNU General Public
* License along with this program; if not, write to the
* Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
* Boston, MA 02110-1301 USA
*
* Authored by: Alessandro "Alecaddd" Castellani <castellani.ale@gmail.com>
*/

public class Sequeler.Welcome : Gtk.Box {
    
    private Granite.Widgets.Welcome welcome;
    private Sequeler.Library? library = null;

    private Gtk.Separator separator;
    public Gtk.Stack welcome_stack;

    public signal void create_connection ();

    public Welcome () {
        orientation = Gtk.Orientation.HORIZONTAL;

        width_request = 950;
        height_request = 500;

        welcome = new Granite.Widgets.Welcome (_("Welcome to Sequeler"), _("Connect to any Local or Remote Database"));
        welcome.hexpand = true;

        welcome.append ("bookmark-new", _("Add New Database"), _("Connect to a Database and save it in your Library."));
        welcome.append ("preferences-system-network", _("Browse Library"), _("Browse through all your saved Databases."));

        separator = new Gtk.Separator (Gtk.Orientation.VERTICAL);

        library = new Sequeler.Library ();

        library.go_back.connect (() => {
            welcome_stack.set_visible_child_full ("welcome", Gtk.StackTransitionType.SLIDE_RIGHT);
        });

        welcome_stack = new Gtk.Stack ();
        welcome_stack.add_named (welcome, "welcome");
        welcome_stack.add_named (library, "library");
        welcome_stack.set_visible_child (welcome);

        add (welcome_stack);
        add (separator);

        welcome.activated.connect ((index) => {
            switch (index) {
                case 0:
                    create_connection ();
                    break;
                case 1:
                    welcome_stack.set_visible_child_full ("library", Gtk.StackTransitionType.SLIDE_LEFT);
                    break;
                }
        });
    }

    //  public void reload () {
    //      var connections = settings.saved_connections;
    //      welcome_stack.set_visible_child_full ("welcome", Gtk.StackTransitionType.NONE);

    //      if (library != null) {
    //          welcome_stack.remove (library);
    //          remove (library);
    //          library.destroy ();
    //          library = null;
    //      }

    //      if (connections.length > 0) {
    //          library = new Sequeler.Library ();

    //          library.go_back.connect (() => {
    //              welcome_stack.set_visible_child_full ("welcome", Gtk.StackTransitionType.SLIDE_LEFT);
    //          });

    //          welcome_stack.add_named (library, "library");
    //      }
        
    //      if(connections.length > 0 && settings.show_library) {
    //          add (library);
            
    //          //  library.item_selected.connect ((connection) => {
    //          //      connect_to (connection);
    //          //  });

    //          separator.visible = true;
    //          separator.no_show_all = false;
    //      } else {
    //          separator.visible = false;
    //          separator.no_show_all = true;
    //      }
    //  }
}