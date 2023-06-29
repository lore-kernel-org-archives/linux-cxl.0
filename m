Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC0D5EB64D9
	for <linux-cxl@archiver.kernel.org>; Thu, 29 Jun 2023 15:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbjF2PaR (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 29 Jun 2023 11:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbjF2PaQ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 29 Jun 2023 11:30:16 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF732952
        for <linux-cxl@vger.kernel.org>; Thu, 29 Jun 2023 08:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688052613; x=1719588613;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=Wckbm422MmMhE7MnZtXTG3XVR5XgtCDA5CyvHC3M1Uo=;
  b=nlpwMYjbcwyO8aSE2t9/tmiF1CQ0PWmlr35OKa/8Fqg7J7enPkUWGe9q
   BvnQxcqo1vEdM68wCSKgtbLgXE/G08CoDdq8EZCkdHBLhlNywFqy+BtyV
   T8AZkZ7HAmgysVqhYGIGSBscLmLy07fJo37RPz36h9C18QOdvB7rgni8Z
   mqSN3OOGuhCJCfna4uuAPz7vsVNDsTr9lubDzd/iQEYUQ85X5BPMryKyz
   1wBAIZ/QYnMBfYnlVR9wBufkWRFORbyzcdydyM/CHJJUF0J1BRtypsAX7
   tRmF9MpzanucVbsZUImhtrH45PoQVaKj7Xn2gVlemI6AIXqPm9lUhpfsx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="364709390"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="364709390"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2023 08:30:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="782711681"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="782711681"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga008.fm.intel.com with ESMTP; 29 Jun 2023 08:30:12 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 29 Jun 2023 08:30:11 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 29 Jun 2023 08:30:11 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 29 Jun 2023 08:30:11 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 29 Jun 2023 08:30:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iiZDm8u9CzHY+q3M2XO/9ffcBumf7IJcnnScq/fuWsLvqVCTi9npaLul8hAxFJZnqvFplDtWlBdfV7kAo4xNEjCfwVYXgityHtYKZpD8ze4yZzqIkEBW+DdqSgSmhnUbm8Eg15vkgaelQ+POc+f5OHi8+A7165BPujXeTy00IVcDVEmEVLeRER8KOZO7U89VSpltK+wVXvJmwXeB1bevEmvTo4Qb9irxs62SnuDS0dLOvihgU90FVGtl5j2H0ACRCRoqqxHashyn1LtY1/omz5jlqXz4CNVgCZDSMGcgH5Te8oJXIaRSEScwL9xS/O95eiPLHonKDPi+SSG27Nk+hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1sxzoPI1gFb1+Eo33a6Xm/H12F6On2T+6RVwOm5857c=;
 b=XQndNPOYJCHag/zUJ1QVM4Vx3nM08YJqWXMR1IFWZCpe0incjIs23nNxS0S3dGJOfvyyHa8Hixh5j3UTPyxAmT8iBAjnjj2WcpY8cgSCaF6S/8jMzg+m5huhHze/GqkduvVjp1ruxmmNf96GHd8mud3L9yGVQNZbuweH8SYheFTK8Bw2OLcrdXjrPhSiBaWs/gtWV+RtLrBvLu8GC+uGp9zCMXAtoC6Wdgok4Z1902gXI9lbyy0Gcd6pIf7Tz7+DnrUIw8T2vzcZw4JpWWFPuriabjvr9s7jQepAoBhA0EOEmFQBj5zaQBrLoa/JKeeRoP8NPUruzg/v0aFr4aEz7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DM4PR11MB5504.namprd11.prod.outlook.com (2603:10b6:5:39d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Thu, 29 Jun
 2023 15:30:06 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::7237:cab8:f7f:52a5]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::7237:cab8:f7f:52a5%7]) with mapi id 15.20.6521.024; Thu, 29 Jun 2023
 15:30:06 +0000
Date:   Thu, 29 Jun 2023 08:30:00 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     <ira.weiny@intel.com>, Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Dan Williams" <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 0/5] cxl/dcd: Add support for Dynamic Capacity Devices
 (DCD)
