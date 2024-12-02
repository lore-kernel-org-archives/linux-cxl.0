Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26481FCFE7;
	Mon,  2 Dec 2024 11:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733138430; cv=fail; b=nNI2jbok/jXLmvow7swSTAadjWpLMO593R9IQlXMXOGa7FD/wsdl1AUHm9VWJa0tR4sk2whUNpolAcoAdns7HbkaiSz39YO8b2poJngIcPvOJfMZkf2Ra0E3fYPoA/rXuA0fRFG1N2XAe7a72hAkI/ypg6E2p1xhRgze/IzrDFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733138430; c=relaxed/simple;
	bh=E6EBfQdrK1XZ0xdOhp/6lsFSuH8DwEoIZin/WkOLGKs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Za93mzGh5EbeAxM7Oaj/t2dpFc70AdIK/IEROjx77kVYjbuY42n9BcbQPoM2OC59EJTXO3qVGxXUKSD9Sro/W3UKnTRhzS6gfzdvzm3SR8XVACvQSLLUlyw5fumplFEgGybufMsHp9IYyeGXvKrR54WkNbWT26lF8dgT7q3Unqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=O5fmgkSi; arc=fail smtp.client-ip=40.107.244.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="O5fmgkSi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sIKyarUQsUOvEc9s1pJ0+KSaoNleYfJXckoLD7Za7DK3SuHHBD2elmJSboSSaIQsmoaNM3bQxv6Wzrm5rjqrm4FbeMX7xAWceQjZgGerho/vtIdaqnUh/A+/G1anO1A43A8TpJlqDm9N9T9VqqEpLMPrrhNvBUXuJP+30Eju0BOZhf3ZW0yen8IdpEg3NA2zhNcITd018+Y20UGKLbor49lq+HF6+OdWvIVjjvF1k4NKFAG31+rzk1cGV8BsnvT+dQCh5Stiwg+NOnicxUJi/hrEYy+FFnY/TN6pUyumvF5rfycMPoPL+TWLsn3NaWieA5nRxOHbIC9sKnazCc4f7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8sojNcxyvxsk3EFC9RaVbNXsT3rDL+nmY8hG0PQC9gw=;
 b=B6XoFmgSUqlh31GfO8QhrgoiND5pzmRFt94IOSy9qNLsp/kQR1A9CXL7hyanBLHuRYHhEcnVOOg1/UjJ6SONHPQOmf/3BT26HN1tPMs6n8rcepmdvHNKi3RJpl61joT2CJhAJgS75Imr+dWGJEHdJhqL01LOBVDMG9W4uzr4PGtrNqxduQ6U3cLlkImqsFmoEknF1yj0iR9fMcqp/m3wlgqwgtNyZ9f4cQVopJ9RZxyW2saafBmVFaLEgjNF4+P0v+g9lDdNFzoGLjG2d8UbpGk+mWoWC5nlZa28B+pAaIAxmIUZsOiAcuJLJXmYRqVkjpkNCcpABPHUSmeys3UA1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8sojNcxyvxsk3EFC9RaVbNXsT3rDL+nmY8hG0PQC9gw=;
 b=O5fmgkSivZLkDhQKl74/FnICfgSFEwzpHdmECS0JBMSv0kBSa7nsRipYuLZBAhYr3t8WacHEHz1Xy7SD1uN2I0MAWLRO/AeETu9tztsAZITeZ02I3wwtwofqb7knbF4vkDSrOMWudMT9Zwfi48MnFZ+mDnmotcH49yAo+fVWwvE=
