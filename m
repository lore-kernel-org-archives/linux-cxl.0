Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010034.outbound.protection.outlook.com [52.101.56.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B460C233723
	for <linux-cxl@vger.kernel.org>; Wed, 25 Feb 2026 12:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772022163; cv=fail; b=iaQqP67W0NcdeVgXbt3b7+hGbxVordZzA9qZegAS9vZ+VL/jA0/zFE7q35EF5w2s2A8wieiDTGE+Xnl7M8fWK23Po2PFS0YOvkdliY/ZEAIOPTarHQuKfYQj3mz2SGZoNauhRGiZOuBIx6bbFN3hA4Beae576uSnBB43Q83vbYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772022163; c=relaxed/simple;
	bh=7jUkkwCAHjcpsQR6ZCH7UG5ZUMB29JXDk8rehzVaJ7k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=svq9iAdZLMlcLFBs3AunSeM8E6NiZ7oV11n32C+FoXcujOP+4YSgX1nrx+Ac5SrNAuDSN7iddLfH2K9eQFOvg3et9rrDlRWXvPB2tx8648mrvCzSzS9WGBjDBiEuRorHM5T8lqgTV2w3b+r7Fn+ezExLeru2RPVq0MSkEmoZIRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=M/pkCvkB; arc=fail smtp.client-ip=52.101.56.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="M/pkCvkB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FCOgX61x09FP9p+C3+HXatrO/GSKPho0gNi0dtxYnqIFfE41AF5GoUpLzNqqeYwFTxC9QwRuelvD2wmMpq/DJ7qL/C7ha4JImjvbQKryAsoPOlUY+nryQeptRABE7ANe3ZmeV1pnZ37Gwqw20lUQzeJl3R2PVYoZsKZOghY/4DrKJHV1M0WX9WYtyPlVSMeGF9YtDe6wEnfq2VOsHrVEwLTRQJ82pXs4nIa0dCsTHioT5d+rMjj2sMEifGjmzmKRFHlROR+74wJaVpkMBheW9kc1l/VN7iGyzI6+QR0Xe/78uFHPjp4hO15cO+SgZJBqoXHgi3uEyiYjDnVWY05sog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xq46jwzUGpGetO1BMgfj5kV2txojjmN/BaSnHPeU7m0=;
 b=UVVanBHVQ3pgkH2G2Zu8XcxheVqXM1SD3DM2ghD8Yyj0S9kvbXU4LtKgbrRL3VIgAfD0QI68Vk950fMEXZiS6p6ODDOBZBfjFragZdQmKKW+/u1tTRoVCDcRACzpfBcDuy3u4w5CA05ofsoYs26UZWj/UX9wr0RZraonJORr353eJCxh/Xenu3Kej6oYwL3J2Ddzm6SKPuIXTfOxxVUW8xXBJuogpuDvfZeYKL/XQysI2al4NyJTnxcHsVa+B8T4YQ4+VA2IQPSecKoh/4SOGYFlMmyd+kwqfk04GJumC/lPO2vuKYa6yyE3SGspkR/dEtYgeooKdZcerBY8kJnQ9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xq46jwzUGpGetO1BMgfj5kV2txojjmN/BaSnHPeU7m0=;
 b=M/pkCvkBz1D0z1SnfPbuLxl9eJhGEN3hkypR0PbUksTjvFKuYZnYNcL1fg8C3aDY/OFYBMBgi2pJ6mVCqKnPzAUM0IFWeM7pw/n4pqttb0EWCYAs71ej1tqtxrdjCD7X2tbCVAtAvVKU5cjS2nxzgtQM73ioOcueG4b3K/aSG7g=
Received: from DS7PR07CA0001.namprd07.prod.outlook.com (2603:10b6:5:3af::10)
 by DS7PR12MB6190.namprd12.prod.outlook.com (2603:10b6:8:99::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 12:22:38 +0000
Received: from DS2PEPF000061C5.namprd02.prod.outlook.com
 (2603:10b6:5:3af:cafe::92) by DS7PR07CA0001.outlook.office365.com
 (2603:10b6:5:3af::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.23 via Frontend Transport; Wed,
 25 Feb 2026 12:22:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF000061C5.mail.protection.outlook.com (10.167.23.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 25 Feb 2026 12:22:38 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Feb
 2026 06:22:38 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Feb
 2026 04:22:37 -0800
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 25 Feb 2026 06:22:36 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Zhi Wang <zhiw@nvidia.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>, Alison Schofield <alison.schofield@intel.com>,
	Davidlohr Bueso <daves@stgolabs.net>, Gregory Price <gourry@gourry.net>
Subject: [PATCH v2 1/3] cxl: Make region type based on endpoint type
Date: Wed, 25 Feb 2026 12:22:21 +0000
Message-ID: <20260225122223.3841889-2-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260225122223.3841889-1-alejandro.lucero-palau@amd.com>
References: <20260225122223.3841889-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C5:EE_|DS7PR12MB6190:EE_
X-MS-Office365-Filtering-Correlation-Id: cf93c6be-e717-48b8-4e82-08de74689088
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	ThM1Fh4Byr/jU17ZPpzlbWVBBzHuUA6utbjZ37XE0KqkNIkA+vrUVpGhhvdvfRpFfqYfIDk78qS7mhEiuscxZQmbzRIoWP2VBu+CVgOB8Y3Uo9EKTsAJnkIIWPBpFRB0bDMSmZEASE93tvcYhsOCRr0WIOeqa1h+w/YGdbSa5JpOZO0kR3G0buPiZNMqL6U5J1TbEd3ipqp/6ep3/O2wT2Hu5loPRXtodx2zB0cVfTuSaiCDCHTgs+mCnToYOoWOkn41FkZh3Y4OI5TUNzYyI0jGtA1AMqS1XDJ/pa3kjxnkzGZx7HXw7PZb9+31EGHD6gCe3Z6q2APD3ELOCemcmfeEmrLut1QStWojm597kdq9Ep1XMN9rqFjRV1uhhgZP4ak5V9uBZNxIIH7DAeaBB6N9lKeprjvAOkGn9Ixo1PbQLEMykdCY26XotO3wfL/4Y2mXTFvBNF8AS6znq2oEC4LkLRY8toaVCNYhyL+rytB3WcVos0+DYSn1hVQG84EG+DRuYmPiB7D62b4Z2PoeB6JaRQzlypTVBC7y+/ww2mhBXM/zyW8eDOgA2y9AZyYJVsuSfq7Z3Sk1iEu3XYqyLrdye7fOHfgzF3nFplxYuVmwdWXNVmkvPPzlNUKGzvo7kzKhhBv/Cq9Jp5c6FbbCkGd/sOKxgKhevcgHdlKt1PAQUnrMxUa0r5yAKy8NZaVtOSJSsZ8n7j3YYRS+lZOSSYX0/EQL5+agW4+hJ7GWay3O15ymKhKYdwffKK1eZLR9B9+r/Qjdi2+YxxXf5H7vx8N7q3uTOQjYY6ONdmNnOCQbAfP8qpTU0xjidI7TPKzzbFIWSio81fhMPRfmEXBQjA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	o6OtJjJM1ySgVxjOJ8+tNKQCk0JGr0uAQlTG+ZXWG63rox5tbccx0xUIKa+eVBbD47+3MJCxYczKV2hybZ+HwgJyfEUTLZNtbtyvNJ/7jbbS8tZ3mjUYQ0bYKVg+RQg5E2d6Vm//GdyCHRu5j848DNZAhbnAZxjairLKbACX4H4SohCNbQNY7xKZ5WRP1wTcrD3VpnBoD3eVfQQWOEr6hBZkkeAyNUA0A6l3Jp3aNlwlmnuIwcb6fj3yHPPnOpdKhD7+kKE9eNO0IGNcE5+mCVu++i/386Wh3kcY1X3TxgT8svQkK6pK5tzM8sjOBh3uoEfe42tY+DPpVrWdisAD3/pKC2em4Z6KARrXrzLDNeJDv8uYENOAVvEQXKOQMnEdlqpx55LF3x9KbqAULgykZj8vNbt8+YYO8fG8Bl7ddTb25xW+Sc5G/+jRWqVrSc2Z
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 12:22:38.3091
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf93c6be-e717-48b8-4e82-08de74689088
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF000061C5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6190

From: Alejandro Lucero <alucerop@amd.com>

Current code is expecting Type3 or CXL_DECODER_HOSTONLYMEM devices only.
Support for Type2 implies region type needs to be based on the endpoint
type HDM-D[B] instead.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Zhi Wang <zhiw@nvidia.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Davidlohr Bueso <daves@stgolabs.net>
Reviewed-by: Gregory Price <gourry@gourry.net>
Tested-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/region.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index fec37af1dfbf..cac33c99fe6a 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2650,7 +2650,8 @@ static ssize_t create_ram_region_show(struct device *dev,
 }
 
 static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
-					  enum cxl_partition_mode mode, int id)
+					  enum cxl_partition_mode mode, int id,
+					  enum cxl_decoder_type target_type)
 {
 	int rc;
 
@@ -2672,7 +2673,7 @@ static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
 		return ERR_PTR(-EBUSY);
 	}
 
-	return devm_cxl_add_region(cxlrd, id, mode, CXL_DECODER_HOSTONLYMEM);
+	return devm_cxl_add_region(cxlrd, id, mode, target_type);
 }
 
 static ssize_t create_region_store(struct device *dev, const char *buf,
@@ -2686,7 +2687,7 @@ static ssize_t create_region_store(struct device *dev, const char *buf,
 	if (rc != 1)
 		return -EINVAL;
 
-	cxlr = __create_region(cxlrd, mode, id);
+	cxlr = __create_region(cxlrd, mode, id, CXL_DECODER_HOSTONLYMEM);
 	if (IS_ERR(cxlr))
 		return PTR_ERR(cxlr);
 
@@ -3902,7 +3903,8 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 
 	do {
 		cxlr = __create_region(cxlrd, cxlds->part[part].mode,
-				       atomic_read(&cxlrd->region_id));
+				       atomic_read(&cxlrd->region_id),
+				       cxled->cxld.target_type);
 	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
 
 	if (IS_ERR(cxlr)) {
-- 
2.34.1

