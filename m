Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B9DEB64D7
	for <linux-cxl@archiver.kernel.org>; Wed, 21 Jun 2023 00:05:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjFUAFG (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 20 Jun 2023 20:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjFUAFE (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 20 Jun 2023 20:05:04 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F3E173F
        for <linux-cxl@vger.kernel.org>; Tue, 20 Jun 2023 17:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687305903; x=1718841903;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=n6jZUEjzWhfvMizDUHMMbhS36WakICN8iFzwoTV04l4=;
  b=FNhsVknGIKayGqdfSO17LaDeWtBFsMztFT+reN7y715PZ61OgyLtZAj4
   kvQNLrEtn3WDcb2U6nCOUGoqAHH3EPm4lqHNzMn4j9/Q18zq+RvcwxFYR
   ISyRp4p8S9S46fMjt4njiEF+O7Uu/Ll1Fi5NS2CVHnVq9CH7MNmgS5pUy
   ilQYfIFwAin1mzlZjQHd5qUl3r3o/dHE8s4VYvLvuiRpvSCXaogzVmPlw
   AXkf74DWnoP7WOEI4bMSds5yMnoAs9xLHgViInO5fvS+a+GVLSrWUizHo
   NCK1aG2LJ8vk4GUvyY7aX3HiTEaBTQt9uwEKI6qiuw89bhCHbe3t4YR1/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="344757701"
X-IronPort-AV: E=Sophos;i="6.00,258,1681196400"; 
   d="scan'208";a="344757701"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 17:05:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="827211871"
X-IronPort-AV: E=Sophos;i="6.00,258,1681196400"; 
   d="scan'208";a="827211871"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP; 20 Jun 2023 17:05:02 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 20 Jun 2023 17:05:02 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 20 Jun 2023 17:05:01 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 20 Jun 2023 17:05:01 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 20 Jun 2023 17:05:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HRVpOlY7wYP+AZoslbg7r8E1VRKZ0CTbGKNmFifzNphwbw+ACbdLg3k7SqyesYX84QFeWB0PsURrURF2sqYIkxOEr81i57jbftUM9BnWQwmx84k0MFIse3P+SI2qnvE+1D4EY6K3lTmCKPGkWvwptLdlFadVf3HBS0i+e3/rGfMJ3eKt1phY0C1NidPTudH/ml90V2KF7jhWdsu3mvxHO4554guUjjA1xpyAkCoBpXclA9UZ9QfvAC9852PT8p32S3X5WlAmbY5TRZypc1Xs9el3YPxPvYMzgfROQF3UEnuVdNcEet8rIPvHOG6AQAD/owIIdmgEp7r2FQ+hOI41zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JU7ZNXTM9OOO+m3q5jKHW2IaHzAl5uQwu+4tZTh8DyM=;
 b=MZOwKHzCr6rdcOW5mc8G2YMZYAudEz6aSWQDJxQXZOKaDz1n7CDtdWU03wK3VKRs9b2T6L0N+tEMAoilVTQ0up6tzStyRac/dZ+sWEe8OeWu1P41ZqmnMMU0LB4ETMcS5sNnKblwCn4MbtzWb3Ew6wjxQ2eVIneMuqUiZbftAgXSp0dzN90dMHPsPZXQE3E4QjBwrxMegjIoqo0/afNZQ7/9JRf3DWbX0BYVeQFyYN5AKzEwy5/E/9Ejq1qjIB1W364ZNLFU7MkQAYcq7jDK3MDQ0KKcF9ddFnSGseKuJYmD6GjtcUAjM9AXnzUn85yMYqUWA4tO6t3NqTrXrksifA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by DM4PR11MB6336.namprd11.prod.outlook.com (2603:10b6:8:b9::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.37; Wed, 21 Jun 2023 00:05:00 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528%7]) with mapi id 15.20.6500.036; Wed, 21 Jun 2023
 00:05:00 +0000
Message-ID: <9fdce293-6a67-fa29-0ff3-82dbb810120e@intel.com>
Date:   Tue, 20 Jun 2023 17:04:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.1
Subject: Re: [PATCH 2/3] cxl/region: Flag partially torn down regions as
 unusable
To:     Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
CC:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
References: <168696506332.3590522.12981963617215460385.stgit@dwillia2-xfh.jf.intel.com>
 <168696507423.3590522.16254212607926684429.stgit@dwillia2-xfh.jf.intel.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <168696507423.3590522.16254212607926684429.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0009.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::19) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|DM4PR11MB6336:EE_
