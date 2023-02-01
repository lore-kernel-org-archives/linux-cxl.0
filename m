Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C2CC05027
	for <linux-cxl@archiver.kernel.org>; Wed,  1 Feb 2023 18:33:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbjBASdH (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 1 Feb 2023 13:33:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbjBASdF (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 1 Feb 2023 13:33:05 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6AA17171
        for <linux-cxl@vger.kernel.org>; Wed,  1 Feb 2023 10:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675276382; x=1706812382;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ggCAJ07cJa7SKZmQUdAc8x8dddkjekX8ZeVi75XsoDE=;
  b=KlrmDDMRtmSs3gbWF47w4loOpnwYg9VCP8Txx7SBAosfH/MWz8r/qfly
   GbPNKmc+IAYxckXjv1f3z7ALzDDmEsyChNUFzzadVSgX/MGPpoRZhQPiP
   anwbmZz/c6Jh6SKmZwHQpXvb/RFKIlm+sf7CcyghRVcIfpFT4ExFqI7so
   98UmGB+CX0SqsyiGdIHDelzgAzKZ6MRpB/jA8yYlAdzYgzMFsdJkAC+Yt
   IClL1vixvh1tWlxm1cD4Seq0+XRBR7asZWDcVTIxWqqmWAn8fcV1NPGu0
   4eIV0UFqKqRxgD/x0oJBTlHlqYlhzuozklX01Gq/0Z4y9nYhpk4ElvqV7
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="355567170"
X-IronPort-AV: E=Sophos;i="5.97,265,1669104000"; 
   d="scan'208";a="355567170"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 10:31:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="733674509"
X-IronPort-AV: E=Sophos;i="5.97,265,1669104000"; 
   d="scan'208";a="733674509"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 01 Feb 2023 10:31:50 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 1 Feb 2023 10:31:49 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 1 Feb 2023 10:31:49 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 1 Feb 2023 10:31:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fon+3KktrujrKr+WeW3/l4XeF0B84WyCmkIMPL5zkr7jfbRG7sFIXK4RmovCnJKKMzLJa3mVrGugH/6SFLBGuCZY4wyJHmPIWjUG5113lDRUhcNCiQuXQHRzxKx4K1I+NhkMZNqjScPaw2V0mxDirYHSIG/x+4X0oI+xLCdQlfavVkjl3FCLZ2/aoZi3MLqnHWugjbm3QZ5R97OiQKO3SRxR1qimsNEEd8G5oewlXgR7zJVx2eicuvUbk6s0Mnny6OJ/ZzI81e+lkcaj8v+36rXLxoU2R2ndaJDDVb/Jxc1JAhbJAJprqBGu/Pt8ljgQM1vXudVACZ8e3f2x202Qug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kjNivgrknoMUKuIJvweZVPlJG/pKDEECvsbQW7D4/14=;
 b=DguqfvB7Ux6VZOhwPdyQQMUDkL1mzVhUymo8N4jyZMVBnx4u2xdmvceARTAGgaRGFoDMzVjfJdgv+jEGSbMSBUPZODmQ8ZIiIMsK1zrMjjrdR2C5uo/VjvlfK/JgNfZX49oaL9NuG60mG42vknmazBD+CPJUf8nF6L2V1nfgnNKFLdo5oiuzpDR3/tx8lr81WvlJYbgjUsvxxjbFCEpkgbhVIWZynzJ9i3NapNfvfbII57s/w+fyJW0YkHsH55PyD60c0AaxyYOEOiqIRFJ5Z8Nwlm/Zt4qtZNl0DPO+OSW+/I3Y5AvIV0dj/bVdQGlnwph7qYEsF1+EF2G/VIBcYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB7493.namprd11.prod.outlook.com (2603:10b6:510:284::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.25; Wed, 1 Feb
 2023 18:31:47 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%6]) with mapi id 15.20.6043.038; Wed, 1 Feb 2023
 18:31:47 +0000
Date:   Wed, 1 Feb 2023 10:31:43 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     "Jiang, Dave" <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Robert Richter <rrichter@amd.com>,
        "Jonathan Cameron" <jonathan.cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>
Subject: RE: [PATCH v2 3/4] cxl/uapi: Only return valid commands from
 cxl_query_cmd()
Message-ID: <63dab00f2c3e8_ea222294d3@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221222-cxl-misc-v2-0-60403cc37257@intel.com>
 <20221222-cxl-misc-v2-3-60403cc37257@intel.com>
 <63d483332ff46_3a36e52942c@dwillia2-xfh.jf.intel.com.notmuch>
 <63d843729334b_a2cd4294c2@iweiny-mobl.notmuch>
 <63d85857b1648_8e2c29465@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <63daa7fa7f9dd_b941e294a7@iweiny-mobl.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <63daa7fa7f9dd_b941e294a7@iweiny-mobl.notmuch>
X-ClientProxiedBy: BYAPR06CA0006.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::19) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB7493:EE_
X-MS-Office365-Filtering-Correlation-Id: b862980e-bc7c-4ee1-89d3-08db0482938b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 92oO7spdtoEdTOxDcr0tS/LlN286Em/qZg9gruI80NW5vboK94eTisCr09sVOiNxXUTB0rqbylMYH41zh5zhOvIIqb3nkcnRaFWmnn9jtFDEw4fuqibRg9H1isHpKy4lcgScLATUEZFB9uWe8LZ88fiTOiddhwkcNyEGw7bK/kWjLm2t5/9zmKoumYmX4AvtV8vyA5GvKYnUu/8+nWf3xFzmqjHAZegA3A7g4V0jlAcyovMY4pda9aNkN7TYa9Wwl6dQDi0UeQUvK69tnCmAfknSnEjXNjivopqZJz32wJcv4TKyRr0AFpU/OQWRjHyJRFJF+APhEOQxO7sZfDt25ttwNElwUi/PC2+Az0A3l3azxNJp/111fsZvK9v5LB9FAKGttv3weUc8C/muoUl1Ozm8x6dCWio/kDmkJTR+iztROgg8C/hHrOZhrcwm4hpRZ11Hli2HAl1GRGc+3SWY0HDSAF6VqPl7wdc0yA1fY+vuq43C9WMHMP74fNLg4KhgxXhMAy6W+e6G3LoKulThbhxGIlObf7E67NMlguR2XcqDqvNz9bKfWqUslPAGgZB2yuF3gOb6I89OT/Px5/IRxpw7/nCwTPc7vf4oD/GbexCnUclcugDt9ZEeRhtr4XDwdcsmUqidSaTBDUy87vrijA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(366004)(39860400002)(136003)(346002)(376002)(451199018)(83380400001)(6666004)(107886003)(54906003)(110136005)(316002)(2906002)(38100700002)(82960400001)(6506007)(66476007)(66556008)(66946007)(6486002)(26005)(186003)(6512007)(8676002)(478600001)(9686003)(86362001)(41300700001)(4326008)(5660300002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ax2ncJ+alcgZuDPgnmYxI3wzqbY5usJDbUQHsw6tS6tCClOWMdITOZKHlyJp?=
 =?us-ascii?Q?RgmnvNJZoLSeJ+uITcbe0HQawVUZI1CHgKK/7//stsF1V7qta3Ab5hBnQNoC?=
 =?us-ascii?Q?UvFUCziVOUJdykeEJkEUDPGaPWDoc4cF30yesuDqnsIr5Rf+hZAv407skDjw?=
 =?us-ascii?Q?HBzId4P6fMYMe/cytBp6sqHaKb5z3ulScc2rtjZ7N1ZgRFGcpMHoq71H0bu/?=
 =?us-ascii?Q?aX6BNvT1N01HBIwVyI6gHaL0gTBOjoFKvczX1SUaiXo7kZ6cJmD9NTBZVYHe?=
 =?us-ascii?Q?vumbrx0fz1VqWA+Pnxjfyn8sKV/OgmsimSorfCiE2h+HiXUdXq73EgdCiWsp?=
 =?us-ascii?Q?2wWQyY9W/ymkGq6RxC1wW0H2OR36w/1CF8rvowM2Wd1aFqvn6BHgQ6ZeS/w8?=
 =?us-ascii?Q?6d03gPuBnS7T3i66PGWkiPzSB6byXxm3FtWFTKU/EYyRHt70WAglnbV9uU3k?=
 =?us-ascii?Q?MZSEAq6P3yxDFt0TIuLCpmf+9kcPOZTkdkCjCUuuQ/lJvsNjhuFh8o20r42U?=
 =?us-ascii?Q?dJvlIGqrcz0PChzS5gIJwfu0Sj5zqWjXsSGQMl8ErqiTtzahnsReLsp4NVPV?=
 =?us-ascii?Q?Y6jSP3egWWfRr9gWD+yxmT3ZR/SDwAVZH6VWuExdpOQ4N9PE9YZxlKqHN7DY?=
 =?us-ascii?Q?+npCR1hUxl6sD9eDfho7naVpyovDKieDH+HGr7zcTLOrQaO8rRvaMPtpBQ0L?=
 =?us-ascii?Q?QzxI2T38dB2u6DIKfnxepkQu0qZM5EkJSbQxLl2JfJIi0PSp0go/Jjjcs/ms?=
 =?us-ascii?Q?A4QZgcoH8cfGz8eENQYtzN0T93ydG+GgFZymwN68dmr/EA02kBPGM7LKYUmv?=
 =?us-ascii?Q?I8ZUkBGswUpzP3fiOtcwfMXCRxsfmiHH7NRrGz3BHB/fp5FJhC47bMiB0d0i?=
 =?us-ascii?Q?bsSNbS99YmTPt4cLpwubMxi+MMJ0OBXtCPoD0v+22AYHWU6jswIOMlHoEAG8?=
 =?us-ascii?Q?SerAHFjP7VkXInhl8yr5r4G8ElumxB2W2eBzIiZERz7nklme2PP/c3fENYGq?=
 =?us-ascii?Q?COtA0Rh2pPIfaW7JuQj7+/t/Du5ycpJ7C56ZBoyh6+6J7xev7fqw69WhW3A3?=
 =?us-ascii?Q?Jn+BDffwZa0dHyrg9B3qU0pDVgl7nMPg5VRpmys5D7wWZ3p9Do0891TcFol4?=
 =?us-ascii?Q?M+3CIltF8CPDwslQQSrWqBidjEStQdHJBLd0WRdxoNJYB9z+r8ApFOoUMQyz?=
 =?us-ascii?Q?ZhXbbKCyOXkbXPpbW1b35CGpIh7nR4K7Ggi1j88WNxfgbYe1zOSyK3bmXJOR?=
 =?us-ascii?Q?va5YN2n7jn1ocwC9DD0UUb0nT7p4jK4yadDqdLdZTy0sQNWtIto4sE1hTuB3?=
 =?us-ascii?Q?NQrIOq+UrUhG5Ha2Ix/JE/6rxUTd9hE5zGHSuNnKZDIizU5W7OByLm6YOzvQ?=
 =?us-ascii?Q?o1HjCHsOvg2ifZj9ixp90QV7ZlsJ/zNkQmVYZs9pYBuu3eP+35T2jWH/M/5K?=
 =?us-ascii?Q?p+LQSYePt426qn8RroThbkDknlDwLgYfWDYJ8212Z26GuHicx/n0OGPhurtf?=
 =?us-ascii?Q?tKXwTpaPlFPE4nlFFDOSgx/r2IU8uIjxfW+aKblEK2MWKFJjSKSDshvl5P/u?=
 =?us-ascii?Q?uNhjNFxCYnTNqq3zHEGUTdBJC4pC5j/tFyAd4RI47Ux9JqtCi/SAqSk9GQb4?=
 =?us-ascii?Q?Dg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b862980e-bc7c-4ee1-89d3-08db0482938b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 18:31:47.2743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O9Te9igLSUuus/qqEEa5a1QvNo+gFuDKDz/tsUF92c2IXh6s7OKdh+m9aAVSl2zQpCFn4lbnWQ1Iy6BEJ1B6eQN/6EdUr4UHIBKuQyum9vk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7493
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Ira Weiny wrote:
> > There is value, similar to the motivation to print the status of enabled
> > commands. It is useful to know what functionality is limited by the
> > kernel and what functionality is limited by the device.
> 
> Ok.  Do you think we should then update libcxl to use these flags?  Or are
> you ok with the try and fail behavior now?

The try and fail behavior needs to stay if only to maintain backward
compatibility.

> 
> [snip]
> 
> > 
> > > 
> > > >  
> > > > -               if (copy_to_user(&q->commands[j++], info, sizeof(*info)))
> > > > +               /* reflect exclusive and enabled */
> > > > +               if (test_bit(info.id, cxlds->enabled_cmds))
> > > > +                       info.flags |= CXL_MEM_COMMAND_FLAG_ENABLED;
> > > > +               if (test_bit(info.id, cxlds->exclusive_cmds))
> > > > +                       info.flags |= CXL_MEM_COMMAND_FLAG_EXCLUSIVE;
> > > 
> > > Ok Just to make sure I'm following you.  This is then expecting user space
> > > to check these flags to know if this command is available or not?
> > 
> > No, there is no expectation that userspace check these, especially since
> > they were not mandated before, but they are optional useful information
> > for future debug.
> 
> Ok this is obviously easy to incorporate.
> 
> > 
> > > This means additional user space changes to use these.  Which is ok.  But
> > > what is the value?  Current user space will still be broken and future
> > > user space will be more complicated.
> > 
> > Value is as above, more user visible debug information which will be
> > important as different levels of enabling make it out to different
> > backport kernels.
> > 
> > > Right now libcxl issues a query before each command to ensure the command
> > > is available.  These flags can't be cached.
> > > 
> > > The patch as I have proposed simply short circuits the already failing
> > > path in libcxl with minimal changes.
> > > 
> > > Do we have a use case for user space to report the current disabled and
> > > exclusive commands?
> > 
> > Nothing beyond future debug flexibility.
> 
> I'll respin with this change.  Let me know on any user space change you
> might want.  Another option would be to add a libcxl 'info' functionality
> which reports the above flags?  Not quite sure how that would work exactly
> but I could put some thought into that if you want.

I think it can wait until there is a bigger need to enumerate device
capabilities. All the current commands have sysfs and other sideband
ways to enumerate their presence, but going forward I can see this being
useful. I.e. legacy commands are enumerated by try and fail, but new
commands (post this enabling) can reliably depend on the flags to be
there.
