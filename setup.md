

Here is a detailed outline to guide you from start to finish.

---

## Part 1: Managing Your Google PM Certificate as a Formal Project

Think of "Complete the Google PM Certificate" as your first official project. You will be the  **Project Manager** . This approach will form the content of your first blog post, your "walkthrough."

### Phase 1: Project Initiation 🚀

This is where you define the project and its goals.

1. **Create a Project Charter:** Make a simple, one-page document.
   * **Project Title:** Google Project Management Certificate Learning Journey.
   * **Project Goal (SMART Goal):** "To successfully complete the Google Project Management Professional Certificate on Coursera with a final grade of over 90% by January 31, 2026, by dedicating 6-8 hours per week, in order to gain foundational project management skills and enhance my employability for tech internships."
   * **Key Stakeholders:** Yourself, future employers, your academic mentor.
   * **High-Level Deliverables:**
     * Completion of all 6 courses.
     * A final, shareable certificate.
     * A "Lessons Learned" document (this will be your blog post!).

### Phase 2: Project Planning 🗺️

This is where you create your roadmap.

1. **Define the Scope:** List all 6 courses in the Google PM Certificate specialization. This is the "work" that needs to be done.
2. **Create a Work Breakdown Structure (WBS):** Break the work into smaller, manageable tasks.
   * **Level 1:** Course 1: Foundations of Project Management
     * **Level 2:** Week 1 Videos & Readings
     * **Level 2:** Week 1 Quiz
     * **Level 2:** Week 2 Videos & Readings
     * ...and so on for all 6 courses.
