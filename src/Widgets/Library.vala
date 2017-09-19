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

public class Sequeler.Library : Gtk.Box {

    private Gtk.FlowBox item_box;
    //  private Gtk.FlowBoxChild item;
    //  private Gtk.Box box;
    private Gtk.ScrolledWindow scroll;

    public signal void go_back ();
    public signal void delete_all_connections ();

    public Library () {
        orientation = Gtk.Orientation.VERTICAL;

        var toolbar = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
        toolbar.get_style_context ().add_class ("toolbar");
        toolbar.get_style_context ().add_class ("library-toolbar");

        var go_back_button = new Gtk.Button.with_label (_("Go Back"));
        go_back_button.clicked.connect (() => { 
            go_back ();
        });

        go_back_button.get_style_context().add_class ("back-button");
        go_back_button.can_focus = false;
        go_back_button.margin = 12;

        var delete_image = new Gtk.Image.from_icon_name ("user-trash-symbolic", Gtk.IconSize.BUTTON);
        var delete_all = new Gtk.Button.with_label (_("Delete All"));
        delete_all.always_show_image = true;
        delete_all.set_image (delete_image);
        delete_all.clicked.connect (() => {
            delete_all_connections ();
        });
        delete_all.can_focus = false;
        delete_all.margin = 12;

        toolbar.pack_start (go_back_button, false, false, 0);
        toolbar.pack_end (delete_all, false, false, 0);
        this.pack_start (toolbar, false, true, 0);

        scroll = new Gtk.ScrolledWindow (null, null);
        scroll.set_policy (Gtk.PolicyType.AUTOMATIC, Gtk.PolicyType.AUTOMATIC);

        item_box = new Gtk.FlowBox ();
        
        item_box.valign = Gtk.Align.START;
        item_box.min_children_per_line = 2;
        item_box.max_children_per_line = 5;
        item_box.margin = 12;
        item_box.expand = false;

        scroll.add (item_box);

        //  foreach (var conn in settings.saved_connections) {
        //      add_item (conn);
        //  }

        this.pack_end (scroll, true, true, 0);
    }

    //  public void add_item (string connection) {
    //      var item = new Gtk.FlowBoxChild ();
    //      var box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
    //      box.get_style_context ().add_class (Granite.STYLE_CLASS_CARD);
    //      box.margin = 10;

    //      box.pack_start (new Gtk.Label (connection), true, true, 10);

    //      var button_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);

    //      var edit_button = new BoxButton ("emblem-system-symbolic", _("Edit Connection"));
    //      var delete_button = new BoxButton ("user-trash-symbolic", _("Delete Connection"));

    //      button_box.pack_start (edit_button, false, true, 10);
    //      button_box.pack_end (delete_button, false, true, 10);

    //      box.pack_end (button_box, true, false, 10);

    //      item.add (box);
    //      item_box.add (item);
    //  }

    public void add_new_item (Gee.HashMap<string, string> data) {

    }

    protected class BoxButton : Gtk.Button {
        
        public BoxButton (string icon_name, string tooltip) {
            can_focus = false;

            Gtk.Image image;

            if (icon_name.contains ("/")) {
                image = new Gtk.Image.from_resource (icon_name);
            } else {
                image = new Gtk.Image.from_icon_name (icon_name, Gtk.IconSize.BUTTON);
            }

            image.margin = 3;

            set_tooltip_text (tooltip);
            this.add (image);
        }
    }
}