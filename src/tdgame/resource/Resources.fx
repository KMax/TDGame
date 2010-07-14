package tdgame.resource;

import javafx.fxd.FXDLoader;
import javafx.scene.Node;
import javafx.fxd.Duplicator;
import javafx.scene.shape.Path;

/**
 * @author Maxim Kolchin
 */

def fxd = FXDLoader.loadContent("{__DIR__}AmbushGame.fxz");
public def EMPTY = "empty";
public def EMPTY_NODE = fxd.getNode(EMPTY);

public function getPath(name: String): Path {
    getImage(name) as Path;
}

public function getImage(name: String): Node {
    def node = fxd.getNode(name);
    Duplicator.duplicate(if (node == null) EMPTY_NODE else node);
}
