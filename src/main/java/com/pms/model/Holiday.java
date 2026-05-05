package com.pms.model;

import java.sql.Date;

public class Holiday {
    private int    id;
    private String name, type;
    private Date   holidayDate;

    public int    getId()                   { return id; }
    public void   setId(int v)              { this.id = v; }
    public String getName()                 { return name; }
    public void   setName(String v)         { this.name = v; }
    public String getType()                 { return type; }
    public void   setType(String v)         { this.type = v; }
    public Date   getHolidayDate()          { return holidayDate; }
    public void   setHolidayDate(Date v)    { this.holidayDate = v; }
}
