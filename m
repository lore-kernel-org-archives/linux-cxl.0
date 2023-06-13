Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B0DEB64D8
	for <linux-cxl@archiver.kernel.org>; Tue, 13 Jun 2023 22:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240031AbjFMWmz (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 13 Jun 2023 18:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232592AbjFMWmx (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 13 Jun 2023 18:42:53 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54A3B5
        for <linux-cxl@vger.kernel.org>; Tue, 13 Jun 2023 15:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686696172; x=1718232172;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vTTLm9j4H86mc5td8K3SLD08h753AdNhRla2TFyQrSU=;
  b=nc2MUINlwwXxKXISNUD3PNEKGnvH5zYF7AFU0xMrv72LbyLY/dPb7B9P
   WfaNCM1+TqEWwQUTKchljWQUl4DSJiSzKtHQeIOOvBfZQAm6YkT27nC8s
   /5qLjVYQ0OSUHK8b7dZlirmxjV4xmFwfgJ1zNzl+7lIbkxALnm8B7APa/
   RxCSCIYUMKO6rJpHuvThKuHVdlluUPPeMphhe7f0qA2aXUZJvzXYErnlM
   VMlxnGQhVancqj00WvcxxAVM3d6XAbOEMfBLy19ywIKTRNceQhjyzlepr
   v9zWEkKvLTiN1S6SuvwsZVKnFHs/t0/Id6ako7v7A6s1qlQnX9D3cVtLH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="338100712"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="338100712"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 15:42:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="781868601"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="781868601"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP; 13 Jun 2023 15:42:51 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 15:42:51 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 13 Jun 2023 15:42:51 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 13 Jun 2023 15:42:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WSM1bdBZWCKDJVjtxfrgVwjjKTkymNYm+OsmaKhXCLryNA9GSZrZRXtYpSw866mNKTcifl7J6/i9zLt8vV3cXMowvyqnbBojd9KltA+vCCnkLiIWGJq2ygmtZNoXM4cBT55QKBcg1Ipdg1fIM09NYKiR5vqX7nINKdVoHOjNSAW8KMCQu3nUWQFDOcqHkMaae+l1vThk8rB4asvGZVg0JigAzVHSrh3Q8WBQ7oop2N/l5VX3DGPUY6bzlZJ5BDORvtZBzRYXZhx6Dhd9f19B64iqzAY70z16KhCDCy2WpvS9m/Vnb/rJWJ2BhV4FPQMJbdFcOrSUdEaP6VtTJUyVCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8GEaRGP+EvMZlrKDLQjZOMU4Qbj/7VvUT+Y+Jcz1yjQ=;
 b=CH4u3SVNSQHWid3zZL6BHVeAQjApH5tCE3rsibFAiadS1E9gNaiACSW0xUM0c2rF/wVpSZzd/K3GgoH+t7TWMsYEw463uqj2e26ExdDW0iNEF6y/zFeNLKeQn/BvK0S7ssobmqAdkyrpN5hLl76N6VE0Y5GjOMtgVb/iU0yhROnN23woKA+jCYiMBICwFytEGXTf1zzCV+5XxDowD4XdOOB3B/f6iDNFMoPNaYsOZZClcKiXOasWZ7cm4LenccGmTEJjxMf/OKGTk5vslWVdzZYRrxjaE8jUbV5j45yOY/M7cuTfFQA/LeTacjhLMLI3M8LdkTb9ol45PElmRxlObA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by SA1PR11MB8573.namprd11.prod.outlook.com (2603:10b6:806:3ab::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.38; Tue, 13 Jun
 2023 22:42:49 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528%7]) with mapi id 15.20.6455.043; Tue, 13 Jun 2023
 22:42:48 +0000
Message-ID: <dbfde134-149d-0150-29de-39b4d4570e01@intel.com>
Date:   Tue, 13 Jun 2023 15:42:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.0
Subject: Re: [PATCH 07/19] cxl/region: Manage decoder target_type at
 decoder-attach time
To:     Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
CC:     <ira.weiny@intel.com>, <navneet.singh@intel.com>
References: <168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com>
 <168592153599.1948938.3754212703217628741.stgit@dwillia2-xfh.jf.intel.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <168592153599.1948938.3754212703217628741.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0298.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::33) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|SA1PR11MB8573:EE_
