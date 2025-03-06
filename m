Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887D4253B7B;
	Thu,  6 Mar 2025 16:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741279558; cv=fail; b=QPJbBt7nQk+eWeZxE2gnxkWSmVIccTjQa3nXHFQM2lEjSQaP/txOTyfwf1aiyXmlwwVY8DerhJPCZAnsH1a6vY47UG1bSnGDYyMoPMKHJkDMso2chbsBIIhuvw9yNdftJJ7BlRBrEL8Y0aHuiHBMsKyaTtHvEG1j7JJ8wYp39Jg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741279558; c=relaxed/simple;
	bh=G4dCmHq5d4eZ9+BG5eocxrd8nrYAa4NiBSdVlLGr5+w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ifADuDb7egJ2nYTy9xXR6hf0NENREqmFnBx4eKTH7zL8tq9UokKcuxDmSIONqu8p1IUIHY8QxiESJoGqcsQ9+ME05haecS/nkN6kMEucCVVyUJD9J3UGiTGzLgQHsaUkaC9YQQq6gLbSwwl39fRqhpZlhd/dgZpd3S8HLpXnIUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2gi+YIGj; arc=fail smtp.client-ip=40.107.223.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2gi+YIGj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f+s69Do7jCTk9Y5Y0ez0ouJ/YUAavgNyAOer22osetxb+jEbM8izOH3cBtkqIkPdnMKrAes8cFeAsacHwza50rkLzkwH0wUzayeyrWM7YRVyYvgV3ts3vexBfQ3UX7kZ9JuM8SKbhcyMX6f1lJUKrlmoYjMoyKhsDzUE7hu4Rbxz3mnJ7PuHihxMRKTZ10LC0RSzfPceyvqmPDSnx7DMhNQZU6uM7t7BD/L7wFWd+HFd0JD9J2P1xfbQJxpeoM9keXElFsH1Y7fWPMdiE1ITetKw4pPYFncezkJRZ3sWtSbIZxdNRPSZ2VDQGwqor5vqFiIi4cKNmvAa8xzwKvqBpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nRGd+Wxz9Lz8w38N7733t4jyvyv5FC/mu7LPJCRN0sg=;
 b=Q68Doy8l/XOjiWCRO4P/L/C5EyB2XH/O4pPli8tdq9fT21/J1Let0oyHB9U4MwgI7SE6UGiIVsHcvZvzwyYDwHNNvIVaXcLr1fJJZF7fcKj0b1SJqnkAPqVdMGjAhxsHVtR+3fhZcF1RZ4xfDBheE04PVfFTKnqob85MlGJz8yhZmMEf6F+/XClry7sAsZDDuN+6JN7SGZICtIybRldr2y846+3b9YxWlFuOBOjIGyU9LaCOlbdssGbMC0XD/JMemZarhDMDAP0fAprTsK0e+GqukqXgCwhJcp0iTNUcaP4fDraY8ABGdsZw0SeSoondluNflcaqhpPtVzhGGQaUaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nRGd+Wxz9Lz8w38N7733t4jyvyv5FC/mu7LPJCRN0sg=;
 b=2gi+YIGjvyr6f7EF3P/XSO7LBoFa32l5pPs97rvgXVd1Jw9tEsJUB2IIiQ96QnkhXjSO0KCD1Jj5ITu+BP6FRA8O8xVMpGwVLp91U5lK6kt4F+TP+vVGABkH5libxiFHaz4TDL0DmcWEvW9Kie4NC1IBgsryq27xXjcfgmXdI+k=
Received: from MW4PR03CA0340.namprd03.prod.outlook.com (2603:10b6:303:dc::15)
 by IA1PR12MB7613.namprd12.prod.outlook.com (2603:10b6:208:42a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Thu, 6 Mar
 2025 16:45:51 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:303:dc:cafe::a0) by MW4PR03CA0340.outlook.office365.com
 (2603:10b6:303:dc::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.19 via Frontend Transport; Thu,
 6 Mar 2025 16:45:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Thu, 6 Mar 2025 16:45:50 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Mar
 2025 10:45:46 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v4 11/14] cxl/region: Add a dev_warn() on registration failure
