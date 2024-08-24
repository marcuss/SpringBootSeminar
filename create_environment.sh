#!/bin/bash

# Function to check if a command exists
command_exists() {
    command -v "$1" &> /dev/null
}

# Check if Homebrew is installed
if ! command_exists brew; then
    echo "Homebrew not found. Please install Homebrew first."
    exit 1
fi

# Check if Python is installed
if ! command_exists python3; then
    echo "Python not found. Installing Python..."
    brew install python
else
    echo "Python is already installed."
fi

# Check if pip3 is installed
if ! command_exists pip3; then
    echo "pip3 not found. Installing pip..."
    python3 -m ensurepip
else
    echo "pip3 is already installed."
fi

# Check if python-pptx is installed
if ! pip3 show python-pptx &> /dev/null; then
    echo "python-pptx not found. Installing python-pptx..."
    pip3 install python-pptx
else
    echo "python-pptx is already installed."
fi

# Check if virtual environment directory exists
if [ ! -d "myenv" ]; then
    echo "Creating virtual environment..."
    python3 -m venv myenv
else
    echo "Virtual environment 'myenv' already exists."
fi

# Activate the virtual environment
source myenv/bin/activate

# Reinstall python-pptx in the virtual environment (if needed)
if ! pip show python-pptx &> /dev/null; then
    echo "Reinstalling python-pptx in the virtual environment..."
    pip install python-pptx
else
    echo "python-pptx is already installed in the virtual environment."
fi


cat << EOF > create_presentation.py
from pptx import Presentation

# Create a presentation object
prs = Presentation()

# Define the slide titles and content
slides_content = [
    ("Introduction to Spring Boot 3", "Brief overview of the presentation\\nHighlight key differences from earlier versions"),
    ("Core Enhancements in Spring Boot 3", "Discuss significant improvements and new features\\nExample: AOT (Ahead-of-Time) compilation, new APIs, performance enhancements"),
    ("Migration from Spring Boot 2.x to 3.x", "Key considerations for upgrading existing applications\\nPotential breaking changes and how to address them"),
    ("Enhanced Security Features", "New security configurations and enhancements\\nHow Spring Boot 3 integrates with Spring Security 6"),
    ("Spring Boot 3 and GraalVM Native Image Support", "Introduction to native image compilation with GraalVM\\nBenefits and performance considerations"),
    ("Advanced Configuration and Customization", "New configuration options in Spring Boot 3\\nBest practices for customization and configuration management"),
    ("Improved Observability and Monitoring", "Discuss enhancements in metrics, tracing, and logging\\nIntegration with tools like Prometheus, Grafana, and Zipkin"),
    ("Spring Boot 3 and Microservices Architecture", "How Spring Boot 3 optimizes microservices development\\nExamples of microservices patterns and implementations"),
    ("Spring Boot 3 with Kubernetes and Docker", "Containerization best practices with Spring Boot 3\\nDeploying Spring Boot 3 applications on Kubernetes"),
    ("Performance Tuning in Spring Boot 3", "Techniques for optimizing performance in production environments\\nMemory management, startup time, and runtime efficiency"),
    ("Case Study: Real-World Application of Spring Boot 3", "Present a real-world case study or example project\\nHighlight challenges faced and solutions implemented"),
    ("Best Practices and Lessons Learned", "Common pitfalls and how to avoid them\\nRecommendations for maintaining code quality and scalability"),
    ("Q&A", "Open the floor for questions\\nEngage with the audience on their specific challenges"),
    ("Conclusion and Next Steps", "Recap key takeaways from the presentation\\nProvide resources for further learning (e.g., documentation, blogs, courses)")
]

# Add each slide to the presentation
for title, content in slides_content:
    slide_layout = prs.slide_layouts[1]  # Using the 'Title and Content' layout
    slide = prs.slides.add_slide(slide_layout)
    title_placeholder = slide.shapes.title
    content_placeholder = slide.placeholders[1]

    title_placeholder.text = title
    content_placeholder.text = content

# Save the presentation
prs.save("Spring_Boot_3_Presentation.pptx")
EOF


#!/bin/bash
echo "Hello, World!"
python3 create_presentation.py
