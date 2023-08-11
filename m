Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ACCBC001B0
	for <linux-cxl@archiver.kernel.org>; Fri, 11 Aug 2023 19:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234847AbjHKTze (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 11 Aug 2023 15:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjHKTzd (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 11 Aug 2023 15:55:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8FD2D43
        for <linux-cxl@vger.kernel.org>; Fri, 11 Aug 2023 12:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691783730; x=1723319730;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=a4FUcgjPeD3x/pFJbc3Itee++4Ut0g5wQVtiCUGLcgY=;
  b=XfOOvEHAblRgeAopBh6Y1QJPjUrpDloJ20lsM6J2q6etynAqPUByAPr5
   gpUGDaFWRPVLN+1JKFw5cbNsvF5f85UbLZlknkAV67ihIDsXjyhLzQjoy
   QtQGNDBOqIOEVGEPLRH6WjbKlDX43KUsnDgGxyhG1chDLssTMa3rOkp/F
   Dh/NvfoxcnZwFaSLwxbNW2tMtPx61J89Ch6FxrSpYh/INAPVtyoYQ4tpM
   VrxLqJ7fwBJ36ykeMfLJ2aQxVBMUT+nU9TVz9rJyeRKfcD692AckwLWSu
   2LBkjIZMYTiT67qWRdp4t5fYntQIyu+GkMrmiD+FQDSf5qIjGrLjzH7U9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="402729570"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="402729570"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 12:55:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="798145089"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="798145089"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP; 11 Aug 2023 12:55:29 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 11 Aug 2023 12:55:29 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 11 Aug 2023 12:55:29 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 11 Aug 2023 12:55:29 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 11 Aug 2023 12:55:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zavoy+jIrCacRzrXnbePjBBH8JWl99m/fROrR9jIdkPaXxRPuMnP40QgAKQQysKDrjDN4DstvqSa23Hi+3GXlhHEJSNalxrgqLskHgK2UZ30uFjtsWetVOZz0txShMATgyQJ7D5H0V522dkcYi4B27Pi617ZSqHF1W91f5R4TXgBpS13/nqcUjuTWhiGK8jmvmwXiQl1f0BjjxWk61UEQ3hKt95qg5XVlecTBPTBWCqjSovPNq0xFrRuoc/G2jtwbnEqCRGc/6YQ4aKSkoDCTTK3j7vSuC+LfRSwi2X4JBON/mxIWxem7wkY8+4EjlAvAEWYJLqJlfXrMqHIsY95bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lfdhltZleDOhnk82lyHLa1k9LggDsTNGbP+GuV9Jsi8=;
 b=Yd7snzMvlYNEUprz8ww9vAl0qDRzwg4BOTq2rTp/XEjOvpExOQ9+dslonYpNFYG/3vp5GlSr/UHZz4H5i2d4KK+8nhU2dohaiCJfQ92jw0K+d5gOZSNc6b9o+yJUOXDEN8nBU1b1dZYVbm5sgClJ3s9TNK0fPP6YAVi6MaIqdagdqHrPNFtqaVlqnrWxxaurAd2s8V/JkP6mMtnW8IWzIdh6hIzI2wV3B761RypzVnOSSTcB3S6xseuRiLuaxpIrAEWOAMSBdOJLSuKU4/CB+crVT2Y0JB4gkpamjnA7ZF5ZM+Jqz7z6WGktldlPlkaZT7qsx4L9NZrYlozdG5pFiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 19:55:27 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938%6]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 19:55:27 +0000
Date:   Fri, 11 Aug 2023 12:55:23 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>, <dan.j.williams@intel.com>
CC:     <ira.weiny@intel.com>, <dave.jiang@intel.com>,
        <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2] cxl/memdev: Decouple security init from
 devm_cxl_add_memdev()
Message-ID: <64d6922b4e6ed_1aed4629414@iweiny-mobl.notmuch>
References: <20230811025755.15103-1-dave@stgolabs.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230811025755.15103-1-dave@stgolabs.net>
X-ClientProxiedBy: BYAPR05CA0072.namprd05.prod.outlook.com
 (2603:10b6:a03:74::49) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH0PR11MB7472:EE_
