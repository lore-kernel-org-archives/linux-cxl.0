Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DAFDC4332F
	for <linux-cxl@archiver.kernel.org>; Sun,  4 Dec 2022 01:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiLDBIw (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 3 Dec 2022 20:08:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiLDBIu (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sat, 3 Dec 2022 20:08:50 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C29F1D31E
        for <linux-cxl@vger.kernel.org>; Sat,  3 Dec 2022 17:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670116129; x=1701652129;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=eiPzWJ9OzZWfJBOLcf8tK9g/OK0o4Vu/Aze8p6orBjg=;
  b=BnDsTypnWeLX01WcmXrRBuHZF9sPNFPeddceJdij7QBVKmf3DJmXaBHY
   dknGu/hAElXsCq+vMDVIerFz9YKpgt3vPA6dBzcGGIsZw66FXPkngH5fh
   l19DvT5PbXPT21f5JHqlyCJ3TolAB+xOe+lQ99dugWpAefaQIsF1+DVTg
   eHUoF3QC/bZhG0IDzdRrPKD3TC0ghwZDk5ol0lIKeZwOzURhztkwQHjQS
   YxYhNNkjjHC06P5zG22vkECSBz3xeuwesLsiinF3Vioy1DvALzKz39FnM
   5I2a/RhChVvOXVd8PG9mkCGoiMqyVjmfCExZIPgvHjVwtY61pFQZ0DrUR
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10550"; a="296513757"
X-IronPort-AV: E=Sophos;i="5.96,216,1665471600"; 
   d="scan'208";a="296513757"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2022 17:08:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10550"; a="647555924"
X-IronPort-AV: E=Sophos;i="5.96,216,1665471600"; 
   d="scan'208";a="647555924"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP; 03 Dec 2022 17:08:49 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sat, 3 Dec 2022 17:08:48 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sat, 3 Dec 2022 17:08:48 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.43) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sat, 3 Dec 2022 17:08:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d4XBQ6xKXflYcGX/op36aQVVNAGR6WwG/otEzwXzXgKB/vSARdHLXuz/29nha/LIQE+dDTOPVkmAmuzSPoSAbWB+Mhz9l+FEIF05MlEAIsJuauibXfKcMJCH61vRdM2uLVoqlsYcKnvrtIo0ZGJpynV0R8C1t1r3/u4rzAUxNux/b7JkbKoi0CHDc6LuXQPRUayIN1Wvo9DjeJ++v49upV2PWmkP/H185p1kZn4ej+luU1GX2d00DbAbKUKa1jDKsZQ0/4EnzWj8jWRTcVra1VaPDBomR3uowTq98gbOkieeTns2iub/pTpTd0NpdMOkSGuza0gO3xJyWxzOAYU3/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v/qo8FHJkbqVBP5SuVPWG8+Q4uMp+jEcrR//2w1Vmf0=;
 b=DJd94UPP1S02AncMwhOYt3zaC/cp4h9amwRdjgGt2ax0b/oeSUoML1L/HYf9heuyunhu0ne7bNBFHDPtupgkGkA63qWrTy93uF7S1dkemS27jvI0Ds9AIhZgYb/H9AEAyhTPWXVa1Fe4bje6yaN/Uctfzh3wa73Y6+N0wglirkw0k3bkKvv/3bmMhnmE+EYjMWHGcU4lzpDoqOTjDMBTUAlYlTywb0Poja5hqtnslSoFozR2QZ8BAaoJIA3lv8lszqqlXNPUR8ZeGTXtOFQfFpssQQvWNAO7yd6H+3fbbKv2K2c5StN2bs5dPm/9UNfW+gGF34Wn5VkuflWEEH1yMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SJ2PR11MB7645.namprd11.prod.outlook.com
 (2603:10b6:a03:4c3::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Sun, 4 Dec
 2022 01:08:41 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b%9]) with mapi id 15.20.5880.013; Sun, 4 Dec 2022
 01:08:41 +0000
Date:   Sat, 3 Dec 2022 17:08:36 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
CC:     Alison Schofield <alison.schofield@intel.com>,
        <linux-cxl@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: RE: [PATCH v9 2/3] cxl/acpi: Support CXL XOR Interleave Math (CXIMS)
Message-ID: <638bf31410166_1eca82294b7@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1669847017.git.alison.schofield@intel.com>
 <5794813acdf7b67cfba3609c6aaff46932fa38d0.1669847017.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5794813acdf7b67cfba3609c6aaff46932fa38d0.1669847017.git.alison.schofield@intel.com>
