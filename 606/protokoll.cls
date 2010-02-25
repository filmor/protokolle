\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{protokoll}[2009/05/03 v0.2]

\LoadClass[a4paper,oneside,toc=bibliography]{scrartcl}

%\RequirePackage[a4paper,left=3cm,right=3cm,top=2cm,bottom=2cm]{geometry}
\RequirePackage{amsmath, amsthm, amssymb, amsrefs}
\RequirePackage[ngerman]{babel}
\RequirePackage[latin1]{inputenc}
\RequirePackage{makeidx, graphicx, tikz, units, calc, pgfplots, fancyhdr}
\RequirePackage{wrapfig, subfigure, caption, booktabs, floatrow}

\pgfplotstableset{ 
    every head row/.style={before row=\toprule,after row=\midrule}, 
    every last row/.style={after row=\bottomrule}
} 

\pagestyle{fancy}

% \def\@firstchar#1#2\@sentinel#3\@sentinel{#1.\ #3}

% \def\blauthor{Kian Salimkhani}

\newcommand{\versuch}[2]{\def\@nummer#2\def\@versuch#1}

\fancyhf{}
\rhead{\scriptsize P. Pütsch, B. Sauer - Versuch \@nummer: \@versuch}
\rfoot{\thepage}
\renewcommand{\headrulewidth}{0.1pt}

\fancypagestyle{plain}{
    \fancyhf{}
    \renewcommand{\headrulewidth}{0pt}
}

\setlength{\parindent}{0pt}
\setlength{\parskip}{8pt}

\usepgflibrary{plotmarks}

\author{Philip Pütsch und Benedikt Sauer}

\newcommand{\origdoc}{}
\let\origdoc=\document
\let\endorigdoc=\enddocument

\renewenvironment{document}
{\begin{origdoc}
    \begin{titlepage}
        \title{\Large{Advanced Laboratory Course}\\
               \large{Kerne und Teilchen}\\
                \vspace{0.5cm}\textnormal{Wintersemester 09/10}\\
                \vspace{2cm}\large\textnormal{Protokoll zu}\\
                \vspace{0.5cm}\Huge{\@versuch}\vspace{1cm}
        }
        \author{Philip Pütsch, Benedikt Sauer\\
                Gruppe p17\\
        }
        \date{\vspace{1cm} Universität Bonn \\ 22. Februar 2010}
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

\pgfkeys{/pgf/number format/.cd,
    fixed,
    precision=3,
    set thousands separator={}}

\makeindex

