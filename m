Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8AD0C433F5
	for <linux-cxl@archiver.kernel.org>; Mon, 10 Oct 2022 22:46:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiJJWqg (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 10 Oct 2022 18:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbiJJWqS (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 10 Oct 2022 18:46:18 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792947C77D
        for <linux-cxl@vger.kernel.org>; Mon, 10 Oct 2022 15:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665441943; x=1696977943;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8ENVfp7hhTyEYCyuIIdwQuJ+R0FkpDeMhhOGeXBEmEA=;
  b=TUYsRyxmTZThoUgou6bEhZuqFmth0+h8OIIJXt2LUfWONf2d4/2XR/IA
   qpCjjK5gpOWa6NL99mDtgANIEH7ZMqJ0oOIDPtwyUS6sjghTWa7a/mO5D
   ktRiKMNzYHya56wbZUdzma4YiCIHL1UmxXqaXQTQLEK8x7HWPeJ5Wd90g
   1m8ptdBKlAMRyG46eUXkWM3PBh1qhIzd/n3LfaWuD2bItox2DYVg1MEOB
   GMyY4M89KwsHz2dvFc455j/B/hD6R6OeHh7rCsAuwnsJxYRpmgL+qrBmN
   HA/3O/NLoxLXoxnCUkuCzqmjn30q8goMXO75vupgLxw8l3zbTW5GTNNrI
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="330824242"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="330824242"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 15:45:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="626137958"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="626137958"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 10 Oct 2022 15:45:40 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 10 Oct 2022 15:45:39 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 10 Oct 2022 15:45:39 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 10 Oct 2022 15:45:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lKCM11DaAGiUx57KQm6MJk0zHp/4WDHk4OAtB89W1WKUlGORmUDMnM1d9cEKElRiOXecQe0FyGfDt/QhqLpv49bBjzReND7bcDRPW8Pc8PFQDWjxwW5htl8exzSuPqsNpWyUP1C8JXp+3Umtv3IgLNepWZSor85maXGMaKcCJe1QUitBK9Wb8GeJndkQ4A5YPj/5pAAieGZMBAc7fMdF5g1ewvnpyTyjH/67TznioQh/8L7xTxy4ZtjcSP10MGe7ll1X/M3pe67vYP2o9MjDJ9d5T01xilHdrMHC8q16H3FLup/kqYPFudA7Qok4+IMbZS9Lz7+u7xmUj4do+wr4nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GE80gOualzcvbV8YvP7n8sh55poj3CVpJwO8zKrENRw=;
 b=aHK8Qx5XWb1VDytroP7mkBBly1iAD6/fkPAKgQuv7TVivOYeFau8O/zaWklbWhhE1d5HnFyLQ3/OCTMnPDuW7bVCq17h58xmFA7xF2s3bVuZyBrIyNRdGq1gNjrCs5UrSthmTmh9dGyUMYFHFsvPxPezBImwApH6hDEfQ5Gv+54FCNLaP7kYBOX4eVzqjsisVG9EVd12VkUYV3HY+NRr8ZDGNjvXyjVW5k/jVaWSrjV+eRiyDu4o1XIMunik8/vrQb4J+lppOL61LkUibhvrmqObyy7PNsx2iww3XtsZKSw/4DpdKgwb2cBPaiQcWb6uV9kU4DWMjUB9jn87cP6+mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by IA1PR11MB7270.namprd11.prod.outlook.com (2603:10b6:208:42a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Mon, 10 Oct
 2022 22:45:36 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6f83:c165:aa0c:efae]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6f83:c165:aa0c:efae%6]) with mapi id 15.20.5676.032; Mon, 10 Oct 2022
 22:45:35 +0000
Date:   Mon, 10 Oct 2022 15:45:30 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [RFC PATCH 0/6] QEMU CXL Provide mock CXL events and irq support
Message-ID: <Y0Sgiq+WMwOmqToe@iweiny-desk3>
References: <20221010222944.3923556-1-ira.weiny@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221010222944.3923556-1-ira.weiny@intel.com>
X-ClientProxiedBy: SJ0PR05CA0204.namprd05.prod.outlook.com
 (2603:10b6:a03:330::29) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|IA1PR11MB7270:EE_
