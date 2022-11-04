Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF898C4332F
	for <linux-cxl@archiver.kernel.org>; Fri,  4 Nov 2022 18:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbiKDS5G (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 4 Nov 2022 14:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiKDS47 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 4 Nov 2022 14:56:59 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE2A5986F
        for <linux-cxl@vger.kernel.org>; Fri,  4 Nov 2022 11:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667588219; x=1699124219;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=EHBGm4PLVhmoggY6gK/yA2obzr6UVLP6Gey8gzsFFKc=;
  b=BOMVfNgV9vdY/in3bjKvfzTzy604uXKbk0oZbJ0FVm1g6w6OqR9hFq/t
   lazFXFuPMX3DHGBchwWN0s5Yac1fni0c3XMth+IDUE4X6/OWMF+UPbtM4
   v5GJ0a2mEq8pp0Gk+FJUzfuB9EOas3FRN0EWbyVqRmEwMXNJqt/9eKoBJ
   XKodUaKJAMBXaurddD1cupV0eclYN5EbS3O6MSrww8jW7Tu9UiwBgSXRj
   c5ZcXvTexm/RpnEB1q1jIhyAa7Cv6RtCik+chZDSLJ8CCmT+naKPhd1nq
   xjm/hTJxsTvyVTszPjFDACP0SqgfGJFh4gkOReBMDWRzWn1xFb54fIp1V
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="310043688"
X-IronPort-AV: E=Sophos;i="5.96,138,1665471600"; 
   d="scan'208";a="310043688"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 11:56:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="740730383"
X-IronPort-AV: E=Sophos;i="5.96,138,1665471600"; 
   d="scan'208";a="740730383"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP; 04 Nov 2022 11:56:58 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 4 Nov 2022 11:56:58 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 4 Nov 2022 11:56:58 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 4 Nov 2022 11:56:58 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 4 Nov 2022 11:56:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e9zkFHSorWLwKQyYtjsSYcUtPAjmjingcxB5HqBw57S4Kt9Is1wZFcWAnru6+IrZ8WyUNdi0pA2DJJqwERSzR3RPZF7kMX680nvvK1ObqMmw7GOwjNUbge2f9DO/QPEIejKwpf7BR99m3hU8uOUCoZ3+ELe6TntzGdCYJlCJGuhHlG6ZnQu8bvY8edeuzsv1STdaM2CEWaWNvaJO2mjPRJNuMcSLuwXh3H9Pw2QZVYcRj+0re9DDudwhOF8coMTKjhICcIQJw8uYp+NiK0SHkONxSOsdtehIfiilhq2iAkxZxQjJqlVgiCFkoV6hdJvPcWPD7FacYp7auM7B2lzsRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s0qfUrHFe0ObAFFS65wtuXEeYFzFclPRZrc4glMVEy4=;
 b=KN2hL08FsRngmL2BCIoEBfTj6cS55F75KmmIIe1frRIgddy7DJk1u0dhVfRN79e/uoEfuJG1SeEURpot9DB+4hVkPuPaSJnrrQf18TCbpQCQBkCVqOL5FtdIUCy5NNR0pIyQlFFkBdNYy0mwsunOrXPWyrbJybwAolmot3imdXzeXYmHpkgy3ArpUQ285DB4/hd9joDmu0Xl44IGlj48RVjW2uo7UaKhByT+hBRWepdPA5CSEArXqT5hJ4lwJX18zhdxOgukDWEShBL326vfyke/moKsOCFW4+24Q1ayHTCFYkH5B+EWYF2LBeCIS9CBzZE8+cnUU+hjbxN/S72PEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DM4PR11MB5971.namprd11.prod.outlook.com (2603:10b6:8:5e::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.22; Fri, 4 Nov 2022 18:56:50 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f%4]) with mapi id 15.20.5791.022; Fri, 4 Nov 2022
 18:56:50 +0000
Date:   Fri, 4 Nov 2022 11:56:46 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     Steven Rostedt <rostedt@goodmis.org>, <linux-cxl@vger.kernel.org>,
        <dan.j.williams@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>
