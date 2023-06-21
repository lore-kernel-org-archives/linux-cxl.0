Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73102EB64D7
	for <linux-cxl@archiver.kernel.org>; Wed, 21 Jun 2023 03:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjFUDNa (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 20 Jun 2023 23:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjFUDN2 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 20 Jun 2023 23:13:28 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8DF1717
        for <linux-cxl@vger.kernel.org>; Tue, 20 Jun 2023 20:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687317206; x=1718853206;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=5xLXgMX67ci3wtDvRIW4aXwhW2nlY7QfSJBgni2dMGM=;
  b=G/4D6dxvg96E8j7tk6INWFPb4ZajbivRnR3Y1jH3UGmpJeb7c2BhCr17
   y+2l+ljvHUK/xvNiTSxLj+qPh796CZ19S0D1mmfnVH0Yk99iPAJcwPInG
   sIzWY5YQa0Stdk/Skntmf59KzG2FVEFy5KaRdxoT5NTyDM2T0TnmBFgqT
   7h6UjzUjXgKOLekLf5Rl6VNDqehlN1jcwU0b0+otROnwxNXzkNxnMqdS+
   E/Sbi8avVxV4D6AZYrYguSLHx1qOrzkJuyJszYSbP9dBV55+cdrxJtW+4
   Ii9TlaXoDzA942Iq8tY1oqMXNoGp4i38Jc0S76vMqBj1dPv1Zpzx0v1C1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="423714907"
X-IronPort-AV: E=Sophos;i="6.00,259,1681196400"; 
   d="scan'208";a="423714907"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 20:13:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="708532244"
X-IronPort-AV: E=Sophos;i="6.00,259,1681196400"; 
   d="scan'208";a="708532244"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP; 20 Jun 2023 20:13:25 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 20 Jun 2023 20:13:24 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 20 Jun 2023 20:13:24 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 20 Jun 2023 20:13:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VTLHIEoYC4KjoGiCcpp7qL+qGCv4+sgJSSaHWUx0xf0V3ABcJTrr/EATgkXCp9Bh+EN+MQ43WcSSGBi53NkqkCBTXHxQp8LYNc5d7vGKpIY+wyJ7Dl/KipkMsaqcOKzFk/jcnOALNwqaVp6OaW0oMPv6hD44JsLF1/um8jYnYh9LNvViyzK31UVlUvBeoTqHPHiH/VjgICBk4mVtPBg49KDYnkvq+lZCZzwNBSbh3243M1BsdOBkPMIQxy3vr+cPeTdApHx53t9n2l6l7SaTP/HPhU6kXXVAXKjqT6anL0S1n1JEvtFnTt67pv6dawbBY+ooWhBCHny6/UDr4Abyyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tJhyjx/fKzUDt8gyMQNK2IPhMzttKfuCLD6AG228LaE=;
 b=W8M+Ara6SXJrNtg2WJ5P9TsAlumsaWceJcC+DIoibiJng/Bc+6Rax11b8w04hryPDJy6puIOn+59ZeZhXbDDk+CVQmSRmGGLMuYv0Je2MaLjZQlx5dXx2+7DlyDIq0nbdtXsAKm0u9a9wo8DueeCrmyUfDjgNsKzAWOFP0A0TlTnEZOFvmDzXDgxSts/yQC4BRc+u6RUiwU54zjQ2/FtwBL9nSLkgR72+J1iIuChri1effibOG+EezJSECzZCD+XTEM4HbWt94RLbIJ3C97r6N7XaAYFPpWKmaZwmXfB/SRjSSEfd+X+A+LNMBtTL/8pgsA1TYZDgy9tl6HnRySdBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN9PR11MB5322.namprd11.prod.outlook.com (2603:10b6:408:137::18)
 by CO1PR11MB5121.namprd11.prod.outlook.com (2603:10b6:303:98::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 03:13:21 +0000
Received: from BN9PR11MB5322.namprd11.prod.outlook.com
 ([fe80::497b:51a8:9880:7eeb]) by BN9PR11MB5322.namprd11.prod.outlook.com
 ([fe80::497b:51a8:9880:7eeb%7]) with mapi id 15.20.6521.020; Wed, 21 Jun 2023
 03:13:21 +0000
Date:   Tue, 20 Jun 2023 23:13:07 -0400
From:   Navneet Singh <navneet.singh@intel.com>
To:     Fan Ni <nifan@outlook.com>
CC:     <ira.weiny@intel.com>, Fan Ni <fan.ni@samsung.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>, <a.manzanares@samsung.com>,
        <dave@stgolabs.net>, <nmtadam.samsung@gmail.com>
Subject: Re: [PATCH 2/5] cxl/region: Add dynamic capacity cxl region support.
Message-ID: <ZJJqw2zG2nbT9/9l@fedora>
References: <20230604-dcd-type2-upstream-v1-0-71b6341bae54@intel.com>
 <20230604-dcd-type2-upstream-v1-2-71b6341bae54@intel.com>
 <SG2PR06MB3397DD960E58B1F026CBC0E8B25CA@SG2PR06MB3397.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <SG2PR06MB3397DD960E58B1F026CBC0E8B25CA@SG2PR06MB3397.apcprd06.prod.outlook.com>
X-ClientProxiedBy: PN3PR01CA0150.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::8) To BN9PR11MB5322.namprd11.prod.outlook.com
 (2603:10b6:408:137::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR11MB5322:EE_|CO1PR11MB5121:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e84d082-0570-4a97-274c-08db720577a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 83WGZhWJxVTRYuqDrGH6ZAY8hwxFOVU6remMfYW1i7J7xkVemQGB1aqIrvorAG2Y2tDqKCein6nnCBfAOi/sdNh8LcxOXLZFYPLyat+sRc6QKqMdT3hwgD8DuxiudkqoqO+B6y5eZFNakjCfx7O0ICaZzeGVQk/eby8Czeb3ZI2O/keoxP5e4X+zed5wrPuumlxGWssNmvyQT0awax52hSPVkWbVAlpe6e5LRTLilQ7RTKSCJK0LF6U+76kRevCP6UlTiYSVgcepxyR4XQMZrRK2NYv5iPovAfQtqwi7Ahr3sU9F85j9QU3yw9a7jFzNO32uGMywhMGS2P9KQOircChTY7DjTMKPqEEWdKy2TuRxxQEng0dTUdwMHM6nxw4q0AQ/vvZ4wV0D1p2nJlVB/dBVMALUBx8q8EMXjby9ITGj/+948GXo9Uy+ECa9kBuRm5REYldWQbg0A75eJG1WHwU5Uvt06CW8lFHv2Rv23PU3LoJL/ZzAuj7fVixX9m2p5wSxWapI2JeyfL/aICsgOl6ham/8bpnKVb/4BL6ogRoX+CmEzReKSQfGSk4iUJtQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5322.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(39860400002)(376002)(136003)(346002)(396003)(451199021)(6506007)(83380400001)(9686003)(26005)(186003)(6512007)(82960400001)(38100700002)(6486002)(478600001)(45080400002)(6666004)(54906003)(86362001)(66556008)(66946007)(66476007)(8936002)(8676002)(4326008)(316002)(6916009)(2906002)(5660300002)(44832011)(41300700001)(33716001)(30864003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fTfcE74DEaZMsSmCXKrs+skeJwytJQnGYiCWLknfDTXmj8BNv0cD0xUAcYac?=
 =?us-ascii?Q?1pncGHLie2qXOyIyOq/UokhvdHBZ7Xl735tCzRyi7m3o0SNEwoHCOD85Fblm?=
 =?us-ascii?Q?FzYGgvXm9Np09fqAA5VZLCFocDpJvhn+83LNyUfuhkRv84GlX1UN+vQcFYqB?=
 =?us-ascii?Q?djz8f8WmA7FsdyOn3ubpUN3t+QUNC+y3n4z2714nNEPwRXTbXnrVJUoPo2NQ?=
 =?us-ascii?Q?wLwhZ1FLm2URVXXsGc+MhxDYqWNawRyLaS9pHBT0yvDc0su0Jw1x6UDSD1E0?=
 =?us-ascii?Q?eON/8odDkWaHmUmoYcLhdx/RpEzYE0mdgr8sq07OCrwNlhazU6fbNc7MjaC0?=
 =?us-ascii?Q?obnIH2OzLgFsc1lx5ZwRKdB7tV0qPCswbBNoNZiOkPww8r9gkOlix1GqBjCM?=
 =?us-ascii?Q?jG03LWKht3dnvJ2UB54WztQ9hgQsZUMR8TxdTxa55dx6GQSxJGGN5E4UPh8R?=
 =?us-ascii?Q?n6O7TB2moYTrQwLZ8kalrWsD5c+ZxM+y2t+bm7FyAcVjuGcMU/DrG2/cY+KD?=
 =?us-ascii?Q?gZBwnwuqLDRvl+bT701eHI0IU25nV+2LwwSZiJIGessTXpnXpiLejffj3KQg?=
 =?us-ascii?Q?1Rn6MQByk4dyzjNXx8K4OhZvN/1bHypf89GIPPwa6tdUSeIcz5DFTEifa7dH?=
 =?us-ascii?Q?u7ggU5IIq9A0DK7l2wGLRzzf4ID8jhJN0FUTzxBYyeKBtVA2Yl+b1ntBscaC?=
 =?us-ascii?Q?owSZ5mT8D6uTJiFTQ7A0c0rEXnTc0Mme7WecE2pNVs+pukBHClzpBj4qIKa0?=
 =?us-ascii?Q?6551d497pRetN9mklNTBstDNLU1c07tvV7JDjUPsmZbm83DZzj3kAYKs0QNt?=
 =?us-ascii?Q?6KNy6wojZLS6QjLtWAGkQX54jll0ylFLugrlHXB6auaFMymzYyL+gtN2Hf7c?=
 =?us-ascii?Q?9FgquZsYULVS2zDARExaSgqZL7W9h8kzouJS7sGRPmJ7YlSGgZFctn2+R9o9?=
 =?us-ascii?Q?YwnztpXEGdqgG7Tj3dkxyc5K8aBkKazXE7dMPF/Du6Qo/sKfjJ27zyxRtpon?=
 =?us-ascii?Q?yYpE2EwNEu6t9gWpIGIAJp/gZd3tZO1WIREllGcQlxYXMqnrlU8bzWUyt9TR?=
 =?us-ascii?Q?qgw0lxgKSjAc75lsPv41TwNE7mTt84K7Qe8CkXgGBpvRQGmA7C5VMz1cLmrA?=
 =?us-ascii?Q?ZTa6oiFlB6go+OdnNlKMLuc1oP3+9rlaSh23nsFWbq9hhGagUjPXVHmF2ReU?=
 =?us-ascii?Q?hjV6lpeJr7wqpY0uise0Hzbuc16fZOvfxsHoPFoDCfl3m7fGq4p87ekdIeO+?=
 =?us-ascii?Q?TmHtexrWLf3soJBw0C2KG9AuSVj8iwIJe5ILxl8bVIk6b/Ch90y0cS0L7CrG?=
 =?us-ascii?Q?8juxNPJ+JvEn9Yc2gPu63HCMkGrZks4Fgq3niQii2zCZGUc6vG4Iq72bzHRu?=
 =?us-ascii?Q?IUyOBSEN8PS+UCcAMjVSd1dOIJLXWzUs5qXgLDty3uurL3uumuwBSv307mxS?=
 =?us-ascii?Q?K8ThOYFLtOgEzu8ujolOqDb7EjL/IrG5gNgq0oXFMQSTarub9EPRJEgCp7/r?=
 =?us-ascii?Q?wym3BjMFomftLpKXXpH1IKfzqUAv6xeDz6yonOjg2VuV0IU2bDsNeHgYXrks?=
 =?us-ascii?Q?eX55AgdTzmBwVAOYjjhnxUrWvnsxJ9pHPPulr5x7PeOh9a8ZwaAkxhj3oP8+?=
 =?us-ascii?Q?yw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e84d082-0570-4a97-274c-08db720577a5
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5322.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 03:13:21.5948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Clg6TYAQbGp8WjzlJun/ARHqjqa+w36O5IVLxwRCrDI7xpjprRgEMomWq3TUKfE3/e4bw3QziBKz28ccMsCzVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5121
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Jun 20, 2023 at 10:55:15AM -0700, Fan Ni wrote:
> The 06/14/2023 12:16, ira.weiny@intel.com wrote:
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
> >  
> >  	lockdep_assert_held_write(&cxl_dpa_rwsem);
> >  
> >  	/* save @skip_start, before @res is released */
> > -	skip_start = res->start - cxled->skip;
> > +	skip_start = res->start - skipped;
> >  	__release_region(&cxlds->dpa_res, res->start, resource_size(res));
> > -	if (cxled->skip)
> > -		__release_region(&cxlds->dpa_res, skip_start, cxled->skip);
> > +	if (cxled->skip != 0) {
> > +		while (skipped != 0) {
> > +			res = xa_load(&cxled->skip_res, skip_start);
> > +			__release_region(&cxlds->dpa_res, skip_start,
> > +							resource_size(res));
> > +			xa_erase(&cxled->skip_res, skip_start);
> > +			skip_start += resource_size(res);
> > +			skipped -= resource_size(res);
> > +			}
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
> >  	lockdep_assert_held_write(&cxl_dpa_rwsem);
> >  
> > @@ -304,28 +330,119 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
> >  	}
> >  
> >  	if (skipped) {
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
> Should it be cxlds->pmem_res here?
> 
> Fan
Navneet - Yes , This is already in the change list. 
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
> > +			rc = -ENXIO;
> > +			goto out;
> > +		}
> > +	}
> > +
> >  	cxled->mode = mode;
> >  	rc = 0;
> >  out:
> > @@ -469,10 +611,12 @@ static resource_size_t cxl_dpa_freespace(struct cxl_endpoint_decoder *cxled,
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
> > +	index = dc_mode_to_region_index(cxled->mode);
> > +	if (index >= 0) {
> > +		if (cxlds->dc_res[index].child) {
> > +			dev_err(dev, "Cannot allocated DPA from DC Region: %d\n",
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
> > +		 * already handled the RAM and PMEM skip.Check for DC region
> > +		 * skip.
> > +		 */
> > +		for (int i = index - 1; i >= 0 ; i--) {
> > +			if (cxlds->dc_res[i].child) {
> > +				skip_start = cxlds->dc_res[i].child->end + 1;
> > +				break;
> > +			}
> > +		}
> > +
> > +		skip_end = start - 1;
> > +		skip = skip_end - skip_start + 1;
> >  	} else {
> >  		dev_dbg(cxled_dev(cxled), "mode not set\n");
> >  		avail = 0;
> > @@ -548,10 +729,25 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
> >  
> >  	avail = cxl_dpa_freespace(cxled, &start, &skip);
> >  
> > +	dev_dbg(dev, "DPA Allocation start: %llx len: %llx Skip: %llx\n",
> > +						start, size, skip);
> >  	if (size > avail) {
> > +		static const char * const names[] = {
> > +			[CXL_DECODER_NONE] = "none",
> > +			[CXL_DECODER_RAM] = "ram",
> > +			[CXL_DECODER_PMEM] = "pmem",
> > +			[CXL_DECODER_MIXED] = "mixed",
> > +			[CXL_DECODER_DC0] = "dc0",
> > +			[CXL_DECODER_DC1] = "dc1",
> > +			[CXL_DECODER_DC2] = "dc2",
> > +			[CXL_DECODER_DC3] = "dc3",
> > +			[CXL_DECODER_DC4] = "dc4",
> > +			[CXL_DECODER_DC5] = "dc5",
> > +			[CXL_DECODER_DC6] = "dc6",
> > +			[CXL_DECODER_DC7] = "dc7",
> > +		};
> >  		dev_dbg(dev, "%pa exceeds available %s capacity: %pa\n", &size,
> > -			cxled->mode == CXL_DECODER_RAM ? "ram" : "pmem",
> > -			&avail);
> > +			names[cxled->mode], &avail);
> >  		rc = -ENOSPC;
> >  		goto out;
> >  	}
> > diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> > index 5e21b53362e6..a1a98aba24ed 100644
> > --- a/drivers/cxl/core/port.c
> > +++ b/drivers/cxl/core/port.c
> > @@ -195,6 +195,22 @@ static ssize_t mode_store(struct device *dev, struct device_attribute *attr,
> >  		mode = CXL_DECODER_PMEM;
> >  	else if (sysfs_streq(buf, "ram"))
> >  		mode = CXL_DECODER_RAM;
> > +	else if (sysfs_streq(buf, "dc0"))
> > +		mode = CXL_DECODER_DC0;
> > +	else if (sysfs_streq(buf, "dc1"))
> > +		mode = CXL_DECODER_DC1;
> > +	else if (sysfs_streq(buf, "dc2"))
> > +		mode = CXL_DECODER_DC2;
> > +	else if (sysfs_streq(buf, "dc3"))
> > +		mode = CXL_DECODER_DC3;
> > +	else if (sysfs_streq(buf, "dc4"))
> > +		mode = CXL_DECODER_DC4;
> > +	else if (sysfs_streq(buf, "dc5"))
> > +		mode = CXL_DECODER_DC5;
> > +	else if (sysfs_streq(buf, "dc6"))
> > +		mode = CXL_DECODER_DC6;
> > +	else if (sysfs_streq(buf, "dc7"))
> > +		mode = CXL_DECODER_DC7;
> >  	else
> >  		return -EINVAL;
> >  
> > @@ -296,6 +312,7 @@ static struct attribute *cxl_decoder_root_attrs[] = {
> >  	&dev_attr_target_list.attr,
> >  	SET_CXL_REGION_ATTR(create_pmem_region)
> >  	SET_CXL_REGION_ATTR(create_ram_region)
> > +	SET_CXL_DC_REGION_ATTR(create_dc_region)
> >  	SET_CXL_REGION_ATTR(delete_region)
> >  	NULL,
> >  };
> > @@ -1691,6 +1708,7 @@ struct cxl_endpoint_decoder *cxl_endpoint_decoder_alloc(struct cxl_port *port)
> >  		return ERR_PTR(-ENOMEM);
> >  
> >  	cxled->pos = -1;
> > +	xa_init(&cxled->skip_res);
> >  	cxld = &cxled->cxld;
> >  	rc = cxl_decoder_init(port, cxld);
> >  	if (rc)	 {
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 543c4499379e..144232c8305e 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -1733,7 +1733,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
> >  	lockdep_assert_held_write(&cxl_region_rwsem);
> >  	lockdep_assert_held_read(&cxl_dpa_rwsem);
> >  
> > -	if (cxled->mode != cxlr->mode) {
> > +	if (decoder_mode_is_dc(cxlr->mode) && !decoder_mode_is_dc(cxled->mode)) {
> >  		dev_dbg(&cxlr->dev, "%s region mode: %d mismatch: %d\n",
> >  			dev_name(&cxled->cxld.dev), cxlr->mode, cxled->mode);
> >  		return -EINVAL;
> > @@ -2211,6 +2211,14 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
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
> >  		dev_err(&cxlrd->cxlsd.cxld.dev, "unsupported mode %d\n", mode);
> > @@ -2321,6 +2329,43 @@ static ssize_t create_ram_region_store(struct device *dev,
> >  }
> >  DEVICE_ATTR_RW(create_ram_region);
> >  
> > +static ssize_t store_dcN_region(struct cxl_root_decoder *cxlrd,
> > +				const char *buf, enum cxl_decoder_mode mode,
> > +				size_t len)
> > +{
> > +	struct cxl_region *cxlr;
> > +	int rc, id;
> > +
> > +	rc = sscanf(buf, "region%d\n", &id);
> > +	if (rc != 1)
> > +		return -EINVAL;
> > +
> > +	cxlr = __create_region(cxlrd, id, mode, CXL_DECODER_HOSTMEM);
> > +	if (IS_ERR(cxlr))
> > +		return PTR_ERR(cxlr);
> > +
> > +	return len;
> > +}
> > +
> > +static ssize_t create_dc_region_show(struct device *dev,
> > +				     struct device_attribute *attr, char *buf)
> > +{
> > +	return __create_region_show(to_cxl_root_decoder(dev), buf);
> > +}
> > +
> > +static ssize_t create_dc_region_store(struct device *dev,
> > +				      struct device_attribute *attr,
> > +				      const char *buf, size_t len)
> > +{
> > +	/*
> > +	 * All DC regions use decoder mode DC0 as the region does not need the
> > +	 * index information
> > +	 */
> > +	return store_dcN_region(to_cxl_root_decoder(dev), buf,
> > +				CXL_DECODER_DC0, len);
> > +}
> > +DEVICE_ATTR_RW(create_dc_region);
> > +
> >  static ssize_t region_show(struct device *dev, struct device_attribute *attr,
> >  			   char *buf)
> >  {
> > @@ -2799,6 +2844,61 @@ static int devm_cxl_add_dax_region(struct cxl_region *cxlr)
> >  	return rc;
> >  }
> >  
> > +static void cxl_dc_region_release(void *data)
> > +{
> > +	struct cxl_region *cxlr = data;
> > +	struct cxl_dc_region *cxlr_dc = cxlr->cxlr_dc;
> > +
> > +	xa_destroy(&cxlr_dc->dax_dev_list);
> > +	kfree(cxlr_dc);
> > +}
> > +
> > +static int devm_cxl_add_dc_region(struct cxl_region *cxlr)
> > +{
> > +	struct cxl_dc_region *cxlr_dc;
> > +	struct cxl_dax_region *cxlr_dax;
> > +	struct device *dev;
> > +	int rc = 0;
> > +
> > +	cxlr_dax = cxl_dax_region_alloc(cxlr);
> > +	if (IS_ERR(cxlr_dax))
> > +		return PTR_ERR(cxlr_dax);
> > +
> > +	cxlr_dc = kzalloc(sizeof(*cxlr_dc), GFP_KERNEL);
> > +	if (!cxlr_dc) {
> > +		rc = -ENOMEM;
> > +		goto err;
> > +	}
> > +
> > +	dev = &cxlr_dax->dev;
> > +	rc = dev_set_name(dev, "dax_region%d", cxlr->id);
> > +	if (rc)
> > +		goto err;
> > +
> > +	rc = device_add(dev);
> > +	if (rc)
> > +		goto err;
> > +
> > +	dev_dbg(&cxlr->dev, "%s: register %s\n", dev_name(dev->parent),
> > +		dev_name(dev));
> > +
> > +	rc = devm_add_action_or_reset(&cxlr->dev, cxlr_dax_unregister,
> > +					cxlr_dax);
> > +	if (rc)
> > +		goto err;
> > +
> > +	cxlr_dc->cxlr_dax = cxlr_dax;
> > +	xa_init(&cxlr_dc->dax_dev_list);
> > +	cxlr->cxlr_dc = cxlr_dc;
> > +	rc = devm_add_action_or_reset(&cxlr->dev, cxl_dc_region_release, cxlr);
> > +	if (!rc)
> > +		return 0;
> > +err:
> > +	put_device(dev);
> > +	kfree(cxlr_dc);
> > +	return rc;
> > +}
> > +
> >  static int match_decoder_by_range(struct device *dev, void *data)
> >  {
> >  	struct range *r1, *r2 = data;
> > @@ -3140,6 +3240,19 @@ static int is_system_ram(struct resource *res, void *arg)
> >  	return 1;
> >  }
> >  
> > +/*
> > + * The region can not be manged by CXL if any portion of
> > + * it is already online as 'System RAM'
> > + */
> > +static bool region_is_system_ram(struct cxl_region *cxlr,
> > +				 struct cxl_region_params *p)
> > +{
> > +	return (walk_iomem_res_desc(IORES_DESC_NONE,
> > +				    IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
> > +				    p->res->start, p->res->end, cxlr,
> > +				    is_system_ram) > 0);
> > +}
> > +
> >  static int cxl_region_probe(struct device *dev)
> >  {
> >  	struct cxl_region *cxlr = to_cxl_region(dev);
> > @@ -3174,14 +3287,7 @@ static int cxl_region_probe(struct device *dev)
> >  	case CXL_DECODER_PMEM:
> >  		return devm_cxl_add_pmem_region(cxlr);
> >  	case CXL_DECODER_RAM:
> > -		/*
> > -		 * The region can not be manged by CXL if any portion of
> > -		 * it is already online as 'System RAM'
> > -		 */
> > -		if (walk_iomem_res_desc(IORES_DESC_NONE,
> > -					IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
> > -					p->res->start, p->res->end, cxlr,
> > -					is_system_ram) > 0)
> > +		if (region_is_system_ram(cxlr, p))
> >  			return 0;
> >  
> >  		/*
> > @@ -3193,6 +3299,17 @@ static int cxl_region_probe(struct device *dev)
> >  
> >  		/* HDM-H routes to device-dax */
> >  		return devm_cxl_add_dax_region(cxlr);
> > +	case CXL_DECODER_DC0:
> > +	case CXL_DECODER_DC1:
> > +	case CXL_DECODER_DC2:
> > +	case CXL_DECODER_DC3:
> > +	case CXL_DECODER_DC4:
> > +	case CXL_DECODER_DC5:
> > +	case CXL_DECODER_DC6:
> > +	case CXL_DECODER_DC7:
> > +		if (region_is_system_ram(cxlr, p))
> > +			return 0;
> > +		return devm_cxl_add_dc_region(cxlr);
> >  	default:
> >  		dev_dbg(&cxlr->dev, "unsupported region mode: %d\n",
> >  			cxlr->mode);
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index 8400af85d99f..7ac1237938b7 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -335,6 +335,14 @@ enum cxl_decoder_mode {
> >  	CXL_DECODER_NONE,
> >  	CXL_DECODER_RAM,
> >  	CXL_DECODER_PMEM,
> > +	CXL_DECODER_DC0,
> > +	CXL_DECODER_DC1,
> > +	CXL_DECODER_DC2,
> > +	CXL_DECODER_DC3,
> > +	CXL_DECODER_DC4,
> > +	CXL_DECODER_DC5,
> > +	CXL_DECODER_DC6,
> > +	CXL_DECODER_DC7,
> >  	CXL_DECODER_MIXED,
> >  	CXL_DECODER_DEAD,
> >  };
> > @@ -345,6 +353,14 @@ static inline const char *cxl_decoder_mode_name(enum cxl_decoder_mode mode)
> >  		[CXL_DECODER_NONE] = "none",
> >  		[CXL_DECODER_RAM] = "ram",
> >  		[CXL_DECODER_PMEM] = "pmem",
> > +		[CXL_DECODER_DC0] = "dc0",
> > +		[CXL_DECODER_DC1] = "dc1",
> > +		[CXL_DECODER_DC2] = "dc2",
> > +		[CXL_DECODER_DC3] = "dc3",
> > +		[CXL_DECODER_DC4] = "dc4",
> > +		[CXL_DECODER_DC5] = "dc5",
> > +		[CXL_DECODER_DC6] = "dc6",
> > +		[CXL_DECODER_DC7] = "dc7",
> >  		[CXL_DECODER_MIXED] = "mixed",
> >  	};
> >  
> > @@ -353,6 +369,11 @@ static inline const char *cxl_decoder_mode_name(enum cxl_decoder_mode mode)
> >  	return "mixed";
> >  }
> >  
> > +static inline bool decoder_mode_is_dc(enum cxl_decoder_mode mode)
> > +{
> > +	return (mode >= CXL_DECODER_DC0 && mode <= CXL_DECODER_DC7);
> > +}
> > +
> >  /*
> >   * Track whether this decoder is reserved for region autodiscovery, or
> >   * free for userspace provisioning.
> > @@ -375,6 +396,7 @@ struct cxl_endpoint_decoder {
> >  	struct cxl_decoder cxld;
> >  	struct resource *dpa_res;
> >  	resource_size_t skip;
> > +	struct xarray skip_res;
> >  	enum cxl_decoder_mode mode;
> >  	enum cxl_decoder_state state;
> >  	int pos;
> > @@ -475,6 +497,11 @@ struct cxl_region_params {
> >   */
> >  #define CXL_REGION_F_AUTO 1
> >  
> > +struct cxl_dc_region {
> > +	struct xarray dax_dev_list;
> > +	struct cxl_dax_region *cxlr_dax;
> > +};
> > +
> >  /**
> >   * struct cxl_region - CXL region
> >   * @dev: This region's device
> > @@ -493,6 +520,7 @@ struct cxl_region {
> >  	enum cxl_decoder_type type;
> >  	struct cxl_nvdimm_bridge *cxl_nvb;
> >  	struct cxl_pmem_region *cxlr_pmem;
> > +	struct cxl_dc_region *cxlr_dc;
> >  	unsigned long flags;
> >  	struct cxl_region_params params;
> >  };
> > diff --git a/drivers/dax/cxl.c b/drivers/dax/cxl.c
> > index ccdf8de85bd5..eb5eb81bfbd7 100644
> > --- a/drivers/dax/cxl.c
> > +++ b/drivers/dax/cxl.c
> > @@ -23,11 +23,15 @@ static int cxl_dax_region_probe(struct device *dev)
> >  	if (!dax_region)
> >  		return -ENOMEM;
> >  
> > +	if (decoder_mode_is_dc(cxlr->mode))
> > +		return 0;
> > +
> >  	data = (struct dev_dax_data) {
> >  		.dax_region = dax_region,
> >  		.id = -1,
> >  		.size = range_len(&cxlr_dax->hpa_range),
> >  	};
> > +
> >  	dev_dax = devm_create_dev_dax(&data);
> >  	if (IS_ERR(dev_dax))
> >  		return PTR_ERR(dev_dax);
> > 
> > -- 
> > 2.40.0
> > 
> 
> -- 
> Fan Ni <nifan@outlook.com>
