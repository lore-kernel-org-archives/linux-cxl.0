Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEE923F262;
	Wed, 15 Jan 2025 08:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736930701; cv=none; b=muZ6Pv+zf2u49ecxd5Z3QONFtSL3rLWI4T9Jh5dsfHX3//1j6EpcYmoJsEznz6YheCInH5NoUjzmC9oQOY/kV7KmcVHNsAM/tBelREdNbsYhZfqNJ+0mzBL7PKUzI0jZjw54h3xZ9XMAA6wAZuKbSL3QtbT741uKQTEwgIg53aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736930701; c=relaxed/simple;
	bh=1G6Fu2GBD25ntessdBmkIq0MhYS3K36ZgkS1cb7efxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OJDjO70y8SplkiHGirQkRWGefs1+5f58S4VVqYowHFWwerIYs+mDAVNi4NeJquw0MdwWVy/chQJ/JrWDowJnI7/OyyiD7cTyC0seijCOsaOBB7fxaa7z1Ef2ISaoHqTvP/60s6t4/IfA4zHqGpeMvoUKg74apbhFHn6Ju8GudUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=ZR3kPPsn; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="ZR3kPPsn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1736930686;
	bh=1G6Fu2GBD25ntessdBmkIq0MhYS3K36ZgkS1cb7efxo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZR3kPPsnLYNmR8QtM3dcCtBEs/0Mb+iTWPrRKi6DdK2bbDRjN9IjhVISHiv/UxVMa
	 UE0Sp8iS3LYYNnFHFVgmYyHN4d320qWQp0hWWY4C5F5EuiPlGMWXTtrKdpwSf5CGy7
	 QBbsibRM6ByeaBpSBPl/wvuIpKbcvCHOTIcUGzCk=
Date: Wed, 15 Jan 2025 09:44:46 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cxl/port: Constify 'struct bin_attribute'
Message-ID: <4b3560e7-68f2-480d-8337-2699c999e55c@t-8ch.de>
References: <20250114-sysfs-const-bin_attr-cxl-v1-1-5afa23fe2a52@weissschuh.net>
 <Z4bsws_eoYz4fMnp@aschofie-mobl2.lan>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z4bsws_eoYz4fMnp@aschofie-mobl2.lan>

On 2025-01-14 15:01:22-0800, Alison Schofield wrote:
> On Tue, Jan 14, 2025 at 10:25:14PM +0100, Thomas Weißschuh wrote:
> > The sysfs core now allows instances of 'struct bin_attribute' to be
> > moved into read-only memory. Make use of that to protect them against
> > accidental or malicious modifications.
> > 
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > ---
> >  drivers/cxl/port.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> > index 4c83f6a22e584f1f248807c7fa4fe932d6f11d67..664fde6ff53862c6aef2a83be56c1518b6bfbadd 100644
> > --- a/drivers/cxl/port.c
> > +++ b/drivers/cxl/port.c
> > @@ -153,7 +153,7 @@ static int cxl_port_probe(struct device *dev)
> >  }
> >  
> >  static ssize_t CDAT_read(struct file *filp, struct kobject *kobj,
> > -			 struct bin_attribute *bin_attr, char *buf,
> > +			 const struct bin_attribute *bin_attr, char *buf,
> >  			 loff_t offset, size_t count)
> >  {
> >  	struct device *dev = kobj_to_dev(kobj);
> > @@ -170,7 +170,7 @@ static ssize_t CDAT_read(struct file *filp, struct kobject *kobj,
> >  				       port->cdat.length);
> >  }
> >  
> > -static BIN_ATTR_ADMIN_RO(CDAT, 0);
> > +static const BIN_ATTR_ADMIN_RO(CDAT, 0);
> >  
> >  static umode_t cxl_port_bin_attr_is_visible(struct kobject *kobj,
> >  					    const struct bin_attribute *attr, int i)
> > @@ -184,13 +184,13 @@ static umode_t cxl_port_bin_attr_is_visible(struct kobject *kobj,
> >  	return 0;
> >  }
> >  
> > -static struct bin_attribute *cxl_cdat_bin_attributes[] = {
> > +static const struct bin_attribute *const cxl_cdat_bin_attributes[] = {
> >  	&bin_attr_CDAT,
> >  	NULL,
> >  };
> >  
> > -static struct attribute_group cxl_cdat_attribute_group = {
> > -	.bin_attrs = cxl_cdat_bin_attributes,
> > +static const struct attribute_group cxl_cdat_attribute_group = {
> > +	.bin_attrs_new = cxl_cdat_bin_attributes,
> >  	.is_bin_visible = cxl_port_bin_attr_is_visible,
> >  };
> 
> What's the point of s/bin_attrs/bin_attrs_new above?

The new type of cxl_cdat_bin_attributes is not compatible with
.bin_attrs. Therefore .bin_attrs_new was introduced.
When all users have been migrated to the new type, .bin_attrs itself will
be switched to the new type and all users moved back to bin_attr.
In one big centrally managed commit to avoid annoying subsystem
maintainers (even more).

The same issue exists in .read_new/.write_new but in this specific case
that is handled transparently in BIN_ATTR_ADMIN_RO().

> 
> --Alison
> 
> >  
> > 
> > ---
> > base-commit: 7f5b6a8ec18e3add4c74682f60b90c31bdf849f2
> > change-id: 20250114-sysfs-const-bin_attr-cxl-d102eab47586
> > 
> > Best regards,
> > -- 
> > Thomas Weißschuh <linux@weissschuh.net>
> > 
