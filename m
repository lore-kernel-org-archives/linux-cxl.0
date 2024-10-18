Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39B2201261
	for <linux-cxl@vger.kernel.org>; Fri, 18 Oct 2024 11:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729249454; cv=none; b=IGoxbqIzVisoywsA27xwrT5NA8tI7/b3aOGMvDwK3givEcgW6uDf8WVmPP4A+G2bRFdtfdE8x/OwiLipqFk3aZ85+d4idjnyt3sozTrTqhwrS5Bkmb1QCFUORRSr61xKbAmw4NdHxj93L4bFwX/kIxFcCtD96BfBaRzOFtHvN/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729249454; c=relaxed/simple;
	bh=nWEGXdMrySqOo4TimTW13L+TzkQvGvyH9MGATMuVpUo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BQIhFgXY6OJesKr8UcBC40CogWn6hdaZG//4miKXBE5nekR6WEeO8EzUI/NNmv6QHmr2SjUk6afYHSu2DX3UjFVscSw4v9TEKqaEY7cEDiT/GM9GsknOIbc9hb0GATCd1Tb+BkasEed1aXxNPKcIGy0v4xXBUKHCSL9iniJjMUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XVMGw3FS5z6K6WJ;
	Fri, 18 Oct 2024 19:02:16 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 648591403A0;
	Fri, 18 Oct 2024 19:04:03 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 18 Oct
 2024 13:04:02 +0200
Date: Fri, 18 Oct 2024 12:04:01 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <ira.weiny@intel.com>, <dave.jiang@intel.com>, Dan Carpenter
	<dan.carpenter@linaro.org>, Li Ming <ming4.li@intel.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] cxl/port: Clarify add_port_attach_ep()
Message-ID: <20241018120401.00006e7a@Huawei.com>
In-Reply-To: <172921383206.2133624.16072155083340676420.stgit@dwillia2-xfh.jf.intel.com>
References: <172921380683.2133624.1708770961640157143.stgit@dwillia2-xfh.jf.intel.com>
	<172921383206.2133624.16072155083340676420.stgit@dwillia2-xfh.jf.intel.com>
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
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 17 Oct 2024 18:10:33 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> The subtlety in add_port_attach_ep() is too high as even static analysis
> checkers had trouble following the error exit logic [1]. Jonathan points
> out that at a minimum the 2 acquisitions of @port should use 2 variables
> [2]. This patch goes a step further and refactors the code to:
> 
> - drop the redundant uport_dev argument

Feels like an 'and' patch.  Maybe split off this first trivial bit as
a separate patch. Also a move of a comment could be done as a final
patch to simplify the diff of the important stuff.

> - move all device_lock dependent code to a new find_add_dport() helper
> - clarify why the @port reference needs to held
> - clarify that @port is not devm released on failure
> - create a new __free(put_cxl_dport) helper for this case of passing
>   around an implied @port refernce
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: http://lore.kernel.org/2a19289b-0bcf-42c4-82a9-268a922535f2@stanley.mountain [1]
> Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Link: http://lore.kernel.org/20241017181244.00003e1f@Huawei.com [2]
> Cc: Li Ming <ming4.li@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
A couple of trivial comments inline, but definitely looks much better
to me after this!

Jonathan

> ---
>  drivers/cxl/core/port.c |  112 ++++++++++++++++++++++++++++-------------------
>  drivers/cxl/cxl.h       |    1 
>  2 files changed, 68 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 8e6596e147b3..599b1a4caa70 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1539,14 +1539,63 @@ static resource_size_t find_component_registers(struct device *dev)
>  	return map.resource;
>  }
>  
> +/*
> + * Check if @parent_port has a child cxl_port that hosts @dport_dev.
> + * and if not create a new port attached via the @parent_dport
> + * downstream of @parent_port
> + *
> + * Caller is responsible for dropping the port reference after using
> + * @dport
> + */
> +static struct cxl_dport *find_add_dport(struct cxl_port *parent_port,
> +					struct device *dport_dev,
> +					struct cxl_dport *parent_dport)
> +{
> +	struct device *uport_dev = dport_dev->parent;
> +	resource_size_t component_reg_phys;
> +	struct cxl_dport *dport;
> +	struct cxl_port *port;
> +
> +	/*
> +	 * lock serves 2 purposes:
> +	 * - Resolve races to find/create a new port
> +	 * - Prevent found / created ports from being freed before a
> +	 *   reference can be taken
A breadcrumb on why this second one is true might be helpful
as no immediately obvious why holding parent would do this.
I'm guessing because reap_dports holds the same lock?

> +	 */
> +	guard(device)(&parent_port->dev);
> +	if (!parent_port->dev.driver) {
> +		dev_warn(&parent_port->dev,
> +			 "disabled, failed to enumerate CXL.mem\n");
> +		return ERR_PTR(-ENXIO);
> +	}
> +
> +	port = find_cxl_port_at(parent_port, dport_dev, &dport);
> +	if (port)
> +		return dport;
> +
> +	/*
> +	 * Note that this port is only unregistered when @parent_port
> +	 * is unbound / removed, not if this routine returns an error.
> +	 * It is a shared object across multiple downstream endpoints.
> +	 */
> +	component_reg_phys = find_component_registers(uport_dev);
> +	port = devm_cxl_add_port(&parent_port->dev, uport_dev,
> +				 component_reg_phys, parent_dport);
> +	if (IS_ERR(port))
> +		return ERR_CAST(port);
> +
> +	dport = cxl_find_dport_by_dev(port, dport_dev);
> +	if (!dport)
> +		return ERR_PTR(-ENXIO);
> +	get_device(&port->dev);
> +	return dport;
> +}
> +
>  static int add_port_attach_ep(struct cxl_memdev *cxlmd,
> -			      struct device *uport_dev,
>  			      struct device *dport_dev)
>  {
>  	struct device *dparent = grandparent(dport_dev);
> -	struct cxl_port *port, *parent_port = NULL;
> -	struct cxl_dport *dport, *parent_dport;
> -	resource_size_t component_reg_phys;
> +	struct cxl_dport *parent_dport;
>  	int rc;
>  
>  	if (!dparent) {
> @@ -1560,50 +1609,23 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
>  		return -ENXIO;
>  	}
>  
> -	parent_port = find_cxl_port(dparent, &parent_dport);
> -	if (!parent_port) {
> -		/* iterate to create this parent_port */
> -		return -EAGAIN;
> -	}
> +	struct cxl_port *parent_port __free(put_cxl_port) =
> +		find_cxl_port(dparent, &parent_dport);
>  
> -	device_lock(&parent_port->dev);
> -	if (!parent_port->dev.driver) {
> -		dev_warn(&cxlmd->dev,
> -			 "port %s:%s disabled, failed to enumerate CXL.mem\n",
> -			 dev_name(&parent_port->dev), dev_name(uport_dev));
> -		port = ERR_PTR(-ENXIO);
> -		goto out;
> -	}
> +	/* iterate to create this parent_port? */
> +	if (!parent_port)
> +		return -EAGAIN;

Just to reduce diff and hence make this slightly simpler to review,
I'd leave the formatting as above.  If you care trivial follow up patch.


>  
> -	port = find_cxl_port_at(parent_port, dport_dev, &dport);
> -	if (!port) {
> -		component_reg_phys = find_component_registers(uport_dev);
> -		port = devm_cxl_add_port(&parent_port->dev, uport_dev,
> -					 component_reg_phys, parent_dport);
> -		/* retry find to pick up the new dport information */
> -		if (!IS_ERR(port))
> -			port = find_cxl_port_at(parent_port, dport_dev, &dport);
> -	}



