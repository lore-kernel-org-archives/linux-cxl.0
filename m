Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0487FC001DE
	for <linux-cxl@archiver.kernel.org>; Sun, 23 Jul 2023 04:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjGWE5L (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 23 Jul 2023 00:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjGWE5K (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 23 Jul 2023 00:57:10 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B09BE7B
        for <linux-cxl@vger.kernel.org>; Sat, 22 Jul 2023 21:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690088228; x=1721624228;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Gb4dpqtPbqE71HOGlII8XtpcKD2dtbfy/LDRwRcT3T0=;
  b=m0LBtrkyCX0Nt7B4LBdm/J7YJ/pGvlR5qKv/e9RDSnNI6e4Iiheg0woh
   Q5Li8LEMGKGqOvM7lNG6Tmgl8bCyR5jwDnE4hdyI93i/BFBI605BE2sdD
   1ERbzfGI5jWBe9hoYr7HdNst8xHNw2wamVsQv8mUoOcWqmhd3VsMnf6Iu
   NgLiNA2BItc7ewgpVmIerCtpLXigX2Z0tyjUBmejmvGBLu5fYsQJVZ1Y5
   J70NrIIBKe7N4DPQpwQF8cbxo2QN8VS1nCpVrg7niKL42EQRjkOredDlc
   DoF4aGymfrgD27WE3iNqEMtlh1urWImxf32PcgnuCP5AjpwoJfZrxD+Nu
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10779"; a="352142982"
X-IronPort-AV: E=Sophos;i="6.01,226,1684825200"; 
   d="scan'208";a="352142982"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2023 21:57:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10779"; a="760407171"
X-IronPort-AV: E=Sophos;i="6.01,226,1684825200"; 
   d="scan'208";a="760407171"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP; 22 Jul 2023 21:57:07 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sat, 22 Jul 2023 21:57:06 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sat, 22 Jul 2023 21:57:06 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Sat, 22 Jul 2023 21:57:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SZWLYvfU7R0A9co3riIOXXdsmky8LjxWX1tWGGytCQYlPle+lwzXVhDs7dojnNNYA/1JgEz78p9i1YbVxPzHH6ygzo6WCpBBeXpI4hi9/5zlLVP8l3YwK58swk6dPOmE+xzcTE4x3bTWp4nZLsViAMiJK9bgW2a40pGXRIgiy2fGEfGA0bZbgtDA7DSWhGhwFZVkP08/GOsVHWkJmkbBR2yFmHG6MLkdLI+hGSnThAT58zROL4gmKKnfJeOtBOS7D6Zb9JgnsRW8JXsvrnSMln2ueku59aVa/vK9ziLjimGmDdvh2dFJUcjAoMP8gHzTSmWbj3AczVmCC7B09f2xEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KxrQ8nR4qwKpiXGK6sWPcUibhmJjvBQdd5I9yQLKp3I=;
 b=coYksCBkOYIRmk9Qt9QpiK6QXitHlEQKzTnTfb9TfGSCEpseaLQxGujOjhs0+tEJ9sgtWSQ9ASe+PdRQXObIGYf4ED7CCS0Gla8xbdvuiVWVbfhT0TvMYrB0MxbAgE1wn6meKu+0KpiPMwCNijNMbsUMxoFDpWMYTmHhAkE1QmgA8kfCDIRDXyCjrUhS+w/+EieDhuf0+1Umo5ZVA23KQlXLH5gsrrDuDzK0qU6oNO6l0XiN76Vl5QWrDBnUdV9yEm+oTwF5N9UdyEG/QP+oA/Wwgs+cMTJS34aaSXU+X2vV7AykudUzNjUAeYQQVb4HYVFm+ctXs1hQ0Vdz/ZQLpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SA0PR11MB4672.namprd11.prod.outlook.com (2603:10b6:806:96::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Sun, 23 Jul
 2023 04:57:04 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938%6]) with mapi id 15.20.6609.030; Sun, 23 Jul 2023
 04:57:04 +0000
Date:   Sat, 22 Jul 2023 21:57:00 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     <nifan@outlook.com>, <qemu-devel@nongnu.org>
CC:     <jonathan.cameron@huawei.com>, <linux-cxl@vger.kernel.org>,
        <gregory.price@memverge.com>, <hchkuo@avery-design.com.tw>,
        <cbrowy@avery-design.com>, <ira.weiny@intel.com>,
        <dan.j.williams@intel.com>, <a.manzanares@samsung.com>,
        <dave@stgolabs.net>, <nmtadam.samsung@gmail.com>,
        Fan Ni <nifan@outlook.com>
Subject: Re: [Qemu PATCH 0/9] Enabling DCD emulation support in Qemu
Message-ID: <64bcb31c9a8dc_760de2941@iweiny-mobl.notmuch>
References: <SG2PR06MB33976BB3F9C47CBE08F02D09B23EA@SG2PR06MB3397.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <SG2PR06MB33976BB3F9C47CBE08F02D09B23EA@SG2PR06MB3397.apcprd06.prod.outlook.com>
X-ClientProxiedBy: SJ0PR13CA0004.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::9) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SA0PR11MB4672:EE_
X-MS-Office365-Filtering-Correlation-Id: f75df93a-5634-4d65-a1d1-08db8b39420f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GU0ldQ+nb7hjwyxLeHhgEQfUjKi6gBYL6Ee+NzYWPTRnHrvaZLYpE8d+oB+Q2IhGOGDtWaOF+BoAsEiyGQBAJEIEOA8WTdloN1eSCEklKVq5aVB1972VKVDKU83qbLPP07dUNa1kL/VmFCVTS0PaSuwxxmtKgrEOB5UhUZbHcqb+2FtXxWq7z/lXqN0PFiYrO7cUsYVOKC74035tcs4uODd6/g/LpWucrpJzKZxWjksYNqR2jkQ8Qh9F3R9uBq4NkH7qTa/2En40yEA0YpbV9mcZkNwm2A15unpj3AYcnfBUUOLCDfPl9/BCN1+pJMGKjqIYzWJnQcY1K0sdiEDHKxeqAvdpa+rtYZ5IljsJ7PVqaKJABrVl1XDGcgWPa4pl4CJ0k+0bLDh0QkQgIKL6cZx6QjDehLcyYsuKgLqxoqtRYRA5FkbzzrZZn0SsV/PRgUeNuAgSnz9fAMFEO3w5GI411ARLBwYtN7X3cqgqtPq1iAGZpG5YCgR5oh4PsDBt+ln26BQcJDwZn2Zc+5eSbey1vIbQsLXSldZll1D/u2U9Etu1RbmDIp+pVI7gZavDXRorcjtUuLySYtyns6SWxQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(346002)(136003)(39860400002)(366004)(451199021)(38100700002)(83380400001)(8936002)(8676002)(7416002)(44832011)(5660300002)(478600001)(66556008)(66476007)(4326008)(316002)(66946007)(41300700001)(26005)(186003)(6506007)(45080400002)(966005)(6486002)(6512007)(6666004)(9686003)(2906002)(86362001)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yXdeNleoULDktR0EttF2pfciTOCN8jUTjV+VhVCh04WJrotzbgysFLPkYGfo?=
 =?us-ascii?Q?gjG8IVwkdNr8ZRzfOJHa0Vuk/YmlsHzKL26F7qVV1XdxRiLP40Yr3bMQRtzy?=
 =?us-ascii?Q?Kulc2GtsK+N+nOrcu7CbfFRL/1Lrtv6Dgni53baVlDCVm+kY+CHMZG4de6HF?=
 =?us-ascii?Q?XJ7qj19zKEo5fxOM5RWSo748cC6U4nY6ms7J0AFmKQnZcZhNiriGIikTK7f0?=
 =?us-ascii?Q?vwuk7XyMJC46nQM2UG8Xyu27gZWcol3StHYr53QbrK4qYW86prZSgXHE4j8h?=
 =?us-ascii?Q?PNEnSpiUD3Eo9n74vVXTg/sKxd/4TGWLhi0o385QyIQ/Lc1VBmWxj/IazPIW?=
 =?us-ascii?Q?hzHmBkV0fuWQ/rh7dpQkKVFeYR6wKMfdtPDBpoMQeXMI8qrr/S3t1+IUN6aD?=
 =?us-ascii?Q?OeDUw11bEbLiWNwE2LY/G9wHHWtCSp1H0YbLKeDHoEN0DStrasNAABzYaxvW?=
 =?us-ascii?Q?CtI9p2HruUEhMIAAhLroZpHgNTbu9RBugd7sYuWTr1iWOGDw5SCnhfVPgK0K?=
 =?us-ascii?Q?79wbAIF0zQJ7zIBzo9yNKWNQ6gEAD2Z2riSPMLPUfvRKfqyWMdQz/dwPwu46?=
 =?us-ascii?Q?fegavFLVhlhnHRQY43zNP1dMieCD1/mzyWUxzsWepIuBDq+eaB3ARYQQIvIH?=
 =?us-ascii?Q?5NkjPENdGt71OF+AQ36gVvoVjSHSjv6XQgC+ZLWDmL2td9wDdH0nB/OlnFvV?=
 =?us-ascii?Q?sESq2r47qFDsTqBqrGWMtbOkA7KipO807qAuUnceowqqlCnIM/DskNFna6Yc?=
 =?us-ascii?Q?9XObhvmTn0h1SBx/y7hdtxOBnnkEC115amRHSwwSbDul/tg/UNHYlAntMzoy?=
 =?us-ascii?Q?CSLfc9Ooy+oAYm/BjZLYqVzr7hiPo+HW2qgYAgK4Brd3TXdtSWJFWBOEoFoB?=
 =?us-ascii?Q?saHFfpp2LrVUuIZ3xXJAPBklcWePWVJtAFb7Mrlucf7rRQwNQXdAaYEVt0XC?=
 =?us-ascii?Q?k255CGG2qwwBbGvhQSxDE7KoVmtaUnwPVpmDsd4Liboj3BbiVA8rZejDwgD2?=
 =?us-ascii?Q?hfOMEVnRkvqqQsKOKjV+AWNiQS5UGLZ9m4jw75sqOo7s5RShglg4m0GNKImg?=
 =?us-ascii?Q?RQGP/a/uWqujrJH/1iFAnXrNEaRb8m8KFYmTUGuOiWScmJHOUe1kO+ITA/Mi?=
 =?us-ascii?Q?8F2p0O/cKBeeuRfFi5pWSVo7mDuQS0dTF4wrDRUPG6BOMVgpjkO8qtNZsD1+?=
 =?us-ascii?Q?u83gMEebVSkEZfsMGrv5VIdnqF72C79xERgB5xULlh7/HS1IxHQxWjmMYUwC?=
 =?us-ascii?Q?djEFm/RdQbsh/hUbz4K+j/13HmXBd8ACzhtLrJkTXWrFmAuR8bPxmznSILe7?=
 =?us-ascii?Q?bIHFzAFjcYkYQ+GOgIjg8s+8eyvT2GYIx6SGX8oSkxAgbKtr73Xi8sIOLDjD?=
 =?us-ascii?Q?3aJuAIqPkCp+nOmCcriB6AztNkpS13xuGUro0rvo6Xtc9RybT17RgqIjTUAT?=
 =?us-ascii?Q?Q0FPqacsrn16/rg0B+IPCcCKZpfaFuEfGOa+wCmWQiMuBIxZi9Czz4lZkXC5?=
 =?us-ascii?Q?NlnbRwaAeXVxqZZNuOHTbGrXQGODRXA/2GPzzEo66iNm84WAmSs6gbjq/Jol?=
 =?us-ascii?Q?nTzqSnknYcYs5z6uVyevohrpmHV1VoK800/F/uZ7?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f75df93a-5634-4d65-a1d1-08db8b39420f
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2023 04:57:04.3048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TSMtYMywkq8WZINKpfa4Q1PUFBFFVmxAoXNjMBU0ZVsAet65TlbypEO9npD9+USWnQEAlTShr91/BQe1vSgDeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4672
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

