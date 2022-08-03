Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B812C19F2B
	for <linux-cxl@archiver.kernel.org>; Wed,  3 Aug 2022 21:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236115AbiHCVtq (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 3 Aug 2022 17:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbiHCVtp (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 3 Aug 2022 17:49:45 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B86B19008
        for <linux-cxl@vger.kernel.org>; Wed,  3 Aug 2022 14:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659563385; x=1691099385;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=uheeTlEHV8bRzC1AcaJ9iuxypWlOotLhh22WggDc78w=;
  b=KItZjjh+sLsOUJNY7Nm+RV/KMH8UxpEuzVtIb3XQgxazMmlKQNiC83mr
   6BDzD515u813pwngTRRiP0bMrqZjZJDeI3qmIceSz+t+3n9CLEl3KOEp3
   Lz7qZ8QPNRgzGcNpHBzMC9Yx/+Hl2x8qBRgI1SSzy4vTrcD/KNOUhfdzj
   zb9/mREEvULKpuqBbJ7bj7N8gqbrgpBtSphH/O+ctUDQbfRBhnYHxohgD
   9Sw7kL/Yz0PIyNR1ZbqJ6Jk838dT57yB/KwFbHBare/nUNdsRi6jtCy2g
   gx0zEwQvzwECmzMtUHtTFbXBhHsa9CgP+lw8I5pNjYR/k1BfqwlicoJmO
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10428"; a="287345898"
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="287345898"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 14:49:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="930549644"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 03 Aug 2022 14:49:44 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 3 Aug 2022 14:49:44 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Wed, 3 Aug 2022 14:49:44 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Wed, 3 Aug 2022 14:49:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UtnAXGErGHtSQsBwgrgeVbJ9okTG2w05I9gxJsMRDrfNnEjnneWR2xTWnjp8c4Xyyq/Ax8MtNL6930V8EmerpyuDABqU39lOgXzat1UdypPwCV3+1i4ZbrHm5ws1WWpuEt/3GwKVuCqCdwjHgnniB7j8QSoiGiWwMH48xfrIqxrWPUZIH/vaUVjStN6X5N38ADgh5O39iANN11YUW261UlRdTBCODRpTHACy+jDfm+kNWncMtvK/hNp2EFWweyGN1oW2UESfJshxJ82ntCc39LyCfmOoldjk7DGerKlc28USYGojj9/wVbEwDyS+NKxmI3+GhJjG9PCQ73pJNVs0dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N09uoY4+olz1GowHI5Zm7VAMlojrQqfDz+GCj9dL4Jw=;
 b=EfdH7+bopfb5ccB5KEAwfkLsj8z8v5LCcrLynDUB6l032YSQkv/VJ+e/uYX5oprA+ezwVWx7TO0OMlOHCRH7G8F7Oq81oGtp48F+pan7dKHRSzBma23JR9jvdLGh5zWXJUig6EvhbSLLcH0VqBsnOSC7kTNJaYfJvWJnrtrqydNawdQ3/mH1amPjSLzTHkppD9zXq4HhGmmvlP9qB9l2eb1+g5Z3P7GrXRLqddPtJkPQsy3jpVMfYD9WJcpCpD61ySxM2qjCcsQkuYpcrdv1viz0fIk1GjkJUKfWu38yUyiKwEmLvyZA/uT5mxApvJF7aQiOXARIvwP2d/GvEaLUXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 SJ0PR11MB6791.namprd11.prod.outlook.com (2603:10b6:a03:484::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.14; Wed, 3 Aug 2022 21:49:42 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::b965:e89c:548f:d058]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::b965:e89c:548f:d058%3]) with mapi id 15.20.5504.014; Wed, 3 Aug 2022
 21:49:41 +0000
Date:   Wed, 3 Aug 2022 14:49:37 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, kernel test robot <lkp@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <dave.jiang@intel.com>
Subject: Re: [PATCH 4/4] cxl/region: Fix region commit uninitialized variable
 warning
Message-ID: <YurtcUKKDFUbjJp4@iweiny-desk3>
References: <165951145706.967013.3023584411011908037.stgit@dwillia2-xfh.jf.intel.com>
 <165951148105.967013.14191992449932268431.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <165951148105.967013.14191992449932268431.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: SJ0PR03CA0387.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::32) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7669825e-7e72-45fa-1b45-08da759a1239
