Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1858CC00528
	for <linux-cxl@archiver.kernel.org>; Fri,  4 Aug 2023 22:14:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjHDWOK (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 4 Aug 2023 18:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjHDWOJ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 4 Aug 2023 18:14:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D96510CA
        for <linux-cxl@vger.kernel.org>; Fri,  4 Aug 2023 15:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691187248; x=1722723248;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=evyUj+8wJl27SFYp8NtqUX+rpLQ7efh0rAOTfR0nZBs=;
  b=OgUnsN5AfxeYvRg2tcYVHX3BAsWSEo+7b+ZIllWR2nqq3sToK0K0hPn3
   XvL8b6xKVNg6n8kdpjMVQJkRG60O/M3gHeFsunZsJOgplNUQy/m4iT9PO
   yLNhLuc9J9PDnDKLPcdjzO10pfxVqRwadQQ+omrITNPzZLSSHP+Wjc68C
   RW1bli7BLLbSbf2bAtyJCA8W15PvJDcyoNF/fBqXQODCWNo/C5ntT2lw/
   VJ4BiXxLN4BmwEXUt2DRLRXosTrb61D2MAGspp5fbxJY2Xq0Bj48RoJie
   VvGtfgqngdrZdcmbDf/IQqtcE6MKUQ1yzehe0Y029DPw588LFVr8f+EFS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="369152658"
X-IronPort-AV: E=Sophos;i="6.01,256,1684825200"; 
   d="scan'208";a="369152658"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 15:14:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="730215604"
X-IronPort-AV: E=Sophos;i="6.01,256,1684825200"; 
   d="scan'208";a="730215604"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 04 Aug 2023 15:14:04 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 4 Aug 2023 15:14:04 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 4 Aug 2023 15:14:03 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 4 Aug 2023 15:14:03 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 4 Aug 2023 15:14:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fTTeSCmjBb11GLjrVcmPzexLXqTxgHDkHMO5Oy63SNOWiRnAbHTJil/H1FU11Wcr1yJZQ9+VTjEHdecylqXx4F5qPVlbfrVuw2vy4zvHHEbQG2am4alxlqGP9trI6pZSJBvgPBbF0yTZvfc2Aj7sigrqt/7l8A6wCD4QWqTqePZF+JLvm99kOFnfk8Oyf795tVQDIYHAPluJxPVZGGZESPFtoir3H2l+R7VkSDqfNpmu/MLJcd+e+NxebhYa21f226mPRNHYqC9Ww09/q/4uQF7jOfIcnyEYZFn5FD3IFd4XOmT39pBeaaRft5Af1zh/m0eokzqHnO46vw/ZHAj7BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X+KGO8E7cdQqqfNHjAE34saDj9JmJNICPmXApW8v0Ng=;
 b=Sa4e4i0EM8XJaAYVLCeVmQ42UW74GFOvIuWQL2/oIkxU4VXpBza4s1N96Oa8qq1oqHrbl0qx+tM+HTTmUHi4iRb4vra/jsTFTzzz5dlHoh+CRy+I1amlL4EKtcY5vtmlkQuE1x45aQpRJcvOr52L15y3hVDJaA8ujdk0c0iK3YgnCwaTaaen1z+9o8liaz+tg+/lt07ooL4cOLsJUTnD16Hyoh3KnUiWgjNHMxmNOCmhhRaiDMnswoGweMOn79VuyWxr0Y9kMzD7UM++cukU1EvGffPqYKu1fJx5uyuL+cnO/4lvMGSTo7hpOuZhvw+23EIi3BpqxmlA+6uAyHDxgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BN9PR11MB5273.namprd11.prod.outlook.com (2603:10b6:408:132::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21; Fri, 4 Aug
 2023 22:14:01 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::4556:2d4e:a29c:3712]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::4556:2d4e:a29c:3712%4]) with mapi id 15.20.6631.046; Fri, 4 Aug 2023
 22:14:00 +0000
Date:   Fri, 4 Aug 2023 15:13:58 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     <alison.schofield@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH] cxl/region: Match auto-discovered region decoders by HPA
 range
Message-ID: <64cd782673ff9_2138e2946a@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230804213004.1669658-1-alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230804213004.1669658-1-alison.schofield@intel.com>
X-ClientProxiedBy: MW4PR02CA0003.namprd02.prod.outlook.com
 (2603:10b6:303:16d::30) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BN9PR11MB5273:EE_
