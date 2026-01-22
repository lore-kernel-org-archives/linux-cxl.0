Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB4A2D9EE4
	for <linux-cxl@vger.kernel.org>; Thu, 22 Jan 2026 13:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769087290; cv=none; b=hoR6ZuVdhrD/SvTAgkt3JgoxW5tX5l0Mn1s0HITNkG6UABhG/ok558y8ocfNCpoRI0HKdrNrWFUuC2YObgNNP/eFG8pmUGUVNn2GWxoQsgtx18YzRWh8XJV+0mq1VH93ZAMgXxGsc4tcByrFq6uqIwjN+4rTauQtZPfOKtOvYH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769087290; c=relaxed/simple;
	bh=owtuU8xKEWByCt05QdZixDi64XA+JD/J+4LRdrHhhOQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FGbz6EPtNc5oW2FhWh/FeuyBY4ZG7HORyekWIUMe4iVqK613oL+G7F2GoBXyRo9IE1MzY1swEsrAKYdMpa8QXrcMcF+/s3RBDgRRzhhm+swzx/DNjwBTXW5C2T/9ciSV8ljKAKS+Fg381YZeVzNv60iHKHsCS2eiUCW+4pMxCms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dxhDd5tLMzJ469G;
	Thu, 22 Jan 2026 21:07:29 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 90AD640569;
	Thu, 22 Jan 2026 21:07:57 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 22 Jan
 2026 13:07:57 +0000
Date: Thu, 22 Jan 2026 13:07:55 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <ira.weiny@intel.com>, <terry.bowman@amd.com>
Subject: Re: [PATCH 4/9] cxl/port: Move decoder setup before dport creation
Message-ID: <20260122130755.000016e4@huawei.com>
In-Reply-To: <20260122033330.1622168-5-dan.j.williams@intel.com>
References: <20260122033330.1622168-1-dan.j.williams@intel.com>
	<20260122033330.1622168-5-dan.j.williams@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Wed, 21 Jan 2026 19:33:25 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> There are port setup actions that run on first dport arrival, and there are
> setup actions that run per dport.
> 
> RAS register setup is a future additional setup action to run per-port
> (once the first dport arrives), and each dport also has RAS registers to
> map.
> 
> Before adding that, flip the order of "first dport" and "per-dport"
> actions. This makes allocation symmetric with teardown, "first dport"
> actions unwind after last dport removed. It also allows for using a devres
> group to collect the unrelated decoder, RAS, and dport setup actions into
> one group release action.
> 
> The new cxl_port_open_group() collects "first dport" and "per-dport" into
> one group that can be released on any failure. This group's lifetime only
> needs to span the short duration of cxl_port_add_dport() to cleanup all
> potential damage from failing to add a dport. Contrast that to the "dport"
> devres group that is called upon to destruct fully formed dport objects.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Trivial stuff only.  Took me a while to get my head around the temporary
group usage, but having done so it seems correct to me.  I poked the
various paths fairly heavily to be sure they all worked out after
thinking there was a bug due to a misread :(

Either way on suggestions below.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> ---
>  drivers/cxl/core/port.c | 43 +++++++++++++++++++++++++++++------------
>  1 file changed, 31 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index f2723bf948e2..f69395ea0c14 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1650,10 +1650,24 @@ static bool dport_exists(struct cxl_port *port, struct device *dport_dev)
>  	return false;
>  }
>  
> -DEFINE_FREE(del_cxl_dport, struct cxl_dport *, if (!IS_ERR_OR_NULL(_T)) del_dport(_T))
> +static void *cxl_port_open_group(struct cxl_port *port)
> +{
> +	return devres_open_group(&port->dev, port, GFP_KERNEL);
So only reason you are using port as the ID is so there is just one thing
to pass to the DEFINE_FREE() callback. Fair enough, but...
> +}
> +
> +/* note this implicitly casts @port_group back to its @port */
> +DEFINE_FREE(cxl_port_release_group, struct cxl_port *,
> +	    if (_T) devres_release_group(&_T->dev, _T))
> +
> +static void cxl_port_remove_group(struct cxl_port *port, void *port_group)
> +{
> +	devres_remove_group(&port->dev, port_group);

To keep this inline with the DEFINE_FREE(), I'd pass in only one parameter.
Can in theory be either of them but to me port_group is more
consistent. Then cast that to get the struct cxl_port *


> +}
> +
>  static struct cxl_dport *cxl_port_add_dport(struct cxl_port *port,
>  					    struct device *dport_dev)
>  {
> +	struct cxl_dport *dport;
>  	int rc;
>  
>  	device_lock_assert(&port->dev);
> @@ -1664,14 +1678,13 @@ static struct cxl_dport *cxl_port_add_dport(struct cxl_port *port,
>  	if (!port->dev.driver)
>  		return ERR_PTR(-ENXIO);
>  
> -	struct cxl_dport *dport __free(del_cxl_dport) =
> -		devm_cxl_add_dport_by_dev(port, dport_dev);
> -	if (IS_ERR(dport))
> -		return dport;
> -
> -	cxl_switch_parse_cdat(dport);
> +	/* Temp group for all "first dport" and "per dport" setup actions */
> +	void *port_group __free(cxl_port_release_group) =
> +		cxl_port_open_group(port);
> +	if (!port_group)
> +		return ERR_PTR(-ENOMEM);
>  
> -	if (port->nr_dports == 1) {
> +	if (port->nr_dports == 0) {
>  		/*
>  		 * Some host bridges are known to not have component regsisters
>  		 * available until a root port has trained CXL. Perform that
> @@ -1684,18 +1697,24 @@ static struct cxl_dport *cxl_port_add_dport(struct cxl_port *port,
>  		rc = devm_cxl_switch_port_decoders_setup(port);
>  		if (rc)
>  			return ERR_PTR(rc);
> -		dev_dbg(&port->dev, "first dport%d:%s added with decoders\n",
> -			dport->port_id, dev_name(dport_dev));
> -		return no_free_ptr(dport);
>  	}
>  
> +	dport = devm_cxl_add_dport_by_dev(port, dport_dev);
> +	if (IS_ERR(dport))
> +		return dport;
> +
> +	/* This group was only needed for early exit above */
> +	cxl_port_remove_group(port, no_free_ptr(port_group));
> +
> +	cxl_switch_parse_cdat(dport);
> +
>  	/* New dport added, update the decoder targets */
>  	device_for_each_child(&port->dev, dport, update_decoder_targets);
>  
>  	dev_dbg(&port->dev, "dport%d:%s added\n", dport->port_id,

> -	return no_free_ptr(dport);
> +	return dport;
>  }
>  
>  static struct cxl_dport *devm_cxl_create_port(struct device *ep_dev,

