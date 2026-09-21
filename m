Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012065.outbound.protection.outlook.com [52.101.53.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE514EF154;
	Mon, 21 Sep 2026 17:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790013362; cv=fail; b=p++H1Y0IhOVDOT2OJmUuSb2L8lW1g0HbwGaCa6SV3yn2giX2H3pBh6bJjgsJEQ57lW61TJjCn2pVfsaIseqEgTYXjIg9Uofrc8yf7VZrdIokdFviYmy1vigFWGmIvh6fYhaU9yisZSl75T60LKhX5ImprMk2agMIIAXqtH773pI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790013362; c=relaxed/simple;
	bh=9Yg4dArsHSJxnsPuZsmtS9YX99nweXRJhVTPpSzD6eU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W9sFYM3rMrJFwlOJ2tkUWQMVIGdvgndkqYpGO8y9SdGbLTsWYUsr03Cmr1Nc4mQSeGTzaCccI9syvzDQWHhr24JfRo3fsqQuwn8TzOZ2UL/sO7KRyE5ygoSDZu3O8X9R/sUEkhwmkDqmt3Ht5/aSRtWNOfO8po+4ETjfBNEqgAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=n4EEbsPA; arc=fail smtp.client-ip=52.101.53.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="n4EEbsPA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DJJXnKVXrF820fITZaUZzUGxLg60BTj8pq7N1uiTd+jrGBubVP5cC9EViEsmyrFJiff98CZHbrSxhDdUXRPXMB7YsZ0W/r+TItHvSVrGaBHM4KGKw2YNWJUy68peRMZSeRxRcNt1KTVl+3tW0Yx1vGsChKbM/0IQyYMdRwg00MPVJj5luppRPZDDBDIP+Oj8GquWz/DExGGhMCx3uTtPSZvEXaE2PkZHhCuy0hFwk1OT4K8ps2Bsn6r61MNSYK3K97JtTmTt5uG7F5gQdNdUcJHpivL1NeLQzuGAsE+foSSdkNpgk1WtTgy22Oo2jRIO7NwT9AfT0C60hnr1yVBe9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=peQ12znfLBfWS5Gr+219xzS3xF2/hQ0eyMfmrWhGwvE=;
 b=Dv9Qd/V1RQaHeg//H4qhNp27IJZM7jI2M0GC3WFVdrgtyVmy1Y8q+eRBoophcx0A9tqPQ6tkQSZ7cxTfymUYwxCaUi81GMoqYDa9GhNr/RT9wOn0VvLHC7WZ1CVRIOLL6pgevgi8uBPXhcNL3/402NpMpIpcKWVptzZEwZ7RLT39HTk0Nw6A7z88RrAYTwp5YHhxPSU/5lMgvoEKoYA7NBWf9xyUKLf13AIxkiBpmzW5X5TSZ+82nqIoGbS4uwFzroee+iC5Z1m2Sgi3S7U2lVphmLD69XM2V2keHqTRYCbp8zB/EVwTOyXw3tHiv1TsjsyJ8YJS5SsDkttLtTPWWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=peQ12znfLBfWS5Gr+219xzS3xF2/hQ0eyMfmrWhGwvE=;
 b=n4EEbsPAllyLAYF0yYg2dfWz5067LJn9cHMrRdKGElNBomTlQq849bZxZiHMdrflVdL4rzl4KU3XIGvr8z6RHcI4NVHRBZODL9G72BZSkcbhOH78h+TQuHpmdqfvjq3D3scMi991pqljFu8uQ7QfoykkBJEFttQlFAhf3YmlegI=
Received: from DSZP220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:5:281::8) by
 EAYPR12MB964616.namprd12.prod.outlook.com (2603:10b6:303:2ff::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 17:55:55 +0000
Received: from BN2PEPF00004FBF.namprd04.prod.outlook.com
 (2603:10b6:5:281:cafe::9f) by DSZP220CA0024.outlook.office365.com
 (2603:10b6:5:281::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Mon,
 21 Sep 2026 17:55:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF00004FBF.mail.protection.outlook.com (10.167.243.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Mon, 21 Sep 2026 17:55:55 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 12:55:55 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 12:55:54 -0500
Received: from galena-46a8.xcblab.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 21 Sep 2026 12:55:53 -0500
From: <alucerop@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <ecree.xilinx@gmail.com>, <icheng@nvidia.com>,
	<rafael@kernel.org>, Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v1 3/4] cxl/memdev: Add support for multi PF devices
Date: Mon, 21 Sep 2026 20:12:38 +0100
Message-ID: <20260921191239.4249-4-alucerop@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBF:EE_|EAYPR12MB964616:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dffaaf4-c9d7-4b16-4de5-08df180995aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|6133799003|10067099003|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	UYrbMcV5v1Fn1oATSYE3ShP8TuV1cew+aSM+ewqJr9pNAVYwWmsEN+bL4jTdPFuQqHlr0uCRpbQrMUNWB1eXlhgl7IIBLk5HasT7INuub4QjnuHFIsZ2LhTJ8lNxdJeUhJXkJBAr2gEiJ0qIOpd6w+iGFWSfPOqnxMCSv79+1ORNmuuWbZSJvEv4MkVOYEST3j21fTDrDJPcN4WcvBRohDOAugzLklbmY0/Z3VcBjihl1KM1FP8CaN0WKuwqUXZtGlrlb97EgsE669zXuvZrGeZwmcNK0wBi8Jl114fr5reXR3FOU96VK32m7H1Meg1Rxwc9ER6tkT4y/LNp8MRaNzs8XCsjQMpTHbyUG2N7KS2CohHvEW48lQtJo1ic6r4PIKyb2C6ipSE8HVB7juhSDljoMQCRmovd6ruR5/Zx6GJV3jWnK4UOT2/6yZk6GJWHirjtmSWUW+xRdYszEmAAyh3fpUIiJi7SqlNJr25aBFJLHjgKMJn8+nPh8WL6IJn2d/LPugXO+NWvCKZk9f9F2J5EoYlVTX2Xq6ncz3q5Vb4ovs73BK0nI+3ST+PWCofaC34djJvhboRmfhc5keH7qKu+fJIVerxwnmRJal9rl8+pC5+iE9FqD39xDZNc+YzefmKSxZkFJBM8l67ImQibxC7SWWoxraI7PbajfSNpkW3CDbSnOIpH/cE4TlUnlLXOlTRtRXXmCpPBsba3truQEw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(6133799003)(10067099003)(11063799006)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	rvvGGHd+QR+fO34p3PdMxNAihlWwTJusroUP97JssrAdN1o52HUNtXdSJB241CYmFZWnmtVXyGl+/QHxmm27+nuy6L+SSJjMwp+T9RN5o/Wx0xUhs1n9EZIovq7Ah7iz76ZWvQi7kz3andHbT/Kc4qXJAOQgR8bfqQRaW+3XuIsASGxfn5+uuodc1lZLD/FCIotifsjBfl2PUACzAUvMxLsQqULpwSKkm/ZZtzJQdxynZz0Ub5WD9aw3LIL6OsuNOoEjjq0rkSRG6B8wqy/LfYH8cCHsU8wQmvFBdZQXrTatcrSOK2ea20XVnBtnF1VgjlNBcG19wBUZIFSIWV2yyCBPhmv5YqU6BuT0YqitAX+cWrr+B2RPQsGA0JWmn88e886ZzlMZOFVHNP/o63MFvCV90DWMSRV1xTuO+UPaESyC97Zv6nfJsxr3Z8MzLq9o
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 17:55:55.4210
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dffaaf4-c9d7-4b16-4de5-08df180995aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR12MB964616

From: Alejandro Lucero <alucerop@amd.com>

A PCI device can present multiple Physical Functions(PFs) but the CXL
specs restrict to the first one, PF0, the discovery and management of
CXL capabilities accessed through a PF0 BAR. Other non-PF0 PFs need to
obtain the CXL.mem range to work with somehow.

Add a device link between the cxl region a PF0 memdev is attached to and
the non-PF0 wanting to use the CXL region. A CXL region release will
trigger such a PF to be released from its driver first.

PF0 being unbound from its driver triggers memdev and region release
leading to non-PF0s being unbound first keeping the CXL memory use safe.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/memdev.c | 66 +++++++++++++++++++++++++++++++++++++++
 include/cxl/cxl.h         |  1 +
 2 files changed, 67 insertions(+)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index b3419df586b9..67be02faa7e1 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -802,6 +802,72 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
 	return ERR_PTR(rc);
 }
 
+static int match_memdev_by_parent_device(struct device *dev, const void *data)
+{
+	const struct device *pf_dev = data;
+	struct cxl_memdev *cxlmd;
+
+	if (!is_cxl_memdev(dev))
+		return 0;
+
+	cxlmd = to_cxl_memdev(dev);
+	return (cxlmd->cxlds->dev == pf_dev);
+}
+
+/**
+ * cxl_get_pf0_memdev - register a device link with the region PF0 memdev is
+ * attached to. The region release will imply the link consumer to be unbound
+ * from its driver first.
+ *
+ * @pf0: device to use for finding target memdev.
+ * @pfx: device to link to PF0's memdev region, the link consumer.
+ * @range: to be set with the PF0's memdev range.
+ *
+ * Return: PF0 memdev pointer or error.
+ */
+struct cxl_memdev *cxl_get_pf0_memdev(struct device *pf0, struct device *pfx,
+				      struct range *range)
+{
+	struct cxl_attach_region *attach;
+	struct cxl_memdev *cxlmd;
+	struct device *mem_dev __free(put_device) =
+		bus_find_device(&cxl_bus_type, NULL, pf0,
+				match_memdev_by_parent_device);
+
+	if (!mem_dev)
+		return ERR_PTR(-ENODEV);
+
+	cxlmd = to_cxl_memdev(mem_dev);
+
+	/*
+	 * we got the cxl_memdev and the implicit get_device in bus_find_device
+	 * makes the next steps safe.
+	 */
+	attach = container_of(cxlmd->attach, struct cxl_attach_region, attach);
+
+	/*
+	 * The cxlmd object does exist and it can be found in the cxl bus after
+	 * creation but before attach probe setting the proper HPA range. If so,
+	 * the caller will need to try later.
+	 */
+	if (attach->hpa_range.end == -1)
+		return ERR_PTR(-EPROBE_DEFER);
+
+	/*
+	 * Create the device link between the region and the consumer device.
+	 * AUTOREMOVE_CONSUMER means the link implicitly to be removed if the
+	 * consumer unbinds first with no consequences for the supplier.
+	 */
+	if (!device_link_add(pfx, &attach->cxlr->dev, DL_FLAG_AUTOREMOVE_CONSUMER))
+		return ERR_PTR(-ENODEV);
+
+	range->start = attach->hpa_range.start;
+	range->end = attach->hpa_range.end;
+
+	return to_cxl_memdev(mem_dev);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_get_pf0_memdev, "CXL");
+
 static long __cxl_memdev_ioctl(struct cxl_memdev *cxlmd, unsigned int cmd,
 			       unsigned long arg)
 {
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 802b143de83d..e3b1e5be95f8 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -228,4 +228,5 @@ struct cxl_memdev *devm_cxl_probe_mem(struct cxl_dev_state *cxlds,
 				      struct range *range);
 
 int cxl_set_capacity(struct cxl_dev_state *cxlds, u64 capacity);
+struct cxl_memdev *cxl_get_pf0_memdev(struct device *pf0, struct device *pfx, struct range *range);
 #endif /* __CXL_CXL_H__ */
-- 
2.34.1

