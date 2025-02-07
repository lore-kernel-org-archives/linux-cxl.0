Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2078.outbound.protection.outlook.com [40.107.236.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E732F2475E2;
	Fri,  7 Feb 2025 15:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738942746; cv=fail; b=P5XD4wDN/Ig6mvP3eFUHR03gRk6kf252kOvnJeZBmPazVpIFSrz1yd2mLzvMRsW6ZdN8kTrfs/vvopmQ6ubMed+xq1xXv4I3lY12XVTcI3VfvBQSiVS/rJY1EBg2gRiYqc59mRsqsDaNaF7MYKaQwY8D8nECBbomCe96uB1fsD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738942746; c=relaxed/simple;
	bh=WsnQC+EFVYqCB8qlPn1qsHaxO7oEYqEQamzYTq7oW7Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gOWP1nHoq0amjyKW8nKZ8woK6GOC8de85Yp13rV5bPkW/WhLXGe3N6W0SGsj/fJWyAzCPI7tioGHU+Ps5xha6CKUlFO1X583PE47w47p7RS7L9wAvDWpzJ6dEqBx4XuZKSAq5LKV5bih55CwVgNzTDcucUUJP2kE/ke6TrqPfv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hNP7yCFB; arc=fail smtp.client-ip=40.107.236.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hNP7yCFB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pN8TB8x4GsiFAMqamxWUP/uXvEqpewv20rrkPj3V5z+6RcnzAFNYKnACpdt1Z6iudfKuI0z+EBr8pPvC8vvU+YMIM7kLW2QZ3Wv6teI1IMVqSReDxX2JBoZgVDz35zuluM+i21pYLPyP3OhCFkCJ4ffps8Rnxrm+rGxoiM+iocH9hXBRFsVEOTVAiP34BxTrE11nDpIJr4znP1CIoRulVrBZDSKSi56GVFa44Lg6znIWpvDeH2sQvuSu4h9jf+M+K6/1RQKka/TxN2uYvLBqnWVfwIL7xQ3dSM5YZh7w+ujYfS1e7tRZYjpwIOq7aFzMZ711NboQfVsyKzBDWDq8bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=enRnp4rJyzuafsh2R8Nko/V0p4/91dX3rTMtR0Z7Jlg=;
 b=XoPY/ChhTx/NOZdGfnoTvaL6JwizyqDK4gsScYXD8gtTAABBa1o46I2ilaZ0Z2VNqxmBFyWTajbc+GxF50vVeVCy9ViJ2s1FpCLDqpezO8grd2AlID9QigeFWcCmiwjxMaof8cAQn06nbbJSznNreXBakjK2Si7rsBn7c7TjM6IRDtNn26f5A299ofyFpN5MDCJDaEGPM05MWgpdIJDif96UT7L5zOd/8E18u9pJtexJRxGTQ1r2CiSBmlcT0swXj4NLnlJvqCFbxsfPETM7OGRs28vpbRbVKl71hlMKy3Jhqbbq3PkYP0nGSH4ib214ZunB9dUQA/BrzEKhsHCUIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=enRnp4rJyzuafsh2R8Nko/V0p4/91dX3rTMtR0Z7Jlg=;
 b=hNP7yCFBytCKNUd2LSrOkOkEv3nYuDCXUyugiKKoHfj3OBxLZGolxuHTRM9SWas/lHTxPOXc9s1LKdQPwoiRYrHOih9o6/7l+sDmzf0N9lxJXEiHsQiR8IuB3EYhUTwuLQ3jJRR4AB/do3YvIQUTZEb0N+rwChMKNi2SpKu4+Hs=
Received: from SJ0PR13CA0041.namprd13.prod.outlook.com (2603:10b6:a03:2c2::16)
 by SJ2PR12MB8876.namprd12.prod.outlook.com (2603:10b6:a03:539::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Fri, 7 Feb
 2025 15:39:00 +0000
Received: from MWH0EPF000971E4.namprd02.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::7d) by SJ0PR13CA0041.outlook.office365.com
 (2603:10b6:a03:2c2::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.13 via Frontend Transport; Fri,
 7 Feb 2025 15:39:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E4.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 7 Feb 2025 15:39:00 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Feb
 2025 09:38:56 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v2 12/18] cxl/region: Use iterator to find the root port in cxl_find_root_decoder()
Date: Fri, 7 Feb 2025 16:37:47 +0100
Message-ID: <20250207153753.418849-13-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250207153753.418849-1-rrichter@amd.com>
References: <20250207153753.418849-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E4:EE_|SJ2PR12MB8876:EE_
X-MS-Office365-Filtering-Correlation-Id: 86ca1259-a1fc-48c3-d741-08dd478d8aef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N/5aPWy0GGtU3TssEk1AydkjIeZwIrigrIR4VQewGc1spqMH4HsFwL5I9uf+?=
 =?us-ascii?Q?qR5pOaYBQJ3rEcezUXWhfWRjGz96Ut45Bl5M5QZB/1QdVj5u4fETX8B++gQf?=
 =?us-ascii?Q?w/TTUVjp219T1sWQ+h+tO5nNs59n+7YlP2gde9lU2tl+COFlybTVOiy1DViy?=
 =?us-ascii?Q?Borrg1PIXjWOUCV/h61Mv3nA671UbTHp9HEqDpmkg4LDzWJCgnXHTBs2cej2?=
 =?us-ascii?Q?h+VjIWyYOA/iDt78dIEryfv1s7FvRoCPKeVZiriTo2ApnPstnflN0b1769ES?=
 =?us-ascii?Q?iJ3ubLjbR2/bNvxdQdoB67qsQjfGfBH53ddBpPaknjRfyD26y3haNhuwB/pW?=
 =?us-ascii?Q?POcda2rc/MTtiHiFjQ7yblRlTL53LnwGQZ1nrPN4igX4KxKBjG6sTzqSU5ov?=
 =?us-ascii?Q?g0Om7uQaQiJ+UKV8rnkBtuzFbO0UjdTmKwc4wdqnzLEBQkEtjIhuQwmO4shE?=
 =?us-ascii?Q?ph1AhnpcutcGP/+uigwOvtc6ea4xfH6ad1WGONsW3g9M38kZMVIE8qoh3zgF?=
 =?us-ascii?Q?uiFzIhoLmtXYMdUdcPWFnFmy7wgEaAuiwsIpWnnPE2DjiAHT3Hj86M7Mai8D?=
 =?us-ascii?Q?Jhom0RrbBdi+L1tCVQxaC78G+32JS+Wq0VHqWgEreaExQ6B12MMSYDTAxzCC?=
 =?us-ascii?Q?hDd9eLVzVbaa6HFFK7Fccnxqgz0Bof2ENbgmg7xFLZ+mJJRTl/nl3CNge0i6?=
 =?us-ascii?Q?KMgNfd3Bj+HfcU6rN8V7rI0+9Pa4JAeCXFEXQd4mquqeKPxJZmR0y5/JSCQn?=
 =?us-ascii?Q?H2oCgdUoz+rXOR+bUlPK9J3ANAwHZPKMBOIoTLFrcDtkT3uEi63eqR/pwOCA?=
 =?us-ascii?Q?H/eatXP8wG6DUOGkcO9d8tfa0hpniKdl0NtxNbBB2TFoMv+viX5mX6wx1656?=
 =?us-ascii?Q?tFNRHgv8lUn3bWjGucqQJDK6XnRQqcWtjgjqFZJbWZj7OYXLM/6L6kchtZ+M?=
 =?us-ascii?Q?HhUC7jCoq6eNfSa0SdKyq8K2J85Ch3mViWcXWpJcXOxC9HFP+NxUM8n/SB6+?=
 =?us-ascii?Q?aDQ8UHyq389PcutYKmfFtqxU2LBTbfyIifNEh5YNzKZvxtHA0pVpuj3CBECk?=
 =?us-ascii?Q?CVbMdE+vuFz3TJSWmhkFG06P9MD+dQHomuREdZrzHJShogPtEhfY0MkSAnv2?=
 =?us-ascii?Q?cUgTO67FMXK8rtM7pJIeuGUGAivDr7faWKF+Kwj4NF4cQEJNERSDkM06wi3H?=
 =?us-ascii?Q?19bULvrTzhz1SZurMmR/RvZpfsSrGrir6zylZcA2/GTW5EYyVSzyqqTsi0sF?=
 =?us-ascii?Q?J0ClwGyhX2S9zXimzVZnKxyPHZBCaetKuhWLcluyl25wDhuJxxv3liBCZUF9?=
 =?us-ascii?Q?1GhXOUkabgkiRgkkKhmi0zj5zDUpgecnBPR0isNQGqwpoqVXcbzFJ2YsR+NU?=
 =?us-ascii?Q?6/o8WSUCaas9b8LWYu43OH/mOJh4xNWHirIS8+m437kjHDDkBin4l3LdaN9y?=
 =?us-ascii?Q?EFTcUzNxi0c+a6Z1zVBWR5s9B1xBxkjURyj45PpkXgqfNfSK6qpjWyr89fw9?=
 =?us-ascii?Q?tohCFfdKRq2y9zo=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 15:39:00.1694
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86ca1259-a1fc-48c3-d741-08dd478d8aef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8876

cxl_find_root_decoder() uses find_cxl_root() to find the root port.
In order to support address translation, an iterator must traverse all
ports from endpoint to root port and filter based on system physical
address. Replace the call to find_cxl_root() with the required logic.

Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/region.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index fb43e154c7b9..cfcd235f311e 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3207,13 +3207,18 @@ static struct cxl_root_decoder *
 cxl_find_root_decoder(struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
-	struct cxl_port *port = cxled_to_port(cxled);
-	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
+	struct cxl_port *iter = cxled_to_port(cxled);
 	struct cxl_decoder *cxld = &cxled->cxld;
 	struct range *hpa = &cxld->hpa_range;
 	struct device *cxlrd_dev;
 
-	cxlrd_dev = device_find_child(&cxl_root->port.dev, hpa,
+	while (iter && !is_cxl_root(iter))
+		iter = to_cxl_port(iter->dev.parent);
+
+	if (!iter)
+		return NULL;
+
+	cxlrd_dev = device_find_child(&iter->dev, hpa,
 				      match_root_decoder_by_range);
 	if (!cxlrd_dev) {
 		dev_err(cxlmd->dev.parent,
-- 
2.39.5

