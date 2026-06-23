Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012011.outbound.protection.outlook.com [40.93.195.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA71D366553;
	Tue, 23 Jun 2026 01:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782179790; cv=fail; b=uH7S6fRuiHVLAY3zFDCUxRYFpCD7FPxzG2hsXi+42HJw94nSkqxBXTjGoQsMDiDNH57QwA0SyxOHwGnjCFpfk3zyJwmT3gvE3YboG7Lf0p2i5+cgnQw/1htDYi+26x8egfKBLUks5rimiWKANOmwFY+AHdu1XNG9o9PCIBow7xQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782179790; c=relaxed/simple;
	bh=b6s/ABLVzPtGTlwdzVhF3R782D1HdoglXn6DfYbOadc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MJk/kw2/agIMnjhU6cL1/ep42kN3r+at85egMua0/MNzdUAe7E3eOq5OnBimTgfYvzvQlYZvK2MbHEq9HlYMvLIoB6ETeIwmfwFD1g9CSqyLxNjmMZlYJQ2YKDWOFdEcvj8q37oRDSHE0FYm7SXdKomzzE4ELmAoo5jiaSjKCYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aBmWk4zo; arc=fail smtp.client-ip=40.93.195.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aBmWk4zo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s4McKEdPHxZX/TsARtuwpVgFGer8D17sh/Fpl6cmvYEVsmhAgMNVU0fYOno88m4wEKYQcaS9IPb9kU9LIXMsniXwRY1n0T0+XRHoY50d6r8PfrLGFBT+AK0yK9bvFyxA6nr501gZ8ClviB7U3SU7fKr/PtQDiX0gmli5/CjF++ToTxCVIryWWG2n+wvdEtDfeIid7jwRKtoashWUs8QTCHI0FN39DJPwbrCut2bDrzSsp1JLIsMEuqr7m5/94FudHdOuFRDzmjWDYhAwzLoYC7mf2z3N7SMQs0Zq9sGPgkDa3phyBcKv/UKkJ3S2c4PFoiV95chA1uZUC+X7OXpwdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jHRVXgQq21Db9HInx4qcYFKlCNynht0B02VPcoKMwAE=;
 b=YPRPFJjtye/rMr0RjrGpIF98RyKxs2Bm3TrEwmDu2pH7c3DDrMK0v54VMA5mqCXxjZWIJq/caRFFxP2IK2zIhrO7DW7UzDoHZ0gz9xJGeI1tYF4lLOvFvfzsqp5pgYbc3mq2Ltt7ujVS5Y2UdYk/aaTrmBET+ETX8fiFvmDUE0XIWRI+ursgi2Kxf2Ht4X0viWsYp98vrXMcp3jxZQnKsdqJpDT7u6c74E9lRI3kAU2sDHuKytROmy0XAd1fu0Uk1phKkKM1ES7wxtNft8QRhTPJoNMGf/FIgej27o2h7eGFsB4A5UZU0AO9/DFKtlBIUa/xxcDuaex+gAyD80s29g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jHRVXgQq21Db9HInx4qcYFKlCNynht0B02VPcoKMwAE=;
 b=aBmWk4zoYljVb+shKRcG3VlWhHxmnwt/7Ko9sOYBJJIg0vihiDdeAhpZKOVBqD0KzP9+qejpnp7CD4HnxgpTgKfx0rxXbfGI/XclvoOiECBi/l56fJwnetSBFOICNaIJGpp9praqlLff6eD5YrBsxEzJfQwkAV5xxQ6Hgd4kgNDw1xkTxoOcZpt5NoRvp/Ua2aF2sCxx70r0G2Hhj2a0JbaDUPft2o6X7f/6j9YHSua/hf+XVSm1DCKAD1rohkp3i6Zj7/Wa2jgAulrZm3uSEFeUNdUZZ+Ujw79oGS0SriQDQ3i+w30kLDQzvM5Atkd3rwEYGL0X8I0NWpdsrL1AmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by SA5PPF634736581.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8cd) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 01:56:23 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0139.009; Tue, 23 Jun 2026
 01:56:23 +0000
