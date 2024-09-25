Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C506E14AD32;
	Wed, 25 Sep 2024 02:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727232440; cv=none; b=nus475/NYHtzFHtQuqk5cB6/ubJXUiROHO60apMVOJIwPJtQZiROL/KAQ3LYftUozwBTeF1V+FOmE2+1GTVxLgcJndZpoAzuIvxAmIHfqUhf13f2/eJsYG6kVNNDtLmYuotdnObpaacei9drK0DAHkXxMu9/k3YOkj2t2ziRVTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727232440; c=relaxed/simple;
	bh=KR5JtIBjk9XQKtGLonFY5l2vNf8jHSzObyuuvpIkJNI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cHW5RxbCKMWREwJ9kP2XO+0mRjcSz/fQkQzjK+recWz+7U/v8p6g0q99qlSjOFjg3LyrrACnmjRbHo9KJEvImO5/kYDwQHlN7a/kQldRfs2ouSbEUwMhq99i1JZL7YbqTcjxefZLx8JOiFjDlBLGIBhko8KxkfjWVdb4EICrdFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KOLhb5mw; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KOLhb5mw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727232439; x=1758768439;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KR5JtIBjk9XQKtGLonFY5l2vNf8jHSzObyuuvpIkJNI=;
  b=KOLhb5mwBcxAZ+jaguVrbrz2NlCjsiaWkjiam4TRSEZ392oLymhJLkui
   V8N/GlUUB/uUOaK7w83xK9NF5YbwMASMRqivzDGpm4pIhyNMDOI7I6UvE
   19X26F1521EGCx0w54/4VbEz+SphwPqt7KG0vyOVoh20qqQtcVjteLpSO
   Y/0zNZ6aI7B9D8nAVe82sszoYqHniXBAioBZn11iQ3Jlr7gItPVJU44En
   dfPq9jNCgsrzoaZ2vzLSZV41pIII4scLVMEeKjJekKpG7h+OHbUDDN6G4
   5pJxFprAHu2u7CAYb1suSJ0M3b45kO4vGOc9L07CWtMovy0UkSaixTlFv
   w==;
X-CSE-ConnectionGUID: Sd/ISAdsRUmJRnwcVNAdpQ==
X-CSE-MsgGUID: 2hJW1xw2RjesuEne2fMzhQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="26132055"
X-IronPort-AV: E=Sophos;i="6.10,256,1719903600"; 
   d="scan'208";a="26132055"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 19:47:19 -0700
X-CSE-ConnectionGUID: 8gzOwi7XS3qjgWvHfYU97w==
X-CSE-MsgGUID: ZvikI7uxTWuV9Dyc4rNCrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,256,1719903600"; 
   d="scan'208";a="102389003"
Received: from yhuang6-mobl2.sh.intel.com ([10.238.3.32])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 19:47:16 -0700
From: Huang Ying <ying.huang@intel.com>
To: Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Huang Ying <ying.huang@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Alejandro Lucero <alucerop@amd.com>
Subject: [RFC 3/5] cxl: Separate coherence from target type
Date: Wed, 25 Sep 2024 10:46:45 +0800
Message-Id: <20240925024647.46735-4-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240925024647.46735-1-ying.huang@intel.com>
References: <20240925024647.46735-1-ying.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, target type (expander or accelerator) and
coherence (HOSTONLY (HDM-H) or DEV (HDM-D/DB)) are synonym.  So target
type is used to designate coherence too.  However, it's possible for
expanders to use HDM-DB now.  So, we need to separate coherence from
target type.

Accordingly, the HOSTONLY field of decoder ctrl
register (CXL_HDM_DECODER0_CTRL_HOSTONLY) need to be set according to
coherence.

The coherence of decoders can not be determined via target type too.
So, accelerator/expander device drivers need to specify coherence
explicitly via newly added coherence field in struct cxl_dev_state.

The coherence of each end points in a region need to be same.  So, the
coherence of the first end point is recorded in struct region.  Which
will be checked against the coherence of all other end points.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/hdm.c    | 22 +++++++++++++++-------
 drivers/cxl/core/mbox.c   |  1 +
 drivers/cxl/core/port.c   |  1 +
 drivers/cxl/core/region.c | 37 ++++++++++++++++++++++++++++++++++---
 drivers/cxl/cxl.h         |  9 +++++++++
 drivers/cxl/cxlmem.h      | 11 +++++++++++
 6 files changed, 71 insertions(+), 10 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 57b54ecdb000..478fb6691759 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -569,10 +569,10 @@ static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
 	*ctrl |= CXL_HDM_DECODER0_CTRL_COMMIT;
 }
 