X-MS-TrafficTypeDiagnostic: SJ0PR11MB6791:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gOgssaCkNG4yfMGzNRx1hW7zM/hCK108FEXjVgIiTCRbBiGgDNCmpK7GiT7gIv244yDEzvI/Ahk+/qwjCmNTsM6QySVo74Ox3efeK5sj3Sq/LEOjR0RoJZqAsEhCD6ldr3RO1tzhvsZTBQW/ObMJAiU9bqhGG2UVU6gf+SxJMfNNLAwCPfvBKTnF0aSIneDAL629mfSeL9x1rip3N+eME+ZaVCS/hzVSeJ9H2id+fu+RlBUGoiPjBwHZuuNS1BLfl6tC2nRVVZsmwUoNUWMk57pS2VJ+WG6CaH/jEyM6FLIyKKt6cVtaRm9tO4jBZafdVEs+0VJ1ypjSbpHkDYohg+nYNPxVhspY0UDIrVI+6xYU55V6J6ZwsV6Om/vchh5K511hEfV7D5lqHjiwYxQ5on31GJpgIPWgd3QD3JIeeDYXr6ps1x5HqdRBjzNxz+DuO5dO5HwBG8Z4N8tSLPDxZKmyDlnad1zcAYDOMdu/m+z2IkVFTX9bYtxivr71FXEglee87UugbDGlg2IBxiozrl6Tn5XdBszoy7qhZ28er0ZZu9Bm+s20b5TEj3MY0OF/sU0WpC8ag4zyQCZ9iD0wGH2NqdAqD04tIc1njFKvD0KFuM1dHkzkWi49nK3ffpB4Y9CI/BIM/29DuJY8+ypRVArPgkuNkjcj9RZSHrQ+G9sy8apiTxlwLf6OT1APdkLi0ZKJzDL1iman3Iytc6OeckY+KlCb41vda80Ntf6WhFDtmiKv64tAwfTj2jrBISD7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(346002)(396003)(366004)(39860400002)(136003)(44832011)(82960400001)(2906002)(5660300002)(66476007)(8676002)(66946007)(66556008)(6862004)(38100700002)(8936002)(4326008)(9686003)(6506007)(83380400001)(6486002)(33716001)(6512007)(26005)(86362001)(6636002)(316002)(478600001)(6666004)(41300700001)(186003)(107886003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Tnw4TyUWD1KFIdY1IgTVhwvEIHloqzTIFm6C6AtGYmaR6gK3FJZsLp4aY3zO?=
 =?us-ascii?Q?AzGYKb5vIF1CnwxhqJk3NB/F+h4Cim5/xXD3qk85/NBxllgdcLWhvvzbc+eJ?=
 =?us-ascii?Q?OSYI25LNcSXbMyYwKeryKWIWLB7T34aMzT2FF+LJhVz5fZccaCaHpb2s34Vj?=
 =?us-ascii?Q?gP+QcRA6etgobx+Hi8AxToq4xJtlW1B9AHZlKrEU/S3aoOZ9Z3h22kSNhaFH?=
 =?us-ascii?Q?rImpuyAEKiMKjPapfCXlW7db7bmKU1vG+5w4/Qeuep+mbigTIZNccPNvs5Gf?=
 =?us-ascii?Q?xR2hs4MJ6D5VDAwClsh/OIsooXlBqorsX4kiYcQqqSAMSRHSuCznFPshNQ8l?=
 =?us-ascii?Q?Ajs1AAK8Nxcw5a39IjcBYgTnWC6eYNwvku4gOsvU9lfnsjRV1DG7ZjMGcJJW?=
 =?us-ascii?Q?ArgSDXwJc7MZdg0fTGUjd3xqLf5rT4lhssBevyPtbIZIX5EG5sNfcAqmrqRd?=
 =?us-ascii?Q?nCOMzMTU3c9j4pMEGN+aJ7N+pg6VDZfzpTar3pJ+4FOQp/6KwX+CF8WK3Jfh?=
 =?us-ascii?Q?bZtWiR19H7ecx45dZiykhngbOsZZwH4hMIueDXIc8gly1wMfj2MwG+vkFJrw?=
 =?us-ascii?Q?KKNpT+t4Em8l4f31WYDV4aIuOLbbPxA7l/PZvnPZ5qyrxuMgfx/kVGxjtwBu?=
 =?us-ascii?Q?LrYEl+0i+nGI51d+xHY2ThvFDUH6b2tGjruL1MWHJwENiExpzpwQRY7iCAru?=
 =?us-ascii?Q?DmqgZmX9YjPCZISVr7pAeLIGFsi2uib/QWMpHyW5yuG+1VHuBpAhUty27C0t?=
 =?us-ascii?Q?EzE/fFlNXV2UR2M5wx/N2L9652PmZY0TTFP8j8iEX3NEmVH22jAUU7YFf0TF?=
 =?us-ascii?Q?Vcn84xEu6z+Gm4Y+ptahrH+UYG8uxCELRMbxoM8KTFzyvMgy9/eIFS4/DCZ2?=
 =?us-ascii?Q?86m5zRr8kiu3j23BOjNVsmrCf+yeE1u1X94rqwgQu8LhzxyZ5GDRnRqvvtwx?=
 =?us-ascii?Q?ChzP/dK57u9UIvQsS0Vb0IC6k5tSL1WdMzb6i5bISG3dg322cTqCCm2HBCs2?=
 =?us-ascii?Q?SkfwK42dhhoANKzPuGOgQPBAD+2OPULcqgbnYAEjhg+IEs4e5N8YSQ/3fRgX?=
 =?us-ascii?Q?wmE2vjFao7nbgrX4Mdi5nVjXKrE9G+RgRk0DFMN6R5uqYPrx+eBk+Zr0Hm+E?=
 =?us-ascii?Q?3ek2hAFYa8HZ9DRhbCIvAVXWvc6JwWYNayw0Pg4xq5SEexcqcmMZJw3jgWWY?=
 =?us-ascii?Q?6WLefiPcqlXOrs5Lrm49j3xa/axnaf4Z5RcwZarox5ILvOKqT8Ty1K7N/XVQ?=
 =?us-ascii?Q?IwOKqfeiwrhPCrykfVU2OU58YAtknIpEKNQwy1+t89HS6Tp/KAArw9YCzSrX?=
 =?us-ascii?Q?Knezopy1l4K7Nz1WxGv2qJLmGI01MBJUE3MzYEXfMh32Vv+c+sEhxPNbcs3A?=
 =?us-ascii?Q?t3ld/vMgna5WTRD5solbiaWicFV4/gjRY12WDTVoPZT734vhXWQU4a6DdCq5?=
 =?us-ascii?Q?1zV4MyKAgx8D1wLu3AGuiajQoxg1l9pgPIKoEVXnQZCESN7Q9FEwxL05PbFX?=
 =?us-ascii?Q?gQjgnMTwk8w+JPZj/uMHSW65zb2+5Q9tNfa3wDqhKvDaiu1PjjfZTYkBBB6W?=
 =?us-ascii?Q?+rGaXj2xzmg9OLdm92l4dzaQfz91CpLMNHzi5RCW?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7669825e-7e72-45fa-1b45-08da759a1239
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2022 21:49:41.8898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k51JMVCB6eF2u+s7Jaw9kV60SdD25Ridz2HOzG7AtdrZfPdci3BTEdd+UjIhwoBxmkUpyhDg7dsuZ0kfXyoJeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6791
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Aug 03, 2022 at 12:24:41AM -0700, Dan Williams wrote:
> 0day robot reports:
> 
> drivers/cxl/core/region.c:196 cxl_region_decode_commit() error: uninitialized symbol 'rc'.
> 
> The re-checking of loop termination conditions to determine "success"
> makes it hard to see that @rc is initialized in all cases. Remove those
> to make it explicit that @rc reflects a commit error and that the rest
> of logic is concerned with unwinding committed decoders.
> 
> Fixes: 176baefb2eb5 ("cxl/hdm: Commit decoder state to hardware")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/core/region.c |   12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 5c931b6eb4e7..a68e4e0cf169 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -159,7 +159,7 @@ static int cxl_region_decode_reset(struct cxl_region *cxlr, int count)
>  static int cxl_region_decode_commit(struct cxl_region *cxlr)
>  {
>  	struct cxl_region_params *p = &cxlr->params;
> -	int i, rc;
> +	int i, rc = 0;
>  
>  	for (i = 0; i < p->nr_targets; i++) {
>  		struct cxl_endpoint_decoder *cxled = p->targets[i];
> @@ -180,7 +180,7 @@ static int cxl_region_decode_commit(struct cxl_region *cxlr)
>  		}
>  
>  		/* success, all decoders up to the root are programmed */
> -		if (is_cxl_root(iter))
> +		if (rc == 0)
>  			continue;
>  
>  		/* programming @iter failed, teardown */
> @@ -192,14 +192,12 @@ static int cxl_region_decode_commit(struct cxl_region *cxlr)
>  		}
>  
>  		cxled->cxld.reset(&cxled->cxld);
> -		if (i == 0)
> -			return rc;
> -		break;
> +		goto err;
>  	}
>  
> -	if (i >= p->nr_targets)
> -		return 0;
> +	return 0;
>  
> +err:
>  	/* undo the targets that were successfully committed */
>  	cxl_region_decode_reset(cxlr, i);

Doesn't this take care of teardown now?  Does the for loop even need to do
teardown now?

Ira

>  	return rc;
> 
