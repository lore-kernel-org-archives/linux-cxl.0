Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4A7204F97
	for <linux-cxl@vger.kernel.org>; Thu, 12 Dec 2024 12:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734007223; cv=fail; b=oic5MBZ7pQKtvRCVEToNuhrDqI0Ej35MJ+BpNJskSlD3YH0wk6wZXnEoQ/8W09n7SjQC5GDrpPnizRzitaoX9YazwJb11ylM5HX7Nbfy4JyPNwEPkXj2xqVFXmW+xxtwJ/3pijaI+heJsWZw3Rpzmyt+4xwC3KvishGRDeuo4IY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734007223; c=relaxed/simple;
	bh=A6BWw4xYLk1OopfmCjeP6h4hGnCG4fk8eGgoiVFkMP4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KUADb9J6JSja7Dd3/9odMy3DBwYvo9a9KmZY0rYitk6GnPAbnV8OZtd8SXjk/ofOUVB3/RHAR+6DRX21old/Hh3Ufm7yZANb7uyB2Btg1rLRSwuaMRwS8ZmXofSBJBVZwLBkhBXD6bJMydx8Jz+eebp0yCqT5D/TQvlPwByD6lk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IiDV5Ln7; arc=fail smtp.client-ip=40.107.243.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IiDV5Ln7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=crH60cx98A6vdIHvgE3n/n1Wh2fCzSVBvz3pB0XoBt7aJPGb9CCsfm0JLKrH26lNKUW1P/6w7eKe6a+8M8dBQA0BOvZ+p1RxQRPbAJsY8SCmt9kX95Cpm9+raPW1WhyxIp1EKpML48kHZKqkfsp3I5CYVZyuCvYoZFIw8SvwLMiX0huvIUWoObaI+b5H1pNPhT0M49JU9uvs/aL2XWJGD1rw55lVeZkxieaXUCNUudSJVjO1ZtyyjVUN1kB36fCNiT2T0w88I96nY5DyqxnK87D1gSznlJfBZwjRrEH3EeT3RZqcbNOCrZv/hlArLbFcwXNTqJS23+TznheIlvUnMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BbBuwN11aWeok/WwLR946lHwCjzkKkH+KT/BS0vIfqQ=;
 b=mBNATgVukjFnHBwWrrRU6Mow981m9qses00D848LySPxw+Mkq4BMLO0Figqg9MBgGvh+TkPUwxR/LtkGvWe/gc3PgOzpP418BC2GykrXfbohc42N3Lnjnqi+6PU/26ULVhwt/A0DAFkVZYipxZeWn5kn7Qb8rfXd6tnRU6cSbVfCXbAsDM802yEPFd8t7IbB54hVWM+Tki/Pzi7Kb0O+/gqQB/FsRkaKPbeefAvoyLh50BgRPzH7ie8ZfyFhmGhJT/W+7Yfl+XyIurLkDQr1cXzMNTSojROf1Q1y9g0+BAeYzNItaYXpLIvxTKPjLfGOsxol3WMqCCZo7lt++iTqSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BbBuwN11aWeok/WwLR946lHwCjzkKkH+KT/BS0vIfqQ=;
 b=IiDV5Ln78X6UUkVMxOQSNfeijC/cwklOGQkRJcyk5Iu1W0O6+cO6cmh0QmUM+6jj+Q8t0mW1ODHNwgdKRwfq86kGUHpuG22EZ3kay+zr/iz8/rcKPdhhfNLqJf57OI1jUthaGMLxgGBlPaeots9heJx054+Yo4d30xL8hyy112lEzNuuUPgXMgOMnhJyT8dfbIKgScVJXstNDkiX5La1rMg52ttXa6AXo/IOxrWnvktwA6sPmmsmO39ONW/+Krb4xlfAujSL4JkL8e17QNQhsvHBnKmQ4SqirGEjo9vO1KCy0Q9yVEMdIFdjJPerxulpbD6BvK5Sst9/NlnzICo3yg==
