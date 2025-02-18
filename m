Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3691A26A1D9;
	Tue, 18 Feb 2025 13:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739885118; cv=fail; b=t7Xd4fVfybSkO9DZlv6P8RDSlcwa743aXd/0GPwmjj2NQSyDLEN6y5Lt05l1IbcE3VbhOFlO7HDJ+I7rkKg3bcNTIIhHfIOZ5f0lgkUw+Pq76SkI9OSLfFn7epMPoXRETyq1DfG1xglDNDNL3WIjfDeyPjSGGPm7h8Pm2zlwy88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739885118; c=relaxed/simple;
	bh=Txb9rkAeGu3IkwImDIXtfttvjTEp6iNa0J1gScyiu0U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IHIZoZX7sfjawD6MPlPOIKIFFS/gGS3KmDwxPdu/NYvQ/ZDIodaycm/b5N03KUjbjRiOW1OyR8l+K5D9R/dh/KL0qskVdtguslhufOltIhEDWgNqI2a32pzp9ItMGpmBai05J5xfg4X0jW7yEZ5mmtjt1DXCIf8DPWfWxT5U0CE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EkbOibaw; arc=fail smtp.client-ip=40.107.92.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EkbOibaw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y3k49ZB//36VvNzRNDkTbMKBBsasJ44bvwfdo7FaMpQPxet/55ycWM8yyivA2TsGlD9o7iV0vnSRgJf9EXheHDsn7QWG6OfpmfB/2idBV/NL2UT7s+byg8rpg3yXA5yPiyecgFgBwxF2y4p4OKAaYdQ5VZxG16ntQE2np3WjuJelMn31c5dCOLj2OsEMwZlFh/2hRGrBa7gTKZUYq0ngTAclHASdq1X4kwOlqok9psLuiE16uQQK+ezdUe808fPNse72bBh7eZNR82jWYQeNbkSRraN6t0cTpYV3WM/h9NCNuB94qM3EuHhZr1STGfx6bJ/XnnU37aI+/dhSjwWPJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z59g/90XzzJrWCboBlbj/6p5Mkebr/2273sx4ufMb54=;
 b=q7VRt7OBidZ1gi1pzEY3K1rULBOFNv2F6HiDZZdpoMQ2QkeGPV/GS5dFx/kJplbdSRK1AgCijQnR8/rq/wkzFwSe+vkD58VAysQDZu+6BAveupQuRqGFIn3X0084+G/Y7hVPk31Qy+Q4UvGKYzAMM8/07KucqCieLPV1lSoKo2goQTKmgiPq5Qcdfq36f1ckIk1w4H/PPtsQMIPRgHE1pJ4S8V/YQPtivYT/Azt7gUmTFZCgtmEDQh0KL0TCbyoMRNiibnjz2PTUZVi3WXKH64o0MF7uAJuXupuQ0yx1zn0s/lt8iUMdkpdcGsiypm+wVKm78/u3hQcLdpeyPZ9Adw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z59g/90XzzJrWCboBlbj/6p5Mkebr/2273sx4ufMb54=;
 b=EkbOibawkBbcIgrSskT4+Qqlzcr0Dw9eIAArxZoOJQEYjyMdRPSOb2ktoIZj7TUJKHeiVh+zeF2vxFzyYy3e2GWDbYrkC5eL0fzc+pdSonhLkeok5UhiY17RAza0fRmPtDknf075nw4K1RBYvMgnHjw8FJBX09zTa8hN07js8FI=
Received: from BN8PR04CA0039.namprd04.prod.outlook.com (2603:10b6:408:d4::13)
 by DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Tue, 18 Feb
 2025 13:25:12 +0000
Received: from BL02EPF00021F6F.namprd02.prod.outlook.com
 (2603:10b6:408:d4:cafe::cb) by BN8PR04CA0039.outlook.office365.com
 (2603:10b6:408:d4::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.14 via Frontend Transport; Tue,
 18 Feb 2025 13:25:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6F.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Tue, 18 Feb 2025 13:25:12 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Feb
 2025 07:25:09 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v2 11/15] cxl/region: Use the endpoint's SPA range to check a region
