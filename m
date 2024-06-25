Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54CD10A35
	for <linux-cxl@vger.kernel.org>; Tue, 25 Jun 2024 00:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719276962; cv=none; b=D0A4tGt93QVmc26b68KMbTVFGrCYNvw0CWpytQQxhIMY5oeCTG4cyWC0GvUMP9ISX59zoqLhd+72H8LXj58BGiLmKH7hX30atZvYbc5P3d3Ipz7T0rPBc0aNQgq44hzPkdnJsD1l6yAquGTmwyhxxCnrQ6jg5gf/46iwve6Xxdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719276962; c=relaxed/simple;
	bh=Z5l2JaJqXhRbUO4BRBgkhLxsWnAyzZZp3IqJbFHXSa0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S3HWdBkfYSJG3z1+Su143saBsJZOD9RxPK0LUNjmip3HSCzsPITR1Nwrh8VWgtruycQh+HG6i64oGOjJR9pLxvjpy8LmMOAqnyEiE9QvH215uanM2s2W1P5V7TltW5c+ILhaoWKSIP5YwPKgDnWW9uxGKuyuIO8iELi2l1EjXl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WhLDhlpQ; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WhLDhlpQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719276961; x=1750812961;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Z5l2JaJqXhRbUO4BRBgkhLxsWnAyzZZp3IqJbFHXSa0=;
  b=WhLDhlpQ3k1182vWF9x5D+qv7Wtr/HgrtdOtgHV526Z5ovhRMP04NG87
   VNU+V2Yv9PaZtxl34pU202g8IjE9vuxmrJMBm8p2cZhxjPnzC4mKyJhwy
   SdjP3kZsFwcp9/DTtXcXdUiuOyKV94/6eBdHp4SAuN1Mod4zl2rvkGq/S
   36Mc7SlTnuTfaY996CbpcdZxi2Zrr+ecufnR8O/ffBnydTFkPCqmdUBjI
   rEpPD3II1elm11aB0DlNSoBSjBmGbgijNn3Rwl78Uu/kylvP6W49Rpu62
   U9oKXC8KMviUrXZfocAFeOkEHFG6l3CeyuhqxDVSLQhCyQQe7M5NDOv8F
   Q==;
X-CSE-ConnectionGUID: 9bp2x7DcSEOPIYe3HE3WFQ==
X-CSE-MsgGUID: 8B2fTjYeTkecSmaBUoNTVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="16028467"
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="16028467"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 17:56:00 -0700
X-CSE-ConnectionGUID: l/LRICaiRIikfyCPzZORVQ==
X-CSE-MsgGUID: cv+gjihUQCqlp+l1yzaMwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="66697316"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.55.37])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 17:55:59 -0700
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v3 1/4] cxl/core: Rename cxl_trace_hpa() to cxl_dpa_to_hpa()
Date: Mon, 24 Jun 2024 17:55:52 -0700
Message-Id: <3ed59646c9f1400432520845e482fb0341af4d56.1719275633.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1719275633.git.alison.schofield@intel.com>
References: <cover.1719275633.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

Although cxl_trace_hpa() is used to populate TRACE EVENTs with HPA
addresses, the work it performs is a DPA to HPA translation, not a
trace. Rename it.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
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

