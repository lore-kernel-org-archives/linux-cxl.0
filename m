Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010024.outbound.protection.outlook.com [52.101.46.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AD5322C81;
	Mon,  3 Nov 2025 18:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762195769; cv=fail; b=j1loqZBY2cX51JkcliV/gd6GTWCgFupkKMJXp+0DZUCbeDdx9/y6+vyOeXLTcaf9IiID3N9FXH8D3JkXmzSnNwMD+7ybg0T8Kw8d3/gpXpgE+ky6TkcNb6VyJTHiWZwQTeu6XzIgTw01G2Hf68mXpHPBfajw+3qsP0eUffnCmTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762195769; c=relaxed/simple;
	bh=qZcTjeUqxw7Q7nQADck0RFg58dKGnLXrfkb74e8cl9A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N2sqwi6bw2uyqpDDKhhhdZ7R/g/grKhkB789KymU+f9hlzMSrtM5cDw+e4lB7HC+iluylJf6Q654JIfJrU52OmxTL2jbE7aI+3YglAJh/bJ41HM8ZNA4yHkMYqxbUbOX9Gmt01f/onJGvsxihAZ9IZWpT1l70Ldvynbyit6H5TA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LXUdAtQs; arc=fail smtp.client-ip=52.101.46.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LXUdAtQs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jIjZbn0fFA/lPw7MzCjSY2nj+ZZpsetWADXJJmpDMKAx1FaMKkajgv1Vk5jjWoEh3O3MwhhRv0VC0xvosIvWlDREuDPc2bGMfDVyeGOBgBi4ZaKep/3zLKogjrFCGf/igTis2/H3Ij4l4QgtXQOAxCEkmBjnE/Pc8od8l0LdCIXj0leQ6MZeyin7p7eZbX1fuVYPjdizKVL5UjCUN9vMxPg5vXbSHOs+2P6mg0YINt0OAU8Ii7w3+EOvwqQibyDpFxCIgk0MTOOnr3JRSJ9J42+VynGap6YufVy/Xj9GHymo+TPN+dmnOCGoBVn/0N3p71nOSaXTzcmTXdoxtlnQNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tJk6PRhlCM/v7QYZLUEzYncbgRDTKRNUV3/M4GSZIMM=;
 b=MZn6NEZ61GWI90X5Wdz1YhhWTCNFWb+2+l1Nxvz0jPpPpzn8Vr89JTTVwBtVU4Xdpp33mUbaR+MtVhYwGiUrsktzPnBXSsrukTqoG5/e385NeAJ88RUDeX0KFnjCVzYZC9Q/xuHFOye3syuXKC1wto2rGUTHtN32fIuy2Js2/cntLNWAS+D3WXRQsGCcTU7OApY3q1npA7cTfmswl95LSneTjNaHi8kRiBen7UUHYQiZ7ZzYXCUq5Lsu6kcdD9A9Y1ZSngnOrFz9lozr3sRED4teiSky5GA3LTM0TT3oD4rJSXA9B3F0rWs0gE53GI9Ws3QccTIMepWaegjH0ZX7lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tJk6PRhlCM/v7QYZLUEzYncbgRDTKRNUV3/M4GSZIMM=;
 b=LXUdAtQs9Z5gaR6MF8sZfCc7bWAAJ52w5c2s1aDHvKSmxd4uXcEbP/3XlX/sQ2DOMGZ5DYVtfz8001wbdeWOU3Ti9LQVdlUGGQjsgDUPpnJUSKtfSd1EYmyZtgP54/ErGHmDe/Y2NgiQdowOuI7YDgOrdcbKjz24vSPIOyfLF1o=
Received: from BLAPR03CA0131.namprd03.prod.outlook.com (2603:10b6:208:32e::16)
 by LV2PR12MB5822.namprd12.prod.outlook.com (2603:10b6:408:179::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Mon, 3 Nov
 2025 18:49:22 +0000
Received: from BL6PEPF00022571.namprd02.prod.outlook.com
 (2603:10b6:208:32e:cafe::55) by BLAPR03CA0131.outlook.office365.com
 (2603:10b6:208:32e::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Mon,
 3 Nov 2025 18:49:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022571.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Mon, 3 Nov 2025 18:49:22 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 3 Nov
 2025 10:49:17 -0800
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v4 08/14] cxl: Introduce callback for HPA address ranges translation
Date: Mon, 3 Nov 2025 19:47:49 +0100
Message-ID: <20251103184804.509762-9-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251103184804.509762-1-rrichter@amd.com>
References: <20251103184804.509762-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022571:EE_|LV2PR12MB5822:EE_
X-MS-Office365-Filtering-Correlation-Id: 5874a314-85ba-4bcc-e8ab-08de1b09b46b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HouKheyGl+eCQt//cb48ucwBRFbqPzAp6HkxawCeSKWWfPpcN389bzFp1vas?=
 =?us-ascii?Q?DnXjXsZ68+jGrg32ha4l17ki7mBJ0t8RydNQAA0wxddnntCY583RHuNg/+GA?=
 =?us-ascii?Q?jNQ4WtTQG3gkuPI5+JkCZrzddu69NEqkPHvri75iwru6K8c4uYzrDV/35yF6?=
 =?us-ascii?Q?wmxnA3wQ8jrQ9cHEvi6GAZmtIpHhjt6ityt11V2088jJrJkjlfUtyvSHEUWi?=
 =?us-ascii?Q?V9MRKx/pQeTKsbIq6ihHZgfuc0qWxHdYbjr178pK2ipKuV0wfb4m2ipTFKW8?=
 =?us-ascii?Q?5wjffKvkx4PbuaDjsJa/1NdhZIUEx5+TUqGZqQOqp+jXqoKh3ST88wNWyKx1?=
 =?us-ascii?Q?S/3pk0Dk/Mxx1wxRU5yALl3rkdOC5zCwovA1mCc86nEHpD5zQwLTkzm3akMm?=
 =?us-ascii?Q?MqLjN8IlXaZNDJdivWQzxorkJ1SaKPxW6/NGe9/K1rKLOYt2xg9JPXVahzDY?=
 =?us-ascii?Q?tMs9F2q3rH++1cHFB+77xcx3/lF0O6it98BHdjX6HyfPsi+LnvnjC/0CjXQk?=
 =?us-ascii?Q?fWP2UR6ZouFu4b5QOEt0acWChHmVJg8jCDzwm6UKHaEjFvKIFVm8q7oWEqWd?=
 =?us-ascii?Q?KbhJ228PRCHMInXg1OnSUyVQftoSuaTnYMOXqQJtf1q0hPIajnCwER150TFD?=
 =?us-ascii?Q?MTLq6y3FGmME3yX/Q7THygFtFdi1WHZuSHHjayd2cznpzNdcmELvYnIhk3y1?=
 =?us-ascii?Q?XNQ1C9Gcu+w3x62vR+zQlwARKBzS0WT0yumK7X+MJPaxRD8fCrh+/u4AFPp8?=
 =?us-ascii?Q?A+aecxE8NAQ1Bffq5/0tsJhoIaIJZR7uak5H9OYWTi4BequupqaxC6wl20nz?=
 =?us-ascii?Q?ILqrJ7DS6snI3HTkcWaXTXJipGJkGMEJee3GUrSkLt00imxxZ+0tiIGEry2W?=
 =?us-ascii?Q?WqhLGMSoJHABhB/j2RHWWa2u1/My49lVxAShy3Rds6SUB1oqPrA646kjdIp2?=
 =?us-ascii?Q?o6DnHIG7U8JFrzj/D9hfHi2NWGSYOKYswnuU/TRzyC+03ggK+PszayLtWfNp?=
 =?us-ascii?Q?0sxEECeViKUM+Xn+yKR4z0RkLcfikdR1s7X2ASNE1MTBlDyv9aINcjdw3OL4?=
 =?us-ascii?Q?jRkOtaZY3e9C24EQ4zwezmYezdBtM5O6T3DnPTmcVdNWhd36h/9ADTgybw91?=
 =?us-ascii?Q?XR1SAg85rA9RSLwivY1jnFX4mpLfbDejSnKbqhWxImNSZr3vVFPvVvbKyRyM?=
 =?us-ascii?Q?eiSMoaa3Xu7HLSkIZYwbiZ6l151tPfpFwO5wSBGqqga9JCQynrsbllcyukU7?=
 =?us-ascii?Q?CxYIzHQNcUYzg1YDymzNuAsKIVtUp31swX59yRbho1gJFp0pw+nDOphfNLKA?=
 =?us-ascii?Q?jsOd1KvK7JHkrOnXuUQ35s5lt0OsK/UmL0HtXz1TKoRlHAYHdaeJVVmRdhVP?=
 =?us-ascii?Q?BCZXrwvjFRNBU7lRT6U+chvU1XHXqFHgk6BEQR1FGj9zxDH1jd2eHtDU0B2g?=
 =?us-ascii?Q?i/xbSbyCyCKTbqcsv1KDJFiBIIOLawSLW3Q+dyWkUMrwimUlrpqGetJL1DTY?=
 =?us-ascii?Q?izvodFvocff7ZJ8Cn5cJdJzbn+rd6Li7VsVogy4nP2LJmtXQJkYLgbC0BOxj?=
 =?us-ascii?Q?Nt0LLRdxhfcuezoiRio=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 18:49:22.8385
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5874a314-85ba-4bcc-e8ab-08de1b09b46b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022571.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5822

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

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 19 +++++++++++++++++++
 drivers/cxl/cxl.h         |  1 +
 2 files changed, 20 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 2dd9e9be4889..379a67cc8e31 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3364,6 +3364,15 @@ static int match_root_decoder(struct device *dev, const void *data)
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
 static struct cxl_root_decoder *
 get_cxl_root_decoder(struct cxl_endpoint_decoder *cxled,
 		     struct cxl_region_context *ctx)
@@ -3371,6 +3380,16 @@ get_cxl_root_decoder(struct cxl_endpoint_decoder *cxled,
 	struct cxl_port *port = cxled_to_port(cxled);
 	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
 	struct device *cxlrd_dev;
+	int rc;
+
+	rc = translate_hpa_range(cxl_root, ctx);
+	if (rc) {
+		dev_err(port->uport_dev,
+			"%s:%s Failed to translate address range %#llx:%#llx\n",
+			dev_name(&ctx->cxlmd->dev), dev_name(&cxled->cxld.dev),
+			ctx->hpa_range.start, ctx->hpa_range.end);
+		return ERR_PTR(rc);
+	}
 
 	cxlrd_dev = device_find_child(&cxl_root->port.dev, &ctx->hpa_range,
 				      match_root_decoder);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 9a381c827416..94b9fcc07469 100644
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

