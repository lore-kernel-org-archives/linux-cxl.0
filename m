Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5673D6CD9
	for <linux-cxl@vger.kernel.org>; Wed, 20 May 2026 10:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779273223; cv=pass; b=he26YXwYsi5gU9bdrJcb/wNxF1xtYc05x2uDy/rT+xt0RX6Dio1XS8HbxyBi9XtXsWIosRc0PjTJv5NSIjBM2VAPNb4UDnCWm3cJAVpgbZ0+DxFxolzakrmLIXJ/bx2TL4BvTSy32cVPj7K97mQOKni3Mehd6dTrz9EjDcZx8W0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779273223; c=relaxed/simple;
	bh=I3nCSO8EnQlbzVzYsHNKe6zQ9gVE/7aRqrfkKO0oNLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JBQB60zIonWWIkppR5abfCp0K2V1RaBq1cmY0ekq13B/oj2qFVzwlWGFkKYH8jeJZwFU2p3J7yrMbi3TbJx11wiVokknTbKJ3IBH5dkUrMDAeSOYzPVW0A5oFKVui8Ff83qgPEc9GW4g9RARNfdBWpvpIrwwH28UfaGJ9RlWzAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s81m1jYs; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s81m1jYs"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-bce57c132b2so1077625766b.0
        for <linux-cxl@vger.kernel.org>; Wed, 20 May 2026 03:33:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779273217; cv=none;
        d=google.com; s=arc-20240605;
        b=OS1rEUj9T7z546FJ7wm07ipzy1qdt/HVKGzRwW56rQjRuEPgkpScYVZzteH5HR60Le
         yB/+KAO6GeC+il+dj9z2j3XR36mviSI3BZ0Tzsg5AuMdzVV3/vBJwph90sIo8LP5xEn6
         ZUEwt+CeydP7Pp63a0xyOKxd2tKq4MdSq/0S/tw/GrRlFhhMa6dwlmhwVhTD6R0aqVw2
         agsgy0M/dDRnGRNJjzmcduRBGGXjsmPJdt+5vUKk8eCp8dPcIJh8JgjBLddu2+gUB9L8
         t/cI9sqajjVWBkj2VaRPcbdfgQmE7pwqoIXgJsB8SFqlvA1TULAoNkwykKbbwLe3n2Qk
         Us9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CuNkcUrfA5La6Ov2pSAQWUelqrEhmV3emRmHUdz7AgI=;
        fh=ieLbio+VduFhFXCM+fONPNSKZxNtWUB3pkiWkMs4ueU=;
        b=DvAtbgnQgJ2mlrwospyWJKn/dvesJhenZqgPJFImVA9ccju1WFuBm19LdtQ7na9rTh
         4YLg2/PEhs6qlCtpD+rEMK+rrSJodF0QzdYJ4P0T6YOjtiPN+M+eAre3SvJ18PLbmi5u
         Jpchi5q2ONjqh8nN2949x7pXw8nfRBNMDyvh9nxs6ZnmwUUJ5sUSWzsZHXlf98PIoPbO
         4SpWRs4E+mmj8d9bDf5GT2+1P8hbW1f9YPXpcfxp0h3UHtinoGchM9uudAV0J0M6RrWF
         FmJuvHfGjdo6bRnnBwwEyo1aztvh2emaHAQ44gDohriEJAfyLE869qZVGb7NKQDYT7ok
         g0vA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779273217; x=1779878017; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CuNkcUrfA5La6Ov2pSAQWUelqrEhmV3emRmHUdz7AgI=;
        b=s81m1jYsA5EyNwOGcooePs7jzXuKz7Mfl4nK6berxNdmoFTLHb6tlPU+i6ds4juqkV
         rjHMMYsdufThTgfjAmiouitPBJLACnRTBATPRxyHIlfx91PJ/zd/BELKAQdN06V9L0eo
         KQn0b55DvY2kYLGsXvd5vC9+9VSL5sd3txPLc3h8F26HQrgNsbmc9GdeIceheYkA33P1
         Sn6swOvWZ+EDVKzF6xEwd5/iFavvx2sdVjeLeWISLBSYRDaHwh3S3mFAQjBf7yJI9np8
         9tqBZ1kZDj3E+CeS6gbrZojZlhwEoRWizEhoyJ6llq3Ta30Nkk72EzhBdKFiForwD7jL
         6GnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779273217; x=1779878017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CuNkcUrfA5La6Ov2pSAQWUelqrEhmV3emRmHUdz7AgI=;
        b=llz1655FgVfSIW3Q5FXdgSdeH4+nwFMJ8fuJTOx9YRZa1TakJ8TCIxM43xK5dOjZvg
         dWQC2giBUEglw7FN7XVm7//X/jqRnZC22HRT/kfoQKxsFBz8xuKg6S4SI9Q8dPTK4ani
         s1z5M6QcIeUm5ArtACdkd3+i4SWYGBttiYAK7CwzSRrJs0MlkqXmPHUG+XbcVAvu3nla
         Qs/BPHzsoN5YQeAtut3H03K8+wXQQv0qcIqtxffItdETtSeadOO9lBCNeCdM2OAu/1n6
         X2FQ5kuvyBCHc1QFT7pS3Avl5HX6nRtVIwV/AB3Z7o95s7macCQ6/z3SrI5Jvyl0R4Tw
         2CNw==
