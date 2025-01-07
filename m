Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982FA1F9EB8;
	Tue,  7 Jan 2025 14:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736259135; cv=fail; b=NoCbFYvh1z3JBw1AgnoQNvt0Jr4EN9ziMDWcaFZL/alcVoZ3pRDRuMn8Jl/29NwrZF5d6iGkvGOVu6qwO4SIYo71d9zvu8PWUmfDjSyUpIru66+5DiakrZ91faC5yrwSoPHRP9E9YHo/Xw3z1JqERFa+SUvf/0mVdeNedsh674Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736259135; c=relaxed/simple;
	bh=bTpgXzmT9yVfdG4iQvpZmwkXawaYRpbgatOrq/VPMgc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jhcEWUNz1caVBthyJh3mZGb17c9VyFmp0hruyN59q6Uv2782dy7UBLZmnvfO9Kg+2G35Fl35h1vxEZyk2mtefInv5+/5VMDkHG08N4oOQrRQcBLK6OjpmfPHxOVpJA+rnfV2FH99s7GLjP0zYmTKDSjaE8jlWlBzaWyCiIXt9uc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4/EAiAut; arc=fail smtp.client-ip=40.107.237.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4/EAiAut"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qXEtElBEYh7NmAdTbBLNQIi5mG31HHR7t1rRVS4F/2HS6jZXT9MhZMLgt1SzwT15GAU98fki90qPFNfIEGgNoU8LUWZUrOEbU5P748R3ABHwR8Zb1W6NLeCqcyDPHjvWvnPEz1h7eBNbNhpjqf/y9m5Kk0L6xHJEk3pz1paHke56Ven25q14PDQEMEsMmH3CgeXhKlqhTopJ8uGrrK/QSkOPSEHA/oj/sK+McmNyToNfINgmy2PjoT6pdZsWahOFRynC9HWg9popzEg4NbdcFFIpuq4/1FidFBkq17tAzxqdfoYbLLzEvWjwvQ+R31TmRQX2zqEbN19KXcjkWEB8Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ACrIQnX5bQSRPUb3ElQrwGpZqWWsoNyglDHCPBup5w=;
 b=pldzKkyK6RbtiF0Zyn8Ox1/iZZJRa8SiQdY/+UCEDtDESvTr1EwePuX/AkM40L3EAhegkT7JgCVWAsPc6/3xjDkfn1LDyuOr7tabo4eld9sW6mmYWIHNJ/uOqL72KqsEfj8cDDRHaPlJP3TODEXOY7/Obz47iCdKf/Ff7kqafRQxay+RRNQTW7aoVNivgrX3NOEVJ6/uPCWggegTAZQDpKwOsdVCeHFTaGxDw7CwH+ecXoG+KlwsZi9SOozGGwhN6IBBgzsuRFXM/fAWYKBzfxZNgxn2qmDL6zuBb5OhFfiwl2n7uVmnQICrNRkdinYyI6185SYZOrFgYhG77q6WBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ACrIQnX5bQSRPUb3ElQrwGpZqWWsoNyglDHCPBup5w=;
 b=4/EAiAutI5V3yaTrbwUAVL32o43y0OfMy5i8KErUYZHcbY0X5hn188I69qlpfKcfBqjf9wfcqxSmb30FJiGwKtuePwhg96cTleuwPyIQOcYTB2bu4Ywa41beDkan92EGhcyNUyORdgmEdQMScnnkmsWV9PhDAWYnhL+Tvle6oqg=
Received: from BY1P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::9)
 by DS0PR12MB7925.namprd12.prod.outlook.com (2603:10b6:8:14b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Tue, 7 Jan
 2025 14:12:05 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::21) by BY1P220CA0024.outlook.office365.com
 (2603:10b6:a03:5c3::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.10 via Frontend Transport; Tue,
 7 Jan 2025 14:12:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 14:12:04 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 08:12:01 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v1 23/29] cxl/region: Use root decoders interleaving parameters to create a region
