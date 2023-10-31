Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696F4208A2;
	Tue, 31 Oct 2023 21:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dq0/b//i"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9E4ED;
	Tue, 31 Oct 2023 14:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698788872; x=1730324872;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Hwv1A8jP05LmncY9XZL1XxNGEV7K5XsKHdQ2EDUhl+k=;
  b=Dq0/b//iXPlUb+RaAY0u6E0TU2y0YGsX/xA3cFFGwga6EI1iOdDb9tPZ
   B7SiUlLCHYneo8riRbtal+J70PS7pEos64LNKM0Bee185urJe1aPR5aQS
   UISY9jHYkGkk9gaoMNBb6wBnILADNLbMwikNy+UtxGG1uWZjN3buZE74k
   sz9QKuoiau21veGmTrOP0rxqBVtN5FiDNXQPPDPtJgzf1H8aEm5Vn4pwg
   x7YWIaTjW2uHCucfnyjg3mvKU9eFF6aYz+vREbhX5yqT1FY1MALLfztup
   qlHBa6LnHw4E59bpw6Si+LSmWcF0EL5VwDOgrlBDZtvIhAz7J8BzIb12l
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="419494056"
X-IronPort-AV: E=Sophos;i="6.03,266,1694761200"; 
   d="scan'208";a="419494056"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 14:47:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="754263844"
X-IronPort-AV: E=Sophos;i="6.03,266,1694761200"; 
   d="scan'208";a="754263844"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Oct 2023 14:47:46 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 31 Oct 2023 14:47:45 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 31 Oct 2023 14:47:45 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 31 Oct 2023 14:47:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ko4E6/ROF11BG/Q76m1mDwQZouFbb+pk+ezEFAc9Yl66WcHn4jk0xFMlj0xOa6CDoDbU59WcexLer/gzCxFnSED1WI1iJbH0wugIGnZbo+h2h4WdlxCOpSgeadiNpEw31nZyzdMRPp1GWBlhjf2ZTZT+whqLwefRCLhVKnhshE8xeDfzH74Iww6kS0gU0ovzPcIbw0wrhXaJsZxQjESOOQud7MmVB5R8qRrBnkOq/cws3OvfXSvk5FWwYxgrPHMvn97/Mbwj+AgJttz9bF1ygf3Cz6fgzsvnxq2VfEE8G7L1QYHgV4OLkemnWzCmL4MbSvGOEsD3Lf4cpiN5Vz+5ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vr9kEeKBoXIHHiDJVzfSn5Zf6H0l8UFHDLiUR33eKG0=;
 b=NoK4bbespntXHkzcXb1DOhUqC4b/sgBZPgOJ4QP/K/eKHOD5tbs8z0nbfrr9o6kIehACH0LSGJVi8zs0kCSqNFm7yN98EiUsIGaAROIIpEUt52stWoj68l8TGRpDEE77kHX+dnrO7Az061ZvzVyzTw+BPxZ2o+8t/YDZqQf14iYPvOC2k3bN8MeOc+TCxx5LxvsFZahabAkeeVcsqk0ppYTIv4BpuqTcZSXQH/NfXFf0EkMo78VvGe10CoVF9QuFo5MzJyFsP2mSzPZzeLEG9mxJkHfbM0fQJVLnOU4D7qkDTFhC9yswGDSZG7IjO1sVO1kXyPczVKITAt+0yKFy7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by PH7PR11MB6953.namprd11.prod.outlook.com (2603:10b6:510:204::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29; Tue, 31 Oct
 2023 21:47:42 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::28a6:ecda:4bb7:2f9e]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::28a6:ecda:4bb7:2f9e%6]) with mapi id 15.20.6933.029; Tue, 31 Oct 2023
 21:47:42 +0000
Message-ID: <b2ebd8bc-d8ce-42ee-a5a0-f9b0d738e388@intel.com>
Date: Tue, 31 Oct 2023 14:47:39 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH 2/2] cxl/hdm: add unlock on error path
To: Dan Williams <dan.j.williams@intel.com>, Dan Carpenter
	<dan.carpenter@linaro.org>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Terry Bowman <terry.bowman@amd.com>, Robert Richter <rrichter@amd.com>,
	<linux-cxl@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <60028378-d3d5-4d6d-90fd-f915f061e731@moroto.mountain>
 <63295673-5d63-4919-b851-3b06d48734c0@moroto.mountain>
 <65416eecf55b_780ef29464@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <65416eecf55b_780ef29464@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2PR07CA0001.namprd07.prod.outlook.com
 (2603:10b6:a03:505::11) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|PH7PR11MB6953:EE_
