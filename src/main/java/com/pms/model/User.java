package com.pms.model;

public class User {
    private int    id;
    private String name, email, password, role;

    public int    getId()               { return id; }
    public void   setId(int id)         { this.id = id; }
    public String getName()             { return name; }
    public void   setName(String v)     { this.name = v; }
    public String getEmail()            { return email; }
    public void   setEmail(String v)    { this.email = v; }
    public String getPassword()         { return password; }
    public void   setPassword(String v) { this.password = v; }
    public String getRole()             { return role; }
    public void   setRole(String v)     { this.role = v; }
    public String getAvatar() {
        return (name != null && name.length() >= 2)
            ? name.substring(0, 2).toUpperCase() : "??";
    }
}
