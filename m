Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABEE6EB64D7
	for <linux-cxl@archiver.kernel.org>; Fri, 16 Jun 2023 03:53:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240017AbjFPDxY (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 15 Jun 2023 23:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240000AbjFPDxV (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 15 Jun 2023 23:53:21 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5318273C
        for <linux-cxl@vger.kernel.org>; Thu, 15 Jun 2023 20:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686887592; x=1718423592;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=wrrV1Vr+ZYa4Woeag/5xa5tmUw1RaOxaQRd0HdaLptI=;
  b=Uplry/6xfIfHindAOuPcXHeOfiFLvgnvlR6/GU4bNX3HuDt/pB6czHG8
   UBWoH87yOS5XqNt7wjADLn0tXVPqRgz0/SzSayOGHwRF5ljNMesr9mPPL
   FV0i4ZVLQQhkPBmhawXPMcKbpg20UCkUwuGAlJwbuD4iiZ2oC0EOM/VpB
   0htc/Evhjv3XGMq8BEM8WKuxGlqOHMhQIbrCm2QuS2VmV5MgLVVqdi2xT
   og3VJ5PJZSwGh1CbtASV3HKqn0pufY+XoAF9btq9Ha4tq1rgst6x3PJ48
   c22Sml3P7QzjFgDr3nHlbvU2lWkUvPj7uLZudeSMzS3ohRZUSj5w3CW24
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="361628561"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="361628561"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 20:53:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="712703145"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="712703145"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP; 15 Jun 2023 20:53:11 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 20:53:11 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 15 Jun 2023 20:53:11 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 15 Jun 2023 20:53:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NIlWF9TofJY0gkT2yn6/Q2Gk/n5SAvZwW1YDUVlPbwJmYTklK4TRHrqRuRmjzKBBuT6SOAeJg/jY63Ed0av8LDk2kOqCNyiL6Uw9cDYz07ignQif0fVPUCcHgckcVKbpJJ3BPI6WTH1oyHm3/AuvrJQo3rWHaukRCzZUa+IrVIu/wtbnpuIB7tuyNhgJg/F9l0PpZ7EEQVMt+cLQRVdWKT1qo8+zv/vI+BGEdTyN3mFXLypWcOZMIt8Uz3ZUr+7yo60V87muqYdtzcSnj5gSNrfx7t0axkSsJ1isas6QqxzUkcPnElKuOnZJAbuVO/RL6WOkBnpXbe8rpVnLi6e6Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v9yQ/9B9CCMYlTpgfVc38xUbIvh3Fj93BWO3nCNXpu4=;
 b=LSOF2hZDbCgiHCSwrJpKdBBwWiK77gG7OAB9YTU9yyUWbRKkc6dXQLPMQPHpNly8fq95GaBBdOTWnnvxguHUYmqSBWF+JeA4mU7XxF169e0KSHWODHD7fB5J2c8Zw9yJOez/hEORjeL2lYrFfpp9S2+U4vDIYcPQ3kM3Szfm5/x8lql/J1u1Maz32g0A7gkDdRnqh26yPFJZNi/vzcKXtSfOqeLH6qerUyrS7+8Dv0uPqGCggRFHe/Jt1Q1pqeYDu2HtYGTS9qdr38WCCP0Cq8MPhsbNpOMvzb7pRFfU/hzj7UXjGZAX5qmFYllEA1hvtFp8STjxxhQnHfmmaio+uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN9PR11MB5322.namprd11.prod.outlook.com (2603:10b6:408:137::18)
 by CYYPR11MB8329.namprd11.prod.outlook.com (2603:10b6:930:c7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Fri, 16 Jun
 2023 03:53:09 +0000
Received: from BN9PR11MB5322.namprd11.prod.outlook.com
 ([fe80::497b:51a8:9880:7eeb]) by BN9PR11MB5322.namprd11.prod.outlook.com
 ([fe80::497b:51a8:9880:7eeb%7]) with mapi id 15.20.6500.026; Fri, 16 Jun 2023
 03:53:08 +0000
Date:   Thu, 15 Jun 2023 23:52:52 -0400
From:   Navneet Singh <navneet.singh@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     Ira Weiny <ira.weiny@intel.com>, Fan Ni <fan.ni@samsung.com>,
        "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/5] cxl/region: Add dynamic capacity cxl region support.
Message-ID: <ZIvclLh8kU1Qn4Af@fedora>
References: <20230604-dcd-type2-upstream-v1-0-71b6341bae54@intel.com>
 <20230604-dcd-type2-upstream-v1-2-71b6341bae54@intel.com>
 <f6cd4851-b024-c8fa-8f6e-fcc27843f120@intel.com>
 <648b548db05f5_1c7ab42944a@iweiny-mobl.notmuch>
 <06bcf919-1abb-33d2-105b-b7e7a7c73b96@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <06bcf919-1abb-33d2-105b-b7e7a7c73b96@intel.com>
X-ClientProxiedBy: SI1PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::15) To BN9PR11MB5322.namprd11.prod.outlook.com
 (2603:10b6:408:137::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR11MB5322:EE_|CYYPR11MB8329:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ffe7a2e-d2c0-4a71-30d2-08db6e1d323e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GXGta6qlWM4hYwpaXTGIxUP10CmmClHHFr2XRmKfXYXUk80v1ki54crBOfD/cPu9nQEhF8aGm/oP4t3BTIFxPoSh76REyqI1mO24F9etICPTSZsYlVIn0zGtJQvbAgkw9nyGjjYmSO25nw7DpKGyIrCiN79Yw+r0++jygoHV3CkjNM5r7btlQ9HZPNTZcGRgA0hTpdzATafgI7arA+h5m1OiElQ+z4mwwljkyYP3BgITlq0PIl3VM8TFd1/hhyCAUktFWZ39waq9IexZfHDio2KX1ensFpqa/ygLE7B7zkDTj0e8H4ULAR2CG83z3BQq8naL2WE+KjPOSzC/LwuFOIJmF5rWK4nfJRgF3v39PijztKGs86kkD2ZUGMRi/uetdv/8iAc/1rdcX78xfwyUNgvpfzUvACnuCicVlAKys5lHBh0RQa6ep563gFFDf4XYwr7yjWLkbu/Jj/pfP6lkOphAgCGXMB1h7uDTG+AgvJGzkdVU+Lia+aVqYvHrbH4xMPg9ztozgEVI5TkSVkMM+weWWro167cVeui5+47PiPk3SErG9SoG9HEZQsHeYlUC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5322.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(39860400002)(136003)(396003)(366004)(346002)(451199021)(316002)(44832011)(41300700001)(2906002)(30864003)(66556008)(6862004)(66476007)(4326008)(8936002)(66946007)(8676002)(6636002)(5660300002)(6486002)(86362001)(54906003)(478600001)(33716001)(6666004)(53546011)(26005)(6506007)(6512007)(83380400001)(38100700002)(186003)(9686003)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7GwVFB60C+fcske/m+S9sope0tTRybeNQF+qAMXIlXx5bBu6sN8f2PTtS8vq?=
 =?us-ascii?Q?g7p0EqAfRUFeForOgpvhtoOPp/LzEnnJOZiVDL3rPzmd/jWtOR1c2VQQ2oRs?=
 =?us-ascii?Q?VpwcFwKGSHtbiK5l0S/6vgz+WItSjiTLqa5WPA6TWE6cgdG96vRZjRQY1WGL?=
 =?us-ascii?Q?Lo93DtfuXXTenjsvsM9XCp6l3mSwiYIWdNhsA8mLc/eV0Om9gBJZFUWIrSp9?=
 =?us-ascii?Q?Ni61mIufMT4XNj7IsMvYK4oI4MqsvBhYNTqI2QTNU90Lh3en0E4CHp+E1dTX?=
 =?us-ascii?Q?07SJAx9ncOryZJqwJKqIla1WH4DbIyLQ08KNhOYW+n2rKM9AGf+l/JRpyYvO?=
 =?us-ascii?Q?JfY+6RDE3A7D7Uvm/GSTauimUDG4Z6cJIoEoJ1x3Jr+PtCnTeDe6QN9QnUbB?=
 =?us-ascii?Q?kkTvux/mXjffUF1s+j/BU6uhnjvpQ+tPHbY8No7s3StkVOM+LjGgmcgN8Qo8?=
 =?us-ascii?Q?XDuvJ/6MYADcEDWZjC9rUdWbgnAbe+tyjIrYhySCeJrtJC6bZvXyXdyVdhls?=
 =?us-ascii?Q?+K5heUfkvcs/6IKJljzL7UFkCC1TRPPpOM29pfrq3IFsDqfBTB4xESnvbUJ6?=
 =?us-ascii?Q?pHVARufxV6oLU27Hjw5dha4E0MGFrEmnRIWGwp6GNbnA0Dv/Jx1hnz/ahg9a?=
 =?us-ascii?Q?tZyUb147tT0Q66MFqmj8BYXek7M+KJqR3BRmW0vEnkzu5DJ9iAqp01/RNQHw?=
 =?us-ascii?Q?I9V8oubLxNM5lx39zHbbVP8N6ntR6waBI1Dsee674KWNFbOJUsWev2TEhNOe?=
 =?us-ascii?Q?QU/gikONnRPaxz/acvvCvU245zT+IQnpIRkYI4EtCHBTk4vYbHi1tIfHdoCH?=
 =?us-ascii?Q?8jpjGFQ351/UvgU8WmrQtkFiG1SpHutqaZkgesmOx/eHysVOCF5qcs++swIj?=
 =?us-ascii?Q?23YBlujXTgRf+SGd0qJZvhSBHvorBUJqU5nwNlTeb0yU5CSXK2xH5HqYwDzz?=
 =?us-ascii?Q?/9iiLd69GdTH39TGACrC0SzIMaa22zFBo0XQIxbztDro2HUX+pLzsH4kFrJW?=
 =?us-ascii?Q?70ovuSA7q6AaUk7nJzDHRX3Kqu6ANTKtr871iP3HrGKunp9TY/P9UqlvNSbh?=
 =?us-ascii?Q?7gLI393PBjueCS9Owg5Jw0dCJJhCvVaLK/Qkt7xSlfqTuvTYEWJ3Bog3KArX?=
 =?us-ascii?Q?ALNCLGKyI9wS3+n1Y2nsmtvvgr3QcO5lTSOViKlOK7MiZez0fCiI6iOJg8yK?=
 =?us-ascii?Q?U/4Jrb998r0DPuPv7tC/L2FH5PUh+TyxZM1eEzjXajrEIDg3OqcOedasVDih?=
 =?us-ascii?Q?8d7La/v8lPFGd5/+3yo+xDjabVYrtrHZiH/pmj34fPWOsD7UMsquOjsVlYE4?=
 =?us-ascii?Q?VCbqU721Y00YIe0J4Ok4zq930Lfs6fzcXZ6KjvHkpmR3SSMUdA5bafQ8JCKu?=
 =?us-ascii?Q?13Zd5a+IPqcSgdalOUgCDyy2v2p8r2VcWZMrzUMmI9LZK3ClO5Dq26NImHf8?=
 =?us-ascii?Q?aKxrwGuick3CVAKfUuvpFb7hLBEZ2o+KjGJz3rSyRNLitwJSWTnWkDvFI9u9?=
 =?us-ascii?Q?ZnH6OHcnJwJd7VXBWA13sB87XkAP1wKpf+978vVXL7rX1qmQsnHchf3ClnlU?=
 =?us-ascii?Q?a+YSa//3+Fs7PP+Z4d6ZRbxhi4WCq+XQmKd0kLuwr+QINBChdzk8vpthzKgH?=
 =?us-ascii?Q?ug=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ffe7a2e-d2c0-4a71-30d2-08db6e1d323e
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5322.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 03:53:08.2543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 90/Yc/nTgHfxQJVb8I26s+h/eWkIySFbzhufGtIBMHgyaOO0M7J5D3vrjsg+mEnUBQKY4H17W1QJYassLdpn1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8329
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Jun 15, 2023 at 11:28:26AM -0700, Dave Jiang wrote:
> 
> 
> On 6/15/23 11:12, Ira Weiny wrote:
> > Dave Jiang wrote:
> > > 
> > > 
> > > On 6/14/23 12:16, ira.weiny@intel.com wrote:
> > > > From: Navneet Singh <navneet.singh@intel.com>
> > > > 
> > > > CXL devices optionally support dynamic capacity. CXL Regions must be
> > > > created to access this capacity.
> > > > 
> > > > Add sysfs entries to create dynamic capacity cxl regions. Provide a new
> > > > Dynamic Capacity decoder mode which targets dynamic capacity on devices
> > > > which are added to that region.
> > > > 
> > > > Below are the steps to create and delete dynamic capacity region0
> > > > (example).
> > > > 
> > > >       region=$(cat /sys/bus/cxl/devices/decoder0.0/create_dc_region)
> > > >       echo $region> /sys/bus/cxl/devices/decoder0.0/create_dc_region
> > > >       echo 256 > /sys/bus/cxl/devices/$region/interleave_granularity
> > > >       echo 1 > /sys/bus/cxl/devices/$region/interleave_ways
> > > > 
> > > >       echo "dc0" >/sys/bus/cxl/devices/decoder1.0/mode
> > > >       echo 0x400000000 >/sys/bus/cxl/devices/decoder1.0/dpa_size
> > > > 
> > > >       echo 0x400000000 > /sys/bus/cxl/devices/$region/size
> > > >       echo  "decoder1.0" > /sys/bus/cxl/devices/$region/target0
> > > >       echo 1 > /sys/bus/cxl/devices/$region/commit
> > > >       echo $region > /sys/bus/cxl/drivers/cxl_region/bind
> > > > 
> > > >       echo $region> /sys/bus/cxl/devices/decoder0.0/delete_region
> > > > 
> > > > Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> > > > 
> > > > ---
> > > > [iweiny: fixups]
> > > > [iweiny: remove unused CXL_DC_REGION_MODE macro]
> > > > [iweiny: Make dc_mode_to_region_index static]
> > > > [iweiny: simplify <sysfs>/create_dc_region]
> > > > [iweiny: introduce decoder_mode_is_dc]
> > > > [djbw: fixups, no sign-off: preview only]
> > > > ---
> > > >    drivers/cxl/Kconfig       |  11 +++
> > > >    drivers/cxl/core/core.h   |   7 ++
> > > >    drivers/cxl/core/hdm.c    | 234 ++++++++++++++++++++++++++++++++++++++++++----
> > > >    drivers/cxl/core/port.c   |  18 ++++
> > > >    drivers/cxl/core/region.c | 135 ++++++++++++++++++++++++--
> > > >    drivers/cxl/cxl.h         |  28 ++++++
> > > >    drivers/dax/cxl.c         |   4 +
> > > >    7 files changed, 409 insertions(+), 28 deletions(-)
> > > > 
> > > > diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> > > > index ff4e78117b31..df034889d053 100644
> > > > --- a/drivers/cxl/Kconfig
> > > > +++ b/drivers/cxl/Kconfig
> > > > @@ -121,6 +121,17 @@ config CXL_REGION
> > > >    	  If unsure say 'y'
> > > > +config CXL_DCD
> > > > +	bool "CXL: DCD Support"
> > > > +	default CXL_BUS
> > > > +	depends on CXL_REGION
> > > > +	help
> > > > +	  Enable the CXL core to provision CXL DCD regions.
> > > > +	  CXL devices optionally support dynamic capacity and DCD region
> > > > +	  maps the dynamic capacity regions DPA's into Host HPA ranges.
> > > > +
> > > > +	  If unsure say 'y'
> > > > +
> > > >    config CXL_REGION_INVALIDATION_TEST
> > > >    	bool "CXL: Region Cache Management Bypass (TEST)"
> > > >    	depends on CXL_REGION
> > > > diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> > > > index 27f0968449de..725700ab5973 100644
> > > > --- a/drivers/cxl/core/core.h
> > > > +++ b/drivers/cxl/core/core.h
> > > > @@ -9,6 +9,13 @@ extern const struct device_type cxl_nvdimm_type;
> > > >    extern struct attribute_group cxl_base_attribute_group;
> > > > +#ifdef CONFIG_CXL_DCD
> > > > +extern struct device_attribute dev_attr_create_dc_region;
> > > > +#define SET_CXL_DC_REGION_ATTR(x) (&dev_attr_##x.attr),
> > > > +#else
> > > > +#define SET_CXL_DC_REGION_ATTR(x)
> > > > +#endif
> > > > +
> > > >    #ifdef CONFIG_CXL_REGION
> > > >    extern struct device_attribute dev_attr_create_pmem_region;
> > > >    extern struct device_attribute dev_attr_create_ram_region;
> > > > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > > > index 514d30131d92..29649b47d177 100644
> > > > --- a/drivers/cxl/core/hdm.c
> > > > +++ b/drivers/cxl/core/hdm.c
> > > > @@ -233,14 +233,23 @@ static void __cxl_dpa_release(struct cxl_endpoint_decoder *cxled)
> > > >    	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> > > >    	struct resource *res = cxled->dpa_res;
> > > >    	resource_size_t skip_start;
> > > > +	resource_size_t skipped = cxled->skip;
> > > >    	lockdep_assert_held_write(&cxl_dpa_rwsem);
> > > >    	/* save @skip_start, before @res is released */
> > > > -	skip_start = res->start - cxled->skip;
> > > > +	skip_start = res->start - skipped;
> > > >    	__release_region(&cxlds->dpa_res, res->start, resource_size(res));
> > > > -	if (cxled->skip)
> > > > -		__release_region(&cxlds->dpa_res, skip_start, cxled->skip);
> > > > +	if (cxled->skip != 0) {
> > > > +		while (skipped != 0) {
> > > > +			res = xa_load(&cxled->skip_res, skip_start);
> > > > +			__release_region(&cxlds->dpa_res, skip_start,
> > > > +							resource_size(res));
> > > > +			xa_erase(&cxled->skip_res, skip_start);
> > > > +			skip_start += resource_size(res);
> > > > +			skipped -= resource_size(res);
> > > > +			}
> > > > +	}
> > > >    	cxled->skip = 0;
> > > >    	cxled->dpa_res = NULL;
> > > >    	put_device(&cxled->cxld.dev);
> > > > @@ -267,6 +276,19 @@ static void devm_cxl_dpa_release(struct cxl_endpoint_decoder *cxled)
> > > >    	__cxl_dpa_release(cxled);
> > > >    }
> > > > +static int dc_mode_to_region_index(enum cxl_decoder_mode mode)
> > > > +{
> > > > +	int index = 0;
> > > > +
> > > > +	for (int i = CXL_DECODER_DC0; i <= CXL_DECODER_DC7; i++) {
> > > > +		if (mode == i)
> > > > +			return index;
> > > > +		index++;
> > > > +	}
> > > > +
> > > > +	return -EINVAL;
> > > > +}
> > > > +
> > > >    static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
> > > >    			     resource_size_t base, resource_size_t len,
> > > >    			     resource_size_t skipped)
> > > > @@ -275,7 +297,11 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
> > > >    	struct cxl_port *port = cxled_to_port(cxled);
> > > >    	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> > > >    	struct device *dev = &port->dev;
> > > > +	struct device *ed_dev = &cxled->cxld.dev;
> > > > +	struct resource *dpa_res = &cxlds->dpa_res;
> > > > +	resource_size_t skip_len = 0;
> > > >    	struct resource *res;
> > > > +	int rc, index;
> > > >    	lockdep_assert_held_write(&cxl_dpa_rwsem);
> > > > @@ -304,28 +330,119 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
> > > >    	}
> > > >    	if (skipped) {
> > > > -		res = __request_region(&cxlds->dpa_res, base - skipped, skipped,
> > > > -				       dev_name(&cxled->cxld.dev), 0);
> > > > -		if (!res) {
> > > > -			dev_dbg(dev,
> > > > -				"decoder%d.%d: failed to reserve skipped space\n",
> > > > -				port->id, cxled->cxld.id);
> > > > -			return -EBUSY;
> > > > +		resource_size_t skip_base = base - skipped;
> > > > +
> > > > +		if (decoder_mode_is_dc(cxled->mode)) {
> > > 
> > > Maybe move this entire block to a helper function to reduce the size of
> > > the current function and reduce indent levels and improve readability?
> > 
> > :-/
> > 
> > I'll work on breaking it out more.  The logic here is getting kind of
> > crazy.
Navneet - yeah, its like splitting the skip in ram, pmem, dc
regions and gaps between the regions.Helper can be done.
> > 
> > > 
> > > > +			if (resource_size(&cxlds->ram_res) &&
> > > > +					skip_base <= cxlds->ram_res.end) {
> > > > +				skip_len = cxlds->ram_res.end - skip_base + 1;
> > > > +				res = __request_region(dpa_res, skip_base,
> > > > +						skip_len, dev_name(ed_dev), 0);
> > > > +				if (!res)
> > > > +					goto error;
> > > > +
> > > > +				rc = xa_insert(&cxled->skip_res, skip_base, res,
> > > > +								GFP_KERNEL);
> > > > +				skip_base += skip_len;
> > > > +			}
> > > > +
> > > > +			if (resource_size(&cxlds->ram_res) &&
> >                                                    ^^^^^^^
> > 						  pmem_res?
> > 
> > > > +					skip_base <= cxlds->pmem_res.end) {
> > 
> > The 2 if statements here are almost exactly the same.  To the point I
> > wonder if there is a bug.
> > 
> > Navneet,
> > 
> > Why does the code check ram_res the second time but go on to use pmem_res
> > in the block?
> > 
> > > > +				skip_len = cxlds->pmem_res.end - skip_base + 1;
> > > > +				res = __request_region(dpa_res, skip_base,
> > > > +						skip_len, dev_name(ed_dev), 0);
> > > > +				if (!res)
> > > > +					goto error;
> > > > +
> > > > +				rc = xa_insert(&cxled->skip_res, skip_base, res,
> > > > +								GFP_KERNEL);
> > > > +				skip_base += skip_len;
> > > > +			}
> > > > +
> > > > +			index = dc_mode_to_region_index(cxled->mode);
> > > > +			for (int i = 0; i <= index; i++) {
> > > > +				struct resource *dcr = &cxlds->dc_res[i];
> > > > +
> > > > +				if (skip_base < dcr->start) {
> > > > +					skip_len = dcr->start - skip_base;
> > > > +					res = __request_region(dpa_res,
> > > > +							skip_base, skip_len,
> > > > +							dev_name(ed_dev), 0);
> > > > +					if (!res)
> > > > +						goto error;
> > > > +
> > > > +					rc = xa_insert(&cxled->skip_res, skip_base,
> > > > +							res, GFP_KERNEL);
> > > > +					skip_base += skip_len;
> > > > +				}
> > > > +
> > > > +				if (skip_base == base) {
> > > > +					dev_dbg(dev, "skip done!\n");
> > > > +					break;
> > > > +				}
> > > > +
> > > > +				if (resource_size(dcr) &&
> > > > +						skip_base <= dcr->end) {
> > > > +					if (skip_base > base)
> > > > +						dev_err(dev, "Skip error\n");
> > > > +
> > > > +					skip_len = dcr->end - skip_base + 1;
> > > > +					res = __request_region(dpa_res, skip_base,
> > > > +							skip_len,
> > > > +							dev_name(ed_dev), 0);
> > > > +					if (!res)
> > > > +						goto error;
> > > > +
> > > > +					rc = xa_insert(&cxled->skip_res, skip_base,
> > > > +							res, GFP_KERNEL);
> > > > +					skip_base += skip_len;
> > > > +				}
> > > > +			}
> > > > +		} else	{
> > > > +			res = __request_region(dpa_res, base - skipped, skipped,
> > > > +							dev_name(ed_dev), 0);
> > > > +			if (!res)
> > > > +				goto error;
> > > > +
> > > > +			rc = xa_insert(&cxled->skip_res, skip_base, res,
> > > > +								GFP_KERNEL);
> > > >    		}
> > > >    	}
> > > > -	res = __request_region(&cxlds->dpa_res, base, len,
> > > > -			       dev_name(&cxled->cxld.dev), 0);
> > > > +
> > > > +	res = __request_region(dpa_res, base, len, dev_name(ed_dev), 0);
> > > >    	if (!res) {
> > > >    		dev_dbg(dev, "decoder%d.%d: failed to reserve allocation\n",
> > > > -			port->id, cxled->cxld.id);
> > > > -		if (skipped)
> > > > -			__release_region(&cxlds->dpa_res, base - skipped,
> > > > -					 skipped);
> > > > +				port->id, cxled->cxld.id);
> > > > +		if (skipped) {
> > > > +			resource_size_t skip_base = base - skipped;
> > > > +
> > > > +			while (skipped != 0) {
> > > > +				if (skip_base > base)
> > > > +					dev_err(dev, "Skip error\n");
> > > > +
> > > > +				res = xa_load(&cxled->skip_res, skip_base);
> > > > +				__release_region(dpa_res, skip_base,
> > > > +							resource_size(res));
> > > > +				xa_erase(&cxled->skip_res, skip_base);
> > > > +				skip_base += resource_size(res);
> > > > +				skipped -= resource_size(res);
> > > > +			}
> > > > +		}
> > > >    		return -EBUSY;
> > > >    	}
> > > >    	cxled->dpa_res = res;
> > > >    	cxled->skip = skipped;
> > > > +	for (int mode = CXL_DECODER_DC0; mode <= CXL_DECODER_DC7; mode++) {
> > > > +		int index = dc_mode_to_region_index(mode);
> > > > +
> > > > +		if (resource_contains(&cxlds->dc_res[index], res)) {
> > > > +			cxled->mode = mode;
> > > > +			dev_dbg(dev, "decoder%d.%d: %pr mode: %d\n", port->id,
> > > > +				cxled->cxld.id, cxled->dpa_res, cxled->mode);
> > > > +			goto success > +		}
> > > > +	}
> > > 
> > > This block should only happen if decoder_mode_is_dc() right? If that's
> > > the case, you might be able to refactor it so the 'goto success' isn't
> > > necessary.
> > 
> > I'll check.  I looked through this code a couple of times in my review
> > before posting because I'm not 100% sure I want to see 8 different modes
> > DC decoders and regions.
> > 
> > I think the 'mode' should be 'DC' with an index in the endpoint decoder to
> > map DC region that decoder is mapping.  But that change was much bigger to
> > Navneets code and I wanted to see how others felt about having DC0 - DC7
> > modes.  My compromise was creating decoder_mode_is_dc().
> > 
Navneet - Discussed with Dan before splitting the modes in dc0-dc7.
Intent is to keep the Linux definition simple and enforce one decoder per DC region.
Each DC region will have its own DSMAS entry.The primary reason to 
have multiple DC regions is to have different performance properties.


