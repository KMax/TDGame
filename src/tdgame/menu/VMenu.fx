package tdgame.menu;

import javafx.scene.layout.VBox;

/**
 * @author Maxim Kolchin
 */
public class VMenu extends Menu {

    override function create() {
	VBox {
	    spacing: 10
	    content: items
	}
    }

}
