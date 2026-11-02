Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793648474;
	b=25JUDA2pvKCtX+aoQmxNaPmWqB3hAot8qcGZ4Pp5FkhdKIHRRA5Q7ylxvCyn0Ukx1xjW
	 nhz0z8BWgEx6nC30Ehsz3Ri7HHlZ7mxjw130Xsc0MZP606d+k7ToKRrjjVGtVbeYLD4d+
	 UHLPHk3pOI22Qe2kvGo0uI7Ri9lRZ9eqohL3hH5VGzcUooJr4R6xI8mfTakLsXbyDp9IU
	 oZBQ3/yvWN6EK9ted64eX4Ye/+G1bZujOhoBb4yOpcJyPEprMMKAa0T1LExfE2d95etMH
	 73GeEh6C4Vag2v2Ct0z+qqGPYTbO5ecQlVYVTvkWBN7xmDIKdCLNOW1EBkDMuywAylA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793648474;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hkPWmaCky5W9ZtvBeQ8qvs6llvQ7sqyJvIYBj283GTg=;
	b=Ef91iMyknQqS+vn/5l0xwX5ARNdFdeszbaWFHvk2V3ziALuWcOn0mvi3jovtANsDE2ry
	 WyLVXt0VwCWWjNJiQlZ/MiVc4RTLRDnM4O3DQMpraw5pDjvpfcFXTZf/DNex5aaP2ZC0B
	 ItDQ/dYRz2YimKGayuQ3P9fhxJIm2143JItTTZhSA3KD/YVUErJu4Jgh9MjIYV1+GlgaQ
	 F2oO604bmAZnRIRRYI7yD133DHpC5NxVDMoSo5EWJB/StDPz2gPdNVYX4Y17zspEU6OwB
	 +dJeWGAje+tJACVfiWaYwoMStxtzQm6rwlFZBvpeK/xnJ4b0slMY0Pytos93kdy5nHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E4AAeII1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6371606A324
	for <linux-cxl@vger.kernel.org>; Mon,  2 Nov 2026 19:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E4AAeII1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01BDB1F00A17;
	Mon,  2 Nov 2026 19:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793648473;
	bh=hkPWmaCky5W9ZtvBeQ8qvs6llvQ7sqyJvIYBj283GTg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E4AAeII1KS1riiB887L0qFvZPCQ8+b2dATicts/b3r3eax4TmYosUy7OVfRCt0osL
	 8iOymyMEPiYkT+CDFGd7pAuhRaa22heDtzJ+ellS/40LuBkBIwJi5oZzSj0rF0oGi1
	 L/X0YF4x540L/3pY6fmIV1X2l5ZHjjWoT5A///eHbHrmAYDDIt4Wf9VYeuUDf4ojD1
	 NnOA1/9ayRzJamq5+qEzq65+co0czMYwZbpIYuxSGJIh4g+KSyQ2aD9GcNFUDcn2KH
	 KgDhK9aEQ4fUthkdLZOFk9l3uPEoQjHi2dio2b5Jb1SzuiSi/vAlFjYRN/kTXtU0oS
	 294Fo0Rdfbhag==
Message-ID: <sashiko-outbox-194015@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mm/memory_hotplug: don't offline a hwpoisoned page
 still in the page cache
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mani Tofigh" <mt4022@columbia.edu>, "David Hildenbrand" <david@kernel.org>, "Oscar
 Salvador" <osalvador@suse.de>, "Andrew Morton" <akpm@linux-foundation.org>
Cc: "Miaohe Lin" <linmiaohe@huawei.com>, "Naoya Horiguchi" <nao.horiguchi@gmail.com>, "Vlastimil
 Babka" <vbabka@kernel.org>, "Gregory Price" <gourry@gourry.net>, linux-mm@kvack.org, linux-cxl@vger.kernel.org, tz2294@columbia.edu
In-Reply-To: <20261101-memhp-hwpoison-pagecache-v1-1-ed8785ca44eb@columbia.edu>
References: <20261101-memhp-hwpoison-pagecache-v1-1-ed8785ca44eb@columbia.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 19:41:12 +0000
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] mm/memory_hotplug: do_migrate_range() isolates busy hwpoisoned fol=
ios from LRU
- [High] mm/memory_hotplug: scan_movable_pages() misses poisoned tail pages=
 of folios
--

commit 90624953bdb2c5ae02a7473ca37edfda72128f6d
Author: Mani Tofigh <mt4022@columbia.edu>

mm/memory_hotplug: don't offline a hwpoisoned page still in the page cache

This commit prevents memory offlining from skipping hwpoisoned pages whose
folios still have a page-cache or swap-cache mapping in scan_movable_pages()
and __test_page_isolated_in_pageblock(). This avoids offlining memory while
files or swap caches still reference poisoned pages.

