Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F127C433EF
	for <linux-cxl@archiver.kernel.org>; Tue,  2 Nov 2021 03:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8157760EB4
	for <linux-cxl@archiver.kernel.org>; Tue,  2 Nov 2021 03:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbhKBDdy (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 1 Nov 2021 23:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhKBDdv (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 1 Nov 2021 23:33:51 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB545C061714
        for <linux-cxl@vger.kernel.org>; Mon,  1 Nov 2021 20:31:14 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id s136so18926018pgs.4
        for <linux-cxl@vger.kernel.org>; Mon, 01 Nov 2021 20:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AigGPmyZD8EcTpsCPYFvXhcD4l8yO1yv9GYHF6kp4B4=;
        b=z95MEU7Haqn+CRGXEG6H0fO4x63gHPLpk4Ik/AiUGTlgKhz72x/7MnkCEYAhTokZRN
         40bJjkEzsERatgTNdqPZbGMWqzmt8qq4xP+ipvantu0ondWKG80txMsMNnk33exjus0v
         0OidryW4nOFdqAPhnjlLBbdLyaH6ZLgG2Bj841WWQongBOBum3CEFgpkv+kq05Cq3fVy
         WeY+yFUeNFKzbogVniZKsC09rzW/Ddw1q0oRfgwRuPc3xAGcARwewcS/9gD8icY+vRV8
         0kLnqUwwtIOjGCEni1/y01Qnm5tua8lnrHnItvqnu3NTcZKHHBI8dCKFEVfZkko0xVK1
         86ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AigGPmyZD8EcTpsCPYFvXhcD4l8yO1yv9GYHF6kp4B4=;
        b=RYRQ7+Yf0E/57H1Qv70w+M8XXAp2tBmsyUCUIC+cCEKonn4CmiHu6cq6vBvvJXv1yf
         dyiokgwe0bseMOAyOYI355Zwuctp7Ay4qX+uZloscLOdH16nl6bg6cEO7VjaSaRYJI4/
         uuBKjq6Xd42k7qpFQ0/vKMzTuul9h85Hsb9Jjh6N6e6dNps2nkau9NcX8KPsi1TaSQ6W
         PM4jMKTQz2iKSz3o0UiBA5ZbF2Sq9LmBNa1sQl7QGNTdL5YyYTfptHIpobyQEE/mZxx3
         lyGu8fp1SgIdYToDCmZWWnB6Bj6NW2rJLOh1VYVuQefumhHN8LtMtldwAYog2H/Yk8ok
         e4GQ==
X-Gm-Message-State: AOAM530kRak00CjFh1IpuZeYLANX15aTFjt2vIBx99RQ4wJyUj5OgqXV
        NLS4yVlGE5EDOujWhZQc3g+1Du4UjfIBp1DeUAJwXw==
X-Google-Smtp-Source: ABdhPJwmxv3qxKC2Rc1C5gFShAZiieYOLVf4DciDb+B4FWHgmSnwRpMKOhj6WsU0tx3FhOTD0QCZC2LkrluXDHDuAD8=
X-Received: by 2002:aa7:8019:0:b0:44d:d761:6f79 with SMTP id
 j25-20020aa78019000000b0044dd7616f79mr33753327pfi.3.1635823874170; Mon, 01
 Nov 2021 20:31:14 -0700 (PDT)
MIME-Version: 1.0
References: <20211022183709.1199701-1-ben.widawsky@intel.com>
 <20211022183709.1199701-9-ben.widawsky@intel.com> <CAPcyv4g9AUzNihcYJ3AzwZ+UnFquOf1VWX3fZgb-77ZNteFTAA@mail.gmail.com>
 <20211101175314.lrq3ccqkts725bjt@intel.com>
In-Reply-To: <20211101175314.lrq3ccqkts725bjt@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 1 Nov 2021 20:31:03 -0700
Message-ID: <CAPcyv4hKxUXbmCkuf8Rw1vsOhErKMyZ8ivBjO9YkhxDgiogo-w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 08/28] cxl/port: Introduce a port driver
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, Chet Douglas <chet.r.douglas@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Nov 1, 2021 at 10:53 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> On 21-10-29 18:37:36, Dan Williams wrote:
> > On Fri, Oct 22, 2021 at 11:37 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
> > >
>
> [snip]
>
> > > diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
> > > index cf07ae6cea17..40b386aaedf7 100644
> > > --- a/drivers/cxl/Makefile
> > > +++ b/drivers/cxl/Makefile
> > > @@ -1,5 +1,6 @@
> > >  # SPDX-License-Identifier: GPL-2.0
> > >  obj-$(CONFIG_CXL_BUS) += core/
> > > +obj-$(CONFIG_CXL_MEM) += cxl_port.o
> >
> > It feel odd that CONFIG_CXL_MEM builds cxl_port, why not have a
> > CONFIG_CXL_PORT that is simply selected by CONFIG_CXL_MEM, or a
> > CONFIG_CXL_PORT that defaults to the value of CONFIG_CXL_BUS?
> >
>
> Can you help me understand when CONFIG_CXL_MEM is useful when
> #CONFIG_CXL_PORT=n? I was unable to figure out such a case and so I tied the two
> together.

With a 'select' dependency it's impossible to have the
CONFIG_CXL_PORT=n and CONFIG_CXL_MEM=m combination. The extra config
symbol is for idiomatic (one config-symbol per module .ko) reasons to
reflect the module dependency in the Kconfig.

[..]
> > > +static inline int cxl_hdm_decoder_ig(u32 ctrl)
> >
> > No need for plain inline in C files.
> >
> > It's not clear why this simple helper needs a "cxl_hdm_decoder"
> > namespace prefix?
>
> I had a patch to share this with acpi driver at one point, but I dropped it. Do
> you care if I merge those two decoders, or just rename?

Not sure what you mean by "merge"?

>
> >
> > > +{
> > > +       int val = FIELD_GET(CXL_HDM_DECODER0_CTRL_IG_MASK, ctrl);
> > > +
> > > +       return 8 + val;
> > > +}
> >
> > Why is this return a power of 2 value...
>
> I don't understand this comment.

Isn't this returning an IG as a bit-shift value? The "iw" is returning
bytes and I'm proposing they both be bytes.

>
> >
> > > +
> > > +static inline int cxl_hdm_decoder_iw(u32 ctrl)
> > > +{
> > > +       int val = FIELD_GET(CXL_HDM_DECODER0_CTRL_IW_MASK, ctrl);
> > > +
> > > +       return 1 << val;
> >
> > ...while this one is converted to absolute values.
> >
> > These could just be:
> >
> > unsigned int to_interleave_granularity(u32 ctrl)
> > unsigned int to_interleave_ways(u32 ctrl)
> >
> > ...and return units in bytes.
> >
> > > +}
> > > +
> > > +static void get_caps(struct cxl_port *port, struct cxl_port_data *cpd)
> > > +{
> > > +       void __iomem *hdm_decoder = cpd->regs.hdm_decoder;
> > > +       struct port_caps *caps = &cpd->caps;
> > > +       u32 hdm_cap;
> > > +
> > > +       hdm_cap = readl(hdm_decoder + CXL_HDM_DECODER_CAP_OFFSET);
> > > +
> > > +       caps->count = cxl_hdm_decoder_count(hdm_cap);
> > > +       caps->tc = FIELD_GET(CXL_HDM_DECODER_TARGET_COUNT_MASK, hdm_cap);
> > > +       caps->interleave11_8 =
> > > +               FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_11_8, hdm_cap);
> > > +       caps->interleave14_12 =
> > > +               FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_14_12, hdm_cap);
> > > +}
> > > +
> > > +static int map_regs(struct cxl_port *port, void __iomem *crb,
> > > +                   struct cxl_port_data *cpd)
> > > +{
> > > +       struct cxl_register_map map;
> > > +       struct cxl_component_reg_map *comp_map = &map.component_map;
> > > +
> > > +       cxl_probe_component_regs(&port->dev, crb, comp_map);
> > > +       if (!comp_map->hdm_decoder.valid) {
> > > +               dev_err(&port->dev, "HDM decoder registers invalid\n");
> > > +               return -ENXIO;
> > > +       }
> >
> > Perhaps promote cxl_probe_regs() from the cxl_pci to the core and make
> > it take a dev instead of a pdev, then you can do:
> >
> > cxl_probe_regs(&port_dev->dev, CXL_REGLOC_RBI_COMPONENT)
> >
> > ...instead of open coding it again?
> >
> > > +
> > > +       cpd->regs.hdm_decoder = crb + comp_map->hdm_decoder.offset;
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static u64 get_decoder_size(void __iomem *hdm_decoder, int n)
> > > +{
> > > +       u32 ctrl = readl(hdm_decoder + CXL_HDM_DECODER0_CTRL_OFFSET(n));
> > > +
> > > +       if (!!FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl))
> > > +               return 0;
> > > +
> > > +       return ioread64_hi_lo(hdm_decoder +
> > > +                             CXL_HDM_DECODER0_SIZE_LOW_OFFSET(n));
> > > +}
> > > +
> > > +static bool is_endpoint_port(struct cxl_port *port)
> > > +{
> > > +       if (!port->uport->driver)
> > > +               return false;
> > > +
> > > +       return to_cxl_drv(port->uport->driver)->id ==
> > > +              CXL_DEVICE_MEMORY_EXPANDER;
> >
> > Why does endpoint port device type determination need to reach through
> > and read the driver type?
> >
>
> I couldn't figure out a better way at this point in enumeration. I'm open to
> suggestions.

list_empty(&port->dports)?


>
> [snip]
>
> > > +
> > > +       /*
> > > +        * Enable HDM decoders for this port.
> > > +        *
> > > +        * FIXME: If the component was using DVSEC range registers for decode,
> > > +        * this will destroy that.
> >
> > Yeah, definitely need to check that before this patch can move
> > forward. Perhaps a port should not even be registered if DVSEC
> > Memory_Size && Mem_Enable are non zero, that device is explicitly
> > opting out of being a part of the CXL 2.0 subsystem hierarchy.
> > However, we might still need to track it and potentially reserve it
> > out of CFMWS capacity to make sure nothing else collides with it. I'll
> > also note that "ECN: Devices operating in CXL 1.1 mode with no RCRB"
> > was recently published that reads on what the driver should do here.
> >
>
> I believe we want to create the port since we might decide to reset and want
> control back over it and as you said, safety check other things. The reason it
> was left as a FIXME is because this belongs in the PCI driver which I didn't
> really want to touch at this time. I will go back and add that for the next
> version.

Ok.

>
> > > +        */
> > > +       ctrl = readl(portdata->regs.hdm_decoder + CXL_HDM_DECODER_CTRL_OFFSET);
> > > +       ctrl |= CXL_HDM_DECODER_ENABLE;
> > > +       writel(ctrl, portdata->regs.hdm_decoder + CXL_HDM_DECODER_CTRL_OFFSET);
> >
> > I feel like that if the driver finds it enabled it should leave it
> > enabled at ->remove() time, as you have it here, as BIOS might not be
> > expecting the OS to disable a decoder it set up. However, if the
> > driver actually does the enable, then it should pair it with a disable
> > at the end of time, so not a blind enable, but one that conditionally
> > arranges for the unwind.
>
> My thought was that once we enumerate a port, all of it's architectural state
> belongs to the OS. For us that means blanket enable/disable. I don't feel
> strongly about this.

I think the driver needs to tread carefully when it comes to potential
BIOS interactions. The minimum BIOS collision would be to not toggle
the enable off if the OS cannot assert that it set it. A more precise
policy would be checking if the device contributes to any EFI memory
map ranges, or any locked CFMWS entries.

[..]
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index 5e2e93451928..bd7b008207a4 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -302,6 +302,10 @@ struct cxl_decoder *cxl_decoder_alloc(struct
> > cxl_port *port, int nr_targets);
> >  int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map);
> >  int cxl_decoder_autoremove(struct device *host, struct cxl_decoder *cxld);
> >
> > +void set_cxl_topology_host(struct device *dev);
> > +struct device *get_cxl_topology_host(void);
> > +void put_cxl_topology_host(struct device *dev);
> > +
> >  extern struct bus_type cxl_bus_type;
> >
> >  struct cxl_driver {
>
> As you've seen by now I do implement something like that you have below in a
> later patch. I believe it will still be nice to have, but I haven't read through
> all of your feedback yet. So I might change my mind.

The main difference I proposed is a {get,put}_cxl_topology_host() to
wrap topology operations in a rwsem.
