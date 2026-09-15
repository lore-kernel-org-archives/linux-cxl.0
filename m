Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013032.outbound.protection.outlook.com [40.93.201.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05FF3EB0F0
	for <linux-cxl@vger.kernel.org>; Tue, 15 Sep 2026 09:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789463827; cv=fail; b=QJ5MjP6Ll9cNbanu7wYOC81kGlWu7FoahzmDpTEpIBXCOxPFivSeZmqQITVQkwDcPJkGuPhmYUt+CkZT8OoxykWZaUgFa60hTm9wblKv66P1LLyTBzUtmP5psuad7d8WvjuJ+GTmxZgVvkl8SB4Nko0PSSQzcwd6H5u0/0XAnfM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789463827; c=relaxed/simple;
	bh=4hcQ0d8SvVZTTm8kaMGCgTeJlDcJobXtuclHKc2wvN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nahRK7A+oKPedojMu4bcyS/LNYnokUmUJWSm5aGU4N4qhP2JY+biDceV8wWdtJNRJDW36AWcKINmWp7krFgtYuKjvlD+INeSZ+/EPn4rdtx1KQFTRTlPiqeaJOuHwRkTFYxi3PHEyoCSluHdmC3wrKqjl10nPgw87Y8phhLXPEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZNzJvFpP; arc=fail smtp.client-ip=40.93.201.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZNzJvFpP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t96DDm/NHylziFIx/dvq7yb4PiEE0z6yKXF+J1NPP0j2ROanxzIqcJf50ta9w7moJlkOyRRUNZbbRh8XLLySeA/uYpLej98rNDiMZFcg/5ahuwKE+vQ392D9wnHlxWn2H7f91/qo9GyVqhsipIYiXc2p0Ov4IVd8mLnk5Z8GpjhJQTkllQ8ojqCoH9FNoHOkFw9EyKDk5n4CnCGcpdskCW2fPUnGRCXuidtm62/lvDTL9Drey+u5TaY5Z62QwTKVyQFGu0nNUEUqLGfXpPFJ+cY5em9oA7jbWgApk11LqgOiwdhPelcdp812TfhFZbtQwqYHeYBmw3FZJHq4K1Nc3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UfVVLykpSh7n5sgqKKizcBV9xSlfnK7ZGIJTKyopbZk=;
 b=KrIbZBr7U5yZ64cCm3w7hosH2vxX9w0aDjI0natIyabTp9G58qUSYINqC2mEUKGwWeAcUzJAjD4OF3Y/iRsXc066Mc+TjJUCTgGQM9oiWAeDp3ac2JtZuA8rg9dDxSVHkvzFr+0iX1ub6Nox01dG44DUf17B644h6lYF3hY4DVjn5mOgEQf8W1fuQ+kQHwglSkce6UMBq5E0CdjKWBbSptbXM8Joe6ZMyQrjdwojlEhUpzxrhy+u31deZqi2sKeEKuLtuY7lwENcasM0KVYx4RqW4DnYsrae1yFIV+OqwBouG/aVkuoElS2cQfAuZLkNEoE83CRaFR/iuaQs6geaiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UfVVLykpSh7n5sgqKKizcBV9xSlfnK7ZGIJTKyopbZk=;
 b=ZNzJvFpP/OSuvNtHGDcndQcHlzVVqhme2QqXG2hnfWE56x1kyxVE+uyuM6jXKb8AnvHjvDmEBprBegfVrNtkNcGEtgN+y4/qczsLw95S2LdMM+wwcCtR/1VFj5gL5H/aYjrrUd9U1BA7rf632uFiYT/zoJAlo9NQzs+a9OiQUHU8ueZ5QBNUiwQ8A3Usvcx1kcLx+E6ivntZz9iWmnSIhD+10IkO3mZ/E+4F2jCZPUtkKsA39R/uwVxeupPLTO446o2qAeDeX9vGFjf6EDrh1ukuiyWwobC9PHslkeQH/TaNCSr0o1QfiO3xHlvNOd1RMO8jZP21Bfzj69UO+wEmIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by CH1PPF2EB7CF87B.namprd12.prod.outlook.com (2603:10b6:61f:fc00::60b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 09:16:59 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%7]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 09:16:59 +0000
Date: Tue, 15 Sep 2026 17:16:52 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Anisa Su <anisa.su887@gmail.com>
Cc: linux-cxl@vger.kernel.org, alison.schofield@intel.com, 
	jic23@kernel.org, dave.jiang@intel.com, gourry@gourry.net, ming.li@zohomail.com, 
	vishal.l.verma@intel.com, dave@stgolabs.net, benjamin.cheatham@amd.com, 
	Ira Weiny <iweiny@kernel.org>, Anisa Su <anisa.su@samsung.com>, 
	Wonjae Lee <wj28.lee@samsung.com>, Junhee Park <jh9934.park@samsung.com>, 
	Heesoo Kim <habil.kim@samsung.com>
Subject: Re: [RESEND PATCH v13 3/8] cxl/cdat: Gather DSMAS data for DCD
 partitions
Message-ID: <aqkMVCJRlgyJMJAT@MWDK4CY14F>
References: <20260908102124.2231730-2-anisa.su@samsung.com>
 <20260908102124.2231730-5-anisa.su@samsung.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908102124.2231730-5-anisa.su@samsung.com>
X-ClientProxiedBy: SI1PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::17) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|CH1PPF2EB7CF87B:EE_
X-MS-Office365-Filtering-Correlation-Id: bd7822f4-f3fd-4f38-ec37-08df130a1817
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|10067099003|4143699003|56012099006|5023799004|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	5zVfyRA/8pHqgRnhUwnQvFaBIipQn1vXVnA+exkywVgttyGeZVilgepqL5toII8bu8zImexI94JT+8XvgzIvE8L+FOYHomlKcIsc7BmiCnb8ggOuN9jjrllIn2zMBvXf7DW8/Ekp9xZK6PNDUrK0SIeJ1GVE2OK/0NtA0BLq6qS+oD+bxQTLiuwpzkkvP+ra5Cd8h6owbEN0HLJYdD0hHsnldm8oEvDvhw8TQNqfxib/NV1qICdK35lkVbNmsenpjsuffUdZk/H66u7RUTN47GThuWzE+tSrfGDC1pC5Yu5kSL38tz8jCsv+2ehJaorzPvH76sFSMKIx+DpvFzoE0keqqKCtCmhctU8md6qB8NPWC9NIlfbawTZfozHccFG+AYTu7U04fJeiwqhFFEqjtWk0n2ayPoUPs/cOQoUvE+ib9VdWuEU2u5yxdiWdhDW1VnknTjO1twvzR5FAFAjxjqvmCC120OuI7kI2bcJs5cjx4OWIVn4EzJ3MysAB24KFswRhR13BypdtgVDadyeNtiEw+1tAUTD3Jsf9XwYZjwaBRSnMskU7KCNXPYeqc8IUOS/6MU3sb/8G4z78YxgZm/otKWX8Xz+MaOT5/rFMY6+G0xtADKm+3Io8lPxzqew2LUc4RgWc6sc+h+rryRPqg7nKBKJuBogi6rkTMbjc410=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(10067099003)(4143699003)(56012099006)(5023799004)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?85Si0qW+RMx9UOTY02hAJsKVQotsgL8S0r+l3L+k1gFy+nXd6dQ1EE1n464J?=
 =?us-ascii?Q?9SVXsKXW3ll6Gk8+58vyTcxc1rx3AO23BT1M+32OKtVD3Nw07ERrK/JYfiCz?=
 =?us-ascii?Q?+tj4dn9NTDIf6bsNwjgUWilaS+R/zMjDFkjGlw7kYdni8EpfzzCHzxHyWpey?=
 =?us-ascii?Q?nqyMUzn2YeMa3gDBE1jEpzrY127SaKeT+zPbZ6t1stgZi9H/5zMlSkCKsfUB?=
 =?us-ascii?Q?CIgDWL4jAY/bzLB5QNWdDZ/iy/cIOrYDRdzqv2ptHAfbeNCvztQiUYv011Wa?=
 =?us-ascii?Q?LYQSc+7tWzayUC0fbl29YCtNqq8pS4dWAfajEZH7K/ljkMP0GVVXsPJCJiGh?=
 =?us-ascii?Q?Cfu76Crg6Y78Y0lNu0wrPkmNt5pli9dDBSAou3g/LinmRmH9cZY9SQ9Kzn8Y?=
 =?us-ascii?Q?M7vMpGwlxlt3oaaMl597XIrM6mI4u605zuNNhS2iyOG0t5dJZoKU3L4Zb/vx?=
 =?us-ascii?Q?eHS4i8k4rgoTT+22HmY62dPuhva1iDL6Vwk+xnBZ3K879pFJSJTJrPBOT9Og?=
 =?us-ascii?Q?8DiTHIcJ4cU5jQUpPSPxMGSkLLKqZRKFOETLFWwxADFq6IccHs9Y4pwCZgVT?=
 =?us-ascii?Q?Fz8ppbZ38FpHBLMlcY5UUh7GILgV4AahGbWSCdKFNGrjP8oeINvQGrngLW8Z?=
 =?us-ascii?Q?2cwi+1Ts1XaQAGjsi3tV1VdRZJ8b0wmpnoTYynggsuoFOwMlW8ZcRMpOVzS2?=
 =?us-ascii?Q?268bXK1EgmUtoaG4Hyyh12DU2pjy+tLBKv55jR7aHf9eNAPBJFWQnUZzVz3I?=
 =?us-ascii?Q?OYUts9vCRGbPxuSAIzYcKQYPEsyK4pSwrR700BURlC7yySNMFO/2XYHUMoJE?=
 =?us-ascii?Q?5j2qYx1RIwjDEbf2DgTe5al2KXzuQZ/hDq+tBaG7GhieeV/TuYQPMppI5Qxe?=
 =?us-ascii?Q?ND/wqwAOPfof5GhanLF0f99vbgFOsWBZH3ICyQGq2o2+43fL7IEABvMtQdVD?=
 =?us-ascii?Q?PsIli/PZINZWPZ58JMUscC6LT8GDuTU2GOjAjG+RuFZ0k32GIgYxgMwHShpJ?=
 =?us-ascii?Q?u7kAng+Zh1HpHvPISX6hIooDkbjuP/wOIZPmYOiOBCXRogOaNRPn4Y71TY7z?=
 =?us-ascii?Q?/bdNK5lwowkGfU+0jrhgoZhLcX71rciruOe+27Rpq+TYMgHFDaPVeyurhQ2J?=
 =?us-ascii?Q?B5ejwarkVa8nGvbS3arnZzxs1fzPzKSg/jRACnJNeoQbTpr8FAbfKO4+sucC?=
 =?us-ascii?Q?pL0sn2J9i6+79vKR/9TgIPDkkvT+diJWWt5/L8Tss2LKXLGsEq3y4T/z4rd0?=
 =?us-ascii?Q?8YtH1lZ/hdNYZUhNN+pw2p41vJPF6tLO6GwCiEGs2snf7ZmF8orIla1P9XlV?=
 =?us-ascii?Q?44F6WEQHC3DGvIdOUOtY1apryiqTekDtMqsAxs+sNzT3IEhWWcvoDrDKfDWE?=
 =?us-ascii?Q?1nFA0c8yCgC69d4leeIK9syNT3J13rhx53w3L0QdU4hR8V44635SKDlz4aYu?=
 =?us-ascii?Q?cvibYfNYzspd5IGfAhluUPDTitUce14v5gL8ZcuA7I5fJT16CoxmWxAGERH7?=
 =?us-ascii?Q?nwfzUe607FiLW4EJo7DI7evcOTK9s3WiPim4fKftgb0bz1O4WPN/e6maRED2?=
 =?us-ascii?Q?KZBroqMNAvB72oct+DNyrXuqz6ENqgVXV+yP2/spcxGS+M9W/ftJN37xp5iv?=
 =?us-ascii?Q?FpLP2Gc/J/UE/RI/Nz/+9fI9kLCI+r4W5mrEYYU9wUN2xteMVXHbvmVXFcGG?=
 =?us-ascii?Q?dGyIYq4dk7sBbV1d6rLu67ceoQ4W6q6BSpbP4SmiyyW9Wv8F?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd7822f4-f3fd-4f38-ec37-08df130a1817
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 09:16:59.0304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TGDXJa1eyMsKWt5H06vNy/8XNpn+U5q5dnDi187zIowhtZFyEComwCSl29HFCoBmHwLNoGyCVt0j3nFtr59FKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF2EB7CF87B