-static void cxld_set_type(struct cxl_decoder *cxld, u32 *ctrl)
+static void cxld_set_coherence(struct cxl_decoder *cxld, u32 *ctrl)
 {
 	u32p_replace_bits(ctrl,
-			  !!(cxld->target_type == CXL_DECODER_EXPANDER),
+			  !!(cxld->coherence == CXL_DECODER_HOSTONLYCOH),
 			  CXL_HDM_DECODER0_CTRL_HOSTONLY);
 }
 
@@ -667,7 +667,7 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
 	/* common decoder settings */
 	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(cxld->id));
 	cxld_set_interleave(cxld, &ctrl);
-	cxld_set_type(cxld, &ctrl);
+	cxld_set_coherence(cxld, &ctrl);
 	base = cxld->hpa_range.start;
 	size = range_len(&cxld->hpa_range);
 
@@ -846,10 +846,13 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 		cxld->flags |= CXL_DECODER_F_ENABLE;
 		if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
 			cxld->flags |= CXL_DECODER_F_LOCK;
-		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_HOSTONLY, ctrl))
+		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_HOSTONLY, ctrl)) {
 			cxld->target_type = CXL_DECODER_EXPANDER;
-		else
+			cxld->coherence = CXL_DECODER_HOSTONLYCOH;
+		} else {
 			cxld->target_type = CXL_DECODER_ACCEL;
+			cxld->coherence = CXL_DECODER_DEVCOH;
+		}
 
 		guard(rwsem_write)(&cxl_region_rwsem);
 		if (cxld->id != cxl_num_decoders_committed(port)) {
@@ -879,13 +882,18 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 				cxld->target_type = CXL_DECODER_EXPANDER;
 			else
 				cxld->target_type = CXL_DECODER_ACCEL;
+			if (cxlds->coherence == CXL_DEVCOH_HOSTONLY)
+				cxld->coherence = CXL_DECODER_HOSTONLYCOH;
+			else
+				cxld->coherence = CXL_DECODER_DEVCOH;
 		} else {
-			/* To be overridden by region type at commit time */
+			/* To be overridden by region type/coherence at commit time */
 			cxld->target_type = CXL_DECODER_EXPANDER;
+			cxld->coherence = CXL_DECODER_HOSTONLYCOH;
 		}
 
 		if (!FIELD_GET(CXL_HDM_DECODER0_CTRL_HOSTONLY, ctrl) &&
-		    cxld->target_type == CXL_DECODER_EXPANDER) {
+		    cxld->coherence == CXL_DECODER_HOSTONLYCOH) {
 			ctrl |= CXL_HDM_DECODER0_CTRL_HOSTONLY;
 			writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(which));
 		}
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index e5cdeafdf76e..3635a0a402b7 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1424,6 +1424,7 @@ struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
 	mds->cxlds.reg_map.host = dev;
 	mds->cxlds.reg_map.resource = CXL_RESOURCE_NONE;
 	mds->cxlds.type = CXL_DEVTYPE_CLASSMEM;
+	mds->cxlds.coherence = CXL_DEVCOH_HOSTONLY;
 	mds->ram_perf.qos_class = CXL_QOS_CLASS_INVALID;
 	mds->pmem_perf.qos_class = CXL_QOS_CLASS_INVALID;
 
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 47ad6d9329db..2dee78e9b90c 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1769,6 +1769,7 @@ static int cxl_decoder_init(struct cxl_port *port, struct cxl_decoder *cxld)
 	cxld->interleave_ways = 1;
 	cxld->interleave_granularity = PAGE_SIZE;
 	cxld->target_type = CXL_DECODER_EXPANDER;
+	cxld->coherence = CXL_DECODER_HOSTONLYCOH;
 	cxld->hpa_range = (struct range) {
 		.start = 0,
 		.end = -1,
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 8229e8a0072d..cec7d08b6f44 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1005,9 +1005,10 @@ static int cxl_rr_alloc_decoder(struct cxl_port *port, struct cxl_region *cxlr,
 	}
 
 	/*
-	 * Endpoints should already match the region type, but backstop that
-	 * assumption with an assertion. Switch-decoders change mapping-type
-	 * based on what is mapped when they are assigned to a region.
+	 * Endpoints should already match the region type/coherence, but
+	 * backstop that assumption with an assertion. Switch-decoders change
+	 * mapping-type/coherence based on what is mapped when they are assigned
+	 * to a region.
 	 */
 	dev_WARN_ONCE(&cxlr->dev,
 		      port == cxled_to_port(cxled) &&
@@ -1016,6 +1017,13 @@ static int cxl_rr_alloc_decoder(struct cxl_port *port, struct cxl_region *cxlr,
 		      dev_name(&cxled_to_memdev(cxled)->dev),
 		      dev_name(&cxld->dev), cxld->target_type, cxlr->type);
 	cxld->target_type = cxlr->type;
+	dev_WARN_ONCE(&cxlr->dev,
+		      port == cxled_to_port(cxled) &&
+			      cxld->coherence != cxlr->coherence,
+		      "%s:%s mismatch decoder coherence %d -> %d\n",
+		      dev_name(&cxled_to_memdev(cxled)->dev),
+		      dev_name(&cxld->dev), cxld->coherence, cxlr->coherence);
+	cxld->coherence = cxlr->coherence;
 	cxl_rr->decoder = cxld;
 	return 0;
 }
@@ -1925,6 +1933,29 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 		return -ENXIO;
 	}
 
