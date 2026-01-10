Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010019.outbound.protection.outlook.com [52.101.56.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8779A33F8A6;
	Sat, 10 Jan 2026 11:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768045710; cv=fail; b=Dc3+iEun6SkkEltDJDgzKvprAh0Ba25fSnknxR37+nwKlA8clx9W0mELn4JdMvWoCUl9hwhoMgreUKAPT4JgeZaCsNo4MppkHEbTgSrwMmJbiqJd7zU2GIxHdSVY72TWZvvCohyZdyva1pHfEf/2OYurmjv9B5XFtBeyHmf1AjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768045710; c=relaxed/simple;
	bh=MDiG82Wfc5JbG6uOcrnzljitxjHN5e7UjXQ/UFD+jj8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LXgNEgit/UIUSAsZ2jyPZYtPZFcBz7SUg84+YSlnso8vSBONu1n1gKs2yzQoq8SmarA4j5bx181XF5EZsm0pkopDj15FLAIsyEVr/YDqhIUy20KknbOGKOlWRohqYhLq8c+Uszmp3C1pQPE3v4Z5wCJBwrMOI1G1w0K6OC6Z97E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=d7uFVpOP; arc=fail smtp.client-ip=52.101.56.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="d7uFVpOP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nVAH0d6wKwJy8y6VmA8Fc1z3PasCA1V5gE7d7jXi4QX3iLftYlwx5wDRVC9ItCZJ2HYwqQZjsRLlJJYlhlzVEm2e2p0SOO8V3HUnwEhij2Fs+sPS9k7oxpdqq4PaGHXSuCC3Gt+1jQZX3Y2EFimlDN0glTP+QULqrLWGxZNyqodjt2Exg3Owx4yW533kFD/x7bG8oPKMrwu9hFvRr9WwZopUl4fkhv7JiPN26Js3ZjuNDsGSENZ20D70CNjsoq1s1FXELOdPSWZ6hEkDKLMPHPZ441QY/EBtM67IWJ1lG3O0xaraH0gHOMG9Y/D6cYsc0VJVDgEhZmUOYNDWkAYUtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oV193kkP8HeQjPPmyDyy6ZC8KPw6yfnXgirHNxRyueA=;
 b=A/un/J0F0vDhyItEnbFY5Zhs8cOFEOl9DonVgTB6hOpi8qsR4pOtdSlIINgdaEFfHq9+Wd3G7M0HzbtQRjRquuM9VKTeOTZBtBgTMbIXeXMvtBAdJNvtvpglgs5LH3Ulwr5fvOXy/GrLIJiYhJwvJNyMaOXkP42hNTGrwGcyvq67FBT+aIN+qsb/RBEwm7x/9ThamaHjCSSZ7ezb0yenjiyI8as6hAjFOykUg+RCogW3VlLFOjNk88oxVVqvWHcl6aUd6M+/uksQXmDxMzIVCnJgC/l+0U1Gy8aNvANLgc8Bxwh2EuZhBSgWeO1qRVMVGL+2l4g2HiKMNtstDJrSiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oV193kkP8HeQjPPmyDyy6ZC8KPw6yfnXgirHNxRyueA=;
 b=d7uFVpOP/Bc2mDHZPWTMNZRYvyxWWP/CGI0YVhoZAtL6l9J4Un/Ld4GtvrSgHLmOGckQST8bRRbyZTAeqCTEFsQUbk8xydpaKQgs48gIDePDsu/FeURjVQhJnHwjMm7DtNKMKHo8+PjEaxHADAIUlLQcBqdhND+Sqzy3wdfmz0k=
Received: from MN2PR15CA0044.namprd15.prod.outlook.com (2603:10b6:208:237::13)
 by SJ0PR12MB6687.namprd12.prod.outlook.com (2603:10b6:a03:47a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Sat, 10 Jan
 2026 11:48:23 +0000
Received: from BN2PEPF000055DD.namprd21.prod.outlook.com
 (2603:10b6:208:237:cafe::25) by MN2PR15CA0044.outlook.office365.com
 (2603:10b6:208:237::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.6 via Frontend Transport; Sat,
 10 Jan 2026 11:48:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055DD.mail.protection.outlook.com (10.167.245.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.0 via Frontend Transport; Sat, 10 Jan 2026 11:48:23 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sat, 10 Jan
 2026 05:48:18 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v9 13/13] cxl: Disable HPA/SPA translation handlers for Normalized Addressing
Date: Sat, 10 Jan 2026 12:46:58 +0100
Message-ID: <20260110114705.681676-14-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260110114705.681676-1-rrichter@amd.com>
References: <20260110114705.681676-1-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DD:EE_|SJ0PR12MB6687:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ed6d929-7cd3-43c5-e05e-08de503e288b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GN7Pj33SHOJztPTJgg+XdQj+b7gqilr2gcQEVmLqLZJ3ryYx+BuXWCC7KjPe?=
 =?us-ascii?Q?rWwkqKATpSnmJ9tjmr1AJtOCA3dBqOh8tXNC69rnUOghu0+OiNMxHhw88Lea?=
 =?us-ascii?Q?m74NAyOzW+tjskMNhcLaBYUqbfcexH0i6nWVvXVotXiV3H3YaXAefbGf/hQB?=
 =?us-ascii?Q?K/7P+cphHkWCyMRI2mtkHsss9z8g94VE6H3b5iDyflFGrQqdKr7L0jD2bR9f?=
 =?us-ascii?Q?WRlySNPX3rY1eUIXWImo4tcn1AdwdBJLyecaqIkPp49KWKxzfKcy3M8vWZUA?=
 =?us-ascii?Q?CNKdsekLB5u7+/S+r4CQLavzIGITVkrSzRpELJknvDwcrTOMN/teuauWmzTP?=
 =?us-ascii?Q?Az0BKZJ7V1wym+kZieyAvQCWGRlHst/Y1/LTh1rERL+1UP/k6r/33a4Cj77s?=
 =?us-ascii?Q?iRRY643At0VrGhpypitbL2nJ0pxpvxd/PEm2DO4oI6ho1Z19IV3Hs3C+77V8?=
 =?us-ascii?Q?zX7cBcQM+XorPt9KCUtRlNhaC0L/kJO5r9lkLUBs9m5xG4RrqwccwudjGKBP?=
 =?us-ascii?Q?anJEJv4tNUswB4HSGAXf2UhqVGZC6dw4H9HqFs+i0EF9uMgQgfmWhj9D5bg4?=
 =?us-ascii?Q?68KRTbyfy9IujXqGFNhR2HiJ3JuWUhGXPtN7QQ8Kv84WPGSHwWv9x5dGjvjv?=
 =?us-ascii?Q?fLz98vm2cO387wuhfevOmxLp81hyL8TzLNWeJP2ziyZvEHtTDPZLsxqeLixI?=
 =?us-ascii?Q?FhATELQ80sPjOEaUA4ZWJ2Jmijsyw+gngsfke+merNqhjlevYbpCkpoFJIfS?=
 =?us-ascii?Q?9fWaiw1G+XvC4nIiJ57ljNQjxRg3znhl1MzXt4ilDDlka2E+IhuzYSpjuLpq?=
 =?us-ascii?Q?9BA71Mt45hFlasFjuk/7vIsAe0Latl+R8zv9tXr0cix84JYir6MqGaTKRky7?=
 =?us-ascii?Q?og4PN/0V6B6PnbIf4prH2Uk1VNtLZrRwvmin6EYPxa1Er3yc3CF4sHxeQZ+T?=
 =?us-ascii?Q?9cKI6XKFh8OGh+9Cg8RJ6D98meNPrMqai8OZtKAl4mgDP/1OGvMSEFSnwlAw?=
 =?us-ascii?Q?/ZB/21732jbdRJA+WXaVUb/J6zGn0YJEP431Yolvt7/wrJiWnKKxnnknTplr?=
 =?us-ascii?Q?X7+AvPLJ4q4ZXVtbUXiOUfvRy4XyiTDMERSs3u/fji141WleEc87Jzm78X43?=
 =?us-ascii?Q?yyacHtUOtPcAUxWU4g2T0xYEAqzJGC+V2ksR3+X/TTGS3bJCFgysnbqy78ZE?=
 =?us-ascii?Q?hBSlRW1tJroGglpR2n3ROGITmqXgHeQztF6OkDp4uJxQXQ4sjSdmVoFsKXbl?=
 =?us-ascii?Q?crbtE6ZzcrD9kh5JPzWzsGUol3jxOqe+gccSkeJTrgqkN64crcLjyv++B11p?=
 =?us-ascii?Q?68Oa/R9cXdsQ82kcHgJ12DaDgXfrVAzVpOJeiHME2j5qC2fK5iqIv4rd5C1N?=
 =?us-ascii?Q?SHPAbltLj0G5pgxbd5rhXcGrAX0vnL3P0cGeheDCEduOg7LN42BZpRGo5ckG?=
 =?us-ascii?Q?la6rQgGbTVSnym8FysYa/yNzSegXfot/r0mkzB1JwbF/6qoNUnN92oAcFmt5?=
 =?us-ascii?Q?/QMAMLv1FAUMlgsIP83USTD7SyArgXGjkm5vku0Liuv10ErX69ojeiY3XSOI?=
 =?us-ascii?Q?8It4FzVHkqNN98rREhI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2026 11:48:23.1218
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ed6d929-7cd3-43c5-e05e-08de503e288b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6687

The root decoder provides the callbacks hpa_to_spa and spa_to_hpa to
perform Host Physical Address (HPA) and System Physical Address
translations, respectively. The callbacks are required to convert
addresses when HPA != SPA. XOR interleaving depends on this mechanism,
and the necessary handlers are implemented.

The translation handlers are used for poison injection
(trace_cxl_poison, cxl_poison_inject_fops) and error handling
(cxl_event_trace_record).

In AMD Zen5 systems with Normalized Addressing, endpoint addresses are
not SPAs, and translation handlers are required for these features to
function correctly.

Now, as ACPI PRM translation could be expensive in tracing or error
handling code paths, do not yet enable translations to avoid its
intensive use. Instead, disable those features which are used only for
debugging and enhanced logging.

Introduce the flag CXL_REGION_F_NORM_ADDR that indicates Normalized
Addressing for a region and use it to disable poison injection and DPA
to HPA conversion.

Note: Dropped unused CXL_DECODER_F_MASK macro.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/atl.c    |  3 +++
 drivers/cxl/core/region.c | 33 +++++++++++++++++++++++++--------
 drivers/cxl/cxl.h         |  9 ++++++++-
 3 files changed, 36 insertions(+), 9 deletions(-)

diff --git a/drivers/cxl/core/atl.c b/drivers/cxl/core/atl.c
index 09d0ea1792d9..13f1118dc026 100644
--- a/drivers/cxl/core/atl.c
+++ b/drivers/cxl/core/atl.c
@@ -169,8 +169,11 @@ static int cxl_prm_setup_root(struct cxl_root *cxl_root, void *data)
 	 * decoders in the BIOS would prevent a capable kernel (or
 	 * other operating systems) from shutting down auto-generated
 	 * regions and managing resources dynamically.
+	 *
+	 * Indicate that Normalized Addressing is enabled.
 	 */
 	cxld->flags |= CXL_DECODER_F_LOCK;
+	cxld->flags |= CXL_DECODER_F_NORM_ADDR;
 
 	ctx->hpa_range = hpa_range;
 	ctx->interleave_ways = ways;
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 80cd77f0842e..8b68ccce1554 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1097,14 +1097,16 @@ static int cxl_rr_assign_decoder(struct cxl_port *port, struct cxl_region *cxlr,
 	return 0;
 }
 
-static void cxl_region_set_lock(struct cxl_region *cxlr,
-				struct cxl_decoder *cxld)
+static void cxl_region_setup_flags(struct cxl_region *cxlr,
+				   struct cxl_decoder *cxld)
 {
-	if (!test_bit(CXL_DECODER_F_LOCK, &cxld->flags))
-		return;
+	if (test_bit(CXL_DECODER_F_LOCK, &cxld->flags)) {
+		set_bit(CXL_REGION_F_LOCK, &cxlr->flags);
+		clear_bit(CXL_REGION_F_NEEDS_RESET, &cxlr->flags);
+	}
 
-	set_bit(CXL_REGION_F_LOCK, &cxlr->flags);
-	clear_bit(CXL_REGION_F_NEEDS_RESET, &cxlr->flags);
+	if (test_bit(CXL_DECODER_F_NORM_ADDR, &cxld->flags))
+		set_bit(CXL_REGION_F_NORM_ADDR, &cxlr->flags);
 }
 
 /**
@@ -1218,7 +1220,7 @@ static int cxl_port_attach_region(struct cxl_port *port,
 		}
 	}
 
-	cxl_region_set_lock(cxlr, cxld);
+	cxl_region_setup_flags(cxlr, cxld);
 
 	rc = cxl_rr_ep_add(cxl_rr, cxled);
 	if (rc) {
@@ -2493,7 +2495,7 @@ static struct cxl_region *cxl_region_alloc(struct cxl_root_decoder *cxlrd, int i
 	device_set_pm_not_required(dev);
 	dev->bus = &cxl_bus_type;
 	dev->type = &cxl_region_type;
-	cxl_region_set_lock(cxlr, &cxlrd->cxlsd.cxld);
+	cxl_region_setup_flags(cxlr, &cxlrd->cxlsd.cxld);
 
 	return cxlr;
 }
@@ -3132,6 +3134,13 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 	u8 eiw = 0;
 	int pos;
 
+	/*
+	 * Conversion between SPA and DPA is not supported in
+	 * Normalized Address mode.
+	 */
+	if (test_bit(CXL_REGION_F_NORM_ADDR, &cxlr->flags))
+		return ULLONG_MAX;
+
 	for (int i = 0; i < p->nr_targets; i++) {
 		if (cxlmd == cxled_to_memdev(p->targets[i])) {
 			cxled = p->targets[i];
@@ -3922,6 +3931,14 @@ static int cxl_region_setup_poison(struct cxl_region *cxlr)
 	struct cxl_region_params *p = &cxlr->params;
 	struct dentry *dentry;
 
+	/*
+	 * Do not enable poison injection in Normalized Address mode.
+	 * Conversion between SPA and DPA is required for this, but it is
+	 * not supported in this mode.
+	 */
+	if (test_bit(CXL_REGION_F_NORM_ADDR, &cxlr->flags))
+		return 0;
+
 	/* Create poison attributes if all memdevs support the capabilities */
 	for (int i = 0; i < p->nr_targets; i++) {
 		struct cxl_endpoint_decoder *cxled = p->targets[i];
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 20b0fd43fa7b..0ab0a86e1d4f 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -332,7 +332,7 @@ int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev, struct cxl_dport *dport);
 #define CXL_DECODER_F_TYPE3 BIT(3)
 #define CXL_DECODER_F_LOCK  BIT(4)
 #define CXL_DECODER_F_ENABLE    BIT(5)
-#define CXL_DECODER_F_MASK  GENMASK(5, 0)
+#define CXL_DECODER_F_NORM_ADDR BIT(6)
 
 enum cxl_decoder_type {
 	CXL_DECODER_DEVMEM = 2,
@@ -525,6 +525,13 @@ enum cxl_partition_mode {
  */
 #define CXL_REGION_F_LOCK 2
 
+/*
+ * Indicate Normalized Addressing. Use it to disable SPA conversion if
+ * HPA != SPA and an address translation callback handler does not
+ * exist. Flag is needed by AMD Zen5 platforms.
+ */
+#define CXL_REGION_F_NORM_ADDR 3
+
 /**
  * struct cxl_region - CXL region
  * @dev: This region's device
-- 
2.47.3

