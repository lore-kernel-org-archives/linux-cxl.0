Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F08E6DCE3
	for <linux-cxl@vger.kernel.org>; Thu, 16 May 2024 08:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715847155; cv=fail; b=mg3ryuTaAmxnNb8mg+Qz2eQVyjkGw8mvLehGSeHyfdQPIA6Sy9R+Y9iHq3/5KpJ6t0bE7MPiXy2PiveE7J8x+SkuSj8hzl5W4NW8vvsUjH3ccoieM1Drs2qkUD1F0GyVlj3A6DnHbrTmYtM6biG8/dVsqoA7sBD034UYllXKOyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715847155; c=relaxed/simple;
	bh=tCqLT0SoYMQus09BOqacnF1AJxUoKYIXDjtpqTsjYtI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f73eZR5EfrHCDOZIt8Nj5o26ItF9kFewk1KdBzFbyZh1cc87KPJFQIMbutqlymy1Dfj/Uc6EN+dQvac0F1T90Asp72KKMA1Sc4/M3xixmSKpSyv8kooj8aMVTK7uVe4HsdK3pEisUu7feUTeD/dnwCmTaZTFT9CPZPKm50xZdfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BT9N5D04; arc=fail smtp.client-ip=40.107.243.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BT9N5D04"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jty1BRusGiFSB5Kvnv6rXCyP7ySbSQW7w4w/96hw7sP3oLDa4s8MizgrmApHDaDFjpUm8TKHBU4TFpXdVpPdrDuBQH/hFpSTwa3iS0k20pv3qFovP7SGtQoIEa1mIgFJWh2ZY5JOuNLhl9VDpG9xuSsFfs4pCxOZFRzqCh/1OsguOrPq8L+h9IYGxv9QGK1EIrF++R7rUyiOJH3SI6iXJIhPd3QA1TQ0GCIepOdA2l+MHCTxYUo2W0JL4Evzg5xr7MEBxS5ct650baMIoI9m4rOqRcF8m4jeJcurhrQp4UeCm8C+l6MGUcwzvROQCsQZIY7C1Rox7SEdXDNrP/ItsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3yxDj4NnejIpoplpXR0m5pKsGMQ4eEXMkPk/rqHgz8k=;
 b=OqoA+4QPeN0ZVITxBumk8Qac19uuZngBFx7j2HHl0ffJWk9toqmKeKDRtpKXrt4wm96jqltDmYAqKVxtzQe6QhSWcbdhOM+hxO9HayFKYvwlM6d2C9Pv0SgmNJJyCZaSyKtEJXAivGdHyk1kIKZ7c+5383ElhINijeMlDWJ+8x5f7BN9hxtmi2jEqWVAt+ep7vVnxsglVmt0WpL14vzMq/lsfr4WpaVJPv9ljWCsAJhgVUA27g0EhxSsFcynJfFrUkSgdkekYzF3SvnO9H+SHFq7HIpgPuhsaSCNUwhaqgz9dk+fcIfh2HrcETgr095eIL5QP8KernqtolemzOINHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3yxDj4NnejIpoplpXR0m5pKsGMQ4eEXMkPk/rqHgz8k=;
 b=BT9N5D04YKRC2aGbFWyioBoO4Uokto8Ttn4k3KSgaDGT4Fd/mS8za1SFtoNfVYkJJfuZ5pqk7KLDb8WJigqNjBoZr3KZQmTGlqgXhea5dISTkQRgTZwj13DMQ5Lbd3gljQGvChfxZ+0kyf72rPf+mzXjn6Vd/AjIlxSx73qHXQU=