Date: Thu, 6 Mar 2025 17:44:45 +0100
Message-ID: <20250306164448.3354845-12-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250306164448.3354845-1-rrichter@amd.com>
References: <20250306164448.3354845-1-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|IA1PR12MB7613:EE_
X-MS-Office365-Filtering-Correlation-Id: bddebbef-23f0-43a7-67cc-08dd5cce5a51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DN7Gn3OhsYuh6ZokwyH1xArB5o2F7dWpm+owTCPUl8z0DcZuwjR/6E4cq5eS?=
 =?us-ascii?Q?MK2VZ7P2CLiwoWxBXMUkKYDDs3DgYZ5pSEp2PkWceLnvTmo9/ID73337/6jo?=
 =?us-ascii?Q?t3tFSmUJXi374VwJLQf1fE2TacNk2etTKy8XFHKFu2VLOPPL3IIxz8rQch3+?=
 =?us-ascii?Q?L6L9K8N6RiNG9NxmPHt7unpyNMKJPuofTTwxBA2Td3oqBr9ACSIvhuo0gYsh?=
 =?us-ascii?Q?c6hG57MEGd6geDJmzip38YRKZfEovB8FEDf1t55U/NZCcKtHEGhQEsNrs/Iw?=
 =?us-ascii?Q?oc/rMjPjjG9dJ3oFKP7IEs9Onmf8J0vURWe9kPJHSeFM/nxao/5uWWw7tqZq?=
 =?us-ascii?Q?Rd6rrm9543cOL9zrIqMYPrQg/+FapssHcg9BBcTJnEd4ld6XXrIA8RX67/ln?=
 =?us-ascii?Q?1p/KJzRD4OLRjRQ/LuzC6g01xicj4NdrEVPxjpE+TFJEHSli7WBePfUBXVml?=
 =?us-ascii?Q?K9q3Rl0y2YUP0yZcAl99GdtMpMEgPZlkLK/7T+vt8KWDjD16KZeeuvuE1swm?=
 =?us-ascii?Q?uJm00tpDEFjMLjYPcM6jFrAMB5LfqR0VVsUl+PU0dDmHX8aK8gt+zEKE2Wp2?=
 =?us-ascii?Q?jCbb2QSAjY1IhtijPDJWg8lnjNbXGfWBSIllcy273WjwUmPThedFn+fljkhw?=
 =?us-ascii?Q?ct6Li+f8N8Is1vBLg18n5DOTXCiOn3imRBlepVwJuUvywZhTjf4xmz5C2JZZ?=
 =?us-ascii?Q?h3O8t/6j5ADz/wjPw4sOt8TKt91XlMBkOcuY2tkNklSOy8zk1GpR9EGYerm/?=
 =?us-ascii?Q?W70QINqT29yqa4W1Lb2Qw82l+/9U6/IglkiqdiHALMGzRRYqhB/5iKtoK8yT?=
 =?us-ascii?Q?puVfMFXpVy5R6pEEyTbjbjQ59hyxBKQFppb9lsAliaW7A8swxfbCvK7hWjJI?=
 =?us-ascii?Q?BOVlgUh/w8JvJK6Jj4dc51MD1bVfk07fOk0foaaBk+f2OaXJHrdvnDkUGqgy?=
 =?us-ascii?Q?oJEbvFBpENZayUc3sK4z0aMuh3I6umxaZh7HusnkjaovswAzlWFbSWjCv6gx?=
 =?us-ascii?Q?FWMZ748X+ZsSJRvnezTGFhzVSZG7bYpaGm80xG2NKTMTom+oX2Ajs7Oqg27q?=
 =?us-ascii?Q?nqh58ifcOOHlUN62p6WsOayu878rt0dUUkRu3HMSV0NwwEsx9u0z8wxfU3/j?=
 =?us-ascii?Q?TYqOE6xSIZZco9SpQDWu+L/PZHOfDkglRmIe99Ak7T+JhfoCHuZHSHOoxAIW?=
 =?us-ascii?Q?+qWBReGaTatsVSfbytiXq95j6vbq84vXZfjGtx5n6/2apkbNtTdYiWF+6KIT?=
 =?us-ascii?Q?1/t0ybua1UsjDLN2lxr1NWW09VhtWDW+VkvlxGVwvkzE2tHX0r+gRBAXJEMs?=
 =?us-ascii?Q?XTGah8vbBDQJsO/iq5sB2zmsNSrMKAxZEsh9oFzGdDPaxC2YDluzR26mSIzZ?=
 =?us-ascii?Q?1A0QmShp+NICeyf1g7lrU8H7fP8gD2at3NCqvdmzjraXVjJ7PgL1+1wOfAWa?=
 =?us-ascii?Q?uX/FvMD4mlIXit2ROARtnLTw6S0z+iY4ENGqopVMPIWECYSCyn5+groZ/ZWY?=
 =?us-ascii?Q?Oxci8M8TuPs/tlw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 16:45:50.3062
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bddebbef-23f0-43a7-67cc-08dd5cce5a51
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7613

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
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Tested-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/region.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index cf58ee284696..bd1ce9d8bed7 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2162,6 +2162,12 @@ static int attach_target(struct cxl_region *cxlr,
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

