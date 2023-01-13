Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E4EC67871
	for <linux-cxl@archiver.kernel.org>; Fri, 13 Jan 2023 15:20:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjAMPT6 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 13 Jan 2023 10:19:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjAMPTg (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 13 Jan 2023 10:19:36 -0500
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240CD631AF
        for <linux-cxl@vger.kernel.org>; Fri, 13 Jan 2023 07:12:34 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 67C0330000D2F;
        Fri, 13 Jan 2023 16:12:17 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id EB800233EB0; Fri, 13 Jan 2023 16:12:06 +0100 (CET)
Date:   Fri, 13 Jan 2023 16:12:06 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Gregory Price <gregory.price@memverge.com>, qemu-devel@nongnu.org,
        Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linux-cxl@vger.kernel.org,
        linuxarm@huawei.com, Ira Weiny <ira.weiny@intel.com>,
        Gregory Price <gourry.memverge@gmail.com>
Subject: Re: [PATCH 0/8] hw/cxl: CXL emulation cleanups and minor fixes for
 upstream
Message-ID: <20230113151206.GA20583@wunner.de>
References: <20230111142440.24771-1-Jonathan.Cameron@huawei.com>
 <Y8AppXP+eP9cEz+i@memverge.com>
 <20230112172130.0000391b@Huawei.com>
 <Y8CNw/fZT5fZJZcK@memverge.com>
 <20230113091213.00002146@Huawei.com>
 <Y8Foj/12QNl0C96o@memverge.com>
 <20230113144026.000001fb@Huawei.com>
 <20230113144511.00001207@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113144511.00001207@Huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Jan 13, 2023 at 02:45:11PM +0000, Jonathan Cameron wrote:
> On Fri, 13 Jan 2023 14:40:26 +0000 Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> > On Fri, 13 Jan 2023 09:19:59 -0500 Gregory Price <gregory.price@memverge.com> wrote:
> > > On Fri, Jan 13, 2023 at 09:12:13AM +0000, Jonathan Cameron wrote:  
> > > > Just to check, are these different from the on stack problem you reported
> > > > previously?  Doesn't look like the fix for that has made it upstream yet.
> > > > 
> > > > What kernel are you running?
> > > 
> > > The prior issue I saw was related to the CXL Fixed Memory Window having
> > > an e820 region registered during machine initialization.  That fix is
> > > upstream.
> > > 
> > > On 2023-1-11 branch it is commit 2486dd045794d65598fbca9fd1224c27b9732dce
> > > 
> > > This one appears when registering any kind of type-3 device, during
> > > boot.  
> > 
> > I meant this one
> > 
> > https://lore.kernel.org/all/20221118000524.1477383-1-ira.weiny@intel.com/
> > 
> > Sorry, should have dug out a link in earlier reply and save a round trip.
> 
> Ah I'd forgotten we were going round the houses somewhat on the right fix...
> https://lore.kernel.org/all/20221128040338.1936529-3-ira.weiny@intel.com/
> was another proposal and Lukas had yet another.
> https://lore.kernel.org/all/cover.1669608950.git.lukas@wunner.de/

I'll respin those fixes shortly, together with the other DOE patches
I've accumulated on my development branch for DOE+SPDM:

https://github.com/l1k/linux/commits/doe

Ira kindly tested them this week and reports that they don't regress
CDAT retrieval for him.

Thanks,

Lukas
