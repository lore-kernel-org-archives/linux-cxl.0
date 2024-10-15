Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8C71B4F3E;
	Tue, 15 Oct 2024 06:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728975508; cv=none; b=dDoLBu7deY6aj6/TrD6v7MK8mEg/ivtc/LoiTTs7j6Xd2QK0vNbXNE3997+YvvAByazjZsJRx8yh20ZNWPpQjj0QBUv//33phhz3mtmbm6LMrU0zHH/Z3GmJsp29V85FVJ3O2oS86r3WUfjqq5SO7dEGbl2Chq/UUsXq34VR1Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728975508; c=relaxed/simple;
	bh=pvBwtu4JQxUWjKxLWnVdsVP0pKJHDkT2XbcNeyPqdwM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t42ley1W8c8OxP13OCbBPg24QvjogZ7NJvg93BoX+sAB4KArxzd97sS1YcF0ydH0osmgn+bigoWU3RORfammNrqbgoJ542VM6T8gNcGOYr6xlJDQRjvWlZ8UdgDjUNWaYnHGsOuKjj8Zc9lz3jqgB8wUVltTyqGG0ICi2PSwZ90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iQlOSu9K; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iQlOSu9K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728975507; x=1760511507;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pvBwtu4JQxUWjKxLWnVdsVP0pKJHDkT2XbcNeyPqdwM=;
  b=iQlOSu9K1R04SJWp1c0MkVrnOWXu2HsSrCjkQ8O9gFG/AmCp3eRpLWTl
   O/uIyyt0jTDLnvZ1qA+h2u2xQk5UKMlGhr0PHmn8k6RmfgZ0pNuU3HEIK
   qwg3+7gc3agWwvRdxhdiwAl75CVCcnbbSwh4JN/8RAw13Y94Fw4GTiBDF
   3HCWYyWU2EchTmuysXKb71599KuTfmxoPq2DocmUbg49WQlgjW0g+26N+
   2Pr+Tw42owx7e741me/8Evia1WUMxIS7L97FykcyO5JTHhna4DR4v8+3Y
   PR0Sn3DgbQFqgRFZL3UbwKnpDbVw3ISb7Q8bUnJHfM12tqJuYv+I/Kt25
   w==;
X-CSE-ConnectionGUID: /WhJb/cWQn6S3JEq1zSWnw==
X-CSE-MsgGUID: 8hUg0ANSSmyxq31h68C3Pw==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="28447850"
X-IronPort-AV: E=Sophos;i="6.11,204,1725346800"; 
   d="scan'208";a="28447850"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 23:58:27 -0700
X-CSE-ConnectionGUID: Ia9b77BnQTGPsPhfFK+cIw==
X-CSE-MsgGUID: CKFDbMAfToW98mATEuauYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,204,1725346800"; 
   d="scan'208";a="81776917"
Received: from yhuang6-mobl2.sh.intel.com ([10.238.3.32])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 23:58:23 -0700
From: Huang Ying <ying.huang@intel.com>
To: Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Huang Ying <ying.huang@intel.com>,
	Gregory Price <gourry@gourry.net>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Alejandro Lucero <alucerop@amd.com>,
	Ben Cheatham <benjamin.cheatham@amd.com>
Subject: [PATCH 3/5] cxl: Separate coherence from target type
Date: Tue, 15 Oct 2024 14:57:11 +0800
Message-Id: <20241015065713.308671-4-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241015065713.308671-1-ying.huang@intel.com>
References: <20241015065713.308671-1-ying.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, target type (expander or accelerator) and
coherence (HOSTONLY (HDM-H) or DEV (HDM-D/DB)) are synonym.  So
current kernel uses target type to designate coherence too.  However,
it's possible for expanders to use HDM-DB now.  So, the patch
separates coherence from target type.

Accordingly, the patch sets the HOSTONLY field of decoder ctrl
register (CXL_HDM_DECODER0_CTRL_HOSTONLY) according to the coherence
instead of the target type.

Because we cannot determine the coherence of decoders via target type,
the patch lets accelerator/expander device drivers specify coherence
explicitly via newly added coherence field in struct cxl_dev_state.

