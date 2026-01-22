Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880143AE6FF
	for <linux-cxl@vger.kernel.org>; Thu, 22 Jan 2026 11:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769083195; cv=none; b=t3Kj5YfvWi94UJ3nZPJJt5E1021zSd+5OIpEJfr40J+sCCCJNQ92wzTc7qI40sFiy9BCRsT7cR73qJ5IlZuDDSUrLVftGfSaRVR4cyJ63Hx40VcBfaS1CRv1xPXwATayx1cCOUcdXrJzBJD04qIKNCGSrodN3XcbZiBi96nMa+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769083195; c=relaxed/simple;
	bh=BFEpzDhXdboORR01Ro1/wQ6BeSXRtf3i6/3IZK/Etfc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ICGiAjubLPt5ZXQkDof4xHdRDWUKBr9O+JFFVikMfFGmJ9CLBp2uITtv0fEHnJ21ktnxLp/hA23hYqGvOE8OCmPEQgZrxOKmPeeMtn0cJZ3C9dU1ia11h8R79ZQuXFBivtGaPXBFMPwwV38fuLsHn1qIMR5vl5heJWYH3oTWA7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dxfjr5ZJWzHnGk0;
	Thu, 22 Jan 2026 19:59:12 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 6795240584;
	Thu, 22 Jan 2026 19:59:48 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 22 Jan
 2026 11:59:47 +0000
Date: Thu, 22 Jan 2026 11:59:45 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <ira.weiny@intel.com>, <terry.bowman@amd.com>
Subject: Re: [PATCH 3/9] cxl/port: Cleanup dport removal with a devres group
Message-ID: <20260122115945.000062e6@huawei.com>
In-Reply-To: <20260122033330.1622168-4-dan.j.williams@intel.com>
References: <20260122033330.1622168-1-dan.j.williams@intel.com>
	<20260122033330.1622168-4-dan.j.williams@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Wed, 21 Jan 2026 19:33:24 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> In preparation for adding more setup actions like RAS register mapping,
> introduce a devres group to collect all the dport creation / registration
> actions. This replaces the maintenance tedium of open coding several
> devm_release_action() calls in del_dport().
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Whilst nice, there is some logic buried deep enough that it might surprise
anyone trying to grasp flow in __devm_cxl_add_dport.

I like the cleanup.h stuff but here I'm wondering if it is appropriate.
Maybe just use a goto in __devm_cxl_add_dport()

Minimum I think is we need a breadcrumb in the function naming that
it has anything to do with devres.  _dr_ is used in a few places where
devres naming is too long. 

Otherwise one minor thing inline around reusing del_dport in
the DEFINE_FREE()
If we can't because the diverge later, maybe add a comment (or just
ignore this feedback).


> ---
>  drivers/cxl/core/port.c | 62 +++++++++++++++++++++++++++++++++++++----
>  1 file changed, 56 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 1637e97f6805..f2723bf948e2 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1118,6 +1118,51 @@ static void cxl_dport_unlink(void *data)
>  	sysfs_remove_link(&port->dev.kobj, link_name);
>  }
>  
> +static struct device *dport_to_host(struct cxl_dport *dport)
> +{
> +	if (is_cxl_root(dport->port))
> +		return dport->port->uport_dev;
> +	return &dport->port->dev;
> +}
> +
> +static void free_dport(void *dport)
> +{
> +	kfree(dport);
> +}
> +
> +/*
> + * Upon return either a group is established with one action (free_dport()), or
> + * no group established and @dport is freed.
> + */
> +static void *cxl_dport_open_group_or_free(struct cxl_dport *dport)

Can we put something in the name to hint this is devres stuff?
Group could mean too many things :( Even
cxl_dport_open_dr_group_or_free() avoids sounding too generic.


> +{
> +	int rc;
> +	struct device *host = dport_to_host(dport);
> +	void *group = devres_open_group(host, dport, GFP_KERNEL);
> +
> +	if (!group) {
> +		kfree(dport);
> +		return NULL;
> +	}
> +
> +	rc = devm_add_action_or_reset(host, free_dport, dport);
> +	if (rc) {
> +		devres_release_group(host, group);
> +		return NULL;
> +	}
> +
> +	return group;
> +}
> +
> +static void cxl_dport_close_group(struct cxl_dport *dport, void *group)
> +{
> +	devres_close_group(dport_to_host(dport), group);
> +}
> +
> +/* The dport group id is the dport */
> +DEFINE_FREE(cxl_dport_release_group, void *,
> +	    if (_T) devres_release_group(dport_to_host(_T), _T))

Reorder so this can use the typed del_dport()?

> +
>  static struct cxl_dport *
>  __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>  		     int port_id, resource_size_t component_reg_phys,
> @@ -1143,14 +1188,20 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>  	    CXL_TARGET_STRLEN)
>  		return ERR_PTR(-EINVAL);
>  
> -	dport = devm_kzalloc(host, sizeof(*dport), GFP_KERNEL);
> +	dport = kzalloc(sizeof(*dport), GFP_KERNEL);
>  	if (!dport)
>  		return ERR_PTR(-ENOMEM);
>  
> +	/* Just enough init to manage the devres group */
>  	dport->dport_dev = dport_dev;
>  	dport->port_id = port_id;
>  	dport->port = port;
>  
> +	void *dport_group __free(cxl_dport_release_group) =
> +		cxl_dport_open_group_or_free(dport);
> +	if (!dport_group)
> +		return ERR_PTR(-ENOMEM);
> +
>  	if (rcrb == CXL_RESOURCE_NONE) {
>  		rc = cxl_dport_setup_regs(&port->dev, dport,
>  					  component_reg_phys);
> @@ -1203,6 +1254,9 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>  
>  	cxl_debugfs_create_dport_dir(dport);
>  
> +	/* keep the group, and mark the end of devm actions */
> +	cxl_dport_close_group(dport, no_free_ptr(dport_group));
> +
>  	return dport;
>  }
>  
> @@ -1431,11 +1485,7 @@ static void delete_switch_port(struct cxl_port *port)
>  
>  static void del_dport(struct cxl_dport *dport)
>  {
> -	struct cxl_port *port = dport->port;
> -
> -	devm_release_action(&port->dev, cxl_dport_unlink, dport);
> -	devm_release_action(&port->dev, cxl_dport_remove, dport);
> -	devm_kfree(&port->dev, dport);
> +	devres_release_group(dport_to_host(dport), dport);
>  }
>  
>  static void del_dports(struct cxl_port *port)

