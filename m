Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44961C7EE23
	for <linux-cxl@archiver.kernel.org>; Fri, 26 May 2023 04:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjEZEGm (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 26 May 2023 00:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjEZEGl (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 26 May 2023 00:06:41 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582D712F
        for <linux-cxl@vger.kernel.org>; Thu, 25 May 2023 21:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685074000; x=1716610000;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=iDjuBtXMoO5+US08EFFbTameXX48py8Tky9ThxZkw48=;
  b=X+od/6ubSpuR+F+PwtWKKOLWEP+EEOThPYuRheGAg59X1upKdyefxyql
   bOfKzTmV8leaR9PDlCSf5Xx//wgQ81ZSTW39RUlWvN1dI9vlgaOd9G2rA
   6g4gs7uvHrrD/PM2oJKkIii0Gxv8dG9Tm+u5SOudo6gio2wO6ClY9DWfh
   Fl7ZvcWMMFLUzdKVxkmX/JRx0qGfGRBRrKQk28pDeZkkWM6XXKHseVVfB
   1l2Q4+RR/5RsQ73wms9NyuFjh98NY7qxbP5noHn0hBPkRu0SlnPWv5zAJ
   AR/WUFBSWGEKBXxArhcIytaDIAZvCFnbEryDLGPJVgzPOa33XuNWGFFb/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="356492339"
X-IronPort-AV: E=Sophos;i="6.00,193,1681196400"; 
   d="scan'208";a="356492339"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 21:06:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="817389430"
X-IronPort-AV: E=Sophos;i="6.00,193,1681196400"; 
   d="scan'208";a="817389430"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP; 25 May 2023 21:06:39 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 25 May 2023 21:06:38 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 25 May 2023 21:06:38 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 25 May 2023 21:06:38 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 25 May 2023 21:06:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KGYs9QBJZ2P4g+IHj5pX1y22lzO83RAnHLC6jJvu4F+JyVC/XG3cP5mahFFN2u7qCOCUUcUpXtCQcs+KCzjpyOS+F/N4AQ++6jU9zKphQVtdTMPH3BgvGAiq0ZiUOLQ98Emk/QaLYR+raaUNp1b/emxRO+cjTCbo4bbTFkjarEloj8Oupod9bZxgRWsEAbkp/9XgaoaqjIVSEOl6DZaArF0eDL4BQKYVg1Oj/S1UzYC1/Cvqs8rBbtdQTnk6gmhCi/zPjn5Z9CfZbrz+JRaZzUKutilEhrpZnAV8FWiQjdnF9bod8yB2jcsaBOuRv1iuQ+MyG2uWR7hBRHBo9jRw2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Sek701ZEPi4dOxxvJTxIDmMzv6+TyDctfNIOzVzTW8=;
 b=GGQoutV+y8HMbKejz6VEC56uXn+FkBkuuggFoSOyd43yF77mYJFcLt5T5HkbjB6dtqcDL2DEGvexszONT2G8vH/bfBf0mqPzn62NHsh83SPiejrNCHvhG0y/HVNg/p2o+pt/tU6X4Gx/4YZUr1ifPLf/WS7qECffqfsa6l5z3nq5XcYxdwj7u+MYprrz0lC2VcA9wLypgRQSoSC00tBEivJlVtqtPHREFWxKHmOuUuOJgs0grlvMaLd8ZjhQQH68hTSLyd82PICaBUiFTgxOCGTQdXeWpJOVIv9b4m3aZ+p62C9GfIqET7ghtsHmSpgsJPSVy2+cigQ6TtthmHR1pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW3PR11MB4603.namprd11.prod.outlook.com (2603:10b6:303:5e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.17; Fri, 26 May
 2023 04:06:30 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%5]) with mapi id 15.20.6433.017; Fri, 26 May 2023
 04:06:30 +0000
Date:   Thu, 25 May 2023 21:06:27 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>, <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <alison.schofield@intel.com>
Subject: Re: [PATCH] cxl: Explicitly initialize resources when media is not
 ready
Message-ID: <6470304389cc2_1d75929477@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <168506118166.3004974.13523455340007852589.stgit@djiang5-mobl3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <168506118166.3004974.13523455340007852589.stgit@djiang5-mobl3>
X-ClientProxiedBy: SJ0PR05CA0060.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::35) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW3PR11MB4603:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e3a76eb-f22d-4276-4755-08db5d9e955e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1kSi3FKi13vOcpEb2kDaKXwKa5kj/Vovqu6p3KFuYDMi8jiTBLDtkjvdfDkRzGbjbqKS1s+QWRLnjbP2R9cbMV8Q5th8lVbA3y7QcPKvCW/tqccYHPJheWqQFMRq7lza9on7UO2/u2CYJ0vbCIdb1GtYsG1xiEISFXs1/q4a653XWoBVvpsGkk3mbpwj32QKENU6DIiDZYp5iyNT+CL/MBsS2CsDuKJhhXAYTHh4bG12HXqGoILaLmgcQkGpG+YZVzPCU1SdiRyiUBfRvderAkcJCOVvqSJuuqgNoux95Mb9PPr5Q1MiMlW6Wazy3OWoKdF08SrLvDQHvoSaxPXH4jwL/jV+ffL+U91V6OGX5/pfTsJ3wZSQCCMoDrxISmvT7Hal9tTWmyzzGSUssX3gChgx9v0II+0bbtxLAPLp/XVR0RqW1mGWh4vMZIIvjNh2sJNqOQbvkJ83wX/g0Qx99YRdnJPN7L+yFUv/N9X+WNMBPyEw6CVbAkyGFBaXHyoX9z2zf+6eDU/TlIUs5jHDRU9rBmRqscaYNG1lPNknjjKZLJ7WESBN6PeUdtNXruln
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(39860400002)(346002)(376002)(396003)(451199021)(38100700002)(9686003)(186003)(6512007)(107886003)(6506007)(83380400001)(82960400001)(26005)(478600001)(2906002)(6666004)(86362001)(6486002)(66476007)(66556008)(66946007)(41300700001)(316002)(8676002)(8936002)(4326008)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P0xkQdHRiOMXLA+2pK9D2llm2e2a+JEm+DZmikF36csK7FKHNGv1UPAle8Tt?=
 =?us-ascii?Q?V95s/ODwYE7NIfN80xUl89/TALs9UdXvymWB60fFlNtrDLeA8Eb4fWzD32Da?=
 =?us-ascii?Q?YE3urficcR5NanUXvXsXiWQY6RGlGen1ZHkuEbjWexLic61BsRVEpGRVW/4q?=
 =?us-ascii?Q?d+n+4I2XnDv6PAS7mL0p5BoOSCmMoWhW8rYwAtMJJRoh0Y9QHgnpFttqFEUS?=
 =?us-ascii?Q?+xnmcocnFWLuxLPR0V1ty8DwiK8vWi9xG566gwKnpzZ/dj5D/US7jAWKpn9T?=
 =?us-ascii?Q?u4ELYxA+WhfQ1MJy8C9JbHCaPu/Zi5RSBeQOr1/XhUaooN2oWWmoiA7tt9EX?=
 =?us-ascii?Q?dLwwUoJihDxDVKR6y6IkBuLC2U0NwoV7T1uKWgC54BbvS5cy7zIqjl3Aimhx?=
 =?us-ascii?Q?0T3P2JYaS2Qgy57u69ZmrVa6BLqJkm1XdAch3hIhwjgEqupFAyEpRUCsS80w?=
 =?us-ascii?Q?rPTk8w8iigj0PgNjETy2gekjrtDTIKGofE3FyfK72PhJZBSel3/C2Y0dnNam?=
 =?us-ascii?Q?IgJrzIYh1SzXUUUt2G4YX/HjMu21JSWPhq6vdLfFVcxmcPR7NN6cXYnJM+xA?=
 =?us-ascii?Q?MUvLoQU+4BjPCaOJ9EvXSUu5Ivz+fTxmwQ7/moLbbqDJUgJk4nqb1PRrd86X?=
 =?us-ascii?Q?ogdWZB1nKVADOmz0XoPUHNKD5zE6PSSwSLnezROqaMpNWklmux6lqVoFWF50?=
 =?us-ascii?Q?fUEimYDSjX0vNXHauzvk8F9vLN508Zb4jWfdjX2EoIa9n3P3uxSFXu18j/na?=
 =?us-ascii?Q?HKFKqZauK3rFDeYaBsL7pThWZ5NJ/xvPu04GRgsEttWDpOggeHTnjHaquLXv?=
 =?us-ascii?Q?WXv8wItfa7VDmwcXjR5/jr8ZcpWtwGhCV4MVxeaXyyQknLiChJGE2fCCLOy5?=
 =?us-ascii?Q?pulA9I1J4NHLY4qowuuUPs14lww+lUZCV3jCtnMz+eueIjzTUyx6bc/k7i+J?=
 =?us-ascii?Q?NI9Qi+yMnxXdi9Pvx98Y+IIH13liKmweZHzhHwrDrSTnAXoULQ1RxAuiYzPk?=
 =?us-ascii?Q?eJUF9/EB1HEszHJ//uJNekmBTzuhSCImQTBMXeIq5L9CVBGtHGtPIjkZNTPw?=
 =?us-ascii?Q?+sdswR6LHo9JuzHQLHjF9rMJsAfUcEGfb8CbP7LcxLnsyLDQfw7GyJbXCBnB?=
 =?us-ascii?Q?7GRwjAE0NvheVi/NutS5uZ5KLu7awpCSB0tdsnTVz2USE5gKZOAzk1opqBDJ?=
 =?us-ascii?Q?wcaGiF1b37MAlYfIgsP4kDJetSf9u0Rdlbol7yoEHgzOFkwSfkA5mNOqinSH?=
 =?us-ascii?Q?Hy8gMk//mzVjFqhpU2D0xbhZHKHDKqqL7HaUXNOgtpX454Ar9Je3aK4Sr7nq?=
 =?us-ascii?Q?7XUAezlTbj2pGl9ZDecnm7o5odPomoYvUt6l+dC2DcR+RX9n2ni7+mYfZc+Y?=
 =?us-ascii?Q?FLUi01nTMtENdE2cUa6IyNS6jEVoW1wx9UPjQq1D3ttQNTGTtl+28Oe1xstD?=
 =?us-ascii?Q?vuAhJKyNy7tJ65YjmrOz0t8eVcMFKNfKd76JYCGmhsOoCGiFEFISgoYQEmL3?=
 =?us-ascii?Q?7IKwG12OVuCkA2dxUv+6ZbLpHemWNcpD8yE6gNcQdxLCzbHtSCji463kk3b6?=
 =?us-ascii?Q?boV0kE/PtVMOSUbEn37iskiNc3voD9XD3gYDANwZ+JkuzrteLT5ECZhfBMr0?=
 =?us-ascii?Q?4Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e3a76eb-f22d-4276-4755-08db5d9e955e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2023 04:06:29.6794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s6hZFzvvdePbikNp209o2cXaKsopDxMNMRPNeMdN9Pa913R+ZqvHAkDCLRewgj8GDqrz3lZihBCDdbLKMRsvgaEKR4MSdlewc679H17GBEs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4603
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Dave Jiang wrote:
> When media is not ready, all media information are not read from the
> device. Explicitly set zero out the resources instead of going through the
> success code path with 0 size capacity to init the resources and return.