Received: from BN9PR03CA0502.namprd03.prod.outlook.com (2603:10b6:408:130::27)
 by PH8PR12MB6844.namprd12.prod.outlook.com (2603:10b6:510:1cb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Thu, 16 May
 2024 08:12:29 +0000
Received: from BN2PEPF000044A8.namprd04.prod.outlook.com
 (2603:10b6:408:130:cafe::f6) by BN9PR03CA0502.outlook.office365.com
 (2603:10b6:408:130::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55 via Frontend
 Transport; Thu, 16 May 2024 08:12:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044A8.mail.protection.outlook.com (10.167.243.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Thu, 16 May 2024 08:12:29 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 16 May
 2024 03:12:25 -0500
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 16 May 2024 03:12:24 -0500
From: <alucerop@amd.com>
To: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<pieter.jansen-van-vuuren@amd.com>, <richard.hughes@amd.com>,
	<dinan.gunawardena@amd.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [RFC PATCH 09/13] cxl: add cxl_request_dpa
Date: Thu, 16 May 2024 09:11:58 +0100
Message-ID: <20240516081202.27023-10-alucerop@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240516081202.27023-1-alucerop@amd.com>
References: <20240516081202.27023-1-alucerop@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: alucerop@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A8:EE_|PH8PR12MB6844:EE_
X-MS-Office365-Filtering-Correlation-Id: b28783f2-2146-451c-6cfe-08dc757fedeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|1800799015|376005|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ax3BLshqly1zP3JOpmySGkj+aZQIYgYTEq5Zn2awjQ1GOqWJxmlIgSimyl0N?=
 =?us-ascii?Q?1PUfvoTE0XdfZGLwClh1nYa/C6H2FczDas4f4R67vSQgFCD7V4U0OnaoiN3b?=
 =?us-ascii?Q?z0BtPiIKo1Sw/1r+u3V8G1GDEEVqar9/G+5PJV7Omt1wmch2juPdhE2RM8ae?=
 =?us-ascii?Q?wbGRlt9xjSODuONbjwBTdJ9Rm/gqHblzp8vy516jvY2YZbVgZKrCi5jfaunM?=
 =?us-ascii?Q?Z7sIYfmBOx4k6V10hvyuRlYaVu4UgkiNOnHd0ektCsKtuLnXkbnAs/pJ9rmw?=
 =?us-ascii?Q?PQ9TM+cNeJQX2r+1+eMyStL9/EoSScB9X0Vvomvjfbac812ms+Dg7tL8fl2J?=
 =?us-ascii?Q?gFy7M+CmXEIa1cfUrS4hVc1zHvdwuC3+5fX6ubCuRP9qQCio+MiHGe9fPVsT?=
 =?us-ascii?Q?Ir5a3kA6w5HOjAYW8gEks6zwE6bXOjaVqDmUrcGnm57fazlJcR+2ZTc21EmY?=
 =?us-ascii?Q?2g5TF4DB9qmZ3BQmJ8z+gJ0DlhQTX2Kryh0Xax9txMHTAIa4bZQBye3p7qbi?=
 =?us-ascii?Q?sGQK5J04QhfnO0S4N1KTMfIob/PgCEzhV3kb0L0T3uSQ5YFtkUiC68HQHf4u?=
 =?us-ascii?Q?ugM/YT2/55JNek44iGKvASS8XjlYuFfwi0jYNMxEmrGWPpRaatPC1zfeBVxd?=
 =?us-ascii?Q?Xr9T/jjzGphXI7n7A9iCkacEUqjELUfM24MUxjFXI2OZtLyfVnmDqs0xgpnb?=
 =?us-ascii?Q?IsGb1CMD5Mzf2ReAPxHxBTCtowLnfcT14vGKkVnfjxbdKW8e/SzmX72WEbf6?=
 =?us-ascii?Q?s3gKWlilBW+gddipF08nOdAg0FJGlDQIp7EgLF5MQOLaM6+UED1+SUU6/ZQU?=
 =?us-ascii?Q?LQi1eKZ7qsMnrTJsl1Hf/4uUnq8L4yCH6/TBUldy6Q4MiLGO7qOWXtoe4y1o?=
 =?us-ascii?Q?ZWFLzStZmuU/uYI9K0RCXpfrW9yJpYlaR3r0heTJpFHXM/G2x5YO1N+ISdOM?=
 =?us-ascii?Q?N4+8A+6sSs4QcWUhm3UccG9tqp99+XvYuV+50JL0KP6s7Tln3l/D+DE6AjIS?=
 =?us-ascii?Q?B2ifAqNA8keyj5AYSrz4UdGs8Rl9K/4Tyv2+5N1MInx8EZJbIzZCrqVuaBbq?=
 =?us-ascii?Q?Q/d+35ZGLBMWpK65qI5zOCrA/xXqUvhKOsvzu3Yfo7uhVEUZpUyNppE4MQQg?=
 =?us-ascii?Q?osMIIsDIpSevzYPdUgtv7dMd8R8Q2HHQHGYoQKTAJWiRUCOW3+2GS7QKimZB?=
 =?us-ascii?Q?hGOeLktWdxhwLz5PnIv94n4dDzCERX+ZY90DjC7m31ynWa4foZM4A6nkRHze?=
 =?us-ascii?Q?8EilsPdQQQY9tlFUaz71BKn/0xLO/mNI/itA0lX3ywWFro/ho25UeLcuHj7Q?=
 =?us-ascii?Q?utY+GS8GO9m3ugCrcEo+upB4yovWDNm+aiRbniW/5gX+I71YzFqclhzTjMIS?=
 =?us-ascii?Q?IYB1MzovFcuE7CMTqfmu6v2lw28R?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(376005)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 08:12:29.2224
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b28783f2-2146-451c-6cfe-08dc757fedeb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6844

From: Alejandro Lucero <alucerop@amd.com>

Search and reserve DPA given input constraints.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/core.h             |   1 -
 drivers/cxl/core/hdm.c              | 153 +++++++++++++++++++++++-----
 include/linux/cxlmem.h              |   5 +
 tools/testing/cxl/type2/pci_type2.c |  12 ++-
 4 files changed, 145 insertions(+), 26 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index bc5a95665aa0..c0a2e2c1ccb3 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -61,7 +61,6 @@ struct dentry *cxl_debugfs_create_dir(const char *dir);
 int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
 		     enum cxl_decoder_mode mode);
 int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size);
-int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
 resource_size_t cxl_dpa_size(struct cxl_endpoint_decoder *cxled);
 resource_size_t cxl_dpa_resource_start(struct cxl_endpoint_decoder *cxled);
 
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index c5f70741d70a..6459b6ecde88 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -404,6 +404,7 @@ int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
 	up_write(&cxl_dpa_rwsem);
 	return rc;
 }