X-MS-Office365-Filtering-Correlation-Id: c77532cd-dcd9-4086-0e40-08db95381b01
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RZyPVv12sBnPGMROkat8OQkub3cxe/fHghQ7+yr61OzOnUmfD5MSw3NUkoaimZVaP3XhaUOnZZAyC+R8ZoDMs0qq57Eaaj7YsSabws8FMWPOXTGxrPLvU0bVNCo/hupI4/B6bi/dYeq/z739JRxBK/MY2B8haX1WbzWLlQoxJTyG6u69sAUIhvnu9typaZeqH4z3ekLGQTiNS2Y/kq+I8U1te6gH+iHakKok1jFMpPt3oVrDZ2IX186Ozmz6x3dciNjdQhuY/p3ZcEX06jQMVNPh8mx19k2BvWCJCNOWprUb1GLhg42eCkm0r8HPABaA6AhOhHvbtzgppws8pgnTx+jDSUdPRtmeMctnV2K86WXsz3ML2RL0Na5EC5yI4QHN5X99FWL4VxyS/zTcyhlD71cr/+eVX+l6awU9i3uVeVnU0OF4cWiOdi/06kLZm+oUPH749DTkNWpDDMHW+FbwOuzxPp4c83Yr90e5ViSgzsPji1HYCG+9Tfub1AIFeZMTCEUQj40uWJkilHuhf9E/0b76ptrQSRuovIVdFehJpCd/g1WRlvBgQlEEpf22b+gu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(39860400002)(136003)(366004)(396003)(186006)(451199021)(1800799003)(66946007)(66476007)(66556008)(4326008)(2906002)(38100700002)(6506007)(82960400001)(83380400001)(110136005)(9686003)(86362001)(6512007)(26005)(478600001)(6486002)(8936002)(8676002)(5660300002)(41300700001)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GdScYm4ztCEl7n6Giz5VmPIyAMfUiAhlkHKGkeb/IiEbN2XHIWGL91ju5b7B?=
 =?us-ascii?Q?yqELk8tWmfPoImXUqF5SbMBEXGXvxGMGkZ9J70iFtTRZ84rUupgCxKQfker8?=
 =?us-ascii?Q?dJIDI2diqnvMmh4TCdFZhgGggnmXJBRx0BPzrBjl8EuFaUVzbrKz48kDp57Q?=
 =?us-ascii?Q?UY9VhwB2aPS8Stlpf8RhaoL5WA1LxTBkmrYAYXSxQnBwbaWsfu/OgYNMV7UC?=
 =?us-ascii?Q?pQKWhWyn4vJ7YdPz4WAEroJFytPYvO/CK+5kZ7e72yBZZCPnMVQDIDG+dQhI?=
 =?us-ascii?Q?HDCS2jmGmNnUIA9IckhxZHaNJM6TULpyY3TyqJuk5GO2qSSZ5zfBbN9RW4mU?=
 =?us-ascii?Q?tR45IWfARlTXXHemzcGNW7YSl8yhda/FyRk62W9dnSFApfWjRVivx9wpNzbA?=
 =?us-ascii?Q?HVz4LwjLE51q0yEMdY2WBRfAcdTIsmBlVoKq9LAmPDldpEvepcl/VWt95+vw?=
 =?us-ascii?Q?rCo3SKlRefM1WxdtjI99xCAi+ySrO5uX/hqqIpFBXUE4cIu/Q78H4a4YeB4F?=
 =?us-ascii?Q?PlR64YuFcuqruRKj2DvqQS1NlWrHbuoWWziudf6DjUu873Zu4Nc4QYn4QVhq?=
 =?us-ascii?Q?//KHTl/n9vYlxKCE6/PRYOT98xwdpnvG9yeMLRYs062OEaDovkF+VZDz54so?=
 =?us-ascii?Q?UKxVc3EMb1KcTwPkAohRC1X5IaRIktpPbZhP+kmEJJoQQg5bca9LUjFwTxlr?=
 =?us-ascii?Q?8fxn9uSIZrNlmCJXCxDxl2SlZXBIQluyOyEQXZPXDz9f2F9Z8ZxGTFFvP6KO?=
 =?us-ascii?Q?X27qDQohuq1qbW36ONtFTB/xzW+Ncjp9iPcVHLhEfxGyoK6xiM3XJLXWHjhe?=
 =?us-ascii?Q?GE4clYGALtCzN4gzK7rDj5ytcUAXfLoOyFgtELBIGh4Kz2yzQj/maYoYlid0?=
 =?us-ascii?Q?D0p+L8MBK9GvVuCIlXLYz4kfVeCyvjATpYdTnjHFDornO+DbIWkx4zFzT+TC?=
 =?us-ascii?Q?+pggyFwd9NjxJqJfVu+CIQByvgthCeXpyr8vk1BTdaQNusoC6dCgnfomeRWW?=
 =?us-ascii?Q?NF7IuG2jmOVz2DZePMvICXLYbetRm5bARn3vw0ectm4T3yUKQiKwsispMX+G?=
 =?us-ascii?Q?D2PvFfRoKi4GeE7/o2oqHUygO97AyIdLI7G1/x3xMNX5El2E8IESoqf1Kx6C?=
 =?us-ascii?Q?OVjAKTlHJXeWrzr6eNngK8CwDEgGy71tJ5T6t9N1hpjnhFj5ktNnTWrBGxI1?=
 =?us-ascii?Q?/qOLf0yQIovDKqelLP4kQ8sY5kz3Odb7GcHF2nStufs2CgI5gEaENBUX1060?=
 =?us-ascii?Q?U4ywMvdBWCKC6mLqDylQ0z/hY142FzyA9ll8df17oTFLHGyK+2wcpF1YkBkB?=
 =?us-ascii?Q?s1SWfiSrOiDjjIJf2jmqVHGUIqKW3Xg9FgnxyrHOGvAdkcz3+drme/L4Hvcp?=
 =?us-ascii?Q?U+BlYEDybE9wvjY4kAk/wsWCp735eNmPBGle5hJmrNoXJtC9KBH7DEXQLG06?=
 =?us-ascii?Q?nuF6Zbi65xORWfAnMJ8FpeN8zUolF+sl/JVk0eUy9p68dMWhnxMdVajBtKhG?=
 =?us-ascii?Q?oTVykzKSBJdufM9LM/jwjZNZBAEdR+WZFpWnhBwUId9dSlZXhy81OSVQ2oBJ?=
 =?us-ascii?Q?Q82n4OI22SkDN+a7wS9QgLiN4S6/ziay1G1ub4MNc2vx604cSBaEHNd9de0U?=
 =?us-ascii?Q?Rg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c77532cd-dcd9-4086-0e40-08db95381b01
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 22:14:00.7983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KZoFsWl2ErHGksWYopt8Xa+prbZW8YF/zBfS3QKdc9SMWbTuPRzgWPMCbRMy/XF0y4Wt5F5b97m+8lfaDdyr144AaYRwIYbuq1DGmDfXFzs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5273
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> Today, when the region driver attaches a region to a port, it
> selects the ports next available decoder to program.

