Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C67EC4332F
	for <linux-cxl@archiver.kernel.org>; Sun,  4 Dec 2022 01:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiLDBOQ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 3 Dec 2022 20:14:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiLDBOP (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sat, 3 Dec 2022 20:14:15 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A841C128
        for <linux-cxl@vger.kernel.org>; Sat,  3 Dec 2022 17:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670116452; x=1701652452;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=bpGBv2vNKumiIRnqWEThgc4BBSC4ulLYONNal1tVwRY=;
  b=F8Kd54uHFC3q3wrM1727U2BS4Zp0P8h+tvEWdFle0Hl+iOZwSm4N7Io9
   7UUNyPvjf6+tStPM+u0umGXW7F73davXnEWLKEH2ZKbPiLSVfieBHs5fA
   CBrp4luothUOoySDNdJAaumhqrilYmix6sKJ2JUdr+ZlNm0kaL7Duz332
   r4chD96IMEG+OWeUHTs92t3dXRZMYnP0GlQzDrl5F/gVk4MmlY8+wvx/n
   pzdYJY5vCXQlqg5fMhgtRSqZNe3QEfnQ1+9HrXjYYfMuIBFYODRqlxrPA
   uvTdlMQhspHipfFL84thtBKHifsoY86SDxzNhsrjbuyLaCwsjNf0Xfwtt
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10550"; a="402433359"
X-IronPort-AV: E=Sophos;i="5.96,216,1665471600"; 
   d="scan'208";a="402433359"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2022 17:14:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10550"; a="890552553"
X-IronPort-AV: E=Sophos;i="5.96,216,1665471600"; 
   d="scan'208";a="890552553"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 03 Dec 2022 17:14:12 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sat, 3 Dec 2022 17:14:11 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sat, 3 Dec 2022 17:14:11 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sat, 3 Dec 2022 17:14:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fTDl9SL5W0zaYUQUzN9pI328Id4AbZmgNFAVi8SXMWb/GSGsgbt+iTJ34yASB4Tpvei/muZrN26A7QkzM+nV21vi5UzrgIAmaPPMp2l7GG0Zh7wo9esyCU5Z9lWZE0EHI9dduz7ZHf6hXUKd7V+F3qMkBt/LCSAr5dG5NbLyvgybCsjMO4aQib5/N/SuY2UkB2YghizT9+UWZc54t8gk+CZvWnODxwu7b2ogKqWiCHfdYWSAAIniYpSK1YvCVqRyIKW+/BQ8Qiptf+/mCj1JSaeVLZVdm/cZOELR/f11Ri4fZtz85c+sizPcgRT8lkdp0wAECDZj+oJwT312Uakz7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0hlGvPa7NSbhmT7axp7vB1wW8x9edMfrnNG5sf4wOgw=;
 b=h9bAa06YVKZ+VaIaf4Oj0MSNZid39jK0x9YPol7VLlkfXmN3YueLaE6lOr92xWlmPkgEcuApqEA6RoswdBka/YU2ilu4Lhyij+sBykZm6qzEZPOlSmTy04eQJSkdh3HvCfsNvV+BQAR2I/MjK9/yBT/iKqVl6k+pkdeOZgk+00gAkBzE7/1O+ihQbiOSnI8Ie1Y0xv0bQVVV8m8V2gAIxaN5YCMUMdX/ZHXni+mhimEGShcLR4M+kY9462Q6OVgvN3wCOMowfryaRWA+Fn7nJTl+JV4saT7Cqpsb60PdOPKlxFQLFc54NgnCxGELVCtXo8lbMSY1YCYsMENhxrS67g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BL1PR11MB5384.namprd11.prod.outlook.com
 (2603:10b6:208:311::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Sun, 4 Dec
 2022 01:14:09 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b%9]) with mapi id 15.20.5880.013; Sun, 4 Dec 2022
 01:14:09 +0000
Date:   Sat, 3 Dec 2022 17:14:03 -0800
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
Message-ID: <638bf45b7ca77_1eca8229474@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1669847017.git.alison.schofield@intel.com>
 <5794813acdf7b67cfba3609c6aaff46932fa38d0.1669847017.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5794813acdf7b67cfba3609c6aaff46932fa38d0.1669847017.git.alison.schofield@intel.com>
