Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0541F956
	for <linux-cxl@vger.kernel.org>; Tue, 16 Apr 2024 17:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713286902; cv=fail; b=qVOC8XMK4vaDCsmGS7iKVKwPD1rBJuC29tEk5TkYeUDEDwsDlPZJns5m16F5CIhLPYhDqTis3uGmsus/8W7Y8PAX+HAAAlBKSxpTq8j1iEgHgYEkYqpqGeZO86jyFEGQLjP+wjrjzOO2EjJgMqH8xQNhuySJ7ovmh0U4qdkrqAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713286902; c=relaxed/simple;
	bh=yCHUsHLy9Xx9/6INdW1JHuq55ysp28Uf5JxqGIREeuU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=A9xHi/c3PB+ticos3amEDUDXgy5q3F9ho63uD8PwznW2AM5bGTu7B82z7UnhtM4DLkPalmlH58QZ97/rWOCWYFWnIgD7E4MvCMnIBkIKZ5lVlTjQOn9pN2NPnN4SJ1p0P1vmDF9Qz1gBF3y2PcRVz9zNeOGLoDHUoBOPvxJFNKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AtOkbDFH; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AtOkbDFH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713286898; x=1744822898;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=yCHUsHLy9Xx9/6INdW1JHuq55ysp28Uf5JxqGIREeuU=;
  b=AtOkbDFH3PAYWF19W1s+QE+m7XrK5ZzgLWy/1oICw811+vD3HjmRwvsU
   NgrFvKQrukqylegrQ4zs2vUnltyhQwyg5ResJoVMq89djIAXW+VSG0TzK
   1yLBYDnzalH2C43qG01crm4VWK+bvbYVnyzcBlEUHtYFXhof+SO6MWX8y
   jZT/PbPPZguHgyDJCGhJFHJoStRQiXOjtMl1id5J+fSyon9itrWwiuZiY
   bHS/C0yeOPYL2EpMpQRByxlEG8kKQWxLdZXZU4o/dxQsezW2TCmctc7wq
   lCjKoNwKljGZnd8UEflite55xB8PZZew5PcWYdNrSpRO/4TJRWTD231wF
   A==;
X-CSE-ConnectionGUID: cdB6dC2lRVquWXvKwfM0Cg==
X-CSE-MsgGUID: RoAH8zruR06oowYgb8vLuA==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="31222723"
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; 
   d="scan'208";a="31222723"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 10:01:37 -0700
X-CSE-ConnectionGUID: 90HPnYx2RZO65XZlJKJndQ==
X-CSE-MsgGUID: IBnGOcdsSqOlruFaqMyCyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; 
   d="scan'208";a="27003734"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Apr 2024 10:01:37 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Apr 2024 10:01:36 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 16 Apr 2024 10:01:36 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Apr 2024 10:01:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XgtSziyrggPjHoM/nYYJcd2w+0wWhzKp0gnNAZtxXEQRbVjWDDQ8mFtgDnS+k5/GdR4KjES40pRG7bYaEg05MWVhWHvbw4lFXrxgXKbBzBKOWJ4pqNE4fg8Lg3jgHpVma4zVEUhZ2Ubl+m1Q7C5qNyu2waVB09AW9BLfyngqwYRAY54f3Ao2mX571uX3gY7LKfBD8cj5fQVG3W52ULR9dCbRqAgNJRsRfi95k3notlCKhvFd/egQlREIoQIHj7WEGBovnMDC3OKt1pz4Wquekw+W4JtkVwEWEPvsvM/jLhSqBQOdiBsK4y5ZU525Ww2dFA1ECsAcEx0OrStlHsbJXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m8MXzBps4SAiauXewjj+cVdcOSI0oN4u03PcoZPBuZs=;
 b=KSiR7r+JqKC6P3GD+zwV9ZvfVxe1H7TqQs9aXOesBoS3ywnJRohMYQ9tRy51MvNVvKynXjEfL6pFWQ5oNzJddlN7a8Uvqf//o3IQjhoDTuYNor7SG3cgveirFm20N0t3aqIee7QfSCk21IpqRZK6eUoRBMsQ3jokXn2wiV3N9qvegGyhkVMai+LeoPU0SBV04sRYaByIRAG62/k1vzmNh6c1yyhPKOz9XE6LGZ7UvIAav3ROd75l0cN8N9KNOJp2SDW7mWp2/n7gL2mvNd+EHi16jQkvy55XJtkkj5ZqQckJ+8kMYfguM4tVfNlJIsNHmElT6ppGxScJaOht4DbDmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CY8PR11MB7266.namprd11.prod.outlook.com (2603:10b6:930:99::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7430.46; Tue, 16 Apr
 2024 17:01:26 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5c74:8206:b635:e10e]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5c74:8206:b635:e10e%7]) with mapi id 15.20.7472.027; Tue, 16 Apr 2024
 17:01:26 +0000