A small nit: s/Today/Currently/

> With the addition of auto-discovered regions, a port decoder has
> already been programmed, so grabbing the next available decoder
> can be a mismatch when there is more than one region using the
> port. Match on the port HPA range for auto-discovered regions.

This patch looks correct to me, just a couple questions beloe.

It would be great if it was accompanied by a cxl_test scenario that
tested the failing case, but barring that it would be good to have some
logs from a scenario where people can notice if this fix applies to
their failure.

> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

I think this wants a "Fixes" tag:

Fixes: a32320b71f08 ("cxl/region: Add region autodiscovery")

> ---
>  
>  drivers/cxl/core/region.c | 31 ++++++++++++++++++++++++++++---
>  1 file changed, 28 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index e115ba382e04..8bfec7a96975 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -717,13 +717,37 @@ static int match_free_decoder(struct device *dev, void *data)
>  	return 0;
>  }
>  
> +static int match_auto_decoder(struct device *dev, void *data)
> +{
> +	struct cxl_endpoint_decoder *cxled = data;
> +	struct cxl_decoder *cxld;
> +
> +	if (!is_switch_decoder(dev))
> +		return 0;

Is this check needed? Endpoint decoders should also match by range.
Maybe make it explicit like:

    if (cxld == &cxled->cxld)
    	return 0;

...where it is obvious no further checks are needed, but I think that
also goes away with the change proposal below:


> +
> +	cxld = to_cxl_decoder(dev);
> +
> +	if (!range_contains(&cxld->hpa_range, &cxled->cxld.hpa_range))
> +		return 0;

Hmm, shouldn't it be identical and no bigger?

if (cxld->hpa_range != cxled->cxld.hpa_range)

> +
> +	if (!cxld->region)
> +		return 1;

Interesting, I am trying to think through the implications of failing
here. That would only happen if the port had been setup previously with
a different region for the same address range? How would that happen?

It feel like it should be:

	if (cxld->region) {
		dev_WARN(...)
		return 0;
	}

	return 1;

> +
> +	return 0;
> +}
> +
>  static struct cxl_decoder *cxl_region_find_decoder(struct cxl_port *port,
> -						   struct cxl_region *cxlr)
> +						   struct cxl_region *cxlr,
> +						   struct cxl_endpoint_decoder *cxled)
>  {
>  	struct device *dev;
>  	int id = 0;
>  
> -	dev = device_find_child(&port->dev, &id, match_free_decoder);
> +	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags))
> +		dev = device_find_child(&port->dev, cxled, match_auto_decoder);
> +	else
> +		dev = device_find_child(&port->dev, &id, match_free_decoder);
> +
>  	if (!dev)
>  		return NULL;
>  	/*
> @@ -839,7 +863,8 @@ static int cxl_rr_alloc_decoder(struct cxl_port *port, struct cxl_region *cxlr,
>  	if (port == cxled_to_port(cxled))
>  		cxld = &cxled->cxld;
>  	else
> -		cxld = cxl_region_find_decoder(port, cxlr);
> +		cxld = cxl_region_find_decoder(port, cxlr, cxled);

It looks like the cxled is only used to convey the range. Maybe just get
that from cxlr->params->res and not add another parameter here? Of
course that would then change the suggestions above where you can not
compare 'struct range' instances directly.
