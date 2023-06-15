Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF47EB64DD
	for <linux-cxl@archiver.kernel.org>; Thu, 15 Jun 2023 21:32:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbjFOVcc (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 15 Jun 2023 17:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237446AbjFOVca (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 15 Jun 2023 17:32:30 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12E72962
        for <linux-cxl@vger.kernel.org>; Thu, 15 Jun 2023 14:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686864749; x=1718400749;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HTkoFlTl4WZyrhc2M0bJa7Gqt0PCGSpvOOJL4E+XAbw=;
  b=QZ7tlDu5LEAApmyJ6Dawe3H3hGNWk0PlbZSXoPvKCKhjHjr5xUHNARqr
   OEWY1imJ5STQV++4gjXMd91V/RDtejJoWJmY/k2rczu8FuXz7M2YxKPMF
   3GtyUtCh/q/6uBOlkFuo8L1Ald1idmfvC125BXWNN6PwHy7ykD+yDVygp
   Gdvvc1jisyF43XcH0VDcL+nluzJDs7Uh9GiSaHKN+wvZ0HlKtFcdNQRn4
   lWISve37Al/YkjQJdXdzS/Pgr1MP41y3bum5JUSk58W3LUfZZ4HfOixCs
   zrSC/EA3fbge1RAKKAIvksMwGch9KUqfPnVaZKKJ3NBTzI2LWhvFoN3LV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="387642777"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="387642777"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 14:32:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="777895971"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="777895971"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 15 Jun 2023 14:32:29 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 14:32:29 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 15 Jun 2023 14:32:29 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 15 Jun 2023 14:32:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IQqLAMDvN1xAvp3VCGJIa0ewiNIPHy26Ydhi6901UmG8sbQBStoT9CqgCVqQFsDDqLCwmWCFizhwJ/CvoQBifdoLlfiI9UwZdopSnKKFq+RLk9QSZR1T/2EemHFZ0dwZLp4x5cDKsItdkxIy0Ywpag3OcSjao2wuwfFcU+68fEHufu0bW/D47bLGhP6r+WEKccs7+WnblrVXQIV5IiLNovFH+5GYEdNcKGj0a9ZVBaznrvAFfNlX7sSmwN/CT9nv7eknjGGCXLO1XwkTLUB8cqPWDBawmKDM8xQGXyV+jT+qfg1kGeSRfV87paJs2ycBmoOJKNk7JWiioMd7ykQZFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G3vgnXE5+ZP+eSS526FYf6RGedlCqdwF793Oj9fd9S4=;
 b=WCopXbau37ImSjRfJcMawHT1RxD9EbesT4Hk0hWneZUo296+2jw2Koh9c4+aU0iPZUIBt3uBwsZVsr6oMxEJoKtB3nOQf5D8l/Je751qPrU+JqpilrN/vLY1pGO4HVfRuLBOTdY/YUfkmJ+qHwi4jm8e29uGdnr64uPCeodqKax6C+pmjs7tzX4yw5Ts+XKpOR4LT8y+JfQgguczLNJyjw4S09GuPIbdBs8Y665eD5uWsONqlR9/C6cScxOMZEHy81Kf2Z8Gcb+WibkegZao6jcNjSwxilftQuFbcy3QsAGyi6HfyHzpACzWJTpZF1ipb2Vz3di8l2qvj/MZYnc1Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by DM6PR11MB4708.namprd11.prod.outlook.com (2603:10b6:5:28f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27; Thu, 15 Jun
 2023 21:32:26 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528%7]) with mapi id 15.20.6500.025; Thu, 15 Jun 2023
 21:32:26 +0000
Message-ID: <41e060b1-81c0-e389-8e94-3a8bf5b2e80e@intel.com>
Date:   Thu, 15 Jun 2023 14:32:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.1
Subject: Re: [PATCH v2 08/12] cxl/hdm: Default CXL_DEVTYPE_DEVMEM decoders to
 CXL_DECODER_DEVMEM
To:     Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
CC:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <168679257511.3436160.9707734364766526576.stgit@dwillia2-xfh.jf.intel.com>
 <168679261945.3436160.11673393474107374595.stgit@dwillia2-xfh.jf.intel.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <168679261945.3436160.11673393474107374595.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0022.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::35) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|DM6PR11MB4708:EE_
