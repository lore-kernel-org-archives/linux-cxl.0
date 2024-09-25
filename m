Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E68614A4D0;
	Wed, 25 Sep 2024 02:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727232437; cv=none; b=unGZJAesjKp30wl4VHaueiA7BNkIPrfdm52+2c7fF/k+NfXP0irIoBKxfJMavJB+zcm07fIwpvEwlEJKq4d30Sq7dCnPDsvZLuMNoHceU4rcEYnzXtmbBjAENi2OISo5D0X9HPo5k2aylDkdYQZMYGDxlhSQYW/9+CNbI4sIG9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727232437; c=relaxed/simple;
	bh=m4ookucFEI6FwnJQ40I6imhYRVPguRTN6n1jzM6Aa0s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pz/Yv04FYJ3aX299AlAts5cjTR02aCxtASffMz/V8mGdf8RMUUa3P7AyUmB5g0Ixz9iTZ+QdqrvozQetrahAI70e2n+xQTUGdqTFqftdnUEppAkAz1SDQnY4ORkXOf0PKeAiwKwDs+OErGWvccOs83H0nRK8V7co/vfedtpab4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MEpaEu88; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MEpaEu88"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727232436; x=1758768436;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m4ookucFEI6FwnJQ40I6imhYRVPguRTN6n1jzM6Aa0s=;
  b=MEpaEu88f/ll52LhdUxU1KKUz6RWCPBVWLB2OYkRdathoV1eb/TBo0AX
   3quqEesLq3tDvhs/1Ehl1Yd6jTzcFFyAl+/EDROhc3KwtcD0MZ2Bx/wTt
   UaGzwq0Fy49tKGkvVVdGsikkGVK8ArLs/qh4yYrzTnn43UO0sFJ2A8A6h
   WPWgcdRM3+X+HLmK//waB75cVG+pVjuMqt4JBKpBwXcylh+mX8o/pd6oF
   npuNCHRJBnUhqHiNSipht2l4GZ/pXezBnFoKK1/sl3dMC0WrLOxWmCrPH
   eV1uM4MGGHii49oOn1RnN++aPAJJyfZN3xNFixEF9WDwh1vOSHsKQVjKU
   Q==;
X-CSE-ConnectionGUID: cxZxsGuISFO19hkJxKye3A==
X-CSE-MsgGUID: EEYX+r9XSZmYMz8prswKbw==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="26132043"
X-IronPort-AV: E=Sophos;i="6.10,256,1719903600"; 
   d="scan'208";a="26132043"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 19:47:15 -0700
X-CSE-ConnectionGUID: qZl88NFBTcO8pjcd3NZHSw==
X-CSE-MsgGUID: zQoAT6HISImexiM+KQgT1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,256,1719903600"; 
   d="scan'208";a="102388982"
Received: from yhuang6-mobl2.sh.intel.com ([10.238.3.32])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 19:47:12 -0700
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
Subject: [RFC 2/5] cxl: Rename CXL_DECODER_HOSTONLYMEM/DEVMEM
Date: Wed, 25 Sep 2024 10:46:44 +0800
Message-Id: <20240925024647.46735-3-ying.huang@intel.com>
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

Previously, CXL type3 devices (memory expanders) use hostonly
coherence (HDM-H), while CXL type2 devices (accelerators) use dev
coherence (HDM-D).  So the target device type of a cxl decoder is
named as CXL_DECODER_HOSTONLYMEM for type3 devices and
CXL_DECODER_DEVMEM for type2 devices.  However, this isn't true
anymore.  CXL type3 devices can use dev coherence + back
invalidation (HDM-DB) too.

To avoid confusing between the device type and coherence, in this
patch, CXL_DECODER_HOSTONLYMEM/DEVMEM is renamed to
CXL_DECODER_EXPANDER/ACCEL.

No functionality change is expected in this patch.

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
index 67a8dc4d7868..47ad6d9329db 100644
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
index 21ad5f242875..8229e8a0072d 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2545,7 +2545,7 @@ static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
 		return ERR_PTR(-EBUSY);
 	}
 
-	return devm_cxl_add_region(cxlrd, id, mode, CXL_DECODER_HOSTONLYMEM);
+	return devm_cxl_add_region(cxlrd, id, mode, CXL_DECODER_EXPANDER);
 }
 
 static ssize_t create_pmem_region_store(struct device *dev,
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 28c8783d3c14..55b8c32f8d72 100644
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