On Tue, Sep 08, 2026 at 03:15:07AM +0800, Anisa Su wrote:
> From: Ira Weiny <iweiny@kernel.org>
> 
> Additional DCD partition (AKA region) information is contained in the
> DSMAS CDAT tables, including performance and shareable attributes.
> 
> Match DCD partitions with DSMAS tables and store the meta data.
> 
> Signed-off-by: Ira Weiny <iweiny@kernel.org>
> Co-developed-by: Anisa Su <anisa.su@samsung.com>
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
> Tested-by: Wonjae Lee <wj28.lee@samsung.com>
> Tested-by: Junhee Park <jh9934.park@samsung.com>
> Tested-by: Heesoo Kim <habil.kim@samsung.com>
> 
> ---
> Changes:
> 1. cdat.c: set found=true as soon as a partition contains the range, and
>    break out of the search on a DSMAD handle mismatch. Partitions are
>    disjoint, so the continue could never match another one; the search
>    always ran out and the entry was reported twice, once as a mismatch
>    and again as "no partition for dsmas dpa" even though a partition did
>    cover it.
> 
> 2. cdat.c: only assign shareable for the dynamic ram 1 partition. It
>    was set for every partition the DSMAS range fell into, while the
>    handle check above it is DC only. The field describes a DC partition,
>    so ram and pmem have no use for it.
> 
> 3. Commit message: drop the claim that the read only attribute is
>    gathered. Only the shareable flag is. Nothing in this series or the
>    follow-on DCD work consumes a read only flag, so storing it would be
>    dead state. Implementing read-only (reject writes to RO partitions)
>    applies to any DSMAS described range, non-specific to dynamic capacity and
>    belongs to separate patch.
> ---
>  drivers/cxl/core/cdat.c   | 32 +++++++++++++++++++++++++-------
>  drivers/cxl/core/hdm.c    |  1 +
>  drivers/cxl/core/mbox.c   |  9 +++++++++
>  drivers/cxl/core/memdev.c | 17 ++++++++++-------
>  drivers/cxl/cxlmem.h      |  2 ++
>  include/cxl/cxl.h         |  4 ++++
>  6 files changed, 51 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index 5c9f07262513..05058d4520f2 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -17,6 +17,7 @@ struct dsmas_entry {
>  	struct access_coordinate cdat_coord[ACCESS_COORDINATE_MAX];
>  	int entries;
>  	int qos_class;
> +	bool shareable;
>  };
>  
>  static u32 cdat_normalize(u16 entry, u64 base, u8 type)
> @@ -74,6 +75,8 @@ static int cdat_dsmas_handler(union acpi_subtable_headers *header, void *arg,
>  		return -ENOMEM;
>  
>  	dent->handle = dsmas->dsmad_handle;
> +	/* Shareable is CDAT 1.03 and later, DSMAS Flags bit 3 */
> +	dent->shareable = dsmas->flags & ACPI_CDAT_DSMAS_SHAREABLE;
>  	dent->dpa_range.start = le64_to_cpu((__force __le64)dsmas->dpa_base_address);
>  	dent->dpa_range.end = le64_to_cpu((__force __le64)dsmas->dpa_base_address) +
>  			      le64_to_cpu((__force __le64)dsmas->dpa_length) - 1;
> @@ -266,18 +269,33 @@ static void cxl_memdev_set_qos_class(struct cxl_dev_state *cxlds,
>  		bool found = false;
>  
>  		for (int i = 0; i < cxlds->nr_partitions; i++) {
> -			struct resource *res = &cxlds->part[i].res;
> +			struct cxl_dpa_partition *part = &cxlds->part[i];
>  			struct range range = {
> -				.start = res->start,
> -				.end = res->end,
> +				.start = part->res.start,
> +				.end = part->res.end,
>  			};
>  
> -			if (range_contains(&range, &dent->dpa_range)) {
> -				update_perf_entry(dev, dent,
> -						  &cxlds->part[i].perf);
> -				found = true;
> +			if (!range_contains(&range, &dent->dpa_range))
> +				continue;
> +
> +			found = true;
> +			/*
> +			 * part->handle is from Get DC Config, dent->handle
> +			 * from the CDAT DSMAS entry.
> +			 */
> +			if (part->mode == CXL_PARTMODE_DYNAMIC_RAM_1 &&
> +			    dent->handle != part->handle) {
> +				dev_warn(dev,
> +					 "DSMAD handle mismatch: %pra has %u, DSMAS %pra has %u\n",
> +					 &range, part->handle,
> +					 &dent->dpa_range, dent->handle);
>  				break;
>  			}
> +
> +			update_perf_entry(dev, dent, &part->perf);
> +			if (part->mode == CXL_PARTMODE_DYNAMIC_RAM_1)
> +				part->shareable = dent->shareable;
> +			break;

I think this should be independent of QoS discovery ?

If FW returns no QTG recommnedations for any entry, that calculation returns
-ENOENT even though CDAT was parsed successfully.
And the result is that a matching DSMAS entry having its shareable bit set, but
part->shareable remains false because this assignment is never reached.

Best regards,
Richard Cheng.

>  		}
>  
>  		if (!found)
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 0ef076c08ed2..7f63b86887f4 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -477,6 +477,7 @@ int cxl_dpa_setup(struct cxl_dev_state *cxlds, const struct cxl_dpa_info *info)
>  
>  		cxlds->part[i].perf.qos_class = CXL_QOS_CLASS_INVALID;
>  		cxlds->part[i].mode = part->mode;
> +		cxlds->part[i].handle = part->handle;
>  
>  		/* Require ordered + contiguous partitions */
>  		if (i) {
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index a484e23b2b3a..efc3bf3563a5 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1365,6 +1365,7 @@ static int cxl_dc_check(struct device *dev, struct cxl_dc_partition_info *part,
>  {
>  	u64 blk_size = le64_to_cpu(dev_part->block_size);
>  	u64 len = le64_to_cpu(dev_part->length);
> +	u32 handle = le32_to_cpu(dev_part->dsmad_handle);
>  
>  	/*
>  	 * Not an error; leave the entry empty. A partially zeroed partition
> @@ -1376,9 +1377,17 @@ static int cxl_dc_check(struct device *dev, struct cxl_dc_partition_info *part,
>  		return 0;
>  	}
>  
> +	/* The CDAT DSMAD handle this refers to is 8 bits */
> +	if (handle & ~0xFF) {
> +		dev_warn(dev, "DSMAD handle 0x%x exceeds the 8 bit CDAT DSMAD handle\n",
> +			 handle);
> +		return -EINVAL;
> +	}
> +
>  	*part = (struct cxl_dc_partition_info) {
>  		.start = le64_to_cpu(dev_part->base),
>  		.size = le64_to_cpu(dev_part->decode_length) * CXL_CAPACITY_MULTIPLIER,
> +		.handle = handle,
>  	};
>  
>  	/*
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index fdd6b395dcdf..4a5793fa3cbf 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -594,7 +594,8 @@ bool is_cxl_memdev(const struct device *dev)
>  }
>  EXPORT_SYMBOL_NS_GPL(is_cxl_memdev, "CXL");
>  
> -static void add_part(struct cxl_dpa_info *info, u64 start, u64 size, enum cxl_partition_mode mode)
> +static void add_part(struct cxl_dpa_info *info, u64 start, u64 size,
> +		     enum cxl_partition_mode mode, u8 handle)
>  {
>  	int i = info->nr_partitions;
>  
> @@ -606,6 +607,7 @@ static void add_part(struct cxl_dpa_info *info, u64 start, u64 size, enum cxl_pa
>  		.end = start + size - 1,
>  	};
>  	info->part[i].mode = mode;
> +	info->part[i].handle = handle;
>  	info->nr_partitions++;
>  }
>  
> @@ -623,9 +625,9 @@ int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
>  	info->size = mds->total_bytes;
>  
>  	if (mds->partition_align_bytes == 0) {
> -		add_part(info, 0, mds->volatile_only_bytes, CXL_PARTMODE_RAM);
> +		add_part(info, 0, mds->volatile_only_bytes, CXL_PARTMODE_RAM, 0);
>  		add_part(info, mds->volatile_only_bytes,
> -			 mds->persistent_only_bytes, CXL_PARTMODE_PMEM);
> +			 mds->persistent_only_bytes, CXL_PARTMODE_PMEM, 0);
>  		return 0;
>  	}
>  
> @@ -635,9 +637,9 @@ int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
>  		return rc;
>  	}
>  
> -	add_part(info, 0, mds->active_volatile_bytes, CXL_PARTMODE_RAM);
> +	add_part(info, 0, mds->active_volatile_bytes, CXL_PARTMODE_RAM, 0);
>  	add_part(info, mds->active_volatile_bytes, mds->active_persistent_bytes,
> -		 CXL_PARTMODE_PMEM);
> +		 CXL_PARTMODE_PMEM, 0);
>  
>  	return 0;
>  }
> @@ -674,7 +676,8 @@ int cxl_configure_dcd(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
>  	info->size += dc_info.size;
>  	dev_dbg(dev, "Adding dynamic ram partition 1; %#llx size %#llx\n",
>  		dc_info.start, dc_info.size);
> -	add_part(info, dc_info.start, dc_info.size, CXL_PARTMODE_DYNAMIC_RAM_1);
> +	add_part(info, dc_info.start, dc_info.size, CXL_PARTMODE_DYNAMIC_RAM_1,
> +		 dc_info.handle);
>  
>  	return 0;
>  }
> @@ -693,7 +696,7 @@ int cxl_set_capacity(struct cxl_dev_state *cxlds, u64 capacity)
>  		.size = capacity,
>  	};
>  
> -	add_part(&range_info, 0, capacity, CXL_PARTMODE_RAM);
> +	add_part(&range_info, 0, capacity, CXL_PARTMODE_RAM, 0);
>  	return cxl_dpa_setup(cxlds, &range_info);
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_set_capacity, "CXL");
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 4fac65dbb808..9fd5af2e41d4 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -140,6 +140,7 @@ struct cxl_dpa_info {
>  	struct cxl_dpa_part_info {
>  		struct range range;
>  		enum cxl_partition_mode mode;
> +		u8 handle;
>  	} part[CXL_NR_PARTITIONS_MAX];
>  	int nr_partitions;
>  };
> @@ -851,6 +852,7 @@ int cxl_dev_state_identify(struct cxl_memdev_state *mds);
>  struct cxl_dc_partition_info {
>  	u64 start;
>  	u64 size;
> +	u8 handle;
>  };
>  
>  int cxl_dev_dc_identify(struct cxl_mailbox *mbox,
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 4ef9511fbbdd..43edcde5bce3 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -141,11 +141,15 @@ enum cxl_partition_mode {
>   * @res: shortcut to the partition in the DPA resource tree (cxlds->dpa_res)
>   * @perf: performance attributes of the partition from CDAT
>   * @mode: operation mode for the DPA capacity, e.g. ram, pmem, dynamic...
> + * @handle: DSMAS handle that represents this partition
> + * @shareable: Is the partition shareable (from its CDAT DSMAS entry)
>   */
>  struct cxl_dpa_partition {
>  	struct resource res;
>  	struct cxl_dpa_perf perf;
>  	enum cxl_partition_mode mode;
> +	u8 handle;
> +	bool shareable;
>  };
>  
>  #define CXL_NR_PARTITIONS_MAX 3
> -- 
> 2.43.0
> 
