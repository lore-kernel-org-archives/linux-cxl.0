Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7084EC5
	for <linux-cxl@vger.kernel.org>; Tue, 22 Apr 2025 16:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745340894; cv=none; b=nkwvsmMYhpctbOIGqjIhFkBTJ4fMiv4q/anpqQozqse3ekXkm/g6cXMAdq2uEwVFQJT7pBSHeJXrCyViCodMPYKAy5xmGiZVgHf50WA1C0NFAlwu66n3ENs36qbdSun73x3lGGnTaskUgRdaVrmtrBNfDzoIRh865P+wFJxModg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745340894; c=relaxed/simple;
	bh=v0zIc63cbjrkD0v3FWKKV8dM+goj0B5vHhEPw4tk+S8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zt5WvWb2S914idrnIQv0qcyRb4ZGedrf5ir7GFw0k998NAi9fBPHrqUDvym99Xx6cDUA9F/UyIIWq9WcF6sLWu/wYEG6aeBmTjuMa7DmHgC8qtMuu1w57Nvj2ez8UO5aCXVBDnlPnPSUhGKLguFWh4x6Ho/tZYeXn+7Do4CqLs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZhpBc2JX6z6K5qf;
	Wed, 23 Apr 2025 00:50:16 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 13B8E1400CA;
	Wed, 23 Apr 2025 00:54:48 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 22 Apr
 2025 18:54:47 +0200
Date: Tue, 22 Apr 2025 17:54:46 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<dave@stgolabs.net>, <alison.schofield@intel.com>, <ira.weiny@intel.com>,
	<rrichter@amd.com>, <ming.li@zohomail.com>
Subject: Re: [PATCH 1/4] cxl: Saperate out CXL dport->id vs actual dport
 hardware id
Message-ID: <20250422175446.00002ac5@huawei.com>
In-Reply-To: <20250404230049.3578835-2-dave.jiang@intel.com>
References: <20250404230049.3578835-1-dave.jiang@intel.com>
	<20250404230049.3578835-2-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 4 Apr 2025 15:57:33 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

Typo in patch title. Separate


> In preparation to allow dport to be allocated without being active, make
> dport->id to be Linux id that enumerates the dport objects per port.
> Keep the hardware id under dport->port_id to maintain compatibility and
> introduce a dport->id as the enumeration id.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

I'm getting my head around this still but just based on refactor in here
we have a bit where lifetimes weren't quite what I expected to see.

