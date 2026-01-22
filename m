Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608ED37C0E9
	for <linux-cxl@vger.kernel.org>; Thu, 22 Jan 2026 11:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769081954; cv=none; b=li/sM2uEMc3J7YkNqzkN+e5l/25zXlH4VA/RAa1IHTQO8WkpLEP8KR3hDcgmvDApQ/3jot5cYegVk3fTz+whhib5jitik/qaipXfTDGLGZ2hxTX/RmdLeqyGoLXLWpaqylLPgcF9eAu4SEJSZ2yM4lfZgcREaX+1kLpuW+DeZsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769081954; c=relaxed/simple;
	bh=thmxlGjmaO+nwhRVCf64tWTUeLN00gG4Y6pKdp0094w=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YiVRtm8KvaVgZITO36WSG1Sjne4pz0vRVbPGcQE1Uznta4EbSP/z9JdTdjhLZDQuNaARsQQXTqv4Qln5lPRDid01yUNzFy70y8v6z+h5bZVZM13YtIUF8MBzWoGk05Y312cedYo6E2yfrIh7m7Be9/LC2dV0t519cM1CXfKzPl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dxfG856smzJ46dc;
	Thu, 22 Jan 2026 19:38:40 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 5E84440569;
	Thu, 22 Jan 2026 19:39:08 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 22 Jan
 2026 11:39:07 +0000
Date: Thu, 22 Jan 2026 11:39:06 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <ira.weiny@intel.com>, <terry.bowman@amd.com>
Subject: Re: [PATCH 2/9] cxl/port: Reduce number of @dport variables in
 cxl_port_add_dport()
Message-ID: <20260122113906.000028d2@huawei.com>
In-Reply-To: <20260122033330.1622168-3-dan.j.williams@intel.com>
References: <20260122033330.1622168-1-dan.j.williams@intel.com>
	<20260122033330.1622168-3-dan.j.williams@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Wed, 21 Jan 2026 19:33:23 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> In preparation for refactoring cxl_port_add_dport() to add RAS register
> setup, cleanup the number of dport variables with a dport_exists() helper.
Maybe mention why the driver check is now after the duplicate check.
If there isn't a reason for that, I'd put them back to reduce churn a tiny
bit.

> 
> Kill the @dport needed to check for duplicates, rename @new_dport to
> @dport.
In ideal world I think the helper introduction and the rename
would be two patches. Still real world, this is fine.

Assuming you'll address the reorder of checks by comment or
putting them back,

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>


> 
> Reported-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Closes: http://lore.kernel.org/20260116150119.00003bbd@huawei.com
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/core/port.c | 43 +++++++++++++++++++++++++----------------
>  1 file changed, 26 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index ff899c690d85..1637e97f6805 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1587,30 +1587,39 @@ static int update_decoder_targets(struct device *dev, void *data)
>  	return 0;
>  }
>  
> +static bool dport_exists(struct cxl_port *port, struct device *dport_dev)
> +{
> +	struct cxl_dport *dport = cxl_find_dport_by_dev(port, dport_dev);
> +
> +	if (dport) {
> +		dev_dbg(&port->dev, "dport%d:%s already exists\n",
> +			dport->port_id, dev_name(dport_dev));
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
>  DEFINE_FREE(del_cxl_dport, struct cxl_dport *, if (!IS_ERR_OR_NULL(_T)) del_dport(_T))
>  static struct cxl_dport *cxl_port_add_dport(struct cxl_port *port,
>  					    struct device *dport_dev)
>  {
> -	struct cxl_dport *dport;
>  	int rc;
>  
>  	device_lock_assert(&port->dev);
> -	if (!port->dev.driver)
> -		return ERR_PTR(-ENXIO);

Diff is a bit of a mess due to the checks (originally driver bind
then duplicate test) being swapped.
Is there a reason to do that?


>  
> -	dport = cxl_find_dport_by_dev(port, dport_dev);
> -	if (dport) {
> -		dev_dbg(&port->dev, "dport%d:%s already exists\n",
> -			dport->port_id, dev_name(dport_dev));
> +	if (dport_exists(port, dport_dev))
>  		return ERR_PTR(-EBUSY);
> -	}
>  
> -	struct cxl_dport *new_dport __free(del_cxl_dport) =
> +	if (!port->dev.driver)
> +		return ERR_PTR(-ENXIO);
> +
> +	struct cxl_dport *dport __free(del_cxl_dport) =
>  		devm_cxl_add_dport_by_dev(port, dport_dev);
> -	if (IS_ERR(new_dport))
> -		return new_dport;
> +	if (IS_ERR(dport))
> +		return dport;
>  
> -	cxl_switch_parse_cdat(new_dport);
> +	cxl_switch_parse_cdat(dport);
>  
>  	if (port->nr_dports == 1) {
>  		/*
> @@ -1626,17 +1635,17 @@ static struct cxl_dport *cxl_port_add_dport(struct cxl_port *port,
>  		if (rc)
>  			return ERR_PTR(rc);
>  		dev_dbg(&port->dev, "first dport%d:%s added with decoders\n",
> -			new_dport->port_id, dev_name(dport_dev));
> -		return no_free_ptr(new_dport);
> +			dport->port_id, dev_name(dport_dev));
> +		return no_free_ptr(dport);
>  	}
>  
>  	/* New dport added, update the decoder targets */
> -	device_for_each_child(&port->dev, new_dport, update_decoder_targets);
> +	device_for_each_child(&port->dev, dport, update_decoder_targets);
>  
> -	dev_dbg(&port->dev, "dport%d:%s added\n", new_dport->port_id,
> +	dev_dbg(&port->dev, "dport%d:%s added\n", dport->port_id,
>  		dev_name(dport_dev));
>  
> -	return no_free_ptr(new_dport);
> +	return no_free_ptr(dport);
>  }
>  
>  static struct cxl_dport *devm_cxl_create_port(struct device *ep_dev,

