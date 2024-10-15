Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C411AB52D;
	Tue, 15 Oct 2024 06:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728975505; cv=none; b=MJcHsBV0TqliqpmHTJ+671pEUDs9ZS6Vfc/tJ0gkhILPlQRebfrHQM9aAm7ez0E82Cym4Mvk58HAr9dHl6X6xiuV7Dguen/7KCIxRZU70DzC9TnpmLN5AMgxAHu9HMGNv7LtG2BWi61OkLXB/olzB195JM/hz/bRzn6NJTHjhSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728975505; c=relaxed/simple;
	bh=nxme6BbZVCGNJxz3mRXMUQP2VLpNyphZdCA3VzVUPQc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L7VPho3U4uT21Khh5ZWq1RkT/BiBpXajQ4x8YNI7xhUxvbsVZ7vMoX+8tNNt+a5kmfuo3pF3Mxx5LjeKGQ2GetIjvFM+VXZztoLPFDLGK1j4iqZIhUR8Wzh1nwuaGklq4V8DWKmQBPw+jE6VxetnMunOjO4c/epEMk94Bk8iPEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i3+p+QDs; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i3+p+QDs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728975504; x=1760511504;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nxme6BbZVCGNJxz3mRXMUQP2VLpNyphZdCA3VzVUPQc=;
  b=i3+p+QDsIWhfX9IeIcu/bH/xoND17DwrawTFaZlZ0De57s74Bf2OSoh7
   4yBI7wmEhcHoer1ymxuCvm10F+Moo6x8vDiA+ALAA1dGkn4uXb3NCHpxN
   qaDORJ/e7VFyo1vylrAejraXAaxX4WmA4gSjM6xqgKfzhaDO+gV1FXenp
   bQjDowyTNrL0RyBRZ2BeYuhC5oN67Bknsp/Su7nM50gJnuj26VDrx9kUC
   BXtoZeKZ8esqXts1pBBEK22foEZM3RhiYH240C1feip6zbK9u9W6XqsHE
   qf45icF+ykGMsMvBvBktY4BW4Kgezzu7ijUPum8T9S5n6Hyf4I4FnLbjf
   A==;
X-CSE-ConnectionGUID: nn6aYHQjQ5mCX33bTAUkFA==
X-CSE-MsgGUID: jkZkg7JIQ+yHLuRI/Pq4tA==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="28447832"
X-IronPort-AV: E=Sophos;i="6.11,204,1725346800"; 
   d="scan'208";a="28447832"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 23:58:23 -0700
X-CSE-ConnectionGUID: bSY7ES7aSSWHbiWmxl3bow==
X-CSE-MsgGUID: DyRc54RxT82BNZh/yJmr6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,204,1725346800"; 
   d="scan'208";a="81776912"
Received: from yhuang6-mobl2.sh.intel.com ([10.238.3.32])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 23:58:20 -0700
From: Huang Ying <ying.huang@intel.com>
To: Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Huang Ying <ying.huang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Gregory Price <gourry@gourry.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Alejandro Lucero <alucerop@amd.com>,
	Ben Cheatham <benjamin.cheatham@amd.com>
Subject: [PATCH 2/5] cxl: Rename CXL_DECODER_HOSTONLYMEM/DEVMEM
Date: Tue, 15 Oct 2024 14:57:10 +0800
Message-Id: <20241015065713.308671-3-ying.huang@intel.com>
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

Previously, CXL type3 devices (memory expanders) use host only
coherence (HDM-H), while CXL type2 devices (accelerators) use dev
coherence (HDM-D).  So the name of the target device type of a cxl
decoder is CXL_DECODER_HOSTONLYMEM for type3 devices and
CXL_DECODER_DEVMEM for type2 devices.  However, this isn't true
anymore.  CXL type3 devices can use dev coherence + back
invalidation (HDM-DB) too.

To avoid confusion between the device type and coherence, the patch
renames CXL_DECODER_HOSTONLYMEM/DEVMEM to CXL_DECODER_EXPANDER/ACCEL.

We don't expect any functionality change in this patch.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Gregory Price <gourry@gourry.net>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Alejandro Lucero <alucerop@amd.com>
Cc: Ben Cheatham <benjamin.cheatham@amd.com>
---
 drivers/cxl/acpi.c           |  2 +-
 drivers/cxl/core/hdm.c       | 16 ++++++++--------
 drivers/cxl/core/port.c      |  6 +++---
 drivers/cxl/core/region.c    |  2 +-
 drivers/cxl/cxl.h            |  4 ++--
 tools/testing/cxl/test/cxl.c |  6 +++---
 6 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 3115f246273b..21486e471305 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -382,7 +382,7 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
 
 	cxld = &cxlrd->cxlsd.cxld;
 	cxld->flags = cfmws_to_decoder_flags(cfmws->restrictions);
-	cxld->target_type = CXL_DECODER_HOSTONLYMEM;
+	cxld->target_type = CXL_DECODER_EXPANDER;
 	cxld->hpa_range = (struct range) {
 		.start = cfmws->base_hpa,
 		.end = cfmws->base_hpa + cfmws->window_size - 1,
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 3df10517a327..57b54ecdb000 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -572,7 +572,7 @@ static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
 static void cxld_set_type(struct cxl_decoder *cxld, u32 *ctrl)
 {
 	u32p_replace_bits(ctrl,
-			  !!(cxld->target_type == CXL_DECODER_HOSTONLYMEM),
+			  !!(cxld->target_type == CXL_DECODER_EXPANDER),
 			  CXL_HDM_DECODER0_CTRL_HOSTONLY);
 }
 
@@ -771,7 +771,7 @@ static int cxl_setup_hdm_decoder_from_dvsec(
 	if (!len)
 		return -ENOENT;
 
-	cxld->target_type = CXL_DECODER_HOSTONLYMEM;
+	cxld->target_type = CXL_DECODER_EXPANDER;
 	cxld->commit = NULL;
 	cxld->reset = NULL;
 	cxld->hpa_range = info->dvsec_range[which];
@@ -847,9 +847,9 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 		if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
 			cxld->flags |= CXL_DECODER_F_LOCK;
 		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_HOSTONLY, ctrl))