X-MS-Office365-Filtering-Correlation-Id: f3d9963d-660d-4b11-1c1d-08db9aa4e878
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kukEIp5//MWgafnmFoykzaxGCQgVEkP++xTFbwaI/Jbg+9OJekgRM99iMAyCZ/k2M5OydY9nOZAFpgan82vbSyIV/ELr3A/2r+HkMkgNVKSpNOxORwWqaU7MDVFLIeMuAKvLRadiZ904bWU2xX6l0U5aaVVXF/3lahKwLOJNBmhJ3OkKZZXqJ2MmHQ+oxoVf7WuAKCczZkU+j6bM5EAZJIbLJDTqEPzvTJi8HvqaCdmF39x52BKKdJNvtd09Nz1qDycCa/wVhCw2wu/ZznjL5brdzzJWagRTp/AqHN8lss5aNlqg3g7fyVn4jITIjW0X0xoL0QiLnv8a+/Tro1/2b2u3D048bH+1Mo87MmWUZ+OjbQ1ESySH/WvGbAVX5qYSPuGNLJvmGibSuyL7cCnw/bgnsGpFqUCkWlVY1vMQI8fnB+J2EsUo/srNZ3nq3ool6kgI8f4iTE/6wqv7h9veAApxbQ3q4YxMNgeVoyXdM8R7b9bju/EScdfxInB5/JBo/4sNwP/rYyFdIctSDGp+3/A/osqQPn0stF+oTJUcroI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(376002)(346002)(39860400002)(366004)(186006)(1800799006)(451199021)(5660300002)(6666004)(41300700001)(26005)(82960400001)(44832011)(8936002)(6486002)(8676002)(316002)(6506007)(15650500001)(6636002)(4326008)(66946007)(66476007)(9686003)(66556008)(6512007)(966005)(83380400001)(2906002)(86362001)(38100700002)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DbXoitkYV79rPXpwmRoYMQ5x/E8d+TP5lZC3aY6pmHpVUR5HrUvrdAOy5cIB?=
 =?us-ascii?Q?GZlNkz99fUA0sQqrW2Q0yrKqdQmj8y969o/7txTwGggsFZSdjOaGupcvcajM?=
 =?us-ascii?Q?3MdHGIEaH/aOWGd9EbLL66O50oZkCJyBHLX45c6D9yUORqUxi539PGyAoJQj?=
 =?us-ascii?Q?5URZctOds3VMyhcGLFl4SUSZcMw6dU61iohvJuv3g29a3y3pkK/4l7Ub4e/N?=
 =?us-ascii?Q?rWcy0fuILr0VDqDLesP/G/RIB/nqJzqcKWgg3Qq0ZY/FkSuXfEmcu6syd90k?=
 =?us-ascii?Q?8jwPn3zdnMpN1j6T94J1F3dfDxZG85qZnEqh3+037ZA/6BP/C1AakRkDD9OE?=
 =?us-ascii?Q?G4FXiLWTmM0yt2miuzU6jChG2n2th4AvqZye9lQTuQmPu7jaOgKl1O6C9HKd?=
 =?us-ascii?Q?i21PL5MIv+XjLw8A3qiYznPgZMroFhfLB7BteCDxC612DUHvmdqWuT0XAAAY?=
 =?us-ascii?Q?wKhp6/0ntzxmvKmCJ4UO2xMv5byIqoVB6PhKIlY+nnRVoOQmrhPQrSZtZD8j?=
 =?us-ascii?Q?cc2AzVRwXHUpcNwTIKdNAO+uL85RMA1GnzpL4qDSYQAUQYilUjzE/nneqJhc?=
 =?us-ascii?Q?2Dcl9aMtYuY7+7dUWexHUIgDOuGCGGgooT7toKf4dJrO8u8McNm8kstR1gTM?=
 =?us-ascii?Q?kpOd+eSk4h0yg/1rHQxh8xgoX2leAm68cKwr/qkA+4g7L1zkF19fIbaB9Y6o?=
 =?us-ascii?Q?XxW/dVal4igMP1nYWan4RvbghnM77l9oTsWwHHMNHt+kM6iqzVsi9Mw7b1Dw?=
 =?us-ascii?Q?SBuNZ41dAZTXbpLb0M7MKPbO7Y9ESfSddYgNYEPQ/93txuZf42Wmhp1t6WAD?=
 =?us-ascii?Q?Me2hHSQk909CduCeExzMBRZPY2BhkhE9aVJymjnGy/vZxc+ppBD4fpW3eYjh?=
 =?us-ascii?Q?5iN+Mh1SkbNbtzlNMtJYarI5GXK5cvLGDnoraKWmlPMACweqNp08FVyZn3Ud?=
 =?us-ascii?Q?E3us1GFVshR9NsCvUQV0fvkSKm4NSeCV1iUnrhhoU2rA2IJIzjFI8d+8J85d?=
 =?us-ascii?Q?2M07tnret9WSbDGFcRSYlcbCxMgpoh1QkLEPXRWKebAd1dQgzz8IpzJziVYk?=
 =?us-ascii?Q?KOm55kxWxDelmHPGpN6/a/SMU+djhTOt3nX9C03GbVeAi/Z6IZcJW1VrT4dt?=
 =?us-ascii?Q?a7MoYPxWM0KFhiOQN8Mgo1v2aPzWkqxy1/QmyDyHdnJa9bpxAwFnNs/Poql6?=
 =?us-ascii?Q?jKai9r4kaHIdRo+PAnm6TIeNaXY60cIuJ1tfINbzzI2sstnazUKpvISfEtFP?=
 =?us-ascii?Q?mnCLg+sSVz9yVlf4FCC4/hEnn0WfVh/nW46qv8uTcXz1/06nXkFerX3wPnn9?=
 =?us-ascii?Q?OK9hlP2FTpRBuSgPOG1MGjw0Abg0b1F8ROzmPQSY4ZDm6o/fvSxk/G9/G3d+?=
 =?us-ascii?Q?Q0H8OqI6mFlrZhcPf3ogBoW6pVr8tXvsiUZAjjcqRaVLhXoPyrOxxJm2upnN?=
 =?us-ascii?Q?rVnxsiNVLh2jln/XQJVy7IcgmJdfpW3hf0X/xhRePhRoEO623f65nRfOglI5?=
 =?us-ascii?Q?OltqQBsvzmlHMn1ETMt7yAjBqpjcYOLXjpdDuUg2Yuu0/5DQ7S++CVVyN/7F?=
 =?us-ascii?Q?rcaUOw2BsJr9VU4GHQ8JL7C+HVLv2wCmMzKK384n?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f3d9963d-660d-4b11-1c1d-08db9aa4e878
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 19:55:27.0158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s0OkCOzvFAZl5YfcsbVganlkc/hxvSB6ZCcS2N8lAOpSq3vJVUEl0wpLnyfqHBzUOl2Crfq3UabjSPnNYQzXYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7472
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Davidlohr Bueso wrote:
> A crash was reported during type2 device enablement[0] which called
> devm_cxl_add_memdev() without an mds, causing the security state
> init steps to be bogus.
> 
>   BUG: kernel NULL pointer dereference, address: 0000000000000278
>   [...]
>   RIP: 0010:devm_cxl_add_memdev+0x1de/0x2c0 [cxl_core]
>   [...]
>   Call Trace:
>    <TASK>
>    ? __die+0x1f/0x70
>    ? page_fault_oops+0x149/0x420
>    ? fixup_exception+0x22/0x310
>    ? kernelmode_fixup_or_oops+0x84/0x110
>    ? exc_page_fault+0x6d/0x150
>    ? asm_exc_page_fault+0x22/0x30
>    ? devm_cxl_add_memdev+0x1de/0x2c0 [cxl_core]
>    cxl_mock_mem_probe+0x632/0x870 [cxl_mock_mem]
>    platform_probe+0x40/0x90
>    really_probe+0x19e/0x3e0
>    ? __pfx___driver_attach+0x10/0x10
>    __driver_probe_device+0x78/0x160
>    driver_probe_device+0x1f/0x90
>    __driver_attach+0xce/0x1c0
>    bus_for_each_dev+0x63/0xa0
>    bus_add_driver+0x112/0x210
>    driver_register+0x55/0x100
>    ? __pfx_cxl_mock_mem_driver_init+0x10/0x10 [cxl_mock_mem]
>    [...]
> 
> Move out cxl_memdev_security_init() and allow the pci probing to call
> it directly. This is more aligned with the intention of f6b8ab32e3ec
> ("cxl/memdev: Make mailbox functionality optional").
> 
> The cxl_memdev_security_shutdown() counterpart is removed altogether
> and handle the sanitation corner case directly in the unregister. In
> addition, the devm_cxl_add_memdev() cleanup path case is about ioctls,
> and regardless, there is no way for the sanitation to become active
> during that time.
> 
> [0] https://lore.kernel.org/all/168592160379.1948938.12863272903570476312.stgit@dwillia2-xfh.jf.intel.com/
> 
> Reported-by: Ira Weiny <ira.weiny@intel.com>
> Tested-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
> Changes from v1:
>  - Picked up tags.
>  - Add missing EXPORT_SYMBOL_NS_GPL.
>  - Kill the shutdown function.
>  - Fix typo in changelog.
> 
