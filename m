Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FA1355F57
	for <linux-cxl@vger.kernel.org>; Thu,  3 Sep 2026 23:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788477858; cv=none; b=UxS6ZlWpT6Xx2iwrIcsnFgKUTVqGnLH70SnbDJs3wK7n+Gjrg/+wRzC+QQQJMPjKB6CPeEinbo/wb0C7QqDYA8lN2ZdcQi3BJnPOAqTdjkyBv3qM7VgMvgp41wDtpuPLm0EV8QV/7tRtP22TrWCXTboCZu4dXma0GEyPWlNMbCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788477858; c=relaxed/simple;
	bh=9bIYWYJ2a/ECyf3K+oHpYjpMrJhXj3dcXW4KgfsGsPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HOGDKTiEuIFpqTXmWox/vGTldz1L3iWtElbEJ+RUaZDwfH9hcy6ZEOXbF/ndvM7u0NVjeqzFkJpZVCzZS+XXjRV8QK6bG3XkjMpEfHUqB8FPN55R1S6BZvYBmQsD1WJy6jqZLCV5sefE/fWvNnLkSjBguP1PRXhOSG+SCoWAZqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cMuvc6+y; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cMuvc6+y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788477855; x=1820013855;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9bIYWYJ2a/ECyf3K+oHpYjpMrJhXj3dcXW4KgfsGsPE=;
  b=cMuvc6+ysjZp1pKUJKh9GFXO90Mi1HcKwjLHvB2n3AWn5YvwJZqTklHO
   mXbu5HqiHrIdY+qskkjmmyig9InPV61hTw0ZDXnse6ng1BHYXSnVKGxRi
   eYk+tSrQbhEJyLoj5LEz1Rv6d5OHyWB+7kEZtYhmzljJR8dqbzQWu22bP
   YRPGX5HQObrrZXilP8u7upE5kiNM7LxlZtF5ZLlh6jy626QMumuV5HwnY
   zrJ64ua7EidLtqn+r3OjJTgJJYLNtvNYFdc+8NQCMpK5MRLBebR/6za5L
   4RpyjybdyasFfop41+eoiVbeQocz3E+PkrTsFbIxvwdBB3ZTSOXwct7oE
   A==;
X-CSE-ConnectionGUID: Dn01/ORMQUaJiF7ecsA0Ag==
X-CSE-MsgGUID: eqgXlZTaQFKWVzFf0hU34A==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="92847706"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="92847706"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 16:24:15 -0700
X-CSE-ConnectionGUID: f+QsgBQSTYmOEiYBAaNTDA==
X-CSE-MsgGUID: jIvVwjbbScu3h9fjUEZ+Ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="268129525"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.221.10])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 16:24:14 -0700
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
Subject: [PATCH v5 7/7] cxl/test: Add a topology to test mixed-granularity regions
Date: Thu,  3 Sep 2026 16:23:49 -0700
Message-ID: <762061594706e626bf41c2cbae773f49e34d1a29.1788475206.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1788475206.git.alison.schofield@intel.com>
References: <cover.1788475206.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a cxl_test topology for mixed-granularity region testing.

modprobe cxl_test mixed_gran_regions=1 creates three host bridges, two
root ports per host bridge, one switch per root port, and two endpoints
per switch, for twelve endpoints total.

Two root ports per host bridge is what makes the interleaving levels
selectable. A region built from one endpoint per root port interleaves
at the host bridge and passes through the switch; a region built from
both endpoints below a single root port passes through the host bridge
and interleaves at the switch; a region using every endpoint
interleaves at both. The CXL Specification lists those as distinct
legal configurations, so the choice of member endpoints, rather than a
second topology, selects which one is under test.

Three CFMWS windows are added:

1) A 2-way window at 4K over two host bridges, hosting an 8-way region
at 1K and a 4-way region at 2K.

2) A 3-way window at 512 over three host bridges, hosting a 6-way
region at 256: CXL 4.0 Table 9-7 rows 2 and 3.

