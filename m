Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2087.outbound.protection.outlook.com [40.107.102.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AF02F0661
	for <linux-cxl@vger.kernel.org>; Tue, 12 Aug 2025 21:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755034423; cv=fail; b=pslTrbaTpYHGzyDtE8YUAhZPavBl6cd0UmkYnzWG9cYqme/0O4q/G7QU7WV+fk/wmdh0/hXIZ65/iOR0Eslwr18U3Nu6HsAk1GW8ZjODRhFhEKs2kFJKhYkD5v9aSMd/4YZyizdaQ3UhB4umOD6+vP6aU3Th0go+IMZ+pb+aUZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755034423; c=relaxed/simple;
	bh=jiyEZsTs+0lNtcmH+BPEWOXnEFuV/TxeSE2+i/8r0NI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BRDwaYmFFOfVAKG/Co7T9DhPL5nwF4eNRiIVPCz1JfJoFdCU+SKULq2I8A5sV6raw6UH7q2Ug0hmqvr475Jcowef/vNaPZiL1CXH4achyj1I9oIFXTn7Fdq/6bwRGZJ0inwsmHJA6HJPSO1DR1XUae/MehHsCXIS0+vNc8Wz4nA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2pPhxbQy; arc=fail smtp.client-ip=40.107.102.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2pPhxbQy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YyT21OT9LIvYz2EhRHMBSFCUHuI37EKbApi/zQlAb3OwAJnOsXeGE+yryEyHsci5r8YBS+IBtfPZv+ESECV4W5J/HAhTj1Vvpjdl7SA/rf0WXNao+rfQJa03LtQyL9KqEM6HqW191TCAJPDNIzTv4MeHkbBETn8gz0DpYNFNqXvhKzKqfFLUXOx1ExMrcfl7TwN8JXUS3aKkfE2LaI83k2kY9FWA2zbnc5bx0GSD6/ceZUSt4vnHGMTnmCdpK9mxkdW7/+diR0ZQq12d819bW+Cr/QKh5L0VDgM8pFdoYzAazEs3UFNc/r7WH1Y6Tq/ZUkOMOkpmeko3JpoOOC4LOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=50Civ48TSoncvhqf9MzqKYkg4NwQCDCw+mSH4x3QCnI=;
 b=FIbLHoMS+bFIlVuF9GAfOk4G2hZ+Mmj3dWuj0pEFcofDWZRAA17drKEynHrSqLRpB+2Lhwdm9/pa1BbyVqpKM9ziBrMI+d72odXSscjXxuhe2FArHyEQzTbbw9jsabZkJMo5xn0TjoopurSQqY9kcAdTlZxot/jmKxIyBgyUuOrqvdh0/VQz/C7K7yMDPU7uIVajjx49+5a6slDtdT0EQUkF3PYTo7oGH8bqml09qgnGQTlUB+CTHSesKs+GWKo1VoHowNJskOnj+f09UjVF+QGPmnhqtg5xj8vrd9GQrweDw3YRwI6/+H9ZScnJqz9RdzQBhA5URCcPJ+P7pITwkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=50Civ48TSoncvhqf9MzqKYkg4NwQCDCw+mSH4x3QCnI=;
 b=2pPhxbQys/v2aNSlydIE+0is3UP5tx7uIdmF1Osa8rSo+QJxKBJjcQPSU37kpqOMYcv0nuQy30fuD4xKhK9oNjJHg5a4YDkjD59RWuK2s7xJklFSBcuAqTBuP9dPk0Tp/gyQh8UM7spUr4ouyLvXcOAjLUu76hYQZD75+ZRObhs=
Received: from CH0PR03CA0224.namprd03.prod.outlook.com (2603:10b6:610:e7::19)
 by LV5PR12MB9780.namprd12.prod.outlook.com (2603:10b6:408:304::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.14; Tue, 12 Aug
 2025 21:33:40 +0000
Received: from DS3PEPF0000C37A.namprd04.prod.outlook.com
 (2603:10b6:610:e7:cafe::c8) by CH0PR03CA0224.outlook.office365.com
 (2603:10b6:610:e7::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.14 via Frontend Transport; Tue,
 12 Aug 2025 21:33:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37A.mail.protection.outlook.com (10.167.23.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Tue, 12 Aug 2025 21:33:39 +0000
Received: from SCS-L-bcheatha.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Aug
 2025 16:33:38 -0500
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <linux-cxl@vger.kernel.org>
CC: Ben Cheatham <Benjamin.Cheatham@amd.com>
Subject: [RFC PATCH 17/18] cxl/core: Add cache device attributes
Date: Tue, 12 Aug 2025 16:29:20 -0500
Message-ID: <20250812212921.9548-18-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37A:EE_|LV5PR12MB9780:EE_
X-MS-Office365-Filtering-Correlation-Id: 24cb0938-1d99-4782-ddeb-08ddd9e7e760
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lfVBRuqgp+GDgcNJccN09VTFiYVPK9WnfEg/YByKewD2N3eFiWRKPEH7Ii0C?=
 =?us-ascii?Q?72mcIv37KCzNdBoWcl2IW1CNe5BM6U7dakNbqqUvaFEAIlaX6LF47kxD0drj?=
 =?us-ascii?Q?0Zd1MWOUMwVqwXjoAX0gbi2wGOyoYuUoD16ZtcVnP6l0u2gGZg3/aAd9Wwqk?=
 =?us-ascii?Q?Znvc7iPBOlwlmQFxT70sV0mTyoB6gUYqdRI1hIQ0oX8B1o1e5vXH/udKfUCy?=
 =?us-ascii?Q?CxKPbk/MQWdTQG1GesldSr278bImLVy4Jbnh9lhDqH4yKHvd0vG3Eqens4yB?=
 =?us-ascii?Q?wPy5dP2uHtaQSaE9qutMZ+Td7u3c7CMaCtrTKyFmagtq2+BRLRjjdbGVG2pQ?=
 =?us-ascii?Q?mFpst8o4Q6Y5Sc9oedVFjXj21i24RrOe56wlEZ+/A5Kjcd3mJedKhmPt8t51?=
 =?us-ascii?Q?8KbVLwlypnWU828upvEoNhVHfxxBibD7b9aR0kK6albcBM+sGqvubX4uSwOp?=
 =?us-ascii?Q?ZpiZcoJeGWwu/TSTmRXAV+w9GBrsgfTd/znYMWU3B5AWHOtf0+aOBgU4Tb4L?=
 =?us-ascii?Q?HOJTXbasS29VSEhzNncNDscNxPnNUZOYnCxHNl3+ScydrkF0lpdAUZFMryy1?=
 =?us-ascii?Q?8av19emoT6kN/TxkLEvvq7z8tCtQANu23ebOzgSNVMKPqg9ymHtkXXiHxhf3?=
 =?us-ascii?Q?j1nFCw+U3lptfYN7ARRXVMnH2+OYptB6rz+tiuPEzRatd50oeyogwhy2ZngX?=
 =?us-ascii?Q?7js+4ZbeXPqUkDVlPBN3wS+pTlUhcb4W49gyYXzaaXajBgkXGu5cFwMv6LX5?=
 =?us-ascii?Q?ccPi9XdWusEfNs0O8WmWUcYWUSHu4NFgOKQuwrbXnVjpMpNaU/qKIkHTwFsh?=
 =?us-ascii?Q?GtXeHzO7+HDLLCz0P7ti04JRKYEqwDezxCCTnL+JOTEyJFbgW2Kvlg8u7mq3?=
 =?us-ascii?Q?3Zl6Wid6l3/sTx9FkEmkTHBic73f6wseMo2PpcquTHgH+hyMO6cDcOTwX9/5?=
 =?us-ascii?Q?3EQ+Z4+HYFRbmWHNAyLS/vg4MKkFx+xFMyf4a/nH7KcWPw9oH81s6t6dRthg?=
 =?us-ascii?Q?AYcGaf5P9N8ktCvUWHFVNgNYa8eS7IZWrdqH/zxKTmVISLgNQibtQN+oS8F0?=
 =?us-ascii?Q?VHUWn1dMFDNzVS45i3hXkxJ/4KVGCIaMN5ZL2hVvTAcJBu3sKFCXN9mSkaJ/?=
 =?us-ascii?Q?nRta8eyuvIkLZus2Go5bimGybCULF0DP2s+Lf68Jzy8j8mHQE7BkSC9DaOYd?=
 =?us-ascii?Q?I9ijNHFuqVArl2lsqGUaEkAp73IIkBYmhFe09y/hCKHt6Ou3ENyLQJXQ4MoA?=
 =?us-ascii?Q?lpyHnjwZxjYCKp9Z/8iBWamDtBGj4d/AvwVSr+os2jji2DumSTOJ+hoKc0Hv?=
 =?us-ascii?Q?V8G3sO5Vjh1sipGHTMCxRil1u+yer01jbk8OBAOK+QUrpHiJ2AjsA1OenF2/?=
 =?us-ascii?Q?m3XeRwOsjGsas63WxGF8PM1h5CqFU6pQYee88VSB3ksECtWl8XUQtYxx48e8?=
 =?us-ascii?Q?WJ0M30m5LbXcywrpVNliAw7zdh8/2sKTiJZXSikgkQvm+lm76o4HMlhXc6gq?=
 =?us-ascii?Q?euQG2XlGBN1SMV/nRrFVY98iFUqDp/qzeb8N?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 21:33:39.8217
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24cb0938-1d99-4782-ddeb-08ddd9e7e760
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9780

Add sysfs attributes for getting the serial number, numa node, CXL cache
unit, and CXL cache size to struct cxl_cachedev.

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 drivers/cxl/core/cachedev.c | 102 ++++++++++++++++++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/drivers/cxl/core/cachedev.c b/drivers/cxl/core/cachedev.c
index aaf4a1b94178..1cdd94520ceb 100644
--- a/drivers/cxl/core/cachedev.c
+++ b/drivers/cxl/core/cachedev.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (C) 2025 Advanced Micro Devices, Inc. */
+#include <linux/string_helpers.h>
 #include <linux/device.h>
 #include <linux/pci.h>
 
@@ -30,10 +31,111 @@ static char *cxl_cachedev_devnode(const struct device *dev, umode_t *mode,
 	return kasprintf(GFP_KERNEL, "cxl/%s", dev_name(dev));
 }
 
+static ssize_t serial_show(struct device *dev, struct device_attribute *attr,
+			   char *buf)
+{
+	struct cxl_cachedev *cxlcd = to_cxl_cachedev(dev);
+	struct cxl_dev_state *cxlds = cxlcd->cxlds;
+
+	return sysfs_emit(buf, "%#llx\n", cxlds->serial);
+}
+static DEVICE_ATTR_RO(serial);
+
+static ssize_t numa_node_show(struct device *dev, struct device_attribute *attr,
+			      char *buf)
+{
+	return sysfs_emit(buf, "%d\n", dev_to_node(dev));
+}
+static DEVICE_ATTR_RO(numa_node);
+
+static struct attribute *cxl_cachedev_attributes[] = {
+	&dev_attr_serial.attr,
+	&dev_attr_numa_node.attr,
+};
+
+static umode_t cxl_cachedev_visible(struct kobject *kobj, struct attribute *a,
+				    int n)
+{
+	if (!IS_ENABLED(CONFIG_NUMA) && a == &dev_attr_numa_node.attr)
+		return 0;
+	return a->mode;
+}
+
+static struct attribute_group cxl_cachedev_attribute_group = {
+	.attrs = cxl_cachedev_attributes,
+	.is_visible = cxl_cachedev_visible,
+};
+
+static ssize_t cache_size_show(struct device *dev, struct device_attribute *attr,
+			       char *buf)
+{
+	struct cxl_cachedev *cxlcd = to_cxl_cachedev(dev);
+	struct cxl_dev_state *cxlds = cxlcd->cxlds;
+	struct cxl_cache_state cstate = cxlds->cstate;
+	char size_buf[32];
+	int rc;
+
+	rc = string_get_size(cstate.size, SZ_1K, STRING_UNITS_2, size_buf,
+			     sizeof(size_buf) - 1);
+	if (rc <= 0)
+		return -ENXIO;
+
+	return sysfs_emit(buf, "%s\n", size_buf);
+}
+static DEVICE_ATTR_RO(cache_size);
+
+static ssize_t cache_unit_show(struct device *dev, struct device_attribute *attr,
+			       char *buf)
+{
+	struct cxl_cachedev *cxlcd = to_cxl_cachedev(dev);
+	struct cxl_dev_state *cxlds = cxlcd->cxlds;
+	struct cxl_cache_state cstate = cxlds->cstate;
+	char unit_buf[32];
+	int rc;
+
+	rc = string_get_size(cstate.size, SZ_1K, STRING_UNITS_2, unit_buf,
+			     sizeof(unit_buf) - 1);
+	if (rc <= 0)
+		return -ENXIO;
+
+	return sysfs_emit(buf, "%s\n", unit_buf);
+}
+static DEVICE_ATTR_RO(cache_unit);
+
+static struct attribute *cxl_cachedev_cache_attributes[] = {
+	&dev_attr_cache_size.attr,
+	&dev_attr_cache_unit.attr,
+	NULL,
+};
+
+static umode_t cxl_cachedev_cache_visible(struct kobject *kobj,
+					  struct attribute *a, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct cxl_cachedev *cxlcd = to_cxl_cachedev(dev);
+	struct cxl_dev_state *cxlds = cxlcd->cxlds;
+
+	if (!cxlds || cxlds->cstate.size == 0)
+		return 0;
+	return a->mode;
+}
+
+static struct attribute_group cxl_cachedev_cache_attribute_group = {
+	.attrs = cxl_cachedev_cache_attributes,
+	.is_visible = cxl_cachedev_cache_visible,
+};
+
+static const struct attribute_group *cxl_cachedev_attribute_groups[] = {
+	&cxl_cachedev_attribute_group,
+	&cxl_cachedev_cache_attribute_group,
+	NULL,
+};
+
 static const struct device_type cxl_cachedev_type = {
 	.name = "cxl_cachedev",
 	.release = cxl_cachedev_release,
 	.devnode = cxl_cachedev_devnode,
+	.groups = cxl_cachedev_attribute_groups,
 };
 
 bool is_cxl_cachedev(const struct device *dev)
-- 
2.34.1

