Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49980246797
	for <linux-cxl@vger.kernel.org>; Wed, 17 Dec 2025 16:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765987930; cv=none; b=czcxt4eJ/7EcnG5TzfeFsIqeccFgHrtmnHmT1zYWtqF44pn8+BS+9hSqD2ems337Cs7cNiuf4i7rmDphsk6UnGC1U8zdoHmPvIYhHbk1QsskP2UenYXxbKCDUp/cDZ+P6hOsK4dLCHV4v+BUykfNQCT0V1FIHhJVTnCqyp0mwYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765987930; c=relaxed/simple;
	bh=lO077ZBUIuwpxkmipQxZW4da3GbO01n1PmUCwAbEbwk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mqn5j5YLAcfQmh2ExnICxUO31F8S6DhFqsagSvt9Rwm4YHojbFKHiixaAUDGCXHFINDD7658IStaVgGaQocvjOFg2S+tKvG83nmTswK1EU6KL7PogkkathfiVC72IbYFnVpHFvV/ZvE0MNJEniKAgr8PPVNSBklzep52P9Ec0oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dWf1k2WJnzHnH4y;
	Thu, 18 Dec 2025 00:11:38 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id CE30E40570;
	Thu, 18 Dec 2025 00:12:03 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 17 Dec
 2025 16:12:03 +0000
Date: Wed, 17 Dec 2025 16:12:01 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 16/17] cxl/core: Add cache device attributes
Message-ID: <20251217161201.0000067f@huawei.com>
In-Reply-To: <20251111214032.8188-17-Benjamin.Cheatham@amd.com>
References: <20251111214032.8188-1-Benjamin.Cheatham@amd.com>
	<20251111214032.8188-17-Benjamin.Cheatham@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Tue, 11 Nov 2025 15:40:31 -0600
Ben Cheatham <Benjamin.Cheatham@amd.com> wrote:

> Add sysfs attributes for getting the numa node, CXL cache unit, and
> CXL cache size for a cachedev.
> 
> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
Documentation is king for ABI.

Documentation/ABI/testing/sysfs-bus-cxl probably.

> ---
>  drivers/cxl/core/cachedev.c | 85 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 85 insertions(+)
> 
> diff --git a/drivers/cxl/core/cachedev.c b/drivers/cxl/core/cachedev.c
> index 0b7430450b4e..d8bf18ec0579 100644
> --- a/drivers/cxl/core/cachedev.c
> +++ b/drivers/cxl/core/cachedev.c

> +static ssize_t cache_size_show(struct device *dev, struct device_attribute *attr,
> +			       char *buf)
> +{
> +	struct cxl_cachedev *cxlcd = to_cxl_cachedev(dev);
> +	struct cxl_dev_state *cxlds = cxlcd->cxlds;
> +	struct cxl_cache_state cstate = cxlds->cstate;

Why copy it?  &cxlds->cstate;
If there is a reason to copy add a comment.

> +
> +	return sysfs_emit(buf, "%llu\n", cstate.size);

> +}
> +static DEVICE_ATTR_RO(cache_size);
> +
> +static ssize_t cache_unit_show(struct device *dev, struct device_attribute *attr,
> +			       char *buf)
> +{
> +	struct cxl_cachedev *cxlcd = to_cxl_cachedev(dev);
> +	struct cxl_dev_state *cxlds = cxlcd->cxlds;
> +	struct cxl_cache_state cstate = cxlds->cstate;
> +	char unit_buf[32];
> +	int rc;
> +
> +	rc = string_get_size(cstate.size, 1, STRING_UNITS_2, unit_buf,
> +			     sizeof(unit_buf) - 1);

This reflects back to comment in earlier patch.  Do we care about unit
other than as a means to establish the size?  I'm not sure they have
meaning beyond allowing that register to express a larger range than
if we did it on 64K always.

> +	if (rc <= 0)
> +		return -ENXIO;
> +
> +	return sysfs_emit(buf, "%s\n", unit_buf);
> +}
> +static DEVICE_ATTR_RO(cache_unit);
