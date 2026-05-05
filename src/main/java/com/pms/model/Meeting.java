package com.pms.model;

import java.sql.Timestamp;

public class Meeting {
    private int       id, projectId, createdBy;
    private String    title, description, location, projectTitle, creatorName;
    private Timestamp meetingDate;

    public int       getId()                    { return id; }
    public void      setId(int v)               { this.id = v; }
    public int       getProjectId()             { return projectId; }
    public void      setProjectId(int v)        { this.projectId = v; }
    public int       getCreatedBy()             { return createdBy; }
    public void      setCreatedBy(int v)        { this.createdBy = v; }
    public String    getTitle()                 { return title; }
    public void      setTitle(String v)         { this.title = v; }
    public String    getDescription()           { return description; }
    public void      setDescription(String v)   { this.description = v; }
    public String    getLocation()              { return location; }
    public void      setLocation(String v)      { this.location = v; }
    public String    getProjectTitle()          { return projectTitle; }
    public void      setProjectTitle(String v)  { this.projectTitle = v; }
    public String    getCreatorName()           { return creatorName; }
    public void      setCreatorName(String v)   { this.creatorName = v; }
    public Timestamp getMeetingDate()           { return meetingDate; }
    public void      setMeetingDate(Timestamp v){ this.meetingDate = v; }
}
