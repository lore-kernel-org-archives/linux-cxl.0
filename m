Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC4118E06
	for <linux-cxl@vger.kernel.org>; Mon,  5 Feb 2024 11:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707132732; cv=none; b=an+oNAjoYv7p20fg/sVxgoUU5RyDENPKtIbZu2jkDUF0U74hE6rhUGagmM0ts6e8Y9pt5nshG9WJa0w36InKfUsHqvhOdEOGI/H2tgmH/gdWNBmL+QWT+amU9UNqap4q9SMPPz/TQEcMbFd2FBWJMr8HWLWSOnLQB2sbssUtS5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707132732; c=relaxed/simple;
	bh=42rZBIcJGbexm2gqbTPDdpMb6vYVegqR7Z2Lgq+HJqc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TWia5y0jEvZGNLx9013rcRPFcVwImbvFJm1cxT5t2s9xl9qlgfDeXAwD/LTT1C/ts9n9QeLAagKOkxUe5x60jpbx8Url9cbvNzfhVDQKlKZ6asnauYpFz14aqzTlEHir6xSPwaY7NZpg3AmGTMWI+omOmxD8XDPQxFsmDzog1h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TT3zq1zhRz6K6QP;
	Mon,  5 Feb 2024 19:28:55 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 2E721140CF4;
	Mon,  5 Feb 2024 19:32:07 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 5 Feb
 2024 11:32:06 +0000
Date: Mon, 5 Feb 2024 11:32:06 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>
Subject: Re: [PATCH v3 1/3] cxl: Change 'struct cxl_memdev_state'
 *_perf_list to single 'struct cxl_dpa_perf'
Message-ID: <20240205113206.00004f1f@Huawei.com>
In-Reply-To: <20240201214731.1297389-1-dave.jiang@intel.com>
References: <20240201214731.1297389-1-dave.jiang@intel.com>
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
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 1 Feb 2024 14:47:29 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> In order to address the issue with being able to expose qos_class sysfs
> attributes under 'ram' and 'pmem' sub-directories, the attributes must
> be defined as static attributes rather than under driver->dev_groups.
> To avoid implementing locking for accessing the 'struct cxl_dpa_perf`
> lists, convert the list to a single 'struct cxl_dpa_perf' entry in
> preparation to move the attributes to statically defined.
> 
> While theoretically a partition may have multiple qos_class via CDAT, this
> has not been encountered with testing on available hardware. The code is
> simplified for now to not support the complex case until a use case is
> needed to support that.
> 
> Link: https://lore.kernel.org/linux-cxl/65b200ba228f_2d43c29468@dwillia2-mobl3.amr.corp.intel.com.notmuch/
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
A few comments inline.

Jonathan

> ---
> v3:
> - Add to commit log about simplification (Dan)
> - Remove check for dev->driver (Dan)
> - Remove check for invalid qos_class (Dan)
> ---
>  drivers/cxl/core/cdat.c | 81 ++++++++++++-----------------------------
>  drivers/cxl/core/mbox.c |  4 +-
>  drivers/cxl/cxlmem.h    | 10 ++---
>  drivers/cxl/mem.c       | 28 ++------------
>  4 files changed, 33 insertions(+), 90 deletions(-)
> 
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index 6fe11546889f..55b82dfd794b 100644
> --- a/drivers/cxl/core/cdat.c

>  static void cxl_qos_match(struct cxl_port *root_port,
> -			  struct list_head *work_list,
> -			  struct list_head *discard_list)
> +			  struct cxl_dpa_perf *dpa_perf)
>  {
> -	struct cxl_dpa_perf *dpa_perf, *n;
> +	int rc;
>  
> -	list_for_each_entry_safe(dpa_perf, n, work_list, list) {
> -		int rc;
> +	if (dpa_perf->qos_class == CXL_QOS_CLASS_INVALID)
> +		return;
>  
> -		if (dpa_perf->qos_class == CXL_QOS_CLASS_INVALID)
> -			return;
> -
> -		rc = device_for_each_child(&root_port->dev,
> -					   (void *)&dpa_perf->qos_class,
> -					   match_cxlrd_qos_class);
> -		if (!rc)
> -			list_move_tail(&dpa_perf->list, discard_list);
> -	}
> +	rc = device_for_each_child(&root_port->dev,

Over aggressive wrap.

> +				   &dpa_perf->qos_class,
> +				   match_cxlrd_qos_class);
> +	if (!rc)
> +		reset_dpa_perf(dpa_perf);

I'm not particularly keen on a function that on failure to match resets
some internal state in one of it's inputs.
Would prefer to see this return a bool then the caller decide to reset it.

>  }
>  
>  static int match_cxlrd_hb(struct device *dev, void *data)
> @@ -334,23 +312,10 @@ static int match_cxlrd_hb(struct device *dev, void *data)
>  	return 0;
>  }
>  

>  static int cxl_qos_class_verify(struct cxl_memdev *cxlmd)
>  {
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> -	LIST_HEAD(__discard);
> -	struct list_head *discard __free(dpa_perf) = &__discard;
>  	struct cxl_port *root_port;
>  	int rc;
>  
> @@ -363,16 +328,16 @@ static int cxl_qos_class_verify(struct cxl_memdev *cxlmd)
>  	root_port = &cxl_root->port;
>  
>  	/* Check that the QTG IDs are all sane between end device and root decoders */
> -	cxl_qos_match(root_port, &mds->ram_perf_list, discard);
> -	cxl_qos_match(root_port, &mds->pmem_perf_list, discard);
> +	cxl_qos_match(root_port, &mds->ram_perf);
> +	cxl_qos_match(root_port, &mds->pmem_perf);
>  
>  	/* Check to make sure that the device's host bridge is under a root decoder */
>  	rc = device_for_each_child(&root_port->dev,
>  				   (void *)cxlmd->endpoint->host_bridge,

Why is the explicit void * cast needed?  It's not removing const or anything like
that so usual c rules on it being fine to implicitly cast to void * should apply.


>  				   match_cxlrd_hb);
>  	if (!rc) {
> -		list_splice_tail_init(&mds->ram_perf_list, discard);
> -		list_splice_tail_init(&mds->pmem_perf_list, discard);
> +		reset_dpa_perf(&mds->ram_perf);
> +		reset_dpa_perf(&mds->pmem_perf);
>  	}
>  
>  	return rc;
