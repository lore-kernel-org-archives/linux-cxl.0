Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D9681AC8
	for <linux-cxl@vger.kernel.org>; Mon,  2 Dec 2024 15:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733154965; cv=fail; b=KN+6Gy5yx3+RQAdHKxa3XhnHbfOtHw5xT/QWk+md55qpsj19rzyM59Zyfy9Pd+XHu1SimOCBrD65peyZkjdudDmRLhKqVc02KNyJ7JV52xo+ozHw/Gp3p3Wn2P0o3mJmHV+ZUXUPdId1Doq0/C0NUFNxCb0HTwUbcVDtrre2yFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733154965; c=relaxed/simple;
	bh=Cbj26YsaXq1ce4NmoEFgsL8BuiNGOJWbtwe8vI0HfT0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FVz86AcIPvZ5+avrFMbZdmKdUrEyMtCNKF40DLycAgjulbwk0Urhm+7vHamE90Qg6QL7oySEG6jvHeR5OAkhea4JnPCG/AGBna5XvKntst7hvhJb12ZFafVrbJSh+o1I84sVIpJkmU6jRKvd3nSma0fqJacT46sr72XyX9UQe9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XiHsqOdp; arc=fail smtp.client-ip=40.107.244.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XiHsqOdp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZHFSwtwbrbt/8CPzRJmFTiuXVFsVXSwVPjY09KUaVrX+SiRIs31CR9q1ltJax/cdft3ogqlO3I4nxid0wmvicE4WUUgL9CO8QVHx/XKzNUzJY3DWfu9Klv71pnn9b7CGVimH62wxJoV6zuR4SrgXM6OqEf89TISMlF3JMazCJp/zu8saq4kciYu5CI18c67tVjZIZTcjuXQZFQ9rSZHrk6WOj6zMCgOFvEnAHcgKeBLwTxrSUa40kzx0NhLa+bDUE9LH4O4dQrDD/GxSyJ2zQHplFFPl2y+1hqoy+e6itjt9zRon8qDSf/sO/IT+9OPPLhmWUGjDTOYR2U8DT2qA+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vPq1BM31nn7q5pv9dV+zyjO67XSh7QwmypuwKZcLQJQ=;
 b=kFsPWJuKs8dq3nLNqsGKAUAFkZQYCnS1RZQafOHOpWSjq7R7ojW2APhlbx8AA4RNjtUb5qEjLItWO3MY5OqfLVYYRalUVigIX6Xffih3CfHofRzTKcIHXH1tmRg0bwAbyybYwopnV1qDw9DsvW6aLgMj5YgddH1NiC1izu5U6mOSwRU5fWvxvcGM34zFmVnZ0AW6e2yGEI/9fFrNbKdzlM25ij73h1TUbyJt0o1HeHwoi4qWHOkCGlW431U4QA0w2qfPByCgkWc9yXGAIGPsv2kFPEuP3S84+jH15k7wbv3E4MkwTJPVWRNmlz/CqZTK72c3LQExKCAITTGF95cr/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vPq1BM31nn7q5pv9dV+zyjO67XSh7QwmypuwKZcLQJQ=;
 b=XiHsqOdpiHWnDPRAMUklHngRitYiKzNYZNucxshH502WV97ei/g3Img40ZeoN9fRJViCvn0+gApK2thlDJWfEgKRefrFw5SozReSaZQpTy/+kWzWFffaJawtE5Safedrfx4RlQVfJ71ItU3Byvqo0QEn0pd9NatLB7H5ehEQres=
