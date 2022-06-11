Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA4F4C43334
	for <linux-cxl@archiver.kernel.org>; Sat, 11 Jun 2022 18:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiFKSUC (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 11 Jun 2022 14:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiFKSUB (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sat, 11 Jun 2022 14:20:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708242661
        for <linux-cxl@vger.kernel.org>; Sat, 11 Jun 2022 11:19:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F0BA61237
        for <linux-cxl@vger.kernel.org>; Sat, 11 Jun 2022 18:19:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5016FC34116;
        Sat, 11 Jun 2022 18:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654971598;
        bh=Yb08cxZcCucpQGFnXYEkF5Yj5ESAaDbMCJgoVWWqKQQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ggso6JDPzxrPWbWhL21WgCTUeEpavJ29eC24U1RHo4IBlZjdJ1X1BPIF10Lb6MqqB
         PBCD0VNobbDTeSxVhv9nPLQQ1yghZSJ8ugPOnbF9nSpgDeRSZxpfYmbEZfvoiFOSty
         XuIbGWgNi9vZGwMU9fSkWI13LtoqblXbwplBIO6oBEbtxTQcB7/OcOhyYopgQ1/JgA
         sVanAkf6s+QqPUD+BCjXEMfzRPzyrs8mdWzg1hyAn8XYXiIq9bpThXX2K5+rK9ibzx
         EYV353QFq1W3S7LpRdwPhKm7Ong50TI+g7MnnXyyMeLS/PhryQklAhAMjSBA1qOz+Z
         Bv8fQPiDS43Fw==
Date:   Sat, 11 Jun 2022 11:19:56 -0700
From:   Ben Widawsky <bwidawsk@kernel.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, a.manzanares@samsung.com
Subject: Re: [PATCH] cxl/port: Check for sane CXL.io values for device DVSEC
Message-ID: <20220611181956.6od4hlfr3z7mutao@bwidawsk-mobl5>
References: <20220611020246.140637-1-dave@stgolabs.net>
 <20220611040321.gmjyddcyb4q73o4e@bwidawsk-mobl5>
 <20220611042601.ezsjsoq2kaov76e3@offworld>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220611042601.ezsjsoq2kaov76e3@offworld>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 22-06-10 21:26:01, Davidlohr Bueso wrote:
> On Fri, 10 Jun 2022, Ben Widawsky wrote:
> 
> > On 22-06-10 19:02:46, Davidlohr Bueso wrote:
> 
> > > +	if (!(cap & CXL_DVSEC_IO_CAPABLE)) {
> > > +		dev_dbg(dev, "Not IO Capable\n");
> > > +		return -ENXIO;
> > > +	}
> > 
> > I don't know if it's worth doing this. We wouldn't have gotten to the registers
> > if it wasn't CXL.io capable.
> 
> Yeah I thought there might be reason as to why bit 2 was checked but not 1.
> Does this also apply for CXL_DVSEC_IO_ENABLE? fwiw I thought this was handy
> in case of bogus dvsec setups via qemu.
> 
> > > +
> > > +	if (!(cap & CXL_DVSEC_MEM_CAPABLE)) {
> > > +		dev_dbg(dev, "Not MEM Capable\n");
> > > +		return -ENXIO;
> > > +	}
> > > +
> 
> Either way this check should still be moved before reading the ctrl
> word.
> 
> Thanks,
> Davidlohr

I don't seem to have this code in any branch readily available, so it's hard to
say. In general I don't see a marked improvement in doing this, but if you can
address it in the commit message on why/how it might make better debugging, then
I'm all for it.

Ben

> 
> > > 	rc = pci_read_config_word(pdev, d + CXL_DVSEC_CTRL_OFFSET, &ctrl);
> > > 	if (rc)
> > > 		return rc;
> > > 
> > > -	if (!(cap & CXL_DVSEC_MEM_CAPABLE)) {
> > > -		dev_dbg(dev, "Not MEM Capable\n");
> > > +	if (!(ctrl & CXL_DVSEC_IO_ENABLE)) {
> > > +		dev_dbg(dev, "Not IO Enable\n");
> > > 		return -ENXIO;
> > > 	}
> > > 
> > > diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> > > index fce1c11729c2..845f59288dc3 100644
> > > --- a/drivers/cxl/cxlpci.h
> > > +++ b/drivers/cxl/cxlpci.h
> > > @@ -18,9 +18,11 @@
> > >  /* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
> > >  #define CXL_DVSEC_PCIE_DEVICE					0
> > >  #define   CXL_DVSEC_CAP_OFFSET		0xA
> > > +#define     CXL_DVSEC_IO_CAPABLE	BIT(1)
> > >  #define     CXL_DVSEC_MEM_CAPABLE	BIT(2)
> > >  #define     CXL_DVSEC_HDM_COUNT_MASK	GENMASK(5, 4)
> > >  #define   CXL_DVSEC_CTRL_OFFSET		0xC
> > > +#define     CXL_DVSEC_IO_ENABLE		BIT(1)
> > >  #define     CXL_DVSEC_MEM_ENABLE	BIT(2)
> > >  #define   CXL_DVSEC_RANGE_SIZE_HIGH(i)	(0x18 + (i * 0x10))
> > >  #define   CXL_DVSEC_RANGE_SIZE_LOW(i)	(0x1C + (i * 0x10))
> > > --
> > > 2.36.1
> > > 
