/// metadata : {"id":"asana_cat_cow_v1","title":"Cat-Cow Flow","category":"spinal_mobility","defaultLoopCount":4,"tempo":"slow"}
/// assets : {"images":{"base":"Base.png","cat":"Cat.png","cow":"Cow.png"},"audio":{"intro":"cat_cow_intro.mp3","loop":"cat_cow_loop.mp3","outro":"cat_cow_outro.mp3"}}
/// sequence : [{"type":"segment","name":"intro","audioRef":"intro","durationSec":23,"script":[{"text":"Come to all fours. Hands below shoulders, knees under hips. Feel the earth beneath you — steady, quiet, alive.","startSec":0,"endSec":7,"imageRef":"base"},{"text":"Inhale… arch your spine, lift your heart. Let your chest open like sunlight breaking through leaves.","startSec":7,"endSec":14,"imageRef":"cat"},{"text":"Exhale… round your back, tuck your chin. Feel the breath soften you like morning mist.","startSec":14,"endSec":23,"imageRef":"cow"}]},{"type":"loop","name":"breath_cycle","audioRef":"loop","durationSec":20,"iterations":"{{loopCount}}","loopable":true,"script":[{"text":"Inhale… open, expand, shine.","startSec":0,"endSec":8,"imageRef":"cat"},{"text":"Exhale… release, soften, ground.","startSec":8,"endSec":16,"imageRef":"cow"},{"text":"Feel your spine flowing like a wave through the trees.","startSec":16,"endSec":20,"imageRef":"base"}]},{"type":"segment","name":"outro","audioRef":"outro","durationSec":18,"script":[{"text":"Finish your final round…","startSec":0,"endSec":4,"imageRef":"cat"},{"text":"and return to a neutral spine.","startSec":4,"endSec":7,"imageRef":"cow"},{"text":"Notice the warmth in your back, the ease in your breath. You are supported — rooted, yet free.","startSec":7,"endSec":18,"imageRef":"base"}]}]

class YogaAppModel {
  YogaAppModel({
    Metadata? metadata,
    Assets? assets,
    List<Sequence>? sequence,
  }) {
    _metadata = metadata;
    _assets = assets;
    _sequence = sequence;
  }

  YogaAppModel.fromJson(dynamic json) {
    _metadata =
        json['metadata'] != null ? Metadata.fromJson(json['metadata']) : null;
    _assets = json['assets'] != null ? Assets.fromJson(json['assets']) : null;
    if (json['sequence'] != null) {
      _sequence = [];
      json['sequence'].forEach((v) {
        _sequence?.add(Sequence.fromJson(v));
      });
    }
  }
  Metadata? _metadata;
  Assets? _assets;
  List<Sequence>? _sequence;
  YogaAppModel copyWith({
    Metadata? metadata,
    Assets? assets,
    List<Sequence>? sequence,
  }) =>
      YogaAppModel(
        metadata: metadata ?? _metadata,
        assets: assets ?? _assets,
        sequence: sequence ?? _sequence,
      );
  Metadata? get metadata => _metadata;
  Assets? get assets => _assets;
  List<Sequence>? get sequence => _sequence;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_metadata != null) {
      map['metadata'] = _metadata?.toJson();
    }
    if (_assets != null) {
      map['assets'] = _assets?.toJson();
    }
    if (_sequence != null) {
      map['sequence'] = _sequence?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// type : "segment"
/// name : "intro"
/// audioRef : "intro"
/// durationSec : 23
/// script : [{"text":"Come to all fours. Hands below shoulders, knees under hips. Feel the earth beneath you — steady, quiet, alive.","startSec":0,"endSec":7,"imageRef":"base"},{"text":"Inhale… arch your spine, lift your heart. Let your chest open like sunlight breaking through leaves.","startSec":7,"endSec":14,"imageRef":"cat"},{"text":"Exhale… round your back, tuck your chin. Feel the breath soften you like morning mist.","startSec":14,"endSec":23,"imageRef":"cow"}]

class Sequence {
  Sequence({
    String? type,
    String? name,
    String? audioRef,
    num? durationSec,
    List<Script>? script,
  }) {
    _type = type;
    _name = name;
    _audioRef = audioRef;
    _durationSec = durationSec;
    _script = script;
  }

  Sequence.fromJson(dynamic json) {
    _type = json['type'];
    _name = json['name'];
    _audioRef = json['audioRef'];
    _durationSec = json['durationSec'];
    if (json['script'] != null) {
      _script = [];
      json['script'].forEach((v) {
        _script?.add(Script.fromJson(v));
      });
    }
  }
  String? _type;
  String? _name;
  String? _audioRef;
  num? _durationSec;
  List<Script>? _script;
  Sequence copyWith({
    String? type,
    String? name,
    String? audioRef,
    num? durationSec,
    List<Script>? script,
  }) =>
      Sequence(
        type: type ?? _type,
        name: name ?? _name,
        audioRef: audioRef ?? _audioRef,
        durationSec: durationSec ?? _durationSec,
        script: script ?? _script,
      );
  String? get type => _type;
  String? get name => _name;
  String? get audioRef => _audioRef;
  num? get durationSec => _durationSec;
  List<Script>? get script => _script;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = _type;
    map['name'] = _name;
    map['audioRef'] = _audioRef;
    map['durationSec'] = _durationSec;
    if (_script != null) {
      map['script'] = _script?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// text : "Come to all fours. Hands below shoulders, knees under hips. Feel the earth beneath you — steady, quiet, alive."
/// startSec : 0
/// endSec : 7
/// imageRef : "base"

class Script {
  Script({
    String? text,
    num? startSec,
    num? endSec,
    String? imageRef,
  }) {
    _text = text;
    _startSec = startSec;
    _endSec = endSec;
    _imageRef = imageRef;
  }

  Script.fromJson(dynamic json) {
    _text = json['text'];
    _startSec = json['startSec'];
    _endSec = json['endSec'];
    _imageRef = json['imageRef'];
  }
  String? _text;
  num? _startSec;
  num? _endSec;
  String? _imageRef;
  Script copyWith({
    String? text,
    num? startSec,
    num? endSec,
    String? imageRef,
  }) =>
      Script(
        text: text ?? _text,
        startSec: startSec ?? _startSec,
        endSec: endSec ?? _endSec,
        imageRef: imageRef ?? _imageRef,
      );
  String? get text => _text;
  num? get startSec => _startSec;
  num? get endSec => _endSec;
  String? get imageRef => _imageRef;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['text'] = _text;
    map['startSec'] = _startSec;
    map['endSec'] = _endSec;
    map['imageRef'] = _imageRef;
    return map;
  }
}

/// images : {"base":"Base.png","cat":"Cat.png","cow":"Cow.png"}
/// audio : {"intro":"cat_cow_intro.mp3","loop":"cat_cow_loop.mp3","outro":"cat_cow_outro.mp3"}

class Assets {
  Assets({
    Images? images,
    Audio? audio,
  }) {
    _images = images;
    _audio = audio;
  }

  Assets.fromJson(dynamic json) {
    _images = json['images'] != null ? Images.fromJson(json['images']) : null;
    _audio = json['audio'] != null ? Audio.fromJson(json['audio']) : null;
  }
  Images? _images;
  Audio? _audio;
  Assets copyWith({
    Images? images,
    Audio? audio,
  }) =>
      Assets(
        images: images ?? _images,
        audio: audio ?? _audio,
      );
  Images? get images => _images;
  Audio? get audio => _audio;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_images != null) {
      map['images'] = _images?.toJson();
    }
    if (_audio != null) {
      map['audio'] = _audio?.toJson();
    }
    return map;
  }
}

