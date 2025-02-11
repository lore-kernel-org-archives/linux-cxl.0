Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2049.outbound.protection.outlook.com [40.107.96.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4D01F3D57;
	Tue, 11 Feb 2025 09:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739267708; cv=fail; b=Ijx1VFjICBKTlfz9HyahVaAIjR5AoV9+EnjAyOP5Dx0+vvBvyEiJEocV2DZRDibzcVw3Qjh8tkz1RV013g9eWYn/2aOOnjGBm2ztfXTqVYhBQ3WiiJLrZaEUgYPcXnBWo9+eSZhXSypsnlSVLRwWAYh4iVHJoHp7hSS5ePgCu2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739267708; c=relaxed/simple;
	bh=+W02+Fn1MOgxHuX2aoAFK8ywe5KGPcv9B4lD9LlcTnE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RYsYrJ1x7aYekMCcXUJbCQxATMUL3ZuiuuGsIotoPXCBGPQBKLSWo8Q8xW+jadz5unuBGJpSSq8TMMH7DkxNVxSRJu9BZ6/wcz/psdqvk1JXu+0djZEzR+V6AOMDehT68ZYGz36ZQpcmbRBxkO9SrXdJC1QT5jG+thaJUPlsCOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wGkE9noD; arc=fail smtp.client-ip=40.107.96.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wGkE9noD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZLoGwPzVSkkAD/HmwnOtSbqAdTNNpWtiS6NzI2Fewcwq9hbcvtrw0E3ecbaL6Z0fLBn0fEcWfCY9LHHxjDQVIdBbmL75WSHC1CmAykohRlvd0+sxJKElt4k9My+wdvTBi+coGFunWyxvtqk3NDAai4wYEURXoE5iX4tlaRe/1Y/AwMesu10VFUQvlbvOC/9kh2Z96TYSXNIYUs2e48PxawXyXdZNH6XJVvUey8E3MTpiZJxKr4y8uTEnIeV3rCsGwukMMz0M0+HqchOtEPH5wI81vd1u7HZbKHwI9I8tW/5ah5bbkAswyAv8yFmFRh/ePxDFdxONihZI+3bIdiCeGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bQD0sUaJ2t131uRXeSG13IQj7LB1poP5k4SI1LfCtDI=;
 b=qSSrrHYDHP/LW9aLn9P0VP1y0XhD5Z4QkY/nLRglo8MA995O+dyCPa+06NPfX/NgryVcM8k9773Z7933Gqv1jzBeYnPsYfdH8wsj7bkwc4NpSI/jyIdI6+C8VC/C3wwGc+yxELRm+VqEYWxccXErPqZUp383f9P0LaHvmV38QS7c5Vb5u+GTrLOSi+oBzZGPiT/4hwR6NjVzOqzQBB+bLa19tcGOjICybMYvMtdwFVevvRBYF9CX0ybB841mEmyHoqD099UeHkxClAG+W7lumyhABAZpghTp2vY+o5u7AIpFszW1IQFEBiFuzLT0+aTEt0FCEntDxbhpBN0Tnbu0cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQD0sUaJ2t131uRXeSG13IQj7LB1poP5k4SI1LfCtDI=;
 b=wGkE9noD42Nepc73i63Q0c50XerNYMKIeOVGv+fF6NY2qdgshcuswKzEuzDv0acdxIff0L1amKCP52BvMIValmthIW2V23eCFBg8VDOsBxDqo1lpjRjRfJYr8RIEMujXsuJ/3lb+uS9JcOsFCILT7zEKSaaceeqSMPd0L4fT0i0=
Received: from MN2PR10CA0023.namprd10.prod.outlook.com (2603:10b6:208:120::36)
 by PH8PR12MB7110.namprd12.prod.outlook.com (2603:10b6:510:22e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Tue, 11 Feb
 2025 09:55:02 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:208:120:cafe::f8) by MN2PR10CA0023.outlook.office365.com
 (2603:10b6:208:120::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.25 via Frontend Transport; Tue,
 11 Feb 2025 09:55:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Tue, 11 Feb 2025 09:55:01 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Feb
 2025 03:54:58 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v3 12/18] cxl/region: Use iterator to find the root port in cxl_find_root_decoder()
Date: Tue, 11 Feb 2025 10:53:42 +0100
Message-ID: <20250211095349.981096-13-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|PH8PR12MB7110:EE_
X-MS-Office365-Filtering-Correlation-Id: 6825d614-50c1-4140-f795-08dd4a8226f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZXd3nHvxMI81grig1C/x0pwP1qplhIp5V69AZ/uQzKZnvypzfWwIiFCBFeng?=
 =?us-ascii?Q?m3M5+D+ujquty617Z/zyTBuyFZjG5vG8PA6ujOUFl/bTFEOs12COkI0RUr8I?=
 =?us-ascii?Q?G3PB4UjkYEJfUdSdj71JTiJE6TCVObbL3VdcMnjfN80s3vMjgud+A/14V08E?=
 =?us-ascii?Q?/Po13EqZAh77ksv+dUFMr6jCcIByaK45++/RzzlntN9Ivn6EK4YiCiLxSeND?=
 =?us-ascii?Q?FZIkW2LL48HM0j84Rm516VC5gmeYSq3IDgHY1aBEIbVdG7/eBp7wGxNH1ML0?=
 =?us-ascii?Q?zxitSwAPk3lqD5fQiHQQYYHZ+ot2YbDbajFGpSyfZbyfuuP+pt0/uTMrGdUm?=
 =?us-ascii?Q?p8kW/zD2i1TUTbyYsMgEjBU4gqm6b7NjCgZv8rg6zLiTkuDV0J4eRDivPA25?=
 =?us-ascii?Q?ze0oRyicn6tlX1Xh386p6QSfeqmrmxqrHSLDP/sjzTr2Nb40h0yXDc+vJjZF?=
 =?us-ascii?Q?ExVoJsEH/t1bvhIJ9nMi4+O9oxYKU5Cug+1HWpua/4G0Sb40gl8SE6eXwe4p?=
 =?us-ascii?Q?fwQnPaoBdrQcrcrcewfc/fFg7Q8kvSgt4X520qzKM6jn7DaoIrvalCMTyCpW?=
 =?us-ascii?Q?U0VlCOpNzUTZJlzP4YYreQ1D4duczWWJzA3hplE6rZiwDYyomsxKPfy31YzC?=
 =?us-ascii?Q?heV3Bt6eYkbw7D6hHA/fZjv1WbgwvA2DSaAeKRaeT81f0cW5qThB8eqLOSJh?=
 =?us-ascii?Q?7VgenVEYyTG8coqk3RBvJ3R6px8cgYzkaIUUVHEqLaj+zvV7BYjqeoHBdYla?=
 =?us-ascii?Q?X9Ug8wv9Gx0T1QrvNRP997jP7Du6Io13Ebt3d1KyDJasjkZusS84TodshYNy?=
 =?us-ascii?Q?/qkFxl97KxdFRRanpVYOlkg2c26On9qqKJpTODqScGzPdEmdVvw9JuVLQboG?=
 =?us-ascii?Q?y8Iz9ibRXP85euJvW8KiUUISKnX+dQLm/taAAy2KVFfaPX5hAP12Dz1zfdSm?=
 =?us-ascii?Q?/MCKAAV0s5JIER40qB7oSHD3fDeIJJvxR8CB+J5Uu+BCOsoZUHklGUeb4dBg?=
 =?us-ascii?Q?tz65Xcd97XPwZyrlKuYidMmc1zqjeVP72re7qUNhUyKbPAEAFzz5xtUQLjfN?=
 =?us-ascii?Q?aotbrPBSNfDF3CPSh2XP69kZHq792VcFoPsGIC6OJetHeiQoiRGyWKAAf9Bx?=
 =?us-ascii?Q?P5U/5KYEnXiVFrsCGiO7VVL6QP32nz35KLIj8mzxtTRwUvAJd1we9PTYSz9J?=
 =?us-ascii?Q?LzpqXzWw98ylSWa1GjLySVHVc6Bd560ENexOpHLaLo5EaynwvpTCL5gDyQSS?=
 =?us-ascii?Q?U7cK3izPitU7V48PQXmhyXWwQOdsL3pSe45CBSLZp8Px7pxJHsez3nELadqZ?=
 =?us-ascii?Q?6EU89BhV8vEeTEg3ymkvhEmXlJaLzd1nth8S9/N33XvZzXqYMzlH20WiqVq6?=
 =?us-ascii?Q?EJlgYevtILjNAXVASs4QAIfRNCdhJg+QWjMWvJ4RZpc688+zggBNuN1uCA9n?=
 =?us-ascii?Q?wJZUluv9c2dUwp4as/GoTrO4AUGfFhI2xqkNoCX7EHaHhICaachisomgoC2v?=
 =?us-ascii?Q?1WwnVeiZKQe6tk0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 09:55:01.5751
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6825d614-50c1-4140-f795-08dd4a8226f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7110

cxl_find_root_decoder() uses find_cxl_root() to find the root port.
In order to support address translation, an iterator must traverse all
ports from endpoint to root port and filter based on system physical
address. Replace the call to find_cxl_root() with the required logic.

Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Tested-by: Gregory Price <gourry@gourry.net>
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