X-Forwarded-Encrypted: i=1; AFNElJ9DQieXorbIB4vwPW3cphTdzPg5/9EElbcmGC2kPNhZIfbiJeixvfTChbqfVA2s3lGjvcHcMc3ExQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ7bJDvLwClDWL9VQDjw6H7+zkzWSn5Sai9R4qM2GtltjBrhY+
	syL0CDMpGKy9VHfEWiY3IcFH8H1e9+ZOWpUE7VuGtEnWRhVksSdVYy57h8SmDefM9554TDuHS3M
	U7Bg6JJlVz/zB/DxZn/uNQebXRxs8KM0=
X-Gm-Gg: Acq92OFItgmcCuDSfY8GAEEZSDEnd5VcNGmFTGzr8fvMWaRnKf5owC+dvAd+m6R6vlC
	PALfiKt/btmznAww6gtlAdnYI0UdVeswal9o0ptHGOD/pI4pzcOdTSPxDATKruM0UnHUkDgD+rN
	yIlC3XThYIHCJHBHbqYtFTbUYqIpsMaHr0EqniklLC5aztVx2BgrI8k1V3IjVO0gwgNCMall+Jw
	IUvQkqIZI+ynxcZ30lURhcvqmHolC2QfnlMPWO6kJS1VNsU+Ct7nFczMTAcl3m4ROG912vd0tU4
	a2jCetbt1eKjhQWsI91uMqUXXzmNd1L5bcY2AnCZ
X-Received: by 2002:a17:906:4fc4:b0:bcf:6ba7:4bf8 with SMTP id
 a640c23a62f3a-bd4f34bd118mr1396926266b.26.1779273217009; Wed, 20 May 2026
 03:33:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519151008.1399226-1-qkrwngud825@gmail.com> <e9a08bed-3d5f-4606-8d17-80a16a4c82f1@kernel.org>
In-Reply-To: <e9a08bed-3d5f-4606-8d17-80a16a4c82f1@kernel.org>
From: Juhyung Park <qkrwngud825@gmail.com>
Date: Wed, 20 May 2026 19:33:24 +0900
X-Gm-Features: AVHnY4IeL4rkcfGD6vJpoWHJPVsVY0mlOdz31w-7ieRtyfoF4Q7rZALT5Z8EpPQ
Message-ID: <CAD14+f316+wMZNm_sJF6ULRDUD9EbkdecdDwhGQKcsu70Bdp0w@mail.gmail.com>
Subject: Re: [PATCH] x86/mm: fix vmemmap leak on memory hot-remove
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-mm@kvack.org, stable@vger.kernel.org, 
	Lu Baolu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>, Oscar Salvador <osalvador@suse.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dan Williams <djbw@kernel.org>, Dave Jiang <dave.jiang@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org, 
	nvdimm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Neat. Any sign of it getting merged?

