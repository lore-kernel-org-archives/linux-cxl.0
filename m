Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010059.outbound.protection.outlook.com [52.101.201.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89BB3644D4;
	Mon, 22 Jun 2026 10:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782123192; cv=fail; b=K7HVvPuMPueKt3hVGXJpWJcIfwNHybhtBTeEPKw7ASqNwr6GjvKlQB68Al/vdcu3TDCsiwXGyungVHuUcdmCslUb5LIvKevd7kXg6BONwQT9WMxqNthQ3ivXooXXNR3/AMwx3A0rfTxO3IDb0Q+z+ihjBoW3V32wOBPKX1m+Kr0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782123192; c=relaxed/simple;
	bh=zX/l7mNiFYyGJVQCl5bYiy6qEajIfhaLGiojDsbRl3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XufYsyJUA8AixatZEwNH2SQ4+khscDAF0rkPDjHHDWGirAK6SPDtL4DF7oQWcjuwAWf3zyVP5GZUFtE1F2EtRPPNXbOInotm0afN03b4/kGR1zpApfQS/vuu1ClMB996QNyQo1ILCOM+8yhKFk3SaE8c282LS1hV7P3qz9vVTD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VWBG2p9y; arc=fail smtp.client-ip=52.101.201.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VWBG2p9y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xjPiabNSfxSL753vCQvJMIWxFy0C6ujAlbutpyRtobqpENQZVb3IpR7QDiV/VNMlTa29hrt35G6B6x5CeYDpTu4ATO5tIAFMaHIXM8rZbDxwqQcH+4xog2KVNGUb+d/SoPtgBy6m92v7IuPCUyQcvtj7gKKXcOmYg7CJ7iF098v6PZhVw/6eIuFwbTWXfFSaTkXffZTRG0ODy3Jdb3mtS14eLOtnM/grVDYuiwVAMhmuipKm+IrzHZ2OreHpsXxoNbEm2EPzD7eljPAG75VFowAfw0bMEiBUnd50oWAA5CN0frU+Vw5ziWC9d1Mv5YgRQkus9q13F3RH5Xem69AsPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z1dmVLk1YP51IKyHc2AQWHNY+vfvMZQ5iXSRAiqWGxM=;
 b=dH9Moo/x+l2scOdNVHhzuee+TktWD3n81FnShWx+KF69hYi/a7ix9QjTmazwKmF108l5U8T57VyGsvs5olc5KrjEJDaGhBWlS+0yxeqXK3+pOCnr5yftdM3tah/YlrPlCUkGcPhCE2asydvuDaHC21Or1wRZiBAf+Z/iMmQ3TXhq93isff+BiLICZZkxFssfsv57PYN6EcjXQnY3PiWgCfWJPGtt2Y3cgUMy2hOkkkd7sMOpRap2jl1ttUltfGhGhTwqGCXJlhkRQ1J1fIBvtxqc21RdBSKUYUw8gc4KyVCChrJIvzb1uccf2B4CvU0HMeRYt5q2x9hrMp7srDGA5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z1dmVLk1YP51IKyHc2AQWHNY+vfvMZQ5iXSRAiqWGxM=;
 b=VWBG2p9yt8dzbh01mSissc2KLsBgXGIQInW1lTEBxA2jv+tlccJgenEpgs5UHhZoHwG4kdXoy9YplCH/wGXp13vntvQkPWy9BxUXSJ4a5n8b5DYbbkHDiXyq/3iB72462vkpGt0bdcaaAMtJFR8vG7axbsHYdVOjVA7PP62/7xEhVYJqPkbWXUz0ulurnt7vLFtRtpNaO07GnBYx8p/1zWmPCh36qGqZQ4O2LIW0TujINJ4P9i7jD/9FubHQCYsyMsKI6Auwjh6MdT3U7knUDmasln+JPJi9FMTeiTvCTim0T5pvrh8RGJ2ikGkApeDmq6GGsZH+aKGxPy+Wg0KjMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by MN0PR12MB6103.namprd12.prod.outlook.com (2603:10b6:208:3c9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Mon, 22 Jun
 2026 10:13:07 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0139.009; Mon, 22 Jun 2026
 10:13:06 +0000
Date: Mon, 22 Jun 2026 18:13:00 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: jic23@kernel.org, dave.jiang@intel.com, alison.schofield@intel.com, 
	vishal.l.verma@intel.com, ira.weiny@intel.com, djbw@kernel.org, shiju.jose@huawei.com, 
	ming.li@zohomail.com, alucerop@amd.com, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org, newtonl@nvidia.com, kristinc@nvidia.com, kaihengf@nvidia.com, 
	kobak@nvidia.com
Subject: Re: [PATCH] cxl/mbox: Bound the output payload allocation to mailbox
 payload size
Message-ID: <ajkKfx9mCtTP7ae9@MWDK4CY14F>
References: <20260611094546.31496-1-icheng@nvidia.com>
 <20260617210745.55uzogugkcjbosp7@offworld>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617210745.55uzogugkcjbosp7@offworld>
X-ClientProxiedBy: TPYP295CA0053.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:8::10) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|MN0PR12MB6103:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ae81d1d-4f63-4af4-9437-08ded046da1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|4143699003|56012099006|11063799006|5023799004|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	XiP7KMMTtAxUKN6jTyMeS2ejRs9f93kbq6OD14hxghCGTddgv1J/ZdL4Zlm+StOaOkSl4Vehfuu5M/w/UkdponXybPMz7/3s2mD8FKN/OMv5eULMa48t8Au4GszGUt5CeW2IXzoIAEgWVvwdKdWrwkIdNTyC6UVBR5KC+oxIaco07vtY6xfAQwFBYyV+npLiGdIyCOA34e+gYo5bqfhhQPebufW376gKNFm85UVe1SE346EuKi45KC6ggIMQMBMgijD24NsffXjoDVOq/FJKh7C26DJcBygdoPCzFeVarT64dNcHa1keahw+UvL0YICzfQXpmya+MH8i6g4IDJqg3E11OCKsyYFPZk62xJyrcQ7W5PeDbYnfXxRMBYvoOXR3G7b6zv4dp/IQmPNF6eOwxDmfUWpUnuWQ7Ke1q+efskWwUj6E0lFK4rfDy10/TXPrFBFXKZ4TeIxdA7oOVZSyxrJkh473FCU61LCmHpIJeBj6PY8K9pVuyqTpmgEN1m3GME9VfXcuKWfmp59Sd3BOnsIcBKrSmmTHwwOyaGmtz9c/pJSmyO+st1WtIxzF9PsqMn3eiDApvufZEg1ts/ObHS/blv54O9LPjisChaTzKFzYd1YUnna3svoy56Ywz2+xDh7YNvpJgQd1CzMy390JFyiT22eR8dd3BciFHX6aKGU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(4143699003)(56012099006)(11063799006)(5023799004)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eQt1lyDypRaMDvI1AarVlHK4fvUvI/jciKx1d8T3KSLiG5z+qkWl7xblCJf8?=
 =?us-ascii?Q?EVaG9nE15dr/prxVFbOjncLOu42AlKVnCfoL9Ddx27CufjjtO0f7Qcv4wDLN?=
 =?us-ascii?Q?TimniZM8zrVt330YYXvuoW5VsIt/c0CA5uFIHk44nBVd/wvowj55Enh4c40S?=
 =?us-ascii?Q?w5ZcESn0Ozu8GWrhKsrbAbCRt3NekeU7eTdHe9PY9f2m6WJW1hBW4EbSe95k?=
 =?us-ascii?Q?VIVz9Ml04/Grtx1r+xQD29OiEGWF3OJBDAT7jaenuBTVHeHfA223RLzcPLL1?=
 =?us-ascii?Q?itDSALoYXj85V6eJXOQG2ap8zBOKWvYge3oULC06BnBJ5QBaryv/WPuT7g9B?=
 =?us-ascii?Q?9E4wpsTRyNRTYi2pQwuT2LkFugImhRj71Eheiry+uz3l/HDaqC9XYciJ1wpP?=
 =?us-ascii?Q?BSs+smOi9Soyn157dq/7zZaq4wrxQQzX1qacsS+hk0RzjCsoKA0dcm+qnfLY?=
 =?us-ascii?Q?rF7y1umdpklp2LptqOA6EEAuDeaRyw2IEiGj9RA4BQs03fLnuWgFx4d6Xn10?=
 =?us-ascii?Q?qG3xJG3bUUlO+X+o9whhBg6M9NOS5ZQ7FTPvn+FZh9dBU9m/T8inZE7AZQat?=
 =?us-ascii?Q?qDHlY4rKMvTuLkTFSTM55sMNj9q3MrQQ9LCdGOQmFwuKeHGybWFSZXzuUJ/u?=
 =?us-ascii?Q?OTzsvKxbpyB3WaVVesXWJJZOCp5d8UP8TL0Mo+0Z1tVzK25cCzCMs5u3Kund?=
 =?us-ascii?Q?kitBaSHX490Tpw12NWc6pBJzCgxSgymQaob6P4T7SToDKdO6suBbFTPpplla?=
 =?us-ascii?Q?j7YV4NDvz95KLnp88soPAzEhKLJa4PwpTfdfe0z7BQehkKETcSmzpde8NL8l?=
 =?us-ascii?Q?HkOkSeiF3qCNIA/q7P0kxmpwpcRo7IeaU2HX9hGs5Lilita7vRvjGBba8nSo?=
 =?us-ascii?Q?xk7Ipq1y9+5VDw8GKP+n1+z7YAXHAi4QLq/xRX/oEuqNCmwmSh8p4tPyFrzj?=
 =?us-ascii?Q?+66ZPPilYvZC8mxlwuC1hcMKbjxaC9JD+azvAi3thUoP9QzFQoBT+clZz7j3?=
 =?us-ascii?Q?r160p4bWnHN/AS6nqwL6Sb7iOLz/lq8M3Ys8g/3YTnO3fDE3irHJJT7rShYM?=
 =?us-ascii?Q?eMWJjg9CYdSr8rfybyGJtowi87YsgCmvW3ubvNAKMyiPvCLCTuttSVB0BFWV?=
 =?us-ascii?Q?ODTVQtWkpoBLE0xmKtm2QW8BELbsyxm1s+OMcSeuA1K29XYZ8Os7K9RStJGQ?=
 =?us-ascii?Q?CYe5PW87B6HQqAu+i+Osur8LNe+21jEp6NX0fwMYL91G64xt3zfXYbuElqCQ?=
 =?us-ascii?Q?7PMTT0YQASbEVSOuTP9GsjuNf7ufcsdFd0gmM1+tNaTk4C7fqDicB9XYm4un?=
 =?us-ascii?Q?W+9pz+nJecNtY1M1LIWFw/GaO2O1SVRnE046F+IQA1d5T9fWWZHv/DmuDyY4?=
 =?us-ascii?Q?ZVGHcIN/OnyMvzI6X7M8d1Q5Zt2uC5Bz1W75HiJvSH/f9niHstNkRw3gULsE?=
 =?us-ascii?Q?WEfgesqKRgcmvcfbjB6ziFsFkcLo8vOr+1oMQ7w5H1IWFRAAuevRng7E2/B7?=
 =?us-ascii?Q?YJCdcZA4D2z0Qagje7PGhRrO+D0gy4FV+JuQgNjtbcDPdGoyiYJICEbN7Q8v?=
 =?us-ascii?Q?FJPDbeC6qyzLgRcgyIHA6cbMWyXCjH8KVhQiSYrK2xrV4VJT9RocT8ab84T+?=
 =?us-ascii?Q?DRrFGAqxeO6Dd37Me5rVU+0TdUeukGoyDI9QNGrSGh3YJIvz+i3AEnr5o7sg?=
 =?us-ascii?Q?CcQUmP1/MORGzUUiPi3Vzubryohh6oxe9jzUCO+3vGHESx666O+l8yJmKBVx?=
 =?us-ascii?Q?McCQbUtUTg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ae81d1d-4f63-4af4-9437-08ded046da1f
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 10:13:06.4219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Mx1iWucweLfi5WufwSxrW1/f6ZMvTtDeEEMVfrzcC7XP66xy/gVYzkTfe7WJL9Aa5t9MN8YR11dp3YwN+DaHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6103

On Wed, Jun 17, 2026 at 02:07:45PM +0800, Davidlohr Bueso wrote:
> On Thu, 11 Jun 2026, Richard Cheng wrote:
> 
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
> >        #include <fcntl.h>
> >        #include <stdint.h>
> >        #include <stdio.h>
> >        #include <sys/ioctl.h>
> > 
> >        #define CXL_MEM_SEND_COMMAND        _IOWR(0xCE, 2, struct cxl_send_comma
> >        #define CXL_MEM_COMMAND_ID_IDENTIFY 1
> > 
> >        struct cxl_send_command {
> >                uint32_t id, flags;
> >                union { struct { uint16_t opcode, rsvd; } raw; uint32_t rsvd; };
> >                uint32_t retval;
> >                struct { uint32_t size, rsvd; uint64_t payload; } in;
> >                struct { uint32_t size, rsvd; uint64_t payload; } out;
> >        };
> > 
> >        int main(void)
> >        {
> >                static unsigned char buf[512];
> >                struct cxl_send_command c = {
> >                        .id          = CXL_MEM_COMMAND_ID_IDENTIFY, /* any enabl
> >                        .out.size    = 0x80000000,                  /* > INT_MAX
> >                        .out.payload = (uint64_t)(uintptr_t)buf,
> >                };
> >                int fd = open("/dev/cxl/mem0", O_RDWR);
> > 
> >                return ioctl(fd, CXL_MEM_SEND_COMMAND, &c);
> >        }
> 
> Nit: Maybe not needed in the changelog.
>

Thanks, will remove them in v2.
 
> > """
> > [2]:
> >  [ 3675.127839] ------------[ cut here ]------------
> >  [ 3675.127841] WARNING: mm/slub.c:6841 at __kvmalloc_node_noprof+0x534/0x818,
> >  CPU#131: cxl_repro_outsi/4668
> >  [ 3675.127853] Modules linked in: nft_masq nft_ct nft_reject_ipv4
> >  nf_reject_ipv4 nft_reject act_csum cls_u32 sch_htb nft_chain_nat nf_nat
> >  nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables bridge stp llc qrtr
> >  cfg80211 binfmt_misc nls_iso8859_1 acpi_power_meter nvidia_cspmu acpi_ipmi
> >  ipmi_ssif coresight_trbe ipmi_devintf sbsa_gwdt dax_hmem arm_smmuv3_pmu
> >  coresight arm_cspmu_module arm_spe_pmu ast nvidia_t410_cmem_latency_pmu
> >  nvidia_t410_c2c_pmu ipmi_msghandler cppc_cpufreq mlx5_ib macsec ib_uverbs
> >  mlx5_fwctl mlx5_dpll sch_fq_codel dm_multipath nvme_fabrics efi_pstore
> >  nfnetlink dmi_sysfs ip_tables x_tables autofs4 ib_core btrfs libblake2b raid10
> >  raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor
> >  raid6_pq raid1 raid0 linear ghash_ce gf128mul sm4_ce_gcm mlx5_core nvme
> >  sm4_ce_ccm nvme_core mlxfw sm4_ce tls nvme_keyring igb sm4_ce_cipher sm4
> >  arm_smccc_trng i2c_algo_bit nvme_auth psample i2c_tegra aes_neon_bs aes_ce_blk
> >  [ 3675.127894] CPU: 131 UID: 0 PID: 4668 Comm: cxl_repro_outsi Tainted: G
> >    W           7.1.0-rc7-cxltest #1 PREEMPT(full)
> >  [ 3675.127897] Tainted: [W]=WARN
> >  [ 3675.127898] Hardware name:  , BIOS buildbrain-gcid-sbios-45820373-12 Fri
> >  Jun  5 07:54:44 AM UTC 2026
> >  [ 3675.127899] pstate: 23400009 (nzCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
> >  [ 3675.127900] pc : __kvmalloc_node_noprof+0x534/0x818
> >  [ 3675.127902] lr : __kvmalloc_node_noprof+0x520/0x818
> >  [ 3675.127903] sp : ffff800102c2fb90
> >  [ 3675.127903] x29: ffff800102c2fbc0 x28: ffff0001911d5000 x27:
> >  d8eaa73777d13b74
> >  [ 3675.127905] x26: 0000000000000001 x25: ffffa73777d13b74 x24:
> >  0000000000000000
> >  [ 3675.127907] x23: 00000000ffffffff x22: 0000000000000dc0 x21:
> >  00000000000029c0
> >  [ 3675.127908] x20: 0000000000000000 x19: 0000000080000000 x18:
> >  ffff800125340040
> >  [ 3675.127910] x17: 0000000000000000 x16: 0000000000000000 x15:
> >  0000ffffd627bed8
> >  [ 3675.127911] x14: 0000000000000000 x13: 0000000000000000 x12:
> >  0000000000000000
> >  [ 3675.127913] x11: 0000000000000000 x10: 0000000000000000 x9 :
> >  0000000000000000
> >  [ 3675.127914] x8 : 0000000000000000 x7 : 0000000000000000 x6 :
> >  0000000000000000
> >  [ 3675.127916] x5 : 0000000000000000 x4 : 0000000000000000 x3 :
> >  0000000000000000
> >  [ 3675.127917] x2 : 0000000000000000 x1 : 0000000000000000 x0 :
> >  000000007fffffff
> >  [ 3675.127919] Call trace:
> >  [ 3675.127919]  __kvmalloc_node_noprof+0x534/0x818 (P)
> >  [ 3675.127921]  cxl_send_cmd+0x514/0x7e0
> >  [ 3675.127926]  cxl_memdev_ioctl+0x7c/0xe0
> >  [ 3675.127928]  __arm64_sys_ioctl+0x4a4/0xbc8
> >  [ 3675.127931]  invoke_syscall.constprop.0+0xac/0x100
> >  [ 3675.127934]  do_el0_svc+0x4c/0x100
> >  [ 3675.127935]  el0_svc+0x50/0x2b0
> >  [ 3675.127938]  el0t_64_sync_handler+0xc0/0x108
> >  [ 3675.127940]  el0t_64_sync+0x1b8/0x1c0
> >  [ 3675.127942] ---[ end trace 0000000000000000 ]---
> 
> My cxl syzkaller also ran into this issue and I had a similar patch
> I never sent out.
> 
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> 

Thanks for the review.

--Richard

> > 
> > Fixes: 4faf31b43468 ("cxl/mbox: Move mailbox and other non-PCI specific infrastructure to the core")
> > Reviewed-by: Kai-Heng Feng <kaihengf@nvidia.com>
> > Reviewed-by: Koba Ko <kobak@nvidia.com>
> > Signed-off-by: Richard Cheng <icheng@nvidia.com>
> > ---