X-ClientProxiedBy: BY5PR17CA0070.namprd17.prod.outlook.com
 (2603:10b6:a03:167::47) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|SJ2PR11MB7645:EE_
X-MS-Office365-Filtering-Correlation-Id: 5abe860a-16ec-4669-ec05-08dad59413d8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n6DeB+xlz3NHWRUypaTkUPOUwCX0VokPnOCUJz+jvYu24dTn5EfxjpkEpegmFCUOpdD1xdN/nAhIz5fehWssFs/hELCTZ6RgRuLPGrvDcl/Vjk5nUFfNqUiBr7jCpdklMk5LVBy9nOSL9UrpHDx9O60bwIh3+O9jHpd5vD14W9PAPriONZIadu2Ygp35glRJerBKFYBDoR5gTprJ8rRbo4WM6rdM1+JIcxY5OBPH5dXMnrGf6wpFQrPgMwYWD3v+BDnbythQjZvB5gGm4+SM20e0Qh0XZ5IIrt1Xgp9VxTLpq8mhjW4Q5F+mKKjqJdzriJX0qYglUNQBRg7MS8QuGy0ZNVPsduJbJJa3YWPRhqSL6rL2SKeXPtFigt9zytThGUQdLG7rI4ajbnfVMpeE0ddEQeCH7cG41N0fS4Ef1/VxQEEI9weBANoVxozr9y87iSxD/1Z/ZrYA0BZHYJ4gIFHtKEeKogC9EcKifn7baggjc/E3o0PMeA48evZAmH7TDIg2rlPuqwctN1+zORhdzNHOCnlZwe0gEPxAxzy6gwEXdoZ21FD0TwXfQ1z+uJO6Kpz3BReLaww7rvZk1ERB1Uh8ViTmU1KJ1oYfHXXsQtLiTXGcJqG0j35YYC21VUVP0CDKzUACsJevfhv/8ghh+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(366004)(39860400002)(396003)(136003)(451199015)(2906002)(83380400001)(186003)(41300700001)(8936002)(86362001)(54906003)(82960400001)(38100700002)(9686003)(6512007)(110136005)(8676002)(26005)(5660300002)(4326008)(66946007)(6636002)(66476007)(66556008)(6666004)(478600001)(6506007)(6486002)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1LwIQldjg6YNfpHp1/OqJ/ulgvVZY7Ue/olAWRm4xSTKXDyMr84ewgOSGZbq?=
 =?us-ascii?Q?cIUuaZyXPfaa5NbwrgfmU9llahVG2Nbas8GjxL9LG92ngqfzK7E3iozsS+1k?=
 =?us-ascii?Q?T38CCpvoc9qPos+u9x4WGeKpQnDTEBW1QllwGZBnqm89GzStZkGdBQ6unE8e?=
 =?us-ascii?Q?7klyNiv8VK0VTVeR0PDvBdmfRdXOznXq5X66XMiMqOOErZfItOYi12N+hxpA?=
 =?us-ascii?Q?j/CNuQkcQJ242gz5mzKcfb7YYXb+TjQ9isIszGw5F1KfOHzP5vnvPql385J4?=
 =?us-ascii?Q?XUKVjmCCnwGMUaBKinP7UN052476U7zAcuegk5pNApCFp8CNN9L/v1JxCpwL?=
 =?us-ascii?Q?Jw2Q2EGquPVZopYtpXztMSW1dfVoVWnZBmuCfvqD9sZt4SbT3I89oyruKyly?=
 =?us-ascii?Q?psQl1YaOoIMvwqeVW0gDCGY/1jNm3EJdD98oETqS4ClPbHkIclsIdFIAEqHl?=
 =?us-ascii?Q?fbOPQ58lW45kCM0psWTm0m1+m5DfD9y3t+nQ+XLtuB5AubHw7u+VqnQSRynV?=
 =?us-ascii?Q?2iW2AMOp35BED9lgWkkm7zK4ORvEkNiJQrken/imJJQi1woHOtVQ5Azaa9te?=
 =?us-ascii?Q?NBikKt2sME5sWCylW1wvM1ZcdmSyN36bEZJymsrV4wJhXPghDUdnV+v8jRXt?=
 =?us-ascii?Q?d4Nwr3eRigv326EDt8I/xPBtbiEC+5E837m4Hon/jGi8gLKulkIceBxGYHIQ?=
 =?us-ascii?Q?Eslz5ZpVmbiA0ymP6dM70pLCYjza4itEqxf/VVMjN/5pRBb7K89MUSN1lA2o?=
 =?us-ascii?Q?p5e/Uo9k919jUW/nqNio7CtcNZ9cdUXcdzahqX5PZBMUJmkRwzvBGAjTkl7L?=
 =?us-ascii?Q?27Vo8BVcd1cPfrc9xFsz5eZ2XCZF1U+VNvGXMKUIj5ILGn0DGiLi5d/qHdXO?=
 =?us-ascii?Q?63rQoRmIsE+TZ/A9hYJlFxg+DfANjnLCulF2t1SSaXVOaeq8D8SLPj+jU3CE?=
 =?us-ascii?Q?eSk9/Ze9PoZwa8S3Rj7xjj5N2TFe6Z+Ij4Nw5VCwFNPvLImvtf/bMCpGYM7B?=
 =?us-ascii?Q?oGLh9d80yPQ/32HAmMhpx3S6mDEHV5+bSQ/wwCEpE23yBf6OaGRlayc9EkQg?=
 =?us-ascii?Q?pQ1MuWS+CxIEGCpNZHwvIHm5asi2+AWMMfLTHq/EYn6dy1Pm5DmNxtmYKy3h?=
 =?us-ascii?Q?Spqn9pVyXr61Z+faIXfk+GldXdbeU2RGIsawYKyW0q5TiZW1gOhuSQiLdXNM?=
 =?us-ascii?Q?zDlcpaWK5xuU7k0Nb+VDOaQASYeAA/LVsQ/wSr+XV+FfcnyTMbd/rS63hfyl?=
 =?us-ascii?Q?u2JLKD+7cKVzptD458/7/ygZhwI9qU8f0y4LfGC5MQPs5UHRq5uNxNVaJC9u?=
 =?us-ascii?Q?14GRkzzUVt+qFRgbyebeA6vc3TEdid0JJHJ2I6R1PGb9bgQ/bL8dphJFHZq2?=
 =?us-ascii?Q?rIm+jWeWCZRRpSGBf4RdNq51SYpt93V1AwjCZNj6SaOh3dYT2w5umfssKvbI?=
 =?us-ascii?Q?OKCB56lSCsaRHKEoWQDIdNtTLq3p4C91qQMNfyz7luoFzeO+VcxIi7AM5zUE?=
 =?us-ascii?Q?sXyrT98eIBJMkxAo3FQJZBwnu4rr1K92rBzyyIWqygNq9fdFObDTK3Qwtjb+?=
 =?us-ascii?Q?PA+scnEnSw7vt/BbXnYNOUAuL1a7BGf9ccNhWooIfq+QRnJ4cuip5BXbXMeL?=
 =?us-ascii?Q?Cg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5abe860a-16ec-4669-ec05-08dad59413d8
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2022 01:08:40.7142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CTGUc9VKBYyoUMq7BxFTcToWlXxMxEVXmYUZcgwbiEbMVNgrqXeNRS+ax6o119OA32G9iHteGt7TfrM7s/uLNBTSR+3DtdXkK13heYCNQNo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7645
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> When the CFMWS is using XOR math, parse the corresponding
> CXIMS structure and store the xormaps in the root decoder
> structure. Use the xormaps in a new lookup, cxl_hb_xor(),
> to find a targets entry in the host bridge interleave
> target list.
> 
> Defined in CXL Specfication 3.0 Section: 9.17.1
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/cxl/acpi.c      | 136 +++++++++++++++++++++++++++++++++++++++-
>  drivers/cxl/core/port.c |   9 ++-
>  drivers/cxl/cxl.h       |  11 +++-
>  3 files changed, 148 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index fb649683dd3a..8eee0aa49a77 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -6,9 +6,117 @@
>  #include <linux/kernel.h>
>  #include <linux/acpi.h>
>  #include <linux/pci.h>
> +#include <asm/div64.h>
>  #include "cxlpci.h"
>  #include "cxl.h"
>  
> +struct cxl_cxims_data {
> +	int nr_maps;
> +	u64 xormaps[];
> +};
> +
> +/*
> + * Find a targets entry (n) in the host bridge interleave list.
> + * CXL Specfication 3.0 Table 9-22
> + */
> +static int cxl_xor_calc_n(u64 hpa, struct cxl_cxims_data *cximsd, int iw,
> +			  int ig)
> +{
> +	int i = 0, n = 0;
> +	u8 eiw;
> +
> +	/* IW: 2,4,6,8,12,16 begin building 'n' using xormaps */
> +	if (iw != 3) {
> +		for (i = 0; i < cximsd->nr_maps; i++)
> +			n |= (hweight64(hpa & cximsd->xormaps[i]) & 1) << i;
> +	}
> +	/* IW: 3,6,12 add a modulo calculation to 'n' */
> +	if (!is_power_of_2(iw)) {
> +		if (ways_to_cxl(iw, &eiw))
> +			return -1;
> +		hpa &= GENMASK_ULL(51, eiw + ig);
> +		n |= do_div(hpa, 3) << i;
> +	}
> +	return n;
> +}
> +
> +static struct cxl_dport *cxl_hb_xor(struct cxl_root_decoder *cxlrd, int pos)
> +{
> +	struct cxl_cxims_data *cximsd = cxlrd->platform_data;
> +	struct cxl_switch_decoder *cxlsd = &cxlrd->cxlsd;
> +	struct cxl_decoder *cxld = &cxlsd->cxld;
> +	int ig = cxld->interleave_granularity;
> +	int iw = cxld->interleave_ways;
> +	int n = 0;
> +	u64 hpa;
> +
> +	if (dev_WARN_ONCE(&cxld->dev,
> +			  cxld->interleave_ways != cxlsd->nr_targets,
> +			  "misconfigured root decoder\n"))
> +		return NULL;
> +
> +	hpa = cxlrd->res->start + pos * ig;
> +
> +	/* Entry (n) is 0 for no interleave (iw == 1) */
> +	if (iw != 1)
> +		n = cxl_xor_calc_n(hpa, cximsd, iw, ig);
> +
> +	if (n < 0)
> +		return NULL;
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
> +	struct cxl_cxims_data *cximsd;
> +	unsigned int hbig, nr_maps;
> +	int rc;
> +
> +	rc = cxl_to_granularity(cxims->hbig, &hbig);
> +	if (rc)
> +		return rc;
> +
> +	if (hbig == cxld->interleave_granularity) {

In cases like this with a big indented block followed by a return I
prefer to just do an early return, and undo the indentation.

I'll fold in the following to relieve some 80 column pressure:

@@ -88,32 +88,33 @@ static int cxl_parse_cxims(union acpi_subtable_headers *header, void *arg,
        if (rc)
                return rc;
 
-       if (hbig == cxld->interleave_granularity) {
-               /* IW 1,3 do not use xormaps and skip this parsing entirely */
-
-               if (is_power_of_2(cxld->interleave_ways))
-                       /* 2, 4, 8, 16 way */
-                       nr_maps = ilog2(cxld->interleave_ways);
-               else
-                       /* 6, 12 way */
-                       nr_maps = ilog2(cxld->interleave_ways / 3);
-
-               if (cxims->nr_xormaps < nr_maps) {
-                       dev_dbg(dev, "CXIMS nr_xormaps[%d] expected[%d]\n",
-                               cxims->nr_xormaps, nr_maps);
-                       return -ENXIO;
-               }
+       /* Does this CXIMS entry apply to the given CXL Window? */
+       if (hbig != cxld->interleave_granularity)
+               return 0;
 
-               cximsd = devm_kzalloc(dev,
-                                     struct_size(cximsd, xormaps, nr_maps),
-                                     GFP_KERNEL);
-               if (!cximsd)
-                       return -ENOMEM;
-               memcpy(cximsd->xormaps, cxims->xormap_list,
-                      nr_maps * sizeof(*cximsd->xormaps));
-               cximsd->nr_maps = nr_maps;
-               cxlrd->platform_data = cximsd;
+       /* IW 1,3 do not use xormaps and skip this parsing entirely */
+       if (is_power_of_2(cxld->interleave_ways))
+               /* 2, 4, 8, 16 way */
+               nr_maps = ilog2(cxld->interleave_ways);
+       else
+               /* 6, 12 way */
+               nr_maps = ilog2(cxld->interleave_ways / 3);
+
+       if (cxims->nr_xormaps < nr_maps) {
+               dev_dbg(dev, "CXIMS nr_xormaps[%d] expected[%d]\n",
+                       cxims->nr_xormaps, nr_maps);
+               return -ENXIO;
        }
+
+       cximsd = devm_kzalloc(dev, struct_size(cximsd, xormaps, nr_maps),
+                             GFP_KERNEL);
+       if (!cximsd)
+               return -ENOMEM;
+       memcpy(cximsd->xormaps, cxims->xormap_list,
+              nr_maps * sizeof(*cximsd->xormaps));
+       cximsd->nr_maps = nr_maps;
+       cxlrd->platform_data = cximsd;
+
        return 0;
 }


Other than that this looks good to me.
