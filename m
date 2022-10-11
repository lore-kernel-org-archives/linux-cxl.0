Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7398C4332F
	for <linux-cxl@archiver.kernel.org>; Tue, 11 Oct 2022 17:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbiJKRGo (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 11 Oct 2022 13:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiJKRGm (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 11 Oct 2022 13:06:42 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA15132A96
        for <linux-cxl@vger.kernel.org>; Tue, 11 Oct 2022 10:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665508000; x=1697044000;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Z9eArLJIR0opb2Se+hLYafuXCSpm9O6I6jO7yujmRcE=;
  b=d34LWlppp70Zl6OiG4ZqrTpfBKVWk1W+48vxLxkSoiI32eckGMC8Qvds
   ZwdrIS/w74SUvZ/YMsi2xJVpNP70pckBUitBD8ZTsnDA/hb4+zgvL3X5E
   cAhbQ3IUh48/noTnubdvRPWmYKKOCNuy/22V4dc3v20rulbIDV8ulM4++
   yIHS62sPf7vI8R1pbEtSxUvNlZqRyT0d1GEHXmAwrkrpPMZJyWd7XvoFz
   rPtHdiKnxhFqJrtwIaS4vO1CIxK8Cgry9RDZiSNORQa1GpYAyen5lY9Pg
   HRe0rqqHddahTVMD6/PbzrpA7z8AvLAOSKPxlmpiJEnHAN9PX+kqHzMZo
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="368734785"
X-IronPort-AV: E=Sophos;i="5.95,176,1661842800"; 
   d="scan'208";a="368734785"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2022 10:03:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="628773549"
X-IronPort-AV: E=Sophos;i="5.95,176,1661842800"; 
   d="scan'208";a="628773549"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 11 Oct 2022 10:03:39 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 11 Oct 2022 10:03:39 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 11 Oct 2022 10:03:39 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 11 Oct 2022 10:03:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CLzwn5XmSLn16hl1rGDwe1oPPiBRIUlVGFJc2hVJbwQqLvsoPoCkCos8rV6CDoX35L0S1O4DU8NzzfJkIqPqu7tH44Ra7wtBluBLKTQxGVkCKbuMjLnGUANfB+Y8q9vTuafzh+IHH/ZKVCYnuo/2hmgSEjf88DCZwyLP3J2SBeEN6zMAVab1dwgVJd0MPWWbcQWGpn4VHr6Q8KF++G+bCLVmN926HbVN4L1HLPTbSg0RC9d7ldRUFB+Ugj5q069BNGJS0GB2Q66LKdXZh23Bf7Lvtp/G3p3uBTbiFwS4E2Lcv8GhzAA5pkzCNHlUkSgcejIKxbNxNHAiOBFrum/Izw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v87S7U/yuMqVf0fzzSMmuiBQDBhxPMEBaN9QDOOALtQ=;
 b=GAAGeT/yd8OaUs9Jo+648DCvH/fDNgYVQh4+r7ZcQRpw/zjOVPrEAQZWjybpZzo/BCZxtw9NtKUu7J8R0NyItAqQ9Jqh4o/2444BZNny8bXvt9h7YeU59CyF8JCmguKJxhRSrC2TU/jJ7YQfeTM3Oygz7tsGBlF0wm+iuFBdiKqBvvrFaRoCgESVW/GZXsE4ChoCMkKuYLM1kHptwFUMOzNqDl1GZbRI7mNH/2YAYRWPkUPhyHCIg+9pnTX5Xn2v2HLhjH18NCdCJdySTn0EjDsqX6AMTpAAoKfSlQk8MSDuJz5z8a3LYdtU+c66E740o/9xf+m0z2nIzeNBLLjUnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DM6PR11MB4673.namprd11.prod.outlook.com (2603:10b6:5:2a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21; Tue, 11 Oct
 2022 17:03:37 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6f83:c165:aa0c:efae]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6f83:c165:aa0c:efae%6]) with mapi id 15.20.5676.032; Tue, 11 Oct 2022
 17:03:37 +0000
