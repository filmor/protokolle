\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{protokoll}[2009/05/03 v0.2]

\LoadClass[a4paper,oneside]{scrartcl}

%\RequirePackage[a4paper,left=3cm,right=3cm,top=2cm,bottom=2cm]{geometry}
\RequirePackage{amsmath, amsthm, amssymb, amsrefs}
\RequirePackage[ngerman]{babel}
\RequirePackage[latin1]{inputenc}
\RequirePackage{makeidx, graphicx, tikz, units, calc, pgfplots, fancyhdr}
\RequirePackage{wrapfig, subfig, caption, booktabs, floatrow}

\pgfplotstableset{ 
    every head row/.style={before row=\toprule,after row=\midrule}, 
    every last row/.style={after row=\bottomrule}
} 

\pagestyle{fancy}

\fancyhf{}
\rhead{\scriptsize K. Salimkhani, B. Sauer - Versuch \nummer: \versuch}
\rfoot{\thepage}
\renewcommand{\headrulewidth}{0.1pt}

\fancypagestyle{plain}{
    \fancyhf{}
    \renewcommand{\headrulewidth}{0pt}
}

\setlength{\parindent}{0pt}
\setlength{\parskip}{8pt}

\usepgflibrary{plotmarks}

\author{Kian Salimkhani und Benedikt Sauer}

\newcommand{\origdoc}{}
\let\origdoc=\document
\let\endorigdoc=\enddocument

\renewenvironment{document}
{\begin{origdoc}
    \begin{titlepage}
        \title{\Large{Physikalisches Praktikum V}\\
               \large{Kerne und Teilchen}\\
                \vspace{0.5cm}\textnormal{Sommersemester 09}\\
                \vspace{2cm}\large\textnormal{Protokoll ad}\\
                \vspace{0.5cm}\Huge{\versuch}\vspace{1cm}
        }
        \author{Kian Salimkhani, Benedikt Sauer\\
                Gruppe $\alpha 4$\\
                 \\\large\textnormal{Assistent: \assistent}
        }
        \date{\vspace{1cm} Universität Bonn \\ \today}
    \end{titlepage}
    \maketitle
    \newpage
    \tableofcontents
    \newpage
}
{
    \end{origdoc}
}

\newcommand{\Literatur}[1]
{
    \section{Literatur}
        \begin{biblist}
            \bibselect*{#1}
        \end{biblist}
}

\DeclareMathSymbol{,}{\mathpunct}{letters}{"3B}
\DeclareMathSymbol{.}{\mathord}{letters}{"3B}
\DeclareMathSymbol{\decimal}{\mathord}{letters}{"3A}

\makeindex

