Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2070.outbound.protection.outlook.com [40.107.101.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCDF6BFBF
	for <linux-cxl@vger.kernel.org>; Thu, 16 May 2024 08:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715847150; cv=fail; b=NK45Bpfe/aUmbrLneq/RUggDWsj710ZFZRGeYgHQhQEtbsBLJm5YgeMEag2RqUzS30+1wj0A9fa7kScKY91b2JBY9LReCDaoriaYs2nw83lBAqiHS7KwD7bzFx0MTf3BlyH2foOMxI1AsVaNI/lwRUnULVSRtiwFZQvmJui6C2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715847150; c=relaxed/simple;
	bh=c0KtIH8yXvmwOdQjrS40942Z0AGQeBj6m2JzQu3YBFQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GxClE3AKiIsBJFgRAufUEunsPDHwl3I4zh0qPM/JwcJ1EFDTACA8Tg7+edXs2OYL+MqgNivrY0hAfbBEJz+mFi7/o16gZxVvNLh3xXPha2jUbwo/TlOHKq229thyPwYs5aT4033g+JfdsNTttMryxq501FLR/bRYrFynS0s8Y88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tXoKygoB; arc=fail smtp.client-ip=40.107.101.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tXoKygoB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j2GnsdKxRvSHDkMNEdp4NX96Az9SOiLLCgPLVqmTk0XkWMu56fiky2TshyCqJacuDmM4xIq3aBPz/URvdEW9LA/BuzLe/r7WT1BSN8ADgzvooPyX4htzug7+IS2Zv7Kamv0xgY4XeuFK5moBS9NefVHyVXMPMNfhQfkqF2e0nyBn4cIKgHcYERLPNt0tt2t5DGI1xgF4GaTPGMD1SJnMabL23d3WuL61QiGDaAF1jIytByKggvopem4VHMxMxv/Ew2/Jldx0z41U/x1tFuozVC3KPmpoWY6ZO/KOEq430+zPZW8fFaIzKub88VNzBNBNwdQCyoOJUiYqToUW+oOsbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JR1A5+VgjuB09UPRqcWpkzGStEfOuEU44vbDaafBhiE=;
 b=fxhCRLuhZh72tJsE0vSAoRVWXCAURa/gu9KBAJdkU2FY36fNCnTANHxbmIavIfiZj3vbmBIB4g8U5ucuXt7jeReBf//kJD+V9cVOPV1myRlm+VZ5KJqn7HELmyyjHqWUIFe9Bvq/OdaQWaidLn2PIOtFk6jIGrvLHtB9OgSwSMsCBBWotq4IzyWWd3U8ceHF+BS71c4OKIDqqlJdGWog3z6gHNHl0pG0KYnAH5N0XoZWRH2emRFIuQ90Gz0iYAUr5jZbA2T1xsAxo79+YJmI7hON7h+vHkI9OVJnF7dV5ZDH7IMJ8lWFZceQbg/cquBx8+qk2TPQiLGz8fQCU12Xow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JR1A5+VgjuB09UPRqcWpkzGStEfOuEU44vbDaafBhiE=;
 b=tXoKygoBtb0JMm+2Nt5NWGd+sBRWiBu3YQ148wplam76VwcnWxtAeLi1l/AdyTciCusvTt3gJquKMvURt78kQrJR5VEFWrCO/mZRAkDX83KvH5rIq5PMa8ypxu3s6YJa4mQKinlrN9CuMJ1TR7sVD22hor9H6qK7ywccWd7kE2g=
Received: from BN0PR03CA0032.namprd03.prod.outlook.com (2603:10b6:408:e7::7)
 by CY5PR12MB6321.namprd12.prod.outlook.com (2603:10b6:930:22::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Thu, 16 May
 2024 08:12:26 +0000
Received: from BN2PEPF000044A9.namprd04.prod.outlook.com
 (2603:10b6:408:e7:cafe::92) by BN0PR03CA0032.outlook.office365.com
 (2603:10b6:408:e7::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28 via Frontend
 Transport; Thu, 16 May 2024 08:12:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044A9.mail.protection.outlook.com (10.167.243.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Thu, 16 May 2024 08:12:26 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 16 May
 2024 03:12:21 -0500
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 16 May 2024 03:12:20 -0500
From: <alucerop@amd.com>
To: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<pieter.jansen-van-vuuren@amd.com>, <richard.hughes@amd.com>,
	<dinan.gunawardena@amd.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [RFC PATCH 05/13] cxl: fix check about pmem resource
Date: Thu, 16 May 2024 09:11:54 +0100
Message-ID: <20240516081202.27023-6-alucerop@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240516081202.27023-1-alucerop@amd.com>
References: <20240516081202.27023-1-alucerop@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB03.amd.com: alucerop@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A9:EE_|CY5PR12MB6321:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f72d333-6daa-45e6-25bb-08dc757fec36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|1800799015|36860700004|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N2Vlb013bk9GblZPTXMzYXByK0Q2OFgrc2ZNNlNBNERPejM5NzBPYW1paXl0?=
 =?utf-8?B?WWZsRndyZWtWZWRDL2paRkJ6QzVqTnJoWWRCZXJ2MkFvc1BrRlVCWCt3TVcr?=
 =?utf-8?B?R0JHT3BHZXBDUjBpaXFJajFKUFJxeFlxNUh3bDZpM1hOeGdtMlk1bXU1YWtE?=
 =?utf-8?B?Z0RaaGVtTzlvUE1wSTVkd1ZGR0Y4Wi9QM0FnSUx5MkhURG0waWZMaEJTVWxk?=
 =?utf-8?B?dGVQZDBLT1BGOXNtNlpwcmgvRGNVKzFlb3lwajdPenN2YTZ6N0RCU0RoeGVp?=
 =?utf-8?B?S1RuMU84WXQvWGQzUWZEM3FMRU52S3YyQUFTb1cvRHdsekt4bUhaZDdtdmNE?=
 =?utf-8?B?dnpLTGFkdjFESi91SUY2RVJIQzZFSWZCcmFqY2c2OW43U3FleE9HVlZia1lu?=
 =?utf-8?B?YnNZRHhUU0hzTUFoK3NYME0xeDRRdVJLaVpvQU1RL2M4ZXl2Q1oyUEMyUW84?=
 =?utf-8?B?QktCd0p5NDA3a3dEUXhDd0NySkJmWFdKdldQVHN1dmExM2FBaStIeEk4TFlN?=
 =?utf-8?B?VnNkL3hOenVQUlYxaHorSitCaEd5U04zZlVNNUkyNEZUWnlTb2VYOW9QUndz?=
 =?utf-8?B?RE5kQUtkcm1EK2syZWprZmNrV2ZlbWU3UHhkcFZDSHBWNkNQTU5uZkNCZTB4?=
 =?utf-8?B?ZW1naENXQ2t4akIxVXFZQjhDaEhjS2RRSm5lTk1IeVF6SzdjWTE0ckI2QmFr?=
 =?utf-8?B?VDg0YXNEN25jSy9DVm1EbXBiOTV4Zy9nK2xnam1TQzA3Uk9xTVlkSnArWVJs?=
 =?utf-8?B?VlJEeExuc1RQUGRnWFhhTkR3Q2h2OUUzR1ZlRytjMjBmbDFZNVZ1Qm15QVFT?=
 =?utf-8?B?LzNXak1pTWlDOHYyYmk5cW13bmZnWXpmQndJdVhGNjYyWW56VnFRVGpVQUh6?=
 =?utf-8?B?T1I3WitLd3BDSjNPZkg3WmlEaG10ZEl0eGowUDkrdTJMNEo2UHZiQnlaUG9v?=
 =?utf-8?B?cXQ4aDl0RjhUYTgzdGJXNldqYVgxeWFPbEhZTWpRUU1jbXZFR3c0S1hZeno4?=
 =?utf-8?B?TkRYTEpvbmhqRi9lYkN5OEJYR1NjQjF2amJuUy9TQzltM2hTcHNLYlJ2d3ZN?=
 =?utf-8?B?UTNnaUtnQkppN0prOHFMWDBkTXdhcitDWC9YcDdzTWo1eWxXT1V5RXlBckpW?=
 =?utf-8?B?RjRqOHR4VE9Db2ovOHpzYWpLRWlxRnFIZllCTUNZRVgzejBxOXV6dWk0Q0VY?=
 =?utf-8?B?VzNrWmsyREszb0tPeWo2Tmloa05RL0RTSmtleFh0eGdYb2RxZVVEQ3ZMNm1E?=
 =?utf-8?B?YVI3ZUpsWVRmSEE5K2oyK2QrK0tKWEVId1FNYWRSd3lpY0d4UXMvZHNONEhu?=
 =?utf-8?B?NE9KRUlvWHpZaGhZckJCZER4WThldWZIRnRpeXlWNzB6MEZ5QzVDS2JPUHA1?=
 =?utf-8?B?dGFVR1dQSC8vWXpWclJSZEplR0gxblUyYmZaT091REN1cUR1UmEyc2FtN3JI?=
 =?utf-8?B?Ti9LaUZpcDNHTTJ5NXhiK2pURURrbENBTnVDQVN1RU9uU1lPTTJ1bGpMRThi?=
 =?utf-8?B?TkFGajd1cDZDcjlLWjk3VktjYkNZZWljQVA1ZzFVamQwYjdZZGYrNHFYcXVW?=
 =?utf-8?B?cGYvLzBEK3k2RU1rOElMMmhQNVdRVUk2N1dOVGp4ZjJIWnd0Wnkvbks3cW9y?=
 =?utf-8?B?VGFTbjhJZ21uQk93b0hmSlZnNmhUMldIZnJpQjAvdGJROHNuRGZBTm5TZzNR?=
 =?utf-8?B?SnFNc3l3Y1dlM2NFZ0tvUWYxZytmSWtjSHkvYWxDRm5xTUN2UjFIdEU3a3R2?=
 =?utf-8?B?aEFqTVE3MnMwQlNTTXZCaHFJSExXekdBMkZTeHhtVUZGT2FVbVoraDFpUDA1?=
 =?utf-8?B?bEwzL2F3TlQwRktZR0dYVkxSUGRJNUNhT0RFSWZoRGlIcWxKRVgvTVFsOVdS?=
 =?utf-8?Q?0gH8IdNZ2srnz?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(1800799015)(36860700004)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 08:12:26.3567
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f72d333-6daa-45e6-25bb-08dc757fec36
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6321

From: Alejandro Lucero <alucerop@amd.com>

Current check is using resource_size which counts on a range bigger than
0. For a resource with start and end being 0, resource_size returns 1
and implying a false positive. Use the end not being zero as the new check.

Note: If I´m not missing anything here, this should be extended to the
whole linux kernel where resource_size is being used in conditionals,
and where the likely right fix is to modify resource_size itself
checking for the range not being 0.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/hdm.c    | 4 ++--
 drivers/cxl/core/memdev.c | 8 ++++----
 drivers/cxl/mem.c         | 2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 47d9faf5897f..c5f70741d70a 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -432,12 +432,12 @@ int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
 	 * Only allow modes that are supported by the current partition
 	 * configuration
 	 */
-	if (mode == CXL_DECODER_PMEM && !resource_size(&cxlds->pmem_res)) {
+	if (mode == CXL_DECODER_PMEM && !cxlds->pmem_res.end) {
 		dev_dbg(dev, "no available pmem capacity\n");
 		rc = -ENXIO;
 		goto out;
 	}
-	if (mode == CXL_DECODER_RAM && !resource_size(&cxlds->ram_res)) {
+	if (mode == CXL_DECODER_RAM && !cxlds->ram_res.end) {
 		dev_dbg(dev, "no available ram capacity\n");
 		rc = -ENXIO;
 		goto out;
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 0336b3f14f4a..b61d57d0d4f4 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -197,14 +197,14 @@ static int cxl_get_poison_by_memdev(struct cxl_memdev *cxlmd)
 	int rc = 0;
 
 	/* CXL 3.0 Spec 8.2.9.8.4.1 Separate pmem and ram poison requests */
-	if (resource_size(&cxlds->pmem_res)) {
+	if (cxlds->pmem_res.end) {
 		offset = cxlds->pmem_res.start;
 		length = resource_size(&cxlds->pmem_res);
 		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
 		if (rc)
 			return rc;
 	}
-	if (resource_size(&cxlds->ram_res)) {
+	if (cxlds->ram_res.end) {
 		offset = cxlds->ram_res.start;
 		length = resource_size(&cxlds->ram_res);
 		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
@@ -266,7 +266,7 @@ static int __cxl_dpa_to_region(struct device *dev, void *arg)
 		return 0;
 
 	cxled = to_cxl_endpoint_decoder(dev);
-	if (!cxled->dpa_res || !resource_size(cxled->dpa_res))
+	if (!cxled->dpa_res || !cxled->dpa_res->end)
 		return 0;
 
 	if (dpa > cxled->dpa_res->end || dpa < cxled->dpa_res->start)
@@ -302,7 +302,7 @@ static int cxl_validate_poison_dpa(struct cxl_memdev *cxlmd, u64 dpa)
 	if (!IS_ENABLED(CONFIG_DEBUG_FS))
 		return 0;
 
-	if (!resource_size(&cxlds->dpa_res)) {
+	if (!cxlds->dpa_res.end) {
 		dev_dbg(cxlds->dev, "device has no dpa resource\n");
 		return -EINVAL;
 	}
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 6dc2bf1e2b1a..a168343d2d4d 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -174,7 +174,7 @@ static int cxl_mem_probe(struct device *dev)
 	if (rc)
 		return rc;
 
-	if (resource_size(&cxlds->pmem_res) && IS_ENABLED(CONFIG_CXL_PMEM)) {
+	if (cxlds->pmem_res.end && IS_ENABLED(CONFIG_CXL_PMEM)) {
 		rc = devm_cxl_add_nvdimm(cxlmd);
 		if (rc == -ENODEV)
 			dev_info(dev, "PMEM disabled by platform\n");
-- 
2.17.1

