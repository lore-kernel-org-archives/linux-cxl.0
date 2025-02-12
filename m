Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A06209663;
	Wed, 12 Feb 2025 18:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739383758; cv=none; b=FphAR4IulH4eZORyaJyVXk+gKG6pCNqZH4bUpzPuSbRCC2WfeoR8zRXSNbiTL4/FMmow2ZUrQcV6hC90h5LgeVqg0lWWJ7YNdppYIAVP6YkrMfNiYMBWWtge2cntgqjPX/YivhMOviWRo01E1dWogCoACito8XPtQ2zzdPl/sto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739383758; c=relaxed/simple;
	bh=TnLc9oxkAdA2FboTiWdFK5GZGeDnHLEhWMHibySxBo0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QyjYOd6sguThJ9KLIZj1jMCN3YjZiwrnnfQLTdsnKK7KhqJCHOpAe9pA8n+ULM57tePCg7BTczlCqn8S9me6DGMulFQ9Ty2pvjbsjJi0jwDOdeRe29sxKZuK9p02rZiI8mMbBb65VZHu/640m+BbFvuV+KSvV3f9UCZR8ekEI+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YtR840gqVz6L55G;
	Thu, 13 Feb 2025 02:06:12 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id DE559140A90;
	Thu, 13 Feb 2025 02:09:12 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 12 Feb
 2025 19:09:12 +0100
Date: Wed, 12 Feb 2025 18:09:10 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Robert Richter <rrichter@amd.com>
CC: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>
Subject: Re: [PATCH v3 03/18] cxl/pci: cxl_hdm_decode_init: Move comment
Message-ID: <20250212180910.00005839@huawei.com>
In-Reply-To: <20250211095349.981096-4-rrichter@amd.com>
References: <20250211095349.981096-1-rrichter@amd.com>
	<20250211095349.981096-4-rrichter@amd.com>
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
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 11 Feb 2025 10:53:33 +0100
Robert Richter <rrichter@amd.com> wrote:

> The comment applies to the check, move it there.

I think I disagree. It was in the right place as far as I can tell.
It is an odd place for comment, but it's kind of describing
why it is not an error to get down there.

> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Tested-by: Gregory Price <gourry@gourry.net>
> ---
>  drivers/cxl/core/pci.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index f8e22bc278c3..c49efc419285 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -419,6 +419,15 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
>  	if (!hdm)
>  		return -ENODEV;
>  
> +	/*
> +	 * Per CXL 2.0 Section 8.1.3.8.3 and 8.1.3.8.4 DVSEC CXL Range 1 Base
> +	 * [High,Low] when HDM operation is enabled the range register values
> +	 * are ignored by the device, but the spec also recommends matching the
> +	 * DVSEC Range 1,2 to HDM Decoder Range 0,1. So, non-zero info->ranges
> +	 * are expected even though Linux does not require or maintain that
> +	 * match. If at least one DVSEC range is enabled and allowed, skip HDM
> +	 * Decoder Capability Enable.

This check is about mem_enabled. Would be fine to add another comment here to
say.

	/*
	 * If mem_enabled is not set prior configuration is irrelevant and we
	 * can do what we like so enable HDM decoders and ignore DVSEC registers.
	 */
> +	 */
>  	if (!info->mem_enabled) {
>  		rc = devm_cxl_enable_hdm(&port->dev, cxlhdm);
>  		if (rc)
> @@ -454,15 +463,6 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
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

This is the path the comment is talking about because only if we get to this
return path are we 'skipping' the HDM decoder capability and not returning
an error.  The path representing an HDM decoder equipped device that
was configured by a BIOS that decided to use the DVSEC registers.

I'm not sure why we care about how the hdm decoders are programmed inthis
case though.

I'm confused :(

>  	return 0;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_hdm_decode_init, "CXL");

