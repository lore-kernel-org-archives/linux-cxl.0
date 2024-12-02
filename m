Received: from esa.hc4959-67.iphmx.com (esa.hc4959-67.iphmx.com [139.138.35.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657AE1DEFD2
	for <linux-cxl@vger.kernel.org>; Mon,  2 Dec 2024 22:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.138.35.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733179845; cv=fail; b=WYZQjpyX2abNWiPuWSG38IkWcMM9XVTCndIFzt5zK/WsxU/Q4nUgjE7eDaA8z7zqj/aiEXNTDjHb/BxjC+gj1coYQ1byXhgkvc9/M8066IyJUlRDGX4EYUH7NjjyedcgFnHg9xGt/dN6hyXECFNAfvQvIF2V/EbDJ25I8v8xtcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733179845; c=relaxed/simple;
	bh=92ZViDS5K6CVrWTwExPbSW6thPxujHyMchapt0Se1Wo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=SbZFmveWXwF7M9z7CuWY4dNyewlG1zwm17XPUTjAbVE07+vCRoX8Fx3l9ziATEDGuZLUO+n0pd/y8yGpN1zAV0mmNotW3RaB5tSsq4jmKYWYQYy65MHZ/z62dC6+GeXQkkL63YZ5VcwPEqJNGUuqM+KrpYQD2IjVXHGjcEfYkZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seagate.com; spf=pass smtp.mailfrom=seagate.com; dkim=pass (1024-bit key) header.d=seagate.com header.i=@seagate.com header.b=kvQSM8s1; dkim=pass (1024-bit key) header.d=seagate.com header.i=@seagate.com header.b=YV6mQ5EM; arc=fail smtp.client-ip=139.138.35.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seagate.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seagate.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seagate.com header.i=@seagate.com header.b="kvQSM8s1";
	dkim=pass (1024-bit key) header.d=seagate.com header.i=@seagate.com header.b="YV6mQ5EM"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=seagate.com; i=@seagate.com; q=dns/txt; s=stxiport;
  t=1733179843; x=1764715843;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=92ZViDS5K6CVrWTwExPbSW6thPxujHyMchapt0Se1Wo=;
  b=kvQSM8s1QJ+qe7aS6RMpws9NSDD889rhk8QobcTf+d+4CmRU0mJV838v
   ialE2kCYAQZI+oH3T0aT+wXyt9bfaC4FGOXGi+yL6AIzllPbCWlsRyXLs
   Lk/R9diAAEVecaNLgveZXhUvpkAE8K5nTmmYbjKNR/Nz1Aj7BCDVA+Sff
   M=;
X-CSE-ConnectionGUID: dQQLbzpoQYOxCSo6gtEuYg==
X-CSE-MsgGUID: Q6r+TutrRiGW9JJnlEI+ZA==
Received: from mail-bn7nam10lp2040.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.40])
  by ob1.hc4959-67.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 14:49:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hZfgb8BV8Y8AZFNcxS/ccCIzzMLPDF+hH/KTuwVJrGAKBz9K8z6KYEXRd9YmyNCyCyeSkBeBCkuGDst9sT1GaIMwV5bii92uuP8wigW5X0c88oeZXXA5h7sMAPeL+3HZl31PKu9MgSsB7R8gfGB7Ao0AnZpGMdxKLVgrxhMVtfk+Xz0C2t7gTXb1SnpG2zU6MVJ+08+OPOz02qi7cgf13UhbYVkKs1t+OGAYVU0aXTFLd7zp4Q97jHnUwdRe1gqP2NN40BDBVb7Qwiu0ZYMy6d+tB2H0Ng/yeA9cwj5V2bnnRFcOPkTzye/4nxr7OJ9CzmbY1HXJbaFHtFDi93z5Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0msWWMp6lNH/OVHvjwB1kEkRiWg3E4iezqN3tCtkZCA=;
 b=XU7TD1Rl/OeL5gm2w+I5UmDHhYxuhVhBoEgAsr3XCHkx6EMtHah9BLf4aY3eZHM+lc4+M6ws7tM8sZb/T9e/pKtZcNCOikNsqNCrRdnRvehWKI0nMIVqbKIMR3p7zKB2qULUcZFHCmNZNRG7+htNrde9Kkudth8/NL1xmTx5QadVT4LYMoHsCro1D3GqZJF4ZXii3fxjxLhtu3sFoPaie+yy4olubYSohWJfUCn194gsOZiyaexfaEwj5XXoX4khmZtf00iyJECUisswKwfsM2qO7/WTS+bwyguy3ApgEUcxehdx/lalbwGsKNyJIliQgR4ir1xRtKOYol1le+UCqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 134.204.222.53) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=seagate.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=seagate.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0msWWMp6lNH/OVHvjwB1kEkRiWg3E4iezqN3tCtkZCA=;
 b=YV6mQ5EMGBcMkTvhjIIfeHVrqLBnkMSv8ekAT5AmCQeneuFHT4hjtntPDpp8G8GcaOTKSA+gLSQhkS3wJNKtixSNvDacMfMKa6eIGYn8BAPQtvVsEmhRFtRODXGRuvmQC6TyA7aTDdqAfKNT7MuZeupMg+QRxyqDVuaW/iHNzlY=
