Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8F323F29E;
	Fri,  7 Feb 2025 15:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738942727; cv=fail; b=W2sjCCpL8v0FMIemDOsAh45kIY1ZL3X0NDN5dwgbX5qz7Ws+wcMePhwVaz1Xa+ehMJRcX7AwsfDWYX6x5rFKaKXw5NXQ1pRQFDqje+hx406YQPCdiIyB4sSjUoVXRYvhMjstIEofs/vskLyMXeiwpQb2mX2ugzWClWHZ1NqFUUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738942727; c=relaxed/simple;
	bh=DvpPqMdP/uzpP4ovh+NgZA7kh7jcy2+A7rGDs7JdLIc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iSPEFz56Xy25KlgIjjRXFlRPs9CjGR0VzUyhX00iqU9DrTEgLUOmyPnTOhGLBQ2Bst5xW/5H45X5st0UxVASUrk1pJ7zY2tYjwq7jdC4X/8c/bGOtwSPNBQ6x7cuChVy0fXx7yviGLdSiLYMicx1umPpmwZ97JNtqKGfE8m1xIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HWCPjNm+; arc=fail smtp.client-ip=40.107.243.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HWCPjNm+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oPnnxR5nVWWzkYyWbc4DjHatIuvVBP66MZcrWgljYP26HJsTeL5+Xw9UDTQOhGKhhzavhjT+1BrAGog3vSOS3QqiK10VhnyRjr3cvtDVEet6G/UPKATG1dFvwD0cXfsBfFbl4vZVGtCiTGPxNXqeKMAOTSSfxbtXngsuxJOG46ffLtBsXFI2ZV+HjQj7dK881nZf4zC2r3s4/J7TS58ZMeILwo5CUmgnFjJKVPvL5R2C1U1J2vS0rWLwWDqsuymcdX4BcxmQMNfeD5nHh+wYoyUwZvQq70JWiL4db7ubTOe5wcRDoLUeL6jTDLeNh+posFQS0+okd74VYFgXbdgJoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VYLII2ySey8hCRtUf3QRFgc0322E/Ed1fRH0WKXNbpc=;
 b=OTb04mmev8+dnAzowl8onLns6zIAgbTPWFX0UYchRvNOwlUGQNTzubgF8XKKrt7aThClnXCkF5yMgIu/SSAsmMn26VrfqbBNihg39ZP03RcuIfZ6ny9W0UmjHVUQ9+u8YWVZ5EWXz+R5LFxZMjID0ZxZCg6+z07sW/9ig3+MwvRnKWyGLS0k9+3ptf0xS4pkCDY+YNWEAOebsrpF4FdOFw526ZmPkbKFrgmn6wwSFOyFGTyjpHsctWsqjDRTcXIerfnGJ9dwnUSIr04Ni6Xa8wymy1X9PSm6tT4ZPRYNmbJIUcRsob19/4midm5W6o3qvIx0rqhLjlrf6pHPUVvHeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VYLII2ySey8hCRtUf3QRFgc0322E/Ed1fRH0WKXNbpc=;
 b=HWCPjNm+SWoMkD67hNtLnlmNIFoAchQnCd/ai21l0xLmccs/dNFRscfh/8Zdew83uDbFObp+77jdo+jVN7lvGVWCAabkxIPHrE02Mnb84t8Q7MffJk0ZeuE9Ofnalu+uhH2apUJJPsBPU8yRh69lC2rZTPbSZ/LRR7kY+Z2H2t4=
