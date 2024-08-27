Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6234F155CA5
	for <linux-cxl@vger.kernel.org>; Tue, 27 Aug 2024 11:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724759287; cv=none; b=nENFOT8aL9zdncq4OpL7sOklT99l38ayzwPvQN+ang9OT3E6WYGMtuh2mMZSHcQia7mlmlLdKh2+h3ymEsBTs/mEHKyeCDpqCpUwVY1//JqGXkxx7u6ZcQajtgKrnRS/giW+3eCbwSmhXqbd/4vvss/NctelpIzJdeBYIi59i2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724759287; c=relaxed/simple;
	bh=4kxZqSc5s2rY5hcgeL2biDYQvJyTz3LwNbFkhYJBk+4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=acfD2DV03ef5DzIWMMr+4WuJGDiHtigBqcnpfO5X5QzBy7DNTUO2o18+jOjdXz71QIbDaDhJ+Qb3OzBkkjyjFMuJdEd2jQfNt6dljwEDsWYQqqT0bwjQp92YYzIdXJqamNLZcDcZaOk3ZEekusDjKWEvCqdd9ujf3aGjXgyD1SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WtQgz2rNVz6K9d3;
	Tue, 27 Aug 2024 19:44:47 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id B5180140B39;
	Tue, 27 Aug 2024 19:48:02 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 27 Aug
 2024 12:48:02 +0100
Date: Tue, 27 Aug 2024 12:48:01 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Li Ming <ming4.li@intel.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] cxl/port: Use __free() to drop put_device() for
 cxl_port
Message-ID: <20240827124801.00002f31@Huawei.com>
In-Reply-To: <20240826083058.1509232-1-ming4.li@intel.com>
References: <20240826083058.1509232-1-ming4.li@intel.com>
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

On Mon, 26 Aug 2024 08:30:56 +0000
Li Ming <ming4.li@intel.com> wrote:

> Using scope-based resource management __free() marco with a new helper
> called put_cxl_port() to drop open coded the put_device() used to
> dereference the 'struct device' in cxl_port.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Li Ming <ming4.li@intel.com>

I'm a bit doubtful about this in general because of the increase
in scope and reordering of the releases, but there
is one case below that I particularly dislike.

This is fiddly code so you've done a good job btw.

Jonathan

> ---
> v2:
> - Use guard() instead of scoped_guard() in some cases.
> - Ira: Check the return value of find_cxl_port_at().
> Link to v1: https://lore.kernel.org/linux-cxl/8ac82c61-7871-4914-b376-32431868622c@intel.com/T/#m07695675435bf702311dfc40f64289b9623afa16
> ---

> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 1d5007e3795a..b50dda6610e3 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c

> @@ -1539,8 +1537,8 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
>  			      struct device *uport_dev,
>  			      struct device *dport_dev)
>  {
> +	struct cxl_port *port __free(put_cxl_port) = NULL;

I don't much like the ordering here.  This will get freed
later than it probably should.

Can you move it down to just before the device_lock() is taken?
That way at least it will get released in the same order
wrt to the parent_port->dev + keep it's constructor as near
as possible.



>  	struct device *dparent = grandparent(dport_dev);
> -	struct cxl_port *port, *parent_port = NULL;
>  	struct cxl_dport *dport, *parent_dport;
>  	resource_size_t component_reg_phys;
>  	int rc;
> @@ -1556,7 +1554,8 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
>  		return -ENXIO;
>  	}
>  
> -	parent_port = find_cxl_port(dparent, &parent_dport);
> +	struct cxl_port *parent_port __free(put_cxl_port) =
> +		find_cxl_port(dparent, &parent_dport);
>  	if (!parent_port) {
>  		/* iterate to create this parent_port */
>  		return -EAGAIN;
> @@ -1596,10 +1595,8 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
>  			 */
>  			rc = -ENXIO;
>  		}
> -		put_device(&port->dev);
>  	}
>  
> -	put_device(&parent_port->dev);
>  	return rc;
>  }

