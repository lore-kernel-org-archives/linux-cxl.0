Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012004.outbound.protection.outlook.com [40.107.200.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1B02F746D;
	Wed,  7 Jan 2026 10:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767780265; cv=fail; b=o7qlfzKGMYahvLkUd40S73qF4357bUoLAJyr69QjNQTqsCAN5HBRgSBseXP7h1kJsOIF9UJGFKhAOpE051NJARhwy4YVxA3vwc5Sk7v/PyK3iSsFgjbK2NKiPS3uhGuHOoR7XVYK8A4k/QDrKXyIugB/gn+ltNQ033aRs6Bh6cA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767780265; c=relaxed/simple;
	bh=T2dRqtn9G3BnbQOxAljFN7CN3NGFl9/zMRhVu6OuFQg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gtCI9THomQqwIGjoRUP1P7MBKQ/FSeYRh0GC7aK2VkzE7zewh67ZV0RAE5eV9uMKVeDG3M7vY8++ra2rBVi7FTLfJykM++luA8FA7N3SC2FJkyi7fAw3/q47hnoHl+r8E43YG24102wfVK/Txy4z0sJdfVQ6a/oVHTryXaIzsfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LAnk3SZN; arc=fail smtp.client-ip=40.107.200.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LAnk3SZN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iQumg2qKd13K6tMWAbv4OtX4Ad10uphG8dTvxVxz6eZMPqUnr/27UthDuIHvERB1LuZq71n88h4B2zZU/+wEBSgqgumFMbQZG7H97m24fgNPmA/6fxtmBAutgckfD13rzH4DrwmbQz/OrSiY6bSrEsYzxWiBHk/1k+Z5/vGsp6Jb1B/QllEmIE3q9jyB7SadiCauM8JfFAB7YMnKvPB44KCfG8+PIJXpQQ03E54Spg8HZ77ok+94V2bGMtEMoqfzSBkbxZ4feelFOVql8+OLy74eMvPRtBL63R0G5Xsvz3iAOvZmRGnoNE+uszv9XKlrgKJwkjYjeX88xijV6AsxsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lT8qfu5LGtHbRmIbfztApLpBppYUSNhfXhLgXqGNE/k=;
 b=Dj8+SFRiPxK2dVZSdw+NR5fOzA6HV8xnifNh3GtNwKO9ACvn6ABlL513CgStKOqV+3orhLXMiLf7QkCde/AHgkO8XyL70z7cDJ6bzSKQRmOLLLTbUGzlDraYIkdw1AY0fo3PS9Xpx2nRt0sMCVjlbKqccibQRK3N/yJ258Vv/7Wn/19IJs4qLscj99l5r2OU0388aJQBlrszICttvL1U1JrLb6CbHnu8U9X4MMg63dwm/jzqza50QSAfu4sDbeP1vtPk9m/ocKGaQB0Dt4aUsXBzR/3J981NQjS4Y36BwgBK/MNHhCNfvheVFh3T9A8+5QEwJRXWhkKbPiQ6E71G1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lT8qfu5LGtHbRmIbfztApLpBppYUSNhfXhLgXqGNE/k=;
 b=LAnk3SZNa1BvZ01QxVgN+/jnJQdYYDvRDxlmxRGekeJ9UCp9qX8gKIITfbufBPlDO1EE98DRRi6poWC303TA3DPhYfHBvHcNOcHp7UNjKUUDuR7BWme33LZPMQRvC5Amw2Osc0kJAhIb4YpE7GNIs/Lua5YuP9PhcXZxp/70+So=
Received: from BY5PR17CA0043.namprd17.prod.outlook.com (2603:10b6:a03:167::20)
 by PH8PR12MB7232.namprd12.prod.outlook.com (2603:10b6:510:224::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 10:04:18 +0000
Received: from SJ1PEPF000023D2.namprd02.prod.outlook.com
 (2603:10b6:a03:167:cafe::be) by BY5PR17CA0043.outlook.office365.com
 (2603:10b6:a03:167::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Wed, 7
 Jan 2026 10:04:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D2.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Wed, 7 Jan 2026 10:04:17 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 7 Jan
 2026 04:04:15 -0600
From: Robert Richter <rrichter@amd.com>
To: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: Robert Richter <rrichter@amd.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v1] cxl/port: Fix target list setup for multiple decoders sharing the same dport
Date: Wed, 7 Jan 2026 11:03:55 +0100
Message-ID: <20260107100356.389490-1-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D2:EE_|PH8PR12MB7232:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b5546f4-1223-49ea-976f-08de4dd41ee5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tv4o/qN3kh5MDrdrTPlgfRp//b6rmICQDWm/Zvc0RxBseA0qgrZju3W2sCEh?=
 =?us-ascii?Q?IQMfHu84gMcGYnE9ibLMkib8oyWepDi5Rrmkn330aCRjHt7fj59yeYEAXtk0?=
 =?us-ascii?Q?XfZ+AVMN+aJ3FxaPRq3swKksSdGdP9dq8YeH5lJQFy8Btug4XZeOXJit0j7v?=
 =?us-ascii?Q?6/PJMsHsRU0IEbRLOJNFtumY0fLgpgpgQsJqn/A62/Dn4IYA1XRQJE0ibZjW?=
 =?us-ascii?Q?a0JiafifbXm8xOGgmsUbAqGMWlP7e6Xijc1QO9XjZZY2QPIJiXthK86voAFT?=
 =?us-ascii?Q?g6CBDdU/U+oQd7SVityTucb+hrAfXsAPencZ/Z/TIv1g6JnnGCoSg8PHBo2F?=
 =?us-ascii?Q?B05AdJDrGTLb2ZmHfYx/gzGYX5JMk4vnXU2v9m2Kn7oXqJzRdu7OcxTspK88?=
 =?us-ascii?Q?C6mW/vDimrofCFJ0npfn38l7KqgNqFGtbDaPLbxLQqWwquz6AHG3ryWKuVEB?=
 =?us-ascii?Q?4yecgESaCJdQGm/P3Ej7Vlq5Zbd3RDbOrZ0C5n9zNOzOCoV8kFpQS7/wMUpn?=
 =?us-ascii?Q?08RE4IrVzBC9QPMKLpTTo4V3ZxgpWsLoMdDm3jOFIGw7AHj7p7wOPnSOcVuC?=
 =?us-ascii?Q?4ITNyRx6kDf8/U4xEXltGAEwFqg+3Xrbm0ku3lR/YIuLFD1eJ9U04xuuJ0c/?=
 =?us-ascii?Q?S6soL44XUjmLZfLSb1svtHAZRMSmrDMbiTMNNo1jF4L5DUKL/tgj+LPPX7nB?=
 =?us-ascii?Q?Pozooou1N0rJnSpi4L2FudpedO0Uet8YwAECEf9f7na2cRTBBbafXVP2QXcX?=
 =?us-ascii?Q?dQND/aK+p9QCgPjNZgzBVqBG/PhhOXNARtfPhhnQQUF35u7dCEwGGjKC5xsk?=
 =?us-ascii?Q?wFfdsST4hmtS7FRTj9kItKEvU+Q2zlMJTxFlS54Y+gqbdyJNi2aHqpuoyeA2?=
 =?us-ascii?Q?ZNbK73QuHSeqP7A4X8SlvZWHecjfYDMEpwEzd/o6pTw6jQK3fcYEd9O0C1gb?=
 =?us-ascii?Q?x/ODDsB5VuOAop5WFu/ncSnmUpe5FvJlRcdVL4XP8WupQB0zQnIMfHOgTKZD?=
 =?us-ascii?Q?KP26oja8XrlTvnBkp1KhyNdLgcQ3u4wzfhnIAjBo/CqYm93tqEffhyERUmwP?=
 =?us-ascii?Q?22U3fnvYggD/z1fBuhhu8H6e2eBHTQWSaZCw9anQt1PUrxfRsKr1Pfj0Hj3U?=
 =?us-ascii?Q?ssZ3d3rMoLKT4jlbEO4fwg4G8yU63chVHyPX2CGYcrA1/y760aqyncSSXkjN?=
 =?us-ascii?Q?6AyKaMjxWb7zXEqiyAx0qbdSldQBGMw+eCgiHDFiBur5Z65LCLB1Ek98BGza?=
 =?us-ascii?Q?FkI24bipjZ5DqE585hr7PIIDWcCsLkrpN+xuGmdEEoSZrexTjSHlt3uQElQr?=
 =?us-ascii?Q?VTl15ufHgJsVq/j/8Yd9W4szjQbsgB7Mt++LMrX7AWRxVRan89chOkkhn10G?=
 =?us-ascii?Q?ciw3AtamNW4tS05Mi25paBRm15NKVYDLywreixO6dLZ8s5oIux+QOTkoBM6F?=
 =?us-ascii?Q?dchVdrHvBEgdv4+1gQon4roC5Hw0kTgHkAoDUxWhsVsurvquMWHvuqIGAE1P?=
 =?us-ascii?Q?PEm9Z3ghj0NJSFqW8jBpmJbwqi1yT8/Ip59VMqdv8F66UY5uZI3udJsFpsR6?=
 =?us-ascii?Q?RnFrCnyUgKgOXVwnpwg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 10:04:17.8590
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b5546f4-1223-49ea-976f-08de4dd41ee5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7232

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

Signed-off-by: Robert Richter <rrichter@amd.com>
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
prerequisite-patch-id: a92b04b164c158c7f0f0dcde957bf5c02ffb3918
-- 
2.47.3

