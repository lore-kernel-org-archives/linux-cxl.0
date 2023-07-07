Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD25EB64D9
	for <linux-cxl@archiver.kernel.org>; Fri,  7 Jul 2023 16:50:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjGGQu0 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 7 Jul 2023 12:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjGGQuZ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 7 Jul 2023 12:50:25 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3861C170C
        for <linux-cxl@vger.kernel.org>; Fri,  7 Jul 2023 09:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688748624; x=1720284624;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dMVC5O7/Wwv3R+NKEOTkFGHDlAO7OM1cKd/U2DU2Vck=;
  b=MW2EyshEGlqv8VbN4oG/hANROET+3ZPPqz9O2lzaG4pixBTWjiY/73yU
   ANaOAUAFskJVTSN5D0kRFb1iH++71BzVKqoM/Zapvo03tTo6bwaSIJ2ER
   9UEZ5QnhKjUEgO1iUy/rwvK+bey41vYt+tF8/jvAFN5m/4ecJsm06q/oY
   w6HCqaHNwh+A3vLeWvCg/c09neHakvKZBW/mIWMRi4/J874LwgHPyvufB
   ZXJCYaqH/4Rqjj6fRLbzkStqGIG3Mp57cSg7CrqZ+ZvMs4ti92dH47GO8
   5gNeccA+JOON5jrgoPoaFfx9XTBa1HlRoFJrX3xIx8/L8x+Pnp6eDMFm2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="450287063"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="450287063"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2023 09:50:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="755245170"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="755245170"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP; 07 Jul 2023 09:50:19 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 7 Jul 2023 09:50:18 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 7 Jul 2023 09:50:16 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 7 Jul 2023 09:50:16 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 7 Jul 2023 09:50:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GsTkRkB9Bbk1xiqNtD0xjwjunh5y4aKou27uQbpbouqOTH9NtXR0lLuyqIFGkbXVb2PT5DGE7DZWSfu1SUVg6GftxvjaJ+92Gkqa8QyUURzjmfLiA4wRQaFGSsB7f72V0hV7cqemh1DMP4AMR9g2OMwJGAhj0/ajrlv+axM7HyqJVzB6gMCiffniJgT+gA3YHSyALuz8QuOjoIhCjeLaw7asb4/eaLgnWTZ93/l0U1IFUdFtCEy9wNI1GJj7QuMNiwb0kPdp/SPa1ciroKzyUetH+7Va5rakmdppnSaCx+kqQj6NHkDLIyfXzEjj4apvB5fYwRSYap6/cs1kFc27Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fxwd4YJXZD5av0cmpTSQHQfElM3sghBcHCr2+s5h0cU=;
 b=Fh4a5ETQtBXRGfQiOIEU6Sy3Xr8ZQhhwVQEoRRB5McMvyuq6zcEBV1b306o3Cpr40O7C1Y1379q42oQms2LXc3wRGjAhN2dOjWzekFinCZsA+D0eE5JdrWZhSANZ4pI3ai7NuvxCF4m/ACcA+AlQWYwDPAdMRZL8NRWeFslwLTHLhubSfNC3AmSgAnKMd9kLC0LgppPXEFgiz2TlpjBOZ3eXbidGdcMQ9O27J+xBBishTJgbQ/spr2tz4M5pEJ0HSyduyxCwtxNj/sJiRq9h/48wEJVXcWLYX/fQ97QwCddEZg/ugAoiUoir1ylXXK41Y7M3FGdh2LMZe76ayX+ZQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by DS0PR11MB6469.namprd11.prod.outlook.com (2603:10b6:8:c3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Fri, 7 Jul
 2023 16:50:13 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528%7]) with mapi id 15.20.6544.024; Fri, 7 Jul 2023
 16:50:13 +0000
