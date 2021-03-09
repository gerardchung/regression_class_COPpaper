# COP
## Word clouds

rm(list = ls())
library(quanteda)
library(stringr)
library(dplyr)
library(here)
library(ggplot2)


section <- c("abstract", "introduction", "depression", "dep_parenting", "pse")
text <- c("Head Start/Early Head Start (HS/EHS) programs deliver comprehensive early childhood services in the U.S. to support low-income families to improve a range of early childhood outcomes and to develop positive parenting and parent-child relationships. From the beginning of the program, increasing fathers’ involvement with their children in HS/EHS has been an important emphasis. However, depressive symptoms among low-income fathers can negatively impact their relationships with their children. Protective factors such as parental self-efficacy (PSE) can potentially buffer the effects of depression. In this study, we aimed to understand the associations between low-income HS/EHS fathers’ depressive symptoms and relationship closeness and conflict with their young children aged 5 and below. We also examined if the PSE of fathers can buffer the negative associations between depression and father-child relationship. We analyzed cross-sectional data collected from fathers (n = 102) who participated in a parenting support program while receiving HS/EHS services in the United States. Participants were primarily African American (83%), of mean age 32 years, and lived with their children (74%). Using multiple linear regression, we found that fathers’ depression was significantly associated with father-child closeness (B = -.37, p < .001) and conflict (B = .28, p <. 05). More importantly, PSE functioned as a protective factor by reducing the negative associations between depression and fathers’ relationship closeness and conflict with their children. Implications include providing mental health assessments and support to low-income fathers. HS/EHS services or early childhood services that aim to promote positive parenting practices and develop healthy parent-child relationships among low-income fathers should give attention to strengthening PSE in fathers.",
          "Since 1995, the Head Start/Early Head Start (HS/EHS) program in the United States has been a key federal-funded program in providing comprehensive early childhood services to support low-income families to improve a range of early childhood outcomes that include school readiness, cognitive, language, physical health, and socio-emotional development among young children from infants to age five (Kisker et al., 2002; U.S. Department of Health and Human Services, 2010). From the beginning of the program, engaging fathers and increasing fathers’ involvement in HS/EHS has been an important emphasis particularly with increasing recognition of the positive contributions of fathers to parenting and child outcomes (Vogel et al., 2003). Specifically, an integral part of the HS/EHS program has been the promotion of positive parenting practices, the development of healthy parent-child relationships, and supporting fathers  involvement and engagement with their children. 
However, given the high prevalence of depression among HS/EHS fathers (EHR Research and Evaluation Project, 2006), an area of concern for HS/EHS service providers and practitioners is how fathers’ depressive symptoms may adversely affect the quality of their relationships with their children and the possible interventions and engagement strategies that can help to support fathers’ depression and promote positive parenting outcomes (National Center on Parent, Family, and Community Engagement, 2013). Recent studies have found that parental self-efficacy can be a protective factor in directly affecting fathers’ parenting as well as moderating the effects of depression (Trahan & Shafer, 2019). Using cross-sectional data with a sample of fathers receiving HS/EHS services, this exploratory study aims to understand how fathers’ depressive symptoms and PSE are associated with relationship quality with their children and if PSE can have a protective influence for fathers with depression. Though the study is exploratory, it can provide initial knowledge for future studies that can help in the development of HS/EHS services to effectively support fathers’ mental health and to create a father-friendly family service approach (Administration for Children and Families, 2018).
",
              "Depression is a complex, multiply-determined disorder with genetic and environmental determinants that interact across the life course (Dunn et al., 2015; Repetti et al., 2002). Depression is also one of the common mental health problems in the United States and has been identified as a significant public health issue (McLaughlin, 2011). Further, among adults, depression disproportionately affects parents compared with nonparents with 7.5 million parents experiencing depression in the USA each year (National Research Council and Institute of Medicine, 2009) and about 10% of mothers experiencing depression in the past year as found by a national representative survey of the USA population in 2001-2002 (Ertel et al., 2011). Existing studies indicate that depression among parents may compromise their parenting and adversely affect the development of relationships with their children (e.g., see review by Dix & Meunier, 2009). As parent-child relationships are the cornerstone of child development, understanding the effects of depression on parents’ relationships with their children is critical. This is particularly of concern among HS/EHS parents due to the high prevalence of depression identified among these parents. For instance, one multi-site study found nearly 48% of 1,275 mothers in EHS were at risk of depression (Administration for Children and Families, 2002). However, much of our current understanding is limited to mothers and maternal depression (Cabrera et al., 2018; Wilson & Durbin, 2010). Less is known about depression among fathers of children in HS/EHS and the impact depressive symptoms have on father-child relationships. Depression Among Fathers of Young Children Depressive symptoms may emerge among fathers of young children due to stressors and emotional demands related to nurturing, disciplining, and guiding a child at this young developmental stage (Evenson & Simon, 2010). Several nationally representative studies in the United States indicate that the prevalence of depression is high among fathers of young children, particularly among low-income fathers. Findings from the Early Childhood Longitudinal Study, using the Center for Epidemiological Studies Scale for Depression (CES-D), indicate that approximately 26% of resident biological fathers with young children were mildly or moderately depressed and about 4% were severely depressed (Paulson et al., 2009). In the Fragile Families and Child Wellbeing Study, the prevalence of major depressive episode in the past year among low-income African American fathers was 12% for those with children at both 1 and 3 years of age, and 9% for those with children 5 years of age (Sinkewicz & Lee, 2011). 
Several studies have also found a significant prevalence of depression among fathers in HS/EHS programs. One study found that 40% of low-income fathers with infants mostly enrolled in EHS programs were at risk for depression and 23% of fathers had moderate to severe depression when their child was either at 1 month or 14 months (Vogel et al., 2003). Another study using a sample of 80 low-income EHS fathers with 2-year-old children found that the average reported CES-D scores for the fathers were above the clinical cut-off for mild depression (Malin et al., 2012). These studies strongly suggest that depression is experienced by a significant number of low-income fathers with young children in EHS/HS programs. Increased Risk for Depression Among Low-income Fathers of Young Children For low-income fathers in EHS/HS, financial demands may create economic pressures that lead to higher emotional distress and increased risk for depression. A study on a community sample of parents with young children in Chicago found that financial strain experienced by low-income parents was associated with higher depressive symptoms (Kingston, 2013). Another study found that high employment needs among low-income fathers from multiple “Responsible Fathering” programs were associated with more depressive symptoms (Fitzgerald et al., 2012). 
	With the high risk of depression among low-income fathers with young children, one concern is how fathers’ depression may affect their parenting functions and relationships with their children since parents’ psychological functioning has been found to be a key determinant of parenting outcomes (Belsky, 1984; Finzi-Dottan et al., 2016; Taraban & Shaw, 2018). Existing research, mostly with samples of mothers, strongly shows that mothers’ depression is linked with deficits in parenting skills and parent-child relationships (Badovinac et al., 2018; Beck, 1999; Dix & Meunier, 2009). There is a need to understand how depression can affect fathers and their parenting. 
",
          "Effects of Depression on Fathering Depression impacts parenting and parent-child relationships through disruptions in parents’ cognitions, behaviors, and affect (Goodman & Gotlib, 1999; Psychogiou & Parry, 2014). A systematic review of 152 studies found that depression can undermine parent functioning by reducing parents’ attention to child input, accentuating negative appraisals of parenting competence, and triggering emotions that are high-negative or low-positive (Dix & Meunier, 2009). Another study found that compared to nondepressed mothers, depressed mothers displayed more negative and less positive interactions with their children (Hops, 1995). 
Recent empirical studies and meta-analyses indicate that depression in fathers has comparable effects on fathers’ parenting and relationships with their children (Finzi-Dottan et al., 2016; Kane & Garber, 2004; Kopala-Sibley et al., 2017; Lee et al., 2012; Shafer et al., 2019; Sweeney & MacBeth, 2016; Wilson & Durbin, 2010). Wilson and Durbin (2010) concluded from a meta-analysis of 28 studies that there is a significant but small mean effect size for the relationship between paternal depression and decreased positive parenting behaviors (e.g., affectionate & sensitive parenting) and increased negative parenting behaviors (e.g., hostile & coercive parenting). A systematic review of 21 studies found that paternal depression was linked to increased risk of externalizing and internalizing behaviors in children from the age of 2 months to 21 years (Sweeney & MacBeth, 2016). Notably, these associations were stronger among younger children than older children indicating that the developmental period during early childhood is particularly vulnerable to the effects of depression among fathers. 
Studies with low-income fathers found that paternal depression can lead to child neglect (Lee et al., 2012), higher incidents of spanking (Davis et al., 2011), and more parent-child conflicts (Finzi-Dottan et al., 2016; Kane & Garber, 2004). Few studies, however, have specifically sought to understand the effects of depression on the parental functioning of fathers in HS/EHS. A study by Vogel and colleagues (2003) found that depressed EHS fathers of infants spent less time with their children, were less engaged in play and caregiving activities, and showed poorer quality of engagement (e.g., less affect & flexible). This study will fill in the gap in our understanding of HS/EHS fathers by looking at the associations between fathers’ depression and relationship quality with their children.
", "Parenting Self-Efficacy
	In fatherhood research, the risk and protective framework has been used to understand the determinants of fathers’ involvement with their children (Fagan & Lee, 2012). The framework considers the balance of risk and protective (internal and external resources for the protection against risk) factors that interact to determine an individual’s ability to function adaptively despite stressful life events (Jenson & Fraser, 2011). Risk factors are conditions that may hinder fathers from having effective engagement and involvement with their children (Fagan & Palkovitz, 2007). Identifying the protective factors that may protect these fathers from the effects of risks is therefore important in developing effective fathering interventions. Parental self-efficacy (PSE) is a parenting-related cognition (Taraban & Shaw, 2018) and has been defined as the “degree to which the parent feels competent and confident in handling child problems” (Fagan et al., 2016, p. 666). We focused on PSE as a protective factor for several reasons. First, there is consistent evidence to support the effects of PSE on parenting outcomes including parenting behaviors, parental stress, and parent-child relationships (Albanese et al., 2019; Jones & Prinz, 2005). Second, PSE is understudied among low-income fathers in the HS/EHS though existing studies with general populations support its role in influencing fathers’ involvement (Finzi-Dottan et al., 2016; Trahan, 2018), fathers’ warmth (Trahan & Shafer, 2019), and father-child relationship (Dyer et al., 2017). Third, there is evidence that PSE can mitigate the effects of risks on parenting outcomes (Jones & Prinz, 2005; Trahan & Shafer, 2019). 
Based on the risk and protective perspective, high levels of PSE are hypothesized to buffer fathers from the negative effects of risks and also increase their engagement and promote positive development of parent-child relationships (Fagan & Lee, 2012; Grote et al., 2007). One study with a general population of fathers found that PSE moderated the relationship between depression and paternal warmth, indicating PSE as a potential protective factor for fathers who are depressed (Trahan & Shafer, 2019). However, the extant literature lacks studies that seek to understand whether PSE can function as a protective factor for low-income fathers in HS/EHS programs. 
")

section_name <- "section"
text_name <- "text"

library(reshape2)
paper_df <- melt(data.frame(text, section))
colnames(paper_df) <- c(text_name, section_name)

paper_corpus <- corpus(paper_df, 
                          text_field = "text")
summary(paper_corpus)
paper_dfm <- dfm(paper_corpus, 
                    remove = stopwords("english"), 
                    remove_punct = TRUE)

pdf(file = "abstract.pdf")
jpeg(file = "abstract.jpg",
     height = 30, width = 20, units= "cm",
     res=300)  

# tiff("abstract.tiff", height = 30, width = 20, units= "cm" ,
#      compression = "lzw", res = 300)
     
set.seed(12)

abstract <- textplot_wordcloud(paper_dfm[1,], # abstract
                   max_words = 12, 
                   color = rev(RColorBrewer::brewer.pal(10, "RdYlBu"))) 

dev.off()
#ggsave(here("figures", "abstract.pdf"), plot = abstract, scale = 1.5)
#ggsave(here("figures", "abstract.jpeg"), plot = abstract, scale = 1.5)

################
pdf(file = "intro.pdf")
set.seed(12)

textplot_wordcloud(paper_dfm[2,], # intro
                   max_words = 12,
                   color = rev(RColorBrewer::brewer.pal(10, "RdYlBu"))) 
dev.off()

###################

pdf(file = "depression.pdf")

set.seed(12)
textplot_wordcloud(paper_dfm[3,], # depressio
                   max_words = 12,
                   color = rev(RColorBrewer::brewer.pal(10, "RdYlBu"))) 
dev.off()

###################
pdf(file = "depression_parenting.pdf")
set.seed(12)
textplot_wordcloud(paper_dfm[4,], # dep parenting
                   max_words = 12,
                   color = rev(RColorBrewer::brewer.pal(10, "RdYlBu"))) 
dev.off()

###################
pdf(file = "pse.pdf")

set.seed(12)
textplot_wordcloud(paper_dfm[5,], # PSE
                   max_words = 12,
                   color = rev(RColorBrewer::brewer.pal(10, "RdYlBu"))) 
dev.off()
