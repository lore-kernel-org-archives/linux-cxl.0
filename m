Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012039.outbound.protection.outlook.com [40.107.200.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC7626F28D;
	Fri, 14 Nov 2025 00:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763080897; cv=fail; b=NzEkkiu88MXHX9FkysIgYc6C2EbxHhgj6dqTZnf1Y9D5axS/W9+lItCzxWGCAvH/vVRGV0n1BW6xBWblWX2W2dB0jPQ6TaaKA5K9hvCnUcUZD0nbNxjjPfOM8wRvayF5XUB8rRm5WWExB6Wp9SbuxRcdGdUChpEHxfXXLQAouLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763080897; c=relaxed/simple;
	bh=GS0tkR1bxoAWbCbJFlmi6dlSShLTzJvNkXsbjHidgek=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zs2lTntFjcB4hMZ2u+UeXuZsMQWoQck+s2aCohe8e9x0ovxvvEDEFQfaigO36Ni1ZOQwX/eZzN51ltvHR6AX7T6TbKU27p0n/6XexSonGGWt42WAzleU9Px2PjW8qiXk37hYZuD2MTkxRU745Xya6UmdPBV9UFexBYwZh6AfbYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=378NJz3k; arc=fail smtp.client-ip=40.107.200.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="378NJz3k"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e+w2nDzGP7Boh6HnroTXwbg7tPso1+g8GErDRfLNjCWS7iuDYbhKyL2CmozpROW6phNGhcWmv5ixvJ+PrFwk4Il93fiq1WSJ6+0Gs3gVgAy+bP2TMpAPFrdi3e0aJzwciWp9Iue1f/1n93hzFtNL8fmNdRnkDoI/lzcSGF/2Tz4lHII5nphVEc+n8QWkAfq+8LvfSRhq6hmcrZd2zqqZkhcwD7Sdd93dOWMkYIYdI40OG3iJ5L84MzUPH1O52aT5JX53Y3D2YfiRIJ4ira2oGTzAp5OIPEqlhW26VIxD/lsCWaFLGOnPJQOJWYb1aQBmu5Z5aQC9YcCiXYgKLx7q4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+1Kuu5LfrtWDVLGCFKooEngQQXUA4xBf60Mc9IOwj+w=;
 b=k5sTP6FKQWMRyKFMUUB7ryQzF7vLC2EzaYw90+okWtsU3m99Q3Bq3syQbn28YND6LmbP1bJAEGRO5qm6du9B2+JCRx3YOhCNj1T/80BycAq1SY7IZ6rgxRIkd71kr8E71qSfrTxG4zFBYQm8dTR82n0nS870x6dQRewhYRdXgN7Re4Jn6aO8dA9xiCtZ7wdccbj/6Yz5ZWmEXGv1TbMCyFHaWuUwu1JuO0hBGIxUmDKSZ9176kL+1bhvOs7ExJGyYwphBOyXFPDSjybaDY7VIp/ezIW7ziOGxdO19yNuaEvURogYBQv0IaRAD1W291taAKNoF8mAGNRi04CIiihWdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+1Kuu5LfrtWDVLGCFKooEngQQXUA4xBf60Mc9IOwj+w=;
 b=378NJz3kSpPx2/TpHLylPAUdHUL0s3MeJxisZl27w+dZj3umtkdmYxy5lWGGcYSSYnujONKNpWQ+401DtJhWSqyheslbWrPzorAqrP77VYsPUfFY6bBAY/q79DdEjZf4Rfs2sEYrTIINi/iYaB/ZnSGxHBm8Gnrn/80hq1jsCV4=
Received: from SJ0PR03CA0255.namprd03.prod.outlook.com (2603:10b6:a03:3a0::20)
 by CH0PR12MB8485.namprd12.prod.outlook.com (2603:10b6:610:193::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 00:41:30 +0000
Received: from SJ1PEPF000023D1.namprd02.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::3f) by SJ0PR03CA0255.outlook.office365.com
 (2603:10b6:a03:3a0::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Fri,
 14 Nov 2025 00:41:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D1.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Fri, 14 Nov 2025 00:41:29 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 13 Nov
 2025 16:41:24 -0800
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v6 08/11] cxl: Introduce callback for HPA address ranges translation
Date: Fri, 14 Nov 2025 01:40:13 +0100
Message-ID: <20251114004021.1310661-9-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251114004021.1310661-1-rrichter@amd.com>
References: <20251114004021.1310661-1-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D1:EE_|CH0PR12MB8485:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a8f4169-2caa-474a-d31f-08de23168d34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4Y66SBFz+lPK+EdhmumuY10WkmnhjtWeJ0kSpuK9OTgw7M+Rskh3zBjG+RQO?=
 =?us-ascii?Q?upo/1y6pSoVHZEGLOhvpRf0csdzW7z0uU33OzF9G0WoroI/XjrIg5lEE1JPp?=
 =?us-ascii?Q?UoX2lJctFiEThE7/UXb4lorjAh8OvQPzRycpxDBedJe8EysOPbeBt4h83yjk?=
 =?us-ascii?Q?FJsowuUg4CO9wl2MkHlTpNF0L2HXtkt5VNReLdXYosNzDNk1edwPN4Qf98d4?=
 =?us-ascii?Q?DVKeEVy55Lsu8kExQabco99Jm3g1N6glR4BuL0zazmxiLhpQPmTS+SUKpErE?=
 =?us-ascii?Q?zWwQtjsq0XyzfqTYIENeJPLE6Uc077oqfmDMFfnxd0OhtHcTFJwuUSQ7K+lL?=
 =?us-ascii?Q?Cx+GnXfLR4LwlwmT5G8/vdUNUiwnBKrVD4zu+kvFxJgqZC3Z3zBgHNp+QCa0?=
 =?us-ascii?Q?w2RkAVFdvfZKXJ8ur5Y9/sKLlr/J0ioXaU7xjkX2unkaOzJaFfnj95dWkFhx?=
 =?us-ascii?Q?d3syxVuVKe92CBE3xGQaar/nohMHcux8DaBav84OmuX9Zo3NA2bFiTYgFhA7?=
 =?us-ascii?Q?VlaqcJkKRqaG9xEufK4TujhuuhWD44rmH+tsabAeWj5onx89aaDqf98AJEOV?=
 =?us-ascii?Q?rtbHirw/LpWk+jMceIZOdRr+uW7KR3WDGVidOdrEvcRj9ZrI3WjKLu2/YiGw?=
 =?us-ascii?Q?hkmZmrtzkSeqkYLNSNDk7vKD26DJIlJvrzk+kZbogg5KZCdkDvojh8h8p+Vu?=
 =?us-ascii?Q?pu6rH/YKxnITi53U/PJoMRabZpngAC6ah7BAn6OJ5oLZJSpGo3DlbgE/ONLS?=
 =?us-ascii?Q?bixECD+CzVcKopU/Ht7Ui0NlPGSgKpzLbCPxxFn0xeMphx26M7JBveOoTrSJ?=
 =?us-ascii?Q?AAcduPEtzfh0jeMkZjWqn2AgqPznw+wJh2pc+zV9IHIUx/hODMxkTMdDoW85?=
 =?us-ascii?Q?zo8jca37s7x2KKUjcAytS4l5KUOxfpUN183WH/wOYgPtn044wXmaRYJ21bSp?=
 =?us-ascii?Q?C9Uh1l3mHNcoq/OXTUH4WCTNvec8pwUmeIn1buOfNSCqXnM9YL1WdGwVZ32o?=
 =?us-ascii?Q?cvVIiThqjaObEInFynks1Xm/rii36bviu9CCUvgCasAaf35mx4Vu1d8+sqiJ?=
 =?us-ascii?Q?/RmBjmb79ANHmuvfU4bjQ+qHoSuRHncKN7oOJl9Y0wZhkJvA+fSVUfx1UOJZ?=
 =?us-ascii?Q?nHJ2tAoV5Yia5a5OQ6fZReLp2/h3dk732zgZD+bxv10kk1ZaYFDqyfk5oJcM?=
 =?us-ascii?Q?ZnH4JWcTxczulkya1BTVWz4gqyWFoXh1GXf3wstf8OD195Tw8i0472wq3KiW?=
 =?us-ascii?Q?aVjOPeFwm66LIsKiAjs3qnMTIU3xOXA9pyJWGJoH/u11MuidiRbU9RXSGVM9?=
 =?us-ascii?Q?xZnGfeJeEo4r4lqfgm9UCzGwS9QeZLtI8SxoKtyaknGhoPSl6OplSm/ilb+V?=
 =?us-ascii?Q?6CMw1YJajHzOvxF27cpvhGj9S31FOOARV9w1Z+5gKarcWbhORMZeQiT4ZLrh?=
 =?us-ascii?Q?VZpUXdIz9CNuTDddFjo/PesG9EcjufsQxqD4a4eSfbiAWm0srj4ZrsIrLtKk?=
 =?us-ascii?Q?iJemVuwqHr6ampF8AUyL5KH2/86OqoLW7lNkpUJdathqfNTJ6arMefo1ObjR?=
 =?us-ascii?Q?wqMeAUstN+7uVEEpev4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 00:41:29.7146
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a8f4169-2caa-474a-d31f-08de23168d34
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8485

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

