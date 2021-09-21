Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B63C433F5
	for <linux-cxl@archiver.kernel.org>; Tue, 21 Sep 2021 22:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89B846115A
	for <linux-cxl@archiver.kernel.org>; Tue, 21 Sep 2021 22:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235856AbhIUWBp (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 21 Sep 2021 18:01:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:40370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235766AbhIUWBh (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Tue, 21 Sep 2021 18:01:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B256F6115A;
        Tue, 21 Sep 2021 22:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632261609;
        bh=RBmuJeyGABlAu1Pp67/jivP7of6tCDStM2bE1ePeREc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=r5hzQNM9LAeFVk+d/b+vaIcBnsXXOp66h29LPIWLx044HN/xofMyIS0FLF8eIh82Q
         OeRez36qr0COWkwdss45JJDYlPpjsJ07594mU2MGxCicyZUNEKmdZ7Emlr3gHJmxwt
         28jxqwVTjG3CGbD1XAbk6HHP50n6rDSE+obDIOF9DYZfNss76tYhVjSY1feziVhHQh
         Ler24WxVDXD0AeHWx7hnC4S3OKSF3CPTcUPucRDOa4W3TdTplNofcMfq6rxXeq0bSY
         +cGr6MKKS/SJStAH+tWZ6hdDKzLxnwPGDbHOHVUQKBrV/5HFpMFyX9U0MTcPPwCACS
         TyNMkpPl8sSFA==
Date:   Tue, 21 Sep 2021 17:00:07 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-cxl@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] cxl: Move register block enumeration to core
Message-ID: <20210921220007.GA135188@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4ja65PA5qjKPW4dYsVUCEiEDKD65_5vw15VryYL1h7=QQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Sep 21, 2021 at 07:07:13AM -0700, Dan Williams wrote:
> On Mon, Sep 20, 2021 at 3:57 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
> >
> > CXL drivers or cxl_core itself will require the ability to map component
> > registers in order to map HDM decoder resources amongst other things.
> > Much of the register mapping code has already moved into cxl_core. The
> > code to pull the BAR number and block office remained within cxl_pci
> > because there was no need to move it. Upcoming work will require this
> > functionality to be available outside of cxl_pci.
> >
> > There are two intentional functional changes:
> > 1. cxl_pci: If there is more than 1 component, or device register block,
> >    only the first one (of each) is checked. Previous logic checked all
> >    duplicate register blocks and additionally attempted to map unused
> >    register blocks if present.
> > 2. cxl_pci: No more dev_dbg for unused register blocks
> 
> Why not break these out into separate patches before moving the code?
> It makes it easier to review, and it increases the precision of future
> Fixes: patches if necessary.

+1

> > +static int cxl_pci_dvsec(struct pci_dev *pdev, int dvsec)
> > +{
> > +       int pos;
> > +
> > +       pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_DVSEC);
> > +       if (!pos)
> > +               return 0;
> > +
> > +       while (pos) {
> > +               u16 vendor, id;
> > +
> > +               pci_read_config_word(pdev, pos + PCI_DVSEC_HEADER1, &vendor);
> > +               pci_read_config_word(pdev, pos + PCI_DVSEC_HEADER2, &id);
> > +               if (vendor == PCI_DVSEC_VENDOR_ID_CXL && dvsec == id)
> > +                       return pos;
> > +
> > +               pos = pci_find_next_ext_capability(pdev, pos,
> > +                                                  PCI_EXT_CAP_ID_DVSEC);
> > +       }
> 
> We punted on refactoring this for the initial driver submission
> because it was difficult to coordinate. Now that cxl.git is an
> established tree, instead of moving this it seems time to address that
> refactor that Bjorn asked about. Bjorn, would you be willing to carry
> a non-rebasing branch with such a cleanup that CXL could pull from?

Sure.  Would be nice to get this cleaned up.
