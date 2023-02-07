Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D5B4C636CC
	for <linux-cxl@archiver.kernel.org>; Tue,  7 Feb 2023 22:39:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjBGWjw (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 7 Feb 2023 17:39:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjBGWjv (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 7 Feb 2023 17:39:51 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289D71A4AA
        for <linux-cxl@vger.kernel.org>; Tue,  7 Feb 2023 14:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675809590; x=1707345590;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=iPdNLO+0GW7k9HFBjLBMtdjLDKyuWdlc/TRJMlxTPLM=;
  b=XTxolezm4GBdv6aXNSLOUaChc9UoYN4YkYxbriPUWsxgXsuEOuzjXJrw
   Oi8MSh8tVYrjO2JeEilE5sSPWNHwU3mMCo/1OtNfH1glWS55+KyuIeKb6
   g2mx7VkGOJW9EKxanLgHrpe2OQQdYMNC/5m+jhFvHokTS6ZsSijQfUexB
   R9JJMRRO/vCVoMMTfcEVErZ3UFnzPpVmzoEIQUseVWwM9FKyGENTVjDJ4
   WdJduH+SYfyjsOBN7M9BHJK041pC1ckORgfJS7AWG8WjVczUrx2TLgNvl
   5UtjcuLGOe6qRBRFt84tCi5GaRHJTWZ4ZjnHtEtLdxFHzdWyyWoDx2Fcs
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="313290914"
X-IronPort-AV: E=Sophos;i="5.97,279,1669104000"; 
   d="scan'208";a="313290914"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 14:39:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="790969441"
X-IronPort-AV: E=Sophos;i="5.97,279,1669104000"; 
   d="scan'208";a="790969441"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP; 07 Feb 2023 14:39:49 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 7 Feb 2023 14:39:49 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 7 Feb 2023 14:39:49 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 7 Feb 2023 14:39:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lT0lMyYqXBET9xaedhBmihvV3rzPGptyBBxIEUL20pcaLXAH5ZdELb6VFg0Skz2YcmkPTkAImMqP1oXxsYs7Y9rnrviRR7+25P1Ul1oLlbVonV9O7dO6M9bSX8RFBUlT8mb8+si6XwQx0+KvWUS/c6m77sbfY3Ig6cmacKBJAcuhEOz8ppPOpadnYGi91XpvROW2++BHAPlqUV4MvFdg2XH0YT1LZ3jf1BETjpa/wTlzYx6f+N4mIGWAtrTFY+DRsD6JlSXGSpu8l+WluO8khvwsiDg6SUKmiM/4PaCbNoTn9/GqcuQXL78ec6KGWKHJZ0kRsqgjDHhHMsKhaV6SbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7nvUCvVLroe6KxXCiUmkgkizMN1myZ6oJcp+hVYaz14=;
 b=dhBfFb+WUMGnTOAq/Gyj6cpWnS9+wZ3OpovHlp9/zV7uE4qxh/ookhFh49YCYWj/U6zLEEVOMwpxkUE8Z1h1c1Ws6LqqX4ajzvgv1ou2/0/5d/oDhnIkoxiCP0l0KvRkr0u5559w7ZkWLxLCyenr9ZQNsZxAZkNO/kI6XNXN838c8FsqYwcSxUKcyqIT65P/swDG17c1mA75p8nUmO6eBsh4no5OexpaIxCj2x5XgcpKyL0/anChHD8ajmAqlXQsxY5uLLtv1gKOT+eQ4FSfse6nG4AKSMOWP5PERgBPnK45k0iMR6xoYcU7w2VZTo8oT3rM1nwHzs4FUycdPUXXQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB8000.namprd11.prod.outlook.com (2603:10b6:8:128::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 7 Feb
 2023 22:39:16 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%6]) with mapi id 15.20.6064.036; Tue, 7 Feb 2023
 22:39:16 +0000
Date:   Tue, 7 Feb 2023 14:39:12 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC:     <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <jonathan.cameron@huawei.com>
Subject: RE: [PATCH v3 4/8] cxl: emulate HDM decoder from DVSEC range
 registers
Message-ID: <63e2d310d5063_e3dae2943d@dwillia2-xfh.jf.intel.com.notmuch>
References: <167406522720.1455071.8837344641950166822.stgit@djiang5-mobl3.local>
 <167406533420.1455071.7180353856174143346.stgit@djiang5-mobl3.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <167406533420.1455071.7180353856174143346.stgit@djiang5-mobl3.local>
X-ClientProxiedBy: BY3PR10CA0022.namprd10.prod.outlook.com
 (2603:10b6:a03:255::27) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB8000:EE_
X-MS-Office365-Filtering-Correlation-Id: afda022c-fbcd-428d-17c8-08db095c24b1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YjUpUGUoWyjGorIe5QRxM65M5m1qvWr9MRB+y94f311H5DCq+LadP9tdQonJWKElRb+Sj0+MTvkmxrNqU3BDVdhbZ5mDnAjD/I37lGJsCyYKDoeyCbvNEXu3aGmxxDkkJbYfvk/rwZGbpLyl2IGfhq/BS1rcdu3UV5K7MLSIVZVJhgTfux4I/lsMbZNXwDm6wWOqag3qHB544ND13p6ADH2Bh7curWdFAbVmYOjJuOBkxD9XXgsxlN5oW49Rixv/42om4kGcmt1ifNZmS5l0+RRkhux0zVg16J635byWbcER7x22Zt4gHbkxTzTbUHXY48N3LYMaRa/jr9WOQmWzGHCCCBk8NgF/wbj8bI+U9WjnXKMq4Ocqv2HwGGWs6GPd/VyyXTy64JHkbRahKkV4O1wAnZcDH/8fK+jZ8lELRx7lztf+tR3lNguv8Z1NibIcbwDHqVsFgFljk9j3CMcbZdYIvMwT/1gDYfRIFmA9cnYPo4VZ5bhvuMLvAkKj/fptbOAsOqb5C3UhcHjk12TXVcppo7SlvwobWxZYScTBpp+YuRKe35wBnYBqkfpOVIhc300gg7O0HyvjCdpMSPKltDLs7KGhOfQrbBv68n8uNZIdvcp0nvufwwWE/1TD1qXHRuwQwHgq/Ds/yfBfbuHpaQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(39860400002)(136003)(376002)(366004)(451199018)(6506007)(316002)(86362001)(8676002)(66946007)(478600001)(83380400001)(66476007)(6512007)(4326008)(9686003)(6666004)(66556008)(26005)(6486002)(186003)(8936002)(5660300002)(2906002)(38100700002)(41300700001)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9uteKKnYbO1+ynzjBg2enft7daukW9+DW2rkS85dI+KGazk7oclJ+sStjXLM?=
 =?us-ascii?Q?STnzz/c4io2wWYZGTtZANPz4z4VxJfJjdOdmDLHI4iORs/TEU3a8/3ea3Ayu?=
 =?us-ascii?Q?NTr33z1qAEnTJcrv2xo/+83dB+Kih7WPX5qmIh15zaBpOSzZQNSQaYhNanYG?=
 =?us-ascii?Q?CWa78t+ZMju/QLOcY4IF0tTuBu9v/hYQnXvcut3F4LnUc2tB/h9bEGcf3Hef?=
 =?us-ascii?Q?1uXosU+eNSXQDLRC/6DEwRDYlaF6x5sqesuOl8e9HawH/09cqa11iO1HFwqR?=
 =?us-ascii?Q?zWeeF5Ef3xgCkttYWrIxeVAlI9sMQ2lJuRWoc9L6TPks69JcLI5czkjTjNWb?=
 =?us-ascii?Q?gwjewfX7dVx8nmk1ZZxE8r6b8DZ3oVfb7YhkTIKIs2hTXOMkdvzsoB0p6psy?=
 =?us-ascii?Q?myVtHljZi26cAGrC/+7gPZIjEHzXQWFHLhnCMvAEsStpOvul2sqMdgzQ0o7/?=
 =?us-ascii?Q?d4J213Gsf0ec+4zG/zAuH12TnZn18ralsf6PVPSBYtnig+xRg4fLPxvrPDu+?=
 =?us-ascii?Q?QlB3/k8t53so3YOXQPWWA9Ss6+AJey1fl4TKZYuwsT4qKvuGcwVZEKGEL9fW?=
 =?us-ascii?Q?jY7EqUYEZDcu8aCLqHF6Fz811l9L5l8xSGppMIA0MCdEOhAGzgE3Ro9ykuug?=
 =?us-ascii?Q?g+a60xGAbP2T6OF4k++QLfGhC7wy2JPo8L+n46n47imE4hKLco0qWBpekD2s?=
 =?us-ascii?Q?39bcsCxR7TY+uyuN1atHDaDFcinlDWp9USBQNhCaHS/QKvTTBCZohELQIByL?=
 =?us-ascii?Q?8sFmx0uEbDMUMNPPiWjPfCyOrGqz5c/irtxGK3Ba1kdoQVN67TiDbiS2UUZ9?=
 =?us-ascii?Q?QBsRsOqeII74gPz9nmUKup5sxVMvJ5al3KGOl4C5de37teiq2NJFSLwtkhEq?=
 =?us-ascii?Q?OZ+JNfCzEsN9AkRlfE5Qw4hLsAstX5M8wZ7bhma+eiYDxuRYwi68A/tzqhqS?=
 =?us-ascii?Q?2fFJXDeFtqeUX6tm/hyC0Ug99bcbpH4ql8/ZRRdHc+Kzo+WLe1zi5VnfoQD6?=
 =?us-ascii?Q?bhWpUKbUjcokS31SZr56n0FBki6PPxP7DuUe0S1dYywaGeD6lySXJM3f+X7h?=
 =?us-ascii?Q?41Qe3ktDIPDYxBX+zkPNMQkus2ulg9A3ATRccBqWupRo00GCcbS/DTYPU67P?=
 =?us-ascii?Q?+OFn5Y/ikgKxXGdKpre6HaSawvSzWhFXvnJE6qkTcS4RJLT7kRaPgja/4p32?=
 =?us-ascii?Q?0yZEbDHBY/CGpzXes+UAAyhIx+NksGTcwKZu0FgJCBd41gMCE6blbkPCijUP?=
 =?us-ascii?Q?myAohvdI0SYtpaoDFxZvCxcUHX7fa0RdzlFbSYVQCKx1DIM0zc7h6PsmsXvn?=
 =?us-ascii?Q?XbHytlLrMmEEbAIgTcxKwpICIUHhy80rEj4B1rLfTlelpjmEs5g5ynYQ/Cj1?=
 =?us-ascii?Q?aZdMzAHQ5qmmb65QPqrXcPD7d1IMOG6xDgiHA2xZEztVcaMONcNKo+uc2sC2?=
 =?us-ascii?Q?kFYJQ50QtMrxvz7bV7Op/ULJC2r9JzHBXj5/rG6LkydVWJ9FRGpK+Grb5Xg4?=
 =?us-ascii?Q?/xnh9T3wM0hP4Ym2aJtqwayXtdycjywt/xXVZLf8VVwymkF9OgPGjhu6FYQ6?=
 =?us-ascii?Q?bJIz3YM1SBh+sDlhKfdQ+Fly4rjNfOzVwIljK7kIEHcckHLWxH00+NwDf7h8?=
 =?us-ascii?Q?zg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: afda022c-fbcd-428d-17c8-08db095c24b1
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 22:39:16.2784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AgtBWDp+C+wsGAYx+FFfOlFoau4/V9Gmt1FxSTJQXmZns+SP7iMVvfj0Iz5FowSC1DsiBXc4ID2psM5RteCdRDqRNwSg+WzWg/kTIJkcvQM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8000
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Dave Jiang wrote:
> In the case where HDM decoder register block exists but is not programmed
> and at the same time the DVSEC range register range is active, populate the
> CXL decoder object 'cxl_decoder' with info from DVSEC range registers.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> ---
> v2:
> - Set target_type to CXL_DECODER_EXPANDER (type 3). (Jonathan)
> - Skip HDM enabling if DVSEC range is active. (Jonathan)
> ---
>  drivers/cxl/core/hdm.c |   36 +++++++++++++++++++++++++++++++++---
>  drivers/cxl/core/pci.c |    2 +-
>  drivers/cxl/cxl.h      |    3 ++-
>  drivers/cxl/port.c     |    2 +-
>  4 files changed, 37 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index dcc16d7cb8f3..af1f5f906f52 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -679,9 +679,34 @@ static int cxl_decoder_reset(struct cxl_decoder *cxld)
>  	return 0;
>  }
>  
> +static int cxl_setup_hdm_decoder_from_dvsec(struct cxl_port *port,
> +					    struct cxl_decoder *cxld, int which,
> +					    struct cxl_endpoint_dvsec_info *info)
> +{
> +	if (!is_cxl_endpoint(port))
> +		return -EOPNOTSUPP;
> +
> +	if (info->dvsec_range[which].start == CXL_RESOURCE_NONE)
> +		return -ENXIO;
> +
> +	cxld->target_type = CXL_DECODER_EXPANDER;
> +	cxld->commit = NULL;
> +	cxld->reset = NULL;
> +
> +	cxld->hpa_range = (struct range) {
> +		.start = info->dvsec_range[which].start,
> +		.end = info->dvsec_range[which].end,
> +	};

They're both 'struct range' values so this can just be an implict
memcpy:

	cxld->hpa_range = info->dvsec_range[which];

> +	cxld->flags |= CXL_DECODER_F_ENABLE | CXL_DECODER_F_LOCK;
> +	port->commit_end = cxld->id;

I think F_LOCK should ultimately come from whether the associated CFMWS is locked,
but for now perhaps a comment like:

/*
 * Set the emulated decoder as locked pending additional support to
 * change the range registers at run time.
 */

...basically just to indicate that there is no requirement that they be
locked, but that the unlock case needs quite a bit more work and
testing.

> +
> +	return 0;
> +}
> +
>  static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  			    int *target_map, void __iomem *hdm, int which,
> -			    u64 *dpa_base)
> +			    u64 *dpa_base, struct cxl_endpoint_dvsec_info *info)
>  {
>  	struct cxl_endpoint_decoder *cxled = NULL;
>  	u64 size, base, skip, dpa_size;
> @@ -717,6 +742,10 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  		.end = base + size - 1,
>  	};
>  
> +	if (cxled && !committed &&
> +	    info->dvsec_range[which].start != CXL_RESOURCE_NONE)

