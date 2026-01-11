Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C53264614;
	Sun, 11 Jan 2026 20:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768165158; cv=none; b=UYS/JfVoGQqjzsYgU2Rh9w3xlqOPVNt058g3kjx/ZtFtklOeYTIAKmPvNcx8q1srOBxrFVLREdnmn9dIdiTpC1qD9LISXo1AM1VurcaNC9ugreDUOJum/GkcJaa3Xg2/Wok9R4P88R3pePB1wApizh/KxBRQ/3ifkQ3FAANpOcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768165158; c=relaxed/simple;
	bh=LNpnDim8q3+dLb7XU5TehbNGB6MpSqAnHM9U6qmRx90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dgIkb/EhHRdp4UV/08AfYmrxtVb42FS+giutHK24B3f/KKjdRiM2dIVzYI34U2KSUBCG9qNi1Qb4neT0dEBvzAJ5AoZoRdPmGsp3rYrdrxpjQS8B9G0s8mY/zUyUFi1Wbbn8MA1yuNTtK2EdJADAichFEFyvW6jkbpNdbSW5iHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EPnGEHUE; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EPnGEHUE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768165156; x=1799701156;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LNpnDim8q3+dLb7XU5TehbNGB6MpSqAnHM9U6qmRx90=;
  b=EPnGEHUERnjl73tawdV+urbqr7P7cNjJskTEaWjQ0GS2aFK+7hZFd7oS
   QF9tERSTRtH99I4Q1srzSNVvuRF+y+nMZB9oe4co3yzX8PkaifCNk22Up
   19XSTGFSO4QRfTQvIMLl7Rsbr/P/mDBdlx85QUkUPlBSiMosPsNwRL8Pp
   saDNyIWHsez5//mcI9YmKNqzwHA1Darm+XuhfN+miFSsi7su5HW9+kufa
   9XysMiJAIxhZne6v9aeWbzh9pY7uryRFwAvSSyydnDymlHYhCxNU382e6
   n0EN2Oal+HtQjbJLg7Z1Ae2Is4t+Ei6C12cP52Kh6gJOTcx/pSOaaabpg
   Q==;
X-CSE-ConnectionGUID: r2pWd2k9Q6u6Twq7+XX8kg==
X-CSE-MsgGUID: wNERepExSleyNKDw2Vl6Hg==
X-IronPort-AV: E=McAfee;i="6800,10657,11668"; a="80904696"
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="80904696"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2026 12:59:16 -0800
X-CSE-ConnectionGUID: Bkff/IltSoKRlj2s67sD2g==
X-CSE-MsgGUID: HR5Gkm0nQJKuc017WtcF5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="208419967"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO fdugast-desk.home) ([10.245.245.11])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2026 12:59:12 -0800
From: Francois Dugast <francois.dugast@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
	Matthew Brost <matthew.brost@intel.com>,
	Zi Yan <ziy@nvidia.com>,
	David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Balbir Singh <balbirs@nvidia.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Alistair Popple <apopple@nvidia.com>,
	linux-mm@kvack.org,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Francois Dugast <francois.dugast@intel.com>
Subject: [PATCH v4 2/7] mm/zone_device: Add free_zone_device_folio_prepare() helper
Date: Sun, 11 Jan 2026 21:55:41 +0100
Message-ID: <20260111205820.830410-3-francois.dugast@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260111205820.830410-1-francois.dugast@intel.com>
References: <20260111205820.830410-1-francois.dugast@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matthew Brost <matthew.brost@intel.com>

Add free_zone_device_folio_prepare(), a helper that restores large
ZONE_DEVICE folios to a sane, initial state before freeing them.

Compound ZONE_DEVICE folios overwrite per-page state (e.g. pgmap and
compound metadata). Before returning such pages to the device pgmap
allocator, each constituent page must be reset to a standalone
ZONE_DEVICE folio with a valid pgmap and no compound state.

Use this helper prior to folio_free() for device-private and
device-coherent folios to ensure consistent device page state for
subsequent allocations.

