Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6CFDC4332F
	for <linux-cxl@archiver.kernel.org>; Fri, 14 Oct 2022 00:22:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiJNAWM (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 13 Oct 2022 20:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiJNAWL (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 13 Oct 2022 20:22:11 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2958B140BE
        for <linux-cxl@vger.kernel.org>; Thu, 13 Oct 2022 17:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665706926; x=1697242926;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=p1U/XlJbU/B648MpyCF7Mkn+Th1ToiTJaISFEfSX8+c=;
  b=FtfUAJ4Qo1Y3C/duQeWQT7F9CO8f9aOE/YVK/iJjCkf4K3iSTU9XA6Vg
   5aYDx/pa13naSPASFwghpbTcJaN7oYtsKjeAhCgIHgUjLrj7ubDP0qRvD
   zzz8sE5ofsv9qJJppnHt7d3KxFRWRtgzrjUk5+uERu1XK68gGMQkVaX7H
   2ZwjyOsPVM6uF+9LRy9TPsAEB9Z6FegtCqgP6wFG6GH3fSwSZZBky1lLC
   9yAzmN03MEVxT6+Zxf+miTZ8tUgAwNVtQXKbTAY24/FR4b6Eo9HQjE0f5
   MTixfDjOQAsm51oU+aM2A9tNisWR2WBqdxWW48B822oKg/kBwCoCGs8m/
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="391548129"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="391548129"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2022 17:22:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="658389670"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="658389670"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP; 13 Oct 2022 17:22:04 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 13 Oct 2022 17:22:03 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 13 Oct 2022 17:22:03 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 13 Oct 2022 17:22:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DfoavQR7/L1ee36ozXWPgTNa7L+s1a6WjsXejkMvi154j6uUuTDkcKDL8xfrE4QjGKV+rDxt+b27ufcJRePbGcxAPdIM+Cnf1cdi1jYHrmzuhVJfOpBjD7rMxhMwiAY0AjhiMTTQNoOJjGFnFWnmULut12/5vGmWt/F/DbZvc/U2Tg2HlUIFnzw+HqiRSmOQ3ZusyDPC6M5MLCPv8dvi+1y8O8ksDgaJjR5wcpmmrekUlEFHN2COif3fwitcL13uy6Fdl4H5K3KMftAK4ybvyaHlMb3TCpFKDEmbTxodVLY2EBi5xOfVjWrO3k9KCP+nRAOodBXUwd8KrIZCDivdHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QEmGHuTpxKd3CQX1o1fjeEp4SzTAyhx/n7P5wbkO+mw=;
 b=PTWMuG4yvD2yirz/l+ItvQi3K0iQ8N63lqQDMlfpfwkz+cPn39Fn4HCn6F6MG/cDWIc9gtbb2qFiGyqn3BbhBPy1Hx114F5DkqLJNofJCPhqNN2AzeMAdwn86oUBXjoCdEQHIbhxzevLM8cImVk77PIBN6X946ajwHUOjvju6AJAXFaDcCEChL/hrHXuC7rVWeP5ikiMWjRq92ImJC25uzmHNjBhVplW3vsWXKoox64/LbTmjOItPRyXtSMDjSpXcgk3ln4N0+fwg6oPjp8Ho22gJO9pt1yFNSP5IWQ7WBHH7/u0B6y0yk+lPkGG+gjfJ0ZidyATkgP4aq1Fi9RFRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SA1PR11MB6566.namprd11.prod.outlook.com (2603:10b6:806:251::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Fri, 14 Oct
 2022 00:22:01 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6f83:c165:aa0c:efae]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6f83:c165:aa0c:efae%8]) with mapi id 15.20.5723.026; Fri, 14 Oct 2022
 00:22:01 +0000
Date:   Thu, 13 Oct 2022 17:21:56 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>, <qemu-devel@nongnu.org>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [RFC PATCH 3/6] hw/cxl/cxl-events: Add CXL mock events
Message-ID: <Y0irpF3hT947zkol@iweiny-desk3>
References: <20221010222944.3923556-1-ira.weiny@intel.com>
 <20221010222944.3923556-4-ira.weiny@intel.com>
 <20221011110759.00002226@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221011110759.00002226@huawei.com>
X-ClientProxiedBy: BYAPR01CA0067.prod.exchangelabs.com (2603:10b6:a03:94::44)
 To SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SA1PR11MB6566:EE_
