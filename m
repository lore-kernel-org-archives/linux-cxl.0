Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010040.outbound.protection.outlook.com [52.101.85.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CCF4A8FE9;
	Mon, 21 Sep 2026 17:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790013360; cv=fail; b=m2t4KHSqyWBiS9ZSm1qln9QWi2eKKA0pc35bVYRxo4Pa/JoO5DDPc1L4vXrgVdoWXnVZonIcyCVLXSDqL10h2Yx19pMz/FRP9fVCr5WHhDqaye5eh4RHfAnV+r2zouAbG6cRnMlmxh/ZT6vWue31p+J2gW+rvVssE9dqSB6dB7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790013360; c=relaxed/simple;
	bh=ixlpRm6bkOfmGon63Zy69B3fj7KZ8vh4kzeFvxUNmuc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hZyeBcS70BcPKzo4y07xyr96zXfyCZgSRJZ+vLHgLazS9LI/l/qYjmxROYw3a/i5DygQPBvMrx4HbX1PR9Q35tTpFM7/jiZ9Srto9J1T1pzd+T/6y4vXEyAVIkWAp+oXgmSRSxjqn13aJER3JEHf9HGjXKz6Hqw2LJs5r1f4SSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DHkPd/KR; arc=fail smtp.client-ip=52.101.85.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DHkPd/KR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hsKpAnjWVEPSJYeCgVreyjm056oeCSl5NXA3ukMEHWHdH2A2TUO/JLowrTRTpacd06tIEiT3ns9K+dB1oyAIR0MjOXPMqnjSAnThdi4RC95JqUb68HRr0fKgNWiiQqSOvxy5wGv/9brJOFonf+4eN6Q+CzwmIWCF0OmSsiAywLREauV6G1z6jD6GY5BB5RGsaXQ4Esx1/7EPfQinvskjnvhk1NPWboAUlYDhwph6yobeOc//ErPbsFbccWYVFuh1i8NqUv4Picb9UVI/f+y17jCsURMWY3jDm5r5iqcBCUa20rsKlsZL2Zh1eumu/51BbmwwnM1/1g7q2Xr9ohftzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aorIkc0HWa2KurYiqIBGnyIW+qZeSYoo5Icanm1lHAg=;
 b=QQ6te/8e1wwyjtGtP3ZBSqQuEydKODdsEJWACqcMH1Pigs2PHn9y8Btd8h/81N1jEmA3h8SerNzZ4guadxE0DAXSY95rsa6wr5phRJgNAd0ycNxgDrBPWnykr9Ft0NqyV3sWQccuy4rAyCqg5QViAW+4lRxLg9Wt9IUr8lIBbJjYNIlvBedPu9Xj7LOxyeUNaYSfkAbiZZQTKGCs0v8N8j47lKY0h7kixBO+1yoUZU7YIMcSPN9YJ6mCb5TsEFSVxYMzrMReM+ApYwsFy1QX7hcpVhMerUq18ciXQotrIbK3mccLMW3msLf71ISIXQdmq4e7U/LRZ8Cj7wibKvSGxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aorIkc0HWa2KurYiqIBGnyIW+qZeSYoo5Icanm1lHAg=;
 b=DHkPd/KR9n+87xC6tYtwGPWa6DJdkhgji8d0COHaGujB1+9mIcn5AQU6Sz8O+lPl2DyGHlUBAVCvoctDdo+oo6gkZWfzmv5uMwvqp8FYs+sdrz2v+ZXcsH820UEGBuONcb/YgzmHdoiW253BdXAz/YzLw2B+R1+rpJ4Xyv1PhwU=
Received: from PH7P223CA0020.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:338::32)
 by CH3PR12MB8726.namprd12.prod.outlook.com (2603:10b6:610:17b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 17:55:55 +0000
Received: from SJ1PEPF000023CE.namprd02.prod.outlook.com
 (2603:10b6:510:338:cafe::94) by PH7P223CA0020.outlook.office365.com
 (2603:10b6:510:338::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.15 via Frontend Transport; Mon,
 21 Sep 2026 17:55:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023CE.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Mon, 21 Sep 2026 17:55:54 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 12:55:53 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 12:55:53 -0500
Received: from galena-46a8.xcblab.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 21 Sep 2026 12:55:52 -0500
From: <alucerop@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <ecree.xilinx@gmail.com>, <icheng@nvidia.com>,
	<rafael@kernel.org>, Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v1 2/4] cxl/region: Add region reference in memdev attach
Date: Mon, 21 Sep 2026 20:12:37 +0100
Message-ID: <20260921191239.4249-3-alucerop@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260921191239.4249-1-alucerop@amd.com>
References: <20260921191239.4249-1-alucerop@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CE:EE_|CH3PR12MB8726:EE_
X-MS-Office365-Filtering-Correlation-Id: cb085492-bf08-4e78-3b9c-08df18099502
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|82310400026|1800799024|36860700016|11063799006|56012099006|10067099003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	e7twN0Cw+3+NNWzpAJuG8B1urUgChzLf6QeFbLx937IHI8PlHz3/9d1qSJdpk18Ozf53ea00FTNzdqSrqYfXp1I43Va8pD1adX7BdgSjKzqyRMBeGyq0SfGIKbpjKo0TIq43zdvZCvOgqRgNS03htRyY+JFWrFzOF1ZS1jruEi+KXn5mQjSb2Wz/cEu5Tkxlf4TGQMlPSQD4Q1Fi5/SQkFvk03fja1AAbYP4SaUS/O/KIuM7nSVksIVK9qG6D60jFoKAU7SaaoMOBxmsxbQ7relGz5ph1AJY6uEj12iDvEPbMxfOAp0Y1w4NjKGPa4SbbCHC7m3hOv5BPUthBUBD+c0JbVyfnJiPj75svjjzgPrpHYhcwqdfD9HNPjBebhaZ3Z8NuKJh4LuMlDWPlcMfzQaj/52qZP530UdMQ6jpiy8kaXMnwuQt8xwzMxwbM90O1RaaHCkBh4LHSd5yDeZacoTJI86kEFG91CSYAkIOy35hMU1v4DFSnE6083pKeOAmlArb0iMoXC1NIFBipHVcC7DIb58BWrFFUXh4istZbXucF/NlvBUmMXwfecYTK36PnZK8tHaDJCMZejKS3Y05IQCWM9NM9ZN5jns/8u2UVK8YnQ3qVUrxJbg+43sSKqDiOMzFoLoJPs0MfESOBWSDerjSL8qgniJ/fjizn57MtQES4bhcZwUkIo/QPVA3gld66uXP49KqgZFLPBHd2ilnLw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(82310400026)(1800799024)(36860700016)(11063799006)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9VdHNsmdk1hhbh90KmaRmpdD0It9ZkbNTNDXCkGUeJrqhPc7XmRI2HXZgGboyLZ1vgVxj/X5BLYBx3JUcVcvKZSi0ShWqX27jTNU12Tq2hZZ7mihx1MfUEWkNTmdbao9j/ZpqUGtTivNR2KVYMt3LpgGI2bJUFtRie54IEtAyBL6aO5zppAUVGdUz6tChUqyfGwY/OHrFXDRLvJZ+MWmwwvcmTVCkCi3Iz94a2ovKEteLv24TOeDYlohYAyAzTMtTCSEt4J8bkMAiTfzkxiDW6HpiEvzgMMqqlD4pSloHeXhH+ngXUGfGwyaRpN5Pa4H8JPmhWKHiqxfFew4zJ2gqdGHmkd8Kv63I0hZ+Cdkt3G+Xxe8oQxw/TI//5l9IoowF3dPH0NBwaqD5j9WYfdwCsCbhcPh7lDHw+JGIM8yKUmsx6NgtZuIDhGYhOU2H7Qd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 17:55:54.2350
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb085492-bf08-4e78-3b9c-08df18099502
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CE.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8726

From: Alejandro Lucero <alucerop@amd.com>

Use a new field in cxl_attach_region struct for easily link it with the
region the memdev is attached to.

This facilitates device links creation where such a region is the supplier
with non-PF0 physical functions wanting to use the CXL region being the
consumers.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/region.c | 1 +
 drivers/cxl/cxlmem.h      | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 27e63e6dab7c..78ca7ebc3e55 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -4132,6 +4132,7 @@ int cxl_memdev_attach_region(struct cxl_memdev *cxlmd)
 	if (rc)
 		return rc;
 
+	attach->cxlr = cxlr;
 	attach->hpa_range = (struct range) {
 		.start = cxlr->params.res->start,
 		.end = cxlr->params.res->end,
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index c401e3a1af06..c598561b8e5f 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -104,6 +104,7 @@ struct cxl_memdev_attach {
 /**
  * struct cxl_attach_region - coordinate mapping a region at memdev registration
  * @attach: common core attachment descriptor
+ * @cxlr: cxl region the memdev is attached to.
  * @hpa_range: physical address range of the region
  *
  * For the common simple case of a CXL device with private (non-general purpose
@@ -112,6 +113,7 @@ struct cxl_memdev_attach {
  */
 struct cxl_attach_region {
 	struct cxl_memdev_attach attach;
+	struct cxl_region *cxlr;
 	struct range hpa_range;
 };
 
-- 
2.34.1

