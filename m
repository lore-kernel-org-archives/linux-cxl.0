Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50434269824;
	Tue, 18 Feb 2025 13:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739885079; cv=fail; b=kBIuzJx8OnSsg/1CZ3RQKHpzNE8/y7161wAm9duX/8HwgldgEFv0JWJY9uG4BdkSMon+OcetJtPbOEXJ7fYWkPR4yBjkAcI+V11ugM8YDzxDpD0tp/+Dhc+dR+P8hOC6QcCzMVm8c6vsN3QrmXxHXD61VM5n7/o5TqJOq8QgEb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739885079; c=relaxed/simple;
	bh=WFGbGKQrQQwa3mhGhALvun06ef25Xmj43773LzX/rjg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lq1GivPD8n5o3PH5jFBWIKPWXesGsfAp7dPKsV5UyOHEugoZAkDbPJ25XAM7yM7LC1+BMvAUQ6qLKc5Y4P7CwHgVwoXs9vyx5GtlQEgKJAea11dcUg2UTwkCry9azpJKJ4UZ7gmFv/O/lswvEWs5NS7t+a+HlWG0YMyoercWrOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dV8tLgzk; arc=fail smtp.client-ip=40.107.94.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dV8tLgzk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hvKrNsXsH+cu96YuUnIoX3wzKoO4nO8UWXLHu9xBdpWOWmlBSBq0XG1p4f7lxNtKPAYhFAPoMJMQcE/UrtmNSniAXebsSGcWlhGt8cFX7D4C4G20bTSPRfdpNnWj8yuCS8FI4172cqZI+hG+miRNI8lD/S13QB9dG7sXeFf1EidoTSGsT7IYaXAB7eEFkOoiK4cilFbqrChA7NWtGkZ4jcd29WyFhWmwggIZcZiCQ9btND4G5ltq0Sgy1rjPmFmK4lvcRhhYsGnUDqbe2hKwQG1WejFA5NNckpL45pWjDvrd7LKECymRg1vrRx/2wsYaHUHQD6VnX46/0TZ2sMF/8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vo7GUoDdtpJjdwGuPuMhSeEKkUxhoC7/VrAKYeJnYiQ=;
 b=prNL4XxnFlzoWPU4Jy3Uj/CHSz6sl3nIJsPOUQp90GOL4ImFGmc/yhOIMBa9DXnhTMrMH8tyEnr9mDdPghrvWxcwnecgHeGUQmJfEwCaMnhXQ1GKBU7L0HhyaK98SH/pZUp8RwZLl3hS99jujpiCtz6oQDzMLl/WMScZKIt8lM2v/PH+Rlh6eiPCMTbYEnTdhNj04zIwYe0+H2PkuKy/5Y3lp7tM9kCCa0lWrNXC2nkGB6ELbMnYHPkgjUcHpPoycnAUPAx8aiosRG2OD1Xvfj0DFSnQCGQfFo6EmWgaZEEMiV0YOeEaVRvsKVMD2sOfUICreEfga7Bvp7f+0r6Ziw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vo7GUoDdtpJjdwGuPuMhSeEKkUxhoC7/VrAKYeJnYiQ=;
 b=dV8tLgzkYKn05UmT4DXor6qvDoMQpVDOd8/5hP4K0yc8PLsoujQqjTrkJB29a++AaSg+S+iWNvtTMz1Rsng5k/88SxRzD+soRRArE9IM37ON6rZjEz5Mnd8HitXBQZe6RQRmaZOwHjVwXh/u0I2VdSsKBT0Z0SxGBNBknWfpJ6w=
