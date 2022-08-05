Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F61DC00140
	for <linux-cxl@archiver.kernel.org>; Fri,  5 Aug 2022 22:50:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240856AbiHEWui (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 5 Aug 2022 18:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240471AbiHEWuh (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 5 Aug 2022 18:50:37 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E5F10FED
        for <linux-cxl@vger.kernel.org>; Fri,  5 Aug 2022 15:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659739836; x=1691275836;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=9Xml7oUcC1lEhrgf7pNN3leEBu39JprwC7uJD0FbPoE=;
  b=ZAgAuBrJhnTwi3QQI0oYu9Jqnb6sYZgisNCsOFrOKXQa1GPOLmSEGbDl
   0IdnTu16pHi8wuECjgH1d4LOD7lMPjixCE6vcC5ueBapHk7uxxIjRwnII
   1PebXQyl5ZGuO1BnCXOuIBVQ/YTWBDtMmI+fZ2vVN+E3R4gRYBRqciUGX
   DSnSJ21VKUm4VP2Wr7oO26aOexcjpbHcS5Vl5KevTMTEIbYlXXMMAbD+d
   eRk1ivgsOzAXTyy4iTpBK8lixho/E0nSHy9IHmHhTicxhALEktUtk0+9V
   AE3xTWjvzD5A5a7WIPNp/tfpTiZGHA0M8cKnUu6Cy3s0niY0+sgHcnWJc
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10430"; a="352030162"
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="352030162"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 15:50:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="663175556"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga008.fm.intel.com with ESMTP; 05 Aug 2022 15:50:35 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 5 Aug 2022 15:50:35 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 5 Aug 2022 15:50:34 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Fri, 5 Aug 2022 15:50:34 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Fri, 5 Aug 2022 15:50:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=guGZyUnJ56OwNb4dKKVYhG97cCeOUQp1ECkP+eAkmSDrQT3j4rskayRhxJpryeD2IqJSXJDUF9rOrOiAY0wTatfSJD19zQ6lwuoyPeOMqaGioJ+8oMoZLVOQy3c7sxOPj5oL8otzsiciY/zyiB0/zQIO9lSQGkvL4wAltYCgfZhVnJa8SGLnib0l3orlfVC9iWLkaHdCns/WSxoms4/bEghFDikWbUr0G52ViMilxfqB/idiMPLCpZ/CPlHRXCpxrI7baSoWD4uUAvTIt2Z4sCkqp9DLDQv7xwf+DtmcnfSZ3zsKVGTlc7S3yb4qgKDlHIvIEighK5D+JCqwRwwuKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jRk6m1cuqDmwBhgCSQOSGJhHSZCGqHs9pjcGMFrZfYw=;
 b=gxeoowN1MdxOlGttt9KwhLzd14GiO8Zn25LTO3uSmxUxdd5QUwR8zsOQSbyv9FzZ3DIbQ9gH0cXnZDkL5UtFeOrLHitq8zfxfekD7nHh7uhYYPzht3Mr+Gbtd+S7KGDj4U3WGpl6h91FdqhPUKG6EhdiIt0wWI+h+ePun6iUQ2xbNJKS2HQT56KvaDIvpLJFPnyg+evvh7gEORhvxkyXcA/yU5FAFoRPh486k6DdWZ42o7PI91ZVvhfQZs+e56R9Nh232OZc1a15WvZ0ZGYXcn98+gARyU1v7RPWzafXRIMmbJFryWsJxd8DL9kZbIhDA0q7TgfHbsaI0vXKxmdYlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 PH7PR11MB6449.namprd11.prod.outlook.com (2603:10b6:510:1f7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Fri, 5 Aug
 2022 22:50:30 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::b965:e89c:548f:d058]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::b965:e89c:548f:d058%4]) with mapi id 15.20.5504.015; Fri, 5 Aug 2022
 22:50:30 +0000
Date:   Fri, 5 Aug 2022 15:50:25 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <dave.jiang@intel.com>
Subject: Re: [PATCH v2 2/3] cxl/region: Fix x1 interleave to greater than x1
 interleave routing
Message-ID: <Yu2esd1Cz283GBOD@iweiny-desk3>
References: <165973125417.1526540.14425647258796609596.stgit@dwillia2-xfh.jf.intel.com>
 <165973126583.1526540.657948655360009242.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <165973126583.1526540.657948655360009242.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: BY3PR05CA0052.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::27) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a4e6a2ae-0442-41dd-edf6-08da7734e597
