Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2088.outbound.protection.outlook.com [40.107.102.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D10831A04D;
	Fri, 12 Sep 2025 14:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757688386; cv=fail; b=rc0AsFbuVuBRFcztM7qOo80PuFaF2J/0G1TAbWnNEzaO9G+MiJUI7bpiifQiBKsZ0opQERRCsD8EZy8I1M/yKtxK0D9fKEigOPeRojDZbSpKInK+83Nx21fPGtlynUIvE74mwIlZ38Yf7JR06pW4i3LeecGwVYaW5z5akhTq7sI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757688386; c=relaxed/simple;
	bh=66/K40WYKW4wEUGjiq2yQWKqvrd92wQBEeeJj4/Y7pU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eJ+haGJg+qVyD8fXxgW8jCFGimqRDR5lGCfK/46yQTzQllCO76kqguCiXcOVKm4STakTlIsAW0mUOHRN9QROSid3jkrgWXMMPC7Al8COMDY1ZLaJ21Z9gm6KWHGIEC7tmILHeMcehmvM68LGmJC7b+wn3FtOF+EqjnGa2HeQovo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iR5d7Daf; arc=fail smtp.client-ip=40.107.102.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iR5d7Daf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yburrSIM3nnuPGJQImge/bT4Y7w0L6GYcl2qI1+ISs9Yr1Cko+obpzsVVTXbD6OKzsY0TJuJYPmis7q/He/s4fXKDqy2HVg3oGw4U9WFvFeCsEW6CuR5ucaAlQpYghBVQXy+Uv+pjcdDvjSes4jPLJGkGWN8HiZIsW9CN4VxtL+/4mIoovt98UM4F6aNUbRjBVFgv9QCbvxYnoz15CuBD5vRa78OYP45o0ryS+U72iablonribSByKCdT4N12zZgIicHys9fcI7LpETNHwPI7Ro9zyl+T7eSitoP73wcPZINXP99f96sAoBaRvr/AapGuTjasi4WAovVhhmopqUXbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NkN2bMW0w2JOycF7odO+s8GXBNqmieq3I4tfxU8vaqw=;
 b=H88fai1PZfzyiYq7SoYtTnI3zmsRDXeOXqmtclyyt9XetKgtlO5HL8sfRfCmhQ8sxqeh9vRti9QOEA8i+dcl+ym8oCREkzSY9SeMO56HXvVS0zjdv3/QRRSMaBXGoUfVT8xFBO7sEgZtzK78i4QFbq/BbhXFxfXSIr5RqUESF/Iu4Dii3mV8LJvpUu6SuBF9EFV5Dp5aVJWLz5RTN/7dBRNWX8ttfif0eYT/2YD8LF6z3lm+4lBytNYuxaZRu6HIgNoIQcfNb8oNMdqv97P3JNvUQv1pojlVULWUhmXw/ab8C+nWIIiryV5DANhRaShdgKZEfpn6VfQo6I2JBh7Zwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NkN2bMW0w2JOycF7odO+s8GXBNqmieq3I4tfxU8vaqw=;
 b=iR5d7Daf95Y0ln1wDTLApPqvje6Qnyl0rfAlKodnYaoDl2VRCZ311Etgv4nzUpSxA9uFUmyjq+CiujQVlknceJUC3VeX+EbUjGf5WRxKBEk9hiPHykXZLRC9NbzIMGIpyMumEBhC7dgVLSa4b1xKlMMnIACDX/5PkPQiXPoUzzM=
Received: from DS7PR03CA0048.namprd03.prod.outlook.com (2603:10b6:5:3b5::23)
 by DM4PR12MB6397.namprd12.prod.outlook.com (2603:10b6:8:b4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 14:46:17 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:5:3b5:cafe::d9) by DS7PR03CA0048.outlook.office365.com
 (2603:10b6:5:3b5::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Fri,
 12 Sep 2025 14:46:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Fri, 12 Sep 2025 14:46:17 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 12 Sep
 2025 07:46:09 -0700
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v3 10/11] cxl/acpi: Prepare use of EFI runtime services
Date: Fri, 12 Sep 2025 16:45:12 +0200
Message-ID: <20250912144514.526441-11-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|DM4PR12MB6397:EE_
X-MS-Office365-Filtering-Correlation-Id: 4deb88da-af72-4479-f085-08ddf20b2133
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WE1hWZS5rx1b2G/sFjM+8TwJXKxdPChqoi4tN3XB0Z/MMSb7mx45s9r5Kc1O?=
 =?us-ascii?Q?yHd50E7dhWj/tHPs6v663gVFmX8Qw0s1754HQB3R+7Be7al9m784n+ZHtxPt?=
 =?us-ascii?Q?bfk5sdq8yZTJ99gpO6aVG0UTQY57GqFFE7+KpUOVc8fDaX2PgJKpTRx26Pdy?=
 =?us-ascii?Q?snIKGJFsAKNluEUrJ7sq61v4PyIh1AKtUScuv3M0u5w+QL7bV+z5RjB1kgvL?=
 =?us-ascii?Q?Gs7NloeSkxqwzgr431AmzCiDiF7DRyC/v3Jm+AI1cpxs5g1MQsE7kZIyMADP?=
 =?us-ascii?Q?acz7Suh2iOABZ8rpMplDyOyjKMwtz/iLU+vjApeJB/rSDJqC4VM0qTbYvRC6?=
 =?us-ascii?Q?rcr5xfcA2QPRvWeXLtuHBfqtewJdJTnN5RULVltHNw2pNICym6BqQr8OTK/0?=
 =?us-ascii?Q?VUk6AjqlE+SSMar2NyBN45G1caykFb2vQUnzJh4dxfsUpeEb+uoi56dbHjgU?=
 =?us-ascii?Q?j4ctiA3AW7VYXSThL3JEHhvLggqdcWfbrz9EI75WUuT35LBQuCRiBDoYDSE/?=
 =?us-ascii?Q?ChWLqQkt0ULwhNmfYOC/XjIDRx96DHUhKJu6Koe+55ljsFEd0a5V3vpwwPYs?=
 =?us-ascii?Q?PPTwz6MWuB/vg91tmgYFepOujYym6qaUzOUbE29XzkHK1SqksTcGcV36EBBI?=
 =?us-ascii?Q?jGvkA3W9s1mlE3Wnw+/qQLkwf6wlQj18c+4wrQQRa0JNRdJu5fqABCv5KiXB?=
 =?us-ascii?Q?x5FOHr4DWhJd3YWAYXbOAyM9bD9pKt/rYEQ6FO78uHnjlF1Mz6xkiE5Lu3Oc?=
 =?us-ascii?Q?PH1h4qmdqTSk8j13UB8vKJd9C3pOioOkFo1fMA6alqsDkQkYxUSp6wlGo6OZ?=
 =?us-ascii?Q?iARqu1bRf6aJEEWmME/vj64KvLbR3IFrJUB1aVPlxIToMjH9J5hvaJvWDEG4?=
 =?us-ascii?Q?J7ULhz1lar7Sp5akrloDGrr6EQ7f8BACH3CeX8HY7yGJxay6cBtabp6Jkbge?=
 =?us-ascii?Q?2/YFGMIoofOVs64id3iXPwLC0gcR5tpOnSdObH+OMPyIgm1ma1nyEjWocUqU?=
 =?us-ascii?Q?6ENj2Mx3YiaIxXwnSsv/vXFt9NLtX5Y/mgbtkZ3KBa7N8fnMdTwUtZD7+uBq?=
 =?us-ascii?Q?xugOJpPyKWGW9sd9VSNJcma3EOiSE2McXyRlDitF8ZcY/yORqz2iZSweOBNj?=
 =?us-ascii?Q?k9xUzn3c3qxlhSBPkaGFkHAtc50keBKYTP3YdBsv/+g2Hyd8HPyqD6B4N7qr?=
 =?us-ascii?Q?6CmDbx1p8aThjW5wsTAlVqw+JZAtBr0KzzW7FFABpX7oubVw/CBQCOn3yTZz?=
 =?us-ascii?Q?7KBYkqt2oqG5CKRJI129209fE2RaBDBxWnSvhzF+X8xZNpjTrT8rGthph4Tf?=
 =?us-ascii?Q?3p0dkT73lV0ReyvUmnMDx87EC4EQh/rnmDdakAcuj1MVXyyluQhm/KN05pso?=
 =?us-ascii?Q?F+xTImSZpIyxcuaScZXxUtxkd75zktUnD1QA++UycfWdctywCmsP7bnSnQNS?=
 =?us-ascii?Q?wDwrkt/VnbbzCU0baKz/4ppR7tLXFlnpc+BGCpDpNKQdGSFRcOKA1KlLZuOF?=
 =?us-ascii?Q?2RpR80Ce4jMO7Acry5owKx6pMls0AmneqEom?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 14:46:17.1357
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4deb88da-af72-4479-f085-08ddf20b2133
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6397

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
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/acpi.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 26c494704437..95a5ba395c1a 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -1012,8 +1012,12 @@ static void __exit cxl_acpi_exit(void)
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
2.39.5

