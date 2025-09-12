Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBF63128C9;
	Fri, 12 Sep 2025 14:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757688359; cv=fail; b=ZrZGiWv919YQd9i/eq/6QVFPdlfoovbcpZU57ts76no+S+VJMnzNBmoZp2CqZSMvSV2D7AFSc1o249d2IizFtpF6VAaptAFnUiSH5hrbPTShD254/aS0g2u5sYL6T7Fh0XFAuusy0SLwwcfUTVj0KHpyriT2n8X3BwWZTfu1oF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757688359; c=relaxed/simple;
	bh=rwIp97opEQZJBhC4k4YKxmTMmhjzj1bjNpAQFSkCXss=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WRvaB7wPbHLYY0/GC/9Ts1rP1xzxAeEtHnjlaAXDN7OBPX99jPi3WLLlsUP5Q0jBE6jv4pAgIVQTR3O0oHthCLXWFxh7q4AcCkKj+LFGXhAuJKWPA/lEuuBH/yUqB8AzR/ZS2j9R/INpZTIEu6lureBV/1uMRLw8KvVkrIeqYOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=r8tnH+Hw; arc=fail smtp.client-ip=40.107.223.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="r8tnH+Hw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n3RpEJomuSPAq7oFsuFQ5IQfFrowX871ywHjfudH/wi1iRhTYsg/+RuJSo3F1gc1e4y7Y4ns5lfEFk5ni2Zy5yVZZMDXoM1Vnxoc8HWZRJTuqA62cxsTB9LEfhLCi9Iywz+4EOysSto2ym6cW7vpPWCTygk/vhrPQ42+QT/kVNSdcUIvVSRw+txh7hJRAPDA3G7nGMbgbBt/GHAAlb95wJR9TQbracRnITGy+JiUQQobVx1y5ZYfunCMDnD9FsFmjHtKI8t7Z7MCllfWgyD9PiqtCDm+6X3nN6kvaO2qyegC1z3aqmiwg7QDgPK2dcgEnWbKSKDVOIjoRkxMtxTTeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J5iVcwxhs3vipzRg4n17Hok7SqfSHhif+5Z6pQdaSno=;
 b=Sz3NEh8TRVwK44TqNwaScizB8Y6EY1o9o0PjoSMbV0eTHnnbmV83GW6EESFwzLPFaC0moZevhPYworJHuu9RG5DH/i7FaWwJqGFZwjfiya2P1KNjRfWiExglDK12bqv4IthyPD3IDruJkF2Vo137Eub2bXHoq4NshmwYIFkOX5hHZTMB0ySMT2rrJV10Zcu8/xUXQA1zg0+veWNI6WOhMKmo84Ojpm3wNPQXcd8bNUPdRzQtnRoF2Chu7QUy+QwpYV0WdNcyw7dlTh/6ygVdl+OPSWkMvS/oARzxKygkrNK5yCLK0p26XBYBopDIbKh6GdrLbxEZ2MqV7pXHBye9xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com;
 dmarc=temperror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J5iVcwxhs3vipzRg4n17Hok7SqfSHhif+5Z6pQdaSno=;
 b=r8tnH+HwfvJHPyzy8+qECS4Hg84T5YLmW8MAv2iXOQLpnlOs2SQZ+P/6+1Xj7DZn+fBJQSTKZVjHb4o2bf8fukcjx9b7gPBJnsy+eySfpjW9nn14hT+iIQZKFsX0PrHvugE7rqBHhvc9JMHGibNijstS+ADRcB+pFuTtQkFXJIE=
