Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2074.outbound.protection.outlook.com [40.107.100.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB022F068B
	for <linux-cxl@vger.kernel.org>; Tue, 12 Aug 2025 21:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755034250; cv=fail; b=TEHjpbracQyUFONZSbApZbVAp3141ccLPIqxQON8pCdpsgIjRfmfN8tyrRTh9EgiiTlBpt+A8uehqRXu0Sl9MeMGgpjcCn24/539upRrnXJms7x2OvW9a6jQdVBHnkQ57is+VKq82ynRpF/5AM0Z+ufqMGuyoFQtoo8QsGU3TzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755034250; c=relaxed/simple;
	bh=+sgqYUzS91LE6/T0z25tE/RwW/0rxUB7KZyCz/KrwP4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jgz9MoK+WiNwbtlMrT8zVTqUMEhswK79pY5GmIAVjAAm7aKWlBVDxq/jKKlRI96iQBHFALSIkxGlwNKEAV6dmO3Ni238Xu36chSmZosBO4wUpRmZv1fllYsa2985QJxwkKShliogfq890VsejhQPINBUr2A4o/yinpNl4gvRCi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Z9A+08LA; arc=fail smtp.client-ip=40.107.100.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Z9A+08LA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BxaGcXIsYNC/ciQ6bX3pMLYv/ahw411XmpUdygVPo4U5FFqM1BIzHiUy4JOIFjTiowhbqRXUgkxuFD515xHKDF7dOrrXBrH4zpnDe5xffSLHf0GsrlIOpQfbgeLUgw+sllM3wIFSGeAxYWb8KFUwTT7GoNRCKehg+iY5fpywAONqhiT+bJduEABP4vfo3bRaKth7+k6CBeMoXhzlbBhxUXs53dm34j9TfEb9TsWZ4KBktRvG25T21o7KN0nhwbihFckNfZhL7VNPYYvJTrVkWvcTwXVOyi/6HUCggZNJx6W/HvFPW8nhZi8PKl4BYgIBtUQkKpsQi3yDY9prPoKf/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LZozMubhZcNt8mflv/+p4pjlNaDg7Pox68Bm3s3ohVk=;
 b=NsYb5gyP00ab0rkwdTbUOOK8/wqhPLgYDohOJkx+v81acfQ23JJs3WbZvo21p9Lu1C97k+IYcsGFIKH+uebHD3vP7/yWYvX2Y+UWDnAiGT6EvEoveXgSKQnxE8Nd9ToQ8XA1z4nbunmFKC7zRJTsthYbqx4JsSTh4t4QOXm07X4V9tXkk6NkEYUbOm27g6jm/IqyEkxEWGCi+TSZJgGqliMuJdCXhPcztICVnHzJl14H5awh/oDt5fBo84/P5tQjwrnpYCnV6naG2AyaORTaEGIcalPIZvU3z1hBZ2DBmZad1f/EjhdpufYminNfq2DFJhutAk/t2XsoW1nbzK19bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LZozMubhZcNt8mflv/+p4pjlNaDg7Pox68Bm3s3ohVk=;
 b=Z9A+08LAeve0J9fVp+Hc8V6XJN5KqCSxJ7CyMLTzEWfOEKn3YdP/UK9MTIAQAEd48Z3jp6WM4o6LooYqRBQg9AGwK4hn3JA4rogyUx+OOqThZTnG0xpe+CNfcZFTTnupBcCMm0VEeQlkL0vT4rfKOyQcdjhybF+was3Vq2u9eeI=
Received: from CH0PR04CA0038.namprd04.prod.outlook.com (2603:10b6:610:77::13)
 by MW4PR12MB7013.namprd12.prod.outlook.com (2603:10b6:303:218::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Tue, 12 Aug
 2025 21:30:45 +0000
Received: from DS3PEPF0000C37B.namprd04.prod.outlook.com
 (2603:10b6:610:77:cafe::fb) by CH0PR04CA0038.outlook.office365.com
 (2603:10b6:610:77::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.22 via Frontend Transport; Tue,
 12 Aug 2025 21:30:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37B.mail.protection.outlook.com (10.167.23.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Tue, 12 Aug 2025 21:30:44 +0000
Received: from SCS-L-bcheatha.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Aug
 2025 16:30:43 -0500
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <linux-cxl@vger.kernel.org>
CC: Ben Cheatham <Benjamin.Cheatham@amd.com>
Subject: [RFC PATCH 04/18] cxl: Replace cxl_mem_find_port() with cxl_dev_find_port()
Date: Tue, 12 Aug 2025 16:29:07 -0500
Message-ID: <20250812212921.9548-5-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37B:EE_|MW4PR12MB7013:EE_
X-MS-Office365-Filtering-Correlation-Id: 7896c958-a206-4aab-07ce-08ddd9e77ea8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aA3pUg0uUfpQRXEv2An7pIBZFrW1YjTGLTQaGLIbdGHkhsdgQDkmSM1lOslV?=
 =?us-ascii?Q?ZpDoIO8qwIQRa00dxgu0+S2lfn26hSb25ri7+90V9+9r6wrVY+Uuvguuw8SS?=
 =?us-ascii?Q?3pe83jagOxTOoNCurubRHOqsU5jWWUQ9K0ql69r/EB7NWOuWgr6zRMegN/Mj?=
 =?us-ascii?Q?AOlO76U1MZ44DZf6EvrZWh5XxnHWvhdMmHZythLktiDjr/ve7osZexQFrfNz?=
 =?us-ascii?Q?mxwNBjo2sXhcs/RfHs0UNvf6fRQ/DRyAuLBCn3qunyEWGWUZ1pYnoHp9Ml4I?=
 =?us-ascii?Q?3UseXWZtGw1eVNXSPqU/ELmrDVPtmEOheh5+VKdl5XgAMiQ8AwUSjYHcYJ6w?=
 =?us-ascii?Q?VeWi5iBhtqMPrw6x2qO/+I31usEWx1ZK5CTcicyyCU4fdlcME5mSi370nojP?=
 =?us-ascii?Q?SIuNhPaVTJzH5o+LqPNdTX8ePvdLywO7ZwmQzNA76Obs6m6p1gq4Wg7O+CQa?=
 =?us-ascii?Q?m53FJeGvjkTHqI5vbF+LgIcZWi2jByY8wfu3YzarTLZGUUM72IP/lDJACVmT?=
 =?us-ascii?Q?C+RXQdOKBHTz8m5wQQiiPWdjPxIrSHc1hEN1GxP06EcmEPVw+ueGt63Y7nqa?=
 =?us-ascii?Q?oeJz1RZGhIf7HIVPyQinJ6dlgA+jrnqU2woQmq8zmZI9GjOYpzdLCji7DOJV?=
 =?us-ascii?Q?M+CInk/+iwJ5fQNNorxx0raiS4jMb2087+a91LKo8RXHHwvVkSJY7ZpSs6/R?=
 =?us-ascii?Q?PD782nY9PRz9y8undSyE62/PPkMb4J36ASu899COqIJuY96rSDsOhxxpqneV?=
 =?us-ascii?Q?TTQKtG7Jhii2ybcmoSh376TZhQpFEByRpcBcT2mcyM07Aq4OmddFGRHDWvxr?=
 =?us-ascii?Q?UYzzAnNSWkYCdgMPOx9Ceq2thiCn0cAWPNIgG6mQdLEdOCpUCaw7I6lvTvgb?=
 =?us-ascii?Q?+LDpcr06pyrs9xiP5PFAKXtn8mY4bcUEBv4gso/jXKcNYaX/cSgo/4iBpKf3?=
 =?us-ascii?Q?xTMwhWW87fMCD4D0SSlXvkpMRh42UUDSeATxbhRVGCHQrBEVGIyUe/cjBHK9?=
 =?us-ascii?Q?kKCVDW2F0yg0ogHRep3JokqTCVD5WUOQMVbI49H4QvnbSXKt3i7wlkvLtNm7?=
 =?us-ascii?Q?9TmEZQqsiKC9Ue8qh3DJYdVCdDCYyLaRhgxZ81yRPQHNduiEgUv8rue0Ypll?=
 =?us-ascii?Q?Ya4eDqYFuuUeKWjM2dnOJFaPU9f/EIXrZ6YzWWy8r2b+NyWLuxwd8FB2dHx0?=
 =?us-ascii?Q?QnmtyDTVeaad7MZAch2UM/ezazVNOq8KmrkgjSdBEBzCFwjfu6RUGZYFBQ+r?=
 =?us-ascii?Q?ay2MOvdQekTtw/AWSbmdaKL4AQaYCOPbagGNcIpMKjKgM1BlG166tc6I6QHy?=
 =?us-ascii?Q?+BlA47vH4Mbt1MUyzG59WERHNziSurNCwrFLfWM876Uv7dia/cURPaPTDjIY?=
 =?us-ascii?Q?PuiUnReL0Wold8J+4Mb/FMYA8FEaQGY5vymM3AKEdkHYHUd3EniwhuqP1pKN?=
 =?us-ascii?Q?HwvdNdXy0+qKWkK689tE7bi2OrcAvzHXy91zea05HAX0KOEjnSHw5lPUmot8?=
 =?us-ascii?Q?AkNWBX1J1Xcs7dBEgQGosYxlt+MO+9mjzeKM?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 21:30:44.1277
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7896c958-a206-4aab-07ce-08ddd9e77ea8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7013

Change cxl_mem_find_port() to take a struct device * instead of a struct
cxl_memdev * in preparation for adding cache devices to the port
hierarchy.

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 drivers/cxl/core/port.c | 11 +++++++----
 drivers/cxl/cxl.h       |  2 +-
 drivers/cxl/mem.c       |  2 +-
 drivers/cxl/pci.c       |  2 +-
 4 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 0730a60cb722..0d27c9e8aa64 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1960,7 +1960,7 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
 			 */
 			if (i >= CXL_ITER_LEVEL_SWITCH) {
 				struct cxl_port *pport __free(put_cxl_port) =
-					cxl_mem_find_port(cxlmd, &dport);
+					cxl_dev_find_port(&cxlmd->dev, &dport);
 				if (!pport)
 					goto retry;
 			}
@@ -2003,12 +2003,15 @@ struct cxl_port *cxl_pci_find_port(struct pci_dev *pdev,
 }
 EXPORT_SYMBOL_NS_GPL(cxl_pci_find_port, "CXL");
 
-struct cxl_port *cxl_mem_find_port(struct cxl_memdev *cxlmd,
+struct cxl_port *cxl_dev_find_port(struct device *cxldev,
 				   struct cxl_dport **dport)
 {
-	return find_cxl_port(grandparent(&cxlmd->dev), dport);
+	if (!is_cxl_memdev(cxldev) && !is_cxl_cachedev(cxldev))
+		return NULL;
+
+	return find_cxl_port(grandparent(cxldev), dport);
 }
-EXPORT_SYMBOL_NS_GPL(cxl_mem_find_port, "CXL");
+EXPORT_SYMBOL_NS_GPL(cxl_dev_find_port, "CXL");
 
 static int decoder_populate_targets(struct cxl_switch_decoder *cxlsd,
 				    struct cxl_port *port, int *target_map)
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 9ff67a58ceac..3ad25229a48b 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -874,7 +874,7 @@ void cxl_bus_rescan(void);
 void cxl_bus_drain(void);
 struct cxl_port *cxl_pci_find_port(struct pci_dev *pdev,
 				   struct cxl_dport **dport);
-struct cxl_port *cxl_mem_find_port(struct cxl_memdev *cxlmd,
+struct cxl_port *cxl_dev_find_port(struct device *cxldev,
 				   struct cxl_dport **dport);
 bool schedule_cxl_memdev_detach(struct cxl_memdev *cxlmd);
 
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index c311536def38..cdac7bfa2289 100644
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
index 2ff19359dc0d..a0863b04a8f0 100644
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
2.34.1