Date: Tue, 16 Apr 2024 10:01:21 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: <alison.schofield@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny
	<ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 3/4] cxl/core: Add region info to cxl_general_media and
 cxl_dram events
Message-ID: <661eaee1cadc2_3f1829294fe@iweiny-mobl.notmuch>
References: <cover.1711598777.git.alison.schofield@intel.com>
 <061d1eac5d4e270337911199f0b0633c0ff230b4.1711598777.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <061d1eac5d4e270337911199f0b0633c0ff230b4.1711598777.git.alison.schofield@intel.com>
X-ClientProxiedBy: BYAPR07CA0027.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::40) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CY8PR11MB7266:EE_
X-MS-Office365-Filtering-Correlation-Id: 35a56d0a-0f27-4bea-2b0c-08dc5e36da0b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kFBFAdYEBRJbQxD4GwTWEeB1C/XG5ZEqr1RSAx1S0LNbkCtlm9ITDZMJQALYv1grfnTyVLK1kOOA+C9gHTH5qDKXQiHFvL3WKBwglmRtdxzZX9s31oCReiI6Kh6b8RcZgMYXtCXdfovMtyHnbrh2SQCx8F/f4M03wQAwKxY5eV9AYZ4NL2m6gb0wgwX0vKXfWB+z8U8/rEuKD9zh7t+4oVe9ENX95RhJeFAYJRDZSjWOnzD5K+PWIIli+H8yhXwZyP7gyB9vi8mre+0AQuSS/2mXnPA67TcHvoJ3BufJoZguOdiK2ChwJauVesmaDELvZLlPxv4u+K6CtIqs+yqUOghBkaQUXRP7UWvaWdkG+S5bfpgUfr5vYsarI265kUG0xnbXmZ25oz5gyYJMGT9cR0CbHJbp1gzI2KsStHtfTDDD9pCVXQ2cm4wT5y8F/wCsniBeBmXWxFawV8HkzHaCL93cNC5/btwv3WuQgaLeuEoVWph9KcLMGlVt1qs1eE+xc1FHdMlASm+jc60DWzrWftLFRCkLPZw4rv4apW8Y3cgVk2hepQZbqsmkgUh3OdIggTb0SvExMd96IX4ZYMGjv87EF4wtdNLMEkWjNAIkwVaINWwWoVOz9tlu1bbV3T7ixqCXj8aLaPzfmP3iakfP/4Msxz57b29/99k6nx9Te28=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sUHskt6sFN+fnxS3HyMQ99qasxLWBnAQoUywomLJkwa+r8YGiMLVuqreDZYm?=
 =?us-ascii?Q?y5THylACXmW1fMt97uDLqSEQN4yEQ1qmARXWHT2BiSMrNFj/Tk675EICTKfO?=
 =?us-ascii?Q?aIeFNYHdw7xClBHRKToSAe7NmS0+mv8ka1V7d+1pSQdaier0yj+iwCSwsepk?=
 =?us-ascii?Q?MPpLOMv/BNf2REJFSZcfNU3vIR4bZyUW7sTWXGYjapN0yeD23qz7xVWaSlfk?=
 =?us-ascii?Q?ZJQhIxbsZ2p70JlLa8SAxmQLOvsH6uKKa8WqbgzPpga+z74+hytudPkM+RwM?=
 =?us-ascii?Q?CPdqKh/wHSlwPJlebad9fvJ0ovyIwNuObfu/waexu9r1dx2isoin6u9znpOb?=
 =?us-ascii?Q?O+W/rKz7pdxTeZpSCa6LBsx1rxZMT1YCyqDyPQz1MHs8wcJjXjPCohVvBQvN?=
 =?us-ascii?Q?G8TenFTlSmBItIv9Z48c/IiDsU+i1LEs7/8JRlI0khvijfQVnN2X2dQjp5+k?=
 =?us-ascii?Q?ZWxCI2cifuG3sNP/MVOwsv1OHi2jfgHY/GvR2yI5pw65GCL0Jmp80swHm1N/?=
 =?us-ascii?Q?WQ3usnk0Q63n5OSswFwdC6UDkfMtPGK/JgPnaaI7wUY9jJJMnRqmJ6Dfx8Wi?=
 =?us-ascii?Q?2iZrKnfisyryVZCCDAD5mptp22VJqZqrRMZdCmyGmdFrqRAXtndz5SQMWSL/?=
 =?us-ascii?Q?vBu9jyQiyBJs2M4Cp/iFr31stSF2hxPrM/Uog3w3NAnld+hNT2yik+TYSAjJ?=
 =?us-ascii?Q?sUNXE/KyV6BFeWHOTg3sI92VcHmdpA7QJC5uLRHbu0sw1/y6RSDaOfcbHKiP?=
 =?us-ascii?Q?fjElOl/EHwbEbhnfDKBaCqY8XcLU4Rx2snmrxYGaKzqqchiy3nSCnDXfj/lh?=
 =?us-ascii?Q?GtH1lmPBIAtbfvYKRzMjbqXE9TmoskccPp8OLGPE9dYfne8thfyS0DzaXdAY?=
 =?us-ascii?Q?WexTeHWdLzeUl2cxlowMAI05Tb7arUYxOLZjdFBNngZBPWqbON1BlQ6ZNXt8?=
 =?us-ascii?Q?+K1k4oDGRT+t08D3Vpp0Z3wnvIDVZQziSXCafzRK5Kba1mHEOte9uB9HpqVQ?=
 =?us-ascii?Q?/6KDYb4S1ElW8ecmfNs/loAoUpCiK8kpSgiY3ly4w2RjwLqiXh7q0jriv4L2?=
 =?us-ascii?Q?OknzMAJ5I8qwjaQs8AAaePKNj/HbMmEOZegSEp1SnJbKGx20E+7is/sB7eih?=
 =?us-ascii?Q?mAB/L3vtT53rLE8VlDcun1CbxulFD1IApDYQ6FoFPzJeVfQ+81LBJLJRE7eg?=
 =?us-ascii?Q?0NtsM7+a7EveMQTIIjY+5nPcIHTBoqovxvyfQJrLU4rDWph2s+6hkRnXkSYw?=
 =?us-ascii?Q?qoHlICUerkS1r8q/A8B+Qei/SOABNRqespjluB/8JR5JyGkcboL49OUiW8SG?=
 =?us-ascii?Q?aNncyfdZmwgI4V00nOKfIMldqlBBFgCQtdsZxNr9F2zvsyzV0gcivoaIfBY7?=
 =?us-ascii?Q?O9L1uGaBrwWYmeEHLuZCv8POVjbHkfVefNx7KTMs3cB5LmtXenzmXTX8TVKj?=
 =?us-ascii?Q?IyRvTY8dIrUdM4vCpIHPWfQ+8dcLrrzBMqKpGLbg3MIRBY0UDCLVGouPtOi2?=
 =?us-ascii?Q?uiZL+pNQwFsn8v/h3sc0iyMG9qq1wL1wfrZHl/P4aoLt6CJB8apHJ2pqlelc?=
 =?us-ascii?Q?CsQ9G8eW5VPOf+EYLACgF1qln9LH9lMunsEd096Z?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 35a56d0a-0f27-4bea-2b0c-08dc5e36da0b
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 17:01:26.0927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yud/mHTO1t2hedLyVc7CEWKbINHk+o7bYIVx8fZ/6RXnqMchd20qMP67tpaEEYTvzp8KOO6u9jznIA4B4xop+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7266
X-OriginatorOrg: intel.com

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 

