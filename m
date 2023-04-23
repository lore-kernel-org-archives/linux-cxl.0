Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191D5C77B76
	for <linux-cxl@archiver.kernel.org>; Sun, 23 Apr 2023 08:19:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjDWITI (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 23 Apr 2023 04:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjDWITI (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 23 Apr 2023 04:19:08 -0400
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E4A1993
        for <linux-cxl@vger.kernel.org>; Sun, 23 Apr 2023 01:19:06 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 95B742800BBC5;
        Sun, 23 Apr 2023 10:19:04 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 7ED87187E74; Sun, 23 Apr 2023 10:19:04 +0200 (CEST)
Date:   Sun, 23 Apr 2023 10:19:04 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, ira.weiny@intel.com
Subject: Re: [PATCH] cxl/port: Fix port to pci device assumptions in
 read_cdat_data()
Message-ID: <20230423081904.GA5476@wunner.de>
References: <becaf70e8faf9681d474200117d62d7eaac46cca.1678543498.git.lukas@wunner.de>
 <168213190748.708404.16215095414060364800.stgit@dwillia2-xfh.jf.intel.com>
 <20230422083502.GA31480@wunner.de>
 <20230422140534.GA8951@wunner.de>
 <644449689728c_1b66294e1@dwillia2-xfh.jf.intel.com.notmuch>
 <20230422223005.GA12308@wunner.de>
 <64446c2a54c53_1b6629433@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64446c2a54c53_1b6629433@dwillia2-xfh.jf.intel.com.notmuch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Sat, Apr 22, 2023 at 04:22:18PM -0700, Dan Williams wrote:
> Lukas Wunner wrote:
> > On Sat, Apr 22, 2023 at 01:54:00PM -0700, Dan Williams wrote:
> > > Lukas Wunner wrote:
> > > > On Sat, Apr 22, 2023 at 10:35:02AM +0200, Lukas Wunner wrote:
> > > > > I note however that before af0a6c3587dc, xa_for_each() was run on an
> > > > > xarray which was not initialized with xa_init() on non-pci cxl ports.
> > > > > (xa_init() was run from cxl_pci_probe() -> devm_cxl_pci_create_doe()
> > > > > but xa_for_each() was run from read_cdat_data() -> find_cdat_doe()
> > > > > for non-pci cxl ports as well.)
> > > > > 
> > > > > Hence can't this crash prior to af0a6c3587dc as well?
> > > > 
> > > > After taking another look with a fresh pair of eyeballs I think
> > > > you may see splats with CONFIG_DEBUG_LOCK_ALLOC=y (even prior to
> > > > af0a6c3587dc on non-pci cxl devices) due to the missing xa_init().
> > > 
> > > The xa_init() was included before in the removed call to
> > > devm_cxl_pci_create_doe().
> > 
> > ... which was called from cxl_pci_probe(), so only if a pci_dev exists?
> > 
> > I guess I must be missing something...
> 
> Oh, no you're right in the sense that the code will use an
> only-zero-initialized xarray before the move to the PCI core, but a zero
> initialized xarray is sufficient. Recall that xarray walks are only RCU
> protected, so the xarray spinlock is not used for xa_for_each().
> 
> The change that makes this a failure is now the doe_mbs xarray is not
> even allocated in the !pci_dev case.

Makes sense, thanks for the explanation.
