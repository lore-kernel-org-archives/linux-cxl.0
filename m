Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC1B1C433EF
	for <linux-cxl@archiver.kernel.org>; Tue, 28 Sep 2021 00:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAD5E60FF2
	for <linux-cxl@archiver.kernel.org>; Tue, 28 Sep 2021 00:32:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238350AbhI1AeR (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 27 Sep 2021 20:34:17 -0400
Received: from mga03.intel.com ([134.134.136.65]:6149 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238349AbhI1AeP (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Mon, 27 Sep 2021 20:34:15 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10120"; a="224659117"
X-IronPort-AV: E=Sophos;i="5.85,328,1624345200"; 
   d="scan'208";a="224659117"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2021 17:32:37 -0700
X-IronPort-AV: E=Sophos;i="5.85,328,1624345200"; 
   d="scan'208";a="518783491"
Received: from westonsh-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.133.229])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2021 17:32:36 -0700
Date:   Mon, 27 Sep 2021 17:32:33 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org
Subject: Re: [RFC PATCH] cxl: switch usp to parent cxl_port
Message-ID: <20210928003233.fo2ddlinveg66rm5@intel.com>
References: <20210924212817.489801-1-ben.widawsky@intel.com>
 <CAPcyv4gsVCoaqX81q57XZSAOqQmdLbdruGGxBpOk59nNRn+hXg@mail.gmail.com>
 <20210927224522.gvybo3nhbgqhjbwo@intel.com>
 <CAPcyv4gmsmtOap8jwu7zEC6K1PCeTGSwRwEHKbBGksRERdCUnQ@mail.gmail.com>
 <20210928000605.eh5yiqdkty45z6px@intel.com>
 <CAPcyv4gAJBV8Z3Xfi+R+DL6x3LXoOtHkcnsewU6Ru8YmH-bfSQ@mail.gmail.com>
 <20210928002124.wgwss44ygjjeaaej@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210928002124.wgwss44ygjjeaaej@intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 21-09-27 17:21:24, Ben Widawsky wrote:
> On 21-09-27 17:18:35, Dan Williams wrote:
> > On Mon, Sep 27, 2021 at 5:06 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
> > [..]
> > > > Per-above you probably want to start the scan below each root port, or
> > > > otherwise filter out the top-level scan work that cxl_acpi owns.
> > >
> > > The scan will skip everything until it finds a USP or DSP which cxl_acpi
> > > wouldn't be touching. I don't have any issue with:
> > >
> > > >         list_for_each_entry(dport, &root_port->dports, list)
> > > >                 pci_walk_bus(dport->subordinate, match_uport, ctx);
> > >
> > > but I don't see any issue with the current code either. Did I miss something?
> > 
> > if (pdev->bus != root_bus)
> >     return 0;
> > 
> > Doesn't that always fail for the switches in question? Did I miss
> > where root_bus is updated?
> 
> In my previous comment I meant that I'd drop this check, but I see what you're
> saying now. I need to pick some subordinate bus or I'll just walk over all
> switches, even ones I don't care about...

Would this work?

-int enumerate_ports_from_root_port(struct cxl_port *root_port)
+int enumerate_ports_from_root_port(struct cxl_dport *root_port)
 {
-       struct device *d = root_port->uport;
+       struct device *d = root_port->dport;
        struct cxl_walk_context ctx;
        struct pci_dev *pdev;

        if (!dev_is_pci(d))
                return -ENODEV;

        pdev = to_pci_dev(d);
        ctx = (struct cxl_walk_context){
                .dev = d,
                .root = pdev->bus,
-               .port = root_port,
+               .port = root_port->port,
        };

        pci_walk_bus(pdev->bus, match_add_switches, &ctx);

        return 0;
 }


