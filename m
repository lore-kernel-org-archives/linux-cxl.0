Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793998264;
	b=cklnzmK1drdeHHfoKW6QmhLHss/uNka05y6miV8KVdh5gl38mtW+im7U/nCHH8mb7wVr
	 mXZCvt4TrmlVIHCx39jBQEGt1DTnuuXMspBvSvjpdfvmRDu02oXUTpRNal1auZm9Dg0T8
	 EGXeD6SvKzo4YzysT+jsjZ9rsHNx7MVeXT0XRUNeou/VJqui870k60Sx3LIQYbVVrDCkd
	 PdeSWa5/W9wx7DoH3pzrb9mFsE7Ngqx+vGNZvLas4taqnmJBl4392m/8DkS566vMyyp+0
	 /UIK/SrAQAeQZErvkBjjapPjMbGSJZRooHMFKicMGHNuebGZ9HxvgJmPjlxscZUz++w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793998264;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/Z43IGhuspYCfpzuAAw8swVktLNXQHUFUy1aOvlU79o=;
	b=Pac/hcWLO0H7AoexORNFSscf1mWq8cTT57ZSeNQcSxAyX4V6KjJ5yvRTrhtsbBgL1yqO
	 M7+fwTBjVCG0eSQjWZuQAcsPXhOZjyxqJvkJr8412fKjfokoWHNwYDMtbHrQibvGh3eZ1
	 aFi7MPyP2GIXeyFAECwDHS1cjeuYWEMTAYqIkRlPtGV5zv/3S2NXM2VQSEX389VRfG/pX
	 78gClwRCLm0ojUORu8ED3nT8m9GKr3P5jBuziikYifbbwNZS0bB/miB10wWOHPcRMlMye
	 qEB2tNHjo9DEO8Imy2NZ37YVM2AHdvf44s3rAVf6m9m7/+hFWYMlkV3I0myf3l7h51w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KfIZaFeC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02802606A32C
	for <linux-cxl@vger.kernel.org>; Fri,  6 Nov 2026 20:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KfIZaFeC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50A3A1F0089F;
	Fri,  6 Nov 2026 20:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793998263;
	bh=/Z43IGhuspYCfpzuAAw8swVktLNXQHUFUy1aOvlU79o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KfIZaFeCkJp7t3ZgcF9I8MLKGYc9Yyh9Dr3hYZ+f9zxxY2rTDnuTu6/ce2JXKui/Z
	 f+6UxSMb8x8sf/0rDn+SWJLAOwP1qCvdTSNg0A/2LdPviCpV0A3hR5p6WTXLqJjV8z
	 btx2wnG7sD5YTiZ3Myi94TdbXcpzSnFWMbefaGu66KRBr1GeRcerNCQIr5Y0G66Lg3
	 F3WR76yAQGGQd3Fj0gcaw8fqwnP9IjoPnmz3y+BYc+/ju2ohYpgamMlNGFdiWsQFWd
	 x/cfXTI95AJFogD+/N5yTO1wjdZBz9AVAcLxYMHCrZTN75bsdZtrb+LrLaQtiZYH/A
	 aJs3uqM7zXPCQ==
Message-ID: <sashiko-outbox-202255@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] mm/memory_hotplug: don't offline a hwpoisoned page
 still in the page cache
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mani Tofigh" <mt4022@columbia.edu>, "David Hildenbrand" <david@kernel.org>, "Oscar
 Salvador" <osalvador@suse.de>, "Andrew Morton" <akpm@linux-foundation.org>
Cc: "Miaohe Lin" <linmiaohe@huawei.com>, "Naoya Horiguchi" <nao.horiguchi@gmail.com>, "Vlastimil
 Babka" <vbabka@kernel.org>, "Gregory Price" <gourry@gourry.net>, linux-mm@kvack.org, linux-cxl@vger.kernel.org, tz2294@columbia.edu
In-Reply-To: <20261105-memhp-hwpoison-pagecache-v2-1-029d35634d42@columbia.edu>
References: <20261105-memhp-hwpoison-pagecache-v2-1-029d35634d42@columbia.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 20:51:02 +0000
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] mm/memory_hotplug: scan_movable_pages() misses poisoned tail
  pages of folios
--

commit 3a170d5683c399929cdc4fe6d9523b3ecee4c1c1
Author: Mani Tofigh <mt4022@columbia.edu>

