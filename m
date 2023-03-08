Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD58C678D5
	for <linux-cxl@archiver.kernel.org>; Wed,  8 Mar 2023 18:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjCHSWv (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 8 Mar 2023 13:22:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjCHSWu (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 8 Mar 2023 13:22:50 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29448298DC
        for <linux-cxl@vger.kernel.org>; Wed,  8 Mar 2023 10:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678299769; x=1709835769;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8KcueN/V31B0tafN1zuEs/XG94PMAy5BCM6v8t2J+h8=;
  b=FEqcOF0DT6YfGskEXtWDQPRh4eVhChBJBicZCeUF+A0h0uAYtZrj/VY3
   IroCLpiQdTZ0PWo9uSYa5KSXL0FG6NGM8Cqf9quCrswy0TkpzCZ/8RlNN
   jdmIbYSxKbH1O9YrUm/xTOaX28enVcCqfK/VmM08Oiz+hLrVLRn74MXcs
   0T3dj4/xrZhk31fY+IljGlQuFGVUL2dpGky7pNxCPforyxWHq4jyTXNhh
   OI1v+iYsLr98aLVGXrFKDmfTwVooODzmhDryuANOZK8CdjmcHEpIv7osA
   8FXn148hsUVQAnyNRmOro9uIHhi81iWzJ/FZlytp58hpLjg5XCLqo4Yu4
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="422510112"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="422510112"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 10:22:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="820327620"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="820327620"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP; 08 Mar 2023 10:22:48 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 8 Mar 2023 10:22:48 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 8 Mar 2023 10:22:48 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 8 Mar 2023 10:22:48 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.42) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 8 Mar 2023 10:22:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V2zCtPRcJMqJP0Eb7IktsIFF8otk6oXtfdfojcMWTV4l4aUVkvzbIz5/qFQwEcvJ8Qpssl772HDabfkPSmYSRmlwCiqdjb0V7oBd8STsgPKjyt8jvAcMeGGf+kglxx83yeNQcYA2rq+H1W4eX3YjKeWcqtESJRcHeTjmnLs0UgZNpWwkS6hLTK89H8Rf1SpqfVXl7HTlyKt7bT+Wnmsy/ai9qk5HRixGN5TRo3YN5a8wg/85EQytM/3JgjTegt8CAha6sZiGMx3/EBE1959/8DoWG6TnayKwFyBqsUpYS2M68HXGJqIqeiqDbHR1GjqGCVWdV6XBVEKTnwGFC48ySg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N/HDgPp61r/C8RnVzojRPuX2bm9kSMMNyGR7AXBXZds=;
 b=hDFTFj6aCUfpCbepFSrNnHyr+/lBcXs6meUDAhDOQd1FuV9bKJHMlwDLxgk6y/Fvcju2m6tWgmXIJm9azqZON3ZdC1/CxcENqJTc5iG2HZ7p47dUAKJVHXaOgcJW35NwV0ccYghC8RTFJunsXWJo9iCGQEGGepSTRXyIkobbp8hn7pGSEYjRzXVQbZhhrGF3fLT6c4AFO52dRZ4DC5dCQ1BFbT0rUxQDY/7qzv1D7x+CR/srMc3A+pifHaLWXIdHzuB7Wim/oBA3bwgkH9wqsqSTQTWf1GdjaAIzsxOD3ZpnN41aSqHvM3y6CwHvN1Xp263SmIMPQqNPM6fOW/PRNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by BN9PR11MB5323.namprd11.prod.outlook.com (2603:10b6:408:118::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Wed, 8 Mar
 2023 18:22:45 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::84dd:d3f2:6d99:d7ff]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::84dd:d3f2:6d99:d7ff%8]) with mapi id 15.20.6178.017; Wed, 8 Mar 2023
 18:22:44 +0000
Date:   Wed, 8 Mar 2023 10:22:41 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jehoon Park <jehoon.park@samsung.com>,
        Alison Schofield <alison.schofield@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>
Subject: Re: [ndctl patch RFC 0/2] add support for IDENTIFY command
Message-ID: <6408d271a2c96_f3f4a2943@iweiny-mobl.notmuch>
References: <CGME20230307081917epcas2p1accc8f7bf3f31e08525684abb2efa788@epcas2p1.samsung.com>
 <20230307082102.27195-1-jehoon.park@samsung.com>
 <ZAecHtXUX5ZR9ccU@aschofie-mobl2>
 <20230308090134.GA15397@dell-Precision-7920-Tower>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230308090134.GA15397@dell-Precision-7920-Tower>
