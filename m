Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29CD376EA
	for <linux-cxl@vger.kernel.org>; Tue, 30 Jan 2024 04:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706589449; cv=none; b=CbbhqMf/JQRu08YZJNJLkjTutEvj5/53r3zzYJX8NWLt40j+dHFhUk1q0cx9NKFOwRacB3QXeGLSIX/jKOyG2XEVka5MiyaTN2YqmzngmJd2O6lKvu2f8MtW2OdhO36NenXSIRyJ9/LJYlbpMkwXpy/P7Y9Ku+9uk7v48jDdZ6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706589449; c=relaxed/simple;
	bh=8K1O1n708QJ431fkIBq/4nZutVemSis/ylpSdIXxoAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kbz8jDo2GSqci2TGeEdemyNWRtv8ZUbXB/2PDIIL2RSXuvlhbYM5+umhbtHwiAwqkyVKkAj3/xEMGfOAfUQMu0Ln2d6vdJAA0DFncvdPlHygQRnyHMAj4Ic3heuZwQKMJD3GjaxhAKkM2MDhlQP3Y3KLA8UFr1yb6u6UqWL5af0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OdXVJtn1; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OdXVJtn1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706589447; x=1738125447;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=8K1O1n708QJ431fkIBq/4nZutVemSis/ylpSdIXxoAM=;
  b=OdXVJtn1OuMJY4nUm1bDoovsrNR+H/vRt9ysEOyjAR/CHxZfLIO3C80d
   HX1Pj4SvI0nKxLdb0lAywdVx7nIzhHL7BCEiMywgWLFuda+BfqctDF4VC
   cS8gn2Lxw6zZaZtE/LMV4TVURMETcFl68mzb/cjKGFTJmF9uA8uuwZ0bG
   2Y0h/gWEBRGNaoU93Txz1iYdrSQrlQJWLMMyIDc4dzSG/259e4pZa3ZnT
   Ej+J5qKj5DwBCvkSNIXTIAuLSMzSA82aQsXkplv+mtjP5mmYgFzKAuFKu
   ThHmUFfhxIe8gszl2mUByPSphklHrQ1Ec2RjGzDoeXrzOU4dOzwrbUjQc
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="9806607"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="9806607"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 20:37:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="822067068"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="822067068"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.57.56])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 20:37:25 -0800
Date: Mon, 29 Jan 2024 20:37:24 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Wonjae Lee <wj28.lee@samsung.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	KyungSan Kim <ks0204.kim@samsung.com>,
	Hojin Nam <hj96.nam@samsung.com>
Subject: Re: [RFC PATCH] cxl/region: Allow out of order assembly of
 autodiscovered regions
Message-ID: <Zbh9BMbpjr/qtVjE@aschofie-mobl2>
References: <20240113050421.1622533-1-alison.schofield@intel.com>
 <CGME20240113050447epcas2p2097a5c49c1f0f9318ec4202843e169b8@epcms2p8>
 <20240126085108epcms2p8bd88403c60851f769dd7b3ccb0755f05@epcms2p8>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240126085108epcms2p8bd88403c60851f769dd7b3ccb0755f05@epcms2p8>

