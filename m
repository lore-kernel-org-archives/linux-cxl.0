Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79448C74A5B
	for <linux-cxl@archiver.kernel.org>; Wed, 29 Mar 2023 20:44:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjC2UoD (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 29 Mar 2023 16:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjC2UoC (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 29 Mar 2023 16:44:02 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7AF1985
        for <linux-cxl@vger.kernel.org>; Wed, 29 Mar 2023 13:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680122641; x=1711658641;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=aPWRb+cTTbCtTYtSet0CHBScV2c7pFnGO/2SHGTPrAQ=;
  b=eMAtS9zJO2uBfD5q3+rnna9bIx03QJzsrCy85Jge162zZqjgn/ebZzhK
   ewmdIm63e8ttXwnvit7mXApvYGpGo46N8c39L5OkAzX/jI0HM7ZSZwLcV
   LF08Ma8Jy2/aKRJTCqgFSZbHr+UMmXHNsKGOjIribwRIWZKduanH2SF6p
   yaPWBC6ShYZxdTAeA8u/PHbdsVyjVQKVD/OOa6JEZeZa97CCaTWlcryEM
   QioojBeKJnA8fJZynepGwhaZylTHHjdi5dYvKHhEJdJ2x0kTPd51HXUKR
   uQvkB0tBwn9qHij+Y82ACctNi0n0a7frOeztRFxnKPbAJwX6qvJWHBdxb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="403638483"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="403638483"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 13:44:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="773729783"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="773729783"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Mar 2023 13:44:00 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 29 Mar 2023 13:44:00 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 29 Mar 2023 13:44:00 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 29 Mar 2023 13:44:00 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 29 Mar 2023 13:43:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dv7r0K4p+JPWLwZUq0+n0sePSiWICpzdqWmiqQhZe4HB3OzLo6BrLQflVZrhgFN9tSL6AQoeky6DR3ESFeHOVJc9ENwOf3SLZtwi02h1G45+m3DSgJodlo16GJGEu33FauqkmGuxteFJWx0FvYPzN640/0LPYxDbGfJicDPi0FoZHHSl26x04SX2IPeImJoHzo++Tp1/cSiDroicVZgVGcEl+heVeJuW3VSj+5KHbeiQ5Uv9SU3QGkvC7jeUi6l71oU3s+F1jTvYoqyZgPE60jB58LnYeA2l+RsQCzJMn3HipJcVlpjZehCXXn8vtmQXJw9Gp7bMX6mh/h7gyR6dnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iIB4Xp/jZ4ZXTYKaFl6Fd6NOLXBBQ+rRC8PhhopgMFo=;
 b=h2PGEmhtVCin7J5bK+mFG/eDSfIc70d666ve48F58A5qSSDap1VghxvgHpg8oWe9lmwYmnE8Er5DO43eWvQfiFWagbC2ZLUPCEcN9PfUQjUlnL4VFCPkBSoFi7lZaIYwf0pdknB3TXsJm19zSzr9hk4lzLAwGuwX8O8ey779YInAljx1l7buZLJY1T2aCetJ6Zz53XWG97NwsLptYoc+HHtnj8VZl+fe3Dk/RHCuua+qXY6vKY/v9hy1U0B2mvaAoPsuegy7367BLjrSa87zW08xppsZG5Vpi0s+N0l+D9WUOZwhAnKRLydnX8miPIV4DOv3SwCXis6DQpILSfT48w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DS7PR11MB5989.namprd11.prod.outlook.com (2603:10b6:8:70::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Wed, 29 Mar
 2023 20:43:56 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::c5b2:6996:5aee:91db]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::c5b2:6996:5aee:91db%5]) with mapi id 15.20.6222.033; Wed, 29 Mar 2023
 20:43:56 +0000
Date:   Wed, 29 Mar 2023 13:43:51 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
CC:     Alison Schofield <alison.schofield@intel.com>,
        <linux-cxl@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v11 4/6] cxl/region: Provide region info to the
 cxl_poison trace event
