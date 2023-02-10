Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 426C6C05027
	for <linux-cxl@archiver.kernel.org>; Fri, 10 Feb 2023 08:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbjBJIMg (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 10 Feb 2023 03:12:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbjBJIMc (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 10 Feb 2023 03:12:32 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7275623651
        for <linux-cxl@vger.kernel.org>; Fri, 10 Feb 2023 00:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676016730; x=1707552730;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=96x+qQjuSTNdLTGfAIcWuqlCBr2zCkW4CU8HwAQCAW4=;
  b=dM5vHlmZq6N9NkZSDQ8CxlQYjR480bbB2goAu3gYy8Z+Fy5pDcpwNvLl
   fO4ZkxJYWHivunUXBXvCxBOWsami498jUE+AWGwc6xb8iApXzX7YJs7gI
   ZX6H1xP1MXCJ7Bx+IB1CCnStFxAXMIWFypg1U4sGHiln39FzjUwMIOdq2
   J0D257v8oPZyKNHyUXwpHI5xFPwBp2u0VGek5rH4RkdG7TAGljqq8z0/N
   pLpnIKIe008XtdwYjWTDxGqxeqaWFUQUJ5g5QIaoKtskgfdS6OcBm3rKw
   r6qMLEGnbViA2drnJ1dVo2lP0biZdZ/t5GX6DWac2qGQW0vw5JDnebrAM
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="309997470"
X-IronPort-AV: E=Sophos;i="5.97,286,1669104000"; 
   d="scan'208";a="309997470"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 00:08:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="791883589"
X-IronPort-AV: E=Sophos;i="5.97,286,1669104000"; 
   d="scan'208";a="791883589"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP; 10 Feb 2023 00:07:55 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 10 Feb 2023 00:07:54 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 10 Feb 2023 00:07:54 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 10 Feb 2023 00:07:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JEWrkyIPCJQkB6wZoN8VySl4xkNsJ+t78ogfrmRYSkRRXKXaTB2KwtrksjvPnBH3MD+f0jwAR+VJWu9QHPTETVgqsJGW41yEkxz4HHkChy+H6euEVT1hyDp2ZDY+D8yrb3/u8IjUCLrbZmsW3Q/1QH1RDz0JOvr7LRSqh+oiIHvWrH7oDVXQHEy4fNVeHRZV84pMUcr0CD6eFUnjTmJzQH7bHeaKfbhSLpI7cU1kOyXt1usObfz0SpY5uR4qpC5izsI/kspS3Vw4vdoWw3Zr2LCXIm+e5Q6TaYX59xgShkCAKDcf5bhKexlaONcu6z1FZyLRgcD/ILi5DkbhKTfrAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0eW5m3OJVYqB7bPHG2FY1EOkMgM+jz19ZKkAgyGrgDI=;
 b=KSGPln7he0iiswV4HtxZ/mE2U9PRZDOytlEq7vI6gERZeW94vQTY3N/U8x9wBkh62PofBm/qZLC3iHixsQBPCtpFsqo/NnG4toQ8Giqj4pMywdpKFNTgmEjLQZy7F7UcM25rF7iUIu6TwNCScvc4fkoX/ienEsBPyyiuKfq1l92iPKgHQS2So0IuyzTkwY6H8ikzZncG4Ona0W1FrkP2UFeC+bg0znOilhZEhMgASV5J6msLrIBuAeBcn6SakITbW0rtnKOHVP7kdQM/Oh1EGYIXxShSAzX8ZvdklAq8SEUL0qW3VBnEMhsZrpMesAx2xFpeCYtGDuYo03SbWpti/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH7PR11MB7605.namprd11.prod.outlook.com (2603:10b6:510:277::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.21; Fri, 10 Feb
 2023 08:07:51 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6%9]) with mapi id 15.20.6086.019; Fri, 10 Feb 2023
 08:07:51 +0000
Date:   Fri, 10 Feb 2023 00:07:47 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Bjorn Helgaas <helgaas@kernel.org>
CC:     Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
        <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, Stefan Roese <sr@denx.de>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v5] cxl: add RAS status unmasking for CXL
Message-ID: <63e5fb533f304_13244829412@iweiny-mobl.notmuch>
References: <20230105163127.00005ae2@huawei.com>
 <20230105165406.GA1150163@bhelgaas>
 <20230106112605.00006cf6@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230106112605.00006cf6@Huawei.com>
