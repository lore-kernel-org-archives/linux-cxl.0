Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012059.outbound.protection.outlook.com [52.101.43.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1005332D45B;
	Mon, 12 Jan 2026 21:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768252274; cv=fail; b=HFI0iavLgBSI/g4ko8wx2p5Ov4NMQwk1Wqb7CqJlXHWrcYFFiMwP8H0FoDfZAIbTfb61snLxpGvVejuUqao9zYKEvRDIlcl6C4vtoE2g8bsAsvdNRFcGWjW0amb9Q67zoLRmogboD1vWWNFvRnnu8KZETfD0tSBHP1iNbvHYiL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768252274; c=relaxed/simple;
	bh=V7Mu8Hhk3pcZh178AhAVonhLZDrNG+AeOyB7ebr5lUo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=uPUSys+407uX8na4LkohCPvM5VCgB4/vjg2Oa2FV8/SNeLvvKVUm3ZYYQM6m4CQzLuKuGL0IoftWryw35BsCrYQh+uBLq+N3yl6xRl+47LF7Q1/n2NdrN5sy1NuX6BhI3pNQERfG1IomM2Uw7xP7DtwFv4zMQUIR7Iq63lF25IY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zgnZm6d6; arc=fail smtp.client-ip=52.101.43.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zgnZm6d6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RMGMOaBXexmjtYoHotkRfQVAUkTZYCFU2IY/b1co2UnAjSl889wULzSfDIZ6hdQYNaTItHAHbnTsqXHueCC05tX0v4QAZtKjeXyjfzlFdT5De7yvS0qQfggf+YUYitcZdsbKEk4hMgW5Azr1vfkcer/JH5+vsXj4BZJxtBFqk6FcH0mSxsuwtuaZtpshGP4eVjT/3XcuDRsba1GeXEtGWqcGiExyI1GXA8AzhKGNuMOq447EDSxC39y0N14dtq4VOYZU4+Vs4oV5F55GI8MkAdD/W5tsT7KeWeTFW5TPMkGukczfIOx9MY1IqIhRzJ61U/bYiTVfnD3dUVtIjYQHqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G7O0mGsYugAiWnvxR3Kn58IiKyC4O7asuncYnqTnSu0=;
 b=qZY2Qvj7ldAelSL7x4aaG+73S7eGW+JtG/uuD5XZ3z3RyDUS7rvb3DsOLJV0EqFlm1kKGzzpGcHjGMR53OGBiZqrinmz7tkgsMY7rDmDaoRG6pkp4+v2xPGAc78fXw45L2u+/sOc3aYGmfkL2EGufLSvuLZUtvCM9wmW4UfkmBqvM6UBOivgTLkK8lUlJzcO5jlIYg1EiiOxz0Bj176HCLvA0p8hcjVNA/AXmKFrtPYK3EQEsl8eESHoJ78RVihYjh1H2C/mjL0J+i6zcbou9Nu83s5Uqj3EUXF+S3hEdOnDVh+qYvmpN7Rax/G1KHQYwuN9GpyMGh4MAYyxgH9nHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gourry.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G7O0mGsYugAiWnvxR3Kn58IiKyC4O7asuncYnqTnSu0=;
 b=zgnZm6d6fgpMvhEFSHBsLLThmIRn0zxQnugAXbYOayrDzLSR07L+UMEQ4CcYrqTbxYgQ/p6IMWu6Cws3ti7TRcUOdFTVQirqHGNtyKFi4bW0WON9LfiCytD+CdCyuJOQ0OcJKh2VfngH80RfhZwAnFw+lg7EE3eu26lv8HK8KjA=
Received: from SJ0PR03CA0008.namprd03.prod.outlook.com (2603:10b6:a03:33a::13)
 by BN7PPFCE25C719B.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6e1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 21:11:07 +0000
Received: from SJ5PEPF000001F4.namprd05.prod.outlook.com
 (2603:10b6:a03:33a:cafe::fc) by SJ0PR03CA0008.outlook.office365.com
 (2603:10b6:a03:33a::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Mon,
 12 Jan 2026 21:10:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F4.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Mon, 12 Jan 2026 21:11:06 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 12 Jan
 2026 15:11:06 -0600
Received: from [10.236.181.95] (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 12 Jan
 2026 13:11:05 -0800
Message-ID: <9c975c63-2668-4283-a326-292e50bfbfec@amd.com>
Date: Mon, 12 Jan 2026 15:11:05 -0600
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH 6/6] cxl/sysram: disallow onlining in ZONE_NORMAL if state
 is movable only
To: Gregory Price <gourry@gourry.net>, <linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <kernel-team@meta.com>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, David Hildenbrand
	<david@kernel.org>, Hannes Reinecke <hare@suse.de>
References: <20260112163514.2551809-1-gourry@gourry.net>
 <20260112163514.2551809-7-gourry@gourry.net>
Content-Language: en-US
In-Reply-To: <20260112163514.2551809-7-gourry@gourry.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F4:EE_|BN7PPFCE25C719B:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dc54522-1dcc-40d3-68ad-08de521f1a18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZGlFNVZxNERCYkt2R0E1K2l5aWNQbHI0WmdNRjJpbmNuNzI2WVk1U3U3SDVO?=
 =?utf-8?B?bXNOUWwzdHcwSkM2RHRZQUxjY0NyMHVWcVBRNTY0bmtWMVg0Y1lGaTlUclhi?=
 =?utf-8?B?dGMxK1c0QlBUUmNOd29RWmpkQlI3SmdndW9mdzMxaFZDTUg2ZFZkUHVMbUNk?=
 =?utf-8?B?dHhIZlE4NzZ3cGQ4RG82MVZ2Tkh1ZVZIU3JvcHpTS0pHcDNKVEVtdDB2RWUr?=
 =?utf-8?B?TFJjSTkxcTFBdHYvUnc0TlBHWkI4UFhzTUF4WGhNdWRDZDRycTN0K0hNWWM0?=
 =?utf-8?B?VWpDd3dMdmlldG1jekZ4MGkxZWF1SGN5QWdGcENWUjZFRENxT0tWQWtwaGZH?=
 =?utf-8?B?dkdDOGMrRm85WEp0WENkeVkyaG10OXlZRkJhdS9qQkdhaDNTSXE3eldlTFpo?=
 =?utf-8?B?bjhmcXVDbWV5c0RKMnNzNHUwbm54VWJrN2ZaOHZ6dFo2ZStRaU5jb1BnZnlZ?=
 =?utf-8?B?cGhLbjJ5R1lhdVRlS01NNi9XQUFGRitmaHdqNzNMTmtSZUZRZEdHbGZyVXU3?=
 =?utf-8?B?Q2ZOSzA2N2ZmUWI4dDMyOUMraTRuOWI5Y1B4ZVlFaXQzQ3QyMlFveEVwcGNU?=
 =?utf-8?B?dGZ3VkFoYUMyRURWY0lQSmxmd09Zd3FVVlNrRCtPajM1b1pkNHpHUEJRc0RU?=
 =?utf-8?B?K2hyOWhUVjl4bmRQeHU4VWhabzg4YVdxWFkwYytXaUcyTU9lMFdyT3JOK2lw?=
 =?utf-8?B?eWg5YWVZSC9zQWV2NW9KOU52UUdxMFlGZGd5dmYyWHFhbUgwTFZiOStJSG9z?=
 =?utf-8?B?cnJIUVFRUGhPNklWTTdGWU5YenRsM2tVaFV4WWJ0R3lpUkkvcE5UN2ZzcDdD?=
 =?utf-8?B?VGFzK0lBZy9McHlUbDd1Q0czZG1OZVNOTFdpbm4yTVJSd1NoMi9YK2g3UlI3?=
 =?utf-8?B?azc5N2N6bHpIdURlNW56Wm9QVURzVTRKZHh1ZHhJQTdpVlAzREcrbFgxeVRv?=
 =?utf-8?B?VCs1eWlxQnZyTHM4dmJGWk5OTHFNOTlsZlhBWHVPM0kxRWFtb0ZDMHhYbC9X?=
 =?utf-8?B?cWg3N3JBdUFCYnFrVW5CTHRVRnFXSDJRV21aWk1HQ3U1L2tST0hSWVBaWEhR?=
 =?utf-8?B?bVhHdlpNS2RENnltUDcwaGhGSWMxK1pERXdTNysrZStWRm0ybnUyUTRrb0VM?=
 =?utf-8?B?Z3NHVFhJRUZxU1FjSGovdmtZWElKb2pRT3A1U3YrMitwTks5dHBsdzEzcmd6?=
 =?utf-8?B?UWd5QlBldkhPSS9JWWNuMGhlamtON1RHMEE3QW1qbkxxeElsU3ZLem1RR3ZH?=
 =?utf-8?B?alBaeWYxOHJnYm9kNkhxaVc5MVVtRVpVY3hwTUFuQkV0OTZ2SDJVaEtyR3Ra?=
 =?utf-8?B?MnFyRzlSMXVTeWRxSFhQWjZFUzN1SWljSzc1VUNSRElHR2twaFIzMDYwQ3p3?=
 =?utf-8?B?blFkNkFCTEx1NzlLYklWZE5NUmJWU2psYnRxazM3UC82RFFmZkNQMmp2M0ZP?=
 =?utf-8?B?NmZKVS9KRE1ocS9xODRvMjZuRkVEVE5jTXkwTmlHVEhGU2dNRFo1QXV5R1dX?=
 =?utf-8?B?Wk9TdHY3V0FhS1hBWHBnaGxEa3Q0Zml5c1JyTnpuOVAvUEN0WDVCeUdMTHVB?=
 =?utf-8?B?K3g5UlJpSDFIR3pHY1V4bjlVNnkyVVhQUlF3ZVk5UlZHQXZvOWgzMzhmU2Np?=
 =?utf-8?B?eHdvaFdYNjVKSlJRb2RMb3FXVzBDa0NjWXI2T0U0QUdVMmF2OTJoZUFlY0VY?=
 =?utf-8?B?UHhOUHcwbXpHNW54Y08wdUp4QU1NRUgxa1NuYnhmQjBNU2s0dUQyd3g3bTlS?=
 =?utf-8?B?NVVrWkpGTTA1MFBhU3VObVo3YnZ2QytMM0l6SzdwbExDMXdaZHY0QUFDR1BI?=
 =?utf-8?B?WlRiVFBwTFhSMWJlNXNOd2k1cDNUUW00UE1iNjgzZkNpR3lndHh0bk43VEZo?=
 =?utf-8?B?SEhGZVFNcVVTU0p3WVpkaDg1a2M2ZFMzaWV4ODFyZi84dTJhNWtyWER3ekdF?=
 =?utf-8?B?enI2d0lnUDc2dEIvckNWQmQweE5TbGg0QXpRSEJrRUFvMUc0SVVZSDd3c2Qy?=
 =?utf-8?B?L3hGeit1amhDK2FXbGZ5SzNNbGFnSFovTVQ5NXg1QUVuT0I3TmFBMXkxZXBr?=
 =?utf-8?B?RXNra3ljNHZkNVVaMEh4dlBpUDg2SnJVcktKSVZXY25hZGV6MStNaHRXWXZm?=
 =?utf-8?Q?bb01yWE/HZ6L4EdtOUmFvcRco?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 21:11:06.7622
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dc54522-1dcc-40d3-68ad-08de521f1a18
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFCE25C719B

On 1/12/2026 10:35 AM, Gregory Price wrote:
> If state is set to online (default to ZONE_MOVABLE), the user intends
> for this memory to either refuse non-movable allocations, and/or intends
> to preserve the hot-unpluggability of this memory.  However, any admin
> can write `offline` and `online` to the memory block controller and
> bring that memory online in ZONE_NORMAL.

Is it the expectation that the user will never want to change the zone from
MOVABLE to NORMAL? I can't think of a reason someone would want to off the top
of my head, but I also can't think of a reason to restrict it either.

> 
> Register a memory_notify callback that disallows onlining the block into
> ZONE_NORMAL if the default state of the controller is ZONE_MOVABLE.
> 
> If an actor attempts to online the block into ZONE_NORMAL, it will fail,
> but if it attempts to online into either NORMAL or MOVABLE, only MOVABLE
> will be allowed and it will succeed.

I'm not sure you need this paragraph. I think it's a logical conclusion of the above
that if someone attempts to online the memory as NORMAL or MOVABLE it'll only be onlined
as MOVABLE.
> 
> Suggested-by: David Hildenbrand <david@kernel.org>
> Suggested-by: Hannes Reinecke <hare@suse.de>
> Link: https://lore.kernel.org/linux-mm/39533aa8-ca78-41a8-b005-9202ce53e3ae@kernel.org/
> Signed-off-by: Gregory Price <gourry@gourry.net>
> ---
>  drivers/cxl/core/memctrl/sysram_region.c | 138 +++++++++++++++++++++--
>  1 file changed, 127 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/cxl/core/memctrl/sysram_region.c b/drivers/cxl/core/memctrl/sysram_region.c
> index 2e2d9b59a725..71e39d725dc5 100644
> --- a/drivers/cxl/core/memctrl/sysram_region.c
> +++ b/drivers/cxl/core/memctrl/sysram_region.c
> @@ -2,6 +2,7 @@
>  /* Copyright(c) 2026 Meta Inc. All rights reserved. */
>  #include <linux/memremap.h>
>  #include <linux/memory.h>
> +#include <linux/mmzone.h>
>  #include <linux/module.h>
>  #include <linux/device.h>
>  #include <linux/slab.h>
> @@ -23,6 +24,14 @@ struct cxl_sysram_data {
>  	const char *res_name;
>  	int mgid;
>  	struct resource *res;
> +	struct range range;
> +	struct notifier_block memory_notifier;
> +	/*
> +	 * Last online type requested by user via state sysfs or auto-online.
> +	 * Used to enforce zone consistency when memory blocks are onlined.
> +	 * MMOP_OFFLINE means no online preference has been set yet.
> +	 */
> +	int last_online_type;
>  };
>  
>  static DEFINE_MUTEX(cxl_memory_type_lock);
> @@ -158,7 +167,58 @@ static int cxl_sysram_offline_memory(struct range *range)
>  	return rc;
>  }
>  
> -static int cxl_sysram_auto_online(struct device *dev, struct range *range)
> +/*
> + * Memory notifier callback to enforce zone consistency.
> + *
> + * When the user (or auto-online) requests memory to be onlined into
> + * ZONE_MOVABLE, reject any subsequent attempts to online memory blocks
> + * from this region into a different zone (e.g., ZONE_NORMAL). This prevents
> + * accidental zone mixing which could lead to memory fragmentation and
> + * offlining failures.
> + */
> +static int cxl_sysram_memory_notify_cb(struct notifier_block *nb,
> +				       unsigned long action, void *arg)
> +{
> +	struct cxl_sysram_data *data = container_of(nb, struct cxl_sysram_data,
> +						    memory_notifier);
> +	struct memory_notify *mhp = arg;
> +	unsigned long start_phys = PFN_PHYS(mhp->start_pfn);
> +	unsigned long size = PFN_PHYS(mhp->nr_pages);
> +	struct page *page;
> +
> +	if (action != MEM_GOING_ONLINE)
> +		return NOTIFY_DONE;
> +
> +	/* Check if this memory block overlaps with our region */
> +	if (start_phys + size <= data->range.start ||
> +	    start_phys > data->range.end)
> +		return NOTIFY_DONE;
> +
> +	/*
> +	 * If no online preference has been set (MMOP_OFFLINE), allow any zone.
> +	 * Also allow if the preference wasn't for ZONE_MOVABLE.
> +	 */
> +	if (data->last_online_type != MMOP_ONLINE_MOVABLE)
> +		return NOTIFY_DONE;
> +
> +	/*
> +	 * The zone has already been assigned to the pages at this point
> +	 * via move_pfn_range_to_zone() before MEM_GOING_ONLINE is sent.
> +	 * Check if it's ZONE_MOVABLE as expected.
> +	 */
> +	page = pfn_to_page(mhp->start_pfn);
> +
> +	if (!is_zone_movable_page(page)) {
> +		pr_warn("CXL sysram: rejecting online to non-movable zone for range %#lx-%#lx (expected ZONE_MOVABLE)\n",
> +			start_phys, start_phys + size - 1);
> +		return NOTIFY_BAD;
> +	}
> +
> +	return NOTIFY_OK;
> +}
> +
> +static int cxl_sysram_auto_online(struct device *dev, struct range *range,
> +				  struct cxl_sysram_data *data)
>  {
>  	int online_type;
>  	int rc;
> @@ -173,6 +233,9 @@ static int cxl_sysram_auto_online(struct device *dev, struct range *range)
>  	else
>  		online_type = MMOP_ONLINE_MOVABLE;
>  
> +	/* Record the auto-online type for zone enforcement */
> +	data->last_online_type = online_type;
> +
>  	rc = lock_device_hotplug_sysfs();
>  	if (rc)
>  		return rc;
> @@ -187,17 +250,43 @@ static int cxl_sysram_auto_online(struct device *dev, struct range *range)
>  	return rc;
>  }
>  
> +static ssize_t state_show(struct device *dev,
> +			  struct device_attribute *attr, char *buf)
> +{
> +	struct cxl_sysram_data *data;
> +
> +	data = dev_get_drvdata(dev);
> +	if (!data)
> +		return -ENODEV;
> +
> +	switch (data->last_online_type) {
> +	case MMOP_ONLINE_MOVABLE:
> +		return sysfs_emit(buf, "online\n");
> +	case MMOP_ONLINE_KERNEL:
> +		return sysfs_emit(buf, "online_normal\n");
> +	case MMOP_OFFLINE:
> +	default:

You're missing the MMOP_ONLINE case. In that case the memory would be reported as "offline", which
I doubt is the intention.

Thanks,
Ben
> +		return sysfs_emit(buf, "offline\n");
> +	}
> +}
> +
>  static ssize_t state_store(struct device *dev,
>  			   struct device_attribute *attr,
>  			   const char *buf, size_t len)
>  {
>  	struct cxl_region *cxlr = to_cxl_region(dev);
> +	struct cxl_sysram_data *data;
>  	struct range range;
> +	int online_type = MMOP_OFFLINE;
>  	int rc;
>  
>  	if (!cxlr)
>  		return -ENODEV;
>  
> +	data = dev_get_drvdata(dev);
> +	if (!data)
> +		return -ENODEV;
> +
>  	rc = cxl_sysram_range(cxlr, &range);
>  	if (rc)
>  		return rc;
> @@ -206,23 +295,30 @@ static ssize_t state_store(struct device *dev,
>  	if (rc)
>  		return rc;
>  
> -	if (sysfs_streq(buf, "online"))
> -		rc = cxl_sysram_online_memory(&range, MMOP_ONLINE_MOVABLE);
> -	else if (sysfs_streq(buf, "online_normal"))
> -		rc = cxl_sysram_online_memory(&range, MMOP_ONLINE);
> -	else if (sysfs_streq(buf, "offline"))
> +	if (sysfs_streq(buf, "online")) {
> +		online_type = MMOP_ONLINE_MOVABLE;
> +		rc = cxl_sysram_online_memory(&range, online_type);
> +	} else if (sysfs_streq(buf, "online_normal")) {
> +		online_type = MMOP_ONLINE;
> +		rc = cxl_sysram_online_memory(&range, online_type);
> +	} else if (sysfs_streq(buf, "offline")) {
>  		rc = cxl_sysram_offline_memory(&range);
> -	else
> +	} else {
>  		rc = -EINVAL;
> +	}
>  
>  	unlock_device_hotplug();
>  
>  	if (rc)
>  		return rc;
>  
> +	/* Record the online type for zone enforcement on success */
> +	if (online_type != MMOP_OFFLINE)
> +		data->last_online_type = online_type;
> +
>  	return len;
>  }
> -static DEVICE_ATTR_WO(state);
> +static DEVICE_ATTR_RW(state);
>  
>  static ssize_t hotplug_store(struct device *dev,
>  			     struct device_attribute *attr,
> @@ -274,6 +370,11 @@ static void cxl_sysram_unregister(void *_data)
>  		.end = data->res->end
>  	};
>  
> +	unregister_memory_notifier(&data->memory_notifier);
> +
> +	range.start = data->res->start;
> +	range.end = data->res->end;
> +
>  	/* We have one shot for removal, otherwise it's stuck til reboot */
>  	if (!offline_and_remove_memory(range.start, range_len(&range))) {
>  		remove_resource(data->res);
> @@ -334,6 +435,10 @@ int devm_cxl_add_sysram_region(struct cxl_region *cxlr)
>  		goto err_data;
>  	}
>  
> +	/* Initialize range and online type tracking */
> +	data->range = range;
> +	data->last_online_type = MMOP_OFFLINE;
> +
>  	data->res_name = kstrdup(dev_name(dev), GFP_KERNEL);
>  	if (!data->res_name) {
>  		rc = -ENOMEM;
> @@ -373,11 +478,20 @@ int devm_cxl_add_sysram_region(struct cxl_region *cxlr)
>  	dev_dbg(dev, "%s: added %llu bytes as System RAM\n", dev_name(dev),
>  		(unsigned long long)total_len);
>  
> -	rc = cxl_sysram_auto_online(dev, &range);
> +	/* Set drvdata early so auto_online can access it */
> +	dev_set_drvdata(dev, data);
> +
> +	/* Register memory notifier for zone enforcement */
> +	data->memory_notifier.notifier_call = cxl_sysram_memory_notify_cb;
> +	data->memory_notifier.priority = CXL_CALLBACK_PRI;
> +	rc = register_memory_notifier(&data->memory_notifier);
> +	if (rc)
> +		goto err_notifier;
> +
> +	rc = cxl_sysram_auto_online(dev, &range, data);
>  	if (rc)
>  		goto err_auto_online;
>  
> -	dev_set_drvdata(dev, data);
>  	rc = devm_device_add_group(dev, &cxl_sysram_region_group);
>  	if (rc)
>  		goto err_add_group;
> @@ -385,9 +499,11 @@ int devm_cxl_add_sysram_region(struct cxl_region *cxlr)
>  	return devm_add_action_or_reset(dev, cxl_sysram_unregister, data);
>  
>  err_add_group:
> -	dev_set_drvdata(dev, NULL);
>  err_auto_online:
>  	/* if this fails, memory cannot be removed from the system until reboot */
> +	unregister_memory_notifier(&data->memory_notifier);
> +err_notifier:
> +	dev_set_drvdata(dev, NULL);
>  	remove_memory(range.start, range_len(&range));
>  err_add_memory:
>  	remove_resource(res);

