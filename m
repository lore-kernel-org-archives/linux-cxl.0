Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013016.outbound.protection.outlook.com [40.93.196.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAF02F7ACA;
	Tue,  9 Dec 2025 18:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765303721; cv=fail; b=ujTlHKzj+UY9u0qwXYe2UbDdZGb+w6FHe8vh7g4OsxB/9hz9zPbOOy4QWs5BpGPRndofAZRgDGlb/xsGaI5lUOqGmxO3xPa0huocs2DR0J4GimU5upw2Q58L51ilMiUDszt8t1+Oz4n/ghIvaXWdAlU347thaTpeBeGDVbmd4FU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765303721; c=relaxed/simple;
	bh=qyyseSAGmUDBFvA5yNM8iK8z0TcjhT6VxbNBmEltT38=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bSXZczV5DHPLOvpcu+8gum22tyt75+0zrurshp1sgAon8bzhr04ejmWMnFNxgzcuTyfFPvkJSf/gn+/ugpqjur0W/nLyPvaQUP3kidV99kluPuKXRM6aBic1gHOPssl+btm6yFqhUhnxIVV8kimbyiwpGKParkuQT3KdeaqdS5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=chy7oXYn; arc=fail smtp.client-ip=40.93.196.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="chy7oXYn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aMME05dNH9jU/Van5BLN3jhhGyWaUiweHRhxLLxOCPdBBjFB5LARUhbhTz/zxF9CEHA6SMyk9Tf7tYOTgwj0cVTymF1jROtGgZhqmeEc7+u1y6B9NB18A28ZbWPfPz0Md5Ruv4Rdvv4gu134LtsFR1CIkrizhObk3AdEWvSBVyTMTVOpB0tUJBEHd3Sh0VGnM0QCm1Vy8FKF4CIsqZpL8kWLTql7RX2i2bmPvBVkDFpvC81wMcWHVTT3XSS0UQZMyMQ6Lgf1oH/kma44cFQEQMyeDlcCHwDY0/VixYYYE+f0tcyJvbvoafa0QKm0NtjJM5lp11rdl75HcgEqWDlrtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CL8rqwNCbyR5hhSvyHdVG915YX46Qaro80cAShOyJLE=;
 b=j4miREKEuHn1Rr6Z4D78PE+gmMhgjFH2DkcuP6rIFRIKGERd3t1KcLw8zJjXYG9M7jFEWMq6eoSOcRADjh6h2mRECGdT72uHKVM2oApYPM1t6B6Pv+avoo+yFDp4tyy8HbNbTYknsiQhkR0pkG3/9rAS3fhE+nlu3cLxgc9WwhYEgQDfwL+znlHxxkVZBmJmX1enppc0JKcXrP4dDWNP4biBQGo9RcVnspftdU9LIdlrf1zf/ozDBzG6NaeBIFTDP7p706PFNPquI+CJzRW5NgUVp389sCwVPJFZQNEzE93RKMuuDlhSWyU4UzER7qFonhOgAgqTI/3z4UaRrwMLJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CL8rqwNCbyR5hhSvyHdVG915YX46Qaro80cAShOyJLE=;
 b=chy7oXYnhMMp3glOmCvYXgRFF3f7v56XIqtJuZ4rLFIU1wDPE/EqcE2B75B6eYFNnF0rFqo/jaRjU3QQlKBY3ORAT9FY7ouSXo52TQUYJr0tbQv9yhe1kdZItLomiQ0hwgHUiYvGQkyTmB3Xy923AjH22hwAkVlBQPKMJEPsics=
Received: from BYAPR05CA0102.namprd05.prod.outlook.com (2603:10b6:a03:e0::43)
 by DM4PR12MB7552.namprd12.prod.outlook.com (2603:10b6:8:10c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.6; Tue, 9 Dec
 2025 18:08:32 +0000
Received: from MWH0EPF000989E5.namprd02.prod.outlook.com
 (2603:10b6:a03:e0:cafe::27) by BYAPR05CA0102.outlook.office365.com
 (2603:10b6:a03:e0::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.7 via Frontend Transport; Tue, 9
 Dec 2025 18:08:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000989E5.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Tue, 9 Dec 2025 18:08:30 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Dec
 2025 12:08:27 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v8 09/13] cxl/acpi: Prepare use of EFI runtime services
Date: Tue, 9 Dec 2025 19:06:45 +0100
Message-ID: <20251209180659.208842-10-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251209180659.208842-1-rrichter@amd.com>
References: <20251209180659.208842-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E5:EE_|DM4PR12MB7552:EE_
X-MS-Office365-Filtering-Correlation-Id: 51920dbc-c28a-45e4-3348-08de374df5c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7EXQOCoVO4/qpkofhZlYcTxuA+aLqX//pmDU1cRmxpD0uQh6RAX4hwUHloXA?=
 =?us-ascii?Q?aDalAF29S2ez98iobAUocGBnI6QB9bhvYhnolm0wxGrPdpD+Jw1qYzYtU0WR?=
 =?us-ascii?Q?I5LxFLgF9xjnJXXAWkGGKfp22CDaQE8uKMRv56WVqbEWuVoeDEQGDEUcJTJn?=
 =?us-ascii?Q?7iGbuPj46vvj098Rcz6WlBGUWR9lEb2XjKXHoqVPjwmfqd0E3tYVpH8UMFMr?=
 =?us-ascii?Q?S73gdIMDUVgZDKlFDmNbrL2mKWRPvuVoXQgyPlq9reNiCp+U/khF3GGrZ7ME?=
 =?us-ascii?Q?NQIlcepteKCsO5nDaczUAAFjsNyX3dFLj9dyXLwk8gpyTZoIPD6fvZZ6I0G9?=
 =?us-ascii?Q?UVJqZ9hJ2Hu1N5zjmOBAXiR+YIIoSQBnKWBH4JUr66Ibv4RoiA4NxzN7kTQ3?=
 =?us-ascii?Q?p+F3HfJ40FXuDFlEFpLfzeAT8U1uCuGDk+J4n2DRU6ktyIaN2hA/Fkix6KPl?=
 =?us-ascii?Q?qu8no7nEHTxrFvSpn0imknMuuLmDS/VDJaAn0f3HWM7bGVvY2gCNrKQrebLn?=
 =?us-ascii?Q?xk4xMfDAobUGyzkB0BjbMFD+g6VR/EzekzjrwKaf1YBhBYZWNhftEzvv97ik?=
 =?us-ascii?Q?8JEeIrnNZgMZ90ak00vjRQkLta13sOFJkAVm5YQC0ae6wpwS6vIl1b0V3+Gd?=
 =?us-ascii?Q?H010EdsDxLIMkbvWCW78jcZq4o30h7qTEydUnf3l+G6WCzqWupUbZADbUBib?=
 =?us-ascii?Q?O9Odq5Zi8xgH3iLG4dF8ES5zeGQncqn4ETY9I/VmTqLJEH1lHHxHPvg2jp/v?=
 =?us-ascii?Q?fEPVFAAyDEeZfndCluTqJx8apvIoprhCbfJ3Lr1SQJf/HItfFv+5xooX7mYr?=
 =?us-ascii?Q?qrgDC3iJgrxUmezVlfd+eJJ6H+pFjzes7T6NKYOWY7Si0XOjtYhLc6ArN+oh?=
 =?us-ascii?Q?CRf7mn0JgUevl1tWDZzwGMhAUeM7i5rZsV5Jh2TFKdjt4opbA2/6bv4X2g7B?=
 =?us-ascii?Q?6Kn7Jux/3e3tcD/QBQ24AjCNdjmu5unq4g5M5/CJPLeGU1mPDM99boNs1ka6?=
 =?us-ascii?Q?IQpsJo3bxSZz991qG7Ra+gmZwno2h3tuR8oQ6HKwRAAKu4kpFDFgQGgvJG8c?=
 =?us-ascii?Q?/stS5zRUN5ClrXXKhE4tV9JmgZXq5u/Pg+Zx4rIOcXS11NDfi6G6jhbF5SV7?=
 =?us-ascii?Q?ZjxlZISevdTKxUbcT5g0S7okqdGfDaCYoLK1eEASNXGap78x3HriqC/g+521?=
 =?us-ascii?Q?Cs+XuS2DD0jlGZnfm7ZSlHmBYBrmbDLIm2ZI+PFgR1qGkLIiOoc2wsSflMnh?=
 =?us-ascii?Q?0UMEj6btx/6j33km2tgLzndu5A1omhX+KMYuKXqvQ/LimTRDsiPAKUDYk9GG?=
 =?us-ascii?Q?OjziBpkwO6BLl4ytxTGavC9TlPomniG8Mj40U2aSZqKbp//USaXVfdANsubM?=
 =?us-ascii?Q?nE3o5LkzBNhN7IjujzSxOfPUrQC7a8Mmo65P0MY+ctXsTAdRqfvd10zbtK43?=
 =?us-ascii?Q?YW5/ZI5yMR97F5eG6bePQYE4GpiHq7HYx8bi9JcSXulZ5vF9uNEsofQlbyf8?=
 =?us-ascii?Q?YSK9U4ca2m2Gvghc4zwejUWkwCLyQqf8rER4tGEk2LuazenZgtdsnJrmnSNe?=
 =?us-ascii?Q?CIT2yqQqPPG0DZJpZPQ=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 18:08:30.7336
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51920dbc-c28a-45e4-3348-08de374df5c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7552

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
index b4bed40ef7c0..a31d0f97f916 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -1005,8 +1005,12 @@ static void __exit cxl_acpi_exit(void)
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