X-MS-Office365-Filtering-Correlation-Id: a2a210ab-ce4f-4ed1-02e4-08daad7a1d16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: spT9uRxnq18Y5uieLRRyDkkPVMEYuoH/clC/5oZGJEfcWcisnj1x2Du9JPOi923iboJn7IAuX2dJg3pfkxGslSuLjk0qn1ukehpY1VD9sh4WhRECjYjqzM+lTF44Y7HpcMj/VigMsBoJalLViuD4xZh47nMZp8ehxwofs3GVsYFhdu+NekaoSA8HJmEEZVT+wOZ9vs7GmSmzgyuMeCD6FFQ/+GJE2r+NzlJc+1Q+rgjcLeLjWoBUK1CojRRb/WMgDnmLo5mBzrclkArOwgKHuAZbBYsxUoOs/D+KBzRb3B3JUB/kHJsYZqsqG+25Z+ZzZB9ESooCZOKLe0ROka4eOmww2RJi+Evh3UH5XBwF490Iiow3IeGMzoPq+E8BJFELB2ZHtLVfiq2KJZY+36RdRkywK0Wwn1fGkXVH2Fuo68h3phh5RhA02/90G8Pmk5AFZ2JrpWl5RPy40ic0zRxXnYtv6Ylo+W3i/Q+JOmGgPpGiXYpUzHYxaXSEel4mXK3UDhoBGZ9BG7qEqQY3qGLyJde5Mul5plszHTX9dxhvxJ1Z1QlX8iWCGD7cHC7zYZkaUQUaOKktjCvJbj6rw1yx/8yIthvteRrbdUo4daUV92MfrkzolVxc312vjSpa2o4GUVZQNwrDPw+4OdZ7ERz1czbvCYwWZdT8CI3wQf1ahSi1q1L/Y3hXbty8QaS7FazIKq72R0A8hjTv4MvITg7n6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(376002)(39860400002)(346002)(366004)(396003)(451199015)(9686003)(4326008)(26005)(2906002)(6512007)(86362001)(66476007)(33716001)(316002)(8936002)(6916009)(54906003)(186003)(66946007)(66556008)(8676002)(6666004)(38100700002)(82960400001)(478600001)(6506007)(5660300002)(30864003)(6486002)(44832011)(66899015)(41300700001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xXdkMrz37vaB1s1uwVespw6rNIhxubRZSs7mG6Ul4ZtFqDpY/D3VU83g+l0G?=
 =?us-ascii?Q?GHU/m1iKvYH4zerhx9B7PeEfbGai0bjMkbDLfLF62D6o6Z8l2JQ2GW88jB3O?=
 =?us-ascii?Q?U8NeTXyOj2Ytjlb5XMBstjq7nSyha+XzYn0nNaM1ysW5xQSN1w6y3Uz4K9un?=
 =?us-ascii?Q?W0LKRfwnRBR0syDADlVDJOjKAd1QEXkdmaqh/GzZlsKaLw1s9d9bleOs6hqW?=
 =?us-ascii?Q?0oxf139XJ7oJWaAfdo+FW/U0UGPylu/0avSiICB38tNXpQP1bLGMISLwBcOY?=
 =?us-ascii?Q?WXjvahzB/Qh9pd+Cg6qbbAi1g6Pm/Ouybbbqdc9swdDHpxLBRyJTma7d+4xl?=
 =?us-ascii?Q?h71TPpl4RNXgwj9n5QW+9xknDBTuk1+wVBl13CSP8gR6rVSbVJFxkRW7ek5F?=
 =?us-ascii?Q?kvhpeHbzZ7sd0kl5zFUV9osW9qCoel8Zt5lsWredgFv6B720quOSO9S0qDKe?=
 =?us-ascii?Q?5IATDmOowpwzSXtA+99j+H1jvJYNWtBXx2oSuCJGbmZr8tI0Lh9EL3xS4aoK?=
 =?us-ascii?Q?O5r2jxeboKQhKSagiHIs8AdLlr8+ayN+b5Mr8wcF2pBFN+a6X7eZu968PKLm?=
 =?us-ascii?Q?5Khc+9ePQtjqC6bJA45WA4AB2UjkGGon3Rt3mzPZUVTnlvxbtmbY6rqqY4vr?=
 =?us-ascii?Q?S9J/A/lWCewlis7WIttQo3XLctSaW0BPzqiDM9ilTn0s4a+vuf3zBtp1/KjY?=
 =?us-ascii?Q?i06tM2KW+A//sI7BC4OP19QWHJQJ4MpsZYm8U1eXgbIgDkseGyaXevsuqjhX?=
 =?us-ascii?Q?F7KRzzumRrohntDlLRQnjn9rKW4U6AKiRjLI+zx9s86us6AOzeEUjmWYVJ7S?=
 =?us-ascii?Q?V+dWOAJTPZBpmDxS/GeDbLzLwTrdsBprmukdSgHd4Mh4XRkgXqo5vCDk4KPR?=
 =?us-ascii?Q?CFqFj/g8/P5TLq11JLhmB+nKTpJ9jhck4OCLi5cFX98Hpj3DgW62dZ6T8wLZ?=
 =?us-ascii?Q?P+zU41xxkC5voCwMABZ8RJ6tBt//q5kTgEN+nWPxyPPivOwf8aOww1Lxj2RK?=
 =?us-ascii?Q?+NyHBTsRjd6orHh1JVCuIo3msZUgMylhoo6TZJr7HJXBP+MemW0zte48GRey?=
 =?us-ascii?Q?33YphLKNMZ0zSVDaVzWSdTv5D8IV737Fl16a0Ar29FukTBx8+I3Pq8cOQipL?=
 =?us-ascii?Q?7pJrVh8P4nKahDK75dZMK8JVEBLQ9zo5fViVShdE+j/9A2v45M2JC28jVoUF?=
 =?us-ascii?Q?ADW7OKrxCPU85o6yJoQroKWhpcvT75RoOgIwkLWn0tB/sVuHFFSAZlDbYVld?=
 =?us-ascii?Q?ULoAy056YUbD/5Ya1ECV9XK50pvP0LioCc1Fn0eRUnLkzIOSahlYmHnOwFrs?=
 =?us-ascii?Q?30cA7242MagpbJigPoilDzSok1QqCp1M1AOo4gBWG48lgtG/VLfspJSM2YU6?=
 =?us-ascii?Q?LEFdYTx0usT1VaNL43PzPduIFX//h1yjKcywXZtSfpIFNbuBaQg/ZX9W3DvV?=
 =?us-ascii?Q?vygZbLVPUudJyMLdVbZo+4/ZJfy1Eo+AlPp/kQWs0xHhvmGYPKRDQTMeYm6V?=
 =?us-ascii?Q?163E42MZ7/8NVm1cSEKGYdVMQviDEBUFlvL8VV2hRmP4RyxcpKZyx2f2TA1O?=
 =?us-ascii?Q?M/OiesAsfzktHMELM06soXydRxOC0wBamgLrw1LbzKSDMDQ0eTqiDZK3c9hM?=
 =?us-ascii?Q?Ow=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a2a210ab-ce4f-4ed1-02e4-08daad7a1d16
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 00:22:01.3818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xG09qbPGB3UlE6J4V9XSWDhKgv2GOPyLHzq3rkBsMCrnLI0ZE/Tyu6yEoL2AEYpq1L9I0AnkgCyQJX7IVdEsxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6566
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Oct 11, 2022 at 11:07:59AM +0100, Jonathan Cameron wrote:
> On Mon, 10 Oct 2022 15:29:41 -0700
> ira.weiny@intel.com wrote:
> 
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > To facilitate testing of guest software add mock events and code to
> > support iterating through the event logs.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> Various comments inline, but biggest one is I'd like to see
> a much more flexible injection interface.  Happy to help code one
> up if that is useful.

Quick response to this.

I thought about holding off and doing something like that but this got the irq
testing in the kernel off the ground.

I think it would be cool to use QMP to submit events as json.  That would be
much more flexible.  But would have taken a lot more time.

What I did below duplicated the test code cxl-test has.  It was pretty quick to
do that.

The biggest issue with is parsing the various events from the json to binary blobs.

I'll clean up this patch and see what I can do.  But I think having a set of
statically defined blobs which can be injected would make testing a bit easier.
Less framework to format json input to QMP.

More to come...

Ira

> 
> Jonathan
> 
> 
> > ---
> >  hw/cxl/cxl-events.c         | 248 ++++++++++++++++++++++++++++++++++++
> >  hw/cxl/meson.build          |   1 +
> >  include/hw/cxl/cxl_device.h |  19 +++
> >  include/hw/cxl/cxl_events.h | 173 +++++++++++++++++++++++++
> >  4 files changed, 441 insertions(+)
> >  create mode 100644 hw/cxl/cxl-events.c
> >  create mode 100644 include/hw/cxl/cxl_events.h
> > 
> > diff --git a/hw/cxl/cxl-events.c b/hw/cxl/cxl-events.c
> > new file mode 100644
> > index 000000000000..c275280bcb64
> > --- /dev/null
> > +++ b/hw/cxl/cxl-events.c
> > @@ -0,0 +1,248 @@
> > +/*
> > + * CXL Event processing
> > + *
> > + * Copyright(C) 2022 Intel Corporation.
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2. See the
> > + * COPYING file in the top-level directory.
> > + */
> > +
> > +#include <stdint.h>
> > +
> > +#include "qemu/osdep.h"
> > +#include "qemu/bswap.h"
> > +#include "qemu/typedefs.h"
> > +#include "hw/cxl/cxl.h"
> > +#include "hw/cxl/cxl_events.h"
> > +
> > +struct cxl_event_log *find_event_log(CXLDeviceState *cxlds, int log_type)
> > +{
> > +    if (log_type >= CXL_EVENT_TYPE_MAX) {
> > +        return NULL;
> > +    }
> > +    return &cxlds->event_logs[log_type];
> > +}
> > +
> > +struct cxl_event_record_raw *get_cur_event(struct cxl_event_log *log)
> > +{
> > +    return log->events[log->cur_event];
> > +}
> > +
> > +uint16_t get_cur_event_handle(struct cxl_event_log *log)
> > +{
> > +    return cpu_to_le16(log->cur_event);
> > +}
> > +
> > +bool log_empty(struct cxl_event_log *log)
> > +{
> > +    return log->cur_event == log->nr_events;
> > +}
> > +
> > +int log_rec_left(struct cxl_event_log *log)
> > +{
> > +    return log->nr_events - log->cur_event;
> > +}
> > +
> > +static void event_store_add_event(CXLDeviceState *cxlds,
> > +                                  enum cxl_event_log_type log_type,
> > +                                  struct cxl_event_record_raw *event)
> > +{
> > +    struct cxl_event_log *log;
> > +
> > +    assert(log_type < CXL_EVENT_TYPE_MAX);
> > +
> > +    log = &cxlds->event_logs[log_type];
> > +    assert(log->nr_events < CXL_TEST_EVENT_CNT_MAX);
> > +
> > +    log->events[log->nr_events] = event;
> > +    log->nr_events++;
> > +}
> > +
> > +uint16_t log_overflow(struct cxl_event_log *log)
> > +{
> > +    int cnt = log_rec_left(log) - 5;
> 
> Why -5?  Can't we make it actually overflow and drop records
> if that happens?
> 
> > +
> > +    if (cnt < 0) {
> > +        return 0;
> > +    }
> > +    return cnt;
> > +}
> > +
> > +#define CXL_EVENT_RECORD_FLAG_PERMANENT         BIT(2)
> > +#define CXL_EVENT_RECORD_FLAG_MAINT_NEEDED      BIT(3)
> > +#define CXL_EVENT_RECORD_FLAG_PERF_DEGRADED     BIT(4)
> > +#define CXL_EVENT_RECORD_FLAG_HW_REPLACE        BIT(5)
> > +
> > +struct cxl_event_record_raw maint_needed = {
> > +    .hdr = {
> > +        .id.data = UUID(0xDEADBEEF, 0xCAFE, 0xBABE,
> > +                        0xa5, 0x5a, 0xa5, 0x5a, 0xa5, 0xa5, 0x5a, 0xa5),
> > +        .length = sizeof(struct cxl_event_record_raw),
> > +        .flags[0] = CXL_EVENT_RECORD_FLAG_MAINT_NEEDED,
> > +        /* .handle = Set dynamically */
> > +        .related_handle = const_le16(0xa5b6),
> > +    },
> > +    .data = { 0xDE, 0xAD, 0xBE, 0xEF },
> > +};
> > +
> > +struct cxl_event_record_raw hardware_replace = {
> > +    .hdr = {
> > +        .id.data = UUID(0xBABECAFE, 0xBEEF, 0xDEAD,
> > +                        0xa5, 0x5a, 0xa5, 0x5a, 0xa5, 0xa5, 0x5a, 0xa5),
> > +        .length = sizeof(struct cxl_event_record_raw),
> > +        .flags[0] = CXL_EVENT_RECORD_FLAG_HW_REPLACE,
> > +        /* .handle = Set dynamically */
> > +        .related_handle = const_le16(0xb6a5),
> > +    },
> > +    .data = { 0xDE, 0xAD, 0xBE, 0xEF },
> > +};
> > +
> > +#define CXL_GMER_EVT_DESC_UNCORECTABLE_EVENT            BIT(0)
> > +#define CXL_GMER_EVT_DESC_THRESHOLD_EVENT               BIT(1)
> > +#define CXL_GMER_EVT_DESC_POISON_LIST_OVERFLOW          BIT(2)
> > +
> > +#define CXL_GMER_MEM_EVT_TYPE_ECC_ERROR                 0x00
> > +#define CXL_GMER_MEM_EVT_TYPE_INV_ADDR                  0x01
> > +#define CXL_GMER_MEM_EVT_TYPE_DATA_PATH_ERROR           0x02
> > +
> > +#define CXL_GMER_TRANS_UNKNOWN                          0x00
> > +#define CXL_GMER_TRANS_HOST_READ                        0x01
> > +#define CXL_GMER_TRANS_HOST_WRITE                       0x02
> > +#define CXL_GMER_TRANS_HOST_SCAN_MEDIA                  0x03
> > +#define CXL_GMER_TRANS_HOST_INJECT_POISON               0x04
> > +#define CXL_GMER_TRANS_INTERNAL_MEDIA_SCRUB             0x05
> > +#define CXL_GMER_TRANS_INTERNAL_MEDIA_MANAGEMENT        0x06
> > +
> > +#define CXL_GMER_VALID_CHANNEL                          BIT(0)
> > +#define CXL_GMER_VALID_RANK                             BIT(1)
> > +#define CXL_GMER_VALID_DEVICE                           BIT(2)
> > +#define CXL_GMER_VALID_COMPONENT                        BIT(3)
> > +
> > +struct cxl_event_gen_media gen_media = {
> > +    .hdr = {
> > +        .id.data = UUID(0xfbcd0a77, 0xc260, 0x417f,
> > +                        0x85, 0xa9, 0x08, 0x8b, 0x16, 0x21, 0xeb, 0xa6),
> > +        .length = sizeof(struct cxl_event_gen_media),
> > +        .flags[0] = CXL_EVENT_RECORD_FLAG_PERMANENT,
> > +        /* .handle = Set dynamically */
> > +        .related_handle = const_le16(0),
> > +    },
> > +    .phys_addr = const_le64(0x2000),
> > +    .descriptor = CXL_GMER_EVT_DESC_UNCORECTABLE_EVENT,
> > +    .type = CXL_GMER_MEM_EVT_TYPE_DATA_PATH_ERROR,
> > +    .transaction_type = CXL_GMER_TRANS_HOST_WRITE,
> > +    .validity_flags = { CXL_GMER_VALID_CHANNEL |
> > +                        CXL_GMER_VALID_RANK, 0 },
> > +    .channel = 1,
> > +    .rank = 30
> > +};
> > +
> > +#define CXL_DER_VALID_CHANNEL                           BIT(0)
> > +#define CXL_DER_VALID_RANK                              BIT(1)
> > +#define CXL_DER_VALID_NIBBLE                            BIT(2)
> > +#define CXL_DER_VALID_BANK_GROUP                        BIT(3)
> > +#define CXL_DER_VALID_BANK                              BIT(4)
> > +#define CXL_DER_VALID_ROW                               BIT(5)
> > +#define CXL_DER_VALID_COLUMN                            BIT(6)
> > +#define CXL_DER_VALID_CORRECTION_MASK                   BIT(7)
> > +
> > +struct cxl_event_dram dram = {
> > +    .hdr = {
> > +        .id.data = UUID(0x601dcbb3, 0x9c06, 0x4eab,
> > +                        0xb8, 0xaf, 0x4e, 0x9b, 0xfb, 0x5c, 0x96, 0x24),
> > +        .length = sizeof(struct cxl_event_dram),
> > +        .flags[0] = CXL_EVENT_RECORD_FLAG_PERF_DEGRADED,
> > +        /* .handle = Set dynamically */
> > +        .related_handle = const_le16(0),
> > +    },
> > +    .phys_addr = const_le64(0x8000),
> > +    .descriptor = CXL_GMER_EVT_DESC_THRESHOLD_EVENT,
> > +    .type = CXL_GMER_MEM_EVT_TYPE_INV_ADDR,
> > +    .transaction_type = CXL_GMER_TRANS_INTERNAL_MEDIA_SCRUB,
> > +    .validity_flags = { CXL_DER_VALID_CHANNEL |
> > +                        CXL_DER_VALID_BANK_GROUP |
> > +                        CXL_DER_VALID_BANK |
> > +                        CXL_DER_VALID_COLUMN, 0 },
> > +    .channel = 1,
> > +    .bank_group = 5,
> > +    .bank = 2,
> > +    .column = { 0xDE, 0xAD},
> > +};
> > +
> > +#define CXL_MMER_HEALTH_STATUS_CHANGE           0x00
> > +#define CXL_MMER_MEDIA_STATUS_CHANGE            0x01
> > +#define CXL_MMER_LIFE_USED_CHANGE               0x02
> > +#define CXL_MMER_TEMP_CHANGE                    0x03
> > +#define CXL_MMER_DATA_PATH_ERROR                0x04
> > +#define CXL_MMER_LAS_ERROR                      0x05
> 
> Ah this explains why I didn't find these alongside the structures.
> I'd keep them together.  If we need to put the structures in a header
> then put the defines there as well.  Puts all the spec related
> stuff in one place.
> 
> > +
> > +#define CXL_DHI_HS_MAINTENANCE_NEEDED           BIT(0)
> > +#define CXL_DHI_HS_PERFORMANCE_DEGRADED         BIT(1)
> > +#define CXL_DHI_HS_HW_REPLACEMENT_NEEDED        BIT(2)
> > +
> > +#define CXL_DHI_MS_NORMAL                                    0x00
> > +#define CXL_DHI_MS_NOT_READY                                 0x01
> > +#define CXL_DHI_MS_WRITE_PERSISTENCY_LOST                    0x02
> > +#define CXL_DHI_MS_ALL_DATA_LOST                             0x03
> > +#define CXL_DHI_MS_WRITE_PERSISTENCY_LOSS_EVENT_POWER_LOSS   0x04
> > +#define CXL_DHI_MS_WRITE_PERSISTENCY_LOSS_EVENT_SHUTDOWN     0x05
> > +#define CXL_DHI_MS_WRITE_PERSISTENCY_LOSS_IMMINENT           0x06
> > +#define CXL_DHI_MS_WRITE_ALL_DATA_LOSS_EVENT_POWER_LOSS      0x07
> > +#define CXL_DHI_MS_WRITE_ALL_DATA_LOSS_EVENT_SHUTDOWN        0x08
> > +#define CXL_DHI_MS_WRITE_ALL_DATA_LOSS_IMMINENT              0x09
> > +
> > +#define CXL_DHI_AS_NORMAL               0x0
> > +#define CXL_DHI_AS_WARNING              0x1
> > +#define CXL_DHI_AS_CRITICAL             0x2
> > +
> > +#define CXL_DHI_AS_LIFE_USED(as)        (as & 0x3)
> > +#define CXL_DHI_AS_DEV_TEMP(as)         ((as & 0xC) >> 2)
> > +#define CXL_DHI_AS_COR_VOL_ERR_CNT(as)  ((as & 0x10) >> 4)
> > +#define CXL_DHI_AS_COR_PER_ERR_CNT(as)  ((as & 0x20) >> 5)
> > +
> > +struct cxl_event_mem_module mem_module = {
> > +    .hdr = {
> > +        .id.data = UUID(0xfe927475, 0xdd59, 0x4339,
> > +                        0xa5, 0x86, 0x79, 0xba, 0xb1, 0x13, 0xb7, 0x74),
> 
> As mentioned, below a UUID define for each type in the header
> probably makes more sense than having this huge thing inline.
> 
> > +        .length = sizeof(struct cxl_event_mem_module),
> > +        /* .handle = Set dynamically */
> > +        .related_handle = const_le16(0),
> > +    },
> > +    .event_type = CXL_MMER_TEMP_CHANGE,
> > +    .info = {
> > +        .health_status = CXL_DHI_HS_PERFORMANCE_DEGRADED,
> > +        .media_status = CXL_DHI_MS_ALL_DATA_LOST,
> > +        .add_status = (CXL_DHI_AS_CRITICAL << 2) |
> > +                       (CXL_DHI_AS_WARNING << 4) |
> > +                       (CXL_DHI_AS_WARNING << 5),
> > +        .device_temp = { 0xDE, 0xAD},
> 
> odd spacing
> 
> > +        .dirty_shutdown_cnt = { 0xde, 0xad, 0xbe, 0xef },
> > +        .cor_vol_err_cnt = { 0xde, 0xad, 0xbe, 0xef },
> 
> Could make a reasonable number up rather than deadbeef ;)
> 
> > +        .cor_per_err_cnt = { 0xde, 0xad, 0xbe, 0xef },
> > +    }
> > +};
> > +
> > +void cxl_mock_add_event_logs(CXLDeviceState *cxlds)
> > +{
> 
> This is fine for initial testing, but I Think we want to be more
> sophisticated with the injection interface and allow injecting
> individual events so we can move the requirement for 'coverage'
> testing from having a representative list here to an external script
> that hits all the corners.
> 
> I can build something on top of this that lets us doing that if you like.
> I have ancient code doing the equivalent for CCIX devices that I never
> upstreamed. Would probably do it a bit differently today but principle
> is the same. Using QMP  directly rather than qmp-shell lets you do it
> as json which ends up more readable than complex command lines for this
> sort of structure command.
> 
> 
> 
> > +    event_store_add_event(cxlds, CXL_EVENT_TYPE_INFO, &maint_needed);
> > +    event_store_add_event(cxlds, CXL_EVENT_TYPE_INFO,
> > +                          (struct cxl_event_record_raw *)&gen_media);
> > +    event_store_add_event(cxlds, CXL_EVENT_TYPE_INFO,
> > +                          (struct cxl_event_record_raw *)&mem_module);
> > +
> > +    event_store_add_event(cxlds, CXL_EVENT_TYPE_FAIL, &maint_needed);
> > +    event_store_add_event(cxlds, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> > +    event_store_add_event(cxlds, CXL_EVENT_TYPE_FAIL,
> > +                          (struct cxl_event_record_raw *)&dram);
> > +    event_store_add_event(cxlds, CXL_EVENT_TYPE_FAIL,
> > +                          (struct cxl_event_record_raw *)&gen_media);
> > +    event_store_add_event(cxlds, CXL_EVENT_TYPE_FAIL,
> > +                          (struct cxl_event_record_raw *)&mem_module);
> > +    event_store_add_event(cxlds, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> > +    event_store_add_event(cxlds, CXL_EVENT_TYPE_FAIL,
> > +                          (struct cxl_event_record_raw *)&dram);
> > +
> > +    event_store_add_event(cxlds, CXL_EVENT_TYPE_FATAL, &hardware_replace);
> > +    event_store_add_event(cxlds, CXL_EVENT_TYPE_FATAL,
> > +                          (struct cxl_event_record_raw *)&dram);
> > +}
> 
> 
> > diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> > index 7b4cff569347..46c50c1c13a6 100644
> > --- a/include/hw/cxl/cxl_device.h
> > +++ b/include/hw/cxl/cxl_device.h
> > @@ -11,6 +11,7 @@
> >  #define CXL_DEVICE_H
> >  
> >  #include "hw/register.h"
> > +#include "hw/cxl/cxl_events.h"
> >  
> >  /*
> >   * The following is how a CXL device's Memory Device registers are laid out.
> > @@ -80,6 +81,14 @@
> >      (CXL_DEVICE_CAP_REG_SIZE + CXL_DEVICE_STATUS_REGISTERS_LENGTH +     \
> >       CXL_MAILBOX_REGISTERS_LENGTH + CXL_MEMORY_DEVICE_REGISTERS_LENGTH)
> >  
> > +#define CXL_TEST_EVENT_CNT_MAX 15
> 
> Where did 15 come from?
> 
> > +
> > +struct cxl_event_log {
> > +    int cur_event;
> > +    int nr_events;
> > +    struct cxl_event_record_raw *events[CXL_TEST_EVENT_CNT_MAX];
> > +};
> > +
> >  typedef struct cxl_device_state {
> >      MemoryRegion device_registers;
> >  
> > @@ -119,6 +128,8 @@ typedef struct cxl_device_state {
> >  
> >      /* memory region for persistent memory, HDM */
> >      uint64_t pmem_size;
> > +
> > +    struct cxl_event_log event_logs[CXL_EVENT_TYPE_MAX];
> >  } CXLDeviceState;
> >  
> >  /* Initialize the register block for a device */
> > @@ -272,4 +283,12 @@ MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
> >  MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
> >                              unsigned size, MemTxAttrs attrs);
> >  
> > +void cxl_mock_add_event_logs(CXLDeviceState *cxlds);
> > +struct cxl_event_log *find_event_log(CXLDeviceState *cxlds, int log_type);
> > +struct cxl_event_record_raw *get_cur_event(struct cxl_event_log *log);
> > +uint16_t get_cur_event_handle(struct cxl_event_log *log);
> > +bool log_empty(struct cxl_event_log *log);
> > +int log_rec_left(struct cxl_event_log *log);
> > +uint16_t log_overflow(struct cxl_event_log *log);
> > +
> >  #endif
> > diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
> > new file mode 100644
> > index 000000000000..255111f3dcfb
> > --- /dev/null
> > +++ b/include/hw/cxl/cxl_events.h
> > @@ -0,0 +1,173 @@
> > +/*
> > + * QEMU CXL Events
> > + *
> > + * Copyright (c) 2022 Intel
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2. See the
> > + * COPYING file in the top-level directory.
> > + */
> > +
> > +#ifndef CXL_EVENTS_H
> > +#define CXL_EVENTS_H
> > +
> > +#include "qemu/uuid.h"
> > +#include "hw/cxl/cxl.h"
> > +
> > +/*
> > + * Common Event Record Format
> > + * CXL rev 3.0 section 8.2.9.2.1; Table 8-42
> > + */
> > +#define CXL_EVENT_REC_HDR_RES_LEN 0xf
> 
> I don't see an advantage in this define vs just
> putting the value in directly below.
> Same with similar cases - the define must makes them
> a tiny bit harder to compare with the specification when
> reviewing.
> 
> > +struct cxl_event_record_hdr {
> > +    QemuUUID id;
> > +    uint8_t length;
> > +    uint8_t flags[3];
> > +    uint16_t handle;
> > +    uint16_t related_handle;
> > +    uint64_t timestamp;
> > +    uint8_t maint_op_class;
> > +    uint8_t reserved[CXL_EVENT_REC_HDR_RES_LEN];
> > +} QEMU_PACKED;
> > +
> > +#define CXL_EVENT_RECORD_DATA_LENGTH 0x50
> > +struct cxl_event_record_raw {
> > +    struct cxl_event_record_hdr hdr;
> > +    uint8_t data[CXL_EVENT_RECORD_DATA_LENGTH];
> > +} QEMU_PACKED;
> 
> Hmm. I wonder if we should instead define this as a union of
> the known event types?  I haven't checked if it would work
> everywhere yet though.
> 
> > +
> > +/*
> > + * Get Event Records output payload
> > + * CXL rev 3.0 section 8.2.9.2.2; Table 8-50
> > + *
> > + * Space given for 1 record
> > + */
> > +#define CXL_GET_EVENT_FLAG_OVERFLOW     BIT(0)
> > +#define CXL_GET_EVENT_FLAG_MORE_RECORDS BIT(1)
> > +struct cxl_get_event_payload {
> > +    uint8_t flags;
> > +    uint8_t reserved1;
> > +    uint16_t overflow_err_count;
> > +    uint64_t first_overflow_timestamp;
> > +    uint64_t last_overflow_timestamp;
> > +    uint16_t record_count;
> > +    uint8_t reserved2[0xa];
> > +    struct cxl_event_record_raw record;
> 
> This last element should be a [] array and then move
> the handling of different record counts to the places it
> is used.
> 
> Spec unfortunately says that we should return as many
> as we can fit, so we can't rely on the users of this interface
> only sending a request for one record (as I think your Linux
> kernel code currently does). See below for more on this...
> 
> 
> > +} QEMU_PACKED;
> > +
> > +/*
> > + * CXL rev 3.0 section 8.2.9.2.2; Table 8-49
> > + */
> > +enum cxl_event_log_type {
> > +    CXL_EVENT_TYPE_INFO = 0x00,
> > +    CXL_EVENT_TYPE_WARN,
> > +    CXL_EVENT_TYPE_FAIL,
> > +    CXL_EVENT_TYPE_FATAL,
> > +    CXL_EVENT_TYPE_DYNAMIC_CAP,
> > +    CXL_EVENT_TYPE_MAX
> > +};
> > +
> > +static inline const char *cxl_event_log_type_str(enum cxl_event_log_type type)
> > +{
> > +    switch (type) {
> > +    case CXL_EVENT_TYPE_INFO:
> > +        return "Informational";
> > +    case CXL_EVENT_TYPE_WARN:
> > +        return "Warning";
> > +    case CXL_EVENT_TYPE_FAIL:
> > +        return "Failure";
> > +    case CXL_EVENT_TYPE_FATAL:
> > +        return "Fatal";
> > +    case CXL_EVENT_TYPE_DYNAMIC_CAP:
> > +        return "Dynamic Capacity";
> > +    default:
> > +        break;
> > +    }
> > +    return "<unknown>";
> > +}
> > +
> > +/*
> > + * Clear Event Records input payload
> > + * CXL rev 3.0 section 8.2.9.2.3; Table 8-51
> > + *
> > + * Space given for 1 record
> 
> I'd rather this was defined to have a trailing variable length
> array of handles and allocations and then wherever it was used
> we deal with the length.
> 
> I'm also nervous about limiting the qemu emulation to handling only
> one record.. Spec wise I don't think you are allowed to say
> no to larger clears.  I understand the fact we can't test this today
> with the kernel code but maybe we can hack together enough to
> verify the emulation of larger gets and clears...
> 
> 
> > + */
> > +struct cxl_mbox_clear_event_payload {
> > +    uint8_t event_log;      /* enum cxl_event_log_type */
> > +    uint8_t clear_flags;
> > +    uint8_t nr_recs;        /* 1 for this struct */
> > +    uint8_t reserved[3];
> > +    uint16_t handle;
> > +};
> > +
> > +/*
> > + * General Media Event Record
> > + * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
> > + */
> 
> In interests of keeping everything that needs checking against
> a chunk of the spec together, perhaps it's worth adding appropriate
> defines for the UUIDs?
> 
> > +#define CXL_EVENT_GEN_MED_COMP_ID_SIZE  0x10
> > +#define CXL_EVENT_GEN_MED_RES_SIZE      0x2e
> 
> As above, I'd rather see these inline.
> 
> > +struct cxl_event_gen_media {
> > +    struct cxl_event_record_hdr hdr;
> > +    uint64_t phys_addr;
> Defines for the mask + that we have a few things hiding in
> the bottom bits?
> 
> > +    uint8_t descriptor;
> Defines for the various fields in here?
> 
> > +    uint8_t type;
> Same for the others that follow.
> 
> > +    uint8_t transaction_type;
> 
> > +    uint8_t validity_flags[2];
> 
> uint16_t probably makes sense as we can do that for this one (unlike the helpful le24 flags fields
> in other structures).
> 
> > +    uint8_t channel;
> > +    uint8_t rank;
> > +    uint8_t device[3];
> > +    uint8_t component_id[CXL_EVENT_GEN_MED_COMP_ID_SIZE];
> > +    uint8_t reserved[CXL_EVENT_GEN_MED_RES_SIZE];
> > +} QEMU_PACKED;
> Would be nice to add a build time check that these structures have the correct
> overall size. Ben did a bunch of these in the other CXL emulation and they are
> a handy way to reassure reviewers that it adds up right!
> 
> > +
> > +/*
> > + * DRAM Event Record - DER
> > + * CXL rev 3.0 section 8.2.9.2.1.2; Table 3-44
> > + */
> > +#define CXL_EVENT_DER_CORRECTION_MASK_SIZE   0x20
> > +#define CXL_EVENT_DER_RES_SIZE               0x17
> Same as above.
> 
> > +struct cxl_event_dram {
> > +    struct cxl_event_record_hdr hdr;
> > +    uint64_t phys_addr;
> As before I'd like defines for the sub fields and masks.
> 
> > +    uint8_t descriptor;
> > +    uint8_t type;
> > +    uint8_t transaction_type;
> > +    uint8_t validity_flags[2];
> uint16_t and same in similar cases.
> 
> > +    uint8_t channel;
> > +    uint8_t rank;
> > +    uint8_t nibble_mask[3];
> > +    uint8_t bank_group;
> > +    uint8_t bank;
> > +    uint8_t row[3];
> > +    uint8_t column[2];
> > +    uint8_t correction_mask[CXL_EVENT_DER_CORRECTION_MASK_SIZE];
> > +    uint8_t reserved[CXL_EVENT_DER_RES_SIZE];
> > +} QEMU_PACKED;
> > +
> > +/*
> > + * Get Health Info Record
> > + * CXL rev 3.0 section 8.2.9.8.3.1; Table 8-100
> > + */
> > +struct cxl_get_health_info {
> Same stuff as for earlier structures.
> 
> > +    uint8_t health_status;
> > +    uint8_t media_status;
> > +    uint8_t add_status;
> > +    uint8_t life_used;
> > +    uint8_t device_temp[2];
> > +    uint8_t dirty_shutdown_cnt[4];
> > +    uint8_t cor_vol_err_cnt[4];
> > +    uint8_t cor_per_err_cnt[4];
> > +} QEMU_PACKED;
> > +
> > +/*
> > + * Memory Module Event Record
> > + * CXL rev 3.0 section 8.2.9.2.1.3; Table 8-45
> > + */
> > +#define CXL_EVENT_MEM_MOD_RES_SIZE  0x3d
> > +struct cxl_event_mem_module {
> > +    struct cxl_event_record_hdr hdr;
> > +    uint8_t event_type;
> > +    struct cxl_get_health_info info;
> > +    uint8_t reserved[CXL_EVENT_MEM_MOD_RES_SIZE];
> > +} QEMU_PACKED;
> > +
> > +#endif /* CXL_EVENTS_H */
> 
