Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010055.outbound.protection.outlook.com [52.101.193.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051102192EA;
	Fri, 14 Nov 2025 00:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763080882; cv=fail; b=aOYkrY89YNjllxf9wq5P9H5qPlffvt0zzVSETBYxgObyvoMqb63WeECd+d/Qt2vzC5zHZ78Wnp/AwNzFLxZgxDU+XYYCRCW1t6posBJ0DROgSn0QjNcZQdVVlMw+8/5VXCQH3MRzYWcluSbbyYAImI/AntZkh0CODl39uaZyn9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763080882; c=relaxed/simple;
	bh=/m4K2MszO4PSIp4MRyq1YJ6RQplFH23mK8hnk27UTb0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dTaO30XU3RTGt4OAcTJb5vGMA//paiHYa92w/Wim6dXiG1uytK9SMTXZ5nqcfc6odM8dCs8r3+EOzifJ99jkcFjiYwHa8O6NJslKAFIzmhfi3c8hTAULuwyL+228hVJAF6eADeIWz0Q7chWvORoCDxZUdXH9/72IpAZS4GX3j38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=a2lHTj9A; arc=fail smtp.client-ip=52.101.193.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="a2lHTj9A"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hYaPY+m1xupy6XUgEz5+wxAP1QZ5mizEiaJ+s8TXOkG9Dpp9u8sAc2Kp41En+QzOWPr5iqFoinj9/Yr6osLs3hWUYRGK/nWT6cONh+WKWYU01acoa3fbpD+WcIzHVWOQh/t0JlLCizv3do83Zxs9SqEhSnalqiQc9Q3Gq+1WlhSOSnv9k/uBojfXmWFgb7/ERPUseRwM77wEbhErUNLgSyHYPsGm8KeD0IjUQDcwWNm+thaZE1aksQxpJ+EHfOognw4wIc6bf3lTe7ojTxOdjuQ/2mlOHE/0GEaDAqDynufd46AkIjUvqKoihwWFtEBOIGZ4csIHzKtsG3ZnECLGGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tSbQ34c5JJeZVTwwFMFBOxctCj0izz6Nby7BAoJn3Lg=;
 b=VTuVnjNEwDZeQ6f4unb7Z10CLN+IpX4yb+N4aSL1NfRMPrj+F9bUmFmkEiIaksWZe2P0S46DSOkNQUpse8A8gXT2dLA90lBUYlBtp51Vka1dTfMNyIxGIJ4fwaCxcn2SEsuzR+EbPpDHyXFJIH11YtZdn1oQe0DCYJ2wcMEM/OgHcVyIk68hwv24lXq6z/yVjYTlE9TuxiKiOxMTZK6zM3FFbVDJYTqA5ySKRCPrq22X++xe64xJ5Smohp5wr7DU7bOv+rxy/S1TwoQOJQULaah8qjrzupEH/1aKO1U0dwWRMLbS6A5/bDz+yAvqXQCOIU3TpqFnCuqDRS19RvYfLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tSbQ34c5JJeZVTwwFMFBOxctCj0izz6Nby7BAoJn3Lg=;
 b=a2lHTj9A2XjwuMzs/IkbAGwg05mRBaSEHPedvH8290vTmES/Qa86NJzjkWZd3yOAzS8HiCJRT0quIo0HeNBn8ySdFAiVAfaOBpDYNEDIUy0QeP/Bd7M10myw27d0K7jRDBsAR8AGopE1gk3UEtOZzlQF89oKOU2HhuNSVAXUWdc=
Received: from SJ0PR03CA0264.namprd03.prod.outlook.com (2603:10b6:a03:3a0::29)
 by SJ0PR12MB5634.namprd12.prod.outlook.com (2603:10b6:a03:429::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 00:41:16 +0000
Received: from SJ1PEPF000023D1.namprd02.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::dc) by SJ0PR03CA0264.outlook.office365.com
 (2603:10b6:a03:3a0::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Fri,
 14 Nov 2025 00:41:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D1.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Fri, 14 Nov 2025 00:41:14 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 13 Nov
 2025 16:40:59 -0800
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v6 03/11] cxl/region: Store HPA range in struct cxl_region
Date: Fri, 14 Nov 2025 01:40:08 +0100
Message-ID: <20251114004021.1310661-4-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D1:EE_|SJ0PR12MB5634:EE_
X-MS-Office365-Filtering-Correlation-Id: fcd2c869-b437-4f33-5455-08de23168414
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9hUbZKnfkDzDU9VY2bVy4V5ReyeNa/b9pe/Z6MqOt2+o4vKc7CxuJjwYrdfu?=
 =?us-ascii?Q?J/jZXFlBiupt/W/CftIhACBiNAxss++P50/xjJIqXQbesr/LdzY4aInXs5JY?=
 =?us-ascii?Q?26R7nZrHWRWwkRx4RJxkuWNv9/gy09YMn4tWzcYSfGuTRe0iKVO/CWpnSJvS?=
 =?us-ascii?Q?nC+3L2jxml8hMvd9mtPpE17lRSMacoFFmLt8/O/taUIpiJk0ZTP0ehwQmKff?=
 =?us-ascii?Q?K0+o7kQHdMjbGQPHp1Dd7dL9cyLyO92tvwIFeMebuvPOR8YerVfB1GMR2uP+?=
 =?us-ascii?Q?lnOVp57UtfunFStMptcoGr1P1V/m/vxwP9BXXmEWoMeDOVJnZWaSpadZOU7L?=
 =?us-ascii?Q?A3mEWDI3dyMwmLLZBpU/y/OVMXp0foRny4+NAbqWFeOuTMxpLzIgDYDg25Y0?=
 =?us-ascii?Q?3Y0n8oCHSqNRhLKYiM5jxULNZWJgBuVpWoHs/ZPJ05lhTDuGsNGURBrVrrC9?=
 =?us-ascii?Q?puUvE8b+pb9LTVjjZ0UFcR0WOMGmFV8Ch+FyJztkUCRt3OgulusyxaP3Q79i?=
 =?us-ascii?Q?7Pp2sPXwVSFdlw9FbLAcaTZ7/3PxjCbRK0u/KbJ1keCUJlzd5tJxqcn8U8XM?=
 =?us-ascii?Q?oMKEPVuorFZ7um6rGyWW4zeXwC6O9BPpmuShnDmaEWUAMVIJv3XHmrcD7D3Y?=
 =?us-ascii?Q?civu/nTZ2sskSRnTR1eEZzYSmNQRL3eErnwao+me4Rr9WwaL9vZfZ7gTDq5c?=
 =?us-ascii?Q?vFLJqsfmPpYHfiad0tL1YELaOyfjgjycIeQGU4DhQp3lDiiU4J6FCdkISxNb?=
 =?us-ascii?Q?dXd1n2+/2/4K0+3Dl8Iyp1JhWkQ1WgcHyjhKm9F4C3+L3UwSp9u+mXsE+Goa?=
 =?us-ascii?Q?2NK/o9MoiYynAGTuaQynF7iggJQPMhVfvO0GClUmmstzk7doLanm06cyAbdv?=
 =?us-ascii?Q?95Wa9F59rLXVDzXTvQkiqXReAqbaVek0X9GKLr54OlKiwDCxunh1jLVfNp7i?=
 =?us-ascii?Q?FPAqVRDBGIJpTMH0qphqum2JoNcn3xnqWaM+pivoM0awIN7/Vr8ONCqvEjIk?=
 =?us-ascii?Q?q4VBUO799i9eVltj2fwv+FaEEsXfPVM8tHGdKzx8OWGfc1J0VnDralSGxi9T?=
 =?us-ascii?Q?gX9AmJ2rvRKyWEqzGbDX4mJJ6mJK3rA6YIqBQIJ2CWCUVvrP/faB9LDYfo1d?=
 =?us-ascii?Q?gjNRnfxz9DLyKQnFb1MCYT7naLl8zN8nXYd8b0sWsHfJ5Ee8aLuzun+dyqqs?=
 =?us-ascii?Q?phxphY4BXqCMOGbyMxpSkCU1zilO+6WQ3Wjjey6CN42oMhpfIX4J5sqxcMfr?=
 =?us-ascii?Q?bL6MGlHjLnUHl9ot3N6OMuX2rl0YHr4ODewZ7Nn5hk2qjd2nvMN71cM2eIrO?=
 =?us-ascii?Q?RO8alqIgoPrI5GJWiQdXiKjae1h386wgpUUmgpcBOU8EHXJhSivcknnsJdAW?=
 =?us-ascii?Q?HC5MgtlzzWAhYsdZgER8bO5oyQt5kyz+ABW/q8pPBE9CfueC7Vj/xWcLgKyb?=
 =?us-ascii?Q?v065aP0DKrSmGwoBAGW12akBkGOsuVgvG4qdxztRUCo89KfGi3WMQ8Wkauh2?=
 =?us-ascii?Q?74PsWgMX5AQ7izCZVsnzWDnUvgVKz+kvmS9Y33tbfqrPz1ABI73yzFWtsB9P?=
 =?us-ascii?Q?2vRKcbMXWFHOStqRH4Y=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 00:41:14.4018
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fcd2c869-b437-4f33-5455-08de23168414
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5634

Each region has a known host physical address (HPA) range it is
assigned to. Endpoint decoders assigned to a region share the same HPA
range. The region's address range is the system's physical address
(SPA) range.

Endpoint decoders in systems that need address translation use HPAs
which are not SPAs. To make the SPA range accessible to the endpoint
decoders, store and track the region's SPA range in struct cxl_region.
Introduce the @hpa_range member to the struct. Now, the SPA range of
an endpoint decoder can be determined based on its assigned region.

Patch is a prerequisite to implement address translation which uses
struct cxl_region to store all relevant region and interleaving
parameters.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 7 +++++++
 drivers/cxl/cxl.h         | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index d3bd8d074033..13b4e27248cf 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -670,6 +670,8 @@ static int alloc_hpa(struct cxl_region *cxlr, resource_size_t size)
 		return PTR_ERR(res);
 	}
 
