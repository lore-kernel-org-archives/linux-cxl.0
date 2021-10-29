Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0DE6C433F5
	for <linux-cxl@archiver.kernel.org>; Fri, 29 Oct 2021 22:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADBCD60187
	for <linux-cxl@archiver.kernel.org>; Fri, 29 Oct 2021 22:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbhJ2WFa (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 29 Oct 2021 18:05:30 -0400
Received: from mga07.intel.com ([134.134.136.100]:60525 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231173AbhJ2WF3 (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Fri, 29 Oct 2021 18:05:29 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10152"; a="294222595"
X-IronPort-AV: E=Sophos;i="5.87,193,1631602800"; 
   d="scan'208";a="294222595"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2021 15:03:00 -0700
X-IronPort-AV: E=Sophos;i="5.87,193,1631602800"; 
   d="scan'208";a="448264898"
Received: from applebex-mobl2.amr.corp.intel.com (HELO intel.com) ([10.252.137.25])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2021 15:03:00 -0700
Date:   Fri, 29 Oct 2021 15:02:58 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Chet Douglas <chet.r.douglas@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [RFC PATCH v2 06/28] cxl: Introduce endpoint decoders
Message-ID: <20211029220258.ghqdgnehg6ptjy3e@intel.com>
References: <20211022183709.1199701-1-ben.widawsky@intel.com>
 <20211022183709.1199701-7-ben.widawsky@intel.com>
 <CAPcyv4iiMFCUEg+8zk6yqSmA_9jXjkjkEpYdj4zVr8n=GbodvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4iiMFCUEg+8zk6yqSmA_9jXjkjkEpYdj4zVr8n=GbodvA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 21-10-29 14:00:21, Dan Williams wrote:
> On Fri, Oct 22, 2021 at 11:37 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
> >
> > Endpoints have decoders too. It is useful to share the same
> > infrastructure from cxl_core. Endpoints do not have dports (downstream
> > targets), only the underlying physical medium. As a result, some special
> > casing is needed.
> >
> > There is no functional change introduced yet as endpoints don't actually
> > enumerate decoders yet.
> 
> The nr_targets type change either needs to be commented on here, or
> moved to its own patch.

Do you have a preference?

> 
> Otherwise, this looks good.
> 
> >
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > ---
> >  drivers/cxl/core/bus.c | 40 ++++++++++++++++++++++++++++++++--------
> >  drivers/cxl/cxl.h      |  3 ++-
> >  2 files changed, 34 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
> > index 454d4d846eb2..5564a71773e2 100644
> > --- a/drivers/cxl/core/bus.c
> > +++ b/drivers/cxl/core/bus.c
> > @@ -175,6 +175,12 @@ static const struct attribute_group *cxl_decoder_switch_attribute_groups[] = {
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
> > @@ -184,6 +190,12 @@ static void cxl_decoder_release(struct device *dev)
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
> > @@ -196,6 +208,11 @@ static const struct device_type cxl_decoder_root_type = {
> >         .groups = cxl_decoder_root_attribute_groups,
> >  };
> >
> > +static bool is_endpoint_decoder(struct device *dev)
> > +{
> > +       return dev->type == &cxl_decoder_endpoint_type;
> > +}
> > +
> >  bool is_root_decoder(struct device *dev)
> >  {
> >         return dev->type == &cxl_decoder_root_type;
> > @@ -483,7 +500,8 @@ static int decoder_populate_targets(struct cxl_decoder *cxld,
> >         return rc;
> >  }
> >
> > -struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port, int nr_targets)
> > +struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port,
> > +                                     unsigned int nr_targets)
> >  {
> >         struct cxl_decoder *cxld, cxld_const_init = {
> >                 .nr_targets = nr_targets,
> > @@ -491,7 +509,7 @@ struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port, int nr_targets)
> >         struct device *dev;
> >         int rc = 0;
> >
> > -       if (nr_targets > CXL_DECODER_MAX_INTERLEAVE || nr_targets < 1)
> > +       if (nr_targets > CXL_DECODER_MAX_INTERLEAVE)
> >                 return ERR_PTR(-EINVAL);
> >
> >         cxld = kzalloc(struct_size(cxld, target, nr_targets), GFP_KERNEL);
> > @@ -510,8 +528,11 @@ struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port, int nr_targets)
> >         dev->parent = &port->dev;
> >         dev->bus = &cxl_bus_type;
> >
> > +       /* Endpoints don't have a target list */
> > +       if (nr_targets == 0)
> > +               dev->type = &cxl_decoder_endpoint_type;
> >         /* root ports do not have a cxl_port_type parent */
> > -       if (port->dev.parent->type == &cxl_port_type)
> > +       else if (port->dev.parent->type == &cxl_port_type)
> >                 dev->type = &cxl_decoder_switch_type;
> >         else
> >                 dev->type = &cxl_decoder_root_type;
> > @@ -538,12 +559,15 @@ int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map)
> >         if (cxld->interleave_ways < 1)
> >                 return -EINVAL;
> >
> > -       port = to_cxl_port(cxld->dev.parent);
> > -       rc = decoder_populate_targets(cxld, port, target_map);
> > -       if (rc)
> > -               return rc;
> > -
> >         dev = &cxld->dev;
> > +
> > +       port = to_cxl_port(cxld->dev.parent);
> > +       if (!is_endpoint_decoder(dev)) {
> > +               rc = decoder_populate_targets(cxld, port, target_map);
> > +               if (rc)
> > +                       return rc;
> > +       }
> > +
> >         rc = dev_set_name(dev, "decoder%d.%d", port->id, cxld->id);
> >         if (rc)
> >                 return rc;
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index 7f2e2bdc7883..91b8fd54bc93 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -293,7 +293,8 @@ int cxl_add_dport(struct cxl_port *port, struct device *dport, int port_id,
> >
> >  struct cxl_decoder *to_cxl_decoder(struct device *dev);
> >  bool is_root_decoder(struct device *dev);
> > -struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port, int nr_targets);
> > +struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port,
> > +                                     unsigned int nr_targets);
> >  int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map);
> >  int cxl_decoder_autoremove(struct device *host, struct cxl_decoder *cxld);
> >
> > --
> > 2.33.1
> >