X-MS-Office365-Filtering-Correlation-Id: bc0c96f3-948a-4d28-f06e-08dbda5b0281
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x0EQOKv/46tdms1lglJh8H86S0tbfmsS+CpElHp4AJQBAUjz/GjrdwZnvwSwcxO+fMcfL9bcEAK9IClRppnv+0GkLNkFirO0BbjWg/iSpkAxMP8jb4/MIArBtOFqFeRlFLXWKZxuSacFitxr+v9QZWvCQafjuo1UItQp9MTKbnlg+tQveJ9LxFIE5E+P5PXUm54x6EEng8XcwfQPrjjVgCI0N6Df3kiw0O5rRFSFo1ANXiaq9OAtn7iIXHW3y54lXaMqQ4AoHW38xI92sjbC7t1YQLTGEAlMGIagq8MKS0sZc2i8/maQTjmRYH9u1mW1+vxfUxLxXfQToaK10bm0NS8iTT0bSmxkLHDZMqCYPKwYjySeQGkMI+tcRENSQbgeBMUEkOUCdsFgDrvbZMEK+VhxsKRG+lRe8RCt3tUY/PRA+y+EaZRV7Q0n/XWsyF8/fUjpsCb6cBrdoA7fnL0zuEXe2AB0Yl+C5CDeDKroQBSrZgnOFKee4GPqjtYYSDLGXr7+JSqTeCd35mOVyjMO7kyEMEQQ63s14KIAeOJm4gLsoCRhfJHzIgHrk+IhAPDpZFQtwRzLP7U2bIXImG2yEV12lpktENz6nIVKN89sidg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(376002)(366004)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(82960400001)(36756003)(86362001)(31696002)(31686004)(966005)(6512007)(6486002)(41300700001)(478600001)(8676002)(8936002)(44832011)(6666004)(2906002)(53546011)(4326008)(83380400001)(2616005)(26005)(6506007)(5660300002)(66476007)(316002)(110136005)(54906003)(66946007)(38100700002)(66556008)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHovZmxqYU9Gd2N0bDlRR05FakZmckxpb3JoRnBLM1NPelM2Nng3V3U0cjRr?=
 =?utf-8?B?Qkc0Tk50cDRFeE14czZEWGRrUVdvNDdWSVdvNnMrL2R4eUM1L1RSSStoY1ZE?=
 =?utf-8?B?UlZzN0M2SGpKVkRVWWtySXBid3owMlJxRDk1K1hnY1Rjc0pZTHFmbWRMN004?=
 =?utf-8?B?QlduOFhDZk54UytDWENCaHpLNnQ0OEU2dmFWRy84Q3pUaWd4amI1RVR0eXNH?=
 =?utf-8?B?TTFRNkZtRlNBTDcwcFR2N3R1UGl5cUxBUzdOMzN6b3Vwbnp1U0tiaFR2bFl5?=
 =?utf-8?B?RWxOVzlJT3Ivbjl0U0o1YjJWS2ZiUnhqeHd3Z09iSmpObC84R1AyakVobER4?=
 =?utf-8?B?eERybzBkVy9UM2ZNRTdzWEFXdzNESFFWMkdYaGxnK2JuaEszbGJEc2I3ZFNU?=
 =?utf-8?B?dElvcDQrSGJqNFpFaVcvUFZyaEpmQkF1YlRmR0ltc0EvYi9hbjMxME0zTlcz?=
 =?utf-8?B?RG81TmxUN3YzVXd1OXM2OXA0RmxGRWRFcy9ZZXVwTWI4bllHYlZYQ0hTZzR0?=
 =?utf-8?B?dFhDbzFkai82QnB5aXRnRlRScUtTZFQyK3VZTm9aME5yS1hsaVZkRUIxUEh2?=
 =?utf-8?B?UDlUZk9LaG5iNFgrWml3bnZyYllNSkpaRzAxeHZTL2RLNnJtb216SHgzV0tU?=
 =?utf-8?B?S2ovY3kzSGNnbXdmZVFXMHp4cmg1NW5DOEFTcVd2ZGJVdUpFRldCY3FOUzg0?=
 =?utf-8?B?SkNxZEtleDJTamJIdEc3NHVXNWNhTEhkaG5kY1g5MEhnQ3ZQYzNNWkZnZTkw?=
 =?utf-8?B?UDcrSzNxQzZYR2xzUHcxYkx2a3FpYnVjYWF2aEVBZ0NVNkRVeGFPR091dTZ3?=
 =?utf-8?B?bnVYSnh2RzgzMkFQSTFiaG9yVUt3d1JWODJzK1dHL1BPUHhuVWxXbkl0VXUy?=
 =?utf-8?B?SEtDOWJBMUsySHZCRStXcGptQlZGSllPS2NOK01kaUNIQXp1aFY1SnJ6TnlM?=
 =?utf-8?B?UXMzeFYwR3lvL3BGZzZoMURaT1V2N3htTjBxMFZPbXMwNXlWaDRqTDRWMHFS?=
 =?utf-8?B?SlhJTlNOQW5odW0xcVhOTEhvT3BsMStCc3AzOWxmTEhNZ29vanZGYWlMNHk4?=
 =?utf-8?B?aWlmQVpxbGtNVitidmVFQ1c2R0xqMlhHVFR1MWE3RjNhVG13UlUzWWhoZzVr?=
 =?utf-8?B?Y2k1OC84N09VVkpHUG1EVXEyLysxRkVEV3hWWmpSL090RkJmQzYzdzVPRkFj?=
 =?utf-8?B?NW0reFJQV3pGR3NnTHB6alpseDhzSFNMUWRkRXVYZUoxUTA4NTZOVVR6SVBn?=
 =?utf-8?B?Z3dOeEtId2FLc2praWlHQ3l6dkxGUEUrM1A0SkdpTnlHR1VkeU4yRFE0a2Nx?=
 =?utf-8?B?OExKOUlmdGtadlNERmNJVnVlMlRrUExPMGVjbi84V3luOHhia1dnMUdJQjBM?=
 =?utf-8?B?aCtVYVE5clBoeXhoWEU1bVBtbk9DK1kraGRtQ0JsNzk5RVBxaHI2L2JoTGhE?=
 =?utf-8?B?UCtKYjFzd29iRWh3RG1DcTJjSG82SGhDOGhaNzNFY0V2cjdCdTlUMzl5RjFK?=
 =?utf-8?B?cDQrUnV1N2dTaC94aTFwR3RQWExkVWJXcDhWaXMwbEhsSTdoc2tyamtmRm1L?=
 =?utf-8?B?dWdLUUE5YmE0cDhVMVNMazNVUEl6VURwNTh3ZHJuL2F1YW9Kc2tSNU9xMjEv?=
 =?utf-8?B?NkJSMmhOdWY2ajhWbzNKbitSOUxYQU4xSGg4cGkvYmFpRmZLVHovTHFHRlZ6?=
 =?utf-8?B?ZWUxRW84YkFoZGhRMm1WcTV2ZDB4Wkh5ZFhQb3YxQjJDZkpoNkFvRHlMbGdY?=
 =?utf-8?B?ZEVLTmZDRmd1R3Jpd3puWnFycGlXb09uUUVqcThGaW9VQlB3akx4TUIrMFdW?=
 =?utf-8?B?Z29TYWpPZ3A1bzgvN2NKMTB5SjlOVE9LMUVlQnhETTVrakdYbkRsazRPbmVK?=
 =?utf-8?B?Vmp0UmVWU2poNHVMMGIya0JrVWp2SVVramZWQlFYMHpPbk43dG1iZGk2dDNl?=
 =?utf-8?B?ZURYQmZQd3B2UXJxYkpOOGRMaHhGU1d2ZVRqbHlZOUtjbFVld3d3YkVJanBK?=
 =?utf-8?B?ODZhSHdNSjcvQkFZV0lGWTZBUnJsUlp3UW1IU2lydy91Yk9ndnFnNkpoSmh1?=
 =?utf-8?B?NlZMbEoyKzk1dzFPa0RTM3ZsVk5UV3R4dDZVTFVOU0VvWmRsZ3NkbjBXUkgr?=
 =?utf-8?Q?cAIoTujJdt9JerrZQwo8qyn2b?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bc0c96f3-948a-4d28-f06e-08dbda5b0281
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 21:47:42.7706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zAo6jdqoGMcRTmz1Dix9HtkvShZJaNM/IvSvPOhlpDlvCKqo2KrMMe74LN7Haxp4HpOu/o04QXbrB+n577jNrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6953
X-OriginatorOrg: intel.com



