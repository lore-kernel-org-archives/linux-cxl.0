Received: from sender6-pp-o92.zoho.com (sender6-pp-o92.zoho.com [165.173.180.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE0F1D5CFE
	for <linux-cxl@vger.kernel.org>; Thu,  1 Oct 2026 02:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.180.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790820004; cv=pass; b=SXeJKXkMN8YanPKT1WmapYVqmeRfCKQizUgdp2xqvidUWH3Yy42xVSdnl2YhhdF4ceBdqmFeP95X4dIqiYvld2hv2DwH/X6fRQQmJhJBj//bZ8pOrwPdAsFuT2OA37gF5WrTSxrTuMoSJR3ULgTd2VJXbNW5FwnSE9PYvzrzj/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790820004; c=relaxed/simple;
	bh=MjQMBTbJK38IUmuNQqg5FfYTCrG9bR1cteNw1+NS9J0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MQTCx/1qkKxWTK094KY7kI4sKjKXh84PF0NmrnGlzc+SHf1RaFytUHo6gfeBacwDBjrGkgGmFQ9Y5ZOBvAF68AiYKrrlCgtMRIEqeW5X96KiS6TyeGMtoP8/PEKDuCrns4cz5bOlutSZhbm0fgTTmEp0H8UHeD0fahuDE2D8mcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=Vu7ToNU4; arc=pass smtp.client-ip=165.173.180.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="Vu7ToNU4"
ARC-Seal: i=1; a=rsa-sha256; t=1790819996; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=co1y5qDjLIjm1uLzHsV8u3s/EdVBsVVPg+OW6OgFiBIK/NwZddNtcSQgu/EOihrUW8P37L7upfAHuon2muHU0E2o10qDlho2iyxVcr4zAoLDIng608ZXtuKHpIO1rfpMr1Oht9bJvnDwmBl8l5MZ0OU6MLMuA6dGpVe5VhgWTmo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1790819996; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=DXMiLlnrpe6W1+k6Z9KAnp36S58SOr9NJNchD4roeLI=; 
	b=TwnQ/eGFv0CoVTbtt44yBqZdL/+EIn3TnD1Qb6xO8d6eIBAIxdN5Afs/sbSyjhkV7YKkumv2i3bF0+6j7NaKhPLv/kp057X2MVBobiyn5+jeqQQCLA8G5UdBVAxW/Kd44pvRwtrZQvPbqyh4TECwVgQktx8+xx6FTixW5xg9cus=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790819996;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=DXMiLlnrpe6W1+k6Z9KAnp36S58SOr9NJNchD4roeLI=;
	b=Vu7ToNU4iWeZG28wPDXgc1NX42tww2otLMj0Hae6ANHYfko/aLRwMExPXcnuva1C
	C/BTjlMW+dp2h8XE3QSLs42HadxH85jRlfKvpC5JX9qq5MdjneWPFOGnmfkEeEOwm1M
	KHfcxBXc7ZdZ//si7HZ7cm/CoEb1sUwvhp0/XHZ4=
Received: by smtp.zohomail.com with SMTPS id 1790819995902173.51804760283892;
	Wed, 30 Sep 2026 18:59:55 -0700 (PDT)
Message-ID: <5c19ab8b-f369-448d-abcf-a80ff3bbaf9d@zohomail.com>
Date: Thu, 1 Oct 2026 09:59:53 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] cxl/port: Attach endpoints to a dport under the
 lock that pins it
To: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net, jic23@kernel.org, alison.schofield@intel.com,
 icheng@nvidia.com
References: <20260930152311.4164036-1-dave.jiang@intel.com>
 <20260930152311.4164036-4-dave.jiang@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20260930152311.4164036-4-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: zu08011227e2bba92755547c1cd3945a5600005fd6956a80c3b5fb7dddd5ad86183d89845845cf2c45096b7c:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External

On 9/30/2026 11:23 PM, Dave Jiang wrote:
> devm_cxl_enumerate_ports() and add_port_attach_ep() look up or create a
> dport under its port's device lock, drop the lock, then pass the dport
> to cxl_add_ep(). add_ep() reads dport->port before taking the lock, and
> cxl_gpf_port_setup() reads and writes the dport with no lock held.
>
> A concurrent cxl_detach_ep() for another memdev below the same port can
> free the dport in that window: it calls del_dports() under the port lock
> when the last endpoint leaves. The enumerating memdev then dereferences
> freed memory.
>
> Attach the endpoint and set up GPF while the port lock from the lookup
> is still held. Make add_ep() assert that lock instead of taking it.
> Under the lock, a dport found in port->dports is still live, since
> removal erases it from the xarray before freeing it.
>
> Fixes: de516b40116e ("cxl/port: Record dport in endpoint references")
> Reported-by: Li Ming <ming.li@zohomail.com>
> Closes: https://lore.kernel.org/linux-cxl/0c68324c-cfc7-46b2-9344-24ae40e88923@zohomail.com/
> Assisted-by: LLM
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
>
> ---
> Found by review, not from a failure report.
>
> Tested in QEMU with cxl_test, PROVE_LOCKING and KASAN on: 6 module
> load/unload cycles, 12 concurrent target_list readers, and each cycle 20
> rounds of every memdev unbinding and rebinding in parallel. No KASAN
> report, no WARNING, no lockdep splat; debug_locks stays 1. Both converted
> paths run under this load, so the new device_lock_assert() in add_ep()
> never fired.
>
> Enumeration is unchanged against the same test at patch 2: 11 memdev,
> 8 port, 11 endpoint, 158 decoder after every load.
>
> The races produce transient -EBUSY cxl_mem probe failures (424 with this
> patch, 407 without) from the pending detach_work check in
> cxl_mem_probe(). Memdevs left unbound rebind on the first retry.
> ---
>  drivers/cxl/core/port.c | 115 ++++++++++++++++++++++------------------
>  1 file changed, 62 insertions(+), 53 deletions(-)
>
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 336d7c0f5d98..b71fe3882212 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1349,7 +1349,7 @@ static int add_ep(struct cxl_ep *new)
>  {
>  	struct cxl_port *port = new->dport->port;
>  
> -	guard(device)(&port->dev);
> +	device_lock_assert(&port->dev);
>  	if (port->dead)
>  		return -ENXIO;
>  
> @@ -1365,6 +1365,9 @@ static int add_ep(struct cxl_ep *new)
>   * Intermediate CXL ports are scanned based on the arrival of endpoints.
>   * When those endpoints depart the port can be destroyed once all
>   * endpoints that care about that port have been removed.
> + *
> + * Context: Caller must hold the device lock of @dport->port, which pins
> + *	    @dport, across the lookup of @dport and this call.
>   */
>  static int cxl_add_ep(struct cxl_dport *dport, struct device *ep_dev)
>  {
> @@ -1705,13 +1708,15 @@ static struct cxl_dport *probe_dport(struct cxl_port *port,
>  	return drv->add_dport(port, dport_dev);
>  }
>  
> -static struct cxl_dport *devm_cxl_create_port(struct device *ep_dev,
> -					      struct cxl_port *parent_port,
> -					      struct cxl_dport *parent_dport,
> -					      struct device *uport_dev,
> -					      struct device *dport_dev)
> +static int devm_cxl_create_port(struct device *ep_dev,
> +				struct cxl_port *parent_port,
> +				struct cxl_dport *parent_dport,
> +				struct device *uport_dev,
> +				struct device *dport_dev)
>  {
>  	resource_size_t component_reg_phys;
> +	struct cxl_dport *dport;
> +	int rc;
>  
>  	device_lock_assert(&parent_port->dev);
>  	if (!parent_port->dev.driver) {
> @@ -1728,7 +1733,7 @@ static struct cxl_dport *devm_cxl_create_port(struct device *ep_dev,
>  		port = devm_cxl_add_port(&parent_port->dev, uport_dev,
>  					 component_reg_phys, parent_dport);
>  		if (IS_ERR(port))
> -			return ERR_CAST(port);
> +			return PTR_ERR(port);
>  
>  		/*
>  		 * retry to make sure a port is found. a port device
> @@ -1736,7 +1741,7 @@ static struct cxl_dport *devm_cxl_create_port(struct device *ep_dev,
>  		 */
>  		port = find_cxl_port_by_uport(uport_dev);
>  		if (!port)
> -			return ERR_PTR(-ENODEV);
> +			return -ENODEV;
>  
>  		dev_dbg(ep_dev, "created port %s:%s\n",
>  			dev_name(&port->dev), dev_name(port->uport_dev));
> @@ -1745,11 +1750,25 @@ static struct cxl_dport *devm_cxl_create_port(struct device *ep_dev,
>  		 * Port was created before right before this function is
>  		 * called. Signal the caller to deal with it.
>  		 */
> -		return ERR_PTR(-EAGAIN);
> +		return -EAGAIN;
>  	}
>  
> +	/* @dport is only valid while @port's lock is held */
>  	guard(device)(&port->dev);
> -	return probe_dport(port, dport_dev);
> +	dport = probe_dport(port, dport_dev);
> +	if (IS_ERR(dport))
> +		return PTR_ERR(dport);
> +
> +	rc = cxl_add_ep(dport, ep_dev);
> +	if (rc == -EBUSY) {
> +		/*
> +		 * "can't" happen, but this error code means
> +		 * something to the caller, so translate it.
> +		 */
> +		rc = -ENXIO;
> +	}
> +
> +	return rc;
>  }
>  
>  static int add_port_attach_ep(struct cxl_memdev *cxlmd,
> @@ -1757,7 +1776,7 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
>  			      struct device *dport_dev)
>  {
>  	struct device *dparent = grandparent(dport_dev);
> -	struct cxl_dport *dport, *parent_dport;
> +	struct cxl_dport *parent_dport;
>  	int rc;
>  
>  	if (is_cxl_host_bridge(dparent)) {
> @@ -1786,33 +1805,23 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
>  				return PTR_ERR(parent_dport);
>  		}
>  
> -		dport = devm_cxl_create_port(&cxlmd->dev, parent_port,
> -					     parent_dport, uport_dev,
> -					     dport_dev);
> -		if (IS_ERR(dport)) {
> -			/* Port or dport already exists, restart iteration */
> -			if (PTR_ERR(dport) == -EAGAIN || PTR_ERR(dport) == -EBUSY)
> -				return 0;
> -			return PTR_ERR(dport);
> -		}
> +		rc = devm_cxl_create_port(&cxlmd->dev, parent_port,
> +					  parent_dport, uport_dev, dport_dev);
>  	}
>  
> -	rc = cxl_add_ep(dport, &cxlmd->dev);
> -	if (rc == -EBUSY) {
> -		/*
> -		 * "can't" happen, but this error code means
> -		 * something to the caller, so translate it.
> -		 */
> -		rc = -ENXIO;
> -	}
> +	/* Port or dport already exists, restart iteration */
> +	if (rc == -EAGAIN || rc == -EBUSY)
> +		return 0;
>  
>  	return rc;
>  }
>  
> -static struct cxl_dport *find_or_add_dport(struct cxl_port *port,
> -					   struct device *dport_dev)
> +static int find_or_add_dport_attach_ep(struct cxl_memdev *cxlmd,
> +				       struct cxl_port *port,
> +				       struct device *dport_dev)
>  {
>  	struct cxl_dport *dport;
> +	int rc;
>  
>  	/*
>  	 * The port is already visible in CXL hierarchy, but it may still
> @@ -1828,13 +1837,28 @@ static struct cxl_dport *find_or_add_dport(struct cxl_port *port,
>  	if (!dport) {
>  		dport = probe_dport(port, dport_dev);
>  		if (IS_ERR(dport))
> -			return dport;
> +			return PTR_ERR(dport);
>  
>  		/* New dport added, restart iteration */
> -		return ERR_PTR(-EAGAIN);
> +		return -EAGAIN;
>  	}
>  
> -	return dport;
> +	/* @dport is only valid while @port's lock is held */
> +	rc = cxl_add_ep(dport, &cxlmd->dev);
> +
> +	/*
> +	 * If the endpoint already exists in the port's list,
> +	 * that's ok, it was added on a previous pass.
> +	 * Otherwise, retry in add_port_attach_ep() after taking
> +	 * the parent_port lock as the current port may be being
> +	 * reaped.
> +	 */
> +	if (rc && rc != -EBUSY)
> +		return rc;
> +
> +	cxl_gpf_port_setup(dport);
> +
> +	return 0;
>  }
>  
>  int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
> @@ -1863,7 +1887,6 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
>  	for (iter = dev; iter; iter = grandparent(iter)) {
>  		struct device *dport_dev = grandparent(iter);
>  		struct device *uport_dev;
> -		struct cxl_dport *dport;
>  
>  		if (is_cxl_host_bridge(dport_dev))
>  			return 0;
> @@ -1890,27 +1913,13 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
>  			 * RP port enumerated by cxl_acpi without dport will
>  			 * have the dport added here.
>  			 */
> -			dport = find_or_add_dport(port, dport_dev);
> -			if (IS_ERR(dport)) {
> -				if (PTR_ERR(dport) == -EAGAIN)
> -					goto retry;
> -				return PTR_ERR(dport);
> -			}
> -
> -			rc = cxl_add_ep(dport, &cxlmd->dev);
> -
> -			/*
> -			 * If the endpoint already exists in the port's list,
> -			 * that's ok, it was added on a previous pass.
> -			 * Otherwise, retry in add_port_attach_ep() after taking
> -			 * the parent_port lock as the current port may be being
> -			 * reaped.
> -			 */
> -			if (rc && rc != -EBUSY)
> +			rc = find_or_add_dport_attach_ep(cxlmd, port,
> +							 dport_dev);
> +			if (rc == -EAGAIN)
> +				goto retry;
> +			if (rc)
>  				return rc;
>  
> -			cxl_gpf_port_setup(dport);
> -
>  			/* Any more ports to add between this one and the root? */
>  			if (!dev_is_cxl_root_child(&port->dev))
>  				continue;


