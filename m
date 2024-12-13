Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0646C1BB6B8
	for <linux-cxl@vger.kernel.org>; Fri, 13 Dec 2024 10:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734086363; cv=fail; b=RpFaai4U91ZIYls/AHY+oe5abjp5RyrS6zLe2SB1ZP6fqwudwAv8pVoMQHdX3PCrzOHFApTmd2kits3Qvl7YgLcFF3BNT1r7HS1OJOPjqmM6i1Hiq9FK7NIHWAR2z0i23GHPAL0I9gShB606g0F740X5y9XACoFeLS86iSYlRFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734086363; c=relaxed/simple;
	bh=RVL8keFfEVAzNalthG4fsdPLO8ZuvXAttJRH1khGdPU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=m6ny+wQKskW01oDNgl5nUcNMxgBiL+3P323NzsGGJWTfzzmDz6c6+VrnHiRW4cCNqEoV4SEDM0gXCJtB258gaLEF5pbzPGnVveditYrjduQUDi+pmYJj8/245MrMUa343lRbsL0wAGg1Sc+gTla711k1bIIikw5hnyW2N5WVhi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MJPBNoll; arc=fail smtp.client-ip=40.107.243.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MJPBNoll"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=guijyyZzhdT8ezrHFGNHjwx1umuEkLrNFL9ZJ3Xa2AXBpcZdCGuKXdfalxCFNdBtZS5CpPR8hMK54N1RSWJkzSisK0OX06WkngCz6ObVtvPLR/jGsZrdpL+IUqDwuaJLkmLlG6lcvb8Yg0BIPTT/+BDmkDBJi5iWPxMKgCszWF/uJMeYTExbpyHuxIV4oVfbRZqLdbZjxPV1b4dmxm9fKgxAgFBTnfzfd5survDuseqg+zUkjMMpK3yyecU+5Ov/3OVL5Pi+SOWhBslRWccwIP1GsfL1K/Ekl6xuoFg8mh4kScxzEDvqD6voLdp8W+D2HXBdOIA4DsTIyYN7yLXqAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JagIpPchYZn85ugZl+SVTW2K5MH9gbtYPIUvK9Xwgmk=;
 b=k5FV3GW8fwb3xn0Y+/8UdhGoub58org9Vif3dVaq3D8AuxR9jYfgbNtMoxA+3ybB+/4i/XJ5QrH+YNiGUfdr4ymZgHwn17QG7ozNlvUbzfOUToXkvcLOqLgvq/b7URcnK5lVkC5yWRdPxbIOBq1u8d3WPwt/bfBUibm3Gm7gjbaL6Y4u8vKj9qH4KOs1ARNpSJ7oDzwp5yrZ15u5cnyehz7Mdbe4keWb2cvd1+ftiOcNKa8WUHesIIqJPSxQGna+aJtehQoEhOxlCMQ0g0mMgTWapiPGAK3NQ2CLTVsrwdVGOmd5+aRymWg8plZj3km9p0RgcOZSVe2jScbwa2CLdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JagIpPchYZn85ugZl+SVTW2K5MH9gbtYPIUvK9Xwgmk=;
 b=MJPBNollCfmAeikUa6FXJOKiXwRZJTK8ddnhKarJwwlAIQvIoUCAeWyt+aURF4gwOUWCDtf11yxpidd8YHfsjkH94Y5VZ5OP4hNa2larLPH++z4Znk1NwyF2uGS9sgYnWzClyZ4TvwlUnLQDM2niCaqUxIe23frL0Ad/5xqFnlwXlGz275EIRYrQR891goh5zApxnSqKrd1l7cLZFi3LynZkLxEl1nW4PbCB1omBKc6QFAx6ZKOdnrafj/KrUoirIQd1DHbCN/EG7zPN/Ds+Ef0VsQLizMkZ2GklFXEXuVJ9hL2i1plFM5cBn4NTNatlP8RoE3EBIxEGt8kUKQrXdw==
