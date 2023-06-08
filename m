Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D44C7EE37
	for <linux-cxl@archiver.kernel.org>; Thu,  8 Jun 2023 15:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237200AbjFHPoE (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 8 Jun 2023 11:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237142AbjFHPns (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 8 Jun 2023 11:43:48 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D5B2D78
        for <linux-cxl@vger.kernel.org>; Thu,  8 Jun 2023 08:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686239015; x=1717775015;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=A1t1+MknLwWpTxQRmh9U05w4/DizYJcLe1G5PYLNom0=;
  b=mNnZqRQDVO3JpddvoRzRq0ICVWOO85qEm02Csg/UoG4HiAKzSejkARUn
   knePkidZVC0d6FuN4Y3TxCHnwI92oPUuz/Y0Lboqkp3oQfZilnE0rbglf
   dXQNPwvRXZrho+l38jzOcxYHbVS6sC1GbjTNVvJ2OP8Wd3LKEqUHVuCBL
   m6dDr5o5kJCdNF4ix+e7R23R1xC2lsh/UoReYj+EvFPkXiJtCNTZYWAmR
   POu7INxkuSvV23fihS2p1yu7x2ymcrHzzZSH/wOILslhTmyWIoIGsE04k
   LkB5lHYwWDFu7xhKQWswRDfDwPOPuIgvI5vCNbNSq3Gc6Uzltw527M+fG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="354831918"
X-IronPort-AV: E=Sophos;i="6.00,227,1681196400"; 
   d="scan'208";a="354831918"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 08:43:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="775107146"
X-IronPort-AV: E=Sophos;i="6.00,227,1681196400"; 
   d="scan'208";a="775107146"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 08 Jun 2023 08:43:26 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 8 Jun 2023 08:43:24 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 8 Jun 2023 08:43:23 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 8 Jun 2023 08:43:23 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 8 Jun 2023 08:43:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JsXc0L2qT8NTlGxIwIaMyi+gk3T4l0Ipba/2JDSs8e3CiJKPYVPfs3/ABwsfioqtZQSJc38DKc+JHKIEVPiEzMRoueXiTHzkh/zVlb6t2rUvIJ/VKaLYl2K90xWu48cn4SPNeqHEJ5+ywovM7bfs0fl/l52STH31IZ32nkZ5etcex0PMAWrk9fNQJZ7U5+4OEc82FZZy+a9YtuWUccmliuNotUZ3NvzQBW55+OxvFL2jX5wZm2Sm7rxq9oZnlGhHCmiTsEMhSIVI8dT4L3acpZczMVcDhrl8yNvsbHFjGMdtIMUbmGkCqSyKvvs/ZBQnLyKiDc38p01jOhcBWMqVYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IQtZdN2dkNmFZl8waYwBgpoPjoCIZy5+56yudstrFjI=;
 b=mbj3RkTivfhjKHnvKfVIUNWCPFrbK+ckEg/aQsXMAuEpGaBH2mJT1HRpR1yWbeC71H326lwlbgLd9IPtWJLFHWhJ/QE2ipbNaHw9qCMU3jARWqYm9FeFX4n+nPzcf1BnXCARQucSPBmc0nKpKaMYQoxmlcp1aIiJksDDcW+wVpmoZtvZGwdwdIPe/vjQlVG+1ouamMts+8xedNs/DVrhqUkjQOmVuGHSH8fR59pvUD0LJqhzAOXIgO7GPGnG58Xi9pyNSGC4QE96gcHNRAsk73avA/aEbotPc2m3qoea1L5CQiM+GDqBSMzSssp5oJd1fzW7sdr7pZ/pp2F0FJQzyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MN2PR11MB4550.namprd11.prod.outlook.com (2603:10b6:208:267::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Thu, 8 Jun
 2023 15:43:20 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::7237:cab8:f7f:52a5]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::7237:cab8:f7f:52a5%6]) with mapi id 15.20.6455.037; Thu, 8 Jun 2023
 15:43:20 +0000
