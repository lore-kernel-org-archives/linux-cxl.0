Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09EEDEB64DA
	for <linux-cxl@archiver.kernel.org>; Tue, 13 Jun 2023 23:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbjFMXpo (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 13 Jun 2023 19:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239536AbjFMXp3 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 13 Jun 2023 19:45:29 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915E22122
        for <linux-cxl@vger.kernel.org>; Tue, 13 Jun 2023 16:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686699843; x=1718235843;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hRguXadUUwafWzzMxEhAWrtNu0quCxmy7UnKn7fvxmg=;
  b=bMZMxzE5d4QzhFJHvI8x9hUG7AwtEMbIrsKuGnInj/jgQ6kVSGN77pqC
   hKLPAk04WoiHsbTYVo9jZU0C3v++wstHiXlNWxwf12Xag5YJPj5iEDal0
   Crmmx8/oCxOJHf2Qwhu/JWXN8alqGV/ZcUVK6pCXFQO09crcyrTLCifGj
   WtikTtcXCbIU9FfGCWxiimAXkxreOYHgtzRBvxZ6uhXGNBAaPchFoVV8g
   WoQfKbxe8fDe+Oyuj/wn2cYWx+LoIZK/4PPDs8JjGI4IeJCiRrFpuEmIN
   tSJPlBeKCVRwFVo904+LruMpBCW/Gv5nw+q3nbI2PYpGGD+p6ThY1mZb2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="422076529"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="422076529"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 16:42:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="1041955258"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="1041955258"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 13 Jun 2023 16:42:16 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 16:42:16 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 13 Jun 2023 16:42:16 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 13 Jun 2023 16:42:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bzh6gpDhUXJrcqybygPKzKxFHBg0WSQgOsWXSeWwz00aNpKVraO7ya5UWbuoIANZc6eC1vRcEVBuJYaRh84xDq4cRnyQ3vol0Z1ZfpTJBG9bE1EBG4ukNHczVAxiIFO6uRjIX4ovVEdFbO6KCPjDyf/a5RWQJ8u3I0o0OgPeOvok3+KEGf92bjQw9HUKNevUO1n0w+RMdUmI7K6pezmK0oFSE+PORHmaE28wTNvPFPSmdZTD+U+KRJ5sEy3grgUYTCZ9xFdZOG/vMzAGFDuQ4ldc7xQS2edFs/L24xrKKuyRUXe1aMb4WnRpr7E2zPbLEMOja3+JP8ciOSRhRSGwhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LGME9Q+elNCY0Knq/PjUtV3TsZGzy+LsIBc+iZ5a0Ys=;
 b=nln2cYsk2bJrHeB0s+wCQvd6pPZpQ8L1aUJ2BeSZkD+vVqFz8UcQrqQWQWds9Tn8XCwoTUJjqMkOLhUdz6Afcj8sVLnJLpoYV6N+NgI06uovMsZ5UIqSuNl97sNqHMJA5et5o6kCisP7yD2Pvq+0qLflGnmqhDUpDkGXcgsnY7f5vbiZ82zrmV75hEqDFGk3mcpTJqhbRxVzZFZYCOEAEcsEHHaaG9GR/c2v1kVV+rnISpKbgsLo20XtGg7ybqjFx6KuROI+VweVdCj/ra71qXbnBKDHk2rG+FQ2cBxr4gwXUwh0oM3XrinDsmvxjQCYQKhEJePrqHCdtuuLDaHAxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by PH0PR11MB7615.namprd11.prod.outlook.com (2603:10b6:510:26e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Tue, 13 Jun
 2023 23:42:14 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528%7]) with mapi id 15.20.6455.043; Tue, 13 Jun 2023
 23:42:13 +0000
