package com.pms.model;

import java.sql.Date;
import java.sql.Timestamp;

public class Project {
    private int       id, createdBy, taskCount;
    private String    title, description, status, creatorName;
    private Date      startDate, endDate;
    private Timestamp createdAt;

    public int       getId()                    { return id; }
    public void      setId(int v)               { this.id = v; }
    public int       getCreatedBy()             { return createdBy; }
    public void      setCreatedBy(int v)        { this.createdBy = v; }
    public int       getTaskCount()             { return taskCount; }
    public void      setTaskCount(int v)        { this.taskCount = v; }
    public String    getTitle()                 { return title; }
    public void      setTitle(String v)         { this.title = v; }
    public String    getDescription()           { return description; }
    public void      setDescription(String v)   { this.description = v; }
    public String    getStatus()                { return status; }
    public void      setStatus(String v)        { this.status = v; }
    public String    getCreatorName()           { return creatorName; }
    public void      setCreatorName(String v)   { this.creatorName = v; }
    public Date      getStartDate()             { return startDate; }
    public void      setStartDate(Date v)       { this.startDate = v; }
    public Date      getEndDate()               { return endDate; }
    public void      setEndDate(Date v)         { this.endDate = v; }
    public Timestamp getCreatedAt()             { return createdAt; }
    public void      setCreatedAt(Timestamp v)  { this.createdAt = v; }
}
