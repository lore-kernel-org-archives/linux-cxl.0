Received: from esa.hc4959-67.iphmx.com (esa.hc4959-67.iphmx.com [139.138.35.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8334F17548
	for <linux-cxl@vger.kernel.org>; Wed,  4 Dec 2024 02:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.138.35.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733278419; cv=fail; b=bVVrpJ1X/EuWCln1sLWfITv6Ws65ReoOvly74Em1wsB0dRv20uYzXE2uQYSYbz30ONlzvvELb+O4hdKqZqD6W55sZAtb4xh62tBZSbBXno4arklOJ9Blq9xMB1BfpcLLJnuR9f/XjSuafs/LNQAFEdjFgvj0cjFA8vc3uRnFv+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733278419; c=relaxed/simple;
	bh=+7s5YxCcPou4+jptJ5a/8KpnpHkVJl7MhtJ/XXpRI7U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BOFBwydu4oZHpkmXEtcPB8bO/WVW0IPdXRPMOLya+/p8L3OPLzrVEGDJEE78msu/QIz/Wa09T8DuVlMO7SDpdcS9qzhsu6u2L6TQkmmR4UFOJ8PTxcAsG31jZOZSje0gR9Q8CQVdX3gwQcwMs0TxydVxwJsxAKGlPGOwbSu1h0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seagate.com; spf=pass smtp.mailfrom=seagate.com; dkim=pass (1024-bit key) header.d=seagate.com header.i=@seagate.com header.b=PPcpdaL7; dkim=pass (1024-bit key) header.d=seagate.com header.i=@seagate.com header.b=fbXFOkJA; arc=fail smtp.client-ip=139.138.35.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seagate.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seagate.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seagate.com header.i=@seagate.com header.b="PPcpdaL7";
	dkim=pass (1024-bit key) header.d=seagate.com header.i=@seagate.com header.b="fbXFOkJA"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=seagate.com; i=@seagate.com; q=dns/txt; s=stxiport;
  t=1733278417; x=1764814417;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+7s5YxCcPou4+jptJ5a/8KpnpHkVJl7MhtJ/XXpRI7U=;
  b=PPcpdaL7kMZE9IWJVm2J8Szkk+bVBEbxBXSQ/+L1ZqmIY4kJOUChxiEA
   iy0Fx8LzuiMIwUAwv0xzOckJ6YwMOYwppKANKK6SLzByfsfJ+YsdrIMBc
   kKjj2ZJG5Qe5MaAXLmnIIRpPjC6mYNb46mlb3G6gsJv6v6DZDgcxVluYF
   Q=;
X-CSE-ConnectionGUID: jlhz0IzDQeqOln4BjpGxEg==
X-CSE-MsgGUID: jb0qykaXTfqCgrtOAt3xyw==
Received: from mail-dm6nam10lp2041.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.41])
  by ob1.hc4959-67.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 18:13:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mU3gFIuqfG9bY4ZTcVEYyRC1dGvqRYxiFs6/GQqaahVNphOGnLRZm+jbJJhzARruOYE68z9cQ8ChVldKltrmz5sJ/8u9FKEhkZmGU7ZQnwInjwUzHWjBMTswfqNxm+SSDjyOYweyR80UhIf2niziy/O1Z3Ohxa1hGiUnhOoLkShUzXnJbzNkHmpr2vNE1LnLSE/0f+/ZCbSNCFX4+dtB28Fk2eZrAwg+UGiGsxG9rzQLXZAU4skUF1ph37XNiRT6wStTbWP67VlWa2rcHPsAM66wIA/xhEqxrP32VvuGuv6ZRHAaPMRNlj/51AoHEFicXQo6YaIrhoVAtEqJ5XbGiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KfLP6VNH5k9Lq6gOZ7wCWaVDzYSts8l/dxvWw+CZ7sE=;
 b=IBaq4Sr13iXt01lRZBoRqHc3lluMp4rtGHxvTB/gG2KblCYVBXPID3YamQAGDUEzpoiv7k/5WYCOtv3zUtuUl6+hrfns1igj9cTj3Hor0dBJIZOzEkzB7V3OYcgTeplxcXwmg2jIY9o7h4IECRKAKFuiMh8HEv/XwlhrWLjvJzm4CAaIupDbg4MESW7xI0ll68yAek5K2msdRYg27S12caOUx8ONH7Izy15Q8Xp2rew+LBmAik/59VN8qoft58W+YsXTLhuhHT5wO9Ze3mH4dyTVSrrjkHL8z6siv5iZZ9vN1x2yJQDtYIBP1XeMP9mAZmzlg9OZxfo6fosaJxLFwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 134.204.222.52) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=seagate.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=seagate.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KfLP6VNH5k9Lq6gOZ7wCWaVDzYSts8l/dxvWw+CZ7sE=;
 b=fbXFOkJAjj5AJpuc5U0ip1CZizRbII01DaEtjXxg/LERXf0cM4+LZ96vZWTKcWjteDmpGgEYMKMPFuUD6GOaMOTS3ThJ5UQPWbRyYN75JxftWG6SGKHEjaxjmSJJCus1GjRWGFmkEt9HzswNF5G5RRTb9/cyfne32QvzJLVnH2M=
