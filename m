Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2349719AD89
	for <linux-cxl@vger.kernel.org>; Tue, 12 Aug 2025 21:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755034206; cv=fail; b=Yp6tyfj02pXcP4iBFyi7zgKHAcvxxYTeKUNMgo3cZaE/ftqhfn5iis0TE3z3GCKy/Y/VfM7KGSBtNWG+0xJWdzXcldSG1VPrp4Sl9tUZH+DLrOcvOTwJ8WNpkIVMQJd2nbqjuAuYEwza8dlM4XOiPMgOrWfhnIeHIZmsN8y0UGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755034206; c=relaxed/simple;
	bh=TcHfLSdRlFXRH5VTngUR0IJ+w1ia3kSJws2PL8JCcEA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ciifIKAPdFyb99zr5RQ4G5hizuo1cItb45Mo91/YfZMNzFixk9L819WF98u4rA62oPkCEME4BApoB4LEoc4Cczis8NvTY7rbzQuLppChVLbYj3HxKBYeoT2UzDz1hR0tNB3/JA7++aAruL4HzyRPdQ4nJlsS5ORXXprwcDPlp70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oFs0Wq0b; arc=fail smtp.client-ip=40.107.243.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oFs0Wq0b"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AvLFfA4A5wd1Eypgs3kmIdw/tkrK2jP6VLwr/7CnrbN3fHf7MyEWQncaCbIbFgm3hZi/dyv1fRmkyjq6e09mSMyQC+/7rm0Rv04JbTuk6Tw2WjCsfUSR+qRuMgduHUv4kOhLz5yiSfv5suzrdUQsLgg3GdcwKZP08shDPwVkg3LDtCmdU6GM9MEhlZICxi1wEyednkyovdw+SYEZVMsFlSvaq90SYQz5wTWt5jWCfYglBZMYcRonIAld9Z4wXUwnxJEToWl2SPuD8Gr/IhL9F+nYMQYv8Gu76r7/VwEa691BtftBdnS98SmbDVYOObohoZAa8sUQUVLO27bjaTpjzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zSZiWedfiuhWtt3qEmH5V8fHLb9zY2tzZvi1vuXaqZw=;
 b=HaLuLMps8ZivU+FQwYQNYUH5MWY8v6FH8HYW0N7xFb8xn+eUjuUSb4mz4GvBy1uKT6dFMtIfI+MnCJ7EVO1VISeXEy0S6py+12vEyLfsZme4STsK8TIFY1sFy6YUyXXTRxSfwIwiGKGOQixuZya8Z2pfI5F4MmjwvhaaXp7jbJDKjboh9qAfDkZlVyEwQSL3e4dIrRGo/YnDiRN8TevfkynPYCzaXJMrGk3T7fO3+WzH3VbgNkkxSQiCVf9matXObJ0RxIi9f6Bu2MgFHuS3gBmFfCpgwcDjHpRIWOxsVnHFneNzaEMxkB5U01JLtagtysHt5pnbKHkQKm3l1bzzGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zSZiWedfiuhWtt3qEmH5V8fHLb9zY2tzZvi1vuXaqZw=;
 b=oFs0Wq0bI+erVVeAsImlxMyIbMxNQrkDnTx6rq4X/FejM+WHDTke1zTzM8/JcnNTdGjvbKisuAbwmt39U7+aSSpqPkfz8CUufDxtX3XGgvdkrwGVD4z7xts+CUhXOKYTN9c4yXM1LBiLC3QOHX5iC1EChchmBawKt3Kh+wSZBGU=
