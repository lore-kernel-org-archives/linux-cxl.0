Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011004.outbound.protection.outlook.com [52.101.62.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18786330B07;
	Thu, 12 Feb 2026 22:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770935907; cv=fail; b=FAh41GgqS8Tt5/bM0eAF7lHnN6O7s0nSHJD01MTZXm6+S5IRRcqQNrxlsGA0lnOQnqzEtgY9y+esoAWDZPAWtupNKVBeMzHg2sK/LrWtY3w+0Q4QaoAjOPNSngVr2dhIj+o2rradxPxAHMBT0YTuTi5vJJGe2/fZQ4UmcwUj7k4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770935907; c=relaxed/simple;
	bh=xJpHE/qoF6LpIYKWBdkw9htjIHy0CWjyZhYrf1l0pn8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Rz0CQD8tle5/TWLybRB5ILtfOOKw5GBEVZTTxl2qSU5uR7AlBtEv8KRWFAl9QkW98ugLSDPXedQFIrZbHSFUYLd9az1zo9GZpqfOvKOTFQiOmRlNAr1L8JDf4vJXGLUzcK5qq5i6JUaMg3guxXYyobP5YIfhZei0MAI3QQJ7y10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=J6si4uOF; arc=fail smtp.client-ip=52.101.62.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="J6si4uOF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s8KqBa0BcmwtegCF0xyNIWRm4sAGO1+ggZqzo98OBWn5oOedyHq8xrmi2VykZx+rNfx4JlAC8Jcml+LUg/ayOHSkxgCSreP8gbX+ebUmENWQly926N14pYVb5vsi1dUJXYXZGhynmy6b698qL5Sk6b/M3pBHB8WC6y4ow1fqHdb210FM1HSetdm4S6yx9f1WVsovdWLsZ82oRAQIjkZOlKTBEZ6aPQlsu6MGUd5ovAugUgTSRdH5D8Hc3sDRtchY9qzzE2T8QlIVjH0vFwqgYwUGI4mQ6kDwK6dctKH5lx0Rco2D5zn/K8EM5RaKIY8bYVPGa4RugeNQK1BAl9PhUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X+scsZHnwcAdE81a3CTl+13YVPqRk1QF41KpgYvio0s=;
 b=LAruU5zVYExWAytGecKRHV5k68HU7J59wxXCeh92AOXE93ihsnqb8qTFECzSWEc5/0CRPaW4tlHYNZF0T9bGEj2IOv7j3RZHQna/vpfbGwaXyjoQwT61dQHYU8ne1u35kz+bqiiJyuF60x0aW8VF6IbWvMHAk643bbWYZUEQJ+K+GfzoRmfAgJAqQtWNfB8DBBY7UetBwAgFgb9Pf56x9eGgTx9ohwEIeNOdymolaHKOWO2IEkGnpE4KfNP//rcQAB96KjhxaBZHbIiRNJmBI3TjzBZqjKKgwkH0ySE/IKV9Q21ejsgJm8zHnxB+0pcv0yq8wh4nEfa0brk+CdjPQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X+scsZHnwcAdE81a3CTl+13YVPqRk1QF41KpgYvio0s=;
 b=J6si4uOFoZQsETVzfbsgW//3Yei9cArGH4mzAhMJIITK7jwLzhHUJ0XwZxOcZDSCWFeviSlaSZiFUWYZQBZUE6WNYGgwn4JgfWb2E8CDQs4dJr8UF0Pmff7HLKeHP6wEwnn+8QveyOzmk2HVwUzKrOutjs5Vjtn7x4dkMSf2zpQ=
Received: from MN0PR05CA0027.namprd05.prod.outlook.com (2603:10b6:208:52c::24)
 by SJ2PR12MB9189.namprd12.prod.outlook.com (2603:10b6:a03:55b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.12; Thu, 12 Feb
 2026 22:38:18 +0000
Received: from BN2PEPF000044A6.namprd04.prod.outlook.com
 (2603:10b6:208:52c:cafe::59) by MN0PR05CA0027.outlook.office365.com
 (2603:10b6:208:52c::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.12 via Frontend Transport; Thu,
 12 Feb 2026 22:38:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A6.mail.protection.outlook.com (10.167.243.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Thu, 12 Feb 2026 22:38:16 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 12 Feb
 2026 16:38:14 -0600
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>, Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>, Benjamin Cheatham
	<benjamin.cheatham@amd.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH] cxl/hdm: Avoid DVSEC fallback after region teardown
Date: Thu, 12 Feb 2026 22:38:00 +0000
Message-ID: <20260212223800.23624-1-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A6:EE_|SJ2PR12MB9189:EE_
X-MS-Office365-Filtering-Correlation-Id: 79c585f1-d3f2-4bce-19b1-08de6a876a2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?396nkLoq7kt2JjpsVzsBOD9kUo6crbnftw57dHpDffxE4MJYXQdfjcZtpgr/?=
 =?us-ascii?Q?DTESXMlVNpok7Hg3+MbNrmaoH9w6LEfsyGA5eEkN/A5PUdJRqfl/HlWknPhc?=
 =?us-ascii?Q?hktLK7e9+tPf5lYlTJaeESyJZInD82H14or1O8yHA2gIn3IRSnxpskSlW4Ae?=
 =?us-ascii?Q?4IRqRn3DTUGneQN7wkAFwCKEHmY6GssWoJ3Jq+N0sPKPysd4uGFLIeCknemq?=
 =?us-ascii?Q?dquPF2SpOsiMFy8/JXWJlWkQoU7NMeoZ6ffiqaBn0Whglk34KYAQIA4rd92R?=
 =?us-ascii?Q?5xEQmdN35bE7mtAnmoEp57JNOWUM+Am0KUJcsrUAzaZVRgNaDNgjkzwfHwKN?=
 =?us-ascii?Q?JvcRxkyAjR04U/9v5VLEjPzaZjFzCmKixGz327l4rkZF5VK8mgea5Mmm06qw?=
 =?us-ascii?Q?llXgMXYuNwbO5Xb5jpZFBybWvuYKp5jsg1RcD4Wc7o7kw0mx7pu3x0SY1JyL?=
 =?us-ascii?Q?pMT6PE7W6BEaH7c3mCE8E0rGw+nbmiK/t/AVLTyDB/jzaZrvGF/Jm8mqZDAN?=
 =?us-ascii?Q?r4Th+FW1zvP3/YEldqRGkFgxns1Dkq/L8/aNJ1+QViP8pU6JM2jFxNDUktgq?=
 =?us-ascii?Q?zGd3s3tpWGErmrNr5vDTk+i6Fzi03cBN8PZ9PSbaB63ucjzGvfuUTdlW2xyH?=
 =?us-ascii?Q?66Jnt+RnzAVOBRR+fpTk71JnWqKYbQUu/o7KSIC9nZm5bjQWlGOvThSDB5lg?=
 =?us-ascii?Q?xQn5mPDgor7GvkqK2GTvX9pfP/HiVEry/4NNBh5das1KI430Jgyc0SpmfbFr?=
 =?us-ascii?Q?adYsgjg+dWkv1zng4wLB5tt18g+tVA+QRNfNw6IAVzGZ8b9wRzMNyw1S0MHE?=
 =?us-ascii?Q?IYMd2YNsUhZtCPkkSNRFVdh3Yq7hOB8fPiGdrW4E/mQe64QhWWMJN3d7Fspo?=
 =?us-ascii?Q?MhMbSKPkhd8prGdDNWK417qsIA6dx0VgQjWDz31AMX6nsGxHgYKQRVijp4rm?=
 =?us-ascii?Q?dvofWfBQSikoSxXn5K46kq+pWyHlhVYCGyH3Cqjwpat+vWU8kw4TiDvhltyB?=
 =?us-ascii?Q?qj2pH506cscaRujTSFlW9wqdhUoAHN3j8IK5R1eeqKBDhnH7dnLjD1S/hWmJ?=
 =?us-ascii?Q?z95h3mqrSsKnux9Mzpdg1ltkzA/a3MA0/lzqoTU9oMgCLPXh0REzGyBsKaOd?=
 =?us-ascii?Q?rsUM/zJpnv/YEiFQXML5ciURBy4CIso3WGybKC3OlTrNqcNvEZ8kn72Ef3Ky?=
 =?us-ascii?Q?9V3w5jojCHyQeg42LKJs+MBRBH4/67H+JpTQvPlT0u2EAixcxFx+Rue/j6vH?=
 =?us-ascii?Q?h9tG9Z/0R6ARXyK+/C/WvUQgQnQWwhauKiCX9EuB94/NJQq1Bs5fFL3K4kXC?=
 =?us-ascii?Q?WRCb+p8gfKOyJUI+zno+UkmZEv3naP9hz2ZtZIhSnexFBLqxruS+PYEjnLAY?=
 =?us-ascii?Q?WHyJ/PcCRPmoHSEEt0H0+BkAKx16+OeoDQcLCg5w4knNEIHFwlBeSdCoiCaA?=
 =?us-ascii?Q?8L3kLNQ9O7HVwtANaUB99WlLc60sWR3/LEHR6gndujzzGN8U9X406S0JUgRb?=
 =?us-ascii?Q?CKPZ5pXrdhOao2qMMhs52HEVo33fbU2bw0Si8uUMwxsrNnBXzYybY3/oO9ZU?=
 =?us-ascii?Q?RfmVBVD9kMDnhLCz8cNL6/Yh06iXexeW+0Tz1p4d8UXTxZsgwLTKmO3vr/R7?=
 =?us-ascii?Q?t3lb1I/b8t0D5BJGJzihhrZlZSH+3DW+9KKHMm80XH3eiHRP5BirouY53O1r?=
 =?us-ascii?Q?shZN9w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tAOlVCTQDYk2apZhdvM3rDmEbkoM67fDj2ji/wOH8Xfb7PfPqZ3DpEsevgcBvwV1JGVpi+v56YyE/GadD2WK4ZMXRL1Gh2L+zO1AWwE6LFQclx/dCmnCYMXV5rrZyzXSeISBC7a/fCT3IDHVxQh3qv5mMc+tM7XtdGhlTzQwwmKxVQHegJedYeRNcnwGUidd2cB9IxHVJk7HsU5556Trd+lGbvZoabKZWVi4f+kjzsTtW91ycxEMgFq7CvExDWnzUzHkLavKlkIQPdc67A0AI92/FT0m/v1lrgqE31kGWQC1dtgRgK+K9gQjhSiaiHwkhy1LxEQK6nMHvnWnHI436f4w9+vs2pjrQg9o2l/hHr9TSfXYyTWT5tKPEUIHvrOCGqJaTT8mpmujeHqYVZsECvA+ZdCXl4cD8dgXP0kqf5lPIpocm8ZHGexogo4IkuIR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 22:38:16.7133
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79c585f1-d3f2-4bce-19b1-08de6a876a2b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9189

After destroy-region, cxl_region_decode_reset() clears the HDM decoder
registers (base/size/commit). If the memdev is subsequently bounced
(disable/enable), port probe re-evaluates decoder capability via
should_emulate_decoders().

The existing logic checks each decoder's COMMITTED bit. Since those bits
are cleared by region teardown, should_emulate_decoders() incorrectly
falls back to DVSEC range emulation, even though HDM capability is still
present.

DVSEC fallback marks the endpoint decoder as AUTO, which triggers
cxl_add_to_region() -> construct_region(). That path copies the default
interleave_granularity (4096) into the region parameters. The resulting
spurious autodiscovered region consumes the CFMWS HPA space and causes a
subsequent create-region to fail in hpa_alloc().

Use the global CXL_HDM_DECODER_ENABLE bit instead of per-decoder COMMITTED
bits to detect HDM capability. If the HDM decoder block is enabled, zeroed
registers indicate teardown, not absence of HDM support. This prevents the
unintended DVSEC fallback and subsequent region creation failure.

Based on cxl/fixes.
base-commit: 8441c7d3bd6c5a52ab2ecf77e43a5bf262004f5c

Fixes: 52cc48ad2a76 ("cxl/hdm: Limit emulation to the number of range registers")
Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
 drivers/cxl/core/hdm.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index eb5a3a7640c6..a0718cbcc355 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -94,7 +94,6 @@ static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
 	struct cxl_hdm *cxlhdm;
 	void __iomem *hdm;
 	u32 ctrl;
-	int i;
 
 	if (!info)
 		return false;
@@ -113,22 +112,16 @@ static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
 		return false;
 
 	/*
-	 * If any decoders are committed already, there should not be any
-	 * emulated DVSEC decoders.
+	 * If HDM decoders are globally enabled, do not fall back to DVSEC
+	 * range emulation. Zeroed decoder registers after region teardown
+	 * do not imply absence of HDM capability.
+	 *
+	 * Falling back to DVSEC here would treat the decoder as AUTO and
+	 * may incorrectly latch default interleave settings.
 	 */
-	for (i = 0; i < cxlhdm->decoder_count; i++) {
-		ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(i));
-		dev_dbg(&info->port->dev,
-			"decoder%d.%d: committed: %ld base: %#x_%.8x size: %#x_%.8x\n",
-			info->port->id, i,
-			FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl),
-			readl(hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(i)),
-			readl(hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(i)),
-			readl(hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(i)),
-			readl(hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(i)));
-		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl))
-			return false;
-	}
+	ctrl = readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
+	if (ctrl & CXL_HDM_DECODER_ENABLE)
+		return false;
 
 	return true;
 }
-- 
2.17.1

