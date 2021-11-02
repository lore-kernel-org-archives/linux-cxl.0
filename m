Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F7DC433EF
	for <linux-cxl@archiver.kernel.org>; Tue,  2 Nov 2021 17:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76C9C61075
	for <linux-cxl@archiver.kernel.org>; Tue,  2 Nov 2021 17:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbhKBRYe (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 2 Nov 2021 13:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233003AbhKBRYe (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 2 Nov 2021 13:24:34 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B00FC061714
        for <linux-cxl@vger.kernel.org>; Tue,  2 Nov 2021 10:21:59 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id a9so34692pgg.7
        for <linux-cxl@vger.kernel.org>; Tue, 02 Nov 2021 10:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kCr/BZ7lEG9/hAFiuMYr8AV1yr0tRehl9MSpDoH+mJ4=;
        b=aeuNwz7Pd6tsRL28nmPLZxWvlI8bFDcaxHRr3aaF1CZdRodZ5pJ8oak89jN/k0SUO0
         diXiYJZZC7GhzIVp/WypjIL7Q4JISYE9DYwqa//JxjPX/8zExzD9r1RpnSfKdj7Yjul2
         wNLnvpv7U/rtlJ+ktj7TXGXTgb/g98jO997ZVfDaytdL7P1fmp1biMDAZVylTf9Rbv0u
         edCh5S2f48hNztxpCUxNmLWpMmVg2xzSBJZOga95Fxg+bc5DdJpUguDFrHlRjeyUstM4
         3QoZmhqg0jzKp21FNLSK4sTi3skrSF/F1GajK54tpRhZj012TVNJ+qKt3gZpWrf9JaNk
         H9SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kCr/BZ7lEG9/hAFiuMYr8AV1yr0tRehl9MSpDoH+mJ4=;
        b=kogHEutwpYV4bmLkQ27FU1PFN9yy+2vzB+Ra4FxBPPhWdSrDG9TMgiGlfbzWh66lRF
         QeEq4z3R0aNOoC8Nr3A1yTfBxMK7Zw+X76W5Zr5QgZpi3pLXclASUByOZZBBGaYe78r6
         f7cuWoC7sn4aVDuZFHdV4+ZQwkP8ZM1yHHdEc4szpq6VdGGF+wy8XESy2X28q5jeczbA
         aycwexrG4FTZtpBBbahegk8U/PKYk+g1qdGcpUJ+MWUFE1HQhSmc9VYAkuM094gb1Ztp
         Y6CwFZLyalOFb46EOE0PX9ZGNObi1DweLOQt/LiuURMaihrtjyO9BT0+VlalHmcDJk22
         s01Q==
X-Gm-Message-State: AOAM530yOTZTwcs9zA8Ycpw9VZF8mD1zYgC1SWrfobFr5OWEFNUBAyEK
        rv0LUbOTwuZOC34C4E8efcz13yT0LHGatwmFTl1ftA==
X-Google-Smtp-Source: ABdhPJxAjOoSCQXwBFXfT6J7i4r0q48MyewK307oeD47BhkfFHZvbmdT4Kupo30k27lKp5oP2U8qCtHGkc6fsmpY2SQ=
X-Received: by 2002:a05:6a00:1254:b0:481:2730:a52a with SMTP id
 u20-20020a056a00125400b004812730a52amr4807246pfi.86.1635873718409; Tue, 02
 Nov 2021 10:21:58 -0700 (PDT)
MIME-Version: 1.0
References: <20211022183709.1199701-1-ben.widawsky@intel.com>
 <20211022183709.1199701-9-ben.widawsky@intel.com> <CAPcyv4g9AUzNihcYJ3AzwZ+UnFquOf1VWX3fZgb-77ZNteFTAA@mail.gmail.com>
 <20211101175314.lrq3ccqkts725bjt@intel.com> <CAPcyv4hKxUXbmCkuf8Rw1vsOhErKMyZ8ivBjO9YkhxDgiogo-w@mail.gmail.com>
 <20211102162720.z7b3pwf5xojledv6@intel.com>
In-Reply-To: <20211102162720.z7b3pwf5xojledv6@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 2 Nov 2021 10:21:47 -0700
Message-ID: <CAPcyv4iAitwKm6Gm4KVQ7LX9HWu7vHe9VNtcFHC0dGvXqXFWUw@mail.gmail.com>
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

On Tue, Nov 2, 2021 at 9:27 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> On 21-11-01 20:31:03, Dan Williams wrote:
> > On Mon, Nov 1, 2021 at 10:53 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
> > >
> > > On 21-10-29 18:37:36, Dan Williams wrote:
> > > > On Fri, Oct 22, 2021 at 11:37 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
> > > > >
> > >
> > > [snip]
> > >
> > > > > diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
> > > > > index cf07ae6cea17..40b386aaedf7 100644
> > > > > --- a/drivers/cxl/Makefile
> > > > > +++ b/drivers/cxl/Makefile
> > > > > @@ -1,5 +1,6 @@
> > > > >  # SPDX-License-Identifier: GPL-2.0
> > > > >  obj-$(CONFIG_CXL_BUS) += core/
> > > > > +obj-$(CONFIG_CXL_MEM) += cxl_port.o
> > > >
> > > > It feel odd that CONFIG_CXL_MEM builds cxl_port, why not have a
> > > > CONFIG_CXL_PORT that is simply selected by CONFIG_CXL_MEM, or a
> > > > CONFIG_CXL_PORT that defaults to the value of CONFIG_CXL_BUS?
> > > >
> > >
> > > Can you help me understand when CONFIG_CXL_MEM is useful when
> > > #CONFIG_CXL_PORT=n? I was unable to figure out such a case and so I tied the two
> > > together.
> >
> > With a 'select' dependency it's impossible to have the
> > CONFIG_CXL_PORT=n and CONFIG_CXL_MEM=m combination. The extra config
> > symbol is for idiomatic (one config-symbol per module .ko) reasons to
> > reflect the module dependency in the Kconfig.
>
> Can't argue with idiomisms ;-)

It's idiomatic because it's extensible. I expect type-2 drivers to
select port services as well.

>
> >
> > [..]
> > > > > +static inline int cxl_hdm_decoder_ig(u32 ctrl)
> > > >
> > > > No need for plain inline in C files.
> > > >
> > > > It's not clear why this simple helper needs a "cxl_hdm_decoder"
> > > > namespace prefix?
> > >
> > > I had a patch to share this with acpi driver at one point, but I dropped it. Do
> > > you care if I merge those two decoders, or just rename?
> >
> > Not sure what you mean by "merge"?
> >
>
> To have a unified function for both the cxl_acpi driver and the cxl_port driver.

Ah, yeah, CFMWS_INTERLEAVE_WAYS and CFMWS_INTERLEAVE_GRANULARITY are
doing the same work.

>
> > >
> > > >
> > > > > +{
> > > > > +       int val = FIELD_GET(CXL_HDM_DECODER0_CTRL_IG_MASK, ctrl);
> > > > > +
> > > > > +       return 8 + val;
> > > > > +}
> > > >
> > > > Why is this return a power of 2 value...
> > >
> > > I don't understand this comment.
> >
> > Isn't this returning an IG as a bit-shift value? The "iw" is returning
> > bytes and I'm proposing they both be bytes.
> >
>
> IG is definitely wrong since it's documented in struct cxl_decoder as data
> stride. I will fix that. I don't follow what you mean by "iw" is returning
> bytes. It's returning the number of ways.

Sorry, some noise from me there. I should have said integer instead of
encoded value.

CFMWS_INTERLEAVE_GRANULARITY has the same problem (another indicator
that a unit test for all user facing values is needed to catch simple
bugs like this).

>
> > >
> > > >
> > > > > +
> > > > > +static inline int cxl_hdm_decoder_iw(u32 ctrl)
> > > > > +{
> > > > > +       int val = FIELD_GET(CXL_HDM_DECODER0_CTRL_IW_MASK, ctrl);
> > > > > +
> > > > > +       return 1 << val;
> > > >
> > > > ...while this one is converted to absolute values.
> > > >
> > > > These could just be:
> > > >
> > > > unsigned int to_interleave_granularity(u32 ctrl)
> > > > unsigned int to_interleave_ways(u32 ctrl)
> > > >
> > > > ...and return units in bytes.
> > > >
> > > > > +}
> > > > > +
> > > > > +static void get_caps(struct cxl_port *port, struct cxl_port_data *cpd)
> > > > > +{
> > > > > +       void __iomem *hdm_decoder = cpd->regs.hdm_decoder;
> > > > > +       struct port_caps *caps = &cpd->caps;
> > > > > +       u32 hdm_cap;
> > > > > +
> > > > > +       hdm_cap = readl(hdm_decoder + CXL_HDM_DECODER_CAP_OFFSET);
> > > > > +
> > > > > +       caps->count = cxl_hdm_decoder_count(hdm_cap);
> > > > > +       caps->tc = FIELD_GET(CXL_HDM_DECODER_TARGET_COUNT_MASK, hdm_cap);
> > > > > +       caps->interleave11_8 =
> > > > > +               FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_11_8, hdm_cap);
> > > > > +       caps->interleave14_12 =
> > > > > +               FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_14_12, hdm_cap);
> > > > > +}
> > > > > +
> > > > > +static int map_regs(struct cxl_port *port, void __iomem *crb,
> > > > > +                   struct cxl_port_data *cpd)
> > > > > +{
> > > > > +       struct cxl_register_map map;
> > > > > +       struct cxl_component_reg_map *comp_map = &map.component_map;
> > > > > +
> > > > > +       cxl_probe_component_regs(&port->dev, crb, comp_map);
> > > > > +       if (!comp_map->hdm_decoder.valid) {
> > > > > +               dev_err(&port->dev, "HDM decoder registers invalid\n");
> > > > > +               return -ENXIO;
> > > > > +       }
> > > >
> > > > Perhaps promote cxl_probe_regs() from the cxl_pci to the core and make
> > > > it take a dev instead of a pdev, then you can do:
> > > >
> > > > cxl_probe_regs(&port_dev->dev, CXL_REGLOC_RBI_COMPONENT)
> > > >
> > > > ...instead of open coding it again?
> > > >
> > > > > +
> > > > > +       cpd->regs.hdm_decoder = crb + comp_map->hdm_decoder.offset;
> > > > > +
> > > > > +       return 0;
> > > > > +}
> > > > > +
> > > > > +static u64 get_decoder_size(void __iomem *hdm_decoder, int n)
> > > > > +{
> > > > > +       u32 ctrl = readl(hdm_decoder + CXL_HDM_DECODER0_CTRL_OFFSET(n));
> > > > > +
> > > > > +       if (!!FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl))
> > > > > +               return 0;
> > > > > +
> > > > > +       return ioread64_hi_lo(hdm_decoder +
> > > > > +                             CXL_HDM_DECODER0_SIZE_LOW_OFFSET(n));
> > > > > +}
> > > > > +
> > > > > +static bool is_endpoint_port(struct cxl_port *port)
> > > > > +{
> > > > > +       if (!port->uport->driver)
> > > > > +               return false;
> > > > > +
> > > > > +       return to_cxl_drv(port->uport->driver)->id ==
> > > > > +              CXL_DEVICE_MEMORY_EXPANDER;
> > > >
> > > > Why does endpoint port device type determination need to reach through
> > > > and read the driver type?
> > > >
> > >
> > > I couldn't figure out a better way at this point in enumeration. I'm open to
> > > suggestions.
> >
> > list_empty(&port->dports)?
> >
>
> That seems obvious enough. In the v2 series it's possible due to failures for a
> switch port to also have list_empty(&port->dports). Should ports not get added
> if they have 0 dports (unless they're endpoints)?

Sounds reasonable, I can't imagine a usable non-endpoint port that has
no dports.

>
> >
> > >
> > > [snip]
> > >
> > > > > +
> > > > > +       /*
> > > > > +        * Enable HDM decoders for this port.
> > > > > +        *
> > > > > +        * FIXME: If the component was using DVSEC range registers for decode,
> > > > > +        * this will destroy that.
> > > >
> > > > Yeah, definitely need to check that before this patch can move
> > > > forward. Perhaps a port should not even be registered if DVSEC
> > > > Memory_Size && Mem_Enable are non zero, that device is explicitly
> > > > opting out of being a part of the CXL 2.0 subsystem hierarchy.
> > > > However, we might still need to track it and potentially reserve it
> > > > out of CFMWS capacity to make sure nothing else collides with it. I'll
> > > > also note that "ECN: Devices operating in CXL 1.1 mode with no RCRB"
> > > > was recently published that reads on what the driver should do here.
> > > >
> > >
> > > I believe we want to create the port since we might decide to reset and want
> > > control back over it and as you said, safety check other things. The reason it
> > > was left as a FIXME is because this belongs in the PCI driver which I didn't
> > > really want to touch at this time. I will go back and add that for the next
> > > version.
> >
> > Ok.
> >
> > >
> > > > > +        */
> > > > > +       ctrl = readl(portdata->regs.hdm_decoder + CXL_HDM_DECODER_CTRL_OFFSET);
> > > > > +       ctrl |= CXL_HDM_DECODER_ENABLE;
> > > > > +       writel(ctrl, portdata->regs.hdm_decoder + CXL_HDM_DECODER_CTRL_OFFSET);
> > > >
> > > > I feel like that if the driver finds it enabled it should leave it
> > > > enabled at ->remove() time, as you have it here, as BIOS might not be
> > > > expecting the OS to disable a decoder it set up. However, if the
> > > > driver actually does the enable, then it should pair it with a disable
> > > > at the end of time, so not a blind enable, but one that conditionally
> > > > arranges for the unwind.
> > >
> > > My thought was that once we enumerate a port, all of it's architectural state
> > > belongs to the OS. For us that means blanket enable/disable. I don't feel
> > > strongly about this.
> >
> > I think the driver needs to tread carefully when it comes to potential
> > BIOS interactions. The minimum BIOS collision would be to not toggle
> > the enable off if the OS cannot assert that it set it. A more precise
> > policy would be checking if the device contributes to any EFI memory
> > map ranges, or any locked CFMWS entries.
>
> Locked == bit 4, fixed, right? The more precise policy makes sense to me, though
> I still wonder what happens if we reset a device for that case?

I expect it will be painful and likely crash the system if that device
is contributing to active System RAM. There is definitely some more
exclusion needed to coordinate with secondary bus reset on the PCI
side. I can imagine someone trying to passthrough a CXL device to a VM
unaware that it will trigger a reset and crash the system.
