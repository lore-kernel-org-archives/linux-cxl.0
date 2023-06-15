Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA61EB64D9
	for <linux-cxl@archiver.kernel.org>; Thu, 15 Jun 2023 18:12:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238975AbjFOSMt (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 15 Jun 2023 14:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238971AbjFOSMo (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 15 Jun 2023 14:12:44 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E6EE57
        for <linux-cxl@vger.kernel.org>; Thu, 15 Jun 2023 11:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686852762; x=1718388762;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=jjHkwHbJW4Z8oysrjn4fMUVUy4sBtmneIDIE7v9JKgE=;
  b=iqjALyylSPcgBj4WHGe0qQUh5QURhj6hI2quWtFqGba1SOiMtRdewj1k
   +r75Jf7vTxziRSU9+Wf7wI1STiZkv91cL+iWHDTlr5ywAEksz1eVJQBOJ
   jNttja+rd52GH6PkhqwaJrqW0M3PqYiKeoWVkrJm4fcfCqSJi5fkOX179
   irv/044R7oGwxSbqo+ztcO9KG6rKYdtChIzE5WzkcDGWccfpwcU3Joik2
   cHSSEJO3uzOldW1D4v0GQBPPXvduGinEl4KKx6uQmqSVCqie47XI+vcNt
   pMS43rNp3YpKMMIp+E9DUQ0/qU9OUrjHVRPMF0Tqpzc8wjECPKxc3xy3k
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="343739095"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="343739095"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 11:12:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="777829442"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="777829442"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 15 Jun 2023 11:12:41 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 11:12:40 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 15 Jun 2023 11:12:40 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 15 Jun 2023 11:12:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MQvlHreXRDbvW8mxfGoY5T/Lls0RsbnrrAPz5r4Q1Uyu+wwG14Q2ZeukPqBRDUriYqYIVgTT/A1/1/PI0RDcfHXA5M+Yw4TzcKKv7BeU3ESlOoLiCZTQwGICi8Gevlpszlb6XJX6UPfhyS3Doz1gZ8QuDLsx1V1gVzK1tdSlqyoDlkYCzpIiYoF3a7sVmxFf5DqjeRAb9nMmnPj648pQcgBCLn81X0xfpKQnmkYmscbPjAgOJdkoW3Nxocye5whi4PWQlJaCBqh6g88LxNx3T7nQX30Ce1gR4FH4DNlsdQR+7PZdLlESM7WPq6FzmzEXJOZgNkhYBbrGEZfZv/a6vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3O688YOpvR0Wsq2V+QPfWsn5TpZx13RAmF3kPllbJu0=;
 b=PtkzJW3T6UgrJ/RN+Avx14SZUYO/xmLmIGuy7P2NyMCzMiVuZrJ3MicSLJTCsz98Skia3Jcn2pY1UAuf0LXtsAcX8HHGXfVmFZgGSzmExXM5GEhbwPaswsKm15bky7gqZYQQa0eMwhjp7QdnbOfbfLNEnnYdoevf6TDUYeWfideyYZEKB3ST0x5PbiTSrznY32+Rh+cId1Jr2YsLnB1aSJ7BWYkMocid8DdFbU2YD06+ajouuAKHvfckZpMQMgiYQbjomXkzIEF6sKprjxVmDm5vPvhf9syAsnl1YdMnrNvN1Ujk8eRP/0BWlO2HdrBwAQeEJC1b2VTIUgleQIoxqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SJ2PR11MB7504.namprd11.prod.outlook.com (2603:10b6:a03:4c5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Thu, 15 Jun
 2023 18:12:37 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::7237:cab8:f7f:52a5]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::7237:cab8:f7f:52a5%7]) with mapi id 15.20.6477.037; Thu, 15 Jun 2023
 18:12:37 +0000
Date:   Thu, 15 Jun 2023 11:12:29 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>, <ira.weiny@intel.com>,
        Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/5] cxl/region: Add dynamic capacity cxl region support.
Message-ID: <648b548db05f5_1c7ab42944a@iweiny-mobl.notmuch>
References: <20230604-dcd-type2-upstream-v1-0-71b6341bae54@intel.com>
 <20230604-dcd-type2-upstream-v1-2-71b6341bae54@intel.com>
 <f6cd4851-b024-c8fa-8f6e-fcc27843f120@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f6cd4851-b024-c8fa-8f6e-fcc27843f120@intel.com>