X-ClientProxiedBy: SJ0PR03CA0290.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::25) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|BL1PR11MB5384:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a3b9a9e-32fb-470c-3f1c-08dad594d888
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fVXwsZUMpYU8dymkfJONOjxlyOFLu3Kt2AQatQWrMJUYdGEMV33HO06gH9lFTdFw4x8is432ov752sU6V3VoExcTkTR3C+XgEqjQlINI5oSarCn1YIUrjCuLAhzsMucvfK7TV5aI9Zja5no/4xqDtQTqjOTY5fn6cY+L14JPSk/7/WJ3jaVfSTxKt/COUdfYZOC5me2JGKSZDR53h6B4KN5PdDXgCuNque177XtvhxaeU7omZzBwxTjSRVzGkwk33ytDhG8EcqCesXav3hg3x6JZA0gs0TKhMJJ176/8280/P2PKt4s3vfNW45pZ1N8Xo94lSskzDuVAH7aENkfpakeoKtZe5fW2R/y0Q/XTdOae4gUfSI9hBCPed9m4AMILozXZb6mBrlFFYNE8Q3GLVuG3KIjjn8r6B6R+dhfB/2x2U7a9VnjBum+KU3p2+pgp8I55kQy5djX54OT6mZc3VMnpI7ILzWYSZj/4lDh1svoJnoYEFFGn6+nQ2eLELOZtaIOItRNV6+ymIEK5RmbRcvbSbaI4g4m/fDCepWo80pguhmP/NJo8cBHPpcewXR1x4LWFayDo/fu8q5AlJsaSP5NYBLwQbgrxRT/vieGcaMT/ecljaId+s3w0ocJGgVZosHqztzYUUFWYE77M80HamA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(346002)(396003)(376002)(39860400002)(451199015)(5660300002)(66476007)(4326008)(66556008)(41300700001)(8936002)(6636002)(110136005)(8676002)(6486002)(54906003)(316002)(2906002)(478600001)(83380400001)(9686003)(6506007)(66946007)(6512007)(86362001)(186003)(26005)(6666004)(82960400001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nSGZkY7S3extibfC97FByPrt/RbRNExGr8HjBlXHhKCtowLVK9T888+Pc8an?=
 =?us-ascii?Q?IoOmE1nRbjUUE7s1aTu/PEpGGNikaWeNGbl0LWyez45XqbkQFvBYVMioZ9jA?=
 =?us-ascii?Q?k7PSWRmEM48GBXqsEzmizFIUXJj/McxmQ2fVgoPbv0mA7lhDfGE3lTRyAanp?=
 =?us-ascii?Q?a5usGXkv6RM7ZSXDzBy1MTmKCwDkw2jY6UUlwxlPVbFLXwEDoC6izHCskAQd?=
 =?us-ascii?Q?U1YLrVcihF8zCyniW+fGHdlN0itTDLiDIbbiUfXQPJcNb4won52vp3uxjmw8?=
 =?us-ascii?Q?azoeKWomkInE3l3lVuEUy9y4duarAWSAE9vf4L4STYo9ka/jeMVa5suzUbsI?=
 =?us-ascii?Q?9K8Z7wPQzRbGGUomjWYWCLcbXVoifCexQl77ICQJdFYcPb/cVynYlNE8DRGp?=
 =?us-ascii?Q?GhUM9qcaXKhTgatPjh4CNeo+UcU9Upyb5AfwuU5lYF2Cn9nZLqTJUnti5nag?=
 =?us-ascii?Q?OsB542qzBz/ve8TF2U1bS1ElGBJl5vAa4GM38o8U2CY4JRSbLRy5bsTxObOI?=
 =?us-ascii?Q?Bi/oFHqVDzX9FYGt92frqfE8cqaNaAcJllc5R3uGMGdvvJyi+2UeLjZpGBhK?=
 =?us-ascii?Q?rW5zxboZfuU65hVdeA+j1ln3UmsM6B4gnD62WsdRJuGW5RP1MGWngVa//0XC?=
 =?us-ascii?Q?Qggmnfqz6YwLcxqhcdADhoQ9Km7pHj/nj2pRqwQtd2jfmYeVopdMt1vqEAFk?=
 =?us-ascii?Q?7p4U4dnYkNkkLVwtMhmL3yzLvhGmak5/ffyZoznUsO9geeuuD1X4PCqCizxF?=
 =?us-ascii?Q?toQqzDcK7OeNy3+XQpFHMhhJnVdBiHTpALIZzhjrylHYPzdIQrM0zAjBjcbb?=
 =?us-ascii?Q?xmz37yWoC/dhfrC6gMQa6FODsiAyq5/tUStRCrzMs2jZ4W/so+0yxKUgSWw7?=
 =?us-ascii?Q?tiL1SHMaJjVTp9GMp5iiKMCrwss0JUgECTUd7QnOM3rhTJzGGZAUJbmMAW7a?=
 =?us-ascii?Q?m1zDqqPoyq1MlIT1z3GGA4cn++2ND03bQSN/ke2oIwoYpihOnR1NsQ1JEpi7?=
 =?us-ascii?Q?u3fs8aSXMKyr/xgrrsKi0OwxhEeqZoJyKq9TJswNwvqrCEShrygF7bOkrQrR?=
 =?us-ascii?Q?fw3CyMEzKwXneHHrnJ4Ac2JQ3haLW3fERj67hK3C4/K29FX38dV0iQphUBow?=
 =?us-ascii?Q?72WT3sP1hZRW5w13VGaHyn6PyOY6vQ0jdaMmpZwFFZc2G/6mX+iEs/WVxqRV?=
 =?us-ascii?Q?pMUCZumkutmLLCRfHKQDUNSA3lCu3bGMlwNWEGIwMuCOrKw60dXmb71a3dcw?=
 =?us-ascii?Q?GNxsY51FyrVWdF3jJMdsCpY10CoNx4JT7lYgeg/IqVZEdnXYScqmr5VDS57s?=
 =?us-ascii?Q?uWQTHP+Qw2WL7+e4HWtH8YJQqFfRGO3S412Lj5ps4eHOCeYLIy4tYgItMqIM?=
 =?us-ascii?Q?aXfZLs5oco/+lQw1gLD4oMN/8aW840eF9Y/L4+Ir4ILvuv5zQU2Jl7TlQTWZ?=
 =?us-ascii?Q?2Q0O2N97dItqyf/k9YWRdrzyNZBRbodcdP9CxQhE+pO4kPT9Pb00+PpE/1kX?=
 =?us-ascii?Q?7P9Q4jmeFk8CJHSNEgwV40iRxd6AZEGs56IiInwPbpuZ/+xzfJGdYZQ/TBp9?=
 =?us-ascii?Q?HNjYtV+e0igxz7yysHXh6fYZwuw/lxXd4ukUjH1qOHo7WBC6LX2hoOgs4Kr8?=
 =?us-ascii?Q?QA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a3b9a9e-32fb-470c-3f1c-08dad594d888
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2022 01:14:09.2436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RgXpp9XZL1BV+9Ken9E993UZbPrkftDV90ACTzDrjYG5N1Mu5s87dpSjfao/uvxqFj65tvdi4pZS0sPrs34VcPoG2loz+9JdDCs3hry4hFw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5384
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
[..]
> @@ -148,7 +265,20 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
>  		ig = CXL_DECODER_MIN_GRANULARITY;
>  	cxld->interleave_granularity = ig;
>  
> +	if (cfmws->interleave_arithmetic == ACPI_CEDT_CFMWS_ARITHMETIC_XOR) {
> +		if (ways != 1 && ways != 3) {
> +			cxims_ctx = (struct cxl_cxims_context) {
> +				.dev = dev,
> +				.cxlrd = cxlrd,
> +			};
> +			rc = acpi_table_parse_cedt(ACPI_CEDT_TYPE_CXIMS,
> +						   cxl_parse_cxims, &cxims_ctx);
> +			if (rc < 0)
> +				goto err_xormap;

Spotted one question, what about the case there the Window is XOR
arithmetic, but a lookup in the CXIMS comes up empty for the given
granularity? That's certainly a BIOS bug, but BIOSen have been known to
do worse. It would be nice to defend against that potential case with a
follow on fixup, unless I missed it?
