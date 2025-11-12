Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011050.outbound.protection.outlook.com [40.93.194.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D6D2D7DC0;
	Wed, 12 Nov 2025 20:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762979532; cv=fail; b=hf5ZG/fIYPOmPPlx3rkTCRsH27kTOy4u+392mZN9DniCwAJQRcJ1NgK/jvhZxgeobRCj2Kj61ceRniLa6X7Nyulaeadn1SHaK/eOiLtv3U43CM3dw8EcePrJvMRpfEzGHpNV2+qG7YU7iFyZwpUuybwecGbcAEhRVrLsMUXCQuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762979532; c=relaxed/simple;
	bh=gJDaZxsgdrW4v6TuB0efJBsG9T6qCm4Z6I9Uf46gQ1U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IGDYIYU9d3Uy+ifJNGL3fDFwXSKcPyPlwTywkvr1nIaSjhXCE7s8tM0cKfwzH/ZyQ+q8CFWRotb4N+q8biVfClld5q8Lo6IdVS3aY83vJMwxjPS5qlR54gVaykEyTX+Vih9ZGa9x9xRKeiA9oEy3Z0DZ5ykiqkTYQwl5DK15fhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RVhgRHb9; arc=fail smtp.client-ip=40.93.194.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RVhgRHb9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qm2wn3pPytunWUKCNZ5+N4rhbAdvqxxw/YlTwqfAtaOZDrfJIpa0LYfbl+KQl8lGGhuP9lQ+dk7YHIFpit0+elzg1PggQ29R4uexJDwxFh0owctyJLhrAXW2IJJjS+AYoXS5QBlGyP9W6mTuCLNral0au5MIfCo9ZSY5Gu2JK9YMkzY1X09rl1plTnu2uPIILF7Z74Ejh4tv9K6uNBwn/kQmVafee/u19vZeuFJp3Jp8UuFeyD1/m+JWjP05BGgfhNRpGymplA18Sy46TPhQLvUF2DqYUIh4JionEbib6beHqToMvK3BWrFlpvFMwoMB2qAgW4p3X3V/XDupbB3VwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=My9gZOyWsgb3WwQl6LPwS0VQzhjhNTTtyxnF3wbxfP4=;
 b=n2XjTR1KKi18l1UPKso0oHFR5dAnCULswV6TOVW/2rWxuJge38v6vEOU6EUmfKwR20zV69eIgbjoTPONguFaquVOuX+7SOp0Iit2W0w7O+gj1uX0X92zbUEHzY4Dq1AWnuBu0uWbRJxmho9GWR6JlJQeTxahyKMI7BuC04TymOppBCYbqjYIXndYhlnmErY5GVZf/rx2zMvQYNNFZ7Z6Y3bM+L1FrtflFEPr6643vRCzJn4QtYnsNXmxP/KkmzAiotqupRe1FX12719hYoTJKuGm9U4fcVGPbWH8ZPaQLJoELVPrkTNzpqvDe3yXsT+nnNnf64OvcdZxI8nI14Sf0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=My9gZOyWsgb3WwQl6LPwS0VQzhjhNTTtyxnF3wbxfP4=;
 b=RVhgRHb9iJQzb3e2xTbC/BoAxrA22c/HXVJBou/LhsD9NDzIXjUa4B92xQDGEUQ4qxLQW4aRPOR6j90EcjG7z9f8l9U4mrQX28o0WWmkjsn6h3LzwB9iAUHQWjwOc7qIusmo6v+HRENlZyTAFJFhLFb5aPVbWsvPFRJQTVBXxtc=
Received: from DM6PR03CA0046.namprd03.prod.outlook.com (2603:10b6:5:100::23)
 by BY5PR12MB4033.namprd12.prod.outlook.com (2603:10b6:a03:213::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 20:32:07 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:5:100:cafe::ed) by DM6PR03CA0046.outlook.office365.com
 (2603:10b6:5:100::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Wed,
 12 Nov 2025 20:32:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 20:32:06 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 12 Nov
 2025 12:32:03 -0800
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v5 03/11] cxl/region: Store HPA range in struct cxl_region
Date: Wed, 12 Nov 2025 21:31:30 +0100
Message-ID: <20251112203143.1269944-4-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251112203143.1269944-1-rrichter@amd.com>
References: <20251112203143.1269944-1-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|BY5PR12MB4033:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ca6288d-b77f-4fab-8d17-08de222a8c38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yp7/7gB1YS0sUNbuvdOIcJSRniDhjeOzfAV2fYaLB9wU2l5hI1rfyTjLyWi/?=
 =?us-ascii?Q?yh+i52trtNpTOeMaEsU4XDU/nQYex+mvRHGKWu6H3FNt3lCOQ+TexHIo/zJP?=
 =?us-ascii?Q?/9E8sUn8P8H9p0HWPdoNfXKKwHKsYEoE82Yz9bafOFsCQBpEhgktxAMPmAPn?=
 =?us-ascii?Q?ZIqhFb0oQtz26cZZtm6HEs/vhA0hPhtNw3q3W/q0/YqF56Pxdbn8j0zYafY/?=
 =?us-ascii?Q?u8QShpWLI9FjLHmR0L1Bmx8vfEIl9FoJA9ctFXXVY/orY0P/CP9tsgeS5XAj?=
 =?us-ascii?Q?bO32jTMeaod4Dvp0Ob6YizIG1iPGBCr7K3l9rUkEwYRFp/EkWN/9cieuf48/?=
 =?us-ascii?Q?K415QKmnU3rrmvCWi/wextqhvjfdcsO0NlQUPpP/kjF6uirWgRLssIg0n3DB?=
 =?us-ascii?Q?XJrkFolJeM+PxEYSrUUqm+1NqkwuvMF14VenwJvrGQjLy+k1jUhIMlWo5V8B?=
 =?us-ascii?Q?vzrnvdJnxz24MAH8W1YWFXao2729vvvzArPeqcdHabdvzMU87vu8EHL7CpXS?=
 =?us-ascii?Q?2gN/xI3NbRBqy5j/TaInBUONOuc99V7J9YthhJF69XWizRmdM5WVFniZX6Kx?=
 =?us-ascii?Q?9BA1kziXBGPwGojlYs78rRVAppZ6XjrXbtRsVAT8dp3OrB3Bz2RDXW02gcvr?=
 =?us-ascii?Q?F3gzLfZtIhCd6N/9h6UhvNKOY0Op7F1X+AF712le3hPY3NnNcmv4wFYx5veH?=
 =?us-ascii?Q?boA5+iJ83O8FPXP9/4QWYe4GZ5tfMRubaK96sxocfPq7/UuKqCBBIo0F7Lv2?=
 =?us-ascii?Q?4F0rJ4Ixy6frsyIhuq5TbSHOYObBBrfACaghPoa7h6isdGeW4eOB13PZhUFo?=
 =?us-ascii?Q?Kf1V9sLpIcqbwjZ9nqaapRrkuYR7l6rXEtlN6pWdNKrEzd1h/m6AtdHrj40h?=
 =?us-ascii?Q?7bYJdAZEy0A/ePIfQcEHzqxRx7AOAdpTwketa9vXfwyNzs87mX0bU551RVYa?=
 =?us-ascii?Q?V3JbyLXbPAY1NTDwROKjyx1RXyrtsAFVgqwgD/FoA9hZPwuSBv2+zxOwzdYP?=
 =?us-ascii?Q?4e/IrwqCPMqDNFuwggW3XOIq6jtulZv8yAfq1qvANhstEwUgBbU3Gppg/mFW?=
 =?us-ascii?Q?TpAnBV3oxOXc0HeU8+AyI/NalzdaKWiJ1HsKCg+npOJ+ReRboNA5M2Sw74M8?=
 =?us-ascii?Q?36fmgO7gL4ADIL2yXgidgQPpZhPXgpmGVq6jqQdPiryitnjPSPazyuii4VC4?=
 =?us-ascii?Q?RSFpl1JRJ7ln78+XLln/h+7NTpkZVoSuu9d/icQo+pm+a5FpVdRqoGR7rhR1?=
 =?us-ascii?Q?NdOIhwsSzE5+G68+ZgtCTTCpPkz+TE2nwRFAg6NP18iOdRkdZv2mpit1Vwjy?=
 =?us-ascii?Q?DSEQpWTaxKhDfQYeg7S2zYa1h/Z5Aj0PWeoZmDMcymprr654u2lzJML8oo2M?=
 =?us-ascii?Q?kJ9ewfSrQULsQ0/ecm+/J19esLP4UYyCdMw8oKQ+gBdvMjNOaX8MiPeKaXoU?=
 =?us-ascii?Q?A28Ay+E8ogzVR5DkswjFIOShEUgYHl4YagNqI88oa210Ck+gpwkvdV1XYv40?=
 =?us-ascii?Q?yxx94AVZWmjpmRQhFTplljfpnzbalDGLVRDFEKGCtCFvDgX+RjtsV/tpbZTv?=
 =?us-ascii?Q?kktYLcydJ4V+1T/pOMg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 20:32:06.8997
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ca6288d-b77f-4fab-8d17-08de222a8c38
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4033

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
index a7786d768699..5b9d096a73fe 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -655,6 +655,8 @@ static int alloc_hpa(struct cxl_region *cxlr, resource_size_t size)
 		return PTR_ERR(res);
 	}
 
