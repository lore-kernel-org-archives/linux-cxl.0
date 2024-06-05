Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68781B1436
	for <linux-cxl@vger.kernel.org>; Wed,  5 Jun 2024 12:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717589741; cv=none; b=Jz+W9figqb3pymvn8y9lMlLCU6u48qY0Xo363UuJB0oB0U24+OBoJv2YM7sER/dL1p2vZmlQev1gbiH/VfJFKBRRY6AvrL5+bxLefZ18CB9AYSgBLNBn1qlGE/WX/GH8HGaqsk/tq8JQnT0IjRhgEZ9OGNuIBAeoP9dscV1Tkkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717589741; c=relaxed/simple;
	bh=iW/LAUzKA9DEuKW9E7y0qJF5KYwyIiaGdL7Y+R9q2YE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SjsCg0nffHaa+4zX64LqTrzMAz71/N/Nm9iigE55eZVTZAJkJaVI+s4WPq1Zr0kKLQc+Z8ATvSHvrtjAyX3cm/HLIjNKGBZC3t48gFT30XFyukoOeLETqc2g6Mz0AzgYL6S4W0gaTo/YnDTI5hEgfrTNMpxpAqhEGGxh+RwEsPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VvRBW4hlqz6K66K;
	Wed,  5 Jun 2024 20:10:59 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 9C42D140A87;
	Wed,  5 Jun 2024 20:15:35 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 5 Jun
 2024 13:15:35 +0100
Date: Wed, 5 Jun 2024 13:15:34 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Foryun Ma <foryun.ma@jaguarmicro.com>
CC: <alison.schofield@intel.com>, <dan.j.williams@intel.com>,
	<angus.chen@jaguarmicro.com>, <dave.jiang@intel.com>, <dave@stgolabs.net>,
	<linux-cxl@vger.kernel.org>, <rrichter@amd.com>
Subject: Re: [PATCH v3] cxl/core/pci: Move reading of control register to
 immediately before usage
Message-ID: <20240605131534.0000182d@Huawei.com>
In-Reply-To: <20240604032151.655-1-foryun.ma@jaguarmicro.com>
References: <20240604032151.655-1-foryun.ma@jaguarmicro.com>
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
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue,  4 Jun 2024 11:21:51 +0800
Foryun Ma <foryun.ma@jaguarmicro.com> wrote:

> Relocate the reading of the DVSEC control register to immediately
> before usage and avoid unnecessary PCI config access from the read
> if DVSEC capability check, hdm_count check, or device validity check
> results in failure.
I would focus more on the code readability / clarity improvement
Alison highlighted.
Something like:

"Move the read of the DVSEC control register to immediately before is
used to slightly improve readability. Also avoids reading this register
if an error condition is hit before it is needed."

With that as the focus I'm fine with this one as a small improvement.
Dave is handling the tree though, so ultimately his decision on this
one like any other patch.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> 
> Signed-off-by: Foryun Ma <foryun.ma@jaguarmicro.com>
> 
> ---
> V2->V3: move the check to after the comment
> V1->V2: change the subject and commit log, suggested by dave.jiang
> 	and add change log, suggested by Alison Schofield
> ---
>  drivers/cxl/core/pci.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 8567dd11eaac..a663e7566c48 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -338,10 +338,6 @@ int cxl_dvsec_rr_decode(struct device *dev, int d,
>  	if (rc)
>  		return rc;
>  
> -	rc = pci_read_config_word(pdev, d + CXL_DVSEC_CTRL_OFFSET, &ctrl);
> -	if (rc)
> -		return rc;
> -
>  	if (!(cap & CXL_DVSEC_MEM_CAPABLE)) {
>  		dev_dbg(dev, "Not MEM Capable\n");
>  		return -ENXIO;
> @@ -368,6 +364,10 @@ int cxl_dvsec_rr_decode(struct device *dev, int d,
>  	 * disabled, and they will remain moot after the HDM Decoder
>  	 * capability is enabled.
>  	 */
> +	rc = pci_read_config_word(pdev, d + CXL_DVSEC_CTRL_OFFSET, &ctrl);
> +	if (rc)
> +		return rc;
> +
>  	info->mem_enabled = FIELD_GET(CXL_DVSEC_MEM_ENABLE, ctrl);
>  	if (!info->mem_enabled)
>  		return 0;