[snip]

> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> index 161bdb5734b0..6ad4998aeb9a 100644
> --- a/drivers/cxl/core/trace.h
> +++ b/drivers/cxl/core/trace.h
> @@ -14,6 +14,22 @@
>  #include <cxlmem.h>
>  #include "core.h"
>  
> +#define to_region_name(cxlmd, dpa)					\
> +	(cxl_trace_to_region_name(cxlmd, dpa))

NIT: Is this macro really needed?

> +
> +#define store_region_info(cxlmd, dpa, entry_uuid, entry_hpa)		\
> +	do {								\
> +		struct cxl_region *cxlr;				\
> +									\
> +		cxlr = cxl_dpa_to_region(cxlmd, dpa);			\
> +		if (cxlr) {						\
> +			uuid_copy(&(entry_uuid), &cxlr->params.uuid);	\
> +			entry_hpa = cxl_trace_hpa(cxlr, cxlmd, dpa);	\
> +		} else {						\

Does the record get zeroed such that uuid is 0 here?

> +			entry_hpa = ULLONG_MAX;				\
> +		}							\
> +	} while (0)
> +
>  #define CXL_RAS_UC_CACHE_DATA_PARITY	BIT(0)
>  #define CXL_RAS_UC_CACHE_ADDR_PARITY	BIT(1)
>  #define CXL_RAS_UC_CACHE_BE_PARITY	BIT(2)
> @@ -313,6 +329,9 @@ TRACE_EVENT(cxl_generic_event,
>  	{ CXL_GMER_VALID_COMPONENT,			"COMPONENT"	}  \
>  )
>  
> +#define to_gm_dpa(record)						\

