Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D141F4288;
	Fri, 14 Mar 2025 11:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741952024; cv=none; b=Au+DJWS8k3klXw/zHF9/GRGD+6O63Yt6Yg7XI6tiSDGm0jEYoy8u+VoFGuPBIyov+1RkKTI1i/3k8dcSIf+oU+rZJj8Fh6sUgTDaPfeS3ZtoVD5J0qMuA2Zva6ZloBzjD+v+3Z9hGWK04bp9P4cFM6OgGbuYsL51lMVL7nQd/HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741952024; c=relaxed/simple;
	bh=RU3ThuN1mzSrYHjqhvC6ZqRqeSvabqgWdZ+o9sV446I=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qIqD3y7Ts4gm3pw9QbYTOcxE6Gt3XM0+gJCjzzyzZRn0yAFG0wgYNU8QPnDiWPMWTlEPmkmQbUkGhh+x0iocDsGoTEYhLDk8mxh+KmOKYKJmwrPg1zc4dsdkMCC1AcZNqKRbOMAgh+tc3wQ3rTttVwgmVyuWvG41OLBpO/TUe2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZDhw05BRmz6K5sw;
	Fri, 14 Mar 2025 19:29:04 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 7DB7B1400CA;
	Fri, 14 Mar 2025 19:33:39 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 14 Mar
 2025 12:33:38 +0100
Date: Fri, 14 Mar 2025 11:33:37 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Robert Richter <rrichter@amd.com>
CC: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>
Subject: Re: [PATCH v4 03/14] cxl/pci: Add comments to cxl_hdm_decode_init()
Message-ID: <20250314113337.000054b6@huawei.com>
In-Reply-To: <20250306164448.3354845-4-rrichter@amd.com>
References: <20250306164448.3354845-1-rrichter@amd.com>
	<20250306164448.3354845-4-rrichter@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 6 Mar 2025 17:44:37 +0100
Robert Richter <rrichter@amd.com> wrote:

> There are various configuration cases of HDM decoder registers causing
> different code paths. Add comments to cxl_hdm_decode_init() to better
> explain them.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Tested-by: Gregory Price <gourry@gourry.net>
Trivial comment inline.
Otherwise I think this is fine.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/pci.c | 33 ++++++++++++++++++++++++---------
>  1 file changed, 24 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 6386e84e51a4..ef4b08abe424 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -416,9 +416,21 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
>  	if (global_ctrl & CXL_HDM_DECODER_ENABLE || (!hdm && info->mem_enabled))
>  		return devm_cxl_enable_mem(&port->dev, cxlds);
>  
> +	/*
> +	 * If the HDM Decoder Capability does not exist and DVSEC was
> +	 * not setup, the DVSEC based emulation cannot be used.
> +	 */
>  	if (!hdm)
>  		return -ENODEV;
>  
> +	/*
> +	 * The HDM Decoder Capability exists but is globally disabled.

Single line comment syntax appropriate here.

> +	 */
> +
> +	/*
> +	 * If the DVSEC CXL Range registers are not enabled, just
> +	 * enable and use the HDM Decoder Capability registers.
> +	 */
>  	if (!info->mem_enabled) {
>  		rc = devm_cxl_enable_hdm(&port->dev, cxlhdm);
>  		if (rc)
> @@ -427,6 +439,18 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
>  		return devm_cxl_enable_mem(&port->dev, cxlds);
>  	}
>  
> +	/*
> +	 * Per CXL 2.0 Section 8.1.3.8.3 and 8.1.3.8.4 DVSEC CXL Range 1 Base
> +	 * [High,Low] when HDM operation is enabled the range register values
> +	 * are ignored by the device, but the spec also recommends matching the
> +	 * DVSEC Range 1,2 to HDM Decoder Range 0,1. So, non-zero info->ranges
> +	 * are expected even though Linux does not require or maintain that
> +	 * match. Check if at least one DVSEC range is enabled and allowed by
> +	 * the platform. That is, the DVSEC range must be covered by a locked
> +	 * platform window (CFMWS). Fail otherwise as the endpoint's decoders
> +	 * cannot be used.
> +	 */
> +
>  	root = to_cxl_port(port->dev.parent);
>  	while (!is_cxl_root(root) && is_cxl_port(root->dev.parent))
>  		root = to_cxl_port(root->dev.parent);
> @@ -454,15 +478,6 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
>  		return -ENXIO;
>  	}
>  
> -	/*
> -	 * Per CXL 2.0 Section 8.1.3.8.3 and 8.1.3.8.4 DVSEC CXL Range 1 Base
> -	 * [High,Low] when HDM operation is enabled the range register values
> -	 * are ignored by the device, but the spec also recommends matching the
> -	 * DVSEC Range 1,2 to HDM Decoder Range 0,1. So, non-zero info->ranges
> -	 * are expected even though Linux does not require or maintain that
> -	 * match. If at least one DVSEC range is enabled and allowed, skip HDM
> -	 * Decoder Capability Enable.
> -	 */
>  	return 0;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_hdm_decode_init, "CXL");

