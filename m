Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C070C7EE37
	for <linux-cxl@archiver.kernel.org>; Tue,  6 Jun 2023 20:54:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238494AbjFFUyw (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 6 Jun 2023 16:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239062AbjFFUyr (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 6 Jun 2023 16:54:47 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C179D1707
        for <linux-cxl@vger.kernel.org>; Tue,  6 Jun 2023 13:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686084886; x=1717620886;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=bcSbLvB8dGZIPzwY5aU+rmrQj3lz63pzNNTIvHDAs3s=;
  b=Q4i51h82UfQbvB7FmOPipH8sYdPe6vKBfhK3QHsiZnRB1z2x1fz5hsrr
   BVuv+ONMRsRoq0oLRNANeYZY+bm+q/YdEvx3VDe8SGmSFWloPngvW/tiC
   clm5PCQUq2XZUrHZ0HUgvx7A13ga3fBZJYmv0cJoweQX3aIG20vOoNwS6
   IpGcmGwQbo4Ks3xqUgaZ9ApT8Ap8meT5aVaycFjhjV6oJ1TeT3Ylp5o/I
   GCZHiz/ANUpDdtSjZ8cved0UPwPjkYbrZ/yA/svxsVu/gB3ServIjNzI3
   4Lz7odmdOmMtiAWTJ4/kj2jDDhG7X6Iszy3TU4u6v3DwqH3sqLpll1AZj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="346401712"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="346401712"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 13:54:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="703346681"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="703346681"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP; 06 Jun 2023 13:54:42 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 6 Jun 2023 13:54:42 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 6 Jun 2023 13:54:42 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 6 Jun 2023 13:54:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nVqSxT8VyKQtSbsYdSg7Zq96zvhgOXqvo57KSQKzVfCPhGryfFxMNWpmAifcvucnXs8zodg5xt9nXJkWZ8bMW8ldlECkSzm4v9A/JTRGVw/fQcvvq5IV4qlr6w277yMP41noqmlaOOKiR0dftTDvBA5BzpiBBmK6u63YkouMS5TNi0+xIIJaqH+f4jb/4wqDbPUrlNcvFzj1s7wvXVdQB3hfZWIXj5oveV5jpH256rqLMY/XCenJBMpXrjbwSgSMcjrsUlrcqR7ZYYOv22jvc0WCoocpAK62Xz52i4fFXuhZ7vhVvtCJ1Q5/zaLHFrthrnNtI3gJxv1QgxF51l3f0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wJzv3V7HnKHiMZQwwD2hcFuLq1TiFPX8Ud/5Zy/K2mI=;
 b=T4k+UZ6OJ6gm6QYIlMcKfqJy5SHxTrtI71KUZ73WZkbo7RtFJTd34zKkha94bBplHiYjwKQsI54wl5nOdmw+BHfz2Pephmp309jR1uHHYVrAmTPkn1toIaXkhnn1rkZUbrZmG7Hf1BhHvw5vvKDYOdZ6nSsA+z5tcSF2s44/lEYCCOTAH8FPIVVvZSy4OmlLS1e5cSNEgOlbr+JfA4Kll7LaAUfSJIWp3JUzmy5tENSxRnZC7LVvD/CO9Ai6KnP2xAnwicmLNSPS/g3nQ4wHCeod9pv+4hhzZJY1gi8H0nmIe78cxwhj3tHZB5BQlluTv0KCYD9SJF1spW6wYAAE3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM6PR11MB4692.namprd11.prod.outlook.com (2603:10b6:5:2aa::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 20:54:34 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%5]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 20:54:34 +0000
Date:   Tue, 6 Jun 2023 13:54:32 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Vikram Sethi <vsethi@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "catalin.marinas@arm.com" <Catalin.Marinas@arm.com>,
        James Morse <james.morse@arm.com>
CC:     "Natu, Mahesh" <mahesh.natu@intel.com>
Subject: RE: Questions about CXL device (type 3 memory) hotplug
Message-ID: <647f9d082eb30_142af82944e@dwillia2-xfh.jf.intel.com.notmuch>
References: <TYWPR01MB10082116669BA002263DF132A90439@TYWPR01MB10082.jpnprd01.prod.outlook.com>
 <646c04bbbd96_33fb32944b@dwillia2-xfh.jf.intel.com.notmuch>
 <BYAPR12MB333685D98C43D5247BEA998EBD409@BYAPR12MB3336.namprd12.prod.outlook.com>
 <646d0892eadc3_afb77294cb@dwillia2-xfh.jf.intel.com.notmuch>
 <BYAPR12MB3336AB6A519C709DBEA75CB5BD419@BYAPR12MB3336.namprd12.prod.outlook.com>
 <646d8c76811cb_250e29456@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <BN8PR12MB3330831F2E666E9BB1319E66BD419@BN8PR12MB3330.namprd12.prod.outlook.com>
 <646e7f96f33e2_33fb3294c1@dwillia2-xfh.jf.intel.com.notmuch>
 <BYAPR12MB3336F5ADDEDBB6245BC2B48DBD489@BYAPR12MB3336.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BYAPR12MB3336F5ADDEDBB6245BC2B48DBD489@BYAPR12MB3336.namprd12.prod.outlook.com>
X-ClientProxiedBy: SJ0PR13CA0094.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::9) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM6PR11MB4692:EE_
X-MS-Office365-Filtering-Correlation-Id: e5569a5f-a8da-4f7d-ac6a-08db66d03b73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Aeh91qj9FzmhhBSrf+MTO7sAgIPhfU2nDT4EV5HToOx4+w1FsPnGm8aHEXc1q2+RdSlqKXbLhcMy0TfwakhC/NdeUxDNMb7awauQlxCgn7tdeTc5TQoDPdRPlDfKUo45eSVe7T+vZrvnlnE/WQh6GPq1e5eIicIzWBW0dciB8m6RTHFW7MVWKNXNukFdcSQ2Aynmak1roKr27TrH/fgCdrPE3KiC43eWaonDLlDluGl45cruXv2Hwa/7G7D4BBPCCQMnWPPUIJF1dWmxUeStr/K96cGSrYd2vER/GLhEj+6L2AU32K6Crz7h1iMvYy1RmGqSJdY7Dn23U3Aoxwni4m8R+Y5wHLs03hj6Lc32sHMuqavJC/pG/b6Ex7Hyj3vQZDfHzduM5pm+9uv3qpCaCQYzTMjHnFB/1hkaseIpdHz8IjBGlhVDnEGByK2E6PVWh5xTYsUQJJ3ggivCE5bHZDvHTdvgSEh6++wrQjtVOFkaUnWBu0At6N2WgQHI3L8YPDZ+6sA6g/Uzyye44DoVff4N12mzBseCE7S7VWopqMaaCAhShgEvD9IvdSnashl4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(39860400002)(396003)(366004)(376002)(451199021)(107886003)(186003)(6506007)(9686003)(6512007)(26005)(53546011)(83380400001)(86362001)(6486002)(82960400001)(2906002)(8676002)(8936002)(110136005)(478600001)(38100700002)(5660300002)(4326008)(316002)(41300700001)(66556008)(66946007)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cPkCvttC3RaJsF4h3gCAV0Kb2Sif+l6qYR39l5UIJQWowhoZKk3nVp2UzuMH?=
 =?us-ascii?Q?LBC3F0ofNjTt4pwuBqHyPnUJ8Yfgq4231OBaHA6y+cQIgrUjTU/ymcODDgjt?=
 =?us-ascii?Q?YJD/5as6zjPT2VPK28M4cJNBqnNMK8ImAwFGCLKkC8qqiQbo5sEJ1oqCPtiV?=
 =?us-ascii?Q?O1Zqh2uNYBGe7eRnmy27w1vfaY3VyN+pWd8t5z06YtoQJ8fHKEK31sMaYmwh?=
 =?us-ascii?Q?fK8LOXmrdzcy63DUmxOf9k9jHeMBITjhE7TD4dQUuUEYefYrjj0YlgbIV1rN?=
 =?us-ascii?Q?Vz9Yv0sHRmqs5+Vg9/HCJ54VJhuRU+h+78h6ygWz1gGXtXiiA6xxk4rVfD6u?=
 =?us-ascii?Q?EPcAPe1SQcz6zpJm9/OMBm2GuyPINqPWhxNM2pNL4Uhg3y90O7KiNYyYaLAG?=
 =?us-ascii?Q?tZZZJyMShO/IoGKno69nVQFije2mQUj5Qlxpl/NfJwqQKF+r7QKA35xq+ojK?=
 =?us-ascii?Q?zl/KakxbRJ2AOm8bF8Z/SMCiAPx6OfJfjudf8Po2ib/vYVRLx6p2TY6ErYy0?=
 =?us-ascii?Q?f/tJhm+m/C2Rat/g9juI95JYYrahNj49kT1CwWj1BUDnMsup/0g+5Xy4lfL6?=
 =?us-ascii?Q?2q2FGRd3Ux/RedOuFiWqDoji9JzIvO4T60kw2iboIB43rY3P4Dfj5J830SXs?=
 =?us-ascii?Q?JO0atebSLmaQInPs91ixL9ed6AxHD7KTnfG6JwbIRmW7YqQZTBsrabbs2rtp?=
 =?us-ascii?Q?V3bKRKrfiylTv1hHod+wgFonQpENIBCRZ3bGSUTlWfmI5il/Xqr9PQVEsrqy?=
 =?us-ascii?Q?CLj0HRLJYUOYw/vGv9Pxi2ZL+u/rKZhusp5YZkwkDo031ABmh3axTndJJXf6?=
 =?us-ascii?Q?A3gOEzZPB5OM2dzlSt8UH9oJaWfx8CzaWIn3U3aa0Mmj5USYZ103RDthSdIS?=
 =?us-ascii?Q?243vHQpeO7EuCXvr4Ds0fXIB6zZY1McWU2INvqz23Rb6pxf6AlGLS0PqwNwD?=
 =?us-ascii?Q?Nh1plfqB8dHfNF0mJHQZWCPjp14oDHH+E6tjRzKFd6e3TyBPaG9Aqr6eS4gw?=
 =?us-ascii?Q?PIC1+iIJctpOt1pEXUG4Zm4WBFCpWxuYlTYbwIxnLEH1GDP1N7PipX32YfaE?=
 =?us-ascii?Q?kpUy8FFfRR4icyJ73SLIVD+JgMIlzmcl7/qoj7UslNtzn/IEzLXoT2hK2oBl?=
 =?us-ascii?Q?qunJnmeNZ7bEOvKfIstUjHHkhd1XHKVyLcbz/iYc/Hbv2lbZcrCN3r/CyW9T?=
 =?us-ascii?Q?7Kt7DvgRozy/KX7Y0G9V3q1gq5QNSh3DBlhzwgYytKtfNeXd228QpgM0KNty?=
 =?us-ascii?Q?Jur4C5uOCEofnRXBMKFsy9GyhJqq/fLubHm8/EUE73ZyC6HVSa5XSb6VFcPJ?=
 =?us-ascii?Q?Sun89ALF5PsStiO8YgX1PlLGBOc0jOOQ5zL+b/0rAL0BqtFaEkL100jurFNc?=
 =?us-ascii?Q?gp9FoiXwj2OSkFxl+4ReqsM3bXF51FbTpI4nWM9cMDMemoeGC6W4+vRFKMEZ?=
 =?us-ascii?Q?LxiP6CeK5MpVSrF9ZG2xBz/BmD0R80QgMXeF7tlv8TJtElfP3AEMenimt5Ss?=
 =?us-ascii?Q?HYQAu0xo9ruHWX5HLtXMfdKrJ1146hPFIxyn2ZpQJhqxwWsXRDutDawGzNov?=
 =?us-ascii?Q?D4ncj8sfCZUm48nZVH9ZHjQwBJmYK0Eaczr2A4w4p4RQDN2PdxM/cyU5v0pf?=
 =?us-ascii?Q?oA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e5569a5f-a8da-4f7d-ac6a-08db66d03b73
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 20:54:34.1902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Jix+KEVyhUweQuGJ+c9+dOiFn3sFPzmNCT8YxNMTy62mMFXKPpsZE1ZzFT4Qq6DRUvoHlh6i0kEd0yUsZCGOozGKmcFVtGz5DWUX10cvu0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4692
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Vikram Sethi wrote:
> Hi Dan, 
> Apologies for the delayed response, was out for a few days. 
> 
> > From: Dan Williams <dan.j.williams@intel.com>
> > Sent: Wednesday, May 24, 2023 4:20 PM
> > To: Vikram Sethi <vsethi@nvidia.com>; Dan Williams
> > <dan.j.williams@intel.com>; Yasunori Gotou (Fujitsu) <y-goto@fujitsu.com>;
> > linux-cxl@vger.kernel.org; catalin.marinas@arm.com; James Morse
> > <james.morse@arm.com>
> > Cc: Natu, Mahesh <mahesh.natu@intel.com>
> > Subject: RE: Questions about CXL device (type 3 memory) hotplug
> > Vikram Sethi wrote:
> > [..]
> > > > I don't understand this failure mode. Accelerator is added, driver
> > > > sets up an HDM decode range and triggers CPU cache invalidation
> > > > before mapping the memory into page tables. Wouldn't the device,
> > > > upon receiving an invalidation request, just snoop its caches and say
> > "nothing for me to do"?
> > >
> > > Device's snoop filter is in a clean reset/power on state. It is not
> > > tracking anything checked out by the host CPU/peer.  If it starts
> > > receiving writebacks or even CleanEvicts for its memory,
> > 
> > CleanEvict is a device-to-host request. We are talking about host-to-device
> > requests which is only SnpData, SnpInv, and SnpCur, right?
> >
> I was referring to MemClnEvct which is a Host request to device (M2S
> req) as captured in table C-3 of the latest specification

Ok, thanks for that clarification.

>  
> > > looks like an unexpected coherency message and i Know of at least one
> > > implementation that triggers an error interrupt in response. I don't
> > > know of a statement In the specification that this is expected and
> > > implementations should ignore. If there is such a statement, could you
> > > please point me to it?
> > 
> > All the specification says (CXL 3.0 3.2.4.4 Host to Device Requests) is what to
> > do *if* the device is holding that cacheline.
> > 
> > If a device fails when it gets one of those requests when it does not hold a
> > line then how can this work in the nominal case of the device not owning any
> > random cacheline?
> 
> I didn't understand. The line in question is owned by the device (it
> is device memory). The device has just been CXL reset or powered up
> and its snoop filter isn't tracking ANY of its lines as checked out by
> the host. The host tells the device it is dropping a line that the
> host had checked out (MemClnEvct) but per the device the host never
> checked anything out. Seems perfectly reasonable for the device to
> think it is an incorrect coherency message and flag an error. What is
> the nominal case that you think is broken?

