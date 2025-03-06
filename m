Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2049.outbound.protection.outlook.com [40.107.95.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A082566D1;
	Thu,  6 Mar 2025 16:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741279530; cv=fail; b=ekBdQ5xsRnSZ2PjK21rnCJ7JPVnbbZq038R3qEU5ZWVc0+kmBlvOewIzWVlT9tQJwbCvKIHZKh4C2rBjwEsfMpfrz+L8+JYnRaEfjuHPB1Z5Idwp7SPOACaMD0thCJdc+vh7tIl9TB5YV7Xsxyb2i4CgAHGtCl6Xnx+aMKoddNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741279530; c=relaxed/simple;
	bh=yPAvdw7vpgqEcZ5k+4DmXsbki/46NzusNY1k104yARQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DRDdSJ9V7Uzhe0QrCGA+eIjgeO3kfhib7Wn3PN1WjFJ9NfUhsmQKlagOqQU0gJxsuH0Ilb112qdgcmVIkTWyiTqNGLlJFvpji+c6T9umo5TA2NLSm7ZSxhkON+/7/QXtV0fhsxJwwv4Z/G9cWg0z9bVy0h+maS0cUKyKWd+1nEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=USAZV7lb; arc=fail smtp.client-ip=40.107.95.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="USAZV7lb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L2xCFU+4jIQAHlZjc7k9hbq5pIm6N+7Kvo+Z+VtihAI2K03RgJTRu41oCNIrMUAnOYvhyhakVWcw4WNTri9B8uPN9x51gfyPLKfvLh7t3yzyG7KXI00Br7dNHLAYSBvlWvJjz6dpEdxkakoD1QF3XihgNSLmf5ETUY750YnaChBdI/2vc1BshxKc7meQNbnEdB27UvFf/JncQE9iSjAaV4NI+htO0M3T+RoE+WpABSrYe2qfvurVfcXw8MjGHf9YSNsFBUZ6ax2TmywqDTFeqhS0A6mDgwBqotEHE2CY2l14QDJmHRu0+bTAGPYrtvJ1EwnjqzKk0/kycdiMe+QMKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eOvm1vhCRGbnCqwTCXhmgTud/0u3W3npvVgXr2xf2/k=;
 b=iHttgcgaiY/H16P/wGpuju6QKylXXENNqnFgKVPNOjPytZHqwkFGajcpJB6jStFy1JYBs537Nq+LIokTh03sZVIuvJ5aFS4cAq889rDTAdAQ0Ac8dQjoyEPUgFO4gd7D6EeWyJZDDmycpnZryAlCwhP3dQEjPNwA7uiepncSTyE2eHCxnAMrcXcK47SF9ZvcKvSLdkEulKVXum223aPQuCvugpHsIT8HyeLdrarGY6Yg+2XmHxoBO/E0gCrAzInayMZrdGw7nk/gSMHjGjZHfaLrA/KNwj+bFqQlm8axCtRApqjc7LhhNWAspvRzAlOKoAE1ObpQvG4W8BLtIac7rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eOvm1vhCRGbnCqwTCXhmgTud/0u3W3npvVgXr2xf2/k=;
 b=USAZV7lb7JmsZUAFmfQ5ABKRX+naOksokaohd1vUgzZ7k1GxGJ78UHKetp6i9x+0lZU7qNjwqEn/PvA5MX6IgF3V1p3hD/HlcLM323u4eLtmeL1C92KcCkuirGMQ+cBD6KZCGM1IqaQ9GkMQih9dK7TK5DZD0rgE1jPEvW/DRf8=
Received: from MW4PR04CA0102.namprd04.prod.outlook.com (2603:10b6:303:83::17)
 by SN7PR12MB8060.namprd12.prod.outlook.com (2603:10b6:806:343::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 16:45:25 +0000
Received: from SJ1PEPF00001CE6.namprd03.prod.outlook.com
 (2603:10b6:303:83:cafe::2b) by MW4PR04CA0102.outlook.office365.com
 (2603:10b6:303:83::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.17 via Frontend Transport; Thu,
 6 Mar 2025 16:45:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE6.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Thu, 6 Mar 2025 16:45:25 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Mar
 2025 10:45:22 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v4 05/14] cxl/region: Rename function to cxl_find_decoder_early()
Date: Thu, 6 Mar 2025 17:44:39 +0100
Message-ID: <20250306164448.3354845-6-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250306164448.3354845-1-rrichter@amd.com>
References: <20250306164448.3354845-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE6:EE_|SN7PR12MB8060:EE_
X-MS-Office365-Filtering-Correlation-Id: 80a3d887-caa8-4f91-5c76-08dd5cce4b47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u8u+Y73V/VEtHM6WwzkJXeUXl6OioF5kHJ1GBFFsEvFuNmQktBvxleEHrjzV?=
 =?us-ascii?Q?zklZU/Plk5DYaoxY3fes9VQlfrXzLH4W52O/fgGD9utY0aM6TCOFG181pFqz?=
 =?us-ascii?Q?zxqQ2COl3efxLI9yM9CcEsUSbtSIpZ0gvvtgnb1rJhe+zmeFr5lLWSKpZxNs?=
 =?us-ascii?Q?9wv05OXTb+R2bVCvpji3jAbYz529Pe9lyotRwcj/6kZJAbdtm0CnUF36qu55?=
 =?us-ascii?Q?ZvgMDi3Kr8LSQItmOwmTPF5OnFCxprVXXWcvuE4JQBJR+E16O7NOjHOvxzuO?=
 =?us-ascii?Q?GUZ6ZaUnxqmUlIuYmIHHZJqzIZh1q6bnwimrtBSFdAl7Kmblpb5oRD6gADT8?=
 =?us-ascii?Q?g8dM1RTzLfUGTI1eKqJGa+Hmp2RHTkk7/h7T/NT93FK4H2CPFsSnEkkCb3As?=
 =?us-ascii?Q?AOvy9r2+yh5xp2aR419vF+yIePjFhxCbeAqDyPRhSN2XCjSxJdknyc80rNXu?=
 =?us-ascii?Q?Qg248oDKsYMI5OTGNBEsk0qZYfd4OfRMlIioWns4Gk+7vsM/HuHDYTRw99ye?=
 =?us-ascii?Q?alEdgZIjZGlmULAVG9kSfjT7heNDI/U2kKAFJPJpQPRgJfUw3NUfa8imPw3N?=
 =?us-ascii?Q?DEdnlgry60y49+jszgNmHUYguoZYeHX0mmzdeISxEOlYwSVtNXqvhyqCSOGK?=
 =?us-ascii?Q?dBGeDF8L0OgfjgOp1zHY3bPw+C0fpyy4anVBjIUATFdVDRZ4FbiePSnxidyq?=
 =?us-ascii?Q?oBiN35p8w+B/LRSLNUwvXGwU80KQobG/XWz2juT3fuxoRXhe9n4SHLtBsjA7?=
 =?us-ascii?Q?oRFmHV49WBV0mnAiKd/2tWUerDgk/DqcCC7z0Jl0JLNaYO3m0NIsK7mSKyaI?=
 =?us-ascii?Q?MmfWazleVGIbnCkZrOdr4pMSjkDIKomXXDn+F3Ol/YZ0q0MzzPs4dG5uMOoJ?=
 =?us-ascii?Q?gXz7QoV2Ci9ejvrBiPv8fZ+vHTmJ76QyLQqVhvV1pg0pFcMCO3UuY9EvbP+u?=
 =?us-ascii?Q?UpPuNzuOfKjUQqfFd79QqYPXazej26XqjH+CYzvcwTZy4kCbHyLiZXPHG6GE?=
 =?us-ascii?Q?XZuDOsnUNxxhkQJ7wj00KKvfLzE2oDxoCPs5+Lg2+4bLywW2+1gxjhfXFCtK?=
 =?us-ascii?Q?d0lty+gBmXatxFx8IpN0IlHXjWe9qDm6QhGXubDqEeu2oy8QoBuT6zk0AXS1?=
 =?us-ascii?Q?reWNr1Otpn4zftz5Pk3fu+1vciW1AMxGiiILfEF5kNKuO7nlgOTPysemshfZ?=
 =?us-ascii?Q?MFMKdoc73hIHY/vqUxMsZ1wvYtwNySIKxyv4l2dweDjyNW7FAV7Xt79p1rvn?=
 =?us-ascii?Q?JTrPKmdD0SXH5yGuUwi2tYdkcMTe2c0IbPBRBB7ZH8e+I73TnKXoUGgAgsjQ?=
 =?us-ascii?Q?GiVoaIeHbtS6hjuRH77OXEpWfzfN9y42ia4j7PmU+TtTZIcRukE3ROqqVOcZ?=
 =?us-ascii?Q?x0YLNgxv8rdc7u+//iry1rkHOSy2AefA85o9wZqjzfz7G3FVxx33YTyGM7C1?=
 =?us-ascii?Q?DBZ0WuIb8DzO7+qALOTaDY2LVP6+Qffmavdz+5C+7GEAy9HCjtN88psCrmtN?=
 =?us-ascii?Q?O9iMrqTu/QDetwg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 16:45:25.0745
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80a3d887-caa8-4f91-5c76-08dd5cce4b47
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8060

Current function cxl_region_find_decoder() is used to find a port's
decoder during region setup. The decoder is later used to attach the
port to a region.

Rename function to cxl_find_decoder_early() to emphasize its use only
during region setup in the early pre-init setup stage when an endpoint
is not yet attached to a region (cxl_region_attach()). Once a port is
attached to a region, the region reference can be used to lookup a
region's port and decoder configuration (see struct cxl_region_ref).

Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Tested-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/region.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 4f79cc17c9c8..e40ae0fefddc 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -865,10 +865,18 @@ static int match_auto_decoder(struct device *dev, const void *data)
 	return 0;
 }
 
+/*
+ * Only use cxl_find_decoder_early() during region setup in the early
+ * pre-init setup stage when an endpoint is not yet attached to a
+ * region (cxl_region_attach()). Once a port is attached to a region,
+ * the region reference can be used to lookup a region's port and
+ * decoder configuration (see struct cxl_region_ref).
+*/
+
 static struct cxl_decoder *
-cxl_region_find_decoder(struct cxl_port *port,
-			struct cxl_endpoint_decoder *cxled,
-			struct cxl_region *cxlr)
+cxl_find_decoder_early(struct cxl_port *port,
+		       struct cxl_endpoint_decoder *cxled,
+		       struct cxl_region *cxlr)
 {
 	struct device *dev;
 
@@ -932,7 +940,7 @@ alloc_region_ref(struct cxl_port *port, struct cxl_region *cxlr,
 		if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
 			struct cxl_decoder *cxld;
 
-			cxld = cxl_region_find_decoder(port, cxled, cxlr);
+			cxld = cxl_find_decoder_early(port, cxled, cxlr);
 			if (auto_order_ok(port, iter->region, cxld))
 				continue;
 		}
@@ -1020,7 +1028,7 @@ static int cxl_rr_alloc_decoder(struct cxl_port *port, struct cxl_region *cxlr,
 {
 	struct cxl_decoder *cxld;
 
-	cxld = cxl_region_find_decoder(port, cxled, cxlr);
+	cxld = cxl_find_decoder_early(port, cxled, cxlr);
 	if (!cxld) {
 		dev_dbg(&cxlr->dev, "%s: no decoder available\n",
 			dev_name(&port->dev));
-- 
2.39.5

