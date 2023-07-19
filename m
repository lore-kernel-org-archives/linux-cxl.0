Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A30FDC001B0
	for <linux-cxl@archiver.kernel.org>; Wed, 19 Jul 2023 17:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjGSRmn (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 19 Jul 2023 13:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbjGSRmm (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 19 Jul 2023 13:42:42 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB351FC8
        for <linux-cxl@vger.kernel.org>; Wed, 19 Jul 2023 10:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689788560; x=1721324560;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=6rOzmrBrHkfRiNAeFKBbYZErQx7jacfSy/c4dSm3og8=;
  b=ig3o0MkCO4vDjOCrSkKJqGJzH2Jdd2lek0rdfaWOhMYpaHDxnNRZ+Y5G
   4NoCkZNV9BXFSq8lbPiP/kIkzX0SslT67KqMla1sRfk0rtwxhvu5YonwH
   FRAGb8WTvDwXL/8D3+qYGuoJL3kU4ab03s80qsaT2BwNU0qh6mqy8jwDu
   vOq03hT1NfnYxX8OgCi124uCaGDYVSxbAOyah/hkUh0FmrNFNRsRktCf8
   24mR4hSczBgkI31Ef+sj+Ukx+2V19GfpIxs4WTypFjzaDKeVQdjB6x9Uz
   Ro2I5uaog28YcqSFtM0gN1mkSixSyJbg+RYoFyaPcqWrePZ6UO1BG1tuq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="346123199"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="346123199"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 10:42:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="718078859"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="718078859"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP; 19 Jul 2023 10:42:39 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 19 Jul 2023 10:42:38 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 19 Jul 2023 10:42:38 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 19 Jul 2023 10:42:38 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 19 Jul 2023 10:42:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZVy+xmPpGlhoKdEAVMWISXTCns7AoalyZzRz5VIPxO6SjkHiStfN5OWVIX6DuM9s2guyMBqJIWnZsTGf2AOii7zUjQjoTl5AJ/UjIXEdzHm3rDyiyXY/t6KUNDrM1VWwMt8JBA1VZ4zj+iBMgrTDf6Qx8osEO3NKQZQLbqo6FBdHov+xURO7DvpoEcK716pNb1SX3+s49CuDhfnx0ZwRmiwuEGE1iuNbCgw63jqSA3gA3N5Eo7Cb2Ro1LhcYtUnvv1Pvaf4rg6ve/0U9exuP6oTz+rdiVafkTmQSFWDxnOvbYbFZp6FGmbjLX8kWpKXclxMG/nRhGs1a7zdgm+mxTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=64DestQdylxE9On+mfTR/HWecTgxRDYtxTsKTE3Q02U=;
 b=jNU+dBsHf0wKe+4m6pVvx0YKQBY9Mbx/TK4HUIAmXiKyM6ooM/No9J8qm/DviImHbAfFqm+1qvzU5jSKfYuhOvXVeKiWVmEIEQldW3Nl2OI2QrNS71tlNffFukf225RRNEy3wOfOqwJsGeCGgKyW5xXgRqL7MuqhYlHYvoE7y6aXjMTWwHTXamusKM9umy9EBuz6GyzCxw/k3FVcPrbaihXJ4qD1kido+ugCZ18fLqJ4NI8ZdBI6yCTzOAh+QKaKOfgxv6gkd+kI5op04imtnKf3aaqmNEe559mYhd2ULnOsFd5i7P0i7elaVE4HqoGghzCFoMR8/dUp0OV2a3gITQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by IA1PR11MB6100.namprd11.prod.outlook.com (2603:10b6:208:3d4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Wed, 19 Jul
 2023 17:42:34 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::be6a:199e:4fc1:aa80]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::be6a:199e:4fc1:aa80%6]) with mapi id 15.20.6588.031; Wed, 19 Jul 2023
 17:42:34 +0000
