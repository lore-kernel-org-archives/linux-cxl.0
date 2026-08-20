Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35D3399CED
	for <linux-cxl@vger.kernel.org>; Thu, 20 Aug 2026 23:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787268697; cv=none; b=t9feuxpq+iIMNys4RFsKmgaX3E0uwdYzEg9WxsQmPOFQg2dV8CDxWPUaTT4flfAwOyaK8HjgeYifcky/dc6oGa1kfxmWWCOmR3UTecSnx5KgRlKQ1zIuzMvUtwlFh1kh8n215jJrrRYQItqR13ealzyAq/zVb6t851sQl2h7ifc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787268697; c=relaxed/simple;
	bh=8wD8rQ4Ufx6ZS51bNF/l1PO493Us3nebcU5pVC7k6eE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ryV7Iccw+Dz0jpDk+JSXQrGBXIvtC96MGN8UFdQF50X7jHOwWqw6D1U16Vp8eTVWKbqj34z7549yEuOwA0M2u/b5w1MrvjGWwwUrXP5WuvZ4YPxFmTWZ5nVhA7TEfNtfsLd9gqTo4O5YdbATzANwtDneovSyUnQ09CI7+1gixCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fmjb1zcj; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fmjb1zcj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787268694; x=1818804694;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8wD8rQ4Ufx6ZS51bNF/l1PO493Us3nebcU5pVC7k6eE=;
  b=Fmjb1zcjZ9RJj59DSL+hYJf9eJ8tAWOwKbS4z7+/pLD5lUfFW8tOmemR
   pxXKwOey0CqRqctCPh3E+H1WCSA+o5KIABMXoq8E0VbJ5vT0N7H/GrNML
   6DsoW4EWvt3igvZmTdHWOdrymsRif7MpYDoBYsjpIxa/zlONsAa2ejXb3
   hDfBNWNQMa9Iu/GXyEpRY9hG89Xl77IE8S6oR66Uxy2DJcqxR17G0zxM4
   hKwfSdSH3qB0WEThyGPYiXbvU3zBW9vxlMuIjQ+VPmxAaGPQcSOklcBmp
   NQlvLGUoPcsLikBYt9seZoN+1WQQqLB3mpVckWSdEYRuifr8xF/3mUtac
   w==;
X-CSE-ConnectionGUID: PqwgzgBpTjuhBFP8vFXtIw==
X-CSE-MsgGUID: ij2ZfxrETzK7HepZwXiAxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="98483445"
X-IronPort-AV: E=Sophos;i="6.25,234,1779174000"; 
   d="scan'208";a="98483445"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 16:31:34 -0700
X-CSE-ConnectionGUID: Wp7D6TlESeKwQYD/d/Yayg==
X-CSE-MsgGUID: 5bCJds2iTUuGF3Oj5/hRdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,234,1779174000"; 
   d="scan'208";a="261906014"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.221.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 16:31:34 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Robert Richter <rrichter@amd.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v4 5/6] cxl/test: Add a topology to test mixed-granularity regions
Date: Thu, 20 Aug 2026 16:31:23 -0700
Message-ID: <dcba06f559a891950910348418b415aa614f399f.1787255388.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1787255388.git.alison.schofield@intel.com>
References: <cover.1787255388.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a cxl_test topology for mixed-granularity region testing.

modprobe cxl_test mixed_gran_regions=1 creates three host bridges,
each with a passthrough host-bridge port above two switch levels
and four endpoints, for twelve endpoints total.

Two CFMWS windows are added:
1) A 2-way window at 4K gran over two host bridges, that hosts 8-way
regions at 1K.
2) A 3-way window at 512 gran over three host bridges, that hosts
6-way regions at 256.

Both windows also host the same-granularity regions their ways allow.

