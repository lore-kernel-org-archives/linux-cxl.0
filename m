Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2080.outbound.protection.outlook.com [40.107.212.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D061F428F;
	Tue, 11 Feb 2025 09:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739267720; cv=fail; b=kvUjWKD6SzLn3d8+06fpyWnlAg6Q93xjJ34brr0tToBCH2Op/esLTrpj6SJrkcxXWR6EQAicF/rkcjvo/IvRWZvaLaxh9k5eUe4dZny0Dgz2Wv492GcJ1LQKR8Pj6l3xXnbJ5+Ny7GQpS8ZjRYxv/YWpvtHfXutsBPhfV7qM074=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739267720; c=relaxed/simple;
	bh=A9cVDl3bQOs196uxfIUSsJz0rUZpdS2YD4plaJqzi2g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y/lvhLsoJs9ArpyqN2UzLc6NdRjgWhmcTx8x1pD0pBwEAcEMHjT8w9D36EevpYzTBGSYPS/NR1M/hlcEWteThWUbJu45+m9Yr4E35i1knTbPFp6WLx045gm2No+sHlkSh5oNnVsGnLQ10GyuGRtup+EFeMb+LfHcSdeTfE4ye6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qecTafcp; arc=fail smtp.client-ip=40.107.212.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qecTafcp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KKzMiO/bl8aNYTlL/T1vRYVRN85TG4rQ2RJzze9CTjI3Lt74pAxu+7tWrNYLJX7nSiN98cM+bh95cXh1ZfGm6WIYO0+SdgFrim58GIACTq7EYairiNFIIo3Mx+l5TX3dDZUgL5rSz45FZ+q8eIUX8f5aopuSi8GGg2AISHkSLcxciqAJDdJvFt/OtsUFfeYcaIXm5V9LCyOZZbcCi1lqrQt4xOY/ROMXTWUgllNmnbkwo+nsw4QK4Gl8Swv7D7QVUQngztIApRz81Llzh7xpnheM+EMiS3lkRkMFV0eWhWEnvDRD8nHK6zW9KKaXqa/nQZAAzGxz+x5bC8htkmF99A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZtfQ7VnNI0gPjqacWRRWmPWyXHixE15rulj1hLdT0jQ=;
 b=ukp6TUhp5k9pZLAU47Ywp0vft3TRT/K/D00Bx/IoYIYhd4EKsAlGk8ln5RgMTuNPyF/YQ6eVVRKOSYgDjq2tV/cjKVgnflysb3kdzsF0iu/QspGldwkuTw6UdnQoXgBLN1mFidmIBpQP7dzAWu1HCZWMIv9L7/BbmKXbZR03Mb4w7GKqvOEMvx4hqCKzEmKu/iPzWZ/3sqJAc5LK00cpH22oblUL0AESJJg3tIOZoBGFQEFqMJMgUAraR+92fIfkG7VA/KgLm1UPWexk+9RGtEGsEcjGO9NerKfu6cvnAvGkD26Hvj+LyqTHwYHPBqnSu+b20dzYQqk/1NalB7ifVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZtfQ7VnNI0gPjqacWRRWmPWyXHixE15rulj1hLdT0jQ=;
 b=qecTafcpv2KYcwXbWv3rn+fbsXQ6qjSv2+nav+De1xLXL3Z/DYfhfpGOTSP7O1DdcSkLsJAfYKKI57Mhc4pPl352akLQ7u+NLX5jTClmH+9naim291bHgZNgnKiPzj/YBhKMopK1ZNHiWqWOgUL5k6Fhss5jZK/DSvae4uPDROE=
Received: from BY3PR05CA0045.namprd05.prod.outlook.com (2603:10b6:a03:39b::20)
 by CH3PR12MB8581.namprd12.prod.outlook.com (2603:10b6:610:15d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 09:55:14 +0000
Received: from CO1PEPF000042A8.namprd03.prod.outlook.com
 (2603:10b6:a03:39b:cafe::dc) by BY3PR05CA0045.outlook.office365.com
 (2603:10b6:a03:39b::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.12 via Frontend Transport; Tue,
 11 Feb 2025 09:55:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A8.mail.protection.outlook.com (10.167.243.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Tue, 11 Feb 2025 09:55:13 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Feb
 2025 03:55:09 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v3 15/18] cxl/region: Add a dev_warn() on registration failure
Date: Tue, 11 Feb 2025 10:53:45 +0100
Message-ID: <20250211095349.981096-16-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250211095349.981096-1-rrichter@amd.com>
References: <20250211095349.981096-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A8:EE_|CH3PR12MB8581:EE_
X-MS-Office365-Filtering-Correlation-Id: 8608dd74-ee98-42b1-1a4f-08dd4a822e5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P7bvFsNEPnZvPfLSMyZ6E74EY/7gH0N0ayjpPv0OX8JPW69cvKmdSutZpkX1?=
 =?us-ascii?Q?mnF2z9g1jSc//kMUOxwcy1JOe9yNGYU/wWEEfk0bSKPeI9kBzBtlcb+ubep8?=
 =?us-ascii?Q?2pDxk973/46PYF7/mt69CGqT3JYqFR+eYJ8aTPnDAJ0CU8XTpgVixq2hiPyr?=
 =?us-ascii?Q?/Z8pDb3BBLkg0t5CW6roClP+lBxIYgYoqouMkapboWmoxh5NhJ0LhIQ5rMhC?=
 =?us-ascii?Q?S3c4Ioj2/ppXQjwAm4F3eTY8eOlWGQb2R7idWsoO+6J7wwzC/phLRF96m+DA?=
 =?us-ascii?Q?40pBc2B9ytITodfssRbYiV184eCeYNzqhU56lOmy+i6qmnJn0x8aJsdlVIRw?=
 =?us-ascii?Q?q4kvuoo6HUGaxmmDWF9zt/YUH79fia0ZBfDAeWC40YhI4atFpZQU5T0Sx+IF?=
 =?us-ascii?Q?OtXW4HWomoSVOagRa8D56oTrnIvN6SwiMNZMxK90BuTMl0B5b8pn0h+ew4UR?=
 =?us-ascii?Q?fNoQkfXV/fLHXPhIfRBuFmwPuIQZl/Xezp/zg1El0Lnnz01cHZ7cyr1StAgF?=
 =?us-ascii?Q?XaIjyP2EqIZdXi2PU8Xh1MsjkBix2mXrBUT8/0avxobIX7trjo02tv6aWbY/?=
 =?us-ascii?Q?Dg0F+5wUEb/EMGToNAO34CQxtmDOrmDqcTuzHCKItj37FU9dOOCDb2e5TkPq?=
 =?us-ascii?Q?PNQtSqgPHmRTSZjveqmSfPiHbq7sPp6GIr+c8dPyX+LeA8BirxA2l3i6o5wB?=
 =?us-ascii?Q?UC7tXa1PXSNRXM2slPgUVsxAFs2CSluqVOHKBBNQNYuqbH349S10l0m4zuiO?=
 =?us-ascii?Q?axWr/acJEY7OFwkmhasq+28Oyk8Znh2UDtSQUHL+5M1GF0k1Rxq4rpNn/pbg?=
 =?us-ascii?Q?i8ERZv1GvRJY0//Wi2F1LkOGCcjUPRxmxe9l9c1MF/JQ1xMPNawHWDJD5Arx?=
 =?us-ascii?Q?0SW/Lo67TaA/yVcovocCNSCouAwfyiC0AYL5LEm/iajhAe1oz9PoUD6Rz5JD?=
 =?us-ascii?Q?V6gXugU5yX2uclzklt3rIWBXrnjLs5SalJ0zofQO8dABHokEH5s+UUYBZL42?=
 =?us-ascii?Q?QU39LbKbxDzC7gqUsGyrP14F9gNTtGRTuwWYQ8qA7kuFCPRl3LzRZnayunyN?=
 =?us-ascii?Q?laxIxqTnyE6yBhrYIqxbVYVpiCzffcoUzfnyz+mllGEKHN0ctYQTuDpeOKe8?=
 =?us-ascii?Q?lvel/lF8gn3C2Rn/aVtObCPmfPfBO2tSzOMbLKchooe5EzioWOHq1HUXw6Zs?=
 =?us-ascii?Q?k0ZtW8S55n8RAOsZSLe5SMkE8ULNMal1ztA7NMZvmVMZQROzVSv+JgU5NndR?=
 =?us-ascii?Q?ml2kYhwVyDuHbR83AUM+dBHDzStuvluNJ5zxpd/1vPP1vH3nua82pJNYgfri?=
 =?us-ascii?Q?BVKngMF/0XF6XPnLA0py5cdtxil3VDMbv30flw+2bvnqpX3wa6RJKB9e8SUo?=
 =?us-ascii?Q?/Om3hdswp/bgfsZQ47HzW/2lRakYhxKpArN3mk0PfwBn5Or0P9bpv1ovj9zE?=
 =?us-ascii?Q?w7kwiFNvLT88zCPVJ9wzHSIWHhfxYqcGGMl39RMzPgtqne5Y4m7UF6mDnOtn?=
 =?us-ascii?Q?2xvSV5BTFRfzvuI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 09:55:13.9376
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8608dd74-ee98-42b1-1a4f-08dd4a822e5c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042A8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8581

Esp. in complex system configurations with multiple endpoints and
interleaving setups it is hard to detect region setup failures as its
registration may silently fail. Add messages to show registration
failures.

Example log message:

  cxl region5: region sort successful
  cxl region5: mem0:endpoint5 decoder5.0 add: mem0:decoder5.0 @ 0 next: none nr_eps: 1 nr_targets: 1
  cxl_port endpoint5: decoder5.0: range: 0x22350000000-0x2634fffffff iw: 1 ig: 256
  cxl region5: pci0000:e0:port1 decoder1.2 add: mem0:decoder5.0 @ 0 next: mem0 nr_eps: 1 nr_targets: 1
  cxl region5: pci0000:e0:port1 iw: 1 ig: 256
  cxl region5: pci0000:e0:port1: decoder1.2 expected 0000:e0:01.2 at 0
  cxl endpoint5: failed to attach decoder5.0 to region5: -6
  cxl_port endpoint5: probe: 0

Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Tested-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/region.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index ebcfbfe9eafc..3031d4773274 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2147,6 +2147,12 @@ static int attach_target(struct cxl_region *cxlr,
 	rc = cxl_region_attach(cxlr, cxled, pos);
 	up_read(&cxl_dpa_rwsem);
 	up_write(&cxl_region_rwsem);
+
+	if (rc)
+		dev_warn(cxled->cxld.dev.parent,
+			"failed to attach %s to %s: %d\n",
+			dev_name(&cxled->cxld.dev), dev_name(&cxlr->dev), rc);
+
 	return rc;
 }
 
-- 
2.39.5

