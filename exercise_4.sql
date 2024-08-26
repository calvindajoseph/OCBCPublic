-- Query 1.
SELECT 
    f.fin_ID AS Finding_ID,
    ae.ent_AuditableName AS Auditable_Entity_Name,
    pa.pa_Auditname AS Audit_Name,
    a.act_ID AS Action_Plan_ID,
    a.act_Owner AS PIC_Action_Plan,
    afu.afu_ID AS Action_FollowUp_ID
FROM 
    Findings f
LEFT JOIN 
    AuditableEntities ae ON f.fin_Entity = ae.ent_Id
LEFT JOIN 
    PenugasanAudit pa ON f.fin_AuditID = pa.pa_AuditId
LEFT JOIN 
    Actions a ON f.fin_ID = a.act_FindingID
LEFT JOIN 
    ActionFollowUps afu ON a.act_ID = afu.afu_ActionID;

-- Query 2.
SELECT 
    pa.pa_AuditId AS Audit_ID,
    pa.pa_Auditname AS Audit_Name
FROM 
    PenugasanAudit pa
LEFT JOIN 
    Findings f ON pa.pa_AuditId = f.fin_AuditID
WHERE 
    f.fin_ID IS NULL;

-- Query 3.
SELECT 
    ae.ent_AuditableName AS Unit_Kerja,
    COUNT(DISTINCT f.fin_ID) AS Jumlah_Finding,
    COUNT(DISTINCT a.act_ID) AS Jumlah_Action_Plan
FROM 
    AuditableEntities ae
LEFT JOIN 
    Findings f ON ae.ent_Id = f.fin_Entity
LEFT JOIN 
    Actions a ON f.fin_ID = a.act_FindingID
GROUP BY 
    ae.ent_AuditableName;