Message-ID: <6424a307bdd18_353be8294d7@iweiny-mobl.notmuch>
References: <cover.1679888450.git.alison.schofield@intel.com>
 <f5bfd91ce391c1ee13a0d55c698be2417072d02d.1679888450.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f5bfd91ce391c1ee13a0d55c698be2417072d02d.1679888450.git.alison.schofield@intel.com>
X-ClientProxiedBy: SJ0PR03CA0150.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::35) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DS7PR11MB5989:EE_
X-MS-Office365-Filtering-Correlation-Id: deba8965-4856-4a66-6c63-08db309650f6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R7QwIXuNkXzKDAIDAMb+yK7VJnwErJNEODkxLu40phKCVZiIKVUxXB/wSl20soHIrsGAwZ3iGJhMGBq/MR0F3cJsunJwRPFErrh2uLe0QUw8FNiRjgjTBkQ4V/JiBIsCeYihBpANBZh7pcpMhDo0ySKscijfFeYPlLxF4gJbzNDnh2aPYyJMoBs4gbFDHoEaE0nTvSIaaZrd6iR2TNxAl/RjlbipRk/skPnqiSb2tZqgJ/dEpV41jpyinRSrvrGuyqv65T8SUOpC96UVMMknyuBwJNDwnraVfKSWbPhK0KtvAjD/tCJxYlbaNGwO4/b50c7mN5qw/7jmZ5Ih/mDYS7Jk4rH/G/hxS9DUhsaqLfyKY9NyR1HBCETPl0YA8Q9RdPq6iNJ8rGEWwsYBIL/zFajpyPKsS5uVdt+cwzkC2gvtrNcROuS72BkfYzsvhnAlO+kEIZ8S/EkfgoNuuImzXcGYBzEaPuX3w603w5eb/kMHTvj/KVoCKSZxKA7hL5sT5FyotYbOxYSvs9WuxQtl7oAp2J28R/9dlFRnPYEbTVw6chaCp9oLVfnnIeYUg08C
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(136003)(366004)(346002)(396003)(451199021)(5660300002)(478600001)(66946007)(316002)(66556008)(66476007)(4326008)(44832011)(186003)(26005)(82960400001)(41300700001)(54906003)(8936002)(83380400001)(8676002)(6486002)(6666004)(110136005)(9686003)(6506007)(6512007)(38100700002)(86362001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ig0AEhBo+rCuMJOlXhY+ay9WsniT4EryVQbKI1uWayXdIeLt1zx3kMY2WUnm?=
 =?us-ascii?Q?zPjHz4+qroFSuchE4OoIU0XmknH6oCP8KqUZXdFOuS4cWsxPd94dvREv0Olh?=
 =?us-ascii?Q?FN7ZCkQaK8ouTrtwgChIlC1Um9JNfOLZpBj9cbuu2WdmOFdq7r/JgJQ0VLZD?=
 =?us-ascii?Q?wdzsjKtbP8QG6V3C407fXQRMeokdx169FcOt6rOIrqyd8+b4lbrlYWKnJFys?=
 =?us-ascii?Q?QDZ7hiy4JBwNjdK9bUVY8JE1rQwSL/czrWbKOEvF2PxhkaF8MsNAdufGIafz?=
 =?us-ascii?Q?vcbZRQXjbklZOBz1pprvMxgyQBAioF8W9fIyMcqyPNUck7wjFLZZw5KDnM6P?=
 =?us-ascii?Q?sTXydJhjE5fuSAW0IaaU22fLS6HTuOHcwoLy7LB4NoWlq7EhZjYCEh2UqRyX?=
 =?us-ascii?Q?rtr7G7/V8ITEAInYRfCbZVXswfRYxDbdsUgfcdkTxWDYZclwpBHhP+mT8u18?=
 =?us-ascii?Q?gEZ+9ZrF1Icjec4sdxso+lxRoCOtqPkx79GJuCsYb3x9UEpYL+hKZTbpry/8?=
 =?us-ascii?Q?G8TxEjzHUFYCbeH6hl2iXwhFFhUiDM9ecPwfDofm85DUr8zAX1ZqSr3csAhb?=
 =?us-ascii?Q?2kXoJrsI1Zn9NlRasz2BnKckSp23lcAuWxuzH0kbWVzjCRpYR8jl6M+psYhF?=
 =?us-ascii?Q?qQwF5jGCvswdZPFyRlGSFl/xzQ4RfoJpaw3nAzHyWWQeQh5x569X88LkZUBB?=
 =?us-ascii?Q?KKf2bYPhygfLt+5c+GmyhXPRyG4BBURNygcXeL291dPDGc+QH9oQHcB1NBz2?=
 =?us-ascii?Q?YUNwjh/vjAoEeEzoWrcsJJRvH88C9TXte1ZOnq8P6Fvsm6cY+HZKTFs5JXMe?=
 =?us-ascii?Q?w07+UMplc4tF+UGpkna0Q8bmvA6/EZSyY5P9fopM6C3OZI05eI4z2slAhn/t?=
 =?us-ascii?Q?XLhBT0Mi4zvQc+kZXWXhLFJht/a+2jbic0LUeGg5HUfgjRei0mfHO8YRXrl1?=
 =?us-ascii?Q?nQXVqG31QyfyGA3Lizap+8A5evsF08CeonuhTa4DSX02AaaW4G8eFf9HGxoO?=
 =?us-ascii?Q?CuhN6ux41tgwfrxBL4gPHC/8RNDFocbSVU1bxIs4h6OcuHBBbZ6f+/VPZEWj?=
 =?us-ascii?Q?ENMQFYGbuxeTUPxsm1jWnzn0RBMenHIuZ7fYr+57lytL9mDf+5eB/c1kJfD5?=
 =?us-ascii?Q?mEn+2R+qWWigl5pqz1RzvD46pQ6qTRDvqBdWAygiZ5ZAfov4X97InubbbI28?=
 =?us-ascii?Q?73hd9xqQRa9STDL3kWPiedvYnFRb2+rKPN55FnP8X8YKA+8e+Ur8G9vgUwu0?=
 =?us-ascii?Q?wKzVQ2rtwwXXWpr/PmOcIk5fbfCY3Hmpi3yxYoSkGgJcm14kAi4dOOrOO3Nh?=
 =?us-ascii?Q?u3B0Y654zQNM790Aw3iXEN2ge9ECdh1E3X6Y6XAYz9f4meYsWcvF7boRvySl?=
 =?us-ascii?Q?o1y7C6JFFdEqMvwdmGgPjYTRpjLk0m0+9URpHTV9JzxRHUFHw237kwAdBAh1?=
 =?us-ascii?Q?5ImgZz3khRlN+YbHl7TH1jaB+hsctr0W+RgbNJMxuFqUwgNDearTzSy+/99r?=
 =?us-ascii?Q?i8mk64/d5DTupUHV+/8bQ5fZP8MiPVn5/+6F+QBTdNA8GV9G2fUjUMV5hv8m?=
 =?us-ascii?Q?8FrZPUgHfkBI9kQptoBX4T4lg0enyKv2chYO5gFQ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: deba8965-4856-4a66-6c63-08db309650f6
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 20:43:56.7352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4bFwlFXjFFYprB6K/4GaWjJ00gguL4oc6Bf7dPRYkNGEap7Wzfo488vnrpJSvg3wGt9XpnNpsc1XqEaqgf7f4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5989
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> User space may need to know which region, if any, maps the poison
> address(es) logged in a cxl_poison trace event. Since the mapping
> of DPAs (device physical addresses) to a region can change, the
> kernel must provide this information at the time the poison list
> is read. The event informs user space that at event <timestamp>
> this <region> mapped to this <DPA>, which is poisoned.
> 
> The cxl_poison trace event is already wired up to log the region
> name and uuid if it receives param 'struct cxl_region'.
> 
> In order to provide that cxl_region, add another method for gathering
> poison - by committed endpoint decoder mappings. This method is only
> available with CONFIG_CXL_REGION and is only used if a region actually
> maps the memdev where poison is being read. After the region driver
> reads the poison list for all the mapped resources, control returns
> to the memdev driver, where poison is read for any remaining unmapped
> resources.
> 
> Mixed mode decoders are not currently supported in Linux. Add a debug
> message to the poison request path. That will serve as an alert that
> poison list retrieval needs to add support for mixed mode.
> 
> The default method remains: read the poison by memdev resource.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

I like the way this scans the memdev at the end in this version better.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  drivers/cxl/core/core.h   | 11 +++++++
>  drivers/cxl/core/memdev.c | 62 +++++++++++++++++++++++++++++++++++++-
>  drivers/cxl/core/region.c | 63 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 135 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index e888e293943e..57bd22e01a0b 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -25,7 +25,12 @@ void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled);
>  #define CXL_DAX_REGION_TYPE(x) (&cxl_dax_region_type)
>  int cxl_region_init(void);
>  void cxl_region_exit(void);
> +int cxl_get_poison_by_endpoint(struct device *dev, void *data);
>  #else
> +static inline int cxl_get_poison_by_endpoint(struct device *dev, void *data)
> +{
> +	return 0;
> +}
>  static inline void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled)
>  {
>  }
> @@ -68,4 +73,10 @@ enum cxl_poison_trace_type {
>  	CXL_POISON_TRACE_LIST,
>  };
>  
> +struct cxl_trigger_poison_context {
> +	struct cxl_port *port;
> +	enum cxl_decoder_mode mode;
> +	u64 offset;
> +};
> +
>  #endif /* __CXL_CORE_H__ */
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 297d87ebaca6..f26b5b6cda10 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -106,6 +106,47 @@ static ssize_t numa_node_show(struct device *dev, struct device_attribute *attr,
>  }
>  static DEVICE_ATTR_RO(numa_node);
>  
> +static int cxl_get_poison_unmapped(struct cxl_memdev *cxlmd,
> +				   struct cxl_trigger_poison_context *ctx)
> +{
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	u64 offset, length;
> +	int rc = 0;
> +
> +	/*
> +	 * Collect poison for the remaining unmapped resources
> +	 * after poison is collected by committed endpoints.
> +	 *
> +	 * Knowing that PMEM must always follow RAM, get poison
> +	 * for unmapped resources based on the last decoder's mode:
> +	 *	ram: scan remains of ram range, then any pmem range
> +	 *	pmem: scan remains of pmem range
> +	 */
> +
> +	if (ctx->mode == CXL_DECODER_RAM) {
> +		offset = ctx->offset;
> +		length = resource_size(&cxlds->ram_res) - offset;
> +		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
> +		if (rc == -EFAULT)
> +			rc = 0;
> +		if (rc)
> +			return rc;
> +	}
> +	if (ctx->mode == CXL_DECODER_PMEM) {
> +		offset = ctx->offset;
> +		length = resource_size(&cxlds->dpa_res) - offset;
> +		if (!length)
> +			return 0;
> +	} else if (resource_size(&cxlds->pmem_res)) {
> +		offset = cxlds->pmem_res.start;
> +		length = resource_size(&cxlds->pmem_res);
> +	} else {
> +		return 0;
> +	}
> +
> +	return cxl_mem_get_poison(cxlmd, offset, length, NULL);
> +}
> +
>  static int cxl_get_poison_by_memdev(struct cxl_memdev *cxlmd)
>  {
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> @@ -139,14 +180,33 @@ ssize_t cxl_trigger_poison_list(struct device *dev,
>  				const char *buf, size_t len)
>  {
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	struct cxl_trigger_poison_context ctx;
> +	struct cxl_port *port;
>  	bool trigger;
>  	ssize_t rc;
>  
>  	if (kstrtobool(buf, &trigger) || !trigger)
>  		return -EINVAL;
>  
> +	port = dev_get_drvdata(&cxlmd->dev);
> +	if (!port || !is_cxl_endpoint(port))
> +		return -EINVAL;
> +
>  	down_read(&cxl_dpa_rwsem);
> -	rc = cxl_get_poison_by_memdev(cxlmd);
> +	if (port->commit_end == -1) {
> +		/* No regions mapped to this memdev */
> +		rc = cxl_get_poison_by_memdev(cxlmd);
> +	} else {
> +		/* Regions mapped, collect poison by endpoint */
> +		ctx = (struct cxl_trigger_poison_context) {
> +			.port = port,
> +		};
> +		rc = device_for_each_child(&port->dev, &ctx,
> +					   cxl_get_poison_by_endpoint);
> +		if (rc == 1)
> +			rc = cxl_get_poison_unmapped(cxlmd, &ctx);
> +	}
> +
>  	up_read(&cxl_dpa_rwsem);
>  
>  	return rc ? rc : len;
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index f29028148806..4c4d3a6d631d 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2213,6 +2213,69 @@ struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev)
>  }
>  EXPORT_SYMBOL_NS_GPL(to_cxl_pmem_region, CXL);
>  
> +int cxl_get_poison_by_endpoint(struct device *dev, void *arg)
> +{
> +	struct cxl_trigger_poison_context *ctx = arg;
> +	struct cxl_endpoint_decoder *cxled;
> +	struct cxl_port *port = ctx->port;
> +	struct cxl_memdev *cxlmd;
> +	u64 offset, length;
> +	int rc = 0;
> +
> +	down_read(&cxl_region_rwsem);
> +
> +	if (!is_endpoint_decoder(dev))
> +		goto out;
> +
> +	cxled = to_cxl_endpoint_decoder(dev);
> +	if (!cxled->dpa_res || !resource_size(cxled->dpa_res))
> +		goto out;
> +
> +	/*
> +	 * Regions are only created with single mode decoders: pmem or ram.
> +	 * Linux does not currently support mixed mode decoders. This means
> +	 * that reading poison per endpoint decoder adheres to the spec
> +	 * requirement that poison reads of pmem and ram must be separated.
> +	 * CXL 3.0 Spec 8.2.9.8.4.1
> +	 *
> +	 * Watch for future support of mixed with a dev_dbg() msg.
> +	 */
> +	if (cxled->mode == CXL_DECODER_MIXED) {
> +		dev_dbg(dev, "poison list read unsupported in mixed mode\n");
> +		goto out;
> +	}
> +
> +	cxlmd = cxled_to_memdev(cxled);
> +	if (cxled->skip) {
> +		offset = cxled->dpa_res->start - cxled->skip;
> +		length = cxled->skip;
> +		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
> +		if (rc == -EFAULT && cxled->mode == CXL_DECODER_RAM)
> +			rc = 0;
> +		if (rc)
> +			goto out;
> +	}
> +
> +	offset = cxled->dpa_res->start;
> +	length = cxled->dpa_res->end - offset + 1;
> +	rc = cxl_mem_get_poison(cxlmd, offset, length, cxled->cxld.region);
> +	if (rc == -EFAULT && cxled->mode == CXL_DECODER_RAM)
> +		rc = 0;
> +	if (rc)
> +		goto out;
> +
> +	/* Iterate until commit_end is reached */
> +	if (cxled->cxld.id == port->commit_end)
> +		rc = 1;
> +
> +	/* ctx informs the memdev driver of last read poison */
> +	ctx->mode = cxled->mode;
> +	ctx->offset = cxled->dpa_res->end + 1;
> +out:
> +	up_read(&cxl_region_rwsem);
> +	return rc;
> +}
> +
>  static struct lock_class_key cxl_pmem_region_key;
>  
>  static struct cxl_pmem_region *cxl_pmem_region_alloc(struct cxl_region *cxlr)
> -- 
> 2.37.3
> 


