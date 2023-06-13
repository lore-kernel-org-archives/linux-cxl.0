Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07332EB64D7
	for <linux-cxl@archiver.kernel.org>; Tue, 13 Jun 2023 23:53:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjFMXxO (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 13 Jun 2023 19:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjFMXxN (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 13 Jun 2023 19:53:13 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9895101
        for <linux-cxl@vger.kernel.org>; Tue, 13 Jun 2023 16:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686700391; x=1718236391;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iKanGybA0mjsfNxgnKvxnnjvI0/WbeIQiOI8a0L1Njg=;
  b=UDokTj6p03AYRnEXK9eGt0LESYl/KW8r0OW+dvpjPI5d9gvITjKNq8az
   tLCxrzNzKTJYcCVv1y7F6VRJj3xPmHAEaUSod1OtNs/J0GMmitNDWDm+h
   8rHWmSnwhSMnXlRlIAAeyqyJDCKnC68vWFUZEs1X7NT7IpQl6ZsRcM/g8
   lL6yUKeh/1jfqIa29hGL3uvTbYpIKq1FBZHIyRGAe/E3h1sULzbgwh10l
   OzXF7P7VyNx33kp8DtKcIXZhiC4odVV6oWx+CejzhTiiGuva+O432YgMT
   0MwAqundS54Z2B0cjpWWQbArGJfw7nPF/m53vl8ItuzMMIIu62efYZcTd
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="355976650"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="355976650"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 16:53:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="801691986"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="801691986"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Jun 2023 16:53:11 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 16:53:10 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 16:53:09 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 13 Jun 2023 16:53:09 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 13 Jun 2023 16:53:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g/jCWa0KeAiZ4HXWp5Hn5TUmXIWGVCsSs98TfBWu2jnBX05lmEgcs8obAY7r8Ush9Q+/GvUWAww4I+f3mlOVgQnV9/YYv2BFaGnbCFXxynS4JkCUsBOy1qWS5u/CQ0c5CgAmS3Oqu2w5or3Oy/yMMelAMFouI5ctbGQ1Rei1/TzmXYRId6PJFWKTWz4bSi+SRk5l7WOXXIB3poIBzDomYiyOtNnAvMqKVQGtQjHuB8R6/GmAnyf1gqdek2qpPpsXt2dHrZ/b0opGQ4LulvCGr6tFCopSxeSgNJqOJTJSbLGvBLWfXl7kqUx3/vp1a3ZJKzpxftXO7tExZ8OL7Xvacg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SkiAPJJu6iMfRb80Kkyd90M6Uz0VFCIsLwBsfq/3oJw=;
 b=iCu6hmSYIM+i7ck8RPWaBoUI3w8NmORvXpXFJ2bNz7KjQhmRiN2DOwXdBt1iJO/XengYia6yhhHLFKrDOwt0POJR+rz/lAepM4+Ozb7BOuefe2kKvWJ34KJcQVbeJT/65RKNK5mPloggsvpPJss5JO1BeU3O26rF843EKDq14TWbFSy41T+dr4XX+osOcW8y2GAhnSQuQf+WEnipWxeuHxpFdtkZDp/fYY1VhBu/PGvu6H/u3o5SFGIfvesCNukSavlsyAegtNQTTPzsPdf1Levo2qh6cix7i2F2NhnFnBqCxfHb2rykzjgYZVZSQyJhsTQoBOjCdXAh0vDorHrogA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by MW3PR11MB4649.namprd11.prod.outlook.com (2603:10b6:303:5b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 13 Jun
 2023 23:53:07 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528%7]) with mapi id 15.20.6455.043; Tue, 13 Jun 2023
 23:53:07 +0000
Message-ID: <98b1f61a-e6c2-71d4-c368-50d958501b0c@intel.com>
Date:   Tue, 13 Jun 2023 16:53:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.1
Subject: Re: [PATCH 16/19] cxl/hdm: Define a driver interface for DPA
 allocation
To:     Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
CC:     <ira.weiny@intel.com>, <navneet.singh@intel.com>
References: <168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com>
 <168592158743.1948938.7622563891193802610.stgit@dwillia2-xfh.jf.intel.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <168592158743.1948938.7622563891193802610.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::36) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|MW3PR11MB4649:EE_
