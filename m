Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA952101B7;
	Mon, 28 Apr 2025 21:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745876629; cv=fail; b=hNAuH8PgPuLfxIqX9Z8b+8lQScaNWzxsXQh5r0VLKj1D7btoH799vqBXCzz0qguqK2SVy5jtj2OlhthrBnOwgfinvvS9JhotJbfmqspZnPA4ekD4NNcvkrOgPXaxjoMmihp/HB5hQjxss7YNeJOnp9LzO+/abIfI/oaKy5XjaVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745876629; c=relaxed/simple;
	bh=AmJSccOiJ9QD+ArkYMtIs6l/h+EE24djVkLNpBq7EmA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DdTkZf355iEsqWBnQE1NI1eKDYWftUYWdL+RgXYXJjOunHrPGKrLHfnXssD4KYbDV0d+frGWZPg8wTL3QcFwZaKWk6FNGBy1grgAEmD2eMqrUan9idR5d1lOCxnBA2QGT9izfKb7yvqURZWNzc2sfiCOgThJG2DGKaKX6cqbiN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jSyMKGgN; arc=fail smtp.client-ip=40.107.220.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jSyMKGgN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BbFImjIM2POgPjJ+s5vnIaclzQxZOAiwQuXTaSqeY+/quXidkw+cxyzVuzbrZOkD5ien/X2bbxzcoAT1Z4pqd+7o9S7MYIx1tG9gi2wlseeeP3996FHB+gR1Id12AaJQzhy+59Fs8I49RqHTmnxo7ndO4u9FDpL73m5/brl2rjNjuMSkwB4sn2LSQZIv6tYp0AIvKnAZDlTTFAINZXJyhTaEoIuHc7rZrDVaLv0s2Y5JenPWDVMhZ+CsIbrkaDcPkJaFIT6h6Dl8kqMfaTSVs+PaCmrySWgIgL3eZTafVFT1kLHl7M9R9gQlj3ut07/6gQZ+/qcIn+8XB/hmKhTO7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RgrwEtOF2c9IFK8ycvjLP1OoQMNUt3jeoc4SGZgCrxk=;
 b=YACmQvCi2NZiOpeGMgd/Tqk+r8o+jFHIBpuIHTsz6OyP4ergm4LCac/zI9srq9DV2f4UJHG+ZeZsllQyc267FpChagBgksT6VTPEOZsIir9v4iuzQO5xpC9UOYKkW6i7dSrXC0p7LiX4mLVYQ1/LATUMWF/XmZ9HCL7f3PcUh6JuyRYHxZzVW+MdPxJEu3qhOOZR9n1/cCFnQnn+6YCIEII3OVo0+ojVtnlVaHIim3i2rIOAnbmlViAQWfWHPzf2K1aGz7od+kCDOFtv0NvTaFeEyox4gSV4dLBKjy14f6oguIuwDMrVoYoUQLmtuKDFT1pP4b2FNBshZyI66oYu6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RgrwEtOF2c9IFK8ycvjLP1OoQMNUt3jeoc4SGZgCrxk=;
 b=jSyMKGgNeN9maAk5QW8aTnQ8+cyzdIT7hShBRtISyVJ2P1oZ4o7ZmI9oMU5KCIgtOr7q7Ma8G4fsFLDt10YkAJr0fIc2vMQY0k+wlMPbyHyvZZiOKM8sN7QuzolTAcXgDB/SzLMmN4Zr9GOXXQ0nfTLPnCOlck8b+37ncszkMso=
