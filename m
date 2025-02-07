Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A111D47B4
	for <linux-cxl@vger.kernel.org>; Fri,  7 Feb 2025 09:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738919041; cv=fail; b=EgiZCojq1K97Rsk5fXQvYrEtzw5r+wW9C76CRvnMOdR/VOw5g6ve6PSc6AisNOMhOeAIr6fRsqPlvDq0fNMkoZQVzTMDL94pIKn23cG3HGMvq+yX+0f7HSiJJI5ifo3kiYlk9r4hivUWGh1hTa4GmcF6cicY9jjk5spK7Gl2Ps0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738919041; c=relaxed/simple;
	bh=LZMh1w1UlPvxf1/Mjor79ba/ldJBdkhi/JR+NzttHg4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TsjirWCZT1aJLgQmXr+cxY4e8MErrig8YgDthnMIwK/9Es64MacibVc6/H/2FMPH4FMhjpArmleFk8+VSCIsaW167GaYTake1GDbD5c2laFh+uPUie2p7lqJ3EquVSIjxO/aOIRryMvo2ASSCt52fKnjtOpDnFz6jGdx/NThUdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=o+vbm852; arc=fail smtp.client-ip=40.107.93.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="o+vbm852"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nmP/guE/oQ6OIt0bUwUW0sag/0pchH+AWmLJobjQ7/nYsZEeBSm5XWIhfzKqchdJKlkp3UH388UZEfIpR1QnBUFx93PWVml/9eifyExLScG9LK5HIT2MmEknsedOtDILqGGESV8KhHqkdZNYxTaPsIa9T5PWK0hMfUzy5EyOH85eb4li8qk+s4ZHbDG5EyrOEkpqAWcrEZjAYCP52wI0sJYJKc0wbbW5aw3+rbm+3ZA/dvAQ2lFD5SD56tE9zes6EjvV8PxIoPbsiXHVHgBCxXRIiygc49aTUCxuo6PH6HwPDKWGmKccwc4OP+dgP8dI5ddR3DaNGD3hZ11ucLVbIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9aFDTeuFgUX5nyOvhRnL8n/ApY5pflAPug4T4R3PZRs=;
 b=MFPXDwuPHOCdUZHemuFNh9ZR0U/G5Bv/SUz+e1RrxsXIuZU/9QWIf18O7Inqy8m1+oyahVpFjiYvNC90oHrDT5xS9KKcrjLofa4pKIQBqYJXRpvbeCZ1k1PzpTANw7k1+2m3//luoCSJjZfruw+4M3RcaFLUaiVhC9hO3lYiBUBEDtwgSlubRecCrNNTJ5wLo1xXnqtZU/EYB6/JStQgfdXcP+kkqblvj9YVMr2Z0J5rw0FhIuC9Qpl+Kz/eJ1UMggWuwydfIa/qeBNIh6RWJPtT4KzkVKie9gfGInP4JfVhOxDaSMZvexKVW678IaTH0ldZW/YFHu2FDzRv6QQZzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9aFDTeuFgUX5nyOvhRnL8n/ApY5pflAPug4T4R3PZRs=;
 b=o+vbm852/dUZ4HAguif4gY2OCmWGj79OcGCeMWIt/8yEVoM5OukUWW1PrG20D/WsrNTA5y/3BNslOKP+ekZneprUKgBDJWa7Di7hfaHjTCl5Zjw5jaxT3VEIb1L9GyofSpzPlt7tLa0V8ErcbIL/Y/3OFWGj5KSGeNm4s9zJRr3ZTx0c0FvmR44AFl2t7+BuPDik9/3kM+Ljw3qQ34QS0CFERaJGCBViV4Iu+5vxrzZCMRSbjRyM3kG56FCr8V1lljzaQho8Ux08WqkjetMICPIezRmBBj+pigi76Xch7J8U4uN9HCM1m990OviUnZfbdDr6wbOsO2RBv6Qhmp4iig==
