Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592681F3D5E;
	Tue,  7 Jan 2025 14:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736259075; cv=fail; b=kfMOIaZZ0x6WiogCdglvIWDHJufIu7DtToxHOWQPQlcl6wiCIvd+S+EWKP4XAMZ5AOxHfvrGmFMZVu0+uW63QAZT4siYQmRT17O4fJ1eptOjUvYwHUwcRpqBytIITB8eLai8yHPN4fXBP97zinOvNvcXy6eRKvuU/D2zL8ykfrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736259075; c=relaxed/simple;
	bh=438G+qvBdIW8qX1eM/hwhJdrZiUWnHM2y6DrtXRs2Sw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oPUlo28hZ1oclyfVNHBP0R1AKZkagztUdnkcgEnTTdPSyEGvLL5YwcxMaQATuHD0A9X4zElzypjgHW+dedG2qazqREgtQsjzh9cmk4qcTCgiEb+LLbW7mWk3ssvcz2t2LktmMgysYl7W6nPyh9gIfwyuMOywmyPae0sjGBdyFv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HoLHFi+q; arc=fail smtp.client-ip=40.107.236.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HoLHFi+q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OYNy/7xyGoVViV2M/32m+VN/BW3H95+jFX0oO90ZuaEZWW3X5AoZdXP04k+dqWlkMzq0RDtWg//N55TRNxnAeHmoY3cJXJuY9LIUfLuPhoeRPEPCaI+Q+gBCEM4H/1rlcI376L4d/Zyficd8GfZ2j+NPLaOy5MPwLkDXskOfWhwtr9UlxIuTV0Dyn3Au32j78quwkVmhMz4LU0Dx9U29R7790sKeZ5vGnov1dOeWn1+YL2hOg/Eb9vnwR4UE7rc8inp65QUqSVK3KM4lHB0TlBkZAWRofAWjd04nMMrxijSpbHDKwH4eqHpzAo/801eZGQDawqzW11A2cgmw5YYyyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ufE53pNySOALiuPVVso8hyS9fzh3aFaC4N2B094/egE=;
 b=dUFNWx4ejzz4dC/dnIids8WlE9n1MMqKq9pdcgik0mDVAUAHEY54JD2aAf86fk+1S0ipZ08pYRQx6sAYtiftPIgUCR97jGvvhg29XTiadjtD00Bd98GTZrpjj58dAXQZkfVjuN6+Jo9Jau1j+uTXCPOpxJ9nMTFHwFw6SiBrFoYkBfiXTUvksQB6tOr0FskCCKXLfet3sb9SD7BzZm485olIgTzZcPqPlMt4RDOTkZvTfH26PqgIWlc70GME/K/n6o9vmEOWsGHlabpIteu7PklZqfWpOKt/6QNHW7oqhSKvyE7jUziSrxB1iEx38fI9ZhIBYEIjGu4riRamoT9JRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ufE53pNySOALiuPVVso8hyS9fzh3aFaC4N2B094/egE=;
 b=HoLHFi+q6ZdlV2iQF9rj4Bbyrqx+y8p62/fk0xOc2wSg0+qX/Ejiid3tuw1I8qSr9FDt24VZ1M65stj1rKljHNfHbRapWZrGo8cwAWynYKPb+XrZ9sDB/6W5bmu/igKv2CpM8rpWJSK/iCacCKkmFMrJOMSLOQSG8mm7NCy0/Ik=
Received: from BYAPR01CA0063.prod.exchangelabs.com (2603:10b6:a03:94::40) by
 DS0PR12MB7873.namprd12.prod.outlook.com (2603:10b6:8:142::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8314.16; Tue, 7 Jan 2025 14:10:56 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:a03:94:cafe::68) by BYAPR01CA0063.outlook.office365.com
 (2603:10b6:a03:94::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.17 via Frontend Transport; Tue,
 7 Jan 2025 14:10:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 14:10:55 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 08:10:52 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v1 04/29] cxl/pci: Add comments to cxl_hdm_decode_init()
