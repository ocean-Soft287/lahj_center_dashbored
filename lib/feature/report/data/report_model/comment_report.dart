class CommentReport {
  final int id;
  final int advertCommentId;
  final String comment;
  final String commenterMemberId;
  final String commenterMemberName;
  final String reporterMemberId;
  final String reporterMemberName;
  final String reason;
  final String status;

  CommentReport({
    required this.id,
    required this.advertCommentId,
    required this.comment,
    required this.commenterMemberId,
    required this.commenterMemberName,
    required this.reporterMemberId,
    required this.reporterMemberName,
    required this.reason,
    required this.status,
  });

  /// Factory constructor to create from JSON
  factory CommentReport.fromJson(Map<String, dynamic> json) {
    return CommentReport(
      id: json['id'] ?? 0,
      advertCommentId: json['advertCommentId'] ?? 0,
      comment: json['comment'] ?? '',
      commenterMemberId: json['commenterMemberId'] ?? '',
      commenterMemberName: json['commenterMemberName'] ?? '',
      reporterMemberId: json['reporterMemberId'] ?? '',
      reporterMemberName: json['reporterMemberName'] ?? '',
      reason: json['reason'] ?? '',
      status: json['status'] ?? '',
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'advertCommentId': advertCommentId,
      'comment': comment,
      'commenterMemberId': commenterMemberId,
      'commenterMemberName': commenterMemberName,
      'reporterMemberId': reporterMemberId,
      'reporterMemberName': reporterMemberName,
      'reason': reason,
      'status': status,
    };
  }
}