Message-ID: <e3b01acd-688c-ca51-e0c1-f8a62a2d38e6@intel.com>
Date:   Wed, 19 Jul 2023 10:42:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.13.0
Subject: Re: [PATCH] tools/testing/cxl: Remove unused SZ_512G macro
To:     Xiao Yang <yangx.jy@fujitsu.com>, <linux-cxl@vger.kernel.org>
References: <20230719163103.3392-1-yangx.jy@fujitsu.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230719163103.3392-1-yangx.jy@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR16CA0008.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::21) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|IA1PR11MB6100:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dc0622c-1adb-4499-361f-08db887f88f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N3Jme9QBoSRAvA9GbzxIef+Dt3vlrwCsEF7NP8KHD0jruy5O4Lsb9pq6DKZN8o8S7gEEMNRGL++KtnCOO1pHYTeToJgH4qJvS2Cr1zm2sP7PN6xdiDSHag9qRDtkhfo/VktbEs1Pj561U9HSU+lQPsWuj4gtHv9/weV6ipbOFKdyAPkSYMd8ezeWch9Xqmx6gbkVUgo+OFrYZ5xDQAaqwvVEkDE99afcF33VONvAaskUr9ZQS8NS24lHTCDQ2Tvc5Le52159eohtmMT0kvkmgw+xtesuAuEch/Q+nGAQi61ZCnwVkyTCeIYhg28m0GgY3QYMl6KjzvjNxpp7up6hiSZA8isbe/cJimb8YW6PNSioMxfP81c4Q3YqcqwdveDP/YThcHOABKkmrm7sFMCzdAGb7T5VHoHCRYQc6/RswC9mNe0n9UynaxkV81QBKXiVeAQYo9CwP2RbhSqZupE/h9PYtz3aTUftuZ+D7PnTxqULlUGwqZYNRSXhBCC6fqTsNS7Yv9ObQuQX2t0itI4Z60L5ZmnhUJIGp4lwCmHbuL15Zzhvh7HpW9OfzGi80i8Q1EQe4YHMWEKAR0tEFJ9u0RtaHmm2ss7O49TF+UnmpiBbDiY0ztQjW/EOoniAwgBLG3eJiAOcf4/gn79nx/F81Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(396003)(366004)(346002)(376002)(451199021)(66556008)(478600001)(6486002)(186003)(36756003)(316002)(6512007)(2616005)(53546011)(2906002)(6506007)(66476007)(5660300002)(66946007)(38100700002)(44832011)(8676002)(8936002)(41300700001)(82960400001)(26005)(31696002)(83380400001)(4744005)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlpRYk5EK0RVVHpkRUllcEZCSFM5OXNpQTJGSlBadmhOZjkrbXlqWjVzU3ZB?=
 =?utf-8?B?MkY0Y1NxODluZ1pVSmd0VWdQVml5eDFiREd3SzljaGRyaU5sUzl1RTFWc1JX?=
 =?utf-8?B?REE0SWthbTRLWlpUcWRTWDFPMzF5UjFpK0lLRllSRi92L3puSEoyVlhSd2x3?=
 =?utf-8?B?b3NiSUZKdzFMNTcxNUVPT0cwMk1aNGRYemFkOHE0VDhzRkN4RWhCVnI0WVhI?=
 =?utf-8?B?WmVXWDNNczhvbHRDdUFMZnZBeUZsa2JESlg1M0hYUExhS2g0WTBvZG9xV3FX?=
 =?utf-8?B?THJ5R2JSZmYzY2k3TFR1amJ4VlJTd0Y4dzgxNk1aQ3haRUFpOTg4azVXV1lQ?=
 =?utf-8?B?RXlidllOSUc1OVp5QnY5SGpycTFIQWorN1Z0VFNLTjdnY2Jxci8xZzJFZzRK?=
 =?utf-8?B?WGhBU0R3OVh1TUxHd003NkhzQ1J4ZFFZakN3YnpWVzZYUlQyaUJ6SDNwWkhB?=
 =?utf-8?B?UGdZZklXUFRpZVRnNjJabXJ2UUhGSWVXSHU1VkJuelRGQUwzcko2WjJnTEZw?=
 =?utf-8?B?OCtlYnlxRWkwWGQ2Mkl0RElnS0xudmV5QStucVpydlEyUXhyVWpzeTJrZzdZ?=
 =?utf-8?B?UXRueFdpRWpFNUR5OVdkU0NNNzdDeGVTc2NWN2NFNnR4aTlkVTJROWtOb3BB?=
 =?utf-8?B?SG9Xb25XczFCOWN6M0NqUkFXeXBOODlTblRqTUt4a2dncXFHektnRXdKNE9j?=
 =?utf-8?B?dC9jU25SRFNxQ0tMbHcxa1dNcTNxZkhBVDRVbHkySWtmMjdjRXZyM1NldE5k?=
 =?utf-8?B?VElRSlo2L0R2K2VuNEtwbkY4QTFWMm5wNG1JUGRRS0xPVE9PNk56bXV3MzJt?=
 =?utf-8?B?YkxIMWhuVGxZc0JIZVM0K3RrSDNjQWFqL0dmV2NiK0lmQUFESTBQYTRMUSs0?=
 =?utf-8?B?SkNjWG55QUx1bDd3V3JXRDY2c1VsVksxMjZJb3I4bnQ1TFRWS1U5MDE0QmJI?=
 =?utf-8?B?OTJNMGE4ZnZtYm9SbHJCRzNIcW5laXlWaEZQdlNZcEZDeVhjRkorR0tHR1pW?=
 =?utf-8?B?M2pUei81eWoxWTlGL0VjQ2pVMjY1eCtEVUxEMUoyYlRsZDBVMVdWai9NbEFw?=
 =?utf-8?B?SFUwZHlYSkZoUVgycmE0TFp0azNucWtZQlhRMHY5YVlGVy9lVC9ybFAxTUlr?=
 =?utf-8?B?YnJDbGN3NFM3aTRMOXhIRTdRZld2SC9vamtXcW9ETExjVkhtVTlEaEZBUGp3?=
 =?utf-8?B?aEV1Qkc2aVUwSVE2STRTbU1VNXloVHRVSk1udnZHdWVmUlM2RG1NNXBUaHda?=
 =?utf-8?B?OWlFZHcxVFN0OHlVTWphM3lHVERvcDRsM0E5M0J4Wk96emR3b1IwSEZWYnVX?=
 =?utf-8?B?RUVpd1daMG5kaE1lZnM5MDFDWFQybWd1eGpCT1NyY3d0aW9KdVQ4aUN6NG91?=
 =?utf-8?B?amdWOTNLV1NMMjd6aE52c1pNM083bW9HWnoxdUdxdHBlRFNLbHFUQmZ0SWtp?=
 =?utf-8?B?Q2dSRmNheTdyQ0F4Yi95WW16N2dMWXVLQUpNMTRJQW1rMHFmSmVVMU1CbUVY?=
 =?utf-8?B?d2h4QTV6S0U3akZHM2l3M3B0dCs4NGF6Ykl6WDRjc2p5L3EybzhnS3F4cjgx?=
 =?utf-8?B?dFR0dDc1cDcvR1V1Ync4WGhGaUpabEhBMWxidnhxRnowRkZoM2ZwTjNwQkFi?=
 =?utf-8?B?RitZZU4zZ0k3OGZPUktUdmVSQVIzU21VM3pib3VkdzNKZjR1ZWVWWmU4emF4?=
 =?utf-8?B?Y0J2T1B0K0R6SUs1YVJZaUJxUU05UUJJYTVJVktEZC9VOGhiS2d3R1BzbzR5?=
 =?utf-8?B?cFluUDlhODZ0T3ZpelBOc1MvSGpmTWpyNzJES0VXbmFsNGt5ME1ZVWZiQ1ps?=
 =?utf-8?B?a1pZNlNCK1ZETFZpL0I5TE1MeEJFc0lYQ1JuSHFvdEoyYVBIUkwzRTR3T2Y5?=
 =?utf-8?B?RklkWFo0ak1Yb2VIcDlVZllEQ2Jmd3dXa0xwUTRneU8yTnFoY2NsM2lXMVlv?=
 =?utf-8?B?SzBMcG5OS1dnM2x5KzR4YlU5MTRHdEpLTExrYXo2YTlPRndLYkxjRWl0aGtC?=
 =?utf-8?B?TGVPK3RMTW1ReWNtTVJYcHg2RjJpUGxMSXdVTUNKTTc0Z3ZmZnhZTklRbExC?=
 =?utf-8?B?YVdUY2ZRdStRVnRiRUVxazBtQUZrV0JnNFFFamQwOE5GajBCODNoM3Vha3By?=
 =?utf-8?Q?N536r9BaettmZhQ7GNuEZfkla?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dc0622c-1adb-4499-361f-08db887f88f9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 17:42:34.5249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: al37YMa+i+YXSAqNUiJZgrm6CMraO4F83+DTrA+HD/Z/WpGE+WrPKWfOhgolr1l/vIeEv2nIZKhfiC4DVD9egw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6100
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 7/19/23 09:31, Xiao Yang wrote:
> SZ_512G macro has become useless since commit b2f3b74e1072
> ("tools/testing/cxl: Move cxl_test resources to the top of memory")
> so remove it directly.
> 
> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Thanks for the cleanup

> ---
>   tools/testing/cxl/test/cxl.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 0e78d8e19895..fb6ab9cef84f 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -999,10 +999,6 @@ static void mock_companion(struct acpi_device *adev, struct device *dev)
>   #define SZ_64G (SZ_32G * 2)
>   #endif
>   
> -#ifndef SZ_512G
> -#define SZ_512G (SZ_64G * 8)
> -#endif
> -
>   static __init int cxl_rch_init(void)
>   {
>   	int rc, i;
