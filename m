Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5842874E4
	for <linux-cxl@vger.kernel.org>; Fri, 15 Aug 2025 12:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755262224; cv=none; b=cWtBq2F3NSJFmz0lYV4XslOEAvB3vwUJwBAmXCV6DH/LHqZCFtpFyw/9dH+el3xEBaDx7ImwmNg/JDJfO4OU+WOSumbxFDMxXHJuyY2IefqjAgwhHbNgEpFQlFngqNKjQTXBacDnoE21Zs+PsljSowTFXimySBpJRpVTL80sNso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755262224; c=relaxed/simple;
	bh=semqrcwO2T8oFUmRa16pp93zV/GSdsoYjaLc9jrQik4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CwtQQQzT/eMfxa2LNS74iPxHxDHkBhBfzrUFT31C918G2lIaI3rgxtexhgYAlyPmGcztZ4rLNX0SjxwfxOzJSnetGh5e+hnXHUqjr/shXoS6ZFc767ZQzfANHs1HhUUZgAgNYXbjeIMGaJJurUY4Fru6gEHXVo0hEXESuo+AIZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4c3MJv3TMpz6L5Nc;
	Fri, 15 Aug 2025 20:45:19 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id BEF171404C5;
	Fri, 15 Aug 2025 20:50:17 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 15 Aug
 2025 14:50:17 +0200
Date: Fri, 15 Aug 2025 13:50:15 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, <rrichter@amd.com>, "Li
 Ming" <ming.li@zohomail.com>
Subject: Re: [PATCH v8 01/11] cxl: Add helper to detect top of CXL device
 topology
Message-ID: <20250815135015.000078cc@huawei.com>
In-Reply-To: <20250814222151.3520500-2-dave.jiang@intel.com>
References: <20250814222151.3520500-1-dave.jiang@intel.com>
	<20250814222151.3520500-2-dave.jiang@intel.com>
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
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 14 Aug 2025 15:21:41 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Add a helper to replace the open code detection of CXL device hierarchy
> root, or the host bridge. The helper will be used for delayed downstream
> port (dport) creation.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Li Ming <ming.li@zohomail.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v8:
> - Rename to is_cxl_host_bridge() (Dan)
> - Rename duplicate tags from Jonathan
> ---
>  drivers/cxl/core/port.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 29197376b18e..855623cebd7d 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -33,6 +33,15 @@
>  static DEFINE_IDA(cxl_port_ida);
>  static DEFINE_XARRAY(cxl_root_buses);
>  
> +/*
> + * The terminal device in PCI is NULL and @platform_bus
> + * for platform devices (for cxl_test)

Silly but it tickled my in built line length detector...

* The terminal device in PCI is NULL and @platform_bus for platform devices 
* (for cxl_test)

Obviously makes to practical difference to anything!


> + */
> +static bool is_cxl_host_bridge(struct device *dev)
> +{
> +	return (!dev || dev == &platform_bus);
> +}
> +
>  int cxl_num_decoders_committed(struct cxl_port *port)
>  {
>  	lockdep_assert_held(&cxl_rwsem.region);
> @@ -1541,7 +1550,7 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
>  	resource_size_t component_reg_phys;
>  	int rc;
>  
> -	if (!dparent) {
> +	if (is_cxl_host_bridge(dparent)) {
>  		/*
>  		 * The iteration reached the topology root without finding the
>  		 * CXL-root 'cxl_port' on a previous iteration, fail for now to
> @@ -1629,11 +1638,7 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
>  		struct device *uport_dev;
>  		struct cxl_dport *dport;
>  
> -		/*
> -		 * The terminal "grandparent" in PCI is NULL and @platform_bus
> -		 * for platform devices
> -		 */
> -		if (!dport_dev || dport_dev == &platform_bus)
> +		if (is_cxl_host_bridge(dport_dev))
>  			return 0;
>  
>  		uport_dev = dport_dev->parent;