Date:   Tue, 11 Oct 2022 10:03:33 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>, <qemu-devel@nongnu.org>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [RFC PATCH 0/6] QEMU CXL Provide mock CXL events and irq support
Message-ID: <Y0Wh5RS6XdzSHKoD@iweiny-desk3>
References: <20221010222944.3923556-1-ira.weiny@intel.com>
 <20221011104006.0000217f@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221011104006.0000217f@huawei.com>
X-ClientProxiedBy: BYAPR05CA0032.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::45) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DM6PR11MB4673:EE_
X-MS-Office365-Filtering-Correlation-Id: cbb5057e-305e-4108-6ecf-08daabaa89d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qm5E1XWuQ+IKP2ZSduJeh51DGHfugvXyfh7ZM+TTRi4l26EwUhof0wdftdQ+LtEDieIbb/6J8PslsKAXQUlfSGg6D7qy7INqQ/GU9MxMcesh6AXZBlr9r5xlabe5Puz5e5NqZEl7XwcN2wIQHVUleNLDDl5wAByGq/Z9Jjez9oUwMum1QVnI0YUzXF51aEDQJggxjfyIuJ0rtb5p2D5Gla52yMPovqhX6AGkpGuV5OpCNcFAWXN+sqa6wy0U+bs+JNwqzK4Tm7tsY17sFNoVOPHlIHylViIknKfiBSxGw3SwMXb0NsOVH9UZinjz5VXteYmp+uw+UJCPe3b4TQGEKthaIMAN4SxUd/hxI4jJA9B93VXzWSkI9HzsmdS8Q6KaOGEcZ/4m9LMz8H2uI3QyikMoKEPQtk22FG+ADpttyNurTEIiB+bnMm77O0lEwMcKCRm2psrgeFUE1cu+m4oCC06gWlRGkoTmZicWQYo3doFeOHNWOdDP1Nj8IpYhtCnGWp2Lms7MZxdPx+uAJ8uqsKIIwXMO38Ez0AARz83nh5ccssj84ab7do67fmHEnXBOVYWT9Wwd0EzyuxZUz4lvt7jqTcvuWukQidrcV+/21hpQ28AwyX1ZdjuAfWZSQQBEOL1va6PWLxdZd3quJR6EytHlzvL0+jNiEWqdC7vaGGVEXUYsbcci34fm7AVsq0Gz6NR0S+h1nRQw9A5fq9qopLAtd/V7Chb223pHiys4lBM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(39860400002)(136003)(396003)(366004)(376002)(451199015)(38100700002)(6486002)(966005)(82960400001)(478600001)(86362001)(6916009)(54906003)(26005)(186003)(316002)(41300700001)(83380400001)(6506007)(33716001)(6512007)(2906002)(8936002)(9686003)(44832011)(5660300002)(8676002)(4326008)(66946007)(66556008)(66476007)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IMrMegNhB3ivHGdx7tAeaeXuK42EZMN9AdQ/xO2RltDLAJMKikSA3syNVlcq?=
 =?us-ascii?Q?tQwwYujV0nXel27oPRdQIJUdgkJ9L3SVu7nWFRr1TmPxlaIWXgGm/rcUTHZG?=
 =?us-ascii?Q?miaE6Pp8gZZJSs45Ns0mBKd1x2FV2rKzBLTyjgSMEdzlUgi2hBfmpHrSyQup?=
 =?us-ascii?Q?agmjHxEK73ravlPpTq5BIuFMujOxWhgfFW+GrjFJaKxfFo35M+ZAUcwhXs2r?=
 =?us-ascii?Q?DXRp8kr6p9krltaBdA+EpOLdxAjrdsZ2qYIjDgBSHwEjsTakQvfZpEfSAZTR?=
 =?us-ascii?Q?tJrKV/YKiX3pKDrmGhu6s/b1zcJVGGIUDgL46I03oWlsAy9fCkP+TwIjjKd/?=
 =?us-ascii?Q?5gu0JAE3QTZcku1kmbFysIy8ZR9tbzfm8X9ZqyRm4DsaTrt2xK/bHas64zYP?=
 =?us-ascii?Q?vmLUM8VBeXxKciM4+ZkEcHYwoRcbg7p3OYZ1YJIbOzA0IRh4rGBD5fgguwpr?=
 =?us-ascii?Q?1MeO1OCFDoYEC2fVEy1+PuQVY2HbqeZx+Glp62atzEftRqzN1EJrjzxf7H9u?=
 =?us-ascii?Q?nSOoCdXsdSPkpJXAxTCwhYdgGiZhk+IPebPFBXI6ROfOY/ab2ta6uzgUAjn3?=
 =?us-ascii?Q?5giZIpQ11nTBYtO8esMAH7+61ZKF3fBUbGAnKZYoRNMQgt6C8vgdy+luFRYB?=
 =?us-ascii?Q?NP6EtYVsHRN6c9pGfsxDVe3fDkdnrVHlzEULu+HRYCohQrYdTGMQNVJvt5ZU?=
 =?us-ascii?Q?ADZcprR3A80v7NdNsFA1zTU7HgLK6vi3+iaJEnci0Cz6GdmRhQuE7BfcESEY?=
 =?us-ascii?Q?aPXrfHIyZakzaZQEkW2pWqsmlIP35Wc/sAvMbvl00uwCwJwEUV5Biqn4tN19?=
 =?us-ascii?Q?62XBujejkMvmhstSax2n3lthCTqq+Oxa4z0lKbimgykxrzbbZSpqb/S5cxpK?=
 =?us-ascii?Q?QnHInRyAPqIUgoTem5oGi5IS98oFzEGANCTS5unCiqdKmcv3X7qalfX93TkL?=
 =?us-ascii?Q?qGN99VRfCYaSMaDrY5Med/yFTj2OvauDBIdt3xCXIGt2qQoh1TBGTWd2HJg7?=
 =?us-ascii?Q?1+AtGRf9GJZvPhrZZNYwnBGG8sRZ/RJuWO18Y+IruiiHlSNOgmIc1ZJaoCsB?=
 =?us-ascii?Q?fjvW7p/Vz1vlkZtwrc2Pj6BZrUfo+jgk4Um8VjaPg0kqUFt+8E/wnBeCDaZN?=
 =?us-ascii?Q?6nIXtmJuAOVsiwNGCNgFZ7XOT3kFcYw1Mjpv0tVFIBctPYu4/+S22tMp9xpv?=
 =?us-ascii?Q?XRX+Z5F7f0KgYQvFdA0l9UN5R3iahZo/lCUowcoitCOYKeTtZruC18ru/C1J?=
 =?us-ascii?Q?YrpJUGsFBFzP21cTYlx+/gwiPtyvBSvayFP936vAeABsfsfBK511ceyEkUeD?=
 =?us-ascii?Q?YDGjYx8AMGeHzpaMn12fnTtVQ1JDLILMGW6etNmGliSpuYHPRNJaE2+iUbHe?=
 =?us-ascii?Q?7ayRxLE2M3tRYRuxqkmQ7YNdYDBULgbwMlTRYPG7d3tHuwtxjAqPZyT7cSUR?=
 =?us-ascii?Q?BsxFyIiHoNqGyXHZyRCYsM4nF3dcNuaM8NA/R65pyzftcrSLu4QNWlt3ltPu?=
 =?us-ascii?Q?LsRYlSIJvdY0MnUYXUXpYSxcxRMuAl1Ad1fc3P2y8hayY33sXujt2T037riI?=
 =?us-ascii?Q?6GTW1gxf+o8+wdwoO5HoW6/Jx74ru31Z7bOAqFwH?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cbb5057e-305e-4108-6ecf-08daabaa89d2
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 17:03:37.2812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kxvr+PM0Axk1kc1St6AZvUMBoS86x+d+QfA0OoDyjx2E9msSNFHoSm5zXNOS9He1WzkD+02SsL5ISpwCSUVT0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4673
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Oct 11, 2022 at 10:40:06AM +0100, Jonathan Cameron wrote:
> On Mon, 10 Oct 2022 15:29:38 -0700
> ira.weiny@intel.com wrote:
> 
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > CXL Event records inform the OS of various CXL device events.  Thus far CXL
> > memory devices are emulated and therefore don't naturally have events which
> > will occur.
> > 
> > Add mock events and a HMP trigger mechanism to facilitate guest OS testing of
> > event support.
> > 
> > This support requires a follow on version of the event patch set.  The RFC was
> > submitted and discussed here:
> > 
> > 	https://lore.kernel.org/linux-cxl/20220813053243.757363-1-ira.weiny@intel.com/
> > 
> > I'll post the lore link to the new version shortly.
> > 
> > Instructions for running this test.
> > 
> > Add qmp option to qemu:
> > 
> > 	<host> $ qemu-system-x86_64 ... -qmp unix:/tmp/run_qemu_qmp_0,server,nowait ...
> > 
> > 	OR
> > 
> > 	<host> $ run_qemu.sh ... --qmp ...
> > 
> > Enable tracing of events within the guest:
> > 
> > 	<guest> $ echo "" > /sys/kernel/tracing/trace
> > 	<guest> $ echo 1 > /sys/kernel/tracing/events/cxl/enable
> > 	<guest> $ echo 1 > /sys/kernel/tracing/tracing_on
> > 
> > Trigger event generation and interrupts in the host:
> > 
> > 	<host> $ echo "cxl_event_inject cxl-devX" | qmp-shell -H /tmp/run_qemu_qmp_0
> > 
> > 	Where X == one of the memory devices; cxl-dev0 should work.
> > 
> > View events on the guest:
> > 
> > 	<guest> $ cat /sys/kernel/tracing/trace
> 
> Hi Ira,
> 
> Why is this an RFC rather than a patch set to apply?