Received: from BYAPR05CA0090.namprd05.prod.outlook.com (2603:10b6:a03:e0::31)
 by SN7PR12MB8002.namprd12.prod.outlook.com (2603:10b6:806:34b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Mon, 28 Apr
 2025 21:43:43 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:a03:e0:cafe::e7) by BYAPR05CA0090.outlook.office365.com
 (2603:10b6:a03:e0::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.22 via Frontend Transport; Mon,
 28 Apr 2025 21:43:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 21:43:42 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 16:43:38 -0500
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v5 02/14] cxl/pci: Moving code in cxl_hdm_decode_init()
Date: Mon, 28 Apr 2025 23:43:05 +0200
Message-ID: <20250428214318.1682212-3-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250428214318.1682212-1-rrichter@amd.com>
References: <20250428214318.1682212-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|SN7PR12MB8002:EE_
X-MS-Office365-Filtering-Correlation-Id: b7391672-b265-47c3-e72b-08dd869dbecf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|82310400026|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zY2bs16ki4GYEN8X5HIHziuJO1WBeDV3mwaOsgwsCZpKOsO+Q8yH5AiuY+Ch?=
 =?us-ascii?Q?HI9VhcMD+UsSEsjBpdGf47A0ryN7Y5zBCOLgIB76vtZSSaQ/lDUtTciSeuNW?=
 =?us-ascii?Q?fXinRapSF7WGYSqIXwBGcLNBXhNgOZ7v3mS31Ex61AliLtwsNSSRIfgv5rLE?=
 =?us-ascii?Q?D6F5F9BNy849P34N2PgSoByQoPDC/euZUBB9oOP4LvFavMR+EKpz2XXfMTIb?=
 =?us-ascii?Q?UJpWpLgsBjSb9fRBHwoLhrki5n4UscoJnXWDCXYFxf2kOAcKBVpPdQ8znU2U?=
 =?us-ascii?Q?Sp+tKBPXi5qjYoFcOviaPjPfXo2a55JePu4hWTW8KKfnkDYlADn72onnBBii?=
 =?us-ascii?Q?KPrOB819B+mT6M/pRCxkelsqmzwpKXIHka/ZvcOxbJ0rjnfC0qbiDwP8h5qB?=
 =?us-ascii?Q?t2b3s3CEx/mKzrSG0+UoigqCuAgqWIs8mQ3Zu4qfaaQfmUMiQKGz5ML9ECp0?=
 =?us-ascii?Q?sKN+AVhAYaLtcEO61+V+1alAECmYwuOQUXU5ixmkkrVwh6Nm/af7Usg61/Fr?=
 =?us-ascii?Q?gr9O5PFMbx7DC08OrGCUh//hlduejUzutLrBGfEM7InhzU193sE3scUl7BB2?=
 =?us-ascii?Q?ZGWEUqMPiiIaji2yIXcn4tWxxieHWgX92sFrS33W+gDcEf/RiBBztpst8JeB?=
 =?us-ascii?Q?L1vWtpXu178byUOPfXvc77TfG8tzegwv2x58M8xbvC8Zc82bPJHi6K9pSehh?=
 =?us-ascii?Q?1I5k0bTBdMNc8IBDtC3pdQia5r6oQ4aaNh72nW6LpKT+lVRX2xMvRe1s0K4C?=
 =?us-ascii?Q?ylPTuwYorTgs7wa/Z87DQX62nOyulYyj9JW4SKAVaWSgK/TssWkkAuWkn4v2?=
 =?us-ascii?Q?H3yioSdZamXxTBGGbasNo0652zzXrU/DE/Ma06s9D7xpmmVoLZXy+F9T7cAj?=
 =?us-ascii?Q?8zrrg7WlEcVllDD4nrhk99Yh1mEUAE2DcgCvk7oT077Gc7ckwrCbzzcG5Y4L?=
 =?us-ascii?Q?v+WPs3Cr+2tR6O8xYHyU23oHvQ3FD1kOPYWo7pFgS30ljioSzeqP5nygVv4/?=
 =?us-ascii?Q?eWRi++nAkQ8dsROSYmvdvaq9fwdS6Iz+aiTajw9Npg8H3MyjJWij8cGdVPAZ?=
 =?us-ascii?Q?Fm54AnKE0XVmLACJEqAlAXoKPCMzlaHUhwIVCVHkPyd350ZxQWtQLvqG9726?=
 =?us-ascii?Q?8HMNNPFj1HWucq3L0C3C7iuWJH8xpEev8Vte6Zvcx3TT9cozkWGiAdOMRrx0?=
 =?us-ascii?Q?cuwrz8f8F7MXlMePbF5e8LDoKweK8CWmxyU9PdT4U4WPRRb+k/L+dtYpneRv?=
 =?us-ascii?Q?2NNFTVkU3HnO7o9Y6VqgqXC5jGlVNiRDLjz9+eTsXTSJjTq5+99c/cD3m4Tt?=
 =?us-ascii?Q?kD+u7cN1nT3v63j5Z83bPZxEgIkYweycEvCyhpLFhaoJCW626TUz4cQoZ7/R?=
 =?us-ascii?Q?Fd+zgOmbGL0QX5mk1ShIRI6RmkLI0m9OFaoP1J+SqtJhDeyBdEf1F3OqgmZC?=
 =?us-ascii?Q?FXYdM8wUT6xkL/zGgZopVp2VUHiQmoihelAtM71Cx5WpnrJ3conoQO2AdMk3?=
 =?us-ascii?Q?L1OVb0Zwz2Hbcoa9MPkyWoDrAL7tJWG3NIsH?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(82310400026)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 21:43:42.4215
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7391672-b265-47c3-e72b-08dd869dbecf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8002

Commit 3f9e07531778 ("cxl/pci: simplify the check of mem_enabled in
cxl_hdm_decode_init()") changed the code flow in this function. The
root port is determined before a check to leave the function. Since
the root port is not used by the check it can be moved to run the
check first. This improves code readability and avoids unnesessary
code execution.

Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
Tested-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/pci.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 33c3bdd35b24..6386e84e51a4 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -419,14 +419,6 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 	if (!hdm)
 		return -ENODEV;
 
-	root = to_cxl_port(port->dev.parent);
-	while (!is_cxl_root(root) && is_cxl_port(root->dev.parent))
-		root = to_cxl_port(root->dev.parent);
-	if (!is_cxl_root(root)) {
-		dev_err(dev, "Failed to acquire root port for HDM enable\n");
-		return -ENODEV;
-	}
-
 	if (!info->mem_enabled) {
 		rc = devm_cxl_enable_hdm(&port->dev, cxlhdm);
 		if (rc)
@@ -435,6 +427,14 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 		return devm_cxl_enable_mem(&port->dev, cxlds);
 	}
 
+	root = to_cxl_port(port->dev.parent);
+	while (!is_cxl_root(root) && is_cxl_port(root->dev.parent))
+		root = to_cxl_port(root->dev.parent);
+	if (!is_cxl_root(root)) {
+		dev_err(dev, "Failed to acquire root port for HDM enable\n");
+		return -ENODEV;
+	}
+
 	for (i = 0, allowed = 0; i < info->ranges; i++) {
 		struct device *cxld_dev;
 
-- 
2.39.5

