Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813DB24DD00
	for <linux-cxl@vger.kernel.org>; Fri,  4 Jul 2025 09:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751622782; cv=none; b=bdZSiiQETuic4CTg6mAqF0elA/ZwVKNeqlQUjUNV58xGe5nV0PjuTIpoZmr0EeTY1ahEbRVe1RfAZnrR6sfMxVI0jEGllJDZ3+NVV6jJO+spr5eGJwnC3iBaQLGXEDuAxgLoW6/VaiAXtTn6RhZVRg1mi7S7AAJqRd1F5IGNKRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751622782; c=relaxed/simple;
	bh=daXw6CU9sSA9bbpnEQgZaXQdS/38KCnKkmu4IlRQbeQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kygiCse0vIg0zEQ/G4dKwT1Qw8spL31nNuBpRBT0QuBxvhiEfqrJhq3ysHJYfv7lPAiZauQuZ98TBudKnLQ9REE4UT/x6/viOIrPJPCukBjLMbVGwAt83i0tBdbBxqnqA7v8L0iJe/2Zubldxd6xFWyJq5U113u57/BInLA3wUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bYTSG6CK3z6M5JV;
	Fri,  4 Jul 2025 17:51:58 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 4AA2E1402F1;
	Fri,  4 Jul 2025 17:52:57 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 4 Jul
 2025 11:52:56 +0200
Date: Fri, 4 Jul 2025 10:52:55 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
Subject: Re: [PATCH v5 04/10] cxl: Defer dport allocation for switch ports
Message-ID: <20250704105255.000039da@huawei.com>
In-Reply-To: <20250703232710.3141436-5-dave.jiang@intel.com>
References: <20250703232710.3141436-1-dave.jiang@intel.com>
	<20250703232710.3141436-5-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 frapeml500008.china.huawei.com (7.182.85.71)


Hi Dave,

> ---
> v5:
> - Change cxl_port_get_total_dports() to cxl_port_update_total_dports(). (Jonathan)
> - Return dport for the devm_cxl_port_add_dport() and friends. (Jonathan)
I'm not following how the code around this works.  See below.

If I'm reading it right and it should just be a return ERR_PTR(-EEXIST)
where noted, with that fixed:

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>


> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 9691da831224..ffd39c5b7222 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1551,6 +1551,128 @@ static resource_size_t find_component_registers(struct device *dev)

