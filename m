Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4026C433F5
	for <linux-cxl@archiver.kernel.org>; Thu,  4 Nov 2021 20:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D589D6121F
	for <linux-cxl@archiver.kernel.org>; Thu,  4 Nov 2021 20:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbhKDUDZ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 4 Nov 2021 16:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbhKDUDZ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 4 Nov 2021 16:03:25 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5921C061714
        for <linux-cxl@vger.kernel.org>; Thu,  4 Nov 2021 13:00:46 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id f8so9030903plo.12
        for <linux-cxl@vger.kernel.org>; Thu, 04 Nov 2021 13:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R+vrFVZS7Av2+6Ttlxfwx2vMQbH88NNj0Vn6RbFN+Jk=;
        b=JTxVPPx/tbB28b+CyxIMoA24WDScxvjIXT45f9LZzH5LoMTxh7kExWOybSmzDDSJJ4
         Si+jUTNdC5aZbizSQJt7SkL4+wg3qM35gU6AMqDJHec2XaEibIpjcUvQi8wGaQ4sRMl+
         iAasNp6+rbHN65EInD6xH6rvNZJP8wHNduChYZA6tXOgwpicW/hDPlrTGHMILHuBLq58
         7a+Cis+z+o1jXBy726+GblIXIkWjtl00GjUDld1kl6L/dy2So+ZbJHeNBhqJWtr8AC0B
         lkNloahPUZ0RK6uDq/EBZaGyxzgR6OkpBWXcYPGffrtUnDGfgo6IWgxlB8fpZKN3fwyR
         UWzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R+vrFVZS7Av2+6Ttlxfwx2vMQbH88NNj0Vn6RbFN+Jk=;
        b=QfJFgNh90Z2b3Bqpew08G6Q9VdMc3orc3/e4HA4MVew1y6/Ur+V2Q45o2i3QuqVTEN
         gIlsLoNdbwg88kb4pj1RSwql6zAGBDBK14kR93WVnVZQnSf1bn4G9f8gGyIXb1bnrIfI
         q/7uF088DTG0O66vAxP+HfuIwnhoL6BYa3Vg8EKGZ1ud1NONTNWRZUZ06bP1wrMD9oJQ
         TIcxCb4f/jQdalkbDzUeyceJ/5VMDC7hzK/ddjgwavLK85fbiLOOMURLMza5hsQAAQAL
         1cy5upkEGelY10Qvr4K2/aC4ymrEPgCeo2RPNJG08R0sK0Hgbcn646zmvZEB5h9lNiUg
         BW3w==
X-Gm-Message-State: AOAM5322Ug+rUkvgddd6c92IbcIR5sVtYkHmv+zB6TF92scI9xYN0dZa
        od9vY4DxpnohSFBJAaCRVw0sCD0Yo4gW6wHJom5DEw==
X-Google-Smtp-Source: ABdhPJzHUBWya1IDpyt71HNW4GzNnqo930/TfQCNYbIxpw4y90aYMnLGc75ZrWsIJwp5W2l3+FlQ3KS54yJDteYpBGk=
X-Received: by 2002:a17:90a:6c47:: with SMTP id x65mr8216400pjj.8.1636056046351;
 Thu, 04 Nov 2021 13:00:46 -0700 (PDT)
MIME-Version: 1.0
References: <20211022183709.1199701-1-ben.widawsky@intel.com>
 <20211022183709.1199701-9-ben.widawsky@intel.com> <CAPcyv4g9AUzNihcYJ3AzwZ+UnFquOf1VWX3fZgb-77ZNteFTAA@mail.gmail.com>
 <20211104163727.ybgenphhwaruqhff@intel.com> <CAPcyv4gMx-2WuPz5DUyaYin=GfRcx6XVQr0+-1X6qDb4236deg@mail.gmail.com>
 <20211104194602.mhgnlbf65ilyul5c@intel.com>
In-Reply-To: <20211104194602.mhgnlbf65ilyul5c@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 4 Nov 2021 13:00:35 -0700
Message-ID: <CAPcyv4jm6Of-yCvQtYrxMD-2y6wajAXFfzwMpFADGMigApuYiA@mail.gmail.com>
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

