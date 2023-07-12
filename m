Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83294EB64DD
	for <linux-cxl@archiver.kernel.org>; Wed, 12 Jul 2023 17:59:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232727AbjGLR7y (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 12 Jul 2023 13:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232841AbjGLR7s (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 12 Jul 2023 13:59:48 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4370719BA
        for <linux-cxl@vger.kernel.org>; Wed, 12 Jul 2023 10:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689184784; x=1720720784;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4P8yqEFOfgXEnC8PRj0PCDX5F4EaS1JNfMtcoyuYlfM=;
  b=RgtO9EEkgA9eeCbQCsZL20LXVJyekvS4IBeeGzjm/LDTT/QtQOADWOhK
   Sn/7d+5zVgxILsB/FSMRBxs6oGPd9jyASUZv+3AFhXMFUNYefpT3oW31T
   62/M49x7TEGV1uaK+lJ/iOICyEaAKNUtWvvexvAyUbf/PLjTBhB1XCOhQ
   uKYLZI/xpGlIGJCx50x0y5WH8yNYWo4Jbhcfy6IAy8hBkNEoQR4c8vMgK
   mwZNcobsxotsNjLOCdFAO4nLjtCo4gCt44oKivLb5HNtkFu7O5CHhdX6Z
   Dde2lHNChRfN/S3kDAyBEuI/3nX664VB4UmMIs0qjIAxsV+jFfactLi+m
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="428703059"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="428703059"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 10:59:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="791709038"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="791709038"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP; 12 Jul 2023 10:59:43 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 12 Jul 2023 10:59:42 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 12 Jul 2023 10:59:41 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 12 Jul 2023 10:59:41 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 12 Jul 2023 10:59:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TgWnh7ubloYyK2I8T12bGCe3AaM2TLp/U1ZHFxkZe384QhfSuKLZt2+kJtXEhL3apJlMTonCvO48bUkpmKQQpRluH1Am73hBqox3QN/Dr/i7Hnc1UIIBoF6O7ciiSFPlTCmlEqFhjRwMYjXT01Rx55rDkZOa5gMkQNIVL8PzRw1sSe4xuBiN28/bOpNnrXIFtZ5fvqe4vxxrqNjXxOVKVqXOK6MTGAf/yMT7CmVugcBLEDZN3emclqpTd4WIfOLrogkZSfJ+zEjkY2lBsf6lw2np9KgoefiMwZ1BzdC9vzZS+zAMVvKaIyjvtgF/NjK+lPcQ1GnmJD4ioj2mJNGL1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z8SnxpRXVCdjGOoTlPitF6OJLvTVKMkaMZj8taTy1FQ=;
 b=X+0rSZkDAQok8DjaWyeCxbyDnQ4/Q8AlUuw+gsZBsrMKLTP2yc09y23tUTMdNCqP5OVUS6Dvbtc3Tfft2nijmSPtLwAPq6OU0ix1DEvj+3mg2KKTI2WNMckI6RpL3P6o0Dbzq4JvFc8B+MYepwLmX2+5dDb/lJcHzJJOjezN+rTup8EYaksIAi2Z29Y9iVN5T47YGURcQFZj6hOa5Wg5WVacFWIC25m8t/kc8EcZhA6tV7o7KqC/drafRN5zianOPY0Ura55uiHStZguKorU2/ym2V8se8y7jt1oDH9owhl0NeRm0B2d/do1d+NR5BC3ttNo0rk92PVKOdqAyl5MaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by BL3PR11MB6459.namprd11.prod.outlook.com (2603:10b6:208:3be::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Wed, 12 Jul
 2023 17:59:39 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528%7]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 17:59:39 +0000
Message-ID: <ebe2ad81-09ca-9e88-6b78-dcbe4fbf4219@intel.com>
Date:   Wed, 12 Jul 2023 10:59:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.12.0
Subject: Re: [PATCH] cxl: Fix double shift of CXL_FW_CANCEL
To:     Davidlohr Bueso <dave@stgolabs.net>, <dan.j.williams@intel.com>
CC:     <vishal.l.verma@intel.com>, <jonathan.cameron@huawei.com>,
        <fan.ni@samsung.com>, <a.manzanares@samsung.com>,
        <linux-cxl@vger.kernel.org>
References: <20230712164224.31891-1-dave@stgolabs.net>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230712164224.31891-1-dave@stgolabs.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0093.namprd03.prod.outlook.com
 (2603:10b6:a03:333::8) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|BL3PR11MB6459:EE_
X-MS-Office365-Filtering-Correlation-Id: e3aedcab-df71-49e5-b772-08db8301c328
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 90VEm5C5uXpTGFygNSnkTb1gmMnYEx4jl3noQ0/rd9mFaV0mZOyxLaZWwPjFPLQcPvqmpODPKdD8MLb6zpF+0jihWEtZdJSx2Sc+cUa5tLFMHnf4EBx+SrTq9vn8sFkO/BfO+h007pKdSZnp+NojcA6NyRPDWbtllRrAutZCCJHq58gbN+MetVeHsna3VlL9sQu02pdRvFKBf5GIY8sHR7QyUbdJeXu+Cy2Obqoxq5RA+OzS2nCkzQ/h4VorrAsZwX77bxiz9aJNj7tjRHzUVJVpp9DQbi5fBlZ8AoDLN2zsMgfk5BQyca4+9xGCHJ2pVSOQNe6Sj2g6aXcc+ZntnbsdKk+5izpBWAupo9Y3QHLUU539ct9n/KDgK7gaspWzoPzjnY1ZXL03A7d/Ot31Vmrp+/nV1DPDTH5D3bC40GSNwnusPl28GzmVSvrzf7RK2sJCBiLhScwVAP75OyNCnyBhY6wipYd5L8cS1AUTHUxZ+1NhDW9FFjStxUe6eqXNDqoiEWOR9Xg42vh17Y2m1WR9LmttDw4N3DoSU4JmCS3Z/4UScY/HOFt62Vd0ekM9av8I41S9tpsyhIn4OTjGCMOQ0WmlhYpHmCu+crA3JLRl68Fr6ZKFglR64ONZrL9LntZkyYTzNPj6xaRmzu6iWw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(136003)(396003)(346002)(366004)(451199021)(2616005)(53546011)(6506007)(44832011)(31696002)(36756003)(38100700002)(4744005)(2906002)(26005)(86362001)(186003)(5660300002)(6512007)(82960400001)(4326008)(66946007)(66556008)(6636002)(66476007)(478600001)(316002)(8676002)(83380400001)(8936002)(31686004)(41300700001)(6486002)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZitmQ2I4YzBpQnUvS0xRdkl6bG5xRGxMZGJEUE1hcU54S3ZzY3BPa2ZqS3hw?=
 =?utf-8?B?enM1aWQ4a3dCRndCaW9FTjZEM0lienAwMTBMRkZXUmJJbHBSSTZsdm40bzE4?=
 =?utf-8?B?SlpRcm1UVzN4SUYycGt3MGNFMkgxeWhsczFrM3ZNMmJhWW1JL1JacGUwZnBO?=
 =?utf-8?B?Z3lEQ2Q1NERKRGdWa3MxZjNZZ21pM3g2cVJSS09zU0FzZnVWamlEUGdMb1g4?=
 =?utf-8?B?RGdzcnJWUjJTVDFNQVJCbEppMGsxSGJoVEtINGZxYU5wcHJRRS92WVlONURz?=
 =?utf-8?B?dmRxY1lEUU4yRWJ4UGxsN0hqaWpUZUlMM3JRSjIvVDF6cVJLNnlGeHZCSVJ0?=
 =?utf-8?B?a1lmdHFMQ2pIWmczcURRZnVyRmF2UjlKYm1lNWxmVUI1SEMvY0NiaE8zcmpK?=
 =?utf-8?B?TmpQL1h6ME9iYzliZjRRSTFvbHBvZ1VuOEpPS0ZGVDVDd3N2aHdkdFRmcGN0?=
 =?utf-8?B?OUJaSUUrY3UwZ3BZYi9mTVlEczh5MmF5bERjWTlIMUdZWUFYV1ZLb3VOYzY0?=
 =?utf-8?B?U2Fidmk0dTJoRHFLL25lRVEyZ3BjWjlaZHM4VG9Na29LMGlRMkpEQWdqN2pl?=
 =?utf-8?B?S3FQWSt2T3hIMllicGdjL21NNTl3SmpCNDJFckZIZUVLYUR1ZW1Fa3I0Wmh2?=
 =?utf-8?B?VlBuc3lGVWhRamVzVS9jRkF6V1dDMUJlQkJCb3Q3elJIZHB6NFZxbjRMUEk5?=
 =?utf-8?B?N3BNSWhCKzlxNzBRT0ZDWnpVSVRaU0lCUE44ZFVZcXdNSUdWK3JYRndoK0M2?=
 =?utf-8?B?QTV0VTFwcysxV2RtaHRqTTRXZzFSbm9iaThtQVNDOWVLTXBWSmF4SWdYSnMx?=
 =?utf-8?B?bStCTVpuWHh3RHdMM3BjVE1JTGJ5cEd0UWdUTFlwMzhCRWYxT3JUNmozZ0cx?=
 =?utf-8?B?TzVUdFczcUtncnZSd0JoU3RHeEE2UVFaQ2M4NEQyb3UxWmlFY2VRK0lqR3pW?=
 =?utf-8?B?UENVdVk5aHo4UXd1U0VaNWQ4K2VYMjlUVnk5NzNxcEtsVkpDODJnMlhkbWxy?=
 =?utf-8?B?b1J3cFlRcGlyMkVXdmtCWWRQelFLakpLempaZXkvMHl4eFltMnJuNlZHazd0?=
 =?utf-8?B?UlluUDNMdHkycUFxWFVJeUUwTnJNc3lTdW51WTNaanl5bWJDNTZ1OW9MNlds?=
 =?utf-8?B?VGprdXZKc0E1a0kwQU4yZTVydTBaSFdUeWNud0xjUmUyTlZ5R1YwTFpBUTg1?=
 =?utf-8?B?UFRJbVRWdC9OSWw2am5USFFvQmNlYWxFUXJKNXNzUGJDMlZ5SjVlS2dZeWJr?=
 =?utf-8?B?QU1Jd3F2OEd0TnA3b1FoRDBTa1ZKRy9sd1FxeGRrcklacnlDUGphK0ljTUx1?=
 =?utf-8?B?K2ZrVmxtU01hNENacUV3V2dzNUdvdzdaalRZdmZrTHFHTnZKTDlOOWg5VXpw?=
 =?utf-8?B?ODVuUEEwZFdlaFlOcTJUL2IyTlpZVGYvK2hsbE1QbWNVeHBzM05RcmxsV3VM?=
 =?utf-8?B?ZjIxMkxLVFBxU3NDRjlFOWFYUDBPZlVQa1ZCTVpmUWYrNWxhaC9OV01DS0sw?=
 =?utf-8?B?OXp1TCtQYzJnb2VaVkRjaXJJOGc5TXFyMnQ4azNhZEtleEJpcEhsM2ZvU1Nj?=
 =?utf-8?B?K2Z5b29BaWdYdzJtZXQ3US9qOWZLdmt3aDZhN28xUWdEcHJEZHdlVjJDS1Bk?=
 =?utf-8?B?RGVtaUtlN0FDRmVJaGViMmJpT3dxOTh3NmNPbGhlbWw4S3VJUW9FUVM5WjZN?=
 =?utf-8?B?UWZLWk0rRFl0UXBXZG1oTU1nNlZUcTdoQWxhREVPQTQ0VnZHbzB6RldMZkhH?=
 =?utf-8?B?aWQyQmt2YW1nWFAxcmFUSXVyTHJlTjkyYkpHeDBlUFNibkNSVEw5aE1oWm5p?=
 =?utf-8?B?K3Q2MkRnVTc5SmdjMkE0SVFhRWNvamljRWlPUjE0bmd0bklRZlRHNFJEYkxF?=
 =?utf-8?B?RFRsUVJVVEgwVlVMb3AvR1FDZEZnWVhpVEhjUks0R2FLeStoZjF2S1h5cXNy?=
 =?utf-8?B?eWpVVkNvdE44a1NrVVUySWRTV2F0QnJBTStEK1pROENnU2RyZVdZQ0ZDSjRn?=
 =?utf-8?B?ZTljNW9BdEtmVGg2RXFGa0VubEorMElBQVhFbnY0RkRqQnBwQ2xHVlY5WUxW?=
 =?utf-8?B?QytwYVJIYU1lN1FYb205aGdKY0lPOFJSeVlIWXJVNzVYbjVvejk5eE5CMzA2?=
 =?utf-8?B?NzI1T3U0bXlQSldoYnhXY1pkdnZDWjZsdDI2Z1lwUDd0cmJlT2ZhM1dXNC9J?=
 =?utf-8?B?VGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e3aedcab-df71-49e5-b772-08db8301c328
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 17:59:39.7205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: keUIlxmg6v65O6EYYhyzjXVzY20OBVQ37bdv5NqWAL2stBTLiKddZP0UcbOFSINmoPyBf4vApIMUZOyuboESCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6459
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 7/12/23 09:42, Davidlohr Bueso wrote:
> Directly use the bit number for bitops, which already has a shift
> built in. This bug is benign as its done consistently and it doesn't
> clash with any other flags.
> 
> Fixes: 9521875bbe00 ("cxl: add a firmware update mechanism using the sysfs firmware loader")
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>   drivers/cxl/cxlmem.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 79e99c873ca2..499113328586 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -323,7 +323,7 @@ struct cxl_mbox_activate_fw {
>   
>   /* FW state bits */
>   #define CXL_FW_STATE_BITS		32
> -#define CXL_FW_CANCEL		BIT(0)
> +#define CXL_FW_CANCEL			0
>   
>   /**
>    * struct cxl_fw_state - Firmware upload / activation state
