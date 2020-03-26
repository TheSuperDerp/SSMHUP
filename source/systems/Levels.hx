/**
 *  Levels.hx - multiple classes
 *  Classes for all the levels
 *  Stores data like what tilemaps, size, etc
 *  
 *  TODO: Don't hard code this but read it in from a ini or yaml file
 */
package systems;

import flixel.FlxObject;
import flixel.tile.FlxTilemap;

interface TileSet {
    public function getPath():String;
    public function setProperties(tilemap:FlxTilemap):Void;
    public function getWidth():Int;
    public function getHeight():Int;
}

class DevTiles implements TileSet {
    public function new(){}
    public function getPath():String {
        return AssetPaths.desert__png;
    }

    public function setProperties(tilemap:FlxTilemap):Void {
        tilemap.setTileProperties(1, FlxObject.NONE);
        tilemap.setTileProperties(2, FlxObject.ANY);
    }

    public function getWidth():Int { return 16; }
    public function getHeight():Int { return 16; }
}

class DesertTiles implements TileSet {
    public function new(){}
    public function getPath():String {
        return AssetPaths.desert__png;
    }

    public function setProperties(tilemap:FlxTilemap):Void {
        for (i in 1...45) {
            tilemap.setTileProperties(i, FlxObject.NONE);
        }/*
        for (i in 36...41) {
            tilemap.setTileProperties(i, FlxObject.NONE);
        }*/
    }

    public function getWidth():Int { return 16; }
    public function getHeight():Int { return 16; }
}

interface Level {
    public function getName():String;
    public function getPath():String;
    public function getTileset():TileSet;
}

class Level1 implements Level {
    public function new(){}
    public function getName():String {
        return "test_1";
    }

    public function getPath():String {
        return AssetPaths.level1__json;
    }

    public function getTileset():TileSet {
        return new DesertTiles();
    }
}

class Level2 implements Level {
    public function new(){}
    public function getName():String {
        return "test_2";
    }

    public function getPath():String {
        return AssetPaths.level2__json;
    }

    public function getTileset():TileSet {
        return new DesertTiles();
    }
}

class LevelData {
    private var _levels:Array<Level>;
    public function new() {
        _levels = new Array();
        _levels.push(new Level1());
        _levels.push(new Level2());
    }

    public function getLevels():Array<Level> {
        return _levels;
    }

    public function getLevel(level:Int):Level {
        if (level >= _levels.length) return null;
        return _levels[level];
    }
}
