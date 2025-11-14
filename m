Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010062.outbound.protection.outlook.com [40.93.198.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D18B35E53A;
	Fri, 14 Nov 2025 21:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763156422; cv=fail; b=SElpNbwk2YexqnN68xh5cYbwrkIns3pqgbLttK/7kAQjnbyiRQAl7JngzVtwUbkVc5jHG7ttHnPkZjMwBb4A/8eT1BHP0FdO4jvWaFXdKTqFiVRSqy1dPBPz+iPV8KRHIYI/NeZNEYUmR4Q7bY0H9dr+t4jX7wAJPp60evxsl68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763156422; c=relaxed/simple;
	bh=GS0tkR1bxoAWbCbJFlmi6dlSShLTzJvNkXsbjHidgek=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GF4d0R1/f+L5VoAG+HkJOI/HSqa8Fa7cq8tyJ6xfk2IBR8E2G4O/hl01FarVGX2fatJfYY8oh8GZqceE3gTaYxgoV6T+12W0FNHKM1kaudP+t5X1y0ISS31wKAcb+DjwHTqEDZbYQEs7hb141xlgzXf/9LgepPBg94dloj60a9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=S55hAKh7; arc=fail smtp.client-ip=40.93.198.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="S55hAKh7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tprEVPmg323lqN7/HabEWPQD0kq86eMXggjDS2iKXNQEGQ5Sjn4G2wvbzd/95rjNTZRXBWnuFclMM+F7HvA0tGUieHsBKuBoyfB/IoltwpKV6AxbVtcswHvgu9hhWFIJaBRNbD3HGZEgARrwe2JuCcvo+Lf3pzvhYO0tJdus1aq8FiHmpgzP6osba7k50z4CNTaSkj/trUM46TH8/ccy6Nw2A2fybVelkzNL53M93w39AS2/rZvBRWt3hmNLlr35Zn3C214IKn7afCvLAY4XErLj6ZYblBUaOrKURRRRNcHGkjWYiEE9VEbcEYq/InMe2wo/zQZ6zhdtrHu4+VaXIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+1Kuu5LfrtWDVLGCFKooEngQQXUA4xBf60Mc9IOwj+w=;
 b=R8lfE4eb5jS6SITXihfIxSzDdcoQ/8hNbk6YaS1JkQKz9sDXwZQs/uxxESk0KHPb8CzFBAbv8NcNrKRx2RjRx1KRW4NJWkhthajOlUqDRi1e6kI4AFoKgFWfPE6zgAQQjlmWAYlcySNIJf9tAxtTEhGGE92x+7xfDRX0mmMSsfS+G8U6rm10StD4t0FuCP+F1n2BRCiLw1Af6F+v6Uw1eChBh9GDb/YHPeWiMnILyi+HdlsXQhv8qi6IWmP/t05ebEplsWaABfgfuHtGXja2H6MZviK8mzqeEm0DJ1kpjs6RK9gzs44WmWNraTmNXOR1L7rXHxEcFitA30V8Jq0x1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+1Kuu5LfrtWDVLGCFKooEngQQXUA4xBf60Mc9IOwj+w=;
 b=S55hAKh7qnXc3fgFGzcDUMTiZ1EqcXgQpXgHXewr6w5PlWodokGC+ylQktTu1zTOpJ13NShwZ11vPlaSEHDy5BOUuK5OuXnYKd+jqws4k46FPasAVMERGvKilUqtOZPmOa4yh5ndMbz95aIF2zywwJuuYuqdV7XKkPeoxkZb6nA=
Received: from CH3P220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1e8::35)
 by BL1PR12MB5825.namprd12.prod.outlook.com (2603:10b6:208:394::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Fri, 14 Nov
 2025 21:40:15 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:1e8:cafe::28) by CH3P220CA0007.outlook.office365.com
 (2603:10b6:610:1e8::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.18 via Frontend Transport; Fri,
 14 Nov 2025 21:40:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Fri, 14 Nov 2025 21:40:15 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 14 Nov
 2025 13:40:11 -0800
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v7 08/11] cxl: Introduce callback for HPA address ranges translation
Date: Fri, 14 Nov 2025 22:39:21 +0100
Message-ID: <20251114213931.30754-9-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251114213931.30754-1-rrichter@amd.com>
References: <20251114213931.30754-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|BL1PR12MB5825:EE_
X-MS-Office365-Filtering-Correlation-Id: a1fba19b-c93e-4d80-7733-08de23c665c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qWvT8m5BnQzYvb38HXsX/5HZp30ZTetwvoVg4q3c9ODWT9TZpotZgLZCcEHr?=
 =?us-ascii?Q?BX2zhkinnAY4vymYIJN742zP1khWGOz81p4xJpgk5dM++x7qh8h6FB8Zf2Ns?=
 =?us-ascii?Q?F3KY58mpC1I13YPuLg29Nw8TfaiqmAtuhG0NhmfKfW3P7qhQgKnZY6o8DBh4?=
 =?us-ascii?Q?VgQXCFClbH2Gxm/+ZUPa/C6A1Hg8e/oH09vXNAf3t27fZeZDPY9RrcIyPG+/?=
 =?us-ascii?Q?LhNEIf2+wc26Eai4HTxSfDjA6vwRJ25P2tWrM19fyHMvZuHgIWB2WzgjjoOB?=
 =?us-ascii?Q?jI0QX8MNcXakb44mioq7sae6bekdhToqBctrBc3Oze3Sc1I1ddD9T0fwzPWy?=
 =?us-ascii?Q?5Gs41imy43/pnZL+K7EBABujZbW+bXgJmMJ+81DRVQ5RZggWAw1oB/ymKT82?=
 =?us-ascii?Q?hxYAcsOggAbZhNjNinKcCirQChfyb3W5Q+0V/+oxKUKu6smc9zTp9bNYiK7u?=
 =?us-ascii?Q?Ts8iIFRlkq78L0mW6VIJL6zbw3ItSGiYm4hLjaYndWdvhmjzCVPszpO6l5iZ?=
 =?us-ascii?Q?GVJlwa0iTTJyPi6EFrgMF69hyImDJPxU43H43zNXMOPveINYlovMwG/KH6xh?=
 =?us-ascii?Q?MRG48VHpFLH1LXpWx31nnNfMQfd0AlPh9114KdRh7oh/SMbdBoi2VhF9jYdS?=
 =?us-ascii?Q?rl3xsc+aX+O4UggMXy+IcCmE5YnhhPpK0FmZhJsbk8jIUg9mXNyqrVi1xfV2?=
 =?us-ascii?Q?FEYzxj5xzroMaDVLhX6C6vQuWQwX+iL22AeMTiAzicABitx5kuYspRRtnMDS?=
 =?us-ascii?Q?j+YDUHsvxLXOIhuXg3UOlG69+99FGvD3imoM3dLlK9QWL8wuTkoVuCYhmR31?=
 =?us-ascii?Q?Zn27HgUPYrqNFMaCfXqTYTG0sEhLAp2D3Mi2KL8NMMhUHsczv/C2gqBgXDy2?=
 =?us-ascii?Q?artzkMe7IlIsfu6Tl4PxV8QwimHoEr1qfQZPKQg99JEJ4/b3F79MT4Pr/z0l?=
 =?us-ascii?Q?k/X1iASYQrtCJoZn+oRca9KBSsKbA+9GR72OYC9oyU1JgBYhKGwM8UbOqwqZ?=
 =?us-ascii?Q?3JQX5ed4r1k8uQXOYzmImINQvKLgYPb+cetfr472RdDYsXcUgBXLTHJfpIpU?=
 =?us-ascii?Q?pQR+hsJjsgFDwuG/Z5n18h7Dem+40VFblqEVIogniNuViz3cNfcHscKLNl7Y?=
 =?us-ascii?Q?h4BvQ/OTXZ5wJzWGdbIlhBZe83WHU4Vy8HqIHrMtI8HmiMmmRkCXYMt/WOo3?=
 =?us-ascii?Q?ZFj3uTkefig2PtJW/x8iSktbZWJyf5QB5apIU3UTk7eFf5EF8w+1NDVbm4yu?=
 =?us-ascii?Q?UfSLNBamE5RJvcxNJCOrPjLyTssjtUPL2IllHY0Wbyjv3M6tbI9R8KBtXaPd?=
 =?us-ascii?Q?aY/RaQdVkwkWybH5qewEIrSoteET1YABRKJhySehI/D9NqpUMAlQlnzsj+rL?=
 =?us-ascii?Q?H26uA923W8uzQR+tJPpl0UCNl3XhwVWByoITOdTGZT7dC2EcmVxlXtbjvhW6?=
 =?us-ascii?Q?72dNTJ5dVrED4B3rZPZ9nYZTB/g5ZFHbCl3vNWdpVjjbvQ3CYLSukRjVAaZi?=
 =?us-ascii?Q?+mDAO3UTIuyIPPGaZKqjttMyumW1ugiPt/X+qhjKI/EZhe5AQeaghLiD90+e?=
 =?us-ascii?Q?NtDYlOxDI/RZT6QczsU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 21:40:15.0334
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1fba19b-c93e-4d80-7733-08de23c665c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5825

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
index c028b772cfab..42ba0210c779 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3354,6 +3354,15 @@ static int match_root_decoder(struct device *dev, const void *data)
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
@@ -3366,6 +3375,16 @@ get_cxl_root_decoder(struct cxl_endpoint_decoder *cxled,
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
index 8945dc1532a7..e67e37322ee9 100644
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

