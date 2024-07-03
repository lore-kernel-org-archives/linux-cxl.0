Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E530E4502F
	for <linux-cxl@vger.kernel.org>; Wed,  3 Jul 2024 05:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719984599; cv=none; b=BH3M+hcG8BFN/21JiPG6mfklEziaM+vsr1U4JHcFwIGDMd7u9xCalh+2w0cVDNTfVGqCfi9pHgXkQPt3iaVmL4rHTyeizaApDq+6D6Tj/wu3qH9/geaDJKhYyIcy5MPN6juCF9T6oBwpw/Lc3U86nvIZ87ZlWcvzLQqeDv9CX6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719984599; c=relaxed/simple;
	bh=kN0JUgGggoXbheamNP+7gcsRp7Icgd2/oUJPiQNTktY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YO5rvtvbIeaOQLrBo2BQD3DsfoQsFXJO/fK03szBfWqJt1kxBgwSmdoEGy8HxzcvtgTRhVKxcejsorJaG4NEKM7GwQNV669hC6fD+sz5NjCS6kX3AYTlMPyxWmleOgp7VbDwogxbW44ZffhnFcYhdJ6jrV4292yzbZYwujxpuZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bvNa3wRh; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bvNa3wRh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719984598; x=1751520598;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kN0JUgGggoXbheamNP+7gcsRp7Icgd2/oUJPiQNTktY=;
  b=bvNa3wRhp9zdiScD4xG/+YijkLoDytFjMEaXizewCgKlv3sgdvYazGIG
   Dge/5YVHte0qfK1XQD9rH+rXhVD9JFYGTmoT8DCCKoYl6h3lNzXuJPjdP
   n9OhGQ2QVUwI8sL5su73fZ4rWHZKw1VK9S9Pe4b1Yfm5MocxZ4u/jk88t
   cbPq24gFare+dnxugFK171yLZBZYgH5wV31cbVCN4DS0pM8nIsbT4K15g
   WO5fmizVcEdcj4PxF/BvrT8OV3KgUD9Z0eRpWiaeUdt6TzNXE1pcfjday
   tPppt2+e4WNiQIh7mokNA2KbTxXsV9RsrR1LlUtNhnPAcPaao37eBjaFM
   A==;
X-CSE-ConnectionGUID: W4phQujKQmm+QR9QxGHgbg==
X-CSE-MsgGUID: mBDDkYGiQ8miS6QHI9hVrg==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="28326344"
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="28326344"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 22:29:57 -0700
X-CSE-ConnectionGUID: oeaUWj4bQMmNeEe+pOY7Rg==
X-CSE-MsgGUID: tkoZJ6yuTN6lScvwI4Xovg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="46004059"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.8.146])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 22:29:56 -0700
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v4 1/4] cxl/core: Fold cxl_trace_hpa() into cxl_dpa_to_hpa()
Date: Tue,  2 Jul 2024 22:29:49 -0700
Message-Id: <452a9b0c525b774c72d9d5851515ffa928750132.1719980933.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1719980933.git.alison.schofield@intel.com>
References: <cover.1719980933.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

Although cxl_trace_hpa() is used to populate TRACE EVENTs with HPA
addresses the work it performs is a DPA to HPA translation not a
trace. Tidy up this naming by moving the minimal work done in
cxl_trace_hpa() into cxl_dpa_to_hpa() and use cxl_dpa_to_hpa()
for trace event callbacks.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/core.h   |  8 ++++----
 drivers/cxl/core/mbox.c   |  2 +-
 drivers/cxl/core/region.c | 33 +++++++++++++--------------------
 drivers/cxl/core/trace.h  |  4 ++--
 4 files changed, 20 insertions(+), 27 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 625394486459..72a506c9dbd0 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -28,12 +28,12 @@ int cxl_region_init(void);
 void cxl_region_exit(void);
 int cxl_get_poison_by_endpoint(struct cxl_port *port);
 struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa);
-u64 cxl_trace_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
-		  u64 dpa);
+u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
+		   u64 dpa);
 
 #else
-static inline u64
-cxl_trace_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd, u64 dpa)
+static inline u64 cxl_dpa_to_hpa(struct cxl_region *cxlr,
+				 const struct cxl_memdev *cxlmd, u64 dpa)
 {
 	return ULLONG_MAX;
 }
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 2626f3fff201..eb0b08e5136f 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -878,7 +878,7 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
 		dpa = le64_to_cpu(evt->common.phys_addr) & CXL_DPA_MASK;
 		cxlr = cxl_dpa_to_region(cxlmd, dpa);
 		if (cxlr)
-			hpa = cxl_trace_hpa(cxlr, cxlmd, dpa);
+			hpa = cxl_dpa_to_hpa(cxlr, cxlmd, dpa);
 
 		if (event_type == CXL_CPER_EVENT_GEN_MEDIA)
 			trace_cxl_general_media(cxlmd, type, cxlr, hpa,
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 3c2b6144be23..237c28d5f2cc 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2749,15 +2749,25 @@ static bool cxl_is_hpa_in_range(u64 hpa, struct cxl_region *cxlr, int pos)
 	return false;
 }
 
-static u64 cxl_dpa_to_hpa(u64 dpa,  struct cxl_region *cxlr,
-			  struct cxl_endpoint_decoder *cxled)
+u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
+		   u64 dpa)
 {
 	u64 dpa_offset, hpa_offset, bits_upper, mask_upper, hpa;
 	struct cxl_region_params *p = &cxlr->params;
-	int pos = cxled->pos;
+	struct cxl_endpoint_decoder *cxled = NULL;
 	u16 eig = 0;
 	u8 eiw = 0;
+	int pos;
 
+	for (int i = 0; i < p->nr_targets; i++) {
+		cxled = p->targets[i];
+		if (cxlmd == cxled_to_memdev(cxled))
+			break;
+	}
+	if (!cxled || cxlmd != cxled_to_memdev(cxled))
+		return ULLONG_MAX;
+
+	pos = cxled->pos;
 	ways_to_eiw(p->interleave_ways, &eiw);
 	granularity_to_eig(p->interleave_granularity, &eig);
 
@@ -2797,23 +2807,6 @@ static u64 cxl_dpa_to_hpa(u64 dpa,  struct cxl_region *cxlr,
 	return hpa;
 }
 
-u64 cxl_trace_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
-		  u64 dpa)
-{
-	struct cxl_region_params *p = &cxlr->params;
-	struct cxl_endpoint_decoder *cxled = NULL;
-
-	for (int i = 0; i <  p->nr_targets; i++) {
-		cxled = p->targets[i];
-		if (cxlmd == cxled_to_memdev(cxled))
-			break;
-	}
-	if (!cxled || cxlmd != cxled_to_memdev(cxled))
-		return ULLONG_MAX;
-
-	return cxl_dpa_to_hpa(dpa, cxlr, cxled);
-}
-
 static struct lock_class_key cxl_pmem_region_key;
 
 static int cxl_pmem_region_alloc(struct cxl_region *cxlr)
diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index ee5cd4eb2f16..21b76e9c5c60 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -704,8 +704,8 @@ TRACE_EVENT(cxl_poison,
 		if (cxlr) {
 			__assign_str(region);
 			memcpy(__entry->uuid, &cxlr->params.uuid, 16);
-			__entry->hpa = cxl_trace_hpa(cxlr, cxlmd,
-						     __entry->dpa);
+			__entry->hpa = cxl_dpa_to_hpa(cxlr, cxlmd,
+						      __entry->dpa);
 		} else {
 			__assign_str(region);
 			memset(__entry->uuid, 0, 16);
-- 
2.37.3

