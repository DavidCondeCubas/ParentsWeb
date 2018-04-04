/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Montessori;
/**
 *
 * @author Norhan
 */
public class Profesor {

    private String firstName;
    private String lastName;
    private String email;
    private String asignatura;
    private String classId;
    private int id;
    private String pathFoto;
    private String gender;

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getPathFoto() {
        return pathFoto;
    }

    public void setPathFoto(String PathFoto) {
        this.pathFoto = PathFoto;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
    
    public Profesor(String firstName,int i, String lastName, String email, String path,String gender) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.id = i;
        this.pathFoto = path;
        this.gender = gender;
    }
     
    public Profesor(String firstName, String lastName, String email, String asignatura, String classId) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.asignatura = asignatura;
        this.classId = classId;
        
    }

    public String getClassId() {
        return classId;
    }

    public void setClassId(String classId) {
        this.classId = classId;
    }

    public String getAsignatura() {
        return asignatura;
    }

    public void setAsignatura(String asignatura) {
        this.asignatura = asignatura;
    }
    
    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }


    public void setEmail(String email) {
        this.email = email;
    }

    public String getFirstName() {
        return firstName;
    }

    public String getLastName() {
        return lastName;
    }


    public String getEmail() {
        return email;
    }

    
}
