Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012030.outbound.protection.outlook.com [40.107.200.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120342DFA25
	for <linux-cxl@vger.kernel.org>; Thu, 23 Apr 2026 17:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776965161; cv=fail; b=bS4JNLL9uUFGq+JfgACHHagjbVlcmgNFdZLxTip6aDATssP9Lfu3Pwe3HwbqIJnkZGAarXFmxBOqJMs9nN8S+XnKIR22EM997zGqKFMSCTxkzpAw9S7AaywuUmSjk9pYfOSrppGjWUkjy4uVrR5HfD0K/q9SucjSj72vlovcJMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776965161; c=relaxed/simple;
	bh=NDz/1jqk6QUFwU618BBwJbvHFVIJs95fgDLXJmlftUk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VoOCglT/07x5w/v0ERe/pJU6B0OTTmjc/0NUOD9fezsBx/nt6jePeJa0v2WmpINQ6V+XU4T/wlw7w141uz+xYAFKQUhr/FNCqRMHtUBteUl4fIDlBFXtHDMaocKZ3Yn7XULbZlz9XnXb9KomdzUqGRj0qUVMRP3X8ozn6tsFOFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CojV1aQB; arc=fail smtp.client-ip=40.107.200.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CojV1aQB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RxDLqhko6gJ2IpAmBUA1P1iXgH9+PrmScHLY3SPldPcNJzyU7GTnw0CqSwG4Bx9FngFY8Bq9TbUKKMc2426kxMLNO91cmdYvty8Fv1w2BiwRbTJ2Kw4Xttl8OKmQ+W8nqL1dLLfVhdYjCPP6vbKQhwfJXW+7U9jmJTIGEUx4ymQacUcp8xpphTItJkK8kpZIfBO/qlOfFIdK+X5ym2m9qtBHglL8yo4VLv5yb1m7Xdtrif8VKnWX5fVBGmpEubLvVSWfR+apfCxnilZk2GO1ZbJ2eLAdWn2SwMQa0KdGe+wHfVQznpWf7eRjyc2cscKBCfWWwDCvaIc01lbkhfiLtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RICN5WF5RvxhGbjRu3ofhmtrJ+uYciAIKBHfj+4wM8Y=;
 b=CtG6QTvRS0vZLNTCM80gU8a4aov4DoNgqjaHb7GiX4mUKU7wKBdiGECZVjclVIa59hj50WIvTto3z5wEk2B4hqpHim7JIDUGZ4c1Ce9RVoagu7o0gCP4/5n9YE6UFqBNDyQ3D/QMTPguP9wY3hhrhqrdv5za++z2WWJIkmoUPtCAqQNUtpTuQJrYe5PlDSt6aTDfQ4/cYIzFqpz3P179fcNQpcg5zwDYUjsClL+Yyq8VbW2r432SRhaNscIZQYl/eDOwYtlL3wlTrtBBZloW02qUGm9xc8GV2MP4BlaZ/orOu1F4zqBVm1lMF4YL7VPVCj61/XNVdzy2pFJhKxtw6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RICN5WF5RvxhGbjRu3ofhmtrJ+uYciAIKBHfj+4wM8Y=;
 b=CojV1aQBRJalVURcTL7NpFUlsGbtKMOvtcO97x4bbgsBZF5QWNWpt07BRWF3JgnFc1jvZxh4YUJZdZIRwGl+97GCmxEIykj/ly+LWed21YlzRyxv8pGA5gOAK48k3WeYU0QC/7D3DTv+2gRso+bQzPK552pMTQpZHsyfEAecEYw=
Received: from BN1PR12CA0012.namprd12.prod.outlook.com (2603:10b6:408:e1::17)
 by MW6PR12MB8951.namprd12.prod.outlook.com (2603:10b6:303:244::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.20; Thu, 23 Apr
 2026 17:25:53 +0000
Received: from BN1PEPF0000467F.namprd03.prod.outlook.com
 (2603:10b6:408:e1:cafe::66) by BN1PR12CA0012.outlook.office365.com
 (2603:10b6:408:e1::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.21 via Frontend Transport; Thu,
 23 Apr 2026 17:25:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000467F.mail.protection.outlook.com (10.167.243.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Thu, 23 Apr 2026 17:25:48 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 23 Apr
 2026 12:25:34 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 23 Apr
 2026 12:25:34 -0500
Received: from galena-46a8.xcblab.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 23 Apr 2026 12:25:33 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <djbw@kernel.org>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v26 6/8] cxl: attach region to an accelerator/type2 memdev
Date: Thu, 23 Apr 2026 19:05:26 +0100
Message-ID: <20260423180528.17166-7-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260423180528.17166-1-alejandro.lucero-palau@amd.com>
References: <20260423180528.17166-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000467F:EE_|MW6PR12MB8951:EE_
X-MS-Office365-Filtering-Correlation-Id: 805ef175-de61-48cc-7a45-08dea15d5c01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|30052699003|1800799024|36860700016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	y6CdfToBrs4PJJIEg08NIeLYy/5ktCXnmoqjKq8FDDdj/G8WTXLJZATzfevAQNw2R54WqC6S0ogxBP8U3A+dAbErBUOxGL8VaJJprbaLOM7bLvmzyv5knXIbwxOlAH5oe9G63y4eZ7MAFRYBqBnEvpNOlNg6EeEJjmiwoRK0kXU9zpzGN/Vms1jW3pRw0kAEbil1kKsXhwVTncKtttak4VdmzIyYqjuijODzWWn9v9XepVevIyLprbrm2bnvz+2RpVNLC5oE0/OCx0mplo9ag9GS6HP7AItYRqz+2/TixkqUSkKYaGcyODMEIsdzD45xfOSMMsaZR61V9bj3XsPU3DEkCrOGUEdcp2MFUiH2dc0Kmp+Ke1jKN4/LEDZtqi469nebRziMFckKiVLRSsou63dIRGia+MM1BHFpLY7TMS2enslWS7E4y3J3NC8ilcJWDD+Ps6jXUOnNoq20DzdVvGC2Y/d7RjqMYNaY6JGt/054d5DYOXnM5+qMmWh65mf5T3ZAaQU3P3fmXOEVD+5SeMYVWRfTvTG8Icsrce+Ibj2EnffFIwsgpTX7cevfVdLtoSUj5lKQQV9+FLyAV4HSk3OhlwX1lQfXkKm5j6if/2yZshSB/OYN7pKNXyTwE6uoc2VQkpwFkGQvLBo9zthSDQvgBv+e/Loxe73FsLiJATZ/jfvpsehXAMyQ05cZMThrlQHJZH9Jf1ZlOS7tOJqc1yX2duSuqUycSbYpWa4bGC9Eji8l6EiUID9JaCv4cnsdpeFQZwoLCiKU0u+i7PfvOA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(30052699003)(1800799024)(36860700016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	x0GIxDJXRcH+bXh8OBYb4V0MWsRsQ5lJLzzHAnUZ453R5LCwweYGzZMMPoEeh3klyJQrLhQGbD/UYNcm/4WxoNwaX5SEDeTYx6Bx/X3ERES9V+POp2WVUkqi8aUTb4jqxZLIDaKlR1KSbNcsc594CH8gTQ39AQ/o7GkyFSpl+H2KHkerCas6OP+IGgHflsrSn6BuTmYHKY959H31U1FtJgtLu2TODE3qCtbRhDroZIVsi803a7I5DJOtv1W7lYj3UurFWee2fn+4FN6zqIcIFXG0xKKSQAzju3uIcMKIWkrlY1vLCpMY5u6bGFIU4jL5quI8quzKbjwOCvQeDBBhko/ETDmi9+/kMNtSp51YutOdthd9rROIHk9Xqr6eUJS93vtQ5GDvwRJBBOl6kBfgivbCIH0G7TaTJtwCsuaS3B0m+kA66zMBmuE29j0+LYB1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 17:25:48.0385
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 805ef175-de61-48cc-7a45-08dea15d5c01
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000467F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8951

From: Alejandro Lucero <alucerop@amd.com>

Support an accelerator driver to safely work with an autodiscovered
region from a committed HDM decoder through:

        1) an accelerator driver cxl_attach_region struct with attach
           and detach callbacks.

        2) a specific function, cxl_memdev_attach_region() keeping the
           required locks for finding a region linked to the memdev
           endpoint, and

        3) invoking attach callback while keeping the locking allowing to
           work (ioremap and other internal stuff) with the related physical
           range by the accelerator driver, and

        4) linking a detach callback to the endpoint device removal where
           the accelerator driver can stop using the region range.