Received: from DS7PR03CA0035.namprd03.prod.outlook.com (2603:10b6:5:3b5::10)
 by IA1PR12MB6212.namprd12.prod.outlook.com (2603:10b6:208:3e4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 14:45:54 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:5:3b5:cafe::b2) by DS7PR03CA0035.outlook.office365.com
 (2603:10b6:5:3b5::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.18 via Frontend Transport; Fri,
 12 Sep 2025 14:45:54 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Fri, 12 Sep 2025 14:45:54 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 12 Sep
 2025 07:45:50 -0700
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v3 05/11] cxl/region: Add @range argument to function cxl_calc_interleave_pos()
Date: Fri, 12 Sep 2025 16:45:07 +0200
Message-ID: <20250912144514.526441-6-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250912144514.526441-1-rrichter@amd.com>
References: <20250912144514.526441-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|IA1PR12MB6212:EE_
X-MS-Office365-Filtering-Correlation-Id: da079c8f-be7f-4ab2-e691-08ddf20b1370
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WCf8VBKM8Auygb0f/jh01yQ4McHfCbIsnYpEBwT+2apkqhEQ4n+H5ZEBeuOF?=
 =?us-ascii?Q?4Bufd9v0AwbGFFdOUXPtm0A79AxOF0CpIHCvhpwqZ6HLK0NzARVCwyDtHU55?=
 =?us-ascii?Q?BnivRYZ5vKBRd/jCYbLTUtFQJqlQgHn3mwscfjxFItEG/JkAc/OAkVplEYMb?=
 =?us-ascii?Q?0XALor4kDjvu1HLDN1kuUfK2dpt6SmS/kqcA8HDwEtvXmtSUEICsouR16kLQ?=
 =?us-ascii?Q?V8WCuaeOOrJawwQv/9s2Mpr8DxbEbrrJHafYiivYQKeZqd+gm7FKIoeGLNFP?=
 =?us-ascii?Q?dO2OMsYBYtK0nmUnAz5TgVASNeqtFHaIwe8hFfO8Tl9qM0spJGJdim0+WG18?=
 =?us-ascii?Q?6nzSJNsgIWIe8KZnLiZ6uf4bDInYYu9BiQpRes2GUaMfwzRb273jzlBouAx1?=
 =?us-ascii?Q?rTIwfOhUWRubAwIVDTAQftIGWT9Dc9MTeCTuMDemMY8P1r4tgqG3pywYBMOP?=
 =?us-ascii?Q?G7Gu22BR/gqXsMjjeXbVeM7SaN0l8K5951aRJMQgyWG365GMox3KOliRsGMF?=
 =?us-ascii?Q?NN1Y2yFWT/ingp7r1JozpL1EHPgJYbgce/gFHBo038VSqJbkjxpUIw4ghcIp?=
 =?us-ascii?Q?HRGUu7KTdQV2d+kxqHYB91BgOnw9eUKIPrrWy2KXE1Bc/92kqHdjQm/5WTW6?=
 =?us-ascii?Q?MUaI/Xz8JS/2i4wKwGJ10HEQUOGPKnMZMLGW+UeZtLuK117W+LhsiWe5291e?=
 =?us-ascii?Q?LYFAW+ayyEE1eeXhOOBd8Vu+YWAQzzTD0bd2l7v5zPmftlv4xYwbMRaVzxB0?=
 =?us-ascii?Q?0YE3oIbCvMWqNqtlBuolLu6AjRXpMYPB7UedjbDyjEb62q2E4WWOit3KYIiT?=
 =?us-ascii?Q?QBgPj0TzHbNuGA5N8OeMFtevUtJnlRdMWkPz2EtZTZtzOvAJPOY9lknhrhcL?=
 =?us-ascii?Q?c3UYyc7vfxGrfaj30e3u7W6tfK8QK80nOytizJPzTygIESCMtME+WNOalX34?=
 =?us-ascii?Q?agJNQexuKKtr5cseBgF4ODJP1hOeApf19VKexxBL5z1rpUtxUZMz3jqoYWbD?=
 =?us-ascii?Q?cin8Optgu/M70B6KYc5O8MmDVM+T6v33BTcNu8rRdSh6ZM2JHhvC7JTsDW7U?=
 =?us-ascii?Q?0UT7I3ojOHgiY2sWBuRPPn1MKZuHdgAWQGW71cYN5NAMk3lpGBVSlEPQDqgU?=
 =?us-ascii?Q?n17ffdxCzXwVT4zyVGWDcOpAukTD8t2ZR4N/V4f1ZQWKjuWpO0LVshhB2mdm?=
 =?us-ascii?Q?oqA/6sZpQiCitQpwOEjn9hJO2ukOEzvVZAY2OOGFiXsrSVlNEJIuSmDNOOFT?=
 =?us-ascii?Q?AYFG3iUGhoZH1YSbet5AJF0g/v+qtmqTAsct33aZE2wru9vMGKC34bo6ZRYm?=
 =?us-ascii?Q?hUGbpe+LwXBD9y+XQfbPUBBQIeFus+bj+zBqu4lLUpTNjE+irX/kRQA5h62d?=
 =?us-ascii?Q?1t9T1anCJJYpp4h+IcrcxE8iY1wGl4fbBCootsbz1xUjl3jsiJqvt64HWGRf?=
 =?us-ascii?Q?wOnLq+5JIrP8m3tUmFvnD1rXCci8xSv0NYlAKY8M53kr+htlySxWfoTNDPxE?=
 =?us-ascii?Q?iVJGIPB9/81QQ+QhIEsr+tbo0kMquxRk3jRU?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 14:45:54.0463
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da079c8f-be7f-4ab2-e691-08ddf20b1370
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6212

cxl_calc_interleave_pos() uses the endpoint decoder's HPA range to
determine its interleaving position. This requires the endpoint
decoders to be an SPA, which is not the case for systems that need
address translation.

Add a separate @range argument to function cxl_calc_interleave_pos()
to specify the address range. Now it is possible to pass the SPA
translated address range of an endpoint decoder to function
cxl_calc_interleave_pos().

Patch is a prerequisite to implement address translation.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 8ccc171ac724..106692f1e310 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1844,11 +1844,11 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
  * Return: position >= 0 on success
  *	   -ENXIO on failure
  */
-static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled)
+static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled,
+				   struct range *range)
 {
 	struct cxl_port *iter, *port = cxled_to_port(cxled);
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
-	struct range *range = &cxled->cxld.hpa_range;
 	int parent_ways = 0, parent_pos = 0, pos = 0;
 	int rc;
 
@@ -1909,7 +1909,7 @@ static int cxl_region_sort_targets(struct cxl_region *cxlr)
 	for (i = 0; i < p->nr_targets; i++) {
 		struct cxl_endpoint_decoder *cxled = p->targets[i];
 
-		cxled->pos = cxl_calc_interleave_pos(cxled);
+		cxled->pos = cxl_calc_interleave_pos(cxled, &cxlr->hpa_range);
 		/*
 		 * Record that sorting failed, but still continue to calc
 		 * cxled->pos so that follow-on code paths can reliably
@@ -2093,7 +2093,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 		struct cxl_endpoint_decoder *cxled = p->targets[i];
 		int test_pos;
 
-		test_pos = cxl_calc_interleave_pos(cxled);
+		test_pos = cxl_calc_interleave_pos(cxled, &cxlr->hpa_range);
 		dev_dbg(&cxled->cxld.dev,
 			"Test cxl_calc_interleave_pos(): %s test_pos:%d cxled->pos:%d\n",
 			(test_pos == cxled->pos) ? "success" : "fail",
-- 
2.39.5

