Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010066.outbound.protection.outlook.com [52.101.201.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B402D73B3
	for <linux-cxl@vger.kernel.org>; Tue, 18 Nov 2025 18:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763490142; cv=fail; b=dv3YVpATrxHXJ7czZB7G94BendpztMPQaiakDHhBfKzB6Okh2YbQggKhwgJ1HQZit1bgzepbMej7uuFDxvwCMVPxe2P0UwvbmaCJn7ZMVg8WQQFVOQuF0bJzc1YKqFb3g5Utxku2/jPkKSQzezEDrBmKeqhnhoe/YiNzPBpFKes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763490142; c=relaxed/simple;
	bh=uL0WUDc8UVpX1rJI7qWMCVR3FnXmNVfRBlfWRbM7C/k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rImWcV40aIkLz2wQ6Svjm5ZNSJkcJsohhVXmmy6ViKkY0Z1hyIV9q5oiYPPYD1e/7MftJFpQY5x0uzYECbHjSIQ8/s2PxHn4pBNT2SAIVASL6qnnMZW/EB7zlTZxVMW2vadCF83O7hrZOGhnJo7NLIGsb9gm50pV8iawkGw3004=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DqojXRSN; arc=fail smtp.client-ip=52.101.201.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DqojXRSN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uRO9AuTTW5xp7UlVAjf1RxgOOXlAiEa6atxlOiRmPiRX/18UkQI+Fjr2aGcSskGactJ9w0U3OEdoOQJ+O6/ya6JztAu7mM02RZvALLTTY10Zjd61MEFL75neCGXpLknIsZsrqAG/xBDZW6T/Vx65EnygUhw3lKRKWtlp3+ERzO/gF7Cg2hkDE4SrQKd/M4fgf14W2aUSs/dBKYtACFCJGLitUbmJMqfIfqNvnpolmZlkSnc7V4ooUyLMhWgonAUVWhoNM36NLbLhDevwITIAlvYPSyiL0fO5XOCyWKdPtZTtGvTUgvlH2wvX+4ZXTftDkkw7YitMTk9tVxerP7vjqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5CLbhulkSTAVt74GOtFh7kFKkAHdItkNJwZoG6wcdw0=;
 b=tsx0YCliSwzqdqBxj1HsXUyU4alDTTTt59Sdp4cnwKTuVK0pdt1XmXzUP89E0SLw08Rb6GUTX8GByGIFmcnJE7wcc2jzYLRZ/2m4143tBWvclrDF9F+fdT6NZganzX5BPZvEs5Jc/pC3u2QPT8NnPGkFW9dWJZ+Eiy4R31+JMA3J/ZVoeqSFGA199HTWqS6M1VWBLyC6BVqsl2q0QV3pZQAGow8GrLRot1N+nMPtOLbyk13Iqm6rJaGN8AdAiyVUJP+fKsgbixfcrt28NE2q05NSi7ZZx9GHJnnm3vOTSzzhz69QK+atWtN1rJ/e3bzzqDzOdxTROZLLwC/aZ9XJeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5CLbhulkSTAVt74GOtFh7kFKkAHdItkNJwZoG6wcdw0=;
 b=DqojXRSNYH7hYGH7pYKPnsjhslhyq1jyO9qyrUytEmgP2O4Zf2BtWkO/6zqErJWu9wMH3hLWROSsGZL3Gs30IuF3vkjuUL/rYAZpkyja8Onfx+Px4op49tLajKCTpiMyaMxLfcXcTqlMx+wtpg1c6AMdyQAzVkxRrJtotVD5eA4=
Received: from BN0PR04CA0100.namprd04.prod.outlook.com (2603:10b6:408:ec::15)
 by PH7PR12MB8107.namprd12.prod.outlook.com (2603:10b6:510:2bb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.23; Tue, 18 Nov
 2025 18:22:16 +0000
Received: from BN2PEPF000055DB.namprd21.prod.outlook.com
 (2603:10b6:408:ec:cafe::10) by BN0PR04CA0100.outlook.office365.com
 (2603:10b6:408:ec::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.23 via Frontend Transport; Tue,
 18 Nov 2025 18:22:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000055DB.mail.protection.outlook.com (10.167.245.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.1 via Frontend Transport; Tue, 18 Nov 2025 18:22:16 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 18 Nov
 2025 10:22:15 -0800
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 18 Nov
 2025 10:22:15 -0800
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 18 Nov 2025 10:22:14 -0800
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH] cxl/test: remove unused function
Date: Tue, 18 Nov 2025 18:22:02 +0000
Message-ID: <20251118182202.2083244-1-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DB:EE_|PH7PR12MB8107:EE_
X-MS-Office365-Filtering-Correlation-Id: 27ab113b-c35a-48a6-a6aa-08de26cf66f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oe3INdP5Oe0Tn7DRc1CSQmR7Tgtvzh+v0x+TSTyugTiHZyXyainL55EMdQv6?=
 =?us-ascii?Q?j0Srl0Vkz5MvjdAh/lmKrqQboYyDStA1Da62sbKJT713lIpq8yIQiUeyz1FS?=
 =?us-ascii?Q?/66Ey82n/QKbCDySImKHNhdl7QkZnq/AYCIyPdFmKqX9W/ImzlT52IIL0D/1?=
 =?us-ascii?Q?b/CQ6DMtvKcXeGJd+4uD8sfJw7WcXCfBgIBkP8ERsX4CXIwADnRKn04BCxrI?=
 =?us-ascii?Q?zLUbG0c3xNMEiE3SftObjpgRiSOrzYl4tF9NmHRRPocqZEhMa/vpM2SbW+tU?=
 =?us-ascii?Q?i0+10ZXifvN68VaYVLuMQ7C7R8fVpptfp2nAbF8A9BzaiehXytgOJ4u/f1Ys?=
 =?us-ascii?Q?+5/VoOPVeYWNe1ySOPpjWWRLVnsbjUtja5h0tzTGNMpmsOrEoUfGeTr4CjYO?=
 =?us-ascii?Q?rfX7YQo27PqnC81OX5AfsJ4WD+hs8/RllSmjnSZEVzxOG9vLPZ3SJEyDCJQP?=
 =?us-ascii?Q?GwCf3jdCTXAeFagJTqs2s/9uvrBDsYGEKD1CkU66cHo/FeMSiEoKcIIs5z74?=
 =?us-ascii?Q?1hNHbaiohqypCDJYtob8V1VjUYaICNS3WnDML8KYl7Xwa4q9nVjW3L9/sKSi?=
 =?us-ascii?Q?2lWgyXK08kheCZCihsFxCKdDskQ8t/koZ6xMLdUy2MhM9fUbrwHfbdJ06jiP?=
 =?us-ascii?Q?HdHuhPpbDHVSczbv+saFYKF8hN2ZmdBFWWXalPPBB6QXzMcBTPr8Kn6MthQT?=
 =?us-ascii?Q?eqRKG9ToBfmXC2bdr2NlNkB9xUXw5Dn3oT5neFajqObIV6MWrxyPCMKPjqWm?=
 =?us-ascii?Q?V036C/GqrX5pKChV5iYHyXlYmUi4h3a02wbmErptV/80XcJqYstwYMSCFVBT?=
 =?us-ascii?Q?PcG8ZmoPVjKlXNRi9NmadDuCeLFAh24W+3PX2M1mc7b/1q0uXUd0lBgolizW?=
 =?us-ascii?Q?JucAMqOHF7nHoTNSzYzD+B3e1ulBoUuwlrWSeNVd+RJZE/qo/2t6Nip2WjeY?=
 =?us-ascii?Q?5G/W+nlRTmSA3tUWq/BpkD30Gl9A07TQPoBrtrU72+sCFDyPiH5cDuW4+OuX?=
 =?us-ascii?Q?oI7vVs8K2K0H1pfKVzSTAdOYrrtSrusTHNv5ei6WeCGrcqXA5Aaqr8FotbGv?=
 =?us-ascii?Q?5nklEYOZJfDwks5FmiY9hOOFYGg0tIzMegwWR5WVhwBH8nj7YBwZn9IQDjCE?=
 =?us-ascii?Q?sHe5S8Hs8rOUi+gz3EE6pGX1FQO61oaGk+VleXZBcgQU35e/li4UHQNSFage?=
 =?us-ascii?Q?abbsac5CK1r9G4Yl+F4kK89dVOfhSp3Gya/Kpjh6Yntb7yo8/dzwepc8i9d5?=
 =?us-ascii?Q?5W30TV8YfVIQuWop08iXw07cWg9wlnInzu6nC2Vv/f6Vgg6RyUljk9Ezd4uM?=
 =?us-ascii?Q?DgpxCnj4pK4M28Xn+iHEXZ3CV/vUO+mJnPKsJOAs/or6Bc+plrKoXxTA75q9?=
 =?us-ascii?Q?AL5/9z5CMf4X++noIoIUQT6OmC/EmMJ8cWSaSkgRvbQSkFWUggR5tBOfBx8+?=
 =?us-ascii?Q?jHA/PWDq7c7pFVN48Z5n/3F52Q3OmHs8YF4ZVy0vrVBbBPWsZhFteMzy55p9?=
 =?us-ascii?Q?QCmHjRR7WQdLEQpNPXfGpHXR91jfj4wuB5XdI5K7IYqLioMFqMaDpjQU17Nm?=
 =?us-ascii?Q?OUx/6jL5Yrh2V+d2GkM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 18:22:16.0417
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27ab113b-c35a-48a6-a6aa-08de26cf66f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8107

From: Alejandro Lucero <alucerop@amd.com>

Since commit 733b57f262b0 __wrap_cxl_rcd_component_reg_phys()
is not necessary under mocking tests.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 tools/testing/cxl/Kbuild      |  1 -
 tools/testing/cxl/test/mock.c | 17 -----------------
 2 files changed, 18 deletions(-)

diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index d07f14cb7aa4..52736f611ea9 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -12,7 +12,6 @@ ldflags-y += --wrap=cxl_await_media_ready
 ldflags-y += --wrap=cxl_hdm_decode_init
 ldflags-y += --wrap=cxl_dvsec_rr_decode
 ldflags-y += --wrap=devm_cxl_add_rch_dport
-ldflags-y += --wrap=cxl_rcd_component_reg_phys
 ldflags-y += --wrap=cxl_endpoint_parse_cdat
 ldflags-y += --wrap=cxl_dport_init_ras_reporting
 
diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
index 1989ae020df3..c471400116a1 100644
--- a/tools/testing/cxl/test/mock.c
+++ b/tools/testing/cxl/test/mock.c
@@ -268,23 +268,6 @@ struct cxl_dport *__wrap_devm_cxl_add_rch_dport(struct cxl_port *port,
 }
 EXPORT_SYMBOL_NS_GPL(__wrap_devm_cxl_add_rch_dport, "CXL");
 
-resource_size_t __wrap_cxl_rcd_component_reg_phys(struct device *dev,
-						  struct cxl_dport *dport)
-{
-	int index;
-	resource_size_t component_reg_phys;
-	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
-
-	if (ops && ops->is_mock_port(dev))
-		component_reg_phys = CXL_RESOURCE_NONE;
-	else
-		component_reg_phys = cxl_rcd_component_reg_phys(dev, dport);
-	put_cxl_mock_ops(index);
-
-	return component_reg_phys;
-}
-EXPORT_SYMBOL_NS_GPL(__wrap_cxl_rcd_component_reg_phys, "CXL");
-
 void __wrap_cxl_endpoint_parse_cdat(struct cxl_port *port)
 {
 	int index;
-- 
2.34.1