Received: from BN8PR15CA0037.namprd15.prod.outlook.com (2603:10b6:408:80::14)
 by MW4PR12MB7143.namprd12.prod.outlook.com (2603:10b6:303:222::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 2 Dec
 2024 15:55:57 +0000
Received: from BN1PEPF00005FFC.namprd05.prod.outlook.com
 (2603:10b6:408:80:cafe::41) by BN8PR15CA0037.outlook.office365.com
 (2603:10b6:408:80::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.18 via Frontend Transport; Mon,
 2 Dec 2024 15:55:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00005FFC.mail.protection.outlook.com (10.167.243.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 15:55:56 +0000
Received: from AUSNAFONTEN1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Dec
 2024 09:55:55 -0600
From: Nathan Fontenot <nathan.fontenot@amd.com>
To: <alison.schofield@intel.com>, <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-mm@kvack.org>
Subject: [PATCH] cxl: Update Soft Reserved resources upon region creation
Date: Mon, 2 Dec 2024 09:55:42 -0600
Message-ID: <20241202155542.22111-1-nathan.fontenot@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFC:EE_|MW4PR12MB7143:EE_
X-MS-Office365-Filtering-Correlation-Id: 251499e1-5d42-4606-df45-08dd12e9cf0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4/O0B1Hz++IzOoHHYLZnTXGX17zMY9VKo7FGXOjo8zoxDHtNRS+Ta0P3guEk?=
 =?us-ascii?Q?VTQDErBvxpcjfzoN/sVq8ZjDJDVyCTNfM87PprqeVLt7pOySf+RZnWnWF7f0?=
 =?us-ascii?Q?dqe4Qm1Oh/TsZBmXDPOBgnRbMC4MlA3XmAXw+GZao2MjDf04QNbiBx1zPzhG?=
 =?us-ascii?Q?0jcfmifkI9Dzs2vSvjoA+7fEaJoVvzfRsfWlv63KW2QU3ZnydmpIwC4OYVqa?=
 =?us-ascii?Q?0Ih5lndeeqjh/6t4O7vVnEZGFZ7gP33Ba7XVE5LYVtA/5zeSMmihh31MLGg5?=
 =?us-ascii?Q?+kmrc+Or6ItJnqiUj7EJA/kThh6SYB62L6UoCcF/6P8V9LDmVGI/v0s4i0H/?=
 =?us-ascii?Q?Q9wqTKkbh4Uqdorbl6iVE5egXAf3ehgJW7p3o1X64JHbAGHyY+4DZs//eNR7?=
 =?us-ascii?Q?hHQ6aIC5OHo6IHeTSgt7RZNOZsHEuHde/u1MMOt4MiMFb/rhFCd4s04QtVjO?=
 =?us-ascii?Q?azB2JmzokVdubJRk3p1UW6JaU17yAsTzJ2MAr1gQ3ZDZKkKWvIQkY6q92pyt?=
 =?us-ascii?Q?cV3qBgDPzHGnMic+pVgtQBbaPQ5GtKDlgGIauXalcwgKj2VK/+nXniEjbZMk?=
 =?us-ascii?Q?1Lp4Um4QpNHjWM4hMzj63N7iumzObrU3UYIxov59Urt4WK3b8POABUZqPTzx?=
 =?us-ascii?Q?+NpV5ckz8wzWg7eiAUfxPmIWOthEcSXS+tgFHt51wN1JgxtqIw8ERGTA2jl0?=
 =?us-ascii?Q?2qv7lwZR8nSo9m7jYF7QwRTpQVhlLk1EHE4hXp8loSaRVOYRRQv8MlvQ1R+L?=
 =?us-ascii?Q?22jsc/Hpe79MdniQal47FM3uOPMRHklT4Ae+MGCVsqSnycQ8kr+IbVqINfmT?=
 =?us-ascii?Q?+D8PLRqlGh+orDfzeY1rBVEtXwMAuKxgqA7XNpk7fb3rvBLudq1eiqH2uAqe?=
 =?us-ascii?Q?sxjl4bPTsuReySUfQhL+mOzEwK6ak+SBp4NVfiQ3rLcfV1azCu9js8Koke11?=
 =?us-ascii?Q?8dT4zCvk1lDctJdA7MB32/qILykhFfj/VANBQzDJGLRxzLXqD4snKUawXIKV?=
 =?us-ascii?Q?iXHJN92kU/u59KttK5bGr621vHwOWvJrjhO4z78ERJEbGtqx6+RJw5/459dJ?=
 =?us-ascii?Q?JLKurxcHJYwxCg/l2gB9cZRcpfjPBVpDOofuwkCJ1TRA6DUBRiz0CwDLypAf?=
 =?us-ascii?Q?YEn+GO0XwvljlbStdXFNGhkjAGeObloUZeVIOMD9yUk/JnSiFTMWHbK2hPIv?=
 =?us-ascii?Q?bPxxSIl7VXoicorqhIYkGZHaeOgaaNO8T9RzvFJCjGhJMu4ootJpr3gn/sWG?=
 =?us-ascii?Q?AqO2YZUdSm6hulq59fcIH6UOk+F0q/hR1htCocx6VtApfiFVsrCpFwr2s2YG?=
 =?us-ascii?Q?nCTvALZMx7GF3YDw5XosfVuPZH1ptWQA8xTM9eUfyWuxwMALosl7W7wLyBVv?=
 =?us-ascii?Q?zFlIUzUP5UDNyxaSTuDOWGF+qbcFtwiS8wv6k94EnQIkhf80aZx7l5HaFDer?=
 =?us-ascii?Q?6v1Ho63RZZmdAGpQMrhyr12BOKLMfzAg?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 15:55:56.6195
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 251499e1-5d42-4606-df45-08dd12e9cf0b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7143

Update handling of SOFT RESERVE iomem resources that intersect with
CXL region resources to remove the intersections from the SOFT RESERVE
resources. The current approach of leaving the SOFT RESERVE
resource as is can cause failures during hotplug replace of CXL
devices because the resource is not available for reuse after
teardown of the CXL device.

The approach is to trim out any pieces of SOFT RESERVE resources
that intersect CXL regions. To do this, first set aside any SOFT RESERVE
resources that intersect with a CFMWS into a separate resource tree
during e820__reserve_resources_late() that would have been otherwise
added to the iomem resource tree.

As CXL regions are created the cxl resource created for the new
region is used to trim intersections from the SOFT RESERVE
resources that were previously set aside.

Once CXL device probe has completed ant remaining SOFT RESERVE resources
remaining are added to the iomem resource tree. As each resource
is added to the oiomem resource tree a new notifier chain is invoked
to notify the dax driver of newly added SOFT RESERVE resources so that
the dax driver can consume them.

Signed-off-by: Nathan Fontenot <nathan.fontenot@amd.com>
---
 arch/x86/kernel/e820.c    |  17 ++++-
 drivers/cxl/core/region.c |   8 +-
 drivers/cxl/port.c        |  15 ++++
 drivers/dax/hmem/device.c |  13 ++--
 drivers/dax/hmem/hmem.c   |  15 ++++
 drivers/dax/hmem/hmem.h   |  11 +++
 include/linux/dax.h       |   4 -
 include/linux/ioport.h    |   6 ++
 kernel/resource.c         | 155 +++++++++++++++++++++++++++++++++++++-
 9 files changed, 229 insertions(+), 15 deletions(-)
 create mode 100644 drivers/dax/hmem/hmem.h

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 4893d30ce438..cab82e9324a5 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -1210,14 +1210,23 @@ static unsigned long __init ram_alignment(resource_size_t pos)
 
 void __init e820__reserve_resources_late(void)
 {
-	int i;
 	struct resource *res;
+	int i;
 
+	/*
+	 * Prior to inserting SOFT_RESERVED resources we want to check for an
+	 * intersection with potential CXL resources. Any SOFT_RESERVED resources
+	 * that do intersect a potential CXL resource are set aside so they
+	 * can be trimmed to accommodate CXL resource intersections and added to
+	 * the iomem resource tree after the CXL drivers have completed their
+	 * device probe.
+	 */
 	res = e820_res;
-	for (i = 0; i < e820_table->nr_entries; i++) {
-		if (!res->parent && res->end)
+	for (i = 0; i < e820_table->nr_entries; i++, res++) {
+		if (res->desc == IORES_DESC_SOFT_RESERVED)
+			insert_soft_reserve_resource(res);
+		else if (!res->parent && res->end)
 			insert_resource_expand_to_fit(&iomem_resource, res);
-		res++;
 	}
 
 	/*
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 21ad5f242875..c458a6313b31 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3226,6 +3226,12 @@ static int match_region_by_range(struct device *dev, void *data)
 	return rc;
 }
 
+static int insert_region_resource(struct resource *parent, struct resource *res)
+{
+	trim_soft_reserve_resources(res);
+	return insert_resource(parent, res);
+}
+
 /* Establish an empty region covering the given HPA range */
 static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 					   struct cxl_endpoint_decoder *cxled)
@@ -3272,7 +3278,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 
 	*res = DEFINE_RES_MEM_NAMED(hpa->start, range_len(hpa),
 				    dev_name(&cxlr->dev));
-	rc = insert_resource(cxlrd->res, res);
+	rc = insert_region_resource(cxlrd->res, res);
 	if (rc) {
 		/*
 		 * Platform-firmware may not have split resources like "System
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index d7d5d982ce69..4461f2a80d72 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -89,6 +89,20 @@ static int cxl_switch_port_probe(struct cxl_port *port)
 	return -ENXIO;
 }
 
+static void cxl_sr_update(struct work_struct *w)
+{
+	merge_soft_reserve_resources();
+}
+
+DECLARE_DELAYED_WORK(cxl_sr_work, cxl_sr_update);
+
+static void schedule_soft_reserve_update(void)
+{
+	int timeout = 5 * HZ;
+
+	mod_delayed_work(system_wq, &cxl_sr_work, timeout);
+}
+
 static int cxl_endpoint_port_probe(struct cxl_port *port)
 {
 	struct cxl_endpoint_dvsec_info info = { .port = port };
@@ -140,6 +154,7 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 	 */
 	device_for_each_child(&port->dev, root, discover_region);
 
+	schedule_soft_reserve_update();
 	return 0;
 }
 
diff --git a/drivers/dax/hmem/device.c b/drivers/dax/hmem/device.c
index f9e1a76a04a9..c45791ad4858 100644
--- a/drivers/dax/hmem/device.c
+++ b/drivers/dax/hmem/device.c
@@ -4,6 +4,7 @@
 #include <linux/module.h>
 #include <linux/dax.h>
 #include <linux/mm.h>
+#include "hmem.h"
 
 static bool nohmem;
 module_param_named(disable, nohmem, bool, 0444);
@@ -17,6 +18,9 @@ static struct resource hmem_active = {
 	.flags = IORESOURCE_MEM,
 };
 
+struct platform_device *hmem_pdev;
+EXPORT_SYMBOL_GPL(hmem_pdev);
+
 int walk_hmem_resources(struct device *host, walk_hmem_fn fn)
 {
 	struct resource *res;
@@ -35,7 +39,6 @@ EXPORT_SYMBOL_GPL(walk_hmem_resources);
 
 static void __hmem_register_resource(int target_nid, struct resource *res)
 {
-	struct platform_device *pdev;
 	struct resource *new;
 	int rc;
 
@@ -51,15 +54,15 @@ static void __hmem_register_resource(int target_nid, struct resource *res)
 	if (platform_initialized)
 		return;
 
-	pdev = platform_device_alloc("hmem_platform", 0);
-	if (!pdev) {
+	hmem_pdev = platform_device_alloc("hmem_platform", 0);
+	if (!hmem_pdev) {
 		pr_err_once("failed to register device-dax hmem_platform device\n");
 		return;
 	}
 
-	rc = platform_device_add(pdev);
+	rc = platform_device_add(hmem_pdev);
 	if (rc)
-		platform_device_put(pdev);
+		platform_device_put(hmem_pdev);
 	else
 		platform_initialized = true;
 }
diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
index 5e7c53f18491..d626b60a9716 100644
--- a/drivers/dax/hmem/hmem.c
+++ b/drivers/dax/hmem/hmem.c
@@ -5,6 +5,7 @@
 #include <linux/pfn_t.h>
 #include <linux/dax.h>
 #include "../bus.h"
+#include "hmem.h"
 
 static bool region_idle;
 module_param_named(region_idle, region_idle, bool, 0644);
@@ -123,8 +124,22 @@ static int hmem_register_device(struct device *host, int target_nid,
 	return rc;
 }
 
+static int dax_hmem_cb(struct notifier_block *nb, unsigned long action,
+		       void *arg)
+{
+	struct resource *res = arg;
+
+	return hmem_register_device(&hmem_pdev->dev,
+				    phys_to_target_node(res->start), res);
+}
+
+static struct notifier_block hmem_nb = {
+	.notifier_call = dax_hmem_cb
+};
+
 static int dax_hmem_platform_probe(struct platform_device *pdev)
 {
+	register_soft_reserve_notifier(&hmem_nb);
 	return walk_hmem_resources(&pdev->dev, hmem_register_device);
 }
 
diff --git a/drivers/dax/hmem/hmem.h b/drivers/dax/hmem/hmem.h
new file mode 100644
index 000000000000..95583b59cef7
--- /dev/null
+++ b/drivers/dax/hmem/hmem.h
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0
+#ifndef _HMEM_H
+#define _HMEM_H
+
+typedef int (*walk_hmem_fn)(struct device *dev, int target_nid,
+			    const struct resource *res);
+int walk_hmem_resources(struct device *dev, walk_hmem_fn fn);
+
+extern struct platform_device *hmem_pdev;
+
+#endif
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 9d3e3327af4c..119b4e27a592 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -282,8 +282,4 @@ static inline void hmem_register_resource(int target_nid, struct resource *r)
 {
 }
 #endif
-
-typedef int (*walk_hmem_fn)(struct device *dev, int target_nid,
-			    const struct resource *res);
-int walk_hmem_resources(struct device *dev, walk_hmem_fn fn);
 #endif
diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 6e9fb667a1c5..487371a46392 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -14,6 +14,7 @@
 #include <linux/compiler.h>
 #include <linux/minmax.h>
 #include <linux/types.h>
+#include <linux/notifier.h>
 /*
  * Resources are tree-like, allowing
  * nesting etc..
@@ -249,6 +250,11 @@ struct resource *lookup_resource(struct resource *root, resource_size_t start);
 int adjust_resource(struct resource *res, resource_size_t start,
 		    resource_size_t size);
 resource_size_t resource_alignment(struct resource *res);
+extern void trim_soft_reserve_resources(const struct resource *res);
+extern void merge_soft_reserve_resources(void);
+extern int insert_soft_reserve_resource(struct resource *res);
+extern int register_soft_reserve_notifier(struct notifier_block *nb);
+extern int unregister_soft_reserve_notifier(struct notifier_block *nb);
 static inline resource_size_t resource_size(const struct resource *res)
 {
 	return res->end - res->start + 1;
diff --git a/kernel/resource.c b/kernel/resource.c
index a83040fde236..8fc4121a1887 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -30,7 +30,7 @@
 #include <linux/string.h>
 #include <linux/vmalloc.h>
 #include <asm/io.h>
-
+#include <linux/acpi.h>
 
 struct resource ioport_resource = {
 	.name	= "PCI IO",
@@ -48,7 +48,15 @@ struct resource iomem_resource = {
 };
 EXPORT_SYMBOL(iomem_resource);
 
+struct resource srmem_resource = {
+	.name	= "Soft Reserved mem",
+	.start	= 0,
+	.end	= -1,
+	.flags	= IORESOURCE_MEM,
+};
+
 static DEFINE_RWLOCK(resource_lock);
+static DEFINE_RWLOCK(srmem_resource_lock);
 
 static struct resource *next_resource(struct resource *p, bool skip_children)
 {
@@ -1034,6 +1042,151 @@ int adjust_resource(struct resource *res, resource_size_t start,
 }
 EXPORT_SYMBOL(adjust_resource);
 
+static BLOCKING_NOTIFIER_HEAD(soft_reserve_chain);
+
+int register_soft_reserve_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&soft_reserve_chain, nb);
+}
+EXPORT_SYMBOL(register_soft_reserve_notifier);
+
+int unregister_soft_reserve_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_unregister(&soft_reserve_chain, nb);
+}
+EXPORT_SYMBOL(unregister_soft_reserve_notifier);
+
+static int soft_reserve_notify(unsigned long val, void *v)
+{
+	struct resource *res = v;
+
+	pr_info("Adding Soft Reserve resource %pr\n", res);
+	return blocking_notifier_call_chain(&soft_reserve_chain, val, v);
+}
+
+static void trim_soft_reserve(struct resource *sr_res,
+			      const struct resource *res)
+{
+	struct resource *new_res;
+
+	if (sr_res->start == res->start && sr_res->end == res->end) {
+		release_resource(sr_res);
+		free_resource(sr_res);
+	} else if (sr_res->start == res->start) {
+		WARN_ON(adjust_resource(sr_res, res->end + 1,
+					sr_res->end - res->end));
+	} else if (sr_res->end == res->end) {
+		WARN_ON(adjust_resource(sr_res, sr_res->start,
+					res->start - sr_res->start));
+	} else {
+		/*
+		 * Adjust existing resource to cover the resource
+		 * range prior to the range to be trimmed.
+		 */
+		adjust_resource(sr_res, sr_res->start,
+				res->start - sr_res->start);
+
+		/*
+		 * Add new resource to cover the resource range for
+		 * the range after the range to be trimmed.
+		 */
+		new_res = alloc_resource(GFP_KERNEL);
+		if (!new_res)
+			return;
+
+		*new_res = DEFINE_RES_NAMED(res->end + 1, sr_res->end - res->end,
+					    "Soft Reserved", sr_res->flags);
+		new_res->desc = IORES_DESC_SOFT_RESERVED;
+		insert_resource(&srmem_resource, new_res);
+	}
+}
+
+void trim_soft_reserve_resources(const struct resource *res)
+{
+	struct resource *sr_res;
+
+	write_lock(&srmem_resource_lock);
+	for (sr_res = srmem_resource.child; sr_res; sr_res = sr_res->sibling) {
+		if (resource_contains(sr_res, res)) {
+			trim_soft_reserve(sr_res, res);
+			break;
+		}
+	}
+	write_unlock(&srmem_resource_lock);
+}
+EXPORT_SYMBOL(trim_soft_reserve_resources);
+
+void merge_soft_reserve_resources(void)
+{
+	struct resource *sr_res, *next;
+
+	write_lock(&srmem_resource_lock);
+	for (sr_res = srmem_resource.child; sr_res; sr_res = next) {
+		next = sr_res->sibling;
+
+		release_resource(sr_res);
+		if (insert_resource(&iomem_resource, sr_res))
+			pr_info("Could not add Soft Reserve %pr\n", sr_res);
+		else
+			soft_reserve_notify(0, sr_res);
+	}
+	write_unlock(&srmem_resource_lock);
+}
+EXPORT_SYMBOL(merge_soft_reserve_resources);
+
+struct srmem_arg {
+	struct resource *res;
+	int overlaps;
+};
+
+static int srmem_parse_cfmws(union acpi_subtable_headers *hdr,
+			     void *arg, const unsigned long unused)
+{
+	struct acpi_cedt_cfmws *cfmws;
+	struct srmem_arg *args = arg;
+	struct resource cfmws_res;
+	struct resource *res;
+
+	res = args->res;
+
+	cfmws = (struct acpi_cedt_cfmws *)hdr;
+	cfmws_res = DEFINE_RES_MEM(cfmws->base_hpa,
+				   cfmws->base_hpa + cfmws->window_size);
+
+	if (resource_overlaps(&cfmws_res, res)) {
+		args->overlaps += 1;
+		return 1;
+	}
+
+	return 0;
+}
+
+static bool resource_overlaps_cfmws(struct resource *res)
+{
+	struct srmem_arg arg = {
+		.res = res,
+		.overlaps = 0
+	};
+
+	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CFMWS, srmem_parse_cfmws, &arg);
+
+	if (arg.overlaps)
+		return true;
+
+	return false;
+}
+
+int insert_soft_reserve_resource(struct resource *res)
+{
+	if (resource_overlaps_cfmws(res)) {
+		pr_info("Reserving Soft Reserve %pr\n", res);
+		return insert_resource(&srmem_resource, res);
+	}
+
+	return insert_resource(&iomem_resource, res);
+}
+EXPORT_SYMBOL(insert_soft_reserve_resource);
+
 static void __init
 __reserve_region_with_split(struct resource *root, resource_size_t start,
 			    resource_size_t end, const char *name)
-- 
2.43.0

