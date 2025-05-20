Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B91619E968
	for <linux-cxl@vger.kernel.org>; Tue, 20 May 2025 12:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747744475; cv=none; b=aNeYDiCqjbidvlmBFbEoclQuBu0Z4OCTUmLJzi0wOo1/lX3iCefR4HxXJQrbw7js3T9JDyUn7HewKKaEuCQDQT1MmPhVwzKQ+8eJDZ4VqC8fZZXYMW4sUd0+mfIOdXeC9zVqQcjpULYJ1nU65bppo3jCGrqQNobCb+oySv14CQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747744475; c=relaxed/simple;
	bh=IWowBKzl0vLUTKGpbDiwYUWV0J7pdbk+itmki8a3N6w=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TBvB4oDq7qVxOQa8dRUW18sn3+TyGEF7IXDDihSBKpyIx6B9msuZ/bzbMGHW9ahnW1EAmPmnHlUjXqyjaQEomfg43F1KADpmgvSnYy3BqCxDGOAvXHeP3LAru5BCB/r0vwqv9lftXc479F3KLOFjE7in0TstqydU7LJ+kMvQcEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b1v6z0dS9z6H6vr;
	Tue, 20 May 2025 20:31:23 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 3878014050C;
	Tue, 20 May 2025 20:34:31 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 20 May
 2025 14:34:30 +0200
Date: Tue, 20 May 2025 13:34:29 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>,
	<dave@stgolabs.net>, <alison.schofield@intel.com>, <ira.weiny@intel.com>,
	<rrichter@amd.com>, <ming.li@zohomail.com>
Subject: Re: [PATCH v2 08/10] cxl: Add helper to detect top of CXL device
 topology
Message-ID: <20250520133429.000056ab@huawei.com>
In-Reply-To: <20250507004310.3536991-9-dave.jiang@intel.com>
References: <20250507004310.3536991-1-dave.jiang@intel.com>
	<20250507004310.3536991-9-dave.jiang@intel.com>
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

On Tue, 6 May 2025 17:43:08 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Add a helper to replace the open code detection of CXL device hierarchy
> root. The helper will be used for delayed hostbridge port creation later
> on.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Another one that I think can be yanked out ahead of the
main series so we can focus on the more substantial stuff.

Reviewed-by: Jonathan Cameron <Jonsathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/port.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index e212bc2faada..259b217e812f 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -39,6 +39,15 @@ DECLARE_RWSEM(cxl_region_rwsem);
>  static DEFINE_IDA(cxl_port_ida);
>  static DEFINE_XARRAY(cxl_root_buses);
>  
> +/*
> + * The terminal device in PCI is NULL and @platform_bus
> + * for platform devices (for cxl_test)
> + */
> +static bool is_cxl_hierarchy_head(struct device *dev)
> +{
> +	return (!dev || dev == &platform_bus);
> +}
> +
>  int cxl_num_decoders_committed(struct cxl_port *port)
>  {
>  	lockdep_assert_held(&cxl_region_rwsem);
> @@ -1774,11 +1783,7 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
>  		struct device *uport_dev;
>  		struct cxl_dport *dport;
>  
> -		/*
> -		 * The terminal "grandparent" in PCI is NULL and @platform_bus
> -		 * for platform devices
> -		 */
> -		if (!dport_dev || dport_dev == &platform_bus)
> +		if (is_cxl_hierarchy_head(dport_dev))
>  			return 0;
>  
>  		uport_dev = dport_dev->parent;

