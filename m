Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE396139580
	for <linux-cxl@vger.kernel.org>; Tue, 27 Aug 2024 11:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724759729; cv=none; b=WWRt6ipdLJSRSJN8nle9tbHOwgwNG5kzjGs0b4Hjwh/GbvQhG8biyRA93sXmd/nOlALFPRpTqXHRaQReo6kDzc801W0h3nubDKhU5NoLJBZuOik4ZhCC8lUFQUDPSOm/lPD+Xj5qIuNpTIBDNbH9aNLiphBMvmd1rMO230TcrpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724759729; c=relaxed/simple;
	bh=Zb/Pdl/QSPNbsVzHQAlIH59FuhgXmzBdGUsvpMhCQis=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VYMGpBYyaH+nwfbTS5D4i1xpckJFrDFJ+nRNIH1GUxcZQM4tQB7YGmQUvEWGk/i1he0yxDF2GGx3bQ11EhpbT18vfYLcHUDmIS8WUBDMYAnYsNJpxPELztVJE4DwUlZoj8/lG4lm0lnZHxThtaF1ICRiHah0FD8dGKIav4V0ewI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WtQqd35j8z6J75v;
	Tue, 27 Aug 2024 19:51:25 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 7D8BA140A71;
	Tue, 27 Aug 2024 19:55:23 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 27 Aug
 2024 12:55:23 +0100
Date: Tue, 27 Aug 2024 12:55:22 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Li Ming <ming4.li@intel.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] cxl/port: Use scoped_guard()/guard() to drop
 device_lock() for cxl_port
Message-ID: <20240827125522.00007262@Huawei.com>
In-Reply-To: <20240826083058.1509232-2-ming4.li@intel.com>
References: <20240826083058.1509232-1-ming4.li@intel.com>
	<20240826083058.1509232-2-ming4.li@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 26 Aug 2024 08:30:57 +0000
Li Ming <ming4.li@intel.com> wrote:

> A device_lock() and device_unlock() pair can be replaced by a cleanup
> helper scoped_guard() or guard(), that can enhance code readability. In
> CXL subsystem, still use device_lock() and device_unlock() pairs for cxl
> port resource protection, most of them can be replaced by a
> scoped_guard() or a guard() simply.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Li Ming <ming4.li@intel.com>

Hi Li Ming,

The advantages of previous patch become clearer here.  So
overall I think I'm convinced it's worth making the change.

Follow on comment below,

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index b50dda6610e3..7b87b5142fa7 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c

> @@ -1561,40 +1556,38 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
>  		return -EAGAIN;
>  	}
>  
> -	device_lock(&parent_port->dev);
> -	if (!parent_port->dev.driver) {
> -		dev_warn(&cxlmd->dev,
> -			 "port %s:%s disabled, failed to enumerate CXL.mem\n",
> -			 dev_name(&parent_port->dev), dev_name(uport_dev));
> -		port = ERR_PTR(-ENXIO);
> -		goto out;
> -	}

As per comment in previous patch, I'd pull the instantiation of
port down here.  That way constructor and destructor are at least nearby
and the ordering is more what I'd expect.

> +	scoped_guard(device, &parent_port->dev) {
> +		if (!parent_port->dev.driver) {
> +			dev_warn(&cxlmd->dev,
> +				 "port %s:%s disabled, failed to enumerate CXL.mem\n",
> +				 dev_name(&parent_port->dev), dev_name(uport_dev));
> +			return -ENXIO;
> +		}
> +
> +		port = find_cxl_port_at(parent_port, dport_dev, &dport);
> +		if (!port) {
> +			component_reg_phys = find_component_registers(uport_dev);
> +			port = devm_cxl_add_port(&parent_port->dev, uport_dev,
> +						 component_reg_phys, parent_dport);
> +			if (IS_ERR(port))
> +				return PTR_ERR(port);
>  
> -	port = find_cxl_port_at(parent_port, dport_dev, &dport);
> -	if (!port) {
> -		component_reg_phys = find_component_registers(uport_dev);
> -		port = devm_cxl_add_port(&parent_port->dev, uport_dev,
> -					 component_reg_phys, parent_dport);
> -		/* retry find to pick up the new dport information */
> -		if (!IS_ERR(port))
> +			/* retry find to pick up the new dport information */
>  			port = find_cxl_port_at(parent_port, dport_dev, &dport);
> +			if (!port)
> +				return -ENXIO;
> +		}
>  	}
> -out:
> -	device_unlock(&parent_port->dev);
>  
> -	if (IS_ERR(port))
> -		rc = PTR_ERR(port);
> -	else {
> -		dev_dbg(&cxlmd->dev, "add to new port %s:%s\n",
> -			dev_name(&port->dev), dev_name(port->uport_dev));
> -		rc = cxl_add_ep(dport, &cxlmd->dev);
> -		if (rc == -EBUSY) {
> -			/*
> -			 * "can't" happen, but this error code means
> -			 * something to the caller, so translate it.
> -			 */
> -			rc = -ENXIO;
> -		}
> +	dev_dbg(&cxlmd->dev, "add to new port %s:%s\n",
> +		dev_name(&port->dev), dev_name(port->uport_dev));
> +	rc = cxl_add_ep(dport, &cxlmd->dev);
> +	if (rc == -EBUSY) {
> +		/*
> +		 * "can't" happen, but this error code means
> +		 * something to the caller, so translate it.
> +		 */
> +		rc = -ENXIO;
>  	}
>  
>  	return rc;

