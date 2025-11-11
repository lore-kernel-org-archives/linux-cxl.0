Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF23E274B3A;
	Tue, 11 Nov 2025 15:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762875344; cv=none; b=V6Pj4unBj/+6JVETw6QZkgkCZ4xfALCB46+iXguID+haBLF9TcMagyVj0GDp1EB6QNJJunnKx45jJtQoAIHxeoQleWw4LjzYltifXS2amjpKYo+iV82tOtgdN+X+r8sfk7WdI2Ex61Qs9GNrAP3O5X9a6lg3RSIocB+BAFYSkZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762875344; c=relaxed/simple;
	bh=DCLHu/85ts3oap8+QvYW9Hqgbo8t2i729DLyK+XRIYc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lYm3aDoHxOVEf8AIwIu9fE2sPQDari+ZlsPl/yBVVHsG5yZzBA8d/Z+97PO06phvb6GQ1qU84yQ6kbmaXb3A8uircPnpRKbqR9L3jAJPYFOYF6/30jfbv3Hw6Kifg42DveHKpIhMVwfpWtyqeGr4xsP/9s+atkSzuWnJOOxc57U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d5Vw86MVGzJ469b;
	Tue, 11 Nov 2025 23:35:04 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id ED701140371;
	Tue, 11 Nov 2025 23:35:35 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 11 Nov
 2025 15:35:35 +0000
Date: Tue, 11 Nov 2025 15:35:34 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Robert Richter <rrichter@amd.com>
CC: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v4 13/14] cxl/acpi: Group xor arithmetric setup code in
 a single block
Message-ID: <20251111153534.000020fa@huawei.com>
In-Reply-To: <20251103184804.509762-14-rrichter@amd.com>
References: <20251103184804.509762-1-rrichter@amd.com>
	<20251103184804.509762-14-rrichter@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Mon, 3 Nov 2025 19:47:54 +0100
Robert Richter <rrichter@amd.com> wrote:

> Simplify the xor arithmetric setup code by grouping it in a single
> block. No need to split the block for QoS setup.
> 
> It is save to reorder the call of cxl_setup_extended_linear_cache()

safe rather than save

> because there are no dependencies.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
Seems fine to me.
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
>  drivers/cxl/acpi.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 778ee29430ea..40894e2156ce 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -449,8 +449,6 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
>  		ig = CXL_DECODER_MIN_GRANULARITY;
>  	cxld->interleave_granularity = ig;
>  
> -	cxl_setup_extended_linear_cache(cxlrd);
> -
>  	if (cfmws->interleave_arithmetic == ACPI_CEDT_CFMWS_ARITHMETIC_XOR) {
>  		if (ways != 1 && ways != 3) {
>  			cxims_ctx = (struct cxl_cxims_context) {
> @@ -466,15 +464,14 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
>  				return -EINVAL;
>  			}
>  		}
> -	}
> -
> -	cxlrd->qos_class = cfmws->qtg_id;
> -
> -	if (cfmws->interleave_arithmetic == ACPI_CEDT_CFMWS_ARITHMETIC_XOR) {
>  		cxlrd->ops.hpa_to_spa = cxl_apply_xor_maps;
>  		cxlrd->ops.spa_to_hpa = cxl_apply_xor_maps;
>  	}
>  
> +	cxl_setup_extended_linear_cache(cxlrd);
> +
> +	cxlrd->qos_class = cfmws->qtg_id;
> +
>  	rc = cxl_decoder_add(cxld);
>  	if (rc)
>  		return rc;