X-MS-Office365-Filtering-Correlation-Id: 8567d508-64b0-47ae-2aef-08db6c5f82e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lIflmo46HuKcAzf9Il6p/fM1Q65hViZtCvVaYI7lwhI9AC2m3mmd0xrdnJbUNYWXhBoqzTKX70afveTNoXp3EAaO74n/LJUwSfVTFuVUYBquC1SsGyhKDIoF1A9ig9ymnjnVtL8NKFEeGGLj2TaSgqbZbuNWiMrZ/wMn9cR7YBWmzndkiWBUj9x0ktSTPmE12sEG4i7ELTmnHxJtVYfK+jVEFSeit2ka0+YJL7aoVU3AXr7GVM+VQ8QGNugGpo+e/tX35hB6X1LA1bgQqKlSmZNHlmqmEPyVowAZL3zSuLZf4QgAc+BnneyXcbLonpSSkhsTWHSV5gVXeeoneElEkbkFhiyKaOp++sLgJj8Vi12xOm3RNoerr6NvPWkCiWwgiaqF6WFO5+8FpoqjtPrejmqHmzAhxWyBXZZ/PqHUhr6CNVwbgkjayZTctb5qK7wy7GjQLoLE1FPBElnIsbHce9W5p6Sk0iuciwQo0oiIM7XL94Z5B/gjUgsD2G1+L2qLrD/yaTSN5eqvCphC4WAWhqrJL8HbUtOd2yPeUn+cP5hJU0cgUrF3M570pKPZTAr1C0BxrY/O8c17ky2yDgZcqhgUN2dE0BSPMcxuoOETNBBPyg2DQULy07KOm3+K3A8Aws0FKPhLBLcvvhybibig2g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(346002)(376002)(39860400002)(396003)(451199021)(478600001)(8936002)(82960400001)(66556008)(316002)(8676002)(66476007)(38100700002)(66946007)(2616005)(41300700001)(4326008)(107886003)(186003)(6666004)(6486002)(53546011)(26005)(6512007)(6506007)(86362001)(5660300002)(44832011)(31696002)(2906002)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnVEazBiZXRnVzFqTVhoZWxoN25aQ2JrVTc1UEVnV2tDWEsyeFE0bjNxVjRo?=
 =?utf-8?B?cFBCZEFvdkIzOE5pU0dzcHRFdXJpdjlYb3pza1RvRGJERzhxREJjUTVPNWVq?=
 =?utf-8?B?dG5RTU9YVVVBaTR0M1JCMklCdnJMYTRuK1c1WGw5VE9neEU2dURRWm9pcU1Z?=
 =?utf-8?B?Znl0TDNOVTdmSi82eHNRNEZIZy9uSGFuSDBMQ0VWV2pKaHNEWFJrbDdSR1p1?=
 =?utf-8?B?cERhY3ZrMTdlU2JpU2N4L1JSY0VmTkdhKzN1Z0U5Mk8zVTIzVitqbG81ZkNG?=
 =?utf-8?B?WTVqVFZrOXZ1RE55cVE5UUUwc0FvcVNnVDZIeVdEb20vTUl1ZExvSTZjQkIx?=
 =?utf-8?B?WmRJbVJvSEcvTnRxT2FFZXNmeURlb2I0UUlzallUM09Pa2cxNDlUNTdhcUlM?=
 =?utf-8?B?eTY0aWV1WlZMbVBLZ2ZiZ2JwUDViMzR6c0VIMXE5MmhiZWVQYlNEL2lTYnMz?=
 =?utf-8?B?aHkzOERDNFh4Y081SENDNFpMZjEvU2FnUTZNQVBha0JwQXVnKzBsRHNnL29O?=
 =?utf-8?B?OWxNK0QzNmFiRUJnbVZhMkRtQVIwMDd0S3FncGdrbHhSU0VhWkpvMGNYcm5u?=
 =?utf-8?B?d0p2MGpMa1FnY25qLzVUdGw5RGxOSVgwa0FaK2FZWU1xdlVqTTFnTm9iclky?=
 =?utf-8?B?YXBMcXg5NGhINHZQeXlJRGFNbEFKdEpzeVBQUWxERU44WmoydCtrblp5NG4z?=
 =?utf-8?B?SC9lQ0hNSVRUeG1zNmwrdUc2ZitOY2ZZZTBNcHQrTy9ZSDl2aVU1dGQ5SnNv?=
 =?utf-8?B?VXVER0VlWnZxaVNHOThqTFhNdG0zcitZQ1BhYWNWNmFqMmw0dDlnbVI0Tjhp?=
 =?utf-8?B?M1RVTnNMZnYrT2ViTk4wRE1jQUcvV2d2VCtiZEhmNVE4bUt6TWkyQ29FeXd3?=
 =?utf-8?B?cnRrMG1KZUtOSmxIL1BjV3Rqc2dNQlZ1TGs4KzVxeXhxT0RVTTRKeWpZd0p3?=
 =?utf-8?B?TVJ0YXlZRXlmK2U1ZEZ1ZVV3c2VnMnp5amg0ZHFOVUZ2NEtocU9UNUpZTzFC?=
 =?utf-8?B?Q0pBNXFjMEc5R2N0N3dvdHNGQzdBeHI3bXozRUZpMmoyMkE1VFRDVlBCTjZT?=
 =?utf-8?B?YzhFR2RnVFFVMDNxSVdKVlNqT1dtSHY0dGc5UTh3cUNucVlhakoyeTVXQnhU?=
 =?utf-8?B?eG9PNEtsYWZ4U1ZHT1JYbEtXeUk5RmtVSEk2ckNPd0Y2NVUwQm8xYWtyL1Ny?=
 =?utf-8?B?R1crQXQvOGI0dWowZ2d3QThlaUxUV2VpYkRMZ244OGVwclQ1cTIzNU15VWps?=
 =?utf-8?B?czc5V29DMU55VElxUkxlbUYwNm55YXhXdHRpczJjenFhU1QwaXdDcGlMNWhk?=
 =?utf-8?B?bmJPT3JRbHNidXphVDRJZkZNQS95N1VaeTlwOCtZdnhqaUpSMTFWTlIyNUNx?=
 =?utf-8?B?V2l5SGd0VXhxdUFpbXU3emJiWlU5b3hUdkRqdnpOdlYwQ3FjdHZQVVVSUGx3?=
 =?utf-8?B?b3hmTmRKaHdjbURzYTY5S1pPb2U2bFhxNlFNZUl2d25rYzdWQ3JZWUtzcFh2?=
 =?utf-8?B?eWVqNHQ3b1N2a2E1Zk5oc0VjdkluTUR5bzR5eUttQW8xZ0lDQTdUWWppN2NS?=
 =?utf-8?B?Z3JXUHJLUURHSkdUWTJuOFlpRGN4ekNxcEtIdlJJcEhWNlBnYktGV2k0QmFi?=
 =?utf-8?B?UjlKckdjOU5Xb0Q4RmdheS96eGtPTFI4RCtHRGpiWTllL3J1TFJiN1B1cG9h?=
 =?utf-8?B?RTlQd0tyR3NCd1lyRDJmWi9EaE5VU0V2YkM1T2FDZlNOWHlLbXFPT2pIOHhE?=
 =?utf-8?B?WlZmcUtONC83NnJTZ091bDJyaHhHaUVsQ3RWR2p6Wnpzdy83Ty83TERQYUJm?=
 =?utf-8?B?WllYOXlzdEtraG81cVRSNkNpZ2pEZmNSMFU3VjB0ZW9xUmZBUVM3alhQVU14?=
 =?utf-8?B?cHI0ZjZuajZ1N1UyTkcwR2htdURITHdQMm1kYVQrSDVOSi9hZ1BlNTl3MGhp?=
 =?utf-8?B?c3I5b1MrbjJib2Y2Y2IrLzNOaEpPL25uNkJXUE9zQkl3ZThtTW5wenpaUTFF?=
 =?utf-8?B?WWV1eFJWakRZK2k2WVY1VHYxdk1XakRWNGVtdnJQd1E1a0pPN2dDQmE0OTRZ?=
 =?utf-8?B?UzRnQk5VZzU5R0pHS09ZdjhNZHZxUVJTRGR4L2dMK2hCdW9CQVZhWDZDbnVt?=
 =?utf-8?Q?5/3yfSo8NMPJp7Kfb7kKCEPgp?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8567d508-64b0-47ae-2aef-08db6c5f82e8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 22:42:48.1049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SOcjHYCVcAX7JsXFMrXMixLzzj1hxbXYjNNj+J8qdD/EFjL3AOvqBnA+1I9/wmKKtRnjrIQnJbpR0PiJWE5PDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8573
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


