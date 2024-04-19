Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2128.outbound.protection.outlook.com [40.107.101.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6029A13B5B5
	for <linux-cxl@vger.kernel.org>; Fri, 19 Apr 2024 18:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713551085; cv=fail; b=DmrJ+/5URn+v8lUtjPoUjiuDZpc0VCfdSNB4xRgVDodHJItH++cNKZGKopDVS5fdpXaC+Ck8NUPcfyrKCH8YM6jcIa3ndBBvulpYzPa2QGN1c1BILVPugSXsS1EIoyq63G3yGup58+2blWU0sAaRKyvunAHDCGWHI/wJPzfbNb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713551085; c=relaxed/simple;
	bh=typXx7L2G9xvudeOv5iPOsJrtGgLxfAZERrmIIAcFBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AsU+JMmb+q0XJar/OwlUTC5v9BvQVlc3OiQKD9fAZkUOZ98T2Yx5fFK3ibMJ60TeU8RU1wPXNnR2b2UIe5JYn9wLy+1Z962Pm8zjI9hpnjKXhgFA11KziPYTkVI9wLzlgU67cUJlQGYDDSz5JFEJNvr7AfWeWLV+9V5Nafuvpo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com; spf=pass smtp.mailfrom=memverge.com; dkim=fail (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b=iN/d6Kcf reason="signature verification failed"; arc=fail smtp.client-ip=40.107.101.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="iN/d6Kcf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iu2ZPTKvANOZcWIGVvEPEWo2/ustoBV7wQ/awKrU+p6HLd0jJneoMTWbpROwKVSClfIVN9CbxP9/SNP02UbOPZkuWmvbju02g8r0BeilPSXk7s0QI33xHFLJTxOksRzKDn95viMUvx9cr/CrQrrmvHZFFdGr1RCEheSzDIT88wgEfl3BCDihMq0Suwlj6/FlesZnjPm3uVVi0R4O+iOmJG3/lsiHWuFatfKkyZQmXssyf1RMSXgih2xgSU51GJxmB+uhNmhkRWL7L0TEW4Q0LiqglGSDuq5tPu8ZaeiCk3ZbcMP+HAfVoDC+ZxKhVGCR2vxWXrkx4NlETZ75FV7Gqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J6H133nsgGGKX+c5F0sd3BLCiokggDt9PWTT+n1Y18k=;
 b=EePj4/qYk5L/+wC31hgwxgnTyyRy8lqvJZbFhhKUpX7mvuDxlYGbp8LYwI/pWWtqVdgaLs10oo6XlWscao7kbA8hDHzZ7Swo3NoDgtR2zdZBqxqA+l7PIco7h6o94I/LPG2CIKez2F4bjC1GI7n0WlsS56kv4FpKq0Qk1Bd53nciVppKGmKW9v6XeyLoZ68nSrV/HaOx9fcWLb7IYa679klIoLIDcpf4nh8SSEOnj/r7RYF+6Kf2ptr12mlIjzFGeKB7rEmhUnnKprBBBEULL1/nQK8HU3qNz8Rgo+qezmsl/jy7ODMZpQ/O5iBRkmgklltOBFWnraklqXxL6g3+Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J6H133nsgGGKX+c5F0sd3BLCiokggDt9PWTT+n1Y18k=;
 b=iN/d6Kcf3agvL7aj6W15Y1P13u+7Otq6XNQmjNI5nziCdaTvdy+Kgxxk1GyqP6B8ErbBE8ooVPqpVWnLvBLPXL8p/jOwRDMmcWJQT8MozD5VYDFhS4bRzI/+aR2diCgLlKPiueEs46IntRH3fOxMcFb8SlDO6SJN3xRmibc/0DY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by SJ0PR17MB6431.namprd17.prod.outlook.com (2603:10b6:a03:4d5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.43; Fri, 19 Apr
 2024 18:24:40 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::5d53:b947:4cab:2cc8]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::5d53:b947:4cab:2cc8%4]) with mapi id 15.20.7472.042; Fri, 19 Apr 2024
 18:24:40 +0000