Fixes: d245f9b4ab80 ("mm/zone_device: support large zone device private folios")
Cc: Zi Yan <ziy@nvidia.com>
Cc: David Hildenbrand <david@kernel.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Balbir Singh <balbirs@nvidia.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: linux-mm@kvack.org
Cc: linux-cxl@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Suggested-by: Alistair Popple <apopple@nvidia.com>
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Francois Dugast <francois.dugast@intel.com>
---
 include/linux/memremap.h |  1 +
 mm/memremap.c            | 55 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index 97fcffeb1c1e..88e1d4707296 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -230,6 +230,7 @@ static inline bool is_fsdax_page(const struct page *page)
 
 #ifdef CONFIG_ZONE_DEVICE
 void zone_device_page_init(struct page *page, unsigned int order);
+void free_zone_device_folio_prepare(struct folio *folio);
 void *memremap_pages(struct dev_pagemap *pgmap, int nid);
 void memunmap_pages(struct dev_pagemap *pgmap);
 void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap);
diff --git a/mm/memremap.c b/mm/memremap.c
index 39dc4bd190d0..375a61e18858 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -413,6 +413,60 @@ struct dev_pagemap *get_dev_pagemap(unsigned long pfn)
 }
 EXPORT_SYMBOL_GPL(get_dev_pagemap);
 
+/**
+ * free_zone_device_folio_prepare() - Prepare a ZONE_DEVICE folio for freeing.
+ * @folio: ZONE_DEVICE folio to prepare for release.
+ *
+ * ZONE_DEVICE pages/folios (e.g., device-private memory or fsdax-backed pages)
+ * can be compound. When freeing a compound ZONE_DEVICE folio, the tail pages
+ * must be restored to a sane ZONE_DEVICE state before they are released.
+ *
+ * This helper:
+ *   - Clears @folio->mapping and, for compound folios, clears each page's
+ *     compound-head state (ClearPageHead()/clear_compound_head()).
+ *   - Resets the compound order metadata (folio_reset_order()) and then
+ *     initializes each constituent page as a standalone ZONE_DEVICE folio:
+ *       * clears ->mapping
+ *       * restores ->pgmap (prep_compound_page() overwrites it)
+ *       * clears ->share (only relevant for fsdax; unused for device-private)
+ *
+ * If @folio is order-0, only the mapping is cleared and no further work is
+ * required.
+ */
+void free_zone_device_folio_prepare(struct folio *folio)
+{
+	struct dev_pagemap *pgmap = page_pgmap(&folio->page);
+	int order, i;
+
+	VM_WARN_ON_FOLIO(!folio_is_zone_device(folio), folio);
+
+	folio->mapping = NULL;
+	order = folio_order(folio);
+	if (!order)
+		return;
+
+	folio_reset_order(folio);
+
+	for (i = 0; i < (1UL << order); i++) {
+		struct page *page = folio_page(folio, i);
+		struct folio *new_folio = (struct folio *)page;
+
+		ClearPageHead(page);
+		clear_compound_head(page);
+
+		new_folio->mapping = NULL;
+		/*
+		 * Reset pgmap which was over-written by
+		 * prep_compound_page().
+		 */
+		new_folio->pgmap = pgmap;
+		new_folio->share = 0;	/* fsdax only, unused for device private */
+		VM_WARN_ON_FOLIO(folio_ref_count(new_folio), new_folio);
+		VM_WARN_ON_FOLIO(!folio_is_zone_device(new_folio), new_folio);
+	}
+}
+EXPORT_SYMBOL_GPL(free_zone_device_folio_prepare);
+
 void free_zone_device_folio(struct folio *folio)
 {
 	struct dev_pagemap *pgmap = folio->pgmap;
@@ -454,6 +508,7 @@ void free_zone_device_folio(struct folio *folio)
 	case MEMORY_DEVICE_COHERENT:
 		if (WARN_ON_ONCE(!pgmap->ops || !pgmap->ops->folio_free))
 			break;
+		free_zone_device_folio_prepare(folio);
 		pgmap->ops->folio_free(folio, order);
 		percpu_ref_put_many(&folio->pgmap->ref, nr);
 		break;
-- 
2.43.0

