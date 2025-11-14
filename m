Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012003.outbound.protection.outlook.com [40.107.209.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3F935CB63;
	Fri, 14 Nov 2025 21:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763156424; cv=fail; b=S3ApWDfGM548MhFRbXOCACYdahNyKtvWCcTGu2PFClSFHOmwNl4f6rA/8zEMBnnKVepVKikzoPko+h1iubjVQiLr3U1FdlbxPBvYPbsrvfAfUeojnS/N3PhVWZSTH7cykHth4ghOPgv9L6PLZO2/SHR/Njn0FDxbSuOJ1nKmnWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763156424; c=relaxed/simple;
	bh=ZwEUSBt3BzCW4o1QzK5TYxo+6JhVfVXjnKYALU7/JtQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L5+eV3MjAEHJvZlMZN/IkRynn/X9fpVczniLxrv6snhaQqzHVgZyaSCHEBAIM/MZcvCgfgTssKKC8ekRzMkQ8blF7sd098fZ7mSXJ1W5szwMJbxRQaKpnDfs0N3u+nmUcXzDRFSm2LQ6Oc8KlgN2S9lz8BpWnTs4qEKszWFP8iw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rLCoUC8/; arc=fail smtp.client-ip=40.107.209.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rLCoUC8/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dXJda5zBpatRWBp5cW9yhth/aRgK32XOcD/cYCP3T0Bxpfi6UYCl4ep48ls02w6AOkWRxn3iYhl0qvIp17ceLT18CVviB68pKAvQEuJV9dq8T2EmqY+4Ptef3zdJ/ERvAFxpUk/PeHV0Cye1D6Ta+u9FVCRx4v0qVQynPH/FiLcwQ/vMQb4QiWWOk1ZWgEmm5Fgkg02Oc0QZyBiS2syDca9ry/rYNt2yKHdW+IqhODbi/2cun4QoUSNQLcVbsDZ4Q3gl4puYjOQNcRYdwjrrfJX7Lxxq6waOxJdkSKtucOaLtD1TxZjLubb7T+U7Wodg+UcCvEy9Vf7Sdg/UWmeTpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D1SRYRj549j2XPnJd0ES06nTnLWMXYj7DmwV5/M5kgQ=;
 b=aQTSnz+1bBLcA5HYXZ8MG9ZeB3BvhL54wMX0clv86tpdOO2/BLghvgyY2NLQkgZQIGkfLqfq89T9DfuX4k38S3O1Y/MvHj01F7Gtm2M7eiqqAeFMG9Ewr3zemkza+A5vPbV3f4gw/8ZZaRfo1gtJOEfWgZ0acn0ctstAgDs6tVqU7+XW+6yvjNpeFqsl2qWNb7SZEr3sJzzOdwdd1oIvPzkVv3Wuh9redieVu4ahzk8Jd/RvghkFEfyUM8sw2wvFVtdJ0GSXvjJvkb41VjRlmoeoZRGojAj/KGjp9q95m+z1yQqPrWHlgRUPLo9p5belbwdKVWxMvjqQIuUj4E3aMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D1SRYRj549j2XPnJd0ES06nTnLWMXYj7DmwV5/M5kgQ=;
 b=rLCoUC8/x1wFUAsHuKrsqoGzry2obfxhsOE6gmpkWrHMWtwiTjrw4RKbPXjFfbn1hBF8oTblWej8XjtRdi87ew4CKROjhJwuXFO6bmyECtRYD9i4Zg0Dr++obSI6OtFzhJPgk8RF6NJp5JAAZz7HnLYohhn8k3x9P91aUpIS/ks=
Received: from CH0PR03CA0362.namprd03.prod.outlook.com (2603:10b6:610:119::9)
 by IA0PR12MB7627.namprd12.prod.outlook.com (2603:10b6:208:437::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Fri, 14 Nov
 2025 21:40:18 +0000
Received: from CH1PEPF0000AD83.namprd04.prod.outlook.com
 (2603:10b6:610:119:cafe::fd) by CH0PR03CA0362.outlook.office365.com
 (2603:10b6:610:119::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.18 via Frontend Transport; Fri,
 14 Nov 2025 21:40:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD83.mail.protection.outlook.com (10.167.244.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Fri, 14 Nov 2025 21:40:18 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 14 Nov
 2025 13:40:15 -0800
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v7 09/11] cxl/acpi: Prepare use of EFI runtime services
Date: Fri, 14 Nov 2025 22:39:22 +0100
Message-ID: <20251114213931.30754-10-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251114213931.30754-1-rrichter@amd.com>
References: <20251114213931.30754-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD83:EE_|IA0PR12MB7627:EE_
X-MS-Office365-Filtering-Correlation-Id: 61a298e1-48e7-46af-3f0b-08de23c667a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GeSVmIwaBenB1fnw4APE/3P+ccQ2krnjZHAc9oHJimumsLWcxmqOGf2DOF9T?=
 =?us-ascii?Q?AbNvnsCboztx7aapZ4T22buKai67BjefXGyNSrOUUOyWvqZiCo3n6l9nnLHQ?=
 =?us-ascii?Q?oDQbSrW0cV0tVCqiGdmu+ynFRDjyX70AsE1khxiM9BD1zbmBTbmGPqcpDbzx?=
 =?us-ascii?Q?g/AEo/HK5pZjLeeUcquOPFuY+NWix3jdPX0F1aYJBYiZxkq8YnNUQjypu07U?=
 =?us-ascii?Q?9/jA6os472CzE7lEElb3Y84avq3pLuMMf20Xh/P01NJfa+4QOCA5wxy+fsVs?=
 =?us-ascii?Q?x1SfBkNqUR1TieQdigyVPuinMz1q9n+ymSdviUuLLqhbOsTWVqCQPiunq+OV?=
 =?us-ascii?Q?I3zdmK9JYcVF8xnHMl9gK5ZGYwJh8NVHlQOWOQAqUK0Bag9prQaI9vbCUSYn?=
 =?us-ascii?Q?HhYDR7eNgNpUK39LceuXLpDqIvQemvWB2koQF8PbKG8Qb7z5BLNLS4YkSXV1?=
 =?us-ascii?Q?dEkrEE8Rmg6xxLB8NbHSA8ngbdfdn0EYjeVl7xkn3RQzvUKVimAVnq0Gsqxq?=
 =?us-ascii?Q?APx6pkMm8KzIpKLc41JM0D0AKAxexu0IzLK9CqxMS95pbnxCHawpmZDnGNcY?=
 =?us-ascii?Q?QVx2SS08TkZ6u+wAEDgSO1EDrHkSpD6e/8YmxSDAdlec3RMiZbAn5gaGQFmX?=
 =?us-ascii?Q?oAEqyeZd8zRxgUzhF5zDW8zrToUbUaRqg7BTcp2YGK+LY/LUEE9lwkzO88UX?=
 =?us-ascii?Q?ajIHlzfehmWCwmphyUjFdqu0kLQNxSItQGbw/tof5tqjcueDAfX33DrI8e8z?=
 =?us-ascii?Q?H/eOjJibNugN8rv6cpvrJbGUuG6Lw0Wmp+mbhDZ2hA6nQiZoXTEziqCTF8jC?=
 =?us-ascii?Q?2hwXmZr96Q7DU/EpL+4hOorKv+CVLdZ9LljzkP1yzYHsEP3QTPlRbA4G12xO?=
 =?us-ascii?Q?9YCecWWeJGRi2smosciKKN9mjfrl5XFJpDnbCHd4Duwjz9NK9QNIOng3K5aJ?=
 =?us-ascii?Q?wT6GNLzCf6MsN8ruIWho2LggbZgxeAiXyaAEchy3vE0Ia/28ry+1qB5qgOkR?=
 =?us-ascii?Q?V7MfcXCh7iWWnyr1nEk0klhdoY3lpP/Ndg5hg/zbEtcpDpK3k49QJgsNm2ia?=
 =?us-ascii?Q?K6WmVIJ1nqEYhJnPCaSXxEaD2ln29mK4ykvf3q/wM5FB+kU7Ow1cWFfdtd/N?=
 =?us-ascii?Q?0FiylrF28XGC+yCSSqbhhWqnZAC+A8SaPO28h2Jwo3iOl4CQfXxk+2eR02nq?=
 =?us-ascii?Q?f+tFibi9kXLrsI24vSZOD72erIxMXdbyJK8OsS5dHOlTOsTQgTYaR61i3w3U?=
 =?us-ascii?Q?jwELtZRYe9//EwTpQjirvKM4KxUAMVFfUpTnwkCSqB8moFmgfcBPwYXbm0VI?=
 =?us-ascii?Q?H/HKyK4i/TIBNMUjp4dN5+7IvMXc4KXfbINsjMn7zE2vLoJxFeKCKLLdxcya?=
 =?us-ascii?Q?yGyFR69FIOGVBjqGuMv4PaZ2NiB6Il7XZVf91H780EQ8SaBQLysQKXlsaNYD?=
 =?us-ascii?Q?0umtXbxNUGN7gOqSLoaIEyGVcVnbsyHBhIKYhSdF40uD69OoJzIt5pc+hSys?=
 =?us-ascii?Q?OreNGGZZbdrV2FeEeJDyxCEtzEK3n2882jp6c5JboIY6nZbc5+x9zXZyHd2D?=
 =?us-ascii?Q?YMwVWFzJNFkcWL9Z/Fs=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 21:40:18.1959
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61a298e1-48e7-46af-3f0b-08de23c667a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD83.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7627

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

