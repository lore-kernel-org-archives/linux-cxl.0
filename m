Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010013.outbound.protection.outlook.com [52.101.85.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE903A4F2E;
	Wed, 14 Jan 2026 16:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768409395; cv=fail; b=ss6/KtkLLlpOcOqDRQ2ySiZBmaVgzOZgu7IeIHF4bHRnpVCrUEnMjWK6wNMLNcVNNTgqaUTjH98wwOVa/UbX23bxyJIX+vKm5WOsTTUj6P+DYnyFr9wiubxuIfXormlDPhv763effFYRxjl/goPRlVrrucmxvlZVWn+TGlmeTWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768409395; c=relaxed/simple;
	bh=qyyseSAGmUDBFvA5yNM8iK8z0TcjhT6VxbNBmEltT38=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ll2nUcgJ1+50eJrZ1nknIEF2DTqjA9CpeoeCwnWVBvnySbSl9dXvZXl6v3NrxIh/aoYVnd81+GAiDbFXt/0/LLmB3cmi6qDSRN8/B5xX5fkDwJGLqjG8l8e8cRsj/fQp1ioUkv7TV0s366rBTMzdNDfvvPY4JITqPj0j4I5V4IE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LPJOaFku; arc=fail smtp.client-ip=52.101.85.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LPJOaFku"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=feo6GcpTq+vHa83gMgK9e0Foqc/Kk8S8B7dGhMUWFP5XK5sEFFe96+rxaoLY3TtmFkZiCtd7obvyadA+EnPwSJS0WsT0qAlOE30C/nQPMdW4kaVkoy2wqxHGvRmz97UDoTSB1JJiezdfslm84ZAB1QQ23B67MkgXvaakX6aGVavs5d2ocS2nnXOOEjGMtEUeM2Noc5DyJZY8nbOZGnwGZ9w5JLlmF5flI0sBN/qFZZTdaTXDcXebcv9r7kJvSAtEAmMlmC6GMrCqEDSexmofYR0QgH70IOwS5NJreKOIi8O3sqENkRQ4hqEI/zZIsI8AwvTGJRMD/hlXGgZVIX2gbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CL8rqwNCbyR5hhSvyHdVG915YX46Qaro80cAShOyJLE=;
 b=mdxrl4fUa76EA2aC5nkE4gmjYkD1jtvqKRKJ9TUKe6M+arAZJdGSjKnArkmB4GHTJi7DqCQR5RA6UZpm5mBzhyOWHO+FRrazNsQhmnPaRO90rzWaEJ8q9u9C4VAVb3U81qmUAdzrEL+dLIjFzry6sSF7jHWO6JVzycdK25Db9TSL969gHkPOX2tGOioOxiduG4CLLJdUnPuEFBIM+keYgPs59I/7/kFo83QUUgsxATmsJbMswFfoKJU37VikdyNpbthxYyqt675nEoYgHwtLscPFOjauZEpuKc1NCGVPPCgXW8PEZmnJhUa2U4Koj7kLP2HI8cGu6FsynUC3sFGfjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CL8rqwNCbyR5hhSvyHdVG915YX46Qaro80cAShOyJLE=;
 b=LPJOaFkuKlorm3thmDab4KoHaQqnNy4cZH0iowldkN745bvVfSD3/cnNNHWAfCdddPv0VHYPy/qNClzoUuVZrn/t0Ol/O5/C3ECPH43hJ69wmc5nyh3lhn+dNHpS1ykRA56iOjNgX3+0QtOxq7hY3JOc3brrHyIBKESg2V3tgWQ=
Received: from PH8P221CA0017.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:2d8::13)
 by IA0PR12MB8352.namprd12.prod.outlook.com (2603:10b6:208:3dd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 16:49:36 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:510:2d8:cafe::82) by PH8P221CA0017.outlook.office365.com
 (2603:10b6:510:2d8::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Wed,
 14 Jan 2026 16:49:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 16:49:36 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 10:49:30 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v10 09/13] cxl/acpi: Prepare use of EFI runtime services