> > > 
> > > >    	if (resource_contains(&cxlds->pmem_res, res))
> > > >    		cxled->mode = CXL_DECODER_PMEM;
> > > >    	else if (resource_contains(&cxlds->ram_res, res))
> > > > @@ -336,9 +453,16 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
> > > >    		cxled->mode = CXL_DECODER_MIXED;
> > > >    	}
> > > > +success:
> > > >    	port->hdm_end++;
> > > >    	get_device(&cxled->cxld.dev);
> > > >    	return 0;
> > > > +
> > > > +error:
> > > > +	dev_dbg(dev, "decoder%d.%d: failed to reserve skipped space\n",
> > > > +			port->id, cxled->cxld.id);
> > > > +	return -EBUSY;
> > > > +
> > > >    }
> > > >    int devm_cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
> > > > @@ -429,6 +553,14 @@ int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
> > > >    	switch (mode) {
> > > >    	case CXL_DECODER_RAM:
> > > >    	case CXL_DECODER_PMEM:
> > > > +	case CXL_DECODER_DC0:
> > > > +	case CXL_DECODER_DC1:
> > > > +	case CXL_DECODER_DC2:
> > > > +	case CXL_DECODER_DC3:
> > > > +	case CXL_DECODER_DC4:
> > > > +	case CXL_DECODER_DC5:
> > > > +	case CXL_DECODER_DC6:
> > > > +	case CXL_DECODER_DC7:
> > 
> > For example this seems very hacky...
> 
> Not sure if it helps, but you can always do:
> case CXL_DECODER_DC0 ... CXL_DECODER_DC7:
> 
> DJ
> 
Navneet - Definetly, thanks.
> > 
> > [snip]
> > 
> > > > +/*
> > > > + * The region can not be manged by CXL if any portion of
> > > > + * it is already online as 'System RAM'
> > > > + */
> > > > +static bool region_is_system_ram(struct cxl_region *cxlr,
> > > > +				 struct cxl_region_params *p)
> > > > +{
> > > > +	return (walk_iomem_res_desc(IORES_DESC_NONE,
> > > > +				    IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
> > > > +				    p->res->start, p->res->end, cxlr,
> > > > +				    is_system_ram) > 0);
> > > > +}
> > > > +
> > > >    static int cxl_region_probe(struct device *dev)
> > > >    {
> > > >    	struct cxl_region *cxlr = to_cxl_region(dev);
> > > > @@ -3174,14 +3287,7 @@ static int cxl_region_probe(struct device *dev)
> > > >    	case CXL_DECODER_PMEM:
> > > >    		return devm_cxl_add_pmem_region(cxlr);
> > > >    	case CXL_DECODER_RAM:
> > > > -		/*
> > > > -		 * The region can not be manged by CXL if any portion of
> > > > -		 * it is already online as 'System RAM'
> > > > -		 */
> > > > -		if (walk_iomem_res_desc(IORES_DESC_NONE,
> > > > -					IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
> > > > -					p->res->start, p->res->end, cxlr,
> > > > -					is_system_ram) > 0)
> > > > +		if (region_is_system_ram(cxlr, p))
> > > 
> > > Maybe split this change out as a prep patch before the current patch.
> > 
> > That seems reasonable.  But the patch is not so large and the
> > justification for creating a helper is that we need this same check for DC
> > regions.  So it seemed ok to leave it like this.  Let me see about
> > splitting it out.
> > 
> > [snip]
> > 
> > > > diff --git a/drivers/dax/cxl.c b/drivers/dax/cxl.c
> > > > index ccdf8de85bd5..eb5eb81bfbd7 100644
> > > > --- a/drivers/dax/cxl.c
> > > > +++ b/drivers/dax/cxl.c
> > > > @@ -23,11 +23,15 @@ static int cxl_dax_region_probe(struct device *dev)
> > > >    	if (!dax_region)
> > > >    		return -ENOMEM;
> > > > +	if (decoder_mode_is_dc(cxlr->mode))
> > > > +		return 0;
> > > > +
> > > >    	data = (struct dev_dax_data) {
> > > >    		.dax_region = dax_region,
> > > >    		.id = -1,
> > > >    		.size = range_len(&cxlr_dax->hpa_range),
> > > >    	};
> > > > +
> > > 
> > > Stray blank line?
> > 
> > Opps!  Fixed!
> > 
> > Ira
