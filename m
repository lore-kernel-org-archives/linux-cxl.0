Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA16C19F2D
	for <linux-cxl@archiver.kernel.org>; Tue,  9 Aug 2022 23:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbiHIXgg (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 9 Aug 2022 19:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiHIXgb (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 9 Aug 2022 19:36:31 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215187AC22
        for <linux-cxl@vger.kernel.org>; Tue,  9 Aug 2022 16:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660088187; x=1691624187;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Uty5ib2mkGqR1R01z9G1KhokBgM1I4vSnBcb/F9WrKg=;
  b=KlHFxnjKudCrZVg1GnzUycTs+Vc7pEbxtKklKR+7DiGdgxFoLPiV0Cnn
   SKxzW65AXF83xhDXtyPY9fijDTGOpr7C14FQJmEHQBJapkjt2f8rIrOWZ
   XLCQR1fpT1QV6moC0iGPXQm2e9inToc1vSRy6bBpDfsBlX66heWV6Nn4P
   2mGqbM+vpEMvO6sAeuZdH3TXY52Dz1wKo4SUOXCocBG5IulbA+4SVqL/W
   TncFdU2YSIv/dOnKHjY5+eLsQ6qf6ALYXFGuPEGUxxuQXMAQQT0gM6M3h
   bs6sc/dnBq/+iRF3PLE9F/5dqh6VpTs2hZ73rj2vBAn7V+VgbvkWmr5qV
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10434"; a="274008078"
X-IronPort-AV: E=Sophos;i="5.93,225,1654585200"; 
   d="scan'208";a="274008078"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 16:36:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,225,1654585200"; 
   d="scan'208";a="694317071"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Aug 2022 16:36:26 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 9 Aug 2022 16:36:26 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 9 Aug 2022 16:36:25 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Tue, 9 Aug 2022 16:36:25 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.47) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Tue, 9 Aug 2022 16:36:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UBLFMlLCrYG6CSm7ZJYfQU5BJR8c9RgfSduta9anAJ9iv87u1m5wivcUFGtjLZAJyVm8azJg2tAdpkm3yH2GqsWOqmlVL+Eds3RYscbMDcPHaS5wWV/dpUF1N5oiXX4rfdhqsUCMO7rLsHzu9t6s3ozPQExjvYz8mZkGZZ9iKPgDAAQ0IwjpR0d5Sx4F+G/vA+gvkVYi7Zu+FjRBuxXMTPywhGxwfpnKjAANQI1VTdGUsBL9djjXesjYfaNA/LtCz6H1bzapi8ong7ngoD8te7L9Me3dER11gz4n28ZlO6Ytq5an4065CljTO9wP4UM111qJoMjTToEdbGRRjc2/6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oRAiP2kE19fZSsVjYIQsAspvCa/jIbEZALBqLHKxTlM=;
 b=R2rsCE03GEWw+9aQrS4+cbMCOf6OiNKiikB0ivSpVr3IXG4yDZ8SH8C5SQhRNWn6Qf1MuAjh/cx8Jr1NLlHQLXC8zGNjpcDSlOQsIxy/t8nuGuAmjBSbVTyRru0sxoVA/XbOY5g0Ie6L9x8hb8hg+EIl5TsLflyKSOThEqQHQNj40EQ7PJWbqT3PQNn8KUyx9ZRIo6cGSHWYHZhggykk3hwvx9Ov6fhGaFGG/gyOgABg4Rak2DuW7FeaasKjBLraJBJqgGQ1oCwDaM9CN4AiSjjCyt/MekWFLB6uKPNCD9X+Uts1GFc8FFLHpcvK8dqt0WiuJ6A5mdd8v1vyyUqK7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BYAPR11MB2550.namprd11.prod.outlook.com
 (2603:10b6:a02:cc::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Tue, 9 Aug
 2022 23:36:23 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5504.020; Tue, 9 Aug 2022
 23:36:23 +0000
Date:   Tue, 9 Aug 2022 16:36:14 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
CC:     Alison Schofield <alison.schofield@intel.com>,
        <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH 2/2] cxl/acpi: Support CXL XOR Interleave Math (CXIMS)
Message-ID: <62f2ef6e71b35_332482941c@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1660079951.git.alison.schofield@intel.com>
 <f092ab4c6eb82c83c9cec4e7000bac8115c3664d.1660079951.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f092ab4c6eb82c83c9cec4e7000bac8115c3664d.1660079951.git.alison.schofield@intel.com>
X-ClientProxiedBy: SJ0PR03CA0382.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::27) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d24d75d4-735b-4fe5-3f4c-08da7a5ff847
X-MS-TrafficTypeDiagnostic: BYAPR11MB2550:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kKW+l3vcHiBoONC6WOETfPxNon9IRMF/pJcnAM8HTBiqMDSMjoFX1lz5QvtnnNfw4k7Krw3Dt2Kl2D/qcUgnNBBMRGasW4sCmk+MdznG4kVewpb8APpbvjN/SWdJTSE58RDWgHvtZ0IVu0aA5Zl17bnjtGi/wo3CKlyXaSTUewtmwH3vE1tCmD7eHhlXhzFkMeFOBQTKDNsdWTUh+8rpey+3q+dZwvtCJn5VP1ey7eH+HLJpG54AuDBv1X/2Q4tzM+LOssgmyRDWY+rqmAxzfVSfhSLXM62RfNkFbwnDGdawNa8ZZzlW/+JCDeb1BdXfxklgW/iOGUezxJiEo7vrY5W88k6C+gJb3qvOORlZqeZC+F2Is3SK0gthSVbpnHrIDvEcwObdzmK8Unr5RsJwS+aBLhUceM7BP6tjnz63uFQB3ufgAbtAvnxo9GHtwKXTICUG6jjMxRfQi1jWX9/aZ1WKqlrxI8v4mHkJxw9ZO9WfM4ghb6Wf3h5dEfoS1xynmjUj2KlhjmxeU7jEpA7RWJIQid5LUHKVdMFlLtzuTB56ouAP8RpOzfmk/Z9G/D1tBgfE2TyLgxcqf4Wirj4UtkmMSabP2FJ3pRKgB2iC5neQs7tK79mD2VSrR23d5YbsVcEAxsD4d+Prhm9jlpx8YEmJCLcBYDKtiSprihZ0Mu2VTyF6KEoYEltCoNUBedEotDqgjEt2ly9r+UwAwQS6bWyjOfegSV7vqjVgLjcp58uev0ytXyH+q2F2UzW+NB+i
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(136003)(366004)(39860400002)(396003)(82960400001)(6512007)(26005)(83380400001)(186003)(110136005)(9686003)(8676002)(6636002)(316002)(86362001)(4326008)(2906002)(41300700001)(6666004)(6506007)(66946007)(478600001)(66556008)(66476007)(6486002)(38100700002)(5660300002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O0UsR2rxvO8UfjuIvVmRPapQ9KsaKo8Dsd2x5QnxKQuEliXxRhiZQ+5TzfZQ?=
 =?us-ascii?Q?YWm30UL710RXrFlMt+KXv2Ok/rJhrrYgiVIjiflnNMRCZjPJAMIwZyi0nSgd?=
 =?us-ascii?Q?kYscdNotNy06/XQOqobTLSYflc5K8iPAxK7oa2KvAaajmIBaGE6npfQZ8Xih?=
 =?us-ascii?Q?4FevxemL9GEjdWPjeGKAASj9BCPLYhcD9LNtvWEJMEoWd2gi+J3Sj0TW4j/r?=
 =?us-ascii?Q?XIGXcsc4t1+slGStslmgqo6pJvNh7TANc2bPkgRiImOe1DcDNsIoWxhNDoO0?=
 =?us-ascii?Q?FSUzYWErWys7ucw90cJIExuIcrV+Jj66vcplAza26Gd85C2jAjWKx+nTBLbT?=
 =?us-ascii?Q?0MYhhXNxmscczu3cfFA84+AK8q68APRtnMbdLbnxzvqMp2Lo5R6XF1ODbSM2?=
 =?us-ascii?Q?YYLRE7YK98d10h05cSGxYBptbc5tLjGdyWXY7URiwPU+QG/RYMnaaSjIpuuZ?=
 =?us-ascii?Q?tZv6ixAx3Sz5LMdu9ExKCNTspqaMUG3uAwsHF1D5L//YWBsY517fc7X+xbWA?=
 =?us-ascii?Q?nOo/ijivxnvg4dBrrua9C9FiTEYS4Pj04YChmgz4UwCsYBqLOoYPOEXiNMvd?=
 =?us-ascii?Q?rgc0we/JeijcC5FR1zjR2VTPnTGSiBU8/gAjuR0mlN/yR6Ydg+5ld1gE/kH9?=
 =?us-ascii?Q?spVCh9DKW7SoT5zQ5Ab3LE9ZkCFbGD0e/2L34wWyqv8a82WyN3c1/KhF5H6W?=
 =?us-ascii?Q?UcOL89wIO+tcD1yAM3iWBpYuDMg5hosrODsvE6t88+5FgZrCra9wA94n2u9s?=
 =?us-ascii?Q?vf9hm5Wyyo/CiYj+c7Ciu5gPY1t9tHx3L/jdfzD46mClk4ih7xdF4KKWwQPM?=
 =?us-ascii?Q?YIAjUOYFUgPGO6PjYWBlhCNkN49cg+z1uU7Fj1KCfEsCJoYx9Ed8thLWXI+o?=
 =?us-ascii?Q?fW4vq2A/2wtZP+2bnNRNBwPHwAnJZIGT9fYy855lDA3WxBu7oCZ+Y0pMLH2y?=
 =?us-ascii?Q?rfCvRPOv3Ng00B2Pc6b4H7jK7AzfdcJbwa98d3hIjBSJPkieaEhXPR3ODPsR?=
 =?us-ascii?Q?o72BXjypYRMK9IwhW7wjd2CNKGY3E7YHLIMBd0fljN9lAcvKF/kXqel4Zaha?=
 =?us-ascii?Q?utZbHEakVXg6lST+LDH0G51nbmB/hAel9LoE0I6UrF+L9/x6bHxlYTCxrIhR?=
 =?us-ascii?Q?IoY+LRzLN7+BHZWDK/amZhQT1zDxHGhAPATeEgVm/3uO8HVf9VGQ3Qp48b2M?=
 =?us-ascii?Q?/F92CZemoWz+mrK8YE/aKAwVxeGTq6BAM6TOz07j50we1e2V9rjkFOUrt8rS?=
 =?us-ascii?Q?oL/N2z2hr4THEtZLGX7SEHJAAff2Xr2gGA9AMfbKxUF6z1UGpOw54/ryaCjY?=
 =?us-ascii?Q?bijmCGUk5iwONt5RDpuNuelEL7ZbFR+e9tPsr3aE6K31TknWBXgONYVTxOOa?=
 =?us-ascii?Q?IHlVjiNGZnBmm9VOBl45x6omczEbGVf1FXZlyR1PoDZZ9tOiM2QhfiLa8IW+?=
 =?us-ascii?Q?qOUNkvhPUyy20lcfxCw5oILj00IHnUoQRPURJrfYmX/lPPbUp22/EzMPYtOX?=
 =?us-ascii?Q?yX4nIRg5yTeYJvLQtyoXFLqSbMSaSSlzYfnaJnMxs+qWnzot1Xi9cj66hxCP?=
 =?us-ascii?Q?j361/yzcBxC2vf9xo8Q0ErRZUQsyKjoC5VNE2JBDwBwkKOb2bndERLd8Z94d?=
 =?us-ascii?Q?eQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d24d75d4-735b-4fe5-3f4c-08da7a5ff847
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 23:36:23.4278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M992fk/cHgC/b/uKlB8eM6JbZmkNeyMYtpo8+cy8Yhgxjgxc+/4uXEc49cwNH83t+EfJz/fMwrcvXCENpt457LyoX+gda2YolRqm7RZWZMc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2550
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> When the CFMWS is using XOR math, parse the corresponding
> CXIMS structure and store the xormaps in the root decoder.
> Use the xormaps in a new lookup, cxl_hb_xor(), to discover
> a targets entry in a host bridge interleave target list.
> 
> Defined in CXL Spec 3.0 Section: 9.17.1
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  drivers/cxl/cxl.h  |  2 +
>  drivers/cxl/acpi.c | 96 +++++++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 93 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index f680450f0b16..0a17a7007bff 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -330,12 +330,14 @@ struct cxl_switch_decoder {
>   * @res: host / parent resource for region allocations
>   * @region_id: region id for next region provisioning event
>   * @calc_hb: which host bridge covers the n'th position by granularity
> + * @platform_data: platform specific configuration data
>   * @cxlsd: base cxl switch decoder
>   */
>  struct cxl_root_decoder {
>  	struct resource *res;
>  	atomic_t region_id;
>  	struct cxl_dport *(*calc_hb)(struct cxl_root_decoder *cxlrd, int pos);
> +	void *platform_data;
>  	struct cxl_switch_decoder cxlsd;
>  };
>  
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index fb649683dd3a..6ac6751c7f4e 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -9,6 +9,79 @@
>  #include "cxlpci.h"
>  #include "cxl.h"
>  
> +struct cxims_data {
> +	int nr_maps;
> +	u64 xormaps[];
> +};
> +
> +static struct cxl_dport *cxl_hb_xor(struct cxl_root_decoder *cxlrd, int pos)
> +{
> +	struct cxl_switch_decoder *cxlsd = &cxlrd->cxlsd;
> +	struct cxims_data *cximsd = cxlrd->platform_data;
> +	struct cxl_decoder *cxld = &cxlsd->cxld;
> +	int ig = cxld->interleave_granularity;
> +	int i, n = 0;
> +	u64 hpa;
> +
> +	if (dev_WARN_ONCE(&cxld->dev,
> +			  cxld->interleave_ways != cxlsd->nr_targets,
> +			  "misconfigured root decoder\n"))
> +		return NULL;
> +	/*
> +	 * Find this targets entry (n) in the host bridge interleave
> +	 * list. Defined in CXL Spec 3.0 Section 9.17.1.3 Table 9-22
> +	 */
> +	hpa = cxlrd->res->start + pos * ig;
> +	for (i = 0; i < cximsd->nr_maps; i++)
> +		n |= (hweight64(hpa & cximsd->xormaps[i]) & 1) << i;
> +
> +	return cxlrd->cxlsd.target[n];
> +}
> +
> +struct cxl_cxims_context {
> +	struct device *dev;
> +	struct cxl_root_decoder *cxlrd;
> +};
> +
> +static int cxl_parse_cxims(union acpi_subtable_headers *header, void *arg,
> +			   const unsigned long end)
> +{
> +	struct acpi_cedt_cxims *cxims = (struct acpi_cedt_cxims *)header;
> +	struct cxl_cxims_context *ctx = arg;
> +	struct cxl_root_decoder *cxlrd = ctx->cxlrd;
> +	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
> +	struct device *dev = ctx->dev;
> +	struct cxims_data *cximsd;
> +	unsigned int hbig;
> +	u8 eiw;

Per your comment on Dave's patch lets keep eiw as a shorthand for
"encoded interleave ways" i.e. the ilog2()'ish value of interleave-ways.
So just: s/eiw/iw/.

Otherwise, looks good to me. Just need the ACPICA side to land.
