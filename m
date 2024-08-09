Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACCB145FE5
	for <linux-cxl@vger.kernel.org>; Fri,  9 Aug 2024 18:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723227034; cv=none; b=Ffh7bhSaJ7Xa7uaP6jNe/ZQ0bActfTxtZJwkbRtuNC6ziVbTxR3GBMFnXp7NQDHw0iZH24Npmo2h415v2mg+dPtKTElHhLdQU6PhKmxRgDj15+JUKCPzVBCNXodZH4VvwII6F2XqojD6z2U6DmWDSJSh5JxJyo3dN6KJ06dtuVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723227034; c=relaxed/simple;
	bh=hjEkJy4i+WTJzKeWHwYqkdt+dY5dFF47qWBmD1BRAdE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HLH2Q7vFjr/cITnEYvOc2Y7nUsZ3nemYf2a1Ygt3xSf+2zWqX8ZMtX/xMyC11g1f6F+IurSrx9aCEFfd+dEglF24X6FwGL/KrEEni6rbmVyaMHXl2Tcg9s5EBnCvSMx4AkGIPHp/7mbHLSOJkk2XvfBY7J7Q0Csx7VB6noe3GIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=oDIKrFDf; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="oDIKrFDf"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-44fff73f223so13140171cf.2
        for <linux-cxl@vger.kernel.org>; Fri, 09 Aug 2024 11:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1723227030; x=1723831830; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AHqMJlIkWWEgQwJvsxhrebiNG2gW3dBZk5UEyqRtZXk=;
        b=oDIKrFDfCif18AMcZohRHmD/3S9BjRolPEE46VijU6ypl7O01DBLnxlhbPzh3vulRq
         ClVLzK0cGcrqdSf3bZuq12MsryX67e4zXHCiBNQYE08y2hHD9B19o8f+nhBLquEJNqQp
         Rw3T47rury6mFn2lVpvElY7PfdQapKnwm2/MNwfHgrANai6by9uCd9RqxD13WRwl/GDF
         aR2QCVnkFvKuNjpwFHOGk2FieFw/SifwUgSih1ZN7G8ZNwlfBiwtCPxs+buZE+KOWurI
         wxwnETOVgWD0si4zIDJm8tmfpXh/VqQadc0ANtn4CywgsGvs6m0VP/pK0fJa+SAyuOgQ
         d/1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723227030; x=1723831830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AHqMJlIkWWEgQwJvsxhrebiNG2gW3dBZk5UEyqRtZXk=;
        b=vn4iGVXmtfpi1FMhYZP4iGGPxx0TwTCczrfxNOzYsbdVyqVxth86eAJBY5CewuZOJ9
         GsghnESm/I4g7WhOZnvvCWwXRjOCWRQEmz3XlrwvY180t7OjkX8VyZRe+MSAJb1JYBIu
         Tvj/IW8O9hqoIqryjfGpf2B7E7Eg7i1GygYbdfDTuM8jFZVIJlAmOE8TwdbVKARsZ/qh
         JpCQ8Sk2pmd0p7ke5KcbNzYLOyXbKHdMqIUs/VEO1RU4LKkex9IAujKMGjEKTHI0i55L
         9mz/q+sALeW21L0FTWjY35aAeZ8pl0CWtl59qSkqaTI5gIewlXycmAR4t/P6lsu7ilZ2
         aTLg==
X-Forwarded-Encrypted: i=1; AJvYcCXS4hMODtLDJoeNTn5lt9NK/RX6/dxqQC0itu+1RyZ2R4NrLyQh9gjnxuEcTK4OQL3Ju9ZfIiu6dZGu6y2zZp4NU6CBMv6hJ6o9
X-Gm-Message-State: AOJu0YxT60Nc/xXZi0yIz2BiZec22T6tSoasXnK0QsivPcDvb+PPgUp3
	aWIU6ZmD7fqRzJb0fdcPGo53q8y+dmKroPoTxs/aslI3w5EvdhC+8lsew3NbUJJQruV+s5ZiFPe
	MF9JET3BY/PZ2dkWN5eNgV7wlgyIL00nYnQlmOw==
X-Google-Smtp-Source: AGHT+IHrNlz+ta25fI4t3VA0/EEbsr27aU89/bZMIE48EJr0+K917c8yN5Fy0ywTD7GNlhd6voyk2Z4+WfWnBsJ9Ua0=
X-Received: by 2002:a05:622a:4113:b0:451:d70a:80b4 with SMTP id
 d75a77b69052e-4531251ba01mr31251511cf.4.1723227030003; Fri, 09 Aug 2024
 11:10:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808213437.682006-1-pasha.tatashin@soleen.com>
 <20240808213437.682006-4-pasha.tatashin@soleen.com> <b13cf452-4573-4202-8178-26a33e9f2185@redhat.com>
In-Reply-To: <b13cf452-4573-4202-8178-26a33e9f2185@redhat.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 9 Aug 2024 14:09:53 -0400
Message-ID: <CA+CK2bCpay7V=4_AGiTEyX2OG_6rvqR42MkVSJwEhGa7h+5R4g@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] mm: don't account memmap per-node
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

