Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E9D2E1747;
	Tue, 15 Jul 2025 19:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752606782; cv=fail; b=igwqSvOLgCmYjHmWcGHn/vpDvlwZBWc+wozZJjgnu5n65KkN7heSMmFD49kq0u+pUY9Tn4Bz+B3893K9YDBGjSc/whhpxfs6DasI/M5QcjimpqBBsxsuF/0eD9eDDW/X0ekrDWJSHAofUpO9Ee/9fUdLtWcfS7S6Im/9bRWmlNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752606782; c=relaxed/simple;
	bh=n3OZhbsnicJk1jnXtMDi8sksHVoeIA+q8w3TY5o/v3Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QBZpGfpURbHNNc/fzV0SRsuQt8CzVtDvv4td1sSg7be5nwZ2VdDMNXLh13963FU1no7p+f8m5ekAp9MLxTTjaqyN5WdYixKfX/lSD/y6Ci+33spSV8s8xlzhNYE2XNji4vOmyWZ1c+D9sjMEGcVeXDIjs3LO+FKryIEoYdVq7VQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3LEFotU3; arc=fail smtp.client-ip=40.107.243.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3LEFotU3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HSNfzv7W0M1OOH+8ZUFE25+3NL6WDVWeeyvWoDzmlP/8isyhvn9DomJuDWUeD+H7XtAxQHQA4gOiQKKs806ND2mibOFnNxfnbCPNN6gopaksyozDg7+5obAgnqEbx0U4/1idSLNT63/rHLDUIlSAbmJ8fUMj7elAde305H4EE/goZ1G02JP8vruV+W0GLyZdQNrjGk4eww05K+lV6iT/ZKzZDPm4IlP8UsAfi0hY40LETNp6FVHL+3LP2jPJBxJL0mH/tea6tskmdUpapHeHMEDZ9xQ8AwcaUDzaTccNehBASWcb3apIdh93apR1zvttraKzDUbhVggXDS2Xr5RGcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jiv//rQwga+RHZSWBbBVbi+NCZb1ljietdHmK5Psmoc=;
 b=rkvaQoZs36NUeP2tPR5A5VUbk5AR94ZAVJG52rQu5lAfy2JhwZxVEiTreyu5u1pY+hunp4t7iEDQr+nnQhMiZrZVunYBqoGvs3cahfbp/WrFz0t/YiKN1iSPdNovXUh36g+E7qDp6d6jNfRk7l9Z1kdIfNBlMg9D8U6VraKNaG/V7WtGS7sC7AluZ+MRpmj2DlkTGlju/MDNenKm0RLxfr7CX0T0ij+4x/q0ravG+XbGGDaCXgCtor7WX506QSAtglLfwRyorrSLJgpRSbsAy6Pbw2BgEyCW6BhSnmQznCrQl0r+gcutm+68TrOkYXPgaTsQZAxOSDrJ1ZYx3wovoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jiv//rQwga+RHZSWBbBVbi+NCZb1ljietdHmK5Psmoc=;
 b=3LEFotU3ksaRFLIm/QTO+isO6U3NYeVqJOCiU3Tpgy2u5dWqtvUDPPIz4qnnhi8jHr3mHoKRtVvJGcwpf6RvJXzYTCMqtNczSTHlUJiXNbhZhTzT/I+LOsPyFuP28tmAQgtngMOfB59r1p2iaWXwubdDY6+wLlmuzYS0lw7Qkng=
