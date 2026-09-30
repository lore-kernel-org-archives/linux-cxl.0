Received: from mta1.migadu.com (out-158.mta1.migadu.com [95.215.58.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F1C3749F6
	for <linux-cxl@vger.kernel.org>; Wed, 30 Sep 2026 16:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790784290; cv=none; b=Nn1oYdwy8wUtWHWuNbGygjPp8aFbD7e5k5GIXWPenoa0zfWr6cuflf4NaZjSzoz/3aI9NklXwMbdaxBTaS4cRo2AlDbQ8LRIccNT5QDS2tTObzfSPXUM3WgLOb/eUhfNyItbjF3AZTymuAdSFKlrXkRKAZUQCttfgqSMIq4CRHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790784290; c=relaxed/simple;
	bh=+vcczYRy1rNmcGvWO3RhaCJIFdsbwMwez0v32TjbTB8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CWSs0jci/+s3C158ZeZIK9jQNM5A8DZMkm5uN/MQPrS7aYnNrsYzCE0vA9So/ys3191BznXYhMVt8fEoMHlvR1s3KNxTduGZfDPVD8z44yZllLYsApxyYXRbeei0j4lodqRAJ4hDwORahRJiSlZBHN2wvwYLo/jEpiJ7NPQG+j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uG+xLlU4; arc=none smtp.client-ip=95.215.58.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uG+xLlU4"
X-Envelope-To: linux-cxl@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=+vcczYRy1rNmcGvWO3RhaCJIFdsbwMwez0v32TjbTB8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790784283; v=1; x=1791389083;
 b=uG+xLlU4sGw7EqoBVo99T2gQsThTMjyQzYGcTJupxalP3wan7nQJNGc3Kx3jLbr1Jj1KXb7J
 aUmILtDc3r40i/GSBkxKy2+mfCgIsFiPylGlM2EsYPy+ONMcHX+nkytYqN6LA1+qtWfOgXOpubS
 J8KWlbHKtkaDBVN4srGkn2m0=
X-Envelope-To: linux-cxl@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 6e927973fa05e775;
	Wed, 30 Sep 2026 16:04:42 +0000
X-Mizu-Trace-ID: 6e927973fa05e775
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: david@kernel.org,
	osalvador@suse.de
Cc: akpm@linux-foundation.org,
	muchun.song@linux.dev,
	linux-mm@kvack.org,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH 1/1] mm/memory_hotplug: fix missing rollback in __add_pages()
Date: Thu,  1 Oct 2026 00:04:32 +0800
Message-ID: <20260930160432.5564-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__add_pages() returns on a sparse_add_section() failure without removing
the sections already added in the same request.

For memremap_pages(), the failed range is not counted in pgmap->nr_range,
so memunmap_pages() skips it. The sections already added in that range
retain their vmemmap mappings and subsection bits. Retrying a
section-aligned range can then fail with -EEXIST.

Save the initial PFN and remove [start_pfn, pfn) on failure. For a vmemmap
population failure, section_activate() already cleans up the current
section, so the rollback excludes it. If the first section fails,
__remove_pages() receives an empty range and does nothing.

Link: https://lore.kernel.org/all/BAD58999-1EDD-4A37-ABA0-DB1BD8AB3453@linux.dev/
Suggested-by: Muchun Song <muchun.song@linux.dev>
Signed-off-by: Lance Yang <lance.yang@linux.dev>
---
No Fixes tag, as I couldn't identify the commit that introduced this issue.

 mm/memory_hotplug.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 796af1028ee2..ca4656698148 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -380,6 +380,7 @@ EXPORT_SYMBOL_GPL(pfn_to_online_page);
 int __add_pages(int nid, unsigned long pfn, unsigned long nr_pages,
 		struct mhp_params *params)
 {
+	const unsigned long start_pfn = pfn;
 	const unsigned long end_pfn = pfn + nr_pages;
 	unsigned long cur_nr_pages;
 	int err;
@@ -413,8 +414,11 @@ int __add_pages(int nid, unsigned long pfn, unsigned long nr_pages,
 				   SECTION_ALIGN_UP(pfn + 1) - pfn);
 		err = sparse_add_section(nid, pfn, cur_nr_pages, altmap,
 					 params->pgmap);
-		if (err)
+		if (err) {
+			__remove_pages(start_pfn, pfn - start_pfn, altmap,
+				       params->pgmap);
 			break;
+		}
 		cond_resched();
 	}
 	vmemmap_populate_print_last();
-- 
2.39.3

