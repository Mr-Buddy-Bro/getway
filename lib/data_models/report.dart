class ReportModel{
  late final String instDocId;
  late final String reporterDocId;

  ReportModel(String instDocId,String reporterDocId,){
    this.instDocId = instDocId;
    this.reporterDocId = reporterDocId;
  }

  Map<String, dynamic> toJson() =>{
    'instDocId':instDocId,
    'reporterDocId':reporterDocId,
  };
}