On Fri, Aug 9, 2024 at 3:31=E2=80=AFAM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 08.08.24 23:34, Pasha Tatashin wrote:
> > Fix invalid access to pgdat during hot-remove operation:
> > ndctl users reported a GPF when trying to destroy a namespace:
> > $ ndctl destroy-namespace all -r all -f
> >   Segmentation fault
> >   dmesg:
> >   Oops: general protection fault, probably for
> >   non-canonical address 0xdffffc0000005650: 0000 [#1] PREEMPT SMP KASAN
> >   PTI
> >   KASAN: probably user-memory-access in range
> >   [0x000000000002b280-0x000000000002b287]
> >   CPU: 26 UID: 0 PID: 1868 Comm: ndctl Not tainted 6.11.0-rc1 #1
> >   Hardware name: Dell Inc. PowerEdge R640/08HT8T, BIOS
> >   2.20.1 09/13/2023
> >   RIP: 0010:mod_node_page_state+0x2a/0x110
> >
> > cxl-test users report a GPF when trying to unload the test module:
> > $ modrpobe -r cxl-test
> >   dmesg
> >   BUG: unable to handle page fault for address: 0000000000004200
> >   #PF: supervisor read access in kernel mode
> >   #PF: error_code(0x0000) - not-present page
> >   PGD 0 P4D 0
> >   Oops: Oops: 0000 [#1] PREEMPT SMP PTI
> >   CPU: 0 UID: 0 PID: 1076 Comm: modprobe Tainted: G O N 6.11.0-rc1 #197
> >   Tainted: [O]=3DOOT_MODULE, [N]=3DTEST
> >   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/=
15
> >   RIP: 0010:mod_node_page_state+0x6/0x90
> >
> > Currently, when memory is hot-plugged or hot-removed the accounting is
> > done based on the assumption that memmap is allocated from the same nod=
e
> > as the hot-plugged/hot-removed memory, which is not always the case.
> >
> > In addition, there are challenges with keeping the node id of the memor=
y
> > that is being remove to the time when memmap accounting is actually
> > performed: since this is done after remove_pfn_range_from_zone(), and
> > also after remove_memory_block_devices(). Meaning that we cannot use
> > pgdat nor walking though memblocks to get the nid.
> >
> > Given all of that, account the memmap overhead system wide instead.
> >
> > For this we are going to be using global atomic counters, but given tha=
t
> > memmap size is rarely modified, and normally is only modified either
> > during early boot when there is only one CPU, or under a hotplug global
> > mutex lock, therefore there is no need for per-cpu optimizations.
> >
> > Also, while we are here rename nr_memmap to nr_memmap_pages, and
> > nr_memmap_boot to nr_memmap_boot_pages to be self explanatory that the
> > units are in page count.
> >
> > Reported-by: Yi Zhang <yi.zhang@redhat.com>
> > Closes: https://lore.kernel.org/linux-cxl/CAHj4cs9Ax1=3DCoJkgBGP_+sNu6-=
6=3D6v=3D_L-ZBZY0bVLD3wUWZQg@mail.gmail.com
> > Reported-by: Alison Schofield <alison.schofield@intel.com>
> > Closes: https://lore.kernel.org/linux-mm/Zq0tPd2h6alFz8XF@aschofie-mobl=
2/#t
> >
> > Fixes: 15995a352474 ("mm: report per-page metadata information")
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > Tested-by: Dan Williams <dan.j.williams@intel.com>
> > ---
>
> [...]
>
> In general
>
> Acked-by: David Hildenbrand <david@redhat.com>
>
> Two nits below:
>
>
> >   static void free_map_bootmem(struct page *memmap)
> > diff --git a/mm/vmstat.c b/mm/vmstat.c
> > index 6f8aa4766f16..ad82c1bf0e63 100644
> > --- a/mm/vmstat.c
> > +++ b/mm/vmstat.c
> > @@ -1033,6 +1033,23 @@ unsigned long node_page_state(struct pglist_data=
 *pgdat,
> >   }
> >   #endif
> >
> > +/*
> > + * Count number of pages "struct page" and "struct page_ext" consume.
> > + * nr_memmap_boot: # of pages allocated by boot allocator & not part o=
f MemTotal
> > + * nr_memmap: # of pages that were allocated by buddy allocator
> > + */
> > +static atomic_long_t nr_memmap_boot, nr_memmap;
>
> I *think* the clean and portable way to do it is use ATOMIC_INIT(0) for
> both. [even though what you have likely works on all archs]

Yeah, it is not necessary, but I will add ATOMIC_LONG_INIT(0),

>
> > +
> > +void mod_memmap_boot(long delta)
> > +{
> > +     atomic_long_add(delta, &nr_memmap_boot);
> > +}
> > +
> > +void mod_memmap(long delta)
> > +{
> > +     atomic_long_add(delta, &nr_memmap);
> > +}
> > +
>
> Nit picking: (up to you)
>
> I'd do it similar to totalram_pages_add():
>
> memmap_pages_add()
> memmap_boot_pages_add()
>
> And call the variables something like
>
> static atomic_long_t memmap_pages_boot, memmap_pages;

Sure, I will rename them.

Pasha