/// intro : "cat_cow_intro.mp3"
/// loop : "cat_cow_loop.mp3"
/// outro : "cat_cow_outro.mp3"

class Audio {
  Audio({
    String? intro,
    String? loop,
    String? outro,
  }) {
    _intro = intro;
    _loop = loop;
    _outro = outro;
  }

  Audio.fromJson(dynamic json) {
    _intro = json['intro'];
    _loop = json['loop'];
    _outro = json['outro'];
  }
  String? _intro;
  String? _loop;
  String? _outro;
  Audio copyWith({
    String? intro,
    String? loop,
    String? outro,
  }) =>
      Audio(
        intro: intro ?? _intro,
        loop: loop ?? _loop,
        outro: outro ?? _outro,
      );
  String? get intro => _intro;
  String? get loop => _loop;
  String? get outro => _outro;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['intro'] = _intro;
    map['loop'] = _loop;
    map['outro'] = _outro;
    return map;
  }
}

/// base : "Base.png"
/// cat : "Cat.png"
/// cow : "Cow.png"

class Images {
  Images({
    String? base,
    String? cat,
    String? cow,
  }) {
    _base = base;
    _cat = cat;
    _cow = cow;
  }

  Images.fromJson(dynamic json) {
    _base = json['base'];
    _cat = json['cat'];
    _cow = json['cow'];
  }
  String? _base;
  String? _cat;
  String? _cow;
  Images copyWith({
    String? base,
    String? cat,
    String? cow,
  }) =>
      Images(
        base: base ?? _base,
        cat: cat ?? _cat,
        cow: cow ?? _cow,
      );
  String? get base => _base;
  String? get cat => _cat;
  String? get cow => _cow;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['base'] = _base;
    map['cat'] = _cat;
    map['cow'] = _cow;
    return map;
  }
}

/// id : "asana_cat_cow_v1"
/// title : "Cat-Cow Flow"
/// category : "spinal_mobility"
/// defaultLoopCount : 4
/// tempo : "slow"

class Metadata {
  Metadata({
    String? id,
    String? title,
    String? category,
    num? defaultLoopCount,
    String? tempo,
  }) {
    _id = id;
    _title = title;
    _category = category;
    _defaultLoopCount = defaultLoopCount;
    _tempo = tempo;
  }

  Metadata.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _category = json['category'];
    _defaultLoopCount = json['defaultLoopCount'];
    _tempo = json['tempo'];
  }
  String? _id;
  String? _title;
  String? _category;
  num? _defaultLoopCount;
  String? _tempo;
  Metadata copyWith({
    String? id,
    String? title,
    String? category,
    num? defaultLoopCount,
    String? tempo,
  }) =>
      Metadata(
        id: id ?? _id,
        title: title ?? _title,
        category: category ?? _category,
        defaultLoopCount: defaultLoopCount ?? _defaultLoopCount,
        tempo: tempo ?? _tempo,
      );
  String? get id => _id;
  String? get title => _title;
  String? get category => _category;
  num? get defaultLoopCount => _defaultLoopCount;
  String? get tempo => _tempo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['category'] = _category;
    map['defaultLoopCount'] = _defaultLoopCount;
    map['tempo'] = _tempo;
    return map;
  }
}