Date: Fri, 19 Apr 2024 14:24:36 -0400
From: Gregory Price <gregory.price@memverge.com>
To: nifan.cxl@gmail.com
Cc: qemu-devel@nongnu.org, jonathan.cameron@huawei.com,
	linux-cxl@vger.kernel.org, ira.weiny@intel.com,
	dan.j.williams@intel.com, a.manzanares@samsung.com,
	dave@stgolabs.net, nmtadam.samsung@gmail.com,
	jim.harris@samsung.com, Jorgen.Hansen@wdc.com, wj28.lee@gmail.com,
	fan.ni@samsung.com
Subject: Re: [PATCH v7 00/12] Enabling DCD emulation support in Qemu
Message-ID: <ZiK25Log7LmtBffa@memverge.com>
References: <20240418232902.583744-1-fan.ni@samsung.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240418232902.583744-1-fan.ni@samsung.com>
X-ClientProxiedBy: PH8PR22CA0016.namprd22.prod.outlook.com
 (2603:10b6:510:2d1::9) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|SJ0PR17MB6431:EE_
X-MS-Office365-Filtering-Correlation-Id: 105e80b1-269c-48fb-d5a6-08dc609dfa4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZJG4LXtlMWBH9lmJKhpQxIvySMM/aGJgAzmTR0DdD6nDskMqANXuGSdP3NNXfpbTlCsFrNqx1hI4kMn0EqlUscqJwgCN1M7VFBDXICQuMLWSpVEjQqZtx9QDi67FARBjfxEUQKEPEvefJdg+KH3HZu/cID9fUKwWZGhac6Eju6V9lLnEoaWANmvfIwWM9OKEWw9O62JN3a1I7+L2bF8Lsja+3nwEU1bT52ngs/CPikPqyTCvejXQvPfqcdgO0z3FywcEZURN0osfAbUACgwx0gx7L6vNHp9CkeXMA+oC3ViCSb0z0aELWqyBCBgO6DD9CwTBTLnhFsL5j5C5Sobx3WQRqpBiLWuSae/vmDU955KabKZD3d+7gDgfSx2E2A3PJFDyetbpyihtInlIkLgqZhYMlL5n7BEBvN2HkS9lfWl/yc58GOdcNyEanDa/bpSMmXB4Q7FAy9DDN+NUoB0DQmqutSlmsEEFnA4kv6fTfqPSK2XXD6K06h61gW1V5PBsDk2Im92jSB73RHcGlURcAGbsj/yNtbtsVXxXLQm8yx1WpAq/eFcFGlal5jJQ98H0b1gOZNvntRkxSSOVwtS+PbfBUm00XxyLbD5LGZOunoU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?VUr8XbR9U6+zvDD9lyl85Y4CbFgEKu3NjWPaHACTRHkzwyFqDLF7dgPwEZ?=
 =?iso-8859-1?Q?uvBaTjeTbtxU7mrMpO8x2EVSnmZfF+gwn2UinmOBqnTB/wvP5bubaW9Q7k?=
 =?iso-8859-1?Q?f6Lo+KVJ4eR3b/1xCpqO601CGMVf0n0MAXjyRL5ZOETKclGJutUGeiawTS?=
 =?iso-8859-1?Q?faaNNlFxANjPuoncIYVk+X7MtTS6z3ysWIqDbqmqK4vDKWPKlzNU0p7sbR?=
 =?iso-8859-1?Q?/LVQdWuH84AzXzHITcjLlx5EfWFH+BNHr/rbb4hrBh3eCoQPdECNwPFuvQ?=
 =?iso-8859-1?Q?mUvRPVeuehpJeljiQheJGtxUwcrUSphvRTN+5jOLwBXD74IBr7A66JUVcN?=
 =?iso-8859-1?Q?chHsV4gow/s2/LrgpxP/r0DIM8RfnDK4zkuNJz3ZJu1rvrphuSUEHgnKss?=
 =?iso-8859-1?Q?G4fdDy/cVawdGAV4EqyPpFR2Cp8W4Zd5Cll9TznjfR8j7huqXeN29jtGaC?=
 =?iso-8859-1?Q?MSnU/XeZvtGMEzVV4JrXltzm36pIKitUyy/sfeJIZkpQYRI/r1gp0tRz5M?=
 =?iso-8859-1?Q?trwyjQ/0b+BaTPNs+g6F5RL49733Gmatqyq1oHA/2axgZbDt7QL/JI6lgV?=
 =?iso-8859-1?Q?nZQRRfvvzYYJuxkMZI215dfu/2WBkydRNIhI3ff58XP3KU9E//8H3jDoUX?=
 =?iso-8859-1?Q?WKU9r/WK3TTOFMsNPRZ6vadx1gk3VFoLM6UJeWIGh7zLKGXzP+mziDkZaS?=
 =?iso-8859-1?Q?I6Ksh5XbtMXoReE2orkWcdl0PoRztj4cmqy6WBT9Ovg7MytcNydXkr5dYH?=
 =?iso-8859-1?Q?dK2u79GN04tqIAeXEB5ydd9nkRo9ANiQwJpDGEeUV40Iwr5eMSrwnXqiVE?=
 =?iso-8859-1?Q?JnPkiyhkOhmSc1lLy4dhR06s5wVU+wYK+dFB4+HL/Y3iPTeIagMPsL0am4?=
 =?iso-8859-1?Q?xK1gOvxp6LJKvCnjiFb52kNAUuOpjIxV6FlixyeuedM47lxQRm1cThb3ii?=
 =?iso-8859-1?Q?D84hSjSM0bYPWeIv2IcklWSS6VE0Cnxge8ZqlJefJzT8ZBqpqlp+Z6CXhs?=
 =?iso-8859-1?Q?NCrWLs/q6l8F0tyOZCKtWdyF/jYnGiBHY8KIEvmbXeyKVGFcsFOng1GIDN?=
 =?iso-8859-1?Q?cY05j+fCGiUoO8h1Cnsqh9KoMvCkuOPg3pSCSd2qB1hQhy+FLUdzuovQyq?=
 =?iso-8859-1?Q?dcH/ZUtEqRPsAQmivFUiJTycTly8lq7dqcI7d8WTGLuxm5QteiA8d6ky3B?=
 =?iso-8859-1?Q?nRlfYSA74tw4rty9Yz36ywkufwbIOuXXHbn9R/3Y2shab6vHzFBPFb3KyM?=
 =?iso-8859-1?Q?WixOpD6kuAH7uT8+PzNFrI8vmjRh8Eb++Iga6N5jrEz2eqpfcVN1EAFObC?=
 =?iso-8859-1?Q?LEBWVkxFHBnCahCtmXw8EG1OEKskE5XuER//wTiuW8ZPze+7cJzbiy8/2G?=
 =?iso-8859-1?Q?pC0iV1psyjnJ9ObYebmHChfJZgf2g3s8sVHoingBC4Z9SU55c2DGXmTp3y?=
 =?iso-8859-1?Q?rFqv64eOlzXMLs9PyvsfqPOFowHEO/3DmW4M++f1jNKMWmckNnB896qe6Y?=
 =?iso-8859-1?Q?irqiZgbihwvYezO59bwDeXeQDKbN3+gODfS3sZIvJm5YzHybBF+uzbglvk?=
 =?iso-8859-1?Q?jAF4PaajS1Pr4bINCE/Prr6/I+d4Hrz9Fj978FVnMh8o6EYzr8YjPr9aVs?=
 =?iso-8859-1?Q?eYOUT5czHq7C6mQNvYXv7uLPLW5pJNHYI2d2fa49EHllWOSBJ8bOw6UA?=
 =?iso-8859-1?Q?=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 105e80b1-269c-48fb-d5a6-08dc609dfa4e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 18:24:40.6905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k0PPjffeylsqZdkbRaikVurnKUI/0UmonLUA3EmxA5swRk30UjZAAC5+ysCbRqWlxg+aKkVN0MkJSmcfXGpeiFI1KM0Jg5C1LLANQWC8MBQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR17MB6431

