Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD06D4C80
	for <linux-cxl@vger.kernel.org>; Tue, 24 Dec 2024 16:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735056682; cv=none; b=YFR837ggmii1GOmE2ImWSmQN6sVojnZN4gvCvmsT8edJppQGlhyBcMi8IZQTUnZNMsqYt67Ga/rNK6bBVlK3Ee6f8QQPSHQJM08xmW3NFbJBdVb5ObHgXXYYD7j6818DI0HBqbVyu92YkwBUsvgmpz8AtwCASv5HmArQ1NTMIKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735056682; c=relaxed/simple;
	bh=gy3rkKg5MYcAY1R9vZ61IDoDpMDQ485gljf0Dhf272k=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JuAUoe9o0RPxMDUGsakK+tU69pCP6XHGy/DldXuQgR0tkddMxrQvZEzt1Pn6FzOT75pJ/K9mNMGUl5zqpktu7h47IHnKVTA0DgxHFa2JVtW4E3ePk8s6uc6jaZFAOAKkKIuHBX0AFs1yPAI2JMe6/FCL7XuQ7xd5db37Bw3EC2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YHft34bdXz6K5rR;
	Wed, 25 Dec 2024 00:07:23 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id E99C1140391;
	Wed, 25 Dec 2024 00:11:16 +0800 (CST)
Received: from localhost (10.48.156.150) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 24 Dec
 2024 17:11:16 +0100
Date: Tue, 24 Dec 2024 16:11:13 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <dave.jiang@intel.com>, Li Ming <ming.li@zohomail.com>,
	<alison.schofield@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] cxl/mem: Hide RCD attributes when pre-requisites are
 missing
Message-ID: <20241224161113.00003c8d@huawei.com>
In-Reply-To: <173386304532.1383902.17130961308615551692.stgit@dwillia2-xfh.jf.intel.com>
References: <173386304532.1383902.17130961308615551692.stgit@dwillia2-xfh.jf.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 10 Dec 2024 12:37:25 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> A recent change to avoid a NULL rcd_pcie_cap pointer consumption in
> rcd_pcie_cap_emit() [1] arranged for the problematic sysfs attributes to
> return an error on access. However, if the attributes always fail on
> read they should simply be hidden.
> 
> Add a facility called @mem_groups that follows the same visibility rules
> as the "dev_groups" of the cxl_mem driver. It is expressly for
> PCI-device relative attributes, but that require the device to be
> additionally connected to the CXL port topology.
> 
> Link: http://lore.kernel.org/20241129132825.569237-1-ming.li@zohomail.com
> Cc: Li Ming <ming.li@zohomail.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Change makes sense. Only real comments are whether the prints
are too noisy.  Maybe demote to dev_dbg?

Jonathan


> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index af92c67bc954..a53f144bbac1 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1397,6 +1397,7 @@ static void delete_endpoint(void *data)
>  {
>  	struct cxl_memdev *cxlmd = data;
>  	struct cxl_port *endpoint = cxlmd->endpoint;
> +	struct device *parent = cxlmd->dev.parent;
>  	struct device *host = endpoint_host(endpoint);
>  
>  	scoped_guard(device, host) {
> @@ -1407,6 +1408,8 @@ static void delete_endpoint(void *data)
>  		}
>  		cxlmd->endpoint = NULL;
>  	}
> +	if (sysfs_update_groups(&parent->kobj, cxlmd->mem_groups))
> +		dev_info(parent, "CXL.mem sysfs attributes removed\n");

dev_info?  That seems noisy and very implementation specific.


>  	put_device(&endpoint->dev);
>  	put_device(host);
>  }
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 2a25d1957ddb..9c5f2544da75 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -43,6 +43,7 @@
>   * @cxl_nvb: coordinate removal of @cxl_nvd if present
>   * @cxl_nvd: optional bridge to an nvdimm if the device supports pmem
>   * @endpoint: connection to the CXL port topology for this memory device
> + * @mem_groups: host device groups that change visibility based on cxl_mem attach
>   * @id: id number of this memdev instance.
>   * @depth: endpoint port depth
>   */
> @@ -54,6 +55,7 @@ struct cxl_memdev {
>  	struct cxl_nvdimm_bridge *cxl_nvb;
>  	struct cxl_nvdimm *cxl_nvd;
>  	struct cxl_port *endpoint;
> +	const struct attribute_group **mem_groups;
>  	int id;
>  	int depth;
>  };
> @@ -87,8 +89,9 @@ static inline bool is_cxl_endpoint(struct cxl_port *port)
>  	return is_cxl_memdev(port->uport_dev);
>  }
>  
> -struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
> -				       struct cxl_dev_state *cxlds);
> +struct cxl_memdev *
> +devm_cxl_add_memdev(struct device *host, struct cxl_dev_state *cxlds,
> +		    const struct attribute_group **mem_groups);

I'd have been tempted to just go long lines and reduce the churn
caused be the reformat, but not important really.

>  int devm_cxl_sanitize_setup_notifier(struct device *host,
>  				     struct cxl_memdev *cxlmd);
>  struct cxl_memdev_state;
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index a9fd5cd5a0d2..2d2a662c99d4 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -50,6 +50,7 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
>  {
>  	struct cxl_port *parent_port = parent_dport->port;
>  	struct cxl_port *endpoint, *iter, *down;
> +	struct device *parent;
>  	int rc;
>  
>  	/*
> @@ -70,6 +71,13 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
>  	if (IS_ERR(endpoint))
>  		return PTR_ERR(endpoint);
>  
> +	parent = cxlmd->dev.parent;
> +	rc = sysfs_update_groups(&parent->kobj, cxlmd->mem_groups);
> +	if (rc) {
> +		dev_err(parent, "CXL.mem sysfs attributes removed\n");

Likewise, is this too noisy?

> +		return rc;
> +	}
> +
>  	rc = cxl_endpoint_autoremove(cxlmd, endpoint);
>  	if (rc)
>  		return rc;
