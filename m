Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B77F23FC62;
	Fri,  7 Feb 2025 15:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738942742; cv=fail; b=DE1fNc3/KK4pV1HHwoMIbAe2o4R0NuQMJIFAdrGcBM07ibBAhSwboWCcBPFAldlUqgCir7oNYCCUBy9Pl36QClf8Zsab4vaXm/clej0vEbFKLmPgd+2+3INa9nxdPXEvB8TmkkVmW2a9q/GcqUxs9GbgrjOrAaU4aRa/wSYKTEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738942742; c=relaxed/simple;
	bh=9v/uHkt1qRYU6VvAtjJiumv2HXWTbRZr9Re1pqZAu48=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WrOCJzrYS9feoq7q8ytcp2dOV/J0csk80zsDv9eu36UvIZvtzItWeZRHNIo3fY4DNKUVEHktMNfxR6KPaw2TawDdga9jf6VvrG0ztUxFFnLbYI4e/roU5H/9ct3qRGEitj3V1s0KfwklosFofw7ubmsc+6diTV4osiXYnS2AFl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IE0RQi7R; arc=fail smtp.client-ip=40.107.220.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IE0RQi7R"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lA0kADUnh1SbOnmtE1TyakGmw19eRQHzBHDs7p/M0DsUOm3PxPg78Uc3P467aF6UsgpCvcmDGAt1iaVPq1WMsRzrJD2UNlT3+I36iO45OAuJw720UCrXC9x+qGswSTMloMAJxFcgjSURSWSxvxehk5RNjl5mFVdb+80D7IbCEp3Yzi42lGVVqCTsFto5N2f91AU0N/8s6QNGVl+XIyfMr1s95Are/MG0nXETogtZzihqfkHia1mQyeY0pBqeW+CuwZ/UV5ouJzDhm1vS7xWwourVGCLI5poaBGpsPt5wJUpq+kxIkeaBzI2nBUn2/hWy/y5V/LqvwTRXg97FwLZQpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L9biBB2RlhZj+nbVvOaCrhaG6L0atiD1fkCU1ny30fk=;
 b=jWOt9pZOk7xPeWW/8F/fZvj4kflcMq8olp+bfp/JL5n9wpF9aMrbawVYftYhgIdwFq464lmymJm9NyK/wzddwdVIhAbqXXvD67opQ4aITEY7MdmgydnO0lKjGgkzywQg3sMelEr9oWl+cvBvfiNxpDopWke6UKfk7CLBMHH/9396O5PpN2z+eqwi77qrtU3x8G6QIdbwC+DzHoOcWlUKTR9AB3jCG4FTxcoABckp7HrQOrjmzOqYYrEj2BiM5kbpCtyEhqnmLpCz+l9RDOoZSDDpglpv83rxbKNuChbxSQo6v73FyniVMipgrsa8jOkmUHGMqlhunu+xJD8ERGq/yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L9biBB2RlhZj+nbVvOaCrhaG6L0atiD1fkCU1ny30fk=;
 b=IE0RQi7Rh4O58JFbJNcv6t0RKy2EvnhCE+clRzyqKAhrkFEZyX2mj4A0nWKgIw3jGEqJgjDHJgZve8rN+9hBLoy2nlyLvi4vU3mYuxdtCz7F/6FRfb1wfCvrGjO/bSGh1nXt9AK9/KenaAYog82/eGczW9qmmqactZBIDvFu9g4=
