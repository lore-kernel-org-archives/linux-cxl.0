Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B1BDC433EF
	for <linux-cxl@archiver.kernel.org>; Mon, 27 Sep 2021 23:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 773B160FC0
	for <linux-cxl@archiver.kernel.org>; Mon, 27 Sep 2021 23:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238235AbhI0X4O (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 27 Sep 2021 19:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238200AbhI0X4N (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 27 Sep 2021 19:56:13 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76813C061575
        for <linux-cxl@vger.kernel.org>; Mon, 27 Sep 2021 16:54:34 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id rm6-20020a17090b3ec600b0019ece2bdd20so1371803pjb.1
        for <linux-cxl@vger.kernel.org>; Mon, 27 Sep 2021 16:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o8VkW9aJAfzimrnvdQ0DzQJTFhTw3v2oMiNkiKwQDPw=;
        b=DQFp7Cq2wIj4wpnTChljrmlMvn1nkpLqExTPqhxJSbaYMvDi0IMinp2aPoPHnGzXVg
         ElX35q4XW9xkRmXNuuITj4cwe/VVrP8qXhHxoTn4ew4TX+U7lIwdQiXxxyhS0FnaWNX8
         brHuEDlieFwWWeyId30j2DALecbzqyW0Ks+Zw5opzcwN0VmW1hCVdwX+/0gdnoY0BNHP
         WcKYZGnqgsonXPZlAHyuHvSYCTFVfMV1rI19YBgpvCYTUAymhX8tJRfLHnID9lenrOll
         yzHeIBE/SfcJZuQsdgrQSKNY0hNCU8bQOBsLKGtNK+AgDKC+gyp/7VB6JBtzqyPsKRO0
         FXYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o8VkW9aJAfzimrnvdQ0DzQJTFhTw3v2oMiNkiKwQDPw=;
        b=E4JTeOOxfvrlFtI5HRkEldl4hHvuBCwwpyTNZX5WeuvOZhwazu81LtlS5XPOa1nJEL
         z9CJjcLr9X73sl/2jJte3YrizgNdns5sC28Ao+9J0n5iAzelUrjefIYCJsGJ4HpeWCSF
         8N0IR3lppP6b3lbhiGbuZyw4EkjFLdLpVAxIZJcdMD7kvxmYVu2sjV9LhGjQeb9ba84u
         OxjrY7Ge+gYKm3ftfHWYs02EBhvkRMnXk7lY0396sCWzteeXLZLknzXvYI/+qpMWXWsX
         +L8NzCh1+OBU2C1y05+wQRJA6Smz0k99DxQeRe7QPXCvRQxjmhYSA6uJ+7EcjJykbF7s
         ZBeA==
X-Gm-Message-State: AOAM531jR2BDUpFgMxBDskcBCf1ONG1x5xwTaRjb57AKgRe6TTC4dbpP
        t37mrRQJYtTAHHxbVY9XmIP53llYfW/H1Lu03WL9v2solYBjKQ==
X-Google-Smtp-Source: ABdhPJwurpl4WIRWcr7N1lfaZly73sxBeltTwzhzf/+7TKsoxsIhe5XDISH4lobhWjWi6o0pZUDfC7YF6xH9kO6XQhE=
X-Received: by 2002:a17:90a:f18f:: with SMTP id bv15mr1897089pjb.93.1632786873770;
 Mon, 27 Sep 2021 16:54:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210924212817.489801-1-ben.widawsky@intel.com>
 <CAPcyv4gsVCoaqX81q57XZSAOqQmdLbdruGGxBpOk59nNRn+hXg@mail.gmail.com> <20210927224522.gvybo3nhbgqhjbwo@intel.com>
In-Reply-To: <20210927224522.gvybo3nhbgqhjbwo@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 27 Sep 2021 16:54:25 -0700
Message-ID: <CAPcyv4gmsmtOap8jwu7zEC6K1PCeTGSwRwEHKbBGksRERdCUnQ@mail.gmail.com>
Subject: Re: [RFC PATCH] cxl: switch usp to parent cxl_port
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Sep 27, 2021 at 3:45 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> On 21-09-27 14:49:40, Dan Williams wrote:
> > On Fri, Sep 24, 2021 at 2:28 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
> > >
> > > Hi Dan.
> > >
> > > As discussed in #cxl, I'm trying to do the switch enumeration and not entirely
> > > sure of the best way to go about it (and no real way to test it). Do you have a
> > > proposed way to do this better?
> > >
> > >
> > > ---
> > >  drivers/cxl/core/bus.c | 65 ++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 65 insertions(+)
> > >
> > > diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
> > > index 936b6b5665c3..372d30b4bafd 100644
> > > --- a/drivers/cxl/core/bus.c
> > > +++ b/drivers/cxl/core/bus.c
> > > @@ -419,6 +419,71 @@ struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
> > >  }
> > >  EXPORT_SYMBOL_GPL(devm_cxl_add_port);
> > >
> > > +static int match_add_switches(struct pci_dev *pdev, void *data)
> > > +{
> > > +       struct cxl_walk_context *ctx = data;
> > > +       struct pci_bus *root_bus = ctx->root;
> > > +       struct device *dev = &pdev->dev;
> > > +       int type = pci_pcie_type(pdev);
> > > +       struct cxl_port *parent_port;
> > > +       struct cxl_register_map map;
> > > +       int rc;
> > > +
> > > +       if (pdev->bus != root_bus)
> > > +               return 0;
> >
> > This bus is the peer-bus of the other root ports in the system.
>
> I really dislike the word term "root port". You specifically mean other
> hostbridges in the system, correct (or do you mean peer root ports in a
> hostbridge)?

I mean both.

All of the PCIE root ports in the system may appear to be on the same
root bus regardless of which hostbridge they belong, but that's not
relevant for switch scanning beneath root ports.

>
> > You would want to be scanning the buses of the switch's subordinate downstream
> > ports. Also I don't think you want to filter by bus, and just let
> > pci_walk_bus() iterate the full sub-hierarchy.
>
> Yes. That's fine. This was copy-paste from cxl_acpi, but I don't see a reason to
> filter on the bus either.

cxl_acpi is not scanning for subordinates like this code wants to do.

>
> >
> > So if pdev is a CXL uport, then the next uport would be on one of the
> > subordinate bridges. With the expectation that each cxl_port includes
> > a listing of its dports I would expect something like:
> >
> >         list_for_each_entry(dport, &root_port->dports, list)
> >                 pci_walk_bus(dport->subordinate, match_uport, ctx);
> >
>
> Not sure why I need to iterate over the dports, isn't just walking down the from
> the root_port sufficient? I suppose it does some pre-filtering which might be a
> win.

You know you can skip a level because that first level is handled by
cxl_acpi, and that first level has the ACPI hostbridge weirdness.

>
>
> > > +
> > > +       if (!pci_is_pcie(pdev))
> > > +               return 0;
> > > +       if (type != PCI_EXP_TYPE_UPSTREAM)
> > > +               return 0;
> >
> > Yes, assuming that that pci_walk_bus() scans bridges before descending
> > to the next level you can try to scan for CXL capability on anything
> > that claims to be an upstream port. You could also save another
> > pci_walk_bus() by doing the dport check here too... i.e.
> >
> > if (type == PCI_EXP_TYPE_DOWNSTREAM) {
> >     port = find_cxl_port(pdev->parent);
> >     ...determine id and component reg base...
> >     cxl_add_dport(port, pdev, ...);
> > }
> >
>
> find_cxl_port handwave is where I was asking for advice. I believe I know how to
> implement find_cxl_port(struct pci_dev *upstream_port), but...
>
> (see bottom of email for sample with everything)
>
>
> > > +
> > > +       /* Get component registers */
> > > +       rc = cxl_find_register_block(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
> > > +       if (rc) {
> > > +               ctx->error = rc;
> > > +       }
> > > +
> > > +       /* to_pci_dev(dev->parent) == downstream port, or root port */
> > > +       /* to_pci_dev(dev->parent->parent) == upstream port, or hostbridge */
> > > +
> > > +       if (dev_WARN_ONCE(dev, dev->parent->parent == NULL,
> > > +                         "No valid parent\n")) {
> > > +               ctx->error = -ENODEV;
> > > +               parent_port = NULL;
> >
> > Not sure what this is for? I would think filtering pci_walk_bus() by
> > PCI_EXP_TYPE_{UP,DOWN}STREAM is sufficient and that this association
> > is assumed.
> >
> > > +       } else {
> > > +               parent_port = to_cxl_port(dev->parent->parent);
> >
> > No, you can't walk from a pci device to a cxl port, so it would need
> > something like find_cxl_port() like I handwaved above.
> >
>
> This is fundamentally where I'm "stuck". As I add switches, I need to get to the
> parent port and I do not know how to do that. Is it safe to do
> find_cxl_port(dev->parent->parent)?

Yes, but only if you start the walk from dport->subordinate otherwise
this walks off the top of the hierarchy.

>
> > > +       }
> > > +
> > > +       devm_cxl_add_port(ctx->dev, dev,
> > > +                         pci_resource_start(pdev, map.barno) +
> > > +                                 map.block_offset,
> > > +                         parent_port);
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +int enumerate_ports_from_root_port(struct cxl_port *root_port)
> > > +{
> > > +       struct device *d = root_port->uport;
> > > +       struct cxl_walk_context ctx;
> > > +       struct pci_dev *pdev;
> > > +
> > > +       if (!dev_is_pci(d))
> > > +               return -ENODEV;
> > > +
> > > +       pdev = to_pci_dev(d);
> > > +       ctx = (struct cxl_walk_context){
> > > +               .dev = d,
> > > +               .root = pdev->bus,
> > > +               .port = root_port,
> > > +       };
> > > +
> > > +       pci_walk_bus(pdev->bus, match_add_switches, &ctx);
> > > +
> > > +       return 0;
> > > +}
> > > +EXPORT_SYMBOL_GPL(enumerate_ports_from_root_port);
> > > +
> > >  static struct cxl_dport *find_dport(struct cxl_port *port, int id)
> > >  {
> > >         struct cxl_dport *dport;
> > >
> > > base-commit: 5c46722547fb375f460dbe293f40fad0ca32ab90
> > > prerequisite-patch-id: f3e7ffbd5f60cd3f55ad8e174afd9d8c37d546f4
> > > prerequisite-patch-id: a74a0ce5f4a1e4cec50e68181fcbb92624cb0687
> > > prerequisite-patch-id: 3e2e86cbc2631b99c1b5c0179f35799d3df31f91
> > > prerequisite-patch-id: 68cf009af310e296626b7842fc798fc778fcc98e
> > > prerequisite-patch-id: 4063abbb095774d723ad727cb91bc8576d6a5532
> > > prerequisite-patch-id: 3f11cc68d4dfc7f578f8c6a440663e9ef4e27466
> > > prerequisite-patch-id: 5ef0b7ff2acf5896b955dd4f70a06581f42d7904
> > > prerequisite-patch-id: 8cc6066d94bc859ff094c056d77eb63a967a3657
> > > prerequisite-patch-id: b4fa2b34c36f3068743c965ebc01462ab016df4d
> > > prerequisite-patch-id: a8798a409f1ff81979fb35a2c66a991ba6cc69f5
> > > prerequisite-patch-id: d68e5ca2dbd408f206acb40c54f1ed9e6d981aa0
> > > --
> > > 2.33.0
> > >
>
> int match_port(struct device *dev, const void *data)
> {
>         struct pci_dev *pdev = data;
>
>         if (!is_cxl_port(dev))
>                 return 0;
>
>         return to_cxl_port(dev)->uport == &pdev->dev;
> }
>
> struct cxl_port *find_cxl_port(struct pci_dev *upstream_port)
> {
>         struct device *port_dev;
>
>         port_dev = bus_find_device(&cxl_bus_type, NULL, upstream_port, match_port);
>         if (port_dev)
>                 return to_cxl_port(port_dev);
>
>         return NULL;
> }
>
> static int match_add_switches(struct pci_dev *pdev, void *data)
> {
>         ...
>         dev = &pdev->dev;
>
>         if (type == PCI_EXP_TYPE_UPSTREAM) {
>                 parent_port = find_cxl_port(dev->parent->parent);

Looks good.

For the final code you'll probably want to do find_cxl_port(dev) first
just to make sure you're not adding a port for a switch that was
scanned before in a previous API call.

>                 if (!parent_port)
>                         return 1;
>
>                 port = devm_cxl_add_port(..., parent_port); //upstream port

Looks good.

For the final code it will want a "put_device(&parent_port->dev)" here
to undo the reference taken by bus_find_device().

>                 return 0;
>         }
>
>         if (type == PCI_EXP_TYPE_DOWNSTREAM) {
>                 uport = find_cxl_port(dev->parent);
>                 // get component reg base of dport
>                 cxl_add_dport(uport, dev, ...)

Looks good.

>         }
>
>         return 0;
> }
>
> {
> ... pci_walk_bus(pdev->bus, match_add_switches, &ctx);

Per-above you probably want to start the scan below each root port, or
otherwise filter out the top-level scan work that cxl_acpi owns.
