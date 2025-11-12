Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010006.outbound.protection.outlook.com [52.101.61.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D842B2DEA9D;
	Wed, 12 Nov 2025 20:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762979548; cv=fail; b=GwEsXfsoH8E6eZWuJL3JiJ0prgEpK86Og2jQnZlV4ZdT41ftdDEIxIgwYBd3I3tMdOiIfNhqQfPcYIS/8a83JyjouiFvIPfXsj76zdAX1WEwf9x0nUf9dQf/gvXpm//UUXTIM515uOaoUjLTWNThX+vXHtb8UyZ2m30Qmodyfow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762979548; c=relaxed/simple;
	bh=2PtMGP+Qi8HFwGWDCKmpgNcBKc4zIBnVXmIjYSz0j38=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cqzGLNxQ8gKZVwuEB9cBv02t9ElitISnufNXbO8Oav5p5QLSBcB9VvBdgcO7ahvhVAWt1+RBYkj0O+54Nk0hSqPw2cmpCFfxQQjXFAKDO+EmOLRACdSrydGg9FmKV9dhFKu11uq2qa0BL9M8jmUlAF0E3sUzYvZebwpR1sGwFFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bNgqaSxd; arc=fail smtp.client-ip=52.101.61.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bNgqaSxd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uypDj0xQICG8u88lNIH+Y3g8WQreeH4OlsiR7oc64ScIvAO4HhjBZCIT5+cawkoKu98UXp2MxDZz9z+sUSzaWsWdeB884LU67Yds2jkjVa3f9Tt/6zQuSYg0AhLkhNvH1z+qco0UjOVEMsy7WevuB68sJnRWzC00Qsdp+ejVDH7iqfG7ShVCxwHfzCRKXX9l0VlAQBeHWP8jT35C4IM0BJAU4JBd4fbwXEoW/AGF4y3Jp4sBgLQ3p7YJwzENwQnf+PspWp6Guc6SXdRIcIlMU0GgeAiAdW99zZEEkbuNS6tOwe+I0wVqHa5BvlVrPUVyBcge6dUa3+iFibZyo6gjhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bUarpgNSzu4am1/28KGn0mqYD6VkM8OjJF816UxCUXE=;
 b=hzABq9bOsN1AMURC4nwe4WgCpQxuTYPt8x5uQGFW/7XOTwNuz4HOc9nx8l8MvndA8x5PVPf7A1TelRxmjcAycn8fXd8Ny2GjlB+zbDt2q+lMvOiml94vE8zkzFjBLjg4NX78EWQH9kK7WY6FqlJfUuqAovfcmj6Dv2JGCm2PXJzxQ8z/yA7Jz7qb8di+/Y3k7J6btyUNacPjMXsqbGJUaLpTBW/bnHKlLUSkqTpozZZc6De5SCVK5Nht1AG5/wPCNuzQdUk67Xp8TriAIxXht2XpLCfddmZCG9oBU4Zgy/JoGe2TwahffpH84roSiBDvwzj2F5JFw/anIB4aLwumqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bUarpgNSzu4am1/28KGn0mqYD6VkM8OjJF816UxCUXE=;
 b=bNgqaSxdFcmgvsTFxZnZ8sYhZDA2h0et/rKn+BiqM/U9zM4QthNE8kAstf8MnMP34GfISQXdUR+1sVW8koJoQtBZO0GpnbrtLye34/MlgskHdAHiytA9zHWBLzpNkS4lvc8rgSdpHwcIyVrVJPxYIXAO4mtJzzcVbEUF+rxcqCo=
Received: from CH2PR18CA0049.namprd18.prod.outlook.com (2603:10b6:610:55::29)
 by IA1PR12MB6236.namprd12.prod.outlook.com (2603:10b6:208:3e4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Wed, 12 Nov
 2025 20:32:23 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:610:55:cafe::e3) by CH2PR18CA0049.outlook.office365.com
 (2603:10b6:610:55::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Wed,
 12 Nov 2025 20:32:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 20:32:23 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 12 Nov
 2025 12:32:20 -0800
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v5 08/11] cxl: Introduce callback for HPA address ranges translation
Date: Wed, 12 Nov 2025 21:31:35 +0100
Message-ID: <20251112203143.1269944-9-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251112203143.1269944-1-rrichter@amd.com>
References: <20251112203143.1269944-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|IA1PR12MB6236:EE_
X-MS-Office365-Filtering-Correlation-Id: 545736ff-3340-41f2-7827-08de222a9637
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6Ung4yST46ZRyn9zP0x7Tn7XrvoosZXzyK7HNpos8gjOORBO/BICVaU2t0RR?=
 =?us-ascii?Q?bvarlEJ9v179V3IxN7mWU0MHJdqu+DHktjDNmzOD91hvzbGvsrLAI3RVqFKB?=
 =?us-ascii?Q?iMnXG6XneSgSCA0phneZtJywb2VBTXXoevOSSGJVcDWwaQK4S/0aJu2CsL1m?=
 =?us-ascii?Q?/WQqIg+fRuvGSEd7SeNRgUZ18WK8rxXWeJSCnVxsdhpnecPL6vatL7WQ8Rmi?=
 =?us-ascii?Q?K4Ff2eqvs4mzS6bMsAgpRa0vNQ+pX0KjyEOtpq2MfB6+cBdi0bnnOMTuztsR?=
 =?us-ascii?Q?Va3+5Pn1KjOYOxuEcLAxIvA6TaLKKqGqiIk8FWq6hbZqJteUTVLsyCVgkKbf?=
 =?us-ascii?Q?eo0aU4Loe+ewbqbnCMeou5N+7ApQBrruJq79ORjAsryZEhTEmJn1hLG90ZZL?=
 =?us-ascii?Q?klQVlqdpIGBM1WzSC/uMfVSHA3QXGU3ltdq/ootg7eZCGaiZFCjg0g+YdGN1?=
 =?us-ascii?Q?sNqjx+3uDrcIvLDsweP4qwIl2t6bziW4iUhxRYod1BCQpwUlHi61rcz6egkY?=
 =?us-ascii?Q?b9N0JqQ2YPS0o61vsMdfaeKXOfwDelWBfvD0WkWhAaf1N5PwSRDZrAhLTtUW?=
 =?us-ascii?Q?1e7affbL+MGxScmBnLxdzSjohBh5D0UiSMMEMsW8UQuRaiKTAV6ebWqvpbdb?=
 =?us-ascii?Q?lTw9izivW2a1H/dJb9aGhX5XX8o5ZFOFWQ06kjy6p9r80s6JonW0ISVKD2AH?=
 =?us-ascii?Q?6AJBboyemO7wZdR3Vqs9qZ9U4dHlWSvhqzTdYhe9Cv0IikbQRW6ZJq9EX16C?=
 =?us-ascii?Q?D3atDuncxQmCb0rDk6+ZHdH5x8/TFz3HXCtzpSX4FIApKwQ4oKBNVgKtOchL?=
 =?us-ascii?Q?6KJlzttGQ1R/fgGNOYi650ta7rXImt9XiHE4YGcpU/Aicb9anxViugVzdmcd?=
 =?us-ascii?Q?fdEir0gKDE7EGLEtFJ8i6fD+6V8DsG4wQjiFUEVjXzEYIK/GFVeTY6/mEnGg?=
 =?us-ascii?Q?/LFhPpYrUZlLkC4IuQh8CxzaWRfTm5fNjt33Wp8Fyd+U/uFW/73aI5K6gWoT?=
 =?us-ascii?Q?fHYBH4tAV42EPERjzA30WE0vrdYMn0r+8SExJ2TEp9zWyiijctKC9vnS9Nv0?=
 =?us-ascii?Q?8bgT9Uj2XWIWhVgvsx+MC55wLrYw72VdOMuxfUdpOky0EAKztVe2FvcayFWk?=
 =?us-ascii?Q?rgcJVxvkAaWaji2NsLo7Z86kETkraodSddtasZfEz8hldfT0mL4R39sr1+dx?=
 =?us-ascii?Q?x84TzGwuVDSdfBsYP5bNvLVXETkAsPCUDcOnZkndRVkW5WZWvLMTwDcbxftM?=
 =?us-ascii?Q?1nczcH3SrNegUI1OPIT48uqCmslttDqdgXCgoa4yOp3dD0QBHIaZ7X7/vCb2?=
 =?us-ascii?Q?8qn8rnQG3JSUZ3P3jZXgJ6zI0sM262HJdYbeTneQPLGqXRCCaP0xS/Nhlew4?=
 =?us-ascii?Q?m72WzbGxvy2tAT6KfiJU7E9wPVymDOE2YqmL86GK2nQvrT+b1bnMnfpc+b2t?=
 =?us-ascii?Q?SSj2qFh+SRtAUrwSO1rCXdufklGSjEtn0OUcwr/1u9fCCwpvyJh28Q7brm6Y?=
 =?us-ascii?Q?8EIiWqyrjVCU5aa25V1IcC2Ube9yf/I33Nm8MTz3bamkeGpqzavjMQ49olvr?=
 =?us-ascii?Q?nwG9jR2pSlG6gC+5ksw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 20:32:23.6704
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 545736ff-3340-41f2-7827-08de222a9637
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6236

Introduce a callback to translate an endpoint's HPA range to the
address range of the root port which is the System Physical Address
(SPA) range used by a region. The callback can be set if a platform
needs to handle address translation.

The callback is attached to the root port. An endpoint's root port can
easily be determined in the PCI hierarchy without any CXL specific
knowledge. This allows the early use of address translation for CXL
enumeration. Address translation is esp. needed for the detection of
the root decoders. Thus, the callback is embedded in struct
cxl_root_ops instead of struct cxl_rd_ops.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Tested-by: Gregory Price <gourry@gourry.net>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 19 +++++++++++++++++++
 drivers/cxl/cxl.h         |  1 +
 2 files changed, 20 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index bdd44096ea02..451e5492911c 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3472,6 +3472,15 @@ static int match_root_decoder(struct device *dev, const void *data)
 	return range_contains(r1, r2);
 }
 
