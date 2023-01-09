Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD07C5479D
	for <linux-cxl@archiver.kernel.org>; Mon,  9 Jan 2023 19:16:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237654AbjAITQR (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 9 Jan 2023 14:16:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237583AbjAITPz (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 9 Jan 2023 14:15:55 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF60512AC4
        for <linux-cxl@vger.kernel.org>; Mon,  9 Jan 2023 11:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673291753; x=1704827753;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=lZVd7dZS0E2j5P1EiCtyUJtKYmbScLKjkUXiMxD0v0M=;
  b=eaSdHMiA6Gclyp2sqWN3Gcxd0/WEhqxgtVi64Uf6uK2Mg2snpuB2Wr0v
   u2XQTdWLAYRX0m3oldja0Djrc1dWNg9r4K0Fv4nfP+kTvFXrhscpWV/05
   1nbgQ2RS9XFxAMPEVYGYSSyVNQ6dfYsOsz1FYj4SzDGOJzev8cSk9b3oN
   4Gj3bG8mnFgNm4L1HKA0pJd3LvZBERAT8DYghnN4omguGYKd8U4uVbbnM
   uD+EH2vltcI48dBwKfz9hPLY50scaKMm5zpot5aEhSk2RCfPoh9UziDvv
   jR2GgtzNlY5OXzTcG1givANrrDmvgRma9NeMAf+quaHXdHYU6YjojYRab
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="320656824"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="320656824"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 11:15:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="658712239"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="658712239"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP; 09 Jan 2023 11:15:37 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 9 Jan 2023 11:15:36 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 9 Jan 2023 11:15:36 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 9 Jan 2023 11:15:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hVIWJtfNiETVI8GAAwbu9lyoMhwWpF6RfqoDe3MefYrMQlni+LQCEduW09qGdBtlN0wQR5IyaRQhTG2zpT8CBHRV8mV2dYC0dw8owhMICCfIlukYNEleHgMXdMX736tb6Jhj3wEWb73hB5ZQ+8TZZhe1a6fISPqA3oYrgAW2S0uo4rWx4Wg/lc14fOOqIsLNsE4VpW9hG7VVlUfUNZm/v8Sr61N5DHcqNkQzNhleG8qVs98PsaYP+VUwScV2f023b561yDIiE7bQgC6oQLwp1RCcITpz0pNpyHM59T4bJ5KmIDpbuCQObnFpH1Y85tYUU0F35lMDZ7KcPnVCB7H/Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VqxILzVM7/1NCvot0T4XXYMXuI465xy9v3j18tC1Jkc=;
 b=MjAcuB9Gbw66s/Qc15oMWk9G5gFLoO/3AfDyRp8LLBxyrVz6gWfgy3PW4vN8yae6NmrD2TRNUPekhA7vH6Ph7DOvPnodghWPRZKtVQtK9r/BoybwOLmTD8ZSWPRX9/DjhUGZw/mEOezMMEMJJJJu0rzcDfdIvlHl7AyEl64mAftv/21uVE4sb/Gh/YwyJDv6fZguAb+VBvtkgikbxoi44iF4Jaai3RGuvpqTkW9gERZcRjU7c+UF3jno+tgqPxZMmEb9z2c1HLXpXTIaAYlSbdVuKtI8Q53sLgclVKNk7sSTS4Y5vW9j0YlJ1gYoIVr5GLBHZeF4Fj1JaNzx14UqSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by BL1PR11MB6025.namprd11.prod.outlook.com (2603:10b6:208:390::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 19:15:33 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::288d:5cae:2f30:828b]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::288d:5cae:2f30:828b%8]) with mapi id 15.20.5986.018; Mon, 9 Jan 2023
 19:15:33 +0000
Date:   Mon, 9 Jan 2023 11:15:28 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>, <qemu-devel@nongnu.org>,
        <linux-cxl@vger.kernel.org>,
        Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 8/8] hw/cxl/events: Add in inject general media event
