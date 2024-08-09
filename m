Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A2518E031
	for <linux-cxl@vger.kernel.org>; Fri,  9 Aug 2024 08:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723192100; cv=none; b=NWK/9h8c6mTXOROKts67PH5taUre1NYYmjZ6Yd68D6GFja3KS0jwdVIprLq+HUS6hBwLtYqvtbWncn9vDdYWK+gz/g9Xtm+SzlqMMPKd9F9VCYQGNM2xglijD5S11GFo6/e9b1t3ombniP2yXBSVnybVje8Ts7kcL/HpjQqhsas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723192100; c=relaxed/simple;
	bh=DRTs5+Gz6SIbYt1nlEEdgiXyk9f6wMoo2hWYQkKMXO0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=afAtHEbV4aT7E0wlJhdvIVjmcYS1z7rrnMaW2WmKuf5idF5u8HVVeMsp6ZIua+GaHE0wFcAtpRHcbFBhGtqzEMd1Z9+e1Yb9bsfOu6AjiHPhmWHYuNlnqQbOQ4EU60cWk/67yGLRAiEeVYaL85qiuaGgm9foX16X7+a2bVr5xr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EG7w3MXY; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EG7w3MXY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723192099; x=1754728099;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=DRTs5+Gz6SIbYt1nlEEdgiXyk9f6wMoo2hWYQkKMXO0=;
  b=EG7w3MXY+h+n7VcYDfYUjzoMQv6VV8tTWKbF/hF6lIHRSOqlkgtbsi9b
   ctjESB/F81eqBsfQOMLlnznPdajUdOxGAe+HBc4DMuKYpDi3tijzf0D9P
   64+OPWz4WgiS8+As87iXXEGOOqEO2Tygp+1cWGgqObSiHcfYCJibz/47v
   7ioA7x+jqbrOgckic/UCmSBWSfAzFF+TFt8rW+cDsBrJSsc8+9beBy1Cp
   95hUzyJZ8smINMszvuyO6eb4czHElY2HtNGFmBtavropJJmXhqpWJVI0j
   fe5zFquifaCFLRyjF/u4Q+EXtU65VmC9Vxdy0Reo39OlsI1m44E5Baac0
   w==;
X-CSE-ConnectionGUID: h4phdlW3RkKTChfcdGr7LQ==
X-CSE-MsgGUID: ezDs1hrvRBWXwQrgaUAdZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="32034116"
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="32034116"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 01:28:18 -0700
X-CSE-ConnectionGUID: hFWy8xGySnGZ9ehcMExNTw==
X-CSE-MsgGUID: HhCQFFyDRiG+yTCIEOAX3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="57156207"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 01:28:16 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>,  Dave Jiang <dave.jiang@intel.com>,
  Alison Schofield <alison.schofield@intel.com>,  Vishal Verma
 <vishal.l.verma@intel.com>,  Lukas Wunner <lukas.wunner@intel.com>,
  "Zanussi, Tom" <tom.zanussi@intel.com>,  linux-cxl@vger.kernel.org,
  linux-mm@vger.kernel.org