Received: from DM6PR02CA0157.namprd02.prod.outlook.com (2603:10b6:5:332::24)
 by SA1PR20MB7412.namprd20.prod.outlook.com (2603:10b6:806:3e2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.10; Wed, 4 Dec
 2024 02:13:27 +0000
Received: from DS2PEPF0000343E.namprd02.prod.outlook.com
 (2603:10b6:5:332:cafe::51) by DM6PR02CA0157.outlook.office365.com
 (2603:10b6:5:332::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.19 via Frontend Transport; Wed,
 4 Dec 2024 02:13:24 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 134.204.222.52) smtp.mailfrom=seagate.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=seagate.com;
Received: from lcopzesaa001.seagate.com (134.204.222.52) by
 DS2PEPF0000343E.mail.protection.outlook.com (10.167.18.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Wed, 4 Dec 2024 02:13:24 +0000
X-CSE-ConnectionGUID: y9ejUfEaSS26h6t5fKrF9Q==
X-CSE-MsgGUID: xCL0ur0lQAutLXCXD5UDfw==
Received: from lcopiesaa001.seagate.com ([10.230.120.52])
  by lcopzesaa001.seagate.com with ESMTP; 03 Dec 2024 18:17:01 -0800
X-CSE-ConnectionGUID: pxKNXXo9SIW51BBl0feTtQ==
X-CSE-MsgGUID: hVHhVBbPQoW39jRpKYsiZw==
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="112360643"
STX-Internal-Mailhost: TRUE
Received: from mag-tester2.shk.minn.seagate.com ([10.52.21.5])
  by lcopiesaa001.seagate.com with ESMTP; 03 Dec 2024 18:13:07 -0800
From: Hongjian Fan <hongjian.fan@seagate.com>
To: qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org,
	jonathan.cameron@huawei.com
Cc: fan.ni@samsung.com,
	Hongjian Fan <hongjian.fan@seagate.com>
Subject: [PATCH v2] hw/mem: support zero memory size CXL device
Date: Tue,  3 Dec 2024 20:26:19 -0600
Message-Id: <20241204022618.1572959-1-hongjian.fan@seagate.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241203172328.00001a00@huawei.com>
References: <20241203172328.00001a00@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343E:EE_|SA1PR20MB7412:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e38dbba8-9c60-4e22-37c3-08dd14093bab
STX-Hosted-IronPort-Oubound: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?scymlngWc46NBq6/vVcTylfQt8K/Z927SA5JuyzPrc6lvK8FkE3MPI9DYqC0?=
 =?us-ascii?Q?OAJAYAkia0cXxEMrphhhPSiA9HLsoQM7dYZc1cjetNzlBjRJR32c6Ud2j3Gi?=
 =?us-ascii?Q?fhyd1A573dISckoQV5yo6nj0Qbw2sMhVgPHU7kyWBTYlsvWzMCTqm8hfhM7X?=
 =?us-ascii?Q?ASVyXI2A0AO5sQ+pty7hGJU22+hAE2bNaiuXG5G4MEpqvC+BGjJ52+++dlm8?=
 =?us-ascii?Q?dRnjbzdmi8tDM1rGkvWszfyiqgL+Pwk9HYcU/GuWpPHZLZgheT45fNRcmY2+?=
 =?us-ascii?Q?ZChpY86NsDUcmfejWMhFcD/4q/TBeS3qflOoa5JX02Uwpe+r0d+NT14kNCWA?=
 =?us-ascii?Q?Ncc16vTzugYm7NfZc2lkgZR0wuOftg7V/Ipguiep7o0VyRMhhS0M4YxMUQtL?=
 =?us-ascii?Q?7b3oi+lH7pQim23YfqfHJgDwg9cP9CRBim5qFHHTSd+BmhSVUVVj036altbY?=
 =?us-ascii?Q?/ev3eHK1bQQ5tRrbJnooPp01CMnYkWPwnhWkCtYU3bmCx4LOy8kVa32s4SGV?=
 =?us-ascii?Q?ywuYE/3CXCXvEA0MakSeTmo3ddZgTtZOAVHY70yuNAevZ/AUJjQ3Pqz9oeoE?=
 =?us-ascii?Q?snMPV9nH8fjQTP/2+yobgkVggjgOBHDj8TrbqFgHuOxqmiGMz3zx0+2ufuzg?=
 =?us-ascii?Q?ADyKigrFeAvtt4WowoCHGvbKpFxmAAbwlbzrP+JJN+Z2f/dCdzpZGDRkgUQV?=
 =?us-ascii?Q?LI8Zz97AQ0HHGX1b6l6FpdFyOCTvFSilDzURoo3RYkXAYSa9fxr37Lx2/Ieb?=
 =?us-ascii?Q?aodPMldWowSK9lVNcK/6DG+4jCkq56LPxYP3MyDE3dLIv/cqWlZznWRQ6tM6?=
 =?us-ascii?Q?K4KBArQn4r0xDj7jlWVlkCZYIEKfQStSI0iQrASDTSO2MzqZMd+hc/LO2nat?=
 =?us-ascii?Q?EEpyian2gEmhfcCxR3Pd8DRCmewrpxtkqgSFVNERGXUYRBTPfwk3xH1b+1Sl?=
 =?us-ascii?Q?xu5eulq2C9QvnH2Gzv3vyZXVBvagnMBjtlI6gTHo1ejUEUPsiWMWZ5EiTZcc?=
 =?us-ascii?Q?qr+Cv7a3zRwxEeUFnNa32qLCfDbzSBdWCFJxdYmQ8+aJhNsnwByO6mtpP5jW?=
 =?us-ascii?Q?oXDQfsUf8vvBwIei6ViGpoUNsQQLfeAOJHW63brCPOqGmW07F7+aZ2/QBFrY?=
 =?us-ascii?Q?ZO1rkBxCMAZVBkR+SJRv6RPg0BZwCBBvylNIuyaI1N8cbx2HhGFmEfWGPdPp?=
 =?us-ascii?Q?NWdN9YLZfBi4AmOD8+BPzX0iz8cOfNP5lSh0gMmSG50FT1cD5yDjTEALDRNT?=
 =?us-ascii?Q?vcUcIpcRIKslUwPlN5fUcRSsGbylm8DRp8N8kBIGG4bm08eZPpoDCYgpOWmg?=
 =?us-ascii?Q?532sjwehYVdLjLUxhlUTZqeguiticex04DSovbLIjcWENTt8pAZ6cmMESLmG?=
 =?us-ascii?Q?unqqLdTiUpDvsmL1dvbWKZ5rxtWKRwFKdDkWjV84YJwg/lXKQ0xIpS9xs3gb?=
 =?us-ascii?Q?nQCyIvYT2GXyVRabkZh0t1zzF5+ghoy7?=
X-Forefront-Antispam-Report:
	CIP:134.204.222.52;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:lcopzesaa001.seagate.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sMOmeNy89tiMsBavRvmkOOx596Z7flb0XJOrVcfCy72+xwyHGc+O+rPfrQ3Hfm7nZVCqqE2hbNyTGNAmIc332w2dllAA9HhHV0kvPgQAkHIQTDIfJ4Y93WnXYpVRqe/bFAKZOxN6eiGoYc/LwNiB2RP9ohN3q+yWdqoiWEtBtQ4GtLKnnAFP57PpWrpRTwcb5TV2A0Bjl6DrP/bLh8IPvZy327Av/jlZFO7WXMBAHXwlKyT7zpXNNiNfXGPtVYJ0c/nFhOeD9U294PEERlqIpKUmyUicv7ZQfxKmxMNgrsnDaaAcG5UGpOWikpYVxJL6xObcNOMMgCXvz9DgcfrDued35sbpJe1vlQ75Fbf74lwmryChw5euOpBDhofpgkSajV19+yoBMkDbufLkUHSK9aWgWyD5pzaGHA8kfJZhpq68gMtTXxaBjyNC1y1fhURjNCzhS0dzw9BRNL5xocxnwUp45kvC7CNaBiXqf08hQKTPbCGIc2DOsxcnle7BkvpZbw9dwme+gx5pwnmeRX1c1nsILrjRGgG4Y2Qoc1w3hhXYc2fhqqWP511xO3CQFY9dGDo7v9Q0nUjJjDIBgPhYcx1f7swCaREMueZ/njkMpPBdsR+vaF+rUZ7xWlQ8WHXc
X-OriginatorOrg: seagate.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 02:13:24.3566
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e38dbba8-9c60-4e22-37c3-08dd14093bab
X-MS-Exchange-CrossTenant-Id: d466216a-c643-434a-9c2e-057448c17cbe
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d466216a-c643-434a-9c2e-057448c17cbe;Ip=[134.204.222.52];Helo=[lcopzesaa001.seagate.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR20MB7412

This patch allows a CXL type3 device to be initialized with zero memory
size, when there is no memory device property provided.

Signed-off-by: Hongjian Fan <hongjian.fan@seagate.com>
---
 hw/mem/cxl_type3.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 5cf754b38f..4c9d6b8f17 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -159,7 +159,12 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
     int len = 0;
 
     if (!ct3d->hostpmem && !ct3d->hostvmem && !ct3d->dc.num_regions) {
-        return 0;
+        /* zero memory size device. Build one entry with size 0 */
+        table = g_malloc0(CT3_CDAT_NUM_ENTRIES * sizeof(*table));
+        ct3_build_cdat_entries_for_mr(&(table[0]), dsmad_handle++,
+                                0, false, false, 0);
+        *cdat_table = g_steal_pointer(&table);
+        return CT3_CDAT_NUM_ENTRIES;
     }
 
     if (ct3d->hostvmem) {
@@ -712,8 +717,11 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
 
     if (!ct3d->hostmem && !ct3d->hostvmem && !ct3d->hostpmem
         && !ct3d->dc.num_regions) {
-        error_setg(errp, "at least one memdev property must be set");
-        return false;
+        /* no memdev property provided. Default to zero memory size device */
+        ct3d->cxl_dstate.pmem_size = 0;
+        ct3d->cxl_dstate.vmem_size = 0;
+        ct3d->cxl_dstate.static_mem_size = 0;
+        return true;
     } else if (ct3d->hostmem && ct3d->hostpmem) {
         error_setg(errp, "[memdev] cannot be used with new "
                          "[persistent-memdev] property");
-- 
2.25.1

