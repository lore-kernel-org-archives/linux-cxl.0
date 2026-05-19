Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27CD2609FD
	for <linux-cxl@vger.kernel.org>; Tue, 19 May 2026 17:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779210009; cv=pass; b=ec80Jg+pLXBXxxMfC5W4YDRnjMqK6D91CRZmtkPGx5adv0jDJuj9LXzPCstpqrEBBELE7qc7/k23hXLLscfM0AVjKRWVwXIQxn1HoC1sjvdt5DAQ5a30h0UtbI63VjtHZqh5prQwWjAIOedY4yqMRuwlT5shPnE0uOdv5LnRlZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779210009; c=relaxed/simple;
	bh=CAA/xks5Y5gsSYqPnbDpUtTl6A+TM8EjrXGeuoOa8QY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QeXBZyXei2WeL01KlpDEx1YNnMgbBbY7VDAe7OVi38Aunn+H1tBxLQiXdxSuZDDcyedUAUbxiUMtuz/VPOvGw2CVwJxWIupm/56ueOX0h++UKtDm1BtY4aJnUuM8fWhsESBOpFzPXRFgYf5mwKaYJTtZI+3uR0XVhZa0uzBHJi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oPHWBoR6; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oPHWBoR6"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-bd8f9889a8cso299055566b.1
        for <linux-cxl@vger.kernel.org>; Tue, 19 May 2026 10:00:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779210002; cv=none;
        d=google.com; s=arc-20240605;
        b=aUrFwqaWowhnNvog0oXa9AskN2D5zqwLvb7SbWhR1h7cX+Y2QcamXj81VhurZrxj9h
         eQVAR1g4487p9dVqhrChGXAAFvH6U3Vy3O8ty6YQY1PvZiakUm3rP5wFMIVc8bfVgLtd
         aQwQfN1GcbZvJuAVeLXRpnsyRFB9n9kL01ieRccGHvg7UDLsdohPw3CxnlbOv7dNLrWR
         mhozo3Qq+icvjt63O91sxm8J9AmK2DPY3Ako/TxyaEgHPNXiMmtSul2ndPRLNC3c7sgu
         psM0NLDauEqEH1JFdxVC7z5XCqiF/eUHW//F5s9Hil7Te1n526NkBWaMEQprZ9CPl65f
         4g/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pyhG4QIZqICKavDwcU8OoLlp4cF7iJkoZFMHnoscP14=;
        fh=q0fcrlneWjYUo4yJFGI/GsI6x89zQIkfoWJhwrOyrlU=;
        b=KDakSBQWD4KIhWKu/WhPiof4rCMaUyx6WO7cjX7p7WXxk8THCAL4RJJGLzJl9AUBuZ
         TtCbIAUtStWIOi/t9cqeIFtQDA4zL9qlrcoKfPdgE9ARyUrR+axH52VYoqQ4BMuQsQjX
         50exDlWq3LPWFhqhF7E0H1lqeVHYlvQ1d/vsjL7CpsrLqAdOtx9d5R4pP+gOvD0vhNtL
         YcRqSb6QnhBz+PpyDlJ+13ubsqFmrvhADwlOuHEO9YUKK54yet+MpNVl9e16s5a3/AKB
         igaP07Bdcc6i/imCf6JDFR8INQ086DRaq9xMxW5maENgXu/jKJJ/yfEtR3jCeL+1zAZ0
         o/7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779210002; x=1779814802; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pyhG4QIZqICKavDwcU8OoLlp4cF7iJkoZFMHnoscP14=;
        b=oPHWBoR66St03Xr29tlArhBtnXu2DLE2rvcvDEXaFR0ZYIltbj8pO99MutDP4Hs8y1
         qURR+BI1RBFv4ES2d8ywDPhdt+/kZt/4DvP80129EbcDzt5OcWUFAMNmG6YJITBbHA6G
         k/BhQDelw9MM6OxEgp3flPOzIWlAoK0xyq372WFKPIA8h/6J7zZn/8n9xCG6Sr0Y7FpR
         gsfTQQz/91BFnjrELwPGulvdVg9NbwCI7U92RW2PE/+Q006kGqGBuKWhJ6/+0mr/SMes
         XPxTj54nEUFGoTKzpeCLFRqUB2wrZiU/HZpp+3hvZBpsfwiOfV+Lt0U0zvmO8UkY0qNt
         zQMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779210002; x=1779814802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pyhG4QIZqICKavDwcU8OoLlp4cF7iJkoZFMHnoscP14=;
        b=fYkunxtMFGXqyxG2dgYxX26jtZzMlOHe+oSmLdYwMoeIfW5TzT4j7ZNvMbBWE3cKnu
         PZVIEMlU6O39xG1VNjtmLAF4qXmcCohWhmkvjyhSRKOAh7e41F/pnQtIczTXza8gQ9fa
         LBfmAhlxr1h97xWCvonA43wWyfJmzZtdvVb8+iT93JJsI5oBMh1Qwo5FUGz38gNd2xtW
         UFQMAYFy7ZIwRvbGP6b90uHsDc+S5uSeaSwP5hJQxM/M7R4Bisbp0wyftXevXImzspk3
         5xV/SDkD507wozPYoVTcAXFSRD1Chss4LEz8JZKBYCo3K4283tMd6gaGY2/YSLS4CfLE
         EOfQ==
