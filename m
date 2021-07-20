Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3151CC07E9B
	for <linux-cxl@archiver.kernel.org>; Tue, 20 Jul 2021 23:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1899D61001
	for <linux-cxl@archiver.kernel.org>; Tue, 20 Jul 2021 23:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbhGTXDL (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 20 Jul 2021 19:03:11 -0400
Received: from mga06.intel.com ([134.134.136.31]:49148 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235087AbhGTXCf (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Tue, 20 Jul 2021 19:02:35 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10051"; a="272459883"
X-IronPort-AV: E=Sophos;i="5.84,256,1620716400"; 
   d="scan'208";a="272459883"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2021 16:43:12 -0700
X-IronPort-AV: E=Sophos;i="5.84,256,1620716400"; 
   d="scan'208";a="495075686"
Received: from lesliemu-mobl1.amr.corp.intel.com (HELO intel.com) ([10.252.136.56])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2021 16:43:11 -0700
Date:   Tue, 20 Jul 2021 16:43:07 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH v2] cxl: Enable an endpoint decoder type
Message-ID: <20210720234307.qacrosxfaogn5app@intel.com>
References: <20210702040009.68794-1-ben.widawsky@intel.com>
 <20210706160050.527553-1-ben.widawsky@intel.com>
 <CAPcyv4g8XqzbwtSP3Hdww5nUvB9Hz--QL9Z_h56XfxTQMdMxmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4g8XqzbwtSP3Hdww5nUvB9Hz--QL9Z_h56XfxTQMdMxmw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 21-07-09 16:56:48, Dan Williams wrote:
> On Tue, Jul 6, 2021 at 9:01 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
> >
> > CXL memory devices support HDM decoders. Currently, when a decoder is
> > instantiated there is no knowledge of the type of decoder; only the
> > underlying endpoint type is specified. In order to have the memory
> > devices reuse the existing decoder creation infrastructure it is
> > convenient to pass along the type of decoder on creation.
> >
> > The primary difference for an endpoint decoder is that it doesn't have
> > dports, nor targets. The target is just the underlying media (with
> > offset).
> >
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > ---
> >
> > v2 Fixes target_type and stores the decoder type on instantiation
> 
> This depends on the memdev driver series? It's not applying for me on
> top of cxl.git#next.
> 
> >
> > diff --git a/drivers/cxl/core.c b/drivers/cxl/core.c
> > index 196f260e2580..69acdd230f54 100644
> > --- a/drivers/cxl/core.c
> > +++ b/drivers/cxl/core.c
> > @@ -493,10 +493,11 @@ cxl_decoder_alloc(struct cxl_port *port, int nr_targets, resource_size_t base,
> >                         .start = base,
> >                         .end = base + len - 1,
> >                 },
> > +               .type = type,
> 
> ...but there's already the dev->type?
> 
> >                 .flags = flags,
> >                 .interleave_ways = interleave_ways,
> >                 .interleave_granularity = interleave_granularity,
> > -               .target_type = type,
> > +               .target_type = CXL_DEVICE_EXPANDER,
> 
> In the cxl-switch case how to indicate that only type-2 targets are supported?
> 
> I do think I misnamed the cxl_decoder_type. I also did not make it
> clear that root decoders don't have a target type, they have a set of
> flags indicating their restrictions, and unlike switch level decoders
> they can support targeting both accelerators and expanders in the same
> windows. I think the decoder can still be just the dev->type, but
> there needs to be separate helpers for the 3 cases you have
> identified. Something like the following where devm_cxl_add_decoder()
> because private to the core:
> 
> devm_cxl_add_platform_decoder(struct device *host, int nr_targets,
>                               resource_size_t base, resource_size_t len,
>                               int interleave_ways, int interleave_granularity,
>                               unsigned long flags)
> {
>         return devm_cxl_add_decoder(host, NULL, nr_targets, base, len,
>                                     interleave_ways, interleave_granularity,
>                                     0, flags);
> }

How do you want me to handle the existing parent (ACPI0017) and child (ACPI0016)
relationships? I see no reason to preserve this, but perhaps you know something
I don't.

> 
> devm_cxl_add_switch_decoder(struct device *host, struct cxl_port *port,
>                             enum cxl_decoder_type type)
> {
>         return devm_cxl_add_decoder(host, port, 0, 0, 0, 0, 0,
>                                     CXL_DECODER_UNKNOWN, 0);
> }
> 
> devm_cxl_add_endpoint_decoder(struct device *host, struct cxl_port *port,
>                               enum cxl_decoder_type type)
> {
>         return devm_cxl_add_decoder(host, port, 0, 0, 0, 0, 0, type,
>                                     CXL_DECODER_F_ENDPOINT);
> }
> 
> ...where 0 values are filled in by the decoder driver init or N/A.
> Presumably the memdev driver calling devm_cxl_add_endpoint_decoder()
> will know whether it is an expander or an accelerator. Although given
> there are no CXL accelerator drivers on the horizon, maybe even that
> degree of freedom can be hidden for now.
> 
> Then the dev->type determination is:
> 
> platform => no parent cxl_port
> switch => parent cxl_port and flags does not have CXL_DECODER_F_ENDPOINT
> endpoint =>  parent cxl_port and flags has CXL_DECODER_F_ENDPOINT
> 
> ...and probably s/cxl_decoder_type/cxl_target_type/ to make it clear
> that it's not related to the cxl_decoder_X_type dev->type value.
> 
> >         };
> >
> >         /* handle implied target_list */
> >
> > ---
> >  drivers/cxl/acpi.c |  2 +-
> >  drivers/cxl/core.c | 46 ++++++++++++++++++++++++++++++++++------------
> >  drivers/cxl/cxl.h  | 31 +++++++++++++++++++++++++++----
> >  3 files changed, 62 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > index 8ae89273f58e..5215845e0f89 100644
> > --- a/drivers/cxl/acpi.c
> > +++ b/drivers/cxl/acpi.c
> > @@ -114,7 +114,7 @@ static void cxl_add_cfmws_decoders(struct device *dev,
> >                                             cfmws->base_hpa, cfmws->window_size,
> >                                             CFMWS_INTERLEAVE_WAYS(cfmws),
> >                                             CFMWS_INTERLEAVE_GRANULARITY(cfmws),
> > -                                           CXL_DECODER_EXPANDER,
> > +                                           CXL_DECODER_PLATFORM,
> >                                             flags);
> >
> >                 if (IS_ERR(cxld)) {
> > diff --git a/drivers/cxl/core.c b/drivers/cxl/core.c
> > index a2e4d54fc7bc..69acdd230f54 100644
> > --- a/drivers/cxl/core.c
> > +++ b/drivers/cxl/core.c
> > @@ -75,9 +75,9 @@ static ssize_t target_type_show(struct device *dev,
> >         struct cxl_decoder *cxld = to_cxl_decoder(dev);
> >
> >         switch (cxld->target_type) {
> > -       case CXL_DECODER_ACCELERATOR:
> > +       case CXL_DEVICE_ACCELERATOR:
> >                 return sysfs_emit(buf, "accelerator\n");
> > -       case CXL_DECODER_EXPANDER:
> > +       case CXL_DEVICE_EXPANDER:
> >                 return sysfs_emit(buf, "expander\n");
> >         }
> >         return -ENXIO;
> > @@ -167,6 +167,12 @@ static const struct attribute_group *cxl_decoder_switch_attribute_groups[] = {
> >         NULL,
> >  };
> >
> > +static const struct attribute_group *cxl_decoder_endpoint_attribute_groups[] = {
> > +       &cxl_decoder_base_attribute_group,
> > +       &cxl_base_attribute_group,
> > +       NULL,
> > +};
> > +
> >  static void cxl_decoder_release(struct device *dev)
> >  {
> >         struct cxl_decoder *cxld = to_cxl_decoder(dev);
> > @@ -176,6 +182,12 @@ static void cxl_decoder_release(struct device *dev)
> >         kfree(cxld);
> >  }
> >
> > +static const struct device_type cxl_decoder_endpoint_type = {
> > +       .name = "cxl_decoder_endpoint",
> > +       .release = cxl_decoder_release,
> > +       .groups = cxl_decoder_endpoint_attribute_groups,
> > +};
> > +
> >  static const struct device_type cxl_decoder_switch_type = {
> >         .name = "cxl_decoder_switch",
> >         .release = cxl_decoder_release,
> > @@ -458,12 +470,14 @@ cxl_decoder_alloc(struct cxl_port *port, int nr_targets, resource_size_t base,
> >         if (interleave_ways < 1)
> >                 return ERR_PTR(-EINVAL);
> >
> > -       device_lock(&port->dev);
> > -       if (list_empty(&port->dports))
> > -               rc = -EINVAL;
> > -       device_unlock(&port->dev);
> > -       if (rc)
> > -               return ERR_PTR(rc);
> > +       if (type != CXL_DECODER_ENDPOINT) {
> > +               device_lock(&port->dev);
> > +               if (list_empty(&port->dports))
> > +                       rc = -EINVAL;
> > +               device_unlock(&port->dev);
> > +               if (rc)
> > +                       return ERR_PTR(rc);
> > +       }
> >
> >         cxld = kzalloc(struct_size(cxld, target, nr_targets), GFP_KERNEL);
> >         if (!cxld)
> > @@ -479,10 +493,11 @@ cxl_decoder_alloc(struct cxl_port *port, int nr_targets, resource_size_t base,
> >                         .start = base,
> >                         .end = base + len - 1,
> >                 },
> > +               .type = type,
> >                 .flags = flags,
> >                 .interleave_ways = interleave_ways,
> >                 .interleave_granularity = interleave_granularity,
> > -               .target_type = type,
> > +               .target_type = CXL_DEVICE_EXPANDER,
> >         };
> >
> >         /* handle implied target_list */
> > @@ -496,10 +511,17 @@ cxl_decoder_alloc(struct cxl_port *port, int nr_targets, resource_size_t base,
> >         dev->bus = &cxl_bus_type;
> >
> >         /* root ports do not have a cxl_port_type parent */
> > -       if (port->dev.parent->type == &cxl_port_type)
> > -               dev->type = &cxl_decoder_switch_type;
> > -       else
> > +       switch (type) {
> > +       case CXL_DECODER_PLATFORM:
> >                 dev->type = &cxl_decoder_root_type;
> > +               break;
> > +       case CXL_DECODER_SWITCH:
> > +               dev->type = &cxl_decoder_switch_type;
> > +               break;
> > +       case CXL_DECODER_ENDPOINT:
> > +               dev->type = &cxl_decoder_endpoint_type;
> > +               break;
> > +       }
> >
> >         return cxld;
> >  err:
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index b6bda39a59e3..02e0af4c147c 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -164,6 +164,11 @@ int cxl_map_device_regs(struct pci_dev *pdev,
> >  #define CXL_RESOURCE_NONE ((resource_size_t) -1)
> >  #define CXL_TARGET_STRLEN 20
> >
> > +enum cxl_device_type {
> > +       CXL_DEVICE_ACCELERATOR = 2,
> > +       CXL_DEVICE_EXPANDER = 3,
> > +};
> > +
> >  /*
> >   * cxl_decoder flags that define the type of memory / devices this
> >   * decoder supports as well as configuration lock status See "CXL 2.0
> > @@ -177,8 +182,9 @@ int cxl_map_device_regs(struct pci_dev *pdev,
> >  #define CXL_DECODER_F_MASK  GENMASK(4, 0)
> >
> >  enum cxl_decoder_type {
> > -       CXL_DECODER_ACCELERATOR = 2,
> > -       CXL_DECODER_EXPANDER = 3,
> > +       CXL_DECODER_PLATFORM,
> > +       CXL_DECODER_SWITCH,
> > +       CXL_DECODER_ENDPOINT,
> >  };
> >
> >  /**
> > @@ -186,19 +192,36 @@ enum cxl_decoder_type {
> >   * @dev: this decoder's device
> >   * @id: kernel device name id
> >   * @range: address range considered by this decoder
> > + * @type: the type of this CXL decoder (platform, switch, endpoint)
> >   * @interleave_ways: number of cxl_dports in this decode
> >   * @interleave_granularity: data stride per dport
> >   * @target_type: accelerator vs expander (type2 vs type3) selector
> >   * @flags: memory type capabilities and locking
> >   * @target: active ordered target list in current decoder configuration
> > + *
> > + * Abstractly, a CXL decoder represents one of 3 possible decoders:
> 
> s/Abstractly, a/A/
> 
> Outside of that I like this documentation for describing the
> cxl_decoder_X_type options.
> 
> > + * 1. Platform specific routing - opaque rules for the memory controller that
> > + *    may be communicated via ACPI or devicetree. This decoding has implied
> > + *    interleave parameters as well as physical address ranges that are directed
> > + *    to the downstream ports of this decoder.
> > + * 2. HDM decoder for a switch. Similar to the platform specific routing in that
> > + *    it contains a set of downstream ports which receive and send traffic in an
> > + *    interleave fashion, the main difference is that the interleave and address
> > + *    ranges are controlled by the HDM decoder registers defined in the CXL 2.0
> > + *    specification.
> > + * 3. HDM decoder for an endpoint. Like the decoder in a switch, this decoder's
> > + *    configuration is entirely programmable and defined in CXL spec. Unlike the
> > + *    switch's decoder, there is not a set of downstream ports, only the
> > + *    underlying media.
> >   */
> >  struct cxl_decoder {
> >         struct device dev;
> >         int id;
> >         struct range range;
> > +       enum cxl_decoder_type type;
> >         int interleave_ways;
> >         int interleave_granularity;
> > -       enum cxl_decoder_type target_type;
> > +       enum cxl_device_type target_type;
> >         unsigned long flags;
> >         struct cxl_dport *target[];
> >  };
> > @@ -289,7 +312,7 @@ static inline struct cxl_decoder *
> >  devm_cxl_add_passthrough_decoder(struct device *host, struct cxl_port *port)
> >  {
> >         return devm_cxl_add_decoder(host, port, 1, 0, 0, 1, PAGE_SIZE,
> > -                                   CXL_DECODER_EXPANDER, 0);
> > +                                   CXL_DECODER_PLATFORM, 0);
> >  }
> >
> >  extern struct bus_type cxl_bus_type;
> > --
> > 2.32.0
> >
