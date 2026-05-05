package com.pms.model;

import java.sql.Date;
import java.sql.Timestamp;

public class Task {
    private int       id, projectId, assignedTo;
    private String    title, description, status, priority;
    private String    assigneeName, projectTitle;
    private Date      startDate, endDate;
    private Timestamp createdAt;

    public int       getId()                    { return id; }
    public void      setId(int v)               { this.id = v; }
    public int       getProjectId()             { return projectId; }
    public void      setProjectId(int v)        { this.projectId = v; }
    public int       getAssignedTo()            { return assignedTo; }
    public void      setAssignedTo(int v)       { this.assignedTo = v; }
    public String    getTitle()                 { return title; }
    public void      setTitle(String v)         { this.title = v; }
    public String    getDescription()           { return description; }
    public void      setDescription(String v)   { this.description = v; }
    public String    getStatus()                { return status; }
    public void      setStatus(String v)        { this.status = v; }
    public String    getPriority()              { return priority; }
    public void      setPriority(String v)      { this.priority = v; }
    public String    getAssigneeName()          { return assigneeName; }
    public void      setAssigneeName(String v)  { this.assigneeName = v; }
    public String    getProjectTitle()          { return projectTitle; }
    public void      setProjectTitle(String v)  { this.projectTitle = v; }
    public Date      getStartDate()             { return startDate; }
    public void      setStartDate(Date v)       { this.startDate = v; }
    public Date      getEndDate()               { return endDate; }
    public void      setEndDate(Date v)         { this.endDate = v; }
    public Timestamp getCreatedAt()             { return createdAt; }
    public void      setCreatedAt(Timestamp v)  { this.createdAt = v; }
}