X-MS-Office365-Filtering-Correlation-Id: 29f457be-2827-48a8-be96-08db6de80391
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GIQiNnMwbZmVB6T55owll98EUL1ymsDi/XdZ39W2mZS7NoSszQDGtkYMosCqmwPxuczM+OLSL0TnkzApK7HTVpU84a43k1mvJH0AOjT1JAFG38HKX3YjXo52fawCm7TfSzag7xc25PuAwncswo1Li1T0SvGiYPN0jXq1Cwue/G13jNXBFjoHPFPRKZAsD3eEex8subw+n3LrPJmc68pR9ndeSlRhuY82+5u1WytYQTjwNEvlRAVYewELpvAOpgNYZiJDEOCH2QJEdPe0DhTFuoRUOHWiaaMOc0nHgiASynfUbVvgs765jip+Krcf3ps8Gy/CUbGXDmbWh4lrnrRgrK0V/QmRdPQvZ5B8TJERhQC+y4+5iteGz8+BFRaH7fUv4bc2K9oFP9EhBTuajavk/Vh4jCR6e94BX6Gmid9HI/5IUm5K32ATgLaFRpWTsCPB1RBDzCwVmyE4ozed56bMvCLINv04Famy4VFCoVxaXGPcHlrgqG2Jy1uxWhS0oqOLAF+ONjeohsAHZQzEGLsxoKPbgfUjhS6Dj4DXK13CbGvoXmKZGRkmhzpfkk2D5lATUqcAsq/45k80s8kSCNuzpcBFB4+m1ISqkoH1havCtoIv5ygzrrSs6uFiG7dxc1yi4FGsmNJ34PLFLK8P23kUWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(376002)(346002)(366004)(136003)(451199021)(41300700001)(31696002)(6486002)(8676002)(86362001)(8936002)(6512007)(26005)(53546011)(6506007)(44832011)(5660300002)(31686004)(66946007)(38100700002)(2906002)(66476007)(66556008)(478600001)(82960400001)(4326008)(2616005)(36756003)(83380400001)(66899021)(316002)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVNHSWxJdjcrNkd2NVhQRkpDbHZ5c1haK0dETkoySHhoZVdDM0hSV2QzZ01j?=
 =?utf-8?B?QXhLbTVVNGlnTFpPaTNYUkxlTVNXOGFTZHdnNHY4dDZwS0dPRUtpQlBrTlFk?=
 =?utf-8?B?WXdaMDQrT2VaRitKRWFoRmorQnM5eUJTeUZCajJOWW9ubWR4UmZ2MmdEMnBU?=
 =?utf-8?B?VWdkMVBxN1pPSlJUTkhDMjM2VHpkUytFaS9ubUR1MTRPWWpRcmpxM1pSajgw?=
 =?utf-8?B?dXA3MDZSMk5KVlpDZXA5ZW9VeW9haUtDN2NEZlNMaENxdHNCbHZxejRpV2FL?=
 =?utf-8?B?aVNiZkl6cVB0RFA3SU9zUjFkMUx1cjhUSXVja3lsVnUwWGw0MkloUm02WFVY?=
 =?utf-8?B?VUMrMTd5WmtLVitybThxcXhFcWJ1K1h2QWUxdWRnMkxUelVzSnRzZG5mKzNU?=
 =?utf-8?B?QzRlMU44UWd5UDQyakJBR0wyTDQ5b0VGZExxRllUU01OY0NlZHhaZE1teC9m?=
 =?utf-8?B?czdqUnVNQ09veElpVmVvZk5oRFN5YnM1Wkc3RWFuektKYzUrdlJjMWdZaUNP?=
 =?utf-8?B?dERrRHFJMFF3VVQwYWxOWFdFNXU1K1NvbnRad2pDT3kzOVg2UnlZdlJNMldQ?=
 =?utf-8?B?VEZBaktPNHVKeGxkQ2lqM3EwRmFZL0sxOE5uRktQVnZobVJnalkyZ29hMWE2?=
 =?utf-8?B?UWUwMjA0SVBPTWNuMS9NSzdtSk12K2FkL1Yyek0rUUhMbWhCeTRTRGtwWUVl?=
 =?utf-8?B?ZVZ6UEVTVi9rVzhtaG5uU3FCT1cyWnBDYkU3eUJJNitVQnpxYlNJL2dQUDNK?=
 =?utf-8?B?Z1dVRjYvVXVVd0NIbE9tSGVhVElZZmdMMWE0eWpBdXhYazNZRmpVQ1dFMmZM?=
 =?utf-8?B?ZHFYNjM4ZktFQTdLRDNrZGlpaC82QVJVZ3cvZFMvcGVLYnc0Z0xsaWFhUDlO?=
 =?utf-8?B?TER3WmdDZzZvRW0vd3JUZWpHYTlUZWMzNG9CVWdKZFhLSWZGT2JnOVA0OTdM?=
 =?utf-8?B?TVI0THloclU0aitYZkI0YklITldPQVJEK3RPMG5OMEErcjdUcU9kMno3SFhh?=
 =?utf-8?B?bU5BSThzUDNXV0pQd1ZNa1Mvdk1zYWIrVVlQTFdoS3RyS0pkbEUyOXM4ZW0y?=
 =?utf-8?B?U3VmS1ZmVUhGaldLMzBJZ1F2VnYrVVB4Y1FPOVJIeGxIMHZRWE1UdHBsYWli?=
 =?utf-8?B?RStpOWNqbHVwMUV4NitFRGFid0FUR1lXOEZkQ1FqSjMrK2dDOVVrVzRsTHdl?=
 =?utf-8?B?aHozaVJnY3VzNmI5N2JWSnZvOFdwZjJpMnBWR2xDbU9VejFCdE5uUXgxT0lR?=
 =?utf-8?B?QlNhWHo4LzJERDJsQTI1elE4OUJLZkNMZFoxSnd2d2lONUNHZVFDSXhzSFNh?=
 =?utf-8?B?THUyMlNDT1B6QysvR1lZUmF4d2R0NnNuRkRoY0MzTUljVEo3ZzBwNXB0cm9N?=
 =?utf-8?B?Q3dXUzhmZXRQdmpXbVJra2V5VDRTQ0dra21scGRHWklzbzdJWTFtZDJmcnl0?=
 =?utf-8?B?MXJYOW14cGJMeHkyWHN0VWZpOWVlTkdIdzQ1TkpSR2EzeldjeHBmakdoTGxK?=
 =?utf-8?B?bUhpQ2xEY2I3THBlUm93V09ZaGdYVlJ2cVZKMG10cVRQMWtBRVlRc05Zc3N2?=
 =?utf-8?B?ejJ3NkN5R3dXd2xlRTFzQWhCUTFGRjcvYUhCT0Z4Z1VuMzA4MHBSWDZiRmRV?=
 =?utf-8?B?bnk2c2xzbzc0MG5uR00xalozLzh1cnNwV2Q4NjYrOEo0Ukl3bmJmNDg0TDVn?=
 =?utf-8?B?K0lGK09zTjhCQWNhM3RkQlBGbHVWZVljQkJaeHZNRGtTU2VTWFVDTVpGbW1Q?=
 =?utf-8?B?ci9nZTVDN2k5LzRUdVo3MTdqT1BoZXpVKzhTU3FrbGJNaXE5cVBzV01ISXRm?=
 =?utf-8?B?U3NCUVh2VHRGa2w3Z3g3TmExNEwrYXZydEh1UVAvM2o1MnNjV1FIVEk2OSs1?=
 =?utf-8?B?eHFTdnZLUi85Ti9DaTQrRE1HVUJPUFFRcCtWV1ZqQ1BENDhiWEVHS1diWXVr?=
 =?utf-8?B?RzcwaUUwN3Y5blVpaGJqdlJpMFUva0VsWFg3SElzbUx5TUI4WmYvazZ1aW8r?=
 =?utf-8?B?bElGZGN4djFua2tDZVYyZlYzQXJyeW1aRllvOWxHRzVDSDJnL1k2Z0dDUDZl?=
 =?utf-8?B?cXhzbDEzMG9FMTJMN2Vwb2IwNEd3ckgxY1NwZEJCR3djaU10MTVyYjJQTm1U?=
 =?utf-8?B?UjVGalUwWjlvWlBHUEk4cTdCWEtnU2dCMzA3MEZqREJuRHJFd2hTMXhTdWN2?=
 =?utf-8?B?ZVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 29f457be-2827-48a8-be96-08db6de80391
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 21:32:26.4227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t9uLu5BVhL1WoX6VTHD5+xVxv5dppsG+mni0AR/jWfNyv8iqigV7/51H/RpwnNrpHXEIpnWl+/JNMvkE6JvdIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4708
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 6/14/23 18:30, Dan Williams wrote:
> In preparation for device-memory region creation, arrange for decoders
> of CXL_DEVTYPE_DEVMEM memdevs to default to CXL_DECODER_DEVMEM for their
> target type.
> 
> Revisit this if a device ever shows up that wants to offer mixed HDM-H
> (Host-Only Memory) and HDM-DB support, or an CXL_DEVTYPE_DEVMEM device
> that supports HDM-H.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>   drivers/cxl/core/hdm.c |   35 ++++++++++++++++++++++++++---------
>   drivers/cxl/cxl.h      |    2 +-
>   2 files changed, 27 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 79170de13d89..715c1f103739 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -572,7 +572,7 @@ static void cxld_set_type(struct cxl_decoder *cxld, u32 *ctrl)
>   {
>   	u32p_replace_bits(ctrl,
>   			  !!(cxld->target_type == CXL_DECODER_HOSTONLYMEM),
> -			  CXL_HDM_DECODER0_CTRL_TYPE);
> +			  CXL_HDM_DECODER0_CTRL_HOSTONLY);
>   }
>   
>   static int cxlsd_set_targets(struct cxl_switch_decoder *cxlsd, u64 *tgt)
> @@ -794,8 +794,8 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>   			    int *target_map, void __iomem *hdm, int which,
>   			    u64 *dpa_base, struct cxl_endpoint_dvsec_info *info)
>   {
> +	struct cxl_endpoint_decoder *cxled = NULL;
>   	u64 size, base, skip, dpa_size, lo, hi;
> -	struct cxl_endpoint_decoder *cxled;
>   	bool committed;
>   	u32 remainder;
>   	int i, rc;
> @@ -828,6 +828,8 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>   		return -ENXIO;
>   	}
>   
> +	if (info)
> +		cxled = to_cxl_endpoint_decoder(&cxld->dev);
>   	cxld->hpa_range = (struct range) {
>   		.start = base,
>   		.end = base + size - 1,
> @@ -838,7 +840,7 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>   		cxld->flags |= CXL_DECODER_F_ENABLE;
>   		if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
>   			cxld->flags |= CXL_DECODER_F_LOCK;
> -		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_TYPE, ctrl))
> +		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_HOSTONLY, ctrl))
>   			cxld->target_type = CXL_DECODER_HOSTONLYMEM;
>   		else
>   			cxld->target_type = CXL_DECODER_DEVMEM;
> @@ -857,12 +859,28 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>   		}
>   		port->commit_end = cxld->id;
>   	} else {
> -		/* unless / until type-2 drivers arrive, assume type-3 */
> -		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_TYPE, ctrl) == 0) {
> -			ctrl |= CXL_HDM_DECODER0_CTRL_TYPE;
> +		if (cxled) {
> +			struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +			struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +
> +			/*
> +			 * Default by devtype until a device arrives that needs
> +			 * more precision.
> +			 */
> +			if (cxlds->type == CXL_DEVTYPE_CLASSMEM)
> +				cxld->target_type = CXL_DECODER_HOSTONLYMEM;
> +			else
> +				cxld->target_type = CXL_DECODER_DEVMEM;
> +		} else {
> +			/* To be overridden by region type at commit time */
> +			cxld->target_type = CXL_DECODER_HOSTONLYMEM;
> +		}
> +
> +		if (!FIELD_GET(CXL_HDM_DECODER0_CTRL_HOSTONLY, ctrl) &&
> +		    cxld->target_type == CXL_DECODER_HOSTONLYMEM) {
> +			ctrl |= CXL_HDM_DECODER0_CTRL_HOSTONLY;
>   			writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(which));
>   		}
> -		cxld->target_type = CXL_DECODER_HOSTONLYMEM;
>   	}
>   	rc = eiw_to_ways(FIELD_GET(CXL_HDM_DECODER0_CTRL_IW_MASK, ctrl),
>   			  &cxld->interleave_ways);
> @@ -881,7 +899,7 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>   		port->id, cxld->id, cxld->hpa_range.start, cxld->hpa_range.end,
>   		cxld->interleave_ways, cxld->interleave_granularity);
>   
> -	if (!info) {
> +	if (!cxled) {
>   		lo = readl(hdm + CXL_HDM_DECODER0_TL_LOW(which));
>   		hi = readl(hdm + CXL_HDM_DECODER0_TL_HIGH(which));
>   		target_list.value = (hi << 32) + lo;
> @@ -904,7 +922,6 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>   	lo = readl(hdm + CXL_HDM_DECODER0_SKIP_LOW(which));
>   	hi = readl(hdm + CXL_HDM_DECODER0_SKIP_HIGH(which));
>   	skip = (hi << 32) + lo;
> -	cxled = to_cxl_endpoint_decoder(&cxld->dev);
>   	rc = devm_cxl_dpa_reserve(cxled, *dpa_base + skip, dpa_size, skip);
>   	if (rc) {
>   		dev_err(&port->dev,
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index ae0965ac8c5a..f309b1387858 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -56,7 +56,7 @@
>   #define   CXL_HDM_DECODER0_CTRL_COMMIT BIT(9)
>   #define   CXL_HDM_DECODER0_CTRL_COMMITTED BIT(10)
>   #define   CXL_HDM_DECODER0_CTRL_COMMIT_ERROR BIT(11)
> -#define   CXL_HDM_DECODER0_CTRL_TYPE BIT(12)
> +#define   CXL_HDM_DECODER0_CTRL_HOSTONLY BIT(12)
>   #define CXL_HDM_DECODER0_TL_LOW(i) (0x20 * (i) + 0x24)
>   #define CXL_HDM_DECODER0_TL_HIGH(i) (0x20 * (i) + 0x28)
>   #define CXL_HDM_DECODER0_SKIP_LOW(i) CXL_HDM_DECODER0_TL_LOW(i)
> 