> +
> +static struct cxl_dport *devm_cxl_port_add_dport(struct cxl_port *port,
> +						 struct device *dport_dev)
> +{
> +	struct cxl_dport *dport;
> +	int rc;
> +
> +	device_lock_assert(&port->dev);
> +
> +	/* Port driver not attached yet, wait for cxl_acpi reprobe */
> +	if (!port->dev.driver)
> +		return ERR_PTR(-ENODEV);
> +
> +	dport = cxl_find_dport_by_dev(port, dport_dev);
> +	if (dport)
> +		return dport;

I was expecting this to return -EEXIST.
Only going to be visible in the devm_cxl_add_dport_for_rp()
though so maybe test isn't hitting that?

> +
> +	dport = devm_cxl_add_dport_by_dev(port, dport_dev);
> +	if (IS_ERR(dport))
> +		return dport;
> +
> +	rc = cxl_port_setup_with_dport(port, dport);
> +	if (rc) {
> +		reap_dport(port, dport);
> +		return ERR_PTR(rc);
> +	}
> +
> +	return dport;
> +}
> +
> +static struct cxl_dport *devm_cxl_add_dport_by_uport(struct device *uport_dev,
> +						     struct device *dport_dev)
> +{
> +	struct cxl_port *port __free(put_cxl_port) =
> +		find_cxl_port_by_uport(uport_dev);
> +
> +	if (!port)
> +		return ERR_PTR(-ENODEV);
> +
> +	guard(device)(&port->dev);
> +	return devm_cxl_port_add_dport(port, dport_dev);
> +}
> +
> +static struct cxl_dport *devm_cxl_add_dport_for_rp(struct device *uport_dev,
> +						   struct device *dport_dev)
> +{
> +	struct device *dparent = grandparent(dport_dev);
> +
> +	/* Only go down this path if we are at the root port */
> +	if (!is_cxl_hierarchy_head(dparent))
> +		return NULL;
> +
> +	return devm_cxl_add_dport_by_uport(uport_dev, dport_dev);
> +}
> +
>  static int add_port_attach_ep(struct cxl_memdev *cxlmd,
>  			      struct device *uport_dev,
>  			      struct device *dport_dev)
> @@ -1584,6 +1706,8 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
>  	 */
>  	struct cxl_port *port __free(put_cxl_port) = NULL;
>  	scoped_guard(device, &parent_port->dev) {
> +		struct cxl_dport *new_dport;
> +
>  		if (!parent_port->dev.driver) {
>  			dev_warn(&cxlmd->dev,
>  				 "port %s:%s disabled, failed to enumerate CXL.mem\n",
> @@ -1592,6 +1716,8 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
>  		}
>  
>  		port = find_cxl_port_at(parent_port, dport_dev, &dport);
> +		if (!port)
> +			port = find_cxl_port_by_uport(uport_dev);
>  		if (!port) {
>  			component_reg_phys = find_component_registers(uport_dev);
>  			port = devm_cxl_add_port(&parent_port->dev, uport_dev,
> @@ -1599,11 +1725,27 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
>  			if (IS_ERR(port))
>  				return PTR_ERR(port);
>  
> -			/* retry find to pick up the new dport information */
> -			port = find_cxl_port_at(parent_port, dport_dev, &dport);
> -			if (!port)
> -				return -ENXIO;
> +			/*
> +			 * The port holds a device reference via find_cxl_port_at()
> +			 * if the port is valid. But if the port is newly created
> +			 * via devm_cxl_add_port(), no reference is held. Therefore
> +			 * the driver needs to get a device reference here.
> +			 */
> +			get_device(&port->dev);
>  		}
> +
> +		guard(device)(&port->dev);
> +		new_dport = devm_cxl_port_add_dport(port, dport_dev);
> +		if (IS_ERR(new_dport)) {
> +			if (PTR_ERR(new_dport) != -EEXIST)
> +				return PTR_ERR(new_dport);

I think we never get here currently due to lack of returning -EEXIST.

> +
> +			new_dport = cxl_find_dport_by_dev(port, dport_dev);
> +			if (!new_dport)
> +				return -ENODEV;
> +		}
> +
> +		dport = new_dport;
>  	}
>  
>  	dev_dbg(&cxlmd->dev, "add to new port %s:%s\n",
> @@ -1620,11 +1762,13 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
>  	return rc;
>  }
>  
> +#define CXL_ITER_LEVEL_SWITCH	1
> +
>  int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
>  {
>  	struct device *dev = &cxlmd->dev;
>  	struct device *iter;
> -	int rc;
> +	int rc, i;
>  
>  	/*
>  	 * Skip intermediate port enumeration in the RCH case, there
> @@ -1643,7 +1787,7 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
>  	 * attempt fails.
>  	 */
>  retry:
> -	for (iter = dev; iter; iter = grandparent(iter)) {
> +	for (i = 0, iter = dev; iter; i++, iter = grandparent(iter)) {
>  		struct device *dport_dev = grandparent(iter);
>  		struct device *uport_dev;
>  		struct cxl_dport *dport;
> @@ -1686,9 +1830,28 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
>  			if (!dev_is_cxl_root_child(&port->dev))
>  				continue;
>  
> +			/*
> +			 * This is a corner case where the rootport is setup but
> +			 * the switch dport is not. It needs to go back to the
> +			 * beginning to setup the switch port.
> +			 */
> +			if (i >= CXL_ITER_LEVEL_SWITCH) {
> +				struct cxl_port *pport __free(put_cxl_port) =
> +					cxl_mem_find_port(cxlmd, &dport);
> +				if (!port)
> +					goto retry;
> +			}
> +
>  			return 0;
>  		}
>  
> +		dport = devm_cxl_add_dport_for_rp(uport_dev, dport_dev);
> +		/* Added a dport, restart enumeration */
> +		if (!IS_ERR_OR_NULL(dport))
> +			goto retry;

As above. I think if this finds a already existing dport we loop for ever.

> +		if (IS_ERR(dport))
> +			return PTR_ERR(dport);
> +
>  		rc = add_port_attach_ep(cxlmd, uport_dev, dport_dev);
>  		/* port missing, try to add parent */
>  		if (rc == -EAGAIN)
}

