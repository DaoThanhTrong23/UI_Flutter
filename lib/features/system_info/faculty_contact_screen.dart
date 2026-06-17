import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'faculty_view_model.dart';

class FacultyContactScreen extends ConsumerStatefulWidget {
  const FacultyContactScreen({super.key});

  @override
  ConsumerState<FacultyContactScreen> createState() => _FacultyContactScreenState();
}

class _FacultyContactScreenState extends ConsumerState<FacultyContactScreen> {
  String _searchQuery = '';
  String? _selectedFaculty;
  bool _isAscending = true;

  @override
  Widget build(BuildContext context) {
    final facultyAsync = ref.watch(facultyViewModelProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Liên hệ khoa'),
        actions: [
          IconButton(
            icon: Icon(_isAscending ? Icons.sort_by_alpha : Icons.sort_by_alpha_outlined),
            onPressed: () {
              setState(() {
                _isAscending = !_isAscending;
              });
            },
          ),
        ],
      ),
      body: facultyAsync.when(
        data: (faculties) {
          var filtered = faculties.where((f) => f.name.toLowerCase().contains(_searchQuery)).toList();
          if (_selectedFaculty != null) {
            filtered = filtered.where((f) => f.faculty == _selectedFaculty).toList();
          }

          filtered.sort((a, b) {
            // Cố vấn học tập always on top if not specifically sorted out
            if (a.faculty == 'Cố vấn học tập' && b.faculty != 'Cố vấn học tập') return -1;
            if (b.faculty == 'Cố vấn học tập' && a.faculty != 'Cố vấn học tập') return 1;
            return _isAscending ? a.name.compareTo(b.name) : b.name.compareTo(a.name);
          });

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextField(
                        decoration: const InputDecoration(
                          hintText: 'Tìm theo tên...',
                          prefixIcon: Icon(Icons.search),
                        ),
                        onChanged: (val) {
                          setState(() {
                            _searchQuery = val.toLowerCase();
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 1,
                      child: DropdownButtonFormField<String?>(
                        value: _selectedFaculty,
                        isExpanded: true,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                        ),
                        hint: const Text('Khoa', overflow: TextOverflow.ellipsis),
                        items: const [
                          DropdownMenuItem<String?>(
                            value: null,
                            child: Text('Tất cả', overflow: TextOverflow.ellipsis),
                          ),
                          DropdownMenuItem<String?>(
                            value: 'Cố vấn học tập',
                            child: Text('Cố vấn học tập', overflow: TextOverflow.ellipsis),
                          ),
                        ],
                        onChanged: (val) {
                          setState(() {
                            _selectedFaculty = val;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: filtered.isEmpty
                  ? Center(
                      child: Text(
                        'Không tìm thấy giảng viên',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.6),
                        ),
                      ),
                    )
                  : RefreshIndicator(
                  onRefresh: () async => ref.invalidate(facultyViewModelProvider),
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    itemCount: filtered.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final f = filtered[index];
                      return Card(
                        elevation: theme.cardTheme.elevation ?? 4,
                        shadowColor: theme.cardTheme.shadowColor,
                        shape: theme.cardTheme.shape,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
                                child: Icon(
                                  Icons.person,
                                  size: 36,
                                  color: theme.colorScheme.primary,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      f.name,
                                      style: theme.textTheme.titleMedium?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      f.faculty,
                                      style: theme.textTheme.bodyMedium?.copyWith(
                                        color: theme.colorScheme.onSurface.withOpacity(0.6),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.email,
                                          size: 16,
                                          color: theme.colorScheme.primary.withOpacity(0.8),
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            f.email,
                                            style: theme.textTheme.bodyMedium?.copyWith(
                                              color: theme.colorScheme.onSurface.withOpacity(0.8),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.phone,
                                          size: 16,
                                          color: theme.colorScheme.primary.withOpacity(0.8),
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            f.phone,
                                            style: theme.textTheme.bodyMedium?.copyWith(
                                              color: theme.colorScheme.onSurface.withOpacity(0.8),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Text(
            'Lỗi tải dữ liệu: $e',
            style: TextStyle(color: theme.colorScheme.error),
          ),
        ),
      ),
    );
  }
}
