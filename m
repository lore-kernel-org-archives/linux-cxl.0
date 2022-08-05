Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF7BC00140
	for <linux-cxl@archiver.kernel.org>; Fri,  5 Aug 2022 22:48:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238046AbiHEWsi (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 5 Aug 2022 18:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237614AbiHEWsf (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 5 Aug 2022 18:48:35 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2D61EAC9
        for <linux-cxl@vger.kernel.org>; Fri,  5 Aug 2022 15:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659739714; x=1691275714;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=tKRg/5p+KVB4hBtSc0hVv7bN/aMQay9pHgwnuUEZIkk=;
  b=Ttk+Ss648W5N5fKD8jlKs8vRZBkvV9fQ+fbGvipOOHNmTGhYjZ98w6qM
   it97RBVnhEQ7J7RBBuVWfq7NJvGnvmpPYCGHNQ6tjzzfaLsz8W0nhOj1+
   OydlXzkwmfHgLer7QQuNua29GL0v/9bYNm4PJEBNeNcxKx41M8GDUxjsX
   t1Sj8BM059V2aBzeX1UM/nFZkirNw/eflOme1fXsmJMWHmzTrKxq+CX7N
   qw/t6t0OFZAJz4tles5BOMEEjUxzWckkJQcW/WNQJayhCgqQIuvqG0wVi
   e1P67YhYWTZyJQS8OXX//t/MZ0nt1OJsXS4SqskVlfhz3+p3oU6IKvqGO
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10430"; a="277231058"
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="277231058"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 15:48:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="603749010"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP; 05 Aug 2022 15:48:32 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 5 Aug 2022 15:48:32 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 5 Aug 2022 15:48:31 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Fri, 5 Aug 2022 15:48:31 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Fri, 5 Aug 2022 15:48:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=no6pZ19k++nPnF3v0r1DhQ2Gq9noumlZOlnozrXbEHgrV2wluf5KDt+bLRse7XwAhWWsFnL3QAzAtpZKwcQGbY812NSR5GSRloNlnHe3byCzSGH+ZHqynwUlDYAmOZji6g5dVSkkeszgEsfnJrmgBVMWa3jxhqH/idfnizrQox6MhH9FawDICcnXnPsrdAqTEV+9tu277pOkf5TTKqNmcZxrYtZ/QWOFg7aBUF6ZIOf7RJrxY0CNiFOB3JqlqS/bGHkQFHDFvUQufjeItP8KPo0NrN1qbLizUElKrNEjBIC7+TcZp9vGL7+hklUp0fKpkgW4nXaPAUygoeb6KTtuuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UC9S1OSBqJkrrcj2EemGe+81WWF2UAHDpUDgmF0t0KM=;
 b=LIrEXhihz/ACXEBq/D9b+JjzVFWJfC6ipzv2EC0RK0oJd1FjkwNrnRXFyrmqIx1e//vfIRO8WRw54s9E+B68ukCnnhQw7p05yr+NVuNsYPeUZvdv2vJsDRcfeUff05Byg/0pA7GL205kNFF3K8oaPSDqDjdyrdskdx5TJmr8mGRkn/jXcfFVYCpfBqAVnlUAjreAnVy52FBsnt2cBrvNcxWAQNDQbp1dPNMcJixGmyhWCrowjKc+aKVvHCVotUAKvUUI8czaJwC06h/m/IelE/Omzl7tYaUaIgXLck8Kw9o5qlZ42Letw0Eg1iQH6sx3YJhYOwaVPsm6BI1ukpZCAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 PH7PR11MB6449.namprd11.prod.outlook.com (2603:10b6:510:1f7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Fri, 5 Aug
 2022 22:48:29 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::b965:e89c:548f:d058]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::b965:e89c:548f:d058%4]) with mapi id 15.20.5504.015; Fri, 5 Aug 2022
 22:48:29 +0000