nifan@ wrote:
> From: Fan Ni <nifan@outlook.com>
> 
> The patch series provides dynamic capacity device (DCD) emulation in Qemu.
> More specifically, it provides the following functionalities:
> 1. Extended type3 memory device to support DC regions and extents.
> 2. Implemented DCD related mailbox command support in CXL r3.0: 8.2.9.8.9.
> 3. ADD QMP interfaces for adding and releasing DC extents to simulate FM
> functions for DCD described in cxl r3.0: 7.6.7.6.5 and 7.6.7.6.6.
> 4. Add new ct3d properties for DCD devices (host backend, number of dc
> regions, etc.)
> 5. Add read/write support from/to DC regions of the device.
> 6. Add mechanism to validate accessed to DC region address space.
> 

Sorry I see them in this other thread now.

https://lore.kernel.org/all/SG2PR06MB3397F3E74A083607F7492FA4B23EA@SG2PR06MB3397.apcprd06.prod.outlook.com/

Thanks,
Ira

> A more detailed description can be found from the previously posted RFC[1].
> 
> Compared to the previously posted RFC[1], following changes have been made:
> 1. Rebased the code on top of Jonathan's branch
> https://gitlab.com/jic23/qemu/-/tree/cxl-2023-05-25.
> 2. Extracted the rename of mem_size to a separated patch.(Jonathan)
> 3. Reordered the patch series to improve its readability.(Jonathan)
> 4. Split the validation of accesses to DC region address space as a separate
> patch.
> 5. Redesigned the QMP interfaces for adding and releasing DC extents to make
> them easier to understand and act like existing QMP interfaces (like the
> interface for cxl-inject-uncorrectable-errors). (Jonathan)
> 6. Updated dvsec range register setting to support DCD devices without static
> capacity.
> 7. Fixed other issues mentioned in the comments (Jonathan&Nathan Fontenot).
> 8. Fixed the format issues and checked with checkpatch.pl under qemu code dir.
> 
> 
> The code is tested with the DCD patch series at the kernel side[2]. The test
> is similar to those mentioned in the cover letter of [1].
> 
> 
> [1]: https://lore.kernel.org/all/20230511175609.2091136-1-fan.ni@samsung.com/
> [2]: https://lore.kernel.org/linux-cxl/649da378c28a3_968bb29420@iweiny-mobl.notmuch/T/#t
> 
> Fan Ni (9):
>   hw/cxl/cxl-mailbox-utils: Add dc_event_log_size field to output
>     payload of identify memory device command
>   hw/cxl/cxl-mailbox-utils: Add dynamic capacity region representative
>     and mailbox command support
>   include/hw/cxl/cxl_device: Rename mem_size as static_mem_size for
>     type3 memory devices
>   hw/mem/cxl_type3: Add support to create DC regions to type3 memory
>     devices
>   hw/mem/cxl_type3: Add host backend and address space handling for DC
>     regions
>   hw/mem/cxl_type3: Add DC extent list representative and get DC extent
>     list mailbox support
>   hw/cxl/cxl-mailbox-utils: Add mailbox commands to support add/release
>     dynamic capacity response
>   hw/cxl/events: Add qmp interfaces to add/release dynamic capacity
>     extents
>   hw/mem/cxl_type3: Add dpa range validation for accesses to dc regions
> 
>  hw/cxl/cxl-mailbox-utils.c  | 421 +++++++++++++++++++++++++++-
>  hw/mem/cxl_type3.c          | 539 +++++++++++++++++++++++++++++++++---
>  hw/mem/cxl_type3_stubs.c    |   6 +
>  include/hw/cxl/cxl_device.h |  49 +++-
>  include/hw/cxl/cxl_events.h |  16 ++
>  qapi/cxl.json               |  49 ++++
>  6 files changed, 1034 insertions(+), 46 deletions(-)
> 
> -- 
> 2.39.2
> 


