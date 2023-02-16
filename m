Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EDCEC636CC
	for <linux-cxl@archiver.kernel.org>; Thu, 16 Feb 2023 22:12:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjBPWMI (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 16 Feb 2023 17:12:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjBPWMG (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 16 Feb 2023 17:12:06 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721B63A088
        for <linux-cxl@vger.kernel.org>; Thu, 16 Feb 2023 14:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676585516; x=1708121516;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=PEWac5/NmocypUUtQgWQlo+V8AaUlCkuliRq6CFOWM4=;
  b=i3loeKnKKGgREF68MtyiU4qTJAUhrkXpRBbHGNW/xqjeVA1RcTr3UsIm
   fz529k7ZQeZLWmBWbrdZM9jV+9L0Oh3PbbjU4orv0s17pPK2HrcEsMcLj
   3jeyhyAAQ61V7aQOvAyLhe6ztMI8LXWFRH8VWzr3Gcc9v/4z8ZKH9c1GJ
   pWn1bo4+1D5rYtog6U/lujK9OhXNwZwRKL+v069zyOfPUdwYIZ79btWYK
   7kSBESF516UXdZ22Z4DBfGE/s+a4PSpIT4B5CI3QhT3yfEvZjiL/gJose
   AmV5DykGz3IdN7esH8iC3AUMvqimqjfBJW7ARhTZJqGd+ia19UWa3esKQ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="315562862"
X-IronPort-AV: E=Sophos;i="5.97,302,1669104000"; 
   d="scan'208";a="315562862"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2023 14:11:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="702753012"
X-IronPort-AV: E=Sophos;i="5.97,302,1669104000"; 
   d="scan'208";a="702753012"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga001.jf.intel.com with ESMTP; 16 Feb 2023 14:11:55 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 16 Feb 2023 14:11:55 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 16 Feb 2023 14:11:55 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 16 Feb 2023 14:11:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OJ0lBQFfGAellDUOPg70MVhhWGrkCTySr3DzAs/8g93z0c6epFCvMW3a2XIdo9m6ZHSfjwGUCXiss2rkrIzeY0fVJpWXPII1YUu/PT4Tll4pJc4hCeHq/WonLOaKHFjJlFqnvXFAjF9W+pf673UGQGu9NCnIY9LI9dvMV1ai/DrrU0VhnHuk+IvohxxUj4cNhohjzc1kf9TgsxXMilpJrvcq672LOXJIOdjyH1UAp/3e+Xp7lQxBhqzbb/kCMFOJgL/NG4HJJrXeadtKEM8FdRJzRszO2jce1HparYW/o67Gp+u6Bt8ZipKjrZIGXa/K+/Fej1lzFygFXyZh2UEdwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QSRakpvyST55dTmlxtFJUbhqg3srPABEOQoz+qm3EpE=;
 b=acMwqac31BbSWMVFyyGVw33hgS5vbi67xm7mn+Th2Xe07r8xlhC+f2gH98T3iJtd0oE+cqQvyjLx39rn1JstHcWhhWrIM6p1Fn4IdyUmTglV/xmg2tXyDdnBwO7BZ/ak1GNHiyvF52s0hpApdPqXKRV9ms+LrinpFRzM+7e7P/NzSdyZRJr9o8ymZ9wAqezetCWK79oHjmtkFZcQjx0E/FTxoybc6w7nqw5V5AbTi8twjeOGINEHtl4YTxy8OpoqBmvhtQICUyBjmqAkU2vxI9oTA87uzfmgrCwsH2q8IX0IVzdE3aoKv2dwA7r0qBhGQJ9Pjq0EGxQpjO58hTwv3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW5PR11MB5811.namprd11.prod.outlook.com (2603:10b6:303:198::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.13; Thu, 16 Feb
 2023 22:11:52 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%6]) with mapi id 15.20.6086.026; Thu, 16 Feb 2023
 22:11:52 +0000
Date:   Thu, 16 Feb 2023 14:11:50 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
Subject: RE: Not enough CXL HDM decoders in pass through host bridges (sort
 of)
Message-ID: <63eeaa26a4ef1_32d61294cf@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230216183025.00000e39@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230216183025.00000e39@huawei.com>
X-ClientProxiedBy: BYAPR21CA0008.namprd21.prod.outlook.com
 (2603:10b6:a03:114::18) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW5PR11MB5811:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f54c7f2-e16f-485c-bdd2-08db106aceac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EBHPKcYzp6cTg4bQcgNfeAhjvwR8YO1MvVPKmk+2Rz4S0M/xkU6E2HhNjO7EZLWp+STfJuIyATkkM/xkJri9OIFJaBqMCaH2pS4htnFBbOmQbbDjZs9RiHo7ugMF+E8SPuUbcjZXi4VF+ziZ/gH5AJefK4VroC8dNBLISVIg2Pve0KmLPg59ogYsnLWn90p/RZstF+xnhyj+CbjoO+XkzJBqvXRc0GrvsQvA2I3HWbE2TDV0npLmJORMP28lDt2SV0EcVZ4p5cpg+DJJc5xwdJ2MrG/Of6jDFblfGKTzDftfKQk11xj1AF08MrYZ8mHOsnJ7Yo/iGyqoa2WQ+qqZamszNaEgcgRNnEas/agsxfmW0WJXyEVQxELulJkfy4qlW2MHwYdRceKzR6j/uGxT8HTxj0UB9eZZvBLsAxr4HPSCirG8dFR81vuMxVEUCK1r7KpKPZiODe4rjlb23kfcz09EZXwkBq3bLaNkOmndeuUpW3vvjjcMZ1csaLSKem9HgmmucSMpz4MOkjUKK0OP5594HS5NN5kb9M0Hf+0u/KUWXGvCjLUPKcUGSsfM1zjd/dTradtprJ3LJGOarcsoAAyuLOj4O8ilkFNRzB9xMJFsinGcaYwDeuJxoj5EKINfN6SSzHBOL70ljhqjSDjP9Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(376002)(396003)(39860400002)(346002)(136003)(451199018)(9686003)(186003)(6512007)(26005)(6506007)(86362001)(478600001)(6486002)(83380400001)(110136005)(41300700001)(8936002)(8676002)(66556008)(66946007)(66476007)(316002)(5660300002)(82960400001)(38100700002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?46Z4TpEnV5R1xRJfczAvP89yYpvrpQM8Lohw/MDzkOKJchKLK3h19jtCoxug?=
 =?us-ascii?Q?QQa53ixxoQMeohpSjOfzVHYwuFROmsoV06WpInX45P93EaYR7Lk3smDcmo11?=
 =?us-ascii?Q?/HgrykkTjcEL9S9zuch1sYZy0fe1Y5n4wbBSdj5JCh0fsi63dp7WGnHwvJI+?=
 =?us-ascii?Q?EfRAU9ETB9BVOfY42he+GY0NuTaXYH13FAgln9fHZet5n6JW6nW2zg3Ac2f6?=
 =?us-ascii?Q?aX/hlBH6rYY/syXCpqzN0dCJ9DmP+/ZyNa7J84WDol3uBEXw/WRAYMptVkkF?=
 =?us-ascii?Q?RnPFCtlWE5zqD/o6QtgmIjD03OjbzFDufITFB8kDQG+zxBIlTxTCvtk/IdSZ?=
 =?us-ascii?Q?gUX8EuTiL6DWTOWhue7jXhh0UgaMJEGUpq9kM7jWc4L8jmAvBBKksrP51xKr?=
 =?us-ascii?Q?dYpimScxD+rfaXgYrokUk2TV8nbUSguM6t/SrjtldGiXA6+uYRbZF7j0P37T?=
 =?us-ascii?Q?sqz/ZMjF1WkNoqUON2QxBuur2rBYQU+lp6CivMvQyzwF6bN6eYY+6+ARDfob?=
 =?us-ascii?Q?tGZEqO4m/AeIT58aepDFDw7ga+o+eKJPHf/7kk77diOoZu0phSf3zgQejpWA?=
 =?us-ascii?Q?HJfq1efbm+N9cO2aeyRU8NCDxK6uoyADZlnK4v4Y+cRupUzNfFNMhN2l/8vF?=
 =?us-ascii?Q?plFzLY+cyYXmTSRbcAmBxI65gruNX4iX+NE6TOfE2PZTfyBLo4AXeSdL8Cm1?=
 =?us-ascii?Q?VEXvLgt00392ZKdxxvJdt8VyvzmDnO83zHSvgfLoRq5Wwhy5kmDXmNhcuKGu?=
 =?us-ascii?Q?7KMVqn6srX5+V/BOtYnTarIxqJhMgvLz+vkfsEQyUbgGyHoBs7XUQwuXGPXE?=
 =?us-ascii?Q?0rX4v7ZBnQzP8jOuPyeL56cMXRjf68pc0yxqpOGzyUO7ocFWv2+GNRlSKtAC?=
 =?us-ascii?Q?vB2fgm+oAzgDsSf4Y/Acn4m8loy27Cirp8I2/t953ItioXoKaq51a52cbMl6?=
 =?us-ascii?Q?Hi/hoO9GvSXzE6CxtV6iacfcCRAeL+b23GgYqavZ6x6KZviuyIzRADkNpIT8?=
 =?us-ascii?Q?eP7axlIl92EAQeYiBOkLJd14lJ2Y10Ld1/Rfk9RJAvMSEKsqJtv77ZL3xff8?=
 =?us-ascii?Q?kBtr5yyZgD/gqnSUi2wltk/HXGHT1xuChyB4z24o9dXk7YqNGCXTmppFxvjO?=
 =?us-ascii?Q?vEliLreCaNubnp++cUHXjuDz4+ZB59PvACH92717m2qZ9QSgqXbWlFqBGNjf?=
 =?us-ascii?Q?raOXjVbu+4x65jBsU+eASLnRPwS+dJ9JSI3dqv0IN3+6UrRoYPugU6xBmYWl?=
 =?us-ascii?Q?NiQaI5RyK1qbMhsMTH3VVfWJcg5cNQ3IMnsZxQ1S3IBZ/Ctmcua2R834GmvE?=
 =?us-ascii?Q?3wL9/uPgf4MReA7eHbn3Ew7KsX3bL7M9mvCqgcduKKLo8LJguLHPoD0kRQt3?=
 =?us-ascii?Q?c18jUa41gDnC9Xegt5rqFuprn55Z9STYGF/a2TQx0t5EpNztFC/D76vedw1F?=
 =?us-ascii?Q?gMrp9Mb2n7IC9Vz8ks4Bf+JbXcuyov27OjqHBxyOwIamTz6UdphiuxP5hZfc?=
 =?us-ascii?Q?yZqqYVE+byaqHxISwsxvCzell5a8YdcpJvVBfH3UjSktSBscdprHWnMHfWN3?=
 =?us-ascii?Q?7cb1hTvlrTG5nj17Odyamn82wp/bk/0B6gZr5f3HiPfNKVNCqOsdG7jGvjLx?=
 =?us-ascii?Q?mg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f54c7f2-e16f-485c-bdd2-08db106aceac
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 22:11:52.4937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xU2HP85NitNKsJq1tXDr5atRnHvDDYAiwd1AXb95WUbkiICQ6v1wMJrrJ4C9Wq6Em1NZx48nc6sEJQ7CAqQiBhzHcWOUvrrefpVjgFz5zIQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5811
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jonathan Cameron wrote:
> Hi Dan,
> 
> I've finally been adding support for multiple HDM decoders in QEMU
> (need to implement the address decode at EPs, but have it working at
> HB and switch USP)
> 
> Whilst testing ran into a corner case on the kernel side of things.
> 
>            Host Bridge
>                 |
>             Root Port
>                 |
>            Switch USP
>                 |   
>         ________|_________       
>        |                  |
>      DSP0               DSP1
>        |                  |
>      Type3              Type3
> 
> 
> Previously I'd been testing this with either an interleave across the two
> Type3 devices or with just one in use (as I only had one HDM decoder in the SW USP
> so couldn't handle anything else)
> 
> Now I have lots of decoders, I added a simple test with two regions. One on each of
> the type 3 devices.
> 
> It fails on the second region (with a "no decoder available error") because...
> 
> It's trying to find an HDM decoder in the host bridge and the fake one used
> for a pass through decoder is 'already in use' by the first region.
> 
> I'm not sure we can simply skip the check in this case because cxld->region
> can only point at one region at a time and I haven't though through
> the impacts of that for a pass through decoder.  The cynic in me says
> that if this HB had more RPs, we'd have a maximum of 32 decoders, so
> just fake 32 of them instead of 1 and not worry about it any more but
> that feels like a hack and probably has side effects.
> 
> I thought I'd raise the issue first and think about a solution afterwards
> (and secretly hope it is fixed before I get to it ;)).

Hmm, in the case of no decoders in a host-bridge the root-decoders are
effectively mirrored at that level. I.e. root-decoders already support
the property of hosting multiple regions in a decoder so perhaps
tunneling them in this case would be a better model then establishing a
unique "passthrough decoder".

> Obviously I can avoid the whole thing by adding an RP and hence have
> actually decoders to use up on the host bridge which does fine for
> testing my QEMU work, but we still need to fix this up - unless I'm missing
> some subtlety.

I just find it difficult to believe that someone will build decoder-less
host bridges. The moment that you have multiple CFMWS windows to account
for ram vs pmem, type-2 vs type-3, etc... then it mandates multiple
distinct decoders at each level.

At a minimum I think this problem can be solved at leisurely place
unless someone can point to a non-QEMU example of such a platform to
raise the urgency.

> There is another question of whether we should make some effort to conserve
> decoders - so if we can just expand an existing one to cover a wider range?
> We can't do that after commit, but maybe there is a dance we could do to
> soft commit a bunch of regions, then hard commit them as a set.
> HDM decoders may be a precious resource on some systems even though CXL 3.0
> let's host bridges have 32 of them.  One to tackle only when it's a real problem
> though.

How would that work a practice? A switch can only target multiple
downstreams for a given address range if they are interleaved, and if
they are interleaved it's a single region.