Subject: Re: [PATCH v3 01/10] cxl: add helper function to parse trace event
 to json object
Message-ID: <Y2Vgbl/5Gudpa4bP@iweiny-desk3>
References: <166742389426.2654617.4404053893427481848.stgit@djiang5-desk3.ch.intel.com>
 <166742400990.2654617.4918438509154032997.stgit@djiang5-desk3.ch.intel.com>
 <20221103014834.10d126bc@rorschach.local.home>
 <27786f64-b35a-ef82-0e93-55ee608f64ca@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <27786f64-b35a-ef82-0e93-55ee608f64ca@intel.com>
X-ClientProxiedBy: SJ0PR05CA0016.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::21) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DM4PR11MB5971:EE_
X-MS-Office365-Filtering-Correlation-Id: f9943f54-909d-4be6-ede5-08dabe9654c6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bpt0uP+8WIaoxipTzxPR6aQI81uJHlqHdqLJW1YkBz99MO3p/83YQ1SVTNhXz6ZdTnAygoUT4kfGZm5BZuN5fmNh3NM7nfWE2JphxQQXHWEp+dXlT1viOmtRBr1Anhwh17qQNgwVZzfhAQ7UF1SLPVVEHHBXXNtFKDHKyLv1Qu/RXHmHrxlDQP49ABEsy2hzG/w79kIuvKrhee5P40xkLld7zLjP3iRkSiZFVgu7ssw79OyQ79sjrNKA8MQxnQdwzozTM7F3TSA+N6mN5JhcRuSf5HpASZpyn1xh6ZrRxVKLpfg5Wia00tsV/3LSijY1uj74wm+dKc4Vmwu/WkZVKPzdLsmEIu0PnCsCp5uGpNfx7PhU8JvRFcRvnDveuZwdwaqiC9fO2/Ye8SFxX02CxQGNz0n4xgE20OXGn/ulAiF13F+Pq3Cvd/9bE87tHiRgRoTJUzFtB5BeFoyHXP2eaHgbxvRO93WBWZeSAqx61adRp95v2Pt2I5zojdnRdjLY2JVxw2ggKIJAtVhodsk/3lCH7bExHRJyP59mNcHKpyHz7tGvd2bl1JM/9gusNAKPKvncDIaMkED+j8s+5+MGLVqTjdYjFCu2ypyqOqbpkRhLgZ1dpof8jlvUWqCesLVoxH7lEpK5g05u5KS/aWQMwYIhPHjr4kfJkVKDZhjEuFY2gpam21waksyP1ByvsgZumVt9Mk3Rj5zmsrhKESet9Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(136003)(366004)(376002)(346002)(39860400002)(451199015)(5660300002)(8676002)(107886003)(53546011)(33716001)(86362001)(26005)(38100700002)(82960400001)(6506007)(4326008)(6666004)(6862004)(8936002)(66556008)(6512007)(6486002)(6636002)(316002)(478600001)(9686003)(44832011)(66476007)(66946007)(41300700001)(186003)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oIL3skuX9vD972afMpHzabzXoZ56c2E8e5Xat7bt0rvw6jJpjI+iw0jMhNdw?=
 =?us-ascii?Q?gwi4C2kBQs12LdkrjtGbwZd/Yie3GqkjSJWB3jTH/kLSC1d1Tpy4eoexVXC1?=
 =?us-ascii?Q?58kIFj+9yZFsWeLadm2s/9aeEUXZpOZ2wmx/4AGOB1LtE21zHkLIEMeu+ZE5?=
 =?us-ascii?Q?vqmEYHJ6grSzSE76XiU/OXGFE6NBLXCFzDwnm0id/kWTag0DF/6TP01XXYvT?=
 =?us-ascii?Q?tRZMxB3RxpoKydGM1dSzjp6u/QW+wv4W3CJm3nL/w7W9SbsXtnFWgQ9Ef9dl?=
 =?us-ascii?Q?xt0MX8V/wVYnujrYaJyhkHp5ljqhxnGfA4LNtyIoxTBIsz3IjW0P0Mu3rs2r?=
 =?us-ascii?Q?nVusD7yRLJ7hmExZSXRzCY/iX51OfV9oE/3haShDtm/X4BsvetnishVudcFq?=
 =?us-ascii?Q?FlN1+ufcP/I2+vE4SQ+eg72a2nsL8yhyKfGbPv+j0DcShh3YUl2AHu6yK8lb?=
 =?us-ascii?Q?ymGU0ljm/2phdDCxJfjvpZmbTHfxntftlqcLJJ119+tPZ6+aECNh5khkabbq?=
 =?us-ascii?Q?HeX+JgP6iRYn/G8p48T44KItUer8NPD2us74xeoBBFJbQ4TGmlhhrQKZIfqC?=
 =?us-ascii?Q?Bv5cjXyJnea1XZkwMrzdAGJHUK7yAVGxOq0P4VoVxz88G73Xb57GBtvMEFMD?=
 =?us-ascii?Q?I0AIMHNB6gRT4eeJHrGrM7C4PDNkyYNgOMWySiSb/B9XONyafsvj1+Dyj9gs?=
 =?us-ascii?Q?ULfptafsuJQMOxGDU0CSxJytXnsh6veYtr0cN2K+lv2cmjQUV9Y+AbOXF+nS?=
 =?us-ascii?Q?GZfE2p886Avq/D4ljybOAfz109SuqUpkuGpckjhvOcMRXNH8cl2iD9/jyF/2?=
 =?us-ascii?Q?YFQmgyWh97yZSVxSoAf4QAFcWuRPKjGMobRvW0qHdbjNyz41Dn/PYrTvOkfe?=
 =?us-ascii?Q?2AgKVIjyIuX/8CcHZ8GU1I3bAJUr5//btO5QiX0IsmX9nOTNi0imIHZrIM2I?=
 =?us-ascii?Q?sKVTbGh64vPoUIPPxf2HJnm3sQFbRvikgweZd0QPlXWm+jGlHuxiXjDMraOK?=
 =?us-ascii?Q?ho+yyuhKj6bue6bq738GdIyZ8Jz+wam0XSBJ8X3bbRlhjObxtlgB9SPSqZ6+?=
 =?us-ascii?Q?9RVl6nlHQlpe186E2pzqhwbncFUoQMjvwUYlxl7wvpo91pCxYh7/AQCNf8Pd?=
 =?us-ascii?Q?OmII1SQR0uz2Jx2GaR0WgyiNG33T3m7bhXbs4QQAXB3idTVbhdZRl8DRpQlF?=
 =?us-ascii?Q?1OV7oLeP74OklCtW7lYCXEXu0ja51TRuRu/Rp/FDoQjflSuh8vz7ieJo5NYQ?=
 =?us-ascii?Q?5TfAskzk8MCspPwZNaXQqf6rebBc4eXdGcT2eiqe885YONehY4Mfi1a6O+oC?=
 =?us-ascii?Q?t28s7rCqAB9AM3VuuToEOLcuk2tAm6Bypj6BSMn4D9tTiZf6gK7crATmjM7o?=
 =?us-ascii?Q?TsSXrM+MTGTkLjQ63IpcuZmJbzFEnqa6ACEfsl3c66HFqlm9h+E58bC8A2SM?=
 =?us-ascii?Q?VE5XxM5CSJJzvLhI3wXUbvuTgdFZozvZCWYHz5b+h9hZ5yYstfXjWTZlQ5hC?=
 =?us-ascii?Q?7MD05NUotUgYO53/WA7VwIYL05F8emDpDLvAV99gfdKelbt7wrtoWHCAhfzY?=
 =?us-ascii?Q?PMhTk4XO5IIZ05K1WJh1Pg8bTK317zPutTXpPjcm?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f9943f54-909d-4be6-ede5-08dabe9654c6
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 18:56:50.4915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mg++ZB3eyePp4GlK1h6YG1m3ORjInqwXy27MUT1IgYHyyaF5YiW5wIv8UeDRUIdxLNzeKfmpJ0TWnxodJpzMYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5971
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Nov 03, 2022 at 09:15:03AM -0700, Jiang, Dave wrote:
> 
> 
> On 11/2/2022 10:48 PM, Steven Rostedt wrote:
> > On Wed, 02 Nov 2022 14:20:09 -0700
> > Dave Jiang <dave.jiang@intel.com> wrote:
> > 
> > > Add the helper function that parses a trace event captured by
> > > libtraceevent in a tep handle. All the parsed fields are added to a json
> > > object. The json object is added to the provided list in the input parameter.
> > > 
> > > Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> > > ---
> > >   cxl/event_trace.c |  166 +++++++++++++++++++++++++++++++++++++++++++++++++++++
> > >   cxl/event_trace.h |   14 ++++

