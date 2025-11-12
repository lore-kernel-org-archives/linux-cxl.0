Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010057.outbound.protection.outlook.com [52.101.85.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905F62D7384;
	Wed, 12 Nov 2025 20:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762979560; cv=fail; b=J39GQl8HMfvSfDHLrlTJTTAxEkc8AcKGtl8SVZlgqxA/wczqXta5dt0M+k+E43Dfb8hAeZECksLnC439wXT738U8Ul3fcfTw0ADtiL0uwpzjHAXsbhcsHvwGy5maPwogSi7HXX0cY5lPqAD3MrV9l6mOQ6aFc8lYcqhmjBBZcKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762979560; c=relaxed/simple;
	bh=fmPkrHHmJHz+BjwGzTLIHNx69R5QxyCJDSJYO7tOfaA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ino44TXKelpAOIKLCxe7L2dX8VHa5wP9v1vUnGA9Kq2na01gEVblf5Ds0TXE8Dl/7vhzlk8SU/A6X+32GE1+igkpgxKF5SI9eM4YEWpxbDwrZ4PHD90uQ3zjaom4eoZTIJlxGs1bA88XpQFZRYOw47UQm2+1rguOGpelpyBzfc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HwgqxWrM; arc=fail smtp.client-ip=52.101.85.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HwgqxWrM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CM55AWj0ptC/b/4ZVQ+Q0rZwtxerbsuqaE7/UoaIlHLqIx6zdhuJLinSpy/Vu4NDnV8Ef6ggZV5+85BwQ2y8EcDhhe7ezroCddirO/40b6neCo/hYHTPWWv9bwj7M2uGsPEe8sngdCbk08VRyfrg8QgLiijWsWUa92dXco0m2IT2jwi8tUPtW452g8gl6ChbLWei9RUpbXgBW0zmIZoqfwCaLqdze48RDmTPdqLOhX4PXtlZZ/u3gwqwso4Aeesexgp3dTxKJTVbxDccEQHJc12vzA4vvNxmf6QQ0D/xoNkhe/inSnxRQ/3hkTMdNRu8zVvDfeRMsUUWrImAvjNm6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4f138otZxepqQcsYuXrlA+i4xSPSAgzNPKcGE+Dir3M=;
 b=qWwss1l0gImReNiX6/7ORW7OSNzxPI4Ev8LsHCtR2GXnd/JR+dMg2LrkaiSMiF0XqH7deY4MRjYXMTnOh8zHCC8qBULAPDuo19tRCgitPKHa1Z5B1Vf7iPt3NZQKg017kGImAE74rxTSbLOp6WKFg1m297v0J1aJ0OWBSMQpjHF1n6UUPBPVR1MzEH51hqzuk00L1/XO94apShUUwrjIzO54SHU+grpi55omacpgzthf5YNdmJL85766JPh9mSm7FN74oZhktsvUv6Tjq3fat7GHpHhB6ZiuSzxR+AD4O9WzKo4tnvcUibjVBt38sR/gdT4br5z98DU1WbKClLf06A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4f138otZxepqQcsYuXrlA+i4xSPSAgzNPKcGE+Dir3M=;
 b=HwgqxWrMRoswihjJrdNc0gLVSJChbaJ5dSPUeY/eVqX3a9z6jtS21ELTaArJh6wugFdRYtJqtZtC61FLMquE93TqtPJgsvlFl3mySpaAs1jF6Z9oJfjwBkw7PjRFJ6tc01hVx1EjUWnDvJHgb85TMgVxHqIZJVX/il8sqkjZejY=
Received: from CH5PR04CA0017.namprd04.prod.outlook.com (2603:10b6:610:1f4::17)
 by PH7PR12MB5830.namprd12.prod.outlook.com (2603:10b6:510:1d5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 20:32:34 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:610:1f4:cafe::de) by CH5PR04CA0017.outlook.office365.com
 (2603:10b6:610:1f4::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Wed,
 12 Nov 2025 20:32:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 20:32:33 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 12 Nov
 2025 12:32:30 -0800
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v5 11/11] cxl/atl: Lock decoders that need address translation
Date: Wed, 12 Nov 2025 21:31:38 +0100
Message-ID: <20251112203143.1269944-12-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|PH7PR12MB5830:EE_
X-MS-Office365-Filtering-Correlation-Id: f692d31c-8cc9-4e99-12c1-08de222a9c3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5owwamdWue1/Ah7V5EmL1dGSWstC2i4xcVkLcKkboP7IbgGHcgYW8SM14ruY?=
 =?us-ascii?Q?ljrS/FdnfEGcFVGhgCSJzcDUoVRa2PR8CWOjFmESb9IZsloLzAZvMQpXhKCf?=
 =?us-ascii?Q?2zsWG1OtGmn0DwYpBkQT2w0fxtJLoL3x53dQjsuDxEMc0v67RbAXNcHLBE65?=
 =?us-ascii?Q?+U5B4LDPUm9V+WvlSR26SIS/kgQgpOIkacuYbNNV9OXHjPhpiDP9ZdJCpsVs?=
 =?us-ascii?Q?bGia3vkYLY/t/RMvL/rPGqoR1ggM3oC2BZ/842gyRU81i2yboZJRCQFnt6J+?=
 =?us-ascii?Q?pPBbKmhSGw5npTF5zQqXmBB2+77Mx0cE2NFau+xCW1V3vUa+wW2jvnZfXNX8?=
 =?us-ascii?Q?wAEVKreaN6uU5Dfwmzn/4fyFxSJ4VEUjmi1ctj4qaR7ymOj/suCJBLgMSmKu?=
 =?us-ascii?Q?aiVzqTQni/5TmQXCeNQA+6++TKnbNVoR78JALHuaxtfIbJfkAo2lXefqGc/3?=
 =?us-ascii?Q?hOlQBL/k6WcOt6EluGhrB2VIf9TTXwYwy0mEShM241DgKE8syO3o2TTBpuPE?=
 =?us-ascii?Q?V2AtN06px9wtFC/8EKPGqu9D09wvZIWlTkTrTt/cj20SpW5QuKEfVkyRkOOw?=
 =?us-ascii?Q?cIhLdnI4xMJujqwheAaHUJAdEJRroDg1GSYbKQDXj/WVifqt11XYVB2iwanX?=
 =?us-ascii?Q?j4godB+CTEPqOdogsYabmG5o/bGf0JpZvkmGjnHkJPsGLuaw32i6x0PQodUn?=
 =?us-ascii?Q?+iBjwOoFImpzp2YPMLWC+tZR9XAV6IWzS7t1J28wTMkGCuJuzmTeTr+3RrZs?=
 =?us-ascii?Q?HcGcjpzurmVejNhwttcc5UBmo+LX66D9B+IG4YWOAhzHG4Vq46lfw9rbCKMs?=
 =?us-ascii?Q?cQlhd9936J0Iw5Ig81arrCd1y0SB+tMkNDuDtucnFSHWu7pyodAa2d+9kGYt?=
 =?us-ascii?Q?JeGMs5eNu77md0HAmxcOslzzEPaoMXsH/2sDlROBa7bmsftzgD0U+Roid0ql?=
 =?us-ascii?Q?o6UKB4jgNMp/wgdnIrgxl4MFFJ6JNwIUmfG4wXnMYLXYfo/kRvgSmD+3XzQp?=
 =?us-ascii?Q?oCxg78LBHi7t5PZzPM6rOrIAjf4bVv2zqeBJQ+Hz5nSi4Kym33x1g5BTkZVk?=
 =?us-ascii?Q?dflRf+rDhuZpJv+IkrM30deQXJkWQF4eqzRNIf6mMMqbPEZmqHXfCo1svm3K?=
 =?us-ascii?Q?iPWPuTbwO5QRTYOPFSv6nphpWgYBu6wttyZzuAoDFj/eOhQhQjhVA0/fg7u6?=
 =?us-ascii?Q?Wnnrl6ss2sl50hOFXeWbfxI9Q+39vbs8kplnWCByiaLWMVbXSyD3e4Hbx1NB?=
 =?us-ascii?Q?AiFn4shJGuyZiUhu0ZWXDyO9oAKoqHwyqIEOGM1xQeu8W7V5pmwfZo+J2LpN?=
 =?us-ascii?Q?8LKaMO1M4JBHO2oxhw7ZMGXswLlXo5wZ7iy4cMn9bxGGBESontvurOJBbBsq?=
 =?us-ascii?Q?nPWg2gz2dbeJzh/cfHXYyQ7ROprMbzZlZzV/q3/7dw3nxyugAopk32lXU05+?=
 =?us-ascii?Q?rXJl6JwFSB/2Yn211Fj3NlyOuqkeb/HAnFtcpzq1mSUgrllUsLZb+h1f2t9M?=
 =?us-ascii?Q?I8LHxL55ojICvhUq1cAS9uPL6uczMSxU4YlrWugC2rp+te5x+M3FuVX4iosW?=
 =?us-ascii?Q?JFkr4qnnCB3Bcw8RXnk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 20:32:33.7477
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f692d31c-8cc9-4e99-12c1-08de222a9c3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5830

There is only support to translate addresses from an endpoint to its
CXL host bridge, but not in the opposite direction from the bridge to
the endpoint. Thus, the endpoint address range cannot be determined
and setup manually for a given SPA range of a region. If the endpoint
has address translation enabled, lock it to prevent the kernel from
reconfiguring it.

This is more a limitation of the kernel implementation rather than the
BIOS. The BIOS provides enought information by CFMWS, PRM, HDM and PCI
topology. In theory and if there is demand for it, support could be
added for driver region setup. For that reason the lock bit should be
set by the kernel instead of the BIOS.

Reviewed-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Tested-by: Gregory Price <gourry@gourry.net>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/atl.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/cxl/core/atl.c b/drivers/cxl/core/atl.c
index 3b02999d3c59..4f645f71b397 100644
--- a/drivers/cxl/core/atl.c
+++ b/drivers/cxl/core/atl.c
@@ -161,6 +161,16 @@ static int cxl_prm_translate_hpa_range(struct cxl_root *cxl_root, void *data)
 		return -ENXIO;
 	}
 
+	/*
+	 * There is only support to translate from the endpoint to its
+	 * parent port, but not in the opposite direction from the
+	 * parent to the endpoint. Thus, the endpoint address range
+	 * cannot be determined and setup manually. If the address range
+	 * was translated and modified, forbid reprogramming of the
+	 * decoders and lock them.
+	 */
+	cxld->flags |= CXL_DECODER_F_LOCK;
+
 	ctx->hpa_range = hpa_range;
 	ctx->interleave_ways = ways;
 	ctx->interleave_granularity = gran;
-- 
2.47.3