mm/memory_hotplug: don't offline a hwpoisoned page still in the page cache

This commit prevents memory offlining from skipping hwpoisoned pages whose
folios are still in the page cache or swap cache by introducing
hwpoison_page_offlineable(). It updates scan_movable_pages(),
do_migrate_range(), and __test_page_isolated_in_pageblock() so that
offline_pages() fails with -EBUSY instead of offlining memory still
referenced by a mapping or racing with memory_failure().

[ ... ]

> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 1bfd1f4daeb20..c5cfaa24b41b7 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1821,6 +1821,8 @@ static int scan_movable_pages(unsigned long start, =
unsigned long end,
>  		struct folio *folio;
> =20
>  		page =3D pfn_to_page(pfn);
> +		if (PageHWPoison(page) && !hwpoison_page_offlineable(page))
> +			return -EBUSY;
>  		if (PageLRU(page) || page_has_movable_ops(page))
>  			goto found;
> =20
> @@ -1887,6 +1889,9 @@ static void do_migrate_range(unsigned long start_pf=
n, unsigned long end_pfn)
>  			 */
>  			if (folio_test_large(folio) && !folio_test_hugetlb(folio))
>  				goto put_folio;
> +			/* The offline fails on it anyway, leave it to memory_failure() */
> +			if (!hwpoison_page_offlineable(page))
> +				goto put_folio;
>  			if (folio_test_lru(folio) && !folio_isolate_lru(folio))
>  				goto put_folio;
>  			if (folio_mapped(folio)) {

[Severity: High]
As reported by Sashiko on v1 [1], what happens here when a tail page of a
large page-cache or swap-cache folio is hwpoisoned?

Because PG_hwpoison uses PF_ANY while PageLRU() uses PF_HEAD, a large LRU
folio with a poisoned tail page has PageHWPoison(page) false and
PageLRU(page) true on its head page. Since scan_movable_pages() scans PFNs =
in
ascending order, it encounters the head page first and takes the PageLRU(pa=
ge)
branch:

    page =3D pfn_to_page(pfn);
    if (PageHWPoison(page) && !hwpoison_page_offlineable(page))
        return -EBUSY;
    if (PageLRU(page) || page_has_movable_ops(page))
        goto found;

returning 0 with *movable_pfn set to the head PFN without ever scanning the
poisoned tail PFN.

In offline_pages(), the inner loop then passes that head PFN by value to
do_migrate_range():

    do {
        ...
        ret =3D scan_movable_pages(pfn, end_pfn, &pfn);
        if (!ret) {
            do_migrate_range(pfn, end_pfn);
        }
    } while (!ret);

Inside do_migrate_range(), pfn is advanced past all tail pages of the large
folio:

    if (folio_test_large(folio))
        pfn =3D folio_pfn(folio) + folio_nr_pages(folio) - 1;

    if (folio_contain_hwpoisoned_page(folio)) {
        if (folio_test_large(folio) && !folio_test_hugetlb(folio))
            goto put_folio;
        if (!hwpoison_page_offlineable(page))
            goto put_folio;

This appears to leave two regressions for large folios:

First, if PG_has_hwpoisoned is already set on the large folio (and it was n=
ot
split, for instance because min_order_for_split() > 0 or split failed),
do_migrate_range() takes goto put_folio without isolating the folio from the
LRU. On the next iteration in offline_pages(), pfn is still the head PFN, so
scan_movable_pages() stops at the head page again and offline_pages() spins
in an infinite loop while holding mem_hotplug_lock and pcp_batch_high_lock.

Second, if memory_failure() on a tail page has called TestSetPageHWPoison(p)
and is blocked in get_hwpoison_page() waiting on zone_pcp_disable() before
reaching folio_set_has_hwpoisoned(folio), folio_contain_hwpoisoned_page(fol=
io)
is still false. In that window, do_migrate_range() skips the tail PFNs and
isolates and migrates the folio instead of leaving it to memory_failure().

Should scan_movable_pages() and do_migrate_range() check for poisoned
subpages across the folio (or check folio_contain_hwpoisoned_page() in
scan_movable_pages()) so large folios with poisoned tail pages also return
-EBUSY?

[1] https://lore.kernel.org/r/20261101-memhp-hwpoison-pagecache-v1-1-ed8785=
ca44eb@columbia.edu

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-memhp-hwpo=
ison-pagecache-v2-1-029d35634d42@columbia.edu?part=3D1