[ ... ]

> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index c9cc42e54f05d..3d36f7f2e04b6 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1820,6 +1820,8 @@ static int scan_movable_pages(unsigned long start, =
unsigned long end,
>  		struct folio *folio;
> =20
>  		page =3D pfn_to_page(pfn);
> +		if (PageHWPoison(page) && !hwpoison_page_offlineable(page))
> +			return -EBUSY;
>  		if (PageLRU(page) || page_has_movable_ops(page))
>  			goto found;

[Severity: High]
Does do_migrate_range() still isolate a non-offlineable hwpoisoned folio fr=
om
the LRU and leak its reference when another movable page precedes it in the
range?

In offline_pages(), scan_movable_pages() returns 0 as soon as it finds the
first movable page, and offline_pages() then passes the entire remaining
range [pfn, end_pfn) to do_migrate_range():

mm/memory_hotplug.c:offline_pages() {
    ...
			ret =3D scan_movable_pages(pfn, end_pfn, &pfn);
			if (!ret) {
				/*
				 * TODO: fatal migration failures should bail
				 * out
				 */
				do_migrate_range(pfn, end_pfn);
			}
    ...
}

In addition, because memory_failure() does not hold mem_hotplug_lock,
TestSetPageHWPoison() can run after scan_movable_pages() has already scanned
past that PFN.

When do_migrate_range() reaches the hwpoisoned page-cache or swap-cache fol=
io
while memory_failure() is waiting in get_hwpoison_page() on
pcp_batch_high_lock, it isolates the folio from the LRU without checking
hwpoison_page_offlineable():

mm/memory_hotplug.c:do_migrate_range() {
    ...
		if (folio_contain_hwpoisoned_page(folio)) {
			if (folio_test_large(folio) && !folio_test_hugetlb(folio))
				goto put_folio;
			if (folio_test_lru(folio) && !folio_isolate_lru(folio))
				goto put_folio;
			if (folio_mapped(folio)) {
				folio_lock(folio);
				unmap_poisoned_folio(folio, pfn, false);
				folio_unlock(folio);
			}

			goto put_folio;
		}
    ...
}

On the next pass of the loop in offline_pages(), scan_movable_pages() reach=
es
the poisoned page and returns -EBUSY. However, folio_isolate_lru() has
already cleared PG_lru and taken an extra reference on the folio that
put_folio does not drop.

When the waiting memory_failure() resumes in get_hwpoison_page() ->
get_any_page() -> __get_hwpoison_page(), HWPoisonHandlable() sees
!PageLRU(page) and fails with -EIO instead of truncating the folio, and the
leaked reference from folio_isolate_lru() keeps the poisoned folio pinned in
the page cache so subsequent offline_pages() attempts also fail with -EBUSY.

Should do_migrate_range() also skip isolating the folio when
!hwpoison_page_offlineable() is true?

[Severity: High]
What happens in scan_movable_pages() when a tail page of a large page-cache
or swap-cache folio is hwpoisoned?

PG_hwpoison is set per subpage whereas PG_lru is on the head page. Because
scan_movable_pages() scans sequentially from start, it visits the head page
of a large folio before any tail page. At the head page, PageHWPoison(page)
is false and PageLRU(page) is true, so scan_movable_pages() takes the
goto found branch at the head PFN without scanning the poisoned tail PFN.

In do_migrate_range(), if PG_has_hwpoisoned is already set on the large
folio (for instance, when memory_failure() could not split the large folio):

mm/memory_hotplug.c:do_migrate_range() {
    ...
		if (folio_test_large(folio))
			pfn =3D folio_pfn(folio) + folio_nr_pages(folio) - 1;

		if (folio_contain_hwpoisoned_page(folio)) {
			/*
			 * unmap_poisoned_folio() cannot handle large folios
			 * in all cases yet.
			 */
			if (folio_test_large(folio) && !folio_test_hugetlb(folio))
				goto put_folio;
    ...
}

do_migrate_range() skips the large folio without clearing PG_lru, and the
do-while (!ret) loop in offline_pages() calls scan_movable_pages() again at
the same head PFN, looping indefinitely while holding mem_hotplug_lock and
pcp_batch_high_lock.

Conversely, if memory_failure() on a tail page is blocked in
get_hwpoison_page() before setting PG_has_hwpoisoned, do_migrate_range()
advances pfn to the end of the large folio, sees
folio_contain_hwpoisoned_page(folio) as false, and migrates the folio
despite the poisoned tail page.

Can scan_movable_pages() and do_migrate_range() check for poisoned subpages
across the folio so that large folios with poisoned tail pages are handled
consistently?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261101-memhp-hwpo=
ison-pagecache-v1-1-ed8785ca44eb@columbia.edu?part=3D1
