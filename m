Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012027.outbound.protection.outlook.com [52.101.43.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506C630C142;
	Fri,  5 Jun 2026 04:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780632988; cv=fail; b=nNenFcCN57mMY2QpaSe4epd7hyVP2UwB+MIuiTT4xfiEtHqXx0yVvBVw2TG1bm8eJ7iey4qJ4OrZUsdD9ry71kOLg1WjMOuMTNr4B4LiCIKG9g1Pefp8ELVR5t3J7tWakxRlxiQEnN3mcGNLpu9NQixv1RH5U4Nv8hJ63YegW3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780632988; c=relaxed/simple;
	bh=FZRynH/1bCSOaFPYFOvT0/ocBQBujrDuwr/Fla7Ji0s=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=VCmSZXXEW35yURtsGllEcXhJefyiOBL4+xualp5gapHN19KNALnmwpMoblZHDm+nzfcNwK9DRk4HY5jICLBGUD1wxtMD+oNhN6CgRwXbz4V0sIklD6D2BASee7AoZ1sE/4g6kQA2Ab+0XURNbN4PvPpXGu9E030oonGjoebdevI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FHZpsGCQ; arc=fail smtp.client-ip=52.101.43.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FHZpsGCQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MytLXA3ogIpr6xkCPn7zH+l9dm2pE9aixVdC6gkn6dqJEOOor00duKDWVCl2KKjVGS4xHhSd1yScbrw+QqNxwqTcKRRbBFpBYhlKSsUmzErsQki74YYACTGtOiAqnYP3r1IAjPzhf6qZZFGkD1DIHZ8qylqde8O6JewvhrSV/kXg9pXdE3tZ4Qzaf76Sbb1ZMxsowwX8yB5Bc/Q4mgTSu/Av6Z6exgiaNVWzVtM+CMOox7oibU58PBqgMnNsK8IIBPczkRQu42jMflePl8Knvshs37ULqDf7b8BFfjz+hCAeztunK0jUr1JxVHXxP4vbMql6kQaaeUNCS84BvF39XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iCDbyJfzxBMT1u/flW1HB7nZ6BT9+0w+/qca3wz6Ie8=;
 b=JxMuMBqdJ8KUaM2eWHlpHCluFMY0up3Qq2GmLAp3MrWzVA5hjugQ0xWNPTPoqBc53E18eYmM9vdDbSxxq5MzGKTg9XmVy50eOYafYDLYEke4kR569t7WcoTxQCfFCe3QQfCSrw2a6N4ObTa7BhoyJS9oHJAWT0R11zM45vQrgo5oU/loUIEU9ip/Tk7wyGwkLP7xa/Q3/8OuVKSceS4UTSobWHWwuYZnJNce6u+HkPkGYplJ5KoUDFjvrB1p18rewG62qwKB+NYInlrt3K8/7pxUqtLrjT8mfwIuG2IT5w8d7aAjP6Q5HOGSqYlKIEckh/htYXzdMdR2nl/wWepARg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iCDbyJfzxBMT1u/flW1HB7nZ6BT9+0w+/qca3wz6Ie8=;
 b=FHZpsGCQr+GAu3tUhxEcg/OVc7GZWPh3Kd2SHLvhXZYfd7HJlHglPHGYXX000pQvNNGgP+Mbnu5k8g+o8h1qiXZ8C0GcjsZAnnPkw6/vOob4rG5QBu4VenDHVKgr1a7c+ZyAORHHd2NCTzNsSDPPGRS7sqZ8MNFeg9jUH48U7F5iH5rvyeR0r10j3P/aWr0Nm1Paq4ubojTaKroIGsf4yh1ZX+4yqBpSvqRLHDH6JZ62GjN7BGpgcJIbd/GmbxP3RtGVvSSELE0swGrRbHgK3IhZMhJGUrvybEYn8O6aRZNiICudKsyQIZqpkRHlgYLI+esxcR68XKrBJ0MHJSMhLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by PH8PR12MB6723.namprd12.prod.outlook.com (2603:10b6:510:1ce::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.9; Fri, 5 Jun 2026
 04:16:17 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 04:16:16 +0000
From: Richard Cheng <icheng@nvidia.com>
To: dave@stgolabs.net,
	jic23@kernel.org,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	djbw@kernel.org
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	kaihengf@nvidia.com,
	kobak@nvidia.com,
	smadhavan@nvidia.com,
	vaslot@nvidia.com,
	Richard Cheng <icheng@nvidia.com>
Subject: [PATCH] cxl/pci: Fix out-of-bounds read of the RAS Header Log
Date: Fri,  5 Jun 2026 12:16:02 +0800
Message-ID: <20260605041602.37944-1-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::6) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|PH8PR12MB6723:EE_
X-MS-Office365-Filtering-Correlation-Id: d5522fdf-c299-416e-7b34-08dec2b93002
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|6133799003|11063799006|5023799004|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	QM+VFIm7LQuvXwXSbWDsFM3T5OdlSWbNmvVzWqRGBrIEBwyEN1qFr7DJJ9XPYOxngRDP/LJT+whB+wX1bsQBPCGCE+PXbzvMZFAUTx3ala9Bb3Lffu84PCAw5HpLnV5mcyyqGcwrDh/P1AfjyiOJTAwbbDtQMtrfL8Qg1VkfrizgkaNvJS6cT+shyrHNxM+UVnDYLc5VEnOmhCea7uJzhwFo5AmamYt13nGS+AlNoQPeKxITFFxu3yL371Iq4msDj9AE83RPZ5nMRJJ56WSQnMB1mmA8/m3TVeSZH7MFztpycVbcp9XJLpLQzeFvJil9Y4IJRDpEMWGRq82E1dhgl6oa7AGJz9VVVnZ5TvNllMZs7kwW3e83SyB+mI70i6/Yc4mHV7Xv71zC8WiW8voswBe6fhDD+nT1BDBD5rngdsSg5yZ0XpLxmHvNq8rY4QPMxiS1Anv8tXOWPj6Wc1Sx9TmkCemXr/PyUBAk686Th8LU1DAD+7Js/NYCdUk8t5DlqY/cumlS97aFhpsPPSobQjOar1NdmlacHg1BvN4Wyp8X1pfSw+KOS5H9omwXvTRbeYhrhtD3MOgzKbKQL19G1Kn7Z97fqUaLe2kDvL7wuHz6bPsUqJvaVY5WmU5mip1t6cRetRvFTaHwOWnB0alrI+wencg1sPVwnN/fpu9q8GOArLjRp8+BeMcxw8LqoNJz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(6133799003)(11063799006)(5023799004)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vP9SxjyuQbfD9KT2kCezUZ6hqz0qGpLud4w/6q+xjRPpD83WiLa4On3PX04n?=
 =?us-ascii?Q?i9UkzOb29ZIS2b4NTsyVzZu6JC/4J498OY6oEG3wPiIEHPY00zyKznzl5h0g?=
 =?us-ascii?Q?Im6lRdEV2d5Sto/gPPy2O6p5lqEmHZp9ojFGm3DfraAQIkgWUt/1jQny7RZw?=
 =?us-ascii?Q?3jZ8q/x0IIfhbBmv4jz6jHF9srcWSHe+qiGb8AnCLdLY80/2mvh7zmndAlTA?=
 =?us-ascii?Q?AMz1aVj8t+EbElAKjtz36qa+3XgyNX5P9O02qP8rhn6q/YzeNjumbk0cH7Nk?=
 =?us-ascii?Q?+MvZ0nd+VwGSt5ESBlpYaVX5RyFDSEv3/kkvVJD1zqt+Go2OJt2XT12hc0x2?=
 =?us-ascii?Q?JIHPd30gyFFlvCGzhc2+1Yq5ps+hHERGahl5y9o9Tu/he45qAKa124KOe2s2?=
 =?us-ascii?Q?DlBGlumMtkTJIjyEP+za+GFidNtB6CqornCAAW2ZhdEueE56ITh1ttC4dH5I?=
 =?us-ascii?Q?wc/JspxRwYvanVEJnP19XaQK/Y27sWxeLUVzSVVwRoiWIDGQJZoeEQI1eyGZ?=
 =?us-ascii?Q?gkcp/7LzayUjimbrlz3n+mOsFgtl7+pFIumScaulULqQwIgSPIgLGfT+ZzaW?=
 =?us-ascii?Q?fLAJ6c4hAG2Ck9miyYTNvscIsp/w3eKIpecp6u/U8nLR1rUMBHdr9/I4Heb4?=
 =?us-ascii?Q?R1+91EjX7tUUvUx5SIKPdFMG/6sny1A53uCd/FHR2RZJZ5N+y8hAKUlZUOlx?=
 =?us-ascii?Q?UeGeL8dUquRi4B2Yb0OE98P68Zl43JH2Li0uXZ53aFvmh7c/GHFgSWxXPesC?=
 =?us-ascii?Q?jXhAcEURz1asQ6Px3ykYKB4ITO8E+a0y/SICOS/ca0aqABa42kXmmMse2Wls?=
 =?us-ascii?Q?AkNE/DBqlcLQxkDw6SXvQyXLT1NFGjfEGtGkA0rVKKqS3SN3A66bKLsDyHSv?=
 =?us-ascii?Q?zISgdKt2XxFI7y26dBzyk8K+plZM/mYL8r6bz2BtMZQQpszI4IXNbADrViWk?=
 =?us-ascii?Q?zW1XLc72yVxhDXp+w7SJOIHNXxUsks4+HVcC2vu+m1eqEsYE+UFKct1o/XMp?=
 =?us-ascii?Q?+N7klQfL+q2gjZKg7w1F59omTp5a5synxzqZwr9TKtKxIGX1aNVOzeUW0rwU?=
 =?us-ascii?Q?XRG5fAAQZRh0DMPuT+ba14QQk5CUSOf7Ei6+O+SNDnT4Y76ei4YrsO7nt0xa?=
 =?us-ascii?Q?a7oHph5Ncha3mpveaNNQSb/paabkb+tSXp+sJSsXawJ1OCiGvKQSPulw708B?=
 =?us-ascii?Q?bRKU1HJEpu19mzwSSCvknl+sG2jk7mLU6+75aPoEhif6pMx3Fh7koDIM4/d9?=
 =?us-ascii?Q?hxtR68bfTNF6zjWis5MhDnxqUAmIo9mM1SNFJNibbM6rejbSBiSxSYaEj/8W?=
 =?us-ascii?Q?kEnfbdv5Xod1yg96R9E9C6VajY8GWlaydeXjJQTINlXQ8gAMfjGD2nuyRAb6?=
 =?us-ascii?Q?zRV0KKxKRJwGg0CM172sLXyusySKFFR42XkSpIMvW2srmLP2TIBugk9JL82f?=
 =?us-ascii?Q?K+rPCTMXCIDhggRnnLd4W4lAA22ls69nRpxJ89Gd08zsE7BpWZEFNipJXxLB?=
 =?us-ascii?Q?1K2/e9XNXc1rQUZ87vthUGh4dI4F6VX+C/ENL/DUD36rJUwxlwIQsGcaAffA?=
 =?us-ascii?Q?apYU1nzqFt3EgwIWWt4Z9njX8310TcF8OuGgT6MFuhiOlwAIPmQrHQe9eCik?=
 =?us-ascii?Q?JmzXY9hT6J/JKiuGCF7EvySwjgmNgdqwbwHKyyGrvvj7ypcSEe44y9ca2SdB?=
 =?us-ascii?Q?MZz8g05jAKXli4geaTMPwwzgPzlO9zFTz+Nybn+h18xfeKRbR8yoJG68hsaT?=
 =?us-ascii?Q?N4yt1wtZYw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5522fdf-c299-416e-7b34-08dec2b93002
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 04:16:16.6658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ya9TFsLq/naB8MgtcY78N6Pf07ymUQvyFDRfu8CyGuHux3OnAXdXzK/n9xJRhllhYKtV5zgkIZ1RWy53NStuZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6723

The CXL RAS Header Log is 64 bytes, but CXL_HEADERLOG_SIZE is SZ_512,
which is 512 bytes, not 512 bits, so the kernel treats it as 8x times
bigger.

header_log_copy() reads 448 bytes of MMIO past the register, and
cxl_*_aer_uncorrectable_error() tracepoints memcpy 512 bytes from the
64-byte header log. On the CPER path the source is a heap object, so the
copy runs 448 bytes past it and leaks kernel memory into a trace record
that userspace can read:

"""
[  297.704020] BUG: KASAN: slab-out-of-bounds in trace_event_raw_event_cxl_port_aer_uncorrectable_error+0x318/0x4b0
[  297.704032] Read of size 512 at addr ffff0000dd6ee118 by task bash/3078

[  297.704038] CPU: 116 UID: 0 PID: 3078 Comm: bash Not tainted 7.1.0-rc6+ #1 PREEMPT(full)
[  297.704041] Hardware name:  , BIOS buildbrain-gcid-sbios-45660680 Wed May 27 08:27:58 AM UTC 2026
[  297.704042] Call trace:
[  297.704043]  show_stack+0x24/0x50 (C)
[  297.704049]  dump_stack_lvl+0x80/0x140
[  297.704053]  print_report+0x100/0x630
[  297.704057]  kasan_report+0xb8/0x130
[  297.704059]  kasan_check_range+0x15c/0x240
[  297.704061]  __asan_memcpy+0x40/0xc8
[  297.704064]  trace_event_raw_event_cxl_port_aer_uncorrectable_error+0x318/0x4b0
[  297.704066]  __traceiter_cxl_port_aer_uncorrectable_error+0x90/0x108
[  297.704068]  cxl_ras_inject_set+0x278/0x3d0
[  297.704070]  simple_attr_write_xsigned.isra.0+0x198/0x298
[  297.704074]  simple_attr_write+0x44/0x88
[  297.704076]  debugfs_attr_write+0x78/0xd0
[  297.704080]  vfs_write+0x1f4/0x960
[  297.704083]  ksys_write+0x100/0x220
[  297.704085]  __arm64_sys_write+0x78/0xc8
[  297.704087]  invoke_syscall.constprop.0+0x150/0x200
[  297.704090]  do_el0_svc+0xd0/0x210
[  297.704091]  el0_svc+0x44/0x138
[  297.704095]  el0t_64_sync_handler+0xc0/0x108
[  297.704097]  el0t_64_sync+0x1b8/0x1c0

[  297.704100] Allocated by task 3078:
[  297.704102]  kasan_save_stack+0x40/0x80
[  297.704104]  kasan_save_track+0x24/0x58
[  297.704105]  kasan_save_alloc_info+0x44/0x88
[  297.704107]  __kasan_kmalloc+0x108/0x110
[  297.704108]  __kmalloc_cache_noprof+0x1bc/0x588
[  297.704111]  cxl_ras_inject_set+0xcc/0x3d0
[  297.704112]  simple_attr_write_xsigned.isra.0+0x198/0x298
[  297.704114]  simple_attr_write+0x44/0x88
[  297.704116]  debugfs_attr_write+0x78/0xd0
[  297.704117]  vfs_write+0x1f4/0x960
[  297.704119]  ksys_write+0x100/0x220
[  297.704120]  __arm64_sys_write+0x78/0xc8
[  297.704122]  invoke_syscall.constprop.0+0x150/0x200
[  297.704123]  do_el0_svc+0xd0/0x210
[  297.704124]  el0_svc+0x44/0x138
[  297.704125]  el0t_64_sync_handler+0xc0/0x108
[  297.704127]  el0t_64_sync+0x1b8/0x1c0

[  297.704129] The buggy address belongs to the object at ffff0000dd6ee100
                which belongs to the cache kmalloc-rnd-09-96 of size 96
[  297.704132] The buggy address is located 24 bytes inside of
                allocated 88-byte region [ffff0000dd6ee100, ffff0000dd6ee158)

[  297.704135] The buggy address belongs to the physical page:
[  297.704138] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x15d6e
[  297.704140] flags: 0x17fffc000000000(node=0|zone=2|lastcpupid=0x1ffff)
[  297.704143] page_type: f5(slab)
[  297.704147] raw: 017fffc000000000 ffff00008001c1c0 dead000000000100 dead000000000122
[  297.704148] raw: 0000000000000000 0000000802000200 00000000f5000000 0000000000000000
[  297.704149] page dumped because: kasan: bad access detected

[  297.704150] Memory state around the buggy address:
[  297.704151]  ffff0000dd6ee000: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  297.704152]  ffff0000dd6ee080: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  297.704153] >ffff0000dd6ee100: 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc
[  297.704154]                                                     ^
[  297.704155]  ffff0000dd6ee180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  297.704155]  ffff0000dd6ee200: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  297.704156] =================================================================
"""

Define CXL_HEADERLOG_SIZE as SZ_64. The trace record's header_log field
shrinks from 128 to 16 dwords, but only those 16 were ever real data,
the rest was always junk.

Fixes: 2f6e9c305127 ("cxl/pci: add tracepoint events for CXL RAS")
Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
 drivers/cxl/cxl.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 1297594beaec..f322d7c79ed2 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -158,8 +158,8 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
 #define CXL_RAS_CAP_CONTROL_FE_MASK GENMASK(5, 0)
 #define CXL_RAS_HEADER_LOG_OFFSET 0x18
 #define CXL_RAS_CAPABILITY_LENGTH 0x58
-#define CXL_HEADERLOG_SIZE SZ_512
-#define CXL_HEADERLOG_SIZE_U32 SZ_512 / sizeof(u32)
+#define CXL_HEADERLOG_SIZE SZ_64
+#define CXL_HEADERLOG_SIZE_U32 (CXL_HEADERLOG_SIZE / sizeof(u32))
 
 /* CXL 2.0 8.2.8.1 Device Capabilities Array Register */
 #define CXLDEV_CAP_ARRAY_OFFSET 0x0

base-commit: 6f3ed7fec72fc8979b2a8c7219c0a9fcfc8d07b5
-- 
2.43.0