X-Forwarded-Encrypted: i=1; AFNElJ9f4mLO8n3wPh2RTIXCcow4eOk6r95uMPGgrnjSvpnqO6q2anTqWN2LpL937CuLU47cRka5Kggo91Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy434wiVHNhNWRe4Vd4Cr4/XzVZCIUXLCo/ASKn55dcrNZyZ441
	3XoUylmozycqg4kiHxgHMN7F6HCADIcK7Jcwpm7vaaQxH5eB5D54vp06e+uT4yKnArCj3flcby3
	jLt38x8/7YPbbesfYQK+/eXzFsP1+UiM=
X-Gm-Gg: Acq92OGbGGrj8VD36p0Mzv1at4R9OdPwTnEoXJ2q1KOGOb6kKz/mqRpb9qwPzdX8/X+
	+1PH3CzSB+WS3mawUBlmk9CqrYo7u+Ll9mfOA7buOIdX/lqm2mViZHebB95vOX/AOg/G1V1Vri9
	vT8T+1KLWKH++NZQ9gv1NalH6barJDNNK7LB4NGejeGxv62T6JaHTVqgPsEMhSLEtDnBusEUH9S
	51bhxPUZKIiuJOGGt1wwSNQYbXIvembMzDpu3jOF12el8g6zzTwapFEoQZ8HuwrH1cMfqxqHtdP
	Xqqr4RZqli+NCFe0nX8IX8+HO+DEDupqzv2vQFQK1j0ToBsWdAw=
X-Received: by 2002:a17:906:f59b:b0:bd6:4d6d:e02c with SMTP id
 a640c23a62f3a-bd64d6de820mr859954566b.2.1779210001640; Tue, 19 May 2026
 10:00:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519151008.1399226-1-qkrwngud825@gmail.com>
 <5d00b63c-1802-450f-8e54-8da6c0aeedc2@intel.com> <CAD14+f2p7D6eco+-O0X6zWwi-XaxGLs0nQKDAC8eVWhQmB1VhA@mail.gmail.com>
 <e38e5fd0-db57-417b-a2d1-0521333ae7cb@intel.com>
In-Reply-To: <e38e5fd0-db57-417b-a2d1-0521333ae7cb@intel.com>
From: Juhyung Park <qkrwngud825@gmail.com>
Date: Wed, 20 May 2026 01:59:49 +0900
X-Gm-Features: AVHnY4K5SYQOv34TwiBv3zKFQF1M6Tyl-TeVLU2eS0aTWiFY5udiXMkdBY5RsDs
Message-ID: <CAD14+f3sohXj9SKEkRXGK_Mpbp73R5az-tsiHnHkj0poBHwpvw@mail.gmail.com>
Subject: Re: [PATCH] x86/mm: fix vmemmap leak on memory hot-remove
To: Dave Hansen <dave.hansen@intel.com>
Cc: linux-mm@kvack.org, stable@vger.kernel.org, 
	Lu Baolu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	David Hildenbrand <david@kernel.org>, "Mike Rapoport (Microsoft)" <rppt@kernel.org>, Oscar Salvador <osalvador@suse.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dan Williams <djbw@kernel.org>, Dave Jiang <dave.jiang@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org, 
	nvdimm@lists.linux.dev, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 1:41=E2=80=AFAM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> On 5/19/26 09:27, Juhyung Park wrote:
> > Hi Dave,
> >
> > On Wed, May 20, 2026 at 1:02=E2=80=AFAM Dave Hansen <dave.hansen@intel.=
com> wrote:
> >>
> >> On 5/19/26 08:10, Juhyung Park wrote:
> >>>  #endif
> >>>       } else {
> >>> -             pagetable_free(page_ptdesc(page));
> >>> +             /*
> >>> +              * Use __free_pages() to honor @order: vmemmap PMD leav=
es
> >>> +              * freed here are not compound pages, so pagetable_free=
()
> >>> +              * would lose leak 511 of 512 pages per 2 MB chunk.
> >>> +              */
> >>> +             __free_pages(page, order);
> >>>       }
> >>>  }
> >>
> >> I find myself really wondering how much of this came from a human and
> >> how much from the LLM. Could you share that with us?
> >
> > Not my first kernel contribution, just so you know. (first in mm tho)
> >
> > I asked Claude to write both the commit body and comment and it was
> > too verbose. I manually trimmed it down.
> > Sorry if it still sounds too LLM-ish.
>
> Yeah, it still sounded really LLM-ish to me. Still rather chatty.
>
> > This was tested on a VM with virtualized CXL device and toggling it
> > back and forth was visibly causing leaks. kmemleak was unable to catch
> > this (rightfully so), so I skeptically asked Claude to see if it can
> > figure it out while pwd was the kernel source the VM was running.
> > "Access the VM at "ssh -p2223 root@192.168.0.185". There's a memory
> > leak whenever CXL memory switches modes via: daxctl reconfigure-device
> > --mode=3Dsystem-ram dax0.0 --force, daxctl reconfigure-device
> > --mode=3Ddevdax dax0.0 --force. Figure out why. If you need to reboot
> > the VM, do not do it yourself and ask me."
> >
> > It did in 6 minutes and it basically told me to revert bf9e4e30f353. I
> > was very skeptical and reviewed manually (with my short knowledge of
> > mm) why this would be a correct fix.
>
> Neato.
>
> >> We're trying to get _away_ from using the 'struct page' APIs on page
> >> tables. This goes backwards. Worst case, do:
> >>
> >>         /* vmemmap PMD leaves are not compound pages */
> >>         for (i =3D 0; i < 1<<order; i++)
> >>                 pagetable_free(page_ptdesc(&page[i]));
> >>
> >> Right?
> >
> > Shouldn't I worry about the loop overhead? With order =3D=3D 9, that's =
512
> > iterations. That's compounded to O(N) when the entire memory size is
> > in consideration.
>
> Is it optimal? No.
>
> Will anybody ever notice? Also no.
>
> Will anybody ever care? No sir.

Just spun a test with that loop. It doesn't fix the leak.

I hate to be the guy that copy-pastas LLM but this is outside my
knowledge of mm. Claude suggests:
"Each pagetable_free() on the tails is a no-op: When
alloc_pages_node(node, gfp, order=3D9) returns without __GFP_COMP, the
buddy allocator only sets _refcount =3D 1 on the head page. The other
511 pages (page[1] =E2=80=A6 page[511]) have _refcount =3D 0. There's no
compound metadata, so they aren't "tails" in the folio sense either =E2=80=
=94
they're just contiguous pages whose refcounts the allocator never
touched."

Any ideas?

Thanks.

>
> Can you measure the difference? I'd wager a beer: No again.
>
> Even if someone manages to notice, then you have a clear path to fix it
> *right*: fix the ptdesc data structure to represent high-order allocation=
s.