On 6/4/23 16:32, Dan Williams wrote:
> Switch-level (mid-level) decoders between the platform root and an
> endpoint can dynamically switch modes between HDM-H and HDM-D[B]
> depending on which region they target. Use the region type to fixup each
> decoder that gets allocated to map the given region.
>
> Note that endpoint decoders are meant to determine the region type, so
> warn if those ever need to be fixed up, but since it is possible to
> continue do so.
>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>


> ---
>   drivers/cxl/core/region.c |   12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index dca94c458b8f..c7170d92f47f 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -809,6 +809,18 @@ static int cxl_rr_alloc_decoder(struct cxl_port *port, struct cxl_region *cxlr,
>   		return -EBUSY;
>   	}
>   
> +	/*
> +	 * Endpoints should already match the region type, but backstop that
> +	 * assumption with an assertion. Switch-decoders change mapping-type
> +	 * based on what is mapped when they are assigned to a region.
> +	 */
> +	dev_WARN_ONCE(&cxlr->dev,
> +		      port == cxled_to_port(cxled) &&
> +			      cxld->target_type != cxlr->type,
> +		      "%s:%s mismatch decoder type %d -> %d\n",
> +		      dev_name(&cxled_to_memdev(cxled)->dev),
> +		      dev_name(&cxld->dev), cxld->target_type, cxlr->type);
> +	cxld->target_type = cxlr->type;
>   	cxl_rr->decoder = cxld;
>   	return 0;
>   }
>
