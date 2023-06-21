Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D313EB64D8
	for <linux-cxl@archiver.kernel.org>; Wed, 21 Jun 2023 02:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjFUCom (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 20 Jun 2023 22:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjFUCol (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 20 Jun 2023 22:44:41 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D66B10F1
        for <linux-cxl@vger.kernel.org>; Tue, 20 Jun 2023 19:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687315479; x=1718851479;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=hL3vmu4U5/u/aZZkby6aBoTFv9a/1p2Qg/R5QJSq8e0=;
  b=LSjw6pl4iJhxmXyG5l8TMFkXT7LMlz5KvZaf7pSRfLy5pY0zTFkFFmlv
   cDlFwvDvQYUywUndOTjxpZ9t+TzcHV7JbdVMc/C8PGvxePIVI0OW+51K1
   Qomnnkk/DAL2nwhzYPtR9WMUDoTSB1ztdowWkxVz+aMnzfm/CaFPMeLs8
   4Wu/ol4Ke6JX5htLWfFrtzPWEyPIQaMSR5NBZ9R/1D81VLVnybcOQMN+L
   CqB5rDg9dCEMK2x/IJL+Hztszx1oCtY+RkQgRIYVLfaeMwR/sHmc4oeqm
   rn/uXw6U1l/xdQAPwTaZDafEPfiTW/7Pm4uzC8fCo4LLcvSVNs+pWY+N6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="358915777"
X-IronPort-AV: E=Sophos;i="6.00,259,1681196400"; 
   d="scan'208";a="358915777"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 19:44:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="708526355"
X-IronPort-AV: E=Sophos;i="6.00,259,1681196400"; 
   d="scan'208";a="708526355"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP; 20 Jun 2023 19:44:26 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 20 Jun 2023 19:44:26 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 20 Jun 2023 19:44:26 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 20 Jun 2023 19:44:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jz5BXXN++RKo3hk+0SUCycz6eXOGZBr6H0c0Rr+0MW2ZKBDpyCjG4rpwwCLqfaHeeYSYWhboOxsKDrE2+GL7Nf0XPnGBXHye0kGWVTKsofD9uQB483NaoNVSV/KpTtClHasx1DmNvHkwVCSjcaN5wbtC0aV1c7kPb5Thhf6+WX+qLzkToxbGVWfPusp1pBVdICkakZu3sr/i7SaK2mc06trj0XUcDV4iVnO0/KPaa9+dFQTgIggLHDal7PasXWSmMk2eAIrPhLq74VyZ1g4ADsPE5mx6vRc2CUS9EnOlMBGjFgP0MSZPdPqGkVq0sPUUCBR5w123eUGRo0Fp8ingPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h2PhU2vmcvJWD1WWcjueE9ffizWfQME7OTjSEhC98Jk=;
 b=ZjX8BXbhlIA0YCeaX2y0TyDmFxuAZKZSikbt0mQpQ+5iPImgRgp20wuKMVMnTBl5eBdow9TtQwqySugDfnxR86TO+6Jr6K+4KhYXXf21OyLndyAkwR0QLXfllszbBZvSL4FOitVIbJAi4e0iURwfkOYIx+eq2a1idq5qDW+Jp1i+4oCoCjfX3LVUs/pWAwIeAdcnOdYgp2VwZKqnYnLxWaYI1PWkZiMm53KvYcdJj/4inngLr9TAW44pIHXZoqGbjw6y2dxvNodokToinEt36ZJyNqiRVYx2klRoOZU9kodCtbSo6C86WGng9XGWQS1BRKEIOI0O+B8Pb4a+mWNm9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DS0PR11MB7928.namprd11.prod.outlook.com (2603:10b6:8:fe::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.37; Wed, 21 Jun 2023 02:44:22 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::7237:cab8:f7f:52a5]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::7237:cab8:f7f:52a5%7]) with mapi id 15.20.6500.036; Wed, 21 Jun 2023
 02:44:23 +0000
