Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E375A1B4135;
	Mon, 13 Jan 2025 18:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736791902; cv=none; b=YCU51hVqjp4gefbjLUGnVQF+OWJLRrqPOyY0E+dQq63b/VtGuUhgaDxQaaTgutOlEWBxwpHkNdy3B3MhG3qxfUm6vT496CER4FrjQmMC9gHbb24t7bQrXXKEpvphgYoKgaBHKYJstbbxJMzA9UiGtNvfKWWMFQOVOuj/507j0uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736791902; c=relaxed/simple;
	bh=58LiwsGghCk3YkxfQ0TnBqMwOTVdzqWvb19kq9rVJQo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oxaayfyYv6dx8Xn1sscbsDX0cfM8tSttL3Re6gF/7WAv+NE0QkU5nSzH6SyBNfjokGGxio7oFMHOKX0iaRBZOuBYsJWrDanvMEoaA8d8PhF5+oPG4tEd/SEJEo2THMrUxOAmDCcZEnBxCFQMuvpe8x/sduAzF6Oue7z14gPFuuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YX0fW5PzMz6K5pB;
	Tue, 14 Jan 2025 02:10:11 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 3A45914039F;
	Tue, 14 Jan 2025 02:11:36 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 13 Jan
 2025 19:11:35 +0100
Date: Mon, 13 Jan 2025 18:11:34 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Robert Richter <rrichter@amd.com>
CC: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>
Subject: Re: [PATCH v1 09/29] cxl/region: Use iterator to find the root port
 in cxl_find_root_decoder()
Message-ID: <20250113181134.00000277@huawei.com>
In-Reply-To: <20250107141015.3367194-10-rrichter@amd.com>
References: <20250107141015.3367194-1-rrichter@amd.com>
	<20250107141015.3367194-10-rrichter@amd.com>
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

On Tue, 7 Jan 2025 15:09:55 +0100
Robert Richter <rrichter@amd.com> wrote:

> The function cxl_find_root_decoder() uses find_cxl_root() to find the
> root port. For the implementation of support of address translation an
> iterator is needed that traverses all ports from the endpoint to the
> root port.
> 
> Use the iterator in find_cxl_root() and unfold it into
> cxl_find_root_decoder().
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>

It is functionally the same. So I'll assume it makes sense later :)

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/region.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 5132c689b1f2..5750ed2796a8 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3206,13 +3206,18 @@ static struct cxl_root_decoder *
>  cxl_find_root_decoder(struct cxl_endpoint_decoder *cxled)
>  {
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> -	struct cxl_port *port = cxled_to_port(cxled);
> -	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
> +	struct cxl_port *iter = cxled_to_port(cxled);
>  	struct range *hpa = &cxled->cxld.hpa_range;
>  	struct cxl_decoder *cxld = &cxled->cxld;
>  	struct device *cxlrd_dev;
>  
> -	cxlrd_dev = device_find_child(&cxl_root->port.dev, hpa,
> +	while (iter && !is_cxl_root(iter))
> +		iter = to_cxl_port(iter->dev.parent);
> +
> +	if (!iter)
> +		return NULL;
> +
> +	cxlrd_dev = device_find_child(&iter->dev, hpa,
>  				      match_root_decoder_by_range);
>  	if (!cxlrd_dev) {
>  		dev_err(cxlmd->dev.parent,

