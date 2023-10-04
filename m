Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F96AE8FDBF
	for <linux-cxl@archiver.kernel.org>; Wed,  4 Oct 2023 01:01:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbjJDBBZ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 3 Oct 2023 21:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjJDBBY (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 3 Oct 2023 21:01:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D901AAF
        for <linux-cxl@vger.kernel.org>; Tue,  3 Oct 2023 18:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696381281; x=1727917281;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=d0oT7Egzr6ZYNFh2JWqJYRBBGY+svSb/ySm/Wf2hsd0=;
  b=JiC+3neOa8ZGcnCzlXu5JCMTp15hxqd/YaDdmR54emUMAVBK8pbxhQvV
   1V3NhhRJNEM1Ykl9o7zBpY5nW650gWwXT/HPwcFOaF/5E97YcM7cIlEWp
   vVEnNe/g+T6u2AT7Po2pPD2k+6jR1aLkEpgM9gJhDOjpQ0x4rMn+TZxBi
   oIXud/9/LWC44jtTX4E3XxvJPsOSQuBJYdTkrL9jibZ/OAh4xpnNH+Y0W
   yZUBD3IaC3TQQHtcwANvbs3Qr1EIbIRDAfzy2OekMPvq9b6S5uEBDcoPm
   fNdLBEMRrSQE1NNnKtkTba2UpZ2choMTgSSDLn5NTKgLMtKBGR/dw2oK5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="447193633"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="447193633"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 18:01:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="841581371"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="841581371"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Oct 2023 18:01:20 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 3 Oct 2023 18:01:20 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 3 Oct 2023 18:01:20 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 3 Oct 2023 18:01:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XhOwEMj+bQZ+xhWJ0B7nOaXcCIf3qjJP0kvN3xn3OsFTpYWH2q6xa+bIJpPcnZC4hzgGYFMttKCnD9TcpCylcD4w4IvBQTJtN7VlsKMTfPSXX8QxOtl6aLQYjEVMABSk2NWRCxoB2bTH2IzexaMKj9oGYz7zBgPvmLqA/4y6MDrLuc4o7Qk8JBARM1219TciUlBZo/dgRzIadSa3uIcJG9nt9yQKPiMbzTZhlfSh5mc5qkw+ZlRWA7B91fUvitA2gPRjnF5Es+UgUBm9LqU26ZocHwgE8onAmR+Up/7zYUyzvX0JO73t4YLptYwOlp4ncA/AqwjslqpKw8OXs6ZMMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s4pDPIuxNRczhc6r4YZG6IAkpkF5wtFr11yaNuNoTzk=;
 b=Yygv9tNlCPgaJpdrg1uT2IsnKKuowzlEgQkSPqn9St+tFMlzQJBznQQdepAsDYjezeQoDsXHwOJ3gwgtis5exPCTGEAgY0y3KecIe8lMJBLeQK8xHAnK0Gt2nSegqM3H7uyl1GPVZ0ovLspxKGwwWtBya5UvR4yLVtAPmq3oqaQ91oFt20Bjma5IZIysAW30ryI/tw4J3lUCVeN/7PS3yNRh/xYehGWa5h2R/3c4WBG7ze9Q0WvXqhaJcjPh+1WMaRFMNOTk1xxJhAPxpYDGGX2e1WTOXo43gVTvWRorBPYAPCPbNuK0KxETFkWMB9tOAEqoKKUGZtm51r319+Nu7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA3PR11MB7525.namprd11.prod.outlook.com (2603:10b6:806:31a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.28; Wed, 4 Oct
 2023 01:01:17 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992%5]) with mapi id 15.20.6838.024; Wed, 4 Oct 2023
 01:01:17 +0000
Date:   Tue, 3 Oct 2023 18:01:14 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <ira.weiny@intel.com>
Subject: Re: [PATCH v2 2/4] cxl/pci: Cleanup 'sanitize' to always poll
Message-ID: <651cb95aa1af5_ae7e729438@dwillia2-xfh.jf.intel.com.notmuch>
References: <169602896768.904193.11292185494339980455.stgit@dwillia2-xfh.jf.intel.com>
 <169602897906.904193.9057960720070253436.stgit@dwillia2-xfh.jf.intel.com>
 <xqouql3fxo5zyyjqjoxn5g7nmupwh6qei7opsb6cymcvb5a3ou@gg5z2ebxeq7t>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <xqouql3fxo5zyyjqjoxn5g7nmupwh6qei7opsb6cymcvb5a3ou@gg5z2ebxeq7t>