+EXPORT_SYMBOL_NS_GPL(cxl_dpa_free, CXL);
 
 int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
 		     enum cxl_decoder_mode mode)
@@ -451,30 +452,17 @@ int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
 	return rc;
 }
 
-int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
+static resource_size_t cxl_dpa_freespace(struct cxl_endpoint_decoder *cxled,
+					 resource_size_t *start_out,
+					 resource_size_t *skip_out)
 {
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 	resource_size_t free_ram_start, free_pmem_start;
-	struct cxl_port *port = cxled_to_port(cxled);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
-	struct device *dev = &cxled->cxld.dev;
 	resource_size_t start, avail, skip;
 	struct resource *p, *last;
-	int rc;
-
-	down_write(&cxl_dpa_rwsem);
-	if (cxled->cxld.region) {
-		dev_dbg(dev, "decoder attached to %s\n",
-			dev_name(&cxled->cxld.region->dev));
-		rc = -EBUSY;
-		goto out;
-	}
 
-	if (cxled->cxld.flags & CXL_DECODER_F_ENABLE) {
-		dev_dbg(dev, "decoder enabled\n");
-		rc = -EBUSY;
-		goto out;
-	}
+	lockdep_assert_held(&cxl_dpa_rwsem);
 
 	for (p = cxlds->ram_res.child, last = NULL; p; p = p->sibling)
 		last = p;
@@ -496,7 +484,6 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
 		skip = 0;
 	} else if (cxled->mode == CXL_DECODER_PMEM) {
 		resource_size_t skip_start, skip_end;
-
 		start = free_pmem_start;
 		avail = cxlds->pmem_res.end - start + 1;
 		skip_start = free_ram_start;
@@ -506,21 +493,50 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
 		 * already handled the skip.
 		 */
 		if (cxlds->pmem_res.child &&
-		    skip_start == cxlds->pmem_res.child->start)
+				skip_start == cxlds->pmem_res.child->start)
 			skip_end = skip_start - 1;
 		else
 			skip_end = start - 1;
 		skip = skip_end - skip_start + 1;
 	} else {
-		dev_dbg(dev, "mode not set\n");
-		rc = -EINVAL;
+		avail = 0;
+	}
+
+	if (!avail)
+		return 0;
+	if (start_out)
+		*start_out = start;
+	if (skip_out)
+		*skip_out = skip;
+	return avail;
+}
+
+int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
+{
+	struct cxl_port *port = cxled_to_port(cxled);
+	struct device *dev = &cxled->cxld.dev;
+	resource_size_t start, avail, skip;
+	int rc;
+
+	down_write(&cxl_dpa_rwsem);
+	if (cxled->cxld.region) {
+		dev_dbg(dev, "EBUSY, decoder attached to %s\n",
+			     dev_name(&cxled->cxld.region->dev));
+		rc = -EBUSY;
 		goto out;
 	}
 
+	if (cxled->cxld.flags & CXL_DECODER_F_ENABLE) {
+		dev_dbg(dev, "EBUSY, decoder enabled\n");
+		rc = -EBUSY;
+		goto out;
+	}
+
+	avail = cxl_dpa_freespace(cxled, &start, &skip);
 	if (size > avail) {
 		dev_dbg(dev, "%pa exceeds available %s capacity: %pa\n", &size,
-			cxled->mode == CXL_DECODER_RAM ? "ram" : "pmem",
-			&avail);
+			     cxled->mode == CXL_DECODER_RAM ? "ram" : "pmem",
+			     &avail);
 		rc = -ENOSPC;
 		goto out;
 	}
@@ -532,9 +548,98 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
 	if (rc)
 		return rc;
 
-	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
+        return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
 }
 
