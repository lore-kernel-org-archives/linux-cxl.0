Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3CA1C433F5
	for <linux-cxl@archiver.kernel.org>; Tue, 28 Sep 2021 00:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DF8F61181
	for <linux-cxl@archiver.kernel.org>; Tue, 28 Sep 2021 00:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233697AbhI1AHs (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 27 Sep 2021 20:07:48 -0400
Received: from mga06.intel.com ([134.134.136.31]:11595 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231674AbhI1AHs (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Mon, 27 Sep 2021 20:07:48 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10120"; a="285603180"
X-IronPort-AV: E=Sophos;i="5.85,327,1624345200"; 
   d="scan'208";a="285603180"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2021 17:06:09 -0700
X-IronPort-AV: E=Sophos;i="5.85,327,1624345200"; 
   d="scan'208";a="553556971"
Received: from rwang1-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.137.33])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2021 17:06:07 -0700
Date:   Mon, 27 Sep 2021 17:06:05 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org
Subject: Re: [RFC PATCH] cxl: switch usp to parent cxl_port
Message-ID: <20210928000605.eh5yiqdkty45z6px@intel.com>
References: <20210924212817.489801-1-ben.widawsky@intel.com>
 <CAPcyv4gsVCoaqX81q57XZSAOqQmdLbdruGGxBpOk59nNRn+hXg@mail.gmail.com>
 <20210927224522.gvybo3nhbgqhjbwo@intel.com>
 <CAPcyv4gmsmtOap8jwu7zEC6K1PCeTGSwRwEHKbBGksRERdCUnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4gmsmtOap8jwu7zEC6K1PCeTGSwRwEHKbBGksRERdCUnQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 21-09-27 16:54:25, Dan Williams wrote:
> On Mon, Sep 27, 2021 at 3:45 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
> >
> > On 21-09-27 14:49:40, Dan Williams wrote:
> > > On Fri, Sep 24, 2021 at 2:28 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
> > > >
> > > > Hi Dan.
> > > >
> > > > As discussed in #cxl, I'm trying to do the switch enumeration and not entirely
> > > > sure of the best way to go about it (and no real way to test it). Do you have a
> > > > proposed way to do this better?
> > > >
> > > >
> > > > ---
> > > >  drivers/cxl/core/bus.c | 65 ++++++++++++++++++++++++++++++++++++++++++
> > > >  1 file changed, 65 insertions(+)
> > > >
> > > > diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
> > > > index 936b6b5665c3..372d30b4bafd 100644
> > > > --- a/drivers/cxl/core/bus.c
> > > > +++ b/drivers/cxl/core/bus.c
> > > > @@ -419,6 +419,71 @@ struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(devm_cxl_add_port);
> > > >
> > > > +static int match_add_switches(struct pci_dev *pdev, void *data)
> > > > +{
> > > > +       struct cxl_walk_context *ctx = data;
> > > > +       struct pci_bus *root_bus = ctx->root;
> > > > +       struct device *dev = &pdev->dev;
> > > > +       int type = pci_pcie_type(pdev);
> > > > +       struct cxl_port *parent_port;
> > > > +       struct cxl_register_map map;
> > > > +       int rc;
> > > > +
> > > > +       if (pdev->bus != root_bus)
> > > > +               return 0;
> > >
> > > This bus is the peer-bus of the other root ports in the system.
> >
> > I really dislike the word term "root port". You specifically mean other
> > hostbridges in the system, correct (or do you mean peer root ports in a
> > hostbridge)?
> 
> I mean both.
> 
> All of the PCIE root ports in the system may appear to be on the same
> root bus regardless of which hostbridge they belong, but that's not
> relevant for switch scanning beneath root ports.
> 
> >
> > > You would want to be scanning the buses of the switch's subordinate downstream
> > > ports. Also I don't think you want to filter by bus, and just let
> > > pci_walk_bus() iterate the full sub-hierarchy.
> >
> > Yes. That's fine. This was copy-paste from cxl_acpi, but I don't see a reason to
> > filter on the bus either.
> 
> cxl_acpi is not scanning for subordinates like this code wants to do.
> 
> >
> > >
> > > So if pdev is a CXL uport, then the next uport would be on one of the
> > > subordinate bridges. With the expectation that each cxl_port includes
> > > a listing of its dports I would expect something like:
> > >
> > >         list_for_each_entry(dport, &root_port->dports, list)
> > >                 pci_walk_bus(dport->subordinate, match_uport, ctx);
> > >
> >
> > Not sure why I need to iterate over the dports, isn't just walking down the from
> > the root_port sufficient? I suppose it does some pre-filtering which might be a
> > win.
> 
> You know you can skip a level because that first level is handled by
> cxl_acpi, and that first level has the ACPI hostbridge weirdness.
> 
> >
> >
> > > > +
> > > > +       if (!pci_is_pcie(pdev))
> > > > +               return 0;
> > > > +       if (type != PCI_EXP_TYPE_UPSTREAM)
> > > > +               return 0;
> > >
> > > Yes, assuming that that pci_walk_bus() scans bridges before descending
> > > to the next level you can try to scan for CXL capability on anything
> > > that claims to be an upstream port. You could also save another
> > > pci_walk_bus() by doing the dport check here too... i.e.
> > >
> > > if (type == PCI_EXP_TYPE_DOWNSTREAM) {
> > >     port = find_cxl_port(pdev->parent);
> > >     ...determine id and component reg base...
> > >     cxl_add_dport(port, pdev, ...);
> > > }
> > >
> >
> > find_cxl_port handwave is where I was asking for advice. I believe I know how to
> > implement find_cxl_port(struct pci_dev *upstream_port), but...
> >
> > (see bottom of email for sample with everything)
> >
> >
> > > > +
> > > > +       /* Get component registers */
> > > > +       rc = cxl_find_register_block(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
> > > > +       if (rc) {
> > > > +               ctx->error = rc;
> > > > +       }
> > > > +
> > > > +       /* to_pci_dev(dev->parent) == downstream port, or root port */
> > > > +       /* to_pci_dev(dev->parent->parent) == upstream port, or hostbridge */
> > > > +
> > > > +       if (dev_WARN_ONCE(dev, dev->parent->parent == NULL,
> > > > +                         "No valid parent\n")) {
> > > > +               ctx->error = -ENODEV;
> > > > +               parent_port = NULL;
> > >
> > > Not sure what this is for? I would think filtering pci_walk_bus() by
> > > PCI_EXP_TYPE_{UP,DOWN}STREAM is sufficient and that this association
> > > is assumed.
> > >
> > > > +       } else {
> > > > +               parent_port = to_cxl_port(dev->parent->parent);
> > >
> > > No, you can't walk from a pci device to a cxl port, so it would need
> > > something like find_cxl_port() like I handwaved above.
> > >
> >
> > This is fundamentally where I'm "stuck". As I add switches, I need to get to the
> > parent port and I do not know how to do that. Is it safe to do
> > find_cxl_port(dev->parent->parent)?
> 
> Yes, but only if you start the walk from dport->subordinate otherwise
> this walks off the top of the hierarchy.
> 
> >
> > > > +       }
> > > > +
> > > > +       devm_cxl_add_port(ctx->dev, dev,
> > > > +                         pci_resource_start(pdev, map.barno) +
> > > > +                                 map.block_offset,
> > > > +                         parent_port);
> > > > +
> > > > +       return 0;
> > > > +}
> > > > +
> > > > +int enumerate_ports_from_root_port(struct cxl_port *root_port)
> > > > +{
> > > > +       struct device *d = root_port->uport;
> > > > +       struct cxl_walk_context ctx;
> > > > +       struct pci_dev *pdev;
> > > > +
> > > > +       if (!dev_is_pci(d))
> > > > +               return -ENODEV;
> > > > +
> > > > +       pdev = to_pci_dev(d);
> > > > +       ctx = (struct cxl_walk_context){
> > > > +               .dev = d,
> > > > +               .root = pdev->bus,
> > > > +               .port = root_port,
> > > > +       };
> > > > +
> > > > +       pci_walk_bus(pdev->bus, match_add_switches, &ctx);
> > > > +
> > > > +       return 0;
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(enumerate_ports_from_root_port);
> > > > +
> > > >  static struct cxl_dport *find_dport(struct cxl_port *port, int id)
> > > >  {
> > > >         struct cxl_dport *dport;
> > > >
> > > > base-commit: 5c46722547fb375f460dbe293f40fad0ca32ab90
> > > > prerequisite-patch-id: f3e7ffbd5f60cd3f55ad8e174afd9d8c37d546f4
> > > > prerequisite-patch-id: a74a0ce5f4a1e4cec50e68181fcbb92624cb0687
> > > > prerequisite-patch-id: 3e2e86cbc2631b99c1b5c0179f35799d3df31f91
> > > > prerequisite-patch-id: 68cf009af310e296626b7842fc798fc778fcc98e
> > > > prerequisite-patch-id: 4063abbb095774d723ad727cb91bc8576d6a5532
> > > > prerequisite-patch-id: 3f11cc68d4dfc7f578f8c6a440663e9ef4e27466
> > > > prerequisite-patch-id: 5ef0b7ff2acf5896b955dd4f70a06581f42d7904
> > > > prerequisite-patch-id: 8cc6066d94bc859ff094c056d77eb63a967a3657
> > > > prerequisite-patch-id: b4fa2b34c36f3068743c965ebc01462ab016df4d
> > > > prerequisite-patch-id: a8798a409f1ff81979fb35a2c66a991ba6cc69f5
> > > > prerequisite-patch-id: d68e5ca2dbd408f206acb40c54f1ed9e6d981aa0
> > > > --
> > > > 2.33.0
> > > >
> >
> > int match_port(struct device *dev, const void *data)
> > {
> >         struct pci_dev *pdev = data;
> >
> >         if (!is_cxl_port(dev))
> >                 return 0;
> >
> >         return to_cxl_port(dev)->uport == &pdev->dev;
> > }
> >
> > struct cxl_port *find_cxl_port(struct pci_dev *upstream_port)
> > {
> >         struct device *port_dev;
> >
> >         port_dev = bus_find_device(&cxl_bus_type, NULL, upstream_port, match_port);
> >         if (port_dev)
> >                 return to_cxl_port(port_dev);
> >
> >         return NULL;
> > }
> >
> > static int match_add_switches(struct pci_dev *pdev, void *data)
> > {
> >         ...
> >         dev = &pdev->dev;
> >
> >         if (type == PCI_EXP_TYPE_UPSTREAM) {
> >                 parent_port = find_cxl_port(dev->parent->parent);
> 
> Looks good.
> 
> For the final code you'll probably want to do find_cxl_port(dev) first
> just to make sure you're not adding a port for a switch that was
> scanned before in a previous API call.
> 
> >                 if (!parent_port)
> >                         return 1;
> >
> >                 port = devm_cxl_add_port(..., parent_port); //upstream port
> 
> Looks good.
> 
> For the final code it will want a "put_device(&parent_port->dev)" here
> to undo the reference taken by bus_find_device().
> 
> >                 return 0;
> >         }
> >
> >         if (type == PCI_EXP_TYPE_DOWNSTREAM) {
> >                 uport = find_cxl_port(dev->parent);
> >                 // get component reg base of dport
> >                 cxl_add_dport(uport, dev, ...)
> 
> Looks good.
> 
> >         }
> >
> >         return 0;
> > }
> >
> > {
> > ... pci_walk_bus(pdev->bus, match_add_switches, &ctx);
> 
> Per-above you probably want to start the scan below each root port, or
> otherwise filter out the top-level scan work that cxl_acpi owns.

The scan will skip everything until it finds a USP or DSP which cxl_acpi
wouldn't be touching. I don't have any issue with:

>         list_for_each_entry(dport, &root_port->dports, list)
>                 pci_walk_bus(dport->subordinate, match_uport, ctx);

but I don't see any issue with the current code either. Did I miss something?
