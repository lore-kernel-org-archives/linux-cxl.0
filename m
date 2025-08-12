Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4E81E5B7A
	for <linux-cxl@vger.kernel.org>; Tue, 12 Aug 2025 21:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755034347; cv=fail; b=mZPt8Ce/GUYGte2YQx4tvOBP32X9pahVr761W3Nz/jgO78t52whWAJuAfexUcad+02Pta43TqAwQAzYb86jUpDGulVoaYG0w3lECA92qkyb2hizHnv159fa9luU9MMpzOjoOKWiORJPZgY6SvgC5qmQPvlvvAaxRPaIisZm5+Js=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755034347; c=relaxed/simple;
	bh=QkECB7bzUQs7Xg5IL3hngW531AV19v0XrbK2PRQSiXU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=azyyRhcE1EEIJ7TRPiAuKOGTUnUyAQKLjtLadZL3lg4Zek5E7JRvrXz5dTt3LPJ+z+DobccMNz3LMepamfIDw7f1l7j0Vq3Xdg29CSstxkYps/DGhqIuu4X684wulDWok0+MxV7SvBoCa2aM0yI0bSHRE7pmNOXtvzShhSgcYWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=g9UuIS6e; arc=fail smtp.client-ip=40.107.220.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="g9UuIS6e"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xWUhKHlQkUyAh8VMA0ImqyH9V36AnDIbC2Twj6U0VrG6akXlf2kGe6To3lqgeU76is4fpXx1aywh2NYZTSIkyn6CYCLzG0mEb6+IptS1VCUJ9KHm/BnWoDR70gLDVyrGAg6tVYDoBhtrfcZ7fSXubT9BLrBUC0zP/pU7qjAdwQnP0x0+ZvUwIN0/ORW1sNzJ76RRnmvYOWBo5/lAOkaL9PLTJ92xRluooImG6CUvxo50NN2oNjEEyaxmLOfTxyGKTXH2PQNzuXhZB46K9w/2mub4xRCoRYMHGzpDMW6z9283e2Hu172E7BXtNC9ycV6WoPm88/u3wzo7ro0pxiSoAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BOOwvIINUtDvrEmUk8cdq82l8FbI3JPIG1OHUVUZ8LQ=;
 b=nOMiLU+BxI+SJFPn6IsdOeSaSZ++TDPA2YBILz0CfRdecrVsTBzjWGI6ogp4a7YsONfsz71myKlxjQoedZerDGi8yiwSG10ACgb/seucwpTSvQ4Nlaccrvh3Dv+Qzx9vlX5OmSAoDPES133HOLaMIRYs+Y8NUtdnG6M4439BFDg3NKkzpmJPHdsgSngvwfy1P+6AMpi2VgdfybawZQeZKKMjTSWPOoKBVli9z7vKXd7YsvQZGYmCAVmwJTMgnvQEpLKPukQBVzDx02mLXXlb/ALd//Vr6W9cdSJe72fxmFgyW3s0pScrq49Q94RnSC35x46aAyIRjCrLf6vd2OwoJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BOOwvIINUtDvrEmUk8cdq82l8FbI3JPIG1OHUVUZ8LQ=;
 b=g9UuIS6elfQWi/3IDzUcZ1MaI4Y3dr+smDFUPbrzh5QqCqQFE2+7gyGu1+ZPVxKyaEQIU0M6LYBHNIIeoL/bI892wcnukxHsW597wTtrHVdhGye8mL6n0TFm7q4GfrszoHVtM8jEZzE8pjigIRyytTufhQIokQnxZGOIZEoKnFk=
