Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAD726E15D
	for <linux-cxl@vger.kernel.org>; Tue, 12 Aug 2025 21:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755034309; cv=fail; b=Rxwup1GZFY+LZGdSKwzOWdFdc5luC155XIswR/aL13RX7kYtd+qwEuLyXDvGRBJUpoMtCmdHlVB5BgXDy4wvpDpY2SJfEJruMpG4YessDudOF6LB+6MiWV/gCvJQUK8gslTwA0arDL7OuZL1vmez6KUPTvjBHFE64TODVj1+vCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755034309; c=relaxed/simple;
	bh=6TrI/QHld+BDRspS9S0Rt8zT5PbGjLhNpM4luqjeaSY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kV4GlOrWhZLX9IHX+YB6o+jiDYSZGm88txX9UmCJig3eF11bNK9KkmKHZY3KuzFsK4fr3ZxjNXZAaawljQWqVbWed3lPkgW/yIHzd09yjI54WzV4lOEYZJiyE5adpmHGqDLKGh1AlrYfICtD0fTsk1SBhaUQIgE3OEPvsbGcekk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aOa1hlzR; arc=fail smtp.client-ip=40.107.94.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aOa1hlzR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pVzgq90PVbbj2GPqzx/rmOhvYvW0ukaCuktak9YmZ4QVpB/mnS/uBzOvbn4+rm0GNkci6GAjEpqWZN7znyN47q91N++pYRpTsRmG7IQy2Pyo/TsOfsU9eIgezyPce3RGCy0JNdNVNe1j99JIvo3CpnZES+a83/vlrTgg/8NH45WXMYTezrIkEijQZKZYmHDn9TFm9/AF0siH9QGHrwbYSQe7AMT/kcXe6BkMhM+WzDKWWpxuN5X9WslueI1CrEST8Os7Dwg7JMNn3CmbIJXIIo7sRb5/bHkXUrvvu41oYz0nqpZSK1VcQ7Hv2/S++L4SiaJOWGPow/oyofV1dnLNwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wquvxQr119tD2Aoz+7p4wCwZTdfqrXjgIQfvC+8VDyE=;
 b=FBQZZKLPvVcLvzvJUNLZo3wI2A9NGNT5W41OfYEfV3aMMv+p35LqjxJ/mBNv1CeaIpfQcXAhiUc8ET4Or2KVZR7dl+h7hK+KUzkVbK262atVTDASk8wr/buOd+L06kjkKar4IJFyf9qL56VL7R06VY7PIK/ySckw7U72MXjyaRXNZKsC4+woRrIZm12n9lf92H/f57ildSr/AbnvX9+/oBy4lwNsTtwqw53DC1g7V1YzkSmmWMDc9oPvNwVsOS/9r7Mtmcr9rUHieEyJU2lyWOSppdR4acJ2nbG/ncSIGN5SoGwGVAIgKZAdDK1fV1S4V2+vnEFjh8PtL+8J8BFrxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wquvxQr119tD2Aoz+7p4wCwZTdfqrXjgIQfvC+8VDyE=;
 b=aOa1hlzRDshSov2jpMIt8e9KcPZQKyyqZcaGEsR9Xya14Gs2aeC2w5oUW7rXmqpaZbVIzOufLowr8uU+djAlU23IsSFg4R9MW1dFz1l54cmURsDOqyHWPoVaf9wBNMSYXTtpaMIdYH5XUxSrYSsjxadQmwBtboQqJ5K8113S1GQ=
