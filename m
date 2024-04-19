Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2101.outbound.protection.outlook.com [40.107.92.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2E177F13
	for <linux-cxl@vger.kernel.org>; Fri, 19 Apr 2024 17:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713547693; cv=fail; b=Mgf/RM1YL0gr5OnytyTnPVGURZe9vKYoKGDvb3zpLpRYGCuW9g8a3OjEhMMxajvRJot18OM/rhq6TQNgQm/eg1vxvl8KB8yGgr2PSlOlKS+i4rhvD5yrtLqvJm+ubt6ZGh9P8siC1VWaQTjG0VuiWchNK65NnEmQfrB5T0mYL/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713547693; c=relaxed/simple;
	bh=hS23dh2/ywfRpB2ZLuQVdY1v0mDLxLJL3gpMg9EUSBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WcBNXRbPXOIzscNz8dgcBsLbr0pMkgHZRTagazY9BT7us8RdD/sY54PHGKr4tT3hhJFn/SPh06wFt2GNyas66Ts1DVvvb1wR6f7x7Ch4reJUlSybf2obo8ETmDtBLEUhDqNY5bzfbZgeRI1uPW5KReHonSGWZKDC+OVIOXTp1sU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com; spf=pass smtp.mailfrom=memverge.com; dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b=OBNWjent; arc=fail smtp.client-ip=40.107.92.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="OBNWjent"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dYCt5n/0Jiqnc03OL642c0KijzAcXvePYm5aVnVWiiIyUB5GmNnc5zLKDAfQePd0l5hf6olpyWrdXBhattzx6EcjChjcGKGF4U1L7rJhtfZb61Me4wrsIGqTCm71jMKTN27JI4JFmSux94bmixBmft0Qmjlt0MTopmFvpZgQvtJ+WAD4gfSRlW3hvkBCYhGbSP9Y1wdaABmFPBkmhONH2jKpFvP7S+uqi3fSIEstO+l46E8mn9uyWigtDueh6IOlpGzFqRduXQFPfElx2Wnti/4FO67FmVhVAJ5lzLZ5pvlbHP0OcJkTjWdcl5zhLGnbiS8UZpAnoZ4oUjWBlBWFxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0N1YQmNCqZRA/rk4VmBx6brleX65waCc/OFDkiDYkDU=;
 b=mBikYOjHW5VIVpRfNEB4l3e4f4uo9YNAO69WNc29EjtGIfCD3xVydI3JJdbMhU8HIPpBft54TdTKPJxLJjipXLdDjfnW9Arfpi3vQEswPsJzFcub0gttMjBBjAyPTuHqIOalhzWac3Gj1AhUiQnlUZ+x0Ald+M59V+52rwlcoem8MFqKv33OtxnLA9/FJvKj3ulqrmQNdrr1yJAwOL8Eeo47e60w9ODlgUzm7mc/molehmNL+yoQfmlwvcSoQpTCMnkmUFIO6slECuSnIQ5Nj3muZShKYASBBJTRpC0ZSC0kF82qejQrE2UANxIU0YU6vfbAtySj1ffSKzR8YMkp6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0N1YQmNCqZRA/rk4VmBx6brleX65waCc/OFDkiDYkDU=;
 b=OBNWjentJaznxPn7Gnk6Fiqkz6syacC6SA1cesGtQaDY8NZskN81xvLfjPFL0DkRG9wDTFX0qUpOZ3K/TRpXTW17fWlAunjmX5puP5B009d28uzvTMBqNlPCX3UEAwqoYHFoMX0gVm6cvAyYiIDYHVN+u+45Kt8T6czOfhhLjbE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by DS0PR17MB6824.namprd17.prod.outlook.com (2603:10b6:8:115::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.39; Fri, 19 Apr
 2024 17:28:08 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::5d53:b947:4cab:2cc8]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::5d53:b947:4cab:2cc8%4]) with mapi id 15.20.7472.042; Fri, 19 Apr 2024
 17:28:08 +0000