Message-ID: <abb483fb-1549-b9fd-36b7-67d60bf4dda2@intel.com>
Date:   Tue, 13 Jun 2023 16:42:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.1
Subject: Re: [PATCH 13/19] cxl/region: Factor out interleave granularity setup
To:     Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
CC:     <ira.weiny@intel.com>, <navneet.singh@intel.com>
References: <168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com>
 <168592157031.1948938.2150827780624190474.stgit@dwillia2-xfh.jf.intel.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <168592157031.1948938.2150827780624190474.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2PR07CA0018.namprd07.prod.outlook.com
 (2603:10b6:a03:505::22) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|PH0PR11MB7615:EE_
X-MS-Office365-Filtering-Correlation-Id: c41c96eb-8835-4eb5-bb74-08db6c67d012
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I8siz+25nmW5CgXRhHDGGaQH4pfHf15bPvA6Wc8qd5M7yL46yfjc3EA2V8ypORV5HcvY7FtMhtuEKo98wE7kegyR2SBkyFk9UPeq7CwFtVdhrM1BLe21esA4s7vTd73XRKloJTZ5DeUGUC98unxQxWzaFyQL03FeNOTR1j816YXYlfIAx2SNw8vjLKmur5zYfo/5If1Jnl3uJVGOvcWTUxZx/iIbf88AUSw8l+0a4lt5ZdhlPePWt0JdXyGprZVCF0Egfgde0zfi8HAviOF+UjmGv7aZ37LPxBhMbzMVwbmj5ZicV8GZ68WUy/QXP7PzpBytrXf1K/jDRF3Id+zTh/Z9/1XIkMsI5YnSajPcySXPdbtV0EM49nMSHv8YuaQBWqzGiNGpjkKnFXNCPseOupAb6KdpPh9FW5ZDW7aYOGmyjMDHDsCzw1ok5FdUlqopUX6o4u7gScvLmB6JPGjJuNfDf9mUkBBPUowcnuqwJMFIfR5IYpJ4XKyoXBnIb1uFDuJKo554CxBuevW0JrictF8pMTMpdSSKCjQGczmZqM8a99qXCiSwXF8HbJnRhwmji0wyNGPee0TM76g8Pf9ODhM9p/GN25zXMyp6zE+HImgGtj83R5U5sl5huBLb2TUDF9XyJfJh3UNpQVuyuoqmFg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(39860400002)(136003)(376002)(396003)(451199021)(2616005)(83380400001)(82960400001)(86362001)(31696002)(36756003)(38100700002)(478600001)(44832011)(4326008)(6486002)(8936002)(2906002)(8676002)(5660300002)(66476007)(66556008)(66946007)(31686004)(41300700001)(316002)(53546011)(186003)(107886003)(6512007)(26005)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDRkQlFGa2dHUWRlNzF5b3R3YVIyRGJ2dEJnVmlWbDRWMWRkQVdMVjJCWEQr?=
 =?utf-8?B?clZhN1h5anNwUVpEbFY0T2krWVRVdDdaV2pzZWRISnNhZkMyZlpUSExhV1Q4?=
 =?utf-8?B?MUw4Snl1ZXJMT0dsdXdKSWlsc1VJZXNiOStOY3dMUHhaZ0lpeCsvemtPeXZS?=
 =?utf-8?B?TXVSYTFwWVVtK3BQZ3FHUmJOc0ZObUc5dTFraFh0UC9kZ1MyNnhNUktUbFEr?=
 =?utf-8?B?NUlWbDgzeXROcU5aNUJwKzN5UnFCV3NLd0U3U0I2QWtCL2d4MFdCOGhuWmZZ?=
 =?utf-8?B?eWpwRFFxZ2Frdkdyb2thMEU3VnJQUWM5bDNwelRoTjdVdUloU1NCd0xSSDNJ?=
 =?utf-8?B?YTU5bTNCSzk5bG9rT2hIaWMyYUZoMUpCZWppZEt0LzEycW1qWmhFZ2NvN1Fi?=
 =?utf-8?B?WldyYXUwdzdpdW5CWlVOdjUzakNabjQxWERWZ3o2Um9uTk1VYTVkNjdhZGpi?=
 =?utf-8?B?VVZlQkdPQVdvSzFHQVFkZnNxK1VwKzJCK3RUYzRiM25NTXpjdWdmRmRZaDRB?=
 =?utf-8?B?SXE3eTNaUEFtQzRPV1hVUWtsYk5tTXR0OXBYb084bjVNZlY0L2lRKy9oNFNM?=
 =?utf-8?B?cjdOVkhGeEhGTnhHR1NJVW1NK3RMSU5xTmd6aUphazNJZ3lVOTU5QWh4a1VV?=
 =?utf-8?B?dTcyV0IvMjR4WGtydHIxT00reVljWkpTQlBwRXFSSmdKeUJDdFJtWVgySWh5?=
 =?utf-8?B?Z1JKd0FaMDY5MVFPL2hWYjU1OElLM0hOZXZMaTZYaC9VaTJGNVRkRm04aDlQ?=
 =?utf-8?B?VnBZOWRhR2J3V3VYR0xjWk9UQ28wemk2cWt2bHBCeWNMQU9NcUlxY0t1THFP?=
 =?utf-8?B?VFdxb0cwZ3RuQ0dMVlpaL3hJNEN3ZGRITHMrSmpUYi80UmtwTHd2R293emJk?=
 =?utf-8?B?U0IrbkUveWMvVWJxK25rN0JYeWhpRVNpaE9CakUzYWhaMFY3Umxuc0M2eVg4?=
 =?utf-8?B?djh4QkdzbVM3RnBuN0xRQmR5OVJTN2lGNFp4TzFqOEIxSWRsMlJoYlI3UHcv?=
 =?utf-8?B?a2x6akdhTHErU3BFeHZDeXF6Q2tKamppRERpZUhiTi9BUDY3RHNVQllMYUJz?=
 =?utf-8?B?RW5uUFc0WGtNcU82Wkh1NjA5bVVabzNKOStkUkRvakNrRGpXOW8zWVk2NmVv?=
 =?utf-8?B?NzFrMEdyaldFbmVMMmlMWGRlMHhnVllCMFZ1eHVscjF4bmxDUVJTSlpEMTNP?=
 =?utf-8?B?WVQwZUtQNExDcVZiTmV5UHMxMXNFRXJEV3FRb01xQ0dQRGxNZUJ0Nk5YQjBW?=
 =?utf-8?B?amV0b1plRnlGaFJXS0Y5NkpuN1ZOcGhUQmFVUzQwZ0RoRHhHbEl0bmZ1VGpi?=
 =?utf-8?B?M3dHZCt6VzFJeUN0Z05vVEswZktoRUZKQ1BHeDJlL3dSUk8rR013TWVxemNN?=
 =?utf-8?B?WjRQclNUMWE3ZStPMlk3WXU4cktYUFBoTTc3NlIyS0tCZFZJdG1RN0ZPU3lG?=
 =?utf-8?B?dW9RTVB0eEc2eXNFaS9kVExWc0VpZXNCeXZVQUxEUUFKTG5VZ2xZZFRnU1Zp?=
 =?utf-8?B?NzZoYXJDV04vaHhlbm0zSVBFN0MxVDBudkswSmtCVy9OdG9nWVorUXRzc0U5?=
 =?utf-8?B?cDhPSTZTN29FRVdmWEFYN1Y1NkovRHYvMXluYzRqQVNtdWJTK1F0NVlvbjJp?=
 =?utf-8?B?OEptQ1lwVlR1QytwNC95TS9IbzBkZTg5K2dKaFlDcGtKNWN1R0djTEpqdUU0?=
 =?utf-8?B?WVl4dGpQcG1la0NhLzVJU1hJelhLNkxNYjJsTUkrMVZZbUc5b3RndWVzazA1?=
 =?utf-8?B?QkxtTXJtZHdWVVY3K3RSZXE2NnAwS2ZEMjJXdnE3eVpOaGswK205THV2UVRP?=
 =?utf-8?B?OVJERkVuSitSQTZWbGg0cldPY25tTkRDMlhJcjM5dU9iZ1dQS01xQ3ZzckRY?=
 =?utf-8?B?bEswRlV5dVZ5NFlkZ1FJS3Fwb2V2VzBoYTJxUnV3cFkvaEFuUVRaK2Z2bTlB?=
 =?utf-8?B?azlIalYvMWtsMjR0bkVEcmNWQ3hESzZiWFdjZzZ0eTVLNlQ1U0FOaS92am5v?=
 =?utf-8?B?dWV4ZmlEWFE5bURMMnpzUS9DeVl3eFFvNkliaHNkTW8raGprWEltZllSUVB5?=
 =?utf-8?B?WUVHaHJSUGRMNnNWc3MwNjlNeXgyUXE1dmRiTWFYZXVNSllHdTFxMnJvYnp1?=
 =?utf-8?Q?NQc1kEs8yXML+JGmPLbTzs00p?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c41c96eb-8835-4eb5-bb74-08db6c67d012
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 23:42:13.5152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iCPc1X5nxcHsABCqYClMszk95Cw+UR9RkG2W+qVa9w/330zZbyjEWC3A2DJ/cimV1tCkdsC3RO0mtkjpnvS6PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7615
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 6/4/23 16:32, Dan Williams wrote:
> In preparation for kernel driven region creation, factor out a common
> helper from the user-sysfs region setup for interleave_granularity.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>   drivers/cxl/core/region.c |   39 +++++++++++++++++++++++----------------
>   1 file changed, 23 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 821c2d90154f..4d8dbfedd64a 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -414,21 +414,14 @@ static ssize_t interleave_granularity_show(struct device *dev,
>   	return rc;
>   }
>   
> -static ssize_t interleave_granularity_store(struct device *dev,
> -					    struct device_attribute *attr,
> -					    const char *buf, size_t len)
> +static int set_interleave_granularity(struct cxl_region *cxlr, int val)
>   {
> -	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev->parent);
> +	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
>   	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
> -	struct cxl_region *cxlr = to_cxl_region(dev);
>   	struct cxl_region_params *p = &cxlr->params;
> -	int rc, val;
> +	int rc;
>   	u16 ig;
>   
> -	rc = kstrtoint(buf, 0, &val);
> -	if (rc)
> -		return rc;
> -
>   	rc = granularity_to_eig(val, &ig);
>   	if (rc)
>   		return rc;
> @@ -444,16 +437,30 @@ static ssize_t interleave_granularity_store(struct device *dev,
>   	if (cxld->interleave_ways > 1 && val != cxld->interleave_granularity)
>   		return -EINVAL;
>   
> +	lockdep_assert_held_write(&cxl_region_rwsem);
> +	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE)
> +		return -EBUSY;
> +
> +	p->interleave_granularity = val;
> +	return 0;
> +}
> +
> +static ssize_t interleave_granularity_store(struct device *dev,
> +					    struct device_attribute *attr,
> +					    const char *buf, size_t len)
> +{
> +	struct cxl_region *cxlr = to_cxl_region(dev);
> +	int rc, val;
> +
> +	rc = kstrtoint(buf, 0, &val);
> +	if (rc)
> +		return rc;
> +
>   	rc = down_write_killable(&cxl_region_rwsem);
>   	if (rc)
>   		return rc;
> -	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
> -		rc = -EBUSY;
> -		goto out;
> -	}
>   
> -	p->interleave_granularity = val;
> -out:
> +	rc = set_interleave_granularity(cxlr, val);
>   	up_write(&cxl_region_rwsem);
>   	if (rc)
>   		return rc;
> 