Date: Wed, 14 Jan 2026 17:48:25 +0100
Message-ID: <20260114164837.1076338-10-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260114164837.1076338-1-rrichter@amd.com>
References: <20260114164837.1076338-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|IA0PR12MB8352:EE_
X-MS-Office365-Filtering-Correlation-Id: 996c0576-01b3-43c3-50b0-08de538ce684
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XEA7bI/RJndbvm5vgvKhBFKZEY18h//EMG3C9zzCDO0vycXfc/aLA1fvNhGv?=
 =?us-ascii?Q?uGLA5ryYZI1UfrHUMephwR9l0rdyBcEm0qebZq+WhigoZCZXnjoC1hoUkxqg?=
 =?us-ascii?Q?fe4w71mvLoPGhSnIauweTTAvqAma4AlUf5/F3yCZ7ytKWnODpq4yFJomOeK7?=
 =?us-ascii?Q?uaVosiBm+jakNGQKS7/h3jSOkaFJf+D1+h66pDsZ4L8kLGQHgQzIKwVPGPYm?=
 =?us-ascii?Q?a+azjK8YDNtlSQNC8aSFg8nsSTNUqMdlnTIaaFT8YNRcLhTdBtv3Xj//vRNC?=
 =?us-ascii?Q?PbNoS+y6ZYu8EKPe3nWojhKCFn4gtsmllqX5x0KIlIsnbpLEdWaqDnwmGM8V?=
 =?us-ascii?Q?f3hqxbaEYebg7TrJZJKCnnhflCzeSXXA01Kdvk0aOMpGOwXUay9wVQVRyWFI?=
 =?us-ascii?Q?gndx2YPxgrCApXuruO7JqUrYtVl2wCTfupAKl5VU9JVOk19m6CeKhJhmBHgp?=
 =?us-ascii?Q?puAZMr7NjgRF0QIpVJfOMyUHfs1bx4dTa6MKNlStF/yH3K18Cr7lAwygZTla?=
 =?us-ascii?Q?fSuIk14YKlXe7cBwzkxNtJdZ6AqRKHDAdtypvfdbav9K0//OWxSMBqhp1VxS?=
 =?us-ascii?Q?ZA1mmxQ2wOspNimMpWVItpvagSWEucQ31gBXQMl2SLEEBlMPEOcTP0gmHyFU?=
 =?us-ascii?Q?AhZxg+8msdLO2bKoKyUWJ19XEkNq7H0P2oJtyHCBWHqgequGegdi0z6hL21x?=
 =?us-ascii?Q?WiYu/Mjx9gB9w1HUo7hpLixrZpJgsOAibhuZbV+WyvKXln3Vj9LfBIfKvKUp?=
 =?us-ascii?Q?48NepucLrzTXMgF+FPtwz/SAAl/pW2/J740fv1RfuuNM+VQWRn0KtaaBWVHQ?=
 =?us-ascii?Q?gQx4J0QL0Fvy/fzE56dUtx73aTUWV4M+fu7dSpPKVHLQ2Wf+6t0Q+exS0yN0?=
 =?us-ascii?Q?CXhlU/dPtqyo2wYTzZjlAnI+foSWHxPtwnhIr9MQrJbcN7HR+2kC5R5M/Fqi?=
 =?us-ascii?Q?1+LJIAfUgP3gCzXsFgBY/ICWiqdXqxqZujsZ6n6NKOuWBtavKfbAjWFVJAY+?=
 =?us-ascii?Q?ikBfX4OdpfzhGJMn5eFetywCYrwdeicP3pkVwK6c05EdvPAGHLlOJx1O7Rts?=
 =?us-ascii?Q?F3eA0g+Duq/J8MQToHvDnjV8IeBKMl9ZB3BPwECfJeCKMVq8MfYvAVoB8tWf?=
 =?us-ascii?Q?ClXRvypK6Yg8Pqequvs6Vahg4/q51K/RP//RGH5j1Gvsn5jZqBm4Ka3uquId?=
 =?us-ascii?Q?mnuej1GYCrrOB3tazv6ZPk6/d7PBNLseKiOmbV5vtzNyQaiX20NEqLkGwzNm?=
 =?us-ascii?Q?5O8mSOsmSpZnbbUuWcWkRB8nNiflKLW4vWVMfCr520BKBVIcr+Go9dSqVkkz?=
 =?us-ascii?Q?9J+hFYhFQRH3zfKppDk8kCXrOKOjuGZXnll5ArpcVBaI7w0D87NVZDn8acTn?=
 =?us-ascii?Q?q3YCHgys4m36QVmpRd6wdfvEBmNUQ5bCpEOsNpLF+30r1mjOLNFUAteRq3Cm?=
 =?us-ascii?Q?5DWoTIyEknsknya3/BmmzZXveR7lAvHYxS2EzAf4utr6sQzRkqNPIfa2psiF?=
 =?us-ascii?Q?Dr3uKh+TsDG4GmnfuwrwdBMdWfRNYNJQoWtt9PIp3/7oLOOtJtbEJv7LT3uH?=
 =?us-ascii?Q?teco36kKc9MmABwIV0RKdDFVaCfSzrhcUApNJHXxH5nIK/Fh+6MnDcpK5Ltc?=
 =?us-ascii?Q?9P/MgWyAlLneJ0S/W2kZ+b3X9m1/kLvEfuUF6qxSkqDVJ55CnVxbiWDeUi9W?=
 =?us-ascii?Q?jbA4vg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 16:49:36.0558
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 996c0576-01b3-43c3-50b0-08de538ce684
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8352

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