Received: from CH0P221CA0032.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::11)
 by PH8PR12MB6889.namprd12.prod.outlook.com (2603:10b6:510:1c9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.18; Fri, 13 Dec
 2024 10:39:16 +0000
Received: from CH1PEPF0000A345.namprd04.prod.outlook.com
 (2603:10b6:610:11d:cafe::4c) by CH0P221CA0032.outlook.office365.com
 (2603:10b6:610:11d::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.17 via Frontend Transport; Fri,
 13 Dec 2024 10:39:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH1PEPF0000A345.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Fri, 13 Dec 2024 10:39:15 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 13 Dec
 2024 02:39:09 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 13 Dec 2024 02:39:09 -0800
Received: from inno-linux.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 13 Dec 2024 02:39:08 -0800
From: Zhi Wang <zhiw@nvidia.com>
To: <linux-cxl@vger.kernel.org>
CC: <alison.schofield@intel.com>, <dan.j.williams@intel.com>,
	<dave.jiang@intel.com>, <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>, <acurrid@nvidia.com>,
	<cjia@nvidia.com>, <smitra@nvidia.com>, <ankita@nvidia.com>,
	<aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
	<zhiw@nvidia.com>, <zhiwang@kernel.org>, Li Ming <ming.li@zohomail.com>
Subject: [PATCH v2] cxl: factor out cxl_await_range_active() and cxl_media_ready()
Date: Fri, 13 Dec 2024 02:39:06 -0800
Message-ID: <20241213103906.378950-1-zhiw@nvidia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A345:EE_|PH8PR12MB6889:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ffe4755-aeaf-4f92-0cca-08dd1b626463
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Q7CBY1ESpDT0dFuzcAaAnPlalCGBBy0kff0cS4wh9rhTOv7kUj+23AgwQYL4?=
 =?us-ascii?Q?QKHT6vMST09gbAqa6YMn9x4AwNEmlf9nwokzK6t3Ahyq8K1SH/jcV+sZ9Bdi?=
 =?us-ascii?Q?LtKT8yQcnzypqD5h2mJLMYOHtC47+m4+wHFER1bfee0dm1Rf44MB1mO+548B?=
 =?us-ascii?Q?TzvWJSBJLV66PF5VH3VXRx0LOSHyzMBlJnI5GmTgpvSkJqUAm6TdWAQqA3n7?=
 =?us-ascii?Q?OCpOqO1S404xOt+/9nRCTMSL9tpdwPojJqqU9s8JBKlPekrvktO/2NEfvH+o?=
 =?us-ascii?Q?3em4go/4zgCN+gUC38aXggFKR+xgHYrml7Z9bl1zvX4OD6w9IttB38WFFnvu?=
 =?us-ascii?Q?GNwXOOVOR6uptyIHFZUkq0h4HCo/i5nUFGIIqCQP+fqRGeslXut/d+ZhwBzM?=
 =?us-ascii?Q?fvxKg5cZ8gcqaXcjLIP85dyRu5VPfSkRfnl/lmOdVzBhrKICfVA//UEcU12m?=
 =?us-ascii?Q?iGVefnFPOrc6WZ0cd2blfoHqQBDVLPgeprG0QNOUWClrsEsnVMm/Eq8+rPCW?=
 =?us-ascii?Q?5sQmq2xVF8Ebevo+306MCs4TNVk9VQ6aRnTIgvDo3XZARssjNqcb9/F59Ikh?=
 =?us-ascii?Q?c0O6THT/vfrLyR1HikwQHK2HNDDrGXvHgWEdsRi3UYwHJ4YJAdXooLZnTB/m?=
 =?us-ascii?Q?QBODUiHx6YvY7TApWnuTWHUm0IGRxULIX1Sm+cBg4/QtWyBuLEK/yM1rxgbO?=
 =?us-ascii?Q?eUyTFYc8UhclBpc1J/cdRrjoRsGw+3Nu5D5NOS6BKdmiZOjvANRjBFzV2wuU?=
 =?us-ascii?Q?PUXD1EhctLmWdGOc+FqilKop38wzkZVVcCrEvavzifcIoirQEj1GFNgU8jeI?=
 =?us-ascii?Q?GEdp7GnwoaW/ycwJghxtdnv023P+nXaFHRyitGJImU3AT7WhZvbjcyYxvwmu?=
 =?us-ascii?Q?hgWRzQkFrOMS4X2romKvPsa8Pa+9W2T27vRlS4mM8WzDN+/nO4piIg0JTABJ?=
 =?us-ascii?Q?IYmEQGgk1AaOaBRdIhGphIoIac26A3FgtuD5RPcAGJLUrYrTk5bkagJebSD8?=
 =?us-ascii?Q?SiWBYmAf0njIHGkUTr4QwAdMNvQS30Z9Geyh1gSKZablR/CBsm0HsYslGg/X?=
 =?us-ascii?Q?P56ftbeq9Mll1ByKWe/s1xEL6SD0eUltxoyAnh8DAN0B0S1x9QAzzZRK7DzI?=
 =?us-ascii?Q?cEYA6JBt2yJBexsPQ+MpDZbgWcMBw+JDyFax7fvn5xP5s4jDjYEJ+GRiSW3U?=
 =?us-ascii?Q?PZDnfrBId10tbXDfZRYtIyeJeUWZn/2RfFi7B7YMe1U2IKG42HVCuQOycJre?=
 =?us-ascii?Q?ORkKiMcPOtxkFS28FlALzC6CNLaB/lNPq7i82nL0UlDmO+VuLJlmU8A5HEkB?=
 =?us-ascii?Q?0SAjp1nboHAsNvL8xIoDJwIi66hCdfWPWzuYnSBlrz31u0mqdVXnesYFPuqN?=
 =?us-ascii?Q?2tZl/++aYWxwL5YYrzwd+k2ip+53q/W87P3o/oP+dV7fCgK85tlYKLPOJgNE?=
 =?us-ascii?Q?TMLUUyqHWAYyG2iF/acxXhyF20mZAX8Y?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 10:39:15.9873
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ffe4755-aeaf-4f92-0cca-08dd1b626463
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A345.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6889

Before accessing the CXL device memory after reset/power-on, the driver
needs to ensure the device memory media is ready.

However, not every CXL device implements the CXL memory device register
groups. E.g. a CXL type-2 device. Thus calling cxl_await_media_ready()
on these devcie will lead to a kernel panic. This problem was found when
testing the emulated CXL type-2 device without a CXL memory device
register.

[   97.662720] BUG: kernel NULL pointer dereference, address: 0000000000000000
[   97.663963] #PF: supervisor read access in kernel mode
[   97.664860] #PF: error_code(0x0000) - not-present page
[   97.665753] PGD 0 P4D 0
[   97.666198] Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
[   97.667053] CPU: 8 UID: 0 PID: 7340 Comm: qemu-system-x86 Tainted: G            E      6.11.0-rc2+ #52
[   97.668656] Tainted: [E]=UNSIGNED_MODULE
[   97.669340] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[   97.671243] RIP: 0010:cxl_await_media_ready+0x1ac/0x1d0
[   97.672157] Code: e9 03 ff ff ff 0f b7 1d d6 80 31 01 48 8b 7d b8 89 da 48 c7 c6 60 52 c6 b0 e8 00 46 f6 ff e9 27 ff ff ff 49 8b 86 a0 00 00 00 <48> 8b 00 83 e0 0c 48 83 f8 04 0f 94 c0 0f b6 c0 8d 44 80 fb e9 0c
[   97.675391] RSP: 0018:ffffb5bac7627c20 EFLAGS: 00010246
[   97.676298] RAX: 0000000000000000 RBX: 000000000000003c RCX: 0000000000000000
[   97.677527] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[   97.678733] RBP: ffffb5bac7627c70 R08: 0000000000000000 R09: 0000000000000000
[   97.679951] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[   97.681144] R13: ffff9ef9028a8000 R14: ffff9ef90c1d1a28 R15: 0000000000000000
[   97.682370] FS:  00007386aa4f3d40(0000) GS:ffff9efa77200000(0000) knlGS:0000000000000000
[   97.683721] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   97.684703] CR2: 0000000000000000 CR3: 0000000169a14003 CR4: 0000000000770ef0
[   97.685909] PKRU: 55555554
[   97.686397] Call Trace:
[   97.686819]  <TASK>
[   97.687243]  ? show_regs+0x6c/0x80
[   97.687840]  ? __die+0x24/0x80
[   97.688391]  ? page_fault_oops+0x155/0x570
[   97.689090]  ? srso_alias_return_thunk+0x5/0xfbef5
[   97.689973]  ? srso_alias_return_thunk+0x5/0xfbef5
[   97.690848]  ? __vunmap_range_noflush+0x420/0x4e0
[   97.691700]  ? do_user_addr_fault+0x4b2/0x870
[   97.692606]  ? srso_alias_return_thunk+0x5/0xfbef5
[   97.693502]  ? exc_page_fault+0x82/0x1b0
[   97.694200]  ? asm_exc_page_fault+0x27/0x30
[   97.694975]  ? cxl_await_media_ready+0x1ac/0x1d0
[   97.695816]  vfio_cxl_core_enable+0x386/0x800 [vfio_cxl_core]
[   97.696829]  ? srso_alias_return_thunk+0x5/0xfbef5
[   97.697685]  cxl_open_device+0xa6/0xd0 [cxl_accel_vfio_pci]
[   97.698673]  vfio_df_open+0xcb/0xf0
[   97.699313]  vfio_group_fops_unl_ioctl+0x294/0x720
[   97.700149]  ? srso_alias_return_thunk+0x5/0xfbef5
[   97.701011]  ? srso_alias_return_thunk+0x5/0xfbef5
[   97.701858]  __x64_sys_ioctl+0xa3/0xf0
[   97.702536]  x64_sys_call+0x11ad/0x25f0
[   97.703214]  do_syscall_64+0x7e/0x170
[   97.703878]  ? srso_alias_return_thunk+0x5/0xfbef5
[   97.704726]  ? do_syscall_64+0x8a/0x170
[   97.705425]  ? srso_alias_return_thunk+0x5/0xfbef5
[   97.706282]  ? kvm_device_ioctl+0xae/0x130 [kvm]
[   97.707135]  ? srso_alias_return_thunk+0x5/0xfbef5
[   97.708001]  ? srso_alias_return_thunk+0x5/0xfbef5
[   97.708853]  ? syscall_exit_to_user_mode+0x4e/0x250
[   97.709724]  ? srso_alias_return_thunk+0x5/0xfbef5
[   97.710609]  ? do_syscall_64+0x8a/0x170
[   97.711300]  ? srso_alias_return_thunk+0x5/0xfbef5
[   97.712132]  ? exc_page_fault+0x93/0x1b0
[   97.712839]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   97.713735] RIP: 0033:0x7386ab124ded
[   97.714382] Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10 c7 45 b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00
[   97.717664] RSP: 002b:00007ffcda2a6480 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[   97.718965] RAX: ffffffffffffffda RBX: 00006293226d9f20 RCX: 00007386ab124ded
[   97.720222] RDX: 00006293226db730 RSI: 0000000000003b6a RDI: 0000000000000009
[   97.721522] RBP: 00007ffcda2a64d0 R08: 00006293214e9010 R09: 0000000000000007
[   97.722858] R10: 00006293226db730 R11: 0000000000000246 R12: 00006293226e0880
[   97.724193] R13: 00006293226db730 R14: 00007ffcda2a7740 R15: 00006293226d94f0
[   97.725491]  </TASK>
[   97.725883] Modules linked in: cxl_accel_vfio_pci(E) vfio_cxl_core(E) vfio_pci_core(E) snd_seq_dummy(E) snd_hrtimer(E) snd_seq(E) snd_seq_device(E) snd_timer(E) snd(E) soundcore(E) qrtr(E) intel_rapl_msr(E) intel_rapl_common(E) kvm_amd(E) ccp(E) binfmt_misc(E) kvm(E) crct10dif_pclmul(E) crc32_pclmul(E) polyval_clmulni(E) polyval_generic(E) ghash_clmulni_intel(E) sha256_ssse3(E) sha1_ssse3(E) aesni_intel(E) i2c_i801(E) crypto_simd(E) cryptd(E) i2c_smbus(E) lpc_ich(E) joydev(E) input_leds(E) mac_hid(E) serio_raw(E) msr(E) parport_pc(E) ppdev(E) lp(E) parport(E) efi_pstore(E) dmi_sysfs(E) qemu_fw_cfg(E) autofs4(E) bochs(E) e1000e(E) drm_vram_helper(E) psmouse(E) drm_ttm_helper(E) ahci(E) ttm(E) libahci(E)
[   97.736690] CR2: 0000000000000000
[   97.737285] ---[ end trace 0000000000000000 ]---