Received: from MN2PR05CA0060.namprd05.prod.outlook.com (2603:10b6:208:236::29)
 by SJ1PR12MB6099.namprd12.prod.outlook.com (2603:10b6:a03:45e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 13:24:35 +0000
Received: from BL02EPF00021F6C.namprd02.prod.outlook.com
 (2603:10b6:208:236:cafe::e0) by MN2PR05CA0060.outlook.office365.com
 (2603:10b6:208:236::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.13 via Frontend Transport; Tue,
 18 Feb 2025 13:24:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6C.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Tue, 18 Feb 2025 13:24:34 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Feb
 2025 07:24:31 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v2 01/15] cxl: Modify address translation callback for generic use
Date: Tue, 18 Feb 2025 14:23:42 +0100
Message-ID: <20250218132356.1809075-2-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6C:EE_|SJ1PR12MB6099:EE_
X-MS-Office365-Filtering-Correlation-Id: 773e8136-65f2-4898-dc52-08dd501f9619
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UWqFhC0ELe/Xo6k0u9uovmPfspcf1DwbfIzRVHRhRsOmmbPvOT/HKNZQnUp2?=
 =?us-ascii?Q?NKDlQJRS10I96eI56fjN5Jkcgd5Ma0RP98puUqptPW5aiU0EKhAaAlEx2cHn?=
 =?us-ascii?Q?ym9aOVXniy0VAYGGUEAAFD+tEuWyEPvHxwhrngSKz+3PL98slInkCPF6AOY+?=
 =?us-ascii?Q?rMsw6bnPs/I0l1dC5nYPOIKFmVgxi+b4ZyRBDbKKjoKwxM1eLHW2GLzsvaew?=
 =?us-ascii?Q?7B+ERme2VqsUV3qb+AzCdP9QnYW7/jrM/af7ze9ITeECEXlJaaK9LbvEwpLA?=
 =?us-ascii?Q?V8yFQW1bLhnkuYg48/r1k1F5UU2uUBUkp3+2//44NxlfoNcpOf3P5JxRa3J4?=
 =?us-ascii?Q?JFLq+c8Y2Kr2QT6XB1dvS+Yb9j6d88ffM7LyR2c1Q5gXYCCoBdd1cCM4v0eY?=
 =?us-ascii?Q?JXiwxMMirswwz78m7lj/F5RkuKZ0eFI5ea7MNpbd78i1a4fKhrkPcWVY91a+?=
 =?us-ascii?Q?m+Xq8P8dJV338Gy2ecm6Wqmsw6kZB2p3HgnLSRLVbHqRNt2VI0BMIxrYPWT1?=
 =?us-ascii?Q?sGTq15IVmZWhTQal9ozjl32HtOAfTfuA+4aHBmuRuEtlDJ9C1VNdkKFCKnaO?=
 =?us-ascii?Q?6Mi+8+vjceyMTQp+pCmfj/0FmIzl1c+LwqtzEThPnoKwMkScahVpJIO+LpBd?=
 =?us-ascii?Q?NooLVo5h40pnbCz4ZJIWWBvBkhW/I5EvdpGnFDIhz7ziTCoKta7ysuRqcsRY?=
 =?us-ascii?Q?iAGQAHTitjZUEh0vcVm3O+Wx+grDnT1LG1BCmN68x/bf0BXl20nAcQOz1SK5?=
 =?us-ascii?Q?8OeV5q80Rl+2p8WMAlBkl62RI8xcK/ildF95juMaawX+JT6AsdQOIaMJo4Rj?=
 =?us-ascii?Q?jXfBhkl9xtyjzvha3NVbXPatr3ZIgweNzkZnim1If9EjhbAUMXD3jkrlHtR6?=
 =?us-ascii?Q?IhIxrtZAZcSD4GE+/BFd78pDJ11QlcpNDz34xXmgmZDQ6b7NqMNbmINqHojN?=
 =?us-ascii?Q?CALy0xoKMvRFE1Z+9W6diUOGkIkWnSGj/OoaridOaNMyodFY20AWIM1TclCV?=
 =?us-ascii?Q?VTY2+i4vOiQmuApXIMWRVQ2mUu6/F7ItkyFZEyobvRiIOHqFv1dAFX1wV4kF?=
 =?us-ascii?Q?b1mKBcsDZ34pb9xq5qpOL0jBMEC+ZxwbpzD32ri/YND3kQRA0ANpfETAfraF?=
 =?us-ascii?Q?HO8mjc+8DSk724N/Hn9De2pMaA4bbjuiHqyVMlcua+ZUX6diDuTjzsXNZQZK?=
 =?us-ascii?Q?kqHWz/B+wp1aePs6TudIK/1lqEUtD4ZJjy8Hz2qov+z6lt01u+r+LMNJDp8G?=
 =?us-ascii?Q?CDQz8WlYP4B6NUaNXGXOxILDeI+7cStrThLRHhSmZSmv2RTNhXjX8BR3B+bP?=
 =?us-ascii?Q?8y76Rcd0iS14C4Plvo78mLZ3Eus8Mxbrqxlp/ZqmHwj5z6tV95BxVQ0i3M4r?=
 =?us-ascii?Q?2bvW1Bd2hEDsP5UUvFUjsO6dMgM/d2S2XsI4XA+gXLJTyx48AkIWrwLoBjsm?=
 =?us-ascii?Q?OWOP4GFS6uxV04gA44rFNImK2lPQzPGeOPpUGeMiamg6jaOvr8f/mMSzQAFJ?=
 =?us-ascii?Q?8Bo8SKMk9qe18X4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 13:24:34.8495
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 773e8136-65f2-4898-dc52-08dd501f9619
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6099

The root decoder address translation callback could be reused for
other decoders too. For generic use of the callback, change the
function interface to use a decoder argument instead of the root
decoder.

Note that a root decoder's HPA is equal to its SPA, but else it may be
different. Thus, change the name of the function type to
cxl_to_hpa_fn.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/acpi.c        | 4 ++--
 drivers/cxl/core/region.c | 7 +++++--
 drivers/cxl/cxl.h         | 5 ++---
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 93c73b163c28..48ad90025d77 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -22,9 +22,9 @@ static const guid_t acpi_cxl_qtg_id_guid =
 	GUID_INIT(0xF365F9A6, 0xA7DE, 0x4071,
 		  0xA6, 0x6A, 0xB4, 0x0C, 0x0B, 0x4F, 0x8E, 0x52);
 
-
-static u64 cxl_xor_hpa_to_spa(struct cxl_root_decoder *cxlrd, u64 hpa)
+static u64 cxl_xor_hpa_to_spa(struct cxl_decoder *cxld, u64 hpa)
 {
+	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(&cxld->dev);
 	struct cxl_cxims_data *cximsd = cxlrd->platform_data;
 	int hbiw = cxlrd->cxlsd.nr_targets;
 	u64 val;
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index a56b84e7103a..c118bda93e86 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2936,9 +2936,12 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 	/* Apply the hpa_offset to the region base address */
 	hpa = hpa_offset + p->res->start;
 
-	/* Root decoder translation overrides typical modulo decode */
+	/*
+	 * Root decoder translation overrides typical modulo decode.
+	 * Note that a root decoder's HPA is equal to its SPA.
+	 */
 	if (cxlrd->hpa_to_spa)
-		hpa = cxlrd->hpa_to_spa(cxlrd, hpa);
+		hpa = cxlrd->hpa_to_spa(&cxlrd->cxlsd.cxld, hpa);
 
 	if (hpa < p->res->start || hpa > p->res->end) {
 		dev_dbg(&cxlr->dev,
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 50e7d878bb6f..b19ba47242c6 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -418,8 +418,7 @@ struct cxl_switch_decoder {
 	struct cxl_dport *target[];
 };
 
-struct cxl_root_decoder;
-typedef u64 (*cxl_hpa_to_spa_fn)(struct cxl_root_decoder *cxlrd, u64 hpa);
+typedef u64 (*cxl_to_hpa_fn)(struct cxl_decoder *cxld, u64 hpa);
 
 /**
  * struct cxl_root_decoder - Static platform CXL address decoder
@@ -434,7 +433,7 @@ typedef u64 (*cxl_hpa_to_spa_fn)(struct cxl_root_decoder *cxlrd, u64 hpa);
 struct cxl_root_decoder {
 	struct resource *res;
 	atomic_t region_id;
-	cxl_hpa_to_spa_fn hpa_to_spa;
+	cxl_to_hpa_fn hpa_to_spa;
 	void *platform_data;
 	struct mutex range_lock;
 	int qos_class;
-- 
2.39.5

