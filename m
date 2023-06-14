Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD7B8EB64D7
	for <linux-cxl@archiver.kernel.org>; Wed, 14 Jun 2023 00:15:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232873AbjFNAPp (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 13 Jun 2023 20:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbjFNAPo (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 13 Jun 2023 20:15:44 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84CE8127
        for <linux-cxl@vger.kernel.org>; Tue, 13 Jun 2023 17:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686701740; x=1718237740;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5TUEGnVu3Nm+zlyog2/BUTswoyZZC+JlUQsSYsGvrrA=;
  b=DcTICLA7jeWBQiRtsN2hk81IYjvPzxKqlkSAeP042UxDyVGxJROa7dzq
   59kSwUj5QuPxvXT381r02ZTDef3rW0YuV9yAEv7Nx2KQt+mBy11DQFvCv
   78X7HPJb2cFQK6uU4MWfaXzRMea2Wc0ruRoiSjIgIP4zd4QL4RO+6jbuo
   +fzEZm+B27UJ5Gg+VuV09RZSHhsaYZy6V7PGyh6+nO+S9aFir8/Db1JmB
   WDi4xErV/aowG+8QO15FSnE/fiM+DMmdeoA9QaEU+OVYddGCIt9g/cglP
   7t/cjuw1E3jFoE5YxpH2oQSUy2za5SiU3tbkSwYYJ6Ry6/Bj/T3QAbUz8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="358485118"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="358485118"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 17:15:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="824605554"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="824605554"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP; 13 Jun 2023 17:15:40 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 17:15:40 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 13 Jun 2023 17:15:40 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 13 Jun 2023 17:15:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EnTTij10arRmpA14Co6wRWTtE0ykoy2JrJNPFNxn6ELTReMKjjHUIeP0Ay9Hdim777t33CtNFKt5hPQOv5V2Rd41zzCjMgd6ihD3NSD2CCX5N8M4EzxGCsQ1oHm6KTzXNt/xJFhMPSuqB+ytYmsI6+lHIva3ruz1TohRogPe+Ux87t54c/G5o480rFAj5JrzDBZvxLiP1zHC419AXRPQnsxWGW7p9nbI8i5+boWu9JuBAybAhM6wmfzcJX3AdakHxuOATOQqpOAtoJIK7vFrBT/EakBPHuklRkjktFeVh8qbG69kBxAxpaVJ3XY5hlWPxDpaFnSQAFCnkObd0efJDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=emhn3hy7INoect3ur10bztCm6dZCq8tcLdPsWjc8mkY=;
 b=DxznGyuXdlLVzDc6GSEzj/hFhSZfHSUYbJbkSWnn1mFy1/CKk9lNhxENom7yi1xGHQVm1V4zl7bEaeLQZac7G5Lkym/wSTJqkMAuJTC8WCTfVyq/G16MYiFovETvREw4k1xiNmmlqdavmtr/+P25ByMNNRZZJngy/hf5kDAwtpGDGJOjOTbb5R6Ht1qU0LhVBhXGc8T6nWNBN6C0mwLMk/yYDODYTVIHc9QYmq1PVaT7oNKfk1qxfHHiIYEfuuOX/bOzVcHoup6IPb8XCNngFUHHcUptXx/umGGNqdNp7ihd9zH4IZMKj+vaiO+GW5rgQnt3fijXHSzYGNQMzKso0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by PH0PR11MB5061.namprd11.prod.outlook.com (2603:10b6:510:3c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Wed, 14 Jun
 2023 00:15:37 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528%7]) with mapi id 15.20.6455.043; Wed, 14 Jun 2023
 00:15:37 +0000
Message-ID: <9cf84597-ad17-bb06-732f-43ece6750ee3@intel.com>
Date:   Tue, 13 Jun 2023 17:15:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.1
Subject: Re: [PATCH 17/19] cxl/region: Define a driver interface for HPA free
 space enumeration
To:     Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
CC:     <ira.weiny@intel.com>, <navneet.singh@intel.com>
References: <168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com>
 <168592159290.1948938.13522227102445462976.stgit@dwillia2-xfh.jf.intel.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <168592159290.1948938.13522227102445462976.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0382.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::27) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|PH0PR11MB5061:EE_