Message-ID: <fb897ce1-3abf-f5b6-6585-1c74054beb86@intel.com>
Date:   Fri, 7 Jul 2023 09:50:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.12.0
Subject: Re: [PATCH] cxl/acpi: Release device after dev_err
To:     Breno Leitao <leitao@debian.org>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>
References: <20230707161616.3554167-1-leitao@debian.org>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230707161616.3554167-1-leitao@debian.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0079.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::20) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|DS0PR11MB6469:EE_
X-MS-Office365-Filtering-Correlation-Id: fedb643f-70eb-4ee4-1a52-08db7f0a3bce
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ktwlDqHZZnTpz2zNgP+Ysata4/Gv5Se6JYgmGu6DcjhlT7l6IraXFDBW600JrleczdI2HYZVNJweANi2cJnjfk789asBDrTMBB5TWl3rayMAw3YccwliPm5Oerp7iUyh4jjSOTt9+EVfPc943ikvgtB9v1u+NfBQ75FPrlKeW787pqj4QCOOu7muPlUwHf2e1uX/iy/uL2Bz1H4ll1pdjmVblYSCxvSxlnScOHwhzMskjKyEnx5ElmBjuNPQ6j21qibNOU88kAyzjERxA9zsTOAmjLY55fvX1HcvV4HynAeb7iKcyKRsduqtUHjQHyOfG4NUqnLt4YBFOvwQnsIENgfvgexxejeoUNShz2u2vZjZFSzqmqP8y7USS3ktXMvOYW/xAjt6U2ueWR0QuqcpZXLE+K1DkduFnl9Zan1M7w9XKvLv1btZxkZtaimiSqFHj4KoTFul2yOlhqXbUVccFQ7UwRxvn9HELRD7HQzIeDI07XaYsH2AJpIvg8vKNHI5yGZl7m1DCvaxM8e6su6eK0BXO3e8G2bvh3kU4n7GIkZ5h5cSKtUDzcWBXEz8cgHu/kknX64KsoAev5SrJ0OcIHiFnzP/jOmWmqSbBKsI9PRQ2yXnpHWjyR2C2s5Kxbl3JieGbiQa++OS9CF0M2CieQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(376002)(396003)(366004)(39860400002)(451199021)(4326008)(6666004)(66556008)(82960400001)(6486002)(66946007)(478600001)(8936002)(6636002)(41300700001)(8676002)(38100700002)(316002)(2616005)(186003)(83380400001)(6512007)(66476007)(26005)(53546011)(6506007)(31696002)(86362001)(44832011)(5660300002)(2906002)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmJPMnV5anFEeWRPdjU4Z1JFTUgzTGhXQ2pXR05uazFvN3gwK2JubFFlaWRi?=
 =?utf-8?B?RGZ3c0ZRK0VTL3U5a2RxM1BsNzZpa1J0TXhBZ3hQMkwzYlphdW4yZHJnbzJZ?=
 =?utf-8?B?M21nUzJSQzVhZ1NzcExpbzQ4SHJadkxETzd4SGJMeVlLL1I5ai9mYUN1TFht?=
 =?utf-8?B?dVNnUkdYK1JmaXJxMmlaZXhXVTZTdjZMNFlKblpuVkt1MGpkbUZpdUJxc0xp?=
 =?utf-8?B?RUExMkYzQUJielpPK1lFTTVkSEJpbDdEeXVxMjNOTVhWQzJSOHpyY0hBR3Vt?=
 =?utf-8?B?ckc1aHlQeExFY2pscC9rVWRTd3FiYXN0aHdZRnMwZXp2SldocWg2Z0tuSkQ3?=
 =?utf-8?B?R002b3pENlFkS2hVMmpUVndicWhwSkV5RkJDb3c5bFAzSHNiVnU4QzJ4NDMr?=
 =?utf-8?B?a0YvMXhDTElEdy9tZWFweldiYS9iR05abEQ4YTRkVWt4aDBPRmd4RUJ1R2lH?=
 =?utf-8?B?Rk1QRmJKNVZsUCtRdnVIRzRHQmZRWFdBeC9Hbk9PRjA1MldTNGc4UVl1VXQx?=
 =?utf-8?B?U3lsVzcrRVJiOFh5Zkw1T3NSNytIbHBCdUpnT0dNUW4ydk4weUN5Z3pCSHZj?=
 =?utf-8?B?VHYzWjY5UDE5K2JnV0QxOHZPYjVMeUE5dEx1V1pwQmIvbmhEUmI3NDJuVlVi?=
 =?utf-8?B?Y1pGU3ZXa0owMDF4UTNKcXdhelphbWY2SXp2UmtDY2RBOVprK2pXUXJRdFVn?=
 =?utf-8?B?MkFIQ0l4WWk3VUUzZ3FvS2lRejFteHl1K0tRN3R6TGRjSUY1c0tZQ1FFa2Z3?=
 =?utf-8?B?NDU4K05NK1RhVWZZdDZvQjNzSzRFN1d5eDk4Y2RrUUVFaVJnNVlHT05wZE9p?=
 =?utf-8?B?OVJUUmgySjdiN0t4NnZVeGg3RnJ1SjZUbzRwcmdZbm52WnRHVWpUSG9vSjRx?=
 =?utf-8?B?M2duWTJua3dJUHFrSEFscDdLb3MveisvdzMzN1ZVR25pcURwbDVqM3RhZlBl?=
 =?utf-8?B?N0xTWlBsOWJycmdFSVVqUWxxOCtZNExETXZLOStWQW1TUXh4UWprU0dlck9q?=
 =?utf-8?B?SDhVS05sNm5FMjNXWTFLeWYwSHNaRGM4dUYvU0MwZHF0Q1c4ZG1mRURER1lD?=
 =?utf-8?B?Q2pWS0NDSnN3eC9PQlV4UEpnUFM5UDBnU0Vuc0pzSTRIM3dablZqMkpvVndm?=
 =?utf-8?B?WUpseEFGRVRLSXZiSkIwL3laeXhxSTRkUjJPYVdCVWs1cEVhSHp6TEFXQVdq?=
 =?utf-8?B?VWdxc2NZMHF1MmVzKzVPKzNVQmJQWlNZL3hXbzlmUzl1VEREa1ZldGNYOUti?=
 =?utf-8?B?MzlPMTg3YkZ3V3poUGsyVWdUU21SdVFZK0x2U2NmLzNXenBzL2F1WExvTDJx?=
 =?utf-8?B?Uzk1dVAwa1pNZnJuN2Z0Mkw1Nkc4eGYxdjlITjZCOTE3NjFoREpMazNEMFVw?=
 =?utf-8?B?MzgwRHlzdEMybjlBaWcrQUZXTk5NNTZ5aFpXaisvSEdZbWxieW41SzhkMlpY?=
 =?utf-8?B?TXdSL1BLUTZKU2s5Y2xjWTFaRGFiS3M1YysxZVUwQnlwWFNYNjg3SHdwamdu?=
 =?utf-8?B?L3NrTUVLaUZRZWw4ajZKalJqVWhmVEF5MVNTQVliNnlzT3NQV0xNUmFqZlhW?=
 =?utf-8?B?S1F4MTBGalRPQWhGTjZvdzBYN21zNGxtRVRvQ203LzRXYmZsZmhjT1VnSm9m?=
 =?utf-8?B?UE1sSE1HSHlIeElqN203TUVQYVZ4TW9QMjRmQ1BSOFFhMDhPNkYrNWd3UTdv?=
 =?utf-8?B?VE5ubnZmanp0YlgyTDNHc1NobzRmdE5wK3huU2djZE5YdHRiemJCd1Z5cGhF?=
 =?utf-8?B?ZVV2enpkditlZmlYVHhsazVVNENVTTM4UzRIbXYrcHVVdVo5ckxmSVpnSC93?=
 =?utf-8?B?MWtzcFNOekp6TVpIR2tyV09LdlQ2Ylhmckl3YlBSRGlIUVdmTnJvR3ZicTE0?=
 =?utf-8?B?cE8zeVQ1YWVaRnA0NklQUmlvV095ZkZZN0MxZHY1b0lZUjVGbHhZbWpJcnFR?=
 =?utf-8?B?c1JzSWZUR3Z0NS83akxKS0hlVTBWQTlZVlREQ0VlSU1RTkgrRDF6THhxYlVx?=
 =?utf-8?B?elV5RVhjUGxMZGlWK1YxNC9PRTQ1VUdyQUw2V0ZDeU96WUhualJvbHg2TUwx?=
 =?utf-8?B?SU1PQjU3R09sNGxjTFZzYnJocU5yd2VqN2U0eWxmVjV0WldpODJHSkhjTjRi?=
 =?utf-8?Q?JPMw+sNSOwyv5I/ueqlPZdFUs?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fedb643f-70eb-4ee4-1a52-08db7f0a3bce
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 16:50:13.5338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eYdUaS03XPfME4R9ZHTaM3KoLz2wS/+j7862JiqyfzeKA06IX4mCbIhg95B1FdFRhOw1wfgMiJCQ70XddZgxAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6469
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 7/7/23 09:16, Breno Leitao wrote:
> Kfence is detecting a user-after-free in the CXL, when cxl_decoder_add()
> fails. Kfence drops this message, after the following:
> 
>    BUG: KFENCE: use-after-free read in resource_string
> 
> This is happening in cxl_parse_cfmws(), and here is a simplified flow
> that is coming from Kfence.
> 
> Use-after-free:
> 	_dev_err
> 	cxl_parse_cfmws
> 	acpi_table_parse_entries_array
> 	acpi_table_parse_cedt
> 	cxl_acpi_probe
> 
> Free:
> 	cxl_decoder_release
> 	device_release
> 	kobject_put
> 	cxl_parse_cfmws
> 	acpi_table_parse_entries_array
> 	acpi_table_parse_cedt
> 	cxl_acpi_probe
> 
> Alloc:
> 	cxl_decoder_alloc
> 	cxl_parse_cfmws
> 	acpi_table_parse_entries_array
> 	acpi_table_parse_cedt
> 	cxl_acpi_probe
> 	platform_probe
> 
>  From my reading of the issue, the device struct being used by
> dev_err() was removed in the put_device() before.
> 
> Put the device just after the message is printed.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>   drivers/cxl/acpi.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 658e6b84a769..5179bf4211d8 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -291,14 +291,13 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
>   	}
>   	rc = cxl_decoder_add(cxld, target_map);
>   err_xormap:
> -	if (rc)
> -		put_device(&cxld->dev);
> -	else
> -		rc = cxl_decoder_autoremove(dev, cxld);
>   	if (rc) {
>   		dev_err(dev, "Failed to add decode range [%#llx - %#llx]\n",
>   			cxld->hpa_range.start, cxld->hpa_range.end);
> +		put_device(&cxld->dev);
>   		return 0;

I think you will want to change this to 'return rc;' in order to reflect 
the error.

> +	} else {
> +		rc = cxl_decoder_autoremove(dev, cxld);
>   	}
>   	dev_dbg(dev, "add: %s node: %d range [%#llx - %#llx]\n",
>   		dev_name(&cxld->dev),

You also need to change the 'return 0' that follows to 'return rc', to 
catch the error from cxl_decoder_autoremove().