Register every mock device through cxl_mock_platform_device_add() so
the mock array is populated before platform_device_add(), matching the
ordering the rest of cxl_test relies on to avoid the endpoint-probe
race in commit d90f236f8b9e ("cxl/test: Update mock dev array before
calling platform_device_add()").

NULL-check the legacy topology arrays, which are left empty when
mixed_gran_regions=1 selects the new topology.

The default and existing special module params are unaffected.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 tools/testing/cxl/test/cxl.c | 496 ++++++++++++++++++++++++++++++++---
 1 file changed, 458 insertions(+), 38 deletions(-)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index ef92dd35e030..0ec9b402e1af 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -17,6 +17,7 @@
 static int interleave_arithmetic;
 static bool extended_linear_cache;
 static bool fail_autoassemble;
+static bool mixed_gran_regions;
 
 #define FAKE_QTG_ID	42
 
@@ -26,7 +27,26 @@ static bool fail_autoassemble;
 #define NR_CXL_ROOT_PORTS 2
 #define NR_CXL_SWITCH_PORTS 2
 #define NR_CXL_PORT_DECODERS 8
-#define NR_BRIDGES (NR_CXL_HOST_BRIDGES + NR_CXL_SINGLE_HOST + NR_CXL_RCH)
+
+/*
+ * mixed_gran_regions=1: three host bridges, two switch levels, and
+ * twelve endpoints for power-of-2 and 3-way-family region layouts.
+ */
+#define NR_CXL_MIX_GRAN_HB 3
+#define NR_CXL_MIX_GRAN_ROOT_PORTS NR_CXL_MIX_GRAN_HB	/* 1 per HB */
+#define NR_CXL_MIX_GRAN_L1_DPORTS  (NR_CXL_MIX_GRAN_HB * 2)
+#define NR_CXL_MIX_GRAN_L2_SWITCHES NR_CXL_MIX_GRAN_L1_DPORTS
+#define NR_CXL_MIX_GRAN_L2_DPORTS  (NR_CXL_MIX_GRAN_L2_SWITCHES * 2)
+
+#define NR_DEFAULT_BRIDGES \
+	(NR_CXL_HOST_BRIDGES + NR_CXL_SINGLE_HOST + NR_CXL_RCH)
+#define NR_BRIDGES (NR_DEFAULT_BRIDGES + NR_CXL_MIX_GRAN_HB)
+
+/* CHBS index ranges within mock_cedt.chbs[] */
+#define CHBS_DEFAULT_START 0
+#define CHBS_DEFAULT_END (NR_DEFAULT_BRIDGES - 1)
+#define CHBS_MIX_GRAN_START NR_DEFAULT_BRIDGES
+#define CHBS_MIX_GRAN_END (NR_BRIDGES - 1)
 
 #define MOCK_AUTO_REGION_SIZE_DEFAULT SZ_512M
 static int mock_auto_region_size = MOCK_AUTO_REGION_SIZE_DEFAULT;
@@ -52,6 +72,14 @@ struct platform_device *cxl_mem_single[NR_MEM_SINGLE];
 static struct platform_device *cxl_rch[NR_CXL_RCH];
 static struct platform_device *cxl_rcd[NR_CXL_RCH];
 
+static struct platform_device *cxl_mix_gran_hb[NR_CXL_MIX_GRAN_HB];
+static struct platform_device *cxl_mix_gran_root_port[NR_CXL_MIX_GRAN_ROOT_PORTS];
+static struct platform_device *cxl_mix_gran_l1_uport[NR_CXL_MIX_GRAN_ROOT_PORTS];
+static struct platform_device *cxl_mix_gran_l1_dport[NR_CXL_MIX_GRAN_L1_DPORTS];
+static struct platform_device *cxl_mix_gran_l2_uport[NR_CXL_MIX_GRAN_L2_SWITCHES];
+static struct platform_device *cxl_mix_gran_l2_dport[NR_CXL_MIX_GRAN_L2_DPORTS];
+static struct platform_device *cxl_mem_mix_gran[NR_CXL_MIX_GRAN_L2_DPORTS];
+
 /*
  * Decoder registry
  *
@@ -115,6 +143,19 @@ static struct acpi_device host_bridge[NR_BRIDGES] = {
 		.handle = &host_bridge[3],
 		.pnp.unique_id = "3",
 	},
+	/* Dedicated mixed-granularity topology */
+	[4] = {
+		.handle = &host_bridge[4],
+		.pnp.unique_id = "4",
+	},
+	[5] = {
+		.handle = &host_bridge[5],
+		.pnp.unique_id = "5",
+	},
+	[6] = {
+		.handle = &host_bridge[6],
+		.pnp.unique_id = "6",
+	},
 };
 
 static bool is_mock_dev(struct device *dev)
@@ -122,15 +163,18 @@ static bool is_mock_dev(struct device *dev)
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(cxl_mem); i++)
-		if (dev == &cxl_mem[i]->dev)
+		if (cxl_mem[i] && dev == &cxl_mem[i]->dev)
 			return true;
 	for (i = 0; i < ARRAY_SIZE(cxl_mem_single); i++)
-		if (dev == &cxl_mem_single[i]->dev)
+		if (cxl_mem_single[i] && dev == &cxl_mem_single[i]->dev)
 			return true;
 	for (i = 0; i < ARRAY_SIZE(cxl_rcd); i++)
-		if (dev == &cxl_rcd[i]->dev)
+		if (cxl_rcd[i] && dev == &cxl_rcd[i]->dev)
 			return true;
