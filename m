Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F1BC433EF
	for <linux-cxl@archiver.kernel.org>; Mon, 27 Sep 2021 21:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6813460F4A
	for <linux-cxl@archiver.kernel.org>; Mon, 27 Sep 2021 21:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237202AbhI0Vv2 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 27 Sep 2021 17:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237009AbhI0Vv1 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 27 Sep 2021 17:51:27 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E29EC061575
        for <linux-cxl@vger.kernel.org>; Mon, 27 Sep 2021 14:49:49 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 17so19057620pgp.4
        for <linux-cxl@vger.kernel.org>; Mon, 27 Sep 2021 14:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xfvVrQzPhhSy06NfKkwIImGYSRGjt2Ahkk5150tNTxE=;
        b=OwAswgco/2D+E18T7s/uzOp9Sqo7D5bwGJtsJbLXOVTkB4+rDVJCleXjfwiyVUulR8
         ptnXK7k/b4Q3fg4xvWw0J/KHP+BVZ7NjqthOIBdiRRfaXaq0DIkRYas6IWK86cdrBETd
         QqW7xgTz7b+OBbQSEKOVOVLlfZLPVSnFS/YAaLmEr+Uo7FzHCAUNYpXdn29jFqjOibIa
         Bzd21OhltAKIywubz/F01deVGV1kVyR9flRrZPW0dZtK2iCyLUb4A87rtw22TAH6L8/5
         SDn6WRmVNUT0uQl8dnVe7Dg4NKF6wLbpB9Ry167+mRCWKUQtxWHp+fmol484zU3nQpcR
         iibw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xfvVrQzPhhSy06NfKkwIImGYSRGjt2Ahkk5150tNTxE=;
        b=2rZKFApYsQY1VTb+rbx0XhUVNM/v5Xx+TIlNcQ5nv64xu3yQ4Xr5BDAY2GbxP4Am/2
         Fg4jOaKfON8wnT91lD7yMqFoqs1Eptbh6rCjaXsmEehZKsCuOHdZu7lXzk9esv8mAVgb
         QnRs84NpgdV4O749GqlmSnv69R/cpLZu6syMTFdQRhVbbOFEriEnUgSzQv+XP22FMOeJ
         9SMeT8FS2hbmMNeGhU5NhT0VfhF4yfdj1yYRwqjHoJdPbSug1Nya+0USywAVpnPqGJwM
         GfRNgBkFrdX0yzqU7/5SIvYYddl/YLbPiBWz4ptwfDsJ6BEjaW4P7cYw1KDzfsAAXuWz
         tvEQ==
X-Gm-Message-State: AOAM531L2CSAWM5kHnHcZDKtAV0dRuwC1QOFRKLCFAJw8PZrrBTfhCoO
        FtOm6kX3+frvnLCnDhYp1M6zpkiS3jCmzkoQZWk0cA==
X-Google-Smtp-Source: ABdhPJwBdW0pR7/obCCvgZ3xHcUDxuHOyoCkk81ahHDRq8GywzWDinc1KAX2YPBYfJJ/bOXGDFJ8EKY14aaiYSiNaqc=
X-Received: by 2002:a62:7f87:0:b0:444:b077:51ef with SMTP id
 a129-20020a627f87000000b00444b07751efmr1820824pfd.61.1632779388734; Mon, 27
 Sep 2021 14:49:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210924212817.489801-1-ben.widawsky@intel.com>
