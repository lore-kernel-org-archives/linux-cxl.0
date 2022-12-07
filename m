Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B353DC4708D
	for <linux-cxl@archiver.kernel.org>; Wed,  7 Dec 2022 19:47:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbiLGTru (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 7 Dec 2022 14:47:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiLGTrt (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 7 Dec 2022 14:47:49 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15EF93C6C7
        for <linux-cxl@vger.kernel.org>; Wed,  7 Dec 2022 11:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670442466; x=1701978466;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=VX9to0+38CGtbJo3Z+HFQK0F9f8MewMoYkQoheYrGWw=;
  b=FNqXDGNfwZ7isgi+xuGdCenCVwfELV74ysNsKypHPUryD/q9FE/wTgcd
   FvBgOGCMyLW6Ff6ebZtOQ4lz5bFn4RIvqzHH3OLn35IakySYbZLPzr5rV
   6q6Re6Wc9KqSQiWDcr93wtj+lywzX0GLb4Y+rtRBCqHDzYGCoZ67IDMQH
   c51r9OXR8vqzOH6XpJ1Si75HiOvwkzyloktU2bBLjP8svUXmhbWJe/Zkg
   ngQa+SSyZrjvItYx0s6lDoLrFD4L6l0diPr0ObsSSZX8O7ahQnUVMG6pC
   99gkqbrn35Nv/yBo4rbdjiEkb28D/PnwRDvE2/wcAicFwwoCnriUvHOrO
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="297343701"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="297343701"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 11:47:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="640366345"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="640366345"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga007.jf.intel.com with ESMTP; 07 Dec 2022 11:47:45 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 7 Dec 2022 11:47:44 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 7 Dec 2022 11:47:44 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 7 Dec 2022 11:47:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G4zWPKoahl8MGrHtCEPez8yA9nHmpmQd9mNeqwk4XLkPAJK9FPsyxmFin694UyWRVl1qBjKQx2bV89P30rsdjak90Q4ZV83KBl2554Xt094CeGUfQhaePb7HYgNsQ8Chdnp3gjywm2KSY3dlAdC6dduxzUh97Xy4jVj2B27t56yxcXi/wrZxLL/g+FWPXkqpQAF1V8UG4EOmEGjK8CLz7bwEiFvSxvGJn4PIYYD0kz0kVQUX2CIN0xnxAO/zKsYH1wpP+I2oK5mYqU+Ty9Y+gJqWtsbpoww4vtPcEHJH0PCixCsiyWTk4ow/EeUfCNPWL76wnet31605UQgt+grr3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XRVQKA62MtxIQL4RRcmGn1XIskXqqA/vbdAiZFaidsY=;
 b=XrARJ1A/JMFj+JL0Mtzt1S4mZ43sOuBNdogyfCj8LsUR6Z7FIsLAOnB9JWQUlosPkCfqspDe+mKiN/sFfM88Ot0YKct+pdC8tQBt7GfcntgNij+WoEcUp+RhVM5Sy9O3Ph9DWanS6weM8du0r82cx37G2Suia9jU4d1Ry4ahlPvatQ9KoGPffIerJVdcAgfrP6Npmjin2TNgyvMvDaa911pdMvKqJEuY4RObOpE49dARWJOWiUm0yWdYLXlgQJ1ez+zFhw8zHP04Ez9NASFDureFS38ZgOcIAjBaBnisomgGD4cu6T4nGTOYZVqCA9M+QmrVGhPuUUkg6y5sI/1IEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by MN0PR11MB6086.namprd11.prod.outlook.com
 (2603:10b6:208:3ce::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 19:47:36 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b%9]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 19:47:36 +0000
Date:   Wed, 7 Dec 2022 11:47:29 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>
CC:     <ira.weiny@intel.com>, <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 1/3] cxl/mbox: Add background operation handling machinery
Message-ID: <6390edd182b7d_3cbe0294b2@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221206011501.464916-1-dave@stgolabs.net>
 <20221206011501.464916-2-dave@stgolabs.net>
 <638ff285d426e_3cbe0294af@dwillia2-xfh.jf.intel.com.notmuch>
 <984a25cf-f8b4-5d63-9a88-7ed7d4f49ba2@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <984a25cf-f8b4-5d63-9a88-7ed7d4f49ba2@intel.com>
X-ClientProxiedBy: BY5PR04CA0013.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::23) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|MN0PR11MB6086:EE_
X-MS-Office365-Filtering-Correlation-Id: b5c31309-4c7a-4d84-a592-08dad88be335
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3QP8jxw1sMhpx6pOElfQE7jcyL1i4UkYlesHX3z7YisfhTpZvKyoOYVK7bAV+N2mxVWOKR2PNxzCTP3g4oG98S1v4q3e9vhA5526Ig4qa08KgnPguflwbyd4ZYRM4Hgh87+xgVeGP3qRylwWgYempInhe4Gsmr3LNLa63y2hzPzUgMQYA9oRFjoOtFDuErhZw3kRAPHOvORvcANDTOXpRqIozSReQ9OTjTicirLPlgvERnXYbyj+D5zTd766wjLQhou5lAu5exWneHzZFWCxUpn1W5QiIcAqFgxaq2ddbALoGdQnIRnujDr2q49B79jeeSXlUe2K3uOs+unCT5tp5bMIdQVTqiP2DJgYxjwTEVsLznyAbHmdcEp90mihOFnMgEoqnsi87j3yf0wcBmPIUcwtmQ32Apaq9VxVsplqRhbdkCfrYTGEra/Z9ET3dUqwfyi4KBsLvAjcnLhiedYMxbStsdlXaQPfx5C2dH2fgXvDuEalWT/S0eFMueRB9ZbelE5sG6HkmmJBUNwvDebvB24ODNuJ+Vnza0rjdJvePrsAEDWckWLdCTaPCWR3qW1/s6DwdYtOKaeuAVdepr6Gvh3eQpsFw4XKRreyodcnHWj6BWswckjLr6+VIlvoj6rXOc5vK9MN6RZXi1GlTGcqH38nztBYWzeMnj9j0xTYsIDiSKhgld63vt3MmgCowU5h2VQ2i8wGxGOi7sDgEWerWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(366004)(39860400002)(396003)(376002)(451199015)(66899015)(2906002)(86362001)(8936002)(5660300002)(4326008)(38100700002)(83380400001)(478600001)(30864003)(316002)(66946007)(6486002)(66556008)(110136005)(82960400001)(8676002)(966005)(41300700001)(6506007)(6666004)(186003)(6512007)(66476007)(53546011)(9686003)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VObzzz4LnuJyK4Ctwk1BAURtEjBGsWaDiE+GN3oiQC/3dcWiDr1GOgfTL2gx?=
 =?us-ascii?Q?rA6rjWPE/Equqt69xaCqtlfPyY59+7achr1p+KjhAapP6ZIg080EvOCB8F5F?=
 =?us-ascii?Q?x7dcUmoJ8XRZdQtkc631A3evv35k/JQhdB8f7EZudssofNuR6JiFVvJUNdca?=
 =?us-ascii?Q?FmPV67+UFNMr8D/U6+4z/uwEAIsQM8hLZJWDnSSQcxag8RwQqQNvt3/v591C?=
 =?us-ascii?Q?BPdERv4b57ff+CcWKumqB7ZW6GZsRkNZwNwMFKJfrhmf55QzLByHxBrSf8Td?=
 =?us-ascii?Q?PSJgtGcgFUI0vOmGHMhHol8zlhmWUI3c8LK7fefABldMAGpPWh34NCkSuDzS?=
 =?us-ascii?Q?t1Ih99IEJKyksvChQ41Ke5cjzMvHRyIuENKcMK+4/HuHU4udFlTBDWpSEfLN?=
 =?us-ascii?Q?3/inWCgQkjcfPLqaxze8wutZZ/WqlRIfxA/LGEYb9LCJfoh/7UPy58ZXdC6W?=
 =?us-ascii?Q?T09Ac01g/lpT6RcpZdD0VIccwTXwC3+hlw6ORgowT7hLQS+6L04q1TqJ6xu9?=
 =?us-ascii?Q?z93JzdhiO4gNQ+V9iLc0xe8zFovoizJx2pZnQtstpnx9URe+aApuxUw9ZvSI?=
 =?us-ascii?Q?F7W36b4nxABQSEN22nB7vfxpO4gP7uWPpsJ2fgM1uLE7qMRGXMEm8qACxw+d?=
 =?us-ascii?Q?DAZ0ZQ5yggtMdIMVSK63IkXdU4m8RJXwgBBmzob4t/lQvCabRc0OXurHRdVa?=
 =?us-ascii?Q?XMsIUIP2DKCljzM6ZpsURdtG2VtMQmAwZh2HiHZ/EDHYNXIVQu2+VRfNJgFA?=
 =?us-ascii?Q?FNE6u4pL5CjcOfMX5eiI7nsA5loCagjrTAWwXdvA8r3LU6AUz/rEdquI+1TS?=
 =?us-ascii?Q?OKvwDIXJ5qT96VuhE542+4BnjTi6xj1e4WlyB8RIE+Uwday5yviZe4R3QCsg?=
 =?us-ascii?Q?XO4oN6pxpAjyHuu5GpQagPaQbIGEHAgZMYZSte6OE+691hPGhOCa76xze0b6?=
 =?us-ascii?Q?FouFRzIbcGkli8opSBA+U62+BcLq3/mwS3Z5js1dVqor7wljl+TRyBnwyKne?=
 =?us-ascii?Q?AwzAnFl0GURwjbSszMLs9UhgV1etrYr6gG+vnKQggUAXy1bOVr/YMTtDfz4G?=
 =?us-ascii?Q?QPdj+0rffv/DK7Wlimdj4eXqv6taI3P6ogQVQPC2DvujAw9eqNZg7GvHcs4F?=
 =?us-ascii?Q?gLr0xoutAUIZiwn39FsGlFz36Arr64L+g0+W1HY8Y9bjwqaosgYnQi4+FqJe?=
 =?us-ascii?Q?JSMUkXjaB35ljpteroM7e6IN3PTVmrgGcHmvOpOpBwB65M4IbkCcnU0osLq4?=
 =?us-ascii?Q?GOP7VFY6hjJ7IGWafYd4GIm4bQu0QhT2A+fvhOfxrsTvuMlzJVblcqaBEhVe?=
 =?us-ascii?Q?q3SldFNumr6qD9zuKOSAszO3QWuz3T/CSvNjP71LM6fxiR3lNmLSCXZa2ZPJ?=
 =?us-ascii?Q?sOhJAlygF3dbKHqKKA5IcXE0E2Nj2njzF34Q5wm7RqoRPzi4NEDN6UUT1ALi?=
 =?us-ascii?Q?I58tc/lWplz5ER7tk4nUi2HAUq3QVMxE+7z8E6XrcDWd3klE7ueFkkFT+Aym?=
 =?us-ascii?Q?l9OX+eJnHYDUfEu2Za6ByBLWXUyzbVtFgWXPTV5OjtHGaSuG3fW/yX+EJiF5?=
 =?us-ascii?Q?1xysh6jZOs62lt9rxMCLn8/p9lMO6x99YnmdyrHkTCj00masleIB7QHBwmWs?=
 =?us-ascii?Q?5A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b5c31309-4c7a-4d84-a592-08dad88be335
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 19:47:36.3155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HWQv71Y5hi1gJ2zrmgC9D2/nRnsOjDKbm4JPNsJofdIIIwJ6WuC21vUvwsO3fNEBNFN4xkrViUyzkcoPWQIHSDbqHb6owjl1rxA9MZrpu3I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6086
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Dave Jiang wrote:
> 
> 
> On 12/6/2022 6:55 PM, Dan Williams wrote:
> > Davidlohr Bueso wrote:
> >> This adds support for handling background operations, as defined in
> >> the CXL 3.0 spec. Commands that can take too long (over ~2 seconds)
> >> can run asynchronously in the background, these are limited to:
> >> transfer/activate firmware, scan media, sanitize (aka overwrite)
> >> and VPPB bind/unbind.
> >>
> >> Completion of background operations, successful or not, can be handled
> >> via irq or poll based. This patch deals only with polling, which
> >> introduces some complexities as we need to handle the window in which
> >> the original background command completed, then a new one is
> >> successfully started before the poller wakes up and checks. This,
> >> in theory, can occur any amount of times. One of the problems is
> >> that previous states cannot be tracked as hw background status
> >> registers always deal with the last command.
> >>
> >> So in order to keep hardware and the driver in sync, there can be
> >> windows where the hardware is ready but the driver won't be, and
> >> thus must serialize/handle it accordingly. While this polling cost
> >> may not be ideal: 1) background commands are rare/limited and
> >> 2) the extra busy time should be small compared to the overall
> >> command duration and 3) devices that support mailbox interrupts
> >> do not use this.
> >>
> >> The implementation extends struct cxl_mem_command to become aware
> >> of background-capable commands in a generic fashion and presents
> >> some interfaces:
> >>
> >> - Calls for bg operations, where each bg command can choose to implement
> >>    whatever needed based on the nature of the operation. For example,
> >>    while running, overwrite may only allow certain related commands to
> >>    occur, while scan media does not have any such limitations.
> >>    Delay times can also be different, for which ad-hoc hinting can
> >>    be defined - for example, scan media could use some value based on
> >>    GET_SCAN_MEDIA_CAPS and overwrite has predefined values based on
> >>    pmem DSM specs[0]. Similarly some commands need to execute tasks
> >>    once the command finishes, such as overwriting requires CPU flushing
> >>    when successfully done. These are:
> >>
> >>    cxl_mbox_bgcmd_conflicts()
> >>    cxl_mbox_bgcmd_delay()
> >>    cxl_mbox_bgcmd_post()
> >>
> >> - cxl_mbox_send_cmd() is extended such that callers can distinguish,
> >>    upon rc == 0, between completed and successfully started in the
> >>    background.
> >>
> >> - cxl_mbox_bgcmd_running() will atomically tell which command is
> >>    running in the background, if any. This allows easy querying
> >>    functionality. Similarly, there are cxl_mbox_bgcmd_start() and
> >>    cxl_mbox_bgcmd_done() to safely mark the in-flight operation.
> >>    While x86 serializes atomics, care must be taken with arm64, for
> >>    example, ensuring, minimally, release/acquire semantics.
> >>
> >> There are currently no supported commands.
> >>
> >> [0] https://pmem.io/documents/IntelOptanePMem_DSM_Interface-V2.0.pdf
> >>
> >> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> >> ---
> >>   drivers/cxl/core/core.h |   3 +-
> >>   drivers/cxl/core/mbox.c | 213 ++++++++++++++++++++++++++++++++++++++--
> >>   drivers/cxl/core/port.c |   1 +
> >>   drivers/cxl/cxl.h       |   8 ++
> >>   drivers/cxl/cxlmem.h    |  55 ++++++++++-
> >>   drivers/cxl/pci.c       |   4 +
> >>   drivers/cxl/pmem.c      |   5 +-
> >>   drivers/cxl/security.c  |  13 +--
> >>   8 files changed, 282 insertions(+), 20 deletions(-)
> >>
> >> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> >> index 1d8f87be283f..2a71664a0668 100644
> >> --- a/drivers/cxl/core/core.h
> >> +++ b/drivers/cxl/core/core.h
> >> @@ -69,6 +69,7 @@ static inline struct cxl_ep *cxl_ep_load(struct cxl_port *port,
> >>   
> >>   int cxl_memdev_init(void);
> >>   void cxl_memdev_exit(void);
> >> -void cxl_mbox_init(void);
> >> +int cxl_mbox_init(void);
> >> +void cxl_mbox_exit(void);
> >>   
> >>   #endif /* __CXL_CORE_H__ */
> >> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> >> index 35dd889f1d3a..bfee9251c81c 100644
> >> --- a/drivers/cxl/core/mbox.c
> >> +++ b/drivers/cxl/core/mbox.c
> >> @@ -10,6 +10,7 @@
> >>   #include "core.h"
> >>   
> >>   static bool cxl_raw_allow_all;
> >> +static struct workqueue_struct *cxl_mbox_bgpoll_wq;
> >>   
> >>   /**
> >>    * DOC: cxl mbox
> >> @@ -24,7 +25,7 @@ static bool cxl_raw_allow_all;
> >>   	for ((cmd) = &cxl_mem_commands[0];                                     \
> >>   	     ((cmd) - cxl_mem_commands) < ARRAY_SIZE(cxl_mem_commands); (cmd)++)
> >>   
> >> -#define CXL_CMD(_id, sin, sout, _flags)                                        \
> >> +#define __CXL_CMD(_id, sin, sout, _flags, _bgops)                              \
> >>   	[CXL_MEM_COMMAND_ID_##_id] = {                                         \
> >>   	.info =	{                                                              \
> >>   			.id = CXL_MEM_COMMAND_ID_##_id,                        \
> >> @@ -33,8 +34,13 @@ static bool cxl_raw_allow_all;
> >>   		},                                                             \
> >>   	.opcode = CXL_MBOX_OP_##_id,                                           \
> >>   	.flags = _flags,                                                       \
> >> +	.bgops = _bgops,						       \
> >>   	}
> >>   
> >> +#define CXL_CMD(_id, sin, sout, _flags) __CXL_CMD(_id, sin, sout, _flags, NULL)
> >> +#define CXL_BGCMD(_id, sin, sout, _flags, _bgops)                              \
> >> +	__CXL_CMD(_id, sin, sout, _flags | CXL_CMD_FLAG_BACKGROUND, _bgops)
> >> +
> >>   #define CXL_VARIABLE_PAYLOAD	~0U
> >>   /*
> >>    * This table defines the supported mailbox commands for the driver. This table
> >> @@ -63,7 +69,7 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
> >>   	CXL_CMD(INJECT_POISON, 0x8, 0, 0),
> >>   	CXL_CMD(CLEAR_POISON, 0x48, 0, 0),
> >>   	CXL_CMD(GET_SCAN_MEDIA_CAPS, 0x10, 0x4, 0),
> >> -	CXL_CMD(SCAN_MEDIA, 0x11, 0, 0),
> >> +	CXL_BGCMD(SCAN_MEDIA, 0x11, 0, 0, NULL),
> > 
> > One of the recent revelations with this patch:
> > 
> > https://lore.kernel.org/linux-cxl/167030056464.4044561.11486507095384253833.stgit@dwillia2-xfh.jf.intel.com/
> > 
> > ...is that commands that are not meant to be called from userspace
> > should simply never appear in CXL_CMDS nor cxl_mem_commands. The
> > motivation for defining SCAN_MEDIA and friends was to use their
> > definitions to block the RAW command passthrough, but ironically that
> > enables the ioctl path which is also unwanted.
> > 
> > So I think this patchset first needs to mark those uapi command numbers
> > deprecated. Then ensure that all other background commands can not be
> > submitted via the ioctl path.
> > 
> >>   	CXL_CMD(GET_SCAN_MEDIA, 0, CXL_VARIABLE_PAYLOAD, 0),
> >>   	CXL_CMD(GET_SECURITY_STATE, 0, 0x4, 0),
> >>   	CXL_CMD(SET_PASSPHRASE, 0x60, 0, 0),
> >> @@ -145,6 +151,136 @@ static const char *cxl_mem_opcode_to_name(u16 opcode)
> >>   	return cxl_command_names[c->info.id].name;
> >>   }
> >>   
> >> +static unsigned long __maybe_unused
> >> +cxl_mbox_bgcmd_delay(struct cxl_dev_state *cxlds, u16 opcode)
> >> +{
> >> +	struct cxl_mem_command *c;
> >> +	unsigned long ret = 0;
> >> +
> >> +	c = cxl_mem_find_command(opcode);
> > 
> > Per that change above, cxl_mem_find_command() is only for the uapi.
> > 
> >> +	if (!c || !(c->flags & CXL_CMD_FLAG_BACKGROUND)) {
> >> +		dev_WARN_ONCE(cxlds->dev, true,
> >> +			      "Not a background command\n");
> >> +		return 0;
> >> +	}
> >> +
> >> +	if (c->bgops && c->bgops->delay)
> >> +		ret = c->bgops->delay(cxlds);
> >> +
> >> +	return ret * HZ;
> >> +}
> > 
> > In general I worry that this is a bit too flexible. Instead of callback
> > ops I think this wants to be straight line code with something like a
> > poll_interval argument in 'struct cxl_mbox_cmd' where 0 means the
> > command is immediate and non-zero is a number of jiffies between
> > background operation polling intervals.
> > 
> >> +
> >> +static void cxl_mbox_bgcmd_post(struct cxl_dev_state *cxlds,
> >> +				u16 opcode, bool success)
> >> +{
> >> +	struct cxl_mem_command *c;
> >> +
> >> +	c = cxl_mem_find_command(opcode);
> >> +	if (!c || !(c->flags & CXL_CMD_FLAG_BACKGROUND)) {
> >> +		dev_WARN_ONCE(cxlds->dev, true,
> >> +			      "Not a background command\n");
> >> +		return;
> >> +	}
> >> +
> >> +	if (c->bgops && c->bgops->post)
> >> +		c->bgops->post(cxlds, success);
> >> +}
> >> +
> >> +/*
> >> + * Ensure that ->mbox_send(@new) can run safely when a background
> >> + * command is running. If so, returns zero, otherwise error.
> >> + *
> >> + * check 1. bg cmd running. If not running it is fine to
> >> + *	    send any command. If one is running then there
> >> + *	    may be restrictions.
> >> + * check 2. @new incoming command is capable of running
> >> + *          in the background. If there is an in-flight bg
> >> + *          operation, all these are forbidden as we need
> >> + *          to serialize when polling.
> >> + * check 3. @new incoming command is not blacklisted by the
> >> + *          current running command.
> >> + */
> >> +static int __maybe_unused
> >> +cxl_mbox_check_cmd_bgcmd(struct cxl_dev_state *cxlds, u16 new)
> >> +{
> >> +	struct cxl_mem_command *c;
> >> +
> >> +	/* 1 */
> >> +	if (likely(!cxl_mbox_bgcmd_running(cxlds)))
> >> +		return 0;
> >> +
> >> +	c = cxl_mem_find_command(new);
> >> +	if (!c)
> >> +		return -EINVAL;
> >> +
> >> +	/* 2 */
> >> +	if (c->flags & CXL_CMD_FLAG_BACKGROUND)
> >> +		return -EBUSY;
> >> +
> >> +	/* 3 */
> >> +	if (c->bgops && c->bgops->conflicts)
> >> +		return c->bgops->conflicts(new);
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +/*
> >> + * Background operation polling mode.
> >> + */
> >> +void cxl_mbox_bgcmd_work(struct work_struct *work)
> > 
> > Is a workqueue needed? If the goal is to make it so that all the kernel
> > background command use cases chop up their work so that one command can
> > not monopolize the mailbox for a long amount of time then the
> > implementation can also assume that foreground commands that collide
> > with an in-flight background operation can just wait synchronously for
> > their time slice.
> > 
> > That makes the handling simple, acquire lock, poll for completion,
> > and everyone else just queues up on the lock.
> 
> Aren't certain commands valid while a background command is on going? 
> Just thinking if you are doing a sanitize (overwrite), for a pmem it may 
> take a LONG time. And maybe you don't want to block everything for the 
> duration of that command completion? Maybe I'm not understanding what 
> you are saying here.
> 

I am saying the possibility that a device implementation *might* allow
foreground commands to proceed while background commands are operating
is close to useless the way the specification defines it. The fact that
the implementation needs to be prepared for any foreground command to
return "Busy" due to background operation conflict and the fact that
background operations do not stack leads me to say, no, let's not play
those games and just handle everything in-order with no overlap.

While it is true that overwrite can occupy ->mbox_send() for a long
time, it also specifies that commands that depend on the media being in
a 'not disabled' state will also fail. So again, for simplicity, if you
start an overwrite one of the consequences is all other command requests
block or fail until that completes. Likely 'fail' is better than 'block'
to encourage user space to be mindful that it cannot overlap overwrite
and any other device usage.

Otherwise, the complexity needs to have an exceedingly good reason, not
just "because the spec might allow it".
