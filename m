Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.22
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793858453;
	b=mhGPgVXPkfui+oNdwR7aOcI6xGz4HVPWmYVTQ3UICwuJbECeiwEMsHyPjaAYIOW7UEoW
	 iR2vGJ8paMKeHR31lid7ThkiizezUL9/u4hbsPfzOMxiQdfY+SLaqsG0TYLrTSzOZ/Su0
	 RxyGjwsTFLVXzFP4KQaiOLkNVh8wHtQer0yd4ME45wEz70o3xX6YcDaG+immAD4guusCg
	 DcNtTod07HgpvpJrsM52uAvaYdLL26QQf6+wvk06dUNxfJw/E9TAnsVo31L2MenhI2JWs
	 0je8cVEUrQ6fmEbeGAzAwBBuWNNPw3Hbta1pgvIowNKxWW/zFcggKbNsPYpw8I+dW2w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793858453;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=9M0yfwebD4fAJPUL1SH//vCIzURvhWlb24Lpv4vJd58=;
	b=CgLuTxEVtTungieMMOUVZ1qxSZBaN9jyOJXoiUAGiKSq507CkY/Q/1mwpk5XA8bL7sy8
	 DQphzQL8XTEW9Wf6+wIvkVF5b4rEl6STgxTal2IAhV1olS+8YyVocnKI6IqUtHjQ/dGRc
	 ZrWIRm7VJUK9gI7i6j//uXo2EkDQbvbsTOMmo2DraYkHpL2UsiYwl/RjaFqSWIiucQFXo
	 z6BuYBTjQayCNPKIBRhfocl37GkRU2rKfJ2rAPh/RAnq14i8RP2XJ7LCqbVL+4mswBXPs
	 ocphiaMR51cNsSKR4sJDvm9CroOzgUdFOCbkE/kaR2+PTlr91+CDgMujynO7eLB+QUg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=XeYdAa+i;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.22
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013022.outbound.protection.outlook.com [40.93.201.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89131606A326;
	Thu,  5 Nov 2026 06:00:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89131606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=XeYdAa+i
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wFZ57NqnyDl4i1fd3pAIoo8/popzsBFo3JjGCsXCcTpOpvTaeyCJ0Gwqvpz6pbsI1BJSUuyB3VhYEn34WOo8961ZPif4gfeCFqiHS18oAPGUdO5ocM0B0ITSLrudTVtzjwMaeq17KzYgBf6u5aS+WzQEsJkjKsOI5pcOr2zZTNh4CU8egzdwhDKGfg58TrxAaTsGqWCXSM2u3+OjS9KZ7lBosjR6zFSOrNjmO/+5stE2yugSjK7IQPdAmDINLzROV2RG7neUPanatTHv0esMm+UzeqDzkryO5SEKk5mwkLJWRcpXA9nvjtn3h5CHdyMLxgT+e/Qh0LTOTHRxBKgjfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9M0yfwebD4fAJPUL1SH//vCIzURvhWlb24Lpv4vJd58=;
 b=c/Hh7JoFzJVFMmYd+5paOhJUjOFwWyXw5A+8bx+YkLPufPumbCQCACRiA8GsBFSdO0IttR6hTv2iSGJVig/B34pZvUW9zD+CFd/5fYhZhwwAi+vo+NM9DKqktGZg4c8xE1cPzLtYf0H+6ge79izrcCQB8P8BmwDnCX9eiQUmns8VLlVbZt07Jn28Z+QwUfg850uL901k1ZlsrzGok3KJ/lk6Iwl7fMLEZp7qqaNWnalXFSa9bSwDxA/Ok5l8xs96xzXZuMGa4bekrPHttvAedIMXITvvvyHZTI8RhNbaOeBB/Jk8mtex3Xd0emQb0a1f76MaM85EFO0Yjwe2Z2DzhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9M0yfwebD4fAJPUL1SH//vCIzURvhWlb24Lpv4vJd58=;
 b=XeYdAa+iT35bkto3V8Uhn78/RsD467HTXR3oIEI46lRVj0oWRz3mQBo49J3i1tTCcsShCTg6wTlOMavX7M0hi/LrPWrxy9WI79x4S0GYoDJMMMdlq99BGOvnkZ1Tc/+d/8MqOOX431YKlEI3+Z5ueLTvwRO2I7N1PB8OVWXE428NgxMnM8xl6J4JCuMEmk5S4n8K4HGERLFLUw8DRJN3IElQ1sBPgvBN3NjX99tiU42ZBZWyCFWCC14rxGIgDhsM56V/N13s1Pw777ZHny4MlwfrIZIIMmwDUnnstuKRQXAYpFiDApdNazZ1C5w8ojQj6MObkpvU5tKze0zBOLS0mA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by SN7PR12MB7452.namprd12.prod.outlook.com (2603:10b6:806:299::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Thu, 5 Nov
 2026 06:00:49 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0592.007; Thu, 5 Nov 2026
 06:00:49 +0000
Date: Thu, 5 Nov 2026 14:00:45 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Jongwon Lee <ai@linux.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, 
	Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, 
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] cxl/edac: Mask DPA flags in the event record
 cache key
Message-ID: <auwbbYkbjswoBMrv@MWDK4CY14F>
References: <20261102123233.74598-1-ai@linux.com>
 <20261102123233.74598-3-ai@linux.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102123233.74598-3-ai@linux.com>
X-ClientProxiedBy: TP0P295CA0001.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:2::10) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|SN7PR12MB7452:EE_
X-MS-Office365-Filtering-Correlation-Id: 2032f1f3-2120-43fb-e2d2-08df3b02241a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|23010399003|10067099003|18002099003|22082099003|261102123227099003|261026121527099003|261021121427099003|11063799006|56012099006|261009223027099003|261026140227099003|261022105027099003|4143699003|261028144727099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	G5u6QdiVQCrQW9gTVL96zrdC7mnWVzCwM6+sYyw9jwRtdUuIGj6a1rAZnfaf8Qddc9F7pa4ueJELQN2QMZ3RszPjpRIr+UDLuWAmDeM7o3ndVV0me9L7qufHzWk5b2Xp9N/7GCtvQhsbemOoFxUoyYiTCFfZOnYvOT1IXixrOMWfR3ladth3uQCcSUA0zyDg14zvHggVtoqlnr5WWbzcbfFWvke99J3UjRlvnlTFLMnjCznWhS23GDyH3bnJA5gDaCluehCoJpwht+XjCad95Q5EsZJRmPzvn0AFJyBuYzFlXZ98cArpuFEhRhyQoNgfGwao48S4OUQClPOEEBgflTFR5yTDl1utv4FOKUM5wabZ/U58rQPWNlExOdZTKMOq7MXK6GxV4o+0gEHFWBl2m1kB8cO4OQugP367fMLFk+uGlQ9IbLCiyzNKjDvI38C6k2Y2iRW+TCw3UVbUAWKdwzbRkQ3gJcl6OoxKXMbL6M54oU9AlYjM9lAkjTa1d5ORihNlT03bLaz2AZMVX84dDIILmtzQv8SAnnZy8aELWGT7rpAZJrAJSM0YZUac3vZ9shXWF+9c1EYserJtyFZo5lThiyiih6dXnWySHxZ4ub9NhpbzjJ0LcQzh03q7dX1ZCZqRbjZvtp1zoCzOL39EgpKx2XSGxTovbpd5eEnrRAE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(10067099003)(18002099003)(22082099003)(261102123227099003)(261026121527099003)(261021121427099003)(11063799006)(56012099006)(261009223027099003)(261026140227099003)(261022105027099003)(4143699003)(261028144727099003)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?23QRoqUfDX9kc5RowRP125oAwq1RL9rxJFhmLTwXlj0OQc6e3JpKyabolLlL?=
 =?us-ascii?Q?fFQZ9BXn7cxRI3XxOkRtaBjMFz+9gb4XSGn8PdWhUKzCibIMrvIxPTJ8KiVv?=
 =?us-ascii?Q?LmnaabDvAzeLhJe4Swsoqa7Jb3Y8WHVclKE/mZ6MnMzyxGTqbDDT4nkWsO8I?=
 =?us-ascii?Q?9UwKitjsjND2dGxC5Jl/UwcSt1IdyMVxKjj23ij77WCGiit4g9iV+JEvDsL3?=
 =?us-ascii?Q?yMAZrRdQcjLt8aGctZB2Cy8f7S5mxrTUxryWl1okLbIRU670vgxqAXQ35q3T?=
 =?us-ascii?Q?Z+oIzBB3WlErNP42wM8ogqpdqf2664LOFkIYsa0ESu2UMnrbxhtKJtLMnCNL?=
 =?us-ascii?Q?qqcspJsuW2dHqYYz0TAaVNFSPW4/VQA/zW58ziGBFXjJv3Xv68E61JRRmMeI?=
 =?us-ascii?Q?oE2ieB5l/Hn+Nv528hlRtezl8jBapJq5Tha4dNUIj+JgPJIUqXb0/GZzkJCy?=
 =?us-ascii?Q?1FY+jSeW8jGHgC1dKDq00ZFlqGfZibLSjslKmLBHBO4tt77+8e6/DV7xbbKU?=
 =?us-ascii?Q?7tGTJH/CXOSC5bJdcdwrKl4FRAhb6m/coZpN4VQFFtPTH6gt5eOoDVTGZ8F4?=
 =?us-ascii?Q?R5NLXatq3W/yl3dw3So7lkXnPktjcvVqRekwGFYWT7q0DLM/ojCcDQkb8bHd?=
 =?us-ascii?Q?B0C1sFjrxxuTE56tNAK3z34mtCIZAsbk/biAX0Ipa/35NtFZ0VX5q1Bfy1MV?=
 =?us-ascii?Q?qaecM0ihGL+h0kf9SnLoPuZuZIZvZDRTAeu1WLb846kPF/GizIL6viVxqlGI?=
 =?us-ascii?Q?zkhXT8982wvWsc3jJpy9v7V31Jiz+w2uCl6gMgOT4Ps5KCHP+LF1q3o/RJN/?=
 =?us-ascii?Q?95FHb1PDsv4gweq0vgH8Xc50hndgpTgENwZ6NQdfDZovLn4VxuxI0bqUaLce?=
 =?us-ascii?Q?tvXB3NmVcABrNUtiau142gpGiqWfb/pCR68ZcNlFieW9ZLWcd+glGBKHTId8?=
 =?us-ascii?Q?HaIV7TfniUNQb8g5DUyneIkQvd+mRqnGPQ8e4A4soXEAp+ivt8i9j4nvnOst?=
 =?us-ascii?Q?fBj9E7YpuUevWtnksl5A6fhv8O0Hx/pg7aFye8WHotEndWOQLrZncP6iWM5a?=
 =?us-ascii?Q?3gOh3Iu81MZcfKcjEHVSLACzQQg1asDk2fzAhjTvIEulp82PeI7Jk7NsA1hx?=
 =?us-ascii?Q?v8TaAensc+ysPpH3G4DVLf7pIwVqsN49ASnJqBI9wRDv0X862a7unrN/Uh9b?=
 =?us-ascii?Q?etps41n6wFYYH9bVQHETFEUeB45nP6SwHHvHYW77sDRG+jXWjZtjGygvDbJN?=
 =?us-ascii?Q?3Ns6+0qZTY4uz7DiGSGpohYDXExBC5pGGX+8534fVKraFOj1PG//Rgo9ReDA?=
 =?us-ascii?Q?DE7Q4XRgTD5XbLzZzkfWXw8p4kZzfjQ5nKosNkt2fUg3bEsmOaTb/ZqtNnZ6?=
 =?us-ascii?Q?/QAMedn8E/lVHm3R8dDeKj2m55m1267ADmo7nhhZUbwB0E4uvbqIsPF24Cwa?=
 =?us-ascii?Q?OGMagGXbiG0Kh2jmuxG1S9o3xACGTwCteevTZIQ6Ixt1RMSqtAzIozoeViEf?=
 =?us-ascii?Q?tKLf4z/wXOIZhUncCIO3ZVWbSzdjYyDDQbktUHc2N5/BWQgxcMFBiDsCJEAO?=
 =?us-ascii?Q?+AXLZr/RTCR0LT3IObwSPERZG9BR1f6qB9V3ua0aAtwye8duBkK4vCCh6Rg2?=
 =?us-ascii?Q?OlmPzWFBzBdVnCG8ekX04DQxs9VdK4q5WTVA4u03c18A26ym0SM8xkahuc+S?=
 =?us-ascii?Q?djgZjOgYQZa0zWnKENRu0UNMSrjDjtIRxDu02p48DdubgAmq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2032f1f3-2120-43fb-e2d2-08df3b02241a
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 06:00:49.5177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iwUBLpz1PqkX//ejr/eKHlG32sgsWtKuGpxVV6CYQBsmDgaSNEcQ1tA5PEuuW8fzl9gfaPihHyPqSvXPQ40VtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7452