Date: Fri, 19 Apr 2024 13:27:59 -0400
From: Gregory Price <gregory.price@memverge.com>
To: nifan.cxl@gmail.com
Cc: qemu-devel@nongnu.org, jonathan.cameron@huawei.com,
	linux-cxl@vger.kernel.org, ira.weiny@intel.com,
	dan.j.williams@intel.com, a.manzanares@samsung.com,
	dave@stgolabs.net, nmtadam.samsung@gmail.com,
	jim.harris@samsung.com, Jorgen.Hansen@wdc.com, wj28.lee@gmail.com,
	Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v7 06/12] hw/mem/cxl_type3: Add host backend and address
 space handling for DC regions
Message-ID: <ZiKpn7oSQWKkywwx@memverge.com>
References: <20240418232902.583744-1-fan.ni@samsung.com>
 <20240418232902.583744-7-fan.ni@samsung.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418232902.583744-7-fan.ni@samsung.com>
X-ClientProxiedBy: SJ0PR05CA0085.namprd05.prod.outlook.com
 (2603:10b6:a03:332::30) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|DS0PR17MB6824:EE_
X-MS-Office365-Filtering-Correlation-Id: 68ae92d2-3d2e-4b4e-bd0a-08dc60961459
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	P7BMCuK3PFJWrH/gObrDO+jzmFcW6stGFncb/RlZc15vIUUclXrcyvqq28b1bJx7yAVh6+ECC8WEHz2gXe1ySrUiaQScnWjWC3kUjcB08kX7q6ZNci91iOvg+D9Jb5XmqiOKooZw4t9HBYBPwrrGVH5tbmW+fclf/o5AibaQr3PuY8+gnKbDRcM7UedQKhm/pV5G2ScXqe70w3ah9C5tI93SHED5GH+GlRn9DKSkeMzkQctIbHBTn/jHmW7bZYas6s6MvbkAq9LlnnrGNZREn692LH9wZKa4V3Fsp+2Gpi2rEKKjWSXkAR67Ut/XJWi3/Joy03l0WN55lJvkge+kLlp3PEX9bOz+O2DMmYRSU8Q2vTvv/g3N6jfVUc84dFnD1a3UDmnZGzQthAOuKGDsL4gEnmfPIXb12XKadI69ebduw6BEAArSChLSYn/zvIMejMG3XLGMpZuimPvg0W/64NYlgsHWIjJNqqP3Sla7IUMUEIuaZz7OkSc8NpHfYdpqxwDYoqSlO1y5tXNFk40EFGdq1FR61IrbkLyFNsYGYTkIo2DVxYZAZOOHcmEUe5dQjONJKexiWmVGu+nVpzIu1fpKRa+xsfTt/gb05z2eYJmfQvfPQzmoen6nb5NMQPdALJbY4TSRFXSR2Tjax1LhyMuB60r2eyTAZXFymL622kc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T73PH2whzBIfL26nLNXNI2MLtH3M4ihycflpOD09aew20fR2d6o1d4Mknb9J?=
 =?us-ascii?Q?CAb4OcTmQvtBb1zmiNiDjee+5AprLsaqOPTXNUBW7coeJW2fpzhbDR5Jv8t5?=
 =?us-ascii?Q?iDsVd+EWQ1RbXhBaVRgWrYjg0iZCcASKXqCpaFh1Rgg4QYg/nwDTKGp+A+wJ?=
 =?us-ascii?Q?wWqH+3neZRvMTLHg0vDkS7C198kaS9nlBGykOHcBhCXxI8rKY7Sgt67Ok2Qb?=
 =?us-ascii?Q?r1BtaTWGSW5uuMaQavbCp8f8q8Sc+3MTScXmv0H7OzFa5qsVT9lRuDFoIXNM?=
 =?us-ascii?Q?D21aMtS0TlNKyEBEeGrdKwB05tyasxBUeTGPug7ncxm/QgHI9G0A7adO/j7a?=
 =?us-ascii?Q?/jfsYfp/4pXqQFrs94hgTvpxCN4lRH9Uj4eCgfGJ16pZW1z4ZA46YBe2wW+z?=
 =?us-ascii?Q?LEw9bRk0PQKVlIARlCj7742WUgvUKL+Pjixn8FLFNtyTEaPmeyWuwTkccj8I?=
 =?us-ascii?Q?D2vnRq9a3cCwGzw0ICUCBvEZXd06b4DBIou74M/OXaT9m21X9WvdQFay4hbd?=
 =?us-ascii?Q?oGnMcf2SgDjF6XZ+O3Sf0H+Al24mojssBfiF860GClGc+wJG1uVDoS/5HT7J?=
 =?us-ascii?Q?LbmvIb52zLbU6yBxBJ62Duqm+LfQFhgT+ISbg2a3t2ejv2iR0mgBw749lJVF?=
 =?us-ascii?Q?mwCmB9PHAlApbc/yaQ3hxPkxToBBbUNvhszyxGW1t962ltPRAI/YhVPbKJeS?=
 =?us-ascii?Q?gIYJ9/lCfmrnFjWhVyDi5g62Amaynw0d0VIHrCPFMkXbhc8henhJwvDfHhew?=
 =?us-ascii?Q?UmoIzkxKjDRwphAuMfnmF4eYMiZ5IQqU8qXbmMBTN7pK7Wx16dHINR6noEur?=
 =?us-ascii?Q?e08MejxrkpSDl1YQUw9vNLDk2pKUGt1lnOiFBL9Z1K3rhE+rgj4ok328/hEm?=
 =?us-ascii?Q?UMadtHj8ApOr26O3SqUnWQiuu06AepNnEeQ8umscOZ6yDliLxA8w0XaQswaI?=
 =?us-ascii?Q?fr0VPJk/xPrxDIGud1NDnUfyVC5/buqWotk/OlAclDxvscOn+ozehyLcoZW9?=
 =?us-ascii?Q?rcMeA95f4SB5OwwhwwwepBsa747aMhW8OxKBhmhp4rJFov2BFRjvExusHJWH?=
 =?us-ascii?Q?lpb801ImMcAcwZhQxrvjyc6AOJmB2+0dlsCvUa0pVr/Sp7WmNqnh4B+6dRl4?=
 =?us-ascii?Q?n3zY1Y0kNi9deDkmId8kxO4jjnsbgg8NwUL/EKBoxxevcQSRlimwDhjS/Ysw?=
 =?us-ascii?Q?dWYT4AJ0Fcq4yD4ZZYPLan3i7bQbZ29Vy6xj34qgzrIWkJwOEH/1Dflxtj3c?=
 =?us-ascii?Q?hJ/D/pok1ZQZRCovgmud4zeNjbMgwsAX94dJY5aPZOiX4xCwWUNYCjdUlBK6?=
 =?us-ascii?Q?KZHJMaB0x5cf4s26p5XEdhhob/UKMngsVqlp7b23OlQ38nKw2BSpFfqJVS0m?=
 =?us-ascii?Q?poEHaxK+uNTC9Wlq0/AREnbBoomBiFoNEvmZIhaF/OB7FUBF76Z4Larkfqin?=
 =?us-ascii?Q?c/ougmXH8+Eslaurb7eStHs3+5Nre35IDXL3ZltARH68Bogx8hh3vpepn1xP?=
 =?us-ascii?Q?dxACXb2y9ITVtAnyTgrcUUc+vVCl7fRFwYZCe9COCpH/5AXrQMGFIh96Y7oa?=
 =?us-ascii?Q?R51xaHTchRv6pTDMY2qr6okUXDeiBghSKy2njXCDM1BdcL1qOkkoAMv4GjNX?=
 =?us-ascii?Q?iA=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68ae92d2-3d2e-4b4e-bd0a-08dc60961459
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 17:28:08.4501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0CHxacneV4nt4x+az/nx4jugCav/gPwh4e0LClTAzwaSrdsYyvNVPzqrF4bjXoVUC3JsYBGBj6A+Fr7D9UqQRgpPsOMK9HGIhX1Y9xxPg8Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR17MB6824

