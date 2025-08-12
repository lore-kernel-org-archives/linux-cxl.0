Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AF42D0624
	for <linux-cxl@vger.kernel.org>; Tue, 12 Aug 2025 21:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755034376; cv=fail; b=eI/bC16b2YkdHsar78f+cHBFkavqtwW0MUEygk1YcTo5w2e1z526JMioWnyylIVcLJezu8TrI5M4vHLgJCP1JZ4M4N4S3Jw5qvBQ5j5VA3V3gCvzf4Thgx+/3lyug5TJBaalMmcuyma7bYQfsHRaXLd7Mc+N4EmdYfkyb6JF1oA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755034376; c=relaxed/simple;
	bh=AkUi4z8pSolTZYyM8sVzGQWjISsnYyND4xuzyg2kqP4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cVrgvpB254GYsCEFkcLlCPTzp/stnZBP89ioc3qBZdMyfTU4zk6uFIdUI5jhi6J3p1Sk3Yenu2isEZrog557X624s5KG/qSZPfpRUvY5KiUoHxnIlKvea0WXR2h02x93zzbjo3FifPOxeNyDptwCN02THdo6jKMNftAnQeCpbZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Oo4Dkl0N; arc=fail smtp.client-ip=40.107.93.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Oo4Dkl0N"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wf4+7b7SmNVlgkzkrIcer/g8VQ7RDCrba2rNxarJDNf/4fnoKJjGsLJrOxZR7HMS+D4kYtfHMOy0A1iAnrpqai/V+2105Y7yCHTOJvEVsqzmMZlfJM2Vvb++VEjAKqfOg8SSZpGKmyJ33/xKLAp8xUy4A600wjNpu3WAOdm/LzHyMw08+FGAZ10VHlQAARBzCHwx2LHP6goW/auk8PaoOvViRLRRvYiip+UFuD2LesZL+OSf8Q2HJa86QynxrwIalmPzAwryE9+rwjuprLxogJxqdnLZy1chIBRwYzdsaswQ6GSIDyfLxEvJekhYnv1J72m6Vd6uKj/7ekEeDMQ0Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TT7GVBq9/dxwM3gYCXE9WcisSi9QW/8EtoLzXb6JGNI=;
 b=PhrjteYWIxMT53YW9UC4QK+T5lutvuKzTlyem6Y6V5JBxE+JqOKP0HMZVqb1nMHjV+RFZS1YzTq61JEefInEi2sOzgPyIdFa3Wo+zr3BHUu0wBOaViw0q2Mxh8gVF6eWZuiZ7DpLsruYAWpYpxxYDkRQnRpVTjxl/V5vDAMy6e+JBtFAwBQWTz4Ly1WYGFSDJwG8yU+CNGEp9OmNzqSXStDIA9nAsvDJ00ytAHxVL1w2n9ykctwTfZJwANFG0JK1+HRORj+SIyvlJwkhBrVthGePzWx7QMTSdAtACSti9OENCENCqghdN927y46je5j1HhZZnEJrpE845jpmBbAUXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TT7GVBq9/dxwM3gYCXE9WcisSi9QW/8EtoLzXb6JGNI=;
 b=Oo4Dkl0N//2uUr/NlVGoQMRQT7Fdw7c//W3mPxVtMwNrK2BNmJhO6PBAEuzTpfeDfKQXIKeR9x9RxbqC1ZAD/+4WmVn5Shiv+stWekKjQzx6NwuqcmsTaMMxES/oXhDyjgnkw1Iz3UVft20knTPXETdrGomnG5WEb1bd9PcWLf8=