Date:   Tue, 20 Jun 2023 19:44:15 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        <ira.weiny@intel.com>
CC:     Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/5] cxl/region: Add dynamic capacity cxl region support.
Message-ID: <649263ff75fcc_483a294d9@iweiny-mobl.notmuch>
References: <20230604-dcd-type2-upstream-v1-0-71b6341bae54@intel.com>
 <20230604-dcd-type2-upstream-v1-2-71b6341bae54@intel.com>
 <ZIyTFpniGlEv2QEo@aschofie-mobl2>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZIyTFpniGlEv2QEo@aschofie-mobl2>
X-ClientProxiedBy: SJ0PR03CA0106.namprd03.prod.outlook.com
 (2603:10b6:a03:333::21) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DS0PR11MB7928:EE_
X-MS-Office365-Filtering-Correlation-Id: 36de6347-b3ff-4aa9-28e0-08db72016b0c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RcSfjhariTvCY1+dQNRnmOsXSet/45OuYqpCxJr5S8WfogXs6E7be5EQ38gWaHG4DFlTX7ra/ImOOQJC8m80T/O7koOf4k7Nq6sECAW85OeuSTX843d8A/tDTqCUC7Wj35LbOCBj0a9U1Ra0uhAlXO5qZpitV8hMSoxoxXqhK73fOdvEKQdd0M1IJ2ZswkQsAVY/CBKZVxz5FGsROZTu+apafYaUXT5YgWrwhOraF50HSy0bYG0si6OyFpesgF1SrGxHPMa/2wD8BZ2ANG/b1yXEbDWYNziEns2N04hl1BxSffM1y9mcss64qSJ/ZPKMlPeAfNqB2poWHLlYsyxE9IxQOXlX/J1jLUdK/CEYv+oHdVi5mybmfAnWDXG6dQ/6GvYEEjtm58fe6XNBP/9W1CcnVC2V0WspW25aov8ETMYxBdGy2mcKrUN7ZHW2eFDY/sjiOTeS2N06815dYU/IBA9KtiSDWtaw0zZwvYsm/hnjiSjmTtvUj3hTALkIQW4ldL6zbOp7BGM2cRuei7u8S0rBRxxOT8v2x5qhavcQYqo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(366004)(136003)(39860400002)(346002)(451199021)(38100700002)(82960400001)(966005)(86362001)(6666004)(6486002)(186003)(6506007)(9686003)(26005)(8676002)(6512007)(8936002)(30864003)(44832011)(5660300002)(478600001)(54906003)(316002)(41300700001)(66946007)(66476007)(4326008)(66556008)(2906002)(66899021)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u2Xm/rGsy1Oi8m5FQ1j0N/AFqNR7PAcEtcCD/m+3mmN9esIVMsCrU1xaP3Av?=
 =?us-ascii?Q?6jfUyXwn8zwdUQIPaSVQaBGAt3ZkR6Qt5UsG/KIkxETN54L0Dy961eigMW+K?=
 =?us-ascii?Q?cIFO+cIwR+S4+ODk8/4tP5lQy5hgiUydakR16BX8Iczx3q3W4rxXdKusqKZd?=
 =?us-ascii?Q?KiDna+Kqv+W0GF/BTWPJKLV73Mfe93kV6ApDKDTRxCmFrLGOf2yA86Hlf5V/?=
 =?us-ascii?Q?3tbq3pDfxW8U+BD7firoc4mFCF1GTFPZS84NRMoxK1wJriDUwJhDEgiD+eiR?=
 =?us-ascii?Q?CfM6+RviiBPExOKuJ8qNBMcJxVmTF43lCwazZu6y6wQ9hO8F3P9txOtGjFzI?=
 =?us-ascii?Q?O9LO44pbQY7+gVTV3IWyapIlcyBT2vI1QW2qLFnyfR39vTWa7/vHVxZwPi2t?=
 =?us-ascii?Q?BXFfbHZu+0N+mqxvXfYdwFJLAez30aLhxBeJbf2JbKswEHMmGTVkzsvMgCNB?=
 =?us-ascii?Q?FRozADNW9+F6LFj9QBXMlq2M3tfzXiBErUUkKSxSLMBlZvFNUAXdWaHScdki?=
 =?us-ascii?Q?07TEYZBNwoBbVS5fCcdYRbiIHpbZQ/ZjFgXWpKeXS+4gNUqpBLtBeqK5J4pw?=
 =?us-ascii?Q?CtPCSvvrFcd1CfY9XRF2CmyYXO/4VlRfsK4cY1rbcYagm22PLQ/4aJfiROss?=
 =?us-ascii?Q?bSgfrpVMf7UmHulLSrrSGm0dVw4NPY9VMXhBmBPDT7xNV39dd5bykYWZuSL5?=
 =?us-ascii?Q?uDzKYFzwONoxvrk4V5C4mJwh5mbm1PSsghSN6YNmjfaPmQfzzs2TM2zjlyn/?=
 =?us-ascii?Q?pONpbyVAXFIfTS6pvchf+iJxnz9ZSNm1y2OuaRjmJDF16OXlH9kbhgwICpWA?=
 =?us-ascii?Q?ormomzJbdhYDYppTM/rXcLJo0Ez0KYKFcoTpPy4Wl2gH2sACyCwb9o+BH1G2?=
 =?us-ascii?Q?JoKmjGw91+PU0R9Lqr/09vo3rXtC64/5XfMpyx9D1krIyfwmchTb9rAAhPxe?=
 =?us-ascii?Q?Qx85qThgwu+K+Qxr3kxm74yEmT5gkJf4ei3auMPgjQg6OlALw5M8LJQwid07?=
 =?us-ascii?Q?2Dd7TjqluKgMRRyCfSPFcZ2RtFekDYAp2ZP6eFkmPqrED/15v3pVC9jYvPO2?=
 =?us-ascii?Q?acP2U803ohtm+Ys/9bTDEhjgMfh+4doJWtDkWWNThP7czpNzwblCS/BG5eYp?=
 =?us-ascii?Q?RarK0dUp20ZBx8wxrCnjJAfW0XcfudxKTuf4ee3EMhK8AAv2MuRD8J3wa+Je?=
 =?us-ascii?Q?WPQWwbPoAEdXIy3+VPYzuopSyMs6CHHX6LEItmIU29pOp5JH0ynIz+IXMimz?=
 =?us-ascii?Q?4dKp1IujnaVg+iwLhga53mFgkMjrYVSfd/QU+Lcc0ViyBdIFDBsSqIrZihK8?=
 =?us-ascii?Q?bj1VgxebbUQ/fc8j84fXg8HXOp9mal0Ggmwg8iDQE7b10JM8Py0Y7NhE0RCm?=
 =?us-ascii?Q?qSU2PPmohDWg7V/sWjtXTdcu3xd/kcIxw2/zcxZ6ot8H81zLGJYDH5QEzcSm?=
 =?us-ascii?Q?sQmZZzNv87snuOuSs4CHvzZKZ2vzgSxBbqRfr50dp9D8bRQw3LtV+1R4MrcM?=
 =?us-ascii?Q?xAKK0ZiiGMdy4IgJjcAkWXkmgTNUT5LJUBPvLOyvhrpGmR2ms5D+MoCXd+NH?=
 =?us-ascii?Q?HvQ+sWVCv/pJwnbUOHF1tNr9c8Zdo2Yu4K4WY2ic?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 36de6347-b3ff-4aa9-28e0-08db72016b0c
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 02:44:22.4732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SLSQ5Sw6nHV4muQurg+zfQ5fjCFz4cxKy4ZOYdW4VwhQuhhhic3fxInMtUPDsKGcHYHbQqGRFXbnKvyqUdls9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7928
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Alison Schofield wrote:
> On Wed, Jun 14, 2023 at 12:16:29PM -0700, Ira Weiny wrote:
> > From: Navneet Singh <navneet.singh@intel.com>
> > 
> > CXL devices optionally support dynamic capacity. CXL Regions must be
> > created to access this capacity.
> > 
> > Add sysfs entries to create dynamic capacity cxl regions. Provide a new
> > Dynamic Capacity decoder mode which targets dynamic capacity on devices
> > which are added to that region.
> > 
> > Below are the steps to create and delete dynamic capacity region0
> > (example).
> > 
> >     region=$(cat /sys/bus/cxl/devices/decoder0.0/create_dc_region)
> >     echo $region> /sys/bus/cxl/devices/decoder0.0/create_dc_region
> >     echo 256 > /sys/bus/cxl/devices/$region/interleave_granularity
> >     echo 1 > /sys/bus/cxl/devices/$region/interleave_ways
> > 
> >     echo "dc0" >/sys/bus/cxl/devices/decoder1.0/mode
> >     echo 0x400000000 >/sys/bus/cxl/devices/decoder1.0/dpa_size
> > 
> >     echo 0x400000000 > /sys/bus/cxl/devices/$region/size
> >     echo  "decoder1.0" > /sys/bus/cxl/devices/$region/target0
> >     echo 1 > /sys/bus/cxl/devices/$region/commit
> >     echo $region > /sys/bus/cxl/drivers/cxl_region/bind
> > 
> >     echo $region> /sys/bus/cxl/devices/decoder0.0/delete_region
> > 
> > Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> 
> Hi,
> I took another pass at this and offered more feedback.
> I do think that if the big part - the cxl_dpa_reserve()
> was more 'chunkified' it would be easier to review for
> actual functionality.
> 
> I'd also like to see the commit log be a bit more specific
> in enumerated the things this patch intends to do.
> 
> Many of my comments are about style. Some checkpatch --strict
> would call out and some are addressed in the kernel coding
> style - Documentation/process/coding-style.rst