[snip]

> > > +		} else { /* single number */
> > > +			unsigned char *data;
> > > +
> > > +			data = tep_get_field_raw(NULL, event, f->name, record, &len, 0);
> > > +			if (!data)
> > > +				continue;
> > > +
> > > +			/* check to see if we have a UUID */
> > > +			tmp = strcasestr(f->type, "uuid_t");
> > 
> > I didn't even know event fields for uuid existed.
> 
> Ira figured out that you can you can use __field_struct() to accommodate
> uuid_t. Here's what he changed below:

I guess this is a hack.  I looked into creating a new entry specifier and saw
that __field_struct did what I needed.

It all seems to work fine until Alison pointed out this morning that trace-cmd
can't seem to parse this.

:-/

So now I'm not sure what is technically correct.  I've never used trace-cmd
before and this all works fine on the cmd line and with this monitor command.

Is this messing up trace-cmd?

Ira

> 
> diff --git a/include/trace/events/cxl.h b/include/trace/events/cxl.h
> index 6777a1119e68..22fcd677b6d0 100644
> --- a/include/trace/events/cxl.h
> +++ b/include/trace/events/cxl.h
> @@ -68,7 +68,7 @@ TRACE_EVENT(cxl_overflow,
> #define CXL_EVT_TP_entry                                       \
>         __string(dev_name, dev_name)                            \
>         __field(int, log)                                       \
> -       __array(u8, hdr_uuid, UUID_SIZE)                        \
> +       __field_struct(uuid_t, hdr_uuid)                        \
>         __field(u32, hdr_flags)                                 \
>         __field(u16, hdr_handle)                                \
>         __field(u16, hdr_related_handle)                        \
> @@ -79,7 +79,7 @@ TRACE_EVENT(cxl_overflow,
> #define CXL_EVT_TP_fast_assign(dname, l, hdr)                   \
>         __assign_str(dev_name, (dname));                        \
>         __entry->log = (l);                                     \
> -       memcpy(__entry->hdr_uuid, &(hdr).id, UUID_SIZE);        \
> +       memcpy(&__entry->hdr_uuid, &(hdr).id, sizeof(uuid_t));  \
>         __entry->hdr_length = (hdr).length;                     \
>         __entry->hdr_flags = get_unaligned_le24((hdr).flags);   \
>         __entry->hdr_handle = le16_to_cpu((hdr).handle);        \
> @@ -93,7 +93,7 @@ TRACE_EVENT(cxl_overflow,
>                 "handle=%x related_handle=%x maint_op_class=%u" \
>                 " : " fmt,                                      \
>                __get_str(dev_name),cxl_event_log_type_str(__entry->log), \
> -               __entry->hdr_timestamp, __entry->hdr_uuid,
> __entry->hdr_length, \
> +               __entry->hdr_timestamp, &__entry->hdr_uuid,
> __entry->hdr_length,        \
>                 show_hdr_flags(__entry->hdr_flags), __entry->hdr_handle,
> \
>                 __entry->hdr_related_handle, __entry->hdr_maint_op_class,
> \
>                 ##__VA_ARGS__)
> 