Subject: Re: Odd lockdep splat involving mt_adistance_algorithm
In-Reply-To: <66b577d735b3d_c1448294ba@dwillia2-xfh.jf.intel.com.notmuch> (Dan
	Williams's message of "Thu, 8 Aug 2024 18:58:47 -0700")
References: <66b44389e7b5f_71e8129499@iweiny-mobl.notmuch>
	<87wmkrzgsu.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<66b4fb7961376_c1448294dd@dwillia2-xfh.jf.intel.com.notmuch>
	<878qx6zdgx.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<66b577d735b3d_c1448294ba@dwillia2-xfh.jf.intel.com.notmuch>
Date: Fri, 09 Aug 2024 16:24:43 +0800
Message-ID: <87zfpmxfw4.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Dan Williams <dan.j.williams@intel.com> writes:

> Huang, Ying wrote:
> [..]
>> > Ying, I think it is dangerous to be acquiring locks in notifier
>> > callbacks. I am not understanding why this needs to be a notifier use
>> > case at all. Shouldn't the adistance be passed in via dev_dax data
>> > somehow?
>> >
>> > Something like:
>> >
>> > diff --git a/drivers/dax/cxl.c b/drivers/dax/cxl.c
>> > index 9b29e732b39a..3ac20f4b1c63 100644
>> > --- a/drivers/dax/cxl.c
>> > +++ b/drivers/dax/cxl.c
>> > @@ -18,7 +18,8 @@ static int cxl_dax_region_probe(struct device *dev)
>> >                 nid = memory_add_physaddr_to_nid(cxlr_dax->hpa_range.start);
>> >  
>> >         dax_region = alloc_dax_region(dev, cxlr->id, &cxlr_dax->hpa_range, nid,
>> > -                                     PMD_SIZE, IORESOURCE_DAX_KMEM);
>> > +                                     cxlr_dax->adist, PMD_SIZE,
>> > +                                     IORESOURCE_DAX_KMEM);
>> >         if (!dax_region)
>> >                 return -ENOMEM;
>> >  
>> > ...notice how the dax already knows the node id which makes it extra
>> > unfortunate to need to take locks to recalculate the node-id all over
>> > again.
>> >
>> > Can this be reworked to make all the paths that care pass-in rather than
>> > ask for a awkward callback in unknown locking context?
>> 
>> Hi, Dan,
>> 
>> Still want to keep mt_calc_adistance() the unified interface to
>> calculate abstract distance for a NUMA node.
>> 
>> To avoid acquire cxl_region_rwsem in adistance notifier callbacks, can
>> we store NUMA node in struct cxl_region?  If so, we can avoid to acquire
>> cxl_region_rwsem in memory hotplug notifier too.
>
> The problem is that the notifier can fire at any point in the region's lifetime
> which forces the notifier to hold locks while accessing any dynamic data in the
> object.
>
> I made a mistake allowing:
>
> 067353a46d8c cxl/region: Add memory hotplug notifier for cxl region
>
> ...to make the notifier registration lifetime collide with dynamic
> updates to the region. The notifier callback should be able to trust
> that it is safe to access static data. Something like the below at the
> minimum and then there is no concern about needing to take locks to
> snapshot the region parameters.
>
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 21ad5f242875..bc9dc14b88a8 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2313,8 +2313,6 @@ static void unregister_region(void *_cxlr)
>         struct cxl_region_params *p = &cxlr->params;
>         int i;
>  
> -       unregister_memory_notifier(&cxlr->memory_notifier);
> -       unregister_mt_adistance_algorithm(&cxlr->adist_notifier);
>         device_del(&cxlr->dev);
>  
>         /*
> @@ -2484,14 +2482,6 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
>         if (rc)
>                 goto err;
>  
> -       cxlr->memory_notifier.notifier_call = cxl_region_perf_attrs_callback;
> -       cxlr->memory_notifier.priority = CXL_CALLBACK_PRI;
> -       register_memory_notifier(&cxlr->memory_notifier);
> -
> -       cxlr->adist_notifier.notifier_call = cxl_region_calculate_adistance;
> -       cxlr->adist_notifier.priority = 100;
> -       register_mt_adistance_algorithm(&cxlr->adist_notifier);
> -
>         rc = devm_add_action_or_reset(port->uport_dev, unregister_region, cxlr);
>         if (rc)
>                 return ERR_PTR(rc);
> @@ -3386,6 +3376,14 @@ static int is_system_ram(struct resource *res, void *arg)
>         return 1;
>  }
>  
> +static void shutdown_notifiers(void *data)
> +{
> +       struct cxl_region *cxlr = data;
> +
> +       unregister_mt_adistance_algorithm(&cxlr->adist_notifier);
> +       unregister_memory_notifier(&cxlr->memory_notifier);
> +}
> +
>  static int cxl_region_probe(struct device *dev)
>  {
>         struct cxl_region *cxlr = to_cxl_region(dev);
> @@ -3418,6 +3416,18 @@ static int cxl_region_probe(struct device *dev)
>  out:
>         up_read(&cxl_region_rwsem);
>  
> +       if (rc)
> +               return rc;
> +
> +       cxlr->memory_notifier.notifier_call = cxl_region_perf_attrs_callback;
> +       cxlr->memory_notifier.priority = CXL_CALLBACK_PRI;
> +       register_memory_notifier(&cxlr->memory_notifier);
> +
> +       cxlr->adist_notifier.notifier_call = cxl_region_calculate_adistance;
> +       cxlr->adist_notifier.priority = 100;
> +       register_mt_adistance_algorithm(&cxlr->adist_notifier);
> +
> +       rc = devm_add_action_or_reset(shutdown_notifiers, cxlr);
>         if (rc)
>                 return rc;

Yes.  With above change, the notifiers can only be called if the cxl
region is in CXL_CONFIG_COMMIT state.  This makes sense.

--
Best Regards,
Huang, Ying