On Thu, Apr 18, 2024 at 04:10:57PM -0700, nifan.cxl@gmail.com wrote:
> From: Fan Ni <fan.ni@samsung.com>
> 
> Add (file/memory backed) host backend for DCD. All the dynamic capacity
> regions will share a single, large enough host backend. Set up address
> space for DC regions to support read/write operations to dynamic capacity
> for DCD.
> 
> With the change, the following support is added:
> 1. Add a new property to type3 device "volatile-dc-memdev" to point to host
>    memory backend for dynamic capacity. Currently, all DC regions share one
>    host backend;
> 2. Add namespace for dynamic capacity for read/write support;
> 3. Create cdat entries for each dynamic capacity region.
> 
> Signed-off-by: Fan Ni <fan.ni@samsung.com>
> ---
>  hw/cxl/cxl-mailbox-utils.c  |  16 ++--
>  hw/mem/cxl_type3.c          | 172 +++++++++++++++++++++++++++++-------
>  include/hw/cxl/cxl_device.h |   8 ++
>  3 files changed, 160 insertions(+), 36 deletions(-)
> 

A couple general comments in line for discussion, but patch looks good
otherwise. Notes are mostly on improvements we could make that should
not block this patch.

Reviewed-by: Gregory Price <gregory.price@memverge.com>

