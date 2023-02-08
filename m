Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C484C636CC
	for <linux-cxl@archiver.kernel.org>; Wed,  8 Feb 2023 01:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjBHBEy (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 7 Feb 2023 20:04:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbjBHBEw (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 7 Feb 2023 20:04:52 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A36410BC
        for <linux-cxl@vger.kernel.org>; Tue,  7 Feb 2023 17:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675818286; x=1707354286;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8FhPS0sfcb9aHt1SunF1fk44YBJ35yW8rIqu+eqJIHQ=;
  b=GWiKbgzexpMTqHd0m1iG18nqpKBYvUeQWlm9FwLEixrEQIsuqQy+0RT5
   bGMME43lYANts0MyZ3nmx949xSdG+TaUkREJ5kMCO42t/B3Cy9neDKLIu
   I1sBo4aecKO302RUKGW2kpRvJzOeW5avCoHAtiQppw/HvfGFTY5ihpjOJ
   DM53xQ+SHAJ4hlRAVjYeNqeUxf3RLr4S3OjCBeWMpXtbLAd8NEB4XoNbt
   n25pwGzosAMwyORN2lXE+8BQrVWN6cIvDGI0VGJi38E4RATJHm0GAkkch
   Bc3GHrQQSrI+ROkCjq1+s335ymZjy1o2ugzqKvspyuKMkGPIk7yCHoLf1
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="415893432"
X-IronPort-AV: E=Sophos;i="5.97,279,1669104000"; 
   d="scan'208";a="415893432"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 17:04:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="791009862"
X-IronPort-AV: E=Sophos;i="5.97,279,1669104000"; 
   d="scan'208";a="791009862"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP; 07 Feb 2023 17:04:43 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 7 Feb 2023 17:04:43 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 7 Feb 2023 17:04:43 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 7 Feb 2023 17:04:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ApNZ6wc8ar4ED3JPOO7B657436+IOzIYEVtQ7i5ZpVX56kBlbey+/ygF6cMCMmf4XCdjj4MI8jUoKbbx4QTVZqaEJoT2WrpXd5eQmejY+LI1zg3aNtF8zp6TMNB6EYYUQp8YSEgFmIEpdQ3gV2ceJCoY/E9+MuzuonehcW30Yd0Zhkh85iADzFPGesvoleKWMBHJE2nPAkTQQVfyEH+L4Sfjhf+ArngnozWT9Cnc7/oqgYA/wVyz85G3BGAIw93dKzqIufyI75/K0lEu5ItUMXAXgORl+dCtPN+7jYR2t7Hbhb0tW6zdJC4hfzj8TLGEcbnCIQjJSUJvj5xdD2sohg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IAWN7y6Z8wXEtYVpIQXL3F0+FFWWuVBJFLoA35qT3Ps=;
 b=WVpETy0hFMeNHtff0i5FLSEWAJ6CwU4fnYv2ULFHAP7pmMraFE5JbT6fS7+ZaGPr55jXCK7MrPHc1ATXZSv8gwnekeklAp4Ews+zYpRYx9H3X43c+rHCMJccE+dUMTqyCMmYJkDwDYyFJbXl3Eiz5fR/UhMLHss+HqCOBdcn1uNHkzIvIbY3hXHuYO2e/8OM1vgCIEqi06nlviYAWRwjI5QpLMAOe+v8Mrtzaa7NZph3e0cxZ+XvjTiZ3g7RHsK7XblJDPkXVpUuRBe9Vr+qFl2iDeqb5xGSxMhUxzwGwXFR9WOcr2SiM12ARRgywnyFUwQI/6HwjIh3TSmE19RvNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA3PR11MB7581.namprd11.prod.outlook.com (2603:10b6:806:31b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Wed, 8 Feb
 2023 01:04:40 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%6]) with mapi id 15.20.6064.036; Wed, 8 Feb 2023
 01:04:40 +0000
Date:   Tue, 7 Feb 2023 17:04:36 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC:     <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <jonathan.cameron@huawei.com>
Subject: RE: [PATCH v3 7/8] cxl: Add emulation when HDM decoders are not
 committed
Message-ID: <63e2f524a28e6_e3dae29492@dwillia2-xfh.jf.intel.com.notmuch>
References: <167406522720.1455071.8837344641950166822.stgit@djiang5-mobl3.local>
 <167406535984.1455071.5414508134960800436.stgit@djiang5-mobl3.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <167406535984.1455071.5414508134960800436.stgit@djiang5-mobl3.local>
X-ClientProxiedBy: SJ0P220CA0022.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::33) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA3PR11MB7581:EE_
X-MS-Office365-Filtering-Correlation-Id: c6b73f59-3eb3-492e-28a0-08db0970744a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4t++u4dlmBBi/bFx5Wuen14HaplNcW+YLgo3b/OVm9ojoGJzy/NSkyLoxr+doVKm4UftkLCoq7jtbnKYpEn4Zl8UHrAAguUne2/BHUX35TZvDywSligJowm26JgrFfKXHtNLMaIgcjnafINlWczYMaBEP0t7udTe47k9yaK7q8tO1z4P4+z6AX6YqqXLOuii4m0MLm+kk0nf7vD+SUoBFBS/Bxn7uE1LRJrNVUMXS2SCk475V8J978Mm7znLrVTyweFMbwBofd8/gL+in42Dj4BKWTLKOFDRgvjtLS6Dl1QwshLr6lGTUN3Kmwfd2tyD9QPl7wvYSFSPWeytHt7wrP5Pi8Gj01YIhsUxeSXVlKQVhMoKOMOFQWZHUNT+3cRbaFixsJHnSnejN1K3DV7QXwZe+3uAMXY2mIoqKba9PX3E16de9fJui7IWQzHtumAksS/wMHrs6QO2FKusCMmjy6IY1r+JKrpDLd53E/XodZWcLNcjJi5Tx5r50VEfJpyhC3ai6CfzsTV7T2gb5Cf0cO2GbT4q9mSberK8Ea+goRpZpTKj4Damtyu9bSPGgl26SZh05V+r8ZEquTljP1+t67NMb9FtOllKc1oBdt1F+pnGTikwBEwXIW57mV0+JxLq68pMUDiym6I3ksP99YzyLg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(136003)(376002)(366004)(396003)(39860400002)(451199018)(8936002)(86362001)(316002)(8676002)(5660300002)(41300700001)(66476007)(82960400001)(38100700002)(66556008)(66946007)(478600001)(6486002)(6506007)(26005)(6512007)(186003)(6666004)(4326008)(2906002)(9686003)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X+fFBAeLWSsizTbJFX0tTO2ESqiDsPxYjT2ZNJTJoYooFhBfvaXIZpv6Flmp?=
 =?us-ascii?Q?FX0b1l2NA38jWwpK4ji4iIQRrkrmZ4iC4XDTT3tLgXsiQ4rAZi6hOqvRhYWZ?=
 =?us-ascii?Q?gtt6MvzRwtx7guUmHg9JEQ+dv1QNrqe+nwVj2MH0PWFEuLGBsVtEIJfM5ajf?=
 =?us-ascii?Q?sPGU9GQg3gE9SafdaZqOWukO0UDguEdepoDZkQrJMZ3tPugwcP89qpBgml/s?=
 =?us-ascii?Q?PL7gVebt/4TDZqN52avFcOT6eldytDzxSvJz7O7TMjScnH44/2ing2VUxeAH?=
 =?us-ascii?Q?p1KD76VVAehuBFvCnk5Smq8Pg+ElujuLxbILgtGZDRSO07oY8ivnJXYhJNIm?=
 =?us-ascii?Q?H/lVS5UIG9ngbrkRffILlw+yfiRWNF0ZDz72xB3Rap5jlrKjN416Lgrn6K8V?=
 =?us-ascii?Q?84eDxKkPSimmjS5vpcYRIceXHUcJvljnQ9zpjgcUOevBSgm5QoMc+gqDy5ex?=
 =?us-ascii?Q?lmYsFp1L0PRN6eNu8jZeEwH1yJFpxtCRYFFlE9bUUVuBTC2AgQaaNaz1ZZNS?=
 =?us-ascii?Q?DRFiMLgLbPyATNzz0jdg7UCgUX2dRsWdRxgPNOcCr+8bM/Vxa39ih5XUXuge?=
 =?us-ascii?Q?gOq6wJsKjTYRNFDFmOwtlpTNrnpJ2DBKM8MqCpTGeDE3rGIJiK3UvD7dbo/z?=
 =?us-ascii?Q?7vTT1OYgmyXT9Y/rRGqB0O99g1PvPYHbnJEvSZffLOXaPxdOrUPo3bTqPtN8?=
 =?us-ascii?Q?kEHzFjFDW3W1StYJQVUPgLJp4tCxtddW+ShuhMt/ZRoXaReoaVc5wBoesaEg?=
 =?us-ascii?Q?vjznYd4Z94ScUN73JqzD6xnLK63khGA7IXPKYi+PFVboT7YEuAwvMHV8wnB4?=
 =?us-ascii?Q?NQ6jyjNKWiZ0471KgbnhH1QpBCSBf6szdzP6VUs8EcXIxCGQdInnjpP3Pn0U?=
 =?us-ascii?Q?RwQMOPmje+TnvUE9SVrJSI7oVwuEW6jD+CUy8MbGqn+70eVSM/lzqvWRV3Zz?=
 =?us-ascii?Q?Zhir5kZcpk8Z0JrJw8bizMB+DMtor7HjGJw8g2SP36rMZumCTz/7HljSi3dr?=
 =?us-ascii?Q?iiVALmRT5aINn1JVjvGw9zG4wEyr9pVi90C0krbE7YwT1u2hRpPOmQ9QAvY+?=
 =?us-ascii?Q?cm0mHTmbKmnYn6ASaQPM4mS644ZYipDOtY+6XUX0c3SHIEFfY8syWBX1i0NH?=
 =?us-ascii?Q?9bYMAdjSrbAFHNsVUohzjkVVBWsUW61XkyPemrAEMBwdLnz+NCy5TR+A3Y7T?=
 =?us-ascii?Q?zLiamzGUYeJ+PVihTEiX9hqC2ZshJDeV7GBvKRFzZg8nfaBfIQanNUiLDV6e?=
 =?us-ascii?Q?FQiCCG7uSAM8adEOPhJilOLQxkVKrBGHde8xtaYt9W8PVBXs0cYZYgSmymtp?=
 =?us-ascii?Q?V7/1OqGGudGMYXoM4R692If9y6Ppsx9NtznMaVc+2cVnXubuLbPIx5UrAd83?=
 =?us-ascii?Q?sjUYM8k/8F6QCpwEv/edWJ6FCJaLVwukJIMZCHVwrGVWQ3YzPfPtz+jqY0M4?=
 =?us-ascii?Q?Ze4UDGP6Qv3p6cCXLU19I51YNZa9FOIUfQqyPs70aCyi/DBteXMPiw67AdnM?=
 =?us-ascii?Q?UFe5rYvdFk6Clq+Cy1RSLGZLmlzKFC3RW3ZgBKrDjAuRNMu+hCiCKJ1OTYGc?=
 =?us-ascii?Q?164FTb6kCwvvuKYzuNRtw68sAFFd8V3W0NtZWpCfd1CiyaEVEEPC74nnRYl+?=
 =?us-ascii?Q?Cg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c6b73f59-3eb3-492e-28a0-08db0970744a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2023 01:04:39.6624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qwcpifN75ocDe0AT+xB7nBwtWB/X5G0/dxyuEkNLzy6WRn9zud+gTq/MvIFGBhEHbA4eKo4l2emF0ugOd1hUK1SI7RAmaXapWZ13Hh/WDIk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7581
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Dave Jiang wrote:
> For the case where DVSEC range register(s) are active and HDM decoders are
> not committed, use RR to provide emulation. A first pass is done to note
> whether any decoders are committed. If there are no committed endpoint
> decoders, then DVSEC ranges will be used for emulation.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/hdm.c |   37 ++++++++++++++++++++++++++++++-------
>  drivers/cxl/cxl.h      |    1 +
>  2 files changed, 31 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index cbec955db4c9..32728f63084a 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -730,6 +730,31 @@ static int cxl_setup_hdm_decoder_from_dvsec(struct cxl_port *port,
>  	return 0;
>  }
>  
> +static bool should_emulate_decoders(struct cxl_hdm *cxlhdm)
> +{
> +	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
> +	u32 ctrl;
> +	int i;
> +
> +	if (!is_cxl_endpoint(cxlhdm->port))
> +		return false;
> +
> +	if (!hdm)
> +		return true;
> +
> +	/*
> +	 * If any decoders are committed already, there should not be any
> +	 * emulated DVSEC decoders.
> +	 */
> +	for (i = 0; i < cxlhdm->decoder_count; i++) {
> +		ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(i));
> +		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl))
> +			return false;
> +	}
> +
> +	return true;
> +}
> +
>  static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  			    int *target_map, void __iomem *hdm, int which,
>  			    u64 *dpa_base, struct cxl_endpoint_dvsec_info *info)
> @@ -745,16 +770,12 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  		unsigned char target_id[8];
>  	} target_list;
>  
> +	if (info->emulate_decoders)
> +		return cxl_setup_hdm_decoder_from_dvsec(port, cxld, which, info);
> +

This has a code smell of letting program logic leak into a data
structure. I think ->emulate_decoders can be killed in favor of
something like:

if (should_emulate_decoders(port))
	return cxl_setup_hdm_decoder_from_dvsec(port, cxld, which, info);

...and do "cxlhdm = dev_get_drvdata(&port->dev)" inside
should_emulate_decoders().


>  	if (is_endpoint_decoder(&cxld->dev))
>  		cxled = to_cxl_endpoint_decoder(&cxld->dev);
>  
> -	if (!hdm) {
> -		if (!cxled)
> -			return -EINVAL;
> -
> -		return cxl_setup_hdm_decoder_from_dvsec(port, cxld, which, info);
> -	}
> -

Doh, just delete the previous patch from the series at this point since
all that code is gone now.
