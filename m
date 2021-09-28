Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 259ADC433EF
	for <linux-cxl@archiver.kernel.org>; Tue, 28 Sep 2021 00:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08684611EF
	for <linux-cxl@archiver.kernel.org>; Tue, 28 Sep 2021 00:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238284AbhI1AXH (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 27 Sep 2021 20:23:07 -0400
Received: from mga07.intel.com ([134.134.136.100]:38606 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238277AbhI1AXF (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Mon, 27 Sep 2021 20:23:05 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10120"; a="288249775"
X-IronPort-AV: E=Sophos;i="5.85,327,1624345200"; 
   d="scan'208";a="288249775"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2021 17:21:27 -0700
X-IronPort-AV: E=Sophos;i="5.85,328,1624345200"; 
   d="scan'208";a="437898180"
Received: from westonsh-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.133.229])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2021 17:21:27 -0700
Date:   Mon, 27 Sep 2021 17:21:24 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org
Subject: Re: [RFC PATCH] cxl: switch usp to parent cxl_port
Message-ID: <20210928002124.wgwss44ygjjeaaej@intel.com>
References: <20210924212817.489801-1-ben.widawsky@intel.com>
 <CAPcyv4gsVCoaqX81q57XZSAOqQmdLbdruGGxBpOk59nNRn+hXg@mail.gmail.com>
 <20210927224522.gvybo3nhbgqhjbwo@intel.com>
 <CAPcyv4gmsmtOap8jwu7zEC6K1PCeTGSwRwEHKbBGksRERdCUnQ@mail.gmail.com>
 <20210928000605.eh5yiqdkty45z6px@intel.com>
 <CAPcyv4gAJBV8Z3Xfi+R+DL6x3LXoOtHkcnsewU6Ru8YmH-bfSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4gAJBV8Z3Xfi+R+DL6x3LXoOtHkcnsewU6Ru8YmH-bfSQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 21-09-27 17:18:35, Dan Williams wrote:
> On Mon, Sep 27, 2021 at 5:06 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
> [..]
> > > Per-above you probably want to start the scan below each root port, or
> > > otherwise filter out the top-level scan work that cxl_acpi owns.
> >
> > The scan will skip everything until it finds a USP or DSP which cxl_acpi
> > wouldn't be touching. I don't have any issue with:
> >
> > >         list_for_each_entry(dport, &root_port->dports, list)
> > >                 pci_walk_bus(dport->subordinate, match_uport, ctx);
> >
> > but I don't see any issue with the current code either. Did I miss something?
> 
> if (pdev->bus != root_bus)
>     return 0;
> 
> Doesn't that always fail for the switches in question? Did I miss
> where root_bus is updated?

In my previous comment I meant that I'd drop this check, but I see what you're
saying now. I need to pick some subordinate bus or I'll just walk over all
switches, even ones I don't care about...