> ---
>  drivers/cxl/core/port.c | 40 +++++++++++++++++++++++++++++-----------
>  drivers/cxl/cxl.h       |  4 ++++
>  2 files changed, 33 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 0fd6646c1a2e..e90e55bc11ac 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -159,7 +159,7 @@ static ssize_t emit_target_list(struct cxl_switch_decoder *cxlsd, char *buf)
>  
>  		if (i + 1 < cxld->interleave_ways)
>  			next = cxlsd->target[i + 1];
> -		rc = sysfs_emit_at(buf, offset, "%d%s", dport->port_id,
> +		rc = sysfs_emit_at(buf, offset, "%d%s", dport->id,
>  				   next ? "," : "");
>  		if (rc < 0)
>  			return rc;
> @@ -739,6 +739,7 @@ static struct cxl_port *cxl_port_alloc(struct device *uport_dev,
>  		dev->parent = uport_dev;
>  
>  	ida_init(&port->decoder_ida);
> +	ida_init(&port->dport_ida);
>  	port->hdm_end = -1;
>  	port->commit_end = -1;
>  	xa_init(&port->dports);
> @@ -1044,14 +1045,14 @@ void put_cxl_root(struct cxl_root *cxl_root)
>  }
>  EXPORT_SYMBOL_NS_GPL(put_cxl_root, "CXL");
>  
> -static struct cxl_dport *find_dport(struct cxl_port *port, int id)
> +static struct cxl_dport *find_dport(struct cxl_port *port, int port_id)
>  {
>  	struct cxl_dport *dport;
>  	unsigned long index;
>  
>  	device_lock_assert(&port->dev);
>  	xa_for_each(&port->dports, index, dport)
> -		if (dport->port_id == id)
> +		if (dport->port_id == port_id)
>  			return dport;
>  	return NULL;
>  }
> @@ -1105,6 +1106,7 @@ static void cxl_dport_remove(void *data)
>  	struct cxl_port *port = dport->port;
>  
>  	xa_erase(&port->dports, (unsigned long) dport->dport_dev);
> +	ida_free(&port->dport_ida, dport->id);

Hmm. This ordering is effectively different to that in __devm_cxl_add_dport(reversed).
If we were to match that we'd free the ida after the
put_device(dport->dport_dev) which I think is unwinding the reference from
get_device(dport_dev)

This makes me suspicious of the ownership of dport->id.

Maybe just spin another devm_add_action_or_reset() to free the id?

If we need this ordering add a comment here on why.


>  	put_device(dport->dport_dev);
>  }
>  
> @@ -1114,7 +1116,7 @@ static void cxl_dport_unlink(void *data)
>  	struct cxl_port *port = dport->port;
>  	char link_name[CXL_TARGET_STRLEN];
>  
> -	sprintf(link_name, "dport%d", dport->port_id);
> +	sprintf(link_name, "dport%d", dport->id);
>  	sysfs_remove_link(&port->dev.kobj, link_name);
>  }
>  
> @@ -1126,7 +1128,7 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>  	char link_name[CXL_TARGET_STRLEN];
>  	struct cxl_dport *dport;
>  	struct device *host;
> -	int rc;
> +	int id, rc;
>  
>  	if (is_cxl_root(port))
>  		host = port->uport_dev;
> @@ -1139,29 +1141,41 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>  		return ERR_PTR(-ENXIO);
>  	}
>  
> -	if (snprintf(link_name, CXL_TARGET_STRLEN, "dport%d", port_id) >=
> -	    CXL_TARGET_STRLEN)
> +	id = ida_alloc(&port->dport_ida, GFP_KERNEL);
> +	if (id < 0)
> +		return ERR_PTR(id);
> +
> +	if (snprintf(link_name, CXL_TARGET_STRLEN, "dport%d", id) >=
> +	    CXL_TARGET_STRLEN) {
> +		ida_free(&port->dport_ida, id);

I'm not that keen on the number of places we have to call ida_free() manually
in error paths.  I think that's because we should have another devm
handler...

>  		return ERR_PTR(-EINVAL);
> +	}
>  
>  	dport = devm_kzalloc(host, sizeof(*dport), GFP_KERNEL);
> -	if (!dport)
> +	if (!dport) {
> +		ida_free(&port->dport_ida, id);
>  		return ERR_PTR(-ENOMEM);
> +	}
>  
>  	dport->dport_dev = dport_dev;
>  	dport->port_id = port_id;
>  	dport->port = port;
> +	dport->id = id;
>  
>  	if (rcrb == CXL_RESOURCE_NONE) {
>  		rc = cxl_dport_setup_regs(&port->dev, dport,
>  					  component_reg_phys);
> -		if (rc)
> +		if (rc) {
> +			ida_free(&port->dport_ida, id);
>  			return ERR_PTR(rc);
> +		}
>  	} else {
>  		dport->rcrb.base = rcrb;
>  		component_reg_phys = __rcrb_to_component(dport_dev, &dport->rcrb,
>  							 CXL_RCRB_DOWNSTREAM);
>  		if (component_reg_phys == CXL_RESOURCE_NONE) {
>  			dev_warn(dport_dev, "Invalid Component Registers in RCRB");
> +			ida_free(&port->dport_ida, id);
>  			return ERR_PTR(-ENXIO);
>  		}
>  
> @@ -1170,8 +1184,10 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>  		 * memdev
>  		 */
>  		rc = cxl_dport_setup_regs(NULL, dport, component_reg_phys);
> -		if (rc)
> +		if (rc) {
> +			ida_free(&port->dport_ida, id);
>  			return ERR_PTR(rc);
> +		}
>  
>  		dport->rch = true;
>  	}
> @@ -1183,8 +1199,10 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>  	cond_cxl_root_lock(port);
>  	rc = add_dport(port, dport);
>  	cond_cxl_root_unlock(port);
> -	if (rc)
> +	if (rc) {
> +		ida_free(&port->dport_ida, id);
>  		return ERR_PTR(rc);
> +	}
>  
>  	get_device(dport_dev);
>  	rc = devm_add_action_or_reset(host, cxl_dport_remove, dport);