Date: Tue, 18 Feb 2025 14:23:52 +0100
Message-ID: <20250218132356.1809075-12-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250218132356.1809075-1-rrichter@amd.com>
References: <20250218132356.1809075-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6F:EE_|DS0PR12MB6583:EE_
X-MS-Office365-Filtering-Correlation-Id: 52d0d0db-ee0b-445a-1240-08dd501fac45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NnRF1XAvhp9NSgEcBhawj/mX7xBHAJN/IwAbK6L1sOQOy4lwn8bXSzw/mAZT?=
 =?us-ascii?Q?fDYiktTmptfxKd2BjOjqGmVX1e8tusdYxuUQTl2mC4ijXyB2KwKeAW6c0IfM?=
 =?us-ascii?Q?QVhkBhG+3ERwX9cI1JZ86b5apyEYaquEJWSUsu5NoPSleglOTv+hKBt351qg?=
 =?us-ascii?Q?z7LmuoKNIcloNcDaSvHIHS639jgG8I/aYeYu6gXMshyqCtddwXAIsJDXxWDN?=
 =?us-ascii?Q?HWRzE7EvjStVyxqSErba4pmBXJWOoCRk/yRgsHXAR6yY8TK0qxysxvuCjEg2?=
 =?us-ascii?Q?jbuMdfEOtPhhkEOu7tS2EOblaMCoA/sstge1Cw76PoVWoMxzdMJTGcML/VJW?=
 =?us-ascii?Q?bMDUcZo7o+Bd9ltz5iuOhczFzn+APU9jMGJMIudtEwB7Pg3nY1KpLI43W+dj?=
 =?us-ascii?Q?dp1gmnz5w6sxLJtuwK67Ju9UJvfTOOhL6M2ZnQv7zNceWuXs1/5WOOkxe9iM?=
 =?us-ascii?Q?fIg/MvtWPcP2gM3dpa7oedXJFJBq9oj/LTx8XnWH2hmrdAlvndYd1xOL1rEQ?=
 =?us-ascii?Q?WFLiJ0ANWa80Ksxqommu6FHPLGh6COTmUqtjGRiJvbzDnp0gjC2Y+jFG2Ags?=
 =?us-ascii?Q?wnUU8krzwI/ihQNViP2ehzKFTWX1YB+9mjtGcw4cEIN9m5Y5J8643I2SSHSI?=
 =?us-ascii?Q?t+OHM6MBLXzJJigrGZsf+GGoUnw5gmalv7K70QXAe7Lp1Mm8REvEryAXB70+?=
 =?us-ascii?Q?uX0V39MklqDxG4nQ1VRYZI8WXYdEQW6v/2hkZJ08Foy+gCu8CGCtX/y+RQyR?=
 =?us-ascii?Q?zg56k8S8jLbLSNNFcNO7iZyNowrG+4lzmBisd14XtXaO0zaQk0fmgavewAWo?=
 =?us-ascii?Q?L4Nlyg1sQedq4eUL3WNKtGNTBsc3mXlab4YOthaTPHPDMS1j04YHl/OFyJGx?=
 =?us-ascii?Q?XrIcL9DA4tohuJLp1YwLoBk3lb8kbft2cw23y+O3sfJ4lu3VEgFCh3ISm9LF?=
 =?us-ascii?Q?wQJeci8fH5mo4erksC34t9KGrnLLUhT5u4pShHcdPCK6wGfhgZUNMkuH1zU1?=
 =?us-ascii?Q?ymzR3cOXCbxvB47FOCX/+wV0iVeEnmHnq3zJQ1/0mSCECfGLNxai79z0FFTV?=
 =?us-ascii?Q?gfagY1zS+elEr+nxxFHk9gOA1R2DFEdED0QvH8A1AB7HT+Ns3naOFeGZ6MuY?=
 =?us-ascii?Q?Oj0t6wggKXKCsQqiDtiFSm6MLM8ZGVO8wJde0LtVMv3Zol93h5bwCcRuOiy8?=
 =?us-ascii?Q?Yv21es30zkDSHy152kOj2vRd6CHeotdICKER/zdV8P2HKNgqYVx2no1wV+v2?=
 =?us-ascii?Q?u6urdL1cF62rZkF0uZNgDJxGTIwQbtW8Crth1gNmZ9ri6jV3FWsoBdaeJBeI?=
 =?us-ascii?Q?vzbtp/0WXFwg9EbxgPvFA42sdsEX7i1aXmoSdYgsXacWliN8Wg+Nix30IvAv?=
 =?us-ascii?Q?4ylwS5O/Io9PnPv5A6nIAP+nyu7hwtseqZRZkZ+4OoknfQt/HcffcK90ayOR?=
 =?us-ascii?Q?fnDcHJwxyL+aiI6+ubyOua9YkxTTXdr1t1dIL4benrH664UxkbcgUZKpVAzS?=
 =?us-ascii?Q?5Z1lSV17yOijwMs=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 13:25:12.0582
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52d0d0db-ee0b-445a-1240-08dd501fac45
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6583

Endpoints or switches requiring address translation might not be aware
of the system's interleaving configuration. Then, the configured
endpoint's address range might not match the expected range. In
contrast, the SPA range of an endpoint is calculated applying platform
specific address translation. That range is correct and can be used to
check a region range.

Adjust the region range check and use the endpoint's SPA range to
check it.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 3afcc9ca06ae..2ca24565757a 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1531,22 +1531,26 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
 		if (cxld->interleave_ways != iw ||
 		    cxld->interleave_granularity != ig ||
-		    cxld->hpa_range.start != p->res->start ||
-		    cxld->hpa_range.end != p->res->end ||
+		    cxled->spa_range.start != p->res->start ||
+		    cxled->spa_range.end != p->res->end ||
 		    ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)) {
 			dev_err(&cxlr->dev,
 				"%s:%s %s expected iw: %d ig: %d %pr\n",
 				dev_name(port->uport_dev), dev_name(&port->dev),
 				__func__, iw, ig, p->res);
 			dev_err(&cxlr->dev,
-				"%s:%s %s got iw: %d ig: %d state: %s %#llx:%#llx\n",
+				"%s:%s %s got iw: %d ig: %d state: %s %#llx-%#llx:%#llx-%#llx(%s):%#llx-%#llx(%s)\n",
 				dev_name(port->uport_dev), dev_name(&port->dev),
 				__func__, cxld->interleave_ways,
 				cxld->interleave_granularity,
 				(cxld->flags & CXL_DECODER_F_ENABLE) ?
 					"enabled" :
 					"disabled",
-				cxld->hpa_range.start, cxld->hpa_range.end);
+				p->res->start, p->res->end,
+				cxled->spa_range.start, cxled->spa_range.end,
+				dev_name(&cxled->cxld.dev),
+				cxld->hpa_range.start, cxld->hpa_range.end,
+				dev_name(&cxld->dev));
 			return -ENXIO;
 		}
 	} else {
-- 
2.39.5

