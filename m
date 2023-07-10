Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C09BDEB64D9
	for <linux-cxl@archiver.kernel.org>; Mon, 10 Jul 2023 10:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbjGJKmW (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 10 Jul 2023 06:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbjGJKmG (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 10 Jul 2023 06:42:06 -0400
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8711E12A
        for <linux-cxl@vger.kernel.org>; Mon, 10 Jul 2023 03:42:01 -0700 (PDT)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-3fbc5d5742bso48035225e9.2
        for <linux-cxl@vger.kernel.org>; Mon, 10 Jul 2023 03:42:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688985720; x=1691577720;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X7Mh11QsaJnmcKpvOw1jYdGIGgwBZmnNztJ9ynLvHRg=;
        b=kmLHRLv3bmT6f0astx89laCnlsoNtN4sJixvvBuNGHs7RFePnrsMpjiQ3B1LpIj9rL
         2iK0BprinNhogYQisLpGMD/werd7j9Fsu/mzs4hjWHkwb/2t7AFjd/THZwnNUt4osk7L
         Ri+THhzb3ZRG5E1d22Kz/OFzPB4yaAQcpgAZXr59uE8QlUehVkyptXedU/QbVELGTrFh
         DVlCGGYRGhhVXO78t3WFqb4+/zWcU4Hp0nCbeZx1j3O9C4LziDMcZH/IkAvcYTSPYKIq
         ebKUVKk/5GX9tSlZZfp3/ZxxjH+fdm8mEm8Ucqqz+dzV47WztmAGgAYjTiz6GX1Y7nrC
         xDEg==
X-Gm-Message-State: ABy/qLadayaqaX+HGUWugiB7yFi1XMPPyli2/WIHN5AnoiTBemrgdeET
        ysVX3LAbopu07BvvVrBVp5jDtpMLeUU=
X-Google-Smtp-Source: APBJJlGfhRNPfY1AXWeYTJLhlvFhAAN1AN4JbWWFH83g0oepy5A/SYkiBmYk6VrYP7PllYV4ZGlCig==
X-Received: by 2002:adf:e0ca:0:b0:314:13e2:2f6c with SMTP id m10-20020adfe0ca000000b0031413e22f6cmr10944098wri.58.1688985719619;
        Mon, 10 Jul 2023 03:41:59 -0700 (PDT)
Received: from gmail.com (fwdproxy-cln-004.fbsv.net. [2a03:2880:31ff:4::face:b00c])
        by smtp.gmail.com with ESMTPSA id k15-20020adff5cf000000b00314398e4dd4sm11410451wrp.54.2023.07.10.03.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 03:41:59 -0700 (PDT)
Date:   Mon, 10 Jul 2023 03:41:57 -0700
From:   Breno Leitao <leitao@debian.org>
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     vishal.l.verma@intel.com, ira.weiny@intel.com, bwidawsk@kernel.org,
        dan.j.williams@intel.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH] cxl/acpi: Release device after dev_err
Message-ID: <ZKvgdcu5k+JjRtlW@gmail.com>
References: <20230707161616.3554167-1-leitao@debian.org>
 <ZKiPFu0KY0alQxCJ@aschofie-mobl2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZKiPFu0KY0alQxCJ@aschofie-mobl2>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Jul 07, 2023 at 03:17:58PM -0700, Alison Schofield wrote:
> On Fri, Jul 07, 2023 at 09:16:16AM -0700, Breno Leitao wrote:
> > Kfence is detecting a user-after-free in the CXL, when cxl_decoder_add()
> > fails. Kfence drops this message, after the following:
> > 
> >   BUG: KFENCE: use-after-free read in resource_string
> > 
> > This is happening in cxl_parse_cfmws(), and here is a simplified flow
> > that is coming from Kfence.
> > 
> > Use-after-free:
> > 	_dev_err
> > 	cxl_parse_cfmws
> > 	acpi_table_parse_entries_array
> > 	acpi_table_parse_cedt
> > 	cxl_acpi_probe
> > 
> > Free:
> > 	cxl_decoder_release
> > 	device_release
> > 	kobject_put
> > 	cxl_parse_cfmws
> > 	acpi_table_parse_entries_array
> > 	acpi_table_parse_cedt
> > 	cxl_acpi_probe
> > 
> > Alloc:
> > 	cxl_decoder_alloc
> > 	cxl_parse_cfmws
> > 	acpi_table_parse_entries_array
> > 	acpi_table_parse_cedt
> > 	cxl_acpi_probe
> > 	platform_probe
> > 
> > From my reading of the issue, the device struct being used by
> > dev_err() was removed in the put_device() before.
> 
> Hi Breno, 
> 
> I'm not familiar w kfence, but I don't follow what it finds
> suspect here. Does kfence point to exact offensive lines of
> code, or ???

Unfortunately I do not lines that match anything public. Collecting them
might be hard also, since kfence problems during failure mode are not
easy to reproduce.

> The put_device() removed &cxld->dev and the dev_err() that
> this patch moves the put after, was using 'dev', which was
> assigned from ctx.dev. It is not the same as &cxld->dev. I
> wonder if Kfence thinks we can get to the next dev_dbg()
> statement and misuse &cxld->dev.

Any chance that "struct device_type->release"() might be touching
ctx->dev? This is because "struct device_type->release"() is calling
during the put operation, which seems to be the one de-allocating the
resource.

> More below...
> 
> 
> > 
> > Put the device just after the message is printed.
> > 
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> >  drivers/cxl/acpi.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > index 658e6b84a769..5179bf4211d8 100644
> > --- a/drivers/cxl/acpi.c
> > +++ b/drivers/cxl/acpi.c
> > @@ -291,14 +291,13 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
> >  	}
> >  	rc = cxl_decoder_add(cxld, target_map);
> >  err_xormap:
> > -	if (rc)
> > -		put_device(&cxld->dev);
> > -	else
> > -		rc = cxl_decoder_autoremove(dev, cxld);
> >  	if (rc) {
> >  		dev_err(dev, "Failed to add decode range [%#llx - %#llx]\n",
> >  			cxld->hpa_range.start, cxld->hpa_range.end);
> > +		put_device(&cxld->dev);
> >  		return 0;
> > +	} else {
> > +		rc = cxl_decoder_autoremove(dev, cxld);
> >  	}
> >  	dev_dbg(dev, "add: %s node: %d range [%#llx - %#llx]\n",
> >  		dev_name(&cxld->dev),
> > -- 
> > 2.34.1
> > 
> 
> (pulled in fresh code snippet to get the dev_dbg() in view.)
> 
> >	}
> >	rc = cxl_decoder_add(cxld, target_map);
> >err_xormap:
> >	if (rc)
> >		put_device(&cxld->dev);
> >
> 
> This puts &cxld->dev, not dev.
> 
> >
> >	else
> >		rc = cxl_decoder_autoremove(dev, cxld);
> >	if (rc) {
> >		dev_err(dev, "Failed to add decode range [%#llx - %#llx]\n",
> >			cxld->hpa_range.start, cxld->hpa_range.end);
> >		return 0;
> 
> This return avoids getting to the next dev_dbg() statement after
> put_device(). We cannot get to the next dev_dbg() statement when
> rc is non zero, but it seems kfence thinks we can.

Oh, the problems is on dev_err() not on dev_dbg(). Basically on the
return path.

Here is what dmesg says:

	cxl root0: Failed to populate active decoder targets
	cxl_acpi ACPI0017:00: Failed to add decoder for [mem 0x4080000000-0x2baffffffff flags 0x200]
	cxl root0: Failed to populate active decoder targets
	cxl_acpi ACPI0017:00: Failed to add decoder for [mem 0x2bb00000000-0x5357fffffff flags 0x200]
	cxl root0: Failed to populate active decoder targets
	==================================================================
	BUG: KFENCE: use-after-free read in resource_string+0x80/0x570\x0a
	Use-after-free read at 0x(____ptrval____) (in kfence-#111):
	 resource_string+0x80/0x570
	 pointer+0x389/0x3c0
	 vsnprintf+0x214/0x670
	 pointer+0x1b2/0x3c0
	 vsnprintf+0x214/0x670
	 vprintk_store+0x102/0x450
	 vprintk_emit+0x6f/0x1b0
	 dev_vprintk_emit+0x117/0x163
	 dev_printk_emit+0x51/0x6b
	 _dev_err+0x6e/0x88
	 cxl_parse_cfmws+0x2a0/0x2d
	 acpi_table_parse_entries_array+0x1fc/0x330
	 acpi_table_parse_cedt+0x4f/0x70
	 cxl_acpi_probe+0xd6/0x150
	 platform_probe+0x2f/0x60
	 really_probe+0x1f5/0x340
	 driver_probe_device+0x1e/0x80
	 __driver_attach+0xfc/0x190
	 bus_for_each_dev+0x76/0xb0
	 bus_add_driver+0x1bb/0x230
	 driver_register+0x85/0x120
	 do_one_initcall+0xbe/0x240
	 kernel_init_freeable+0x1cc/0x2d2
	 kernel_init+0x16/0x1a0
	 ret_from_fork+0x1f/0x30