Received: from MW4PR04CA0228.namprd04.prod.outlook.com (2603:10b6:303:87::23)
 by DM4PR12MB6400.namprd12.prod.outlook.com (2603:10b6:8:b9::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.19; Mon, 2 Dec 2024 11:20:21 +0000
Received: from CO1PEPF000044EE.namprd05.prod.outlook.com
 (2603:10b6:303:87:cafe::b3) by MW4PR04CA0228.outlook.office365.com
 (2603:10b6:303:87::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.16 via Frontend Transport; Mon,
 2 Dec 2024 11:20:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044EE.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 11:20:20 +0000
Received: from tunga.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Dec
 2024 05:20:13 -0600
From: Raghavendra K T <raghavendra.kt@amd.com>
To: <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
CC: <bharata@amd.com>, Raghavendra K T <raghavendra.kt@amd.com>, Huang Ying
	<ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, "Dan
 Williams" <dan.j.williams@intel.com>, David Hildenbrand <david@redhat.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Alistair Popple
	<apopple@nvidia.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Baoquan He <bhe@redhat.com>,
	<ilpo.jarvinen@linux.intel.com>, Mika Westerberg
	<mika.westerberg@linux.intel.com>, Fontenot Nathan <Nathan.Fontenot@amd.com>,
	Wei Huang <wei.huang2@amd.com>
Subject: [RFC PATCH] resource: Fix CXL node not populated issue
Date: Mon, 2 Dec 2024 11:19:41 +0000
Message-ID: <20241202111941.2636613-1-raghavendra.kt@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EE:EE_|DM4PR12MB6400:EE_
X-MS-Office365-Filtering-Correlation-Id: ecd98a2f-b34d-483c-132c-08dd12c34f0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZbJqA8zFLvGT/lkee+Tkn3Sx5uD/f9zz37SdybkJREvTvReaFBLK5aJQAj+b?=
 =?us-ascii?Q?zk0L4lLUi4KkJQ6GyJIu9zh1p+CSusm8Tz/xVK1TxfCTCrz+3Fxjcb5DBNR7?=
 =?us-ascii?Q?9UVqLeOfIijby1E5o5Vo2AwDxmyoiQnD6zc1l4MtlhqY/QBn5Rb9TzmaT8Kc?=
 =?us-ascii?Q?dfcZ5kEA9ERK6n9cgFeq6f2JWQFx83d/zFsasZuA45x0Nzhe/F6gis0RMGfG?=
 =?us-ascii?Q?T9EAtvid9oX/OYxDKush8WEENOap8U2fndhyOe2sqQcSzJBVBjlSZN5FxIS9?=
 =?us-ascii?Q?VV+29rDNTFs8yNnMyk/uDc8e27nEFtfjtTZS6yirdgmcr04BLbyWCJ0iOhgL?=
 =?us-ascii?Q?+EM65fFg34V8geYlgNU2F9+NdVh43Z+52ICx5rLlIkW4fhaHGrDZxibZeCZJ?=
 =?us-ascii?Q?f2YtSudpp2cDYzH+HKm9DuJeImVWX+GA56tvelwSSpi7gwrNvh2VQiKv/Fw7?=
 =?us-ascii?Q?UPXJ9OdUuVerOLcUuZ1KYIoJHR+9kyxey4cfoVNpGrney1NL+FiTyz/uLL7z?=
 =?us-ascii?Q?pbVTIni+NAdwUu494VUiUxJ7YlhcqwTDlsn3Tqv8BpHjzO3YrdAyg+YqgK0r?=
 =?us-ascii?Q?btiEqsr1dmJpz7JVxkAPIqGKZ8qReqk2trTCEOWe/NIQRWKY0ssSoXNhZBeT?=
 =?us-ascii?Q?2xqQdALWk1mCO3oPmt+wYrOUru5oyZK2sDbADymtjKAchSw9hBZs+WjGYoku?=
 =?us-ascii?Q?gxTeKiiImvK5lt/1zIVB3VP1uIG3rXr+aOyk+VTqpPKYl8+rccDrJWuRdDM0?=
 =?us-ascii?Q?kZNbjEYzt5IgXF0pJf20bBSm15iDnzEc8T78kBwPNgFOu8GSpUa1s16PTyCk?=
 =?us-ascii?Q?Ktp1Mp3V4UYm/Kfpvc2uLH0pWXB51qExbRObpZfTdVg7cujcuNr4WpY4s/Wb?=
 =?us-ascii?Q?XgQFv52EWPAmmijH8BdODOxWMa51IeKo8J35abvbZzaHAJZi/rax7RCDAmBu?=
 =?us-ascii?Q?a22PUJl+NglCat/e0iACD80F8kecgtfsIiYPVt0W+82H4hXz/btWEob+mHYS?=
 =?us-ascii?Q?tOQbB9tkLDr6U8vgsQMkK+z9ssvlcbbyFj2VL88W+oJZm4pGBUA1o57VyAi8?=
 =?us-ascii?Q?DYg8G31n25oGYw1EqJuUzfeHfR+EkWNzkp0R/hB1SoWP2jg6gk4gMFXLtLxi?=
 =?us-ascii?Q?QvVnFyL61xlbTqVM19d+BnmwKrtUgaMbXghOk9l/hDeHaZ3A3UvlXIwZ/2mK?=
 =?us-ascii?Q?sPC6DKMl1GvqMF39x/KeT9EBwM29c0FK/tJyOb2tdkTLW7JkzxG5ou0zJk21?=
 =?us-ascii?Q?awOwSXwLgrj8yZIhqt3nWA/x/bznS/cSJ5M7nBa9EoSExNWav2q+5tb9I2SQ?=
 =?us-ascii?Q?EbmpQn6rTkl+ISZnSeNupqBgK4XRpUYrNWdeHdV86KtqP8Qlx23nddH4h6Hv?=
 =?us-ascii?Q?fR1ww4BLBZT5u8CcXu1F7h9K/X6ivqS3NyP1togi+uFlg0kK8w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 11:20:20.8651
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecd98a2f-b34d-483c-132c-08dd12c34f0b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6400

Before:
~]$ numastat -m
...
                          Node 0          Node 1           Total
                 --------------- --------------- ---------------
MemTotal               128096.18       128838.48       256934.65

After:
$ numastat -m
.....
                          Node 0          Node 1          Node 2           Total
                 --------------- --------------- --------------- ---------------
MemTotal               128054.16       128880.51       129024.00       385958.67

Current patch reverts the effect of first commit where the issue is seen.

git bisect had led to below commit
Fixes: b4afe4183ec7 ("resource: fix region_intersects() vs add_memory_driver_managed()")
Cc: Huang Ying <ying.huang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: <ilpo.jarvinen@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Fontenot Nathan <Nathan.Fontenot@amd.com>
Cc: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
---
 kernel/resource.c | 51 ++++++++---------------------------------------
 1 file changed, 8 insertions(+), 43 deletions(-)

Note: Posting the fix that works for me. But looks like an exact fix
might be different. Since I am not much familiar with the below code,
I will have to go back and look into more details.

Please let me know if more detail is needed. sorry if I had missed something
obvious.

Git bisec log looked like this:

# good: [f7feea289f9ae3a8fb56e9daa3832949bf742c53] mm: numa_memblks: use memblock_{start,end}_of_DRAM() when sanitizing meminfo
git bisect good f7feea289f9ae3a8fb56e9daa3832949bf742c53
# bad: [9852d85ec9d492ebef56dc5f229416c925758edc] Linux 6.12-rc1
git bisect bad 9852d85ec9d492ebef56dc5f229416c925758edc
# good: [a65b3c3ed49a3b8068c002e98c90f8594927ff25] Merge tag 'hid-for-linus-2024091602' of git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid
git bisect good a65b3c3ed49a3b8068c002e98c90f8594927ff25
# bad: [486fd58af7ac1098b68370b1d4d9f94a2a1c7124] zram: don't free statically defined names
git bisect bad 486fd58af7ac1098b68370b1d4d9f94a2a1c7124
# bad: [7856a565416e0cf091f825b0e25c7a1b7abb650e] Merge tag 'mm-nonmm-stable-2024-09-21-07-52' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
git bisect bad 7856a565416e0cf091f825b0e25c7a1b7abb650e
# bad: [1868f9d0260e9afaf7c6436d14923ae12eaea465] Merge tag 'for-linux-6.12-ofs1' of git://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux
git bisect bad 1868f9d0260e9afaf7c6436d14923ae12eaea465
# good: [e55ef65510a401862b902dc979441ea10ae25c61] Merge tag 'amd-drm-next-6.12-2024-08-26' of https://gitlab.freedesktop.org/agd5f/linux into drm-next
git bisect good e55ef65510a401862b902dc979441ea10ae25c61
# good: [f1a4dceeb2bd4b4478e4f0c77dac55569d153fb3] drm/xe: Fix missing conversion to xe_display_pm_runtime_resume
git bisect good f1a4dceeb2bd4b4478e4f0c77dac55569d153fb3
# bad: [839c4f596f898edc424070dc8b517381572f8502] Merge tag 'mm-hotfixes-stable-2024-09-19-00-31' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
git bisect bad 839c4f596f898edc424070dc8b517381572f8502
# good: [726e2d0cf2bbc14e3bf38491cddda1a56fe18663] Merge tag 'dma-mapping-6.12-2024-09-19' of git://git.infradead.org/users/hch/dma-mapping
git bisect good 726e2d0cf2bbc14e3bf38491cddda1a56fe18663
# good: [992f9884626a0e6ab73a98ca4eb166d17675cae6] Merge patch series "NCR5380: Bug fixes and other improvements"
git bisect good 992f9884626a0e6ab73a98ca4eb166d17675cae6
# good: [adedd0f46c923f8d63aeb42d504c82431febed31] scsi: bnx2i: Remove unused declarations
git bisect good adedd0f46c923f8d63aeb42d504c82431febed31
# good: [a1d1eb2f57501b2e7e2076ce89b3f3a666ddbfdd] Merge tag 'scsi-misc' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi
git bisect good a1d1eb2f57501b2e7e2076ce89b3f3a666ddbfdd
# good: [fb497d6db7c19c797cbd694b52d1af87c4eebcc6] mm/damon/vaddr: protect vma traversal in __damon_va_thre_regions() with rcu read lock
git bisect good fb497d6db7c19c797cbd694b52d1af87c4eebcc6
# bad: [2a058ab3286d6475b2082b90c2d2182d2fea4b39] mm: change vmf_anon_prepare() to __vmf_anon_prepare()
git bisect bad 2a058ab3286d6475b2082b90c2d2182d2fea4b39
# bad: [b4afe4183ec77f230851ea139d91e5cf2644c68b] resource: fix region_intersects() vs add_memory_driver_managed()
git bisect bad b4afe4183ec77f230851ea139d91e5cf2644c68b
# good: [6040f650c56862a4ac40b00c37ef6ab1ddfcebb5] zsmalloc: use unique zsmalloc caches names
git bisect good 6040f650c56862a4ac40b00c37ef6ab1ddfcebb5
# first bad commit: [b4afe4183ec77f230851ea139d91e5cf2644c68b] resource: fix region_intersects() vs add_memory_driver_managed()
#
#
#  git bisect good
b4afe4183ec77f230851ea139d91e5cf2644c68b is the first bad commit
commit b4afe4183ec77f230851ea139d91e5cf2644c68b

diff --git a/kernel/resource.c b/kernel/resource.c
index c9fd26c06345..d4dcaa1831cd 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -556,55 +556,20 @@ static int __region_intersects(struct resource *parent, resource_size_t start,
 			       size_t size, unsigned long flags,
 			       unsigned long desc)
 {
+	struct resource res;
 	int type = 0; int other = 0;
-	struct resource *p, *dp;
-	struct resource res, o;
-	bool covered;
+	struct resource *p;
 
 	res.start = start;
 	res.end = start + size - 1;
 
 	for (p = parent->child; p ; p = p->sibling) {
-		if (!resource_intersection(p, &res, &o))
-			continue;
-		if (is_type_match(p, flags, desc)) {
-			type++;
-			continue;
-		}
-		/*
-		 * Continue to search in descendant resources as if the
-		 * matched descendant resources cover some ranges of 'p'.
-		 *
-		 * |------------- "CXL Window 0" ------------|
-		 * |-- "System RAM" --|
-		 *
-		 * will behave similar as the following fake resource
-		 * tree when searching "System RAM".
-		 *
-		 * |-- "System RAM" --||-- "CXL Window 0a" --|
-		 */
-		covered = false;
-		for_each_resource(p, dp, false) {
-			if (!resource_overlaps(dp, &res))
-				continue;
-			if (is_type_match(dp, flags, desc)) {
-				type++;
-				/*
-				 * Range from 'o.start' to 'dp->start'
-				 * isn't covered by matched resource.
-				 */
-				if (dp->start > o.start)
-					break;
-				if (dp->end >= o.end) {
-					covered = true;
-					break;
-				}
-				/* Remove covered range */
-				o.start = max(o.start, dp->end + 1);
-			}
-		}
-		if (!covered)
-			other++;
+		bool is_type = (((p->flags & flags) == flags) &&
+				((desc == IORES_DESC_NONE) ||
+				 (desc == p->desc)));
+
+		if (resource_overlaps(p, &res))
+			is_type ? type++ : other++;
 	}
 
 	if (type == 0)

base-commit: e70140ba0d2b1a30467d4af6bcfe761327b9ec95
-- 
2.39.3

