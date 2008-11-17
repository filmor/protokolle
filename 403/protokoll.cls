\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{protokoll}[2008/10/23 v0.0]

\LoadClass[a4paper]{scrartcl}

\RequirePackage{amsmath, amsthm, amssymb}
\RequirePackage[ngerman]{babel}
\RequirePackage[latin1]{inputenc}
\RequirePackage{makeidx, graphicx, tikz, units, calc, pgfplots}

\usepgflibrary{plotmarks}

\author{Kian Salimkhani und Benedikt Sauer}

\newcommand{\origdoc}{}
\let\origdoc=\document
\let\endorigdoc=\enddocument

\renewenvironment{document}
{\begin{origdoc}
    \begin{titlepage}
        \title{\Large{Physikalisches Praktikum IV} \\ \large{Atome, Moleküle, Festkörper} \\ \vspace{0.5cm}  \textnormal{Wintersemester 08/09} \\ \vspace{2cm} \large\textnormal{Protokoll ad}  \\ \vspace{0.5cm}\Huge{\versuch} \vspace{1cm}}
        \author{Kian Salimkhani, Benedikt Sauer \\ Gruppe $\alpha 4$ \\ \\ \large\textnormal{Assistent: \assistent}}
        \date{\vspace{1cm} Universität Bonn \\ \today}
    \end{titlepage}
    \maketitle
    \newpage
    \tableofcontents
    \newpage
}
{\end{origdoc}}

\DeclareMathSymbol{,}{\mathpunct}{letters}{"3B}
\DeclareMathSymbol{.}{\mathord}{letters}{"3B}
\DeclareMathSymbol{\decimal}{\mathord}{letters}{"3A}

\makeindex

