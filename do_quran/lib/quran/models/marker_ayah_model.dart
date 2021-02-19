enum MarkerType { lastAyah, pinnedAyah }

class MarkerAyah {
  MarkerAyah({this.surah, this.ayah, this.type});
  int surah;
  int ayah;
  MarkerType type;
}