In-Reply-To: <20210924212817.489801-1-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 27 Sep 2021 14:49:40 -0700
Message-ID: <CAPcyv4gsVCoaqX81q57XZSAOqQmdLbdruGGxBpOk59nNRn+hXg@mail.gmail.com>
Subject: Re: [RFC PATCH] cxl: switch usp to parent cxl_port
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Sep 24, 2021 at 2:28 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> Hi Dan.
>
> As discussed in #cxl, I'm trying to do the switch enumeration and not entirely
> sure of the best way to go about it (and no real way to test it). Do you have a
> proposed way to do this better?
>
>
> ---
>  drivers/cxl/core/bus.c | 65 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
>
> diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
> index 936b6b5665c3..372d30b4bafd 100644
> --- a/drivers/cxl/core/bus.c
> +++ b/drivers/cxl/core/bus.c
> @@ -419,6 +419,71 @@ struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
>  }
>  EXPORT_SYMBOL_GPL(devm_cxl_add_port);
>
> +static int match_add_switches(struct pci_dev *pdev, void *data)
> +{
> +       struct cxl_walk_context *ctx = data;
> +       struct pci_bus *root_bus = ctx->root;
> +       struct device *dev = &pdev->dev;
> +       int type = pci_pcie_type(pdev);
> +       struct cxl_port *parent_port;
> +       struct cxl_register_map map;
> +       int rc;
> +
> +       if (pdev->bus != root_bus)
> +               return 0;

This bus is the peer-bus of the other root ports in the system. You
would want to be scanning the buses of the switch's subordinate
downstream ports. Also I don't think you want to filter by bus, and
just let pci_walk_bus() iterate the full sub-hierarchy.

So if pdev is a CXL uport, then the next uport would be on one of the
subordinate bridges. With the expectation that each cxl_port includes
a listing of its dports I would expect something like:

        list_for_each_entry(dport, &root_port->dports, list)
                pci_walk_bus(dport->subordinate, match_uport, ctx);

> +
> +       if (!pci_is_pcie(pdev))
> +               return 0;
> +       if (type != PCI_EXP_TYPE_UPSTREAM)
> +               return 0;

Yes, assuming that that pci_walk_bus() scans bridges before descending
to the next level you can try to scan for CXL capability on anything
that claims to be an upstream port. You could also save another
pci_walk_bus() by doing the dport check here too... i.e.

if (type == PCI_EXP_TYPE_DOWNSTREAM) {
    port = find_cxl_port(pdev->parent);
    ...determine id and component reg base...
    cxl_add_dport(port, pdev, ...);
}

> +
> +       /* Get component registers */
> +       rc = cxl_find_register_block(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
> +       if (rc) {
> +               ctx->error = rc;
> +       }
> +
> +       /* to_pci_dev(dev->parent) == downstream port, or root port */
> +       /* to_pci_dev(dev->parent->parent) == upstream port, or hostbridge */
> +
> +       if (dev_WARN_ONCE(dev, dev->parent->parent == NULL,
> +                         "No valid parent\n")) {
> +               ctx->error = -ENODEV;
> +               parent_port = NULL;

Not sure what this is for? I would think filtering pci_walk_bus() by
PCI_EXP_TYPE_{UP,DOWN}STREAM is sufficient and that this association
is assumed.

> +       } else {
> +               parent_port = to_cxl_port(dev->parent->parent);

No, you can't walk from a pci device to a cxl port, so it would need
something like find_cxl_port() like I handwaved above.

> +       }
> +
> +       devm_cxl_add_port(ctx->dev, dev,
> +                         pci_resource_start(pdev, map.barno) +
> +                                 map.block_offset,
> +                         parent_port);
> +
> +       return 0;
> +}
> +
> +int enumerate_ports_from_root_port(struct cxl_port *root_port)
> +{
> +       struct device *d = root_port->uport;
> +       struct cxl_walk_context ctx;
> +       struct pci_dev *pdev;
> +
> +       if (!dev_is_pci(d))
> +               return -ENODEV;
> +
> +       pdev = to_pci_dev(d);
> +       ctx = (struct cxl_walk_context){
> +               .dev = d,
> +               .root = pdev->bus,
> +               .port = root_port,
> +       };
> +
> +       pci_walk_bus(pdev->bus, match_add_switches, &ctx);
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(enumerate_ports_from_root_port);
> +
>  static struct cxl_dport *find_dport(struct cxl_port *port, int id)
>  {
>         struct cxl_dport *dport;
>
> base-commit: 5c46722547fb375f460dbe293f40fad0ca32ab90
> prerequisite-patch-id: f3e7ffbd5f60cd3f55ad8e174afd9d8c37d546f4
> prerequisite-patch-id: a74a0ce5f4a1e4cec50e68181fcbb92624cb0687
> prerequisite-patch-id: 3e2e86cbc2631b99c1b5c0179f35799d3df31f91
> prerequisite-patch-id: 68cf009af310e296626b7842fc798fc778fcc98e
> prerequisite-patch-id: 4063abbb095774d723ad727cb91bc8576d6a5532
> prerequisite-patch-id: 3f11cc68d4dfc7f578f8c6a440663e9ef4e27466
> prerequisite-patch-id: 5ef0b7ff2acf5896b955dd4f70a06581f42d7904
> prerequisite-patch-id: 8cc6066d94bc859ff094c056d77eb63a967a3657
> prerequisite-patch-id: b4fa2b34c36f3068743c965ebc01462ab016df4d
> prerequisite-patch-id: a8798a409f1ff81979fb35a2c66a991ba6cc69f5
> prerequisite-patch-id: d68e5ca2dbd408f206acb40c54f1ed9e6d981aa0
> --
> 2.33.0
>
