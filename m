Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3879914B955;
	Wed, 25 Sep 2024 02:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727232444; cv=none; b=sXL46e+DFNF4NkMRl3t2Zf9T39pU8t52jogGvaR1TMcWuaKBLQM8pI02kbZ9Lbc3+KVxcZfQctBa8E5862TZp2sfIpEoPVr3qW4/OHmsP5MyBGW28Yj9Euin/0/6c8YRuwUHvlMIns2Rc1J9dxV7EN21bNfBYuxDa1dAqTRVOyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727232444; c=relaxed/simple;
	bh=KJXo8CquvIp6jpXXQM1ww2sW6uLXMf0+6SQWjmsIFBU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SlSR4YXgLn6UnZwFi1of2b3h8K2nfmuv6CAwq/dXmt9HpvpSlyEhQ9/En9UC/rD7Be5NFZtXnGldxtXvveMlafF7mCb00wem0ftyN6KJQkhBfTXFVDCu6lEPoJOUeWMfeg5gfJXhxrjSll0QfueFN6RYK7I6dT4jOnup4AYckLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iy3bP5UL; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iy3bP5UL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727232442; x=1758768442;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KJXo8CquvIp6jpXXQM1ww2sW6uLXMf0+6SQWjmsIFBU=;
  b=iy3bP5ULHJkyEI3LSyu24+ZIJp+u5F0gE3NFJahReZu8f0hCAHb//4zh
   CMu2Rqzok6tgJ1UfXOh0+LKlMiFnid5mnCDS4XYWe33b2Jb3HAII/g7nf
   uRSAJokIihuLVqC8ovrdNqb2WcbjD7KzIq7QHdAG5Xl7zGfmuCR74GrFV
   /UD7LMEXrY9dc2ezFdzaO14qHj7k2pDyl6XTa6mlOx/zNQpNQwIX1kBPx
   btdDOqo/xjMiG7KgcnFROhGLsxYuSaGjHIemwRp6NNjtC40+LorpvBkdd
   fmz3ChdKi09EP+QUAqgJrbTg6TSsATSPcl9d5zCOGEfsEpWiwENmWfmGh
   w==;
X-CSE-ConnectionGUID: +AG9weyuTbexeDTVjkiR8w==
X-CSE-MsgGUID: NVupepx/QZS8sGyCtQcqPw==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="26132067"
X-IronPort-AV: E=Sophos;i="6.10,256,1719903600"; 
   d="scan'208";a="26132067"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 19:47:22 -0700
X-CSE-ConnectionGUID: QRzszYR1TuCJBAgyXM6yNg==
X-CSE-MsgGUID: XYpsNtclRxqCawOIFDuwSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,256,1719903600"; 
   d="scan'208";a="102389036"
Received: from yhuang6-mobl2.sh.intel.com ([10.238.3.32])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 19:47:19 -0700
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
Subject: [RFC 4/5] cxl: Set type of region to that of the first endpoint
Date: Wed, 25 Sep 2024 10:46:46 +0800
Message-Id: <20240925024647.46735-5-ying.huang@intel.com>
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

The type of region is hard-coded as type 3 expander now, because this
is the only supported device type.  As a preparation to support type 2
accelerators, we set the type of region to that of the first endpoint.
Then, we will check whether the type of region is same as the type of
other endpoints of the region.  Because what we really need is to make
sure the type of all endpoints of a region is same.

The target type of endpoint devices comes from expander/accelerator
device drivers via struct cxl_dev_state.

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
 drivers/cxl/acpi.c        |  1 -
 drivers/cxl/core/hdm.c    | 28 +++++++++++++---------------
 drivers/cxl/core/port.c   |  2 ++
 drivers/cxl/core/region.c | 13 +++++++------
 drivers/cxl/cxl.h         |  1 +
 5 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 21486e471305..29c2a44b122c 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -382,7 +382,6 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
 
 	cxld = &cxlrd->cxlsd.cxld;
 	cxld->flags = cfmws_to_decoder_flags(cfmws->restrictions);
-	cxld->target_type = CXL_DECODER_EXPANDER;
 	cxld->hpa_range = (struct range) {
 		.start = cfmws->base_hpa,
 		.end = cfmws->base_hpa + cfmws->window_size - 1,
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 478fb6691759..c9accf8be71f 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -841,18 +841,25 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 		.end = base + size - 1,
 	};
 