Message-ID: <649da378c28a3_968bb29420@iweiny-mobl.notmuch>
References: <20230604-dcd-type2-upstream-v1-0-71b6341bae54@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230604-dcd-type2-upstream-v1-0-71b6341bae54@intel.com>
X-ClientProxiedBy: BYAPR07CA0099.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::40) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DM4PR11MB5504:EE_
X-MS-Office365-Filtering-Correlation-Id: 33715921-aea0-4263-f959-08db78b5b729
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: htshXsVNPqp1F33tdeUTIGuE0hqta5Wdc64+T8LYn2prJ7dTRbE0+1Yu33PtZrhiNxWRivMLa/a89YjWwfmNlRW56bu382naZBOKdGInMsRxG1vgdNqoJ1f0JtPWqBDq8iiMIu3brNXnGcSf/CjihxYRUBrsiOaoxVsxFTbDezYmDW5zJiwHgalC08FA7fyfi2JWpoVfn2wXaXfHIUoR5mEiestg33fG5pe3E2R6cuICNLqKcWWn1x1cs8zxLyPaJOq/crb8Js5jSSAoMDYZM4YmkLfKn3w6cCCAcPvREB49Dx1UvhlERo85Ajy2qniylPHEjtglW6YsMh1mz1/oGLFT9lrzTT9P1xH8JPE4LrKPoC8osHmIWF5uYQCeUUjcOC/R0r1IYDWzNUSvgEamMg6HqOW8ydkHVYeVX+lzlvmOY6PruXvw9E3Xy1FL1gkAuFASvWUaj+htP93xzpMl5mTqlDFWvZQLZ4i5cwYJ51/McbXroPWL2VQn2lajK31Ubo5oQOzO9r/QzRjcsnMPqbm/VrDE5+Df6Ku9pQhL07eu66PX/g6rXrykCoyrRMvw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(366004)(39860400002)(396003)(346002)(451199021)(6506007)(66556008)(6486002)(26005)(6666004)(110136005)(4744005)(6512007)(186003)(2906002)(9686003)(478600001)(44832011)(86362001)(316002)(5660300002)(66476007)(82960400001)(66946007)(8676002)(41300700001)(8936002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Zx18qzcuwGUiHRO+RuYkFoDTFJLtIvU/7pvhScAaolX4HJ6lqGKtgVUSM0AX?=
 =?us-ascii?Q?WZIM9uD72+F4i9h8F758Na3gO0rZ2lomiJbRT6luU6MvzgC60C0dmU/Ng1nP?=
 =?us-ascii?Q?UqgdkBsi9VjOu0SExOL8hqu4VfWllfirRzyjFWey3qt1AaUBAndpQG9GqZo/?=
 =?us-ascii?Q?tAxl2s45/bnZOpbjbffg+lVmJ7vBvYoqP0d8UplKkWhPeMiC6C6wLfJQe4kS?=
 =?us-ascii?Q?o9++nvyPw6/N+lA77rwe+dFpb+P3Z16GI/Z7fqCWnz59Q1JEYB7knYNKv6i+?=
 =?us-ascii?Q?GphXXAA2B3N/4BA0frEPwLOelzXQSIC31+zBo5WaGDECDn0WZZ/AqxFaRzus?=
 =?us-ascii?Q?YLlaOOOzXUseMclx3i/QpwLLmmMEYvoartwUY4EoiGk3LyZJrSeX4Pv0/Z8F?=
 =?us-ascii?Q?HX0lIPKoCMa4CXNrXivnCS7Rhzw0oNXQPOY1EB2L4lA4CM6BkzT8Kig2HmNq?=
 =?us-ascii?Q?6oWU1/9pJfMs/pTH9uwL2QvlLHm8oEkud1NjPpILoDx/pHC2PsNjZJ+r1qP0?=
 =?us-ascii?Q?C4Z8PsoJ4JPKS4s21Nei/UmomGK2npl+rqZ3YjPveUvXt+BPBJJMHEWMgjNB?=
 =?us-ascii?Q?9pGQSWCtPvyvo3XRMh6eoGriOXZ7aTJCf8JtMnmtbsv2lPaSdHp1njr629zZ?=
 =?us-ascii?Q?Mb0ChLsgwik7pRDPiJfRkSTC22di68sfLuj7oU+8sex8s14d+DZwGIu4Mxfu?=
 =?us-ascii?Q?mLjcFF2TbNWu+zjnsQTd7wVY474qIErq/gbzIdG4bz+tlvJFn1Y4S5tqlUxY?=
 =?us-ascii?Q?RhpZiDA2EA7s9QXZUzvh5dD/0qkbJ2ZbMtW1QwxkAnsWD1txmGYzEvSt7ruZ?=
 =?us-ascii?Q?mjoq+r7v02XBG6SGiPrLwCHKemED4n5oSsdDIJHj1hk7GFRTCc6hmMSerFB/?=
 =?us-ascii?Q?nilMsyjyMBetFJGHc4LoxwDY9wXDEBlvI32gwXLm+I1YKf6SS+e14wd1Qr9X?=
 =?us-ascii?Q?sCTYaNlt040VcpbZLdls5/RPGnomBHuXVk0xlOevjBfQ7Np/T0VGCPGaqLGS?=
 =?us-ascii?Q?YfXQ6EhvE93qdjrXTSqa/3uYfWXrMs1qDm79AQWPkjB2/fDjChMyh4l2gWq/?=
 =?us-ascii?Q?N4z6xkNmpindxschE9Uhlnd9KMQaqoVD1rVRi4ER4gOmmjvgVI1kvzAQoLrj?=
 =?us-ascii?Q?pftR3MFKMpHwtgSm9sZT+XvMo1ErfffNq9F2li0GjWxAZbUftWPBFK5JPSc4?=
 =?us-ascii?Q?iqKxzU+wY0/SRZz029GAMneGv6oC06Rc9L8x8XWDFy+fiv6o2boLkkxGAx2J?=
 =?us-ascii?Q?m0MPf+ABI6H2GVdkU75mekJSd50LdMlJ2JdFpqOO6RtZPH9AlvmZwavhJdvY?=
 =?us-ascii?Q?Ug/rtaaWBGTZqH2rpW+lxjuI4ldCi6mq40FhcLt7TLgcqchIhrwneD9tkwQi?=
 =?us-ascii?Q?4sEnxLCIVHjmK+/2WV3iEc0++Nd2yTwj0AtdE/G03w9hNmG2Fe+JrVrmFRwa?=
 =?us-ascii?Q?2xKJfMVrJXXxWv1Wzs8gwVfxQT519+NRBpi53OkRmFzLdIEz1ph8HWja+mYJ?=
 =?us-ascii?Q?5Uok3kPeMkfer0BQ25Oqh5szp5FscImUTHTtSclyOpCrm/gcbZvl16ogl5x4?=
 =?us-ascii?Q?VNwWmfr3qGL80ynNv9b11ELcCqv2HkWJEtAxGAtA?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 33715921-aea0-4263-f959-08db78b5b729
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 15:30:06.2467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U5+5cS0bmVv23DXvvaqqOEaI4U8Z44a3vHQwOL1/g43ZoaClm/Z5NyGpKB62EEWv36zIf3Hemeh4uQfweL+ikg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5504
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

ira.weiny@ wrote:
> I'm submitting these on behalf of Navneet.  There was a round of
> internal discussion which left a few questions but we want to get the
> public discussion going.  A first public preview was posted by Dan.[1]

There has been a lot of review on this series so far.  Thank you!  At this
point a number of issues have been pointed out which is requiring some
extensive and careful rework of the series.

In the interest of saving folks time.  Any further review should focus on
the ABI or other big architectural issues.

The next version should be much improved, mostly due to the feedback we
have gotten thus far.  :-D

Thanks,
Ira