On Thu, Apr 18, 2024 at 04:10:51PM -0700, nifan.cxl@gmail.com wrote:
> A git tree of this series can be found here (with one extra commit on top
> for printing out accepted/pending extent list): 
> https://github.com/moking/qemu/tree/dcd-v7
> 
> v6->v7:
> 
> 1. Fixed the dvsec range register issue mentioned in the the cover letter in v6.
>    Only relevant bits are set to mark the device ready (Patch 6). (Jonathan)
> 2. Moved the if statement in cxl_setup_memory from Patch 6 to Patch 4. (Jonathan)
> 3. Used MIN instead of if statement to get record_count in Patch 7. (Jonathan)
> 4. Added "Reviewed-by" tag to Patch 7.
> 5. Modified cxl_dc_extent_release_dry_run so the updated extent list can be
>    reused in cmd_dcd_release_dyn_cap to simplify the process in Patch 8. (Jørgen) 
> 6. Added comments to indicate further "TODO" items in cmd_dcd_add_dyn_cap_rsp.
>     (Jonathan)
> 7. Avoided irrelevant code reformat in Patch 8. (Jonathan)
> 8. Modified QMP interfaces for adding/releasing DC extents to allow passing
>    tags, selection policy, flags in the interface. (Jonathan, Gregory)
> 9. Redesigned the pending list so extents in the same requests are grouped
>     together. A new data structure is introduced to represent "extent group"
>     in pending list.  (Jonathan)
> 10. Added support in QMP interface for "More" flag. 
> 11. Check "Forced removal" flag for release request and not let it pass through.
> 12. Removed the dynamic capacity log type from CxlEventLog definition in cxl.json
>    to avoid the side effect it may introduce to inject error to DC event log.
>    (Jonathan)
> 13. Hard coded the event log type to dynamic capacity event log in QMP
>     interfaces. (Jonathan)
> 14. Adding space in between "-1]". (Jonathan)
> 15. Some minor comment fixes.
> 
> The code is tested with similar setup and has passed similar tests as listed
> in the cover letter of v5[1] and v6[2].
> Also, the code is tested with the latest DCD kernel patchset[3].
> 
> [1] Qemu DCD patchset v5: https://lore.kernel.org/linux-cxl/20240304194331.1586191-1-nifan.cxl@gmail.com/T/#t
> [2] Qemu DCD patchset v6: https://lore.kernel.org/linux-cxl/20240325190339.696686-1-nifan.cxl@gmail.com/T/#t
> [3] DCD kernel patches: https://lore.kernel.org/linux-cxl/20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com/T/#m11c571e21c4fe17c7d04ec5c2c7bc7cbf2cd07e3
>