X-MS-Office365-Filtering-Correlation-Id: 38c0bc4f-3bea-4bad-c459-08db6c6c7a31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0g0vLxMXjPy5K+6hubtR3anekeB8kuSK70bT6Un4od+ulhf+gBqTs/25aSao8ytbzLmZSUPJtAgAjSIA0jhnGbR9UFC4vas1AQ6kZ5Sx8DRUjXU4HbwwJLRc8A98xQhwKZmM63BSs2nRmW1f/K4g2zaUQdzPnSEl7SbjVHoTWt9US8dju4k6zPjongtP/KLFTLMs2VEhLMkIBwIOBadQAvH0VWnTcVQug3OEYUvpWhQvJbXCeNJ5nSlbx5MI3khlZWdMxSVF90qsl9TSxd6mGCy9qwqwP6yjyG6m2g79CYnrKMa/bo4I6ZQeQXOOTsfsVyPhfi2OwO/qjl1D4AwJZJPqHiOh+xQH5hxipee1jFCdpFV+Ow+nx6yGbVygDlw8VKvWLHR+AgQ73Vy2WXUB2h+Hmhii/X9U3xyHlCu7yrwVciKVrs5zJHMCOQq4XJ4q1kgmrIVACzeEg3eba4nCMz0jLrfYjPk94B/jX7mZVhUo3TcT1GAHiz8sbtrqmua3KejvFY63HCPNV99PiNErLh2P4jXqXmjbXFUCAdCCaq8+U7JXQFgCpJqGXH0cvnhv53wBiajziHW8yH8SOoAlWyH+JcrVxOPE4vs5iiXAudaIUkE/5eolfu1awODmaglGadB/aMqxvUz0yrol5O+pmg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(346002)(376002)(39860400002)(136003)(451199021)(107886003)(6486002)(6666004)(36756003)(83380400001)(2616005)(38100700002)(31696002)(82960400001)(86362001)(6506007)(26005)(53546011)(6512007)(186003)(2906002)(4326008)(5660300002)(8676002)(316002)(8936002)(41300700001)(31686004)(44832011)(66946007)(66556008)(66476007)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blNwK1JCbWFvVCthQ0NoaitLdE1jRGhHaDRhNjRHNENTSTlRdzhIQWNWZmVC?=
 =?utf-8?B?dGIwTHFFd0lUVEFNa0EzNjJlQ0dtRGNkWHBHMUVVVm4xVGZVd0dVWXBOSnBa?=
 =?utf-8?B?eGlXT3h6WWVxNDVtaXRUeFc4NHgzQ3h3TnhqWndvMEM4STRRVnNxekl1Ukp0?=
 =?utf-8?B?bmN4YzR2NVdkSEVXQlptcWorWHZSeTJ6K1d6ZmdUTWQvREZleHU3a3VaZllw?=
 =?utf-8?B?QmJBVE9xWUpFcjZETTZBdmdCMHVCTEFiR2RHSENYUy9yUlRVaGw2N2dPN0R5?=
 =?utf-8?B?WlErbWdWVkJnNEo5VmFKbEtkY3BRSkdxRXBmYnNYK3VkSlMwRWZERnZXZExW?=
 =?utf-8?B?V2RsRS9KcFZnZDlhVmZLY25KYUNqTlQ1ejlKWXZEWGREbDJwaHJCaldZdVh5?=
 =?utf-8?B?QmlwZzhVM3htTWZRNGUwMTNmM3JWSTc0OFFBMlk1OHVHcXE5WnlTRmFibENw?=
 =?utf-8?B?OHk3Ry9ISGtCWE02K2tXT0xUaXFVdFRSS0RQU3JVdlFSc0ZTQnFJOTZVNHRU?=
 =?utf-8?B?UnJ4OXBIZmYvV3lqekZaazB0NldVRkNKU3Y4V2F6K25rZ096WXczTC84dGZ2?=
 =?utf-8?B?c241SFM1REZPZEZZenFrQTl5dlhmcUw1SGdpK0VCelljTm1hTENrQWM2TitP?=
 =?utf-8?B?TXIvWmpYWmdpbStiZ1JPc3pGUDAyMUFqb2R5TDRVWHA5QXpMWXg1bU9aZ0t3?=
 =?utf-8?B?bWhGVlhER1B2TTJQb2diRi9wdm1vUDA3SGJhTmRYUXJlTzBVQWVhQ08yZzAx?=
 =?utf-8?B?cTVvRURmZW9DRFJXbFRSV0Z3MktPZk14bVpGNmlmZ2J4Q2R4ZTY3TE15NEdR?=
 =?utf-8?B?Wlp2U2xCS3FIZjBsV1pteDNyRm53MUU3bzFaQjBlRjJCRGVFdlhVT1RqNGpL?=
 =?utf-8?B?Zktia0lvZWNtZGZJTmFadFZkMHBjNDhTdUJmZHB5NStLcVFyKzVhSjFaaFZY?=
 =?utf-8?B?U2dQRzg0VXVtU045ZVp5QXFKa2tsTElmUTlROXZGTzJwajZ4M0c4a2E3OUZF?=
 =?utf-8?B?SHhuc0FMTGRLL1crRDREWkZoTUIybXBVdk5wRE45LzdCQUsvWUpyZmVqVC9o?=
 =?utf-8?B?b0JQcmFrZVFvcm1OWnNGYnpFRkZIKzdSakFoTFd2OFFQTTRJWDJpVDc0VXFG?=
 =?utf-8?B?UkFCYWljcm5nV3BNK1g3T1ZQajZEOGZvck03Rnc5NEtWdFhVUHYybEtsNUNz?=
 =?utf-8?B?MGl3OXp3S0RBTVEyeWw4TkMyT1htR2lWVlZIYjVXWjdqM01iU3lsWWd2clBQ?=
 =?utf-8?B?a1c0ZncxamlXYzZRQjhDSk1paHhCSDZGSHFhTGhDSkRTRUpIbG9qb080L0t2?=
 =?utf-8?B?Qk9jQUo4QTBpSXF6Syt6cnBNTGhlZ2dGVG15d3E3Mzl3ZVNkc0NTdm54RW1j?=
 =?utf-8?B?MWlNRnVHZ1lNa2x0QTdPbWo0SHBSQ2REeWVFOWhnQm1YQzJPMWk0T2tJRlVI?=
 =?utf-8?B?TXJUNHdKYk00alk0bWlxVEdhOTBxVVFRMTBXSGpVUjltYm96ZDRtbmtPOWtm?=
 =?utf-8?B?ZE1ocUhBbWlLR2s3TmVRNHhlMWtvb2pXY1o1R0xMNENlZFNPbVNXQWZFcENT?=
 =?utf-8?B?TXdMNGRCd2R6TlpMWmI1Q1c2Ty9ldlpleDU1WnN5elk1SUZtR3J3bDYzams2?=
 =?utf-8?B?cTNmdDJLV3ZRTGRPWkVyQkR3MXdzY2QyRFFhem9GUDlEZE9kZE5hdXBmeDlS?=
 =?utf-8?B?eHdCbUkzY2d0cFB4Uk12ZmljRGdmSGdKTnlCR2diL0Z2cENLaTRWRXRNTFcv?=
 =?utf-8?B?WVRxbzlFZkpDN1VMS2lLRVBRR3FCc1BQRkllc3dyNkY5OWxXc0ZVejRrZmp4?=
 =?utf-8?B?dUFCb0xiem1WcXRPRzA1eTgzYXdLUmRQVXVWODZ3U1NkWTdSZVlicWo0UVRt?=
 =?utf-8?B?L3FrdklrdGFlTCtVcnFZejdqbGl6VFcvL1VzYWFNVkVTNDUxSnZTTTVzdExN?=
 =?utf-8?B?QzlWaWxDSDBEVEFKYnRQUjNzWFJHZS9VaGdEWS91cHRNM2daZytKZ0NyVFZI?=
 =?utf-8?B?TzMvMG9XV0hEb3hJSjNaeSs3dXAxOTdiUHZFU0tSRTFoRkFIRW83ZjV0eC9p?=
 =?utf-8?B?WnRKWVlIR0xzYTZ2d0tOcUNML2lzTzRiMU5kM2JNWEttSWpsM1VFZnp5eHZm?=
 =?utf-8?Q?iYoKm7o1oVyFG39TXLktAWwDp?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 38c0bc4f-3bea-4bad-c459-08db6c6c7a31
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 00:15:37.0494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xtLuwCDmwpySjJVZi6CagMEK1tH1ECFiZP4VcXVlUzBLMvaJ94TgiC0HydviZSGx0U/tLsB7rrghwNBR6SD9yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5061
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 6/4/23 16:33, Dan Williams wrote:
> CXL region creation involves allocating capacity from device DPA
> (device-physical-address space) and assigning it to decode a given HPA
> (host-physical-address space). Before determininig how much DPA to
> allocate the amount of available HPA must be determined. Also, not all
> HPA is created equal, some specifically targets RAM, some target PMEM,
> some is prepared for the device-memory flows like HDM-D and HDM-DB, and
> some is host-only (HDM-H).
> 
> Wrap all of those concerns into an API that retrieves a root decoder
> (platform CXL window) that fits the specified constraints and the
> capacity available for a new region.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>   drivers/cxl/core/region.c |  143 +++++++++++++++++++++++++++++++++++++++++++++
>   drivers/cxl/cxl.h         |    5 ++
>   drivers/cxl/cxlmem.h      |    5 ++
>   3 files changed, 153 insertions(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 75c5de627868..a41756249f8d 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -575,6 +575,149 @@ static int free_hpa(struct cxl_region *cxlr)
>   	return 0;
>   }
>   
> +struct cxlrd_max_context {
> +	struct device * const *host_bridges;
> +	int interleave_ways;
> +	unsigned long flags;
> +	resource_size_t max_hpa;
> +	struct cxl_root_decoder *cxlrd;
> +};
> +
> +static int find_max_hpa(struct device *dev, void *data)
> +{
> +	struct cxlrd_max_context *ctx = data;
> +	struct cxl_switch_decoder *cxlsd;
> +	struct cxl_root_decoder *cxlrd;
> +	struct resource *res, *prev;
> +	struct cxl_decoder *cxld;
> +	resource_size_t max;
> +	unsigned int seq;
> +	int found;
> +
> +	if (!is_root_decoder(dev))
> +		return 0;
> +
> +	cxlrd = to_cxl_root_decoder(dev);
> +	cxld = &cxlrd->cxlsd.cxld;
> +	if ((cxld->flags & ctx->flags) != ctx->flags)
> +		return 0;
> +
> +	if (cxld->interleave_ways != ctx->interleave_ways)
> +		return 0;
> +
> +	cxlsd = &cxlrd->cxlsd;
> +	do {
> +		found = 0;
> +		seq = read_seqbegin(&cxlsd->target_lock);
> +		for (int i = 0; i < ctx->interleave_ways; i++)
> +			for (int j = 0; j < ctx->interleave_ways; j++)
> +				if (ctx->host_bridges[i] ==
> +				    cxlsd->target[j]->dport) {
> +					found++;
> +					break;
> +				}
> +	} while (read_seqretry(&cxlsd->target_lock, seq));
> +
> +	if (found != ctx->interleave_ways)
> +		return 0;
> +
> +	/*
> +	 * Walk the root decoder resource range relying on cxl_region_rwsem to
> +	 * preclude sibling arrival/departure and find the largest free space
> +	 * gap.
> +	 */
> +	lockdep_assert_held_read(&cxl_region_rwsem);
> +	max = 0;
> +	res = cxlrd->res->child;
> +	if (!res)
> +		max = resource_size(cxlrd->res);
> +	else
> +		max = 0;
> +	for (prev = NULL; res; prev = res, res = res->sibling) {
> +		struct resource *next = res->sibling;
> +		resource_size_t free = 0;
> +
> +		if (!prev && res->start > cxlrd->res->start) {
> +			free = res->start - cxlrd->res->start;
> +			max = max(free, max);
> +		}
> +		if (prev && res->start > prev->end + 1) {
> +			free = res->start - prev->end + 1;
> +			max = max(free, max);
> +		}

Can skip the extra compare, not sure if it's worth the extra level of 
indent.

		if (!prev) {
			if (res->start > cxlrd->res->start) {
				free = res->start - cxlrd->res->start;
				max = max(free, max)
			}
		} else {
			if (res->start > prev->end + 1) {
				free = res->start - prev->end + 1;
				max = max(free, max);
			}
		}


Same below.

DJ

> +		if (next && res->end + 1 < next->start) {
> +			free = next->start - res->end + 1;
> +			max = max(free, max);
> +		}
> +		if (!next && res->end + 1 < cxlrd->res->end + 1) {
> +			free = cxlrd->res->end + 1 - res->end + 1;
> +			max = max(free, max);
> +		}
> +	}
> +
> +	if (max > ctx->max_hpa) {
> +		if (ctx->cxlrd)
> +			put_device(cxlrd_dev(ctx->cxlrd));
> +		get_device(cxlrd_dev(cxlrd));
> +		ctx->cxlrd = cxlrd;
> +		ctx->max_hpa = max;
> +		dev_dbg(cxlrd_dev(cxlrd), "found %pa bytes of free space\n", &max);
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * cxl_hpa_freespace - find a root decoder with free capacity per constraints
> + * @endpoint: an endpoint that is mapped by the returned decoder
> + * @host_bridges: array of host-bridges that the decoder must interleave
> + * @interleave_ways: number of entries in @host_bridges
> + * @flags: CXL_DECODER_F flags for selecting RAM vs PMEM, and HDM-H vs HDM-D[B]
> + * @max: output parameter of bytes available in the returned decoder
> + *
> + * The return tuple of a 'struct cxl_root_decoder' and 'bytes available (@max)'
> + * is a point in time snapshot. If by the time the caller goes to use this root
> + * decoder's capacity the capacity is reduced then caller needs to loop and
> + * retry.
> + *
> + * The returned root decoder has an elevated reference count that needs to be
> + * put with put_device(cxlrd_dev(cxlrd)). Locking context is with
> + * cxl_{acquire,release}_endpoint(), that ensures removal of the root decoder
> + * does not race.
> + */
> +struct cxl_root_decoder *cxl_hpa_freespace(struct cxl_port *endpoint,
> +					   struct device *const *host_bridges,
> +					   int interleave_ways,
> +					   unsigned long flags,
> +					   resource_size_t *max)
> +{
> +	struct cxlrd_max_context ctx = {
> +		.host_bridges = host_bridges,
> +		.interleave_ways = interleave_ways,
> +		.flags = flags,
> +	};
> +	struct cxl_port *root;
> +
> +	if (!is_cxl_endpoint(endpoint))
> +		return ERR_PTR(-EINVAL);
> +
> +	root = find_cxl_root(endpoint);
> +	if (!root)
> +		return ERR_PTR(-ENXIO);
> +
> +	down_read(&cxl_region_rwsem);
> +	device_for_each_child(&root->dev, &ctx, find_max_hpa);
> +	up_read(&cxl_region_rwsem);
> +	put_device(&root->dev);
> +
> +	if (!ctx.cxlrd)
> +		return ERR_PTR(-ENOMEM);
> +
> +	*max = ctx.max_hpa;
> +	return ctx.cxlrd;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_hpa_freespace, CXL);
> +
>   static ssize_t size_store(struct device *dev, struct device_attribute *attr,
>   			  const char *buf, size_t len)
>   {
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 55808697773f..8400af85d99f 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -686,6 +686,11 @@ static inline struct device *cxled_dev(struct cxl_endpoint_decoder *cxled)
>   	return &cxled->cxld.dev;
>   }
>   
> +static inline struct device *cxlrd_dev(struct cxl_root_decoder *cxlrd)
> +{
> +	return &cxlrd->cxlsd.cxld.dev;
> +}
> +
>   bool is_root_decoder(struct device *dev);
>   bool is_switch_decoder(struct device *dev);
>   bool is_endpoint_decoder(struct device *dev);
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 8ec5c305d186..69f07186502d 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -93,6 +93,11 @@ struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_port *endpoint,
>   					     enum cxl_decoder_mode mode,
>   					     resource_size_t min,
>   					     resource_size_t max);
> +struct cxl_root_decoder *cxl_hpa_freespace(struct cxl_port *endpoint,
> +					   struct device *const *host_bridges,
> +					   int interleave_ways,
> +					   unsigned long flags,
> +					   resource_size_t *max);
>   
>   static inline struct cxl_ep *cxl_ep_load(struct cxl_port *port,
>   					 struct cxl_memdev *cxlmd)
> 
