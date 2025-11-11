Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012000.outbound.protection.outlook.com [40.107.209.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53153326951
	for <linux-cxl@vger.kernel.org>; Tue, 11 Nov 2025 21:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762897466; cv=fail; b=Yk7adap1+FJB5H54SrR0ZZsUAOZtTPl4OyrJTW6b2woZgTWGWs13By80QJbBNz7X57/Fd+lCxCRw+o6ZoPAQ9I4brMqNtGgawQQZe8ppwzbn2g2OXXT4ymrp31zK2QdSduwBeeWBZi4NAEAGY0nZbTYyqH+l7CtHUheSkdpgSqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762897466; c=relaxed/simple;
	bh=bCZO+I/E/bEIP40mb6bQIdwW/Q80BNk1av/rQtc0lyk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hvg1fXy5IivPlQIZYeBhDkk6HwJIna4Y3AHrsHTBQ59qrIr4GlLwm/ubqxsUbXJSLjS08lfzb9Np/+ChUMJvezJopd9yPNJGQUTXvu4DJZhXjSz8uXnLRn///6mQGXT12lZGctMEMHBeQk3lQ7M0a6fAxOb8JIFtKJ+r3GsKJSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=drcFepxS; arc=fail smtp.client-ip=40.107.209.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="drcFepxS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qhD5pxaH9w/8sSWDg/4TAnEU1VhjHAM82vCa/ha3uYd/U3HLqC/LR3tTA9ZlTmLEDbz2wnzZLY7LiCOClUwld5o5JfbPDd6gi3IBK31hDB9jfvtxnEQluclt2dVpmTHfX5scZXQrCd/2kqj33hTwDceyj3bwExLir+w2LFBIdzn+DDRN4yFK/rtBIdlZnNgumLCqz5TyLuGJNi06bBGPs80Zx16U5nWi2cul10MY4K/aJWOHU3nWA9NHUTahUdH+oZgYYOAFUkRoq+GI6uuoNX3EM/Y4P25PwesnGlMygS26YksL52bdPTVJOh7M6wEF1DuXZdagyJiUqSrplwo0BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uzcqRPeP4gSc7hDwxvx76Qpr2+8/WpvDQ/mr77J50L8=;
 b=obKEObyR4smGpIQdKeVF62UEwFTdD6NjTH8AtwWss46E7QLQSFpKQ6kW11Y+6SukiEhrFjc7mshlapg7xU+lE+WlsbTug2z84qQtb+rFusaCOSxz3c9Jl5KBjEFQV1LAKZ/4NZ7H+SDbFndQkSRlC9YxgD32zrzueWLLEO4+XUVMDldU0rjmExDZcNplZNcSa7qsq9zv3HEcHLUzZ3rbVW8GCp52RcCMSnKx3cMKJ+Q+EdqWWvSXusd0eYqAoV7Bqfic8tO8gVahY75WxwzKjJ4mg+5rjz2+DHrq720FTWAOwUsHK5UAAB92jyJ5xIrYDpc/WfKdK6ibimU+fLaAmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uzcqRPeP4gSc7hDwxvx76Qpr2+8/WpvDQ/mr77J50L8=;
 b=drcFepxSsXA3uePzdT0hl98USlZb8i3GIKz+MA1AkLqGkZN6/Z5Z/VXb2xwlQcxtlbeDSOHpWnVCDIOZUPwABy0uRL2pDbVjESsS7Z8oa9rKgFc0FLaMcfbePJkZof0V3PJLzp2OVjfEvmBHYvoPER6ZAsQUN3sJ+o+KnrBJEVw=
Received: from SJ0PR05CA0146.namprd05.prod.outlook.com (2603:10b6:a03:33d::31)
 by LV3PR12MB9236.namprd12.prod.outlook.com (2603:10b6:408:1a5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 21:44:20 +0000
Received: from MWH0EPF000A6731.namprd04.prod.outlook.com
 (2603:10b6:a03:33d:cafe::25) by SJ0PR05CA0146.outlook.office365.com
 (2603:10b6:a03:33d::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Tue,
 11 Nov 2025 21:44:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A6731.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Tue, 11 Nov 2025 21:44:18 +0000
Received: from ausbcheatha02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 11 Nov
 2025 13:44:16 -0800
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <linux-cxl@vger.kernel.org>
CC: <benjamin.cheatham@amd.com>
Subject: [PATCH 17/17] cxl/core: Add cache device cache management attributes
Date: Tue, 11 Nov 2025 15:40:32 -0600
Message-ID: <20251111214032.8188-18-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251111214032.8188-1-Benjamin.Cheatham@amd.com>
References: <20251111214032.8188-1-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6731:EE_|LV3PR12MB9236:EE_
X-MS-Office365-Filtering-Correlation-Id: 592e4309-44aa-482b-969e-08de216b77ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GbpGYeCKfqDwbZt14Irkb5eDhXyM4mqHmpeNxlHKskLi1nkwYETapzGcQWxG?=
 =?us-ascii?Q?E8FcJ+UHfTHufZE3BBZH/1G+96ewm4AO0X6pHiq0QCbAgmr2bsoItmIGI/Ww?=
 =?us-ascii?Q?A/MwrNovogV32Hxm7BL/ipVaBz/QHthFySGfZ+zFdP69EN/ZztBQlJqLyfZo?=
 =?us-ascii?Q?gkN7+bUA7V1mYph1vK3yragXAC2S5ungkmTummLtoPDWEqVR/cRu0G4CPa0D?=
 =?us-ascii?Q?mqSyUckcyhcU88fHZOn0MHIySHUrSuakdfeXijxSiH1/M6RqXg2qf6rXWSBd?=
 =?us-ascii?Q?kyAKO2VNQ3zoqfpTusQPqOqxJAzKDjOWtBnDmbU9NtKRXzWog+Dugl0QUSi0?=
 =?us-ascii?Q?9bLeL8vKjWDQ2IpkgcyfPilyECVEoMDCe+bHh0OHUN30uRMfLhUfqW0rYP1F?=
 =?us-ascii?Q?wtJQ9iLqOYNNkWo3VoA71ob9uulHuz7i5Hrd8otG0a13Ht98UNdf1UQGv/d7?=
 =?us-ascii?Q?MeAhhLLDiqqjAlwQd//yfQV6neRNizLWmy+EVbrr1yK4ezBjttMA/e0qPj/t?=
 =?us-ascii?Q?aa7dYrfA4QhHrUOeluqx/dlTLydOIrIgy8g7/XQxwmrbA3Tqv/6sfeH5iO82?=
 =?us-ascii?Q?QHvQd8TnFO55NALabKo0jaB2M+jkLzhajqYFyXYDLQEDHWap/j2Ru7WfRkCg?=
 =?us-ascii?Q?3mrzEDy+DqalMgOEHgVXU5VwaG6O4lBVdAXN03z0nY6fc4oU/C40nG/t6902?=
 =?us-ascii?Q?UbphBjk840WW8JdiOZgTZi/x2yfd4+cDtWE1t67+bonrVGIwa5/+0DnJt/SV?=
 =?us-ascii?Q?TtC8EU/BKbbHprJZabKlsnXaw5uhcUPJOJ8P7dzYYU5W7ZwW16hY5ClMl12C?=
 =?us-ascii?Q?OHW8ciBzOnhUImyCJp1pBb57Ig9ApTjL+koobJelmiP492bHi5nK8EbdUY00?=
 =?us-ascii?Q?BOEKScvw7abd/ZRfQfDRaY7SFr0iwNpK3/vMAlyGIFKeB2vVlG3LOpeXEyXC?=
 =?us-ascii?Q?OwHhYE6XA03In+c+LwkFZzjoBfFYVBxnZ79bhG/6phv0W/HXjIKQ9yJOkBfu?=
 =?us-ascii?Q?ijAP4aDz19rM8G81Q+7VaTkUStA+pk00Fs4pqoxKwwp+itSabY8RyI7pI3MJ?=
 =?us-ascii?Q?Pr3YICzKp1fNMuTMJFftaiQRkDMfSqYkqcAM0D5yHZ+YqJYXJp+8RGa+7HLN?=
 =?us-ascii?Q?iAHiZwSGydtmZvZ0ZHm5/VvB/aY1EOuvJSaGmTBMvG5pc6j/rkolLb4eE0DP?=
 =?us-ascii?Q?nKy9cnxT3p8cai1xtg+SsVCyp1t5+bg9fur0N/U7EIBgFoodt8Mijwoe8nnm?=
 =?us-ascii?Q?YbtO3+tVsZIofCZSqCO1GHDaza4gYSCEb0rtVef1AHJztuTCK0xpR4kYU4hd?=
 =?us-ascii?Q?pPo/9uIMWUnQ0KvrHplVBrR8QDWCkKTYKKtxVLDGkcKE+li+LzyEqW0llkPN?=
 =?us-ascii?Q?iKFVTODLm7bfRTJ/5jMIaUtOPhPukqKCYYSY40f8pC95KcPrZvAyYrf61xFp?=
 =?us-ascii?Q?wl0Ojy5utlzfMTtuYWrtkfEyL4s7GFoLfpwLmAZNoZS2au1Hb1NZNQjQScZq?=
 =?us-ascii?Q?KgrLtAJWE4/ro7xgNExn4nreMWGZOojtdcx3UeMWnD8rKKr8puX5PLOS4I7i?=
 =?us-ascii?Q?hBxT/4KMoJJaWPHsTeI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 21:44:18.8914
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 592e4309-44aa-482b-969e-08de216b77ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6731.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9236

Add functions to cxl/core/pci.c to manage the cache of a CXL.cache
enabled endpoint. Add these new functions to sysfs attributes for
userspace accessibility.

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 Documentation/ABI/testing/sysfs-bus-cxl | 31 +++++++++
 drivers/cxl/core/cachedev.c             | 89 +++++++++++++++++++++++++
 drivers/cxl/core/pci.c                  | 85 +++++++++++++++++++++++
 drivers/cxl/cxlcache.h                  | 13 ++++
 drivers/cxl/cxlpci.h                    |  6 ++
 5 files changed, 224 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 6b4e8c7a963d..b7293a09dc93 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -615,3 +615,34 @@ Description:
 		The count is persistent across power loss and wraps back to 0
 		upon overflow. If this file is not present, the device does not
 		have the necessary support for dirty tracking.
+
+What:		/sys/bus/cxl/devices/cacheX/cache_disable
+Date:		Dec, 2025
+KernelVersion:	v6.19
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RW) Reading this attribute returns whether the CXL cache of this
+		device is currently disabled. Writing a '1' to this attribute disables
+		the CXL cache of the device.
+
+What:		/sys/bus/cxl/devices/cacheX/cache_invalid
+Date:		Dec, 2025
+KernelVersion:	v6.19
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) Whether the CXL cache of this device is currently invalid. Reading
+		this attribute while caching is enabled will always return 0. See the
+		"cache_disable" attribute for disabling caching.
+
+What:		/sys/bus/cxl/devices/cacheX/initiate_wbinvd
+Date:		Dec, 2025
+KernelVersion:	v6.19
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(WO) Writes to this attribute initiate an attempt to writeback and
+		invalidate this device's CXL cache. Writing to this attribute while
+		caching is enabled will result in a failure, see the "cache_disable"
+		attribute for disabling caching. The writeback and invalidate may take
+		some time to finish depending on the device. The result of this
+		operation can be found by reading the "cache_invalid" attribute of the
+		device.
diff --git a/drivers/cxl/core/cachedev.c b/drivers/cxl/core/cachedev.c
index d8bf18ec0579..2a6a3e4f6a17 100644
--- a/drivers/cxl/core/cachedev.c
+++ b/drivers/cxl/core/cachedev.c
@@ -6,6 +6,7 @@
 #include "cxlpci.h"
 
 #include "../cxlcache.h"
+#include "../cxlpci.h"
 #include "private.h"
 
 static DEFINE_IDA(cxl_cachedev_ida);
@@ -110,9 +111,97 @@ static struct attribute_group cxl_cachedev_cache_attribute_group = {
 	.is_visible = cxl_cachedev_cache_visible,
 };
 
+static ssize_t cache_disable_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t n)
+{
+	struct cxl_cachedev *cxlcd = to_cxl_cachedev(dev);
+	struct cxl_dev_state *cxlds = cxlcd->cxlds;
+	bool disable;
+	int rc;
+
+	rc = kstrtobool(buf, &disable);
+	if (rc)
+		return rc;
+
+	rc = cxl_accel_set_cache_disable(cxlds, disable);
+	if (rc < 0)
+		return rc;
+
+	return n;
+}
+
+static ssize_t cache_disable_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct cxl_cachedev *cxlcd = to_cxl_cachedev(dev);
+	struct cxl_dev_state *cxlds = cxlcd->cxlds;
+
+	return sysfs_emit(buf, "%d\n", cxl_accel_caching_disabled(cxlds));
+}
+static DEVICE_ATTR_RW(cache_disable);
+
+static ssize_t cache_invalid_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct cxl_cachedev *cxlcd = to_cxl_cachedev(dev);
+	struct cxl_dev_state *cxlds = cxlcd->cxlds;
+
+	return sysfs_emit(buf, "%d\n", cxl_accel_cache_invalid(cxlds));
+}
+static DEVICE_ATTR_RO(cache_invalid);
+
+static ssize_t init_wbinvd_store(struct device *dev,
+				 struct device_attribute *attr, const char *buf,
+				 size_t n)
+{
+	struct cxl_cachedev *cxlcd = to_cxl_cachedev(dev);
+	struct cxl_dev_state *cxlds = cxlcd->cxlds;
+	int rc;
+
+	rc = cxl_accel_initiate_wbinvd(cxlds);
+	return rc ? rc : n;
+}
+static DEVICE_ATTR_WO(init_wbinvd);
+
+static struct attribute *cxl_cachedev_mgmt_attributes[] = {
+	&dev_attr_cache_disable.attr,
+	&dev_attr_cache_invalid.attr,
+	&dev_attr_init_wbinvd.attr,
+	NULL
+};
+
+static umode_t cxl_cachedev_mgmt_visible(struct kobject *kobj,
+					 struct attribute *a, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct cxl_cachedev *cxlcd = to_cxl_cachedev(dev);
+	struct cxl_dev_state *cxlds = cxlcd->cxlds;
+	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
+	u16 cap;
+	int rc;
+
+	rc = pci_read_config_word(pdev, cxlds->cxl_dvsec + CXL_DVSEC_CAP_OFFSET,
+				  &cap);
+	if (rc)
+		return 0;
+
+	if (!(cap & CXL_DVSEC_WBINVD_CAPABLE) &&
+	    a == &dev_attr_init_wbinvd.attr)
+		return 0;
+
+	return a->mode;
+}
+
+static struct attribute_group cxl_cachedev_mgmt_attribute_group = {
+	.attrs = cxl_cachedev_mgmt_attributes,
+	.is_visible = cxl_cachedev_mgmt_visible,
+};
+
 static const struct attribute_group *cxl_cachedev_attribute_groups[] = {
 	&cxl_cachedev_attribute_group,
 	&cxl_cachedev_cache_attribute_group,
+	&cxl_cachedev_mgmt_attribute_group,
 	NULL
 };
 
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 27c74e90ade5..a1bd7778aaff 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -1313,3 +1313,88 @@ int cxl_accel_read_cache_info(struct cxl_dev_state *cxlds, bool hdmd)
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_accel_read_cache_info, "CXL");
+
+bool cxl_accel_caching_disabled(struct cxl_dev_state *cxlds)
+{
+	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
+	int dvsec, rc;
+	u16 ctrl2;
+
+	if (!dev_is_pci(cxlds->dev))
+		return false;
+
+	dvsec = cxlds->cxl_dvsec;
+	rc = pci_read_config_word(pdev, dvsec + CXL_DVSEC_CTRL2_OFFSET, &ctrl2);
+	if (rc)
+		return false;
+
+	return FIELD_GET(CXL_DVSEC_DISABLE_CACHING, ctrl2);
+}
+
+int cxl_accel_set_cache_disable(struct cxl_dev_state *cxlds, bool disable)
+{
+	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
+	int dvsec, rc;
+	u16 ctrl2;
+
+	if (!dev_is_pci(cxlds->dev))
+		return -EINVAL;
+
+	guard(device)(cxlds->dev);
+	dvsec = cxlds->cxl_dvsec;
+	rc = pci_read_config_word(pdev, dvsec + CXL_DVSEC_CTRL2_OFFSET, &ctrl2);
+	if (rc)
+		return rc;
+
+	if (FIELD_GET(CXL_DVSEC_DISABLE_CACHING, ctrl2) == disable)
+		return 1;
+
+	ctrl2 &= ~CXL_DVSEC_DISABLE_CACHING;
+	ctrl2 |= FIELD_PREP(CXL_DVSEC_DISABLE_CACHING, disable);
+	return pci_write_config_word(pdev, dvsec + CXL_DVSEC_DISABLE_CACHING,
+				     ctrl2);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_accel_set_cache_disable, "CXL");
+
+int cxl_accel_initiate_wbinvd(struct cxl_dev_state *cxlds)
+{
+	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
+	int dvsec, rc;
+	u16 ctrl2;
+
+	if (!dev_is_pci(cxlds->dev))
+		return -EINVAL;
+
+	guard(device)(cxlds->dev);
+	if (cxl_accel_caching_disabled(cxlds) != 1)
+		return -EBUSY;
+
+	dvsec = cxlds->cxl_dvsec;
+	rc = pci_read_config_word(pdev, dvsec + CXL_DVSEC_CTRL2_OFFSET, &ctrl2);
+	if (rc)
+		return rc;
+
+	ctrl2 |= CXL_DVSEC_INIT_WBINVD;
+	return pci_write_config_word(pdev, dvsec + CXL_DVSEC_CTRL2_OFFSET,
+				     ctrl2);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_accel_initiate_wbinvd, "CXL");
+
+bool cxl_accel_cache_invalid(struct cxl_dev_state *cxlds)
+{
+	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
+	int dvsec, rc;
+	u16 stat2;
+
+	if (!dev_is_pci(cxlds->dev))
+		return false;
+
+	guard(device)(cxlds->dev);
+	dvsec = cxlds->cxl_dvsec;
+	rc = pci_read_config_word(pdev, dvsec + CXL_DVSEC_STAT2_OFFSET, &stat2);
+	if (rc)
+		return false;
+
+	return FIELD_GET(CXL_DVSEC_CACHE_INVALID, stat2);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_accel_cache_invalid, "CXL");
diff --git a/drivers/cxl/cxlcache.h b/drivers/cxl/cxlcache.h
index fe9e44fda641..b62c5269507c 100644
--- a/drivers/cxl/cxlcache.h
+++ b/drivers/cxl/cxlcache.h
@@ -32,4 +32,17 @@ int cxl_accel_read_cache_info(struct cxl_dev_state *cxlds, bool hdmd);
 struct cxl_cachedev *devm_cxl_add_cachedev(struct device *host,
 					   struct cxl_dev_state *cxlds);
 bool cxl_cachedev_is_type2(struct cxl_cachedev *cxlcd);