Date:   Fri, 5 Aug 2022 15:48:23 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>, <dave.jiang@intel.com>
Subject: Re: [PATCH v2 1/3] cxl/region: Move HPA setup to cxl_region_attach()
Message-ID: <Yu2eN/FpFykVvuLc@iweiny-desk3>
References: <165973125417.1526540.14425647258796609596.stgit@dwillia2-xfh.jf.intel.com>
 <165973126020.1526540.14701949254436069807.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <165973126020.1526540.14701949254436069807.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: BYAPR05CA0029.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::42) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4ccaa10-30f5-4945-e408-08da77349d58
X-MS-TrafficTypeDiagnostic: PH7PR11MB6449:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l3y4HGOkNlhwxFOJF/WloLNp/8EXpn2/FjSuLVaW5B+phTJc1XECpib8MjEAsCV/7BSejDok/8e7F+mR+USHc3rtzs4y5GdeJ92CliCl9mtTKqoosj4bHGKW4sr3Mc/g9BpdAcGZp0pJWZBN4/KID4aa7gZCCzrXn6xubsUxb7nynw9Z5DQh7Mtolb5zLJCaBCTIk352zcpf/SO5wpMaXgYRJGIPDYSa3PsbBCMpcl3h5R07FkCPPPeAKDsYMCtSb1ofnfDHMSABGxANE89V83JQWWEFXn0PTRi9S2hb1C6SgN15iWJFYIURd0Vunazn2Sik25uLc0XCit7yta/olyguiAsGeQATryAat0xa/FmQAeb20GZQZeUcKawTQ+CGdJYbaUSIT5AHuzEM4NRLJuS0CV0uVEGiIyrK5uB7rSwiUV1PskL4+V2Mrm9f1lZxG36zEUR0LPRD3KxgfSFBZssVgpe6g78f4M7IeCoASM9J1fQWRxXZCOtR6k+jSsd70vd0/mxXnzdvrUYM3pSzqFkw9cRCgUDSkNxq0QnU+COFuIaNWM91yvi+aONxxjVl35i4GwuupWDJ9R9QjKU5x0zkd7ZbmLMTzL7xN0+JlFMlVXd5ZWCNzLlRuDmSWLvkU19I+Swdfl5uTw6QA41O7pBaeyINkfvtE7yMtvAiOUvSHHzHUxUcdlDeu0/l3n5Rznj3unWwoj/VPW9MfHzUieoTymfJ8urKiMAcMxHmCxJkt+nFdyCoOpGyj9KAzIb5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(376002)(136003)(346002)(39860400002)(366004)(5660300002)(6506007)(82960400001)(2906002)(186003)(83380400001)(107886003)(41300700001)(86362001)(6666004)(6486002)(44832011)(38100700002)(6636002)(9686003)(33716001)(478600001)(26005)(6512007)(6862004)(66476007)(8936002)(4326008)(316002)(54906003)(66556008)(8676002)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AuTGGhLLAEFo35l/CcEWpo+i1c6mM9Nx3wrr/74knZyAyPuMFlLRuzd/sWw3?=
 =?us-ascii?Q?tan/uRLQoS1qwVIYCSE+X7tV+1twmMhbe0E2MoyIl+aAE0NoZnFQb3MgGe30?=
 =?us-ascii?Q?0omgeokbq7SszsioJDB2/UaIsRAnLby7O+1FnTv26YFPvBXmaG9weNS0ZXp7?=
 =?us-ascii?Q?dXk+TEffndgkBjCYNa7wXwLvjGb2YX1o6Zb20W/d4lxLo90DeenlKBu/Pj/l?=
 =?us-ascii?Q?yTgkKgTZvVzO9Jx4Ujl5may65h8N/ee7ocDcwm5oUIWfyVaHgXTmGGfTDLcf?=
 =?us-ascii?Q?rhhmUKIU4j2H5n4bz58Sa4lG9hc7+cHiLLVi3mSvxBj+DmYvlZVNBbwvdH/y?=
 =?us-ascii?Q?hXGsrEv7p6O7O/kPpw/2Y05LQkpxqS8QLX9qyt94MmUN7Y15Xd3SZA4qUJq7?=
 =?us-ascii?Q?QjMwHnh4JdTMBHPxEf83eAV8bpSjA4u8HDicH6/IBZgK1NJ9tu9YkllDeQsS?=
 =?us-ascii?Q?TUs+rcMdRt7WHtN2ZFpb3uw2/feaV3YGWwYXq7C4VJ7zI4PJcQ2BC+lEXmCM?=
 =?us-ascii?Q?qeeiSHf0shEOtn9Oww2Mulu3cNdUN8cX+F4pWRyUKvzF6AFmST/BLqWfhN+J?=
 =?us-ascii?Q?avEx/6JXLtVldbqnb8l6pO/hyIoRISwHbClD/jBznnTpSx4oEgd1O7qgD6u1?=
 =?us-ascii?Q?BIsTBMwt30/Bu6OtcW8GfvF1RGGcMZ1WJZSBlqD45SL4hAW1Oh6U/7T0CNCd?=
 =?us-ascii?Q?TtbYXhzp0iTLobiuvhLyNQUTJQOd4txqTbIfVagcdB2ZDWcJfo7CXsBsgB97?=
 =?us-ascii?Q?en1Po2c7fDMqAgizPqHGzR5wxx5P80XJVbgAfiJLDixyGeeQnka6mnkOU29h?=
 =?us-ascii?Q?MLMJBaiHyodj/ipdujx84VztDzca9UnqswCcovmzRXtAgyQs2q2/3U6A74pn?=
 =?us-ascii?Q?sMFlndV2zfJwi6qsvCTv+ZzVZdH5t3x6fp4E6P1AdhWoWn7ilBYx/xNy4EUB?=
 =?us-ascii?Q?EkRR9QQL0CFGNPxGrpZXaMkqCdZFqMkSAdIhZGLXK/d2avOyvey4Af06Ud3x?=
 =?us-ascii?Q?RVfSfzvwaDqowouLLhqLqUU/UD3uhypbbDQQ6dBsb66vPk1jql1mx5iila8x?=
 =?us-ascii?Q?inRkp5MQqYbZa7jdOXa4VddpCGr5e0CjQrJBiHALRqEjUP5StJO7HAIGY5Hy?=
 =?us-ascii?Q?mpQ0uziS26zFEtvgfv4zCOsk+8TCwQRcHP2BfqNdRvhpNCxy990vAMOLk7No?=
 =?us-ascii?Q?v9r40i9JuDSOtlo9vawAK28ueUUzCF8qsVwI2L4YzYvjOfc+7k+PbvbDw3n1?=
 =?us-ascii?Q?SYE44y10ROT8/fJzr9M3KbXN8nBtre4cw0t+Il/OMTkqHfQF+D0nI03gwQPw?=
 =?us-ascii?Q?fixEHr0WhZkWCPuFvlwBJfLglgJNbkBDnKZql7MW6yvN1k/TsW5x/wk/yiSf?=
 =?us-ascii?Q?xN+qb4a3Bb7Sc20sOF20maWGcIlMIzyjmTqe04wzSok24CaNzAXwBsGZXV5v?=
 =?us-ascii?Q?1FgxOsng9gR+BzqtyDYIWiYOvIjP/nfUgt/I7QXv/OCgMDbnJ4aWuCB0DOfv?=
 =?us-ascii?Q?s+GnZ+5iH+uZj4tyhiU8equJE7TXnQhr5hMzitBz6UIaAzEzetCyFAMaNmnd?=
 =?us-ascii?Q?1ciAL3t2I4aB0OOtc5OermHrSuZCwUwodIcx6eW1?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b4ccaa10-30f5-4945-e408-08da77349d58
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2022 22:48:28.9761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CqxlDAXvHjIwLGv0wzCSHvi0kJvIVlz06xv91ZIFekYBOAQvHCik5wM1m50AeAwWAGR29yssLdxDPPDm9SM1+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6449
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Aug 05, 2022 at 01:27:40PM -0700, Dan Williams wrote:
> A recent bug fix added the setup of the endpoint decoder interleave
> geometry settings to cxl_region_attach(). Move the HPA setup there as
> well to keep all endpoint decoder parameter setting in a central
> location.
> 
> For symmetry, move endpoint HPA teardown to cxl_region_detach(), and for
> switches move HPA setup / teardown to cxl_port_{setup,reset}_targets().
> 
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  drivers/cxl/core/hdm.c    |   26 ++------------------------
>  drivers/cxl/core/region.c |   24 ++++++++++++++++++++++--
>  2 files changed, 24 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 8143e2615957..e096f74e19df 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -499,28 +499,6 @@ static void cxld_set_type(struct cxl_decoder *cxld, u32 *ctrl)
>  			  CXL_HDM_DECODER0_CTRL_TYPE);
>  }
>  
> -static void cxld_set_hpa(struct cxl_decoder *cxld, u64 *base, u64 *size)
> -{
> -	struct cxl_region *cxlr = cxld->region;
> -	struct cxl_region_params *p = &cxlr->params;
> -
> -	cxld->hpa_range = (struct range) {
> -		.start = p->res->start,
> -		.end = p->res->end,
> -	};
> -
> -	*base = p->res->start;
> -	*size = resource_size(p->res);
> -}
> -
> -static void cxld_clear_hpa(struct cxl_decoder *cxld)
> -{
> -	cxld->hpa_range = (struct range) {
> -		.start = 0,
> -		.end = -1,
> -	};
> -}
> -
>  static int cxlsd_set_targets(struct cxl_switch_decoder *cxlsd, u64 *tgt)
>  {
>  	struct cxl_dport **t = &cxlsd->target[0];
> @@ -601,7 +579,8 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
>  	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(cxld->id));
>  	cxld_set_interleave(cxld, &ctrl);
>  	cxld_set_type(cxld, &ctrl);
> -	cxld_set_hpa(cxld, &base, &size);
> +	base = cxld->hpa_range.start;
> +	size = range_len(&cxld->hpa_range);
>  
>  	writel(upper_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
>  	writel(lower_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
> @@ -674,7 +653,6 @@ static int cxl_decoder_reset(struct cxl_decoder *cxld)
>  	ctrl &= ~CXL_HDM_DECODER0_CTRL_COMMIT;
>  	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
>  
> -	cxld_clear_hpa(cxld);
>  	writel(0, hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(id));
>  	writel(0, hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
>  	writel(0, hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 40f04c543e41..e71077beb021 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1044,6 +1044,10 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  
>  	cxld->interleave_ways = iw;
>  	cxld->interleave_granularity = ig;
> +	cxld->hpa_range = (struct range) {
> +		.start = p->res->start,
> +		.end = p->res->end,
> +	};
>  	dev_dbg(&cxlr->dev, "%s:%s iw: %d ig: %d\n", dev_name(port->uport),
>  		dev_name(&port->dev), iw, ig);
>  add_target:
> @@ -1070,13 +1074,21 @@ static void cxl_port_reset_targets(struct cxl_port *port,
>  				   struct cxl_region *cxlr)
>  {
>  	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
> +	struct cxl_decoder *cxld;
>  
>  	/*
>  	 * After the last endpoint has been detached the entire cxl_rr may now
>  	 * be gone.
>  	 */
> -	if (cxl_rr)
> -		cxl_rr->nr_targets_set = 0;
> +	if (!cxl_rr)
> +		return;
> +	cxl_rr->nr_targets_set = 0;
> +
> +	cxld = cxl_rr->decoder;
> +	cxld->hpa_range = (struct range) {
> +		.start = 0,
> +		.end = -1,
> +	};
>  }
>  
>  static void cxl_region_teardown_targets(struct cxl_region *cxlr)
> @@ -1257,6 +1269,10 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  
>  	cxled->cxld.interleave_ways = p->interleave_ways;
>  	cxled->cxld.interleave_granularity = p->interleave_granularity;
> +	cxled->cxld.hpa_range = (struct range) {
> +		.start = p->res->start,
> +		.end = p->res->end,
> +	};
>  
>  	return 0;
>  
> @@ -1315,6 +1331,10 @@ static int cxl_region_detach(struct cxl_endpoint_decoder *cxled)
>  	}
>  	p->targets[cxled->pos] = NULL;
>  	p->nr_targets--;
> +	cxled->cxld.hpa_range = (struct range) {
> +		.start = 0,
> +		.end = -1,
> +	};
>  
>  	/* notify the region driver that one of its targets has departed */
>  	up_write(&cxl_region_rwsem);
> 