X-MS-Office365-Filtering-Correlation-Id: a8b511e3-9036-4b17-503a-08daab1124ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: przfpM0M3btrjwKBKAJ9eiWXHXfbli5P5FEe8UJWmU0SGxZO9n8YDE/EXrvmiBabAXUce+tORLz+8D/J3nNdmD5FVHBseYiBeYIm4Yr8J/RSJ+3akxwETIeiAddaqQjXeoxZJBMbe4rp1xJYi3kflk+rsQQt4I+Mfwn0myBwbHVQoFZ5XylYjnT1PvYSfJwTizj7icVLctOrgItgMGpDQAGCUD/VRdafMqPQ4WU7+AY+H0gVK6wgYuOz9BD4vSX4idlmyQT61WcuuPjS0JufRXB9wxdx/Vq8JIm+1aAQvlzJ04XOrYmihO/owXTIyouyO/Lv9osvzN5fgRh+6vP8lv6OAhleLsx8dIj5C6VBgC99lhIjMKl+7skKcitWYu8CdmReK3E0pcJx+FqbJJgJ8aa84DxJJ+shZszCaRIr7fkkGWVQbr4MDPrFlF58sVpEdhxTaLVRymZilE3BNbwBBkvyZ4mIXrXCHlSgNpQmDm7oj2OmosoeywSVc5nCd7bHUiPUbuOsfuz2yj3N3VmWMK9/LE5tY8I/3yU0lOo0CO+emurNuTMSaBFQbSFJcvmYzp9hvmy3X+quFOfjuqJsFVD5P7s98LGBUB4WDa4G0IJzKcn/7HqduW/C5P1pdOparHqN+wzUbJvIFM8NYctqPaDMUrNXvpKoKsHs34aO6bgjE1TopSkE92kGNANu3IjT726ftvynvz5AroyKq0b0kemgEJMw1UJ5aMwAlhuuw8brByhRVJ1otUywbSPtc40nKFEw21Caf3dOLE3l1EgsRW7rY3TfI0mPhfDpwDzt6RNaeuRQe3rh+u5xbr94NCKeITtjVV9lsDXrPTXpkQOgjQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(396003)(346002)(136003)(39860400002)(376002)(451199015)(5660300002)(8936002)(6666004)(26005)(6512007)(9686003)(6506007)(2906002)(186003)(44832011)(316002)(33716001)(83380400001)(110136005)(41300700001)(478600001)(966005)(86362001)(66556008)(66476007)(4326008)(8676002)(66946007)(6486002)(38100700002)(82960400001)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YLxlecVqHjH1Q60HXCZNvShcD4XwN5eqsuikY65K5hfmZgHlEB348v73NOjE?=
 =?us-ascii?Q?VsE31nhOrOMe54V4Qjh7SotsBxu7YMRDpudZjuMFqhqyjg+Kn/KyWeYOVn8G?=
 =?us-ascii?Q?opA46TeWNk9p3C4t1mp9UkZ8dCIE8ucXNT6RJxx0gBzBWbdrhixgEM4NZOcu?=
 =?us-ascii?Q?DAZYFLXxUQI8+UfhLwG4jaX3hCUTnjkn7SK6jdE6aDZIDxzS8ZMe/MqjfF1g?=
 =?us-ascii?Q?HNkhR8WFo6njc3tZTrgXy0DduLV7KF++yNfMPXavXT1M8WYUp7LXz90ied47?=
 =?us-ascii?Q?TmXNB0xEPXnRf/jnyHY1/rw2obrA8M8CYY0igWRhbgcxjIamw2xqXcKf564T?=
 =?us-ascii?Q?Tgx+Lt20t6UaYf6Y1aYMNGpv97pPYH2CPzZyksiSeqEs59Zv6Nr4dYfq1civ?=
 =?us-ascii?Q?lnetbFsGo8xg+XjvIeqzr/shXinCVH7LhwaD24AZyOHCxNnLQ7uLR9WZuOJa?=
 =?us-ascii?Q?v/TxNDeZPx7dsEfGr3pmWegb2flVALTH/QZmoMto/ss9+tNvh59lTgLzZzmg?=
 =?us-ascii?Q?C7G+OokM2cWUg8cWNRoJ2gspGSQJJ2S053uW7rKRvF5HLVkjX1WY5GMtCu65?=
 =?us-ascii?Q?z//1JqOHA/dskskRRkd1Z4QobWxC6UQaYxC+SWOJlLaYO0R8HPM4YejCF8+/?=
 =?us-ascii?Q?RJWeAspQRXXkmyiiUT1PLCG1/if3zmKD3DmBReWfPslAfQTAv35W1QaoT2T5?=
 =?us-ascii?Q?zD/zt7pH8MZwMSVakZjkSbmE6dU+epdf8euPH3UmrX1rWHVeAuRrfdcUeG34?=
 =?us-ascii?Q?EwLu1Obz4QElFvUBgd9lvPQICXk51y23POQVTJFE62q5zxkbzESmYUKtP5kq?=
 =?us-ascii?Q?BZJYq5IWBx172Flx6pfgoiRChf5JbELIEedW6hSQQJN0AhzTjbC+IgO/mkrV?=
 =?us-ascii?Q?wZUTWregFaXXkWt5T9yjSQu8NgKf+0DDAbMBB2dLtrH+oHcdbTO5kSI+BBfz?=
 =?us-ascii?Q?6dR/PzWPARol65v0END3JYTRe6kfpnB0Vqek9DW+y1BBZ7dcxZt3HOaZadFM?=
 =?us-ascii?Q?Mwt08sbF6GQ/fMMJJgl4fGM0NBO5rCwzsDWA34URKmE7kS9Y4nQmCZXE8bPg?=
 =?us-ascii?Q?vY0dLUtKmFOS2UbV0GRi0pZ1L07I3/gYTf3DnmYD075RK2QSueT2mzzXFOLf?=
 =?us-ascii?Q?j8mrFk8wIHwNlYArDhsaiQYguqpQe4OqLQj9wJ3SzbiiZKisnqc88BmaqoP7?=
 =?us-ascii?Q?NLcL0YNU9lhgELZDNod9bR1Ned0gtycbEcI9BekojRlrfWf1g+ammpVyoXc8?=
 =?us-ascii?Q?a2DuSOm3pR0F5F9OjVxQmAz0BpHTBmmrVd0I9pTIgHAT8Wdzr5E0txVKwdCF?=
 =?us-ascii?Q?2cxQtk052MmArCDrKgGFKhV0+EuNG5rMn9lRCipx3nAQQNNlca9kbz3+fExs?=
 =?us-ascii?Q?SWzbwZ8lG6tMRce7Lnbf8hMpqndCOTNr8VWbDKMmlxClO1toK0REH/NYeQOX?=
 =?us-ascii?Q?NyHWQ46VmhL7gPRUbbARopgSZVuUhpipSN9L6Df47kp5TfwOAEv+35abV+uY?=
 =?us-ascii?Q?c0KODThdKLEQLig7BWzt1f82wrrLnYkri5wIVKAqCsdyjLakOExItyDHJwEF?=
 =?us-ascii?Q?mRfTl9JLmYEZ9DixfgQYgzup9few9cPaUg3DXSSv?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a8b511e3-9036-4b17-503a-08daab1124ee
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 22:45:34.9987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nFcDhN5nKSOZrFY4o4VesDz4KEJzdTK5Z6gtMku7AeyrtWv335CMsMGBpfOyezg2mLxq4kUif4oGWhcJUBaZdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7270
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Oct 10, 2022 at 03:29:38PM -0700, Ira wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> CXL Event records inform the OS of various CXL device events.  Thus far CXL
> memory devices are emulated and therefore don't naturally have events which
> will occur.
> 
> Add mock events and a HMP trigger mechanism to facilitate guest OS testing of
> event support.
> 
> This support requires a follow on version of the event patch set.  The RFC was
> submitted and discussed here:
> 
> 	https://lore.kernel.org/linux-cxl/20220813053243.757363-1-ira.weiny@intel.com/
> 
> I'll post the lore link to the new version shortly.