On Mon, Nov 02, 2026 at 09:32:35PM +0800, Jongwon Lee wrote:
> The low bits of the DPA in a General Media or DRAM event record are
> flags: bit 0 is VOLATILE and bit 1 is NOT_REPAIRABLE. The trace events
> report the DPA with CXL_DPA_MASK applied, but cxl_store_rec_gen_media()
> and cxl_store_rec_dram() use the raw value as the xarray key.
> 
> User space reads the DPA from the trace event and writes it to the
> mem_repair dpa attribute. If the record had any flag set, xa_load()
> misses it and the repair fails with -EINVAL. The raw key also lets a
> repair go through for a record the device marked NOT_REPAIRABLE, if the
> DPA is written with bit 1 set.
> 
> Key the records by the masked DPA and skip records marked
> NOT_REPAIRABLE. cxl_find_rec_gen_media() now reads the record, so do
> the lookup under the xarray lock as cxl_find_rec_dram() does, and
> return a bool since its only caller tests the result.
> 
> Fixes: 0b5ccb0de1e2 ("cxl/edac: Support for finding memory operation attributes from the current boot")
> Signed-off-by: Jongwon Lee <ai@linux.com>
> ---
>  drivers/cxl/core/edac.c | 43 ++++++++++++++++++++++++++---------------
>  1 file changed, 27 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
> index c5c8dda20e..a5f198b561 100644
> --- a/drivers/cxl/core/edac.c
> +++ b/drivers/cxl/core/edac.c
> @@ -918,24 +918,37 @@ struct cxl_mem_repair_attrbs {
>  	enum cxl_mem_repair_type repair_type;
>  };
>  
> -static struct cxl_event_gen_media *
> -cxl_find_rec_gen_media(struct cxl_memdev *cxlmd,
> -		       struct cxl_mem_repair_attrbs *attrbs)
> +/*
> + * The low bits of the event record DPA are flags (VOLATILE, NOT_REPAIRABLE).
> + * Records are looked up by the DPA user space writes back, which comes from
> + * the trace event and has the flags masked off, so key them the same way.
> + */
> +static inline unsigned long cxl_rec_key(const struct cxl_event_media_hdr *hdr)
> +{
> +	return le64_to_cpu(hdr->phys_addr) & CXL_DPA_MASK;
> +}
> +
> +static inline bool cxl_rec_not_repairable(const struct cxl_event_media_hdr *hdr)
> +{
> +	return le64_to_cpu(hdr->phys_addr) & CXL_DPA_NOT_REPAIRABLE;
> +}
> +
> +static bool cxl_find_rec_gen_media(struct cxl_memdev *cxlmd,
> +				   struct cxl_mem_repair_attrbs *attrbs)
>  {
>  	struct cxl_mem_err_rec *array_rec = cxlmd->err_rec_array;
>  	struct cxl_event_gen_media *rec;
> +	bool found;
>  
> -	if (!array_rec)
> -		return NULL;
> +	if (!array_rec || attrbs->repair_type != CXL_PPR)
> +		return false;
>  
> +	xa_lock(&array_rec->rec_gen_media);
>  	rec = xa_load(&array_rec->rec_gen_media, attrbs->dpa);
> -	if (!rec)
> -		return NULL;
> +	found = rec && !cxl_rec_not_repairable(&rec->media_hdr);
> +	xa_unlock(&array_rec->rec_gen_media);
>  
> -	if (attrbs->repair_type == CXL_PPR)
> -		return rec;
> -
> -	return NULL;
> +	return found;
>  }
>  
>  /* Caller holds the xarray lock. The record may be freed once it is dropped. */
> @@ -949,7 +962,7 @@ __cxl_find_rec_dram(struct xarray *rec_xarray,
>  	lockdep_assert_held(&rec_xarray->xa_lock);
>  
>  	rec = xa_load(rec_xarray, attrbs->dpa);
> -	if (!rec)
> +	if (!rec || cxl_rec_not_repairable(&rec->media_hdr))
>  		return NULL;
>  
>  	validity_flags = get_unaligned_le16(rec->media_hdr.validity_flags);
> @@ -1130,8 +1143,7 @@ int cxl_store_rec_gen_media(struct cxl_memdev *cxlmd, union cxl_event *evt)
>  		return -ENOMEM;
>  
>  	old_rec = xa_store(&array_rec->rec_gen_media,
> -			   le64_to_cpu(rec->media_hdr.phys_addr), rec,
> -			   GFP_KERNEL);
> +			   cxl_rec_key(&rec->media_hdr), rec, GFP_KERNEL);
>  	if (xa_is_err(old_rec)) {
>  		kfree(rec);
>  		return xa_err(old_rec);
> @@ -1160,8 +1172,7 @@ int cxl_store_rec_dram(struct cxl_memdev *cxlmd, union cxl_event *evt)
>  		return -ENOMEM;
>  
>  	old_rec = xa_store(&array_rec->rec_dram,
> -			   le64_to_cpu(rec->media_hdr.phys_addr), rec,
> -			   GFP_KERNEL);
> +			   cxl_rec_key(&rec->media_hdr), rec, GFP_KERNEL);
>  	if (xa_is_err(old_rec)) {
>  		kfree(rec);
>  		return xa_err(old_rec);
> -- 
> 2.55.0
>

Reviewed-by: Richard Cheng <icheng@nvidia.com> 
