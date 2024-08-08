Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20AD13F435
	for <linux-cxl@vger.kernel.org>; Thu,  8 Aug 2024 18:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723143317; cv=none; b=GFb/LRc6SPXTaUucjJHwd7OsSVucX23M6XUmxjxabFia2hioc7SVTHUok0zfiQ9I5pLJt3Rqqce24FdgZjoto6rrxBNMLseQZ36ryqraIgcb3ZLLw5l9drG3Si5AgXRaCGBrOr/uBdE0f6LvbzLgBsPKzIMuRVeLBntTMfVw4gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723143317; c=relaxed/simple;
	bh=lfFCBH9xl2pbQz5/RgTr95SckKR16ouqjSGMkA/j2uw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LP34IiVzu3pTaaJ6VOUPk4JBftYA7EmtlhF5oEceM7Zbm9VXNrxTmoU8t8jKQXSXYKk5Nbf0o5wJun/4wiZEN0WqK6xv1fwQeTonPV5UVARouW8qpYu2/Mw8VS148sIHK9j6jbOvgI1Sl3xpnT7nwaECYU+Inyw30rbdss8JRnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=lzBJnmo5; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="lzBJnmo5"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-44fe9cf83c7so7111861cf.0
        for <linux-cxl@vger.kernel.org>; Thu, 08 Aug 2024 11:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1723143314; x=1723748114; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DO/Z3SbablodSUL+R3JeSvJ8+7bDWABWfQskJp837f0=;
        b=lzBJnmo58WX+zWJhg0ZW48pMzEE1o2F5s36NqfXgMtyCvtriXcDcnw13xw0/QDnP0M
         thehAZnwpnkiMCjUr3sDXOTi9jrELI5l8xuEGfZoJYn/i3rsUe87GpT1gYanruKtToKb
         /r/kF1LG9ull8LuJhTsT3Mii0QswVdQH6l7jy0m7wuQw51vUuo4j4NiZdg+BHO7pqGK4
         7jlSsy/tdPWPnPec7KJuHQFD/Ph6hHL8ZeRsO+MDHEP/oM8I5k1vZEboXF6U+BeY0UYi
         AQByG+YdAqLfjrc18v1GHR6jWSEF673zMfJCSUk3Sk6k8CLKgojPKghUVFnxn0HinK54
         FvbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723143314; x=1723748114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DO/Z3SbablodSUL+R3JeSvJ8+7bDWABWfQskJp837f0=;
        b=kWRz5hkp8xSLkT0m/ZZaPvCZsN2HY2NOezuo1c+Dx4bxG/mR4E/7hfvO8JpJ4KGpNm
         crvUrkkNNzyoOd5NtJ4w5HhQKT/8+0Rd/DaBnQUWno0paVnIQULdAZWangqmqP2hIovP
         5+k34e+/LkENI6NCKi2XCs/J33vpeB0Uk2pBZmUFklEheEqLIqvbe+HSYesembkwrjpp
         ylydmiiAoVl6s9/Ta1YfXfCPR/Of63rmjPUzQOj5YL5GagL0EU5VzCRV20csJDxYsRlr
         ZZpfnVPo21VdDXD69MHa+vI51Sjd9cYi16ogjE601bRjvmWqjHLwRrYq6PLSdIyp4eP/
         Fznw==
X-Forwarded-Encrypted: i=1; AJvYcCU+LXseFq7pH/S+jcYCvMlGdVXtDDy04AwUKpG6zHvpm9GDXQqHv5CSqobnBRxVyDmUcU5rlv5XchKC3rGKmnoN7Bo1lO5Uug0T
X-Gm-Message-State: AOJu0Yy6WmfoUNqdVlZds+PMkq7ZO+yC5e/KHbCEwb0RAEOcgKYRl9aQ
	Q2l+M5fBic5HZs3b8fnG3A3NKR447eRzMT+jNTCRc0UtaHNipevddiPt8YE1g+fT4TekDn3dDMd
	BAZzF6od2pacPDqbTJKP0p3kwOarIWJSVOyKPvw==
X-Google-Smtp-Source: AGHT+IGCSGjuz41NNdGhYP00jq6qPDxX9zDID06r1oWKzkL+fM3fiKkjBrJ2CXqN+zVBtulvpbY7hra6xTPzoF1wD6c=
X-Received: by 2002:a05:622a:4ac9:b0:44f:dd52:8aee with SMTP id
 d75a77b69052e-451d430ab3fmr39557171cf.46.1723143313673; Thu, 08 Aug 2024
 11:55:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808154237.220029-1-pasha.tatashin@soleen.com>
 <20240808154237.220029-3-pasha.tatashin@soleen.com> <24003526-ba18-42fb-b5c0-7b89872eb61e@redhat.com>
In-Reply-To: <24003526-ba18-42fb-b5c0-7b89872eb61e@redhat.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 8 Aug 2024 14:54:35 -0400
Message-ID: <CA+CK2bDvmSq1Wg92TVi6A5jVwxn5Xeo5aTf3sfUafCkiWPPZUw@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] mm: don't account memmap on failure
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-cxl@vger.kernel.org, cerasuolodomenico@gmail.com, 
	hannes@cmpxchg.org, j.granados@samsung.com, lizhijian@fujitsu.com, 
	muchun.song@linux.dev, nphamcs@gmail.com, rientjes@google.com, 
	rppt@kernel.org, souravpanda@google.com, vbabka@suse.cz, willy@infradead.org, 
	dan.j.williams@intel.com, yi.zhang@redhat.com, alison.schofield@intel.com, 
	yosryahmed@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 2:12=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 08.08.24 17:42, Pasha Tatashin wrote:
> > When in alloc_vmemmap_page_list() memmap is failed to allocate, do
> > not account, the memory is going to be release at the function exit.
>
> I would write it as
>
> "When we fail to allocate the mmemmap in alloc_vmemmap_page_list(), do
> not account any already-allocated pages: we're going to free all them
> before we return from the function."
>

Will change.

> Acked-by: David Hildenbrand <david@redhat.com>

Thank you,
Pasha

>
> >
> > Fixes: 15995a352474 ("mm: report per-page metadata information")
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> >   mm/hugetlb_vmemmap.c | 5 +----
> >   1 file changed, 1 insertion(+), 4 deletions(-)
> >
> > diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> > index fa83a7b38199..70027869d844 100644
> > --- a/mm/hugetlb_vmemmap.c
> > +++ b/mm/hugetlb_vmemmap.c
> > @@ -392,13 +392,10 @@ static int alloc_vmemmap_page_list(unsigned long =
start, unsigned long end,
> >
> >       for (i =3D 0; i < nr_pages; i++) {
> >               page =3D alloc_pages_node(nid, gfp_mask, 0);
> > -             if (!page) {
> > -                     mod_node_page_state(NODE_DATA(nid), NR_MEMMAP, i)=
;
> > +             if (!page)
> >                       goto out;
> > -             }
> >               list_add(&page->lru, list);
> >       }
> > -
> >       mod_node_page_state(NODE_DATA(nid), NR_MEMMAP, nr_pages);
> >
> >       return 0;
>
> --
> Cheers,
>
> David / dhildenb
>
