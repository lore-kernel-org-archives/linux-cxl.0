Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010031.outbound.protection.outlook.com [52.101.61.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D470A32693B
	for <linux-cxl@vger.kernel.org>; Tue, 11 Nov 2025 21:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762897334; cv=fail; b=CwN12QtmiowrP50p5YlQmac8RneALjdKuPXPQd3g7Yp25ZDEOVqlXyGwjeCXX1Fu65GqG6nhrjF07QnLaL2l+O3yJEX3eA1aXrArUwXScuKI0HEVQCwakmY6nnjGnVAnvSVcK2I/AhvGJgez1jcFSzP73rZn10HLHcTXNRHnqok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762897334; c=relaxed/simple;
	bh=gdvXNhe5fhAIqTelQ1AP31bkOiUW/J0lQ5z1vE+BEu8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uxsjYzU76xP4SVzHi/DjxvgLgDNWOAjIft9R4PrYhGvnxd8Q+OAzwvuF4bHbJ2uGi0NBfeQ6o4OH7hG3hManSUVoVzCEvpS6Wd8hulGEjteeD6c4W+hggjy9W4V3YbedM+0NXVbXSoAfPc1w5GdMm01DWry9R+z28IAqVpcOvyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=N1n9iN4E; arc=fail smtp.client-ip=52.101.61.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="N1n9iN4E"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TgC0faatrChfMAQC3BI/QHdFf3lKBSX0juTY1YtCiF9iA1wITyRGQGeQFWoc52ADl8IOr3Rqpudq6nYMQjqDgZXepL7AGcyy+uPnCvUeorooXAq+sWNkCynyVEVOc6sM+Ik/rL963ThZ1bRBZ/dMldpz3rdqhHYXSAWkTc0eLN7BLAaIpqVK96TfVcmHmkUavEqKTF7HAHU/uitRu1egxQu8PKDsdMxaWvkXYSNVL2v5LALhsiQqvqrVhxI0FqhVmCluEjh+iufQl3tr5oDHpxZU715Os+nDak1rmMm+HaEE3l5O8oXDCBPUWdZwmdNMpZ7DkDuPCYS/YRQ2T/EZ7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h90e8NEjG//KAvPBVMKHYAMFIyK8Lq2YiriHR25TnmA=;
 b=qI4jwMOQ7z3CL0o42WuYuRKXyIBwtv/qTP224yY9Faxc44efiQhjhkbwBdZ66H5F5DA1rPCyWoQ6Ks2o3krmuthhau6tkqIF5mo2yvgZNc9NzCapf2XfjivQf2wpY78UPo94l33O4eOAa+S4QGwTV/VMXLhCfkyI0Xw/HrEhs83CWuo1/cvlRfkTcdTKffzjdB87Uh/Ftq34L4/I/ZkcFaeU31hGSgabScrROlNvWevks179mpCw7eNZjahDG/FJRray5Bnkv66bc44IcacRP9OJy0mPmn3XJoxeD560W6CAcYeBvraayp6WdB0elKvkq+BJWhFaIIYoXLviNTS5XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h90e8NEjG//KAvPBVMKHYAMFIyK8Lq2YiriHR25TnmA=;
 b=N1n9iN4EgFOuSYOWu5lklYUslyX80KKSIdKstJR5Pp+nrST+ztDUFEPC8YtwAK5aaCpExxtu5LqEsWwoZITw9uXvlkC45zsSK3iLxXmbQjis4yNTP0DlM+H1LhagPknDhy8FS3+F2Pw9HlNmSPNqOKtGFOmJ3q6MTmVOOi2t9FU=
Received: from BL1PR13CA0389.namprd13.prod.outlook.com (2603:10b6:208:2c0::34)
 by DS2PR12MB9568.namprd12.prod.outlook.com (2603:10b6:8:27c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 21:42:09 +0000
Received: from BL6PEPF0001AB58.namprd02.prod.outlook.com
 (2603:10b6:208:2c0:cafe::2f) by BL1PR13CA0389.outlook.office365.com
 (2603:10b6:208:2c0::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Tue,
 11 Nov 2025 21:42:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB58.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Tue, 11 Nov 2025 21:42:09 +0000
Received: from ausbcheatha02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 11 Nov
 2025 13:42:02 -0800
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <linux-cxl@vger.kernel.org>
CC: <benjamin.cheatham@amd.com>
Subject: [PATCH 06/17] cxl: Replace cxl_mem_find_port() with cxl_dev_find_port()
Date: Tue, 11 Nov 2025 15:40:21 -0600
Message-ID: <20251111214032.8188-7-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251111214032.8188-1-Benjamin.Cheatham@amd.com>
References: <20251111214032.8188-1-Benjamin.Cheatham@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB58:EE_|DS2PR12MB9568:EE_
X-MS-Office365-Filtering-Correlation-Id: bd401fdf-e150-4f53-87fc-08de216b2ab9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ibyuLic25Ovth3AL5dFQra/6UWuHUkeC4nhF1tLXAI5razoXAoWPe7uFsGZF?=
 =?us-ascii?Q?DXPUBZAuurpBzc+lcCbA/EzQ5JfmNcgp/cZ5h4nGIMCfJNqgRdQIZKGFyROU?=
 =?us-ascii?Q?hDphr90R8kmvPRa+uBAekiCJgDMv8lSTMg23XNpZAtQKo/dImAbLvFONmkrS?=
 =?us-ascii?Q?1QYUdcXa7JngNpZzE9XM8/qPKWb3MKwxULFF8uB4lQLYMvSCv9FKXU2i2I4A?=
 =?us-ascii?Q?Cs+95kA0fK78M48aQLK3mmxmxws1OrMH1Bffq8vNxLm/xnH6bdjQKBzhMjCI?=
 =?us-ascii?Q?0RKKM+p+S4T5iL34n55mRH+FLTSHLLYCwurRQ80KKKGbfNHfgg5M4ZNvyuw8?=
 =?us-ascii?Q?jwJFeAdQS/sMfcqhvEh3UffwjnRsv1gvLFNRDSEGnVCHBxnvCagzMrAdpe+H?=
 =?us-ascii?Q?mhpPUB/VaYC4Gtt3H3IXfQ4H5gHu+e3mTQmYLhecqgAdzfwceXS1AvEGCUPs?=
 =?us-ascii?Q?1pGo4gtGMQMoogNB41+wu/2EHPMYBoQSh9b9+h5BDliT2W64dHBP9ROPw8xt?=
 =?us-ascii?Q?LzuLnzr5gfbxCa05mLbgr1Eer8UgveyW5hVPGBTOuXGL760OpoLt3QbUncqU?=
 =?us-ascii?Q?Eu22SzBt3n5+Q9RtQDwMQhUH3D47Pn5V5lKyoJdKl9ESC7fhvun8zpzomKIT?=
 =?us-ascii?Q?ApASUURAhSIG/UWwGLTNXZkiHV1z1bOU5ckfnkHABJBPoEvnDz1lgIbcvslB?=
 =?us-ascii?Q?KInsXmvksyZF3y39FExfVFXso4lhMrfW9CC9xNd3vNppJAsZKn8XWRx/2NO1?=
 =?us-ascii?Q?FCosj1qeKAEyMsohIxBThEtDtLIfgAydvdp45Og7yVsdfwpRdCrF0ji3B+ZM?=
 =?us-ascii?Q?cfA4+DBZEq4YGfLwopAz+rSIeS7mzUs/fw4ABc3Jg+JBKucOJkYP0Jic2Ku+?=
 =?us-ascii?Q?N6SL1Yycl2DQWWKNZIP1WCC/E+/webX5tWQyvqi051DDfI5L9xK0oj0xDCCl?=
 =?us-ascii?Q?nlEPdau+UsN1QdKBQb3an218gB9WZJ4R+yxqairIWsYsmd+6kXl3qIBW7hOd?=
 =?us-ascii?Q?IhXVP8UIgtX1S86KxLZkm7jEeH92LWpE173NfaBZ7Yqb7MNQyRDdsTqn3HyG?=
 =?us-ascii?Q?g2SLlsE+CejCDBYcKZNnQ3kwx8hvsmwZ3ogGV4z/jay6lIENzP47/WsE9DPv?=
 =?us-ascii?Q?mNVvalgu3v2iTPY8HHE0DtJVjZBMtxsQzXwMek7ljdUVzmiXbUycTYgwNu45?=
 =?us-ascii?Q?F9Le51u34f8SIV9TAMqkEkXbdbWTLQ/7HKi2xltTzdlKqMhGdF25ADyRBc7K?=
 =?us-ascii?Q?riaykyH+ZNKRmR7xRHQU7RzCbnek9p07ooMHXDSIW3T2WOMwY7UhzW0Cs+9e?=
 =?us-ascii?Q?OClSvget5reG1tsXKONJ8tv3PVB0kYzrT9GuW1f9PPNA/cuaxOHxoBOBDVTy?=
 =?us-ascii?Q?b4koFAELshtIZjYQ1+GmZ8K05HIywNKofhzot1qkrJ6CAWBH99rPNdofi+WI?=
 =?us-ascii?Q?/7SPeV6KdyKa0egk0+jYjDwGD7el2FL22f+E7NoiYW7to+rEVwGfU6B7Aya+?=
 =?us-ascii?Q?vlok5cUEI3E8mru8u3E6uo5mILwR/e03tbCsK6Wz4TXb6KczS3nnix+SW/Lw?=
 =?us-ascii?Q?UECatVKnyid+Bk86jD4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 21:42:09.4763
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd401fdf-e150-4f53-87fc-08de216b2ab9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB58.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9568

Change cxl_mem_find_port() to take a struct device * instead of a struct
cxl_memdev * in preparation for adding cache devices to the port
hierarchy.

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 drivers/cxl/core/port.c | 9 ++++++---
 drivers/cxl/cxl.h       | 2 +-
 drivers/cxl/mem.c       | 2 +-
 drivers/cxl/pci.c       | 2 +-
 4 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 603cf862e311..4ac8f6f83d80 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1872,12 +1872,15 @@ struct cxl_port *cxl_pci_find_port(struct pci_dev *pdev,
 }
 EXPORT_SYMBOL_NS_GPL(cxl_pci_find_port, "CXL");
 
-struct cxl_port *cxl_mem_find_port(struct cxl_memdev *cxlmd,
+struct cxl_port *cxl_dev_find_port(struct device *cxldev,
 				   struct cxl_dport **dport)
 {
-	return find_cxl_port(grandparent(&cxlmd->dev), dport);
+	if (!is_cxl_memdev(cxldev))
+		return NULL;
+
+	return find_cxl_port(grandparent(cxldev), dport);
 }
-EXPORT_SYMBOL_NS_GPL(cxl_mem_find_port, "CXL");
+EXPORT_SYMBOL_NS_GPL(cxl_dev_find_port, "CXL");
 
 static int decoder_populate_targets(struct cxl_switch_decoder *cxlsd,
 				    struct cxl_port *port)
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 4cf8ca3a2494..5ef0fb71af91 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -890,7 +890,7 @@ void cxl_bus_rescan(void);
 void cxl_bus_drain(void);
 struct cxl_port *cxl_pci_find_port(struct pci_dev *pdev,
 				   struct cxl_dport **dport);
-struct cxl_port *cxl_mem_find_port(struct cxl_memdev *cxlmd,
+struct cxl_port *cxl_dev_find_port(struct device *cxldev,
 				   struct cxl_dport **dport);
 bool schedule_cxl_memdev_detach(struct cxl_memdev *cxlmd);
 
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index e49d57bee2e9..d12c96b68c82 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -109,7 +109,7 @@ static int cxl_mem_probe(struct device *dev)
 		return rc;
 
 	struct cxl_port *parent_port __free(put_cxl_port) =
-		cxl_mem_find_port(cxlmd, &dport);
+		cxl_dev_find_port(&cxlmd->dev, &dport);
 	if (!parent_port) {
 		dev_err(dev, "CXL port topology not found\n");
 		return -ENXIO;
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index bd100ac31672..58dcd0690ffd 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -827,7 +827,7 @@ static ssize_t rcd_pcie_cap_emit(struct device *dev, u16 offset, char *buf, size
 	struct device *root_dev;
 	struct cxl_dport *dport;
 	struct cxl_port *root __free(put_cxl_port) =
-		cxl_mem_find_port(cxlmd, &dport);
+		cxl_dev_find_port(&cxlmd->dev, &dport);
 
 	if (!root)
 		return -ENXIO;
-- 
2.51.1

