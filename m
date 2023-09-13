Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E41CA0ED1
	for <linux-cxl@archiver.kernel.org>; Wed, 13 Sep 2023 03:48:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234124AbjIMDsV (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 12 Sep 2023 23:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjIMDsU (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 12 Sep 2023 23:48:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6301723
        for <linux-cxl@vger.kernel.org>; Tue, 12 Sep 2023 20:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694576896; x=1726112896;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=zUVUF8J86BSxWuSb+dMP5zPWVj5hXzusuaR9G7OTDNU=;
  b=T43Y05t/twgdMpmzqkzkroox2PS6dTh+QX5R97sIe5gDrG5Q3INkDbC/
   Cf3hi8eQfGQO6AQHV4JEsFYN0piY1QDwRywFFxUxe3OCGr4SzBd8hsy8j
   hLqC/dkKiBl33sKcHnlz+YCaV2z9k2nuBxIGlTIDarUv+J6mvQVUmHpQ6
   PXqpoQfTKLio9dfvbVnn2l1tDHkGDwH0jKsjsOR6Aw5U41v9yAS7BHfjP
   bggLjublcs/xa5BpyS9ZoOmE1uxKGaCme6dLptkiY0K4Gc3arButO5Azx
   fLvEtLknevbBi9hXJewQgJ4rVUYzbAz2ysvhKi6unFJdqkfV3vbB4Yka1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="363590437"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="363590437"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 20:48:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="693707220"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="693707220"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Sep 2023 20:48:16 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 12 Sep 2023 20:48:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 12 Sep 2023 20:48:15 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 12 Sep 2023 20:48:15 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 12 Sep 2023 20:48:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FZEy8mM871QCYOGThMc54+7cps4tb7em+rlamYIP8PLYKaUy6Q8X7gJJ/kGLpmsjiRnXiB1uWWS+XpuztdOdaXm2R+hiajfWjj3U0gpeBttFandB/tUMnm1YA/S83zk3pviJJ6UeeEjGHiMmF7pYqqO+UwQL6ubJSRiYjjIxtCDI3t2CgcW7m8NW5R52oD9FrlHR7gtcgB8ZytjLypwDxioFJRVBqckI50t8q1pJ7XmQ+1vTb0zw/8uVKwPOMVU4wiVQJBHKSVMxuvZ7Fc53p7o2CamV5PqfSEJUE9eImkVpbr8mgMXqJE9pt0QdVK6WKQuby6R1+dQ1XLzbjXhsGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nO8KXMp6URUIqbIIjm0rsxKqXQlronljG/dlh1gkOUc=;
 b=D0hewr5KJIGE5cpZsHS4FjTDC+w+gvGbZBvK34/xCJgnooSw2jXCwKekVqOFgnZvqwo7L57xMvx3UQGhKCuhPWu42OkASM1b7fW6p89B4Rk3xzaHyac6P0pGEVnqZeEVkM8mN52e2A+6+mPPOLk7QQPJKpYhPDjObfTScdgUOP53K2OekY1R2/nqNRdl3rWkA0uQmHasR+Lsm/QfNDuChMYH6L1kFMl0/Hfq/uiPsb9mJVZWoigAQH7jUcPifbvfr1TK6GWrvSkt+fLIxJiRA4SXG568lI5b5bijHcPztzLBVQIQtHfLCoqJyAI5rY8Fs4A1o/pwj6hggukVrVKfMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA2PR11MB4988.namprd11.prod.outlook.com (2603:10b6:806:f8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.38; Wed, 13 Sep
 2023 03:48:08 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992%5]) with mapi id 15.20.6768.029; Wed, 13 Sep 2023
 03:48:08 +0000
Date:   Tue, 12 Sep 2023 20:48:05 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Alexis Gryta <alexis.gryta@liquid-markets.com>,
        <linux-cxl@vger.kernel.org>
Subject: RE: [CXL DAX Question]: How to change the memory-type/cache policy?
Message-ID: <650130f57c37e_71e58294fd@dwillia2-xfh.jf.intel.com.notmuch>
References: <CAPtxMzOiKZXBrY4KXbQiRHaS0Kx8N0_La-1P=G3eo=3Vk6Jzjg@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAPtxMzOiKZXBrY4KXbQiRHaS0Kx8N0_La-1P=G3eo=3Vk6Jzjg@mail.gmail.com>
X-ClientProxiedBy: MW4PR04CA0171.namprd04.prod.outlook.com
 (2603:10b6:303:85::26) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA2PR11MB4988:EE_
X-MS-Office365-Filtering-Correlation-Id: e328694b-88aa-4d0a-4897-08dbb40c3e1b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 22kq0G6nFMqIoYYMw/+ONKUx1V15UWeJPECZHXO8EFHTVnH4zcxaoFE26+e2ov1jyH19rWM5KP5D+qWRnUGpRx62xa7EjvAetp6v0ri9YmNh6/x5KncJbxOkrjkBS7//AL3rS4QJn+ooP+ocsLkjJ0nOB7s9hapByUh+0+sy6cL/oYmlgLyUCZR0dul/zA1mPMFByjFQ+ubDR71iUI3m+ZDyT0Nw+noUw3dljSy07YUROKSG2AGH0JO9gQZXJwUhhUXHATvlLKHu6PW1LLMXyMwHnOgzJP7ZT6SuQ4GhNg8WcQ5820ht8EMO/nrzm3iNm7whPovy4OsyXw+JpRybpbN7mJp1FkLpBM74WreHa2K9GJSq2d9a3fix+HmG0ZbiNmI6+WeInc7ART9rz+yWgijEY9p1ui6gwA4Y2XiLZNaEePtg0aVCLIWjZg6eyEeCrPJ9oQ3LRL+v6nRX7U1vfqjkOyt3JpFqLGbyEL+510ZNrSSUGjsWCWBaWrePIJbg6BtSGmpSxGzw0N0pVNmQMAObeRcmsUynIegM0YQQKOInCwg6D9GI6/AR4AH3WgH0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(396003)(39860400002)(366004)(186009)(1800799009)(451199024)(66556008)(2906002)(38100700002)(82960400001)(86362001)(5660300002)(478600001)(8676002)(41300700001)(8936002)(83380400001)(66476007)(26005)(6512007)(9686003)(6486002)(316002)(6506007)(6666004)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fPlH+pYGgc8gOIZzBFKHkizqUvNMKSh+fBtKpvZ5CkQksAVmcTzrjsjQkjsw?=
 =?us-ascii?Q?Vl3L5hOG3A2tqDVY/M7yBd3W0p+q/AEWwyW14TomuqSPvNClGi7UtBN1LRhg?=
 =?us-ascii?Q?CaZW38mZUAjy5SPs5+WjooevZj4LzT5GlXyPJK6p5xvboPTn9lgDigBWlqWZ?=
 =?us-ascii?Q?iyzVw6VIcZpFiF8py/UEbDW1VtLREABZJXaXWmKiUJpwiuhNR4MLo81VLVcl?=
 =?us-ascii?Q?TQNMSpHvuWjnlAlLWqwP/YC3TeIcKbbmtY4yU++LuWWx/oeDAdRmEDLxvoXa?=
 =?us-ascii?Q?OHxe0yNwcIkQoGAMtDGQXNCgEOwVJL5fcQhOHQ0f13iOT2PsLBNCv5Z3KHm3?=
 =?us-ascii?Q?24ZJllaJ3y4aoFpNDxeP+dmrNIHLBoyUh25wXAp3vys7PXY1fZspBculyhCf?=
 =?us-ascii?Q?/xgCdNcVSKc+qj654Hfi4GUKKKY6Rq9C6Gk/u0k0GwRwGLkC2j5UUdixvb+2?=
 =?us-ascii?Q?q80Ln88WMQYhMc1YIfCk7AHL7TLv0TEu46yUmp1/wMd2vHdlOAxDbMFCNwoW?=
 =?us-ascii?Q?XrPDKF08nC9Ksi/e2JxOtDQRC7qGBEHWltMGQca5u6M2g+Ld3h76Fd9DLFbR?=
 =?us-ascii?Q?NZ4UF0BlPVeZaCu3z1MTE9aTtXN6bYrr0ebyw3T/2fblBcRWmE1cyHl4pqLC?=
 =?us-ascii?Q?Y5uxyILYptUjWseYW7xo/29LlCzp/2bhqurlrtJaqxwrfG59NGYb8k3tZgy1?=
 =?us-ascii?Q?WwwB4Swr7/7P2HhnejUWhY3m5OwYiXUy0ALakl6/B0AWGkeE0B3aXA+ZLZVY?=
 =?us-ascii?Q?8WIeLmadHooQhkrrWLTFOKKYJq1UG8kGlLJ4BUI57DH0qWiuMbebMZ5yvQA+?=
 =?us-ascii?Q?o2eBzF7uCPjBOuJVHknTT+yrLmKxgIJnD0PJam6wKK7AJqyP8B/wZj5HNh87?=
 =?us-ascii?Q?PwzotO8sweXD09uCq3eH+bw9vzYPfRswSWRyHO+cvuQy9afB7WZntRk271hN?=
 =?us-ascii?Q?VA8zN/EHxqjG3g/Upgw6DKOZ6GTOAYYrKUh41RGnlVgTjsWlBGc2gsod7oYS?=
 =?us-ascii?Q?B5toDq+ZQrUCke3Q4wbo/ClKQVclA9dGdSnF5+hEto+XGIAOpK4uAKX9Jpwf?=
 =?us-ascii?Q?03dNjG7QZyRm4xrSgYnjJWbhRoFgmoixa1J6g8k+SmU0FYWdhhpxG5tIvCLN?=
 =?us-ascii?Q?4H+LTG+QgicU3paxvOSXflsALF4BjIB8OXel2GedyW2Iv+QqXnEZ1091euAU?=
 =?us-ascii?Q?UI00Od90ZcoB1Sb0c5kRGZulXA12tyAITrVTUzazsCw2IoVvOI4vi1inlcne?=
 =?us-ascii?Q?/SDG35Lxl+5Ouuq3BuPZCq3izIhLhTjaQPufLYebTWmqnhRIPUdN5uYoQfyD?=
 =?us-ascii?Q?q1Nr8i8xnq7qvhxG4PWGCsLaoFRjl4LSWCGDJZUb1cFs+B5NmmdYuaWJrMgs?=
 =?us-ascii?Q?7gs0hZy3A4qr/cHbX06yu8jr7LqhCePT/2GuNP5wjZRz/K/yweart9XYauCP?=
 =?us-ascii?Q?drOmAeJ12UZKbGVoRAbppTaJH/WKF14NpEXyUmp6A4TRXQiUHVgkF0GUF7r1?=
 =?us-ascii?Q?zMmXFjP9a/I9alW2FxHhWy6jchBCivIpeoYiqSWwFmc0DmuPpJ/3K+PdXte/?=
 =?us-ascii?Q?nd623QN6fFijnCabnARU5vy7+umk+5/Yq1O+V0V4Li473G9z/yJ+6foHOgLD?=
 =?us-ascii?Q?OQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e328694b-88aa-4d0a-4897-08dbb40c3e1b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 03:48:07.9616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TIR955w1WxXNHNygKCjLtLX9komyf+/gV8lJRMT1M/1t5wF4br3Eshza/huWJfnkSBSAUQy10P9D7BjBz/6w09mfoP+WOfNgq3+8y0Q2xmo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4988
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hey Alexis,

I missed this earlier.

Alexis Gryta wrote:
> Hello,
> 
> It is my first message to this mailing list, sorry in advance for any
> mistake I may make.

Looks good, text formatted with proper line breaks. That's usually half
the battle. The other half of the battle is inline replies.

> I use a CXL Type3 device configured as devdax and I can see and use
> the /dev/dax0.0 device file. Nevertheless, it seems the memory-type is
> by default set to write-back.
> To avoid using the native instruction CLFLUSH and to avoid the
> speculative prefetchs, I would like to set it to WC or UC.

To date the expectation is that all the memory ranges registered with
device-dax are suitable to also be used as System RAM which expects WB
mappings throughout.

> Is there any plan to add an option to "daxctl reconfigure-device"? At
> least for mode=devdax? What could be a production-compatible
> alternative?

The "device memory" examples in the kernel that are not using WB
mappings are also not using device-dax. Those are mostly accelerators
(see other users of memremap_pages()), and have their own drivers and
ABIs like GPUs and graphics stacks.

So that's my initial reaction / starting position, at the point where
you need a non-WB semantic to the memory on your device it likely wants
a different ABI than device-dax.
