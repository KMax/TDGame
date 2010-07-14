package tdgame.menu.item;

import tdgame.menu.MenuItem;
import javafx.scene.control.Label;
import javafx.scene.layout.VBox;

/**
 * @author Maxim Kolchin
 */
public class gameParameters extends MenuItem {

    override function create() {
	VBox {
	    content: [
		Label {
		    text: bind "Cash: ${field.cost}"
		},
		Label {
		    text: bind "Waves: {field.totalWaves}"
		},
		Label {
		    text: bind "Kills: {field.kills}"
		}
	    ]
	}
    }

}
