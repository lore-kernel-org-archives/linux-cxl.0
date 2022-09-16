Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAFA5ECAAD8
	for <linux-cxl@archiver.kernel.org>; Fri, 16 Sep 2022 20:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbiIPU0B (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 16 Sep 2022 16:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiIPU0A (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 16 Sep 2022 16:26:00 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C99A6C6A
        for <linux-cxl@vger.kernel.org>; Fri, 16 Sep 2022 13:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663359960; x=1694895960;
  h=date:from:to:subject:message-id:mime-version;
  bh=D1iCZaU04go93FMBGM290H3M0t1B5EWEmF5psOyjq3k=;
  b=fijLoyzzvMeNuVpKmbxxxcuqFPJTG8eDAAtX92E0J/4fsv1GMppT7gYF
   xqJgGw3dDq2X7ZRlAsgyppT9rvRs+0304whbmoqv5b0uDc1nqkrcTNDW/
   kcubIy7QsHjIDZllxjDZvku90bBiXNNkWKBo/fFslj7REs49I5O4AKu4I
   wBLEWsQ6X8zrHCasWM0ECwMD2KurGmz0/uwsERgF2KYL1xvpX8W+dl5rT
   khDxHws8voHCwY8EEvm6y3znWNXRBOWTp5fWc2D1Hm6UvWZ1BrGHn8Ylj
   iksuhiFpapZ0lNwN25CkYXt1rK6iGAtPP0D/xQikBRyV9rV+CuWFTnytr
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10472"; a="279456097"
X-IronPort-AV: E=Sophos;i="5.93,321,1654585200"; 
   d="scan'208";a="279456097"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 13:25:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,321,1654585200"; 
   d="scan'208";a="743457550"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP; 16 Sep 2022 13:25:59 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 16 Sep 2022 13:25:59 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 16 Sep 2022 13:25:58 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 16 Sep 2022 13:25:58 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 16 Sep 2022 13:25:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F7K+Cdn6KkQG5pnMfjqOJigY2OnK5/KXk/aQR1NLnOlXCx2aZa95nTWozTjGTEI6lXPgx5oeJIOsvPYG6LXBTbr0ayhUspBjWyji3+gKiz4hCMPAOJ5Y0OzE0lzsycyYRsfKibAe8lK7VH9aHRId6YYE9lIHGSp/SR/vE/ybXTus+xq3YafaIwsInsGarcNa4lqyTxRKZPaOk3BU40JCheIIgE8XCegJwadJfx4ECqWR06yfZ2xgTLdg57eJvToDkAXw26lt+yGK5OYc+YdIK6bhCYciiKysneCj38k+7wsPRP6kBoIMlk+r5pRtfhOKvTu112boQlqqbYUnwUvoTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D1iCZaU04go93FMBGM290H3M0t1B5EWEmF5psOyjq3k=;
 b=XIXkgHGksbFG4FAhEn97MPK9l0aB13qb5Yriw5g+fV7UDY7JQ5tzooZzr1/QoO0OYCjIz2xp+fHmEY2t5rQMUjvj2NTbwulLu4ZJreT8DotGwot+n+tLI8su+l7OY+ZZzQkgIIfG6AvhDNBnKlJV1YR6tBr0CTd5AFlhEz8d64ftCLBtjM/jSjy78fwdofW+isJGb07WxPh2n8xwTuHZszrpisSM8pj+kKQLqbF/jNa4lWQn/Z7aqXF+495RsrXkXpp+DhNQII8lBlkmftOjC+4IeMg8srCO9HqzL0c21/Va9dsvicYPNTYNyc2GrpbySr98O6BRj94ma0fpntKxjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by DM8PR11MB5624.namprd11.prod.outlook.com
 (2603:10b6:8:35::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.16; Fri, 16 Sep
 2022 20:25:57 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5632.016; Fri, 16 Sep 2022
 20:25:57 +0000
Date:   Fri, 16 Sep 2022 13:25:55 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     <linux-cxl@vger.kernel.org>
Subject: On Patchwork for managing linux-cxl
Message-ID: <6324dbd35600b_2a6ded29470@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: BYAPR02CA0052.namprd02.prod.outlook.com
 (2603:10b6:a03:54::29) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|DM8PR11MB5624:EE_
X-MS-Office365-Filtering-Correlation-Id: d205d139-7c7c-45f1-3d60-08da9821a96b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zVEXdWiRI93NM74bjV7Tv9wWcHpTohdNrfwhDDZ0m0NoU5Hpf/R9zfD5xM7Ir12ed1n1Jq0dqTScEsopuAOxAF6lAUve+epaqGTRHf3YrzUCFZgmKUUtpmA1fv6YtWD47YxeINZV5+tgxXcDFRERMHdWl5oJ+C0Kb/829RxFG13HL9QOzLZOuADHSukEyq80FmnFWHOh7KyX4SgfkLPOx4dZmE7pdDxkXAT5R1aXhjhiqdpK5ZN/e/FF+yUZOpWP3D0Kmrr6Siu8GUjB95SZYMBR5dlfga8qit93/lGMTFz342cg7gsJhLQEIH9EOpBWWp42JpSF2x1UpbXJcZub/7OTHE4u6wIwYUtf2WSLKbz1/7303Lhes//iKiM7FVuuK/pWP/05Sx1iFTtnMXUx9Q/CDrGyShDkV4y4o+w1RRBDz4EAzosbubMsRUMnJEb1UXkDjSHyXfvipy8gucAcAtH6uhLHH6r1dWF3EIDafzrDrWnjn74fiz011eEhXeLLEnGn9tnPsmlvZ4dMrr7K7JQUKeA7Xx502WMNGB0Js799GkovugR6mM7//gpQTmqBzNUQE1mBE5ORwbiNe6Ex7JlKNwLJu0h+eA4yPdsbsk8STTNNmn48a5809mDJxTA4INub3S/+Ccn2SbkxMwDRGg9O4N4vcLO/ITSBPvhb+9rmsLSyhQvuNPElEoCxMbGjrGMYqPpqTye0Mp+rCztP+7kmrmvb8zUbECGcZbkR2TFd35V8a0fcgM9TyVde31Xb6a9TccCNwWXc711adbZLbQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(396003)(376002)(366004)(346002)(451199015)(82960400001)(38100700002)(8676002)(6506007)(478600001)(966005)(316002)(6486002)(6916009)(186003)(2906002)(83380400001)(6512007)(26005)(66476007)(66556008)(66946007)(5660300002)(8936002)(9686003)(41300700001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l4m2gyCmFmRqbdY+5KivWhPfUsaCnWQkv7d70b+u29cUf1OrDKi57dWUphaF?=
 =?us-ascii?Q?cMkR1wXhjv5rBvKWeg6EYPf0q1tiI+HLOTsSuLM5YY2kkEcshuBvnUr99aTg?=
 =?us-ascii?Q?YjhGqsiiYCHXCLJnWNI2JMNm0ILNhSwELfN1PvRYSqWo9qos47+PorGqr7o4?=
 =?us-ascii?Q?3Jffa3DEGFGllYHNyfJeVXKrOmzij56q6jjfu3/k1+GrrUQldxS/yu6L0dCA?=
 =?us-ascii?Q?mtYrP/5gWcY4bKkQ327ZTbqC0rc8XPPEee03rpg1A36e46K5I6ymRc8X3yLD?=
 =?us-ascii?Q?lkC0+fKjkCgZXQMh/vQvk+i+qWZJyQYSIl1Q/1aP1syt4kTodjenOIsnKxIv?=
 =?us-ascii?Q?/zre5p0RVMEkgKCTR3tFQE/UO8wy0ZyJwYjGyTcDEbaiNwWA+yZbVAwvsDba?=
 =?us-ascii?Q?lhLuvR6fkdIrNAM0pDhnVqv5wD2X0E5wgQw2d+XXXZSstn+CfjyIMyOJpdc/?=
 =?us-ascii?Q?nLhmIBadDzw73vS2TPrEsxubDwLv5ogH4Idohl5eoBwnscxeUQM6g1mRDd51?=
 =?us-ascii?Q?QEbiux7oygkyOqTS9cbzMGk8AgsWn1lWVWV/PjEPWXsXTPNaZvTcf16A1C5o?=
 =?us-ascii?Q?E5GvFk3UYQixpywhkqNhGgTF8PckqyMNbaanhJbVLEqXIjPJ4H7MD9kCJsWs?=
 =?us-ascii?Q?z/oHM8hFh6aVER40Lk6MTs09gaQvfv3YeJXFJIXgU0IsrDNuNjUYGjLiiCZL?=
 =?us-ascii?Q?Al47b7mzJcjkuzezK6OkWCAYCA+NLdBhs0HD/hjXZ0V78xgAgKJ4IErrdji3?=
 =?us-ascii?Q?+4ZP/Tc+IhtYhgkOfzJrAjJutszXEczJ4OeeXeEPBdcdkFGHATxb82IYYAm9?=
 =?us-ascii?Q?ThhpE+asirEeTWOcCuEs35S5otfiQ0NcVJTxbaj8YLfOlgvbN5qeunm+AEVd?=
 =?us-ascii?Q?kW37bwtbLFnLEx34NYlHDRaGSB0qkx+zeLGEklaPTcP27LZkJtsTEb3SxpAK?=
 =?us-ascii?Q?FIvfJhnY+N3t1mutkC0n7JoabMIZ1gjuJxh46dKP3NsnmgV2OjUsRn+7pgp0?=
 =?us-ascii?Q?J1hLNLKtUj8n5meK8ujXZVlEwIBGbUY1LHaQf9Xcal6q8VPcmrEYkhNJ+7Xn?=
 =?us-ascii?Q?CJIbT4U6/cHKnlO8wkJWIYKs2wif6jmPPd49jOPV8XIpB6xF2BkUl2bZhxJ6?=
 =?us-ascii?Q?YkhF0zOWbHG/Yb9/Smv3GzDuqbhMYyne4PSistk6VVvEJB+rdyxkKuBZ6DwT?=
 =?us-ascii?Q?0DutjMhbZFdKi/kcovEiPdHLsj++p2H/kSMstk+G+7G/ZkXNyChPwy4XDE5o?=
 =?us-ascii?Q?OK0KXozwZ6ZxoAxyz6NDpD0H/WaA8Q0YQIAtMsGBT/b+yGUC9ONX3YUtfEXY?=
 =?us-ascii?Q?JVRZzz9Ojkx11Ewhldowg0g0ygrq3NUmN2nDoVX4kX2mDWTWmGVXNRKiZ8E0?=
 =?us-ascii?Q?SSmA6zPE04Rgb8B6cym484MwYaIW9v/Oie/gsMFOdnex/6V83xiFld8GPE/f?=
 =?us-ascii?Q?+HdMUowWgLFKOIjcNSoiw28uhaos/9U/1KlVAEXca9iHBGINz9+NhMp1MWUj?=
 =?us-ascii?Q?P12xtHUZJZEEwYeJWKNLT0MdjAZmGKgPP9uQJHgb5LwvLkUIxqDtEakhDo/w?=
 =?us-ascii?Q?L12/uqpJB8MLMfK+K1O+3K9XyY26j81vJh3+37uONN5lbNDflc02SHHeQvyG?=
 =?us-ascii?Q?tQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d205d139-7c7c-45f1-3d60-08da9821a96b
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2022 20:25:57.1629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FmNc84VlKnObOSJ73n/t3BoZIu1ETRqEFPJ7qCUMjo6ysvkPOfRSivGjvXEIGm2qW/qFb+nDNCBsdhbCgR395QfK7P3gmjKPh7RvLqh6/Fk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5624
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

At the beginning of the v6.1 development cycle I stepped back a bit from
the linux-cxl mailing list to tackle a long standing concern with the
way DAX page references were managed [1]. It was relevant for CXL since safe
/ managed CXL-hotplug needs the guarantee that device-removal properly
waits for all users of device's memory to either release their pins, or
otherwise assure the revocation of their access.

In the meantime the CXL patch backlog grew. I am circling back to it
now, but it strikes me that linux-cxl@vger.kernel.org is busier than
nvdimm@lists.linux.dev. It is busier to the point where it likely needs
more formal tracking and patch status visibility for contributors.

To that end I am going to start using the CXL Patchwork instance beyond
the automation that tracks superseding and application to cxl/next, but
this will be a "learn as we go" type process.

The current accounts marked as "maintainers" are visible on the profile
page [2]. If you want your account added to that list and you have a
"Reviewed-by:" credit in drivers/cxl/ just let me know and I'll add you.
That mainly gives you the right to change the status of a patch and mark
yourself (or be marked by others) as the delegate for a given series.

There is some cleanup needed, the ndctl patches currently only get
automation support on the nvdimm patchwork instance, so there are
patches that are merged upstream that are still shown in the 'New'
state. The qemu patches I have marked as "Handled Elsewhere" for now,
but if it would help to track their status on the CXL patchwork just let
me know.

[1]: https://lore.kernel.org/linux-mm/166329930818.2786261.6086109734008025807.stgit@dwillia2-xfh.jf.intel.com/
[2]: https://patchwork.kernel.org/project/cxl/