X-ClientProxiedBy: BYAPR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::36) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|BN9PR11MB5323:EE_
X-MS-Office365-Filtering-Correlation-Id: 09a6b818-684b-42ad-e3b8-08db20021cb3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a9GK1AJjcoioIS9FFZQ7mJ0JdiL6hhtz2c/AsWckr1XmK02P8Sl0S69TTBVkV76l3U6g0p6xMn2DeK1yKfRh3G7LfFlnO5VE+vTEGY3OfRcZtX+/f6o5cbzyKWo2zcKQJ9cXGVBFZtm5jAcaHNif1LHIJCP9AkTdfDgV/e4u0ULNmRjoTuJsAi5Fcgsq784HE5PTCgtiX6nCYl5rQJ4DxzAbzZp6xOlfD1PuqTPwtnVNEW0mZ2G0OmaPT9YiR8Bl3+kvXwLvnPjEqjVTHp0GnOIjKf7RUrOoRBETt81++belK8wKam3FklmSOckBJ5mTPAxYsR7UgZXhpOF5J7HdPvnXVe6p00cqfW5XvT/+t+zZoqc0afY4180FEiv7h1MUBwgCzrZpYpaxOdizM3WBzCQHK9JEiTDfS8mZwDuYDIhqVed+moi39eQ8YBKtHL3Vvtpll8AYg99n+VasQ7Jrum2VhClsIxvFA297XPQKYfer34I5YsbWBsOChihlHv80faamcJTfZIE+iarqVOGlsTaQnSbQFN/sqCdcGDNMg6QZOvrhsJ9dCNTj4rJykUMqnczjYZL39t7V2mRNhvbboFAZ5Odq/6jg6TWWOpyfGqkcoUFtFQo884q+9q2yAHlDwgYFBHuHKjyN0c6xNSsQsg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(366004)(39860400002)(346002)(136003)(396003)(451199018)(82960400001)(66476007)(66556008)(66946007)(8676002)(38100700002)(4326008)(316002)(8936002)(41300700001)(6636002)(110136005)(6666004)(83380400001)(478600001)(5660300002)(86362001)(44832011)(6486002)(6512007)(186003)(6506007)(9686003)(26005)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?65tJ+eSOjLOJe7DUNUJuo/dx5aiWikds3cxCtZg1votmUg9CXC1/iMCHqNcK?=
 =?us-ascii?Q?S/JSkp58CDAGw55HeGTZOdprVscXxOBvtubrPoupfQLcvUT7an74AOP5PAnH?=
 =?us-ascii?Q?AdjvLZzAGlP1pGCM5YmtmSVP55Wzx9GW5Uf7rsvnZgjZ/ciLzAlIcrcTqeMt?=
 =?us-ascii?Q?029hAsCwgeRIyzf65aDSr/AFjv9ftT7pCQ3aIPqj2YyLzk3YLQALPjVPGqPS?=
 =?us-ascii?Q?C4pTKSHU0a4NKB82zZ531HvodB+BWaLyNOpsqigFwyUOzcwxz9I3jgZmAk1X?=
 =?us-ascii?Q?01NNmrF84hiMEodsZyKpHYN0Rbl4UvkiQtHOMjWxOUVHjvS144RKVGTUeil4?=
 =?us-ascii?Q?KqTfeotv4Uc3PVG7Et7iKvKxK3amP802NEZr5C12l7EdGWdiGqREBA2OTbMt?=
 =?us-ascii?Q?cGfHOT0AJlEH2q4uhtGmC2Es9qrl4KIqL5naM2u4aYSBNstnKbtO/L7geNvo?=
 =?us-ascii?Q?ek7L3INGvpu+4vZjMIQ9OdxJ1YWljuQ1tUxbteWZz8nkncnGIPuN0khYdCvh?=
 =?us-ascii?Q?xc1ptv0DplSrir+Gk6GRgWJxcH77rsfbjEKSkXYJ1jx7QqFWEQPzVP0ebmMw?=
 =?us-ascii?Q?OHXFzJSzqjeCujmsi/eJPzL0mdTuszC0ckhv1YgHECzoK9KaYjFUBEs2Sd2i?=
 =?us-ascii?Q?BTtwsWZc/djCH9j0amD9d/aRQlhkp7ST9MV+BSYFJ+/IY0MAfOKj9brA+N3L?=
 =?us-ascii?Q?qxMhfjjVXdogBxYgdeO2pJ6SYZVvtZAshcrmhifbUul5OKuIXQ7/wWhrYc7s?=
 =?us-ascii?Q?aPl0bEQw5Hi2obG2/WkTjpvEMSaUIyAjgoDUeiG16MtwdY5zqFkZax454D6C?=
 =?us-ascii?Q?5+Y9xET6YhInM1Z3ZHIgTxYYdqv41u94+JsyQzRsYEi/8r0vzHRKsr8NFD/6?=
 =?us-ascii?Q?1oE9cKv6+2yZVrseoNP1JglupMVlo5hSZUz/4HLUHC3Mnw0KX9xX6BoEOXg/?=
 =?us-ascii?Q?91beIjaeXWm6iz1RdWIzMYIEOQ/6YOGiFWHwQUKRPO6Bw9wH7PhlaSi8GuLR?=
 =?us-ascii?Q?KBidnPEj7nJVuMghe7cWwcmhjedjrpiua535vRTGCqQU7aM6y0epp4j6htj4?=
 =?us-ascii?Q?zfX2YFms7x1zQl+utkBXQIazytmMLyjc2DjidBqkdjlz+rgOioCtO0OojF8A?=
 =?us-ascii?Q?0srJ/LKPCdsvgl6F6FK9eX+/QFKMFTigSRnLihqFpaN/BCFcPeNN23bZmMP7?=
 =?us-ascii?Q?It2tCUo9sRrnVpV33SBcVUpv/ag92uTXzOfkQOQ6DrR30QH+pmDNi9qDjQ0g?=
 =?us-ascii?Q?6+W+IjIfPCQmT/iu5Q9Or1PBTCshvTwmgSaRWD5zMx2WmmQa4JKRVKwaueYV?=
 =?us-ascii?Q?veD/ydvpdcD+im+2kBFyI1NjcKbEDhfvXAU0zs5vqMjothFX1LZlibCDVhlR?=
 =?us-ascii?Q?Fw7/kBoFMTNlYtkOfrnrQY3U2nXqT6L/Rguznn8r7zzExLohF+hoiqBSxfZm?=
 =?us-ascii?Q?xIG3HwpJtC5EJ2Lm4LJBCOmQ7+wUGmoUU9DxHV8cNi5Sm7sNjCYl2XG8Aq+z?=
 =?us-ascii?Q?e2Oy7RjdJIFTJ+5wDnyDw6YErYdTBL1zeQ++t3n4dOGGOCMDHHpjkmy6zKj5?=
 =?us-ascii?Q?vW91TQC0DwvsalTQLtn6SYpj/99+nZnPPDbxfUi1?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 09a6b818-684b-42ad-e3b8-08db20021cb3
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 18:22:44.8662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QZ3E4QwYN7zcH43HB6aTWeC1hj8h2uctR1IJcIsaDqM6C3snkiwqjGxQ8PFNWzXIxOlddBUJjFBYuDWnUnqXdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5323
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jehoon Park wrote:
> On Tue, Mar 07, 2023 at 12:18:38PM -0800, Alison Schofield wrote:
> > On Tue, Mar 07, 2023 at 05:21:00PM +0900, Jehoon Park wrote:
> > > From: jehoon park <jehoon.park@samsung.com>
> > > 
> > > This patchset supports CXL IDENTIFY mailbox command and corresponding
> > > cxl tool interface command.
> > > 
> > > CXL 3.0 Spec 8.2.9.8.1 defines IDENTIFY command which retrieves basic
> > > information about CXL memory device. The information consist of device's
> > > firmware version, capacity, LSA size, event log size, poison list size,
> > > inject poison limit, poison handling capabilities and QoS telemetry
> > > capabilities. Firmware version, capacity and LSA size are already supported
> > > and used for partition commands or sysfs attributes while others are not.
> > > Since patches about event log [1] and poison [2] are discussed recently,
> > > support for those information will be helpful.
> > 
> > Hi Jehoon,
> > 
> > Does this need to be a separate command? Identify fields can be included
> > in cxl list options. For example, the -I option to cxl list, issues the
> > identify command and includes the partition related entries in that json
> > output.
> > 
> > There are other identify fields that need to be picked up, like the
> > poison related fields.  They need to be added to the cxl list 
> > options. We may want to include some when we list the poison, and
> > some as an option in the memdev listing.
> > 
> > Is there some reasoning behind separating this out? If not, can we look
> > to add the missing fields to the various cxl-list options and add
> > new cxl-list options where needed?
> > 
> > Alison
> > 
> 
> Hi Alison, thank you for comments.
> 
> I suggested separate identify command since it retrieves basic information
> about memdev. Since cxl-list command lists all cxl objects, I intended to
> focus memdev information by separating it. Also, I referred to nvme-cli
> which has id-ctrl and id-ns commands.
> 
> However, as you commented, some fields were already included in cxl-list.
> I think the idea that providing information to proper listing option also
> makes sense.
> 
> Then, by following the approach, including fields to cxl-list options,
> identify fields could be included like below. Do they look fine?
> 
> 1. FW version and LSA size are included when listing memdev. ("list -m memdev")
> 2. For poison related fields (poison_list_max size and inject_poison_limit),
> include them when listing poison. ("--media-errors" option, patch [1])
> 3. For capabilities fields, add new option "-C, --capabilities" to the
> memdev listing. (I see there exists same option for listing nvdimm device)
> 
> However, I'm confused about event_log_size fields. Could they be included
> in capabilities option too? or require new option like "--event"?

Fundamentally why does user space need to know the event log sizes?

I do like the idea of getting the 'raw' results of the identify command in
it's entirety.

What if list has an '--identify' option which adds the list of Identify
values as a child json object.

Ira
