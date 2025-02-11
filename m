Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2054.outbound.protection.outlook.com [40.107.100.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2A11F4171;
	Tue, 11 Feb 2025 09:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739267716; cv=fail; b=JSQZGcMJclcRFteE9Zy6RA6uEM/eMiOPX/Kyu4Mz+WzUepU2IiLZkYuI3SIClfL88txGCczQjOAL1U/Mrx6J/yFxGF3ee/akUdZzYfY8CnoWDKkDWrQzwcm76msuLov1UqOUsH0tfH9FuNgxSXtpKV0zs3kqvz/n+ZkfCX/vwU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739267716; c=relaxed/simple;
	bh=kLeJnf64uZheUleovTuo7aPpJuSeWIkY2qoUrlFB6pI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R09rzi7SWdR5gtkNRI0EzRSaY61QIK8TXTyWrKqKSUSGHTMmKr0FG496St6afUkztXVf+xRLfzStuuNSeecOdgcuCwJDSRnaI+scXjBj+g3E/2Vmxb5t/U5ShHVZq53kpwPCGKEo2/no5JXbYgs+sIb5orktd0/0i54RLy606/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5uphLMYE; arc=fail smtp.client-ip=40.107.100.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5uphLMYE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u5CmLSlFIVnGNylJZrJ1Ywqge060HuwaSf4TDn5HxrVEowtMEdZOA1q4zwVGytCYsY7ilNc+OLhEJ5iegimyzuwRW4LmiPipZyDFdzYMhuQcrN1KbACxIAnBfOfXlziCdztFelx+kPOL9YrzqRGyEdPvu9h0wu2gDIhyQ3zXAbBqsfG6DltTeK1/G2h6aoZXl/BL2cRTrRh4uIi8s8vH9I1hfNvCHMaDiDsjda5rKJjNGhXJxcQnFpgnGns0EUSt5PZ4B0cZ6Xt5ZHhvy8R0f0D3JNouCIWSSQ3z4t8dpAt28wDFObykt/5enAj0nLVzan4Gif+lHK895wDtzBDAzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WPVKBRMBjtIZ8/SUAP5Fc5x6cFVcEYPsxTufDArqYtU=;
 b=ratMCAbrKjS8biekemZXbzeccScjm/q8LmI0mcbz/nZVDafn4jSz5jcUMR2qy4LwzR4Cop4rs70jjihWWTpAf/WpgXNKzDKdvvkqwiWTu1Fnw6PRbD7AWxolW7cEgQSMkma4wcenyqURrFxDe0SOFaCg/R3vxUuVsHWiUxU2sbx4AeGroAfU6CHjrRgLbZ1VAc3+d42cyYdqx6awSAsz3Hs2JVPGBEHem9oCofefyadihV2QkALh/8PBhY47WNeT0+y/t2UlK5hR0lRtkCRgk3a0OPaJcgJh3vGaQ26zf1Y0za5AYTmHX2vWl4cScuRpam87XCVnsolZ9jmuFlESog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WPVKBRMBjtIZ8/SUAP5Fc5x6cFVcEYPsxTufDArqYtU=;
 b=5uphLMYE1NlaqdVl58Brky5ih1CgfkrQR/eYU8OL+KQU3W18rqxWqV17+dFRCj6wBnsJ3i7zw/fm3X582CKgeNzXgrQK5sHDdXO01GETlaTc1KQ08na0nxZaQ7EsLuA9XL6DaUXCNFqBsSG94/IGGQR3qgESOyRI6N6Fg6QeVJs=
Received: from BN9PR03CA0468.namprd03.prod.outlook.com (2603:10b6:408:139::23)
 by SA1PR12MB8141.namprd12.prod.outlook.com (2603:10b6:806:339::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Tue, 11 Feb
 2025 09:55:11 +0000
Received: from BN3PEPF0000B069.namprd21.prod.outlook.com
 (2603:10b6:408:139:cafe::d3) by BN9PR03CA0468.outlook.office365.com
 (2603:10b6:408:139::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Tue,
 11 Feb 2025 09:55:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B069.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.0 via Frontend Transport; Tue, 11 Feb 2025 09:55:10 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Feb
 2025 03:55:05 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v3 14/18] cxl/region: Unfold cxl_find_root_decoder() into cxl_endpoint_decoder_initialize()
Date: Tue, 11 Feb 2025 10:53:44 +0100
Message-ID: <20250211095349.981096-15-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250211095349.981096-1-rrichter@amd.com>
References: <20250211095349.981096-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B069:EE_|SA1PR12MB8141:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d819d43-cf27-4124-1291-08dd4a822c60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?v3sPUEZalmtRougG+egnfUTW/28Irh8c3+/zh7bXlQInEdzTys9gmUrjXAs1?=
 =?us-ascii?Q?HuzoD0WgmoSW25HUNx117hs3BuwgsDgGzfsmQ3UODHcxhW0SBK9Jt3KqKiQO?=
 =?us-ascii?Q?NqM18bpbYh/6E8aHcQlLLItP0KUV3k3lLjxW/A18ESaBOG7ysBMCGZYI0VSU?=
 =?us-ascii?Q?i2lRMMvl6AAmSqCs5z7vfsLovSY1HMa/6w/aLgkPExur63Ckuet4h8J90pjn?=
 =?us-ascii?Q?7s7dYVMDRYG39XxzYcRqCvrb0SWe8PycVu0YbEWeFm6NSw8nh3rSbx9MQZAS?=
 =?us-ascii?Q?SiMfKe36Z47LQJgLNgAJSboiavMBYn120py9Eis1yYp4v9fMchxaPpXxhqoL?=
 =?us-ascii?Q?LZU/u7vX/CBR1qIYY/fDzpbcupmTXsnB/9NSEWyGbAio+IwKK/3vBDapK0QM?=
 =?us-ascii?Q?VYFEZrwyEmFZiTobnbmMrCmGLN9Ye98gVTHkbYxX3ewOBQ+ZmFJGCgR2RoNG?=
 =?us-ascii?Q?a5hGxOcgCwWOGBBiPmvu/YJBp+cW+tvVBqm96lqi6sWDa3LyRTKNMBEy8xjA?=
 =?us-ascii?Q?w5VKcTmg6DQJU8rByNKqXO8UzwVWCiHPNjJdK7i3CCwC4tz6MISi9cd6D6Wj?=
 =?us-ascii?Q?xYYBn5gmqZw5OOVvF1kYLkEDWIrl5Bkn8wKkianglfJcdqRo3ywLEtoHNbP/?=
 =?us-ascii?Q?TM4+OJAJyLGUKoDTg3A05GpZBXkRly/71zsIb5ASomNlGPN/DVi0u1W7nKaC?=
 =?us-ascii?Q?iOmD0GXUhpf/7sSwh1bExI78M6jRDjUA/X437Nv+g0ugqbzqonRkFxYdKt/m?=
 =?us-ascii?Q?XNiBFGhC89/OyUU3CNPPopzQoCm2JTBpbNOy7DR+AjvCY1aAdSQA+HRQEZlo?=
 =?us-ascii?Q?/Yh/hegfbUYZAxOuAjeER/JrnYYUAQKIqgGO5FCzGDOWxcqB0pTahw5M7oTG?=
 =?us-ascii?Q?EligjLssLQTNJrO7GIoAHy1f7+rahZ3NOcIWXL+Uf3bPL0NStIgJN8ZhxuQx?=
 =?us-ascii?Q?Zy9cLjwVc67zaUzqO/3bVk1w4HYzCP6eODqpEYG7GiaGX0aJ/ebk9YVvf4Me?=
 =?us-ascii?Q?l2uxDI/Y5SmbWUGuuD8rWDt4ET1FFkVaUAXD4N526VkPruoFevPi47Sfm6g0?=
 =?us-ascii?Q?C9K8927R7N3tIaQnpL38wFIKvm5pHT8LEuSYWcBQfG3p93QhXwmFfEttFrbA?=
 =?us-ascii?Q?tT4yGW3jBqCq03F9G5YT0+L4Yy+/5op/PiXKRFyd11jIEHaqhRBE+wpcNbOL?=
 =?us-ascii?Q?6PCtnQ948dnyvhV3E6hJljiqrMn90k4id0DeXsS8HP9ypOAh4eDh+DyAT1E5?=
 =?us-ascii?Q?EGNu1BA0S7H9A0azCIQn2UIgEO6+Gs0GNOQfcMmFNekAL5ZvK62NXdVTnXci?=
 =?us-ascii?Q?vFDrQx5liUqDnjtCxCVlT14Z9/JjqXP3zvgrpf8x0zAG6KZh1FvJu4iCF7yY?=
 =?us-ascii?Q?eRW+7s4VmoUJQEE+yFET6xLgwVo34Co8gOeXjswhzpfXtTo0rX4Eh5uwZY1Q?=
 =?us-ascii?Q?9sU/uMJbaY47LVYDIzbwXQ+dZnmPijdmxChjtL5HHSYyHGn72mpH/YqtbRxD?=
 =?us-ascii?Q?dJ4sDxlPAQp9YBw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 09:55:10.6551
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d819d43-cf27-4124-1291-08dd4a822c60
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B069.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8141

To determine other endpoint parameters such as interleaving parameters
during endpoint initialization, the iterator function in
cxl_find_root_decoder() can be used. Unfold this function into
cxl_endpoint_decoder_initialize() and make the iterator available
there.

Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Tested-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/region.c | 24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 72e991e7d9ab..ebcfbfe9eafc 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3220,8 +3220,7 @@ cxl_port_find_switch_decoder(struct cxl_port *port, struct range *hpa)
 	return cxld_dev ? to_cxl_decoder(cxld_dev) : NULL;
 }
 
-static struct cxl_root_decoder *
-cxl_find_root_decoder(struct cxl_endpoint_decoder *cxled)
+static int cxl_endpoint_decoder_initialize(struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 	struct cxl_port *iter = cxled_to_port(cxled);
@@ -3232,7 +3231,7 @@ cxl_find_root_decoder(struct cxl_endpoint_decoder *cxled)
 		iter = to_cxl_port(iter->dev.parent);
 
 	if (!iter)
-		return NULL;
+		return -ENXIO;
 
 	root = cxl_port_find_switch_decoder(iter, hpa);
 	if (!root) {
@@ -3240,12 +3239,12 @@ cxl_find_root_decoder(struct cxl_endpoint_decoder *cxled)
 			"%s:%s no CXL window for range %#llx:%#llx\n",
 			dev_name(&cxlmd->dev), dev_name(&cxld->dev),
 			cxld->hpa_range.start, cxld->hpa_range.end);
-		return NULL;
+		return -ENXIO;
 	}
 
+	cxled->cxlrd = to_cxl_root_decoder(&root->dev);
 
-
-	return to_cxl_root_decoder(&root->dev);
+	return 0;
 }
 
 static int match_region_by_range(struct device *dev, const void *data)
@@ -3370,19 +3369,6 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 	return ERR_PTR(rc);
 }
 
-static int cxl_endpoint_decoder_initialize(struct cxl_endpoint_decoder *cxled)
-{
-	struct cxl_root_decoder *cxlrd;
-
-	cxlrd = cxl_find_root_decoder(cxled);
-	if (!cxlrd)
-		return -ENXIO;
-
-	cxled->cxlrd = cxlrd;
-
-	return 0;
-}
-
 static int cxl_endpoint_decoder_add(struct cxl_endpoint_decoder *cxled)
 {
 	struct range *hpa = &cxled->cxld.hpa_range;
-- 
2.39.5

