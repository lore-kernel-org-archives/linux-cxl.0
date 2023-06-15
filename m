Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD325EB64D9
	for <linux-cxl@archiver.kernel.org>; Thu, 15 Jun 2023 18:57:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjFOS5c (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 15 Jun 2023 14:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjFOS5b (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 15 Jun 2023 14:57:31 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD83E1FF5
        for <linux-cxl@vger.kernel.org>; Thu, 15 Jun 2023 11:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686855449; x=1718391449;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Z6uyxSGK1lJin/C+K9rbQ+m5gSuFPkvH0NS9fUSwpCs=;
  b=RIt41uppbailapSMWSnzHitfT5nkSYvliUYN5ZdqDtNQKNVEqrW4PR1/
   xULDHOxh1TJrXHoJqRDWm6CSqK3RuDsj9RHEVeHqN3GyHSrX4Wq0klEbW
   rlyDmcFfxRm9jpxD8aE0RMA7HCtjVj0PleHyFwrtUwz4hhHD4fI7jYBI6
   sNUJ8iXNmrLPAzn5EJ6NKlguQm9zPokgpW2PGKywRUsHUEua6hbYWiHVP
   z8qk2JeiPY2u+TYuQMlDMIT1hPO4tdm8SrjyqhRc7TB62wCQWQA/VmYIR
   WWF3v+CmplzYt1+nreYOItq4FKCXf+nLNyOw9ErNtBhY5G1p93MHCm+5b
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="445388486"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="445388486"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 11:56:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="777858065"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="777858065"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga008.fm.intel.com with ESMTP; 15 Jun 2023 11:56:52 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 11:56:51 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 11:56:51 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 15 Jun 2023 11:56:51 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 15 Jun 2023 11:56:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DIaIaIPIejeq1Yh0+JW6hqDg6SDAPMurd390FzFN2P60dOAOaD11vn7eqABxRdtdhN2VX6nfqaIX5ekguuQKfmqc8EnX2ucEalhOice7RJTj8sB9Nl1PG/WuOrbbas9q/Hmf1j1Waxx2rTy6p5VppbEheBd8cr7gg+1VdyywelHgcx0bs6c+HZ3vVC8feb90r+mW2faVzHDkAMRe9vKDxwg7bE7I/e3QdAKVlnf3gaYP4m5TFurqtaAj4oN/HqmCLW5jn6oLqw2PurhgxMU0i5OWH2BrxR3pHzUtwkyU7Cx1Rs/tOoA3bCGIOWEJuv0HGxqR9vN1n5+HiJ71+1MVsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mDf8tAvrPrEjRiUARKxPzCdUpBnE6oDMM00/tnQeEEM=;
 b=WZzO+eX4StxI4eaNsMQeWEwN82bRJb97Vl9oXyRd1lqkrA18pmWf+oIz4YCAqamGZDhEGRtqazAucuk0R0nckCnbs327vc7Ty/edTkGLPVmlY8aUgqXDlqF6/je4XvlWai2foWQSgX807yZSEr10+u3RRlVKhJZDjZ29OJVJ9t3EeCM3ko2HOi2mNf3s7eXUACzz7TvVTnPhpF0oaiC/z8Oq5DfrChJfqXr/5Ay4l459eA2XwzVWmKpLBFkmIdrOkc8dIVJWBFjFoNC0TE9Gu5h72847P+U6l/mvmwtmTHtFL34XWBbZebeySh4rL52MvZaju+UNWq9zjA9/qCELGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN9PR11MB5322.namprd11.prod.outlook.com (2603:10b6:408:137::18)
 by SJ0PR11MB5917.namprd11.prod.outlook.com (2603:10b6:a03:42b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.38; Thu, 15 Jun
 2023 18:56:47 +0000
Received: from BN9PR11MB5322.namprd11.prod.outlook.com
 ([fe80::497b:51a8:9880:7eeb]) by BN9PR11MB5322.namprd11.prod.outlook.com
 ([fe80::497b:51a8:9880:7eeb%7]) with mapi id 15.20.6500.026; Thu, 15 Jun 2023
 18:56:47 +0000
Date:   Thu, 15 Jun 2023 14:56:33 -0400
From:   Navneet Singh <navneet.singh@intel.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>,
        "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/5] cxl/region: Add dynamic capacity cxl region support.
Message-ID: <ZIte4QozSm+n2zI3@fedora>
References: <20230604-dcd-type2-upstream-v1-0-71b6341bae54@intel.com>
 <20230604-dcd-type2-upstream-v1-2-71b6341bae54@intel.com>
 <f6cd4851-b024-c8fa-8f6e-fcc27843f120@intel.com>
 <648b548db05f5_1c7ab42944a@iweiny-mobl.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <648b548db05f5_1c7ab42944a@iweiny-mobl.notmuch>
X-ClientProxiedBy: SI2PR02CA0048.apcprd02.prod.outlook.com
 (2603:1096:4:196::23) To BN9PR11MB5322.namprd11.prod.outlook.com
 (2603:10b6:408:137::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR11MB5322:EE_|SJ0PR11MB5917:EE_
X-MS-Office365-Filtering-Correlation-Id: 673f9516-cd41-421c-da9e-08db6dd244b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: El2QezW7kHZFjdQCfXQ9tlSUMTvKBqkZ6KEdVkXzAZZNN7WwhuZMzEm3iILDJPsKn7V8r+RUfK2zsF+hN2Ii9N53cCfzFBV0Lrc4TPhCI2uAammu6cfHTJWELksX+6x/AVwqjMUi+btr8g6DdAoB9awElzhwIqOZh6FagwJUzyIjfh1+Izz2D0pSJkn0X9uwDhoj0FwG3SnBMKKfMM4LFttHMSXDCfT2gaO6QPgBAS2m8LZS+m5biOsa2wSBG/Y7Ea5/tqbXX/v8XlN49DSqU+YxNQuLs5DNY1qZjfNz1Ji8HujtYFyn43OwbLi4xmwR7TBM702PkZ5jDKlchLWXWMVm0n7A5iPmoC7r+itwIihdSLKwMieEVZ6ianq4kUWd/EMaAcgFT3BNZS1KbC7CYpU+qR0lwt0K0ywa2dIM1fP8WFLbkcTsmuxsvGPgY4D2T4+h4Z300pmBU22dZOQaT0GHkAljPyIKBikQjWBu81aCedTvMemfdeAIic4XXXRU7KKqfKkKb9qbtBfdO5BD1dOmb35sqOqP0ptRhHhEWQraw30NbTN0ozs9XQ98cyfb6jzqcl0c7eRYF2WUtfJFEoadku87QVPgIUbX0sdm98I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5322.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(396003)(39860400002)(346002)(136003)(366004)(451199021)(86362001)(33716001)(30864003)(2906002)(44832011)(6666004)(6486002)(6512007)(186003)(83380400001)(53546011)(9686003)(6506007)(26005)(82960400001)(478600001)(54906003)(6636002)(4326008)(66946007)(316002)(66556008)(38100700002)(66476007)(6862004)(41300700001)(5660300002)(8936002)(8676002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AHb4BRHZm597ndYgLpxsXijkyd21r0ATNu8RmG50M1W1pxTGB2PRYOvDRkJ5?=
 =?us-ascii?Q?FjshP2PUIPXNWAaFsXbkdSHxDBUDXljg7JFgpiZpZQUnp7g1ZaS4E2jWUy0r?=
 =?us-ascii?Q?Ro3EfDFMUa9EQX9MCw4sHht4AZoSxnXOlVqHNM28mfzXmofcL2fvkU3jUIhg?=
 =?us-ascii?Q?43ZCDQ7S3VtfHjJ2+wOEtE92RA2VVQlzqfgsFVKBe+mSZtAlYMlxnpezkpGB?=
 =?us-ascii?Q?zaNiVRO8LC+aOzC8wqaK/7+OGBSHqnJ0hOFGCse8gRLM+ekTGbbQX+Ybs34n?=
 =?us-ascii?Q?pMAaZtxYsnZ5WLqtUSOswRe6F+qyvG1YFm57PvlD5+RLKTMoetChoq5zaNYq?=
 =?us-ascii?Q?e9SF9t0ty7KxJPyefLelFnKRHGIZf5kw5T17ElkRVnOnRKq78k+pQIHouWRh?=
 =?us-ascii?Q?WFFVVEVd6O6or6Om71GBHGxeiG7o4d410r66LHHSJRSmf5xrICgDL9uKszZO?=
 =?us-ascii?Q?ggeomKlhAVlvNXPMoqytERib6FonlOSowyF4D7ImX371G5oRpZ8X96/9E/he?=
 =?us-ascii?Q?bhB8pcRD1lQt5WeL1RGhbYaZo8K44x3DCwO6vEWpfMa1HU5W/vrTKGxNfqLt?=
 =?us-ascii?Q?0WQVLfPNfwtcZvgw40fNo09Ide7k6eX/bu2ICtIAxZHdP8DM2DPbW4o3MiMg?=
 =?us-ascii?Q?g8bs1CWqgxpeLAKXHryhxihIeKrIezUb4TC5xMkrGYiHrHfXqGMSlHTAgLla?=
 =?us-ascii?Q?G8F4mSMvhrUeqpqoGtL9lvZ2JHs129V2o6lE7AO6qIm5CYtYaN3lU1dU8rdV?=
 =?us-ascii?Q?sm/cDIyIJTSmWQRzMlZ8rCuBBsPh109AO8HEWzTwxak1/oyHhJyZ7u15zPXt?=
 =?us-ascii?Q?16sANB9hLjvrSw47e9cJ+NkGnwootPjn2u2s8fzpbdE3yJ8RMUiO4BEe76jl?=
 =?us-ascii?Q?52KoNHgV/Ou5KeHOTQvW33M8Ytt5CyeF/x+2JcqW4vlpLuuGns990yW/JB3w?=
 =?us-ascii?Q?Gu5Mdw4+2uvivxJcRUBjwWpNcWbg3FyND4qUy1TUGacDI+1C0GZNLOaICjuZ?=
 =?us-ascii?Q?m2rjkIgrLGuFylR2HmIi4D05qtRg/6Vq0/iixOCCO8kYWLiKrMf27tz5QORq?=
 =?us-ascii?Q?KGORnDWZPtEXRnHNb+r4lMZhjkMnkDNmSbDIekGnDTOJF+vs6I4jhZFXGnHi?=
 =?us-ascii?Q?zxAI1bWbdlnsHtGf8Jl1UwHFGyK/bj0x5hsT1fYL7dmaVVjoE7uYVzbzrhqD?=
 =?us-ascii?Q?yvgx4HfMn0/m6YqlOlwLfBBUmR/iz0tFhSTmaWAqFYAmYpR2RPoZgFN8codt?=
 =?us-ascii?Q?yAEiYVQ2cULAquiYoO9E40PhYzHN+HAJl5aOeiM9d7/RvEIft3gqohcdH4Fy?=
 =?us-ascii?Q?okJZOzz5Xbt6USqE420nroB5By3KsH4KzSeSswyL0uE6OqVa3vDgfh0VlNOE?=
 =?us-ascii?Q?55mO0ehO5Ssd1ZxN16v3DSab/dwfA2GAlnaC18xoc1pzczYSDu5yf7EXDsEL?=
 =?us-ascii?Q?E02Y0IXbnYjxWO/Kz7TMkWI5I0rVkLvYTZ40JKpHIm4nwYkxrMr6zEq533JP?=
 =?us-ascii?Q?V8GeZ9m19YKU3dF2GE8au8hd3w5Ts9N8uE3oCWDzbnUurpBHc2so/VEQQP4j?=
 =?us-ascii?Q?sGud6x5GZ1D5veTbntuWJzxn12bYCoLMpP0xhSc8vlR1pySZd1hGPhvxJQt0?=
 =?us-ascii?Q?Cg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 673f9516-cd41-421c-da9e-08db6dd244b8
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5322.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 18:56:46.9872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QJAX6O5Jrjstz+uP9m7wC6w7RUb02b0Gzm05EnePWnuGK6t9j/KZL329eH91oFpPTgIlVGW/Sp5j1ddB/MAJlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5917
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Jun 15, 2023 at 11:12:29AM -0700, Ira Weiny wrote:
> Dave Jiang wrote:
> > 
> > 
> > On 6/14/23 12:16, ira.weiny@intel.com wrote:
> > > From: Navneet Singh <navneet.singh@intel.com>
> > > 
> > > CXL devices optionally support dynamic capacity. CXL Regions must be
> > > created to access this capacity.
> > > 
> > > Add sysfs entries to create dynamic capacity cxl regions. Provide a new
> > > Dynamic Capacity decoder mode which targets dynamic capacity on devices
> > > which are added to that region.
> > > 
> > > Below are the steps to create and delete dynamic capacity region0
> > > (example).
> > > 
> > >      region=$(cat /sys/bus/cxl/devices/decoder0.0/create_dc_region)
> > >      echo $region> /sys/bus/cxl/devices/decoder0.0/create_dc_region
> > >      echo 256 > /sys/bus/cxl/devices/$region/interleave_granularity
> > >      echo 1 > /sys/bus/cxl/devices/$region/interleave_ways
> > > 
> > >      echo "dc0" >/sys/bus/cxl/devices/decoder1.0/mode
> > >      echo 0x400000000 >/sys/bus/cxl/devices/decoder1.0/dpa_size
> > > 
> > >      echo 0x400000000 > /sys/bus/cxl/devices/$region/size
> > >      echo  "decoder1.0" > /sys/bus/cxl/devices/$region/target0
> > >      echo 1 > /sys/bus/cxl/devices/$region/commit
> > >      echo $region > /sys/bus/cxl/drivers/cxl_region/bind
> > > 
> > >      echo $region> /sys/bus/cxl/devices/decoder0.0/delete_region
> > > 
> > > Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> > > 
> > > ---
> > > [iweiny: fixups]
> > > [iweiny: remove unused CXL_DC_REGION_MODE macro]
> > > [iweiny: Make dc_mode_to_region_index static]
> > > [iweiny: simplify <sysfs>/create_dc_region]
> > > [iweiny: introduce decoder_mode_is_dc]
> > > [djbw: fixups, no sign-off: preview only]
> > > ---
> > >   drivers/cxl/Kconfig       |  11 +++
> > >   drivers/cxl/core/core.h   |   7 ++
> > >   drivers/cxl/core/hdm.c    | 234 ++++++++++++++++++++++++++++++++++++++++++----
> > >   drivers/cxl/core/port.c   |  18 ++++
> > >   drivers/cxl/core/region.c | 135 ++++++++++++++++++++++++--
> > >   drivers/cxl/cxl.h         |  28 ++++++
> > >   drivers/dax/cxl.c         |   4 +
> > >   7 files changed, 409 insertions(+), 28 deletions(-)
> > > 
> > > diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> > > index ff4e78117b31..df034889d053 100644
> > > --- a/drivers/cxl/Kconfig
> > > +++ b/drivers/cxl/Kconfig
> > > @@ -121,6 +121,17 @@ config CXL_REGION
> > >   
> > >   	  If unsure say 'y'
> > >   
> > > +config CXL_DCD
> > > +	bool "CXL: DCD Support"
> > > +	default CXL_BUS
> > > +	depends on CXL_REGION
> > > +	help
> > > +	  Enable the CXL core to provision CXL DCD regions.
> > > +	  CXL devices optionally support dynamic capacity and DCD region
> > > +	  maps the dynamic capacity regions DPA's into Host HPA ranges.
> > > +
> > > +	  If unsure say 'y'
> > > +
> > >   config CXL_REGION_INVALIDATION_TEST
> > >   	bool "CXL: Region Cache Management Bypass (TEST)"
> > >   	depends on CXL_REGION
> > > diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> > > index 27f0968449de..725700ab5973 100644
> > > --- a/drivers/cxl/core/core.h
> > > +++ b/drivers/cxl/core/core.h
> > > @@ -9,6 +9,13 @@ extern const struct device_type cxl_nvdimm_type;
> > >   
> > >   extern struct attribute_group cxl_base_attribute_group;
> > >   
> > > +#ifdef CONFIG_CXL_DCD
> > > +extern struct device_attribute dev_attr_create_dc_region;
> > > +#define SET_CXL_DC_REGION_ATTR(x) (&dev_attr_##x.attr),
> > > +#else
> > > +#define SET_CXL_DC_REGION_ATTR(x)
> > > +#endif
> > > +
> > >   #ifdef CONFIG_CXL_REGION
> > >   extern struct device_attribute dev_attr_create_pmem_region;
> > >   extern struct device_attribute dev_attr_create_ram_region;
> > > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > > index 514d30131d92..29649b47d177 100644
> > > --- a/drivers/cxl/core/hdm.c
> > > +++ b/drivers/cxl/core/hdm.c
> > > @@ -233,14 +233,23 @@ static void __cxl_dpa_release(struct cxl_endpoint_decoder *cxled)
> > >   	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> > >   	struct resource *res = cxled->dpa_res;
> > >   	resource_size_t skip_start;
> > > +	resource_size_t skipped = cxled->skip;
> > >   
> > >   	lockdep_assert_held_write(&cxl_dpa_rwsem);
> > >   
> > >   	/* save @skip_start, before @res is released */
> > > -	skip_start = res->start - cxled->skip;
> > > +	skip_start = res->start - skipped;
> > >   	__release_region(&cxlds->dpa_res, res->start, resource_size(res));
> > > -	if (cxled->skip)
> > > -		__release_region(&cxlds->dpa_res, skip_start, cxled->skip);
> > > +	if (cxled->skip != 0) {
> > > +		while (skipped != 0) {
> > > +			res = xa_load(&cxled->skip_res, skip_start);
> > > +			__release_region(&cxlds->dpa_res, skip_start,
> > > +							resource_size(res));
> > > +			xa_erase(&cxled->skip_res, skip_start);
> > > +			skip_start += resource_size(res);
> > > +			skipped -= resource_size(res);
> > > +			}
> > > +	}
> > >   	cxled->skip = 0;
> > >   	cxled->dpa_res = NULL;
> > >   	put_device(&cxled->cxld.dev);
> > > @@ -267,6 +276,19 @@ static void devm_cxl_dpa_release(struct cxl_endpoint_decoder *cxled)
> > >   	__cxl_dpa_release(cxled);
> > >   }
> > >   
> > > +static int dc_mode_to_region_index(enum cxl_decoder_mode mode)
> > > +{
> > > +	int index = 0;
> > > +
> > > +	for (int i = CXL_DECODER_DC0; i <= CXL_DECODER_DC7; i++) {
> > > +		if (mode == i)
> > > +			return index;
> > > +		index++;
> > > +	}
> > > +
> > > +	return -EINVAL;
> > > +}
> > > +
> > >   static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
> > >   			     resource_size_t base, resource_size_t len,
> > >   			     resource_size_t skipped)
> > > @@ -275,7 +297,11 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
> > >   	struct cxl_port *port = cxled_to_port(cxled);
> > >   	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> > >   	struct device *dev = &port->dev;
> > > +	struct device *ed_dev = &cxled->cxld.dev;
> > > +	struct resource *dpa_res = &cxlds->dpa_res;
> > > +	resource_size_t skip_len = 0;
> > >   	struct resource *res;
> > > +	int rc, index;
> > >   
> > >   	lockdep_assert_held_write(&cxl_dpa_rwsem);
> > >   
> > > @@ -304,28 +330,119 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
> > >   	}
> > >   
> > >   	if (skipped) {
> > > -		res = __request_region(&cxlds->dpa_res, base - skipped, skipped,
> > > -				       dev_name(&cxled->cxld.dev), 0);
> > > -		if (!res) {
> > > -			dev_dbg(dev,
> > > -				"decoder%d.%d: failed to reserve skipped space\n",
> > > -				port->id, cxled->cxld.id);
> > > -			return -EBUSY;
> > > +		resource_size_t skip_base = base - skipped;
> > > +
> > > +		if (decoder_mode_is_dc(cxled->mode)) {
> > 
> > Maybe move this entire block to a helper function to reduce the size of 
> > the current function and reduce indent levels and improve readability?
> 
> :-/
> 
> I'll work on breaking it out more.  The logic here is getting kind of
> crazy.
> 
> > 
> > > +			if (resource_size(&cxlds->ram_res) &&
> > > +					skip_base <= cxlds->ram_res.end) {
> > > +				skip_len = cxlds->ram_res.end - skip_base + 1;
> > > +				res = __request_region(dpa_res, skip_base,
> > > +						skip_len, dev_name(ed_dev), 0);
> > > +				if (!res)
> > > +					goto error;
> > > +
> > > +				rc = xa_insert(&cxled->skip_res, skip_base, res,
> > > +								GFP_KERNEL);
> > > +				skip_base += skip_len;
> > > +			}
> > > +
> > > +			if (resource_size(&cxlds->ram_res) &&
>                                                   ^^^^^^^
> 						  pmem_res?
> 
> > > +					skip_base <= cxlds->pmem_res.end) {
> 
> The 2 if statements here are almost exactly the same.  To the point I
> wonder if there is a bug.
> 
> Navneet,
> 
> Why does the code check ram_res the second time but go on to use pmem_res
> in the block?

Navneet- Thanks for pointing out it should be pmem_res instead of
ram_res. I will fix it.
> 
> > > +				skip_len = cxlds->pmem_res.end - skip_base + 1;
> > > +				res = __request_region(dpa_res, skip_base,
> > > +						skip_len, dev_name(ed_dev), 0);
> > > +				if (!res)
> > > +					goto error;
> > > +
> > > +				rc = xa_insert(&cxled->skip_res, skip_base, res,
> > > +								GFP_KERNEL);
> > > +				skip_base += skip_len;
> > > +			}
> > > +
> > > +			index = dc_mode_to_region_index(cxled->mode);
> > > +			for (int i = 0; i <= index; i++) {
> > > +				struct resource *dcr = &cxlds->dc_res[i];
> > > +
> > > +				if (skip_base < dcr->start) {
> > > +					skip_len = dcr->start - skip_base;
> > > +					res = __request_region(dpa_res,
> > > +							skip_base, skip_len,
> > > +							dev_name(ed_dev), 0);
> > > +					if (!res)
> > > +						goto error;
> > > +
> > > +					rc = xa_insert(&cxled->skip_res, skip_base,
> > > +							res, GFP_KERNEL);
> > > +					skip_base += skip_len;
> > > +				}
> > > +
> > > +				if (skip_base == base) {
> > > +					dev_dbg(dev, "skip done!\n");
> > > +					break;
> > > +				}
> > > +
> > > +				if (resource_size(dcr) &&
> > > +						skip_base <= dcr->end) {
> > > +					if (skip_base > base)
> > > +						dev_err(dev, "Skip error\n");
> > > +
> > > +					skip_len = dcr->end - skip_base + 1;
> > > +					res = __request_region(dpa_res, skip_base,
> > > +							skip_len,
> > > +							dev_name(ed_dev), 0);
> > > +					if (!res)
> > > +						goto error;
> > > +
> > > +					rc = xa_insert(&cxled->skip_res, skip_base,
> > > +							res, GFP_KERNEL);
> > > +					skip_base += skip_len;
> > > +				}
> > > +			}
> > > +		} else	{
> > > +			res = __request_region(dpa_res, base - skipped, skipped,
> > > +							dev_name(ed_dev), 0);
> > > +			if (!res)
> > > +				goto error;
> > > +
> > > +			rc = xa_insert(&cxled->skip_res, skip_base, res,
> > > +								GFP_KERNEL);
> > >   		}
> > >   	}
> > > -	res = __request_region(&cxlds->dpa_res, base, len,
> > > -			       dev_name(&cxled->cxld.dev), 0);
> > > +
> > > +	res = __request_region(dpa_res, base, len, dev_name(ed_dev), 0);
> > >   	if (!res) {
> > >   		dev_dbg(dev, "decoder%d.%d: failed to reserve allocation\n",
> > > -			port->id, cxled->cxld.id);
> > > -		if (skipped)
> > > -			__release_region(&cxlds->dpa_res, base - skipped,
> > > -					 skipped);
> > > +				port->id, cxled->cxld.id);
> > > +		if (skipped) {
> > > +			resource_size_t skip_base = base - skipped;
> > > +
> > > +			while (skipped != 0) {
> > > +				if (skip_base > base)
> > > +					dev_err(dev, "Skip error\n");
> > > +
> > > +				res = xa_load(&cxled->skip_res, skip_base);
> > > +				__release_region(dpa_res, skip_base,
> > > +							resource_size(res));
> > > +				xa_erase(&cxled->skip_res, skip_base);
> > > +				skip_base += resource_size(res);
> > > +				skipped -= resource_size(res);
> > > +			}
> > > +		}
> > >   		return -EBUSY;
> > >   	}
> > >   	cxled->dpa_res = res;
> > >   	cxled->skip = skipped;
> > >   
> > > +	for (int mode = CXL_DECODER_DC0; mode <= CXL_DECODER_DC7; mode++) {
> > > +		int index = dc_mode_to_region_index(mode);
> > > +
> > > +		if (resource_contains(&cxlds->dc_res[index], res)) {
> > > +			cxled->mode = mode;
> > > +			dev_dbg(dev, "decoder%d.%d: %pr mode: %d\n", port->id,
> > > +				cxled->cxld.id, cxled->dpa_res, cxled->mode);
> > > +			goto success > +		}
> > > +	}
> > 
> > This block should only happen if decoder_mode_is_dc() right? If that's 
> > the case, you might be able to refactor it so the 'goto success' isn't 
> > necessary.
> 
> I'll check.  I looked through this code a couple of times in my review
> before posting because I'm not 100% sure I want to see 8 different modes
> DC decoders and regions.
> 
> I think the 'mode' should be 'DC' with an index in the endpoint decoder to
> map DC region that decoder is mapping.  But that change was much bigger to
> Navneets code and I wanted to see how others felt about having DC0 - DC7
> modes.  My compromise was creating decoder_mode_is_dc().
> 
> > 
> > >   	if (resource_contains(&cxlds->pmem_res, res))
> > >   		cxled->mode = CXL_DECODER_PMEM;
> > >   	else if (resource_contains(&cxlds->ram_res, res))
> > > @@ -336,9 +453,16 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
> > >   		cxled->mode = CXL_DECODER_MIXED;
> > >   	}
> > >   
> > > +success:
> > >   	port->hdm_end++;
> > >   	get_device(&cxled->cxld.dev);
> > >   	return 0;
> > > +
> > > +error:
> > > +	dev_dbg(dev, "decoder%d.%d: failed to reserve skipped space\n",
> > > +			port->id, cxled->cxld.id);
> > > +	return -EBUSY;
> > > +
> > >   }
> > >   
> > >   int devm_cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
> > > @@ -429,6 +553,14 @@ int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
> > >   	switch (mode) {
> > >   	case CXL_DECODER_RAM:
> > >   	case CXL_DECODER_PMEM:
> > > +	case CXL_DECODER_DC0:
> > > +	case CXL_DECODER_DC1:
> > > +	case CXL_DECODER_DC2:
> > > +	case CXL_DECODER_DC3:
> > > +	case CXL_DECODER_DC4:
> > > +	case CXL_DECODER_DC5:
> > > +	case CXL_DECODER_DC6:
> > > +	case CXL_DECODER_DC7:
> 
> For example this seems very hacky...
> 
> [snip]
> 
> > >   
> > > +/*
> > > + * The region can not be manged by CXL if any portion of
> > > + * it is already online as 'System RAM'
> > > + */
> > > +static bool region_is_system_ram(struct cxl_region *cxlr,
> > > +				 struct cxl_region_params *p)
> > > +{
> > > +	return (walk_iomem_res_desc(IORES_DESC_NONE,
> > > +				    IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
> > > +				    p->res->start, p->res->end, cxlr,
> > > +				    is_system_ram) > 0);
> > > +}
> > > +
> > >   static int cxl_region_probe(struct device *dev)
> > >   {
> > >   	struct cxl_region *cxlr = to_cxl_region(dev);
> > > @@ -3174,14 +3287,7 @@ static int cxl_region_probe(struct device *dev)
> > >   	case CXL_DECODER_PMEM:
> > >   		return devm_cxl_add_pmem_region(cxlr);
> > >   	case CXL_DECODER_RAM:
> > > -		/*
> > > -		 * The region can not be manged by CXL if any portion of
> > > -		 * it is already online as 'System RAM'
> > > -		 */
> > > -		if (walk_iomem_res_desc(IORES_DESC_NONE,
> > > -					IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
> > > -					p->res->start, p->res->end, cxlr,
> > > -					is_system_ram) > 0)
> > > +		if (region_is_system_ram(cxlr, p))
> > 
> > Maybe split this change out as a prep patch before the current patch.
> 
> That seems reasonable.  But the patch is not so large and the
> justification for creating a helper is that we need this same check for DC
> regions.  So it seemed ok to leave it like this.  Let me see about
> splitting it out.
> 
> [snip]
> 
> > > diff --git a/drivers/dax/cxl.c b/drivers/dax/cxl.c
> > > index ccdf8de85bd5..eb5eb81bfbd7 100644
> > > --- a/drivers/dax/cxl.c
> > > +++ b/drivers/dax/cxl.c
> > > @@ -23,11 +23,15 @@ static int cxl_dax_region_probe(struct device *dev)
> > >   	if (!dax_region)
> > >   		return -ENOMEM;
> > >   
> > > +	if (decoder_mode_is_dc(cxlr->mode))
> > > +		return 0;
> > > +
> > >   	data = (struct dev_dax_data) {
> > >   		.dax_region = dax_region,
> > >   		.id = -1,
> > >   		.size = range_len(&cxlr_dax->hpa_range),
> > >   	};
> > > +
> > 
> > Stray blank line?
> 
> Opps!  Fixed!
> 
> Ira