X-ClientProxiedBy: BYAPR06CA0029.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::42) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SJ2PR11MB7504:EE_
X-MS-Office365-Filtering-Correlation-Id: 25303911-0f41-4cc9-af04-08db6dcc1986
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7IyhyEQgKytBS3T2Y4mJM+qdGoO/sKHD+8bNRhS5jjTR8EtcWqi8xfWbZC9tcpPzBS5EbcE7IuwU4LLvqL0LunO9kJ0QBlBv8j+oW3GURSNul30PIkxl+IR+3+fN1wYRksooITdp5r58WVIxqy4qxtR9bId8JZlbq1JQNl5elCf3phD4A6yzDNilVpXGFmjUweYhCK/gdS1aaXNUmTCYFkD9M1Hn5g7+4BvY2tACdSOUW7IaWn9wHuWZY4bJkDgtwY7tySv+p++XNdQbZArDjfSjM3Cdr1vN5v3ScopHb6Gq5K7mVfh/8C+PhKWHt7WccbcxW5y2WJ+biNuGNDbc1CtA6vJ/3Kdh2fk0KZuVD5K7J7Nzz3PYMWSwuh9KRGf0HGK0ZM5XEViWIOfrW8nszWjYoCvGp2tsZO1vO38jAIy2IY0wV6lJOw8IxJriq0U9oQXf0ZIadVO3rQD4lD78TDgOJ7UfaVz8Ia3K20jRroFz+2llNOeyFl0UtVo/wKYORFpBWPaPE9mQw1WLCkZp6QANa1nRaBM1+tDTAhxM6RRSy+TBlEVpPUrnEBYFh4mW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(346002)(396003)(136003)(376002)(451199021)(41300700001)(8936002)(8676002)(6666004)(38100700002)(478600001)(82960400001)(83380400001)(6512007)(9686003)(186003)(53546011)(6506007)(110136005)(6486002)(86362001)(316002)(66476007)(66946007)(5660300002)(66556008)(30864003)(44832011)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9H/a4rK1A53EBqpI+5S+ELEcUPG6w54WKylCaXsHdNbQu4NbLu/f+/FjNBM4?=
 =?us-ascii?Q?AtrGWuxr0R0XRmufFbxMmgJl/I5tu456qsa6/6AMMo9nGlbUoiRyoAlkcQM5?=
 =?us-ascii?Q?C2/0Vx1E2DqvHXxAKBK/pO+2FNq2wZfRQ5n7wj0Mzf7vdwjAekRE2eco4MnU?=
 =?us-ascii?Q?58N1GcSKyxhsHljsd19QxwS/zg0gQEv7Ykgkvel6HrnOOEDp2cGis6AeNkhh?=
 =?us-ascii?Q?MEE27wtiobdxqW35wla41438bJsrKOcP2FMnN9DtD2Ah/qca7/dAcbnjlENM?=
 =?us-ascii?Q?9Ses0HwtLZX7GD+FV9iNNUicjrzUdKRAp1FoPjQ5sh0PyBYqhcWYNkQVe/gi?=
 =?us-ascii?Q?uPZtM2eL+QFkF3BR0hM31eIE5AgiXOviNxnWBBuYwQFwhIm7N0VZI44otltY?=
 =?us-ascii?Q?FH71aJSwMtuYQWR1UMdrvyEJ9vi+dLkSbMHLzZ0zVmpIGZONH08afx9cqqIP?=
 =?us-ascii?Q?CFCWJqMyspQUxOkgDuqPICOl2u3bizkaGZ2Qy1zxNXs0K/xsOxLnm7Ajfd2+?=
 =?us-ascii?Q?M8vzMehz32EWv5SfDcHTcYoA+GtWbYQH1IdGfi5jUqJrd/y8w73ZYH/r05WE?=
 =?us-ascii?Q?hW0clBcCToPkQh5SnoTjk8ZveNLLFnZrNUkqZi6g1UjH6l3y3Ehvyia1uCIn?=
 =?us-ascii?Q?90NX0+GPEr/K1uQBTQ8+/OTa4tcfMwREo2FOzL+OwRIxSq4OE/IA/Frq2gYg?=
 =?us-ascii?Q?/quFUKdqXTBJg2Cjl2UrPm4RJqI9yo3l5EIEN4itH5d3Klvic7XJ5QinvCim?=
 =?us-ascii?Q?TfJdaQlzaKyby1UaUL2+ud1J/Bo3x1MmcRv3D7wGTSIKnQPBdwMpRxr9LRhY?=
 =?us-ascii?Q?HL5YNs0R6N4COlew2bVwDmA4s1vdSIqT4P9f8gojfMcW4VFmC1PhhWEp7Lfg?=
 =?us-ascii?Q?/mYe2YUzOO8edr1Lo9+NXTqA/oKnjFZK4DqDk1laQSZcWNJZhckt78fHLWDs?=
 =?us-ascii?Q?8uNNGuboV8QkfzMQEDOEVsZ/GntBwifzq6Nn8QtmV7A1yRAlFW8WVV3ItB9R?=
 =?us-ascii?Q?WaIAc5PmeuboTz8+FpbTKhWs2zVBhRWmqeKW68knal+R3UwR9YoWu+3m0Aht?=
 =?us-ascii?Q?LsaJbAKQ++56RpTChL5E6UZtSrMWBstzB+j6nnVHEsCf4bRSdPYWHHffc7iv?=
 =?us-ascii?Q?qdUJS+EBfX3gNZkgRPdMr3w5i8auFC4aN8aC0kTZVCmP8PoOftGg8xbdwhIz?=
 =?us-ascii?Q?6b5onTAfzaSerJlj3aI5KiUWWSQQij8vzuedLAxYYKXTs0XJ/UMmhC5PNhbo?=
 =?us-ascii?Q?crnqJoabOpP5HCwkmZt+ZbtJln+Kf/Yci6KxUQwyXkoWZGKWD9d3JUNeZtog?=
 =?us-ascii?Q?5Er2YpLbLn2vvl7jQvg4dZcxMIdmWPazt67BEY8NWWHQG1J8hB2bJzgZNnSi?=
 =?us-ascii?Q?kuP370RBQ7yVsfbsYf3Cufo9Pa13anM7/lv2g6XxKyN3oHIBl/pDANOTJlPf?=
 =?us-ascii?Q?PzuRzNkH1pIO9HWA5NQFjcB8kNzKsvbrC+Am/3LBGnXu76K6mK1OlJR3yCId?=
 =?us-ascii?Q?8gaRn2qTA7BdCR/X0Gasb6yXGWb7cp/D/7W7asACtVDIjGMBAVFE4KFU3GDL?=
 =?us-ascii?Q?d1FnE0n40DB+2kp6PSbIi228BZDkDD8gDGVKEikJ+XygkdQEdhGUahXyVvY4?=
 =?us-ascii?Q?1e4jM1qGQy9EAuw00x6izvceaVqpOBqhIip4FC2YM/NL?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 25303911-0f41-4cc9-af04-08db6dcc1986
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 18:12:37.5721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BSuC3vsmY9tY8skNiJk+Trmh6jGSQ0IjZ+gpjdAksLJHaI496xPJugaRqYipIIhZloqJ/jFWDwUL+9/nErTF+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7504
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Dave Jiang wrote:
> 
> 
> On 6/14/23 12:16, ira.weiny@intel.com wrote:
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
> >      region=$(cat /sys/bus/cxl/devices/decoder0.0/create_dc_region)
> >      echo $region> /sys/bus/cxl/devices/decoder0.0/create_dc_region
> >      echo 256 > /sys/bus/cxl/devices/$region/interleave_granularity
> >      echo 1 > /sys/bus/cxl/devices/$region/interleave_ways
> > 
> >      echo "dc0" >/sys/bus/cxl/devices/decoder1.0/mode
> >      echo 0x400000000 >/sys/bus/cxl/devices/decoder1.0/dpa_size
> > 
> >      echo 0x400000000 > /sys/bus/cxl/devices/$region/size
> >      echo  "decoder1.0" > /sys/bus/cxl/devices/$region/target0
> >      echo 1 > /sys/bus/cxl/devices/$region/commit
> >      echo $region > /sys/bus/cxl/drivers/cxl_region/bind
> > 
> >      echo $region> /sys/bus/cxl/devices/decoder0.0/delete_region
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
> >   drivers/cxl/Kconfig       |  11 +++
> >   drivers/cxl/core/core.h   |   7 ++
> >   drivers/cxl/core/hdm.c    | 234 ++++++++++++++++++++++++++++++++++++++++++----
> >   drivers/cxl/core/port.c   |  18 ++++
> >   drivers/cxl/core/region.c | 135 ++++++++++++++++++++++++--
> >   drivers/cxl/cxl.h         |  28 ++++++
> >   drivers/dax/cxl.c         |   4 +
> >   7 files changed, 409 insertions(+), 28 deletions(-)
> > 
> > diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> > index ff4e78117b31..df034889d053 100644
> > --- a/drivers/cxl/Kconfig
> > +++ b/drivers/cxl/Kconfig
> > @@ -121,6 +121,17 @@ config CXL_REGION
> >   
> >   	  If unsure say 'y'
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
> >   config CXL_REGION_INVALIDATION_TEST
> >   	bool "CXL: Region Cache Management Bypass (TEST)"
> >   	depends on CXL_REGION
> > diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> > index 27f0968449de..725700ab5973 100644
> > --- a/drivers/cxl/core/core.h
> > +++ b/drivers/cxl/core/core.h
> > @@ -9,6 +9,13 @@ extern const struct device_type cxl_nvdimm_type;
> >   
> >   extern struct attribute_group cxl_base_attribute_group;
> >   
> > +#ifdef CONFIG_CXL_DCD
> > +extern struct device_attribute dev_attr_create_dc_region;
> > +#define SET_CXL_DC_REGION_ATTR(x) (&dev_attr_##x.attr),
> > +#else
> > +#define SET_CXL_DC_REGION_ATTR(x)
> > +#endif
> > +
> >   #ifdef CONFIG_CXL_REGION
> >   extern struct device_attribute dev_attr_create_pmem_region;
> >   extern struct device_attribute dev_attr_create_ram_region;
> > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > index 514d30131d92..29649b47d177 100644
> > --- a/drivers/cxl/core/hdm.c
> > +++ b/drivers/cxl/core/hdm.c
> > @@ -233,14 +233,23 @@ static void __cxl_dpa_release(struct cxl_endpoint_decoder *cxled)
> >   	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> >   	struct resource *res = cxled->dpa_res;
> >   	resource_size_t skip_start;
> > +	resource_size_t skipped = cxled->skip;
> >   
> >   	lockdep_assert_held_write(&cxl_dpa_rwsem);
> >   
> >   	/* save @skip_start, before @res is released */
> > -	skip_start = res->start - cxled->skip;
> > +	skip_start = res->start - skipped;
> >   	__release_region(&cxlds->dpa_res, res->start, resource_size(res));
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
> >   	cxled->skip = 0;
> >   	cxled->dpa_res = NULL;
> >   	put_device(&cxled->cxld.dev);
> > @@ -267,6 +276,19 @@ static void devm_cxl_dpa_release(struct cxl_endpoint_decoder *cxled)
> >   	__cxl_dpa_release(cxled);
> >   }
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
> >   static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
> >   			     resource_size_t base, resource_size_t len,
> >   			     resource_size_t skipped)
> > @@ -275,7 +297,11 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
> >   	struct cxl_port *port = cxled_to_port(cxled);
> >   	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> >   	struct device *dev = &port->dev;
> > +	struct device *ed_dev = &cxled->cxld.dev;
> > +	struct resource *dpa_res = &cxlds->dpa_res;
> > +	resource_size_t skip_len = 0;
> >   	struct resource *res;
> > +	int rc, index;
> >   
> >   	lockdep_assert_held_write(&cxl_dpa_rwsem);
> >   
> > @@ -304,28 +330,119 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
> >   	}
> >   
> >   	if (skipped) {
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
> Maybe move this entire block to a helper function to reduce the size of 
> the current function and reduce indent levels and improve readability?

:-/

I'll work on breaking it out more.  The logic here is getting kind of
crazy.

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
                                                  ^^^^^^^
						  pmem_res?

> > +					skip_base <= cxlds->pmem_res.end) {

The 2 if statements here are almost exactly the same.  To the point I
wonder if there is a bug.

Navneet,

Why does the code check ram_res the second time but go on to use pmem_res
in the block?

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
> >   		}
> >   	}
> > -	res = __request_region(&cxlds->dpa_res, base, len,
> > -			       dev_name(&cxled->cxld.dev), 0);
> > +
> > +	res = __request_region(dpa_res, base, len, dev_name(ed_dev), 0);
> >   	if (!res) {
> >   		dev_dbg(dev, "decoder%d.%d: failed to reserve allocation\n",
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
> >   		return -EBUSY;
> >   	}
> >   	cxled->dpa_res = res;
> >   	cxled->skip = skipped;
> >   
> > +	for (int mode = CXL_DECODER_DC0; mode <= CXL_DECODER_DC7; mode++) {
> > +		int index = dc_mode_to_region_index(mode);
> > +
> > +		if (resource_contains(&cxlds->dc_res[index], res)) {
> > +			cxled->mode = mode;
> > +			dev_dbg(dev, "decoder%d.%d: %pr mode: %d\n", port->id,
> > +				cxled->cxld.id, cxled->dpa_res, cxled->mode);
> > +			goto success > +		}
> > +	}
> 
> This block should only happen if decoder_mode_is_dc() right? If that's 
> the case, you might be able to refactor it so the 'goto success' isn't 
> necessary.

I'll check.  I looked through this code a couple of times in my review
before posting because I'm not 100% sure I want to see 8 different modes
DC decoders and regions.

I think the 'mode' should be 'DC' with an index in the endpoint decoder to
map DC region that decoder is mapping.  But that change was much bigger to
Navneets code and I wanted to see how others felt about having DC0 - DC7
modes.  My compromise was creating decoder_mode_is_dc().

> 
> >   	if (resource_contains(&cxlds->pmem_res, res))
> >   		cxled->mode = CXL_DECODER_PMEM;
> >   	else if (resource_contains(&cxlds->ram_res, res))
> > @@ -336,9 +453,16 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
> >   		cxled->mode = CXL_DECODER_MIXED;
> >   	}
> >   
> > +success:
> >   	port->hdm_end++;
> >   	get_device(&cxled->cxld.dev);
> >   	return 0;
> > +
> > +error:
> > +	dev_dbg(dev, "decoder%d.%d: failed to reserve skipped space\n",
> > +			port->id, cxled->cxld.id);
> > +	return -EBUSY;
> > +
> >   }
> >   
> >   int devm_cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
> > @@ -429,6 +553,14 @@ int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
> >   	switch (mode) {
> >   	case CXL_DECODER_RAM:
> >   	case CXL_DECODER_PMEM:
> > +	case CXL_DECODER_DC0:
> > +	case CXL_DECODER_DC1:
> > +	case CXL_DECODER_DC2:
> > +	case CXL_DECODER_DC3:
> > +	case CXL_DECODER_DC4:
> > +	case CXL_DECODER_DC5:
> > +	case CXL_DECODER_DC6:
> > +	case CXL_DECODER_DC7:

For example this seems very hacky...

[snip]

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
> >   static int cxl_region_probe(struct device *dev)
> >   {
> >   	struct cxl_region *cxlr = to_cxl_region(dev);
> > @@ -3174,14 +3287,7 @@ static int cxl_region_probe(struct device *dev)
> >   	case CXL_DECODER_PMEM:
> >   		return devm_cxl_add_pmem_region(cxlr);
> >   	case CXL_DECODER_RAM:
> > -		/*
> > -		 * The region can not be manged by CXL if any portion of
> > -		 * it is already online as 'System RAM'
> > -		 */
> > -		if (walk_iomem_res_desc(IORES_DESC_NONE,
> > -					IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
> > -					p->res->start, p->res->end, cxlr,
> > -					is_system_ram) > 0)
> > +		if (region_is_system_ram(cxlr, p))
> 
> Maybe split this change out as a prep patch before the current patch.

That seems reasonable.  But the patch is not so large and the
justification for creating a helper is that we need this same check for DC
regions.  So it seemed ok to leave it like this.  Let me see about
splitting it out.

[snip]

> > diff --git a/drivers/dax/cxl.c b/drivers/dax/cxl.c
> > index ccdf8de85bd5..eb5eb81bfbd7 100644
> > --- a/drivers/dax/cxl.c
> > +++ b/drivers/dax/cxl.c
> > @@ -23,11 +23,15 @@ static int cxl_dax_region_probe(struct device *dev)
> >   	if (!dax_region)
> >   		return -ENOMEM;
> >   
> > +	if (decoder_mode_is_dc(cxlr->mode))
> > +		return 0;
> > +
> >   	data = (struct dev_dax_data) {
> >   		.dax_region = dax_region,
> >   		.id = -1,
> >   		.size = range_len(&cxlr_dax->hpa_range),
> >   	};
> > +
> 
> Stray blank line?

Opps!  Fixed!

Ira