X-MS-Office365-Filtering-Correlation-Id: d4ffe1ce-8766-44f5-28a0-08db6c6955aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yww0TroXWh9ikckYvhsoMnkxOp3srgGqWDdbxKFyYkRa0Pe9RHUTQthj69xF20G8ufPzsnEs1k9L72cg5wdzJLgEzL8YAN/pHSPFA+nIS4BQtqL3BrjaZGSsr8qsnMUUT27MOENwvtPFKtSBlo2VBdTLokhdqh8l2liHXGC366N5xRrUbJigmVyZQJr7UKkojyhndTAawY07qGdq246u/5iM63oSNJdDAlZHeBdQiD/Me0j2MI6+DbWHhghMJf7+QYFZbraAPoeYyke2/qUUUW2RtGJYbe7RdHl7GMiCQNdH/vFb2f0ITj7DJNX1QzHxMJpgluvlmP8LkUYSC03Es1FzkLCwTmLfVqG7Ktji1Raw8Ex4Dv6+RfVk7qpdhzol5mmdhfcODp/GxwGz2Ws7Pcg9ehmRCt0UKCRShZMp0eDBDNJ+taomx2w9KJXb3jjHWrHVG7HpPblfTN/WJwgf5p98yswxEZ2aWy6zUtaMs8oVhMtDAZtJjXFSTEtQfwfd9hdWMcANW0y32u6En2WzS4PTr8EF+4KithXxoTq0V4R3r3qnGrnQeTJIVyqX46GRnpadE9EiloePewhjO0QRlX6XKiB1Rp71fI98WJP5w+LdwJ/iDM0Q1W/6STSLMFd2Y5RTwIIYS5CFSAkG+y1uzw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(39860400002)(376002)(366004)(136003)(451199021)(6666004)(4326008)(66476007)(66946007)(5660300002)(44832011)(66556008)(2906002)(41300700001)(31686004)(316002)(107886003)(8676002)(8936002)(2616005)(6512007)(53546011)(186003)(83380400001)(26005)(6506007)(86362001)(31696002)(82960400001)(478600001)(6486002)(36756003)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2tQcGxNUmVEWWZxUllxTTVRSmtxZjB6UjFCSHhRZTVhSmdIOStQYlRKQmFy?=
 =?utf-8?B?azkwU2ZlQ2c2YzlqMW5QMExYZ3U5eDdPVjBvbTdjd2V3U01Tb0ZzdHRmaWRs?=
 =?utf-8?B?aE9QVHU4RUZQemVqUUlvTmdGdEkxQm4wOHVaU3JxakdtNjNQUVdaRmkzY0R1?=
 =?utf-8?B?NnpiNnRLWUZ3eDN6WERUV05rTG9VS1RuS1Ntbk55VU4rb2VNSS9yamQ3NVlv?=
 =?utf-8?B?QUZBYzNwd3BJZUlKZmRNRWh5QXE3emRkTWgyanVFM2kvVC9lZDNhYnBIRld4?=
 =?utf-8?B?MkY4SWY3KzBQcjN1UW53cXZzeGprQXc5YmxNSysxSVZtZ2xkbC91aEIvNEd0?=
 =?utf-8?B?Q0wxTXVSMG1pVTdJR1diQ3o3bk1jV1NvS0t4MWg3c21OL2EwL0RaSDgzZDVr?=
 =?utf-8?B?LzNWbnFDbGkzSUYxNXdsTUg4L3RHclprNXBndU5YVFVCVkhxdHNlbWJjWXZ2?=
 =?utf-8?B?RUVvdWpJMmE2Z3F2cFhkNzJDc2NxdldRRklwQTJkMHl0TEdXcy9aTkpCRzFv?=
 =?utf-8?B?Qm5odWtiTzVpd2VWakkydUFMcjQ4eFZzZFhGSVhlN1RLNXQ4SGZqeEUzVi9v?=
 =?utf-8?B?L0YyNS93M0E4em9CZVJsaStxbWpCZ1lEaHlCWW5WQ3pOeVRLN011RW1kSlFx?=
 =?utf-8?B?b3J1UzVldFVsV0tQQ1drN3REMk5GYW5PcDVYTHBTbS9JNER3WTFkRlE3bmFH?=
 =?utf-8?B?bHBUZW5NWEtUempxSGE2TUV1cXBoQXpGODdhaDJjaEpWbzlpSFJaWmpFdzdo?=
 =?utf-8?B?d09BNEgycXh1UVBqUWlWUW9JR0ljMEx3M1RvVE9ZWGJ0YWFRWnU3MFVtbm1C?=
 =?utf-8?B?SGkyWnVnU0sxemVnTHdyZUI4MVJuUFJxbUMrcldaRDZobm55NHIyY0dEQStT?=
 =?utf-8?B?OCthR1FNdDk2VXZvQ1l3L0lNOVJoNXN4S1h4a0xvWUxmdFd0YnhsWG9KeU5J?=
 =?utf-8?B?VlU4NVB4R3NOYjFUeVNjUWg3RjZqcnp1ZmxmVk9PUzNHc3Vqc05QN2J3SUw1?=
 =?utf-8?B?V1c1RmZzbjlWQml3RU90NHNhSVNjbFdnSEkxcUtJTENqRVNhSVpvUEJrSkhG?=
 =?utf-8?B?bXdUN3h5ZjBacytKUm1TdmMzWGtDYlZKMGN4TnNvSjh5MFBwNEh2aFdkamt5?=
 =?utf-8?B?UlZqTnhJeERHQndQK1NqMXRlcVY2ZWs1WXI0QVZDVlE0N09Id2cxRmNJeUJD?=
 =?utf-8?B?cm1WcFhzSDRoMVhPUVp6aVVxWnhUbkNNcm5xNFNJSTN5SzBjNGJPdFhuM1I5?=
 =?utf-8?B?ZDdMMlZ2ekRrTytvekRqNWhwenVQbnhzbS9iMkpFdlc5TlhhQ2VPZW1CSWhF?=
 =?utf-8?B?WDVCdEpDbzNYL1RKa3BzbnFWcDhwSG1kRVpveFVhVEFaOTI5Ym84bk56R3dO?=
 =?utf-8?B?eGt5cGRHYmdVR1JNRVIxVUtiY0FvWUs3bGtyUXJjWnNlY043UjJKb2ZBZDZS?=
 =?utf-8?B?NDVrVjRycXNkL09TaXhkaDFNenM2bVlWdU5QSXdNZUozQVNkbW1ZeEUvK2hH?=
 =?utf-8?B?T21qMmpXSjc2YWdCejZwTW4ybnoySlF1aks4cFF6OEVQb1hSNFVWaVZTblhz?=
 =?utf-8?B?QzlNR2pFdzBqeHdaWnhxZ3EvaXJ4SVRBZjcxWHpFRnlKT1pWTzkzdGdNMmxY?=
 =?utf-8?B?RW9NZHI1akxkYTRlT1hEWGlyQ2RWMUdNc25LU3g1ejJ0Y3V1SGlIWjRtWklE?=
 =?utf-8?B?RFA4MU0zUkVSRmoxOUg4UXdlWERCQnEvN2owemk5aVRUZDRqVmE1VnhmYVE0?=
 =?utf-8?B?eXdmaEtwOVpyVWdITk1VY0pqejNYVlRlQ094R0E4VUg3K2lhMmhtRjVFNmpv?=
 =?utf-8?B?K1JhNUcxd2NLQTFjQ3ZwSGZWNDlIS0hLUTFvVzlEYysrbjZxT0ZuL3cyZzA1?=
 =?utf-8?B?aUVidWlBYWMxb0Y5UCtBRzNCaFV3K1UrZk9lWDRKcnlpWlJiejZHaTZnYSt5?=
 =?utf-8?B?WlhiQzdNWU5nanNSM0l3TW5iWEJIMURKbVhRZDVacFBXWEZMYlc2YkhMVXRW?=
 =?utf-8?B?bkJaN29lbDBvdk8xNTJGQWRZQ1hQQlpZRmFuWVNLMEFEbEE3RENYams1QWpP?=
 =?utf-8?B?SG5DcndnNHF0SFNIVWd4V1IxVStsUGIrejFtQU94WjkxUnVGL1Fxa1B6a0hP?=
 =?utf-8?Q?dW0m6/0jflVKeXc1X2vmPbF8D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d4ffe1ce-8766-44f5-28a0-08db6c6955aa
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 23:53:07.0228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UrViwB6HiEwijQGVLzMx6DDazH++Pilj8Q2k3y0sAusTRBULqWAmHuF/Jl1H86YwZfLCahA6OmInv/V1366aVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4649
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 6/4/23 16:33, Dan Williams wrote:
> Region creation involves finding available DPA (device-physical-address)
> capacity to map into HPA (host-physical-address) space. Given the HPA
> capacity constraint, define an API, cxl_request_dpa(), that has the
> flexibility to map the minimum amount of memory the driver needs to
> operate vs the total possible that can be mapped given HPA availability.
> 
> Factor out the core of cxl_dpa_alloc(), that does free space scanning,
> into a cxl_dpa_freespace() helper, and use that to balance the capacity
> available to map vs the @min and @max arguments to cxl_request_dpa().
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>   drivers/cxl/core/hdm.c |  140 +++++++++++++++++++++++++++++++++++++++++-------
>   drivers/cxl/cxl.h      |    6 ++
>   drivers/cxl/cxlmem.h   |    4 +
>   3 files changed, 131 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 91ab3033c781..514d30131d92 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -464,30 +464,17 @@ int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
>   	return rc;
>   }
>   
> -int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
> +static resource_size_t cxl_dpa_freespace(struct cxl_endpoint_decoder *cxled,

This function name reads odd for me. Maybe cxl_dpa_reserve_freespace()?

DJ

> +					 resource_size_t *start_out,
> +					 resource_size_t *skip_out)
>   {
>   	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>   	resource_size_t free_ram_start, free_pmem_start;
> -	struct cxl_port *port = cxled_to_port(cxled);
>   	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> -	struct device *dev = &cxled->cxld.dev;
>   	resource_size_t start, avail, skip;
>   	struct resource *p, *last;
> -	int rc;
>   
> -	down_write(&cxl_dpa_rwsem);
> -	if (cxled->cxld.region) {
> -		dev_dbg(dev, "decoder attached to %s\n",
> -			dev_name(&cxled->cxld.region->dev));
> -		rc = -EBUSY;
> -		goto out;
> -	}
> -
> -	if (cxled->cxld.flags & CXL_DECODER_F_ENABLE) {
> -		dev_dbg(dev, "decoder enabled\n");
> -		rc = -EBUSY;
> -		goto out;
> -	}
> +	lockdep_assert_held(&cxl_dpa_rwsem);
>   
>   	for (p = cxlds->ram_res.child, last = NULL; p; p = p->sibling)
>   		last = p;
> @@ -525,11 +512,42 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
>   			skip_end = start - 1;
>   		skip = skip_end - skip_start + 1;
>   	} else {
> -		dev_dbg(dev, "mode not set\n");
> -		rc = -EINVAL;
> +		dev_dbg(cxled_dev(cxled), "mode not set\n");
> +		avail = 0;
> +	}
> +
> +	if (!avail)
> +		return 0;
> +	if (start_out)
> +		*start_out = start;
> +	if (skip_out)
> +		*skip_out = skip;
> +	return avail;
> +}
> +
> +int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
> +{
> +	struct cxl_port *port = cxled_to_port(cxled);
> +	struct device *dev = &cxled->cxld.dev;
> +	resource_size_t start, avail, skip;
> +	int rc;
> +
> +	down_write(&cxl_dpa_rwsem);
> +	if (cxled->cxld.region) {
> +		dev_dbg(dev, "decoder attached to %s\n",
> +			dev_name(&cxled->cxld.region->dev));
> +		rc = -EBUSY;
> +		goto out;
> +	}
> +
> +	if (cxled->cxld.flags & CXL_DECODER_F_ENABLE) {
> +		dev_dbg(dev, "decoder enabled\n");
> +		rc = -EBUSY;
>   		goto out;
>   	}
>   
> +	avail = cxl_dpa_freespace(cxled, &start, &skip);
> +
>   	if (size > avail) {
>   		dev_dbg(dev, "%pa exceeds available %s capacity: %pa\n", &size,
>   			cxled->mode == CXL_DECODER_RAM ? "ram" : "pmem",
> @@ -548,6 +566,90 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
>   	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
>   }
>   
> +static int find_free_decoder(struct device *dev, void *data)
> +{
> +	struct cxl_endpoint_decoder *cxled;
> +	struct cxl_port *port;
> +
> +	if (!is_endpoint_decoder(dev))
> +		return 0;
> +
> +	cxled = to_cxl_endpoint_decoder(dev);
> +	port = cxled_to_port(cxled);
> +
> +	if (cxled->cxld.id != port->hdm_end + 1)
> +		return 0;
> +	return 1;
> +}
> +
> +/**
> + * cxl_request_dpa - search and reserve DPA given input constraints
> + * @endpoint: an endpoint port with available decoders
> + * @mode: DPA operation mode (ram vs pmem)
> + * @min: the minimum amount of capacity the call needs
> + * @max: extra capacity to allocate after min is satisfied
> + *
> + * Given that a region needs to allocate from limited HPA capacity it
> + * may be the case that a device has more mappable DPA capacity than
> + * available HPA. So, the expectation is that @min is a driver known
> + * value for how much capacity is needed, and @max is based the limit of
> + * how much HPA space is available for a new region.
> + *
> + * Returns a pinned cxl_decoder with at least @min bytes of capacity
> + * reserved, or an error pointer. The caller is also expected to own the
> + * lifetime of the memdev registration associated with the endpoint to
> + * pin the decoder registered as well.
> + */
> +struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_port *endpoint,
> +					     enum cxl_decoder_mode mode,
> +					     resource_size_t min,
> +					     resource_size_t max)
> +{
> +	struct cxl_endpoint_decoder *cxled;
> +	struct device *cxled_dev;
> +	resource_size_t alloc;
> +	int rc;
> +
> +	if (!IS_ALIGNED(min | max, SZ_256M))
> +		return ERR_PTR(-EINVAL);
> +
> +	down_read(&cxl_dpa_rwsem);
> +	cxled_dev = device_find_child(&endpoint->dev, NULL, find_free_decoder);
> +	if (!cxled_dev)
> +		cxled = ERR_PTR(-ENXIO);
> +	else
> +		cxled = to_cxl_endpoint_decoder(cxled_dev);
> +	up_read(&cxl_dpa_rwsem);
> +
> +	if (IS_ERR(cxled))
> +		return cxled;
> +
> +	rc = cxl_dpa_set_mode(cxled, mode);
> +	if (rc)
> +		goto err;
> +
> +	down_read(&cxl_dpa_rwsem);
> +	alloc = cxl_dpa_freespace(cxled, NULL, NULL);
> +	up_read(&cxl_dpa_rwsem);
> +
> +	if (max)
> +		alloc = min(max, alloc);
> +	if (alloc < min) {
> +		rc = -ENOMEM;
> +		goto err;
> +	}
> +
> +	rc = cxl_dpa_alloc(cxled, alloc);
> +	if (rc)
> +		goto err;
> +
> +	return cxled;
> +err:
> +	put_device(cxled_dev);
> +	return ERR_PTR(rc);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_request_dpa, CXL);
> +
>   static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
>   {
>   	u16 eig;
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 258c90727dd2..55808697773f 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -680,6 +680,12 @@ struct cxl_decoder *to_cxl_decoder(struct device *dev);
>   struct cxl_root_decoder *to_cxl_root_decoder(struct device *dev);
>   struct cxl_switch_decoder *to_cxl_switch_decoder(struct device *dev);
>   struct cxl_endpoint_decoder *to_cxl_endpoint_decoder(struct device *dev);
> +
> +static inline struct device *cxled_dev(struct cxl_endpoint_decoder *cxled)
> +{
> +	return &cxled->cxld.dev;
> +}
> +
>   bool is_root_decoder(struct device *dev);
>   bool is_switch_decoder(struct device *dev);
>   bool is_endpoint_decoder(struct device *dev);
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index e3bcd6d12a1c..8ec5c305d186 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -89,6 +89,10 @@ struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds);
>   int devm_cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>   			 resource_size_t base, resource_size_t len,
>   			 resource_size_t skipped);
> +struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_port *endpoint,
> +					     enum cxl_decoder_mode mode,
> +					     resource_size_t min,
> +					     resource_size_t max);
>   
>   static inline struct cxl_ep *cxl_ep_load(struct cxl_port *port,
>   					 struct cxl_memdev *cxlmd)
> 
