package tdgame.monster;

import tdgame.core.Creature;
import javafx.scene.Node;
import tdgame.resource.Resources;

/**
 * @author Maxim Kolchin
 */
public class Bug extends Creature {

    override var energy: Number = 100;
    override var speed: Number = 2;
    override var node: Node = Resources.getImage("monster1");
}