Received: from CH2PR07CA0006.namprd07.prod.outlook.com (2603:10b6:610:20::19)
 by MN0PR12MB6269.namprd12.prod.outlook.com (2603:10b6:208:3c3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Tue, 12 Aug
 2025 21:31:44 +0000
Received: from DS3PEPF0000C37A.namprd04.prod.outlook.com
 (2603:10b6:610:20:cafe::8c) by CH2PR07CA0006.outlook.office365.com
 (2603:10b6:610:20::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.14 via Frontend Transport; Tue,
 12 Aug 2025 21:31:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37A.mail.protection.outlook.com (10.167.23.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Tue, 12 Aug 2025 21:31:44 +0000
Received: from SCS-L-bcheatha.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Aug
 2025 16:31:43 -0500
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <linux-cxl@vger.kernel.org>
CC: Ben Cheatham <Benjamin.Cheatham@amd.com>
Subject: [RFC PATCH 09/18] cxl/core: Add function for getting CXL cache info
Date: Tue, 12 Aug 2025 16:29:12 -0500
Message-ID: <20250812212921.9548-10-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250812212921.9548-1-Benjamin.Cheatham@amd.com>
References: <20250812212921.9548-1-Benjamin.Cheatham@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37A:EE_|MN0PR12MB6269:EE_
X-MS-Office365-Filtering-Correlation-Id: c2d2a627-80c6-42e4-ea99-08ddd9e7a292
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?c58ag7WMfm+1ncSv6z9vKeVtFwakLpVtoWkM7w7LoUMzZ7KxLzYEBGsjlACU?=
 =?us-ascii?Q?oan0VyM13b7zgGlJlTME6NEfJilkQwCp0APEyjOIzuIyyLkfPmP5TJirPJy4?=
 =?us-ascii?Q?AnaYTxD7U79IAdRENMARU9nUpRXmWUd17/UBYbEfuJzeMWmyhykM2VBJRYTf?=
 =?us-ascii?Q?ATZxDa1ChowQY75NpOaxCGS2ajyKNXPALp0tUZ5K3hOJpdPEDaDEf2yPo8qA?=
 =?us-ascii?Q?PsP1JxjBtRKQJPyD6u2trULgM/iHQMVKhuXZJ0LZwRaAW/tA8sduOccsIFPu?=
 =?us-ascii?Q?dVaHkWUsdPojnYIy0zGkmH8Fy2rMe6qhYzTP9JWr7N/CkXe9+IEZaHzNrsWC?=
 =?us-ascii?Q?26sE+FOiumX8YRoURYNbDEH2oXwSp3zawsn0AnJnCAAA0EU01EWM5ftoevaU?=
 =?us-ascii?Q?/3y3AdAk1+gmSbHhl6lfEhfxrWYkum7NM+/xPkYmANmmdT5jRStTDe92+FYT?=
 =?us-ascii?Q?gPKJVIIyVDz6tHzUK9re/n/w+6gYsyYpP9JoMRY8ZelgF63kvWOwpBbuqSn5?=
 =?us-ascii?Q?0pretEM6rkzIGzbJZBsH5/05Zr/4nPU8+ilqnCwqOlE/qvxllljCpxcAq2h3?=
 =?us-ascii?Q?5owqAteNERTKzHHEyNStySFlYDY/9npXrsCAO6PqvgYVWPGcQ3oFC6ALXm3Z?=
 =?us-ascii?Q?H0/R8aqfNCBWuBrc9NEaqdO+9EEeJjmF8W39rR0H7AItpZ108Y86AQtyrnNj?=
 =?us-ascii?Q?utVLxnmdnV5OjrlTrT87ZlvGRDnFIL5U5gwo/meFalOfvJOpglfoLSbH85I5?=
 =?us-ascii?Q?bUPAyGbEEWeReIGtLWkXAF1iAvrmJV0TYkUKu5Gzg/lc3+FZ+qA9bW0kyNu8?=
 =?us-ascii?Q?msGH1QLU9MrNEO5utAo+HlVe7VBzqOM+z7i6nhjYuppWC0j55cfmRnd8qKCw?=
 =?us-ascii?Q?N6KfYtQCu+D/IyZJS9Dwik/02sovR7TqnnhkJN0NYbVrmMaKTL9V/tUW4JaJ?=
 =?us-ascii?Q?cNijwqKtLlmKiMsd+t+xEJLQZmWmSrRBuLsBtLn7IbNRY6+yr459E8snzThy?=
 =?us-ascii?Q?kV7c/vkVqxNutRGYeOpFcRPSDAMzkar8BbubcRQGRQczuhotBSxsVB5rpUec?=
 =?us-ascii?Q?1aHjp5OL6JQQThOXJclgte0tQERRthLys6oKEyo69VjRAmDwW1PNH5Hh40gy?=
 =?us-ascii?Q?+3MSoCv4HKysylYzhIgiQm4fU3NBvjRNvXxbN87asQMpvOWj1aBt9N8xysu7?=
 =?us-ascii?Q?XFPaSxYMlsOThI4836ZDs25nHM9ud3kq203XWIvpLTk+xniHtKIYQriXZUlC?=
 =?us-ascii?Q?QUeiFkTf0n6fapob9K9BIWOjtKwA4qz2uncfkmAaJLI+TCSW8/lnV/h4IEIv?=
 =?us-ascii?Q?nCQltWOxaKpX4kqBnvzy846IGTCOvAl5d81dbWweUsPC2/MRG+Igqa4ShfrD?=
 =?us-ascii?Q?NGrtoIn8KMUvo3zljeeYL8SNDVdPeGaUFbPFETVLJNRaGVQLBjP2eafYb5RY?=
 =?us-ascii?Q?6mEUzNTZh1QfQXao/wFMl6r77utSQJ4T9f47kokabK3Q51klhBXEsOZQiwsR?=
 =?us-ascii?Q?EnFnS3qonC4Xxa4Ry+ixxUOawaAHs1ykUAnk?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 21:31:44.3868
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2d2a627-80c6-42e4-ea99-08ddd9e7a292
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6269

Add a function for getting common CXL.cache information. This
information will be stored in the struct cxl_cache_state member
(cinfo) of struct cxl_dev_state for easy access by endpoint drivers.

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 drivers/cxl/core/pci.c | 45 ++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h      |  7 +++++++
 drivers/cxl/cxlcache.h |  2 ++
 drivers/cxl/cxlpci.h   |  4 ++++
 4 files changed, 58 insertions(+)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 717e25131db7..2279c2690c59 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -7,6 +7,7 @@
 #include <linux/pci.h>
 #include <linux/pci-doe.h>
 #include <linux/aer.h>
+#include <cxlcache.h>
 #include <cxlpci.h>
 #include <cxlmem.h>
 #include <cxl.h>
@@ -1187,3 +1188,47 @@ int cxl_port_update_total_dports(struct cxl_port *port)
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_port_update_total_dports, "CXL");
+
+int cxl_accel_get_cache_info(struct cxl_dev_state *cxlds)
+{
+	struct cxl_cache_state *cstate = &cxlds->cstate;
+	struct pci_dev *pdev;
+	int dvsec, rc;
+	u16 cap, cap2;
+
+	if (!dev_is_pci(cxlds->dev))
+		return -EINVAL;
+	pdev = to_pci_dev(cxlds->dev);
+
+	dvsec = cxlds->cxl_dvsec;
+
+	rc = pci_read_config_word(pdev, dvsec + CXL_DVSEC_CAP_OFFSET, &cap);
+	if (rc)
+		return rc;
+
+	if (!(cap & CXL_DVSEC_CACHE_CAPABLE))
+		return -ENXIO;
+
+	rc = pci_read_config_word(pdev, dvsec + CXL_DVSEC_CAP2_OFFSET, &cap2);
+	if (rc)
+		return rc;
+
+	/* CXL 3.2 8.1.3.7 DVSEC CXL Capability2 for encoding */
+	switch (FIELD_GET(CXL_DVSEC_CACHE_UNIT_MASK, cap2)) {
+	case 1:
+		cstate->unit = 64;
+		break;
+	case 2:
+		cstate->unit = 1024;
+		break;
+	default:
+		return -ENXIO;
+	}
+
+	cstate->size = FIELD_GET(CXL_DVSEC_CACHE_SIZE_MASK, cap2) * cstate->unit;
+	if (!cstate->size)
+		return -ENXIO;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_accel_get_cache_info, "CXL");
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 0dc4e5c96459..1771c42a1e3b 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -753,6 +753,11 @@ struct cxl_dev_ops {
 	int (*probe)(struct device *cxldev);
 };
 
+struct cxl_cache_state {
+	u64 size;
+	u32 unit;
+};
+
 /**
  * struct cxl_dev_state - The driver device state
  *
@@ -774,6 +779,7 @@ struct cxl_dev_ops {
  * @serial: PCIe Device Serial Number
  * @type: Generic Memory Class device or Vendor Specific Memory device
  * @cxl_mbox: CXL mailbox context
+ * @cstate: CXL cache state and capabilities
  * @cxlfs: CXL features context
  */
 struct cxl_dev_state {
@@ -791,6 +797,7 @@ struct cxl_dev_state {
 	u64 serial;
 	enum cxl_devtype type;
 	struct cxl_mailbox cxl_mbox;
+	struct cxl_cache_state cstate;
 #ifdef CONFIG_CXL_FEATURES
 	struct cxl_features_state *cxlfs;
 #endif
diff --git a/drivers/cxl/cxlcache.h b/drivers/cxl/cxlcache.h
index 3ccbeba9fcd6..3880312cd49d 100644
--- a/drivers/cxl/cxlcache.h
+++ b/drivers/cxl/cxlcache.h
@@ -20,4 +20,6 @@ static inline struct cxl_cachedev *to_cxl_cachedev(struct device *dev)
 }
 
 bool is_cxl_cachedev(const struct device *dev);
+
+int cxl_accel_get_cache_info(struct cxl_dev_state *cxlds);
 #endif
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 7827a183128d..e5dd132be7e7 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -17,10 +17,14 @@
 /* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
 #define CXL_DVSEC_PCIE_DEVICE					0
 #define   CXL_DVSEC_CAP_OFFSET		0xA
+#define     CXL_DVSEC_CACHE_CAPABLE	BIT(0)
 #define     CXL_DVSEC_MEM_CAPABLE	BIT(2)
 #define     CXL_DVSEC_HDM_COUNT_MASK	GENMASK(5, 4)
 #define   CXL_DVSEC_CTRL_OFFSET		0xC
 #define     CXL_DVSEC_MEM_ENABLE	BIT(2)
+#define   CXL_DVSEC_CAP2_OFFSET		0x16
+#define     CXL_DVSEC_CACHE_UNIT_MASK	GENMASK(3, 0)
+#define     CXL_DVSEC_CACHE_SIZE_MASK	GENMASK(15, 8)
 #define   CXL_DVSEC_RANGE_SIZE_HIGH(i)	(0x18 + (i * 0x10))
 #define   CXL_DVSEC_RANGE_SIZE_LOW(i)	(0x1C + (i * 0x10))
 #define     CXL_DVSEC_MEM_INFO_VALID	BIT(0)
-- 
2.34.1