Received: from CH2PR10CA0017.namprd10.prod.outlook.com (2603:10b6:610:4c::27)
 by DM3PR12MB9392.namprd12.prod.outlook.com (2603:10b6:0:44::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.14; Tue, 12 Aug 2025 21:32:51 +0000
Received: from DS3PEPF0000C37F.namprd04.prod.outlook.com
 (2603:10b6:610:4c:cafe::5a) by CH2PR10CA0017.outlook.office365.com
 (2603:10b6:610:4c::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.22 via Frontend Transport; Tue,
 12 Aug 2025 21:32:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37F.mail.protection.outlook.com (10.167.23.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Tue, 12 Aug 2025 21:32:51 +0000
Received: from SCS-L-bcheatha.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Aug
 2025 16:32:49 -0500
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <linux-cxl@vger.kernel.org>
CC: Ben Cheatham <Benjamin.Cheatham@amd.com>
Subject: [RFC PATCH 14/18] cxl/cache: Add Cache ID Decoder capability mapping
Date: Tue, 12 Aug 2025 16:29:17 -0500
Message-ID: <20250812212921.9548-15-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37F:EE_|DM3PR12MB9392:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c328614-2c68-480a-ec01-08ddd9e7caa7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3CjJmjCXm+lqeQIUOtcdk6crYz41gi90Hs/5UIrYMOsKuzUl1BlmWN4KR1L0?=
 =?us-ascii?Q?r4xdIkmXeV/y6A7LhAx1Xl6OUzvkvgk2f95KxS1Fufq5Oty8CCXGyIbYUYv0?=
 =?us-ascii?Q?yeeoFLBCpJ8nCguSbWfcgCRuZOGjSjxZSj0aRdFFu/+v0xifDeE2zMQ1eC0Z?=
 =?us-ascii?Q?UBCXrLTHA1z5FFvZVigo6tadCxv4iHmeSvsVEzBEFr72Hn268pq4b0SqbpGA?=
 =?us-ascii?Q?MVPIDHu3Ctf6jU8+C3xZevHsFk5c3qPHVi32lPbTaprhGl6Z5xRdP7Zal7Mq?=
 =?us-ascii?Q?MyCyr6A8Mr6T5Hqn3v7jJhfSyEkK4nc4xjy3Zh63xOiIykwxJtwRAb47FX8J?=
 =?us-ascii?Q?tmeuBycVXSfBAxdbq9smAY4Lt3/GPUniXuMsrXzg1E4q1kzlpWSGHYsJioVq?=
 =?us-ascii?Q?cvc4n9JvRg/AId690W1JvNqoi2hnh99uzOJey4plk1h6ifRRapkan6ml2XeC?=
 =?us-ascii?Q?gWK1JWiSNsaeHfLXWfJuzFASuX04/SU6R+WLx/yb03LqWioLh/aXC2mzEHZz?=
 =?us-ascii?Q?Kouni+uaymlnE8Mi3Zk/3EdFNSSI7yBJi5QHOjntbHzLMT/vIbBJEO61+aed?=
 =?us-ascii?Q?yOJOHp8nuTcy3YmOYktVRU+w8CngfAwlX1R8DBIQFfQXlzNCW1aH7NHnQUSz?=
 =?us-ascii?Q?X3Dod36ah72AxpRH9oE/bQkpsJH6DRq899BpH8OvKB3KCvzlBGq7lx2U/aRM?=
 =?us-ascii?Q?LxnsJW0IjjFsWuzCVNnxDzjKh7WGwU695t/Aia8mSSrgLd1clgR+mSe+u7ei?=
 =?us-ascii?Q?wJhlUo81qMhVJkDSqGFxZ8tOF4Z6XrRqsYuwIOuqVHPO4v69pQ0y24H5lRzr?=
 =?us-ascii?Q?OaDrT2Q4A3TDWplQ+z5Q5eufYJw6EoU8oYiIUOuJ1VYXn2YO05WTWRgnYPEC?=
 =?us-ascii?Q?LgkXv3gh+hKWR2ruGB9xG6UyaKpoaz6ogp70+KHfFvSzoKwc6VGuB2njQl2J?=
 =?us-ascii?Q?dWW6q3xaNuNs1UoG5/WGuq8ICY/RRStREZ2Y2ZsXScmT4AQ23oO+0ZEJNG2u?=
 =?us-ascii?Q?LIiWC3BVStBGpzzGlfWMKeubJugs2w2hT0yGIGXAl8neA/KjwF2Si7g2HK8/?=
 =?us-ascii?Q?/+kAPaxmXpFbBgpXv8W0umN5L0qfplCjtHukw3IK63DGi6yZ0l9EixYq77iu?=
 =?us-ascii?Q?9gK4jSANAQHdtGL5gZzEiF8kkPgWDzyYys/ORCPsJBchfKI2zw2x7peXhOph?=
 =?us-ascii?Q?R4xORjzC+3/0RtLobWw/VgbMPKYm1ymrmOuhhFh12MEs3Tj0V0omx4tzfymm?=
 =?us-ascii?Q?ad3g+Ht35RTsdrxHQwdY2JDcqVwmLbcZQBiEV7pb18ZQqLqGq8WQ3S2wURCa?=
 =?us-ascii?Q?C2hOhUitGHIw2hQfTTI7TWKxofEZnYUAQH7sjfaJFzrgMtoAbmUDiI/fiPRm?=
 =?us-ascii?Q?0Hmnrwe3+jRV5YuKFk4gagJOv1inR7YMBeMUxTQvdwh2yLoPdEG+DTVCLSnI?=
 =?us-ascii?Q?wPGi0tGh7P4KB+5M4AJc37PZdhUINIUccPSepepfz1ew+YhaEzpuTPlV0tD5?=
 =?us-ascii?Q?yn2Xbh/7XTyIOjQ003Fxigs1AFqHIU+qNzgW?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 21:32:51.6348
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c328614-2c68-480a-ec01-08ddd9e7caa7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9392

The CXL Cache ID Decoder capability is an optional capability present on
CXL downstream switch and CXL-enabled PCIe Root ports. This capability
is required for having multiple CXL.cache enabled devices under the same
port (CXL 3.2 8.2.4.29).

Add mapping of the capability as part of allocating a CXL cache id for
an endpoint. Implement mapping/validation of the capability in a later
commit.

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 drivers/cxl/cache.c     | 25 +++++++++++++++++++++++++
 drivers/cxl/core/regs.c |  8 ++++++++
 drivers/cxl/cxl.h       |  6 ++++++
 3 files changed, 39 insertions(+)

diff --git a/drivers/cxl/cache.c b/drivers/cxl/cache.c
index 24559b9ba8e8..f123d596187d 100644
--- a/drivers/cxl/cache.c
+++ b/drivers/cxl/cache.c
@@ -69,6 +69,27 @@ static int map_cache_idrt_cap(struct cxl_port *port)
 				      BIT(CXL_CM_CAP_CAP_ID_CIDRT));
 }
 
+static int map_cache_idd_cap(struct cxl_dport *dport)
+{
+	int agents;
+
+	if (dport->regs.cidd)
+		return 0;
+
+	/*
+	 * A missing Cache ID Decoder capability is only an issue
+	 * if there are multiple cache agents in the VCS
+	 */
+	if (!dport->reg_map.component_map.cidd.valid) {
+		agents = atomic_read(&dport->port->cache_agents);
+		return agents > 1 ? -ENXIO : 0;
+	}
+
+	return cxl_map_component_regs(&dport->reg_map,
+				      &dport->regs.component,
+				      BIT(CXL_CM_CAP_CAP_ID_CIDD));
+}
+
 static void free_cache_id(void *data)
 {
 	struct cxl_cache_state *cstate = data;
@@ -138,6 +159,10 @@ static int devm_cxl_cachedev_allocate_cache_id(struct cxl_cachedev *cxlcd)
 		rc = devm_cxl_port_program_cache_idrt(port, dport, cxlcd);
 		if (rc)
 			return rc;
+
+		rc = map_cache_idd_cap(dport);
+		if (rc)
+			return rc;
 	}
 
 	return 0;
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 0924127bd8fd..1362f4156ee6 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -110,6 +110,13 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
 			rmap = &map->cidrt;
 			break;
 		}