Received: from BN0PR03CA0007.namprd03.prod.outlook.com (2603:10b6:408:e6::12)
 by DS2PR12MB9824.namprd12.prod.outlook.com (2603:10b6:8:2be::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 19:12:54 +0000
Received: from MN1PEPF0000F0E0.namprd04.prod.outlook.com
 (2603:10b6:408:e6:cafe::4e) by BN0PR03CA0007.outlook.office365.com
 (2603:10b6:408:e6::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.17 via Frontend Transport; Tue,
 15 Jul 2025 19:12:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E0.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Tue, 15 Jul 2025 19:12:53 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Jul
 2025 14:12:50 -0500
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v1 11/20] cxl/region: Separate auto-generated region cration code path
Date: Tue, 15 Jul 2025 21:11:34 +0200
Message-ID: <20250715191143.1023512-12-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250715191143.1023512-1-rrichter@amd.com>
References: <20250715191143.1023512-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E0:EE_|DS2PR12MB9824:EE_
X-MS-Office365-Filtering-Correlation-Id: eee4f820-8498-4b93-ea02-08ddc3d39981
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/gnfO8tOIr2u7WcQFM1cQ91qENmZ7aQJTTPLgM2OAZWSA11YSoqSaQCUCZz9?=
 =?us-ascii?Q?eb4kYQh6uTsPsHUm81KvzTO7N2R+23pA2UQAclAmpVEwpwVIp/ZK0WIZkg0d?=
 =?us-ascii?Q?Q0Cc/MZKeNdJdFywzmCmoj0D220t8Em00PvVtmle6fHPBwq0fJHA8hP2gRnN?=
 =?us-ascii?Q?Gp0NgOa+dk0Xoa4ffAwz7vNqZ2bzMzK+jpYSiTq7gUuIqZ1A8JY0qcVqrzu2?=
 =?us-ascii?Q?X2hYws9snh2Wr+0Fqt8njrlArRiPeffg98s5TKkW8Yslc+r9/JFScW9/NexC?=
 =?us-ascii?Q?AC8sSeeTHImkdS9JMtySETIXySHLZFXCvXFTBGKyVzoNO3OLxa04j3fLxicW?=
 =?us-ascii?Q?Ub2z+4ikcnmnQ8qwwCk4lHUsL/vUqTWEt3rHNm7vvEAsQB5z/BAavgEIaMuR?=
 =?us-ascii?Q?2RLhifRHheHcMhhO7ZYeLLzojZGXHqH3PzpgYUzc0i2NqdGsRQDe45ahkDGJ?=
 =?us-ascii?Q?+x1LTKkHz0grQAG54tJlQfLyTq5NpYqctXR6ZdZLLJZojFv3dZoFCRJuKw/F?=
 =?us-ascii?Q?/rcLoftJsZa9cgt6EIJdvdfsfqvijtNZbn2l6ujibXtjKKMs6ljvHxi5U5tS?=
 =?us-ascii?Q?3MwqynftxxXNkqx4cJ8tgrKai3cpm5Q3kvgZT5Rl9neHmSbJBoaO3K6oFbhE?=
 =?us-ascii?Q?fBUIxbAQpqaOOMKpxdO7Ir51tBRuOHRHYq+T7oS/D7oFArR0+3oPheEYqjUT?=
 =?us-ascii?Q?ov2qCY7H/l3NFLavn9Db/EVpAh005j4PrN3RAio5Am1bLUvMmhmbA86rqH0T?=
 =?us-ascii?Q?76MpHqLYe/mP32me7LxpbLZPU+9IKRV+0woA9lHDidLHiFg6srfc0XGlc6CI?=
 =?us-ascii?Q?7kSerjz2n+cfznXZhF5AoIo2QcGTN/ZgkZ5h2TorNDUDbwgYsIDVdd6G+l4u?=
 =?us-ascii?Q?+iDbkvU5ElFqmTv6pAYvul1pveKo3cDhYAEp+tgqy/vHJsBlFjdHFKb6vclb?=
 =?us-ascii?Q?zFR/PaD3vjyZu+o6Blnda5iFtqRQDg5PC5+zgqAFzE0pBVfxBH7BjLGbQg9t?=
 =?us-ascii?Q?ge5ftM7qcR0M5yZ7DU/BC2xSCJag+lYEj1LgaieC8WeH2ihXCcFZaWbDhjcx?=
 =?us-ascii?Q?Tc6SaOIekTbdTutKbC0l5fnCGjou8lz+TLE9Lsg8eYBI+/PI/c1cCbqoBcVw?=
 =?us-ascii?Q?N/qTiNZPm4Wk2YCMQ/YvOifcmyxwy2PJ3M9BKAcLlOMGGSpqpLzh9HylXCQ6?=
 =?us-ascii?Q?nwIyVk7J9xOZ3vb3f6pBKbxRAktfngoB55nF+weDYh5j6b5OTs0ZR9m/mcmk?=
 =?us-ascii?Q?/clngW+cL8aa4s8rdF54tZrP0HbUesq6qijcs0oBFPkfhI85Yb2ONV1Oa/aM?=
 =?us-ascii?Q?20k6RzA44MLsKBShNOl+KjubHIqK4DvMHttnDIOGPRhCgwYKaEHgocPY8nN0?=
 =?us-ascii?Q?23P9bCROaKdzKWKAV4bykX6Xy1W3kP40a0//SBxM8eAYoG0NwBqHHIS3VgeM?=
 =?us-ascii?Q?6pG6XPuEIxui7tlkyA5mc6k6Pl7KXU9C93eP80gefV3M79iP17CSAxdlIW4i?=
 =?us-ascii?Q?gEJzDIhR2sfiDOVLUY0yN/yNIibg1vVigVkG?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 19:12:53.6991
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eee4f820-8498-4b93-ea02-08ddc3d39981
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9824

For further optimizations, separate auto-generated region cration code
path from the one used by sysfs. Introduce the new function
create_region() that is used to auto-create a region.
__create_region() will be used as a sysfs helper function. The
separation helps to simplify both code paths as implementation
of both largely diverged already.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index edd1cd9ef022..ba59fa726cf3 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2609,15 +2609,6 @@ static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
 {
 	struct cxl_region *cxlr;
 
-	switch (mode) {
-	case CXL_PARTMODE_RAM:
-	case CXL_PARTMODE_PMEM:
-		break;
-	default:
-		dev_err(&cxlrd->cxlsd.cxld.dev, "unsupported mode %d\n", mode);
-		return ERR_PTR(-EINVAL);
-	}
-
 	cxlr = cxl_region_alloc(cxlrd);
 	if (IS_ERR(cxlr))
 		return cxlr;
@@ -3356,6 +3347,30 @@ static int cxl_extended_linear_cache_resize(struct cxl_region *cxlr,
 	return 0;
 }
 
+static struct cxl_region *create_region(struct cxl_root_decoder *cxlrd,
+					enum cxl_partition_mode mode, int id)
+{
+	struct cxl_region *cxlr;
+
+	switch (mode) {
+	case CXL_PARTMODE_RAM:
+	case CXL_PARTMODE_PMEM:
+		break;
+	default:
+		dev_err(&cxlrd->cxlsd.cxld.dev, "unsupported mode %d\n", mode);
+		return ERR_PTR(-EINVAL);
+	}
+
+	cxlr = cxl_region_alloc(cxlrd);
+	if (IS_ERR(cxlr))
+		return cxlr;
+
+	cxlr->mode = mode;
+	cxlr->type = CXL_DECODER_HOSTONLYMEM;
+
+	return devm_cxl_add_region(cxlr, id);
+}
+
 /* Establish an empty region covering the given HPA range */
 static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 					   struct cxl_endpoint_decoder *cxled)
@@ -3369,7 +3384,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 	int rc;
 
 	struct cxl_region *cxlr __free(early_region_unregister) =
-		__create_region(cxlrd, cxlds->part[part].mode, -1);
+		create_region(cxlrd, cxlds->part[part].mode, -1);
 
 	if (IS_ERR(cxlr)) {
 		dev_err(cxlmd->dev.parent,
-- 
2.39.5