Date: Tue, 7 Jan 2025 15:10:09 +0100
Message-ID: <20250107141015.3367194-24-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250107141015.3367194-1-rrichter@amd.com>
References: <20250107141015.3367194-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|DS0PR12MB7925:EE_
X-MS-Office365-Filtering-Correlation-Id: d4e35746-6bc3-407e-2e82-08dd2f25439b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Acl0Cjzn03X21PM2940Pv0obkAp/lo2XAL9lUEfkjuP9IOGyQLOPiDj1q2rJ?=
 =?us-ascii?Q?VnfIsBI0hO1dk1x60zkDeK09noqz1mkkoNvFAsS7CI+rt7fjiKT8yP4CPOSq?=
 =?us-ascii?Q?aEz1ApJtwBizUBxaTFex/zsSsqxAUlJqYTD9MZRJumEiW8CwsupjcH54xxPx?=
 =?us-ascii?Q?5AMLjG+Rp4ynHO75H/u7WThcxnqT1eOgFex5kl5RHnsdhU0E53jdtjGwIMR/?=
 =?us-ascii?Q?5jIM0BV821fVcTxAtpmTnFlN+JFs+slDxKqaIPtCAnBjXbpT6pJvAsY7iDxr?=
 =?us-ascii?Q?xKX7MiJqA4OReEuuI8Txiw4YGKOxNo0MYJL1mCslan14lQeQ27h10WO1cGn/?=
 =?us-ascii?Q?Vu7j3DeMSsdnD9xfbFXu5FTrvsSo3+IZAIzyx3T5tzBMNTsG+hjfWwmLJvov?=
 =?us-ascii?Q?tuZwnTzt9FRrWXCs8/O5CG20TuEqdFLSo0aqxgGKSL7SCCpdt56FgmIYV5LF?=
 =?us-ascii?Q?OEPMjb6ZlMAjdcbCOUw/z75gj0Z2fGLgMKCkyrq7SJjVh3pb1d7vqSbwLS0p?=
 =?us-ascii?Q?7AiYQ852GN+PYM2dSJ24ir4llbh4FmEDpgru7fONy5POJLO6eVByMLSImxVH?=
 =?us-ascii?Q?MuvUgaklqeiOL75FE0ITtUlg1mTpt8/8Usho5pRJg9VNQcl52UFpURGwTO+Z?=
 =?us-ascii?Q?Jv66G9fX50NhOBi820gLElaSEakCpuuRYnqeIsPhicWaR6vMlAKT3opdPHR4?=
 =?us-ascii?Q?ytA6P/EbeK5GKI83bcgF5VmX1hixD23gmYt1wwQ4xhp9zT4/L/vHeXa1B9ik?=
 =?us-ascii?Q?D81CLhH87Z7Nubi9juU8nFR451iygFSQMQqg+sM7KTP2tl5N99HYxEpvBnOc?=
 =?us-ascii?Q?zlaZgS555wMD4GjBdpIJPCTgnQQvX7OxJD2njpZlYIK6RoJjB7OQb1STmhB9?=
 =?us-ascii?Q?+Ybeb+Mthpz6QkpOkdfoWch8dfY6H3ZCELL8/qQZ0aNiecTxoKDrsV6dn3m2?=
 =?us-ascii?Q?mJP6S4Nx0LC5dFbldHEyM4mauyKQlPQ3D8LwGJZ2s4F5Kb7Cb9eVKEr3GhLd?=
 =?us-ascii?Q?7mtXEF6FS+SnOhm9unVT9CQ28pxVX8amPP63+ZSAmWvNBDHpCHa4oSvh5Vku?=
 =?us-ascii?Q?t8t9rF79C/6g5zrUWinYpgXIlANXSysry79ABjpwpWSvi4UxkTWiJte0NPeE?=
 =?us-ascii?Q?Ot15WG6sENe9Up7Pdtt30igvxgzAXGnAD+wd8fX7NxZyP31Bibxbe1ycqSQl?=
 =?us-ascii?Q?t31xh7LS+3rO6WSflWusAbTToyElYZuFoD/W1McMFSlPQH5HptnOnyGzn9vs?=
 =?us-ascii?Q?ScyjG7xW2CACM8gtq+LmwHCTQ4kn0KYJROD6DQRfgbTY/JsdVb6iHwpUh9cE?=
 =?us-ascii?Q?lD7guv/i1BXp5taSWTzS8MAuvKnfuv/Sib8pfgVVNQbSUp56WWhoKPsYfUSC?=
 =?us-ascii?Q?Bi/Zq3K5KHbDakojix6uAPW+YPVHCSHUCcYIvaUZgoC4QKyDaw1P+uQuKzz3?=
 =?us-ascii?Q?7y3/DUFGDEvZBcqq7teiFZmB0JEn8jhSxq+7hxh2Oqe7zdA4rOC1rkB04cOp?=
 =?us-ascii?Q?UA5gqNU5Ww2CDx4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 14:12:04.9454
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4e35746-6bc3-407e-2e82-08dd2f25439b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7925

Endpoints requiring address translation might not be aware of the
system's interleaving configuration. Instead, interleaving can be
configured on an upper memory domain (from an endpoint view) and thus
is not visible to the endpoint. For region creation this might cause
an invalid interleaving config that does not match the CFMWS entries.

Use the interleaving configuration of the root decoders to create a
region which bases on CFMWS entries. This always matches the system's
interleaving configuration and is independent of the underlying memory
topology.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index e218f0be2409..c3322bae05b9 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3477,8 +3477,8 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 	}
 
 	p->res = res;
-	p->interleave_ways = cxled->cxld.interleave_ways;
-	p->interleave_granularity = cxled->cxld.interleave_granularity;
+	p->interleave_ways = cxlrd->cxlsd.cxld.interleave_ways;
+	p->interleave_granularity = cxlrd->cxlsd.cxld.interleave_granularity;
 	p->state = CXL_CONFIG_INTERLEAVE_ACTIVE;
 
 	rc = sysfs_update_group(&cxlr->dev.kobj, get_cxl_region_target_group());
-- 
2.39.5