3) A 3-way window at 1K over three host bridges, hosting a 12-way
region at 256: CXL 4.0 Table 9-6 row 7. That row is the composition
the documentation contrasts with the unsupported row 6, and reaching it
needs a root granularity four times the region granularity.

Each window also hosts a same-granularity region at its own ways and
granularity. The 2-way window at 4K hosts 4-way and 8-way regions at 4K as
well; the span identity allows the 3-way windows only their own width.

Register every mock device through cxl_mock_platform_device_add() so
the mock array is populated before platform_device_add(), matching the
ordering the rest of cxl_test relies on to avoid the endpoint-probe
race in commit d90f236f8b9e ("cxl/test: Update mock dev array before
calling platform_device_add()").

NULL-check the legacy topology arrays in the mock device and mock port
lookups, which are left empty when mixed_gran_regions=1 selects the new
topology.

The default and existing special module params are unaffected.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 tools/testing/cxl/test/cxl.c | 410 +++++++++++++++++++++++++++++++++--
 1 file changed, 390 insertions(+), 20 deletions(-)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 62bd92b3be45..75e9a4a3d865 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -18,6 +18,7 @@ static int interleave_arithmetic;
 static bool extended_linear_cache;
 static bool fail_autoassemble;
 static bool type2_test;
+static bool mixed_gran_regions;
 
 #define FAKE_QTG_ID	42
 
@@ -27,9 +28,32 @@ static bool type2_test;
 #define NR_CXL_ROOT_PORTS 2
 #define NR_CXL_SWITCH_PORTS 2
 #define NR_CXL_PORT_DECODERS 8
-#define NR_BRIDGES (NR_CXL_HOST_BRIDGES + NR_CXL_SINGLE_HOST + NR_CXL_RCH)
 #define NR_CXL_TYPE2_ACCEL 1
 
+/*
+ * mixed_gran_regions=1: three host bridges, two root ports each, and one
+ * switch per root port, reaching twelve endpoints. Two root ports per host
+ * bridge let a region interleave at the host bridge, at the switch, or at
+ * both, so a single topology covers the power-of-2 and 3-way-family region
+ * layouts that the CXL Specification permits.
+ */
+#define NR_CXL_MIX_GRAN_HB 3
+#define NR_CXL_MIX_GRAN_RPS_PER_HB 2
+#define NR_CXL_MIX_GRAN_RPS (NR_CXL_MIX_GRAN_HB * NR_CXL_MIX_GRAN_RPS_PER_HB)
+#define NR_CXL_MIX_GRAN_SWITCHES NR_CXL_MIX_GRAN_RPS /* 1 per RP */
+#define NR_CXL_MIX_GRAN_DPORTS \
+	(NR_CXL_MIX_GRAN_SWITCHES * NR_CXL_SWITCH_PORTS)
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
+
 #define MOCK_AUTO_REGION_SIZE_DEFAULT SZ_512M
 static int mock_auto_region_size = MOCK_AUTO_REGION_SIZE_DEFAULT;
 
@@ -54,6 +78,12 @@ struct platform_device *cxl_mem_single[NR_MEM_SINGLE];
 static struct platform_device *cxl_rch[NR_CXL_RCH];
 static struct platform_device *cxl_rcd[NR_CXL_RCH];
 
+static struct platform_device *cxl_mix_gran_hb[NR_CXL_MIX_GRAN_HB];
+static struct platform_device *cxl_mix_gran_root_port[NR_CXL_MIX_GRAN_RPS];
+static struct platform_device *cxl_mix_gran_uport[NR_CXL_MIX_GRAN_SWITCHES];
+static struct platform_device *cxl_mix_gran_dport[NR_CXL_MIX_GRAN_DPORTS];
+static struct platform_device *cxl_mem_mix_gran[NR_CXL_MIX_GRAN_DPORTS];
+
 /*
  * Decoder registry
  *
@@ -117,6 +147,19 @@ static struct acpi_device host_bridge[NR_BRIDGES] = {
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
@@ -124,15 +167,18 @@ static bool is_mock_dev(struct device *dev)
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
@@ -190,6 +236,18 @@ static struct {
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
+	struct {
+		struct acpi_cedt_cfmws cfmws;
+		u32 target[3];
+	} cfmws11;
 	struct {
 		struct acpi_cedt_cxims cxims;
 		u64 xormap_list[2];
@@ -234,6 +292,31 @@ static struct {
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
@@ -373,6 +456,51 @@ static struct {
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
+	.cfmws11 = {
+		.cfmws = {
+			.header = {
+				.type = ACPI_CEDT_TYPE_CFMWS,
+				.length = sizeof(mock_cedt.cfmws11),
+			},
+			.interleave_ways = 8,
+			.granularity = 2,
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
@@ -410,6 +538,10 @@ struct acpi_cedt_cfmws *mock_cfmws[] = {
 	[6] = &mock_cedt.cfmws6.cfmws,
 	[7] = &mock_cedt.cfmws7.cfmws,
 	[8] = &mock_cedt.cfmws8.cfmws,
+	/* Dedicated mixed-granularity topology */
+	[9] = &mock_cedt.cfmws9.cfmws,
+	[10] = &mock_cedt.cfmws10.cfmws,
+	[11] = &mock_cedt.cfmws11.cfmws,
 };
 
 static int cfmws_start;