-	if (dev == &cxl_acpi->dev)
+	for (i = 0; i < ARRAY_SIZE(cxl_mem_mix_gran); i++)
+		if (cxl_mem_mix_gran[i] && dev == &cxl_mem_mix_gran[i]->dev)
+			return true;
+	if (cxl_acpi && dev == &cxl_acpi->dev)
 		return true;
 	return false;
 }
@@ -188,6 +232,14 @@ static struct {
 		struct acpi_cedt_cfmws cfmws;
 		u32 target[3];
 	} cfmws8;
+	struct {
+		struct acpi_cedt_cfmws cfmws;
+		u32 target[2];
+	} cfmws9;
+	struct {
+		struct acpi_cedt_cfmws cfmws;
+		u32 target[3];
+	} cfmws10;
 	struct {
 		struct acpi_cedt_cxims cxims;
 		u64 xormap_list[2];
@@ -232,6 +284,31 @@ static struct {
 		.uid = 3,
 		.cxl_version = ACPI_CEDT_CHBS_VERSION_CXL11,
 	},
+	/* Dedicated mixed-granularity topology */
+	.chbs[4] = {
+		.header = {
+			.type = ACPI_CEDT_TYPE_CHBS,
+			.length = sizeof(mock_cedt.chbs[0]),
+		},
+		.uid = 4,
+		.cxl_version = ACPI_CEDT_CHBS_VERSION_CXL20,
+	},
+	.chbs[5] = {
+		.header = {
+			.type = ACPI_CEDT_TYPE_CHBS,
+			.length = sizeof(mock_cedt.chbs[0]),
+		},
+		.uid = 5,
+		.cxl_version = ACPI_CEDT_CHBS_VERSION_CXL20,
+	},
+	.chbs[6] = {
+		.header = {
+			.type = ACPI_CEDT_TYPE_CHBS,
+			.length = sizeof(mock_cedt.chbs[0]),
+		},
+		.uid = 6,
+		.cxl_version = ACPI_CEDT_CHBS_VERSION_CXL20,
+	},
 	.cfmws0 = {
 		.cfmws = {
 			.header = {
@@ -371,6 +448,36 @@ static struct {
 		},
 		.target = { 0, 1, 2, },
 	},
+	.cfmws9 = {
+		.cfmws = {
+			.header = {
+				.type = ACPI_CEDT_TYPE_CFMWS,
+				.length = sizeof(mock_cedt.cfmws9),
+			},
+			.interleave_ways = 1,
+			.granularity = 4,
+			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
+					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
+			.qtg_id = FAKE_QTG_ID,
+			.window_size = SZ_512M * 4UL,
+		},
+		.target = { 4, 5, },
+	},
+	.cfmws10 = {
+		.cfmws = {
+			.header = {
+				.type = ACPI_CEDT_TYPE_CFMWS,
+				.length = sizeof(mock_cedt.cfmws10),
+			},
+			.interleave_ways = 8,
+			.granularity = 1,
+			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
+					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
+			.qtg_id = FAKE_QTG_ID,
+			.window_size = SZ_512M * 6UL,
+		},
+		.target = { 4, 5, 6, },
+	},
 	.cxims0 = {
 		.cxims = {
 			.header = {
@@ -395,6 +502,9 @@ struct acpi_cedt_cfmws *mock_cfmws[] = {
 	[6] = &mock_cedt.cfmws6.cfmws,
 	[7] = &mock_cedt.cfmws7.cfmws,
 	[8] = &mock_cedt.cfmws8.cfmws,
+	/* Dedicated mixed-granularity topology */
+	[9] = &mock_cedt.cfmws9.cfmws,
+	[10] = &mock_cedt.cfmws10.cfmws,
 };
 
 static int cfmws_start;
@@ -403,6 +513,8 @@ static int cfmws_end;
 #define CFMWS_MOD_ARRAY_END   5
 #define CFMWS_XOR_ARRAY_START 6
 #define CFMWS_XOR_ARRAY_END   8
+#define CFMWS_MIX_GRAN_ARRAY_START 9
+#define CFMWS_MIX_GRAN_ARRAY_END   10
 
 struct acpi_cedt_cxims *mock_cxims[1] = {
 	[0] = &mock_cedt.cxims0.cxims,
@@ -479,9 +591,18 @@ static void cfmws_elc_update(struct acpi_cedt_cfmws *window, int index)
 static int populate_cedt(void)
 {
 	struct cxl_mock_res *res;
+	int chbs_lo, chbs_hi;
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(mock_cedt.chbs); i++) {
+	if (mixed_gran_regions) {
+		chbs_lo = CHBS_MIX_GRAN_START;
+		chbs_hi = CHBS_MIX_GRAN_END;
+	} else {
+		chbs_lo = CHBS_DEFAULT_START;
+		chbs_hi = CHBS_DEFAULT_END;
+	}
+
+	for (i = chbs_lo; i <= chbs_hi; i++) {
 		struct acpi_cedt_chbs *chbs = &mock_cedt.chbs[i];
 		resource_size_t size;
 
@@ -538,12 +659,23 @@ static int mock_acpi_table_parse_cedt(enum acpi_cedt_type id,
 	if (!is_mock_port(dev) && !is_mock_dev(dev))
 		return acpi_table_parse_cedt(id, handler_arg, arg);
 
-	if (id == ACPI_CEDT_TYPE_CHBS)
-		for (i = 0; i < ARRAY_SIZE(mock_cedt.chbs); i++) {
+	if (id == ACPI_CEDT_TYPE_CHBS) {
+		int chbs_lo, chbs_hi;
+
+		if (mixed_gran_regions) {
+			chbs_lo = CHBS_MIX_GRAN_START;
+			chbs_hi = CHBS_MIX_GRAN_END;
+		} else {
+			chbs_lo = CHBS_DEFAULT_START;
+			chbs_hi = CHBS_DEFAULT_END;
+		}
+
+		for (i = chbs_lo; i <= chbs_hi; i++) {
 			h = (union acpi_subtable_headers *)&mock_cedt.chbs[i];
 			end = (unsigned long)&mock_cedt.chbs[i + 1];
 			handler_arg(h, arg, end);
 		}
+	}
 
 	if (id == ACPI_CEDT_TYPE_CFMWS)
 		for (i = cfmws_start; i <= cfmws_end; i++) {
@@ -567,13 +699,16 @@ static bool is_mock_bridge(struct device *dev)
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(cxl_host_bridge); i++)
-		if (dev == &cxl_host_bridge[i]->dev)
+		if (cxl_host_bridge[i] && dev == &cxl_host_bridge[i]->dev)
 			return true;
 	for (i = 0; i < ARRAY_SIZE(cxl_hb_single); i++)
-		if (dev == &cxl_hb_single[i]->dev)
+		if (cxl_hb_single[i] && dev == &cxl_hb_single[i]->dev)
 			return true;
 	for (i = 0; i < ARRAY_SIZE(cxl_rch); i++)
-		if (dev == &cxl_rch[i]->dev)
+		if (cxl_rch[i] && dev == &cxl_rch[i]->dev)
+			return true;
+	for (i = 0; i < ARRAY_SIZE(cxl_mix_gran_hb); i++)
+		if (cxl_mix_gran_hb[i] && dev == &cxl_mix_gran_hb[i]->dev)
 			return true;
 
 	return false;
@@ -587,27 +722,52 @@ static bool is_mock_port(struct device *dev)
 		return true;
 
 	for (i = 0; i < ARRAY_SIZE(cxl_root_port); i++)
-		if (dev == &cxl_root_port[i]->dev)
+		if (cxl_root_port[i] && dev == &cxl_root_port[i]->dev)
 			return true;
 
 	for (i = 0; i < ARRAY_SIZE(cxl_switch_uport); i++)
-		if (dev == &cxl_switch_uport[i]->dev)
+		if (cxl_switch_uport[i] && dev == &cxl_switch_uport[i]->dev)
 			return true;
 
 	for (i = 0; i < ARRAY_SIZE(cxl_switch_dport); i++)
-		if (dev == &cxl_switch_dport[i]->dev)
+		if (cxl_switch_dport[i] && dev == &cxl_switch_dport[i]->dev)
 			return true;
 
 	for (i = 0; i < ARRAY_SIZE(cxl_root_single); i++)
-		if (dev == &cxl_root_single[i]->dev)
+		if (cxl_root_single[i] && dev == &cxl_root_single[i]->dev)
 			return true;
 
 	for (i = 0; i < ARRAY_SIZE(cxl_swu_single); i++)
-		if (dev == &cxl_swu_single[i]->dev)
+		if (cxl_swu_single[i] && dev == &cxl_swu_single[i]->dev)
 			return true;
 
 	for (i = 0; i < ARRAY_SIZE(cxl_swd_single); i++)
-		if (dev == &cxl_swd_single[i]->dev)
+		if (cxl_swd_single[i] && dev == &cxl_swd_single[i]->dev)
+			return true;
+
+	for (i = 0; i < ARRAY_SIZE(cxl_mix_gran_root_port); i++)
+		if (cxl_mix_gran_root_port[i] &&
+		    dev == &cxl_mix_gran_root_port[i]->dev)
+			return true;
+
+	for (i = 0; i < ARRAY_SIZE(cxl_mix_gran_l1_uport); i++)
+		if (cxl_mix_gran_l1_uport[i] &&
+		    dev == &cxl_mix_gran_l1_uport[i]->dev)
+			return true;
+
+	for (i = 0; i < ARRAY_SIZE(cxl_mix_gran_l1_dport); i++)
+		if (cxl_mix_gran_l1_dport[i] &&
+		    dev == &cxl_mix_gran_l1_dport[i]->dev)
+			return true;
+
+	for (i = 0; i < ARRAY_SIZE(cxl_mix_gran_l2_uport); i++)
+		if (cxl_mix_gran_l2_uport[i] &&
+		    dev == &cxl_mix_gran_l2_uport[i]->dev)
+			return true;
+
+	for (i = 0; i < ARRAY_SIZE(cxl_mix_gran_l2_dport); i++)
+		if (cxl_mix_gran_l2_dport[i] &&
+		    dev == &cxl_mix_gran_l2_dport[i]->dev)
 			return true;
 
 	if (is_cxl_memdev(dev))
@@ -678,7 +838,15 @@ static struct acpi_pci_root mock_pci_root[ARRAY_SIZE(mock_pci_bus)] = {
 	[3] = {
 		.bus = &mock_pci_bus[3],
 	},
-
+	[4] = {
+		.bus = &mock_pci_bus[4],
+	},
+	[5] = {
+		.bus = &mock_pci_bus[5],
+	},
+	[6] = {
+		.bus = &mock_pci_bus[6],
+	},
 };
 
 static bool is_mock_bus(struct pci_bus *bus)
@@ -1099,7 +1267,8 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
 		/* check is endpoint is attach to host-bridge0 */
 		port = cxled_to_port(cxled);
 		do {
-			if (port->uport_dev == &cxl_host_bridge[0]->dev) {
+			if (cxl_host_bridge[0] &&
+			    port->uport_dev == &cxl_host_bridge[0]->dev) {
 				hb0 = true;
 				break;
 			}
@@ -1242,6 +1411,8 @@ static int mock_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
 
 	if (is_cxl_endpoint(port))
 		target_count = 0;
+	else if (mixed_gran_regions && is_cxl_root(parent_port))
+		target_count = NR_CXL_MIX_GRAN_ROOT_PORTS / NR_CXL_MIX_GRAN_HB;
 	else if (is_cxl_root(parent_port))
 		target_count = NR_CXL_ROOT_PORTS;
 	else
@@ -1341,6 +1512,27 @@ static int get_port_array(struct cxl_port *port,
 	struct platform_device **array;
 	int array_size;
 
+	if (mixed_gran_regions) {
+		if (port->depth == 1) {
+			array_size = ARRAY_SIZE(cxl_mix_gran_root_port);
+			array = cxl_mix_gran_root_port;
+		} else if (port->depth == 2) {
+			array_size = ARRAY_SIZE(cxl_mix_gran_l1_dport);
+			array = cxl_mix_gran_l1_dport;
+		} else if (port->depth == 3) {
+			array_size = ARRAY_SIZE(cxl_mix_gran_l2_dport);
+			array = cxl_mix_gran_l2_dport;
+		} else {
+			dev_WARN_ONCE(&port->dev, 1, "unexpected depth %d\n",
+				      port->depth);
+			return -ENXIO;
+		}
+
+		*port_array = array;
+		*port_array_size = array_size;
+		return 0;
+	}
+
 	if (port->depth == 1) {
 		if (is_multi_bridge(port->uport_dev)) {
 			array_size = ARRAY_SIZE(cxl_root_port);
@@ -1724,10 +1916,182 @@ static void cxl_single_topo_exit(void)
 	}
 }
 
+#define MIX_GRAN_RP_ID_BASE	(NR_MULTI_ROOT + NR_CXL_SINGLE_HOST)
+#define MIX_GRAN_L1U_ID_BASE	MIX_GRAN_RP_ID_BASE
+#define MIX_GRAN_L1D_ID_BASE	(NR_MEM_MULTI + NR_MEM_SINGLE)
+#define MIX_GRAN_L2U_ID_BASE	MIX_GRAN_L1D_ID_BASE
+#define MIX_GRAN_L2D_ID_BASE	\
+	(MIX_GRAN_L1D_ID_BASE + NR_CXL_MIX_GRAN_L1_DPORTS)
+#define MIX_GRAN_MEM_ID_BASE	(NR_MEM_MULTI + NR_MEM_SINGLE + NR_CXL_RCH)
+
+static void cxl_mix_gran_topo_exit(void)
+{
+	int i;
+
+	for (i = NR_CXL_MIX_GRAN_L2_DPORTS - 1; i >= 0; i--) {
+		platform_device_unregister(cxl_mix_gran_l2_dport[i]);
+		cxl_mix_gran_l2_dport[i] = NULL;
+	}
+	for (i = NR_CXL_MIX_GRAN_L2_SWITCHES - 1; i >= 0; i--) {
+		platform_device_unregister(cxl_mix_gran_l2_uport[i]);
+		cxl_mix_gran_l2_uport[i] = NULL;
+	}
+	for (i = NR_CXL_MIX_GRAN_L1_DPORTS - 1; i >= 0; i--) {
+		platform_device_unregister(cxl_mix_gran_l1_dport[i]);
+		cxl_mix_gran_l1_dport[i] = NULL;
+	}
+	for (i = NR_CXL_MIX_GRAN_ROOT_PORTS - 1; i >= 0; i--) {
+		platform_device_unregister(cxl_mix_gran_l1_uport[i]);
+		cxl_mix_gran_l1_uport[i] = NULL;
+	}
+	for (i = NR_CXL_MIX_GRAN_ROOT_PORTS - 1; i >= 0; i--) {
+		platform_device_unregister(cxl_mix_gran_root_port[i]);
+		cxl_mix_gran_root_port[i] = NULL;
+	}
+	for (i = NR_CXL_MIX_GRAN_HB - 1; i >= 0; i--) {
+		struct platform_device *pdev = cxl_mix_gran_hb[i];
+
+		if (!pdev)
+			continue;
+		sysfs_remove_link(&pdev->dev.kobj, "physical_node");
+		platform_device_unregister(pdev);
+		cxl_mix_gran_hb[i] = NULL;
+	}
+}
+
+static __init int cxl_mix_gran_topo_init(void)
+{
+	int i, rc;
+
+	for (i = 0; i < NR_CXL_MIX_GRAN_HB; i++) {
+		struct acpi_device *adev = &host_bridge[NR_DEFAULT_BRIDGES + i];
+		struct platform_device *pdev;
+
+		pdev = platform_device_alloc("cxl_host_bridge",
+					     NR_DEFAULT_BRIDGES + i);
+		if (!pdev) {
+			rc = -ENOMEM;
+			goto err;
+		}
+
+		mock_companion(adev, &pdev->dev);
+		rc = cxl_mock_platform_device_add(pdev, &cxl_mix_gran_hb[i]);
+		if (rc)
+			goto err;
+
+		mock_pci_bus[NR_DEFAULT_BRIDGES + i].bridge = &pdev->dev;
+		rc = sysfs_create_link(&pdev->dev.kobj, &pdev->dev.kobj,
+				       "physical_node");
+		if (rc)
+			goto err;
+	}
+
+	/* 1 root port per host bridge */
+	for (i = 0; i < NR_CXL_MIX_GRAN_ROOT_PORTS; i++) {
+		struct platform_device *bridge = cxl_mix_gran_hb[i];
+		struct platform_device *pdev;
+
+		pdev = platform_device_alloc("cxl_root_port",
+					     MIX_GRAN_RP_ID_BASE + i);
+		if (!pdev) {
+			rc = -ENOMEM;
+			goto err;
+		}
+		pdev->dev.parent = &bridge->dev;
+
+		rc = cxl_mock_platform_device_add(pdev, &cxl_mix_gran_root_port[i]);
+		if (rc)
+			goto err;
+	}
+
+	/* L1 switch uport under each root port */
+	for (i = 0; i < NR_CXL_MIX_GRAN_ROOT_PORTS; i++) {
+		struct platform_device *pdev;
+
+		pdev = platform_device_alloc("cxl_switch_uport",
+					     MIX_GRAN_L1U_ID_BASE + i);
+		if (!pdev) {
+			rc = -ENOMEM;
+			goto err;
+		}
+		pdev->dev.parent = &cxl_mix_gran_root_port[i]->dev;
+
+		rc = cxl_mock_platform_device_add(pdev, &cxl_mix_gran_l1_uport[i]);
+		if (rc)
+			goto err;
+	}
+
+	/* 2 L1 dports per L1 switch */
+	for (i = 0; i < NR_CXL_MIX_GRAN_L1_DPORTS; i++) {
+		struct platform_device *uport =
+			cxl_mix_gran_l1_uport[i / NR_CXL_SWITCH_PORTS];
+		struct platform_device *pdev;
+
+		pdev = platform_device_alloc("cxl_switch_dport",
+					     MIX_GRAN_L1D_ID_BASE + i);
+		if (!pdev) {
+			rc = -ENOMEM;
+			goto err;
+		}
+		pdev->dev.parent = &uport->dev;
+
+		rc = cxl_mock_platform_device_add(pdev, &cxl_mix_gran_l1_dport[i]);
+		if (rc)
+			goto err;
+	}
+
+	/* L2 switch uport under each L1 dport */
+	for (i = 0; i < NR_CXL_MIX_GRAN_L2_SWITCHES; i++) {
+		struct platform_device *pdev;
+
+		pdev = platform_device_alloc("cxl_switch_uport",
+					     MIX_GRAN_L2U_ID_BASE + i);
+		if (!pdev) {
+			rc = -ENOMEM;
+			goto err;
+		}
+		pdev->dev.parent = &cxl_mix_gran_l1_dport[i]->dev;
+
+		rc = cxl_mock_platform_device_add(pdev, &cxl_mix_gran_l2_uport[i]);
+		if (rc)
+			goto err;
+	}
+
+	/* 2 L2 dports per L2 switch */
+	for (i = 0; i < NR_CXL_MIX_GRAN_L2_DPORTS; i++) {
+		struct platform_device *uport =
+			cxl_mix_gran_l2_uport[i / NR_CXL_SWITCH_PORTS];
+		struct platform_device *pdev;
+
+		pdev = platform_device_alloc("cxl_switch_dport",
+					     MIX_GRAN_L2D_ID_BASE + i);
+		if (!pdev) {
+			rc = -ENOMEM;
+			goto err;
+		}
+		pdev->dev.parent = &uport->dev;
+
+		rc = cxl_mock_platform_device_add(pdev, &cxl_mix_gran_l2_dport[i]);
+		if (rc)
+			goto err;
+	}
+
+	return 0;
+err:
+	cxl_mix_gran_topo_exit();
+	return rc;
+}
+
 static void cxl_mem_exit(void)
 {
 	int i;
 
+	if (mixed_gran_regions) {
+		for (i = NR_CXL_MIX_GRAN_L2_DPORTS - 1; i >= 0; i--)
+			platform_device_unregister(cxl_mem_mix_gran[i]);
+		return;
+	}
+
 	for (i = ARRAY_SIZE(cxl_rcd) - 1; i >= 0; i--)
 		platform_device_unregister(cxl_rcd[i]);
 	for (i = ARRAY_SIZE(cxl_mem_single) - 1; i >= 0; i--)
@@ -1736,10 +2100,42 @@ static void cxl_mem_exit(void)
 		platform_device_unregister(cxl_mem[i]);
 }
 
+static int cxl_mem_mix_gran_init(void)
+{
+	int i, rc;
+
+	for (i = 0; i < NR_CXL_MIX_GRAN_L2_DPORTS; i++) {
+		struct platform_device *dport = cxl_mix_gran_l2_dport[i];
+		struct platform_device *pdev;
+
+		pdev = platform_device_alloc("cxl_mem",
+					     MIX_GRAN_MEM_ID_BASE + i);
+		if (!pdev) {
+			rc = -ENOMEM;
+			goto err;
+		}
+		pdev->dev.parent = &dport->dev;
+		set_dev_node(&pdev->dev, i % 2);
+
+		rc = cxl_mock_platform_device_add(pdev, &cxl_mem_mix_gran[i]);
+		if (rc)
+			goto err;
+	}
+
+	return 0;
+err:
+	for (i = NR_CXL_MIX_GRAN_L2_DPORTS - 1; i >= 0; i--)
+		platform_device_unregister(cxl_mem_mix_gran[i]);
+	return rc;
+}
+
 static int cxl_mem_init(void)
 {
 	int i, rc;
 
+	if (mixed_gran_regions)
+		return cxl_mem_mix_gran_init();
+
 	for (i = 0; i < ARRAY_SIZE(cxl_mem); i++) {
 		struct platform_device *dport = cxl_switch_dport[i];
 		struct platform_device *pdev;
@@ -1860,7 +2256,10 @@ static __init int cxl_test_init(void)
 	if (rc)
 		goto err_gen_pool_add;
 
-	if (interleave_arithmetic == 1) {
+	if (mixed_gran_regions) {
+		cfmws_start = CFMWS_MIX_GRAN_ARRAY_START;
+		cfmws_end = CFMWS_MIX_GRAN_ARRAY_END;
+	} else if (interleave_arithmetic == 1) {
 		cfmws_start = CFMWS_XOR_ARRAY_START;
 		cfmws_end = CFMWS_XOR_ARRAY_END;
 	} else {
@@ -1872,6 +2271,13 @@ static __init int cxl_test_init(void)
 	if (rc)
 		goto err_populate;
 
+	if (mixed_gran_regions) {
+		rc = cxl_mix_gran_topo_init();
+		if (rc)
+			goto err_populate;
+		goto topo_done;
+	}
+
 	for (i = 0; i < ARRAY_SIZE(cxl_host_bridge); i++) {
 		struct acpi_device *adev = &host_bridge[i];
 		struct platform_device *pdev;
@@ -1945,9 +2351,12 @@ static __init int cxl_test_init(void)
 	if (rc)
 		goto err_single;
 
+topo_done:
 	cxl_acpi = platform_device_alloc("cxl_acpi", 0);
-	if (!cxl_acpi)
-		goto err_rch;
+	if (!cxl_acpi) {
+		rc = -ENOMEM;
+		goto err_topo;
+	}
 
 	mock_companion(&acpi0017_mock, &cxl_acpi->dev);
 	acpi0017_mock.dev.bus = &platform_bus_type;
@@ -1955,7 +2364,7 @@ static __init int cxl_test_init(void)
 
 	rc = cxl_mock_platform_device_add(cxl_acpi, NULL);
 	if (rc)
-		goto err_rch;
+		goto err_topo;
 
 	rc = cxl_mem_init();
 	if (rc)
@@ -1971,7 +2380,11 @@ static __init int cxl_test_init(void)
 	cxl_mem_exit();
 err_root:
 	platform_device_unregister(cxl_acpi);
-err_rch:
+err_topo:
+	if (mixed_gran_regions) {
+		cxl_mix_gran_topo_exit();
+		goto err_populate;
+	}
 	cxl_rch_topo_exit();
 err_single:
 	cxl_single_topo_exit();
@@ -2020,21 +2433,25 @@ static __exit void cxl_test_exit(void)
 	hmem_test_exit();
 	cxl_mem_exit();
 	platform_device_unregister(cxl_acpi);
-	cxl_rch_topo_exit();
-	cxl_single_topo_exit();
-	for (i = ARRAY_SIZE(cxl_switch_dport) - 1; i >= 0; i--)
-		platform_device_unregister(cxl_switch_dport[i]);
-	for (i = ARRAY_SIZE(cxl_switch_uport) - 1; i >= 0; i--)
-		platform_device_unregister(cxl_switch_uport[i]);
-	for (i = ARRAY_SIZE(cxl_root_port) - 1; i >= 0; i--)
-		platform_device_unregister(cxl_root_port[i]);
-	for (i = ARRAY_SIZE(cxl_host_bridge) - 1; i >= 0; i--) {
-		struct platform_device *pdev = cxl_host_bridge[i];
+	if (mixed_gran_regions) {
+		cxl_mix_gran_topo_exit();
+	} else {
+		cxl_rch_topo_exit();
+		cxl_single_topo_exit();
+		for (i = ARRAY_SIZE(cxl_switch_dport) - 1; i >= 0; i--)
+			platform_device_unregister(cxl_switch_dport[i]);
+		for (i = ARRAY_SIZE(cxl_switch_uport) - 1; i >= 0; i--)
+			platform_device_unregister(cxl_switch_uport[i]);
+		for (i = ARRAY_SIZE(cxl_root_port) - 1; i >= 0; i--)
+			platform_device_unregister(cxl_root_port[i]);
+		for (i = ARRAY_SIZE(cxl_host_bridge) - 1; i >= 0; i--) {
+			struct platform_device *pdev = cxl_host_bridge[i];
 
-		if (!pdev)
-			continue;
-		sysfs_remove_link(&pdev->dev.kobj, "physical_node");
-		platform_device_unregister(cxl_host_bridge[i]);
+			if (!pdev)
+				continue;
+			sysfs_remove_link(&pdev->dev.kobj, "physical_node");
+			platform_device_unregister(cxl_host_bridge[i]);
+		}
 	}
 	depopulate_all_mock_resources();
 	gen_pool_destroy(cxl_mock_pool);
@@ -2049,6 +2466,9 @@ module_param(extended_linear_cache, bool, 0444);
 MODULE_PARM_DESC(extended_linear_cache, "Enable extended linear cache support");
 module_param(fail_autoassemble, bool, 0444);
 MODULE_PARM_DESC(fail_autoassemble, "Simulate missing member of an auto-region");
+module_param(mixed_gran_regions, bool, 0444);
+MODULE_PARM_DESC(mixed_gran_regions,
+		 "Topology supporting mixed granularity regions");
 module_init(cxl_test_init);
 module_exit(cxl_test_exit);
 MODULE_LICENSE("GPL v2");
-- 
2.37.3