On Thu, Nov 4, 2021 at 12:46 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> On 21-11-04 12:17:48, Dan Williams wrote:
> > On Thu, Nov 4, 2021 at 9:37 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
> > >
> > > On 21-10-29 18:37:36, Dan Williams wrote:
> > > > On Fri, Oct 22, 2021 at 11:37 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
> > > > >
> > >
> > > [snip]
> > >
> > > >
> > > > +void trigger_decoder_autoremove(void *data)
> > > > +{
> > > > +       struct cxl_decoder *cxld = data;
> > > > +       struct device *host = get_cxl_topology_host();
> > > > +
> > > > +       /* The topology host driver beat us to the punch */
> > > > +       if (!host)
> > > > +               return;
> > > > +
> > > > +       devm_remove_action(host, cxld_unregister, &cxld->dev);
> > > > +       put_cxl_topology_host(host);
> > > > +}
> > > > +
> > > > +/**
> > > > + * cxl_port_decoder_autoremove - remove decoders discovered by the port driver
> > > > + * @cxld: decoder to remove
> > > > + *
> > > > + * CXL.mem requires an intact port / decoder topology from root level
> > > > + * platform decoders to endpoint decoders. Arrange for decoders
> > > > + * enumerated by the port driver to be removed when either the root is
> > > > + * removed (in which the entire hierarchy is removed), or when an
> > > > + * individual port is disabled, in which case only that port's
> > > > + * sub-section of the hierarchy is removed.
> > > > + */
> > > > +int cxl_port_decoder_autoremove(struct cxl_decoder *cxld)
> > > > +{
> > > > +       struct cxl_port *port = to_cxl_port(cxld->dev.parent);
> > > > +       struct device *host = get_cxl_topology_host();
> > > > +       int rc;
> > > > +
> > > > +       if (!host)
> > > > +               return -ENODEV;
> > > > +
> > > > +       if (!port->dev.driver) {
> > > > +               rc = -ENXIO;
> > > > +               goto out;
> > > > +       }
> > > > +
> > > > +       rc = cxl_decoder_autoremove(host, cxld);
> > > > +       if (rc)
> > > > +               goto out;
> > > > +
> > > > +       rc = devm_add_action_or_reset(&port->dev, trigger_decoder_autoremove,
> > > > +                                       cxld);
> > > > +out:
> > > > +       put_cxl_topology_host(host);
> > > > +       return rc;
> > > > +}
> > > > +EXPORT_SYMBOL_NS_GPL(cxl_port_decoder_autoremove, CXL);
> > >
> > > The only port which has decoders that aren't discovered by the port driver would
> > > be the "root port" because it's platform specific. However, that port still is
> > > treated similarly to the other ports. Therefore I don't see why you need
> > > cxl_decoder_autoremove() anymore. Could you please explain? I think the safety
> > > check in trigger_decoder_autoremove() makes this work for all cases.
> >
> > I don't think it's worth the games to explain why CXL sees fit to
> > register (here comes your favorite argument...) non-idiomatic devm
> > actions on devices that are not associated with the running device +
> > driver. So as long as the port driver auto-unloads its child devices
> > then we're golden. Is your concern that you want to have the CFMWS
> > decoders registers from cxl_port and not cxl_acpi?
>
> Hey! I'm all for idioms when it makes sense. To me, one of the coolest things
> about working on a new subsystem is you get to define some of your own idioms,
> but anyway...
>
> First, no I think the platform driver (cxl_acpi) should enumerate the platform
> decoders. I confused devm_remove_action() with devm_release_action(). I wonder
> though, if you made trigger_decoder_autoremove() call devm_release_action, would
> that be sufficient and then remove cxl_decoder_autoremove()?

devm_release_action() is not needed if the devm is allowed to fire
naturally which was the realization I came to here:

https://lore.kernel.org/r/CAPcyv4gpA=DH0SQvRdmF6dY01mZ1S-gGEWTSDbb+0ajYtyNv0A@mail.gmail.com

I.e. I regret opening that pandora's box of registering "remote" devm
actions vs typical local devm actions.