+
+int devm_cxl_snoop_filter_alloc(u32 gid, struct cxl_dev_state *cxlds);
+
+int devm_cxl_port_program_cache_idrt(struct cxl_port *port,
+				     struct cxl_dport *dport,
+				     struct cxl_cachedev *cxlcd);
+int cxl_dport_program_cache_idd(struct cxl_dport *dport,
+				struct cxl_cachedev *cxlcd);
+
+int cxl_accel_set_cache_disable(struct cxl_dev_state *cxlds, bool disable);
+bool cxl_accel_caching_disabled(struct cxl_dev_state *cxlds);
+bool cxl_accel_cache_invalid(struct cxl_dev_state *cxlds);
+int cxl_accel_initiate_wbinvd(struct cxl_dev_state *cxlds);
 #endif
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 18230e4f677c..a63bba3ab348 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -20,8 +20,14 @@
 #define     CXL_DVSEC_CACHE_CAPABLE	BIT(0)
 #define     CXL_DVSEC_MEM_CAPABLE	BIT(2)
 #define     CXL_DVSEC_HDM_COUNT_MASK	GENMASK(5, 4)
+#define     CXL_DVSEC_WBINVD_CAPABLE	BIT(6)
 #define   CXL_DVSEC_CTRL_OFFSET		0xC
 #define     CXL_DVSEC_MEM_ENABLE	BIT(2)
+#define   CXL_DVSEC_CTRL2_OFFSET	0x10
+#define     CXL_DVSEC_DISABLE_CACHING	BIT(0)
+#define     CXL_DVSEC_INIT_WBINVD	BIT(1)
+#define   CXL_DVSEC_STAT2_OFFSET	0x12
+#define     CXL_DVSEC_CACHE_INVALID	BIT(0)
 #define   CXL_DVSEC_CAP2_OFFSET		0x16
 #define     CXL_DVSEC_CACHE_UNIT_MASK	GENMASK(3, 0)
 #define     CXL_DVSEC_CACHE_SIZE_MASK	GENMASK(15, 8)
-- 
2.51.1

