package tdgame.menu;

import javafx.scene.Group;
import javafx.scene.layout.HBox;

/**
 * @author Maxim Kolchin
 */
public class HMenu extends Menu {

    override function create() {
	Group {
	    content: [
		HBox {
		    content: items
		}
	    ]
	}
    }

}