Date:   Thu, 8 Jun 2023 08:43:11 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com>,
        Fan Ni <fan.ni@samsung.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "gregory.price@memverge.com" <gregory.price@memverge.com>,
        "hchkuo@avery-design.com.tw" <hchkuo@avery-design.com.tw>,
        "cbrowy@avery-design.com" <cbrowy@avery-design.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "nmtadam.samsung@gmail.com" <nmtadam.samsung@gmail.com>,
        "nifan@outlook.com" <nifan@outlook.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: Re: [Qemu RFC 0/7] Early enabling of DCD emulation in Qemu
Message-ID: <6481f70fca5c2_c82be29440@iweiny-mobl.notmuch>
References: <CGME20230511175641uscas1p2b1877f9179709b69e293acdd7e57104c@uscas1p2.samsung.com>
 <20230511175609.2091136-1-fan.ni@samsung.com>
 <647e1cf4e7e5e_7471a2948f@iweiny-mobl.notmuch>
 <20230605175112.GA2290821@bgt-140510-bm03>
 <DM6PR18MB2844A78EB692A69CE10031E2AF53A@DM6PR18MB2844.namprd18.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <DM6PR18MB2844A78EB692A69CE10031E2AF53A@DM6PR18MB2844.namprd18.prod.outlook.com>