X-MS-TrafficTypeDiagnostic: PH7PR11MB6449:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PZBC2ss7HwK/Ip5vxflYIkbCB5s2AqF/yvrn6mJ9Io2WCCDI5eRw1n872PYuRPKPoTvHcprmp1UMwYa/Iv1LYl+gBo4NQoDXk60QkNvWbHI8dLS8zD/oiYoC8CJEm1Jhli/XpztK846ixobqDwebVNhCljjeeH9paceLV9SwgRujOOLS/ktGRR0utkPLblLiLwbkrM2+ZWCp3hKIOmGpEuojcI0PJX7JMWsi6Wd64jfrKRXkQ4ksamDjJ5aRSZO6CBqvEwSx0foHYN0A8NtvXa3cTkK7PoEdbmrUTdxFw6mBLBdvZU0TGLacvZKm595FhjzOm14iy4u6yHq5Bbt+rmf77FEt5WSf/934A94mAzaQcZddYUcGzOcNSaQ+SY/AF1w3RGNRlswc+3nzFTQL8QjiIWlyXAk+5na4UrWOOAC4rQLGkohASMTa7rghkGuURQSpNrdwo6a6fY2RC3/w/lnj6sBIMjqtWf70gh7MurB0Cs1YpWOHkuz1W++uPM7pokZFzsacph/m/SH3nxcDtdLyv3kfdreRQYvLj6u8C6BnUN+EzEE7gmZOEu3lNe6RZmgdKd6eRGg4fGITdVI6Y2wwe3Du08r9rh55vZwb0OH1wiQ2lzzRrB7CpL+XfiGyilrbYe4d91nJlkyf5wk9wZRBsN4L5ggXgoGPA/9L/hepSCvaf5msU3El9Px/9z/ok8VkyRSziH+AKIdsM/cRNsEcxH88/kyVM4R8sMisasfYMbzZSaGKkQj5wVYVtk2e
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(376002)(136003)(346002)(39860400002)(366004)(5660300002)(6506007)(82960400001)(2906002)(186003)(83380400001)(107886003)(41300700001)(86362001)(6666004)(6486002)(44832011)(38100700002)(6636002)(9686003)(33716001)(478600001)(26005)(6512007)(6862004)(66476007)(8936002)(4326008)(316002)(66556008)(8676002)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r11OK/QdfbE5AkAlg5Cl2ofUgPBZ649uz0baYlzn1cO7bxJFXjXgysoMk3H8?=
 =?us-ascii?Q?NjSdOs7l8i7Brrkz0TuPlJxM3UW7tJF1XgeLmzVJbNpI52SHHJ+K3t31s46C?=
 =?us-ascii?Q?DU0m3iDbO6S2SuVgRSy4YpvOb6dCsTX66p7BFLvcpQAkH3tf97I1bOqcMm7M?=
 =?us-ascii?Q?QZ6JexqI1fXqAA6QCqJJEPKSTh9Rsfia4XpMXkjiB4s4DYwtK/VfAfcjdaCw?=
 =?us-ascii?Q?NVKglj4lQi63MbyoCdpLoshEuJ107Z3GveFvDOZBuZNHuk3I8KQ5jTyiYO8x?=
 =?us-ascii?Q?rJm7bOfdTwY5S/YiMiWZDFNE6jRGJdZwMAh4kxT45fSibvs3TyB6kf4C9PqU?=
 =?us-ascii?Q?R3N0kNZsz/x0cdE2ofP4mtywr8B+bikK2AXYQIPgC6S4QNs8uyB4+Roj1BJK?=
 =?us-ascii?Q?PF3d+wK2Bu/Mw9ApPPHLHte0KLjgjjeQZJlKy+Rv+j5TQXpkI19qO/G7Bex2?=
 =?us-ascii?Q?/yBoJl1gCOyyW9rdbs8AElyA6ZsWDkYORkzsM23WWlSih56j6nEO7buUYMdN?=
 =?us-ascii?Q?po6KxCFRWAUn2R4Eyrn2f2rmtV+VF1TQGxC6Kqg4ilmzD8e5RS+7qzlM1B0O?=
 =?us-ascii?Q?HEVbxx5Nl9LozVraOYB0URMKVGS/DUU4Pzuq6MyuAbOXv2e2Zz2o9l6QuaJY?=
 =?us-ascii?Q?mLFM7Qu4t54IH9N4rJhPFHRWUK7I/IJrlgFEhITVs6e8Ssw4ZIg1bUymq3SA?=
 =?us-ascii?Q?X7br/SBcDxZnEsExeLualUOe0YEVCBBL8WhrVp1zvMa2vp43SsZ+iBWfbSWv?=
 =?us-ascii?Q?Hr7IoyU8EeV1NFtzjr0MtrSFz/MrpTvxKMP7e8v7o/ksqYLMWZrMyrcmwLwv?=
 =?us-ascii?Q?pvnE6G72eS8bUEMjvCV1XiS6uuU00muFA3JPNK8FFaFtPeIIXKBMSoM7+UWK?=
 =?us-ascii?Q?8+ifzdZPizi25pr3AtaRT8OI8B9TlmKV1oStIakBczyRsmT84ooQXmrANMDv?=
 =?us-ascii?Q?6BGFdIm8b83zRHcwBdYSesHXUOpoKfWa3A/pEdeO2paCRCEUWQDdVIo5/D9J?=
 =?us-ascii?Q?wG9T2E6+rW0BqKUgypR5R2KS8LRl0uWyGaCvBscUhynQCm8yPydapQlDWA3L?=
 =?us-ascii?Q?DrMLGQIgJ6DXtvkRS9juoA3I46oMYA+xY1hGDJ061pPHezwjGwugVrKAnSmg?=
 =?us-ascii?Q?Vvo1m53jx9VXDJWMxPUGIWdctwo1oiawOoN3Psc7Iq7wKWJmogh2FEy+lpBh?=
 =?us-ascii?Q?BUfvEVpxQQyV/eT/so2sR1FPIQOXBKVVX9O9jcLJafqENm1M5jfqoA2i6BOl?=
 =?us-ascii?Q?ZF1SGAwPdmVG99e5/NLYpvZz7W0JbI3Pzlo6neEI+80SJWrX56hLmvbJjzPy?=
 =?us-ascii?Q?fExp3y2f2zRkuh3HFi80A943lYz6G0oXkdawRZtJhrgcA9M8hOFIzKKJMAz1?=
 =?us-ascii?Q?7qh+fbji3GPFFt/TyjLAPVrNi4BAiffymi3XY6Vx9Uxad3BUBeQdAB29fc07?=
 =?us-ascii?Q?nFcJbnxiqCACMILKZTmUTC1BiQcR06YBH0fsAVy//URSAWeWE4fY1nJY/Mq6?=
 =?us-ascii?Q?4tRY59MwQqTJ6hK2BTeDzylU2p0EpwG6PF2jTi+WYcfdKnQ0My7Y+7DN/Y9n?=
 =?us-ascii?Q?0KCyQcjc4JqK5dIv5RxLcoaAfvXtdYbdFHo/8R1J?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a4e6a2ae-0442-41dd-edf6-08da7734e597
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2022 22:50:30.1384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GSGJI5Nm/yxHS4YkTZkqBq/9W18hImyyoNiRqVhqp/9EDZZ3bQmku4MraBRVOVH7S+C/UojBaLsNCC/FTSLv7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6449
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Aug 05, 2022 at 01:27:45PM -0700, Dan Williams wrote:
> In cases where the decode fans out as it traverses downstream, the
> interleave granularity needs to increment to identify the port selector
> bits out of the remaining address bits. For example, recall that with an
> x2 parent port intereleave (IW == 1), the downstream decode for children
> of those ports will either see address bit IG+8 always set, or address
> bit IG+8 always clear. So if the child port needs to select a downstream
> port it can only use address bits starting at IG+9 (where IG and IW are
> the CXL encoded values for interleave granularity (ilog2(ig) - 8) and
> ways (ilog2(iw))).
> 
> When the parent port interleave is x1 no such masking occurs and the
> child port can maintain the granularity that was routed to the parent
> port.
> 
> Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  drivers/cxl/core/region.c |    6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index e71077beb021..641bc6344a4a 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1025,7 +1025,11 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  		return rc;
>  	}
>  
> -	if (cxl_rr->nr_targets > 1) {
> +	/*
> +	 * If @parent_port is masking address bits, pick the next unused address
> +	 * bit to route @port's targets.
> +	 */
> +	if (parent_iw > 1 && cxl_rr->nr_targets > 1) {
>  		u32 address_bit = max(peig + peiw, eiw + peig);
>  
>  		eig = address_bit - eiw + 1;
> 