I really just wanted to see what people think of the over all idea.  The
patches themselves stand on their own if the QEMU community is ok using QEMU as
a test vehicle like this.

> 
> It's useful to have that in the cover letter so we can focus on what
> you want comments on (rather than simply review).

Yes sorry,
Ira

> 
> Thanks,
> 
> Jonathan
> 
> > 
> > 
> > Ira Weiny (6):
> >   qemu/bswap: Add const_le64()
> >   qemu/uuid: Add UUID static initializer
> >   hw/cxl/cxl-events: Add CXL mock events
> >   hw/cxl/mailbox: Wire up get/clear event mailbox commands
> >   hw/cxl/cxl-events: Add event interrupt support
> >   hw/cxl/mailbox: Wire up Get/Set Event Interrupt policy
> > 
> >  hmp-commands.hx             |  14 ++
> >  hw/cxl/cxl-device-utils.c   |   1 +
> >  hw/cxl/cxl-events.c         | 330 ++++++++++++++++++++++++++++++++++++
> >  hw/cxl/cxl-host-stubs.c     |   5 +
> >  hw/cxl/cxl-mailbox-utils.c  | 224 +++++++++++++++++++++---
> >  hw/cxl/meson.build          |   1 +
> >  hw/mem/cxl_type3.c          |   7 +-
> >  include/hw/cxl/cxl_device.h |  22 +++
> >  include/hw/cxl/cxl_events.h | 194 +++++++++++++++++++++
> >  include/qemu/bswap.h        |  10 ++
> >  include/qemu/uuid.h         |  12 ++
> >  include/sysemu/sysemu.h     |   3 +
> >  12 files changed, 802 insertions(+), 21 deletions(-)
> >  create mode 100644 hw/cxl/cxl-events.c
> >  create mode 100644 include/hw/cxl/cxl_events.h
> > 
> > 
> > base-commit: 6f7f81898e4437ea544ee4ca24bef7ec543b1f06
> 
