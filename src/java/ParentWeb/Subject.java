/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ParentWeb;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import javax.servlet.ServletContext;
/**
 *
 * @author nmohamed
 */
public class Subject {

    int id;
    private String name;
    private ArrayList<Integer> arrayObjectives;


    public Subject(){
        this.arrayObjectives = new ArrayList<>();
    }
    public int getId() {
        return id;
    }

    public ArrayList<Integer> getMapObjectives() {
        return arrayObjectives;
    }

    public void setMapObjectives(ArrayList<Integer> mapObjectives) {
        this.arrayObjectives = mapObjectives;
    }

    public void setId(int id) {
        this.id = id;
    }


    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
    public void addObjective(int id){
        this.arrayObjectives.add(id);
    }

}