+	if (cxled) {
+		struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+		struct cxl_dev_state *cxlds = cxlmd->cxlds;
+
+		if (cxlds->type == CXL_DEVTYPE_CLASSMEM)
+			cxld->target_type = CXL_DECODER_EXPANDER;
+		else
+			cxld->target_type = CXL_DECODER_ACCEL;
+	}
+
 	/* decoders are enabled if committed */
 	if (committed) {
 		cxld->flags |= CXL_DECODER_F_ENABLE;
 		if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
 			cxld->flags |= CXL_DECODER_F_LOCK;
-		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_HOSTONLY, ctrl)) {
-			cxld->target_type = CXL_DECODER_EXPANDER;
+		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_HOSTONLY, ctrl))
 			cxld->coherence = CXL_DECODER_HOSTONLYCOH;
-		} else {
-			cxld->target_type = CXL_DECODER_ACCEL;
+		else
 			cxld->coherence = CXL_DECODER_DEVCOH;
-		}
 
 		guard(rwsem_write)(&cxl_region_rwsem);
 		if (cxld->id != cxl_num_decoders_committed(port)) {
@@ -874,21 +881,12 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 			struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 			struct cxl_dev_state *cxlds = cxlmd->cxlds;
 
-			/*
-			 * Default by devtype until a device arrives that needs
-			 * more precision.
-			 */
-			if (cxlds->type == CXL_DEVTYPE_CLASSMEM)
-				cxld->target_type = CXL_DECODER_EXPANDER;
-			else
-				cxld->target_type = CXL_DECODER_ACCEL;
 			if (cxlds->coherence == CXL_DEVCOH_HOSTONLY)
 				cxld->coherence = CXL_DECODER_HOSTONLYCOH;
 			else
 				cxld->coherence = CXL_DECODER_DEVCOH;
 		} else {
-			/* To be overridden by region type/coherence at commit time */
-			cxld->target_type = CXL_DECODER_EXPANDER;
+			/* To be overridden by region coherence at commit time */
 			cxld->coherence = CXL_DECODER_HOSTONLYCOH;
 		}
 
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 2dee78e9b90c..5633b7316cb3 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -139,6 +139,8 @@ static ssize_t target_type_show(struct device *dev,
 		return sysfs_emit(buf, "accelerator\n");
 	case CXL_DECODER_EXPANDER:
 		return sysfs_emit(buf, "expander\n");
+	default:
+		break;
 	}
 	return -ENXIO;
 }
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index cec7d08b6f44..9c68ec445128 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1926,7 +1926,10 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 		return -ENXIO;
 	}
 
-	if (cxled->cxld.target_type != cxlr->type) {
+	/* Set the type of region to that of the first endpoint */
+	if (cxlr->type == CXL_DECODER_INVALID) {
+		cxlr->type = cxled->cxld.target_type;
+	} else if (cxled->cxld.target_type != cxlr->type) {
 		dev_dbg(&cxlr->dev, "%s:%s type mismatch: %d vs %d\n",
 			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
 			cxled->cxld.target_type, cxlr->type);
@@ -2482,7 +2485,6 @@ static int cxl_region_calculate_adistance(struct notifier_block *nb,
  * @cxlrd: root decoder
  * @id: memregion id to create, or memregion_free() on failure
  * @mode: mode for the endpoint decoders of this region
- * @type: select whether this is an expander or accelerator (type-2 or type-3)
  *
  * This is the second step of region initialization. Regions exist within an
  * address space which is mapped by a @cxlrd.
@@ -2492,8 +2494,7 @@ static int cxl_region_calculate_adistance(struct notifier_block *nb,
  */
 static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
 					      int id,
-					      enum cxl_decoder_mode mode,
-					      enum cxl_decoder_type type)
+					      enum cxl_decoder_mode mode)
 {
 	struct cxl_port *port = to_cxl_port(cxlrd->cxlsd.cxld.dev.parent);
 	struct cxl_region *cxlr;
@@ -2504,7 +2505,7 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
 	if (IS_ERR(cxlr))
 		return cxlr;
 	cxlr->mode = mode;
-	cxlr->type = type;
+	cxlr->type = CXL_DECODER_INVALID;
 
 	dev = &cxlr->dev;
 	rc = dev_set_name(dev, "region%d", id);
@@ -2576,7 +2577,7 @@ static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
 		return ERR_PTR(-EBUSY);
 	}
 
-	return devm_cxl_add_region(cxlrd, id, mode, CXL_DECODER_EXPANDER);
+	return devm_cxl_add_region(cxlrd, id, mode);
 }
 
 static ssize_t create_pmem_region_store(struct device *dev,
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 99398c868d82..2a2d2c483654 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -324,6 +324,7 @@ resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
 #define CXL_DECODER_F_MASK        GENMASK(5, 0)
 
 enum cxl_decoder_type {
+	CXL_DECODER_INVALID,
 	CXL_DECODER_ACCEL = 2,
 	CXL_DECODER_EXPANDER = 3,
 };
-- 
2.39.2