Date: Tue, 7 Jan 2025 15:09:50 +0100
Message-ID: <20250107141015.3367194-5-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250107141015.3367194-1-rrichter@amd.com>
References: <20250107141015.3367194-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|DS0PR12MB7873:EE_
X-MS-Office365-Filtering-Correlation-Id: e3246f20-eec9-41f4-4c3c-08dd2f251a5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CqU4KxfQ4Qzhex8y3pG7uP7eAzTSf6uYQ+Wfnh9UKES5wO691lzAyzqhV6fx?=
 =?us-ascii?Q?JYWFleH50oMR142js8ks5Je9hFQro5Gujb5yeOlf1Z/TRlTV81ws9mbwc77s?=
 =?us-ascii?Q?fSGBJHm6aetZ6omfBp5YDDaiGcYJRUwP0YBr+jsKWxRrU/PiNYhtLXEnrAmb?=
 =?us-ascii?Q?fvOc9u2vKp28yn2LioMJqirN1dSr+a6H+UUi4NHWOcRkbR7taDCXcpjADhTJ?=
 =?us-ascii?Q?lgM/9SsxzFH6mlpUvHn3JlVyaXtG6qjBBVPw1hfutosjiXsATZrLJkFnHuWK?=
 =?us-ascii?Q?AoifjdYZyxT9pKnswfFwHkDj4Bogy//LMBsOIWD0H7hsLUkVlZKMVq5g8Pzy?=
 =?us-ascii?Q?T+AMI9VY0l5Jis0iGT4pHYdoWDPdTRsT9RWz6QAWxCIQqO5LHwgrNaq1uLiC?=
 =?us-ascii?Q?CGoqwN2Sr5zlZk3Cd4ab/lNfEoSknE7AAiow8jP+KpTI/nl4eTF5CmVjJrhO?=
 =?us-ascii?Q?eawo8M1NDnpAOCSh1fgfMlE/mGY5VjDy2JX1MSqFR7rZ2sPpwL8Zpj1ZUZZ9?=
 =?us-ascii?Q?C7cLaxZuKRv2A8R+hqHe/IOMjJT+oWgWDZOYYrruybcr2VRde4ZiW9yLITYH?=
 =?us-ascii?Q?oa3a2LZJMlib+bmM/Uil6wUXigZdMqZu29plzsYAP05nQZ3BnFFubygCO2H6?=
 =?us-ascii?Q?xEF0HufG1sxilSDBMbjRZ43Jj1Q4BIDnnbwFz0DRTp9clXKS94nMWIpiSYcS?=
 =?us-ascii?Q?rBfzYJ0pu8ttCYlcX6uop7kkf/xDqkK4vs6Sq6Y4OF9Vf3viEpud/eJFCgcS?=
 =?us-ascii?Q?nl8wit2P3h5NLP/sOHqeTsiyVTAJLBsucOAnvtUmGI6QsVk/ywLT7P8BZEkn?=
 =?us-ascii?Q?iCIsI7iunu+E1hVl4UjlNGzsZU5i9q8gvb/a3wJWC1E3IizLqKTqh2R83dIg?=
 =?us-ascii?Q?QSrp2JXbTho9Cn2ypEjNbqCGA9u2zKrpiqYbHN1l0sC50uIWyuAEQrB9Dwol?=
 =?us-ascii?Q?x25keM1bdssBHoqkLZw6Zjr1ya3eL7dMj7VkZrgs7im0ciPcDNDEFdlZ0X+O?=
 =?us-ascii?Q?R67qfo+qqkD+0HycNBS6oJF8zSqBYN6LZA6YSAyhupScieFz/IU6/jcxgJ8i?=
 =?us-ascii?Q?Ca6v6aJpkShZLlfrKwGc3/QiPeQdZ86EGcD4SBQAApXZV02KpfPt8gvDRfDS?=
 =?us-ascii?Q?WcDS0nKaYTzB6rTx7fgJLjbXFAO6eMTw8tb0z9B9VgaUnRGzTqK0GfNzCnbQ?=
 =?us-ascii?Q?nWSyYtP37P8294DUkPbLkKIunE33+2PGf7P8egUnubGkP1F0trZAvbO8lg8g?=
 =?us-ascii?Q?0Iyi+BxR+CQDXQAdCpPZ2fF/tj+EMzI4Jo1B2KI2Zuz/HLYYJETvgCHPkGOd?=
 =?us-ascii?Q?rj4h2DMbRLhuEbUeouTmAjPTbMsNDO2pBhgW1L1VC8Mw70XriBYxfX6pE3uk?=
 =?us-ascii?Q?7r0PF+jSwhxSe1S0c5+mivimuoarnsmXyfk5PFZ9af28xXJCEiwxQbbtsWVP?=
 =?us-ascii?Q?G74Y2UvMo1pWqiUUDh+GLn/g2fuhf/XSCH9WnrQi8Nhn07xXi6gATkuW8cAs?=
 =?us-ascii?Q?myaDvlgDTcMqN6g=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 14:10:55.7336
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3246f20-eec9-41f4-4c3c-08dd2f251a5a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7873

There are various configuration cases of HDM decoder registers causing
different code paths. Add comments to cxl_hdm_decode_init() to better
explain them.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/pci.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index c7050c13f71a..4d2154457efb 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -416,9 +416,17 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 	if (global_ctrl & CXL_HDM_DECODER_ENABLE || (!hdm && info->mem_enabled))
 		return devm_cxl_enable_mem(&port->dev, cxlds);
 
+	/*
+	 * If the HDM Decoder Capability does not exist and DVSEC was
+	 * not setup, the DVSEC based emulation cannot be used.
+	 */
 	if (!hdm)
 		return -ENODEV;
 
+	/*
+	 * The HDM Decoder Capability exists but is globally disabled.
+	 */
+
 	/*
 	 * Per CXL 2.0 Section 8.1.3.8.3 and 8.1.3.8.4 DVSEC CXL Range 1 Base
 	 * [High,Low] when HDM operation is enabled the range register values
@@ -426,7 +434,8 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 	 * DVSEC Range 1,2 to HDM Decoder Range 0,1. So, non-zero info->ranges
 	 * are expected even though Linux does not require or maintain that
 	 * match. If at least one DVSEC range is enabled and allowed, skip HDM
-	 * Decoder Capability Enable.
+	 * Decoder Capability Enable. Else, use the HDM Decoder Capability and
+	 * enable it.
 	 */
 	if (!info->mem_enabled) {
 		rc = devm_cxl_enable_hdm(&port->dev, cxlhdm);
-- 
2.39.5