Date: Tue, 23 Jun 2026 09:56:17 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: dave@stgolabs.net, jic23@kernel.org, alison.schofield@intel.com, 
	vishal.l.verma@intel.com, ira.weiny@intel.com, djbw@kernel.org, shiju.jose@huawei.com, 
	ming.li@zohomail.com, alucerop@amd.com, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org, newtonl@nvidia.com, kristinc@nvidia.com, kaihengf@nvidia.com, 
	kobak@nvidia.com
Subject: Re: [PATCH] cxl/mbox: Bound the output payload allocation to mailbox
 payload size
Message-ID: <ajnncMv0ziztQU_r@MWDK4CY14F>
References: <20260611094546.31496-1-icheng@nvidia.com>
 <2ced93f1-9a64-4f61-a831-1ca3018aa3c9@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ced93f1-9a64-4f61-a831-1ca3018aa3c9@intel.com>
X-ClientProxiedBy: TPYP295CA0015.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:9::10) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|SA5PPF634736581:EE_
X-MS-Office365-Filtering-Correlation-Id: f97095c8-ca1e-4e57-fe44-08ded0caa04d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|7416014|18002099003|22082099003|4143699003|11063799006|5023799004|56012099006|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	6NBSNv5KlVkbkS0ymcdkIMJJ2ncId/k1p+r524BBxGI7OEjcYLY18LAst6qit3wQ6pDgt6FJz4xDIfYPDK0gfufFTBvWeL3TzWOY1fdgMvKWNQhpE0c/vD2TpxwzgDCiNLq4/PQJCdyG/k62GpbeKZOYJgGa7T4kCQquKGks0H+9jRrT+YBCm+qlIT5iD73+vxur50qoriEAT+unbc8Pz8i4gK546fT0TI73C92LXjuFwOHGm0o09NSGN296CHbK/PSFY9sTf1oyRHmdAB5Y8rkHtp6ibIUQuP3qB9bumX+6EcICF9G6WtCsNTeqpUyee5IpbsijLC2bHHpDjgtm+u6/po+Ni2AqwJig8ddWaYZF5Efsmby7l1wHfkwFzRumGr6QLp2Lo0Ye1e4H9Or/DV80rthyLlVbTKKMCJhncV9RtHpYJYHUnAH2Bfc+11JDLjdv2N0OV2nhMJGkW/TZKZ65ZgxbxYKT0CS3OEPDE+m0UeXwEaNeabNHJw5uCm4fTOi2iSY6/GuLzS1FL7SYjxJ59KwQaEh9a7IGveqU30A5RP78XKsD0kLYASmpsVq0YngDbcKnb4G52Icv8DtXx/Xee9TOGwP5d9cimWtxJfYdOJlRlFHp6Ke0qGLqX/hysOkSTx8lzeiQy3XJ2fkmub6S99HWnVvpnf5O4Mzx7x4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(7416014)(18002099003)(22082099003)(4143699003)(11063799006)(5023799004)(56012099006)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?viKS1dDs1n+RhHvld+SqzQqmmQmyIWUJuMMT7W9ysVLa9GvZONc3WCKfct5K?=
 =?us-ascii?Q?CrP7O07yCyhg8SdGpJEunEUcgAmwSjmIiAA1HD7n0WEVgFa81H/nl6CmV015?=
 =?us-ascii?Q?azHLmjj/pgHzscE/Zx9wyNu9jipCs2i1lnHqYaHltx9MS4AEwKzpF8L4Hbz0?=
 =?us-ascii?Q?E6jES6AYfVG5fqG4+8zWKQl2S04WPdYBdRCj85u4Vu1Wk4/VyIgcSx3Bo/G9?=
 =?us-ascii?Q?9pPPXZ6qIJedXlonUkj645oIlMGTbmUlT2y3qrULckf8u0vDR5K8km4AZuiJ?=
 =?us-ascii?Q?fg7UTIhGGg+64PNXx6bOXWX4ogQohOupwCgKbdHgxe5a7V0j334sAPz8lq4M?=
 =?us-ascii?Q?YEnaiZ0clt5Ws5/SXN33jqzNZ0doiexwDZQZ+06mdpGYe6kXDKhsf4m4wJB5?=
 =?us-ascii?Q?DPlVugWqMl2cTBqZI9iv9okIsxS2nxeROBS5OpK2wxRW86z4h5vmq1lEbp/S?=
 =?us-ascii?Q?SfwRhSivH1FcteIZEuWm8ljsZV0hN3AVFOeVKRQBoETMcbFASNwpoERvjm1R?=
 =?us-ascii?Q?t9C8JBJcp8LHLSOtG3AjGAhZ9FhT9ho+211U6gBZXM24PTibyNIUx4DffB4O?=
 =?us-ascii?Q?kp24UwKW4C0leLO4jw6cONMiKc0KKF8MO7F1CRREA7w73MQWDbNXWHTZMGh5?=
 =?us-ascii?Q?BAmd2rojCaz/ptXQYE+pCdctYiLjRoJGg+9HnkScI6snzTkQP6hf+k+N5RCz?=
 =?us-ascii?Q?TeNkEBEa1hFBUuHv5ohSv98AqujrCWMJixl0Sqiw6XyswUPr/5N2vsRS7tMJ?=
 =?us-ascii?Q?yNvIRbLiBLyvsMP7AW1IcSTF31ICZYpO2uBJzWbtkOEBPW/ylvzYUAoz1U7+?=
 =?us-ascii?Q?X+oS/LntGIQdlCx1g20i/iOBhSnMxYdvIHf8yMLI+145HC1SgHFsg3lFxo51?=
 =?us-ascii?Q?GDG3KC+CwH013TnpBnuAMo5WNdtL0aBOHxmTQNUVIR2ReftbwmzlEDyoTDSe?=
 =?us-ascii?Q?N1ep7lNz4bfuUH8tuLnaNk/rgA8WW5FWG3QpOXiLJ3t2BkHzVytCLRPnaiPs?=
 =?us-ascii?Q?2Ei1N9Fy6jvg89k8/t2UPv9JHWCl51nXH7e5s1e2TJ0f72yWs9FkCLwpiJAt?=
 =?us-ascii?Q?eaTiOcMbm9aVxHCy98iPbCkLN8kgZ7thPT068vFBSKTCIYMd/HcQ5+9A3lQH?=
 =?us-ascii?Q?su4/Pr2PLwZHY6KIVFFGJ2FSZaY1Dn0zJ9J0e4gta8uI9K13QNfv71ULxU9U?=
 =?us-ascii?Q?RtjZTUb9BuH797lxCisqgr5eGknU80BaHkzcFN2Qm1YgKwGINANopyWRDdmI?=
 =?us-ascii?Q?6DS4Br1AZSKfVhm6ijFJrrXuEHYMx76PO6ALfLSbBKfL/UchtQlqorSyJ4k2?=
 =?us-ascii?Q?2rFGNeCXNhUWKJ1GisIprlS8LfCBCysGTP4W8ZeyHTHKRxAUEbxvOFNpDQLg?=
 =?us-ascii?Q?mAalqgGKfWKcNugdcbgU2X6ka6ZEYLxi8nEkQgImA7ogOfOzK5IeFeAdhFl0?=
 =?us-ascii?Q?PK03lK/heuxplHD3J97Vdk3N1Rw8tLNJtmCPHb0/7UkN5rUnF3p34LxPvmIE?=
 =?us-ascii?Q?6fdHH0qUGoyn5eEm7V0bKYf7gfK3MSzAsLz8NoSAYehRM/JG9FCJs5V+ng2C?=
 =?us-ascii?Q?Q4wwVoehaz+4TF/6mhlQKz8ARRGMJXAJGojPIrZNlDxyHUOatfWfHiKgf2MV?=
 =?us-ascii?Q?SfPMXMDesgw8XK8kjA3hgpy36iP3A1V2thUiaQDjdk4zQ96JzgPgOX4bdmEV?=
 =?us-ascii?Q?gUAtLo9yZ2LR7D6/fVJ0nZhvtwmPjgZ2MdXvH0FBUH7VGy68Xt3x3jRJ5SlP?=
 =?us-ascii?Q?p78J4Dg5hw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f97095c8-ca1e-4e57-fe44-08ded0caa04d
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 01:56:23.0985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G+LivqHV3Hj4GJE3InM/Hxk6Ac88a2DcfKXBFsRnqS0wIu0aWuvk6m1guCgzEigDwCW7e3FZA7W1cYJcbahDMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF634736581