As I said before I did not run with --strict

I've done a quick run through with --strict and will ensure it is done
again after I refactor the code.

> 
> But really, my goal is that when this code merges, that as
> I scroll through a file, say region.c, I see a consistent
> coding style. I shouldn't be able to notice that oh, Dan
> wrote that, and Ira that, and Navneet wrote that piece.

I agree.

> 
> I think it's important because differences in style distract
> from focusing on the functionality of the code.
> 
> (off my soap box now ;)
> 
> Alison
> 
> 
> > 
> > ---
> > [iweiny: fixups]
> > [iweiny: remove unused CXL_DC_REGION_MODE macro]
> > [iweiny: Make dc_mode_to_region_index static]
> > [iweiny: simplify <sysfs>/create_dc_region]
> > [iweiny: introduce decoder_mode_is_dc]
> > [djbw: fixups, no sign-off: preview only]
> > ---
> >  drivers/cxl/Kconfig       |  11 +++
> >  drivers/cxl/core/core.h   |   7 ++
> >  drivers/cxl/core/hdm.c    | 234 ++++++++++++++++++++++++++++++++++++++++++----
> >  drivers/cxl/core/port.c   |  18 ++++
> >  drivers/cxl/core/region.c | 135 ++++++++++++++++++++++++--
> >  drivers/cxl/cxl.h         |  28 ++++++
> >  drivers/dax/cxl.c         |   4 +
> >  7 files changed, 409 insertions(+), 28 deletions(-)
> > 
> > diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> > index ff4e78117b31..df034889d053 100644
> > --- a/drivers/cxl/Kconfig
> > +++ b/drivers/cxl/Kconfig
> > @@ -121,6 +121,17 @@ config CXL_REGION
> >  
> >  	  If unsure say 'y'
> >  
> > +config CXL_DCD
> > +	bool "CXL: DCD Support"
> 
> "CXL DCD: Dynamic Capacity Device Support"
> is more in line with others in this file, and expands the acronym onetime.

