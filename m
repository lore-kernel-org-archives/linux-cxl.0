Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010050.outbound.protection.outlook.com [52.101.193.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362693B95E1;
	Thu,  8 Jan 2026 10:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767867249; cv=fail; b=hY06aHwCLtDiAPNwnCc8XrHzcnI/Rt87gdVc+8bGrMv2WFkwINPrCZjIsU0I9DqRLjJPM2IKeKYz1/lQ0SVgL7dqJnkK7YY9G0L2WbJrJt/qd99gOZuuuanvpzQ2MoAIVTOKvqULYjkg7JSPhapmMbNyy++KkE6jTH74jj6JRD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767867249; c=relaxed/simple;
	bh=61mEag9CayC3dXJjL5zpdUn5OgG4sjE2y+UPDIriKoQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tXKPCvkFRw205HWd3xXvhsz4bDbturWMmJGEnMJdBrpytSn5NlbIIivC2fR4+OMou8T+5GRloNd4iXhqVBPgvFsUvmaFvf6o/WcVgZ89FwSuzOgVu92YyZ17FIJYwG/2uMQf+Ks/hCCoTbnRqg60n5JoX8d1oWr7tZ3Z7y24WcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yhrqwoXb; arc=fail smtp.client-ip=52.101.193.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yhrqwoXb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JuQ08M5cs/gKMKmlnIlex7Jz4kIYQyjBGJG3rCOug//P1HNT4Eh7gAu7+MkxdriAJtTdoG+FVCl027F2WF5efr97499RmFfLS5TJJKHON7RgF7CV0DSJPdR/kd+U4fJbZRE6sl0dJKccPhPI9DtGSD3zrv0AQJb1NplcQU/xjkbSb+3lg11ZueVAIsjIpzBSjKJJJJe7styLN1C+qaBBPHsC0hUTdLsb7wPSOqvxYb3id+LVHK+FNfCzmOrf0OYoUMTduGeChumRqETlbk3th5f+g8/UinR50TJZgSWVGcdm85/Oim5mLuuNaVUSX6bPjR1jwoCt+6+JZEdBvVIJ0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nYOCFpe1ATQJS22GjA2HvwXPMy51Ki4rkQKRr9bUtAs=;
 b=JakHatfiU5NBM35rVQmDrBU6ILBsqrQMoxxyOuXeJHVA7Doo+DseTJ/Ohsmiz6GWBLiomgjRlPJ26JgJ06h0TT+nTDa9VWnKTDVQ4AuRwyNMc2bIrTQ0MP4iV/eu0+NOGwuNlhFOnIfoiwCI+bdhDPDbq1xjuxtCZ/0QIBg8cS6Z8B6ZoHoSdKo+QHJyx5FrftKBk7eSxLsSNpmVQtAWqyi2UEvZJPuXKq2fjNiD937y4rpZwsZXqge5bcm9eQqr/kFQLOQvq1I6osJ4nEqO9z9WLO9qVDBWqjsK8hdGWJ9FU1Tl1QuBHVgQfcRXUGgCMQItTC//wmIkDhSOqUmz7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nYOCFpe1ATQJS22GjA2HvwXPMy51Ki4rkQKRr9bUtAs=;
 b=yhrqwoXbYU36HLJ/th1T3vo3oiOPIpLxoHVcZSxet2KFmwVlKfw6UBudVDDj0l95m+PmPXB5XQGbTV91gVyOUt6HPtE5+HaRzEyzFUcFAf/+6HLj+HgJ0IbmhxKqAeSY5VX5AncgZVYQj3fJVVdVwcTP+o8p8BtglykNGGJFniA=
Received: from SJ0PR05CA0126.namprd05.prod.outlook.com (2603:10b6:a03:33d::11)
 by BY5PR12MB4164.namprd12.prod.outlook.com (2603:10b6:a03:207::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 10:13:59 +0000
Received: from SJ1PEPF00002317.namprd03.prod.outlook.com
 (2603:10b6:a03:33d:cafe::20) by SJ0PR05CA0126.outlook.office365.com
 (2603:10b6:a03:33d::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.0 via Frontend Transport; Thu, 8
 Jan 2026 10:13:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002317.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 10:13:58 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 8 Jan
 2026 04:13:56 -0600
From: Robert Richter <rrichter@amd.com>
To: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: Robert Richter <rrichter@amd.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v3] cxl/port: Fix target list setup for multiple decoders sharing the same dport
Date: Thu, 8 Jan 2026 11:13:23 +0100
Message-ID: <20260108101324.509667-1-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002317:EE_|BY5PR12MB4164:EE_
X-MS-Office365-Filtering-Correlation-Id: 204a3371-52eb-45f5-4f9c-08de4e9ea394
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sqcaAeSZSiGWl/zDMybEuBsIvacbfSa3GF5rQ0KAE6nk5Pr2EyvNZjoHALCQ?=
 =?us-ascii?Q?QCt52n0iYYhm9dBgmIzlfBqBPXwiO6cd5Tm5FbUpCoZh5p+O4EKkyUX3qHcc?=
 =?us-ascii?Q?vf4ow7Elq8dMXPBhD9uRGfu+j1nhVvmZ22oYiBtfdoFOv/bIG5vsos4M1lzG?=
 =?us-ascii?Q?YMkMbB4s0nAXfDcC6Nh8onvP/4+rrrBmIbkBD/3uQFuxreyIRh5i1+36kubZ?=
 =?us-ascii?Q?85R5mDwUr4sI0BhBvWOWG7PRnouLlByDbPybz2nspSzFczy3Q3DepLdBcxvq?=
 =?us-ascii?Q?5pbQcm7KG6LMPIabp7cqTwyGe8nDgZysYwVf/AvSOgQmTGvS8lpMGkUqKX1X?=
 =?us-ascii?Q?E4AJqGokpDM0ME/cXMbB9IkHfiV2U7wL4HbnnWfHuDcXsmiTQOuYD7y4JMsQ?=
 =?us-ascii?Q?6j7DzrOf7oS11KOBEEO107S1IZuhuRI6bYC5uDDw950HMkAS2b8gffcu51Bx?=
 =?us-ascii?Q?zP7gFQmaaL33H366j5KX9c7Cwn/lkXbdefw4GcL+piEmN7jtjccfY5aLkZMf?=
 =?us-ascii?Q?fYNvnVNmZSsDOmI6ZFpSCuFsem7qTlbLCAs6g6Fy+0P6ePPi19iNfcSh09F7?=
 =?us-ascii?Q?aS8uBgqQortryC8kqFOAxBVHpmpIjcW46Mw5rR9hxAEtL6GFM032irqrD6R0?=
 =?us-ascii?Q?6Uu3BDJ8L4FL0MmodaESscmzEcsFEehXqhUXGq1qW5NLW9XqapvNpXzWXvEE?=
 =?us-ascii?Q?k4qctvklTpZSIV0biQXOhxCOS3M1cAvFmjDxCmzDGjuSf44su6HzwE7Vzy8t?=
 =?us-ascii?Q?3VwAQmQ0DHaRS6O6RQef36+QqjG+fDR7dAS1B+5y/xQtMKxzGr1kdz/aLgDY?=
 =?us-ascii?Q?Mni16GwcaVv+0uC9EejeZtvQGCXXetdSQAPBrotxlXZPex79vKQ1TYvrN1q2?=
 =?us-ascii?Q?Aq9ueEWJVfBILg/uPPrrbeoolJb/9X7BxvucBs/nusBDBsUEie/UAU/41HW6?=
 =?us-ascii?Q?QW00VhLk8h1uzz/dPdL/N/2NVdeoOhKK5xCnJobBQj6Y3WZmCl6Eqa/1buZm?=
 =?us-ascii?Q?yN3p0WXUOz0ASLkvH3qFBSjg/DWVNbq5uepyIQ0kVrpX709MRdoD4RqZYI31?=
 =?us-ascii?Q?lEG5anngmy22lJe4hcpB/sl2VPCFy1dXeXlw89JclRIzlYDG25+ktKE14TOo?=
 =?us-ascii?Q?S1CJOa6EDAW6tFDKSDAcky3SKJNTajJHcyN9zACZO93pu33Y+CDpyGxkZdBs?=
 =?us-ascii?Q?Wg0hgtiuP7iIPPM5orughxQD6gYXZ73y8KYckEbqwbDRNRi4LOLHIDqIcIke?=
 =?us-ascii?Q?0ktYzMxVgi24LXoOCYWPy40KHls7AUVtVtWksb+rRzDKZ+tM3MDL0pFXhpsB?=
 =?us-ascii?Q?oeawWN7YsGjvtBRIyaHwxWnFB9184nD0ttf6pMTwzxKY0C5c3MHDGbBHS8oB?=
 =?us-ascii?Q?IxmfyCcuYQ97uUlzroD044wxzV/Sas6ea3nOs+BWaCpR3ytpnDaYjeWvyCRe?=
 =?us-ascii?Q?19OoCC9JAsQ9RZNlcV6Bl19efi7EemwD4Pd/UUAfnhrijOicoc3gdBYt05Im?=
 =?us-ascii?Q?XfBjJj9QuFamQtx4YA4BOInYbuKDiJz9BoEDVav79nK9qNdq6W8qhgkTgXpA?=
 =?us-ascii?Q?KJ3YybSgBdILo3QTDgg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 10:13:58.8027
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 204a3371-52eb-45f5-4f9c-08de4e9ea394
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002317.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4164

If a switch port has more than one decoder that is using the same
downstream port, the enumeration of the target lists may fail with:

 # dmesg | grep target.list
 update_decoder_targets: cxl decoder1.0: dport3 found in target list, index 3
 update_decoder_targets: cxl decoder1.0: dport2 found in target list, index 2
 update_decoder_targets: cxl decoder1.0: dport0 found in target list, index 0
 update_decoder_targets: cxl decoder2.0: dport3 found in target list, index 1
 update_decoder_targets: cxl decoder4.0: dport3 found in target list, index 1
 cxl_mem mem6: failed to find endpoint12:0000:00:01.4 in target list of decoder2.1
 cxl_mem mem8: failed to find endpoint13:0000:20:01.4 in target list of decoder4.1

The case, that the same downstream port can be used in multiple target
lists, is allowed and possible.

Fix the update of the target list. Enumerate all children of the
switch port and do not stop the iteration after the first matching
target was found.

With the fix applied:

 # dmesg | grep target.list
 update_decoder_targets: cxl decoder1.0: dport2 found in target list, index 2
 update_decoder_targets: cxl decoder1.0: dport0 found in target list, index 0
 update_decoder_targets: cxl decoder1.0: dport3 found in target list, index 3
 update_decoder_targets: cxl decoder2.0: dport3 found in target list, index 1
 update_decoder_targets: cxl decoder2.1: dport3 found in target list, index 1
 update_decoder_targets: cxl decoder4.0: dport3 found in target list, index 1
 update_decoder_targets: cxl decoder4.1: dport3 found in target list, index 1

Analyzing the conditions when this happens:

1) A dport is shared by multiple decoders.

2) The decoders have interleaving configured (ways > 1).

