"""
I need to print a bunch of PDFs. Because Xerox sucks, I can't do that from
Linux if 'accounting' is enabled since the drivers don't support it. This means
putting a pdf on a thumbdrive and using the printer interface directly. This is
fine, except I have to print a bunch of things, which means individually
selecting files on an annoying, slow interface.

So, what to do?  PDF SMASH!

I want to jam all the PDFs in a directory into one big PDF, so there's only one
thing to select at the printer. But I want to documents to be separate. Since I
only ever print double-sided, I need to make sure each PDF has an even number
of pages. If the page count is odd, I add on a blank page to even it out.

Xonsh is the best!
"""

def check_blank():
    """check for blank pdf, else create one"""
    if not `blank.pdf`:
        convert xc:none -page Letter blank.pdf

def count_pages(pdf):
    """Returns number of pages in given pdf"""
    info = $(pdfinfo @(pdf)).split()
    page_index = info.index('Pages:') + 1
    return int(info[page_index])

def even_out_pages(pdf):
    """Add blank page to pdf if it has an odd number of pages"""
    check_blank()
    if count_pages(pdf) % 2 > 0:
        pdftk @(pdf) blank.pdf cat output out.pdf
        rm @(pdf)
        mv out.pdf @(pdf)

def delete_blank():
    rm blank.pdf

def pdf_smash():
    """Smash PDFs together"""
    pdftk *.pdf cat output combined.pdf

def main():
    pdfs = `.*.pdf`
    for pdf in pdfs:
        even_out_pages(pdf)
    delete_blank()
    pdf_smash()

if __name__ == '__main__':
    main()