X-MS-Office365-Filtering-Correlation-Id: 20228cd3-bb92-47c9-7edd-08db71eb276e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kDWl1n58puNItMPL8KCwCKH+lRsXYfmAzHcwfN2ZMmC+QrvBSE9hhrxRi9lGMA4+KyCiuh1D/hn2Mbx2/ceesfMvEu0SaaVLvGCncukcsn3b0lS5UdFiNkZPHr3BnfuxeT6sDHWHkR7hTEyjZf0hzd8QaQMr9r9MaOboamYo8B3UAdIkfUbAe/fWg27uhCD3gzAJdLIw3DVjvVV8ZQUbMM5V9PGpOSYg5ZSt/7C7GQtI6tE4qA3Pc2ijo6WPXFjpFoljlMHm7bK0O6ym/gcNeyoLQiheG4SFJ//SEYs2gPfD40ijcRkFq+Mlq81IP44f6EGOWcHCMU6e2vfnQV6QPL+h0WRJAasf+lOe7U0YUXbeVdrgJMZFykWHKDz0lb7IkDqKqAGZ1gE9s9Y0nul7sVFqhD3Qx2sS0P81RHzr2pL/Slg16OJS9dPnfO1aZd6qdKcm+qwEDiT52Y/mdDQlp/JnbO85v1uoGYh7ANFtiKfI1oHXpGpl0ISwjShwHNJv6HGO3wrNTr8O39pVTPvYkXAmX1DBdOBEhrY85gYTYok0qfaaDGncD9Vr49+cbmyrm/q+lDlnMRo9m0tseKt770aVUoEaS32r5Z7UgjlfClZYZma7E0GpeF2L/LqKGUwt7Nw+5hqV0Fdb39OgnqQp7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(396003)(39860400002)(136003)(346002)(451199021)(4326008)(478600001)(6506007)(53546011)(6512007)(186003)(6486002)(966005)(6666004)(26005)(36756003)(2906002)(8676002)(41300700001)(66946007)(8936002)(66556008)(66476007)(316002)(5660300002)(44832011)(31696002)(83380400001)(38100700002)(86362001)(31686004)(82960400001)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STlIWXo0bVlaWHhQOXBXUzhtblBVbTVQd1lrZVcwVXg5NDZJR1E1aWNNVzFP?=
 =?utf-8?B?RGR2Q2QvZ3ZCU0JDcStnRTFsQm5QT09NdjB2TEJTWTNDbDFHQS9UaFNCR0pR?=
 =?utf-8?B?WG5PNHhuZVo3TlRpNTV3Q0MxMWxsU3ZWUnVUOVIxMWtXdUZLcjhvVUwya2VP?=
 =?utf-8?B?cFV2MjI0QStqMHBZZlI3MGRsU21SdEFKMkUvM3Y4ZE5VTE5aSzQ5ZU04SzFZ?=
 =?utf-8?B?TDk2MG84c1BhZFltZGFIMk9xRnVPYnFWblQ2TzNicHFxTUkzVnp1d1lMMWtW?=
 =?utf-8?B?VnhPWE55bjZmOW9rb1RWOEJsZXBlSHVoWHE3aWsrVzNXaTZWYVRadEFNZmxR?=
 =?utf-8?B?NVFLSXRZMFd6Yk5uOWNGTXk4Um45RmdqaFh0M1lsVW9yL2dTN3Q0eWh3RVF6?=
 =?utf-8?B?Q05OTGtFVnRZNEFPTDVJNmJEK2VCR3h0bFVWVTRnUytaU2hsMW1Nb0JENGNu?=
 =?utf-8?B?ekZqamdSSGNKdWVpd1lDOUtYMTNhejhyeVV6Um9rdUpwTWIyZ2l5NUl5YUZp?=
 =?utf-8?B?S284T2RDTDhMMS9wOWdHWHliNEp1S08wWmhwZzN0K3NiQmR5aGdaQTRzQnl6?=
 =?utf-8?B?MGZETjk5Wi9vK0F4Q3ZPY2dDaFg2bFROYXhlK0kxYWZ4ZWxtM1BueGxldmV1?=
 =?utf-8?B?NTNGYmlVWWNkQmJMQTEvaFlyVGlYRnFtWWJocVlEMjBsZk1uRzh0eGVxR0xF?=
 =?utf-8?B?NlpBZVZnRFBGSmVNVWJmYjVCTkhpcUFMYlJpK29id2ROd0U0eHptUHgwREpa?=
 =?utf-8?B?TzhzWkZrbnhvSmU3VnlsOHVOTGRFWHlMaXI5ZGN1WXdPaHNEMktiRkFwa3RC?=
 =?utf-8?B?VWgwc2dHb3UyUTZGOWwvZGFzWkZNT3N3dGVia0lCa3JFUGF2WTlGd1IwQjBD?=
 =?utf-8?B?aCtBcnhaancvR3NrMXZKQTdOVU82bkNMTSt5K1E1bFpndnFZKytNWjdZaHkx?=
 =?utf-8?B?Y1JaUXJCbkU3Y0ZWblBtWmxmbExhdHFoUjE1Uzh6R01Gb1RFZ1BqQi9yR3U2?=
 =?utf-8?B?MzBuNCtJd2hkZVBoNDJPbUhhdzdHbHFuVC9iUEtKalN2bDAvQVNhZjRDdURD?=
 =?utf-8?B?MWZ0bk9wZnUwa3paZCsxVmN0bndTRldGcjdUVVlFSzJTcHJuSDAyRXY0Ym1T?=
 =?utf-8?B?dHJKS0VleS9YVGlZc1pyTWdJckZqaGpBMHRaQlRoc2lDeHdxS2VmUGJ3aGQz?=
 =?utf-8?B?VU5nS2VjaXFxOGdEZ2d4UjE1RmJiTUw5Z1JTTm5iRFFjSkhSanUyeTZlMnBP?=
 =?utf-8?B?cUkyTEFod1hXaUJ4QnpwRUdiT3NTTCtub1ZkcFc4Y0tJTitYNFMyZFdoSDFi?=
 =?utf-8?B?OEFsOEFOMWRqU1gzSGRibkJ2YzdpUVdEcTVxK2FJMUdUL01aWVRIYmhuRUE5?=
 =?utf-8?B?ZXJiN2VaZGUxbkd6QUI4UWhzQTdUV2ovZ0sybHo0VHdwRnVOdWo1UHgzZVBU?=
 =?utf-8?B?anIzdHZseGlkUzgrM0tBcWx5UmNIUFB2V0JhSUIyZVc4dVB5ZCs1Lzdpd1ZD?=
 =?utf-8?B?UC9hc1FVMVFJVjJoRzQ3OXN2b0x3K3ZVWW8rWWpUcUpETnFSNndOeTNNK3Zx?=
 =?utf-8?B?WktiRkxmNldpc3JzRmNsaUV4YWJEemhNVjZjbk0zUG5rY2ViQjM3QmU5WTY5?=
 =?utf-8?B?N1h0amVGY2VPTU1QZkxFVGswbkJMT2FnSWl0TTE4T0NueFpUSC9jYnozL2VB?=
 =?utf-8?B?UnVGT21CSENFR3pQTk9OUzBTZUhnZTRYdVVWNC9MdzU3bnUrd2tJaWV6NCta?=
 =?utf-8?B?Yjl3NFE1RzZYZzRzUWhnQ2JZQ2h4V29wQXJGZnk2bEtOY2t2clV1VHo4d2Ft?=
 =?utf-8?B?YytweFh3K29YQlEyRlhOSCsyNGY2SDdLY3JzSlhXUnlQZzJ3QkFPNSs2R3JZ?=
 =?utf-8?B?ZWxRWFVmOHZxRXpaWlVsbDdFS3krRVFFdm5sYkZURnhXZ0I4SzBFTXhyVXRM?=
 =?utf-8?B?anNKRmlrME1hSHZZR0FqR1lIOThzR09qTlB4K3FFcVVabTdheDBuVVF6NUtl?=
 =?utf-8?B?bVJhMjh3VjBUTVczenlKMVo0dS96aVRESmdtby9JblRSSTIyelRlRm40KzJZ?=
 =?utf-8?B?MlNNWTZUQURIYk5McjRFWWk0MlVDcVRWbjQwcU53ai9DWEVJR3RxNGdZVDE1?=
 =?utf-8?B?dzZRSTE1Vm5xZm9keDVrNGpxdmpEOFovZzRqQzJQTjIxckFvSUFWYmtKdDZz?=
 =?utf-8?B?c0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 20228cd3-bb92-47c9-7edd-08db71eb276e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 00:04:59.8696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QxAK/eZg6MchC/MTPmFTqmUrKqB1frKdql1/5pNBatZ/8sLeI6m7BcIul4ugtxYWFd8TGFSEX1Ogwc+v1GaKtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6336
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 6/16/23 18:24, Dan Williams wrote:
> cxl_region_decode_reset() walks all the decoders associated with a given
> region and disables them. Due to decoder ordering rules it is possible
> that a switch in the topology notices that a given decoder can not be
> shutdown before another region with a higher HPA is shutdown first. That
> can leave the region in a partially committed state.
> 
> Capture that state in a new CXL_REGION_F_NEEDS_RESET flag and require
> that a successful cxl_region_decode_reset() attempt must be completed
> before cxl_region_probe() accepts the region.
> 
> This is a corollary for the bug that Jonathan identified in "CXL/region
> :  commit reset of out of order region appears to succeed." [1].
> 
> Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Link: http://lore.kernel.org/r/20230316171441.0000205b@Huawei.com [1]
> Fixes: 176baefb2eb5 ("cxl/hdm: Commit decoder state to hardware")
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>   drivers/cxl/core/region.c |   12 ++++++++++++
>   drivers/cxl/cxl.h         |    8 ++++++++
>   2 files changed, 20 insertions(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index d48c5916f2e9..31f498f0fb3a 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -182,14 +182,19 @@ static int cxl_region_decode_reset(struct cxl_region *cxlr, int count)
>   				rc = cxld->reset(cxld);
>   			if (rc)
>   				return rc;
> +			set_bit(CXL_REGION_F_NEEDS_RESET, &cxlr->flags);
>   		}
>   
>   endpoint_reset:
>   		rc = cxled->cxld.reset(&cxled->cxld);
>   		if (rc)
>   			return rc;
> +		set_bit(CXL_REGION_F_NEEDS_RESET, &cxlr->flags);
>   	}
>   
> +	/* all decoders associated with this region have been torn down */
> +	clear_bit(CXL_REGION_F_NEEDS_RESET, &cxlr->flags);
> +
>   	return 0;
>   }
>   
> @@ -2876,6 +2881,13 @@ static int cxl_region_probe(struct device *dev)
>   		goto out;
>   	}
>   
> +	if (test_bit(CXL_REGION_F_NEEDS_RESET, &cxlr->flags)) {
> +		dev_err(&cxlr->dev,
> +			"failed to activate, re-commit region and retry\n");
> +		rc = -ENXIO;
> +		goto out;
> +	}
> +
>   	/*
>   	 * From this point on any path that changes the region's state away from
>   	 * CXL_CONFIG_COMMIT is also responsible for releasing the driver.
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 187abd8ba673..cd7bf6697a51 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -469,6 +469,14 @@ struct cxl_region_params {
>    */
>   #define CXL_REGION_F_AUTO 0
>   
> +/*
> + * Require that a committed region successfully complete a teardown once
> + * any of its associated decoders have been torn down. This maintains
> + * the commit state for the region since there are committed decoders,
> + * but blocks cxl_region_probe().
> + */
> +#define CXL_REGION_F_NEEDS_RESET 1
> +
>   /**
>    * struct cxl_region - CXL region
>    * @dev: This region's device
> 