done.

> 
> > +	default CXL_BUS
> > +	depends on CXL_REGION
> > +	help
> > +	  Enable the CXL core to provision CXL DCD regions.
> > +	  CXL devices optionally support dynamic capacity and DCD region
> > +	  maps the dynamic capacity regions DPA's into Host HPA ranges.
> > +
> > +	  If unsure say 'y'
> > +
> >  config CXL_REGION_INVALIDATION_TEST
> >  	bool "CXL: Region Cache Management Bypass (TEST)"
> >  	depends on CXL_REGION
> > diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> > index 27f0968449de..725700ab5973 100644
> > --- a/drivers/cxl/core/core.h
> > +++ b/drivers/cxl/core/core.h
> > @@ -9,6 +9,13 @@ extern const struct device_type cxl_nvdimm_type;
> >  
> >  extern struct attribute_group cxl_base_attribute_group;
> >  
> > +#ifdef CONFIG_CXL_DCD
> > +extern struct device_attribute dev_attr_create_dc_region;
> > +#define SET_CXL_DC_REGION_ATTR(x) (&dev_attr_##x.attr),
> > +#else
> > +#define SET_CXL_DC_REGION_ATTR(x)
> > +#endif
> > +
> >  #ifdef CONFIG_CXL_REGION
> >  extern struct device_attribute dev_attr_create_pmem_region;
> >  extern struct device_attribute dev_attr_create_ram_region;
> > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > index 514d30131d92..29649b47d177 100644
> > --- a/drivers/cxl/core/hdm.c
> > +++ b/drivers/cxl/core/hdm.c
> > @@ -233,14 +233,23 @@ static void __cxl_dpa_release(struct cxl_endpoint_decoder *cxled)
> >  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> >  	struct resource *res = cxled->dpa_res;
> >  	resource_size_t skip_start;
> > +	resource_size_t skipped = cxled->skip;
> 
> Reverse x-tree.