+	cxlr->hpa_range = DEFINE_RANGE(res->start, res->end);
+
 	p->res = res;
 	p->state = CXL_CONFIG_INTERLEAVE_ACTIVE;
 
@@ -691,6 +693,8 @@ static int free_hpa(struct cxl_region *cxlr)
 	if (p->state >= CXL_CONFIG_ACTIVE)
 		return -EBUSY;
 
+	cxlr->hpa_range = DEFINE_RANGE(0, -1);
+
 	cxl_region_iomem_release(cxlr);
 	p->state = CXL_CONFIG_IDLE;
 	return 0;
@@ -2433,6 +2437,8 @@ static void unregister_region(void *_cxlr)
 	for (i = 0; i < p->interleave_ways; i++)
 		detach_target(cxlr, i);
 
+	cxlr->hpa_range = DEFINE_RANGE(0, -1);
+
 	cxl_region_iomem_release(cxlr);
 	put_device(&cxlr->dev);
 }
@@ -3568,6 +3574,7 @@ static int __construct_region(struct cxl_region *cxlr,
 	}
 
 	set_bit(CXL_REGION_F_AUTO, &cxlr->flags);
+	cxlr->hpa_range = *hpa_range;
 
 	res = kmalloc(sizeof(*res), GFP_KERNEL);
 	if (!res)
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 99e3a1a6587b..4cb7f66b9483 100644
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

