Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6679CD37B0
	for <linux-cxl@archiver.kernel.org>; Mon, 18 Sep 2023 17:49:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjIRRtn (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 18 Sep 2023 13:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbjIRRtn (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 18 Sep 2023 13:49:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5132A103
        for <linux-cxl@vger.kernel.org>; Mon, 18 Sep 2023 10:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695059377; x=1726595377;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=VzetWLB6fgcNcF4Sv9ziZZ+IPEx3Je2LX2GeWhFwz5w=;
  b=COQZut4BirCarDGaPiW0mIVfpIXziVlFGvbGUvmWqkmplPqFAXYMDC/j
   ZSpi51sLPcxkdOyU/qoc4N5KL3+7oKcVqlVgC4//UlSCZeK9sNfcqCvTT
   0AjllucymUjfei2sL9ABQYseAhj9fqTLBCPdHf/N3WCNsyb++HWuHRwZg
   44oJ6dj7DmqvIDS1qf4/m5Aw/zc9482geemqxZ4ACpVgWIYv2igzBbfAj
   6xJ9U7M58m1IOAdB4flHx3VrXp2/Uyq+VYCKSIizk3tpJnpLvhKxE9HXT
   rkeG3+m2nZwm1OlJcTsvSWQp5ICltIM7sGOX2a8dI5WDU9ywTqY6f6TwN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="359981610"
X-IronPort-AV: E=Sophos;i="6.02,157,1688454000"; 
   d="scan'208";a="359981610"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 10:49:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="780989710"
X-IronPort-AV: E=Sophos;i="6.02,157,1688454000"; 
   d="scan'208";a="780989710"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Sep 2023 10:49:36 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 18 Sep 2023 10:49:36 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 18 Sep 2023 10:49:35 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 18 Sep 2023 10:49:35 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 18 Sep 2023 10:49:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PxC2jRQoxxOKyJIVqpAEp9f5vVHQCQDc8dAzHbFq7akKzvnAe8Hk/BiOApjzAmklxFYQBRUqN2QXdVkdiHNOYvYHx6/PgtDGBAp6A6tLnPCfExlFmX3d4jZZfRxvH0G7ygeebt73bJtWqYTodTKcQAUnF1j9k3EBRRBnut13xnhcvF8SClbWG+6fFnTOwE8qrrRBT6OQTA26tT7nKxw6oQj7iSQOOXrtRHmaX0p56rsHOwwipKIWVzKi66oN3uAQ9UQCKSzE8eKskrEK2aM7oyh+HO3ktUD9q/LT1LAFWyv+716j/uI1ZDZuOVjvAhSG/vWztpu5p2lToPhgGmdejw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pWqMDUjOchZcU5M9XSvjr9V+qqSBtXxLst427F9+X9k=;
 b=WrwiJy0sxVlwCO8hTO8UGu0jKK+ZTJyRYblrz5Gy0jFfY23+sxSj1YLeJcvncdtR7EmAiEvX9v9q8o6CKYFk4Kc9jgN0oeeIuUjj0bCtUrP9jDNJUwMSqZQFEHm7MV1fB8YJSTKJzawEE1S9S69n+XERSeRej88mc4rwGFH7zxVIrB5qWsgHqw0xT2/OsH9eQrdqxfZUUpvWj1byQZzujKOMbZ11jGdA4AvHYFruaSxQcfuk0YtZ0QJ4aBp21iP1yIqvylUJ9DTOuCQcs+mCpEuX/inVIvH1wts13VAu9gwwKJcLapZSAW50c9WnmfbgaoqJDFtaS2KjNQ9CgP9H/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by IA1PR11MB8174.namprd11.prod.outlook.com (2603:10b6:208:450::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Mon, 18 Sep
 2023 17:49:32 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938%6]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 17:49:32 +0000
Date:   Mon, 18 Sep 2023 10:49:28 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
        <linux-cxl@vger.kernel.org>
CC:     <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
        <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <dan.j.williams@intel.com>
Subject: Re: [PATCH 1/2] cxl: Move command enumeration from dev_dbg() to
 traceevent
Message-ID: <65088da8ea533_3921be29438@iweiny-mobl.notmuch>
References: <169480882977.2690926.2796694282356938267.stgit@djiang5-mobl3>
 <6504d69a10453_37d9bb294a1@iweiny-mobl.notmuch>
 <1b66b8ae-143d-b227-27de-988ee9f0ce04@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1b66b8ae-143d-b227-27de-988ee9f0ce04@intel.com>
X-ClientProxiedBy: BYAPR07CA0098.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::39) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|IA1PR11MB8174:EE_
X-MS-Office365-Filtering-Correlation-Id: b3c9f39d-847c-45b6-9a22-08dbb86f9d68
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yUvMvx9T7MG2SaYyp3tOuRWNe2Zrs+W4ZXbBVO7asoGQuDMsNH3f1w5Wqy+ruYu9sZ2je0PLLrUbod+zJKb0Y5UbeIHsxjD4yof/aWYGjhG97t9VUgDfUsFsNLhCCeiYJWmf7K3Q45PT4RL4WAB+RA5GRzECfPxLguGpFwd47R5MJqL3geYeZwBOs/IZIiEZjRAUjiErG+augFZ7RClWKM8AVtBu8Mvk5kI0WiSqWAOV4U6HA9rzIa9gVx8Fo78GT5yjFmSEgZC3M8WWm3we5mSanMbvIqOuy3QvJUf2lI7C9AUTraMdJprbQj2FZDBXhVX82daPuGSiCwVCwDSErQfBY6gT732cRARGiGPaTpfkDJD6Z20Z0ckA7Q4e+XUiqCnCuYP4XyutioTrdiv9hqkPpvNx6thvh6orEj78rDt2H/geFjokdK7FsF1qZj82LgqVElIVTeJRp5D2+q+qhhyuCA+CmlhL/se5TAhLT0s+6xc0nnxfClWqNvKTEAHD/Fx9uSeIhgGryq+8b5qkgDpPrarH5OIRK9tL/70hVBk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(346002)(136003)(376002)(186009)(1800799009)(451199024)(26005)(107886003)(6506007)(6486002)(53546011)(9686003)(6512007)(82960400001)(86362001)(38100700002)(83380400001)(44832011)(5660300002)(110136005)(478600001)(966005)(41300700001)(66946007)(66476007)(66556008)(316002)(8676002)(8936002)(4326008)(6666004)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?leAChtVQeAiZycEvjvzxcXDOJ0PHXWSz/JzawUZbpoY0J0ru9DMmL8r+Y4fC?=
 =?us-ascii?Q?v0TZ+2xpOdIryUTfCywdggAqdAcgHTiYpXiWiVoczxRGpCSlL6I/M5sy3UlF?=
 =?us-ascii?Q?HYSwEHB8uvgvkHlaodOwsf2sIwBmwXZanuxOJpJcKlA728/e7rddDXq2bnFp?=
 =?us-ascii?Q?h/irjfGjj9afF9XYjLGjTXtt/dwbfuJeagAIxoBY1AwYrefTYvjmAFO26UR4?=
 =?us-ascii?Q?rUZyfqHefnFLPf9IYCJU6788TOFCrN53/HJmMXYF9PLFie9z67rQJXMEnNub?=
 =?us-ascii?Q?tM4c263+fbHe+9GkEAHDziy8L+lQvYIzWxSWOACyBQ/Ykj5pkvoLcNsKJxs+?=
 =?us-ascii?Q?44LndCj/eWY3kBA68xFvogtQn1Ci9Vibbi+jr3D7A3lkSGMhxrbB9WBVm/lM?=
 =?us-ascii?Q?7lPfjSS8ehHQL2V+Y21ahMfcy9DzULvu7taWleBCLQ5KkpkmS3hgOib4AnP7?=
 =?us-ascii?Q?7dVzfkdAhMHXkXULq0hmMGuzN1C4z8j2vLjP9azg9AN2QCRhM13JQn0mGkrk?=
 =?us-ascii?Q?8hZyNjw89CuaeuYcjCWQ5CnuUPT3gMjJAY21RVkqqK/BR+/16R0YOiqy1d+1?=
 =?us-ascii?Q?fJovrDgwPmrj/YK7LJNugKgjeR5sZ9ddgYcpP8xRA6hw5UbpBXEDniWJsfxW?=
 =?us-ascii?Q?wwACECxuWCAIdXh26/D4APOGDZTCxQf+rsYjeWbUpkafAAhqVjCOAvGGgpa0?=
 =?us-ascii?Q?ggYzrZfTRXuOiaoyd0N45vjyb7bYa9G2T6HBoWNymPEcLpj7qLNQwKU6JNYb?=
 =?us-ascii?Q?jOWNxpr/n3l9hL8mG2lRF8oKErp30AZTNXDrp99iFc23q6hSvmjW38htEPpE?=
 =?us-ascii?Q?o86EdS3ILsd+dPzP5HgHVvgdAZJ2cHvlYl+28YqvV6IwqS107AgEaYE34sZO?=
 =?us-ascii?Q?ddNwBWrsAcD/qVnPVx98IRZNNEGZOWz3hV+RELuSiAhQQQNEpifYFAvHJTok?=
 =?us-ascii?Q?TITbZi74jRXC4aB+is6I9hyrCO8/tXXzbeo6e4pkFNQbD72WKoqJ9kE2YRWT?=
 =?us-ascii?Q?XfpTqal2jf1BBp268jelAJw5BJkntZmvA8a697r/iqLAW47XuCqes7qor05B?=
 =?us-ascii?Q?CBZppIwdTSt0OQWeeb/jEXr/Gt8XZnVsM8g6fWwrFFSxX+RNqGIv+OGxvtTT?=
 =?us-ascii?Q?cbuUtkBclw3mzqC3eccx/FcdBd6i5C4lqjQjC1JjHfbpE668YPgaetOE6HYh?=
 =?us-ascii?Q?b5oSTmQRpjHVCGFwU/4Gfg8oIuiqLUwhpjDI/ytOlQvzzR6BEsz9rLQaewOZ?=
 =?us-ascii?Q?bKhFhlXIxNmeSYzwlAUp7357Wx/JAionW3fYO0xNktKbQn7p2uIWYtaK+V0M?=
 =?us-ascii?Q?SNej/ozZPHV/VLHvrOi/+fnUjXnIjTGBJmx21hzTEWdxtUogtwoxeJKeVkms?=
 =?us-ascii?Q?7Sp1K9L1EHVC6sCN5McHHfP87BmjPnHaSeWBRr3D5rcXbgw/B0m7MvszwBC4?=
 =?us-ascii?Q?zEKcAAzn3CfbvZ2EhfQHs652HYQ3uuN+AeTXTXusFrnmJ28Ei/lpZohpdXeN?=
 =?us-ascii?Q?Y2JA+TswEcLqgvbEXN7rO9V8vzIP2kRIVPy7R36Yhh4RSk4wiZEQyLJ4wxdY?=
 =?us-ascii?Q?Do67IeysvWh53ZnuW92kUFGYJH/A201dYkwGSe4p?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b3c9f39d-847c-45b6-9a22-08dbb86f9d68
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 17:49:32.6590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GDFn4LS4twcKbgggGqtXPn/ZIyKF5FxT0ugY6M8YctGNPXEM2JyE3vD3EMrsDmmQ/3a6f69XlW0hT1BEzvAz/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8174
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Dave Jiang wrote:
> 
> 
> On 9/15/23 15:11, Ira Weiny wrote:
> > Dave Jiang wrote:
> > 

[snip]

> > My gut reaction was to nak this patch because I'm not sure how to enable
> > trace events prior to module load.  Then I realized that this is in the
> > cxl_core and is only triggered by driver loads.  So I've not tested this
> > patch but I think the following sequence will work for these 2 patches.
> > 
> > $ modprobe cxl_core
> > $ echo 1 > /sys/kernel/tracing/events/cxl/cxl_log_type/enable
> > $ modprobe cxl_pci
> 
> I don't see any other way to do this. I saw this [1] but it doesn't appeared to be upstream.
> 
> [1]: https://lwn.net/Articles/432186/
> 
> > 
> > Is that how you tested this?  It seems like a pain.  But perhaps that pain
> > is fine because these debug messages are not as useful as others?
> > Especially for all the unsupported messages mentioned in patch 2?
> 
> Yes. Alison mentioned seeing maybe 500+ of those.

Ok it seems reasonable to me.  But perhaps we can document the above method
somewhere?  Not sure if the commit message is the best place but it is better
than nothing.

Thanks,
Ira