Factor out cxl_await_range_active() and cxl_media_ready(). Type-3 device
should call both for ensuring media ready while type-2 device should only
call cxl_await_range_active().

Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Li Ming <ming.li@zohomail.com>
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
v1 -> v2:
- factor out routines for different CXL-type devices to call. (Dan)

v1: https://lore.kernel.org/all/20241212123959.68514-1-zhiw@nvidia.com/T/

 drivers/cxl/core/pci.c | 18 +++++++++++-------
 drivers/cxl/cxlmem.h   |  3 ++-
 drivers/cxl/pci.c      |  3 +--
 3 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 51132a575b27..d4ce9cb578ff 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -177,12 +177,11 @@ static int cxl_dvsec_mem_range_active(struct cxl_dev_state *cxlds, int id)
  * Wait up to @media_ready_timeout for the device to report memory
  * active.
  */
-int cxl_await_media_ready(struct cxl_dev_state *cxlds)
+int cxl_await_range_active(struct cxl_dev_state *cxlds)
 {
 	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
 	int d = cxlds->cxl_dvsec;
 	int rc, i, hdm_count;
-	u64 md_status;
 	u16 cap;
 
 	rc = pci_read_config_word(pdev,
@@ -203,13 +202,18 @@ int cxl_await_media_ready(struct cxl_dev_state *cxlds)
 			return rc;
 	}
 
-	md_status = readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
-	if (!CXLMDEV_READY(md_status))
-		return -EIO;
-
 	return 0;
 }
