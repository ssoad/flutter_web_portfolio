import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/project_model.dart';

final projectsProvider = Provider<List<ProjectModel>>((ref) {
  return [
    ProjectModel(
      id: 1,
      title: "Wanderlust - Travel Companion",
      description: "AI-powered travel planner with real-time recommendations",
      imageUrl: "https://picsum.photos/800/600?random=1",
      githubUrl: "https://github.com/ssoad/wanderlust",
      liveUrl: "https://wanderlust-ai.com",
      technologies: ["Flutter", "TensorFlow", "Node.js", "MongoDB"],
      features: [
        "AI Trip Planning",
        "Real-time Weather",
        "Local Recommendations",
        "Offline Maps"
      ],
      metrics: ProjectMetrics(
        stars: 128,
        forks: 45,
        downloads: "10K+",
        commits: 456,
        contributors: 3,
      ),
      category: "Mobile Apps",
      date: DateTime(2024, 3, 1),
      status: ProjectStatus.completed,
      type: ProjectType.personal,
      role: "Lead Developer",
      achievements: [
        "Featured on Flutter Weekly",
        "10K+ Active Users",
        "4.8 Star Rating"
      ],
      duration: const Duration(days: 120),
    ),
    ProjectModel(
      id: 2,
      title: "CodeCanvas - Developer Portfolio",
      description: "Modern portfolio template with animated code editor",
      imageUrl: "https://picsum.photos/800/600?random=2",
      githubUrl: "https://github.com/ssoad/codecanvas",
      liveUrl: "https://codecanvas.dev",
      technologies: ["Flutter Web", "Riverpod", "Three.js", "Firebase"],
      features: [
        "Live Code Editor",
        "3D Animations",
        "Dark/Light Theme",
        "Analytics Dashboard"
      ],
      metrics: ProjectMetrics(
        stars: 256,
        forks: 89,
        downloads: "5K+",
        commits: 234,
        contributors: 5,
      ),
      category: "Web Development",
      date: DateTime(2024, 2, 15),
      status: ProjectStatus.completed,
      type: ProjectType.openSource,
      role: "Creator & Maintainer",
      achievements: [
        "500+ GitHub Stars",
        "Featured on Dev.to",
        "Used by 100+ Developers"
      ],
      duration: const Duration(days: 90),
    ),
    ProjectModel(
      id: 3,
      title: "SmartHome Hub",
      description: "IoT-based home automation system",
      imageUrl: "https://picsum.photos/800/600?random=3",
      githubUrl: "https://github.com/ssoad/smarthome",
      liveUrl: "https://smarthome.dev",
      technologies: ["Flutter", "ESP32", "MQTT", "Firebase"],
      features: [
        "Voice Control",
        "Energy Monitoring",
        "Smart Scenes",
        "Device Management"
      ],
      metrics: ProjectMetrics(
        stars: 189,
        forks: 34,
        downloads: "8K+",
        commits: 345,
        contributors: 4,
      ),
      category: "IoT",
      date: DateTime(2024, 1, 20),
      status: ProjectStatus.inProgress,
      type: ProjectType.client,
      role: "Technical Lead",
      achievements: [
        "Best IoT Solution 2024",
        "Featured in TechCrunch",
        "1M+ Devices Connected"
      ],
      duration: const Duration(days: 180),
    ),
    ProjectModel(
      id: 4,
      title: "AI Image Generator",
      description: "Text-to-image generation using deep learning",
      imageUrl: "https://picsum.photos/800/600?random=4",
      githubUrl: "https://github.com/ssoad/ai-image",
      liveUrl: "https://ai-image.app",
      technologies: ["Flutter", "PyTorch", "FastAPI", "AWS"],
      features: [
        "Text to Image",
        "Style Transfer",
        "Batch Processing",
        "Custom Training"
      ],
      metrics: ProjectMetrics(
        stars: 312,
        forks: 67,
        downloads: "15K+",
        commits: 567,
        contributors: 6,
      ),
      category: "AI/ML",
      date: DateTime(2023, 12, 10),
      status: ProjectStatus.completed,
      type: ProjectType.research,
      role: "ML Engineer",
      achievements: [
        "Research Paper Published",
        "15K+ Daily Generations",
        "Top AI Project 2023"
      ],
      duration: const Duration(days: 150),
    ),
    ProjectModel(
      id: 5,
      title: "DevTools Suite",
      description: "Collection of developer productivity tools",
      imageUrl: "https://picsum.photos/800/600?random=5",
      githubUrl: "https://github.com/ssoad/devtools",
      liveUrl: "https://devtools.dev",
      technologies: ["Flutter", "Rust", "WebAssembly", "GraphQL"],
      features: [
        "Code Analysis",
        "Performance Profiling",
        "Debug Tools",
        "Testing Suite"
      ],
      metrics: ProjectMetrics(
        stars: 423,
        forks: 91,
        downloads: "20K+",
        commits: 678,
        contributors: 8,
      ),
      category: "Developer Tools",
      date: DateTime(2023, 11, 15),
      status: ProjectStatus.maintenance,
      type: ProjectType.openSource,
      role: "Core Maintainer",
      achievements: [
        "GitHub Trending #1",
        "20K+ Active Users",
        "Featured in GitHub Blog"
      ],
      duration: const Duration(days: 210),
    ),
  ];
});