+		case CXL_CM_CAP_CAP_ID_CIDD:
+			dev_dbg(dev,
+				"found Cache ID decoder capability (0x%x)\n",
+				offset);
+			length = CXL_CACHE_IDD_CAPABILITY_LENGTH;
+			rmap = &map->cidd;
+			break;
 		default:
 			dev_dbg(dev, "Unknown CM cap ID: %d (0x%x)\n", cap_id,
 				offset);
@@ -231,6 +238,7 @@ int cxl_map_component_regs(const struct cxl_register_map *map,
 		{ &map->component_map.ras, &regs->ras },
 		{ &map->component_map.snoop, &regs->snoop },
 		{ &map->component_map.cidrt, &regs->cidrt },
+		{ &map->component_map.cidd, &regs->cidd },
 	};
 	int i;
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 1a2918aaee62..04fde1a994d0 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -42,6 +42,7 @@ extern const struct nvdimm_security_ops *cxl_security_ops;
 #define   CXL_CM_CAP_CAP_ID_HDM 0x5
 #define   CXL_CM_CAP_CAP_ID_SNOOP 0x9
 #define   CXL_CM_CAP_CAP_ID_CIDRT 0xD
+#define   CXL_CM_CAP_CAP_ID_CIDD 0xE
 #define   CXL_CM_CAP_CAP_HDM_VERSION 1
 
 /* HDM decoders CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure */
@@ -176,6 +177,9 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
 #define   CXL_CACHE_IDRT_TARGETN_VALID BIT(0)
 #define   CXL_CACHE_IDRT_TARGETN_PORT_MASK GENMASK(15, 8)
 
+/* CXL 3.2 8.2.4.29 CXL Cache ID Decoder Capability Structure */
+#define CXL_CACHE_IDD_CAPABILITY_LENGTH 0xC
+
 /* CXL 2.0 8.2.8.1 Device Capabilities Array Register */
 #define CXLDEV_CAP_ARRAY_OFFSET 0x0
 #define   CXLDEV_CAP_ARRAY_CAP_ID 0
@@ -241,6 +245,7 @@ struct cxl_regs {
 		void __iomem *ras;
 		void __iomem *snoop;
 		void __iomem *cidrt;
+		void __iomem *cidd;
 	);
 	/*
 	 * Common set of CXL Device register block base pointers
@@ -285,6 +290,7 @@ struct cxl_component_reg_map {
 	struct cxl_reg_map ras;
 	struct cxl_reg_map snoop;
 	struct cxl_reg_map cidrt;
+	struct cxl_reg_map cidd;
 };
 
 struct cxl_device_reg_map {
-- 
2.34.1