This covers the cases of a potential removal of cxl_acpi module or a
accelerator memdev unbinding from cxl_mem driver through sysfs.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/region.c          | 118 ++++++++++++++++++++++++++++-
 drivers/net/ethernet/sfc/efx_cxl.c |  37 +++++++++
 drivers/net/ethernet/sfc/efx_cxl.h |   2 +
 include/cxl/cxl.h                  |  17 +++++
 4 files changed, 171 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index e50dc716d4e8..68f5a1fd1b1c 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2711,9 +2711,16 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
 	if (rc)
 		goto err;
 
-	rc = devm_add_action_or_reset(port->uport_dev, unregister_region, cxlr);
-	if (rc)
-		return ERR_PTR(rc);
+	/*
+	 * For accelerators/type2, region release linked to endpoint device.
+	 * See handling of cxl_endpoint_region_autoremove() below by
+	 * cxl_memdev_attach_region().
+	 */
+	if (type == CXL_DECODER_HOSTONLYMEM) {
+		rc = devm_add_action_or_reset(port->uport_dev, unregister_region, cxlr);
+		if (rc)
+			return ERR_PTR(rc);
+	}
 
 	dev_dbg(port->uport_dev, "%s: created %s\n",
 		dev_name(&cxlrd->cxlsd.cxld.dev), dev_name(dev));