Ah, here is where that CXL_RESOURCE_NONE is used, can this condition
just be:

    range_len(&info->dvsec_range[which])

...i.e. non-zero size?

> +		return cxl_setup_hdm_decoder_from_dvsec(port, cxld, which, info);
> +
>  	/* decoders are enabled if committed */
>  	if (committed) {
>  		cxld->flags |= CXL_DECODER_F_ENABLE;
> @@ -790,7 +819,8 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>   * devm_cxl_enumerate_decoders - add decoder objects per HDM register set
>   * @cxlhdm: Structure to populate with HDM capabilities
>   */
> -int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm)
> +int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
> +				struct cxl_endpoint_dvsec_info *info)
>  {
>  	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
>  	struct cxl_port *port = cxlhdm->port;
> @@ -842,7 +872,7 @@ int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm)
>  			cxld = &cxlsd->cxld;
>  		}
>  
> -		rc = init_hdm_decoder(port, cxld, target_map, hdm, i, &dpa_base);
> +		rc = init_hdm_decoder(port, cxld, target_map, hdm, i, &dpa_base, info);

Looks like a long line for clang-format to trim.

>  		if (rc) {
>  			put_device(&cxld->dev);
>  			return rc;
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 97690c429e05..81882ea94adf 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -427,7 +427,7 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
>  	 * Decoder Capability Enable.
>  	 */
>  	if (info->mem_enabled)
> -		return -EBUSY;
> +		return 0;
>  
>  	rc = devm_cxl_enable_hdm(&port->dev, cxlhdm);
>  	if (rc)
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 1057affb2db0..ea9548cbc7eb 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -644,7 +644,8 @@ struct cxl_endpoint_dvsec_info {
>  
>  struct cxl_hdm;
>  struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port);
> -int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm);
> +int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
> +				struct cxl_endpoint_dvsec_info *info);
>  int devm_cxl_add_passthrough_decoder(struct cxl_port *port);
>  int cxl_dvsec_rr_decode(struct pci_dev *pdev, int dvsec,
>  			struct cxl_endpoint_dvsec_info *info);
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index 404639a1c3d0..7f1b71c5cf15 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -79,7 +79,7 @@ static int cxl_port_probe(struct device *dev)
>  		}
>  	}
>  
> -	rc = devm_cxl_enumerate_decoders(cxlhdm);
> +	rc = devm_cxl_enumerate_decoders(cxlhdm, &info);
>  	if (rc) {
>  		dev_err(dev, "Couldn't enumerate decoders (%d)\n", rc);
>  		return rc;
> 
> 


