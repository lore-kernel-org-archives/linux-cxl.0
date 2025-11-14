Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012004.outbound.protection.outlook.com [40.107.200.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EF126F28D;
	Fri, 14 Nov 2025 00:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763080905; cv=fail; b=pTeQGRtZvxqpq4QMBqW3zB6IRt90YnUmznsHL0lZHORnkeM0eoo1W4YxODnl9y4eXGWB9dl+f3IVwirY0rkKLoT8u9E0r06c0PHD54PvOYt5B69w4jB1qZJwlnR6Ce90uQhWG8Cs0lrqvDn+6bim+SBVkNH9apA96FtnuYsazJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763080905; c=relaxed/simple;
	bh=ZwEUSBt3BzCW4o1QzK5TYxo+6JhVfVXjnKYALU7/JtQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UuPsDvqnELZQ8U/qJxs5eWTvWziWIKLrv37/fRtXenaNHf3GlAJmB9BKdfQqGkdF5cmqeFU3jR5tYFdd52Tfre5mKpUDYSUsvh//ozLk5w8ydss4lcrAmyu0/heybWO00p9606S1qqsew6MCMt3gE1fy2s0DNRn8u5cETubcKgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pYT1F0JS; arc=fail smtp.client-ip=40.107.200.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pYT1F0JS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nVxY5C3WPh4BVRKc51PNlYk9iT2wPZHUo3vDAQT1yotN1ZlJDXi/JV304zaQZ4idsX0dYVsHl2Lzb8bE8N+ZjZ/0qBRg0NKRoKrN6om2VuVru86ktBmSmQzeqx8JQNlU0eghiJOO4bhKv7m9nXgpl/vfSOmF8Bdr2kt+WxiVWAWRADd0TEnKd39emjItNA/S2Eu1BAsljieX+0zowlN6bnl1eKvEE2ol8G2K+JrFmIMfYrgmqj+9hcmH65xcQaWUfRWKnrol8sqVgF9fJ4Ng52QJucDuPmr+SEdfWvCt91oA70qVVJ1IrVCkVTysgZ38aRlLF33TtNnV0RNqK1AFwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D1SRYRj549j2XPnJd0ES06nTnLWMXYj7DmwV5/M5kgQ=;
 b=RDKO7Pg4GBVXRoYdaWRFDTJ/kUBvQfFRoGJLYLzrJldUs5gQi4157D+EEV2RP10X8ZtPgz9QK57J9pbcOeOX/MdsDlrTwWZiswuk2CU1x0+WYet8OefZDcyPFJQzKv/jv+oyLmr9kk4WMId6ulxykdmLsp2G2bRRotjT9VT8Wer4Tf5p8Ys9L0R2TZ6XNORxDiAd2DZ1TCSga8w98XMmjejXPiRePVLLXKSmYdJC+y1ABpTZbudH5JHOz5zEfktUxfU2t+CM7Vfdv609cgHRL56KzhA7/djasGHrFTV72wKNAbPTfhAxK6/uvrxCT+Val/58kh/+ryynpLA4Y3LwOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D1SRYRj549j2XPnJd0ES06nTnLWMXYj7DmwV5/M5kgQ=;
 b=pYT1F0JSs5s4wwNDYpFOyKk38dM+71sJmprmB9TrB9njGfguQF+NShPN0z8rthG+Xt5vLYF7Obmd2gvf/dgQs0aT+YrxNmHtQVQuaRVsev5qehEOfl8pBtswL9+wT+tYo4/VXZiDJJeDt/9sNysFc/8zzv40ZaA2ZLCCgCyj16k=
Received: from MW4PR04CA0386.namprd04.prod.outlook.com (2603:10b6:303:81::31)
 by BL3PR12MB6522.namprd12.prod.outlook.com (2603:10b6:208:3be::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Fri, 14 Nov
 2025 00:41:34 +0000
Received: from SJ1PEPF000023D2.namprd02.prod.outlook.com
 (2603:10b6:303:81:cafe::5e) by MW4PR04CA0386.outlook.office365.com
 (2603:10b6:303:81::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Fri,
 14 Nov 2025 00:41:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D2.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Fri, 14 Nov 2025 00:41:34 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 13 Nov
 2025 16:41:29 -0800
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v6 09/11] cxl/acpi: Prepare use of EFI runtime services
Date: Fri, 14 Nov 2025 01:40:14 +0100
Message-ID: <20251114004021.1310661-10-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D2:EE_|BL3PR12MB6522:EE_
X-MS-Office365-Filtering-Correlation-Id: b10718e4-5649-4343-59c7-08de23168ff2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oo2SQYQLnaSvGxJjCqn8YRe6y+2hv1Y4zge1QUDJWzbnh4ySXNLKzd6pebFv?=
 =?us-ascii?Q?cM7RI0+c3qEMrfIEovs7NzsSKb/dEVF7HHLdjARpixzX+Tto5Uy3j5/zTu6u?=
 =?us-ascii?Q?F8VgoglPWHDNV8VowrdU6A+cjtW5vGhzduV49K11ZQ/DFiBjHlMDkeH9WrRx?=
 =?us-ascii?Q?oCDOuj5nhHaKrscOxkG5/M8fLRhDXg0LrQ25+z4IhM9TVFnFgG0T/dIyIo8E?=
 =?us-ascii?Q?lTFYnooGZESwVNeexlxRq737YYl72Oo/gpuCa/OTMrgXys1wExR7pjcOrE/r?=
 =?us-ascii?Q?RlVpyTiltKhTdB9FyE7bxpYlZ55VtEw2ye0wUUAqVBwXSJGUrXu1uX1d7QKu?=
 =?us-ascii?Q?vSu6EDEDy9AXTZnl0QFFt8C2TMDyiF9APIPgNGFRUZVm8aNL4ycN6yIcB8jZ?=
 =?us-ascii?Q?IBDUslcmssqa0iOZnWhE0QT6UUgGsXB6Ys9BxXZiNISqTclQRHBUCX2AYI7q?=
 =?us-ascii?Q?ColKtw72jvpdc9Cu/ORIfFeJW+BEqHO2H9X2K9kUh5mHFEec2XXl6AVmt1A+?=
 =?us-ascii?Q?270Rer+y0kzE7bfvHcdGMjUebiAMkkUB0Au8Uq6Bi0qeIqNlCK1NAQjVqf/b?=
 =?us-ascii?Q?P2LefJ7eB+k0GSKSDa8JaHIpG3ytDBEyHMyYaCCEgLmhKbFHBf2Ph+mYdfaU?=
 =?us-ascii?Q?j5nh8NhQk8bKqWyTnqtHWv6e8XpGZs4oh+Ph+Asya/v+7+v35teikiUzt0ql?=
 =?us-ascii?Q?4h+nV8B9z7BJomMHrZ4ShP+kFeS7WOL1U6RiRsNUrbi/XZh1KbIy+Pv8Lu/z?=
 =?us-ascii?Q?o9rxgZYtOUtgoCCqMHF3JAVm8aT/Z4vHN1q/owYuG+IM8ZKdc3vTaUuldwA4?=
 =?us-ascii?Q?XS6I75nDRKXBb4DyExXLf/Vj8JfLOpA24KMpsUeyqLJChTzNLTpTPADvO86B?=
 =?us-ascii?Q?9oQKg8iX3cy9dzIr0hLuBukq7Y5Aw2FIxG9gh6s6CuKfEVyA9KEGji2LRbVp?=
 =?us-ascii?Q?OMuZUeG856bHwkmILFzko+euycZTJiO747BXZrnBUvqRD9iTJPAZf98EAxis?=
 =?us-ascii?Q?HpgRsTVXszrbsTynahgcwhSehxsJZTbU0mcAVMMCVkLcxbgoLgMwyrRE6MvC?=
 =?us-ascii?Q?x2BxvZJY7LBoEb8+WYrqUasxKZHVWlj/XsgnYIKtWLjw6ubaR/r2hENQiOtM?=
 =?us-ascii?Q?xBS4XADVs1RP0ayOF6Fqo4hGtCP5VnaDqjq5L+B1l6hhzKCU8GaKWWu4/jqO?=
 =?us-ascii?Q?urA0Oc2Jgbe1U+/HBpdpyFOPZdG8+JWGKhw43kjH7dTzjKRZR+MIANp+FQV9?=
 =?us-ascii?Q?V5sip4wCYqMf4R+y38x72A2MrDjBMI0707QD8SdWVhTkzd44KWwvviGqBDjv?=
 =?us-ascii?Q?m79jO21IbhqvRSwsGX7kRpVmfXy8C7Dgl7Pv3nPI0B4mwPlo6STHpdyPdnkj?=
 =?us-ascii?Q?ms9d4NOpphOtMiFcWnl+Adqr5MMSZgauhdllalgzWKFUjl7jcy/yxr4y4twI?=
 =?us-ascii?Q?wf3RSOb6V7CgcVbJj4SNX26AwRiyGxGUVoCsOzzwrchr7dlmCRnKJH+c0y7P?=
 =?us-ascii?Q?uv9+bqczJSQzyU5CuLgBiwRsfO8mFXfa+5oDZr0WonBBGI3v8IecIMQ6TnB0?=
 =?us-ascii?Q?oZ7UgaZcvqPG6bykj/0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 00:41:34.3121
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b10718e4-5649-4343-59c7-08de23168ff2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6522

In order to use EFI runtime services, esp. ACPI PRM which uses the
efi_rts_wq workqueue, initialize EFI before CXL ACPI.

There is a subsys_initcall order dependency if driver is builtin:

 subsys_initcall(cxl_acpi_init);
 subsys_initcall(efisubsys_init);

Prevent the efi_rts_wq workqueue being used by cxl_acpi_init() before
its allocation. Use subsys_initcall_sync(cxl_acpi_init) to always run
efisubsys_init() first.

Reported-by: Gregory Price <gourry@gourry.net>
Tested-by: Joshua Hahn <joshua.hahnjy@gmail.com>
Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Tested-by: Gregory Price <gourry@gourry.net>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/acpi.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 866813e1b729..604cf995d0e4 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -989,8 +989,12 @@ static void __exit cxl_acpi_exit(void)
 	cxl_bus_drain();
 }
 
-/* load before dax_hmem sees 'Soft Reserved' CXL ranges */
-subsys_initcall(cxl_acpi_init);
+/*
+ * Load before dax_hmem sees 'Soft Reserved' CXL ranges. Use
+ * subsys_initcall_sync() since there is an order dependency with
+ * subsys_initcall(efisubsys_init), which must run first.
+ */
+subsys_initcall_sync(cxl_acpi_init);
 
 /*
  * Arrange for host-bridge ports to be active synchronous with
-- 
2.47.3