Received: from DM6PR18CA0008.namprd18.prod.outlook.com (2603:10b6:5:15b::21)
 by SA1PR12MB8597.namprd12.prod.outlook.com (2603:10b6:806:251::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Tue, 12 Aug
 2025 21:30:00 +0000
Received: from DS3PEPF0000C381.namprd04.prod.outlook.com
 (2603:10b6:5:15b:cafe::5e) by DM6PR18CA0008.outlook.office365.com
 (2603:10b6:5:15b::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.14 via Frontend Transport; Tue,
 12 Aug 2025 21:30:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C381.mail.protection.outlook.com (10.167.23.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Tue, 12 Aug 2025 21:30:00 +0000
Received: from SCS-L-bcheatha.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Aug
 2025 16:29:59 -0500
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <linux-cxl@vger.kernel.org>
CC: Ben Cheatham <Benjamin.Cheatham@amd.com>
Subject: [RFC PATCH 01/18] cxl/mem: Change cxl_memdev_ops to cxl_dev_ops
Date: Tue, 12 Aug 2025 16:29:04 -0500
Message-ID: <20250812212921.9548-2-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250812212921.9548-1-Benjamin.Cheatham@amd.com>
References: <20250812212921.9548-1-Benjamin.Cheatham@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C381:EE_|SA1PR12MB8597:EE_
X-MS-Office365-Filtering-Correlation-Id: 32506c09-2bd1-4437-5dea-08ddd9e764ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o/tDLJvogqM370WF2dF+DqvupBKlDWW+sysCuO6CQh1FDY5vyXYaLPb+pOgk?=
 =?us-ascii?Q?9jxBw5dRc6HyBcMDzt5cfCaI6OIsfaH6LOMo11zQml2fCu7P9RFq0gozX88U?=
 =?us-ascii?Q?vlGba8hpDhZ2P/N8RiubkfebJ+EUlLYnpZybhmgWtKTSMa1mir6QSfxR25Ph?=
 =?us-ascii?Q?mOjwQ4gqOJ1QRJxxKaluieJJhAYsI1eqTxeOoPcGKpfQwfwlupFs5cP7qkK/?=
 =?us-ascii?Q?oXBFeTibiE9ik+de852Msuymm1qDJR5DdfiwYSnLoPRngoOd/2n6QyaN0Gjt?=
 =?us-ascii?Q?a9/HjzHrWjyX3NkM7fS9I6hDKyJx6MH/V1L+eNj7HEAxP5MWJ/SzIUfT+2mB?=
 =?us-ascii?Q?LxCLaopk4VZx35SSoosXg40XmMYxibpH/7c7KQWVsjVfDryC6GtWRDqnLoiT?=
 =?us-ascii?Q?XtMgRuKFNOxikD1t8S8A00L3TQmzz18c2awMTPc4xYH4maqVnSajpy38axGp?=
 =?us-ascii?Q?yE+tSGz1+P6XWPeZikBeGfcI1dE043guyQyrh1HKrr7LRTChf/vSENU4MMGG?=
 =?us-ascii?Q?lcJ+3PNb53FklQniFfPLZOHExZcwEKfVsfNWQFxcSwkEpMu6QXe1Ja14ynZo?=
 =?us-ascii?Q?fmQ0kl2jVfRXKbgz6Y6zJXIxQ3f306Yk3roEwEqmzeRiI5bhMrB2TtMDpbnq?=
 =?us-ascii?Q?w0Y/iNaYSsEVrRy3AzeSraLEIqflKFgslOzNCCWcVm5QkvMqBYLKYxw0DzhU?=
 =?us-ascii?Q?+rBhuEfDLtUq7gJRz6QnKDbU/ws6esRkutXDUuKWf9SHVKxDWuySQeWRg+mj?=
 =?us-ascii?Q?to/9ujnDc+l8G2/z5XOgdHJbm6fI+aQUpKDsoUcXFOOVDyy6DWlG9PcGeYi0?=
 =?us-ascii?Q?TfBxHjmtyw8q2AbCb6TQBgKicwiJPdGX5ns9NpbLo12I/M0e8vth6eIWpoha?=
 =?us-ascii?Q?SO06UGZa4gAU+QRe9ZDgQ9JT8WphwRg5XfeacDZPUDTZIdFJRYIbGNwUNl0s?=
 =?us-ascii?Q?9tJVfDUpryt43Kl5kJ5W05LZ6379eLT8DfO1Qbc7nEWm4CTjoWjv9N3tpvh0?=
 =?us-ascii?Q?Eu7K3lpXJmmBs0Lsa5l8F4GkX0f/IyFZLXmfkU1/cRcolgJobChAvr/mCaKO?=
 =?us-ascii?Q?zb7eHHhV6CveGMEmEtsANbv81iy3U9Is9kAeRVCxCpeBKDTND9WWklxlDgBZ?=
 =?us-ascii?Q?HD7IZk75YArnFyuZbMvDAgoCQxt2GuPL5OfaH81Fvbs+4S9/Ts6Uri2qW+Tt?=
 =?us-ascii?Q?XH9O4SKmplmNmWOHrGxW97IYFmc2TKLMh44JIwR6zF3ub1+cUzUqZ1XR3YYf?=
 =?us-ascii?Q?ak6Jpp8v8dF5Nl+F8lWClMET2iWXcC/rmpPxMQxXZ/EPrqTnuyUajjbcbjT/?=
 =?us-ascii?Q?zWYORFYk5ceSYQsU/zzq39MucWcOYds9RRBx8irheSbOlJVpX9jXmgT40sWT?=
 =?us-ascii?Q?xBF1foCvn2QEMPJcmvg/zEpTT++91e+LJ87CPdVKwzs9ax5wAwOe95SIDG1R?=
 =?us-ascii?Q?W41UburHMpbPSS+lH+6UU0zW9ExbFf/K3/OMfOYozOCHJJWeCrm2uOC53r0N?=
 =?us-ascii?Q?jcwuhTC/mFJ6U+EsIqWArZHm/R6T/9JS7MWk?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 21:30:00.7587
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32506c09-2bd1-4437-5dea-08ddd9e764ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C381.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8597

Change struct cxl_memdev_ops to take a struct device * instead of struct
cxl_memdev *. This is done in preparation of a new cache device type
that will also use struct cxl_dev_state and need the functionality
provided by cxl_memdev_ops.

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 drivers/cxl/core/memdev.c | 2 +-
 drivers/cxl/cxlmem.h      | 8 ++++----
 drivers/cxl/mem.c         | 4 ++--
 drivers/cxl/private.h     | 2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index b891a5cba4f4..8c3c58c92bcf 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -1013,7 +1013,7 @@ static const struct file_operations cxl_memdev_fops = {
 };
 
 struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
-				    const struct cxl_memdev_ops *ops)
+				    const struct cxl_dev_ops *ops)
 {
 	struct cxl_memdev *cxlmd;
 	struct device *dev;
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 075642d9dff2..5e0e551c9d6b 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -34,8 +34,8 @@
 	(FIELD_GET(CXLMDEV_RESET_NEEDED_MASK, status) !=                       \
 	 CXLMDEV_RESET_NEEDED_NOT)
 
-struct cxl_memdev_ops {
-	int (*probe)(struct cxl_memdev *cxlmd);
+struct cxl_dev_ops {
+	int (*probe)(struct device *cxldev);
 };
 
 /**
@@ -64,7 +64,7 @@ struct cxl_memdev {
 	struct cxl_nvdimm_bridge *cxl_nvb;
 	struct cxl_nvdimm *cxl_nvd;
 	struct cxl_port *endpoint;
-	const struct cxl_memdev_ops *ops;
+	const struct cxl_dev_ops *ops;
 	int id;
 	int depth;
 	u8 scrub_cycle;
@@ -103,7 +103,7 @@ static inline bool is_cxl_endpoint(struct cxl_port *port)
 
 struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
 				       struct cxl_dev_state *cxlds,
-				       const struct cxl_memdev_ops *ops);
+				       const struct cxl_dev_ops *ops);
 
 int devm_cxl_sanitize_setup_notifier(struct device *host,
 				     struct cxl_memdev *cxlmd);
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 13d9e089ecaf..c311536def38 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -144,7 +144,7 @@ static int cxl_mem_probe(struct device *dev)
 	}
 
 	if (cxlmd->ops) {
-		rc = cxlmd->ops->probe(cxlmd);
+		rc = cxlmd->ops->probe(&cxlmd->dev);
 		if (rc)
 			return rc;
 	}
@@ -183,7 +183,7 @@ static int cxl_mem_probe(struct device *dev)
  */
 struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
 				       struct cxl_dev_state *cxlds,
-				       const struct cxl_memdev_ops *ops)
+				       const struct cxl_dev_ops *ops)
 {
 	struct cxl_memdev *cxlmd = cxl_memdev_alloc(cxlds, ops);
 	int rc;
diff --git a/drivers/cxl/private.h b/drivers/cxl/private.h
index f41fc6fd036f..8413db891343 100644
--- a/drivers/cxl/private.h
+++ b/drivers/cxl/private.h
@@ -9,7 +9,7 @@
 #ifndef __CXL_PRIVATE_H__
 #define __CXL_PRIVATE_H__
 struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
-				    const struct cxl_memdev_ops *ops);
+				    const struct cxl_dev_ops *ops);
 struct cxl_memdev *devm_cxl_memdev_add_or_reset(struct device *host,
 						struct cxl_memdev *cxlmd);
 int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
-- 
2.34.1