Kernel support now posted here:

	https://lore.kernel.org/all/20221010224131.1866246-1-ira.weiny@intel.com/

Ira

> 
> Instructions for running this test.
> 
> Add qmp option to qemu:
> 
> 	<host> $ qemu-system-x86_64 ... -qmp unix:/tmp/run_qemu_qmp_0,server,nowait ...
> 
> 	OR
> 
> 	<host> $ run_qemu.sh ... --qmp ...
> 
> Enable tracing of events within the guest:
> 
> 	<guest> $ echo "" > /sys/kernel/tracing/trace
> 	<guest> $ echo 1 > /sys/kernel/tracing/events/cxl/enable
> 	<guest> $ echo 1 > /sys/kernel/tracing/tracing_on
> 
> Trigger event generation and interrupts in the host:
> 
> 	<host> $ echo "cxl_event_inject cxl-devX" | qmp-shell -H /tmp/run_qemu_qmp_0
> 
> 	Where X == one of the memory devices; cxl-dev0 should work.
> 
> View events on the guest:
> 
> 	<guest> $ cat /sys/kernel/tracing/trace
> 
> 
> Ira Weiny (6):
>   qemu/bswap: Add const_le64()
>   qemu/uuid: Add UUID static initializer
>   hw/cxl/cxl-events: Add CXL mock events
>   hw/cxl/mailbox: Wire up get/clear event mailbox commands
>   hw/cxl/cxl-events: Add event interrupt support
>   hw/cxl/mailbox: Wire up Get/Set Event Interrupt policy
> 
>  hmp-commands.hx             |  14 ++
>  hw/cxl/cxl-device-utils.c   |   1 +
>  hw/cxl/cxl-events.c         | 330 ++++++++++++++++++++++++++++++++++++
>  hw/cxl/cxl-host-stubs.c     |   5 +
>  hw/cxl/cxl-mailbox-utils.c  | 224 +++++++++++++++++++++---
>  hw/cxl/meson.build          |   1 +
>  hw/mem/cxl_type3.c          |   7 +-
>  include/hw/cxl/cxl_device.h |  22 +++
>  include/hw/cxl/cxl_events.h | 194 +++++++++++++++++++++
>  include/qemu/bswap.h        |  10 ++
>  include/qemu/uuid.h         |  12 ++
>  include/sysemu/sysemu.h     |   3 +
>  12 files changed, 802 insertions(+), 21 deletions(-)
>  create mode 100644 hw/cxl/cxl-events.c
>  create mode 100644 include/hw/cxl/cxl_events.h
> 
> 
> base-commit: 6f7f81898e4437ea544ee4ca24bef7ec543b1f06
> -- 
> 2.37.2
> 
