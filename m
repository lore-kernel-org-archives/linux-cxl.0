Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78CA8E936F0
	for <linux-cxl@archiver.kernel.org>; Thu,  5 Oct 2023 01:18:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbjJEBSe (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 4 Oct 2023 21:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233908AbjJEBSd (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 4 Oct 2023 21:18:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2CB4D8
        for <linux-cxl@vger.kernel.org>; Wed,  4 Oct 2023 18:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696468709; x=1728004709;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=4KImcWiyBfRsLmub5oTUC/XAIPYTGlFU+3nkjhbfM9A=;
  b=BFJ1mZglgFMMtpaE1fJH9BrtzWW4fsDF1Axf/HDF4azaJ4T0cn310meW
   4BArPbnyykWiVS+4FNMo15OgiUjdK+v33yAurgUMq4/yzdTmJBcZiRczz
   DcAvdfU8Pduzl0wkdgXi7d7ZZ1AduNXyI/dVKLaCtw9H1+bm3m0jUDZ8Q
   6FbDZL0hSYAErs2dwLeF8w5CwFTQ6YoGyHxt8E7w8kvJrAuc9IRvrGM0D
   Vh/rKPMH0KORz6kghc+l18DemT8EjVpNphE7io+zkEyZbbUNX3j88Mlig
   F3O0ofhrpjNBsxutfnbxwSY0vgNHthI0rH06HkyAM/K1JmQWlPsKwvg6H
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="469633332"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="469633332"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 18:18:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="751580002"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="751580002"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Oct 2023 18:18:28 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 4 Oct 2023 18:18:28 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 4 Oct 2023 18:18:28 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 4 Oct 2023 18:18:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oGTSuW+ghLMljFAHWOuA2GKYnwAoEE8eMm6NPhdAOfJZ+I5wz5jQriYChYg4K2vqjiNtWahA5axVZUYoQCg9Aiw00LArH6EKG6SbOles4b+cZT6ue4Mswj7Y0ubX315sjm3ERFMF5xxiu0XQv2hz+knOToWi0Ba05kFy4XECZxgkUq4vBc8T0JRctSGMbG3+kG4nZ80noUZmD/zXt5FJzvdFmKQgAXKXrKf8GVjTxEBclt9wbQXdp34PIf/OuJ10VSOVxxMoYbSfMJDOW6GIkub44HN4IssMKoZ6goBx7Y5w8XKv9HGd4xe1qr7xYKWB22fzmwFVeXFbc92wvn/Q7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wfRIwRjY+5hkWrNMsFBOLWLPiDjxh/J5IUINLJcK7Es=;
 b=C+3JPpkL5JXBTeedad3kNVTAIh/zqAGim1u1Gx0kZ2DPr06BuammrTaz94I6lu4hXyqnNMvyeCjwXc6w/udOZFL/pSkms+j+2rO/OPxLge8TCNrokbCnjFh8QFpbqLBx7qCJy2lQRA8cvNWzCzBwdPmF4pRxqXyTHy0iCxG7+CVrmpf0AllKZubz5LPAfIf6Lch3PS1w+S85mgMyq4osT28SOkEZH/WOkVh04YCBsOdWCsYCICjgKbY+YmebwMQJfTTsfCTiC18d/PEn3nhjMjYBQKp8eZVfk49zIAuHuG0fqhIAopKC+XPeCXJAT6CEVB4+didSSwWC5bAQrRKZww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB5901.namprd11.prod.outlook.com (2603:10b6:510:143::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25; Thu, 5 Oct
 2023 01:18:25 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992%5]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 01:18:25 +0000
Date:   Wed, 4 Oct 2023 18:18:21 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jim Harris <jim.harris@samsung.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH] cxl: set root decoder granularity based on region params
Message-ID: <651e0eddb7f6c_ae7e72946c@dwillia2-xfh.jf.intel.com.notmuch>
References: <CGME20231004230826uscas1p2f7957bf868a609211271e30ad8ff551f@uscas1p2.samsung.com>
 <169646090522.666328.17608442776078591123.stgit@bgt-140510-bm03.eng.stellus.in>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <169646090522.666328.17608442776078591123.stgit@bgt-140510-bm03.eng.stellus.in>
X-ClientProxiedBy: MW4PR03CA0207.namprd03.prod.outlook.com
 (2603:10b6:303:b8::32) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB5901:EE_
X-MS-Office365-Filtering-Correlation-Id: e52f10f1-f8f9-462e-736a-08dbc540f8fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MbUXcwQBxpkLxt7+8CJQZz/gCW1qA/jj9juNmMsmjrTawUnC56OPRoZlMxM1yZb6m0CVw9DaQz0RPY8oPoU3uVlA2s7FnSgln+yUx8UC8DevpP32TJ3r+Qdz1xLRIRjUll48oj6fv6Nixtdn/sKOYZ3bItQwt2xa87R1S0u2eFi06PC2u8zdz+9G5KBu9QkvllmQ/DadyiUf+LxMqTQamOXuvUVt1GukVZnINOHhjEuDG6kj7hZSLiK6PBJWvFV88rQxf1aBL6NSb6YThy8GTPdHcry9uMM0F35DF200ZY3cMW+kN4cK/aFO149M/8gkOUFdgtoLeWY9m34bFI9oq2Hi6b/x38/C4Onp/dJs5MdhaM37OyPKzxRZKFvHeTpaUjn1u2dTxrWTajNl69KMABgr4Pf0Vt1MaJBuukVUpk4+RqVCkiU4XTfvHWM/A+hD0mN5b9FN4MZCai345M8wDOnwCxMMB3S3EBuczm3IIUlXKIhluBMMAklKVLTdZ8LqsVoqRBkKw3Je8gPesHXBzfvBKo/Oz3HRCOBCC3L16tk8zuGqJbr+G8TGmJbWfSjb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(136003)(39860400002)(396003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(41300700001)(110136005)(6486002)(6666004)(9686003)(6506007)(6512007)(316002)(66476007)(66556008)(66946007)(8676002)(8936002)(5660300002)(26005)(478600001)(2906002)(83380400001)(38100700002)(82960400001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?31kabt2z8vMz3eqoir31b1J1oBhFBcK7xPJjvtGaThO6OAIvmt3Rx7JOYI0u?=
 =?us-ascii?Q?iiKNS60JqqE6vDv1ZWRQtiqtzSRBaI2zQL80sZfpO+izlz/Ujgi25ypUbJp6?=
 =?us-ascii?Q?xXIbPt0s4u4QCjK7Jud5tLXnByApucqvvaAJf/mRG4LHLHP9QYYI2AJAaXsM?=
 =?us-ascii?Q?yITcY30GO6C0V/rPY4LnZMTN0ugC6iHjhh/1pIwKIldKGCVImGgVYcEWRRR3?=
 =?us-ascii?Q?AdYKn+It4ijeeBVXnR+eb07OgyqwBZ/GkJDYIbLiq1YiGDMaJLqVnpuDkcJF?=
 =?us-ascii?Q?3B5qjOGgx+Dh/9JJidKfBPfuL4mA27idWxakcUpGJ6F3ChoHZo7CVyonqWND?=
 =?us-ascii?Q?1aSkOlzq1I+BVgpdTbUtygqaVC+MMknDAGTwaoo4/KnOAlDW+vrtfl0y41aa?=
 =?us-ascii?Q?bjrNdgygTX3vlPg+637Y5fPFdaLfAqbbkgaQMjHUrmzwNyHFyRTqNP2FMuqs?=
 =?us-ascii?Q?943GViltBVYRPg888GKqmz2RVunod6Q/lKlUsSlSx5r920TIxHppV7DrV+Tg?=
 =?us-ascii?Q?GXTXWzF+ICt4gtDW5kVtFiJPoHNBJYhIYmDa9OGS8rzwPcBPlu56tGjpmsUL?=
 =?us-ascii?Q?YkKEwYoagZMfsnskltcHTG/YFcnrG+Lezdhs+r47rp7KABgVAX/qnVO8E6Fj?=
 =?us-ascii?Q?QPjHtfHiwr7bmPE3oOe2wmkEDl0nM8PXjLeMrkZmAtt6LqNWfh8EHYpxgWML?=
 =?us-ascii?Q?ZI+8UIDRFGYv6lnUC19dOyyx7uifuO2y3HAZ9WFK1dPQyty4K5sXNHSwwFRS?=
 =?us-ascii?Q?DyEFIK7QHj6malJMCNUPSe526gMAlxXhlxY1pO6orbr8JfX4Vg0i0A7zCTEe?=
 =?us-ascii?Q?MScCOtCrypZ7T933JA2SjjiXavumAnUrMoprq5NLv7O2jd180W09w/ggtBMA?=
 =?us-ascii?Q?Bk7Xfap4JWJ95VdfxQd/oHkAB7O9SjxqMbcqGsv/Q4tlni5/yXPVYDvPYatp?=
 =?us-ascii?Q?zaREE1pMqiwEFYe0waqOdgBrqXGsEsa+UgJLoog3jQjubTqHTie5UFAXLtkc?=
 =?us-ascii?Q?tkYqAlnm+vfkg4tDLc0DFNUuLh6TKugzsrpYXky8zTvUABzHCgJ1/xx5UhT3?=
 =?us-ascii?Q?GTvlDb3pgHzpGbCbPSEdN+hORn3I9yYCu7Svz4RGHVnfdK7ALfipUTjYgEXp?=
 =?us-ascii?Q?Gkb2GYXa2F9FwOUjXL6fVMU1hPU9RjeuK/bT/2U61TH5MWogoVrPrxgonYn8?=
 =?us-ascii?Q?pJTSBhmnFsdnwaa89oWELbHuZ7kd0vpdJFpAuZ/ASfBLXNwolNkLa2SdTG8k?=
 =?us-ascii?Q?PuG/tUT1JTpZI91u4XXpgDiC86z+T7/w4plqJOqwf0cGIDVBbx3o0sWQMQe1?=
 =?us-ascii?Q?5xOh5iK3PSPKAWqh/zy+CkmA1PjIfVVZUtHohZKKVrFjjV+Wg4dNXPJV05Yl?=
 =?us-ascii?Q?9kpULFeNPkY+pUJmHLj0hdlcgE4fPuywsaPzC4BbQP4mytFzuHwgouicJrjZ?=
 =?us-ascii?Q?TDdSz819eX3GIUjaWqK0hevybaKIY+UsA6UtPqkKQqVinOg0mZpAgTIkCuFX?=
 =?us-ascii?Q?7w5lFyKj9X1GW3ZCdFTMmWuBkJ6J2RBd8gjLhBVQ+RoCNbLhkavgruwIJkWW?=
 =?us-ascii?Q?KrmNkzunveJnZa5XuUjUQ77T2el2SmepfA/Nv2sxuLOVg/LID2sDXAbZzU/4?=
 =?us-ascii?Q?lw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e52f10f1-f8f9-462e-736a-08dbc540f8fb
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 01:18:25.2221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ppLvaObBReufrWh9yGp7jMuUO1hqmJXFVqNINKXHSrDEYqI4BuQy3J/XBusnBnP5pNbG7w0ObzLwhN+QheNBB+/jxA2gO+OzzxBc8qmnSJM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5901
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jim Harris wrote:
> The granularity for downstream targets is all based on descending the
> topology from the root. So we need to set the root decoder's granularity
> based on the region params.
> 
> Test configuration is 1 host bridge * 2 switches * 2 endpoints per switch.
> 
> Region created with 2048 granularity using following command line:
> 
> cxl create-region -m -d decoder0.0 -w 4 mem0 mem2 mem1 mem3 \
> 		  -g 2048 -s 2048M
> 
> Use "cxl list -PDE | grep granularity" to get a view of the granularity
> set at each level of the topology.
> 
> Before:
>         "interleave_granularity":2048,
>         "interleave_granularity":2048,
>     "interleave_granularity":512,
>         "interleave_granularity":2048,
>         "interleave_granularity":2048,
>     "interleave_granularity":512,
> "interleave_granularity":256,
> 
> After:
>         "interleave_granularity":2048,
>         "interleave_granularity":2048,
>     "interleave_granularity":4096,
>         "interleave_granularity":2048,
>         "interleave_granularity":2048,
>     "interleave_granularity":4096,
> "interleave_granularity":2048,
> 
> Signed-off-by: Jim Harris <jim.harris@samsung.com>
> ---
>  drivers/cxl/core/region.c |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 6d63b8798c29..f14110e35f79 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1691,6 +1691,11 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  		return -EINVAL;
>  	}
>  
> +	/* Set root decoder's granularity now, so that we can use it to calculate
> +	 * granularity for the downstream targets in cxl_region_setup_targets().
> +	 */

Minor, and I mean minor, nit, the cxl subsystem is using:

/*
 * Comment...
 */

...block-comment style. Yes, it varies across subsystems, yes it's
arbitrary, but general rule is follow local customs.


> +	cxlrd->cxlsd.cxld.interleave_granularity = cxlr->params.interleave_granularity;
> +

So I think this is only valid in the cxlrd->cxlsd.cxld.interleave_ways == 1
case as interleave_granularity_store() forbids regions that do not match
the granularity of the root.

If a BIOS tries to ship such a config in production that's when I expect
that policy needs to be revisited, but outside of being forced to
reconsider that stance the complexity reduction is the benefit.

In the meantime maybe add an "effective granularity" concept for x1 root
decoders and x1 switches so the math can use that value?