Received: from DM6PR13CA0005.namprd13.prod.outlook.com (2603:10b6:5:bc::18) by
 LV8PR12MB9206.namprd12.prod.outlook.com (2603:10b6:408:186::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Tue, 12 Aug
 2025 21:32:23 +0000
Received: from DS3PEPF0000C37D.namprd04.prod.outlook.com
 (2603:10b6:5:bc:cafe::39) by DM6PR13CA0005.outlook.office365.com
 (2603:10b6:5:bc::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.14 via Frontend Transport; Tue,
 12 Aug 2025 21:32:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37D.mail.protection.outlook.com (10.167.23.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Tue, 12 Aug 2025 21:32:23 +0000
Received: from SCS-L-bcheatha.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Aug
 2025 16:32:22 -0500
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <linux-cxl@vger.kernel.org>
CC: Ben Cheatham <Benjamin.Cheatham@amd.com>
Subject: [RFC PATCH 12/18] cxl/cache: Add CXL Cache ID Route Table mapping
Date: Tue, 12 Aug 2025 16:29:15 -0500
Message-ID: <20250812212921.9548-13-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37D:EE_|LV8PR12MB9206:EE_
X-MS-Office365-Filtering-Correlation-Id: 281b4e78-b6c5-4bfe-8bed-08ddd9e7b9be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/AiKlp03zrCUStGCx6VtEPWAlBuGSGQrd5Yo2SymGazS/KG3GVVef4WZLQGo?=
 =?us-ascii?Q?GvHul2rskiY4uoSSGvbtgJOOHPXM42+z6ZHERqoh1KRVquYfVrYFjwZ8ax/W?=
 =?us-ascii?Q?g10H7PToBiwo0di64Uwbyb58ABE/ZnS6q54+JJtN9iR8z+v4KDcdjs7Npgc2?=
 =?us-ascii?Q?qRN16p6OJClYqciesC8doPheiKIMaNtF9144sWhRzvBcx4xYnMcQEdHDrTcK?=
 =?us-ascii?Q?W+VKUnRQcAvdyzSkko+A/AUmWL9cSyYNuvJkUS7V+xcTuSNe9+DFiaLfvSfw?=
 =?us-ascii?Q?MmayNd6398HjCqw7ggOdq8ZlA/D7skSoXG7DlWY1Bpz6Gb/J8H+MjSRwbF6t?=
 =?us-ascii?Q?nqVmfEKFneW+uShj0GN0KbDGmqpb5JNYjVupH+bm+UntIG6NpdXsIFbYOTmW?=
 =?us-ascii?Q?ZU4cGEFYb6aKXLQHfECmrnvGaEkGWq5BGBUDG+cr4ROpicO+5rrRqD4tZCJz?=
 =?us-ascii?Q?IiXwbwnL6lkJDGvpIe2bvQYaQhgHvFoS7CIto2qXw97Dan+3AQjiKEIlpvvA?=
 =?us-ascii?Q?28WyJWzu2MOVL6ZlsuSWOHTbziRtgxjin/kgeh12V1i05jEBU0dXgg1EG47X?=
 =?us-ascii?Q?RbxeOhN/36r8cPOsT9zC1utZ8Jo7by6sxOa47HRPJ4gPrV+y/T4Ro36E290l?=
 =?us-ascii?Q?9nKsXaF/9EFV7iXUIPZJhNZ/XMNGwFxTVGLLJSXV0tKk5nUAOjbET7rjYiQ5?=
 =?us-ascii?Q?39mEUODzDhg1Nz9+acMjESYaTzKgTRp/7fIq/+fQI6dXkAfNL3jpq5Rkydyl?=
 =?us-ascii?Q?xUijuKT6Lg/zqaqfHvCpG/S5v8jspTiBf24k05dKg7+UXLjeTVcGVBJcVOsJ?=
 =?us-ascii?Q?+hRr55b9iBJ0oKmiTjKDeFzg7CF1XWCZcSYUWmfa0voGIgFWhwLrwaGsyrFN?=
 =?us-ascii?Q?JCkTeqCuKuXiENKrbFGlSFi/uCzL1BsV3MvTFym2UR9JGnlXb8ZPNGYTfCDw?=
 =?us-ascii?Q?rTfDoCtUVsui+nZfBNyLitCBBUKDkfG1YcQD6+y/0HFLftCs7ObmwGGw2mBt?=
 =?us-ascii?Q?7cd53YMPka4oJijFC2TrzoR4q8+YKuNgSSg7WekjQ0hPOjSLt2zKzXgDAlf/?=
 =?us-ascii?Q?ZuEkfVFqvuT57OacJlHvuqmgFA8hhlgIgCIzjo/rY0vrinjBX/dq0es4PHgu?=
 =?us-ascii?Q?fc8LN4ic1vcyI5em+l6E/5xL1FRwRVItp+w1REzFIiXjip/Q8U6eONM9LcaQ?=
 =?us-ascii?Q?ZIOpBaSZphu5ycbYuRA8pAmEOTWCmHUewdu30uw79l6q4tSMfu9qeRV08Hwl?=
 =?us-ascii?Q?AktqUyIEHHDf9RKCTNx9iBcKwj4QklO6whI6hg670Jx2tTQinnLgvGFQwY9+?=
 =?us-ascii?Q?uBEz5nE4a9OyoJJHFFmQZFj1fYokfcRPULwLqCOziICHbNVQqRfRusZs6DuT?=
 =?us-ascii?Q?2R6Ah+cNKlEVedx/LcM1kgS6/NcaiG/ww8kvTgvdXuSRX52DtoZoWMb5zsp+?=
 =?us-ascii?Q?g/pNRkYdV7mam/zcrxyoCot2wLYGznaVQ4Mor+6a8DwKr57yG9W3gmZyWsI6?=
 =?us-ascii?Q?pgI5jJVJiomlbxeWvjeqrQQjcj/Rx2iqn5Ds?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 21:32:23.2401
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 281b4e78-b6c5-4bfe-8bed-08ddd9e7b9be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9206

The CXL Cache ID Route Table is an optional capability implemented by
CXL host bridges and CXL upstream switch ports. This capability is
required for having multiple CXL.cache devices below a port (CXL 3.2
8.2.4.28).

Add mapping and allocation of cache ids to be used by the cache id
route table and decoder capabilities. It's possible the id has already
been programmed by BIOS, in that case use the preprogrammed value.
Programming/validation of the capabilities by the OS will come in later
commits.

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 drivers/cxl/cache.c     | 87 ++++++++++++++++++++++++++++++++++++++++-
 drivers/cxl/core/regs.c | 13 ++++++
 drivers/cxl/cxl.h       | 16 ++++++++
 3 files changed, 115 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/cache.c b/drivers/cxl/cache.c
index 7ef36e4bbce8..fd2ae1fa44bc 100644
--- a/drivers/cxl/cache.c
+++ b/drivers/cxl/cache.c
@@ -55,6 +55,90 @@ struct cxl_cachedev *devm_cxl_add_cachedev(struct device *host,
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_add_cachedev, "CXL");
 
+static DEFINE_IDA(cache_id_ida);
+
+static int map_cache_idrt_cap(struct cxl_port *port)
+{
+	if (port->regs.cidrt)
+		return 0;
+
+	if (!port->reg_map.component_map.cidrt.valid)
+		return -ENXIO;
+
+	return cxl_map_component_regs(&port->reg_map, &port->regs.component,
+				      BIT(CXL_CM_CAP_CAP_ID_CIDRT));
+}
+
+static void free_cache_id(void *data)
+{
+	struct cxl_cache_state *cstate = data;
+
+	ida_free(&cache_id_ida, cstate->cache_id);
+}
+
+static int find_cache_id(struct cxl_cachedev *cxlcd)
+{
+	struct cxl_cache_state *cstate = &cxlcd->cxlds->cstate;
+	u32 cap, count, entry, portn;
+	struct cxl_dport *dport;
+	struct cxl_port *port;
+	int id;
+
+	if (cstate->cache_id != CXL_CACHE_ID_NO_ID)
+		return cstate->cache_id;
+
+	dport = cxlcd->endpoint->parent_dport;
+	if (!dport)
+		return -ENODEV;
+	port = dport->port;
+
+	cap = readl(port->regs.cidrt + CXL_CACHE_IDRT_CAP_OFFSET);
+	count = FIELD_GET(CXL_CACHE_IDRT_CAP_CNT_MASK, cap);
+
+	for (id = 0; id < count; id++) {
+		entry = readl(port->regs.cidrt +
+			      CXL_CACHE_IDRT_TARGETN_OFFSET(id));
+		portn = FIELD_GET(CXL_CACHE_IDRT_TARGETN_PORT_MASK, entry);
+		if (portn != dport->port_id &&
+		    !(entry & CXL_CACHE_IDRT_TARGETN_VALID))
+			continue;
+
+		cstate->cache_id = id;
+		return 0;
+	}
+
+	id = ida_alloc(&cache_id_ida, GFP_KERNEL);
+	if (id < 0)
+		return id;
+
+	cstate->cache_id = id;
+	return devm_add_action_or_reset(&cxlcd->dev, free_cache_id, cstate);
+}
+
+static int devm_cxl_cachedev_allocate_cache_id(struct cxl_cachedev *cxlcd)
+{
+	struct cxl_port *endpoint = cxlcd->endpoint, *port;
+	struct cxl_dport *dport;
+	int rc;
+
+	for (dport = endpoint->parent_dport, port = parent_port_of(endpoint);
+	     dport && port && !is_cxl_root(port);
+	     dport = port->parent_dport, port = parent_port_of(port)) {
+		guard(device)(&port->dev);
+		rc = map_cache_idrt_cap(port);
+		if (rc)
+			return rc;
+
+		if (port == parent_port_of(endpoint)) {
+			rc = find_cache_id(cxlcd);
+			if (rc)
+				return rc;
+		}
+	}
+
+	return 0;
+}
+
 static int find_snoop_gid(struct cxl_cachedev *cxlcd, u32 *gid)
 {
 	struct cxl_dport *iter = cxlcd->endpoint->parent_dport;
@@ -122,7 +206,8 @@ static int cxl_cache_probe(struct device *dev)
 	if (rc)
 		return rc;
 
-	return 0;
+
+	return devm_cxl_cachedev_allocate_cache_id(cxlcd);
 }
 
 static struct cxl_driver cxl_cache_driver = {
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 0c8962fcad9b..0924127bd8fd 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -98,6 +98,18 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
 			length = CXL_SNOOP_FILTER_CAPABILITY_LENGTH;
 			rmap = &map->snoop;
 			break;
+		case CXL_CM_CAP_CAP_ID_CIDRT: {
+			int entry_cnt;
+
+			dev_dbg(dev,
+				"found Cache ID route table capability (0x%x)\n",
+				offset);
+			entry_cnt = FIELD_GET(CXL_CACHE_IDRT_CAP_CNT_MASK,
+					      hdr);
+			length = 2 * entry_cnt + 0x010;
+			rmap = &map->cidrt;
+			break;
+		}
 		default:
 			dev_dbg(dev, "Unknown CM cap ID: %d (0x%x)\n", cap_id,
 				offset);
@@ -218,6 +230,7 @@ int cxl_map_component_regs(const struct cxl_register_map *map,
 		{ &map->component_map.hdm_decoder, &regs->hdm_decoder },
 		{ &map->component_map.ras, &regs->ras },
 		{ &map->component_map.snoop, &regs->snoop },
+		{ &map->component_map.cidrt, &regs->cidrt },
 	};
 	int i;
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 2881e0826829..c147846855e2 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -41,6 +41,7 @@ extern const struct nvdimm_security_ops *cxl_security_ops;
 #define   CXL_CM_CAP_CAP_ID_RAS 0x2
 #define   CXL_CM_CAP_CAP_ID_HDM 0x5
 #define   CXL_CM_CAP_CAP_ID_SNOOP 0x9
+#define   CXL_CM_CAP_CAP_ID_CIDRT 0xD
 #define   CXL_CM_CAP_CAP_HDM_VERSION 1
 
 /* HDM decoders CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure */
@@ -159,6 +160,15 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
 #define   CXL_SNOOP_FILTER_SIZE_MASK GENMASK(31, 0)
 #define CXL_SNOOP_FILTER_CAPABILITY_LENGTH 0x8
 
+/* CXL 3.2 8.2.4.28 CXL Cache ID Route Table Capability Structure */
+#define CXL_CACHE_IDRT_CAP_OFFSET 0x0
+#define   CXL_CACHE_IDRT_CAP_CNT_MASK GENMASK(4, 0)
+#define CXL_CACHE_IDRT_STAT_OFFSET 0x8
+#define   CXL_CACHE_IDRT_STAT_COMMITTED BIT(0)
+#define CXL_CACHE_IDRT_TARGETN_OFFSET(n) (0x10 + (2 * (n)))
+#define   CXL_CACHE_IDRT_TARGETN_VALID BIT(0)
+#define   CXL_CACHE_IDRT_TARGETN_PORT_MASK GENMASK(15, 8)
+
 /* CXL 2.0 8.2.8.1 Device Capabilities Array Register */
 #define CXLDEV_CAP_ARRAY_OFFSET 0x0
 #define   CXLDEV_CAP_ARRAY_CAP_ID 0
@@ -223,6 +233,7 @@ struct cxl_regs {
 		void __iomem *hdm_decoder;
 		void __iomem *ras;
 		void __iomem *snoop;
+		void __iomem *cidrt;
 	);
 	/*
 	 * Common set of CXL Device register block base pointers
@@ -266,6 +277,7 @@ struct cxl_component_reg_map {
 	struct cxl_reg_map hdm_decoder;
 	struct cxl_reg_map ras;
 	struct cxl_reg_map snoop;
+	struct cxl_reg_map cidrt;
 };
 
 struct cxl_device_reg_map {
@@ -618,6 +630,7 @@ struct cxl_port {
 	struct cxl_dport *parent_dport;
 	struct ida decoder_ida;
 	struct cxl_register_map reg_map;
+	struct cxl_regs regs;
 	int total_dports;
 	int nr_dports;
 	int hdm_end;
@@ -766,10 +779,13 @@ struct cxl_dev_ops {
 	int (*probe)(struct device *cxldev);
 };
 
+#define CXL_CACHE_ID_NO_ID (-1)
+
 struct cxl_cache_state {
 	u64 size;
 	u32 unit;
 	u16 snoop_id;
+	int cache_id;
 };
 
 /**
-- 
2.34.1

