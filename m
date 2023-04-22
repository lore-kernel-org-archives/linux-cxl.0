Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF96C6FD18
	for <linux-cxl@archiver.kernel.org>; Sat, 22 Apr 2023 14:05:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjDVOFj (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 22 Apr 2023 10:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjDVOFi (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sat, 22 Apr 2023 10:05:38 -0400
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34111AD
        for <linux-cxl@vger.kernel.org>; Sat, 22 Apr 2023 07:05:37 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id CF35C3000253C;
        Sat, 22 Apr 2023 16:05:34 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id B007A179B72; Sat, 22 Apr 2023 16:05:34 +0200 (CEST)
Date:   Sat, 22 Apr 2023 16:05:34 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, ira.weiny@intel.com
Subject: Re: [PATCH] cxl/port: Fix port to pci device assumptions in
 read_cdat_data()
Message-ID: <20230422140534.GA8951@wunner.de>
References: <becaf70e8faf9681d474200117d62d7eaac46cca.1678543498.git.lukas@wunner.de>
 <168213190748.708404.16215095414060364800.stgit@dwillia2-xfh.jf.intel.com>
 <20230422083502.GA31480@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230422083502.GA31480@wunner.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Sat, Apr 22, 2023 at 10:35:02AM +0200, Lukas Wunner wrote:
> I note however that before af0a6c3587dc, xa_for_each() was run on an
> xarray which was not initialized with xa_init() on non-pci cxl ports.
> (xa_init() was run from cxl_pci_probe() -> devm_cxl_pci_create_doe()
> but xa_for_each() was run from read_cdat_data() -> find_cdat_doe()
> for non-pci cxl ports as well.)
> 
> Hence can't this crash prior to af0a6c3587dc as well?

After taking another look with a fresh pair of eyeballs I think
you may see splats with CONFIG_DEBUG_LOCK_ALLOC=y (even prior to
af0a6c3587dc on non-pci cxl devices) due to the missing xa_init().

struct cxl_dev_state is kzalloc'ed and with CONFIG_DEBUG_LOCK_ALLOC=n,
the members of struct xarray all seem to be just zeroed by xa_init().
So no harm no foul.  But that's not the case with CONFIG_DEBUG_LOCK_ALLOC=y
because spinlock_t contains non-zero data.

Thanks,

Lukas