X-ClientProxiedBy: BYAPR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::24) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH7PR11MB7605:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a4198b0-85da-42b9-654b-08db0b3de79b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SQD1tsZasbISgwsdF3Qr7ysGsEqPPIaiTgpr68JpvkygQs3YbPc3XNgrz6Kra+dwwVRvef5mME4yl6rU+Z717V66lTlUBhuGz3vBLdtzhKx/pTRTmASSwI9D4n1hyykNHyyhfA/4ccik9sTj6QMkNYn0vSz7KRLmyq474DXiAlbBUaW9rNnPzDlIbtAgtD8j1/k9oHcMlgjEzRSk9LaWBC1HzWWSa3wjLTbaRHt/WOS4hOY3gUlwtdOewjHJn0oERTrjHDlS2xQZc41CY16ERUp5E3SHsIT46uTRf1XT0mVts7hvui8gGitUGKocZ7UgiRfwXZ03p6V0sgyZraU2mLp2cbjCG2jSpTQjWEykRUs7HEGVXybAMZTeCNpVmSzu65gQBKtuWMTtIWtsWc8QuTwDqdvf8Tj4SND4xEBWvA7or1fFeyiYmkn+JvybQi3muoE9TfBPzj07CIjKR7zdRXkdqpLqcXd0uiIacFst0Qqav6M0bPGY72zGEyR2n2ohE7X+/d1z7SZmAMWAHnLEWToL5TH51DGu8wXd5VAEcHD4YAjgenHb3vrtQbKJILF5BiFAN1pnZL82Z4G9ciFPMak2CuDduGvKzyeL1dWCQUHiZS6IqF3ZRy2YeJQGp/wlc+ouz8xByqfPWHCV4/PE/eYb7WkFgb3OMy6QxTl/EutlfcsbzOuI7Ng0ORmFFImo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(346002)(136003)(39860400002)(376002)(366004)(451199018)(82960400001)(38100700002)(83380400001)(86362001)(4326008)(2906002)(66556008)(66476007)(8676002)(66946007)(8936002)(44832011)(41300700001)(5660300002)(6506007)(6666004)(186003)(26005)(9686003)(6512007)(54906003)(316002)(110136005)(478600001)(966005)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3KHPs9KG3ihMjojeXfdnLhadAkQeiSdjG+MYOC7ntYRbEOd6rTNF9psgvKXW?=
 =?us-ascii?Q?GmXvHIW/v3OAwxDkUbxxs34Y8pJnxNu+tRvQuPmcwWmOzvx8PjDfKI7UWPGe?=
 =?us-ascii?Q?EUg97U0xaR8xN0dIGhlALfUD3REJjBwG9pGla8XtVg9KF7yjy+E5mveC1/gj?=
 =?us-ascii?Q?FCl73UUwiC2rowKCtcfUQYIMKNpgfAiG5yRev7R1Fc1c3ePLw8JsRS+pepaA?=
 =?us-ascii?Q?aeRBK1g+F7Ik1EEKefqWdUC/xZm7v+tLzZZppB9VsdYjpqfYFVgE7vPEp4pO?=
 =?us-ascii?Q?UPlDX06CMfDK8fnOplyQqGdz+xdUYsqFxqlu4AYGXBE38iPc6KFvDxPhBAX/?=
 =?us-ascii?Q?o8jEPQvutR0DjBxOrlNhjLbJlSb19VsrOgQ8JbDwjMeVmQu9uB0cWvuYl9nt?=
 =?us-ascii?Q?SMAZ8z0DuU/P/uzoY2U6JuDjfUcRbLBiOWmapt3ouGO1Db0hFuICKA1W4pVC?=
 =?us-ascii?Q?Nttcny5DCKjhAnFp2n1MvoSpXJQZlt+gE4fqyhs3mUw1pJVrlOtmzO/DO/yJ?=
 =?us-ascii?Q?9v32cbGvMOdZ3kKzC/mP9L2iZoNK/NXCYX9p9tMB4o589I6mYYaGZt47MGS/?=
 =?us-ascii?Q?bzCgoKVoh3tSPaDb/74a8mw4EZxxjHPXUviaaKhsI1u8DLQxHvPfJBA0jAlV?=
 =?us-ascii?Q?3HWyl/MiCHIoihRImcnV+I3YF8rLcDvtT81cxQG+T4AYPQ9UbMtPUebQxQ5n?=
 =?us-ascii?Q?/0f9EwvMNuJE5HOSsqtfeB0onjGR0OP2mH39ePRctyi419p3AsAOxZcmlLbP?=
 =?us-ascii?Q?QTrbIXhwBUVUflFJc6/qqQjFcNGu6dONheplTXy+NAoYeiiD7Yckxc8yQ9r9?=
 =?us-ascii?Q?t4c3MLQJ/drSNIIg2qrHnUmskVUTe6FATOZVxnZP7m+2Ez3tJ87CkGQNP1PC?=
 =?us-ascii?Q?988oaR4aeLl4fLqUvx+hU19So6AoQneb2ViTN1GRMZ81Xd5+ow9mQFuYM/Mi?=
 =?us-ascii?Q?iyTMG6cubSFECy+RWtSRdKUb9CUZSmcxGlqXSnKgW+EzpezwgQlpENnBsoTS?=
 =?us-ascii?Q?mFQ5h66jza+2DsDOS5lVsQSTmJ6mih97cdbX0C2xbBF5ndZlmaUUPvWHN2EQ?=
 =?us-ascii?Q?pGaMBTX9LUAEuFARpZDRksPPE26d9AEa6GhVWk6dZ5Vs/+G3E1FmKCGUSMZu?=
 =?us-ascii?Q?Oqg8QNf2E11oLEokjotT26O2HR+Z2nIZU6ItHa9z9ymUcsPp/fxHmewS2eKQ?=
 =?us-ascii?Q?eNIH+gWGsDhyD7jTN9aPOrr9ml1UIrobev7BBUG9cmCYpePeq/VwZMyRQ9O5?=
 =?us-ascii?Q?Rw1sQ4R+a9yz9NY9zy4BQq1x7zHbLvTl8x6wPwygWysUeCziVIPWMwb4/9O+?=
 =?us-ascii?Q?p7cbTcbRt4AE1XdlqOamSgqyjySJeTNSAeBK7uaYSPgWWxwjRBCrxiCTmEJ5?=
 =?us-ascii?Q?U7SThg3ep+qYkqlWypLRvgUnSGoYwE3UsB1EWwvaPzBAbSUbc9NtvLbYMwtF?=
 =?us-ascii?Q?GepqYSAJm62x6yxMmoGdkICd09Q6hENv1TwaAFbcqMhyaxdwO/OsInzzdhrl?=
 =?us-ascii?Q?/d3ntt+lXt6ImTtz1xg2BB1NyGsWu71S/PL45xuXPtAWhiNTIfpU2zLtines?=
 =?us-ascii?Q?BfySUzDRg4/1m4cdZRl8bTNXVIsGe/qEEXMSlXjQ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a4198b0-85da-42b9-654b-08db0b3de79b
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2023 08:07:51.2031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kf+NKaIY4Da1NuUMojziQxWvPusTragb5+RFeloRX5+HmmaeHjYUkvrxzzcT5mMhivKoWwt2hjmAMe9AYOyVhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7605
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jonathan Cameron wrote:
> On Thu, 5 Jan 2023 10:54:06 -0600
> Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
> > On Thu, Jan 05, 2023 at 04:31:27PM +0000, Jonathan Cameron wrote:
> > > On Thu, 29 Dec 2022 11:27:31 -0600
> > > Bjorn Helgaas <helgaas@kernel.org> wrote:  
> > > > On Sat, Dec 17, 2022 at 05:52:04PM +0000, Jonathan Cameron wrote:  
> > 
> > > > > I realized that adding this patch still only enables error because I
> > > > > didn't check the PCIe spec when writing the QEMU emulation. I had
> > > > > changed the value of  "Correctable Internal Error Mask" to default
> > > > > to unmasked.  PCIe 6.0 says it defaults to masked.  For some reason
> > > > > I thought these masks were impdef (should have checked ;)    
> > > > 
> > > > I assume you refer to the AER "Corrected Internal Error Mask" bit
> > > > (PCIe r6.0, sec 7.8.4.6), which indeed defaults to 1b (masked) if the
> > > > bit is implemented.  
> > > 
> > > Spot on.  I keep confusing the correctable / corrected stuff in PCIe.
> > > Made more confusing by the CXL stuff layered on top.  
> > 
> > Great, it wasn't confusing enough already, so CXL rectified that
> > problem :)
> > 
> > > > We now have f26e58bf6f54 ("PCI/AER: Enable error reporting when AER is
> > > > native"), which turns on error reporting in Device Control for all
> > > > devices at enumeration-time when the OS has control of AER.  But this
> > > > is only the generic device-level control; it doesn't configure any
> > > > *AER* registers.
> > > > 
> > > > I'm surprised to learn that the only writes to PCI_ERR_UNCOR_MASK are
> > > > some mips and powerpc arch-specific code and a few individual drivers.
> > > > It seems like maybe pci_aer_init() should do some more configuration
> > > > of the AER mask and severity registers.  
> > > 
> > > Sounds good.  Any thoughts on where to get the policy from?
> > > Feels like an administrator thing rather than a kernel config one
> > > to me, so maybe pci_aer_init() is too early or we'd benefit from
> > > a nice easy per device interface to tweak a default?  
> > 
> > If we get a solid system-level policy in place and still end up
> > needing some kind of administrative control, that might be OK.  But we
> > don't have that solid system policy yet, so I'd like to push on that
> > before adding admin interfaces.
> 
> I guess next step is a straw man proposal for people to test / shoot at.
> I'll send out an RFC that enables the lot as defined in PCI r6.0
> as that will be most useful for identifying quirks we need to handle.
> 
> My assumption being people will push back on some of them / we'll need
> to quirk others.

Jonathan,

Did you send something along these lines?  I was testing the AER trace
point output while cleaning up the trace points a bit.[1]  And I ran
across the need to set up these PCIe registers.  Because I did not see
anything from you I was thinking of taking a crack at fixing this.

To me, it is pretty straight forward that if a driver enables error
reporting then it would want to include internal errors both correctable
and uncorrectable.  This allows for CXL to further control the CXL
registers as an overlay.  I'm not so sure about the other PCIe AER errors
which are default masked.

PCI v6.0 defaults to a fatal uncorrectable error.  I think it is probably
a good default to make these non-fatal when enabling the _reporting_ of
the errors.  If a driver wants them to be fatal then another call could be
added later.  (or the driver should be doing that on their own now.)

If I understand this thread, the CXL spec, the PCI spec, and all the code; it
seems like unmasking the internal correctable and uncorrectable errors in
pci_enable_pcie_error_reporting() are a good system default.  With the
addition of making uncorrectable non-fatal.[2]

That said, there are approximately 51 drivers which enable error reporting
with this call.  I'm a bit concerned with such a global change.  But
perhaps it seems ok if it is only enabling then internal errors as
non-fatal.  So at worse this would simply spam logs on bad devices?

Ira

[1] https://lore.kernel.org/all/20230208-cxl-event-names-v1-0-73f0ff3a3870@intel.com/
[2]

commit 30e6a0bf308e7b8c68b4da33b505fa967f6bbf34 (HEAD -> cxl-pci-aer)
Author: Ira Weiny <ira.weiny@intel.com>
Date:   Thu Feb 9 22:26:05 2023 -0800

    PCI/AER: Enable internal AER errors by default
    
    The CXL driver expects internal error reporting to be enabled via
    pci_enable_pcie_error_reporting().  It is likely other drivers expect
    the same thing.
    
    PCIe v6.0 Uncorrectable Mask Register (7.8.4.3) and Correctable Mask
    Register (7.8.4.6) default to masking internal errors.  The
    Uncorrectable Error Severity Register (7.8.4.4) defaults internal errors
    as fatal.
    
    Change pci_enable_pcie_error_reporting() to enable both types of
    internal errors.  Ensure uncorrectable errors are set non-fatal to limit
    any impact to other drivers.
    
    Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
    Cc: Bjorn Helgaas <helgaas@kernel.org>
    Cc: Dave Jiang <dave.jiang@intel.com>
    Cc: <linux-cxl@vger.kernel.org>,
    Cc: <dan.j.williams@intel.com>
    Cc: Stefan Roese <sr@denx.de>
    Cc: "Kuppuswamy Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>
    Signed-off-by: Ira Weiny <ira.weiny@intel.com>
    
    ---
    For all drivers other than CXL this is expected to at worse increase the
    error reporting verbosity.  Because the errors are set to non-fatal by
    default this should not adversely affect the operation of those devices.

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 625f7b2cafe4..9d3ed3a5fc23 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -229,11 +229,28 @@ int pcie_aer_is_native(struct pci_dev *dev)
 
 int pci_enable_pcie_error_reporting(struct pci_dev *dev)
 {
+       int pos_cap_err;
+       u32 reg;
        int rc;
 
        if (!pcie_aer_is_native(dev))
                return -EIO;
 
+       pos_cap_err = dev->aer_cap;
+
+       /* Unmask correctable and uncorrectable (non-fatal) internal errors */
+       pci_read_config_dword(dev, pos_cap_err + PCI_ERR_COR_MASK, &reg);
+       reg &= ~PCI_ERR_COR_INTERNAL;
+       pci_write_config_dword(dev, pos_cap_err + PCI_ERR_COR_MASK, reg);
+
+       pci_read_config_dword(dev, pos_cap_err + PCI_ERR_UNCOR_SEVER, &reg);
+       reg &= ~PCI_ERR_UNC_INTN;
+       pci_write_config_dword(dev, pos_cap_err + PCI_ERR_UNCOR_SEVER, reg);
+
+       pci_read_config_dword(dev, pos_cap_err + PCI_ERR_UNCOR_MASK, &reg);
+       reg &= ~PCI_ERR_UNC_INTN;
+       pci_write_config_dword(dev, pos_cap_err + PCI_ERR_UNCOR_MASK, reg);
+
        rc = pcie_capability_set_word(dev, PCI_EXP_DEVCTL, PCI_EXP_AER_FLAGS);
        return pcibios_err_to_errno(rc);
 }
