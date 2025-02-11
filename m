Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BAF1F37C6;
	Tue, 11 Feb 2025 09:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739267699; cv=fail; b=t1W+tKzXYDGf4AOxmzxA4onn5dy1PkJ2NDdg0wKfHcqGk2eSAppGTZ7z4/I/+wtCcLaFtU7TtZjSGr1YsSAZsVHPFcvhSVKY0/dK0GWBxMtkegrEme9W5UdAB19gBNeO6WNddnlmfTlb+2UodSgpgrfroYHQuSVrATdp2T4PvFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739267699; c=relaxed/simple;
	bh=/P9brBoSkg1bGcuEnHV2vdvpqzvbAz0kPrcsAvlVuhk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G393hB9QYdBkKpFrwKYXiLIwI/XDAYftFg+tfw8Zi6vLq3BqdVYvfJilFec8sfrykE9UMsFx8CMrrs0RBxFhVS72jwjImYnZd0IU/qRY+ylrFTu5aIJXgSRZhov6WKW++DomuWnbvUL1DbaR+r4ifqz4ctnFGEJZXZIovSL9sNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2L5ZT/0o; arc=fail smtp.client-ip=40.107.220.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2L5ZT/0o"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AaVcOQacPWERdLA654EftWUX0uZlGi6D9Y674uNZo8WEcQOZVxFn/77xaMmXJ4Uj76PzeXQTXx0cXBzqAQ4qgVmEhYxZ6cNLtdy/CsdpcIbNOnRMJAW1G6MinPMAXXQUjpDhrU9o/WxPUm2H9pxeRpjwMokTBZgyZHFf+gNVAYqH9LX0iTDGoJDLCgxA05txjlyKbKY3RjEsJDTnKHOrcELKlhaXvCzdw7FE3+2jwsiVVPwPA0OIz8wcpU5JY8wXH2z750flrGfrFKjVHESrN+yNO6B5ijlPDyvhZWJYlsitVn0o1Qp+lQgbpV2FQ1LwCNJ+uRd2HHSRXqpFCPUSQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TzhRiDBX6YQak6DQqRBIIYGcXAvp1XIh6g+OO0D1IKc=;
 b=uOAfIrkaoMKCmLOtNdqR9/YuJnP2NcctqCQmZtQXKMqs7NJcg0tin2lZDW8exd4QFy4OXKOEHej9a142a046u79K0TBMTrcQCsHLPd6m2xXtdoekY+XpmmJaNhYvITwUiL8oB48qsNPyeSF50OsdmMhKINakkbBHEwJ0CbkJau7ZsJEKkye8G8YSl3XDGoOt5eZ75F/4G2ABUNb3Ejvwd50h+FdNMFQ00FXWQIKJ9JqpE+M1ZkuEJYu8XMdzwqkbb6PsREzoBd1jXs0a3UGG82vchpcbUFQ618vlm8cq1KSHQbd6GL0ec7u9Gxh1cL7NuV1GxWibYeWpLgkGNNDmLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TzhRiDBX6YQak6DQqRBIIYGcXAvp1XIh6g+OO0D1IKc=;
 b=2L5ZT/0o8sJpNIPQjjZGtO0FE5E3yuQXtcT52frCoUFXR7NKC37O+UbQ5CQ23OMsu5pA/auBfmOKPCxyb2vvqushZt79NBmYY/tI3yTtSaxC4wvV/OLEweZ+/QYflxSBK6on0u9/Popknpa1XHGv0trEVGqsaBdigJKPqhTSxQY=
Received: from BN9PR03CA0124.namprd03.prod.outlook.com (2603:10b6:408:fe::9)
 by DM6PR12MB4106.namprd12.prod.outlook.com (2603:10b6:5:221::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Tue, 11 Feb
 2025 09:54:54 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:408:fe:cafe::ed) by BN9PR03CA0124.outlook.office365.com
 (2603:10b6:408:fe::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Tue,
 11 Feb 2025 09:54:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Tue, 11 Feb 2025 09:54:54 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Feb
 2025 03:54:50 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v3 10/18] cxl/region: Factor out code to find a root decoder's region
