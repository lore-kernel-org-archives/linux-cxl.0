Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982A229A5
	for <linux-cxl@vger.kernel.org>; Tue, 15 Jul 2025 15:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752593029; cv=none; b=CdiLxjYnoUkkrAvXfjMrfCLcXSAvbD9WRW4bQG8+OY/7szYKTD3GAQG8COi0QWVeK5SfKLJIBJFUEZrQGLTq5z/lqgN1w6aheoO6PeSC07mWyDS9NBomyQxZIDtfK4GPX9EgvBRBF4nx8Ea227hPWNHohjlJC+iSmPUqkeNACjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752593029; c=relaxed/simple;
	bh=lUET7AcAg7hj2r2P3Hxd5NDscXlDqhnditBK3M+ZdFw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TK202mRhE0PcRT8hmOZsKA9yq0urfEpUBEvZQ7v66JzaZtA/A0yCCi2J0bhvOJxsp/Fpmq0GOfouwQjA7Axp3wrhzPZgzpGVoXGWji9FvAGK9AOYZ9KkcgpzpWRS6KjZcVbjmUwdRPtrkDF9P1APlx7nILtmUznXHwh49qKsI7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bhNGZ1CDzz6M4wj;
	Tue, 15 Jul 2025 23:22:30 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 4498F14038F;
	Tue, 15 Jul 2025 23:23:44 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 15 Jul
 2025 17:23:43 +0200
Date: Tue, 15 Jul 2025 16:23:42 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Alison Schofield <alison.schofield@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
	<dave@stgolabs.net>, <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>
Subject: Re: [PATCH] cxl: Add hpa_to_spa to the root decoder callback
 operations
Message-ID: <20250715162342.000069cb@huawei.com>
In-Reply-To: <aHFazzPSfwvymGZF@aschofie-mobl2.lan>
References: <20250709200746.2567860-1-dave.jiang@intel.com>
	<20250711174530.0000291a@huawei.com>
	<aHFazzPSfwvymGZF@aschofie-mobl2.lan>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 11 Jul 2025 11:41:19 -0700
Alison Schofield <alison.schofield@intel.com> wrote:

> On Fri, Jul 11, 2025 at 05:45:30PM +0100, Jonathan Cameron wrote:
> > On Wed, 9 Jul 2025 13:07:46 -0700
> > Dave Jiang <dave.jiang@intel.com> wrote:
> >   
> > > Remove cxl_hpa_to_spa_fn callback from cxl root decoder and add the
> > > callback function to cxl_decoder_ops. Refactor to group all the root
> > > decoder callbacks together.
> > > 
> > > Signed-off-by: Dave Jiang <dave.jiang@intel.com>  
> > 
> > Question inline about mixture of types of CFMWS entry.
> >   
> > > ---
> > >  drivers/cxl/acpi.c        |  9 +++++++--
> > >  drivers/cxl/core/port.c   |  2 +-
> > >  drivers/cxl/core/region.c | 11 ++++++++---
> > >  drivers/cxl/cxl.h         | 13 ++++++++-----
> > >  4 files changed, 24 insertions(+), 11 deletions(-)
> > > 
> > > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > > index 48478bc406ee..9f7e2a49dc5a 100644
> > > --- a/drivers/cxl/acpi.c
> > > +++ b/drivers/cxl/acpi.c
> > > @@ -20,6 +20,10 @@ static const guid_t acpi_cxl_qtg_id_guid =
> > >  	GUID_INIT(0xF365F9A6, 0xA7DE, 0x4071,
> > >  		  0xA6, 0x6A, 0xB4, 0x0C, 0x0B, 0x4F, 0x8E, 0x52);
> > >  
> > > +static u64 cxl_default_hpa_to_spa(struct cxl_root_decoder *cxlrd, u64 hpa)
> > > +{
> > > +	return hpa;
> > > +}
> > >  
> > >  static u64 cxl_xor_hpa_to_spa(struct cxl_root_decoder *cxlrd, u64 hpa)
> > >  {
> > > @@ -342,8 +346,9 @@ static int cxl_acpi_get_extended_linear_cache_size(struct resource *backing_res,
> > >  	return hmat_get_extended_linear_cache_size(backing_res, nid, size);
> > >  }
> > >  
> > > -static const struct cxl_rd_ops acpi_rd_ops = {
> > > +static struct cxl_rd_ops acpi_rd_ops = {
> > >  	.get_extended_linear_cache_size = cxl_acpi_get_extended_linear_cache_size,
> > > +	.hpa_to_spa = cxl_default_hpa_to_spa,
> > >  };
> > >  
> > >  DEFINE_FREE(put_cxlrd, struct cxl_root_decoder *,
> > > @@ -425,7 +430,7 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
> > >  	cxlrd->qos_class = cfmws->qtg_id;
> > >  
> > >  	if (cfmws->interleave_arithmetic == ACPI_CEDT_CFMWS_ARITHMETIC_XOR)
> > > -		cxlrd->hpa_to_spa = cxl_xor_hpa_to_spa;
> > > +		cxlrd->ops->hpa_to_spa = cxl_xor_hpa_to_spa;  
> > 
> > What happens if we have a mixture for different CMWS entries?
> > Some xor, some not.  
> 
> A separate root decoder is created for each CFMWS entry, so no
> conflict. Is that what you're wondering?

This isn't modifying a copy. It's modifying the global structure
that you make non const above (or I'm lacking caffeine.)


> 
> 
> >   
> > >  
> > >  	rc = cxl_decoder_add(cxld, target_map);
> > >  	if (rc)  
> >   
> 

