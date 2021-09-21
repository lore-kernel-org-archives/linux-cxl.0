Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD613C4332F
	for <linux-cxl@archiver.kernel.org>; Tue, 21 Sep 2021 19:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95A3D61166
	for <linux-cxl@archiver.kernel.org>; Tue, 21 Sep 2021 19:21:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234420AbhIUTWy (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 21 Sep 2021 15:22:54 -0400
Received: from mga12.intel.com ([192.55.52.136]:6985 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229915AbhIUTWy (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Tue, 21 Sep 2021 15:22:54 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10114"; a="202943449"
X-IronPort-AV: E=Sophos;i="5.85,311,1624345200"; 
   d="scan'208";a="202943449"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2021 12:21:25 -0700
X-IronPort-AV: E=Sophos;i="5.85,311,1624345200"; 
   d="scan'208";a="653035316"
Received: from ksankar-mobl2.amr.corp.intel.com (HELO intel.com) ([10.252.132.1])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2021 12:21:25 -0700
Date:   Tue, 21 Sep 2021 12:21:23 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] cxl: Move register block enumeration to core
Message-ID: <20210921192123.gzh3cich3cbiczp6@intel.com>
References: <20210920225638.1729482-1-ben.widawsky@intel.com>
 <CAPcyv4ja65PA5qjKPW4dYsVUCEiEDKD65_5vw15VryYL1h7=QQ@mail.gmail.com>
 <20210921164401.h46pjfwkpr7m2ven@intel.com>
 <CAPcyv4idgH7=4aVZWsUfeiqJyC_rh0+F5dkuWLiomL1oao7k7A@mail.gmail.com>
 <20210921190637.x54hh4aaom5auffs@intel.com>
 <CAPcyv4hmd=uSwrp=P+yHb=D2YCjM8WBEn0V8jC5VbqvGctMBpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4hmd=uSwrp=P+yHb=D2YCjM8WBEn0V8jC5VbqvGctMBpw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 21-09-21 12:16:18, Dan Williams wrote:
> On Tue, Sep 21, 2021 at 12:06 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
> >
> > On 21-09-21 11:42:55, Dan Williams wrote:
> > > On Tue, Sep 21, 2021 at 9:44 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
> > > >
> > > > On 21-09-21 07:07:13, Dan Williams wrote:
> > > > > On Mon, Sep 20, 2021 at 3:57 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
> > > > > >
> > > > > > CXL drivers or cxl_core itself will require the ability to map component
> > > > > > registers in order to map HDM decoder resources amongst other things.
> > > > > > Much of the register mapping code has already moved into cxl_core. The
> > > > > > code to pull the BAR number and block office remained within cxl_pci
> > > >
> > > > s/office/offset - before anyone else notices...
> > > >
> > > > > > because there was no need to move it. Upcoming work will require this
> > > > > > functionality to be available outside of cxl_pci.
> > > > > >
> > > > > > There are two intentional functional changes:
> > > > > > 1. cxl_pci: If there is more than 1 component, or device register block,
> > > > > >    only the first one (of each) is checked. Previous logic checked all
> > > > > >    duplicate register blocks and additionally attempted to map unused
> > > > > >    register blocks if present.
> > > > > > 2. cxl_pci: No more dev_dbg for unused register blocks
> > > > >
> > > > > Why not break these out into separate patches before moving the code?
> > > > > It makes it easier to review, and it increases the precision of future
> > > > > Fixes: patches if necessary.
> > > > >
> > > >
> > > > I can. Indeed it was my instinct to do so. I went against my instinct...
> > > >
> > > > What are you thinking (something like...)?
> > > > 1. Change register locator identifiers to enum
> > > > 2. refactor cxl_pci to use the new find() function.
> > >
> > > In order to ease the coordination pressure perhaps you could define a
> > > __weak copy of this helper in the CXL core with a comment of:
> > >
> > > /* TODO: Delete once this same function is available from the PCI core */
> > >
> > > ...and then separately send the refactor series to all the stakeholders.
> >
> > You mean so I can work on the other drivers without being blocked on this?
> 
> Yeah, so CXL development is not waiting on a stable commit-id for this
> to show up, and so that other drivers are not needing to merge some
> random point in the CXL development branch into their trees.
> 
> > I
> > think as long as you generally agree with the final outcome, I'll be okay to
> > just keep working on top of this.
> 
> I'm looking to let this soak with stable commit-ids in cxl.git/next.
> It's hard to do that with external dependencies.

Understood. Right now all the drivers have a dependency order, so couldn't the
weakly defined helper just be the first patch in that series? Or are you
suggesting to send that and get it merged before anything else?