Received: from MW4P223CA0009.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::14)
 by BL1PR12MB5873.namprd12.prod.outlook.com (2603:10b6:208:395::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Fri, 7 Feb
 2025 15:38:54 +0000
Received: from MWH0EPF000971E7.namprd02.prod.outlook.com
 (2603:10b6:303:80:cafe::11) by MW4P223CA0009.outlook.office365.com
 (2603:10b6:303:80::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.25 via Frontend Transport; Fri,
 7 Feb 2025 15:38:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E7.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 7 Feb 2025 15:38:52 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Feb
 2025 09:38:49 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v2 10/18] cxl/region: Factor out code to find a root decoder's region
Date: Fri, 7 Feb 2025 16:37:45 +0100
Message-ID: <20250207153753.418849-11-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250207153753.418849-1-rrichter@amd.com>
References: <20250207153753.418849-1-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E7:EE_|BL1PR12MB5873:EE_
X-MS-Office365-Filtering-Correlation-Id: 60e0174d-707e-4e16-68f6-08dd478d8697
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eUbltNGXok5iQdHMe10uQraW0Py+wvkXMx2cqjkDQ4qo/S4Si/2ZaSxLez6W?=
 =?us-ascii?Q?xnuoYqHmj0f+zSSVSuyt3rA/wuNtiFA8aJJ8VylBQRQR3DYCysomFPKmgAAU?=
 =?us-ascii?Q?ApUhEZXFVyglapkE9S1WpRLVI5/plChMa6tuFCHyWGg5UL9Qm835D3TZzEyB?=
 =?us-ascii?Q?AwfYtRLxG4Ri8wyy6pGepuCxIrwckhsK7CwhWMPU1ctdNEHEt0HdTCJY5SQR?=
 =?us-ascii?Q?U9YIs+N8Usi36ZfyJzEDTpP8BGp1bXD/7nXQl3kU9Cm2TAsGJykycTVktNyR?=
 =?us-ascii?Q?Zr+9kJrU7xAe3QtMoLbyb8OkSZ4nWyjDIHaeD//PiHgop8gAzpLfO6RYAN0H?=
 =?us-ascii?Q?IXMDiWGTwEXRg0G6c0dcwFZbovjpyycrsAl17dRWiWlLnvi0iibVYpVI6XHs?=
 =?us-ascii?Q?DlyEWHxhTGrTTZ/mineu13pCG8knlcSYYQspkZRnfpgKdlx5Et4oBFxIVWmS?=
 =?us-ascii?Q?9T6/fCvPBDvO77kFTc/MYc3soPWFjsPi97mNJdyL8u3fRJrqge0NBbB7kx9p?=
 =?us-ascii?Q?8xd+ES8RDKyJ81on49nytm6VzC3WlyyX8JKxLsRu/c9E72vHgu4TG6EYvCh+?=
 =?us-ascii?Q?jjseJxYrMO/witpLTHuSY59553zqqOGaLLTJXWRIqC6qglX9CQa+f3Lck6IF?=
 =?us-ascii?Q?pHMfGkTwatmHHE1KJXTsNbqj7Emg7hQmQj3JCwRgKIYzC23GqCQzxG0ROTVI?=
 =?us-ascii?Q?T4dsjoHpT8xEEsMjSa1fUTkEcphhHF1pBwnr+eX/62LMcB4DsurnHiPcU2wj?=
 =?us-ascii?Q?/LOmMzybLTkyQmwRByS/ipZWpBiu6nVOQMaUOAZsrbpYRT9iw+iCTsbWD9/A?=
 =?us-ascii?Q?/tG0udjTT4BdbP3VEFm0GuVBELwrs8g3O2Ecz85LXDxXn7kwrYu8RhoaHm1H?=
 =?us-ascii?Q?Z0paezZUv/Mmt+y5MJDT2rGF8c4I0J/+KfTRTRIHqQ0BMUunDpjsUWH8mAOT?=
 =?us-ascii?Q?oKd/TtIqyX3qiphRkInefND6EEgtuAGetfUdg1L88PdPArrGzcmr8Qcn2I+h?=
 =?us-ascii?Q?9mZjMw/s4QQ/lAU2aPR6YAcKTMhptU0BqoAvtroY8MaLDhFmWM5uBeFkesbY?=
 =?us-ascii?Q?3jQtC/r3hhxZq/fbYGZcXXq99BRzvU0HXQP1Iyuxw2x8sbuQ+tsRbx2pnu3F?=
 =?us-ascii?Q?FZdKXR5r3Z3PMC38q0x+QBP/N68Ai9I68E7wmTLba8Fi1yQ4aejeqSWXwbXn?=
 =?us-ascii?Q?JgIWEcm6xMn3h3l0uBSLnFbO98D/fLAhEDpkxfxzK3za554ZjovTbEPHtz1R?=
 =?us-ascii?Q?YMgS4FPJ+Kx8FLXXOrpz9ODq7mVz0CXX9ZpHa08Pw/3xCKnHotjSV73qBLk/?=
 =?us-ascii?Q?VQHZVoDtxA7nTNJtMvXwjBQOcWzX+uG0lIZg3bkQA/DcqWs4faChTq9wc0t+?=
 =?us-ascii?Q?FWonJJhjgVYpKf61UVRKEiJVlDUhobSl05DzXbLpGRODDz/Ox8iUb06ETcc3?=
 =?us-ascii?Q?MNih9BEh1yGGHg8xlC2XDabqeHRcB4EX1zA6QXNP54DK5QxGHAf7KAI4uygD?=
 =?us-ascii?Q?zp/nrgDlxrpPSys=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 15:38:52.8946
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60e0174d-707e-4e16-68f6-08dd478d8697
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5873

In function cxl_add_to_region() there is code to determine a root
decoder's region. Factor that code out. This is in preparation to
further rework and simplify function cxl_add_to_region().

No functional changes.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index c641c8922455..9ce0282c0042 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3256,6 +3256,19 @@ static int match_region_by_range(struct device *dev, const void *data)
 	return rc;
 }
 
+static struct cxl_region *
+cxl_find_region_by_range(struct cxl_root_decoder *cxlrd, struct range *hpa)
+{
+	struct device *region_dev;
+
+	region_dev = device_find_child(&cxlrd->cxlsd.cxld.dev, hpa,
+				       match_region_by_range);
+	if (!region_dev)
+		return NULL;
+
+	return to_cxl_region(region_dev);
+}
+
 /* Establish an empty region covering the given HPA range */
 static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 					   struct cxl_endpoint_decoder *cxled)
@@ -3347,7 +3360,6 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
 {
 	struct range *hpa = &cxled->cxld.hpa_range;
-	struct device *region_dev;
 	struct cxl_root_decoder *cxlrd;
 	struct cxl_region_params *p;
 	struct cxl_region *cxlr;
@@ -3363,13 +3375,9 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
 	 * one does the construction and the others add to that.
 	 */
 	mutex_lock(&cxlrd->range_lock);
-	region_dev = device_find_child(&cxlrd->cxlsd.cxld.dev, hpa,
-				       match_region_by_range);
-	if (!region_dev) {
+	cxlr = cxl_find_region_by_range(cxlrd, hpa);
+	if (!cxlr)
 		cxlr = construct_region(cxlrd, cxled);
-		region_dev = &cxlr->dev;
-	} else
-		cxlr = to_cxl_region(region_dev);
 	mutex_unlock(&cxlrd->range_lock);
 
 	rc = PTR_ERR_OR_ZERO(cxlr);
@@ -3394,7 +3402,7 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
 				p->res);
 	}
 
-	put_device(region_dev);
+	put_device(&cxlr->dev);			/* cxl_find_region_by_range() */
 
 	return rc;
 }
-- 
2.39.5

