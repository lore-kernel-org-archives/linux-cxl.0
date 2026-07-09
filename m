Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22853D5226
	for <linux-cxl@vger.kernel.org>; Thu,  9 Jul 2026 06:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783580234; cv=none; b=ty26/BPLdPumqmKtZt86E5ITGO/143zT23flto101Hbt3Ox0raY3uEVNYQ1/K8liD9w0CvGtcm2wiTVlkvzY1j5a1sdQurppX5fURqRwPKjlLry91p4OQG2WtitqC2vsJXrT63a3pNRp+QgIp2b4juK5TYRn8NxpNGastyz26Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783580234; c=relaxed/simple;
	bh=H2sPZ8vychPwASC0yLJnCSVqu8/MmcbFsyaifSFGOJk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OHJB8wA82T5dOaIepaH9zcDUxv3vspaqtffjx6GkDC0qPBkdwqfm75d7645jWFc/uEO5jYQa44R2Jkok1oIuwQ6WlvayAnvUY2laYy0s6r3Qho9VJW/wPzl8VMqgcUc5huYr2oPrwOOnly5agN0y94vFCqj3ohYfWEp8XH231kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MpBHstQV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MpBHstQV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C0F51F000E9;
	Thu,  9 Jul 2026 06:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783580233;
	bh=3+7ne8wvRSTDVLRcLjPOKMZU2gQBMu3DyDdOv003SRk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MpBHstQVi4c0bTFk7//fIGhP3sruE9dZJKX5sJ5ZfK1D3W2Y44asFIX6nhw/nhWEa
	 phnkuE8hWK2qsK/0lvUXJMdfxE9dft/qRQGSRHbMX00YM8uGtlRDFUwuUPLT3qSru0
	 4Yo4HANunvvxdZ8KL2UaDQ4husDwtBUxcVchSAmAfHn+Up7ipdApcAt5ytC0GKF0c6
	 sT7ZlaFq5NP1IjgsziR03NuRs9cvLzo3+5B24prffmpTzObyEHmqhl1Jx7ui7AdV96
	 37CatPtrKCOI6t81lejGMSDS4LwjHLdfHWWtO24FoPoMn4SFm8n94giZed49REsQqf
	 fIwzVSICVp+1g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] mm: split out mm_init and memblock declarations
 from internal.h
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260709-internal-h-v1-1-956d5092782d@kernel.org>
References: <20260709-internal-h-v1-0-956d5092782d@kernel.org>
 <20260709-internal-h-v1-1-956d5092782d@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 06:57:12 +0000
Message-Id: <20260709065713.6C0F51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] Missing semicolon at the end of the `memmap_init_range()` function =
declaration in the new `mm/mm_init.h` header file.
- [Low] `mm/sparse.c` fails to compile because it lacks `#include "mm_init.=
h"`, resulting in undeclared identifiers and potential implicit declaration=
s.
--

--- Patch [1]: [PATCH 1/3] mm: split out mm_init and memblock declarations =
from internal.h ---
commit 13783d4d0cf38a0ede9798e1d71f8e2fb2de5d3d
Author: Mike Rapoport (Microsoft) <rppt@kernel.org>

mm: split out mm_init and memblock declarations from internal.h

This commit moves declarations related to mm/mm_init.c and mm/memblock.c
from mm/internal.h to a new mm/mm_init.h header file to reduce bloat.

> diff --git a/mm/internal.h b/mm/internal.h
> index 5c94d1bd7b930..c514b17c61b87 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
[ ... ]
> @@ -820,14 +807,6 @@ static inline void init_compound_tail(struct page *t=
ail,
>  	prep_compound_tail(tail, head, order);
>  }
> =20
> -extern void *memmap_alloc(phys_addr_t size, phys_addr_t align,
> -			  phys_addr_t min_addr,
> -			  int nid, bool exact_nid);
> -
> -void memmap_init_range(unsigned long, int, unsigned long, unsigned long,
> -		unsigned long, enum meminit_context, struct vmem_altmap *, int,
> -		bool);
> -

[Severity: Low]
Since these declarations are moved to mm/mm_init.h, will mm/sparse.c fail t=
o=20
compile? It appears __populate_section_memmap() relies on memmap_alloc(), a=
nd
mminit_validate_memmodel_limits() relies on mminit_dprintk(), but the patch
doesn't add an include for mm_init.h in mm/sparse.c.

>  /*
>   * mm/sparse.c
>   */
[ ... ]
> diff --git a/mm/mm_init.h b/mm/mm_init.h
> new file mode 100644
> index 0000000000000..118f88c523c95
> --- /dev/null
> +++ b/mm/mm_init.h
[ ... ]
> +void *memmap_alloc(phys_addr_t size, phys_addr_t align, phys_addr_t min_=
addr,
> +		int nid, bool exact_nid);
> +
> +void memmap_init_range(unsigned long size, int nid, unsigned long zone,
> +		unsigned long start_pfn, unsigned long zone_end_pfn,
> +		enum meminit_context context,
> +		struct vmem_altmap *altmap, int migratetype,
> +		bool isolate_pageblock)

[Severity: Low]
Does this declaration cause a syntax error because it is missing a semicolon
at the end?

> +
> +#if defined CONFIG_COMPACTION || defined CONFIG_CMA
> +/* Free whole pageblock and set its migration type to MIGRATE_CMA. */
> +void init_cma_reserved_pageblock(struct page *page);
> +#endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-internal-h=
-v1-0-956d5092782d@kernel.org?part=3D1