Received: from SJ0PR13CA0059.namprd13.prod.outlook.com (2603:10b6:a03:2c2::34)
 by DS7PR12MB6261.namprd12.prod.outlook.com (2603:10b6:8:97::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Fri, 7 Feb
 2025 09:03:55 +0000
Received: from SJ5PEPF000001ED.namprd05.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::84) by SJ0PR13CA0059.outlook.office365.com
 (2603:10b6:a03:2c2::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.6 via Frontend Transport; Fri, 7
 Feb 2025 09:03:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001ED.mail.protection.outlook.com (10.167.242.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Fri, 7 Feb 2025 09:03:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 7 Feb 2025
 01:03:43 -0800
Received: from 181d492-lcedt.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 7 Feb 2025 01:03:42 -0800
From: Srirangan Madhavan <smadhavan@nvidia.com>
To: Srirangan Madhavan <smadhavan@nvidia.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Dan Williams" <dan.j.williams@intel.com>
CC: Zhi Wang <zhiw@nvidia.com>, Vishal Aslot <vaslot@nvidia.com>, "Shanker
 Donthineni" <sdonthineni@nvidia.com>, <linux-cxl@vger.kernel.org>
Subject: [PATCH v1 1/1] cxl: add support for cxl reset
Date: Fri, 7 Feb 2025 01:03:27 -0800
Message-ID: <20250207090327.172478-2-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250207090327.172478-1-smadhavan@nvidia.com>
References: <20250207090327.172478-1-smadhavan@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001ED:EE_|DS7PR12MB6261:EE_
X-MS-Office365-Filtering-Correlation-Id: 2027514c-46f8-4d3f-3acb-08dd4756599c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5GSILbVIRtVUJI+SbtS+FzfISuBG7zzJG1mdUJvWzFH1vd5NaLT9BTYzoWCD?=
 =?us-ascii?Q?2H2RIWVRASkIiPU5ny1V0x/n1ICAhE53IYGJhLqMZPUSXWwT5beXpyDUWu7D?=
 =?us-ascii?Q?VUfZMMEvEvSGEj5NP7Hp6ZYrGh8KVDojBrViiTfvFpYONh/NCPCHE+sRFatY?=
 =?us-ascii?Q?sijfiXFXWSaGGkPHovOf4zTvZJqxYVpXgDLZNWVKQeZ/yfKbfWprz+XaZAO1?=
 =?us-ascii?Q?/kL3aJT06BuK4X2RoxvdsI3y7FYUhyeha0oavcfQ7pkPb7rMcsv56fOqc/Nd?=
 =?us-ascii?Q?0+8ojd+5QgOLKw9TEdavLLzqmLVyiBtaE99ScvF9QIPjY7essWFPqrfl66jK?=
 =?us-ascii?Q?snp03D9l4AUlRxeAFeUBrntUtE2H/RHl0JpMSam0TPsby4R4Y/+FTkatScFa?=
 =?us-ascii?Q?T3hQ+4pAJu0yVfHND8SPvwVXdaMzAaiicg1F1qBEcz3Unly1IGSndlHHLL3l?=
 =?us-ascii?Q?egWJnh8JsZqoHwnSzlzkyYfrKRSVGxe345T2pJoN3T3dksyEWPJx9oLqC/ua?=
 =?us-ascii?Q?cWpKH7f7kwTSri+PnunbB0LvGj7tw/VGcTF6PBE8g1n+RqmGH6Qdq5daJEIL?=
 =?us-ascii?Q?BzCEdy6CMsQDDqvBNk1gqDRYBLIS/OQkSUhthvZVQw7cU07Iol3CV3PIzm2L?=
 =?us-ascii?Q?GZepo7iWHdAt4pkH6tJpH/NN9PjJPpfpNcbOXzO0g4NLmEwsjY50Y6O4bXur?=
 =?us-ascii?Q?Q3UkdsB/AnFipmn3gEtZ8Xu2n6v6UrTEqzwuiU9xlbfYhtz/rQvZsqpEyTjm?=
 =?us-ascii?Q?j19uwazlCsLlkStpT4SUJSypHw64lL3XJwTmI1x646pdCgvMtJT6lk7SIODP?=
 =?us-ascii?Q?cKLNCcoR87QygXMLSU6BpBP61p63V5rpElAQtft829z3UGRrvYWzwhnsA1w1?=
 =?us-ascii?Q?p2/Zi5aP0YC22eZFgQuV/aINFa85ZTAKOmlniCc1KEVysZWeDBnQecW+1V0e?=
 =?us-ascii?Q?a3ZuFtmLgIYw18emSUiFBg7yE4bp6N4Goq2p/j8TQCP+5m1csly1gcMQtpBw?=
 =?us-ascii?Q?bivOkZQOrIX5nm3n6zlidHP/JzRGS9c0JDu8ZE26dGmnwc0ezJUdbOCaJDT1?=
 =?us-ascii?Q?X5M6BYy1BxKGdrM9j5Xnu8v0bIqmdq5/JnfgQtXYRtEWWrOkX5+WILAC5T3G?=
 =?us-ascii?Q?ANUdIqS1JKGal1GZWm0jACegft+koaZ1HpwqYNfmQs0mN5ikzp0YPBYpBAaz?=
 =?us-ascii?Q?NWAsI5xtn8/ILWjvEDodi6mH6amPl29PbBdo5MzX2Z1MXdgKz74y1bHxqvtx?=
 =?us-ascii?Q?9rVJz0fB3olKd963zarNLVwR8BQ7cXTwhf97h0+Ayi1YSDYzFCWfOaMIbjAe?=
 =?us-ascii?Q?uzK6PkO0b6siHw5PwiccKzu25X7m9B93ZXuVl4mzanWu8MlKmb8/oUkJZPs5?=
 =?us-ascii?Q?etPeaFhxQGEMd5J8SFOsAeQncFHxrMzaKQjjPhhutujTPuJNJzPpAaDz0IZt?=
 =?us-ascii?Q?Z+Coxd1xCkW2peEdHmPzCYAxUtxz6salLx0HTLHPR1/ryYRFreznvPLdXmWn?=
 =?us-ascii?Q?PAGbtb0LSZSC2m4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 09:03:55.2023
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2027514c-46f8-4d3f-3acb-08dd4756599c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6261

This change adds the support and implements the CXL reset
steps as laid out by the CXL Spec v3.1 Sections 9.6 & 9.7.

With support for Type 2 devices being introduced, more devices will
require finer-grained reset mechanisms beyond bus-wide reset methods.

This change defines the necessary CXL DVSEC register macros.
For devices that support CXL Reset, cache lines are disabled, WB+I is
asserted, wait for cache invalid status, Mem Clr bit is asserted and
finally reset is initiated.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/pci/pci.c             | 183 ++++++++++++++++++++++++++++++++++
 include/linux/pci.h           |   2 +-
 include/uapi/linux/pci_regs.h |  25 +++++
 3 files changed, 209 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 869d204a70a3..cf6009f5bd6c 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5026,6 +5026,12 @@ static int pci_dev_reset_slot_function(struct pci_dev *dev, bool probe)
 	return pci_reset_hotplug_slot(dev->slot->hotplug, probe);
 }
 
+static u16 cxl_device_dvsec(struct pci_dev *dev)
+{
+	return pci_find_dvsec_capability(dev, PCI_VENDOR_ID_CXL,
+					 PCI_DVSEC_CXL_DEV);
+}
+
 static u16 cxl_port_dvsec(struct pci_dev *dev)
 {
 	return pci_find_dvsec_capability(dev, PCI_VENDOR_ID_CXL,
@@ -5116,6 +5122,182 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
 	return rc;
 }
 
+static int cxl_reset_prepare(struct pci_dev *dev, u16 dvsec)
+{
+	u16 reg, val, cap;
+	int rc;
+	u32 timeout_us = 100, timeout_tot_us = 10000;
+
+	/*
+	 * Wait for any pending transactions.
+	 * Assuming this does cxl.io stuff.
+	 */
+	if (!pci_wait_for_pending_transaction(dev))
+		pci_err(dev, "timed out waiting for pending transaction; performing cxl reset anyway\n");
+
+	/*
+	 * Disable caching and then write back and invalidate lines.
+	 */
+	rc = pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCAP,
+				  &cap);
+	if (rc)
+		return rc;
+
+	if (!(cap & PCI_DVSEC_CXL_DEVCAP_CACHE_CAPABLE))
+		return 0;
+
+	/*
+	 * Disable cache.
+	 * WB and invalidate cahce if capability is advertised.
+	 */
+	rc = pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCTL2,
+				  &reg);
+	if (rc)
+		return rc;
+	val = reg | PCI_DVSEC_CXL_DEVCTL2_DISABLE_CACHING;
+
+	if (cap & PCI_DVSEC_CXL_DEVCAP_CACHE_WB_INVALIDATE)
+		val = reg | PCI_DVSEC_CXL_DEVCTL2_INIT_CACHE_WB_INVALIDATE;
+	pci_write_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCTL2,
+			      val);
+
+	/*
+	 * From Section 9.6: "Software may leverage the cache size reported in
+	 * the DVSEC CXL Capability2 register to compute a suitable timeout
+	 * value".
+	 * Given there is no conversion factor for cache size -> timeout,
+	 * setting timer for default 10ms.
+	 */
+	do {
+		if (timeout_tot_us < 0)
+			return -ETIMEDOUT;
+		usleep_range(timeout_us, timeout_us+1);
+		timeout_tot_us -= timeout_us;
+		rc = pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCTL2,
+					  &reg);
+		if (rc)
+			return rc;
+	} while (!(reg & PCI_DVSEC_CXL_DEVSTATUS2_CACHE_INVALID));
+
+	return 0;
+}
+
+/**
+ * cxl_reset_init - initiate a cxl reset
+ * @dev: device to reset
+ *
+ * Initiate a cxl reset.
+ */
+static int cxl_reset_init(struct pci_dev *dev, u16 dvsec)
+{
+	u16 reg, val;
+	u32 timeout_ms;
+	int rc;
+	u32 reset_timeouts_ms[] = {10, 100, 1000, 10000, 100000};
+
+	/*
+	 * Check if CXL Reset MEM CLR is supported.
+	 */
+	rc = pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCAP,
+				  &reg);
+	if (rc)
+		return rc;
+
+	if (reg & PCI_DVSEC_CXL_DEVCAP_CXL_RST_MEM_CLR) {
+		rc = pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCTL2,
+					  &reg);
+		if (rc)
+			return rc;
+
+		val = reg | PCI_DVSEC_CXL_DEVCTL2_CXL_RST_MEM_CLR_ENABLE;
+		pci_write_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCTL2,
+				      val);
+	}
+
+	/*
+	 * Read timeout value
+	 */
+	rc = pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCAP,
+				  &reg);
+	if (rc)
+		return rc;
+	timeout_ms = reset_timeouts_ms[FIELD_GET(PCI_DVSEC_CXL_DEVCAP_CXL_RST_TIMEOUT_MASK, reg)];
+
+	/*
+	 * Write reset config
+	 */
+	rc = pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCTL2,
+				  &reg);
+	if (rc)
+		return rc;
+
+	val = reg | PCI_DVSEC_CXL_DEVCTL2_CXL_INIT_RST;
+	pci_write_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCTL2,
+			      val);
+
+	/*
+	 *  Wait till timeout and then check reset status is complete.
+	 */
+	msleep(timeout_ms);
+	rc = pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVSTATUS2,
+				  &reg);
+	if (rc)
+		return rc;
+	if (reg & PCI_DVSEC_CXL_DEVSTATUS2_RST_ERR ||
+	    ~reg & PCI_DVSEC_CXL_DEVSTATUS2_RST_COMPLETE)
+		return -ETIMEDOUT;
+
+	/*
+	 * Revert cashing disable.
+	 */
+	rc = pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCTL2,
+				  &reg);
+	if (rc)
+		return rc;
+	val = (reg & (~PCI_DVSEC_CXL_DEVCTL2_DISABLE_CACHING));
+	pci_write_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCTL2,
+			      val);
+
+	return 0;
+}
+
+/**
+ * cxl_reset - initiate a cxl reset
+ * @dev: device to reset
+ * @probe: if true, return 0 if device can be reset this way
+ *
+ * Initiate a cxl reset on @dev.
+ */
+static int cxl_reset(struct pci_dev *dev, bool probe)
+{
+	u16 dvsec, reg;
+	int rc;
+
+	dvsec = cxl_device_dvsec(dev);
+	if (!dvsec)
+		return -ENOTTY;
+
+	/*
+	 * Check if CXL Reset is supported.
+	 */
+	rc = pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCAP,
+				  &reg);
+	if (rc)
+		return -ENOTTY;
+
+	if (~(reg & PCI_DVSEC_CXL_DEVCAP_CXL_RST))
+		return -ENOTTY;
+
+	if (probe)
+		return 0;
+
+	rc = cxl_reset_prepare(dev, dvsec);
+	if (rc)
+		return rc;
+
+	return cxl_reset_init(dev, dvsec);
+}
+
 void pci_dev_lock(struct pci_dev *dev)
 {
 	/* block PM suspend, driver probe, etc. */
@@ -5202,6 +5384,7 @@ const struct pci_reset_fn_method pci_reset_fn_methods[] = {
 	{ pci_dev_acpi_reset, .name = "acpi" },
 	{ pcie_reset_flr, .name = "flr" },
 	{ pci_af_flr, .name = "af_flr" },
+	{ cxl_reset, .name = "cxl_reset" },
 	{ pci_pm_reset, .name = "pm" },
 	{ pci_reset_bus_function, .name = "bus" },
 	{ cxl_reset_bus_function, .name = "cxl_bus" },
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 47b31ad724fa..efcb06598f26 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -51,7 +51,7 @@
 			       PCI_STATUS_PARITY)
 
 /* Number of reset methods used in pci_reset_fn_methods array in pci.c */
-#define PCI_NUM_RESET_METHODS 8
+#define PCI_NUM_RESET_METHODS 9
 
 #define PCI_RESET_PROBE		true
 #define PCI_RESET_DO_RESET	false
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 3445c4970e4d..52618c5b095d 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1209,6 +1209,31 @@
 #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX	0xff000000
 
 /* Compute Express Link (CXL r3.1, sec 8.1.5) */
+#define PCI_DVSEC_CXL_DEV				0
+#define PCI_DVSEC_CXL_DEVCAP				0x0a
+#define PCI_DVSEC_CXL_DEVCAP_CACHE_CAPABLE		0x00000001
+#define PCI_DVSEC_CXL_DEVCAP_CACHE_WB_INVALIDATE	0x00000040
+#define PCI_DVSEC_CXL_DEVCAP_CXL_RST			0x00000080
+#define PCI_DVSEC_CXL_DEVCAP_CXL_RST_TIMEOUT_IND	0x8
+#define PCI_DVSEC_CXL_DEVCAP_CXL_RST_TIMEOUT_MASK	0x00000700
+#define PCI_DVSEC_CXL_DEVCAP_CXL_RST_MEM_CLR		0x00000800
+#define PCI_DVSEC_CXL_DEVCTL				0x0c
+#define PCI_DVSEC_CXL_DEVCTL2				0x10
+#define PCI_DVSEC_CXL_DEVCTL2_DISABLE_CACHING		0x1
+#define PCI_DVSEC_CXL_DEVCTL2_INIT_CACHE_WB_INVALIDATE	0x2
+#define PCI_DVSEC_CXL_DEVCTL2_CXL_INIT_RST		0x4
+#define PCI_DVSEC_CXL_DEVCTL2_CXL_RST_MEM_CLR_ENABLE	0x8
+#define PCI_DVSEC_CXL_DEVSTATUS2			0x12
+#define PCI_DVSEC_CXL_DEVSTATUS2_CACHE_INVALID		0x1
+#define PCI_DVSEC_CXL_DEVSTATUS2_RST_COMPLETE		0x2
+#define PCI_DVSEC_CXL_DEVSTATUS2_RST_ERR		0x4
+#define PCI_DVSEC_CXL_DEVCAP2				0x16
+#define PCI_DVSEC_CXL_DEVCAP2_CACHE_SIZE_UNIT		0x0000000F
+#define PCI_DVSEC_CXL_DEVCAP2_CACHE_SIZE_UNIT_0		0x0
+#define PCI_DVSEC_CXL_DEVCAP2_CACHE_SIZE_UNIT_1		0x40
+#define PCI_DVSEC_CXL_DEVCAP2_CACHE_SIZE_UNIT_2		0x400
+#define PCI_DVSEC_CXL_DEVCAP2_CACHE_SIZE(x)		(((x) & 0x0000FF00) >> 8)
+
 #define PCI_DVSEC_CXL_PORT				3
 #define PCI_DVSEC_CXL_PORT_CTL				0x0c
 #define PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR		0x00000001
-- 
2.25.1