X-ClientProxiedBy: MW4PR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:303:8f::30) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA3PR11MB7525:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b54b8ea-641e-4584-be8c-08dbc4756a2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ETVlp73SsrUXy2FsUHScHnrJ4crtOISd/O9UjD0RXKGY8WAnw4rDA015+o1tBXWmAMeXKk8VWNxok64OEuEUd9Gkf2/x/rZOXvTh+ATDpdn5l69cOnRjEvmKMT+9IfmDdIPWmEjgA0rvnn1PNiDj1RiYfjoQjh8ZV9vpVMUqmlmwi8tJTghXpMXoENPVK2E5lK1LTfCtQQHkgLqQ9qoVIvPTTqWV72YymAAKTCM2JoIGfsd0felAaMoxPQs/U/Ql5UC8TuwOViBh1OPmPufVD7V3PwIhjJ3h7qMZg+vJnvT+dpk37Ff4c9/ojmVcN7F1IVUkkRjyye9Zkw5eaHTA+O9q4bGUt6KZfQsU6pe9bLzUJZXaT48cvuF22vOLTojVH2lvNpVB8DBLGjrXLlmmfdH2dG/X4v2sd8P6RFTxkUruTGK4vV9REMKfE8kem4cwgJvD1LaduOa6DOUH+8Qf07meeHvHIZDvVD4KbOJA7a9lEXh8PINb6OMwwod0Vrh5zH4RSSbjCOa8mrOrtL9nwHm7IbeNxdB2w1GVoe+gvRXthw5drSffAZXMlQRQGGiG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(396003)(136003)(366004)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(110136005)(66946007)(2906002)(26005)(4326008)(8676002)(5660300002)(41300700001)(66476007)(8936002)(66556008)(6486002)(9686003)(478600001)(6666004)(6506007)(6512007)(316002)(107886003)(83380400001)(82960400001)(38100700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JfC+a6F9s9QPXUHihdp6uk4Oe2rA3MwWHb1OJMIgutnUUIoEj59yeD1w+zSa?=
 =?us-ascii?Q?VOi7UN/9kujbzH9yLlIjSX+WC50SiGbso1Jd78RmYkLiwvoifCozTa5ke8+q?=
 =?us-ascii?Q?X1PZnpdyPd3JpuizyhgBiFaj6b9dKhfWGQBIBg1ev143xcjfJf1lkAkvL3xJ?=
 =?us-ascii?Q?WEl+lHxiUtMldDdmRXDa5pcEkUdJWMTZSxC/RxOREjPo4W+xVXWqtG8aUAL0?=
 =?us-ascii?Q?Tk+ZlW1ERI9LnY8nRTbLz8q8N9PK8z5+OPo3DrxvdMoq6k+/4R9JKag46Vl5?=
 =?us-ascii?Q?oH1S9st8Lo/m5LxBLjpx/WCj5rN8Ue1xGpM4I5EGAH2lke0Du7HtTruGpdWV?=
 =?us-ascii?Q?/hHYNn0UWx8kD3ES+c876b5JU/0/wijfOPOo+BOiBIoewndxi7aZDIkaObg6?=
 =?us-ascii?Q?QGugb+Ft+a4ibsGqTXUjN2GdvjDdGBdUD5ThZAcXTJh2UIeXJWO++urIq7Al?=
 =?us-ascii?Q?Pmo0USjDuE4Zubzn8GjOY7aWAGjNzcJ+iI/XuJzFpAdzhqtJz4eMOcQU7rFo?=
 =?us-ascii?Q?njnw8IZq8Plvb4IMRvxy7JDEI8ugDO+aikHOkBKah31ldJd+AnbpG4tQ65ua?=
 =?us-ascii?Q?6uCunLStf9qW+bQkGT3wy75NlBf8aMnNMv4LgznTsiI4YsNInfZ/1FuPoB4w?=
 =?us-ascii?Q?KC9vLrWnvAA60yExwPaLXTrPc6VH6MPITsModltdXLT6lkuWWlc5oxXrdyr2?=
 =?us-ascii?Q?ai/KCsl1OSl/tL5z2B05dfP9p5b2JpKRn9T4IVWrYDv2B4wFPqfFR7PCFn35?=
 =?us-ascii?Q?THacJVPATsKTdbInrDHtASlqTnVeO1boNhHqmOnJhPkcSST/tNaIXeH3oRc3?=
 =?us-ascii?Q?Y1tibfo5UPzSBYWNLPBJ99fBvZq+ty0aRtTlEFVQnN28E7RgXuvfRqL+5w9X?=
 =?us-ascii?Q?qUQaEBgpMSTpMXnEpoEG7izDGZq5F3VWGGyNvc6e8OigFTtI19zGKs1q12GZ?=
 =?us-ascii?Q?2kBAiRxH7E/4RLhgAbPeR8ptvwDmYxs15zomqaiG47UnBMubzC8jCjIfJFPd?=
 =?us-ascii?Q?GKvD6pLP3IjNM9VaWO8OknxDrWpiHdrWskUFpodaQTe53HDiblwGOtVqvEd8?=
 =?us-ascii?Q?u4K9na22BS9uoV2L14NSf0OudoOOOe0Z8wEYQey5mC4onXe5e0wGXZiIWdqN?=
 =?us-ascii?Q?TF0JFFf0im+arJVs0AHmzDsOlGdRRnFQt8UrnHIWwefaLpV0evEMoumKklja?=
 =?us-ascii?Q?g6hqfUOlgXxLM0BLzIaRz51XdD6PnZm8Mmy8tMYRhUpG2AVtTjKN7c/PGBij?=
 =?us-ascii?Q?ty5ukHmmfsMc8RYNosHHngqZtAjtUj40u1EN9Hw+7AGkELA8vZDxCS1JCl/U?=
 =?us-ascii?Q?7io/7NUTZjc1kCRhhOku1wptRkYJnKC5LQgrEqvHQGLUAp9PlqOzyejNhsAu?=
 =?us-ascii?Q?lHOZHjnrv7evsghZUoLxnkKEcEQjwBYjxzxTiBGXk3sQsrKeL/c0OLMd3zZi?=
 =?us-ascii?Q?qcSH11/IB8KM+tlTl6QIAg7Do1pA+B0fW2wamvD10lV3cxC+V1zhGXgvkEHN?=
 =?us-ascii?Q?DGuynZkqDJHVWDmOXRQBdKgQmYaCy3dVJKGgMfL277aK3eWoiXLDqDW2lo2W?=
 =?us-ascii?Q?C8GbN5IGztE7lw/PtPmH7n5SrWY0NgmAx/eoUT+s3xCO9NPuAK/4HQebRr6V?=
 =?us-ascii?Q?IA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b54b8ea-641e-4584-be8c-08dbc4756a2a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 01:01:17.5875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bWXjhO3FH5Ua6MQ0vdo4ZoL4/tQPeEq1uDc7Y4uGqQwYVN1D9u9N9fH+uvSwBKmHNhZbfoexQVi25Y4b4Iet79UO5mmBLtXJQOvUJbau5U8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7525
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Davidlohr Bueso wrote:
> On Fri, 29 Sep 2023, Dan Williams wrote:
> 
> >In preparation for fixing the init/teardown of the 'sanitize' workqueue
> >and sysfs notification mechanism, arrange for cxl_mbox_sanitize_work()
> >to be the single location where the sysfs attribute is notified. With
> >that change there is no distinction between polled mode and interrupt
> >mode. All the interrupt does is accelerate the polling interval.
> >
> >The change to check for "mds->security.sanitize_node" under the lock is
> >there to ensure that the interrupt, the work routine and the
> >setup/teardown code can all have a consistent view of the registered
> >notifier and the workqueue state. I.e. the expectation is that the
> >interrupt is live past the point that the sanitize sysfs attribute is
> >published, and it may race teardown, so it must be consulted under a
> >lock.
> 
> That makes sense, but this is currently under hardirq, so we'd need the
> threaded flavor instead to take the mutex.

Yes I missed that, will fix.
