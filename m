Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012067.outbound.protection.outlook.com [40.107.200.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAC33C1F26;
	Thu, 11 Jun 2026 09:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781171161; cv=fail; b=ZfARP7upzrLSpyj66N8YLSrIavgbLdnzWqKcwC3OycxgMzHJasJgfj43qRR3zoz2svWzD2IW2o5BWrNc8bc8E83TId0PzNsB7MkEH9cx+TlPeTlRtY7RQXQy8LEq2YpHChZk/Jhz0l9KmerqzwSPTztkfkE1NDKirE9YqjruVjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781171161; c=relaxed/simple;
	bh=jBX0VaI5ZwMcp4uXyxQCS3xzgKaruvJv4mMuw4m/Wsw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=TezHKcXHbmwr/P+/E2RvVgODns39o4r75mjwt0Hojng6t5yz+7+1ZCmPmiJXmHKpO7Ao3oh4bJxTDZlARGqL9tm40Z0vgAR1TAEXhiOCCLmQPe4i0cpoQJNHTtx7wg9Pu/9h4LdPlSyimhfPLFPTYxxwi7+EF/gSY6R6kPf1++4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mxwgT7nj; arc=fail smtp.client-ip=40.107.200.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mxwgT7nj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MiefhT4r9IoFaMgiiwVP+8gN1MbNDgL89Llbzgp6yIh724H8ZqQVEcMmrZoyizBpGCxe83bI+S5gSogCHTmXWFwqLE1ulW2mTHBJ3/hgok4XQwFFxiWrQZMI6kUqackUqt9Lpggm7CJX8svleuO2oFxg47yOJflkgZgzQafcG7LDwi+dprXHs5fYBRrO4JwQMzAlw8SLArGBFbKUnEGBheJH7vECrgBS59dP/zsBPCt77Iv/5+EwE1ZAfMnz03zcf6wVYlJ7YAAaO2G47aZLtieZbJ9aJNrmT3Ww3E/6a2Y7xUWci3WvJhS8vyzAKgsHy3p1UMQi+gDCKZ2EDEEVJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DM9IFftwbcCByPUHvkr7RKMyHE4UbyPrd1O04xu09r0=;
 b=cfV+LM0CYSXZqW57uezV6TSM/eZJfKzlkssLJbx9T8N1JpwkC3+93bUVjy/nFV9PhqCoyPsl1ISAWd0MbihRASU6db6sbGDA5mg5r8h8dX3lQ1bqMsAj2dBNz+x6nUDjVipkzgdwcRTNe+LLTodqZl+a0Ulv7QX1B2BDbrROTt5YfacBME3IJXA/lPWJTsrIa0lVwlsjT0KnqID7P+XOBl1RAl2I5XF2jes/jLeCByTZi9HShTJXVwgSct/xunyZbWHfTv4TlEhkFF4J1s0ayllDjGg9026FD+P9UuPmsnyrx+GmBemx8Q6Scr6ZMBmya9FR7zuhHct6P694oM5mTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DM9IFftwbcCByPUHvkr7RKMyHE4UbyPrd1O04xu09r0=;
 b=mxwgT7njZesDNNb9EdHKJrX6YNOffCponxo+CEI5LiynaFw9Gts4il0jM7NMu7/DAN5H1g96bkPKFLdIE7DOO4C/exdUy0PePhp08+3nWEw/NBb+bROgiMOwFOR3aFm2xadhM8OsV1SyIE3CeLBNkbkFCTvnPFaIntMGtoslx5p+a73E6SKgeuk4sXGDr5p5hMomTPGvPXkyJ3fxdEnFJrBOWo/6O7D2ltJtxhdr6U11SR8y1eyfTHzjYTlGzwfZBORgbvhsdrFNeNBd3JGOMpFEMZEQ6hAcpeAM0QZ4DHezBC20jOnELz3RfmrB+sB7NgLRuvhGfxjtwir0rRguIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by DS0PR12MB9726.namprd12.prod.outlook.com (2603:10b6:8:226::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 09:45:55 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0113.013; Thu, 11 Jun 2026
 09:45:53 +0000
From: Richard Cheng <icheng@nvidia.com>
To: dave@stgolabs.net,
	jic23@kernel.org,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	djbw@kernel.org
Cc: shiju.jose@huawei.com,
	ming.li@zohomail.com,
	alucerop@amd.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	kaihengf@nvidia.com,
	kobak@nvidia.com,
	Richard Cheng <icheng@nvidia.com>
Subject: [PATCH] cxl/mbox: Bound the output payload allocation to mailbox payload size
Date: Thu, 11 Jun 2026 17:45:45 +0800
Message-ID: <20260611094546.31496-1-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0009.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:2::19) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|DS0PR12MB9726:EE_
X-MS-Office365-Filtering-Correlation-Id: 269955e4-996c-49b1-6fdd-08dec79e3a1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|23010399003|1800799024|56012099006|11063799006|5023799004|6133799003|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info:
	Ix5G/zy6/fjEWv5ymwYXTYbhv0p1TOSSvRpYpjqCmUQJKoLeBrHrK91zN2LlYVFR+JdPQYhCrPQu8rRehuOIIDrrkPmHTNF0VATxYpbkRHhS5do/V6zTZDSBLPtCgkmVr3j3+Q5JqHhX1knJbEk9PJVTm7J2Nmntrq7NojiqpqD/HLxJqnDUf9jRtdnBionXw25tvT3EqHLFBGTh+hag+QmYxeXTSoWVGQSItzBBuYIhwDnT2rzOMXJfsAFBT+4rse6ZbGblL1yJ19Wp1VqViSiERHUejmsUcqiH5CYsGinn5GyyBEFXAdzEnRxBx8weJWtZ6IifljkrobPtMbPGrY8BByxzcH8RfMMzGF8MdRuKjL9in5V56rnBYVJmEJ2TVdvLy8KqMOuHuLJkdexp2Dsegv+DBj8Nz2mHU03Mv7FkkALYtsDyIPdGoB3ESBOUZFuzNKKBxmTyQzyV/Se8mEuBRDMAg5P5ekTTkHUoG0KicdqJ4auHRaxP4geC8SX1gQ9HA8hXlsj3y4cjcyR/Le0BeUztzbEzMPrfQ/9tNhmpJggKOTilm+W4ZAUr8XXwVjT4bxpsB5cWnwEj8tQosJBFk2Y2ydcwZB0iIyxPHSGewMBWjOYTQY3WmcBcHnn5+sjUcMDVaqoxquwloT0lmwA/3mQBeVom2NisE1AZHdv+MnOw1NXG/zbuuN6sxYkB
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(56012099006)(11063799006)(5023799004)(6133799003)(3023799007)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5SCEotxkkZceBdeOeG3fZ5zxt1Y6828pXWtdT5BFvLw9BBs0SUXd9R/d1YhQ?=
 =?us-ascii?Q?B+PRKZFxKc/ncUoxuicu3Y0s/12DduhoD3uoSbmaJ2d4ygsGKsblTUAkMV5y?=
 =?us-ascii?Q?zMUTHf+qi2/2Vyrm4pLmKo/CxP6i/RKunSDcdxNNtcKQU6lDmcxnI4RB5av4?=
 =?us-ascii?Q?buwWyIkM5wBdiB02eyyGKDPdEgHCvazttDekqT5Z6ytetsDuXww+xkOShBcv?=
 =?us-ascii?Q?9ZenucOZCzJbBedcsOhcOMoz7nN9mSosVW+1COJ7itg5OP8OGMitQKz4uops?=
 =?us-ascii?Q?sRWavr9/Uy1J7gS+q6u+LYx+Lt8TMkXUJQUOeS5H85tTIXdOj80DMz4nbicv?=
 =?us-ascii?Q?K7RFDyk8X7BwyUIGRJUrC9t8VxkS+mN06etqqU4EEsXn5kdT1b/VOG0xkk86?=
 =?us-ascii?Q?OPy8IHQdgctdY2enF2qtkbgIrGRq5+pFnHq2RUw45miWVOyDypxY6qo475a+?=
 =?us-ascii?Q?yBTLIX9Ua3BhiA09rkEwBWbtxshPwAkq4qpSpv4/Wi9kICsmwT12Bzk3KkRo?=
 =?us-ascii?Q?GO7RD+MVJdoaRNSdU6UUFSlCryaR0J/jxb8svcYhrOeuljfJhhvyRM6+m10z?=
 =?us-ascii?Q?uEzs6s6c2TcYfzWaAAeNVQdXRHj5Q0CaRLrSe6mWIu/vob0EfhK8qWIpLZy7?=
 =?us-ascii?Q?SuUHkPer7OS9iJSrS99CBI5zGV6GRnRu+15X3Ia3VL171qvf1yeG74TQHOZd?=
 =?us-ascii?Q?SSqdz8bgZ5OMh6hGyGNzbG1+e9p3JLDu3V6s5ak4SofvhRL4n+E4Gjbjtje5?=
 =?us-ascii?Q?z/iHySLu5xMbEQWig+BOnXVD+kmOrC+ypbWKdiAM43c3QsqiYps3R+LXWiUe?=
 =?us-ascii?Q?7a58Yn71bN0bV+PXl5CrBAZDjhmv3cPRLqU2FE16x4egGl2InXSsuJsaDyfa?=
 =?us-ascii?Q?MmMToE8FtJmBTyHJA45mwQqha35Snu4yCiF52X1ZVkQRkC2GpF0ENw4AB3zi?=
 =?us-ascii?Q?fvESGA/iyYd3tsJzbOMhlhCBTpkpqfwwADAPZohynQ7KkTtUyUOQ+6czxw5/?=
 =?us-ascii?Q?hZNJ1c0QebUigqQms40iGO5JgyZDx62/9yd88w0R/JfvwC6gh1IaQp+2PE2u?=
 =?us-ascii?Q?gKE/XoCWLUAkyQNLG/PMvjW+xxRD62smKAq48V1bjQvy+bS6Ci7Mlp1Y2+6L?=
 =?us-ascii?Q?9n7t2Nk8k6H7+ZTzPWa9aDTprDWPO+xRl0KJgzwyslJfeDyHmRkSwkVxhZwW?=
 =?us-ascii?Q?ex3/qBW0vyo/tY+FcKo1QiaBmPZ+/BfGGQS9bK1KaqJoPFS9H1sdDn3RLGXv?=
 =?us-ascii?Q?+JBr2t1i6ZzJ15zXIu6m13qfKd71pTZGZZxgV1mn8RhpNd+m3JF4fmhl+gLn?=
 =?us-ascii?Q?UeZ98mFZV94SUskI5I9UK6R/ksIHRP3Nn6UUuMg6ZhUUnO12q4/bdc/5lWg6?=
 =?us-ascii?Q?zLJ8Ls7d616BWjpRbqNQtVcULMoA9rxmyogOjPum4+siapuz4x5qh9E9ew+C?=
 =?us-ascii?Q?CasHnBe/lphwfmBbuir/2GX0WHj3g5cxgyjoENmRpLtn4LoG4TmZ1QaN7fL0?=
 =?us-ascii?Q?G9zVmmGqA559AjcBCQ4ge0oUuKUu1fXJ+zJOHu9QTCAPywuyv4eoCmdSDo0+?=
 =?us-ascii?Q?nActL3UDASPNgSucB7yUkz8jGPn+h5frdvW6pQBy+sG9ASk6DVp+F/ETsRFq?=
 =?us-ascii?Q?qWopsyNW56WmgNgMCmSozPgFq7j2YQl6CV3iB7fzZdbA1Co0tSMMHWcxbNdP?=
 =?us-ascii?Q?3KlRJbYLlLXcEYaYTo13+YeRmrborhPe92l4DXAozGl8XC9O?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 269955e4-996c-49b1-6fdd-08dec79e3a1a
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 09:45:53.0492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yRQyRZsfcVa/Onag6tOQ4YmOSnU/xlzxu6ni1FEC6jerNAOHxbemltZhAPXmRnwdDlydCTwPCLwusTPGGPp1gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9726

CXL_MEM_SEND_COMMAND bounds the user's in.size to the mailbox payload
size but leaves out.size unbounded, then cxl_mbox_cmd_ctor() calls
kvzalloc(out.size). A large out.size drives a huge allocation, even
above INT_MAX it WARNS and taints, on kernel with panic_on_warn=1, it
will panic.
The transport __cxl_pci_mbox_send_cmd() already clamps the response copy
to min(out.size, payload_size, device len), so the bound buffer is never
written beyond payload_size. Clamp the allocation to payload_size too,
matching the RAW path.

With the following reproducer[1] , we'll get error logs [2].
[1]:
"""
        #include <fcntl.h>
        #include <stdint.h>
        #include <stdio.h>
        #include <sys/ioctl.h>

        #define CXL_MEM_SEND_COMMAND        _IOWR(0xCE, 2, struct cxl_send_comma
        #define CXL_MEM_COMMAND_ID_IDENTIFY 1

        struct cxl_send_command {
                uint32_t id, flags;
                union { struct { uint16_t opcode, rsvd; } raw; uint32_t rsvd; };
                uint32_t retval;
                struct { uint32_t size, rsvd; uint64_t payload; } in;
                struct { uint32_t size, rsvd; uint64_t payload; } out;
        };

        int main(void)
        {
                static unsigned char buf[512];
                struct cxl_send_command c = {
                        .id          = CXL_MEM_COMMAND_ID_IDENTIFY, /* any enabl
                        .out.size    = 0x80000000,                  /* > INT_MAX
                        .out.payload = (uint64_t)(uintptr_t)buf,
                };
                int fd = open("/dev/cxl/mem0", O_RDWR);

                return ioctl(fd, CXL_MEM_SEND_COMMAND, &c);
        }
"""
[2]:
  [ 3675.127839] ------------[ cut here ]------------
  [ 3675.127841] WARNING: mm/slub.c:6841 at __kvmalloc_node_noprof+0x534/0x818,
  CPU#131: cxl_repro_outsi/4668
  [ 3675.127853] Modules linked in: nft_masq nft_ct nft_reject_ipv4
  nf_reject_ipv4 nft_reject act_csum cls_u32 sch_htb nft_chain_nat nf_nat
  nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables bridge stp llc qrtr
  cfg80211 binfmt_misc nls_iso8859_1 acpi_power_meter nvidia_cspmu acpi_ipmi
  ipmi_ssif coresight_trbe ipmi_devintf sbsa_gwdt dax_hmem arm_smmuv3_pmu
  coresight arm_cspmu_module arm_spe_pmu ast nvidia_t410_cmem_latency_pmu
  nvidia_t410_c2c_pmu ipmi_msghandler cppc_cpufreq mlx5_ib macsec ib_uverbs
  mlx5_fwctl mlx5_dpll sch_fq_codel dm_multipath nvme_fabrics efi_pstore
  nfnetlink dmi_sysfs ip_tables x_tables autofs4 ib_core btrfs libblake2b raid10
  raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor
  raid6_pq raid1 raid0 linear ghash_ce gf128mul sm4_ce_gcm mlx5_core nvme
  sm4_ce_ccm nvme_core mlxfw sm4_ce tls nvme_keyring igb sm4_ce_cipher sm4
  arm_smccc_trng i2c_algo_bit nvme_auth psample i2c_tegra aes_neon_bs aes_ce_blk
  [ 3675.127894] CPU: 131 UID: 0 PID: 4668 Comm: cxl_repro_outsi Tainted: G
    W           7.1.0-rc7-cxltest #1 PREEMPT(full)
  [ 3675.127897] Tainted: [W]=WARN
  [ 3675.127898] Hardware name:  , BIOS buildbrain-gcid-sbios-45820373-12 Fri
  Jun  5 07:54:44 AM UTC 2026
  [ 3675.127899] pstate: 23400009 (nzCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
  [ 3675.127900] pc : __kvmalloc_node_noprof+0x534/0x818
  [ 3675.127902] lr : __kvmalloc_node_noprof+0x520/0x818
  [ 3675.127903] sp : ffff800102c2fb90
  [ 3675.127903] x29: ffff800102c2fbc0 x28: ffff0001911d5000 x27:
  d8eaa73777d13b74
  [ 3675.127905] x26: 0000000000000001 x25: ffffa73777d13b74 x24:
  0000000000000000
  [ 3675.127907] x23: 00000000ffffffff x22: 0000000000000dc0 x21:
  00000000000029c0
  [ 3675.127908] x20: 0000000000000000 x19: 0000000080000000 x18:
  ffff800125340040
  [ 3675.127910] x17: 0000000000000000 x16: 0000000000000000 x15:
  0000ffffd627bed8
  [ 3675.127911] x14: 0000000000000000 x13: 0000000000000000 x12:
  0000000000000000
  [ 3675.127913] x11: 0000000000000000 x10: 0000000000000000 x9 :
  0000000000000000
  [ 3675.127914] x8 : 0000000000000000 x7 : 0000000000000000 x6 :
  0000000000000000
  [ 3675.127916] x5 : 0000000000000000 x4 : 0000000000000000 x3 :
  0000000000000000
  [ 3675.127917] x2 : 0000000000000000 x1 : 0000000000000000 x0 :
  000000007fffffff
  [ 3675.127919] Call trace:
  [ 3675.127919]  __kvmalloc_node_noprof+0x534/0x818 (P)
  [ 3675.127921]  cxl_send_cmd+0x514/0x7e0
  [ 3675.127926]  cxl_memdev_ioctl+0x7c/0xe0
  [ 3675.127928]  __arm64_sys_ioctl+0x4a4/0xbc8
  [ 3675.127931]  invoke_syscall.constprop.0+0xac/0x100
  [ 3675.127934]  do_el0_svc+0x4c/0x100
  [ 3675.127935]  el0_svc+0x50/0x2b0
  [ 3675.127938]  el0t_64_sync_handler+0xc0/0x108
  [ 3675.127940]  el0t_64_sync+0x1b8/0x1c0
  [ 3675.127942] ---[ end trace 0000000000000000 ]---

Fixes: 4faf31b43468 ("cxl/mbox: Move mailbox and other non-PCI specific infrastructure to the core")
Reviewed-by: Kai-Heng Feng <kaihengf@nvidia.com>
Reviewed-by: Koba Ko <kobak@nvidia.com>
Signed-off-by: Richard Cheng <icheng@nvidia.com>
---

Maybe we should consider to put the reproducer into selftests of cxl.

Best regards,
Richard Cheng.
---
 drivers/cxl/core/mbox.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 7c6c5b7450a5..d9cb02c9f72c 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -380,11 +380,7 @@ static int cxl_mbox_cmd_ctor(struct cxl_mbox_cmd *mbox_cmd,
 		}
 	}
 
-	/* Prepare to handle a full payload for variable sized output */
-	if (out_size == CXL_VARIABLE_PAYLOAD)
-		mbox_cmd->size_out = cxl_mbox->payload_size;
-	else
-		mbox_cmd->size_out = out_size;
+	mbox_cmd->size_out = min_t(size_t, out_size, cxl_mbox->payload_size);
 
 	if (mbox_cmd->size_out) {
 		mbox_cmd->payload_out = kvzalloc(mbox_cmd->size_out, GFP_KERNEL);

base-commit: 4549871118cf616eecdd2d939f78e3b9e1dddc48
-- 
2.43.0