added review to all patches, will hopefully be able to add a Tested-by
tag early next week, along with a v1 RFC for MHD bit-tracking.

We've been testing v5/v6 for a bit, so I expect as soon as we get the
MHD code ported over to v7 i'll ship a tested-by tag pretty quick.

The super-set release will complicate a few things but this doesn't
look like a blocker on our end, just a change to how we track bits in a
shared bit/bytemap.

> 
> Fan Ni (12):
>   hw/cxl/cxl-mailbox-utils: Add dc_event_log_size field to output
>     payload of identify memory device command
>   hw/cxl/cxl-mailbox-utils: Add dynamic capacity region representative
>     and mailbox command support
>   include/hw/cxl/cxl_device: Rename mem_size as static_mem_size for
>     type3 memory devices
>   hw/mem/cxl_type3: Add support to create DC regions to type3 memory
>     devices
>   hw/mem/cxl-type3: Refactor ct3_build_cdat_entries_for_mr to take mr
>     size instead of mr as argument
>   hw/mem/cxl_type3: Add host backend and address space handling for DC
>     regions
>   hw/mem/cxl_type3: Add DC extent list representative and get DC extent
>     list mailbox support
>   hw/cxl/cxl-mailbox-utils: Add mailbox commands to support add/release
>     dynamic capacity response
>   hw/cxl/events: Add qmp interfaces to add/release dynamic capacity
>     extents
>   hw/mem/cxl_type3: Add DPA range validation for accesses to DC regions
>   hw/cxl/cxl-mailbox-utils: Add superset extent release mailbox support
>   hw/mem/cxl_type3: Allow to release extent superset in QMP interface
> 
>  hw/cxl/cxl-mailbox-utils.c  | 620 ++++++++++++++++++++++++++++++++++-
>  hw/mem/cxl_type3.c          | 633 +++++++++++++++++++++++++++++++++---
>  hw/mem/cxl_type3_stubs.c    |  20 ++
>  include/hw/cxl/cxl_device.h |  81 ++++-
>  include/hw/cxl/cxl_events.h |  18 +
>  qapi/cxl.json               |  69 ++++
>  6 files changed, 1396 insertions(+), 45 deletions(-)
> 
> -- 
> 2.43.0
> 
