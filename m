Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011059.outbound.protection.outlook.com [40.93.194.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F563320A01;
	Mon,  3 Nov 2025 18:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762195734; cv=fail; b=UBzRJyQlIukmPh6JMr6C+MdVFZcYZTGsmOMo6CAkgzy8n0T47uPoXCJdee1RjgmlO0l36kfhDLLJCRvDbgc2Khhx797W8nRQfi/QBAYR+IPT7PZvvcucgSMRJDBuRdTOp8Qa4KeE7+5C8nh6+yw6S5h1ZPBbbsYscVrbN2iA0Qs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762195734; c=relaxed/simple;
	bh=d5m0zLbYdg56gIx1ASJBQlV1gID9K7AXVOdpmFPAJIM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GfHwSC5V/gW65HBMmjG1vL0xzjNPPplkTs794uORe2u8Q0eKzCg3PKxhDTZ445R5Et8KeCNCJTiasSXeNrNedmbh/HHBg7th7TDu4UhKnwJ12/Gh0dF+qAoyd0XknnY2YV4n64eyb8372MX9mEci28D41pmVVnVgZ9cxYNdKD1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ROwHRaOT; arc=fail smtp.client-ip=40.93.194.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ROwHRaOT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bhm3IaYKA2euLdPpi7iLZSQtsPdC/y6+DlSnK31HFtn6o/M1GLogSP0uD9U5Lb97MKHSM4yT9Pk5j0uHJniNiQeKK+7NQES9z05z+aW38qvdFX6HupmsrquaCZJrEzTWIxP0Vajxrl2LYUtIn1sUJl5+NyJTF8uwfD8fIHYoR2AM7RH6aViJTO4U2W4ayP0RUzwTifJonupjtZ7mTicjwi4XpR/FPGnBeu06aMtZ/rOUJOn8Cxr/j+3eKGT6ZRZS3jt4fGaWyCMUFItL2b0JJ5KHlXUMkl9vmz9noCcBLPznBoz6hSJEIizE4u6IPSVIme6odCripeECysCdwUwN4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uv1UIx9Tn5Of0mXT1bN+DiM5L19iaduOzc1srZndopE=;
 b=kp/iax3eemxV9gVSn8a8ydlIyp3bBdZA7IWBhzwk52ZbQX+zylrrsWKPvY4AUyXOPhy9NcscbJwbX6d8A6A8smzFyuE4MjYkUYpOzaQ7/Xq+reZCwtWcFbp3KgAL9YZXiJ0b/TfcIYSInSxloRwgmtdAXOvlyRc/UvlNgvstY1J/2UabxizAXEw6aagZaUat2ZxnHplR5TisBqj0JsAh48hhkglsGAgopPmhSRJLiB5T3F8wj959yWYj00sJEZj2EWGj0dhOQuvSYKT3p19UnTkWftsPrpyfV05y4S2CgICuIMKjLu8V4JI78cXaOwLYP0DL2Q0ue+jkMqsWIUlLZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uv1UIx9Tn5Of0mXT1bN+DiM5L19iaduOzc1srZndopE=;
 b=ROwHRaOT3XCpcaXc+Peb7Mgt6NdGC5GcDKiVvgdzWACeFCl94bUBtHyseiFhA8STNOVofSlHEOKYBlaG9iF3Y55x+12EGhLgSXZ6dq+50LbnolYqd2J7ghsRJ89nVKZXP4fGf1EXkd+xgj/lQwkNqf/g1NvyUP5CMe1Vj5AmlFI=
Received: from MN0P223CA0001.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::19)
 by DS2PR12MB9664.namprd12.prod.outlook.com (2603:10b6:8:27b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 18:48:45 +0000
Received: from BL6PEPF00022570.namprd02.prod.outlook.com
 (2603:10b6:208:52b:cafe::42) by MN0P223CA0001.outlook.office365.com
 (2603:10b6:208:52b::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Mon,
 3 Nov 2025 18:48:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022570.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Mon, 3 Nov 2025 18:48:45 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 3 Nov
 2025 10:48:40 -0800
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
Subject: [PATCH v4 02/14] cxl/region: Store HPA range in struct cxl_region
Date: Mon, 3 Nov 2025 19:47:43 +0100
Message-ID: <20251103184804.509762-3-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022570:EE_|DS2PR12MB9664:EE_
X-MS-Office365-Filtering-Correlation-Id: f7936187-e274-416e-34f9-08de1b099e1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+KlZpr+rZbIGFKQu8JKy8xuC+XEVkE+18Uw04mHajadBt+wIv2ituuUVtiAr?=
 =?us-ascii?Q?xzPrjKNB3o6DYPKIoCz0dSoYsrwzcDr8QdSLm0kjRC29474gwu5quCovsUNn?=
 =?us-ascii?Q?IMxiAzh7e1TZf5NIPVA1mvjCjF4HyYcYgeR7CVhVlMR8jbsyMmKhX1rUdmjq?=
 =?us-ascii?Q?eeB0zaK33x+t8WC6vsMLnjGYfZkfDG91gCFvx7YvS5emuX4DQh+uj5Lj8Km5?=
 =?us-ascii?Q?hxJPnJ6d5nmOsv2qu1u8gMchZCm5KEYcm35HX2fh2sw/0o7CWqyBxX5LBhL9?=
 =?us-ascii?Q?4v+mke0TqFqaoUrHpZxZHEreRNVSek/LDnTiFCvXkBGNLEoyHR8G5FLOGqJi?=
 =?us-ascii?Q?584nB0IDzdJb8tR+ox+94Z9HsHB2289PX3wwV9/igzZoNcZ4pRqRFlJcNJCj?=
 =?us-ascii?Q?TB7FWBPySfb/FYA2Cy9XPIk5G0Gi5MSx+chLo80SFCTzrboTIV7TeOfKGFzT?=
 =?us-ascii?Q?GLrVuK/pGUq+rFgpThNaGSmCo6+dT31i0T9mYCquCGBGdyPJDA/Hdz4eLl3w?=
 =?us-ascii?Q?x4FaLKUa+IWyjBNlDQudfHgWSymXlJgELhTz65GwmOmQfYLpe3pfwqLthB5d?=
 =?us-ascii?Q?IqkYaoJp+k7a9FiDO/hTAQW75fpUn6dfwXYjm3qXxyZqV9wuN3DyTKpl11Ra?=
 =?us-ascii?Q?tkJ3rkAW7bn8SeQ2TOm8mxJ82ClGbfSwNCfRjW8R6LP5UAqcosVNlOb1mjhK?=
 =?us-ascii?Q?GOr3jyB0eCPQhxlqxTJGyoMxvfS9joTf35fa9KjuM1lJH0KYob3M1kCukVuj?=
 =?us-ascii?Q?4Wa3cFDtn210FAq0eGka1LGF4rz18gIvEOhxXZk17kXG3phYTZKLtfF5p2QV?=
 =?us-ascii?Q?HQp8cw7x3PpPILh4p9p7wPwoKFjlMYUrc0cbxw90xmCfUqyOerVZyNt1wi/G?=
 =?us-ascii?Q?2buKSQ6x2HM7FgqAErgq66082Gu3izqPMqqBilekxfxKgIE4CPPl3fUTaswp?=
 =?us-ascii?Q?YmQmK56Q6AAW3TGkQWTFk22kas/lULj3d36vbcTDDP50YXBVzvr76FYy11AR?=
 =?us-ascii?Q?Q3d5v9N7u+rSeWvQ5jRhW0XW/xDPVYMoCCxyZmVywREMTTNTqjvNuNek2QM2?=
 =?us-ascii?Q?pWxT1kQfBEn0BhnoSYWZAF5a/GeMOGIR+vAxcTM2Bvi2/cIAPKPsvUsM4PYF?=
 =?us-ascii?Q?aebhrsonYDUKpXWG/APo+RH7QBcZYdTCVifSrHV5kTxuxTWyUVkFPSR+Ai/5?=
 =?us-ascii?Q?Vq4ewDv756MfNvYLs3HA1yqXWqejjFMKvNo8n3wKPqbGPU6RiDm/Jc4psAZd?=
 =?us-ascii?Q?mnbrmHSOiNsi3M8zUtUHPB7ywgOd1OdNaFVtZAnxiYm9oiwosvzNCxq1IUm9?=
 =?us-ascii?Q?Ss2vC8MQYY+IEMoZDNQQM2N077BCcMybYRooXjIl6mswMWRvbkICavw8+McM?=
 =?us-ascii?Q?z72vHj8jR0U4rzf1tYmGRahAuGq/lqCo4eTrqEgusJZ8E2ftXCb+RIGLuR3/?=
 =?us-ascii?Q?uiyctAUBCn1yk0aGWfwVfOUB0Dbb0DC3X2GhvZ30mKG5eF/eDopFmkn+Xl4B?=
 =?us-ascii?Q?4RcEOaZ3NRfuYUBpQWLKZsCY1Y/sYJaHQzp2qqqI9sMRw+QbGdPFT/8aQarE?=
 =?us-ascii?Q?j5iYzlGTmwnxTcKyXJw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 18:48:45.3959
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7936187-e274-416e-34f9-08de1b099e1b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022570.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9664

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
index 45b1386a18d7..a780e65532a7 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -670,6 +670,8 @@ static int alloc_hpa(struct cxl_region *cxlr, resource_size_t size)
 		return PTR_ERR(res);
 	}
 
+	cxlr->hpa_range = DEFINE_RANGE(0, -1);
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
@@ -2408,6 +2412,8 @@ static void unregister_region(void *_cxlr)
 	for (i = 0; i < p->interleave_ways; i++)
 		detach_target(cxlr, i);
 
+	cxlr->hpa_range = DEFINE_RANGE(0, -1);
+
 	cxl_region_iomem_release(cxlr);
 	put_device(&cxlr->dev);
 }
@@ -3461,6 +3467,7 @@ static int __construct_region(struct cxl_region *cxlr,
 	}
 
 	set_bit(CXL_REGION_F_AUTO, &cxlr->flags);
+	cxlr->hpa_range = *hpa;
 
 	res = kmalloc(sizeof(*res), GFP_KERNEL);
 	if (!res)
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 19b8b62a1322..b57cfa4273b9 100644
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