I'll fix this up to:

When media is not ready do not assume that the capacity information from
the identify command is valid, i.e. ->total_bytes
->partition_align_bytes ->{volatile,persistent}_only_bytes. Explicitly
zero out the capacity resources and exit early.

> Fixes: e764f12208b9 ("cxl: Move cxl_await_media_ready() to before capacity info retrieval")

I'll drop this since e764f12208b9 is not broken in practice, this is
just a readability fixup.

> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/mbox.c |   17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 2c8dc7e2b84d..e1d257051a7d 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1105,6 +1105,13 @@ int cxl_mem_create_range_info(struct cxl_dev_state *cxlds)
>  	struct device *dev = cxlds->dev;
>  	int rc;
>  
> +	if (!cxlds->media_ready) {
> +		cxlds->dpa_res = (struct resource)DEFINE_RES_MEM(0, 0);
> +		cxlds->ram_res = (struct resource)DEFINE_RES_MEM(0, 0);
> +		cxlds->pmem_res = (struct resource)DEFINE_RES_MEM(0, 0);
> +		return 0;
> +	}
> +
>  	cxlds->dpa_res =
>  		(struct resource)DEFINE_RES_MEM(0, cxlds->total_bytes);
>  
> @@ -1118,12 +1125,10 @@ int cxl_mem_create_range_info(struct cxl_dev_state *cxlds)
>  				   cxlds->persistent_only_bytes, "pmem");
>  	}
>  
> -	if (cxlds->media_ready) {
> -		rc = cxl_mem_get_partition_info(cxlds);
> -		if (rc) {
> -			dev_err(dev, "Failed to query partition information\n");
> -			return rc;
> -		}
> +	rc = cxl_mem_get_partition_info(cxlds);
> +	if (rc) {
> +		dev_err(dev, "Failed to query partition information\n");
> +		return rc;
>  	}
>  
>  	rc = add_dpa_res(dev, &cxlds->dpa_res, &cxlds->ram_res, 0,
> 
> 


