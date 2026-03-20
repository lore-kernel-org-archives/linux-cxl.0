Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B871B2D3A60;
	Fri, 20 Mar 2026 22:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774044828; cv=none; b=ZV8cBVPrRkQseuK3/bpTFD4BssAmAzySuJ3wUKrCEFHHNz3Mtwd3ZeMdJT6mG0nghNwKJZylq/htlzZxdjbo5MlooFsF+0O6Clmv6Q6cZ2qaT2yMFI3UuihQ7CQgKl4n7463Y52sIvJd4pNGCXAhe8DX5Hh4xSH9nhcyI0dshVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774044828; c=relaxed/simple;
	bh=nHbTHkZVPmgr07xrNZlc6QBoO7DF8u1xsHWbyTYeiTQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NokfG8qybjZnpnXev8ugd5/jcDkB3QADIAHVvFraNoQCNikUvheORWvEZSl6Kv17dHifOOTvOl8yhy6ZjEONx5kanXvqw44NRJljz8EDhrYlgAhf46c5dA7tAd+v9+ooJ0vKy0P5aNgHUEpcM/AbICcwUTbELfM8RtZOdBqSs2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tQfW0O52; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tQfW0O52"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B74D4C4CEF7;
	Fri, 20 Mar 2026 22:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774044828;
	bh=nHbTHkZVPmgr07xrNZlc6QBoO7DF8u1xsHWbyTYeiTQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tQfW0O52ZtyktIiPAk6j94DCE/TASe1TGKNwSCHH/AqiVoKikGBfFF3W4UcBK/nfw
	 8V7Vb27Vcmrr0XvfznjhmwdnhGVPlZCBt7c1tUzBlzwi7wYWY0KR84ObQEtEz6uESv
	 dRzL5KUAy9mEFD4GI/QVpkY+cklyuLv1v1lmUNE7D7i6zqVl2H/QaLAOr83tthbwZl
	 jIT3N5KVDUM3OYBhJFn5GCC1nY/SIvLbps9ZcbkHdoN80Bzuh8s1eM7pV8Bva0XXDY
	 h8kXTpPAdxsUhuyQ3Sg8Xd7BkRgiNQ4pgqYN84AN08nzdlaoP9hShigTqDXP9QruqH
	 SbtczXznDUijA==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Fri, 20 Mar 2026 23:13:33 +0100
Subject: [PATCH v2 01/15] mm/memory_hotplug: fix possible race in
 scan_movable_pages()
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260320-sparsemem_cleanups-v2-1-096addc8800d@kernel.org>
References: <20260320-sparsemem_cleanups-v2-0-096addc8800d@kernel.org>
In-Reply-To: <20260320-sparsemem_cleanups-v2-0-096addc8800d@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Oscar Salvador <osalvador@suse.de>, 
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
 Wei Xu <weixugc@google.com>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org, 
 linux-cxl@vger.kernel.org, linux-riscv@lists.infradead.org, 
 "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.13.0

If a hugetlb folio gets freed while we are in scan_movable_pages(),
folio_nr_pages() could return 0, resulting in or'ing "0 - 1 = -1"
to the PFN, resulting in PFN = -1. We're not holding any locks or
references that would prevent that.

for_each_valid_pfn() would then search for the next valid PFN, and could
return a PFN that is outside of the range of the original requested
range. do_migrate_page() would then try to migrate quite a big range,
which is certainly undesirable.

To fix it, simply test for valid folio_nr_pages() values. While at it,
as PageHuge() really just does a page_folio() internally, we can just
use folio_test_hugetlb() on the folio directly.

scan_movable_pages() is expected to be fast, and we try to avoid taking
locks or grabbing references. We cannot use folio_try_get() as that does
not work for free hugetlb folios. We could grab the hugetlb_lock, but
that just adds complexity.

The race is unlikely to trigger in practice, so we won't be CCing
stable.

Fixes: 16540dae959d ("mm/hugetlb: mm/memory_hotplug: use a folio in scan_movable_pages()")
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/memory_hotplug.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 86d3faf50453..969cd7ddf68f 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1747,6 +1747,7 @@ static int scan_movable_pages(unsigned long start, unsigned long end,
 	unsigned long pfn;
 
 	for_each_valid_pfn(pfn, start, end) {
+		unsigned long nr_pages;
 		struct page *page;
 		struct folio *folio;
 
@@ -1763,9 +1764,9 @@ static int scan_movable_pages(unsigned long start, unsigned long end,
 		if (PageOffline(page) && page_count(page))
 			return -EBUSY;
 
-		if (!PageHuge(page))
-			continue;
 		folio = page_folio(page);
+		if (!folio_test_hugetlb(folio))
+			continue;
 		/*
 		 * This test is racy as we hold no reference or lock.  The
 		 * hugetlb page could have been free'ed and head is no longer
@@ -1775,7 +1776,11 @@ static int scan_movable_pages(unsigned long start, unsigned long end,
 		 */
 		if (folio_test_hugetlb_migratable(folio))
 			goto found;
-		pfn |= folio_nr_pages(folio) - 1;
+		nr_pages = folio_nr_pages(folio);
+		if (unlikely(nr_pages < 1 || nr_pages > MAX_FOLIO_NR_PAGES ||
+			     !is_power_of_2(nr_pages)))
+			continue;
+		pfn |= nr_pages - 1;
 	}
 	return -ENOENT;
 found:

-- 
2.43.0

