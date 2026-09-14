Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5916348C4B
	for <linux-cxl@vger.kernel.org>; Mon, 14 Sep 2026 07:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789372706; cv=none; b=NFfjJoelA7pRAf7RmA6vscM6Jmn6/XIsRUNLmkJOoVueMtqNBB0Y3Zu8UO//eKb3sd6RUh1qXLhjZPrIFoEHutZ6URHgZCDEJlpdifBI0vP5jL9C+VXSr4iMZk5Jed6MXq/dcHoksaIdnbZtxGN1XO4UGnSP3oiQHPPWoNlKM2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789372706; c=relaxed/simple;
	bh=3YQB8XuEHzfK7NL93cAgatM7syHiIevtuqQtrngHLe4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=f5hI1m1mbyX+zwZccya6yrLr+w/3rf7thrjBhTCmLuMwsNJgCmuQyptDuHnDozTSbHX5uxveVgo4tFhSprw694CcnlQczBLAAXM2C9LAM+isZyqVapwI6nby1JMDP1oI77hi/s/3QliACGgaDBP1RwOlVw2ymWYheSy7PePEsp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TkfAZkDk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TkfAZkDk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF06C1F000FF;
	Mon, 14 Sep 2026 07:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789372704;
	bh=eWO1eBAsBZmZpy7sxVRWUEOhTjTt4WjF3k5lmWKrngk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TkfAZkDkqRN1FSh8uxOxK6MpFeGCL1YM3za9f44yY1swL5yvLdyA7SbSAqRBH7bkL
	 urv/nI5p5jEiYqNLjfeBNbl0CL1UxtcZ9ZbIQocdcLRIDvbovoCtFtsIALxVxejldI
	 1IFhA+k7xHUZp8QqKrclFUkxsKQQdvxT3v7WZ2LoaggMKCqRZsxvONzKjz71AzjCmI
	 9WyOGtNUfo4AeaSu0WZGJrPc1eQmLAp+toXbrBFUl3ex38bE4DszMPxHT9NAAKAb2O
	 Wcaq9vAK0VxJMnEsSxWdokfP9dj7i1Ak55+L+9eO0xRmpWpozAPC8bpraym6l8L9zz
	 HuABKJAEw6giw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH] mm/memory_hotplug: use public nodes for migration
 targets
Reply-To: sashiko-reviews@lists.linux.dev
To: Zimo.Lu <louis2665573906@gmail.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260914074323.3567923-1-louis2665573906@gmail.com>
References: <20260914074323.3567923-1-louis2665573906@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 07:58:23 +0000
Message-Id: <20260914075823.EF06C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Medium] Restricting the migration target nodemask to N_MEMORY_PUBLIC pre=
vents HugeTLB folios from migrating between private nodes.
- [Low] N_MEMORY_PUBLIC is undeclared, causing a build failure.

Pre-existing issues:
- [High] Infinite loop during memory offlining when encountering a hwpoison=
ed large folio.
- [High] HWPoisoned folios are permanently leaked from the LRU and their re=
fcounts are permanently elevated during memory hotplug offlining.
--

commit a396d55b92bfae38e85ebc68194e34af029a9db7
Author: Zimo.Lu <louis2665573906@gmail.com>

mm/memory_hotplug: use public nodes for migration targets

This commit modifies do_migrate_range() to use N_MEMORY_PUBLIC for the
migration target nodemask instead of N_MEMORY. This aims to prevent
private nodes from blocking fallback to public nodes when allocating
migration targets, which also impacts HugeTLB migration targets during
memory offlining.

> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index d7a59167bec43..683925183df6b 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1928,7 +1928,7 @@ static void do_migrate_range(unsigned long start_pf=
n, unsigned long end_pfn)

[Severity: High]
This is a pre-existing issue, but does skipping poisoned large folios earli=
er
in do_migrate_range() cause a livelock?

During memory offlining, skipping the folio without splitting it means
isolation fails and the folio is never handled:

		if (folio_contain_hwpoisoned_page(folio)) {
			/*
			 * unmap_poisoned_folio() cannot handle large folios
			 * in all cases yet.
			 */
			if (folio_test_large(folio) && !folio_test_hugetlb(folio))
				goto put_folio;

This causes test_pages_isolated() to fail, which forces the outer do-while
loop in offline_pages() to retry indefinitely, holding global hotplug locks
and causing a system-wide denial of service.

Can this be fixed by splitting the large folio before evaluating
unmap_poisoned_folio()?

[Severity: High]
This is also a pre-existing issue, but does this leak the isolation referen=
ce
and permanently elevate the folio refcount for hwpoisoned folios?

When folio_isolate_lru() succeeds, it removes the folio from the LRU and
takes an isolation reference:

			if (folio_test_lru(folio) && !folio_isolate_lru(folio))
				goto put_folio;
			if (folio_mapped(folio)) {
				folio_lock(folio);
				unmap_poisoned_folio(folio, pfn, false);
				folio_unlock(folio);
			}

			goto put_folio;
		}

By jumping to put_folio, the code drops only the initial reference from
folio_try_get():

>  		folio_put(folio);

This leaves the isolation reference permanently leaked and the folio
permanently off the LRU list, preventing the memory block from being offlin=
ed.

>  	}
>  	if (!list_empty(&source)) {
> -		nodemask_t nmask =3D node_states[N_MEMORY];
> +		nodemask_t nmask =3D node_states[N_MEMORY_PUBLIC];

[Severity: Low]
Does this cause a build failure? N_MEMORY_PUBLIC is undeclared in the kernel
source, causing compilation to fail.

[Severity: Medium]
Does restricting this nodemask to N_MEMORY_PUBLIC break HugeTLB migration
between private nodes?

Since alloc_hugetlb_folio_nodemask() strictly iterates the provided nmask,
initializing it to N_MEMORY_PUBLIC strips out all private nodes as potential
targets.

If a private node with HugeTLB pages is offlined, and public nodes lack
sufficient HugeTLB pages, offlining will fail even if other private nodes
could accept them.

>  		struct migration_target_control mtc =3D {
>  			.nmask =3D &nmask,
>  			.gfp_mask =3D GFP_KERNEL | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914074323.3567=
923-1-louis2665573906@gmail.com?part=3D1