>  
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index a1fe268560..ac87398089 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -45,7 +45,8 @@ enum {
>  
>  static void ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
>                                            int dsmad_handle, uint64_t size,
> -                                          bool is_pmem, uint64_t dpa_base)
> +                                          bool is_pmem, bool is_dynamic,
> +                                          uint64_t dpa_base)

We should probably change the is_* fields into a flags field and do some
error checking on the combination of flags.

>  {
>      CDATDsmas *dsmas;
>      CDATDslbis *dslbis0;
> @@ -61,7 +62,8 @@ static void ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
>              .length = sizeof(*dsmas),
>          },
>          .DSMADhandle = dsmad_handle,
> -        .flags = is_pmem ? CDAT_DSMAS_FLAG_NV : 0,
> +        .flags = (is_pmem ? CDAT_DSMAS_FLAG_NV : 0) |
> +                 (is_dynamic ? CDAT_DSMAS_FLAG_DYNAMIC_CAP : 0),

For example, as noted elsewhere in the code, is_pmem+is_dynamic is not
presently supported, so this shouldn't even be allowed in this function.

> +    if (dc_mr) {
> +        int i;
> +        uint64_t region_base = vmr_size + pmr_size;
> +
> +        /*
> +         * TODO: we assume the dynamic capacity to be volatile for now.
> +         * Non-volatile dynamic capacity will be added if needed in the
> +         * future.
> +         */

Probably don't need to mark this TODO, can just leave it as a note.

Non-volatile dynamic capacity will coincide with shared memory, so it'll
end up handled.  So this isn't really a TODO for this current work, and
should read more like:

"Dynamic Capacity is always volatile, until shared memory is
implemented"

> +    } else if (ct3d->hostpmem) {
>          range1_size_hi = ct3d->hostpmem->size >> 32;
>          range1_size_lo = (2 << 5) | (2 << 2) | 0x3 |
>                           (ct3d->hostpmem->size & 0xF0000000);
> +    } else {
> +        /*
> +         * For DCD with no static memory, set memory active, memory class bits.
> +         * No range is set.
> +         */
> +        range1_size_lo = (2 << 5) | (2 << 2) | 0x3;

We should probably add defs for these fields at some point. Can be
tabled for later work though.

> +        /*
> +         * TODO: set dc as volatile for now, non-volatile support can be added
> +         * in the future if needed.
> +         */
> +        memory_region_set_nonvolatile(dc_mr, false);

Again can probably drop the TODO and just leave a statement.

~Gregory