Received: from BYAPR01CA0052.prod.exchangelabs.com (2603:10b6:a03:94::29) by
 DM4PR12MB5962.namprd12.prod.outlook.com (2603:10b6:8:69::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.16; Thu, 12 Dec 2024 12:40:17 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:a03:94:cafe::16) by BYAPR01CA0052.outlook.office365.com
 (2603:10b6:a03:94::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.19 via Frontend Transport; Thu,
 12 Dec 2024 12:40:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8272.0 via Frontend Transport; Thu, 12 Dec 2024 12:40:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 12 Dec
 2024 04:40:03 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 12 Dec
 2024 04:40:03 -0800
Received: from inno-linux.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 12 Dec 2024 04:40:02 -0800
From: Zhi Wang <zhiw@nvidia.com>
To: <linux-cxl@vger.kernel.org>
CC: <alison.schofield@intel.com>, <dan.j.williams@intel.com>,
	<dave.jiang@intel.com>, <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>, <acurrid@nvidia.com>,
	<cjia@nvidia.com>, <smitra@nvidia.com>, <ankita@nvidia.com>,
	<aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
	<zhiw@nvidia.com>, <zhiwang@kernel.org>
Subject: [PATCH] cxl: read MEMDEV_STATUS register iff the device has it
Date: Thu, 12 Dec 2024 04:39:59 -0800
Message-ID: <20241212123959.68514-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|DM4PR12MB5962:EE_
X-MS-Office365-Filtering-Correlation-Id: da00bfad-f926-4cd0-a9fd-08dd1aaa217a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?a/0NDf3EusXUuwoK3h3vR5FSa3b8vkMqaaHwMlUEXoYUAObQ4PTA+WzcMRzV?=
 =?us-ascii?Q?ZxOnjhZHLGZ3uatgRARjRtqQFNb9tBd1Y9tXvpaFDIc84HvaebYn/aROAM0v?=
 =?us-ascii?Q?K1kKvVNp4p/OYKzS6VSM8RoBxsozctuGtRn5JZoC3MAEggN8pibZonXBn4nu?=
 =?us-ascii?Q?KNZWAUGqZ5BW7bQBpup5tm9tlELjm1cpxHq6F3w8HC1s8AI+maKIZzzXijrW?=
 =?us-ascii?Q?FATXhcMHaxqoZ148Lxf3xPIEDqOpcBoGGaJ0yiF7aGxY6SvOpQD3hneVPPxZ?=
 =?us-ascii?Q?2FYQgmrvts6+EJBhPLB5xXq9skA4khB6N0cjhatGnWulK324MCUjF1hJF14B?=
 =?us-ascii?Q?zBbpwJeDnNSlDwHYOq+cLeag/4Qz7TNxHXV+JjXCYDGUN52bXYvkbrS4u04B?=
 =?us-ascii?Q?OwS7lYrGHgjWAbkchcZj3yRcBLE2xaPTo7vwnVyIravgMrd9J08ATwB42LQZ?=
 =?us-ascii?Q?EZ84vHy4y1KYdSHv1WjZoGa5+ZilfocR1qyPdjysH+btnLMjXjSbZQPK8ib6?=
 =?us-ascii?Q?AF03x5J9aUXOqVYaK4tASpGSzoz6zLYBxR5sx/vZXrBnP5w71itUolrGAQi6?=
 =?us-ascii?Q?ahLp+jo0VUqz3SEJMFkLXUH7dzvze9mwt8meqZ2z7UaE+hYbVSJgH4oOBbge?=
 =?us-ascii?Q?KBJIu+HQ7uWLBGvy0cMko/92ACGHCArhIg1YxMzxMgxG/m022VGh5FsRCBGX?=
 =?us-ascii?Q?3qwPlndr4Q8RSeizLMBl+OxvWDUXBpqvBvZClLX81FOKqcdXiF7mq1pkECEv?=
 =?us-ascii?Q?ftLpBtkAeujfnlvAfuQ7/rVuqu5/4Q0mUCCWjr0Xny5SckWH1Eqg+1kp3fPM?=
 =?us-ascii?Q?WTzXN2vGn5bYoTHVIuRc6YBmdOV57imOQwo+uI6m9dRJWgaj98XdHQC+HIup?=
 =?us-ascii?Q?HqDE3ix0Cf7G14cem4Mddi/kgGrE75YuD5tNHgBtZZe6ewsi64zvaxbhMtzq?=
 =?us-ascii?Q?6Z5MtpBenxfJIoiLsZq6ehdGlrMR0EsVZz5I11RLjTjLCMOFTZRwKB3Gvzbt?=
 =?us-ascii?Q?uF/Nq3DaKlzfUrfP5wf5+Y4bCUdZbSmEM+5UsicoNTvMulMwKJtNtzlbnDSg?=
 =?us-ascii?Q?M7cGl8+WBgAC3iHq6Z4z9r3YIlZQlHmEOvr+jE4qBoXoLskIqus7a8i7KceW?=
 =?us-ascii?Q?n4OOwwELBGRqkGb1JVCHs+U4HCxBhansSVo9fYWm4yZFd7SuxHjocpJP/EhZ?=
 =?us-ascii?Q?xCC61ysXGoyaDQGcU3v2BpXBCLblRz2Iep3aZ+rHyfiQVurYvZi7f3YHnehV?=
 =?us-ascii?Q?o7DPpRCA1WZ1LUVq8B7CCDqnAqQcuXlc6z7vKTPjtF3w7a8YBv/iy7ewpUJi?=
 =?us-ascii?Q?5BY2F1aQoGECIpdKd102cyyp1PC/gZD1r5w8Sy1I2IWPmtqpgSUVrGRz3oTN?=
 =?us-ascii?Q?ygs8Q2o4KTsSTrd/aOPc++h4bTrJiM019TJPYYCnehEDbZ23W7v0qJGsodGw?=
 =?us-ascii?Q?4kXeIHAwKAhUmhACNAr6+rmAgyGD7FxE?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 12:40:16.3678
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da00bfad-f926-4cd0-a9fd-08dd1aaa217a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5962

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

Only read MEMDEV_STATUS register for ensuring media ready when the device
has it.

Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 drivers/cxl/core/pci.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 51132a575b27..7a8ec4928da6 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -203,9 +203,11 @@ int cxl_await_media_ready(struct cxl_dev_state *cxlds)
 			return rc;
 	}
 
-	md_status = readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
-	if (!CXLMDEV_READY(md_status))
-		return -EIO;
+	if (cxlds->regs.memdev) {
+		md_status = readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
+		if (!CXLMDEV_READY(md_status))
+			return -EIO;
+	}
 
 	return 0;
 }
-- 
2.34.1