Received: from MW4PR04CA0327.namprd04.prod.outlook.com (2603:10b6:303:82::32)
 by DM6PR12MB4140.namprd12.prod.outlook.com (2603:10b6:5:221::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.13; Fri, 7 Feb
 2025 15:38:42 +0000
Received: from MWH0EPF000971E3.namprd02.prod.outlook.com
 (2603:10b6:303:82:cafe::1e) by MW4PR04CA0327.outlook.office365.com
 (2603:10b6:303:82::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.30 via Frontend Transport; Fri,
 7 Feb 2025 15:38:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E3.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 7 Feb 2025 15:38:41 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Feb
 2025 09:38:38 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v2 07/18] cxl/region: Avoid duplicate call of cxl_find_decoder_early()
Date: Fri, 7 Feb 2025 16:37:42 +0100
Message-ID: <20250207153753.418849-8-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E3:EE_|DM6PR12MB4140:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e6dea12-0e37-4e19-84d0-08dd478d7ff3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jy62WihFBJUyNIJodwIYVq9c+cGktr7TvfSWkvahsTknpnaAEBIZc1neuPBs?=
 =?us-ascii?Q?YHHobiYgY6Hc5m9bJMO0Dmms8kBcjcxSHelE7QI9ipP+7wgHQfEVLRUP/ihN?=
 =?us-ascii?Q?VDJirnEMce7oHmY/vuZfwYC5uIKzt40vkrhb3gCXsRwn+XoznfKMnz0m0t+I?=
 =?us-ascii?Q?MDcYJ4PPkbwSn1SucwSeueU3pI+lMiZ1DkhW5MN+GLDTnN5OH5smrDa67CbM?=
 =?us-ascii?Q?6rAHpavV068cgKU6upYUJ+oSrCi14W/mPuPG8djHFHnmX7uNKSPUE88GCuES?=
 =?us-ascii?Q?5EPTRUiNURPvRhQxQDO2B6zrx0+cz/ToWH8V/bsluZbaUUDJZId/dBZzDrHZ?=
 =?us-ascii?Q?M20E0EwzZopNyNYZabgfpB4nhBYDgJrxl7heXhP8B3NHpcmjk8GbxAuubeH7?=
 =?us-ascii?Q?k3CBe6wW91M3FyDKJ+or32mSBiaJXBLuf5YfB9oBzDtx46VuQ7guxfLr9yk4?=
 =?us-ascii?Q?sG6qWEILeAmnm0sptiBspEiYNmWZN4z41Uhap4LRG3EJUQ5G7kRPw/pOl8TE?=
 =?us-ascii?Q?l22D8lqUC8XInwCzMHE+sLaAAohsUmHJ03dOCZZRSZ3iOk0pgZzxocphHq1C?=
 =?us-ascii?Q?y2whGOQwGQciZeZitOQdF/Pi2ZlK9O7XiYqIY6Cg+1WU56X39eVt1/b/xIDB?=
 =?us-ascii?Q?7pw8Ee2sf9Smup45NumFz0reqOjX75O4Vq14EsY7J+SEROhI5O1ifKF1CHnt?=
 =?us-ascii?Q?RkpxiUFemT8VmnsoWcGSYlvEHf/bQLuGgR/jRLE1MVN59t0/QYeQQlIA0Il/?=
 =?us-ascii?Q?NAUh8kcQmL0uuNerNrEqxsntgW9t5HniooNHpSzkK99FMmTDsrnJBw2vMmIo?=
 =?us-ascii?Q?+Hn/x6xVJbtg2Cg2R3H6GVFsEFmD9XZEn6Shgnc40lnmCOVO7Se2T+lhFHww?=
 =?us-ascii?Q?E7kOE31A2nNRXsCyIraW4Hh0sAJXuC42RWgfuBWyaUGipIdNONxHrMorIMd1?=
 =?us-ascii?Q?57oerTvbu0AGglYqueIJzGQfKrT+YecqanYLGycm+GE2mIvVy/nQBylzFDDK?=
 =?us-ascii?Q?j7wnSYPD0Ohq6dRZji3c+EzPQ5pcIIXiI6lFdlBEvHmsK+NY3dpHp8oocOmW?=
 =?us-ascii?Q?Chuxw2FIvrzI8oScjn+1YIv5G7ANM0xeDNKl9qwvu9HgSH3MJgs+QdHqU7I5?=
 =?us-ascii?Q?uduHg1fYHRFpnyN0qHOp8OIx6asyneh5Q5ty3XTY0q8tz0e0lIeR1fLwkRW3?=
 =?us-ascii?Q?YtX518VOzeFtapvufkmfEO7AH0B9fxpPA9xFzcVPl4ZqeEkKwMdIAWSPwaYm?=
 =?us-ascii?Q?LvMQ8yu6LfTnhPAtIuP1Ba0AJzkfnKmcgOPCj7FsbgfN3wtqlGnGxPJeqTlS?=
 =?us-ascii?Q?7KpPlQ2IAUVsTTSf+dRn7esDFmGBqIoBXKZHbwQm778CEXvX5kWFSdV3AzPq?=
 =?us-ascii?Q?Qdu2tEHkTz+9bQbVtBJ/U4dkw89TfkPuTmvqXhV1FAL+gcDkx6t3kTVAZwAV?=
 =?us-ascii?Q?B5kHPS2N2zPO2r2OQ2UUerVKoguU5/lFetw5tTlmKtDNWGeLOCMAJiW3nY8T?=
 =?us-ascii?Q?LvzvinPE6k3eiCI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 15:38:41.7542
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e6dea12-0e37-4e19-84d0-08dd478d7ff3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4140

Function cxl_find_decoder_early() is called twice, in
alloc_region_ref() and cxl_rr_alloc_decoder(). Move it out there and
instead pass the decoder as function argument to both.

Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/region.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 13e3ba984a53..b8201c2faa87 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -908,7 +908,8 @@ static bool auto_order_ok(struct cxl_port *port, struct cxl_region *cxlr_iter,
 
 static struct cxl_region_ref *
 alloc_region_ref(struct cxl_port *port, struct cxl_region *cxlr,
-		 struct cxl_endpoint_decoder *cxled)
+		 struct cxl_endpoint_decoder *cxled,
+		 struct cxl_decoder *cxld)
 {
 	struct cxl_region_params *p = &cxlr->params;
 	struct cxl_region_ref *cxl_rr, *iter;
@@ -922,9 +923,6 @@ alloc_region_ref(struct cxl_port *port, struct cxl_region *cxlr,
 			continue;
 
 		if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
-			struct cxl_decoder *cxld;
-
-			cxld = cxl_find_decoder_early(port, cxled, cxlr);
 			if (auto_order_ok(port, iter->region, cxld))
 				continue;
 		}
@@ -1008,17 +1006,9 @@ static int cxl_rr_ep_add(struct cxl_region_ref *cxl_rr,
 
 static int cxl_rr_alloc_decoder(struct cxl_port *port, struct cxl_region *cxlr,
 				struct cxl_endpoint_decoder *cxled,
-				struct cxl_region_ref *cxl_rr)
+				struct cxl_region_ref *cxl_rr,
+				struct cxl_decoder *cxld)
 {
-	struct cxl_decoder *cxld;
-
-	cxld = cxl_find_decoder_early(port, cxled, cxlr);
-	if (!cxld) {
-		dev_dbg(&cxlr->dev, "%s: no decoder available\n",
-			dev_name(&port->dev));
-		return -EBUSY;
-	}
-
 	if (cxld->region) {
 		dev_dbg(&cxlr->dev, "%s: %s already attached to %s\n",
 			dev_name(&port->dev), dev_name(&cxld->dev),
@@ -1109,7 +1099,16 @@ static int cxl_port_attach_region(struct cxl_port *port,
 			nr_targets_inc = true;
 		}
 	} else {
-		cxl_rr = alloc_region_ref(port, cxlr, cxled);
+		struct cxl_decoder *cxld;
+
+		cxld = cxl_find_decoder_early(port, cxled, cxlr);
+		if (!cxld) {
+			dev_dbg(&cxlr->dev, "%s: no decoder available\n",
+				dev_name(&port->dev));
+			return -EBUSY;
+		}
+
+		cxl_rr = alloc_region_ref(port, cxlr, cxled, cxld);
 		if (IS_ERR(cxl_rr)) {
 			dev_dbg(&cxlr->dev,
 				"%s: failed to allocate region reference\n",
@@ -1118,7 +1117,7 @@ static int cxl_port_attach_region(struct cxl_port *port,
 		}
 		nr_targets_inc = true;
 
-		rc = cxl_rr_alloc_decoder(port, cxlr, cxled, cxl_rr);
+		rc = cxl_rr_alloc_decoder(port, cxlr, cxled, cxl_rr, cxld);
 		if (rc)
 			goto out_erase;
 	}
-- 
2.39.5