On Fri, Jan 26, 2024 at 05:51:08PM +0900, Wonjae Lee wrote:
> Thank you for your quick response and sending the patch!
> 
> I'm very sorry for the delay in replying to your mail. It took some time to
> reproduce test and check the issue.
> 
> On Fri, Jan 12, 2024 at 09:04:21PM -0800, alison.schofield@intel.com wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> >
> > Wonjae Lee,
> >
> > Here is the RFC Patch I mentioned in this thread:
> > https://lore.kernel.org/linux-cxl/20240112092201epcms2p577b3c979bdc694a370e5952edc091f68@epcms2p5/
> >
> > This passes the cxl-test suite, so hoping no regression, but it needs
> > to be tested with the required config: 2 memdevs connected to the same
> > port, each memdev belongs to a different auto-region. Repeated attempts
> > should hit the test case and emit this debug message upon success:
> >  dev_dbg(&cxlr_a->dev, "allow out of order region ref alloc\n");
> >
> > Failure will be the HPA order violation message.
> >
> > All reviewers & testers welcomed.
> 
> After applying your patch to base-commit, I ran the same test I mentioned in
> the previous thread, and during the boot process, a null pointer dereference
> occurs as shown below:
> 
> thread: https://lore.kernel.org/linux-cxl/ZaFn0dfaJ8iOi1UW@aschofie-mobl2/T/#t
> base-commit: 3601311593eb44d34f142b993cb6f38f9a7863b3
> dmesg log:
> [] cxl region0: region sort successful
> [] cxl region0: mem1:endpoint6 decoder6.0 add: mem1:decoder6.0 @ 0 next: none nr_eps: 1 nr_targets: 1
> [] cxl region0: pci0000:3d:port1 decoder1.0 add: mem1:decoder6.0 @ 0 next: mem1 nr_eps: 1 nr_targets: 1
> [] BUG: kernel NULL pointer dereference, address: 00000000000002e8
> ...
> [] Call Trace:
> ...
> []  ? auto_order_ok+0x5f/0xb0 [cxl_core]
> []  cxl_region_attach_position+0x379/0x860 [cxl_core]
> []  cxl_region_attach+0x466/0x8b0 [cxl_core]
>  
>  
> To be specific, cxld_a in auto_order_ok() is NULL:
>     cxld_a = cxl_region_find_decoder(port, cxlr_a); /* cxld_a == NULL */
>  
> I've noticed that if I pass cxled as a function argument appropriately, and get
> cxld_a as shown below, the region initialization succeeds with the log "cxl
> region0: allow out of order region ref alloc" as you mention.
>  
> @@ -756,8 +756,8 @@ static struct cxl_decoder *cxl_region_find_decoder(struct cxl_port *port,
>         return to_cxl_decoder(dev);
>  }
> -bool auto_order_ok(struct cxl_port *port, struct cxl_region *cxlr_a,
> -                  struct cxl_region *cxlr_b)
> +bool auto_order_ok(struct cxl_port *port, struct cxl_endpoint_decoder *cxled,
> +                  struct cxl_region *cxlr_a, struct cxl_region *cxlr_b)
>  {
>         struct cxl_region_ref *cxl_rr;
>         struct cxl_decoder *cxld_a, *cxld_b;
> @@ -771,7 +771,10 @@ bool auto_order_ok(struct cxl_port *port, struct cxl_region *cxlr_a,
>         if (!test_bit(CXL_REGION_F_AUTO, &cxlr_a->flags))
>                 return false;
> 
> -       cxld_a = cxl_region_find_decoder(port, cxlr_a);
> +       if (port == cxled_to_port(cxled))
> +               cxld_a = &cxled->cxld;
> +       else
> +               cxld_a = cxl_region_find_decoder(port, cxlr_a);
> 
> I hope this helps.

Yes, this is very helpful! Glad to have you trying it out.

I think at this point we can call alloc_region_ref() with a known cxled
of this port and simply pass it on. I'm going to skip this if...else pattern,
and simply get cxld_a = &cxled->cxld;

I think there may be opportunity for refinements in cxl_region_find_decoder()
and it's descendants, but it's not directly tied to this patch.

Thanks,
Alison

> 
> Thanks,
> Wonjae
> 
> > Begin commit log:
> > Autodiscovered regions can fail to assemble if they are not discovered
> > in HPA decode order. The user will see failure messages like:
> >
> > [] cxl region0: endpoint5: HPA order violation region1
> > [] cxl region0: endpoint5: failed to allocate region reference
> >
> > The check that is causing the failure helps the CXL driver enforce
> > a CXL spec mandate that decoders be committed in HPA order. The
> > check is needless for autodiscovered regions since their decoders
> > are already programmed. Trying to enforce order in the assembly of
> > these regions is useless because they are assembled once all their
> > member endpoints arrive, and there is no guarantee on the order in
> > which endpoints are discovered during probe.
> >
> > Keep the existing check, but for autodiscovered regions, allow the
> > out of order assembly after a sanity check that the lowered numbered
> > decoder has the lower HPA starting address.
> >
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> >  drivers/cxl/core/region.c 34 +++++++++++++++++++++++++++++++++-
> >  1 file changed, 33 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 0f05692bfec3..8770ebcae05d 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -753,6 +753,37 @@ static struct cxl_decoder *cxl_region_find_decoder(struct cxl_port *port,
> >  return to_cxl_decoder(dev);
> >  }
> >
> > +bool auto_order_ok(struct cxl_port *port, struct cxl_region *cxlr_a,
> > +        struct cxl_region *cxlr_b)
> > +{
> > + struct cxl_region_ref *cxl_rr;
> > + struct cxl_decoder *cxld_a, *cxld_b;
> > +
> > + /*
> > +  * Allow the out of order assembly of auto-discovered regions as
> > +  * long as correct decoder programming order can be verified.
> > +  *
> > +  * Per CXL Spec 3.1 8.2.4.20.12 Committing Decoder Programming,
> > +  * software must commit decoders in HPA order. Therefore it is
> > +  * sufficient to sanity check that the lowered number decoder
> > +  * has the lower HPA starting address.
> > +  */
> > + if (!test_bit(CXL_REGION_F_AUTO, &cxlr_a->flags))
> > +    return false;
> > +
> > + cxld_a = cxl_region_find_decoder(port, cxlr_a);
> > + cxl_rr = cxl_rr_load(port, cxlr_b);
> > + cxld_b = cxl_rr->decoder;
> > +
> > + if (cxld_b->id > cxld_a->id) {
> > +    dev_dbg(&cxlr_a->dev,
> > +        "allow out of order region ref alloc\n");
> > +    return true;
> > + }
> > +
> > + return false;
> > +}
> > +
> >  static struct cxl_region_ref *alloc_region_ref(struct cxl_port *port,
> >                          struct cxl_region *cxlr)
> >  {
> > @@ -767,7 +798,8 @@ static struct cxl_region_ref *alloc_region_ref(struct cxl_port *port,
> >      if (!ip->res)
> >          continue;
> >
> > -    if (ip->res->start > p->res->start) {
> > +    if (ip->res->start > p->res->start &&
> > +        (!auto_order_ok(port, cxlr, iter->region))) {
> >          dev_dbg(&cxlr->dev,
> >              "%s: HPA order violation %s:%pr vs %pr\n",
> >              dev_name(&port->dev),
> >
> > base-commit: 3601311593eb44d34f142b993cb6f38f9a7863b3
> > --
> > 2.37.3
> >