Curious: what does 'gm' stand for?

> +	(le64_to_cpu(rec->phys_addr) & CXL_DPA_MASK)
> +
>  TRACE_EVENT(cxl_general_media,
>  
>  	TP_PROTO(const struct cxl_memdev *cxlmd, enum cxl_event_log_type log,
> @@ -330,10 +349,13 @@ TRACE_EVENT(cxl_general_media,
>  		__field(u8, channel)
>  		__field(u32, device)
>  		__array(u8, comp_id, CXL_EVENT_GEN_MED_COMP_ID_SIZE)
> -		__field(u16, validity_flags)
>  		/* Following are out of order to pack trace record */
> +		__field(u64, hpa)
> +		__field_struct(uuid_t, region_uuid)
> +		__field(u16, validity_flags)
>  		__field(u8, rank)
>  		__field(u8, dpa_flags)
> +		__string(region_name, to_region_name(cxlmd, to_gm_dpa(record)))
>  	),
>  
>  	TP_fast_assign(
> @@ -354,18 +376,23 @@ TRACE_EVENT(cxl_general_media,
>  		memcpy(__entry->comp_id, &rec->component_id,
>  			CXL_EVENT_GEN_MED_COMP_ID_SIZE);
>  		__entry->validity_flags = get_unaligned_le16(&rec->validity_flags);
> +		__assign_str(region_name, to_region_name(cxlmd, to_gm_dpa(record)));
> +		store_region_info(cxlmd, to_gm_dpa(record),
> +				  __entry->region_uuid, __entry->hpa);
>  	),
>  
>  	CXL_EVT_TP_printk("dpa=%llx dpa_flags='%s' " \
>  		"descriptor='%s' type='%s' transaction_type='%s' channel=%u rank=%u " \
> -		"device=%x comp_id=%s validity_flags='%s'",
> +		"device=%x comp_id=%s validity_flags='%s' " \
> +		"hpa=%llx region=%s region_uuid=%pUb",
>  		__entry->dpa, show_dpa_flags(__entry->dpa_flags),
>  		show_event_desc_flags(__entry->descriptor),
>  		show_mem_event_type(__entry->type),
>  		show_trans_type(__entry->transaction_type),
>  		__entry->channel, __entry->rank, __entry->device,
>  		__print_hex(__entry->comp_id, CXL_EVENT_GEN_MED_COMP_ID_SIZE),
> -		show_valid_flags(__entry->validity_flags)
> +		show_valid_flags(__entry->validity_flags),
> +		__entry->hpa, __get_str(region_name), &__entry->region_uuid
>  	)
>  );
>  
> @@ -396,6 +423,8 @@ TRACE_EVENT(cxl_general_media,
>  	{ CXL_DER_VALID_COLUMN,				"COLUMN"		}, \
>  	{ CXL_DER_VALID_CORRECTION_MASK,		"CORRECTION MASK"	}  \
>  )
> +#define to_dram_dpa(record)						\
> +	(le64_to_cpu(rec->phys_addr) & CXL_DPA_MASK)

Oh.  'gm' was general media.  This should be a common macro...

Perhaps.

#define rec_pa_to_dpa(record)						\
	(le64_to_cpu(rec->phys_addr) & CXL_DPA_MASK)

?

Ira

>  
>  TRACE_EVENT(cxl_dram,
>  
> @@ -417,10 +446,13 @@ TRACE_EVENT(cxl_dram,
>  		__field(u32, nibble_mask)
>  		__field(u32, row)
>  		__array(u8, cor_mask, CXL_EVENT_DER_CORRECTION_MASK_SIZE)
> +		__field(u64, hpa)
> +		__field_struct(uuid_t, region_uuid)
>  		__field(u8, rank)	/* Out of order to pack trace record */
>  		__field(u8, bank_group)	/* Out of order to pack trace record */
>  		__field(u8, bank)	/* Out of order to pack trace record */
>  		__field(u8, dpa_flags)	/* Out of order to pack trace record */
> +		__string(region_name, to_region_name(cxlmd, to_dram_dpa(record)))
>  	),
>  
>  	TP_fast_assign(
> @@ -444,12 +476,16 @@ TRACE_EVENT(cxl_dram,
>  		__entry->column = get_unaligned_le16(rec->column);
>  		memcpy(__entry->cor_mask, &rec->correction_mask,
>  			CXL_EVENT_DER_CORRECTION_MASK_SIZE);
> +		__assign_str(region_name, to_region_name(cxlmd, to_dram_dpa(record)));
> +		store_region_info(cxlmd, __entry->dpa, __entry->region_uuid,
> +				  __entry->hpa);
>  	),
>  
>  	CXL_EVT_TP_printk("dpa=%llx dpa_flags='%s' descriptor='%s' type='%s' " \
>  		"transaction_type='%s' channel=%u rank=%u nibble_mask=%x " \
>  		"bank_group=%u bank=%u row=%u column=%u cor_mask=%s " \
> -		"validity_flags='%s'",
> +		"validity_flags='%s'" \
> +		"hpa=%llx region=%s region_uuid=%pUb",
>  		__entry->dpa, show_dpa_flags(__entry->dpa_flags),
>  		show_event_desc_flags(__entry->descriptor),
>  		show_mem_event_type(__entry->type),
> @@ -458,7 +494,8 @@ TRACE_EVENT(cxl_dram,
>  		__entry->bank_group, __entry->bank,
>  		__entry->row, __entry->column,
>  		__print_hex(__entry->cor_mask, CXL_EVENT_DER_CORRECTION_MASK_SIZE),
> -		show_dram_valid_flags(__entry->validity_flags)
> +		show_dram_valid_flags(__entry->validity_flags),
> +		__entry->hpa, __get_str(region_name), &__entry->region_uuid
>  	)
>  );
>  
> -- 
> 2.37.3
> 