-			cxld->target_type = CXL_DECODER_HOSTONLYMEM;
+			cxld->target_type = CXL_DECODER_EXPANDER;
 		else
-			cxld->target_type = CXL_DECODER_DEVMEM;
+			cxld->target_type = CXL_DECODER_ACCEL;
 
 		guard(rwsem_write)(&cxl_region_rwsem);
 		if (cxld->id != cxl_num_decoders_committed(port)) {
@@ -876,16 +876,16 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 			 * more precision.
 			 */
 			if (cxlds->type == CXL_DEVTYPE_CLASSMEM)
-				cxld->target_type = CXL_DECODER_HOSTONLYMEM;
+				cxld->target_type = CXL_DECODER_EXPANDER;
 			else
-				cxld->target_type = CXL_DECODER_DEVMEM;
+				cxld->target_type = CXL_DECODER_ACCEL;
 		} else {
 			/* To be overridden by region type at commit time */
-			cxld->target_type = CXL_DECODER_HOSTONLYMEM;
+			cxld->target_type = CXL_DECODER_EXPANDER;
 		}
 
 		if (!FIELD_GET(CXL_HDM_DECODER0_CTRL_HOSTONLY, ctrl) &&
-		    cxld->target_type == CXL_DECODER_HOSTONLYMEM) {
+		    cxld->target_type == CXL_DECODER_EXPANDER) {
 			ctrl |= CXL_HDM_DECODER0_CTRL_HOSTONLY;
 			writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(which));
 		}
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 35b6ad4ea0f9..e80b0af3d812 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -135,9 +135,9 @@ static ssize_t target_type_show(struct device *dev,
 	struct cxl_decoder *cxld = to_cxl_decoder(dev);
 
 	switch (cxld->target_type) {
-	case CXL_DECODER_DEVMEM:
+	case CXL_DECODER_ACCEL:
 		return sysfs_emit(buf, "accelerator\n");
-	case CXL_DECODER_HOSTONLYMEM:
+	case CXL_DECODER_EXPANDER:
 		return sysfs_emit(buf, "expander\n");
 	}
 	return -ENXIO;
@@ -1768,7 +1768,7 @@ static int cxl_decoder_init(struct cxl_port *port, struct cxl_decoder *cxld)
 	/* Pre initialize an "empty" decoder */
 	cxld->interleave_ways = 1;
 	cxld->interleave_granularity = PAGE_SIZE;
-	cxld->target_type = CXL_DECODER_HOSTONLYMEM;
+	cxld->target_type = CXL_DECODER_EXPANDER;
 	cxld->hpa_range = (struct range) {
 		.start = 0,
 		.end = -1,
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 7bb79f3f318c..036356bc4204 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2531,7 +2531,7 @@ static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
 		return ERR_PTR(-EBUSY);
 	}
 
-	return devm_cxl_add_region(cxlrd, id, mode, CXL_DECODER_HOSTONLYMEM);
+	return devm_cxl_add_region(cxlrd, id, mode, CXL_DECODER_EXPANDER);
 }
 
 static ssize_t create_pmem_region_store(struct device *dev,
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index a34e4256aa5f..f95101994238 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -324,8 +324,8 @@ resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
 #define CXL_DECODER_F_MASK        GENMASK(5, 0)
 
 enum cxl_decoder_type {
-	CXL_DECODER_DEVMEM = 2,
-	CXL_DECODER_HOSTONLYMEM = 3,
+	CXL_DECODER_ACCEL = 2,
+	CXL_DECODER_EXPANDER = 3,
 };
 
 /*
diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 3982d292d286..352a62c745c6 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -724,7 +724,7 @@ static void default_mock_decoder(struct cxl_decoder *cxld)
 
 	cxld->interleave_ways = 1;
 	cxld->interleave_granularity = 256;
-	cxld->target_type = CXL_DECODER_HOSTONLYMEM;
+	cxld->target_type = CXL_DECODER_EXPANDER;
 	cxld->commit = mock_decoder_commit;
 	cxld->reset = mock_decoder_reset;
 }
@@ -798,7 +798,7 @@ static void mock_init_hdm_decoder(struct cxl_decoder *cxld)
 
 	cxld->interleave_ways = 2;
 	eig_to_granularity(window->granularity, &cxld->interleave_granularity);
-	cxld->target_type = CXL_DECODER_HOSTONLYMEM;
+	cxld->target_type = CXL_DECODER_EXPANDER;
 	cxld->flags = CXL_DECODER_F_ENABLE;
 	cxled->state = CXL_DECODER_STATE_AUTO;
 	port->commit_end = cxld->id;
@@ -831,7 +831,7 @@ static void mock_init_hdm_decoder(struct cxl_decoder *cxld)
 		} else
 			cxlsd->target[0] = dport;
 		cxld = &cxlsd->cxld;
-		cxld->target_type = CXL_DECODER_HOSTONLYMEM;
+		cxld->target_type = CXL_DECODER_EXPANDER;
 		cxld->flags = CXL_DECODER_F_ENABLE;
 		iter->commit_end = 0;
 		/*
-- 
2.39.2