+static int translate_hpa_range(struct cxl_root *cxl_root,
+			       struct cxl_region_context *ctx)
+{
+	if (!cxl_root->ops.translate_hpa_range)
+		return 0;
+
+	return cxl_root->ops.translate_hpa_range(cxl_root, ctx);
+}
+
 /*
  * Note, when finished with the device, drop the reference with
  * put_device() or use the put_cxl_root_decoder helper.
@@ -3484,6 +3493,16 @@ get_cxl_root_decoder(struct cxl_endpoint_decoder *cxled,
 	struct cxl_port *port = cxled_to_port(cxled);
 	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
 	struct device *cxlrd_dev;
+	int rc;
+
+	rc = translate_hpa_range(cxl_root, ctx);
+	if (rc) {
+		dev_err(cxlmd->dev.parent,
+			"%s:%s Failed to translate address range %#llx:%#llx\n",
+			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
+			ctx->hpa_range.start, ctx->hpa_range.end);
+		return ERR_PTR(rc);
+	}
 
 	cxlrd_dev = device_find_child(&cxl_root->port.dev, &ctx->hpa_range,
 				      match_root_decoder);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 11709f0f91d6..8d056095402a 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -644,6 +644,7 @@ struct cxl_root_ops {
 	int (*qos_class)(struct cxl_root *cxl_root,
 			 struct access_coordinate *coord, int entries,
 			 int *qos_class);
+	int (*translate_hpa_range)(struct cxl_root *cxl_root, void *data);
 };
 
 /**
-- 
2.47.3

