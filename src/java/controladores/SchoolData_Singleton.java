/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controladores;

import Montessori.DBConect;
import Montessori.Objective;
import Montessori.Profesor;
import Montessori.Step;
import Montessori.Subject;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.TreeMap;

public class SchoolData_Singleton {

    private HashMap<Integer, Subject> mapSubjects;
    private HashMap<Integer, Objective> mapObjectives;
    private HashMap<Integer, Step> mapSteps;
    private HashMap<Integer, Profesor> mapProfesor;

    public HashMap<Integer, Objective> getMapObjectives() {
        return mapObjectives;
    }

    public void setMapObjectives(HashMap<Integer, Objective> mapObjectives) {
        this.mapObjectives = mapObjectives;
    }

    public HashMap<Integer, Step> getMapSteps() {
        return mapSteps;
    }

    public void setMapSteps(HashMap<Integer, Step> mapSteps) {
        this.mapSteps = mapSteps;
    }

    public HashMap<Integer, Subject> getMapSubjects() {
        return mapSubjects;
    }

    public void setMapSubjects(HashMap<Integer, Subject> mapSubjects) {
        this.mapSubjects = mapSubjects;
    }

    public HashMap<Integer, Profesor> getMapProfesor() {
        return mapProfesor;
    }

    public void setMapProfesor(HashMap<Integer, Profesor> mapProfesor) {
        this.mapProfesor = mapProfesor;
    }

    public static SchoolData_Singleton getSchoolData() {
        return schoolData;
    }

    public static void setSchoolData(SchoolData_Singleton schoolData) {
        SchoolData_Singleton.schoolData = schoolData;
    }

    private static SchoolData_Singleton schoolData;

    private SchoolData_Singleton() throws SQLException {
        this.mapProfesor = new HashMap<>();
        this.mapSubjects = new HashMap<>();
        this.mapSteps = new HashMap<>();
        this.mapObjectives = new HashMap<>();
        getSubject();
        this.mapProfesor = getTeachers();

    }

    public static SchoolData_Singleton getData() throws SQLException {
        if (schoolData == null) {
            schoolData = new SchoolData_Singleton();
        }
        return schoolData;
    }

    private void getSubject() {
        // carga subjects
        String consulta = "SELECT Title,CourseID FROM AH_ZAF.dbo.Courses where active =1 and Title not like ''";
        try {
            ResultSet rs4 = DBConect.ah.executeQuery(consulta);

            while (rs4.next()) {
                Subject auxS = new Subject();
                auxS.setId(rs4.getInt("CourseID"));
                auxS.setName(rs4.getString("Title"));
                this.mapSubjects.put(auxS.getId(), auxS);
            }

            //carga objectives
            consulta = "SELECT * FROM objective order by subject_id,name";
            ResultSet rs5 = DBConect.eduweb.executeQuery(consulta);
            while (rs5.next()) {
                int idSubject = rs5.getInt("subject_id");
                if (this.mapSubjects.containsKey(idSubject)) {
                    Objective auxObj = new Objective();
                    int idObj = rs5.getInt("id");
                    auxObj.setId(idObj);
                    auxObj.setDescription(rs5.getString("description"));
                    auxObj.setName("name");
                    auxObj.setIdSubject(idSubject);
                    this.mapObjectives.put(idObj, auxObj);
                    this.mapSubjects.get(idSubject).addObjective(idObj, auxObj);
                }
            }

            //carga steps
            consulta = "SELECT * FROM obj_steps inner join objective on obj_steps.obj_id = objective.id order by obj_steps.obj_id,obj_steps.storder";
            ResultSet rs6 = DBConect.eduweb.executeQuery(consulta);
            while (rs6.next()) {
                int idSubject = rs6.getInt("subject_id");
                if (this.mapSubjects.containsKey(idSubject)) {
                    int idObjective = rs6.getInt("obj_id");

                    if (this.mapSubjects.get(idSubject).getMapObjectives().containsKey(idObjective)) {
                        Step auxStep = new Step();
                        int idStep = rs6.getInt("id");
                        auxStep.setObj_id(rs6.getInt("obj_id"));
                        auxStep.setName(rs6.getString("name"));
                        auxStep.setOrder(rs6.getInt("storder"));
                        auxStep.setWeight(rs6.getInt("weight"));
                        this.mapSteps.put(idStep, auxStep);
                        this.mapSubjects.get(idSubject).getMapObjectives().get(idObjective).getMapSteps().put(idStep, auxStep);
                    }
                }
            }
        } catch (Exception e) {
            System.err.println("");
        }

    }

    private HashMap getTeachers() throws SQLException {

        HashMap<Integer, Profesor> mapTeachers = new HashMap<>();
        ArrayList<Profesor> listaProfesores = new ArrayList<>();
        HashMap<String, String> mapNames = new HashMap<>();

        try {
            ArrayList<Integer> staffids = new ArrayList<>();
            ArrayList<String> classids = new ArrayList<>();
            ArrayList<String> coursesTitles = new ArrayList<>();

            String consulta = "select StaffID, Classes.ClassID , Courses.Title ,Courses.CourseID,courses.RCPlacement from Roster inner join Classes"
                    + " on Roster.ClassID = Classes.ClassID"
                    + " inner join Courses on  Classes.CourseID = Courses.CourseID"
                    + "  where Courses.ReportCard = 1 order by courses.RCPlacement";
            ResultSet rs = DBConect.ah.executeQuery(consulta);
            while (rs.next()) {
                staffids.add(rs.getInt("StaffID"));
                classids.add(rs.getString("CourseID"));
                coursesTitles.add(rs.getString("Title"));
            }

            consulta = "select FirstName,LastName,Email,PersonID from Person";
            ResultSet rs3 = DBConect.ah.executeQuery(consulta);
            while (rs3.next()) {
                mapNames.put(rs3.getString("PersonID"), rs3.getString("FirstName") + " " + rs3.getString("LastName"));
            }

            for (Integer i : staffids) {
                if (mapNames.containsKey("" + i)) {
                    listaProfesores.add(new Profesor(mapNames.get("" + i), i, "", ""));
                } else {
                    listaProfesores.add(new Profesor(" ", i, "", ""));
                }
            }
            for (int i = 0; i < listaProfesores.size(); i++) {
                listaProfesores.get(i).setAsignatura(coursesTitles.get(i));
                listaProfesores.get(i).setClassId(classids.get(i));
                mapTeachers.put(listaProfesores.get(i).getId(), listaProfesores.get(i));
            }

        } catch (SQLException ex) {
            System.out.println("Error leyendo Alumnos: " + ex);
            StringWriter errors = new StringWriter();
            ex.printStackTrace(new PrintWriter(errors));
        }

        return mapTeachers;
    }

}