X-ClientProxiedBy: BY3PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::7) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MN2PR11MB4550:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bda20cc-8738-4c2b-fbc8-08db683715c9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q0l+Kr4+AyrOVmVCGlziYyJL9dR/mvYJbidIpWFk8jbtF7nFzf6noqerVh8RDxVL7bABAmNV014Z88haw245DFbwUK/KZLVAFghQ2rZcOutNQD/MlUpKwkmoAZ/QyktJvj2xygK6q1pzH5wN8E8M+kVlpztAHU29MGWJaO/wybxhYOYX93h+X8kfDGA6Pe8uMjBrt0fhnopXQL6epu7LzWg7yR5xIfMJ17wN21Hl0TOEIxjYc5aBltz7BQTPEiDwr/EsCTR4mXKgqGsN8MZOVlpPxu0gTvhOaVpy6zcTcwXwdYxOUAWPDSpVlByqzbgrfRYT4cjvbBGNsTlLlgrw6nQHqQA2w7TL6u2KF3vcrCdU2vUfhjWS5U9TriMkMzk5VnQNStcrOrDAz2n2Rxisvtju82jNYVXEdgHuBsEvOnkyv7xPUV8PUI4wwmR9TT7Zzj1JhSkbg1sg0O1ziy/hBbvjG9pYkRbr388zfaMrowHSJtdwKnKNnVuNc9TQG0aFE6HMLCEQOb+kjV5i4WEQlPEfjlb+p9s0zDL9/lNDW+A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(39860400002)(376002)(346002)(136003)(451199021)(26005)(9686003)(6506007)(6512007)(44832011)(316002)(83380400001)(66556008)(4326008)(66476007)(66946007)(966005)(6486002)(6666004)(107886003)(186003)(478600001)(110136005)(54906003)(4744005)(2906002)(5660300002)(8676002)(8936002)(82960400001)(86362001)(7416002)(41300700001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+1D0SlJMfaW1rlEW6Yof0dSl5gZIFF0eRMG0D98jrMNYT4H6Ukz2yGpcyf9o?=
 =?us-ascii?Q?R1DEbagIUxwYtd0vmw2oyXKF5oUL2oiOlEvFAvQymu8lXbzcEUlcucdbh7lp?=
 =?us-ascii?Q?Z49pKA2bj4KGMXS2T4S7HFl81Hvve5nRt4WHey2AjhNojl0I8YYGicMkapZp?=
 =?us-ascii?Q?0W+P6pU9ynYTRHV0VdoijUWPzE0657I5dSSMmj2a0x5Rllkp9/WhRalgLcei?=
 =?us-ascii?Q?YAwScHHUQGOQv5Ru2T91Pw1X+Q/GaksKE4gMW1Ws2qaHom7hZC0ZcZw0hAfF?=
 =?us-ascii?Q?wUH6CYMsF5ePFyRbBVlhG5cLKzpdcU4dr2byfTvlXS1RmDLkhgMXZviZzkWH?=
 =?us-ascii?Q?bj+e7WpHw0O5YmshCzMToFYCBPeFlZrFMdgnpHetcULo5uzj4+S1tK/eUQFY?=
 =?us-ascii?Q?hJYgzQopw4FyewutvUG26pDSnHwQ9GgLaYMI1F3q/a0EleRS5NqRBiCf8mAQ?=
 =?us-ascii?Q?MzLZgu7UVBnNW8PW217uNGfKGVtPJ5Ajprl1uRTSM9cfOsnX8aFPy70k4QYk?=
 =?us-ascii?Q?EWbTWELnpapZ2qarMFkHSHsnu2qd56gqS+voyR4SB35cBxcfUeVgcItHXFmS?=
 =?us-ascii?Q?GBbO5do9LzUyeYf61XXb7f78HT+bUa2CcnWdW3dbX4epdrudiryv3iYmExIt?=
 =?us-ascii?Q?EFiSN9KOXLjbhp6mPlR2Jlk2Mgh6XeKG4L3H1PBGuRprD/r3uQR7elthzQJ+?=
 =?us-ascii?Q?WWQclqYq0V79OVrZ0m3TDDF+fmjzJ9DSJsqRo5SB6IOB4DNb1944e8g54xDC?=
 =?us-ascii?Q?0oc3tHOXL7Swas0l1ZQ6B34GKub//DnTC+Y1MYhwu0IEGd80Hzf4NV89JYuc?=
 =?us-ascii?Q?mU7nPt9BSIjiqBxnjSIsmAqPQLMVxc+Mdn1wYqyu4orZjGjOgXRCyidbWe1I?=
 =?us-ascii?Q?HXZ/Ug0yHW0C3pI+ZFnSpJnxquveV9Vd/C1iEHj1zyaBdYpnfPNFPbAdNjOk?=
 =?us-ascii?Q?P8+Lg4vWM4l1GUOdtZC8UfEzRCLh1L/zPknQYKPemuMc0twPzWE3gTpT+t0D?=
 =?us-ascii?Q?XmYaE+sJ78MTa4zJf8NWq9Q/bz2wLXtZuMcT0GojgC7c1CCySfH4uQwuMm1a?=
 =?us-ascii?Q?0oxG9UwiyH1s95HnAE16OHXWwPHpFdklxPi3hX/CjcCgvEjvAChvQtnCkW1e?=
 =?us-ascii?Q?SGs6Q3Y4AJOYPUAIeGdQ+zdnuZosKTEXquDRR312f6a1UAefRPpxBPEs3IAH?=
 =?us-ascii?Q?2FxZDkE9o/K39nTPxdpMqdzjw7Efuo6jZL+O7sU5WILoPUVCoZujPMb+x+JZ?=
 =?us-ascii?Q?nyY1TTQSeRJjQPBikSBXBjwvCveus4vsbpBkWWQnvRrd+U2jDrcpDxLzLJWF?=
 =?us-ascii?Q?lTjJ++qpk4NCAznh+FFfGKMR0miAMI+dmi4F7SBcyqkJfnESvwEoA96l+PD3?=
 =?us-ascii?Q?7u9aRkslwE5w8yIZ6YnAwBcyYo5ZFTITcu0ouudaZO/TRl7emaojLDXGQHzi?=
 =?us-ascii?Q?H4urdwK2Ff+i7eTwW2b1gtbK1q8D/3u+ptgDH21E1/LffFdpkUS9alh17G1L?=
 =?us-ascii?Q?2ewdOR1wUUsCozP4ydOvtm5RrBZKys4blocJs/jO6lqX3rronkD0TUiFNoQA?=
 =?us-ascii?Q?rpBwx02R+16OiATBJTJN2jZtmGMs9k0mjFlbMMRK?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bda20cc-8738-4c2b-fbc8-08db683715c9
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 15:43:20.2806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CZ/58zJj7o2V1sN90Dl4gTR9njfgW/0qH+4zcYLmDNPy1HKjCVHP4yeYSibNoFUTPo7+nJL5htTz3xI4FCsT2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4550
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Shesha Bhushan Sreenivasamurthy wrote:
> Hi Fan,
>    I am implementing DCD FMAPI commands and planning to start pushing changes to the below branch. That requires the contributions you have made. Can your changes be pushed to the below branch ?
> 
> https://gitlab.com/jic23/qemu/-/tree/cxl-2023-05-25

This is the branch I'm trying to use as well.

Thanks,
Ira