-EXPORT_SYMBOL_NS_GPL(cxl_await_media_ready, CXL);
+EXPORT_SYMBOL_NS_GPL(cxl_await_range_active, CXL);
+
+int cxl_media_ready(struct cxl_dev_state *cxlds)
+{
+	u64 md_status;
+
+	md_status = readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
+	return CXLMDEV_READY(md_status) ? 0 : -EIO;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_media_ready, CXL);
 
 static int wait_for_valid(struct pci_dev *pdev, int d)
 {
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index afb53d058d62..6aba6d39d82b 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -817,7 +817,8 @@ enum {
 int cxl_internal_send_cmd(struct cxl_memdev_state *mds,
 			  struct cxl_mbox_cmd *cmd);
 int cxl_dev_state_identify(struct cxl_memdev_state *mds);
-int cxl_await_media_ready(struct cxl_dev_state *cxlds);
+int cxl_await_range_active(struct cxl_dev_state *cxlds);
+int cxl_media_ready(struct cxl_dev_state *cxlds);
 int cxl_enumerate_cmds(struct cxl_memdev_state *mds);
 int cxl_mem_create_range_info(struct cxl_memdev_state *mds);
 struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev);
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 4be35dc22202..6fbbaae4a79c 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -846,8 +846,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
 
-	rc = cxl_await_media_ready(cxlds);
-	if (rc == 0)
+	if (!cxl_await_range_active(cxlds) && !cxl_media_ready(cxlds))
 		cxlds->media_ready = true;
 	else
 		dev_warn(&pdev->dev, "Media not active (%d)\n", rc);
-- 
2.34.1