3. **Develop a Schedule/Timeline:**
   * Use a simple tool like **Google Sheets** or **Asana** (which you'll learn about in the course).
   * Create a  **Gantt chart** . List all your tasks from the WBS and set start and end dates. As it's now September 1st, 2025, you can plan this out over the next 4-5 months. Be realistic and schedule around your university exams and holidays.
4. **Identify Risks (Risk Register):** What could go wrong?
   * **Risk:** University exam period reduces study time. **Mitigation:** Plan lighter PM study weeks during midterms/finals.
   * **Risk:** Losing motivation. **Mitigation:** Set weekly rewards for hitting targets; connect with other learners on the Coursera forums.

### Phase 3: Project Execution & Monitoring 🛠️

This is the "doing" and "tracking" phase.

1. **Execute the Plan:** Start the course! Follow your schedule.
2. **Track Your Progress:**
   * Update your Gantt chart weekly. Mark tasks as "complete."
   * Keep a simple **"Project Journal"** in a Google Doc or Notion. Every week, write a few sentences:
     * What did I accomplish this week?
     * What challenges did I face?
     * What was the most interesting thing I learned?
   * This journal will be the raw material for your blog post!

### Phase 4: Project Closing 🎉

You've finished the course! Now, you close the project formally.

1. **Confirm Completion:** You have the certificate! This is your final deliverable.
2. **Create Your "Lessons Learned" Report:** This is your detailed walkthrough and first blog post. Using your Project Journal and planning documents, you'll write the story of your project.

---

## Part 2: Creating Your GitHub Pages Blog

Now, let's turn that "Lessons Learned" report into a professional blog post on your own website.

### Step 1: Create the GitHub Repository

1. Log in to your GitHub account.
2. Create a new public repository. This must be named in a specific format:
   your-username.github.io
   (For example, if your username is jdelacruz, the repository must be named jdelacruz.github.io)
3. Initialize it with a `README.md` file.

### Step 2: Choose and Configure a Jekyll Theme

GitHub Pages uses a tool called **Jekyll** to build websites. The easiest way to start is with a pre-made theme.

1. In your new repository, go to  **Settings > Pages** .
2. Under "Build and deployment," the source should be "Deploy from a branch."
3. Click on the **"Choose a theme"** button.
4. Select a simple theme like **Minimal** or  **Cayman** . GitHub will automatically create the necessary files in your repository.

### Step 3: Write Your First Blog Post

This is where you'll post your "Google PM Certificate Walkthrough."

1. Go back to the "Code" tab of your repository.
2. Create a new folder named `_posts`. **The name is important!**
3. Inside the _posts folder, create a new file. The file name must follow this format:
   YYYY-MM-DD-your-post-title.md
   * Example: `2026-01-31-my-google-pm-certificate-journey.md`
4. **Write the content.** A Jekyll post starts with "front matter" followed by the main text in Markdown. Copy and paste the structure below into your file and fill it in with your project details.

**Markdown**

```
---
layout: default
title:  "How I Used Project Management to Ace the Google PM Certificate"
date:   2026-01-31 09:00:00 +0800
---

## My First Official Project: A Walkthrough of My Learning Journey

Welcome to my learning blog! For my first post, I wanted to share how I applied the principles from the Google Project Management Certificate to the learning process itself. I treated the entire certificate as a formal project.

### Phase 1: Project Initiation

My goal was clear: I created a Project Charter to define what success looked like. My SMART goal was...
*(Continue to detail each phase: Planning, Execution, and Closing, using the notes from your Project Journal. Include screenshots of your Gantt chart or risk register!)*

### Phase 4: Project Closing & Key Learnings

Completing the certificate was the final deliverable. My key takeaways were:
1.  **The power of planning:** Having a schedule kept me on track even during busy school weeks.
2.  **Risk management is practical:** I anticipated the challenge of exams and planned for it, which prevented me from falling behind.

Thanks for reading!
```

### Step 4: Customize Your Site

1. Find the `_config.yml` file in your repository.
2. Click the "Edit" pencil icon.
3. Change the `title:` and `description:` fields to personalize your site. You can also add a `theme:` line if you want to switch themes later.
   * Example:
     **YAML**

     ```
     title: Juan's Tech Journey
     description: A blog about my adventures in cybersecurity, development, and project management.
     ```
4. Commit your changes.

### Step 5: Go Live!

Once you commit your changes (your post and your config file), GitHub Actions will automatically build and deploy your site. Wait about 1-2 minutes.

You can then visit your live blog at `https://your-username.github.io`.

Congratulations! You now have a professional portfolio website with a fantastic first post that showcases your ability to learn and apply new skills.


Here is a detailed file and folder structure designed only for your project management learning journey.

### Local Workspace for Your "PM Learning Journey" Project

Create a main folder on your computer. We'll call it `PM_Learning_Journey`. Inside, we will have two main sub-folders: one for your private project files and one for your public website.

```
📁 PM_Learning_Journey/
|
|--- 📁 1_Project_Files/  (Your private workspace for course materials & planning)
|    |
|    |--- 📁 01_Initiation/
|    |    |--- 📄 Project_Charter.docx
|    |
|    |--- 📁 02_Planning/
|    |    |--- 📄 Project_Plan_Gantt_Chart.xlsx
|    |    |--- 📄 Risk_Register.md
|    |
|    |--- 📁 03_Execution/
|    |    |--- 📄 Weekly_Project_Journal.md
|    |    |--- 📁 Course_Notes/
|    |         |--- 📄 Course_1_Foundations.md
|    |         |--- 📄 Course_2_Initiation_and_Planning.md
|    |         |--- 📄 Course_3_Execution_with_Agile.md
|    |         |--- ...and so on for all 6 courses
|    |
|    |--- 📁 04_Closing/
|         |--- 📄 Lessons_Learned_Report_(Blog_Draft).docx
|         |--- 📁 Certificate/
|              |--- 📄 Google_PM_Certificate.pdf
|
|--- 📁 2_Public_Website/ (This will be named your-username.github.io)
     |
     |--- 📁 _posts/
     |    |--- 📄 2026-01-31-my-google-pm-certificate-journey.md
     |
     |--- 📁 assets/
     |    |--- 📁 images/
     |         |--- 🖼️ project_plan_screenshot.png
     |
     |--- 📄 _config.yml
     |--- 📄 index.md
     |--- 📄 README.md

```

---

### Explanation of This Focused Structure

#### 📂 `1_Project_Files/`

This is your private command center. **Nothing in here gets uploaded to your public GitHub blog.** It's purely for your organization and study.

* **Numbered Folders (`01_Initiation`, `02_Planning`, etc.):** These folders directly mirror the phases of a project. This is you *living* the project management process. It keeps your documents organized chronologically and conceptually.
* **`Weekly_Project_Journal.md`:** This is your most important file during the course. Every week, open this file and write down what you learned, your progress against your schedule, and any challenges. This journal will make writing your final blog post incredibly easy.
* **`Lessons_Learned_Report_(Blog_Draft).docx`:** This is where you can write the full draft of your final blog post in a word processor before converting it to Markdown for your website.

#### 📂 `2_Public_Website/` (named `your-username.github.io`)

This is the clean, professional, public-facing folder that will become your live website.

* **`_posts/`** : This will only contain your final, polished blog post. It will be the "Lessons Learned" report that you've perfected.
* **`assets/images/`** : This folder will hold the specific images you choose to feature in your blog post, like a clean screenshot of your Gantt chart from your `Project_Files` folder.

### The Simple Workflow This Enables

1. **Work Privately:** As you study, all your work—your notes, your planning documents, your weekly thoughts—goes into the **`1_Project_Files`** folder. This is your messy, creative space.
2. **Prepare for Publishing:** When you have completed the course and earned the certificate, you will write your final "Lessons Learned" blog post. You will use all the documents in your `Project_Files` folder as a reference.
3. **Publish Publicly:** You will place the final, polished Markdown file (`.md`) of your post into the **`2_Public_Website/_posts/`** folder. You will also add any final screenshots to the `assets/images/` folder.
4. **Sync to GitHub:** You will then use Git to push **only the `2_Public_Website` folder** to your GitHub repository.

This structure is the perfect way to stay organized. It separates your process from your product, which is a fundamental concept in both project management and software development. You're building excellent habits for your future career.




### 1. Project Charter (`Project_Charter.md`)

**Markdown**

```
# Project Charter: Google PM Certificate Learning Journey

**Project Title:** Google Project Management Certificate Completion

**Project Manager:** [Your Name]

**Date:** September 1, 2025

---

### 1. Project Goal & Objectives

To successfully complete the Google Project Management Professional Certificate on Coursera by January 31, 2026. The primary objective is to gain a practical, industry-recognized understanding of project management principles, methodologies, and tools to enhance my resume and qualify for tech internships in 2026.

### 2. Key Deliverables
* Successful completion of all 6 courses with a final grade above 90%.
* The official, shareable Coursera Professional Certificate.
* A comprehensive "Lessons Learned" blog post documenting the entire process, to be published on my personal portfolio website.

### 3. Key Stakeholders
* **Primary:** Myself
* **Secondary:** Future Employers/Recruiters, University Mentors

### 4. High-Level Timeline & Milestones
* **Project Start:** September 1, 2025
* **Coursework Completion:** January 20, 2026
* **Blog Post Published:** January 31, 2026
* **Project End:** January 31, 2026

### 5. High-Level Budget
* **Coursera Subscription:** Est. ₱2,500/month for ~5 months.
* **Contingency:** ₱1,500 for potential extra month.
* **Total Estimated Cost:** ~₱14,000 (Note: Applying for Financial Aid is a key cost-saving measure).

### 6. Approval
**Signed:** [Your Name], Project Manager
```

---

### 2. Project Plan (Text-Based Gantt Chart) (`Project_Plan.md`)

**Markdown**

```
# Project Plan: Google PM Certificate Schedule

**Timeline:** September 1, 2025 - January 31, 2026

| ID | Task                                    | Duration | Start Date | End Date   | Status      |
|----|-----------------------------------------|----------|------------|------------|-------------|
| 1  | **Phase 1: Project Initiation & Planning** | 1 Week   | 2025-09-01 | 2025-09-07 | Completed   |
| 2  | **Phase 2: Course 1 - Foundations** | 3 Weeks  | 2025-09-08 | 2025-09-28 | In Progress |
| 3  | **Phase 3: Course 2 - Initiation** | 3 Weeks  | 2025-09-29 | 2025-10-19 | Not Started |
| 4  | **Phase 4: Course 3 - Planning** | 3 Weeks  | 2025-10-20 | 2025-11-09 | Not Started |
| 5  | **Phase 5: Course 4 - Execution** | 4 Weeks  | 2025-11-10 | 2025-12-07 | Not Started |
| 6  | **Phase 6: Course 5 - Agile PM** | 4 Weeks  | 2025-12-08 | 2026-01-04 | Not Started |
| 7  | **Phase 7: Course 6 - Capstone** | 3 Weeks  | 2026-01-05 | 2026-01-25 | Not Started |
| 8  | **Phase 8: Project Closing (Blog Post)** | 1 Week   | 2026-01-26 | 2026-01-31 | Not Started |

*Note: Schedule includes a buffer for university midterms/finals in October and December.*
```

---

### 3. Risk Register (`Risk_Register.md`)

**Markdown**

```
# Risk Register

| ID | Risk Description                                  | Probability | Impact | Mitigation Strategy                                               |
|----|---------------------------------------------------|-------------|--------|-------------------------------------------------------------------|
| R01| University exam workload conflicts with study plan. | High        | High   | Proactively schedule lighter PM study weeks during exam periods.  |
| R02| Slow or unstable internet connection (common in PH).| Medium      | Medium | Download course videos in advance for offline viewing.            |
| R03| Loss of motivation or burnout over the 5-month period.| Medium      | High   | Set small weekly rewards. Engage in Coursera forums for community.|
| R04| Scope creep: getting distracted by other courses.   | Low         | Medium | Stick to the project plan. Log other interests for after this project.|
```

---

### 4. Sample Course Notes (`Course_1_Notes.md`)

**Markdown**

```
# Course 1: Foundations of Project Management - Week 1 Notes

### What is Project Management?
* It's the application of **knowledge, skills, tools, and techniques** to project activities to meet project requirements.
* A **project** is temporary (has a start and end date) and produces a unique product, service, or result.
* Different from **operations**, which are ongoing.

### Key Roles
* **Project Manager:** The person responsible for leading the project and steering it to success.
* **Stakeholders:** Anyone who is affected by the project or has an interest in its outcome. Can be internal or external.

### The 4 Phases of the Project Life Cycle
1.  **Initiation:** Define the project and get authorization to start. Create the **Project Charter**.
2.  **Planning:** Develop the roadmap. Define scope, schedule, budget, and risks.
3.  **Execution:** Do the work! Manage the team, communicate with stakeholders.
4.  **Closing:** Finish the project. Hand off deliverables and document **lessons learned**.
```

---

### 5. Sample Weekly Project Journal (`Weekly_Project_Journal.md`)

**Markdown**

```
# Weekly Project Journal

### Week 1: September 1 - 7, 2025
* **Tasks Completed:**
    * Created Project Charter, Project Plan, and Risk Register.
    * Set up my local workspace folders.
    * Created the GitHub repository and initial blog setup.
* **Challenges Faced:** None, this was a planning week. Felt very organized.
* **Key Learnings:** The act of creating a charter forces you to think clearly about *why* you're doing a project.
* **Plan for Next Week:** Start Course 1 and complete the Week 1 module.

### Week 2: September 8 - 14, 2025
* **Tasks Completed:**
    * Watched all videos for Course 1, Week 1.
    * Completed all readings and passed the Week 1 quiz with 95%.
    * Took detailed notes on the project life cycle.
* **Challenges Faced:** Found it hard to balance study time with university assignments on Tuesday.
* **Key Learnings:** The difference between a project and ongoing operations is a fundamental concept.
* **Plan for Next Week:** Complete Course 1, Week 2 module and start on the first graded assignment.
```

---

### 6. The Final Blog Post (`2026-01-31-my-google-pm-certificate-journey.md`)

**Markdown**

```
---
layout: default
title:  "How I Used Project Management to Ace the Google PM Certificate"
date:   2026-01-31 09:00:00 +0800
---

## My First Official Project: A Walkthrough of My Learning Journey

Welcome to my learning blog! Over the past five months, I've been on a journey to earn the Google Project Management Professional Certificate. But instead of just *taking* the course, I decided to *live* it. I treated the entire certificate program as my first official project, and I'm here to share how I did it.

### Phase 1: Initiation - Defining the "Why"

Every project needs a beginning. For me, it started with a **Project Charter**. I clearly defined my goal: to complete the certificate by January 31, 2026, to gain skills for tech internships. This wasn't just a course; it was a career move. Having this document kept me focused on the end goal.

### Phase 2: Planning - Building My Roadmap

With my "why" established, I created a detailed **Project Plan**. Using a simple table as a Gantt chart, I mapped out all six courses, estimating about three weeks for each. I also created a **Risk Register**, anticipating challenges like my university exams and potential burnout. Planning for these risks ahead of time was a game-changer.

![My Project Plan](/assets/images/project_plan_screenshot.png)
*(Here you would insert a screenshot of your plan)*

### Phase 3: Execution - The Weekly Grind

This was the longest phase. Each week, I followed my plan, watching lectures and taking quizzes. My most valuable tool here was my **Weekly Project Journal**. Every Sunday, I documented what I completed, the challenges I faced, and what I learned. This kept me accountable and provided invaluable insights for this very blog post.

### Phase 4: Closing - Lessons Learned

After five months of dedicated work, I successfully earned the certificate! But the project wasn't over. The final step was to close it out by reflecting on my journey.

**My Key Learnings:**
1.  **Structure is Freedom:** Having a plan didn't restrict me; it gave me the freedom to study without worrying if I was on track.
2.  **Document Everything:** My weekly journal was a goldmine of information. I didn't have to struggle to remember details when writing this post.
3.  **PM Skills are Life Skills:** These principles can be applied to anything, from academic projects to personal goals.

This project was a fantastic experience that taught me more than I could have imagined. If you're starting your own learning journey, I can't recommend this structured approach enough!
```

---

### 7. Site Config File (`_config.yml`)

**YAML**

```
# Welcome to Jekyll!
#
# This config file is meant for settings that affect your whole blog, values
# which you are expected to set up once and rarely edit after that.

# Site settings
title: Juan's Tech Journey
description: >- # this means to ignore newlines until "baseurl:"
  A student's journey through cybersecurity, project management, and software development in the Philippines.
baseurl: "" # the subpath of your site, e.g. /blog
url: "https://your-username.github.io" # the base hostname & protocol for your site
github_username:  your-username

# Build settings
theme: jekyll-theme-minimal
plugins:
  - jekyll-feed
```

---

### 8. Homepage File (`index.md`)

**Markdown**

```
---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults

layout: default
---

## Welcome to My Learning Journey

Hello! My name is [Your Name], a BSIT student from the Philippines with a passion for cybersecurity and technology.

This site is my personal portfolio and blog where I document my projects, share what I'm learning, and track my growth in the tech world. Thank you for visiting!

---

### Recent Posts

<ul>
  {% for post in site.posts %}
    <li>
      <a href="{{ post.url | relative_url }}">{{ post.title }}</a>
      <p>{{ post.date | date: "%B %d, %Y" }}</p>
    </li>
  {% endfor %}
</ul>
```

---

### 9. Repository `README.md`

**Markdown**

```
# My Personal Portfolio & Learning Blog

Hello and welcome to the repository for my personal portfolio website!

## 🚀 About This Project

This repository contains the source code for my personal blog, built with Jekyll and hosted on GitHub Pages. The purpose of this site is to:

* Document my projects and learning journey as a BSIT student.
* Showcase my skills in web development, cybersecurity, and project management.
* Share my knowledge with the tech community.

## 🌐 Live Site

You can view the live version of the site at: **https://your-username.github.io**

## 🛠️ Built With

* [Jekyll](https://jekyllrb.com/) - A static site generator.
* [GitHub Pages](https://pages.github.com/) - Hosting.
* Markdown

Thank you for checking it out!
```

---

## Practical Workspace Bootstrap (New Unified Reference)

This section summarizes the operational folder structure now in use and how new artifacts should be placed. It augments (not replaces) the detailed narrative above.

### Repository Role
This repository = private learning knowledge base. Public, polished content belongs in a separate `joembolinas.github.io` repository (do not embed that repo as a folder here).

### Core Private Structure (`1_Project_Files/`)

```
1_Project_Files/
  01_Initiation/
    Project_Charter.md
  02_Planning/
    Project_Plan.md
    Risk_Register.md
  03_Execution/
    Weekly_Project_Journal.md
    Course_Notes/
      Course_1_Foundations.md
      Course_2_Initiation_and_Planning.md
      Course_3_Execution_with_Agile.md
      Course_4_Execution.md
      Course_5_Agile_PM.md
      Course_6_Capstone.md
  04_Closing/
    Lessons_Learned_Report_Blog_Draft.md
```

### Legacy / Parallel Directories
- `src/` remains the raw transcript dump (immutable; do not relocate retroactively yet).
- `notes/` holds earlier synthesized artifacts; new structured summaries should transition into `1_Project_Files/03_Execution/Course_Notes/` going forward. Optionally link back rather than migrate.
- `Foundations of Project Management/` retains existing images & progress log; future images can be referenced until a consolidated asset strategy is defined.

### File Placement Guidance
| Artifact Type | Destination | Notes |
|---------------|------------|-------|
| Raw lecture transcript | `src/` | Keep numbering pattern; no edits besides typos. |
| Weekly reflection | `1_Project_Files/03_Execution/Weekly_Project_Journal.md` | Add newest week at top. |
| Course structured summary | `1_Project_Files/03_Execution/Course_Notes/` | Include Sources section citing `src/*.txt`. |
| Risk updates | `1_Project_Files/02_Planning/Risk_Register.md` | Update row status only. |
| Plan timeline change | `1_Project_Files/02_Planning/Project_Plan.md` | Track adjustment note under a "Change Log" subsection. |
| Lessons Learned narrative | `1_Project_Files/04_Closing/Lessons_Learned_Report_Blog_Draft.md` | Draft before publishing externally. |

### Weekly Execution Checklist
1. Capture raw notes (append new numbered files in `src/`).
2. Update Risk / Plan if scope or cadence shifts.
3. Summarize module → update relevant `Course_X_*.md` with Key Concepts & Reflection.
4. Journal weekly reflection (top insertion) in `Weekly_Project_Journal.md`.
5. If milestone (course complete): update root `README.md` checklist.
6. Periodically review for duplicates / formatting drift.

### Assistant Guardrails (Delta)
- Prefer new summaries in `Course_Notes/` instead of `notes/` (mark legacy if touching old files).
- Do not auto-move existing files; propose a migration plan if consolidation becomes necessary.
- When referencing earlier summaries in `notes/`, insert a short "Superseded by" link if a newer structured version exists.

### Migration Plan (Optional Future)
Phase 1 (now): Dual structure; new content only in `1_Project_Files`.
Phase 2 (later): Tag legacy `notes/` entries with front-matter or banner indicating superseded.
Phase 3: Archive `notes/` into an `archive/` folder (keep Git history) once parity achieved.

### Public Publishing Flow (Recap)
1. Finalize `Lessons_Learned_Report_Blog_Draft.md`.
2. Create post in `joembolinas.github.io/_posts/` with Jekyll front matter referencing key artifacts (no raw transcripts).
3. Commit & push public repo; keep this private repo unchanged except maybe noting the publication date in Journal.

### Quick Start Snippet (Windows PowerShell Example)
```
mkdir 1_Project_Files; cd 1_Project_Files; mkdir 01_Initiation,02_Planning,03_Execution,04_Closing; mkdir 03_Execution/Course_Notes
"# Project Charter" | Out-File 01_Initiation/Project_Charter.md -Encoding utf8
"# Project Plan" | Out-File 02_Planning/Project_Plan.md -Encoding utf8
"# Risk Register" | Out-File 02_Planning/Risk_Register.md -Encoding utf8
"# Weekly Project Journal" | Out-File 03_Execution/Weekly_Project_Journal.md -Encoding utf8
"# Lessons Learned Report" | Out-File 04_Closing/Lessons_Learned_Report_Blog_Draft.md -Encoding utf8
```

---

This bootstrap section should be updated first if structural conventions evolve.
