Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 502FCC433F5
	for <linux-cxl@archiver.kernel.org>; Wed,  9 Feb 2022 18:33:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236954AbiBISdi (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 9 Feb 2022 13:33:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235023AbiBISdh (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 9 Feb 2022 13:33:37 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D0AC0613C9
        for <linux-cxl@vger.kernel.org>; Wed,  9 Feb 2022 10:33:40 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id y5so5780049pfe.4
        for <linux-cxl@vger.kernel.org>; Wed, 09 Feb 2022 10:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l70orjZ1aXUy+NoKs+3xfqaxLup+A0K85rAFVA96w9k=;
        b=WCe5LevHMTawNJ081NojF/KihFPZpLNsONGkafEEqWXxAPHFe7flyCiSJyu/OdP5mu
         upJ5cXpLOIPoEWpWYLMBNALxeW0lCHCtWRvYAoK5f0mOTURJURO/dsdEec7NS6C8uVKm
         8r/3tISzs8VsejgZ75HUZqW5MyJv+EDjPBhJruXQ9fHFnCiBwvdcAm8vFFUchpDZeaVk
         wU3oSzmeNyrESDKLJPyO/yCo+gRYMBIKxlrv3DKxoOfeMzQ2AxQK8jBa5uuGZRW0cMJG
         dayJOJ0n40Pz/wc9hPEGTq3Pr6as5ARWQEMJk/8vjLKQff+OAuwXxINMZkP/+JiInNHM
         oHNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l70orjZ1aXUy+NoKs+3xfqaxLup+A0K85rAFVA96w9k=;
        b=iNsSQYrRV5JLX/cv1hx2VVz8SLWYfxaY7zE00BVKtagNYmaWIqh+FHrBJ9hrHJvpHS
         65W7prNG0hv2SI/u3bm0pY/kp53WQEMsgIOT33R7Ex/XICAQ5Z2w/oF207SOirpNwM4V
         4zp7OVhfY5lhbrN2Ct7XqrSk1JT0oOJ98c77zICkIyzoWlx+f9EzPl57BdLsdj93rGSp
         eu0cut2xryriJRLLIVGOIQ4ZjiRkfVbza2I1YO4R0eq1L75BCJASepFHJ4keoejPvwWR
         WU/rLAhq9YTYLbmeaEPKWuisWN8IewhDeZd6tV3LYa6Kr7xNjM7MaWg+6zoFzTPiwWTD
         +Tlg==
X-Gm-Message-State: AOAM5313btwd3VB6jYINrYFJE0SDX4kEz7qLhZqLboMz6Q3K4uuIhXkn
        9sy+JZD3YOuQYJCvTFj5ZP0x/oSPrIEQ6jYAs5uwhA==
X-Google-Smtp-Source: ABdhPJwAmVssziyh62OyqD5lageB0FnDYU2J4VFKbLIsX5Blfr3qpb80ywwoPEyk+hjpEuywrHT4lwC41onfTaGBdAY=
X-Received: by 2002:a63:8849:: with SMTP id l70mr2831759pgd.437.1644431618874;
 Wed, 09 Feb 2022 10:33:38 -0800 (PST)
MIME-Version: 1.0
References: <164439224893.2941117.18331456248117887720.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20220209174941.uyjm3t4qdvggeepk@intel.com>
In-Reply-To: <20220209174941.uyjm3t4qdvggeepk@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 9 Feb 2022 10:33:28 -0800
Message-ID: <CAPcyv4g2nasNw52KS1jSzbMe_CC+BPapYXLsT40+-qTut7JJbA@mail.gmail.com>
Subject: Re: [PATCH] cxl/core/port: Fix unregister_port() lock assertion
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Feb 9, 2022 at 9:49 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> On 22-02-08 23:37:28, Dan Williams wrote:
> > The device_lock_assert() in unregister_port() fails to pick the right
> > device leading to splats like the following from:
> >
> > echo "ACPI0017:00" > /sys/bus/platform/drivers/cxl_acpi/unbind
> >
> >  WARNING: CPU: 32 PID: 1147 at include/linux/device.h:787 unregister_port+0x49/0x50 [cxl_c
> >  [..]
> >  RIP: 0010:unregister_port+0x49/0x50 [cxl_core]
> >  [..]
> >  Call Trace:
> >   <TASK>
> >   release_nodes+0x63/0x80
> >   devres_release_all+0x8b/0xc0
> >   __device_release_driver+0x190/0x240
> >   device_driver_detach+0x3e/0xa0
> >   unbind_store+0x113/0x130
> >
> > Fix it up to assert on the device_lock() for ACPI0017 for root and 1st
> > level ports, and parent ports for all the rest.
> >
> > Fixes: 54cdbf845cf7 ("cxl/port: Add a driver for 'struct cxl_port' objects")
> > Reported-by: Ben Widawsky <ben.widawsky@intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> Comment/question below...
> Reviewed-by: Ben Widawsky <ben.widawsky@intel.com>
>
> > ---
> >  drivers/cxl/core/port.c |   24 ++++++++++++++++++++----
> >  1 file changed, 20 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> > index c3e83c624700..9b4bbd51fbaa 100644
> > --- a/drivers/cxl/core/port.c
> > +++ b/drivers/cxl/core/port.c
> > @@ -348,12 +348,28 @@ EXPORT_SYMBOL_NS_GPL(to_cxl_port, CXL);
> >  static void unregister_port(void *_port)
> >  {
> >       struct cxl_port *port = _port;
> > +     struct cxl_port *parent;
> > +     struct device *lock_dev;
> >
> > -     if (!is_cxl_root(port)) {
> > -             device_lock_assert(port->dev.parent);
> > -             port->uport = NULL;
> > -     }
> > +     if (is_cxl_root(port))
> > +             parent = NULL;
> > +     else
> > +             parent = to_cxl_port(port->dev.parent);
> > +
> > +     /*
> > +      * CXL root port's and the first level of ports are unregistered
> > +      * under the platform firmware device lock, all other ports are
> > +      * unregistered while holding their parent port lock.
> > +      */
> > +     if (!parent)
> > +             lock_dev = port->uport;
> > +     else if (is_cxl_root(parent))
> > +             lock_dev = parent->uport;
> > +     else
> > +             lock_dev = &parent->dev;
>
> I wonder if it would be a little cleaner if the root port and host bridge ports
> had a separate unregistration callback from switches and endpoints.

I think it's "a pay me now or pay me later" situation to just move
this same complexity to the registration side, not sure it would be
net cleaner.