On Thu, Jun 11, 2026 at 08:30:06AM +0800, Dave Jiang wrote:
> 
> 
> On 6/11/26 2:45 AM, Richard Cheng wrote:
> > CXL_MEM_SEND_COMMAND bounds the user's in.size to the mailbox payload
> > size but leaves out.size unbounded, then cxl_mbox_cmd_ctor() calls
> > kvzalloc(out.size). A large out.size drives a huge allocation, even
> > above INT_MAX it WARNS and taints, on kernel with panic_on_warn=1, it
> > will panic.
> > The transport __cxl_pci_mbox_send_cmd() already clamps the response copy
> > to min(out.size, payload_size, device len), so the bound buffer is never
> > written beyond payload_size. Clamp the allocation to payload_size too,
> > matching the RAW path.
> > 
> > With the following reproducer[1] , we'll get error logs [2].
> > [1]:
> > """
> >         #include <fcntl.h>
> >         #include <stdint.h>
> >         #include <stdio.h>
> >         #include <sys/ioctl.h>
> > 
> >         #define CXL_MEM_SEND_COMMAND        _IOWR(0xCE, 2, struct cxl_send_comma
> >         #define CXL_MEM_COMMAND_ID_IDENTIFY 1
> > 
> >         struct cxl_send_command {
> >                 uint32_t id, flags;
> >                 union { struct { uint16_t opcode, rsvd; } raw; uint32_t rsvd; };
> >                 uint32_t retval;
> >                 struct { uint32_t size, rsvd; uint64_t payload; } in;
> >                 struct { uint32_t size, rsvd; uint64_t payload; } out;
> >         };
> > 
> >         int main(void)
> >         {
> >                 static unsigned char buf[512];
> >                 struct cxl_send_command c = {
> >                         .id          = CXL_MEM_COMMAND_ID_IDENTIFY, /* any enabl
> >                         .out.size    = 0x80000000,                  /* > INT_MAX
> >                         .out.payload = (uint64_t)(uintptr_t)buf,
> >                 };
> >                 int fd = open("/dev/cxl/mem0", O_RDWR);
> > 
> >                 return ioctl(fd, CXL_MEM_SEND_COMMAND, &c);
> >         }
> > """
> > [2]:
> >   [ 3675.127839] ------------[ cut here ]------------
> >   [ 3675.127841] WARNING: mm/slub.c:6841 at __kvmalloc_node_noprof+0x534/0x818,
> >   CPU#131: cxl_repro_outsi/4668
> >   [ 3675.127853] Modules linked in: nft_masq nft_ct nft_reject_ipv4
> >   nf_reject_ipv4 nft_reject act_csum cls_u32 sch_htb nft_chain_nat nf_nat
> >   nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables bridge stp llc qrtr
> >   cfg80211 binfmt_misc nls_iso8859_1 acpi_power_meter nvidia_cspmu acpi_ipmi
> >   ipmi_ssif coresight_trbe ipmi_devintf sbsa_gwdt dax_hmem arm_smmuv3_pmu
> >   coresight arm_cspmu_module arm_spe_pmu ast nvidia_t410_cmem_latency_pmu
> >   nvidia_t410_c2c_pmu ipmi_msghandler cppc_cpufreq mlx5_ib macsec ib_uverbs
> >   mlx5_fwctl mlx5_dpll sch_fq_codel dm_multipath nvme_fabrics efi_pstore
> >   nfnetlink dmi_sysfs ip_tables x_tables autofs4 ib_core btrfs libblake2b raid10
> >   raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor
> >   raid6_pq raid1 raid0 linear ghash_ce gf128mul sm4_ce_gcm mlx5_core nvme
> >   sm4_ce_ccm nvme_core mlxfw sm4_ce tls nvme_keyring igb sm4_ce_cipher sm4
> >   arm_smccc_trng i2c_algo_bit nvme_auth psample i2c_tegra aes_neon_bs aes_ce_blk
> >   [ 3675.127894] CPU: 131 UID: 0 PID: 4668 Comm: cxl_repro_outsi Tainted: G
> >     W           7.1.0-rc7-cxltest #1 PREEMPT(full)
> >   [ 3675.127897] Tainted: [W]=WARN
> >   [ 3675.127898] Hardware name:  , BIOS buildbrain-gcid-sbios-45820373-12 Fri
> >   Jun  5 07:54:44 AM UTC 2026
> >   [ 3675.127899] pstate: 23400009 (nzCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
> >   [ 3675.127900] pc : __kvmalloc_node_noprof+0x534/0x818
> >   [ 3675.127902] lr : __kvmalloc_node_noprof+0x520/0x818
> >   [ 3675.127903] sp : ffff800102c2fb90
> >   [ 3675.127903] x29: ffff800102c2fbc0 x28: ffff0001911d5000 x27:
> >   d8eaa73777d13b74
> >   [ 3675.127905] x26: 0000000000000001 x25: ffffa73777d13b74 x24:
> >   0000000000000000
> >   [ 3675.127907] x23: 00000000ffffffff x22: 0000000000000dc0 x21:
> >   00000000000029c0
> >   [ 3675.127908] x20: 0000000000000000 x19: 0000000080000000 x18:
> >   ffff800125340040
> >   [ 3675.127910] x17: 0000000000000000 x16: 0000000000000000 x15:
> >   0000ffffd627bed8
> >   [ 3675.127911] x14: 0000000000000000 x13: 0000000000000000 x12:
> >   0000000000000000
> >   [ 3675.127913] x11: 0000000000000000 x10: 0000000000000000 x9 :
> >   0000000000000000
> >   [ 3675.127914] x8 : 0000000000000000 x7 : 0000000000000000 x6 :
> >   0000000000000000
> >   [ 3675.127916] x5 : 0000000000000000 x4 : 0000000000000000 x3 :
> >   0000000000000000
> >   [ 3675.127917] x2 : 0000000000000000 x1 : 0000000000000000 x0 :
> >   000000007fffffff
> >   [ 3675.127919] Call trace:
> >   [ 3675.127919]  __kvmalloc_node_noprof+0x534/0x818 (P)
> >   [ 3675.127921]  cxl_send_cmd+0x514/0x7e0
> >   [ 3675.127926]  cxl_memdev_ioctl+0x7c/0xe0
> >   [ 3675.127928]  __arm64_sys_ioctl+0x4a4/0xbc8
> >   [ 3675.127931]  invoke_syscall.constprop.0+0xac/0x100
> >   [ 3675.127934]  do_el0_svc+0x4c/0x100
> >   [ 3675.127935]  el0_svc+0x50/0x2b0
> >   [ 3675.127938]  el0t_64_sync_handler+0xc0/0x108
> >   [ 3675.127940]  el0t_64_sync+0x1b8/0x1c0
> >   [ 3675.127942] ---[ end trace 0000000000000000 ]---
> > 
> > Fixes: 4faf31b43468 ("cxl/mbox: Move mailbox and other non-PCI specific infrastructure to the core")
> > Reviewed-by: Kai-Heng Feng <kaihengf@nvidia.com>
> > Reviewed-by: Koba Ko <kobak@nvidia.com>
> > Signed-off-by: Richard Cheng <icheng@nvidia.com>
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> 
> > ---
> > 
> > Maybe we should consider to put the reproducer into selftests of cxl.
> 
> Good idea :) 
>