+	cxlr->hpa_range = DEFINE_RANGE(res->start, res->end);
+
 	p->res = res;
 	p->state = CXL_CONFIG_INTERLEAVE_ACTIVE;
 
@@ -706,6 +708,8 @@ static int free_hpa(struct cxl_region *cxlr)
 	if (p->state >= CXL_CONFIG_ACTIVE)
 		return -EBUSY;
 
+	cxlr->hpa_range = DEFINE_RANGE(0, -1);
+
 	cxl_region_iomem_release(cxlr);
 	p->state = CXL_CONFIG_IDLE;
 	return 0;
@@ -2407,6 +2411,8 @@ static void unregister_region(void *_cxlr)
 	for (i = 0; i < p->interleave_ways; i++)
 		detach_target(cxlr, i);
 
+	cxlr->hpa_range = DEFINE_RANGE(0, -1);
+
 	cxl_region_iomem_release(cxlr);
 	put_device(&cxlr->dev);
 }
@@ -3450,6 +3456,7 @@ static int __construct_region(struct cxl_region *cxlr,
 	}
 
 	set_bit(CXL_REGION_F_AUTO, &cxlr->flags);
+	cxlr->hpa_range = *hpa_range;
 
 	res = kmalloc(sizeof(*res), GFP_KERNEL);
 	if (!res)
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index e61e274cdab2..4633004fb770 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -522,6 +522,7 @@ enum cxl_partition_mode {
  * @dev: This region's device
  * @id: This region's id. Id is globally unique across all regions
  * @cxlrd: Region's root decoder
+ * @hpa_range: Address range occupied by the region
  * @mode: Operational mode of the mapped capacity
  * @type: Endpoint decoder target type
  * @cxl_nvb: nvdimm bridge for coordinating @cxlr_pmem setup / shutdown
@@ -536,6 +537,7 @@ struct cxl_region {
 	struct device dev;
 	int id;
 	struct cxl_root_decoder *cxlrd;
+	struct range hpa_range;
 	enum cxl_partition_mode mode;
 	enum cxl_decoder_type type;
 	struct cxl_nvdimm_bridge *cxl_nvb;
-- 
2.47.3