+static int find_free_decoder(struct device *dev, void *data)
+{
+	struct cxl_endpoint_decoder *cxled;
+	struct cxl_port *port;
+
+	if (!is_endpoint_decoder(dev))
+		return 0;
+
+	cxled = to_cxl_endpoint_decoder(dev);
+	port = cxled_to_port(cxled);
+
+	if (cxled->cxld.id != port->hdm_end + 1) {
+		return 0;
+	}
+	return 1;
+}
+
+/**
+ * cxl_request_dpa - search and reserve DPA given input constraints
+ * @endpoint: an endpoint port with available decoders
+ * @mode: DPA operation mode (ram vs pmem)
+ * @min: the minimum amount of capacity the call needs
+ * @max: extra capacity to allocate after min is satisfied
+ *
+ * Given that a region needs to allocate from limited HPA capacity it
+ * may be the case that a device has more mappable DPA capacity than
+ * available HPA. So, the expectation is that @min is a driver known
+ * value for how much capacity is needed, and @max is based the limit of
+ * how much HPA space is available for a new region.
+ *
+ * Returns a pinned cxl_decoder with at least @min bytes of capacity
+ * reserved, or an error pointer. The caller is also expected to own the
+ * lifetime of the memdev registration associated with the endpoint to
+ * pin the decoder registered as well.
+ */
+struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_port *endpoint,
+					     enum cxl_decoder_mode mode,
+					     resource_size_t min,
+					     resource_size_t max)
+{
+	struct cxl_endpoint_decoder *cxled;
+	struct device *cxled_dev;
+	resource_size_t alloc;
+	int rc;
+
+	if (!IS_ALIGNED(min | max, SZ_256M))
+		return ERR_PTR(-EINVAL);
+
+	down_read(&cxl_dpa_rwsem);
+
+	cxled_dev = device_find_child(&endpoint->dev, NULL, find_free_decoder);
+	if (!cxled_dev)
+		cxled = ERR_PTR(-ENXIO);
+	else
+		cxled = to_cxl_endpoint_decoder(cxled_dev);
+
+	up_read(&cxl_dpa_rwsem);
+
+	if (IS_ERR(cxled)) {
+               return cxled;
+	}
+
+	rc = cxl_dpa_set_mode(cxled, mode);
+	if (rc)
+		goto err;
+
+	down_read(&cxl_dpa_rwsem);
+	alloc = cxl_dpa_freespace(cxled, NULL, NULL);
+	up_read(&cxl_dpa_rwsem);
+
+	if (max)
+		alloc = min(max, alloc);
+	if (alloc < min) {
+		rc = -ENOMEM;
+		goto err;
+	}
+
+	rc = cxl_dpa_alloc(cxled, alloc);
+	if (rc)
+		goto err;
+
+	return cxled;
+err:
+	put_device(cxled_dev);
+	return ERR_PTR(rc);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_request_dpa, CXL);
+
+
 static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
 {
 	u16 eig;
diff --git a/include/linux/cxlmem.h b/include/linux/cxlmem.h
index 342ccd5486d3..caf1cd86421c 100644
--- a/include/linux/cxlmem.h
+++ b/include/linux/cxlmem.h
@@ -870,4 +870,9 @@ struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_port *endpoint,
 					   int interleave_ways,
 					   unsigned long flags,
 					   resource_size_t *max);
+struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_port *endpoint,
+					     enum cxl_decoder_mode mode,
+					     resource_size_t min,
+					     resource_size_t max);
+int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
 #endif /* __CXL_MEM_H__ */
diff --git a/tools/testing/cxl/type2/pci_type2.c b/tools/testing/cxl/type2/pci_type2.c
index deb5eeae501b..6499d709f54d 100644
--- a/tools/testing/cxl/type2/pci_type2.c
+++ b/tools/testing/cxl/type2/pci_type2.c
@@ -4,6 +4,7 @@
 #include <linux/cxlpci.h>
 #include <linux/cxlmem.h>
 
+struct cxl_endpoint_decoder *cxled;
 struct cxl_root_decoder *cxlrd;
 struct cxl_dev_state *cxlds;
 struct cxl_memdev *cxlmd;
@@ -99,6 +100,15 @@ static int type2_pci_probe(struct pci_dev *pci_dev,
 		goto out;
 	}
 
+	pci_info(pci_dev, "cxl request_dpa...");
+	cxled = cxl_request_dpa(endpoint, CXL_DECODER_RAM, CXL_TYPE2_MEM_SIZE,
+				CXL_TYPE2_MEM_SIZE);
+	if (IS_ERR(cxled)) {
+		dev_dbg(&pci_dev->dev, "cxl_request_dpa error\n");
+		rc = PTR_ERR(cxled);
+		goto out;
+	}
+
 out:
 	cxl_release_endpoint(cxlmd, endpoint);
 
@@ -107,7 +117,7 @@ static int type2_pci_probe(struct pci_dev *pci_dev,
 
 static void type2_pci_remove(struct pci_dev *pci_dev)
 {
-
+	cxl_dpa_free(cxled);
 }
 
 /* PCI device ID table */
-- 
2.17.1