Received: from BN9PR03CA0449.namprd03.prod.outlook.com (2603:10b6:408:113::34)
 by SN7PR20MB5190.namprd20.prod.outlook.com (2603:10b6:806:269::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.8; Mon, 2 Dec
 2024 22:49:32 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:408:113:cafe::53) by BN9PR03CA0449.outlook.office365.com
 (2603:10b6:408:113::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.18 via Frontend Transport; Mon,
 2 Dec 2024 22:49:31 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 134.204.222.53) smtp.mailfrom=seagate.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=seagate.com;
Received: from lcopzesaa002.seagate.com (134.204.222.53) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 22:49:31 +0000
X-CSE-ConnectionGUID: neVcBX68RPOmgzMmaQvKyg==
X-CSE-MsgGUID: hs+mcCb1TYKaWafYsqsC8A==
Received: from lcopiesaa002.seagate.com ([10.230.120.53])
  by lcopzesaa002.seagate.com with ESMTP; 02 Dec 2024 14:54:49 -0800
X-CSE-ConnectionGUID: DuqMBeEcSL+JlbCmCRv0AQ==
X-CSE-MsgGUID: klHG5o/WQrCvz1H1hIP7Hg==
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="113320196"
STX-Internal-Mailhost: TRUE
Received: from mag-tester2.shk.minn.seagate.com ([10.52.21.5])
  by lcopiesaa002.seagate.com with ESMTP; 02 Dec 2024 14:48:52 -0800
From: Hongjian Fan <hongjian.fan@seagate.com>
To: qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org
Cc: jonathan.cameron@huawei.com,
	fan.ni@samsung.com,
	Hongjian Fan <hongjian.fan@seagate.com>
Subject: [PATCH] hw/mem: support zero memory size CXL device
Date: Mon,  2 Dec 2024 17:03:11 -0600
Message-Id: <20241202230310.1531219-1-hongjian.fan@seagate.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|SN7PR20MB5190:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 48493879-7fc5-487e-e1a5-08dd1323960d
STX-Hosted-IronPort-Oubound: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1aQJ4NAn3+bmM3dfEaVUEsKv+7ATrgMD3hcEsqIIrr1P9lCvDKoP49P3AIV4?=
 =?us-ascii?Q?wblU137knab0eBCKSLKTaPPhppO+srFQKGfnAQNBbKsDlT0Sz/s9wNEX90CK?=
 =?us-ascii?Q?316XsPIek8YU0jvCxaMLi11MWnR/JtSztXB8RULXU+ySHNTDFbd58SWAvHAk?=
 =?us-ascii?Q?C1hRl0baJXfHemqKvX70/DcegbBGIc3m2Z9q+trGFxLOotmV4OdsJnlJ7zoJ?=
 =?us-ascii?Q?m8k6yiNBDAUZ916/p6b5EJ8OA2mHy4FaPOdhBFWtRXo5Zr5Pif9L6IE5Gnby?=
 =?us-ascii?Q?kRzZc1OXrSQIiT4fIwZh3x6ZNnjQtVwau47rW2j0EjW1o/TwMMzxq9R6jeE+?=
 =?us-ascii?Q?N+IHEm8mSrbQ6Z5hmXOkTNgXVpiEfsJdzyiFhZh0rMUOg77QiBuS4xvNNfTm?=
 =?us-ascii?Q?9deHUDRKBZuoomvlkgmngwNOuHQr9+cs558dzXGu3DZeumVrK13zOoAtS5vy?=
 =?us-ascii?Q?pXs7j/8X07CV1ZlmYHNAQyuybFQ2kTMp4nP+w/sh96r3oelucZ/0kETcV60B?=
 =?us-ascii?Q?fZzFhRrdRBJgUVJppTtMDPL49O8WrurcdH9jlpH21QlGILbbbQsNT/FxrOAA?=
 =?us-ascii?Q?CRgPmV5UtKCJ1RlA2k/+8deH56UqC/ZtyeKZlNRKI8zve60zRMObSxS9REoB?=
 =?us-ascii?Q?HXqCTYIdM1FkOGOmIVKZeIbrfJDk8fozMWSYsWBGAla07zLIhcJfTgMH5tWq?=
 =?us-ascii?Q?AfT8YuDcgkmh1C2Yk2mtH4TIoS1XOtmamfuno4shRWFI4Onahmry62HkG1M2?=
 =?us-ascii?Q?O2QMvD6jjdDkP0vMJvrJ2DX1eDjL/hWyRTGoVE+IMb42JHV+lbCMyeWqb2zc?=
 =?us-ascii?Q?5rF12HxDBvIVKIA0kOAVnSmetXxS3XSb0Rxl9Ks1aq+4nu72SjYCjvs5sG3s?=
 =?us-ascii?Q?Vp7v9iMe+SAECU69hfwnOOrFk55wJBxcEsYEpDURU/gPRkmpZE7Y1HEwovGS?=
 =?us-ascii?Q?99mCFggB78EN7K8IrvR83z9R7xhtyWWS1UOeDUHhoPLyTgMahBLktgAmwowb?=
 =?us-ascii?Q?/YajfIwHLiX77VV0mV1j66oGIRlTuStmWSQN7h9XKdhe2oN+Oj0CnTXCiQhQ?=
 =?us-ascii?Q?UzDgtJvI8G8fdTijsMrdKc7HPeYjj91CrxqYkZYmUhs7eX0CGoiyzQ4gfegM?=
 =?us-ascii?Q?PU1G8ojeqUewNrqJgcrBXXgBkJM9DxXb3jaTuavNQApDLu9kndT3MMFiXog9?=
 =?us-ascii?Q?1ug8taht1BHIU2Tnqm5LUB472CzV51xJshqZAnw4zN5sbUtJKJPpZ1nxt61G?=
 =?us-ascii?Q?WX6nMnSCt3nDcIIdKmoF0vKS+Q7CbIaOm2/FeHyA/Zyms2D0FcO9RTP+ys9I?=
 =?us-ascii?Q?cVLnTwjHInpXMZQ1SK6KJAEp8a+d4vsoXMSk0hG5Y7xBbPMmq57LHhUb5fxk?=
 =?us-ascii?Q?dLv37bdV9QOsSGCDmjFQDWmHkpnbjshqst6piDPbjEnwL2BzXb1AJzKguLuf?=
 =?us-ascii?Q?haEXu+0OMMUQPdafr4WYpc9PtNMVtKKw?=