On 10/31/23 14:17, Dan Williams wrote:
> Dan Carpenter wrote:
>> This error path needs to call up_read(&cxl_dpa_rwsem).
> 
> This looks correct for what it is, but that error path is a "should
> never happen" situation. It would be better to just eliminate that
> possibility altogether...
> 
> -- >8 --
> Subject: cxl/hdm: Remove broken error path
> 
> From: Dan Williams <dan.j.williams@intel.com>
> 
> Dan reports that cxl_decoder_commit() potentially leaks a hold of
> cxl_dpa_rwsem. The potential error case is a "should" not happen
> scenario, turn it into a "can not" happen scenario by adding the error
> check to cxl_port_setup_targets() where other setting validation occurs.
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: http://lore.kernel.org/r/63295673-5d63-4919-b851-3b06d48734c0@moroto.mountain
> Fixes: 176baefb2eb5 ("cxl/hdm: Commit decoder state to hardware")
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

LGTM

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/core/hdm.c    |   19 ++-----------------
>  drivers/cxl/core/region.c |    8 ++++++++
>  2 files changed, 10 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index af17da8230d5..1cc9be85ba4c 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -565,17 +565,11 @@ static void cxld_set_type(struct cxl_decoder *cxld, u32 *ctrl)
>  			  CXL_HDM_DECODER0_CTRL_HOSTONLY);
>  }
>  
> -static int cxlsd_set_targets(struct cxl_switch_decoder *cxlsd, u64 *tgt)
> +static void cxlsd_set_targets(struct cxl_switch_decoder *cxlsd, u64 *tgt)
>  {
>  	struct cxl_dport **t = &cxlsd->target[0];
>  	int ways = cxlsd->cxld.interleave_ways;
>  
> -	if (dev_WARN_ONCE(&cxlsd->cxld.dev,
> -			  ways > 8 || ways > cxlsd->nr_targets,
> -			  "ways: %d overflows targets: %d\n", ways,
> -			  cxlsd->nr_targets))
> -		return -ENXIO;
> -
>  	*tgt = FIELD_PREP(GENMASK(7, 0), t[0]->port_id);
>  	if (ways > 1)
>  		*tgt |= FIELD_PREP(GENMASK(15, 8), t[1]->port_id);
> @@ -591,8 +585,6 @@ static int cxlsd_set_targets(struct cxl_switch_decoder *cxlsd, u64 *tgt)
>  		*tgt |= FIELD_PREP(GENMASK_ULL(55, 48), t[6]->port_id);
>  	if (ways > 7)
>  		*tgt |= FIELD_PREP(GENMASK_ULL(63, 56), t[7]->port_id);
> -
> -	return 0;
>  }
>  
>  /*
> @@ -680,13 +672,7 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
>  		void __iomem *tl_lo = hdm + CXL_HDM_DECODER0_TL_LOW(id);
>  		u64 targets;
>  
> -		rc = cxlsd_set_targets(cxlsd, &targets);
> -		if (rc) {
> -			dev_dbg(&port->dev, "%s: target configuration error\n",
> -				dev_name(&cxld->dev));
> -			goto err;
> -		}
> -
> +		cxlsd_set_targets(cxlsd, &targets);
>  		writel(upper_32_bits(targets), tl_hi);
>  		writel(lower_32_bits(targets), tl_lo);
>  	} else {
> @@ -704,7 +690,6 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
>  
>  	port->commit_end++;
>  	rc = cxld_await_commit(hdm, cxld->id);
> -err:
>  	if (rc) {
>  		dev_dbg(&port->dev, "%s: error %d committing decoder\n",
>  			dev_name(&cxld->dev), rc);
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 8d3580a0db53..56e575c79bb4 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1196,6 +1196,14 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  		return rc;
>  	}
>  
> +	if (iw > 8 || iw > cxlsd->nr_targets) {
> +		dev_dbg(&cxlr->dev,
> +			"%s:%s:%s: ways: %d overflows targets: %d\n",
> +			dev_name(port->uport_dev), dev_name(&port->dev),
> +			dev_name(&cxld->dev), iw, cxlsd->nr_targets);
> +		return -ENXIO;
> +	}
> +
>  	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
>  		if (cxld->interleave_ways != iw ||
>  		    cxld->interleave_granularity != ig ||
