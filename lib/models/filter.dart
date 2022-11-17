class Filter {
  final String name;
  final String path;
  final int min;
  final int max;
  final String gameObject;
  final String parameter;
  final String component;

  Filter({
    required this.name,
    required this.path,
    required this.min,
    required this.max,
    required this.gameObject,
    required this.parameter,
    this.component = 'MeshRenderer',
  });
}