X-Forefront-Antispam-Report:
	CIP:134.204.222.53;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:lcopzesaa002.seagate.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RBTfJqKQowzs1eDgORLL1s9GFNsu/HA4DAxEhgoOJKWHDOWtxmc7sNF8vm+qykwDBzxAogeWOh2ailPvQZYjC/Yv9MUNmq4cHFNVWc8dj4KPymip5zEuZHq/PYewVM97PsAqrAuAU6r1FPc4KstXH4HUxUk+dzWJYLwcCEKIkqo1IOSwiR4Orx9Dw14qZ8fE/yCDYwrySyOu1fgj3Rv45WrACiwieQBvHAtpfp47GiXOkugqUpL8dQv0k9jCa775r45VWJo4OK1hf4nJR+D1UM0gHXo0jJvgpMsHfcaXq29u4e9f7EaIHv9wubdPGOXLp5wdflcm9zZtFr/AQ9lqmEzVZMeSFSMInrzf0efpa1uRgH8iiRi+Wy2es5XM6rcluRZ4VzLlgud8bGiYJJP3f81trmOl89gnCfUZ6MfjRR3LalZMZYAIIlLt347Vz04dyLovzU5m5hOiDpjcGRqHJvKXQwrfal6sHxanVyQJNDde0kmJd5qs7EhLDh8rVkGzLls1UWJQRA+auIp/J3Sr8vbrHZPpjAFgOLhHC+YV/jSEq1qQHiG0X3ZnO01KcT6TPuZBxtHs+7jWKcGEP2jGGYUFwYFLLdtJnrFHYoPGkwBWoI+jKdHSYNRvdii5clZ1
X-OriginatorOrg: seagate.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 22:49:31.6566
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48493879-7fc5-487e-e1a5-08dd1323960d
X-MS-Exchange-CrossTenant-Id: d466216a-c643-434a-9c2e-057448c17cbe
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d466216a-c643-434a-9c2e-057448c17cbe;Ip=[134.204.222.53];Helo=[lcopzesaa002.seagate.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR20MB5190

According to CXL 3.1 specification, 8.1.3.8 DVSEC CXL Range Registers "A CXL.mem-capable device is permitted to report zero memory size."
This patch will allow a CXL type3 device to be initialized with zero memory size, when there is no memory device property provided ( neither volatile, persistent, nor dynamic region).

Signed-off-by: Hongjian Fan <hongjian.fan@seagate.com>
---
 hw/mem/cxl_type3.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 5cf754b38f..35caa186ca 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -159,7 +159,12 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
     int len = 0;
 
     if (!ct3d->hostpmem && !ct3d->hostvmem && !ct3d->dc.num_regions) {
-        return 0;
+        // zero memory size device. Build one entry with size 0
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
+        // no memdev property provided. Default to zero memory size device
+        ct3d->cxl_dstate.pmem_size = 0;
+        ct3d->cxl_dstate.vmem_size = 0;
+        ct3d->cxl_dstate.static_mem_size = 0;
+        return true;
     } else if (ct3d->hostmem && ct3d->hostpmem) {
         error_setg(errp, "[memdev] cannot be used with new "
                          "[persistent-memdev] property");
-- 
2.25.1