+	/* Set the coherence of region to that of the first endpoint */
+	if (cxlr->coherence == CXL_DECODER_INVALIDCOH) {
+		unsigned long flags = cxlrd->cxlsd.cxld.flags;
+		enum cxl_decoder_coherence coherence = cxled->cxld.coherence;
+
+		cxlr->coherence = coherence;
+		if ((coherence == CXL_DECODER_HOSTONLYCOH &&
+		     !(flags & CXL_DECODER_F_HOSTONLYCOH)) ||
+		    (coherence == CXL_DECODER_DEVCOH &&
+		     !(flags & CXL_DECODER_F_DEVCOH))) {
+			dev_dbg(&cxlr->dev,
+"%s:%s endpoint coherence: %d isn't supported by root decoder: %#lx\n",
+				dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
+				coherence, flags);
+			return -ENXIO;
+		}
+	} else if (cxled->cxld.coherence != cxlr->coherence) {
+		dev_dbg(&cxlr->dev, "%s:%s coherence mismatch: %d vs %d\n",
+			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
+			cxled->cxld.coherence, cxlr->coherence);
+		return -ENXIO;
+	}
+
 	if (!cxled->dpa_res) {
 		dev_dbg(&cxlr->dev, "%s:%s: missing DPA allocation.\n",
 			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev));
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 55b8c32f8d72..99398c868d82 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -328,6 +328,12 @@ enum cxl_decoder_type {
 	CXL_DECODER_EXPANDER = 3,
 };
 
+enum cxl_decoder_coherence {
+	CXL_DECODER_INVALIDCOH,
+	CXL_DECODER_HOSTONLYCOH,
+	CXL_DECODER_DEVCOH,
+};
+
 /*
  * Current specification goes up to 8, double that seems a reasonable
  * software max for the foreseeable future
@@ -356,6 +362,7 @@ struct cxl_decoder {
 	int interleave_ways;
 	int interleave_granularity;
 	enum cxl_decoder_type target_type;
+	enum cxl_decoder_coherence coherence;
 	struct cxl_region *region;
 	unsigned long flags;
 	int (*commit)(struct cxl_decoder *cxld);
@@ -517,6 +524,7 @@ struct cxl_region_params {
  * @id: This region's id. Id is globally unique across all regions
  * @mode: Endpoint decoder allocation / access mode
  * @type: Endpoint decoder target type
+ * @coherence: Endpoint decoder coherence
  * @cxl_nvb: nvdimm bridge for coordinating @cxlr_pmem setup / shutdown
  * @cxlr_pmem: (for pmem regions) cached copy of the nvdimm bridge
  * @flags: Region state flags
@@ -530,6 +538,7 @@ struct cxl_region {
 	int id;
 	enum cxl_decoder_mode mode;
 	enum cxl_decoder_type type;
+	enum cxl_decoder_coherence coherence;
 	struct cxl_nvdimm_bridge *cxl_nvb;
 	struct cxl_pmem_region *cxlr_pmem;
 	unsigned long flags;
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index afb53d058d62..cc4880286134 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -393,6 +393,16 @@ enum cxl_devtype {
 	CXL_DEVTYPE_CLASSMEM,
 };
 
+/*
+ * enum cxl_devcoherence - the coherence of the cxl device
+ * @CXL_DEVCOH_DEV      - HDM-D or HDM-DB
+ * @CXL_DEVCOH_HOSTONLY - HDM-H
+ */
+enum cxl_devcoherence {
+	CXL_DEVCOH_DEV,
+	CXL_DEVCOH_HOSTONLY,
+};
+
 /**
  * struct cxl_dpa_perf - DPA performance property entry
  * @dpa_range: range for DPA address
@@ -438,6 +448,7 @@ struct cxl_dev_state {
 	struct resource ram_res;
 	u64 serial;
 	enum cxl_devtype type;
+	enum cxl_devcoherence coherence;
 };
 
 /**
-- 
2.39.2