Same question as I mentioned in cxl/features patch,
personally I would prefer ndctl patch.

What do you think?

Best regards,
Richard Cheng.

 
> > 
> > Best regards,
> > Richard Cheng.
> > ---
> >  drivers/cxl/core/mbox.c | 6 +-----
> >  1 file changed, 1 insertion(+), 5 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > index 7c6c5b7450a5..d9cb02c9f72c 100644
> > --- a/drivers/cxl/core/mbox.c
> > +++ b/drivers/cxl/core/mbox.c
> > @@ -380,11 +380,7 @@ static int cxl_mbox_cmd_ctor(struct cxl_mbox_cmd *mbox_cmd,
> >  		}
> >  	}
> >  
> > -	/* Prepare to handle a full payload for variable sized output */
> > -	if (out_size == CXL_VARIABLE_PAYLOAD)
> > -		mbox_cmd->size_out = cxl_mbox->payload_size;
> > -	else
> > -		mbox_cmd->size_out = out_size;
> > +	mbox_cmd->size_out = min_t(size_t, out_size, cxl_mbox->payload_size);
> >  
> >  	if (mbox_cmd->size_out) {
> >  		mbox_cmd->payload_out = kvzalloc(mbox_cmd->size_out, GFP_KERNEL);
> > 
> > base-commit: 4549871118cf616eecdd2d939f78e3b9e1dddc48
> 