@@ -418,6 +550,8 @@ static int cfmws_end;
 #define CFMWS_MOD_ARRAY_END   5
 #define CFMWS_XOR_ARRAY_START 6
 #define CFMWS_XOR_ARRAY_END   8
+#define CFMWS_MIX_GRAN_ARRAY_START 9
+#define CFMWS_MIX_GRAN_ARRAY_END   11
 
 struct acpi_cedt_cxims *mock_cxims[1] = {
 	[0] = &mock_cedt.cxims0.cxims,
@@ -496,12 +630,26 @@ static void update_type2_cfmws(void)
 	memcpy(&mock_cedt.cfmws0.cfmws, &type2_cfmws0, sizeof(type2_cfmws0));
 }
 
+/* CHBS entries belonging to the topology this load selected */
+static void chbs_range(int *lo, int *hi)
+{
+	if (mixed_gran_regions) {
+		*lo = CHBS_MIX_GRAN_START;
+		*hi = CHBS_MIX_GRAN_END;
+	} else {
+		*lo = CHBS_DEFAULT_START;
+		*hi = CHBS_DEFAULT_END;
+	}
+}
+
 static int populate_cedt(void)
 {
 	struct cxl_mock_res *res;
+	int chbs_lo, chbs_hi;
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(mock_cedt.chbs); i++) {
+	chbs_range(&chbs_lo, &chbs_hi);
+	for (i = chbs_lo; i <= chbs_hi; i++) {
 		struct acpi_cedt_chbs *chbs = &mock_cedt.chbs[i];
 		resource_size_t size;
 
@@ -562,12 +710,16 @@ static int mock_acpi_table_parse_cedt(enum acpi_cedt_type id,
 	if (!is_mock_port(dev) && !is_mock_dev(dev))
 		return acpi_table_parse_cedt(id, handler_arg, arg);
 
-	if (id == ACPI_CEDT_TYPE_CHBS)
-		for (i = 0; i < ARRAY_SIZE(mock_cedt.chbs); i++) {
+	if (id == ACPI_CEDT_TYPE_CHBS) {
+		int chbs_lo, chbs_hi;
+
+		chbs_range(&chbs_lo, &chbs_hi);
+		for (i = chbs_lo; i <= chbs_hi; i++) {
 			h = (union acpi_subtable_headers *)&mock_cedt.chbs[i];
 			end = (unsigned long)&mock_cedt.chbs[i + 1];
 			handler_arg(h, arg, end);
 		}
+	}
 
 	if (id == ACPI_CEDT_TYPE_CFMWS)
 		for (i = cfmws_start; i <= cfmws_end; i++) {
@@ -591,13 +743,16 @@ static bool is_mock_bridge(struct device *dev)
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
@@ -611,27 +766,40 @@ static bool is_mock_port(struct device *dev)
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
+	for (i = 0; i < ARRAY_SIZE(cxl_mix_gran_uport); i++)
+		if (cxl_mix_gran_uport[i] && dev == &cxl_mix_gran_uport[i]->dev)
+			return true;
+
+	for (i = 0; i < ARRAY_SIZE(cxl_mix_gran_dport); i++)
+		if (cxl_mix_gran_dport[i] && dev == &cxl_mix_gran_dport[i]->dev)
 			return true;
 
 	if (is_cxl_memdev(dev))
@@ -702,7 +870,15 @@ static struct acpi_pci_root mock_pci_root[ARRAY_SIZE(mock_pci_bus)] = {
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
@@ -1343,7 +1519,8 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
 		/* check is endpoint is attach to host-bridge0 */
 		port = cxled_to_port(cxled);
 		do {
-			if (port->uport_dev == &cxl_host_bridge[0]->dev) {
+			if (cxl_host_bridge[0] &&
+			    port->uport_dev == &cxl_host_bridge[0]->dev) {
 				hb0 = true;
 				break;
 			}
@@ -1391,6 +1568,8 @@ static int mock_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
 
 	if (is_cxl_endpoint(port))
 		target_count = 0;
+	else if (mixed_gran_regions && is_cxl_root(parent_port))
+		target_count = NR_CXL_MIX_GRAN_RPS_PER_HB;
 	else if (is_cxl_root(parent_port))
 		target_count = NR_CXL_ROOT_PORTS;
 	else
@@ -1490,6 +1669,24 @@ static int get_port_array(struct cxl_port *port,
 	struct platform_device **array;
 	int array_size;
 
+	if (mixed_gran_regions) {
+		if (port->depth == 1) {
+			array_size = ARRAY_SIZE(cxl_mix_gran_root_port);
+			array = cxl_mix_gran_root_port;
+		} else if (port->depth == 2) {
+			array_size = ARRAY_SIZE(cxl_mix_gran_dport);
+			array = cxl_mix_gran_dport;
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
@@ -1883,11 +2080,137 @@ static void cxl_single_topo_exit(void)
 	}
 }
 
+#define MIX_GRAN_RP_ID_BASE	(NR_MULTI_ROOT + NR_CXL_SINGLE_HOST)
+#define MIX_GRAN_USP_ID_BASE	MIX_GRAN_RP_ID_BASE
+#define MIX_GRAN_DSP_ID_BASE	(NR_MEM_MULTI + NR_MEM_SINGLE)
+#define MIX_GRAN_MEM_ID_BASE	(NR_MEM_MULTI + NR_MEM_SINGLE + NR_CXL_RCH)
+
+static void cxl_mix_gran_topo_exit(void)
+{
+	int i;
+
+	for (i = NR_CXL_MIX_GRAN_DPORTS - 1; i >= 0; i--) {
+		platform_device_unregister(cxl_mix_gran_dport[i]);
+		cxl_mix_gran_dport[i] = NULL;
+	}
+	for (i = NR_CXL_MIX_GRAN_SWITCHES - 1; i >= 0; i--) {
+		platform_device_unregister(cxl_mix_gran_uport[i]);
+		cxl_mix_gran_uport[i] = NULL;
+	}
+	for (i = NR_CXL_MIX_GRAN_RPS - 1; i >= 0; i--) {
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
+	/* 2 root ports per host bridge */
+	for (i = 0; i < NR_CXL_MIX_GRAN_RPS; i++) {
+		struct platform_device *bridge =
+			cxl_mix_gran_hb[i / NR_CXL_MIX_GRAN_RPS_PER_HB];
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
+	/* 1 switch uport per root port */
+	for (i = 0; i < NR_CXL_MIX_GRAN_SWITCHES; i++) {
+		struct platform_device *pdev;
+
+		pdev = platform_device_alloc("cxl_switch_uport",
+					     MIX_GRAN_USP_ID_BASE + i);
+		if (!pdev) {
+			rc = -ENOMEM;
+			goto err;
+		}
+		pdev->dev.parent = &cxl_mix_gran_root_port[i]->dev;
+
+		rc = cxl_mock_platform_device_add(pdev, &cxl_mix_gran_uport[i]);
+		if (rc)
+			goto err;
+	}
+
+	/* 2 dports per switch */
+	for (i = 0; i < NR_CXL_MIX_GRAN_DPORTS; i++) {
+		struct platform_device *uport =
+			cxl_mix_gran_uport[i / NR_CXL_SWITCH_PORTS];
+		struct platform_device *pdev;
+
+		pdev = platform_device_alloc("cxl_switch_dport",
+					     MIX_GRAN_DSP_ID_BASE + i);
+		if (!pdev) {
+			rc = -ENOMEM;
+			goto err;
+		}
+		pdev->dev.parent = &uport->dev;
+
+		rc = cxl_mock_platform_device_add(pdev, &cxl_mix_gran_dport[i]);
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
 static void cxl_type3_mem_exit(void)
 {
 	struct platform_device *pdev;
 	int i;
 
+	if (mixed_gran_regions) {
+		for (i = NR_CXL_MIX_GRAN_DPORTS - 1; i >= 0; i--)
+			platform_device_unregister(cxl_mem_mix_gran[i]);
+		return;
+	}
+
 	for (i = ARRAY_SIZE(cxl_rcd) - 1; i >= 0; i--) {
 		pdev = cxl_rcd[i];
 		if (!pdev)
@@ -1960,10 +2283,42 @@ static int cxl_type2_mem_init(void)
 	return rc;
 }
 
+static int cxl_mem_mix_gran_init(void)
+{
+	int i, rc;
+
+	for (i = 0; i < NR_CXL_MIX_GRAN_DPORTS; i++) {
+		struct platform_device *dport = cxl_mix_gran_dport[i];
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
+	for (i = NR_CXL_MIX_GRAN_DPORTS - 1; i >= 0; i--)
+		platform_device_unregister(cxl_mem_mix_gran[i]);
+	return rc;
+}
+
 static int cxl_type3_mem_init(void)
 {
 	int i, rc;
 
+	if (mixed_gran_regions)
+		return cxl_mem_mix_gran_init();
+
 	for (i = 0; i < ARRAY_SIZE(cxl_mem); i++) {
 		struct platform_device *dport = cxl_switch_dport[i];
 		struct platform_device *pdev;
@@ -2076,6 +2431,8 @@ static bool __init have_multiple_modparms(void)
 		count++;
 	if (type2_test)
 		count++;
+	if (mixed_gran_regions)
+		count++;
 
 	return count > 1;
 }
@@ -2345,6 +2702,11 @@ static int cxl_type3_topo_init(void)
 
 static void cxl_topo_exit(void)
 {
+	if (mixed_gran_regions) {
+		cxl_mix_gran_topo_exit();
+		return;
+	}
+
 	if (type2_test) {
 		cxl_type2_topo_exit();
 		return;
@@ -2355,6 +2717,8 @@ static void cxl_topo_exit(void)
 
 static int cxl_topo_init(void)
 {
+	if (mixed_gran_regions)
+		return cxl_mix_gran_topo_init();
 	if (type2_test)
 		return cxl_type2_topo_init();
 	return cxl_type3_topo_init();
@@ -2397,7 +2761,10 @@ static __init int cxl_test_init(void)
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
@@ -2484,6 +2851,9 @@ module_param(fail_autoassemble, bool, 0444);
 MODULE_PARM_DESC(fail_autoassemble, "Simulate missing member of an auto-region");
 module_param(type2_test, bool, 0444);
 MODULE_PARM_DESC(type2_test, "Enable type 2 support testing");
+module_param(mixed_gran_regions, bool, 0444);
+MODULE_PARM_DESC(mixed_gran_regions,
+		 "Topology supporting mixed granularity regions");
 module_init(cxl_test_init);
 module_exit(cxl_test_exit);
 MODULE_LICENSE("GPL v2");
-- 
2.37.3