The configuration above has the following hierarchy details (fixed
version):

 root0
 |_
 | |
 | decoder0.1
 | ways: 2
 | target_list: 0,1
 |_______________________________________
 |                                       |
 | dport0                                | dport1
 |                                       |
 port2                                   port4
 |                                       |
 |___________________                    |_____________________
 | |                 |                   | |                   |
 | decoder2.0        decoder2.1          | decoder4.0          decoder4.1
 | ways: 2           ways: 2             | ways: 2             ways: 2
 | target_list: 2,3  target_list: 2,3    | target_list: 2,3    target_list: 2,3
 |___________________                    |___________________
 |                   |                   |                   |
 | dport2            | dport3            | dport2            | dport3
 |                   |                   |                   |
 endpoint7           endpoint12          endpoint9           endpoint13
 |_                  |_                  |_                  |_
 | |                 | |                 | |                 | |
 | decoder7.0        | decoder12.0       | decoder9.0        | decoder13.0
 | decoder7.2        | decoder12.2       | decoder9.2        | decoder13.2
 |                   |                   |                   |
 mem3                mem5                mem6                mem8

Note: Device numbers vary for every boot.

Current kernel fails to enumerate endpoint12 and endpoint13 as the
target list is not updated for the second decoder.

Fixes: 4f06d81e7c6a ("cxl: Defer dport allocation for switch ports")
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
v2:
 * updated sob-chain,
 * added fixes tag (Dave).
---
 drivers/cxl/core/port.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index fef3aa0c6680..3310dbfae9d6 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1590,7 +1590,7 @@ static int update_decoder_targets(struct device *dev, void *data)
 			cxlsd->target[i] = dport;
 			dev_dbg(dev, "dport%d found in target list, index %d\n",
 				dport->port_id, i);
-			return 1;
+			return 0;
 		}
 	}
 

base-commit: 88c72bab77aaf389beccf762e112828253ca0564
prerequisite-patch-id: f44102a7b095afa1588a5cac012ec2e0d852c021
-- 
2.47.3

