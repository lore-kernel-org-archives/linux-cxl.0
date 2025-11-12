Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011064.outbound.protection.outlook.com [40.107.208.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A692D131D;
	Wed, 12 Nov 2025 20:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762979559; cv=fail; b=Hl7ng9ZrpbA4MwGXSB6lVkgdSNHWjbDLqrfl6yiQIBtQAJeUNtY0Opz9TdwlOinwMCBJZFLL72hkPj/pLemyBdbycHLRkgTd0UMkqRfHw9CgkqKmBcHskxyh0A4VvS03a1HigpT4RuGgOhKG2ctQK+MSE6GEqn+hIDBcF16+ml4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762979559; c=relaxed/simple;
	bh=wTmvORL8tAPljyrlEObROspchDx7t1CByalzGIXj/Z8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OXDr2DmgO/zLpkeG5G61PnTfwmYCCLnkWtE7k3RRRzt7OGRQCJOyPfMUtmnMPba6xFptCCJhJ8J4Wvxvz140rulPsHIg830/Xp1J+QhUump24sJ5vLQsv9eZMIZkliXhGWatwfdGhaQYD9UcsVPkl/2i2cX3ZH2WFOWMPUdLZTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HJwbdnt9; arc=fail smtp.client-ip=40.107.208.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HJwbdnt9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kAPay9iEo7IvbeqdLmyz2W7GEvEd8Cu+jEhViQdeMO+UrTlT+ZJNqmnZ8Q6MdsJpYlvTadVjxPSh2Ikd0dZguZqxMW09mmxaGhtgi2F2oOxNf6/HkoV6Vj5N6ZY9i7IIBolnS5PLuTEkkQ5pElcnQn/ddq1Ld1ScFtBQnRtjFBmZApC4ZjccX7OTgD1vKNKkuCTKN+2SzmnZvFptOyDakeQIwAlnV1NvL6YRwSvoxnQ45Bk6OCnqZv/0QuTHJQ70ybWNvkrubO6742mrwxGa+RAiXMf6IA/6ZFn+XMAK95qv+avZrN9cYZXg02+P10rIlZhOgizwLjbHLlNNoW0juQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9nAYjFGpgizZsPBLVyF5R44opjbDPNo4v4rh9xyImos=;
 b=oOOS0LwDYLKt8ihXJ6vHs6gYrSCxGMb7EjFzVxwTor7STM075lX4AJRkb/dWNHHauuAHlXzeCqvLy3+PRsJp36FvlroB+7OVHkaUM4U2BeK3upRZbNTD6c96fWzbRnTRc8Oj6Bqe6qyGfq3rrQIkHWwg+Ek2CieUWBxk9eIiWrpdhQyvOKgGPTEneBLICZRT+D2+cxHQ+GYJDRotZBZ6zEGPdZKCSY0UYxW4JGO7kv4SFuNFKYZrP2fuKr8s+2LP0otWk8pgsZqPNekqEIgu0Yf7RiboeO8M8mYjrMPOx5RwxrXzRBq7106bLCAI3g8AsUQe4XzsLOpakQUL6RQL5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9nAYjFGpgizZsPBLVyF5R44opjbDPNo4v4rh9xyImos=;
 b=HJwbdnt96PHS+wdevy9yyhUvQfmM/PblmnASZo02HFfNIt6wiDrDeMjvWfb/8+xS7nCwXGuuh1euJps0lLlyfR3jy95Y6Xk7iKSi6B416nWzK0Z98E8m0qJoE8Dqw4zMzkSYkOZZjOjR6ILLST93LasZw1386BJHM1koE2TwE/U=
Received: from CH5PR04CA0006.namprd04.prod.outlook.com (2603:10b6:610:1f4::11)
 by SA3PR12MB9159.namprd12.prod.outlook.com (2603:10b6:806:3a0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 20:32:27 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:610:1f4:cafe::7e) by CH5PR04CA0006.outlook.office365.com
 (2603:10b6:610:1f4::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Wed,
 12 Nov 2025 20:32:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 20:32:26 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 12 Nov
 2025 12:32:23 -0800
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v5 09/11] cxl/acpi: Prepare use of EFI runtime services
Date: Wed, 12 Nov 2025 21:31:36 +0100
Message-ID: <20251112203143.1269944-10-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|SA3PR12MB9159:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e3da646-4278-4ef0-2ebf-08de222a9819
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?x7hpUOiATvD9mIJ8u9WJf9Jup3dFj6YC3hG2WNw0nMJSmKNlI8cPy4ldPD2M?=
 =?us-ascii?Q?jKy9Jxm7ENYvQZ6+SpmBhuhDn5Rk13VGIFJFgKrWhrI6k8ioC+ViYIag4iXu?=
 =?us-ascii?Q?SuO1/KutaHnVzNZCpUPV6rtzfvhY02CpXbNNRiKb2/9aLITqWKdfxpfCQzS1?=
 =?us-ascii?Q?78p8y0UPl300hxDvkfz61QeUyYA3Wem1ZEBX8piRtBAS4aZx4c+1/QNMiZHt?=
 =?us-ascii?Q?jjGHvKBLa2HrssOTZ/G0tDsTJzb7mO5HJgsYSgSzSCD1uEbTl6HBRHRbNT6P?=
 =?us-ascii?Q?Ssi27IfonAvlFqw+eR1OEYEO6wdIS02l8xMQaDd8IruryPwx8e7Kr0CJJOxf?=
 =?us-ascii?Q?kCK3mU9hnJec7PW378p+625xPMHeUJk28CzF751f80d/PUC4kpBDdas4B1sS?=
 =?us-ascii?Q?R4O5eIZikEE3dKkyQiuqk021kI/Jz8rekJliVotBZMuvOmKF7ZYmP5JuD0IJ?=
 =?us-ascii?Q?ynApljqA/y+53QHgtw/BEInGxT3SuBanuy1hkzckntMoAHb3iKQddMO74M27?=
 =?us-ascii?Q?pIOzLolinsrc8ef8M4ESwA4UVu+Sbu6b43VbIWKo/XPi23reQinIpr1lc0Dv?=
 =?us-ascii?Q?FnEIWG4sUu26wOVknwvBVfnLsL2e6qPl6vHZpS2pd9WnW11wUdIWSVTexuRe?=
 =?us-ascii?Q?RNjms6GtwuV9kNUzwmql1eMBddJh8ZKf0NMYlB5O9wsIQIgz4skKhDFfE+uU?=
 =?us-ascii?Q?YPKoEfCb0+OKV4Aj+FhAgxLnQEBRZvOggE43y2a7yQxebetOqEq3mfuRyu0o?=
 =?us-ascii?Q?UnEnozkDPgPST84wgO5gNLZ4NGoC/vgdXIXndW1ssTGxs0DTqw3iNfdG3Kub?=
 =?us-ascii?Q?ORIrrbcGgkgDR8UEWIRd+jryocaofUrmxSM7EO+pYn2l+ZThXAnU5V/2jcTh?=
 =?us-ascii?Q?Z4rE1oUZKJwRMYvPzNMCzJ6IlnJk/tJTK5x1yF+7UB8+xQbo/iNq/tg0KOOB?=
 =?us-ascii?Q?CXOXeF8TMnBfkL6YJMQU0bYFeVD/oL2jk+An9/1cnBp+s96uoHjANzgMkWeA?=
 =?us-ascii?Q?e3fgFUFvx4PWtz79sgoi70iu43vctsu6KyOHsEXZm2b7mmgOQS2WOBGzNwrQ?=
 =?us-ascii?Q?II7Oj6iPNlXZQCS6KL/eCMl2Ng5/QTNa1xDzd6fzuRLLhxDZJMfdr6V4iU5D?=
 =?us-ascii?Q?3eldBUIhN3UNyZxaKmrGsMLqdDq/ZMivSlxIjuJP/v0zsmJer1BlE+o06Aw1?=
 =?us-ascii?Q?TN9j+VVly2fZ2589tKnVePKp0hT8tvG7qo3QDa9fi9k6nUD4GTmuvxwpmFCn?=
 =?us-ascii?Q?pU6n4ht2gCXXGm/cgZkLVepIL9bhQC3OMkMrQhDjw5aW/f5JhRYDUJqG61g2?=
 =?us-ascii?Q?Vg68cF3yelw8evmBM3/axEBJCq5ikc8zH120wRm9T6qMTfOGimYfk3WpDUCH?=
 =?us-ascii?Q?twrIrE3nfh1AL2BhLvJbFKZdZxUIgJSwgbiiyUEjuyPiqJr06aKgax4Ts1J5?=
 =?us-ascii?Q?fbNePuhZYik6K4xXs55G3WnA5WAv/vGwcYy3mH2VRie8XRxhkYwObR6DsKo9?=
 =?us-ascii?Q?E6lE57ZX3zr5rqiwRxupxxgHrzhUfLl3xLOTK98w1dFuaXNGrr+UaZLcvEog?=
 =?us-ascii?Q?jyuKFXkG6IBQAxovh1c=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 20:32:26.8146
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e3da646-4278-4ef0-2ebf-08de222a9819
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9159

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
index 4fe489244a77..52b3c162a564 100644
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
2.47.3

