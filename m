Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013017.outbound.protection.outlook.com [40.107.201.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1BD320CB8;
	Mon,  3 Nov 2025 18:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762195775; cv=fail; b=s2wEw3sg0m21qiUSOzWy2dZz6beFANoxAIxiAuWXFX29iGMh+aACdfNRerEm5DwwianElE+7FNSLhiapuXHV6b1KPXl+yYZmqTSPSh71onCLbfwKbZqTzeP+Mwc7JtLGdgZ35afXK5n3aEKqk+pWQmfous+LnqjuC1jAoPtlvTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762195775; c=relaxed/simple;
	bh=1LTbB6fWTo7lQwHjURF9SpsJV2SoTDUFYGX0Vo1AqHQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ob/gBpSTKxXrlagz77HOgkYp9RtnqJsL39MTbjTB1pjTd/PlMan+ANZNCdYohEfnPnSTFTj7zIYFoq20mCHUL8wEbbmsnlUMAWZeYcT53LtaS6k5mPpgCXduKngTUEg4j3xcco911umztrr3Bpo2XUheQ7/KUYwoA9AiUuTmfzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=M62pi5IS; arc=fail smtp.client-ip=40.107.201.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="M62pi5IS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Of+0A3LeOKbaiRzJpjNZFD3u6e2DBnCMcgPrirT1xvGEhlK8fWVA0rVEB+O1SzqGSImaC42h4oMA+wsMhsyLxSQRldhvhLQePDcJSjaq8r1xOSWbtSZ+UYaJvdRs+l6IWZXH7aNRAWxwxwlvVEV1neCR78uCKtQgF8Gprzw5D4FmcnegnglxkRnEjbnceGGe4/TuLlOWxks9DZXBkZUTmrExNoe2R5BgV8SkKdnz9cU9EAfz5yYCxpzVeAPq20M3BYnZN+Rz1NLvpr5Vxeoz5MHcn2BFKSkGYQK2QB0z6ZDRATddAmQq1neX3uyDS6CdKwX6CJMI/uAlJfixjdD+Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1nq8Ol5wC33FN2b7c5QA4yF7/sxXIr+lnk+++0JNnvQ=;
 b=JGffyclr9WSF6KtDu+bfbdMIvPF+z48cvZFvw/rmHHjOzYk8ZqZQA8VUFQxnn767YKfDdBl9xqjnuypHxwmyqJMokPlCxxocqmmBEji4sXHeieV9zkIuUFLdriDXP488P0ZISKgzM0odMwJKGiNacKkFTXggmqiam+fAKP4nGfIlUVhLizdbIFhWOW4WNGb2aEc1cZhmh6igwEfMvXpwyKPfDQC7CR3JlfaGz9PZmls9pzelPpK31aowaWh0HkKJcfFw0rll72MMl8Ialz40mW3EukLr2oRie01JZDVZazo9Wdqx5OyZVp1GxyGVXcyUR6pmCG7XtheGYJ8YiqkK3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1nq8Ol5wC33FN2b7c5QA4yF7/sxXIr+lnk+++0JNnvQ=;
 b=M62pi5ISijhf+4DOkwkruJtOn97/z//h5glOo6AaOZG9grs6+YBzGcVxYkqc+7PH5Um1NV6WkBMbEYNNaef+RAE8111HRWgaR7HfVIg7PBmYjrXFQDsA8CRYhrySEVrWNz8D/eX5M3S6vscblVvLwfGuoyI59cYb0AQ/F+GJA/Q=
Received: from BL0PR02CA0101.namprd02.prod.outlook.com (2603:10b6:208:51::42)
 by PH7PR12MB8056.namprd12.prod.outlook.com (2603:10b6:510:269::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 18:49:29 +0000
Received: from BL6PEPF00022572.namprd02.prod.outlook.com
 (2603:10b6:208:51:cafe::76) by BL0PR02CA0101.outlook.office365.com
 (2603:10b6:208:51::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Mon,
 3 Nov 2025 18:49:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022572.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Mon, 3 Nov 2025 18:49:29 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 3 Nov
 2025 10:49:23 -0800
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
Subject: [PATCH v4 09/14] cxl/acpi: Prepare use of EFI runtime services
Date: Mon, 3 Nov 2025 19:47:50 +0100
Message-ID: <20251103184804.509762-10-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022572:EE_|PH7PR12MB8056:EE_
X-MS-Office365-Filtering-Correlation-Id: c2bf3a7e-4af5-40d0-5ba6-08de1b09b832
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WvMh9vkLAQKtLZhGK+r7VDp+Zg01LCm/qtWV4tNxS3VqDuQOvCI8SSg8bjC3?=
 =?us-ascii?Q?Yv+QPAqfnG2yZXR5g1OdF0FwC15KIwd4YWf2a37TGxScIbSIcGpXB9RWL7u/?=
 =?us-ascii?Q?VSAItvPvJ/Gk17Z/QfBsuOOWuB7ME3LRtCGyUPTumkIB99bjSNaDCI+ltdzO?=
 =?us-ascii?Q?vqrqEhiuDjDdAtNxkiorzpJrnYuJ1oONcX7Ekw0M5JQSvWZfF6rWPnXAkNpp?=
 =?us-ascii?Q?paFeczus7VCPsmeZXTFQzsKGOhFjBKk+2rb88uR3tk2YRoP2vzlvkvnTcHt5?=
 =?us-ascii?Q?N0DnflwxO0Mdqs03cacm0cay7pL0g1eHsWeRP6hoXQlFZ+XkPUrd1IXOPqsm?=
 =?us-ascii?Q?aiKwrgazFWCq4AT2tRJ0t+ykYYZWRyzarApOUfpzIdfk3QTGURDgCLNm9Y50?=
 =?us-ascii?Q?3f40ImVbAELr4Al6M5qPjl4H6h3uaEaacwpXGbeAVeteag0d9pvY8aMXSsnM?=
 =?us-ascii?Q?N5A8B7lnwqRHB0DuerEsD+0vi62DL237uj2T7uHaRlkAwFbRusmx+ljOEwG3?=
 =?us-ascii?Q?y8ayQOi9IFAm1eMGrWCJq2ggtxWJzag0PvgxGvCGMIVczkUdLkORJLT5fPDf?=
 =?us-ascii?Q?+iZiQXTzh9Tad3hwu3Iz9eZ71x8JZ088R+4xLLQwG7jN5EaZd/vDUUts2l/+?=
 =?us-ascii?Q?3kgikBnR3gIVE7Q9fGH+ulhzAbNQAcqD8fqq+bhIs6QUj00u2UXS5bF5XzTH?=
 =?us-ascii?Q?gBKMoN7a9h8SlZKITI1rW3hJykS4ZpzkCk6ULrCyXy9/1zEXYid4EZ8W3wFl?=
 =?us-ascii?Q?E0wzOsrf+wYjK+w7MovzvMxK2OK3XnDZ7cKkWOK9bzjO2NSU3Na8v59RV/BH?=
 =?us-ascii?Q?/sVfWaQAcfpHVcJefZJFZgueLb7aGdgZn9ZkzwZ+AhAJSTX9d32dGISFn0+N?=
 =?us-ascii?Q?jjs6+KMFbe3RB1g0jaUeupLNfaG2FWTOgxx/EijlX77dNYKy/UzJXUdsFeND?=
 =?us-ascii?Q?hrdWZJvZzuTrKhVNSgYDV2g6LZIoGhQqYdXExrQAd8RPkvQ+LHP3+3n4AfhQ?=
 =?us-ascii?Q?szHMqc8HPLaupf6mshpOZSo8ThMxjBQ9a2q5clGE9SUcnuz9M+D7iXpzuLOl?=
 =?us-ascii?Q?L0h8roY2huViXxqC2M9rydWLpgkxlR0b7IpCV/ym4JSRVZOp5CSVV+nd8HJd?=
 =?us-ascii?Q?vrnyZiOjhGZp+X4KrO4w8LW/KIAaPjjUKIhZ2XEIDk+pNjeY3e6js33zbIkJ?=
 =?us-ascii?Q?itrmS31cs5Hb37uPDbd5JUVQj6pP3IuS4Af8UPV5r/rqCzOia7pSEHbZQKo0?=
 =?us-ascii?Q?jPIqV8qLYSbgamzy97v7paMc+XhTtnP7U/lyB3Ld2sdxy2OlXSY0V2qG8jV0?=
 =?us-ascii?Q?D/QCEnQoyKYg7zeeC+1OkMbdQWVQdL1TWBGhD85X4pRH4Q6SryPftUqj4niC?=
 =?us-ascii?Q?6ghgszl6MrkHfAEUjhf8cHVYG8tOq2OZh6nSAXgxqvKmf7w4gaB64acL48dU?=
 =?us-ascii?Q?W53XAdtcMt1QLnaebd97YhctnPx/M/AA2EguC4ZE4c9p4qFhrJgpHZXf4a4b?=
 =?us-ascii?Q?MoGt1C8Zek5kunAxJcw/EoYTd0nyhj3T9Eg2Aaql7PBFlP6/mVKBx7xTzEMd?=
 =?us-ascii?Q?3eqp08sEajW5LQQ+kfg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 18:49:29.1718
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2bf3a7e-4af5-40d0-5ba6-08de1b09b832
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022572.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8056

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
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/acpi.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 1ab780edf141..a54d56376787 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -996,8 +996,12 @@ static void __exit cxl_acpi_exit(void)
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