The case I was considering was a broadcast / anonymous invalidation
event, but now I see that MemClnEvct implies that the line was
previously in the Shared / Exclusive state, so now I see your point. The
host will not send MemClnEvct in the scenario I was envisioning.

> > 
> > > Remove memory needs a cache flush IMO, in a way that prevents
> > > speculative fetches.  This can be done in kernel with uncacheable
> > > mappings alone, if possible in the arch callback, or via FW call.
> > 
> > That assumes that the kernel owns all mappings. I worry about mappings that
> > the kernel cannot see like x86 SMM. That's why it's currently an invalidate
> > before next usage, but I am not opposed to also flushing on remove if the
> > current solution is causing device-failures in practice.
> > 
> > Can you confirm that the current kernel arrangement is causing failures in
> > practice, or is this a theoretical concern? ...and if it is happening in practice do
> > you have the example patch that fixes it?
> Yes, it is causing error interrupts from the device around device
> reset if the host caches are not flushed before the reset.  It is
> currently being worked around via ACPI magic for the cache flush then
> reset, but kernel aware handling of the flush seems more appropriate
> for both hot plug and CXL reset (whether via direct flush or via FW
> calls from arch callbacks).

Makes sense, and yikes "ACPI magic". My concern though as you note above
is the cache line immediately going back to the "Shared" state from
speculation before the HDM decoder space is shutdown. It seems it would
only be safe to invalidate sometime *after* all of the page tables and
HDM decode has been torn down, and suppress any errors that result from
unaccepted writes.

I.e. would something like this solve the immediate problem? Or does the
architecture need to have the address range mapped into tables and
decode operational for the flush to succeed?

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 543c4499379e..60d1b5ecf936 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -187,6 +187,15 @@ static int cxl_region_decode_commit(struct cxl_region *cxlr)
 	struct cxl_region_params *p = &cxlr->params;
 	int i, rc = 0;
 
+	/*
+	 * Before the new region goes active, and while the physical address
+	 * range is not mapped in any page tables invalidate any previous cached
+	 * lines in this physical address range.
+	 */
+	rc = cxl_region_invalidate_memregion(cxlr);
+	if (rc)
+		return rc;
+
 	for (i = 0; i < p->nr_targets; i++) {
 		struct cxl_endpoint_decoder *cxled = p->targets[i];
 		struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
@@ -3158,8 +3167,6 @@ static int cxl_region_probe(struct device *dev)
 		goto out;
 	}
 
-	rc = cxl_region_invalidate_memregion(cxlr);
-
 	/*
 	 * From this point on any path that changes the region's state away from
 	 * CXL_CONFIG_COMMIT is also responsible for releasing the driver.