Done.

> 
> >  
> >  	lockdep_assert_held_write(&cxl_dpa_rwsem);
> >  
> >  	/* save @skip_start, before @res is released */
> > -	skip_start = res->start - cxled->skip;
> > +	skip_start = res->start - skipped;
> 
> Why did the assignment of skip_start need to change here?

I believe this was done for consistency because skipped now represents
cxled->skip, however...

> 
> >  	__release_region(&cxlds->dpa_res, res->start, resource_size(res));
> > -	if (cxled->skip)
> > -		__release_region(&cxlds->dpa_res, skip_start, cxled->skip);
> > +	if (cxled->skip != 0) {
> > +		while (skipped != 0) {

... what is more concerning is we now effectively have.

	if (skipped != 0) {
		while (skipped != 0) {
			...

:-(

> > +			res = xa_load(&cxled->skip_res, skip_start);
> > +			__release_region(&cxlds->dpa_res, skip_start,
> > +							resource_size(res));
> 
> The above appears poorlty aligned.

fixed.

> 
> > +			xa_erase(&cxled->skip_res, skip_start);
> > +			skip_start += resource_size(res);
> > +			skipped -= resource_size(res);
> > +			}
> 
> This bracket appears poorly aligned.

This is very poorly aligned.  I'll run --strict before sending V2.

> 
> > +	}
> >  	cxled->skip = 0;
> >  	cxled->dpa_res = NULL;
> >  	put_device(&cxled->cxld.dev);
> > @@ -267,6 +276,19 @@ static void devm_cxl_dpa_release(struct cxl_endpoint_decoder *cxled)
> >  	__cxl_dpa_release(cxled);
> >  }
> >  
> > +static int dc_mode_to_region_index(enum cxl_decoder_mode mode)
> > +{
> > +	int index = 0;
> > +
> > +	for (int i = CXL_DECODER_DC0; i <= CXL_DECODER_DC7; i++) {
> > +		if (mode == i)
> > +			return index;
> > +		index++;
> > +	}
> > +
> > +	return -EINVAL;
> > +}
> > +
> >  static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
> >  			     resource_size_t base, resource_size_t len,
> >  			     resource_size_t skipped)
> > @@ -275,7 +297,11 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
> >  	struct cxl_port *port = cxled_to_port(cxled);
> >  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> >  	struct device *dev = &port->dev;
> > +	struct device *ed_dev = &cxled->cxld.dev;
> > +	struct resource *dpa_res = &cxlds->dpa_res;
> > +	resource_size_t skip_len = 0;
> >  	struct resource *res;
> > +	int rc, index;
> >  
> 
> Above poorly aligned.

Do you mean reverse x-tree?

> 
> >  	lockdep_assert_held_write(&cxl_dpa_rwsem);
> >  
> > @@ -304,28 +330,119 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
> >  	}
> >  
> >  	if (skipped) {
> 
> This has excessive indentation, so started out with a monster
> if skipped is begging for a refactoring.

Yea I agree.  Dave pointed this out as well.  What I have to be sure about
is the logic here.

> 
> I find it odd that the DCD case got inserted before the 'default'
> or non-DCD case here.

Yea I'm working with Navneet on this.

> 
> 
> > -		res = __request_region(&cxlds->dpa_res, base - skipped, skipped,
> > -				       dev_name(&cxled->cxld.dev), 0);
> > -		if (!res) {
> > -			dev_dbg(dev,
> > -				"decoder%d.%d: failed to reserve skipped space\n",
> > -				port->id, cxled->cxld.id);
> > -			return -EBUSY;
> > +		resource_size_t skip_base = base - skipped;
> > +
> > +		if (decoder_mode_is_dc(cxled->mode)) {
> 
> This may be cleaner to introduce as a separate function for
> handling _mode_id_dc.

Yes I think all the DC in this function should be handled in it's own
function to clarify how that is handled.

I think it will make the diff/review easier as well because it will be
more clear how things are with and without DCD.

> 
> > +			if (resource_size(&cxlds->ram_res) &&
> > +					skip_base <= cxlds->ram_res.end) {
> > +				skip_len = cxlds->ram_res.end - skip_base + 1;
> > +				res = __request_region(dpa_res, skip_base,
> > +						skip_len, dev_name(ed_dev), 0);
> > +				if (!res)
> > +					goto error;
> > +
> > +				rc = xa_insert(&cxled->skip_res, skip_base, res,
> > +								GFP_KERNEL);
> > +				skip_base += skip_len;
> > +			}
> > +
> > +			if (resource_size(&cxlds->ram_res) &&
> > +					skip_base <= cxlds->pmem_res.end) {
> > +				skip_len = cxlds->pmem_res.end - skip_base + 1;
> > +				res = __request_region(dpa_res, skip_base,
> > +						skip_len, dev_name(ed_dev), 0);
> > +				if (!res)
> > +					goto error;
> > +
> > +				rc = xa_insert(&cxled->skip_res, skip_base, res,
> > +								GFP_KERNEL);
> > +				skip_base += skip_len;
> > +			}
> 
> The above 2 if (resource_size() cases have redundant code. 
> Pull it out, refactor.

Redundant except that the second ram_res needs to be pmem_res.  After
that change I'll have to evaluate how much is duplicated.  As I said above
I'm working with Navneet to see how this logic can be broken down.  It is
a big function now.

> 
> > +
> > +			index = dc_mode_to_region_index(cxled->mode);
> > +			for (int i = 0; i <= index; i++) {
> > +				struct resource *dcr = &cxlds->dc_res[i];
> > +
> > +				if (skip_base < dcr->start) {
> > +					skip_len = dcr->start - skip_base;
> > +					res = __request_region(dpa_res,
> > +							skip_base, skip_len,
> > +							dev_name(ed_dev), 0);
> > +					if (!res)
> > +						goto error;
> > +
> > +					rc = xa_insert(&cxled->skip_res, skip_base,
> > +							res, GFP_KERNEL);
> > +					skip_base += skip_len;
> > +				}
> > +
> > +				if (skip_base == base) {
> > +					dev_dbg(dev, "skip done!\n");
> > +					break;
> > +				}
> > +
> > +				if (resource_size(dcr) &&
> > +						skip_base <= dcr->end) {
> > +					if (skip_base > base)
> > +						dev_err(dev, "Skip error\n");
> > +
> > +					skip_len = dcr->end - skip_base + 1;
> > +					res = __request_region(dpa_res, skip_base,
> > +							skip_len,
> > +							dev_name(ed_dev), 0);
> > +					if (!res)
> > +						goto error;
> > +
> > +					rc = xa_insert(&cxled->skip_res, skip_base,
> > +							res, GFP_KERNEL);
> > +					skip_base += skip_len;
> > +				}
> > +			}
> 
> 
> And, below,we are back to the original code.
> This would be more readable, reviewable if the DCD support was
> added in separate function that are then called from here.

Yep!

> 
> > +		} else	{
> > +			res = __request_region(dpa_res, base - skipped, skipped,
> > +							dev_name(ed_dev), 0);
> > +			if (!res)
> > +				goto error;
> > +
> > +			rc = xa_insert(&cxled->skip_res, skip_base, res,
> > +								GFP_KERNEL);
> >  		}
> >  	}
> > -	res = __request_region(&cxlds->dpa_res, base, len,
> > -			       dev_name(&cxled->cxld.dev), 0);
> > +
> > +	res = __request_region(dpa_res, base, len, dev_name(ed_dev), 0);
> >  	if (!res) {
> >  		dev_dbg(dev, "decoder%d.%d: failed to reserve allocation\n",
> > -			port->id, cxled->cxld.id);
> 
> General comment - look over the dev_dbg() messages and consider placing
> them after the code. I recall, others that were needlessly between lines
> of code.

At the end of the block?

> 
> 
> > -		if (skipped)
> > -			__release_region(&cxlds->dpa_res, base - skipped,
> > -					 skipped);
> > +				port->id, cxled->cxld.id);
> > +		if (skipped) {
> > +			resource_size_t skip_base = base - skipped;
> > +
> > +			while (skipped != 0) {
> > +				if (skip_base > base)
> > +					dev_err(dev, "Skip error\n");
> > +
> > +				res = xa_load(&cxled->skip_res, skip_base);
> > +				__release_region(dpa_res, skip_base,
> > +							resource_size(res));
> > +				xa_erase(&cxled->skip_res, skip_base);
> > +				skip_base += resource_size(res);
> > +				skipped -= resource_size(res);
> > +			}
> > +		}
> 
> 		Can that debug message go here ?

Not sure.  But we have another issue of:

if (skipped) {
	while (skipped) {
	...

which is redundant I think.  I'll have to see about skip_base.

> 
> >  		return -EBUSY;
> >  	}
> >  	cxled->dpa_res = res;
> >  	cxled->skip = skipped;
> >  
> > +	for (int mode = CXL_DECODER_DC0; mode <= CXL_DECODER_DC7; mode++) {
> > +		int index = dc_mode_to_region_index(mode);
> > +
> > +		if (resource_contains(&cxlds->dc_res[index], res)) {
> > +			cxled->mode = mode;
> > +			dev_dbg(dev, "decoder%d.%d: %pr mode: %d\n", port->id,
> > +				cxled->cxld.id, cxled->dpa_res, cxled->mode);
> 
> Can this move to ....
> 
> 
> > +			goto success;
> > +		}
> > +	}
> >  	if (resource_contains(&cxlds->pmem_res, res))
> >  		cxled->mode = CXL_DECODER_PMEM;
> >  	else if (resource_contains(&cxlds->ram_res, res))
> > @@ -336,9 +453,16 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
> >  		cxled->mode = CXL_DECODER_MIXED;
> >  	}
> >  
> > +success:
> >  	port->hdm_end++;
> >  	get_device(&cxled->cxld.dev);
> 
> here...dev_dbg() success message. That pairs it nicely with the
> error message below.

I think it can.  I think we have a case here where there was an attempt
not to change the initial behavior of the code even so much as adding a
debug message.  But I think the over all flow would be better with the
debug here.

> 
> >  	return 0;
> > +
> > +error:
> > +	dev_dbg(dev, "decoder%d.%d: failed to reserve skipped space\n",
> > +			port->id, cxled->cxld.id);
> > +	return -EBUSY;
> > +
> >  }
> >  
> >  int devm_cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
> > @@ -429,6 +553,14 @@ int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
> >  	switch (mode) {
> >  	case CXL_DECODER_RAM:
> >  	case CXL_DECODER_PMEM:
> > +	case CXL_DECODER_DC0:
> > +	case CXL_DECODER_DC1:
> > +	case CXL_DECODER_DC2:
> > +	case CXL_DECODER_DC3:
> > +	case CXL_DECODER_DC4:
> > +	case CXL_DECODER_DC5:
> > +	case CXL_DECODER_DC6:
> > +	case CXL_DECODER_DC7:
> >  		break;
> >  	default:
> >  		dev_dbg(dev, "unsupported mode: %d\n", mode);
> > @@ -456,6 +588,16 @@ int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
> >  		goto out;
> >  	}
> >  
> > +	for (int i = CXL_DECODER_DC0; i <= CXL_DECODER_DC7; i++) {
> > +		int index = dc_mode_to_region_index(i);
> > +
> > +		if (mode == i && !resource_size(&cxlds->dc_res[index])) {
> > +			dev_dbg(dev, "no available dynamic capacity\n");
> 
> I see this one is following the pattern in the function :)
> 
> 
> > +			rc = -ENXIO;
> > +			goto out;
> > +		}
> > +	}
> > +
> >  	cxled->mode = mode;
> >  	rc = 0;
> >  out:
> > @@ -469,10 +611,12 @@ static resource_size_t cxl_dpa_freespace(struct cxl_endpoint_decoder *cxled,
> 
> Hmmm...I don't have cxl_dpa_freespace() in my cxl/next? Where's that?

That was in the patches from Dan which this series depends on.

https://lore.kernel.org/all/168592158743.1948938.7622563891193802610.stgit@dwillia2-xfh.jf.intel.com/

> 
> 
> >  					 resource_size_t *skip_out)
> >  {
> >  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> > -	resource_size_t free_ram_start, free_pmem_start;
> > +	resource_size_t free_ram_start, free_pmem_start, free_dc_start;
> >  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> > +	struct device *dev = &cxled->cxld.dev;
> >  	resource_size_t start, avail, skip;
> >  	struct resource *p, *last;
> > +	int index;
> 
> Why break the alignment above?

What do you mean?

> 
> >  
> >  	lockdep_assert_held(&cxl_dpa_rwsem);
> >  
> > @@ -490,6 +634,20 @@ static resource_size_t cxl_dpa_freespace(struct cxl_endpoint_decoder *cxled,
> >  	else
> >  		free_pmem_start = cxlds->pmem_res.start;
> >  
> > +	/*
> > +	 * One HDM Decoder per DC region to map memory with different
> > +	 * DSMAS entry.
> > +	 */
> 
> It seems this comment is missing a verb. Why not align?

align?

with DSMAS on the end like this?

	/*
	 * One HDM Decoder per DC region to map memory with different DSMAS
	 * entry.
	 */

> > +	index = dc_mode_to_region_index(cxled->mode);
> > +	if (index >= 0) {
> > +		if (cxlds->dc_res[index].child) {
> > +			dev_err(dev, "Cannot allocated DPA from DC Region: %d\n"
> 
> s/allocated/allocate

Fixed.

> 
> ,
> > +					index);
> > +			return -EINVAL;
> > +		}
> > +		free_dc_start = cxlds->dc_res[index].start;
> > +	}
> > +
> >  	if (cxled->mode == CXL_DECODER_RAM) {
> >  		start = free_ram_start;
> >  		avail = cxlds->ram_res.end - start + 1;
> > @@ -511,6 +669,29 @@ static resource_size_t cxl_dpa_freespace(struct cxl_endpoint_decoder *cxled,
> >  		else
> >  			skip_end = start - 1;
> >  		skip = skip_end - skip_start + 1;
> > +	} else if (decoder_mode_is_dc(cxled->mode)) {
> > +		resource_size_t skip_start, skip_end;
> > +
> > +		start = free_dc_start;
> > +		avail = cxlds->dc_res[index].end - start + 1;
> > +		if ((resource_size(&cxlds->pmem_res) == 0) || !cxlds->pmem_res.child)
> > +			skip_start = free_ram_start;
> > +		else
> > +			skip_start = free_pmem_start;
> > +		/*
> > +		 * If some dc region is already mapped, then that allocation
> 
> maybe s/some/any ?

Fixed.

Ira