Date: Tue, 11 Feb 2025 10:53:40 +0100
Message-ID: <20250211095349.981096-11-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250211095349.981096-1-rrichter@amd.com>
References: <20250211095349.981096-1-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|DM6PR12MB4106:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c02067b-e5cb-4616-0720-08dd4a822295
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HnwVi+xoiHGmd5Y0ndOFgOtD03tt3mratWc1pkC5RDII4Jfk2u+tzZ92FMwY?=
 =?us-ascii?Q?X+s2SOD9pOOZcpfRp3i3u7wZM0m9eVMdFoSQTGI3IC63Xs/dkGgURL6f9TiH?=
 =?us-ascii?Q?PE2zjNdC5bzh+wm1XqJrG2e1YZTpd7d194Qcg7rwGnRHU2CjOU6kPcwRx7K2?=
 =?us-ascii?Q?UFHEBo1HihHY8kZhq6y9zBuAcqBp/LukReOdq7av0xvyfyJdKVHVHte1HPN4?=
 =?us-ascii?Q?LdZN4nvjELzhlwNMnumsrE2wKp5hlUxEfbSlVyCRso4qKeqqD+tYbZhB0FGc?=
 =?us-ascii?Q?gcNmN76GqP9uEzel1d0A07mPL/SHkpqUnUBSVBONmv+huxYHE9sPaZdjAwTC?=
 =?us-ascii?Q?eqy94p04/S9fsq5AFsg65G/ynnZZ1MJwbzfuuFwNLrdPYsk/4z0CcbWQ74Iq?=
 =?us-ascii?Q?NhEkzdRww5AIvye0cAK9yzpmex8y41UDo5okKLqIwzQuyN9xe52dZXwiL4XO?=
 =?us-ascii?Q?FDw1j+t3Bs3CGdQG5o5U2mnDjCOI2jCCBVpUIg7KJvexLhtw+kSfJ/cDKPoF?=
 =?us-ascii?Q?ISfCg3y5h3g2o83P6sQmMkJrl7ZyhBQpZ+/x3S8e/NHBdwXqhmNRXcNWn2oJ?=
 =?us-ascii?Q?831MEmsX4AziGqIZN8dtd7sliK3q6WYg4tF3uRtKXvTPax2ZygdvSl+Wl9Q9?=
 =?us-ascii?Q?yyZnrHO/Ie3KWYoqj+5lAxCA5iMoASQlQ1CZp+u9GWIXteDwil2NTOzn6DBK?=
 =?us-ascii?Q?8wkM5gW9dkSVr0jhkzzPOkTJ0FAtM1w63B4dROTu7XLk+CoAu1ev2bF3IwZh?=
 =?us-ascii?Q?G8TKpPzGY1cucrowth/qs3fOJlGPhu+pjX6atiRuFofIFbsRCmAFvzNSvCvB?=
 =?us-ascii?Q?yQz8EyJxMKKibM6xMT7nqzj0CeldtRiHdEEhWn3qU792oNtdFY+lvzEMkT2y?=
 =?us-ascii?Q?MXSfg0hH8r3KLwaRIsAhZshL4Y73KZOe4XFa1yJz+0YSae/+PUsIAmkBfE/5?=
 =?us-ascii?Q?SkSXPC0dGlTpeFe3dr35szaOGjFv5Tkb53h5QTTRTlBGwN7n5ZEKKyjzQ8es?=
 =?us-ascii?Q?OzB+8pM+o+Gwyub/rHp9N9GL6DgfZrOmuQarzvacjdTLQ9hiG/1IseP+zotb?=
 =?us-ascii?Q?3JAl1MNK3/CMAewrbWoNIoAvptqJZqIpqAbPuTTEMiNtFbT8FiDo2gtofr+V?=
 =?us-ascii?Q?nHmAYAKlpjkzX8cy1ZmIhcBz5fxm+im4B2N8jsKfa/eZIb1idfjVXRrI/3yM?=
 =?us-ascii?Q?YePZEyKFQ+mcWQrbJQRJE/l1OktUVFnNRcEvLh/8u/CBxIb+HI7Jl9INJygr?=
 =?us-ascii?Q?SumhbycP9/9XPRdpHBcPIEjjVOEN+I0m3wZ20nKLQwRjuFD3OSzx8JN9FspA?=
 =?us-ascii?Q?fF66KVOtlg9K7tet3PzuclibHOv/bT+NtYLwol3u+zLbST9N9f170dV9LSNo?=
 =?us-ascii?Q?yPqFkyntM3lTqaJ4i3LStTXf7d/XFaYR0Fr1oh3AG2oC4zk9CqpCZYilJFs6?=
 =?us-ascii?Q?CgKDpUQtKrTgGHvy25Rs3ZePKO9uoJW0yyYfsn0bGPy6Rl/H9jGpNiZhdQCq?=
 =?us-ascii?Q?WFYTnxfWg9szdDg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 09:54:54.2093
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c02067b-e5cb-4616-0720-08dd4a822295
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4106

In function cxl_add_to_region() there is code to determine a root
decoder's region. Factor that code out. This is in preparation to
further rework and simplify function cxl_add_to_region().

No functional changes.

Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Tested-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/region.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index c641c8922455..9ce0282c0042 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3256,6 +3256,19 @@ static int match_region_by_range(struct device *dev, const void *data)
 	return rc;
 }
 
+static struct cxl_region *
+cxl_find_region_by_range(struct cxl_root_decoder *cxlrd, struct range *hpa)
+{
+	struct device *region_dev;
+
+	region_dev = device_find_child(&cxlrd->cxlsd.cxld.dev, hpa,
+				       match_region_by_range);
+	if (!region_dev)
+		return NULL;
+
+	return to_cxl_region(region_dev);
+}
+
 /* Establish an empty region covering the given HPA range */
 static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 					   struct cxl_endpoint_decoder *cxled)
@@ -3347,7 +3360,6 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
 {
 	struct range *hpa = &cxled->cxld.hpa_range;
-	struct device *region_dev;
 	struct cxl_root_decoder *cxlrd;
 	struct cxl_region_params *p;
 	struct cxl_region *cxlr;
@@ -3363,13 +3375,9 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
 	 * one does the construction and the others add to that.
 	 */
 	mutex_lock(&cxlrd->range_lock);
-	region_dev = device_find_child(&cxlrd->cxlsd.cxld.dev, hpa,
-				       match_region_by_range);
-	if (!region_dev) {
+	cxlr = cxl_find_region_by_range(cxlrd, hpa);
+	if (!cxlr)
 		cxlr = construct_region(cxlrd, cxled);
-		region_dev = &cxlr->dev;
-	} else
-		cxlr = to_cxl_region(region_dev);
 	mutex_unlock(&cxlrd->range_lock);
 
 	rc = PTR_ERR_OR_ZERO(cxlr);
@@ -3394,7 +3402,7 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
 				p->res);
 	}
 
-	put_device(region_dev);
+	put_device(&cxlr->dev);			/* cxl_find_region_by_range() */
 
 	return rc;
 }
-- 
2.39.5

