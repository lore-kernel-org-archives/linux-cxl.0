Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D39D28B50C
	for <linux-cxl@vger.kernel.org>; Tue, 10 Jun 2025 09:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749548111; cv=none; b=MtgFDUEYuGm7kkYsSipjX2a+wR2az86efNmYkbfkZyAJD5LXENQQodhuxIk1HyiYf3MpYVOkmV+ctIsExmHF5HxFL5/22BFMxQ7WppdJGh2XKIPHGyxIfTxpdAb4nyMFLwUajrmK3Damq9uSWQt6y2kqXOxa1WfSgNDSLxTs+94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749548111; c=relaxed/simple;
	bh=/bs5AXxVqK7qW+/x+CsYi3dKgwdNGYuwdSfSWGWDI1c=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EHGOHFxkV/z6eXyDtOpNCZgQ/YcOjl2n8+EidZabmzhewy2Of6vDnMI3lSb2jPk+nbWWLlN2vkjiQJv2yzJ083UI/9Vnza/MF/uXPv/BlyUv0+UVm0crJZgMZB63ai84uD+pL1q2d5mRZw9ebDOeGjOB0oNYW4vL3kNlYbywGp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bGk9n2dzGz6HJbM;
	Tue, 10 Jun 2025 17:33:17 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id B5DCB140275;
	Tue, 10 Jun 2025 17:35:06 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 10 Jun
 2025 11:35:06 +0200
Date: Tue, 10 Jun 2025 10:35:04 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
Subject: Re: [PATCH v2] cxl: Remove core/acpi.c and cxl core dependency on
 ACPI
Message-ID: <20250610103504.00004316@huawei.com>
In-Reply-To: <20250610000237.2929667-2-dave.jiang@intel.com>
References: <20250610000237.2929667-1-dave.jiang@intel.com>
	<20250610000237.2929667-2-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 9 Jun 2025 17:02:37 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> It was a mistake to introduce core/acpi.c and putting ACPI dependency on
> cxl_core when adding the extended linear cache support. Add a callback
> in the cxl_root_decoder to retrieve the extended linear cache size from
> ACPI via the cxl_acpi driver.
> 
> In order to deal with cxl_test, a device parameter had to be introduced
> to the hmat_get_extended_linear_cache_size() call in order to help with
> the mock wrapped function from ACPI. Even though the 'struct device' is
> not used by the actual hmat_get_extended_linear_cache_size() function.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v2:
> - Remove introduction of 'struct device' parameter to
>   hmat_get_extended_linear_cache_size().
> - Drop comment on flex array (Jonathan)
> - Rename cxl_rcd_ops to cxl_rd_ops for 'root decoder ops' (Fabio)
There is a lot of indirection going on in here, but I think I understand
why it is all there.  A few comments inline. The device reference one
just passes what I'm comfortable assuming you will just fix it up though
so I'll wait for v3 for tags.

J

> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 8a5815ca870d..3f6780179752 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -470,6 +470,43 @@ struct cxl_cedt_context {
>  	struct device *dev;
>  };
>  
> +static int match_root_decoder_by_range(struct device *dev, const void *data)
> +{
> +	const struct range *r1, *r2 = data;

I'm fussy about this, but I'd not mix a non assigned and assigned declaration
in one line.  (Trivial comment though so ignore if you like)

> +	struct cxl_root_decoder *cxlrd;
> +
> +	if (!is_root_decoder(dev))
> +		return 0;
> +
> +	cxlrd = to_cxl_root_decoder(dev);
> +	r1 = &cxlrd->cxlsd.cxld.hpa_range;
> +	return range_contains(r1, r2);
> +}
> +
> +static int mock_hmat_get_extended_linear_cache_size(struct resource *backing_res,
> +						    int nid, resource_size_t *size)
> +{
> +	struct range backing_range = {
> +		.start = backing_res->start,
> +		.end = backing_res->end,
> +	};
> +	struct cxl_decoder *cxld;
> +	struct cxl_port *port;
> +	struct device *dev;
> +
> +	dev = bus_find_device(&cxl_bus_type, NULL, &backing_range,
> +			      match_root_decoder_by_range);

This grabs a reference to the device.  Do we need a put_device()
somewhere?

> +	if (!dev)
> +		return -ENODEV;
> +
> +	cxld = to_cxl_decoder(dev);
> +	port = to_cxl_port(cxld->dev.parent);
> +	if (is_mock_dev(port->uport_dev))
> +		return -EOPNOTSUPP;
> +
> +	return hmat_get_extended_linear_cache_size(backing_res, nid, size);
> +}
> +
>  static int mock_acpi_table_parse_cedt(enum acpi_cedt_type id,
>  				      acpi_tbl_entry_handler_arg handler_arg,
>  				      void *arg)
> @@ -1040,6 +1077,8 @@ static struct cxl_mock_ops cxl_mock_ops = {
>  	.devm_cxl_enumerate_decoders = mock_cxl_enumerate_decoders,
>  	.cxl_endpoint_parse_cdat = mock_cxl_endpoint_parse_cdat,
>  	.list = LIST_HEAD_INIT(cxl_mock_ops.list),
> +	.hmat_get_extended_linear_cache_size =
> +		mock_hmat_get_extended_linear_cache_size,
>  };

Why is list set last in here?  It's first in the structure
and we now end up with the callbacks not next to each other which looks
weird.  Maybe move the LIST_HEAD_INIT() up, or if not move the new
callback setting up one line to next to parse_cdat.



