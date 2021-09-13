Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B78C433EF
	for <linux-cxl@archiver.kernel.org>; Mon, 13 Sep 2021 16:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2A8460EE5
	for <linux-cxl@archiver.kernel.org>; Mon, 13 Sep 2021 16:20:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbhIMQVQ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 13 Sep 2021 12:21:16 -0400
Received: from mga01.intel.com ([192.55.52.88]:3398 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229614AbhIMQVP (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Mon, 13 Sep 2021 12:21:15 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10106"; a="244047141"
X-IronPort-AV: E=Sophos;i="5.85,290,1624345200"; 
   d="scan'208";a="244047141"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2021 09:19:59 -0700
X-IronPort-AV: E=Sophos;i="5.85,290,1624345200"; 
   d="scan'208";a="609067345"
Received: from dvannith-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.128.229])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2021 09:19:58 -0700
Date:   Mon, 13 Sep 2021 09:19:57 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH 04/13] cxl: Introduce endpoint decoders
Message-ID: <20210913161957.qzaoibfalyoamc5c@intel.com>
References: <20210902195017.2516472-1-ben.widawsky@intel.com>
 <20210902195017.2516472-5-ben.widawsky@intel.com>
 <20210903153542.00004518@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210903153542.00004518@Huawei.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 21-09-03 15:35:42, Jonathan Cameron wrote:
> On Thu, 2 Sep 2021 12:50:08 -0700
> Ben Widawsky <ben.widawsky@intel.com> wrote:
> 
> > Endpoints have decoders too. It is useful to share the same
> > infrastructure from cxl_core. Endpoints do not have dports (downstream
> > targets), only the underlying physical medium. As a result, some special
> > casing is needed.
> > 
> > There is no functional change introduced yet as endpoints don't actually
> > enumerate decoders yet.
> > 
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> 
> Comments inline...
> 
> > ---
> >  drivers/cxl/core/bus.c | 29 +++++++++++++++++++++++++----
> >  1 file changed, 25 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
> > index 8d5061b0794d..6202ce5a5ac2 100644
> > --- a/drivers/cxl/core/bus.c
> > +++ b/drivers/cxl/core/bus.c
> > @@ -175,6 +175,12 @@ static const struct attribute_group *cxl_decoder_switch_attribute_groups[] = {
> >  	NULL,
> >  };
> >  
> > +static const struct attribute_group *cxl_decoder_endpoint_attribute_groups[] = {
> > +	&cxl_decoder_base_attribute_group,
> > +	&cxl_base_attribute_group,
> > +	NULL,
> > +};
> > +
> >  static void cxl_decoder_release(struct device *dev)
> >  {
> >  	struct cxl_decoder *cxld = to_cxl_decoder(dev);
> > @@ -184,6 +190,12 @@ static void cxl_decoder_release(struct device *dev)
> >  	kfree(cxld);
> >  }
> >  
> > +static const struct device_type cxl_decoder_endpoint_type = {
> > +	.name = "cxl_decoder_endpoint",
> > +	.release = cxl_decoder_release,
> > +	.groups = cxl_decoder_endpoint_attribute_groups,
> > +};
> > +
> >  static const struct device_type cxl_decoder_switch_type = {
> >  	.name = "cxl_decoder_switch",
> >  	.release = cxl_decoder_release,
> > @@ -196,6 +208,11 @@ static const struct device_type cxl_decoder_root_type = {
> >  	.groups = cxl_decoder_root_attribute_groups,
> >  };
> >  
> > +static bool is_endpoint_decoder(struct device *dev)
> > +{
> > +	return dev->type == &cxl_decoder_endpoint_type;
> > +}
> > +
> >  bool is_root_decoder(struct device *dev)
> >  {
> >  	return dev->type == &cxl_decoder_root_type;
> > @@ -472,7 +489,7 @@ struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port, int nr_targets)
> >  	struct device *dev;
> >  	int rc = 0;
> >  
> > -	if (nr_targets > CXL_DECODER_MAX_INTERLEAVE || nr_targets < 1)
> 
> Why do we let nr_targets go negative?  Could make the parameter unsigned perhaps or
> check for that here (even though it makes no sense).

Unsigned seems like a good idea to me as well.

> 
> > +	if (nr_targets > CXL_DECODER_MAX_INTERLEAVE)
> >  		return ERR_PTR(-EINVAL);
> >  
> >  	cxld = kzalloc(struct_size(cxld, target, nr_targets), GFP_KERNEL);
> > @@ -491,8 +508,11 @@ struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port, int nr_targets)
> >  	dev->parent = &port->dev;
> >  	dev->bus = &cxl_bus_type;
> >  
> > +	/* Endpoints don't have a target list */
> > +	if (nr_targets == 0)
> > +		dev->type = &cxl_decoder_endpoint_type;
> 
> Hmm. Whilst the check seems valid, it's a bit inelegant.
> The capability register unhelpfully simply has it defined
> as not applicable rather than 0, so I'd be nervous that might
> end up here (not checked yet).

AFAICT, 0 isn't a valid value in the register at all. Additionally, from the API
perspective I don't see much of an issue because nr_targets is the decoded
value. So the only entity that should call this with a value of 0 would have to
be something which is ignoring the field in the capability register, which would
only be an endpoint.

> 
> >  	/* root ports do not have a cxl_port_type parent */
> > -	if (port->dev.parent->type == &cxl_port_type)
> > +	else if (port->dev.parent->type == &cxl_port_type)
> >  		dev->type = &cxl_decoder_switch_type;
> >  	else
> >  		dev->type = &cxl_decoder_root_type;
> > @@ -532,9 +552,11 @@ int cxl_decoder_add(struct device *host, struct cxl_decoder *cxld,
> >  	if (IS_ERR(cxld))
> >  		return PTR_ERR(cxld);
> >  
> > +	dev = &cxld->dev;
> > +
> >  	port = to_cxl_port(cxld->dev.parent);
> >  	device_lock(&port->dev);
> > -	if (list_empty(&port->dports)) {
> > +	if (is_endpoint_decoder(dev) && list_empty(&port->dports)) {
> >  		rc = -EINVAL;
> >  		goto out_unlock;
> >  	}
> > @@ -551,7 +573,6 @@ int cxl_decoder_add(struct device *host, struct cxl_decoder *cxld,
> >  	}
> >  	device_unlock(&port->dev);
> >  
> > -	dev = &cxld->dev;
> >  	rc = dev_set_name(dev, "decoder%d.%d", port->id, cxld->id);
> >  	if (rc)
> >  		return rc;
> 
