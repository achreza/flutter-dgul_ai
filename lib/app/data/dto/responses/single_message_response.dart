class SingleMessageResponse {
  bool? success;
  Message? message;
  Metadata? metadata;

  SingleMessageResponse({this.success, this.message, this.metadata});

  SingleMessageResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message =
        json['message'] != null ? new Message.fromJson(json['message']) : null;
    metadata = json['metadata'] != null
        ? new Metadata.fromJson(json['metadata'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.message != null) {
      data['message'] = this.message!.toJson();
    }
    if (this.metadata != null) {
      data['metadata'] = this.metadata!.toJson();
    }
    return data;
  }
}

class Message {
  String? role;
  String? content;
  String? timestamp;
  bool? hasImageAnalysis;

  Message({this.role, this.content, this.timestamp, this.hasImageAnalysis});

  Message.fromJson(Map<String, dynamic> json) {
    role = json['role'];
    content = json['content'];
    timestamp = json['timestamp'];
    hasImageAnalysis = json['has_image_analysis'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['role'] = this.role;
    data['content'] = this.content;
    data['timestamp'] = this.timestamp;
    data['has_image_analysis'] = this.hasImageAnalysis;
    return data;
  }
}

class Metadata {
  String? model;
  String? finishReason;
  Usage? usage;

  Metadata({this.model, this.finishReason, this.usage});

  Metadata.fromJson(Map<String, dynamic> json) {
    model = json['model'];
    finishReason = json['finish_reason'];
    usage = json['usage'] != null ? new Usage.fromJson(json['usage']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['model'] = this.model;
    data['finish_reason'] = this.finishReason;
    if (this.usage != null) {
      data['usage'] = this.usage!.toJson();
    }
    return data;
  }
}

class Usage {
  int? promptTokenCount;
  int? candidatesTokenCount;
  int? totalTokenCount;
  List<PromptTokensDetails>? promptTokensDetails;
  List<CandidatesTokensDetails>? candidatesTokensDetails;

  Usage(
      {this.promptTokenCount,
      this.candidatesTokenCount,
      this.totalTokenCount,
      this.promptTokensDetails,
      this.candidatesTokensDetails});

  Usage.fromJson(Map<String, dynamic> json) {
    promptTokenCount = json['promptTokenCount'];
    candidatesTokenCount = json['candidatesTokenCount'];
    totalTokenCount = json['totalTokenCount'];
    if (json['promptTokensDetails'] != null) {
      promptTokensDetails = <PromptTokensDetails>[];
      json['promptTokensDetails'].forEach((v) {
        promptTokensDetails!.add(new PromptTokensDetails.fromJson(v));
      });
    }
    if (json['candidatesTokensDetails'] != null) {
      candidatesTokensDetails = <CandidatesTokensDetails>[];
      json['candidatesTokensDetails'].forEach((v) {
        candidatesTokensDetails!.add(new CandidatesTokensDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['promptTokenCount'] = this.promptTokenCount;
    data['candidatesTokenCount'] = this.candidatesTokenCount;
    data['totalTokenCount'] = this.totalTokenCount;
    if (this.promptTokensDetails != null) {
      data['promptTokensDetails'] =
          this.promptTokensDetails!.map((v) => v.toJson()).toList();
    }
    if (this.candidatesTokensDetails != null) {
      data['candidatesTokensDetails'] =
          this.candidatesTokensDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PromptTokensDetails {
  String? modality;
  int? tokenCount;

  PromptTokensDetails({this.modality, this.tokenCount});

  PromptTokensDetails.fromJson(Map<String, dynamic> json) {
    modality = json['modality'];
    tokenCount = json['tokenCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['modality'] = this.modality;
    data['tokenCount'] = this.tokenCount;
    return data;
  }
}

class CandidatesTokensDetails {
  String? modality;
  int? tokenCount;

  CandidatesTokensDetails({this.modality, this.tokenCount});

  CandidatesTokensDetails.fromJson(Map<String, dynamic> json) {
    modality = json['modality'];
    tokenCount = json['tokenCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['modality'] = this.modality;
    data['tokenCount'] = this.tokenCount;
    return data;
  }
}
