class HealthCard {
  final String title;
  final String description;
  final String image;
  final HealthType type;

  HealthCard({
    required this.title,
    required this.description,
    required this.image,
    required this.type,
  });
}

enum HealthType {
  heart,
  blood,
  water,
  step,
  weight,
  health,
}

class HealthData {
  static List<HealthCard> getHealthCards() {
    return [
      // Heart Category
      HealthCard(
        title: "Managing Fast Heart Rate with Semag",
        description:
            "Spring is the perfect time to turn the focus back to you and...",
        image:
            "https://images.unsplash.com/photo-1559757148-5c350d0d3c56?q=80&w=1000&auto=format&fit=crop",
        type: HealthType.heart,
      ),
      HealthCard(
        title: "Heart Health Monitoring",
        description:
            "Keep track of your cardiovascular health with daily monitoring...",
        image:
            "https://images.unsplash.com/photo-1628348068343-c6a848d2b6dd?q=80&w=1000&auto=format&fit=crop",
        type: HealthType.heart,
      ),
      HealthCard(
        title: "Cardio Fitness Tips",
        description:
            "Improve your heart health with these effective exercise routines...",
        image:
            "https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?q=80&w=1000&auto=format&fit=crop",
        type: HealthType.heart,
      ),
      HealthCard(
        title: "Heart Rate Zones",
        description:
            "Understanding your heart rate zones for optimal training...",
        image:
            "https://images.unsplash.com/photo-1594824596513-b0b79da8529c?q=80&w=1000&auto=format&fit=crop",
        type: HealthType.heart,
      ),

      // Blood Category
      HealthCard(
        title: "Blood Pressure Management",
        description:
            "Learn effective ways to maintain healthy blood pressure levels...",
        image:
            "https://images.unsplash.com/photo-1559757175-0eb30cd8c46d?q=80&w=1000&auto=format&fit=crop",
        type: HealthType.blood,
      ),
      HealthCard(
        title: "Blood Sugar Control",
        description:
            "Monitor and manage your blood glucose levels effectively...",
        image:
            "https://images.unsplash.com/photo-1576091160399-112ba8d25d1f?q=80&w=1000&auto=format&fit=crop",
        type: HealthType.blood,
      ),
      HealthCard(
        title: "Blood Test Insights",
        description:
            "Understanding your blood work results and what they mean...",
        image:
            "https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?q=80&w=1000&auto=format&fit=crop",
        type: HealthType.blood,
      ),
      HealthCard(
        title: "Hemoglobin Levels",
        description:
            "Maintaining healthy iron levels for optimal oxygen transport...",
        image:
            "https://images.unsplash.com/photo-1631815588090-d4bfec5b1ccb?q=80&w=1000&auto=format&fit=crop",
        type: HealthType.blood,
      ),

      // Water Category
      HealthCard(
        title: "Daily Hydration Goals",
        description:
            "Stay hydrated with personalized water intake recommendations...",
        image:
            "https://images.unsplash.com/photo-1550572017-edd951aa8cdb?q=80&w=1000&auto=format&fit=crop",
        type: HealthType.water,
      ),
      HealthCard(
        title: "Hydration Benefits",
        description:
            "Discover how proper hydration improves your overall health...",
        image:
            "https://images.unsplash.com/photo-1560472354-b33ff0c44a43?q=80&w=1000&auto=format&fit=crop",
        type: HealthType.water,
      ),
      HealthCard(
        title: "Water Quality Matters",
        description:
            "Choose the right water sources for optimal health benefits...",
        image:
            "https://images.unsplash.com/photo-1571068316344-75bc76f77890?q=80&w=1000&auto=format&fit=crop",
        type: HealthType.water,
      ),
      HealthCard(
        title: "Electrolyte Balance",
        description: "Maintain proper mineral balance for peak performance...",
        image:
            "https://images.unsplash.com/photo-1624969862293-b749659ccc4e?q=80&w=1000&auto=format&fit=crop",
        type: HealthType.water,
      ),

      // Step Category
      HealthCard(
        title: "10,000 Steps Challenge",
        description:
            "Achieve your daily step goals with motivating tracking features...",
        image:
            "https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?q=80&w=1000&auto=format&fit=crop",
        type: HealthType.step,
      ),
      HealthCard(
        title: "Walking for Health",
        description:
            "Discover the incredible benefits of daily walking routines...",
        image:
            "https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?q=80&w=1000&auto=format&fit=crop",
        type: HealthType.step,
      ),
      HealthCard(
        title: "Step Tracking Tips",
        description: "Maximize your step counter accuracy and motivation...",
        image:
            "https://images.unsplash.com/photo-1502904550040-7534597429ae?q=80&w=1000&auto=format&fit=crop",
        type: HealthType.step,
      ),
      HealthCard(
        title: "Active Lifestyle",
        description: "Incorporate more movement into your daily routine...",
        image:
            "https://images.unsplash.com/photo-1434494878577-86c23bcb06b9?q=80&w=1000&auto=format&fit=crop",
        type: HealthType.step,
      ),

      // Weight Category
      HealthCard(
        title: "Boost Your Spring Wellness Routine",
        description:
            "Spring is the perfect time to turn the focus back to you and...",
        image:
            "https://images.unsplash.com/photo-1551601651-2a8555f1a136?q=80&w=847&auto=format&fit=crop",
        type: HealthType.weight,
      ),
      HealthCard(
        title: "Healthy Weight Management",
        description: "Sustainable approaches to reaching your ideal weight...",
        image:
            "https://images.unsplash.com/photo-1574680096145-d05b474e2155?q=80&w=1000&auto=format&fit=crop",
        type: HealthType.weight,
      ),
      HealthCard(
        title: "Body Composition Analysis",
        description:
            "Understanding muscle mass, fat percentage, and bone density...",
        image:
            "https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?q=80&w=1000&auto=format&fit=crop",
        type: HealthType.weight,
      ),
      HealthCard(
        title: "Metabolism Boosters",
        description:
            "Natural ways to increase your metabolic rate effectively...",
        image:
            "https://images.unsplash.com/photo-1506629905622-4b2c0aee7058?q=80&w=1000&auto=format&fit=crop",
        type: HealthType.weight,
      ),

      // Health Category
      HealthCard(
        title: "Overall Wellness Check",
        description:
            "Comprehensive health monitoring for your peace of mind...",
        image:
            "https://images.unsplash.com/photo-1576091160550-2173dba999ef?q=80&w=1000&auto=format&fit=crop",
        type: HealthType.health,
      ),
      HealthCard(
        title: "Mental Health Matters",
        description:
            "Strategies for maintaining emotional and psychological well-being...",
        image:
            "https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?q=80&w=1000&auto=format&fit=crop",
        type: HealthType.health,
      ),
      HealthCard(
        title: "Sleep Quality Improvement",
        description: "Tips for better sleep patterns and recovery...",
        image:
            "https://images.unsplash.com/photo-1520206319821-0496cfdec433?q=80&w=1000&auto=format&fit=crop",
        type: HealthType.health,
      ),
      HealthCard(
        title: "Stress Management",
        description:
            "Effective techniques to reduce and manage daily stress...",
        image:
            "https://images.unsplash.com/photo-1506629905622-4b2c0aee7058?q=80&w=1000&auto=format&fit=crop",
        type: HealthType.health,
      ),
    ];
  }
}