The coherence of each end points in a region needs to be same.  So,
the patch records the coherence of the first added end point in struct
region.  Then, it checks whether the coherence of all other end points
is same.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Alejandro Lucero <alucerop@amd.com>
Cc: Ben Cheatham <benjamin.cheatham@amd.com>
---
 drivers/cxl/core/hdm.c    | 22 +++++++++++++++-------
 drivers/cxl/core/mbox.c   |  1 +
 drivers/cxl/core/port.c   |  1 +
 drivers/cxl/core/region.c | 37 ++++++++++++++++++++++++++++++++++---
 drivers/cxl/cxl.h         | 10 ++++++++++
 drivers/cxl/cxlmem.h      | 12 ++++++++++++
 6 files changed, 73 insertions(+), 10 deletions(-)

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
index 5175138c4fb7..fb98cd1a8b61 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1450,6 +1450,7 @@ struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
 	mds->cxlds.reg_map.host = dev;
 	mds->cxlds.reg_map.resource = CXL_RESOURCE_NONE;
 	mds->cxlds.type = CXL_DEVTYPE_CLASSMEM;
+	mds->cxlds.coherence = CXL_DEVCOH_HOSTONLY;
 	mds->ram_perf.qos_class = CXL_QOS_CLASS_INVALID;
 	mds->pmem_perf.qos_class = CXL_QOS_CLASS_INVALID;
 
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index e80b0af3d812..9ebbffcea26a 100644
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
index 036356bc4204..21b877d8582f 100644
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
index f95101994238..1927a1849d82 100644
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
@@ -344,6 +350,7 @@ enum cxl_decoder_type {
  * @interleave_ways: number of cxl_dports in this decode
  * @interleave_granularity: data stride per dport
  * @target_type: accelerator vs expander (type2 vs type3) selector
+ * @coherence: host only vs device coherence selector
  * @region: currently assigned region for this decoder
  * @flags: memory type capabilities and locking
  * @commit: device/decoder-type specific callback to commit settings to hw
@@ -356,6 +363,7 @@ struct cxl_decoder {
 	int interleave_ways;
 	int interleave_granularity;
 	enum cxl_decoder_type target_type;
+	enum cxl_decoder_coherence coherence;
 	struct cxl_region *region;
 	unsigned long flags;
 	int (*commit)(struct cxl_decoder *cxld);
@@ -517,6 +525,7 @@ struct cxl_region_params {
  * @id: This region's id. Id is globally unique across all regions
  * @mode: Endpoint decoder allocation / access mode
  * @type: Endpoint decoder target type
+ * @coherence: Endpoint decoder coherence
  * @cxl_nvb: nvdimm bridge for coordinating @cxlr_pmem setup / shutdown
  * @cxlr_pmem: (for pmem regions) cached copy of the nvdimm bridge
  * @flags: Region state flags
@@ -530,6 +539,7 @@ struct cxl_region {
 	int id;
 	enum cxl_decoder_mode mode;
 	enum cxl_decoder_type type;
+	enum cxl_decoder_coherence coherence;
 	struct cxl_nvdimm_bridge *cxl_nvb;
 	struct cxl_pmem_region *cxlr_pmem;
 	unsigned long flags;
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 2a25d1957ddb..f9156c578bde 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -394,6 +394,16 @@ enum cxl_devtype {
 	CXL_DEVTYPE_CLASSMEM,
 };
 
+/*
+ * enum cxl_devcoherence - the coherence of the cxl device
+ * @CXL_DEVCOH_DEV      - HDM-D (type 2) or HDM-DB (type 2/3)
+ * @CXL_DEVCOH_HOSTONLY - HDM-H (type 3)
+ */
+enum cxl_devcoherence {
+	CXL_DEVCOH_DEV,
+	CXL_DEVCOH_HOSTONLY,
+};
+
 /**
  * struct cxl_dpa_perf - DPA performance property entry
  * @dpa_range: range for DPA address
@@ -427,6 +437,7 @@ struct cxl_dpa_perf {
  * @ram_res: Active Volatile memory capacity configuration
  * @serial: PCIe Device Serial Number
  * @type: Generic Memory Class device or Vendor Specific Memory device
+ * @coherence: Device or Host only coherence
  * @cxl_mbox: CXL mailbox context
  */
 struct cxl_dev_state {
@@ -442,6 +453,7 @@ struct cxl_dev_state {
 	struct resource ram_res;
 	u64 serial;
 	enum cxl_devtype type;
+	enum cxl_devcoherence coherence;
 	struct cxl_mailbox cxl_mbox;
 };
 
-- 
2.39.2