Thanks.


On Wed, May 20, 2026 at 2:24=E2=80=AFPM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> On 5/19/26 17:10, Juhyung Park wrote:
> > free_pagetable() is called via free_hugepage_table() with
> > get_order(PMD_SIZE) =3D 9 to free the 2 MB vmemmap PMD leaves that back
> > struct page arrays on x86_64. After commit bf9e4e30f353 ("x86/mm: use
> > pagetable_free()"), it goes through pagetable_free() instead of
> > __free_pages(), and pagetable_free() ultimately calls
> > __free_pages(page, compound_order()) which ignores the explicit order
> > argument and infers it from the page's compound metadata.
> >
> > The vmemmap PMD chunks are allocated by vmemmap_alloc_block() using
> > alloc_pages_node() without __GFP_COMP, so PG_head is not set and
> > compound_order() returns 0. Only the first of 512 pages of each PMD
> > chunk is returned to the buddy allocator on hot-remove; the remaining
> > 511 pages stay allocated and become unreachable. Generalized: roughly
> > 16 MB leaked per GB of hot-removed memory per cycle.
> >
> > The leak affects every memory hot-remove path on x86_64 when
> > memmap_on_memory=3DN (the default), including dax_kmem, virtio-mem,
> > balloon drivers, ACPI memory hotplug, and direct sysfs offline+remove.
> > memmap_on_memory=3DY avoids it because free_hugepage_table() then takes
> > the altmap branch and does not call free_pagetable().
> >
> > Reproduced with CXL memory toggled through DAX in a loop:
> >
> >   daxctl reconfigure-device --mode=3Dsystem-ram dax0.0 --force
> >   daxctl reconfigure-device --mode=3Ddevdax    dax0.0 --force
> >
> > Fixes: bf9e4e30f353 ("x86/mm: use pagetable_free()")
> > Cc: stable@vger.kernel.org
> > Cc: Lu Baolu <baolu.lu@linux.intel.com>
> > Cc: Jason Gunthorpe <jgg@nvidia.com>
> > Cc: David Hildenbrand <david@kernel.org>
> > Cc: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > Cc: Oscar Salvador <osalvador@suse.de>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: Andy Lutomirski <luto@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Thomas Gleixner <tglx@kernel.org>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: Dan Williams <djbw@kernel.org>
> > Cc: Dave Jiang <dave.jiang@intel.com>
> > Cc: Vishal Verma <vishal.l.verma@intel.com>
> > Cc: linux-cxl@vger.kernel.org
> > Cc: nvdimm@lists.linux.dev
> > Assisted-by: Claude:claude-opus-4-7
> > Signed-off-by: Juhyung Park <qkrwngud825@gmail.com>
> > ---
> >  arch/x86/mm/init_64.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> > index df2261fa4f98..a2301bddb647 100644
> > --- a/arch/x86/mm/init_64.c
> > +++ b/arch/x86/mm/init_64.c
> > @@ -1024,7 +1024,12 @@ static void __meminit free_pagetable(struct page=
 *page, int order)
> >               free_reserved_pages(page, nr_pages);
> >  #endif
> >       } else {
> > -             pagetable_free(page_ptdesc(page));
> > +             /*
> > +              * Use __free_pages() to honor @order: vmemmap PMD leaves
> > +              * freed here are not compound pages, so pagetable_free()
> > +              * would lose leak 511 of 512 pages per 2 MB chunk.
> > +              */
> > +             __free_pages(page, order);
> >       }
> >  }
> >
>
> I sent a proper fix for this already:
>
> https://lore.kernel.org/all/20260429-vmemmap-v2-1-8dfcacffd877@kernel.org=
/
>
> --
> Cheers,
>
> David