Message-ID: <Y7xn0NNupucMou4b@iweiny-desk3>
References: <20221221-ira-cxl-events-2022-11-17-v2-0-2ce2ecc06219@intel.com>
 <20221221-ira-cxl-events-2022-11-17-v2-8-2ce2ecc06219@intel.com>
 <20230103180719.00006437@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230103180719.00006437@huawei.com>
X-ClientProxiedBy: SJ0PR13CA0199.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::24) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|BL1PR11MB6025:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a2cab95-8fe0-4da5-6c22-08daf275e16c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /xXzt4XtTNE//f8UzgrXsJ/vJZO2oEkphBctyH95YApOZHrdz/QFn+nIcjl/rcWJOaYLSuRnzcRJlKb6EnwaifA5+EUvU0jAkuFSTmY3XDDfczc3GnbmRg/90Tk4mK641cyA/w67LOaExYSSMAcT8nVegoEH0p36GiOLm+syuQAQ+CBEJG61ERNU4S6Yo6ZOwsEGzo6sW1mbmIgxVbglDyvkILryvzEqVPk8YqjbIr3DplMcqvInlzTvSN8DSniIbCeP+Y2sBk3jJxz9NRuV38d5skr3NJOvvMKR96qaXNSFB7p1X4iVMultdhnN2K7RyG1nUjfmJrJ//+c3BAokeuB8ZywLGaWpZpr1epORQ7iw99BSXyHKwe072tTM43Vo8kadRNO5qqKXSIMcaCkHutkc3/Okl3vLRz4DUoeDHi9wEPbMW+PZ+VDlCOjHLvF5fZ9RH34v4DQhJxmtxB2aKNJCPmCynp6hM+VvDcHRIzj3T2D0UZnuPUGldHfM9rikcxQkYuwEFKkMK9xIFsvGakMJud/1kbQTLtLscKn8HITVVHzP4OUbcty6pmlPRBWTOfCV5hBQuuqzaW9iqDb+yt7UBVeQVw1rmGsH13hj5tZJ4jmDMWOKr3LGfvfutbVbGIxEZ1CwRAwFp0wyJpHMKLToAMAl7wZcjWyai0Yv3Ns=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(396003)(39860400002)(366004)(376002)(346002)(451199015)(38100700002)(82960400001)(83380400001)(6916009)(86362001)(66476007)(8676002)(4326008)(41300700001)(66556008)(66946007)(54906003)(316002)(44832011)(2906002)(5660300002)(8936002)(6512007)(33716001)(9686003)(966005)(6506007)(26005)(186003)(6486002)(478600001)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gmEHQXwOD8wJNFH/I2WfGE6lLIapvYVjnZ2ESyN8CscT+5BjgyA/GwWUULMh?=
 =?us-ascii?Q?UZw6d3uqo3iVtC9RU3ZaVCGRJNmEghRsPOQxsV8p6iyeMLqdTichYKu2TPQs?=
 =?us-ascii?Q?lveV2ZeR0S7hSSm0x7fgqJy5T5GYApFQ2FxKixsr29SXg3Sa5tkr/AlNX2LZ?=
 =?us-ascii?Q?njXhJAyU1BWim34lFtEqhtNyJ58Yc3CNPaLN/F4rTdFTMcgNFUHh+2iP60Di?=
 =?us-ascii?Q?TvGEWQ8OifpWNavOImyqtzOu0qzPcyguhcLmLM1K/z+piUxnHj6wNQIyxABN?=
 =?us-ascii?Q?X1U7RMdE9/pKzxMAAU4dlyNSexERZqXw3dJnxknjA+WgkmSkLrW1JHvXe6qZ?=
 =?us-ascii?Q?dLxZBAI67piIf9T9ofNHhYbCqSWbVjbLMqL/NFnCzaj1/XMSVWt5VD8lqQjJ?=
 =?us-ascii?Q?Lv8Lt2VlTVXzxuhKcSoq+WoZmyLUK58fvTj9tjFIX6TRpHO7jwSPzlSXLZAL?=
 =?us-ascii?Q?Tb92YzyH+qNiBOFraGgh/aW3EWmY5BrBvp8OS33NZ3vhslZI15Et/1CcdB2n?=
 =?us-ascii?Q?g7Vl0mqM9ZczlGaKwXyFfn06aIqjkhusrm3T+IrRIjnrb4ft/V651DZSZaBY?=
 =?us-ascii?Q?DVhW+cr8fRG5BVC2TWrk3oXTRgpvp+MSewtpY1WeUFIuvqR223cSo2FrIs/w?=
 =?us-ascii?Q?ATLqdusHBf+SQN4bHeCIiz23oF9qJygZl0l4ugc7w7DNaHfgpgACBcOG6Zhm?=
 =?us-ascii?Q?xs8iXLP3Z/zT5HFNh5JL+Dkf7SOIXgR8wJVYEB1EwiGct9JtGSv7J5Y+Yd66?=
 =?us-ascii?Q?61Xa425UvyjFHuzJP6hinQg6hv1/yB5u0XrQ4BpUJ3cX188jekadJUL4VYPO?=
 =?us-ascii?Q?PbV8G9LdtVzLTE/EITxHcDa7ekKy3JLCGPruswJg5JOWzfPVv81zFSb3iAGA?=
 =?us-ascii?Q?BYBPG0agSEiYayBFukshyw1k5KFDgZoi6WlTi7E3QP6SV8b0h0TGasAATlrb?=
 =?us-ascii?Q?DAZu/bka0eYuo5FLReQc818hInN5Ws3lrgP5a7vBGiJGpfEWROOAHbGMosOM?=
 =?us-ascii?Q?mrGzP1yR8YmzgNdqgMQ3SeNHJJs06MPsg57qCTHwGL4ZmO9LtglEDyOBtmul?=
 =?us-ascii?Q?+y6lmJGtcf3d9CDhLNDP6tHcGRb8bMaZwx4saSrvATh/EJ2GSuqhnlt9t7IF?=
 =?us-ascii?Q?W3ePwvrqf10f8XEpX+s7Q0sx7C9Z3O0VbHWqn6dmv824TTI3nMRMPgoZf7WN?=
 =?us-ascii?Q?a9eCf6MOVgHsg7lGtEqIXmds9eGZ3H4wRCk8mJrlqjqwHEVd6gJ85RY8c7Y3?=
 =?us-ascii?Q?V79dMHVLw41cQR5HxY/T2z0xKjyzF747C80WhBb+K2yuJs3tijjkGIdRYNS4?=
 =?us-ascii?Q?JxcLn+xhf1kCN5cqQsz1Pzv73ZkPNWO1wu8KLGPh/7aIrMpnwAeWYJ/rqOl9?=
 =?us-ascii?Q?ScniOtwA127yJh8h0oC154oNST+on7Q9T5Hzwy6qI1knmqGhyqveeJy7rDhG?=
 =?us-ascii?Q?KSK+ylErbkuKRr5uWm1BR2bQOMFu8P91kNvkSPrX8lWc7iuXpN18iCpmrCNP?=
 =?us-ascii?Q?k5/0D+K4rGZZX456W7qfUzodQDXdlbdZrKREzXAABGtpQFGp35WE96qkyysK?=
 =?us-ascii?Q?MwaZb1LWEq6yBrFsxcAdWA8X3maK+AHUid6AynkZ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a2cab95-8fe0-4da5-6c22-08daf275e16c
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 19:15:33.4983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6R6fYNKVe1ThzJ/OukhQ29VnrgYGDnUnhohO0WZfmjJ9YmJehZhe4LeHQcLEvXDgK4lCZtwox919qpkYx16/DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6025
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Jan 03, 2023 at 06:07:19PM +0000, Jonathan Cameron wrote:
> On Wed, 21 Dec 2022 20:24:38 -0800
> Ira Weiny <ira.weiny@intel.com> wrote:
> 
> > To facilitate testing provide a QMP command to inject a general media
> > event.  The event can be added to the log specified.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> Hi Ira,
> 
> Suggestion inline on how to more neatly handle optional arguments using
> QMPs inbuilt handling.  Short version is stick a * in front of the
> argument name in the json and you get a bonus parameter in the callback
> bool has_<name> which lets you identify if it is provided or not.
> 
> Jonathan
> 
> > 
> > ---
> > Changes from RFC:
> > 	Add all fields for this event
> > 	irq happens automatically when log transitions from 0 to 1
> > ---
> >  hw/mem/cxl_type3.c          | 93 +++++++++++++++++++++++++++++++++++++++++++++
> >  hw/mem/cxl_type3_stubs.c    |  8 ++++
> >  include/hw/cxl/cxl_events.h | 20 ++++++++++
> >  qapi/cxl.json               | 25 ++++++++++++
> >  4 files changed, 146 insertions(+)
> > 
> > diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> > index a43949cab120..bedd09e500ba 100644
> > --- a/hw/mem/cxl_type3.c
> > +++ b/hw/mem/cxl_type3.c
> > @@ -916,6 +916,99 @@ static CXLPoisonList *get_poison_list(CXLType3Dev *ct3d)
> >      return &ct3d->poison_list;
> >  }
> >  
> > +static void cxl_assign_event_header(struct cxl_event_record_hdr *hdr,
> > +                                    QemuUUID *uuid, uint8_t flags,
> > +                                    uint8_t length)
> > +{
> > +    hdr->flags[0] = flags;
> > +    hdr->length = length;
> > +    memcpy(&hdr->id, uuid, sizeof(hdr->id));
> > +    hdr->timestamp = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> > +}
> > +
> > +QemuUUID gen_media_uuid = {
> > +    .data = UUID(0xfbcd0a77, 0xc260, 0x417f,
> > +                 0x85, 0xa9, 0x08, 0x8b, 0x16, 0x21, 0xeb, 0xa6),
> > +};
> > +
> > +#define CXL_GMER_VALID_CHANNEL                          BIT(0)
> > +#define CXL_GMER_VALID_RANK                             BIT(1)
> > +#define CXL_GMER_VALID_DEVICE                           BIT(2)
> > +#define CXL_GMER_VALID_COMPONENT                        BIT(3)
> > +
> > +/*
> > + * For channel, rank, and device; any value inside of the fields valid range
> > + * will flag that field to be valid.  IE pass -1 to mark the field invalid.
> > + *
> > + * Component ID is device specific.  Define this as a string.
> > + */
> > +void qmp_cxl_inject_gen_media_event(const char *path, uint8_t log,
> > +                                    uint8_t flags, uint64_t physaddr,
> > +                                    uint8_t descriptor, uint8_t type,
> > +                                    uint8_t transaction_type,
> > +                                    int16_t channel, int16_t rank,
> > +                                    int32_t device,
> > +                                    const char *component_id,
> > +                                    Error **errp)
> > +{
> > +    Object *obj = object_resolve_path(path, NULL);
> > +    struct cxl_event_gen_media gem;
> > +    struct cxl_event_record_hdr *hdr = &gem.hdr;
> > +    CXLDeviceState *cxlds;
> > +    CXLType3Dev *ct3d;
> > +    uint16_t valid_flags = 0;
> > +
> > +    if (log >= CXL_EVENT_TYPE_MAX) {
> > +        error_setg(errp, "Invalid log type: %d", log);
> > +        return;
> > +    }
> > +    if (!obj) {
> > +        error_setg(errp, "Unable to resolve path");
> > +        return;
> > +    }
> > +    if (!object_dynamic_cast(obj, TYPE_CXL_TYPE3)) {
> > +        error_setg(errp, "Path does not point to a CXL type 3 device");
> > +    }
> > +    ct3d = CXL_TYPE3(obj);
> > +    cxlds = &ct3d->cxl_dstate;
> > +
> > +    memset(&gem, 0, sizeof(gem));
> > +    cxl_assign_event_header(hdr, &gen_media_uuid, flags,
> > +                            sizeof(struct cxl_event_gen_media));
> > +
> > +    gem.phys_addr = physaddr;
> > +    gem.descriptor = descriptor;
> > +    gem.type = type;
> > +    gem.transaction_type = transaction_type;
> > +
> > +    if (0 <= channel && channel <= 0xFF) {
> > +        gem.channel = channel;
> > +        valid_flags |= CXL_GMER_VALID_CHANNEL;
> > +    }
> > +
> > +    if (0 <= rank && rank <= 0xFF) {
> > +        gem.rank = rank;
> > +        valid_flags |= CXL_GMER_VALID_RANK;
> > +    }
> > +
> > +    if (0 <= device && device <= 0xFFFFFF) {
> > +        st24_le_p(gem.device, device);
> > +        valid_flags |= CXL_GMER_VALID_DEVICE;
> > +    }
> > +
> > +    if (component_id && strcmp(component_id, "")) {
> > +        strncpy((char *)gem.component_id, component_id,
> > +                sizeof(gem.component_id) - 1);
> > +        valid_flags |= CXL_GMER_VALID_COMPONENT;
> > +    }
> > +
> > +    stw_le_p(gem.validity_flags, valid_flags);
> > +
> > +    if (cxl_event_insert(cxlds, log, (struct cxl_event_record_raw *)&gem)) {
> > +        cxl_event_irq_assert(ct3d);
> > +    }
> > +}
> > +
> >  void qmp_cxl_inject_poison(const char *path, uint64_t start, uint64_t length,
> >                             Error **errp)
> >  {
> > diff --git a/hw/mem/cxl_type3_stubs.c b/hw/mem/cxl_type3_stubs.c
> > index f2c9f48f4010..62f04d487031 100644
> > --- a/hw/mem/cxl_type3_stubs.c
> > +++ b/hw/mem/cxl_type3_stubs.c
> > @@ -2,6 +2,14 @@
> >  #include "qemu/osdep.h"
> >  #include "qapi/qapi-commands-cxl.h"
> >  
> > +void qmp_cxl_inject_gen_media_event(const char *path, uint8_t log,
> > +                                    uint8_t flags, uint64_t physaddr,
> > +                                    uint8_t descriptor, uint8_t type,
> > +                                    uint8_t transaction_type,
> > +                                    int16_t channel, int16_t rank,
> > +                                    int32_t device,
> > +                                    char *component_id,
> > +                                    Error **errp) {}
> >  void qmp_cxl_inject_poison(const char *path, uint64_t start, uint64_t length,
> >                             Error **errp) {}
> >  void qmp_cxl_inject_uncorrectable_error(const char *path,
> > diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
> > index 2df40720320a..3175e9d9866d 100644
> > --- a/include/hw/cxl/cxl_events.h
> > +++ b/include/hw/cxl/cxl_events.h
> > @@ -103,4 +103,24 @@ struct cxl_event_interrupt_policy {
> >  /* DCD is optional but other fields are not */
> >  #define CXL_EVENT_INT_SETTING_MIN_LEN 4
> >  
> > +/*
> > + * General Media Event Record
> > + * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
> > + */
> > +#define CXL_EVENT_GEN_MED_COMP_ID_SIZE  0x10
> > +#define CXL_EVENT_GEN_MED_RES_SIZE      0x2e
> > +struct cxl_event_gen_media {
> > +    struct cxl_event_record_hdr hdr;
> > +    uint64_t phys_addr;
> > +    uint8_t descriptor;
> > +    uint8_t type;
> > +    uint8_t transaction_type;
> > +    uint8_t validity_flags[2];
> > +    uint8_t channel;
> > +    uint8_t rank;
> > +    uint8_t device[3];
> > +    uint8_t component_id[CXL_EVENT_GEN_MED_COMP_ID_SIZE];
> > +    uint8_t reserved[CXL_EVENT_GEN_MED_RES_SIZE];
> > +} QEMU_PACKED;
> > +
> >  #endif /* CXL_EVENTS_H */
> > diff --git a/qapi/cxl.json b/qapi/cxl.json
> > index b4836bb87f53..56e85a28d7e0 100644
> > --- a/qapi/cxl.json
> > +++ b/qapi/cxl.json
> > @@ -5,6 +5,31 @@
> >  # = CXL devices
> >  ##
> >  
> > +##
> > +# @cxl-inject-gen-media-event:
> > +#
> > +# @path: CXL type 3 device canonical QOM path
> > +#
> > +# @log: Event Log to add the event to
> > +# @flags: header flags
> > +# @physaddr: Physical Address
> > +# @descriptor: Descriptor
> > +# @type: Type
> > +# @transactiontype: Transaction Type
> > +# @channel: Channel
> > +# @rank: Rank
> > +# @device: Device
> > +# @componentid: Device specific string
> > +#
> > +##
> > +{ 'command': 'cxl-inject-gen-media-event',
> > +  'data': { 'path': 'str', 'log': 'uint8', 'flags': 'uint8',
> > +            'physaddr': 'uint64', 'descriptor': 'uint8',
> > +            'type': 'uint8', 'transactiontype': 'uint8',
> > +            'channel': 'int16', 'rank': 'int16',
> > +            'device': 'int32', 'componentid': 'str'
> > +            }}
> 
> From an interface cleanliness point of view I'd rather see
> all the optional fields as optional.  That's done by marking them
> with a * so
> '*channel': 'int16'
> 
> Then the signature of the related qmp_cxl_inject_gen_media_event
> gains a boolean has_channel parameter (before channel)
> 
> Those booleans can be used to set the flags etc.

Ah!  Ok cool.  Yes this would make a lot more sense.  I did not realize QMP did
this optional thing.  That makes scripting this easier as well!

Did you put all this on a branch or not?  I did not see anything new at:

https://gitlab.com/jic23/qemu.git

I can definitely respin but it sounds like you were going to make some changes.

Ira

> 
> Very lightly tested: 
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 4660a44ef8..cb9bb0b166 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -1203,8 +1203,9 @@ void qmp_cxl_inject_gen_media_event(const char *path, uint8_t log,
>                                      uint8_t flags, uint64_t physaddr,
>                                      uint8_t descriptor, uint8_t type,
>                                      uint8_t transaction_type,
> -                                    int16_t channel, int16_t rank,
> -                                    int32_t device,
> +                                    bool has_channel, uint8_t channel,
> +                                    bool has_rank, uint8_t rank,
> +                                    bool has_device, uint32_t device,
>                                      const char *component_id,
>                                      Error **errp)
>  {
> @@ -1238,22 +1239,22 @@ void qmp_cxl_inject_gen_media_event(const char *path, uint8_t log,
>      gem.type = type;
>      gem.transaction_type = transaction_type;
> 
> -    if (0 <= channel && channel <= 0xFF) {
> +    if (has_channel) {
>          gem.channel = channel;
>          valid_flags |= CXL_GMER_VALID_CHANNEL;
>      }
> 
> -    if (0 <= rank && rank <= 0xFF) {
> +    if (has_rank) {
>          gem.rank = rank;
>          valid_flags |= CXL_GMER_VALID_RANK;
>      }
> 
> -    if (0 <= device && device <= 0xFFFFFF) {
> +    if (has_device) {
>          st24_le_p(gem.device, device);
>          valid_flags |= CXL_GMER_VALID_DEVICE;
>      }
> 
> -    if (component_id && strcmp(component_id, "")) {
> +    if (component_id) {
>         strncpy((char *)gem.component_id, component_id,
>                  sizeof(gem.component_id) - 1);
>          valid_flags |= CXL_GMER_VALID_COMPONENT;
> diff --git a/qapi/cxl.json b/qapi/cxl.json
> index 56e85a28d7..085f82e7da 100644
> --- a/qapi/cxl.json
> +++ b/qapi/cxl.json
> @@ -26,8 +26,8 @@
>    'data': { 'path': 'str', 'log': 'uint8', 'flags': 'uint8',
>              'physaddr': 'uint64', 'descriptor': 'uint8',
>              'type': 'uint8', 'transactiontype': 'uint8',
> -            'channel': 'int16', 'rank': 'int16',
> -            'device': 'int32', 'componentid': 'str'
> +            '*channel': 'uint8', '*rank': 'uint8',
> +            '*device': 'uint32', '*componentid': 'str'
>              }}
> 
>  ##
> 
> > +
> >  ##
> >  # @cxl-inject-poison:
> >  #
> > 
> 