@@ -4043,6 +4050,111 @@ static int cxl_region_can_probe(struct cxl_region *cxlr)
 	return 0;
 }
 
+static int first_mapped_decoder(struct device *dev, const void *data)
+{
+	struct cxl_endpoint_decoder *cxled;
+
+	if (!is_endpoint_decoder(dev))
+		return 0;
+
+	cxled = to_cxl_endpoint_decoder(dev);
+	if (cxled->cxld.region)
+		return 1;
+
+	return 0;
+}
+
+/*
+ * As this is running in endpoint port remove context it does not race cxl_root
+ * destruction since port topologies are always removed depth first.
+ */
+static void cxl_endpoint_region_autoremove(void *_cxlr)
+{
+	unregister_region(_cxlr);
+}
+
+/**
+ * cxl_memdev_attach_region - bind region to accelerator memdev
+ *
+ * @cxlmd: a pointer to cxl_memdev to use
+ * @attach: a pointer to region attach struct with callbacks for
+ * 	    safely working with a region range by the caller
+ *
+ * Returns 0 or error.
+ */
+int cxl_memdev_attach_region(struct cxl_memdev *cxlmd,
+			     struct cxl_attach_region *attach)
+{
+	struct cxl_port *endpoint = cxlmd->endpoint;
+	struct cxl_endpoint_decoder *cxled;
+	struct cxl_region *cxlr;
+	int rc;
+
+	/* hold endpoint lock to setup autoremove of the region */
+	guard(device)(&endpoint->dev);
+	if (!endpoint->dev.driver)
+		return -ENXIO;
+	guard(rwsem_read)(&cxl_rwsem.region);
+	guard(rwsem_read)(&cxl_rwsem.dpa);
+
+	/*
+	 * TODO auto-instantiate a region, for now assume this will find an
+	 * auto-region
+	 */
+	struct device *dev __free(put_device) =
+		device_find_child(&endpoint->dev, NULL, first_mapped_decoder);
+
+	if (!dev) {
+		dev_dbg(cxlmd->cxlds->dev, "no region found for memdev %s\n",
+			dev_name(&cxlmd->dev));
+		return -ENXIO;
+	}
+
+	cxled = to_cxl_endpoint_decoder(dev);
+	cxlr = cxled->cxld.region;
+
+	if (cxlr->params.state < CXL_CONFIG_COMMIT) {
+		dev_dbg(cxlmd->cxlds->dev,
+			"region %s not committed for memdev %s\n",
+			dev_name(&cxlr->dev), dev_name(&cxlmd->dev));
+		return -ENXIO;
+	}
+
+	if (cxlr->params.nr_targets > 1) {
+		dev_dbg(cxlmd->cxlds->dev,
+			"Only attach to local non-interleaved region\n");
+		return -ENXIO;
+	}
+
+	attach->region = (struct range) {
+		.start = cxlr->params.res->start,
+		.end = cxlr->params.res->end,
+	};
+
+	/*
+	 * With endpoint locked leave the caller to safely work with the region
+	 * range.
+	 */
+	rc = attach->attach(attach->data);
+	if (rc)
+		return rc;
+
+	/* Only teardown regions that pass validation, ignore the rest */
+	rc = devm_add_action_or_reset(&endpoint->dev,
+				      cxl_endpoint_region_autoremove, cxlr);
+	if (rc)
+		return rc;
+
+	/* Link type2 driver callback for stopping use of the region range. */
+	rc = devm_add_action_or_reset(&endpoint->dev,
+				      attach->detach, attach->data);
+	if (rc)
+		return rc;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_memdev_attach_region, "CXL");
+
 static int cxl_region_probe(struct device *dev)
 {
 	struct cxl_region *cxlr = to_cxl_region(dev);
diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 7d8a6c2133c8..9ca16b051d62 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -14,6 +14,36 @@
 
 #define EFX_CTPIO_BUFFER_SIZE	SZ_256M
 
+/* Called with cxl endpoint device locked for precluding potential related
+ * cxl region removal triggered from user space, allowing safely mapping of
+ * such cxl region by the sfc driver.
+ */
+static int efx_cxl_map_region(void *data) {
+	struct efx_probe_data *probe_data = data;
+	struct efx_nic *efx = &probe_data->efx;
+	struct pci_dev *pci_dev = efx->pci_dev;
+	struct efx_cxl *cxl = probe_data->cxl;
+	struct range *cxl_pio_range = &cxl->attach_region.region;
+
+	cxl->ctpio_cxl = ioremap(cxl_pio_range->start,
+				 cxl_pio_range->end - cxl_pio_range->start + 1);
+	if (!cxl->ctpio_cxl) {
+		pci_err(pci_dev, "CXL ioremap region (%pra) failed\n",
+				 cxl_pio_range);
+		return -ENOMEM;
+	}
+	probe_data->cxl_pio_initialised = true;
+	return 0;
+}
+
+/* Called at driver exit or when user space triggers cxl region removal. */
+static void efx_cxl_unmap_region(void *data) {
+	struct efx_probe_data *probe_data = data;
+
+	probe_data->cxl_pio_initialised = false;
+	iounmap(probe_data->cxl->ctpio_cxl);
+}
+
 int efx_cxl_init(struct efx_probe_data *probe_data)
 {
 	struct efx_nic *efx = &probe_data->efx;
@@ -81,6 +111,13 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 		return PTR_ERR(cxl->cxlmd);
 	}
 
+	probe_data->cxl->attach_region.attach = efx_cxl_map_region;
+	probe_data->cxl->attach_region.detach = efx_cxl_unmap_region;
+	probe_data->cxl->attach_region.data = probe_data;
+
+	cxl_memdev_attach_region(cxl->cxlmd,
+				 &probe_data->cxl->attach_region);
+
 	probe_data->cxl = cxl;
 
 	return 0;
diff --git a/drivers/net/ethernet/sfc/efx_cxl.h b/drivers/net/ethernet/sfc/efx_cxl.h
index 04e46278464d..1c294cd1df56 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.h
+++ b/drivers/net/ethernet/sfc/efx_cxl.h
@@ -20,6 +20,8 @@ struct efx_probe_data;
 struct efx_cxl {
 	struct cxl_dev_state cxlds;
 	struct cxl_memdev *cxlmd;
+	struct cxl_attach_region attach_region;
+	void __iomem *ctpio_cxl;
 };
 
 int efx_cxl_init(struct efx_probe_data *probe_data);
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 10a9b8fa2f6b..22d9435b351f 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -7,6 +7,7 @@
 
 #include <linux/node.h>
 #include <linux/ioport.h>
+#include <linux/pci.h>
 #include <cxl/mailbox.h>
 
 /**
@@ -153,6 +154,20 @@ struct cxl_memdev_attach {
 	int (*probe)(struct cxl_memdev *cxlmd);
 };
 
+/**
+ * struct cxl_attach_region - accelerator region handling
+ * @attach: invoked at cxl_memdev_attach_region() with endpoint device locked.
+ * @detach: invoked at endpoint release.
+ * @data: pointer referencing accelerator data for attach and detach calls.
+ * @region: initialised with autodiscovered region values linked to memdev.
+ */
+struct cxl_attach_region {
+	int (*attach)(void *);
+	void (*detach)(void *);
+	void *data;
+	struct range region;
+};
+
 /**
  * struct cxl_dev_state - The driver device state
  *
@@ -231,4 +246,6 @@ struct cxl_dev_state *_devm_cxl_dev_state_create(struct device *dev,
 int cxl_set_capacity(struct cxl_dev_state *cxlds, u64 capacity);
 struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds,
 				       const struct cxl_memdev_attach *attach);
+struct cxl_region;
+int cxl_memdev_attach_region(struct cxl_memdev *cxlmd, struct cxl_attach_region *attach);
 #endif /* __CXL_CXL_H__ */
-- 
2.34.1

