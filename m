Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0DC3234;
	Fri, 14 Feb 2025 15:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739548286; cv=none; b=BL7IL42d2ItGECqooXtkn9nEiPXvecUbM42IA1YU+3cfKpw4d1yxbY7Zrmg6U1jnfHAuKTVfqqP82OGDK9U4ElbZHopbcpgDDQclyjg2UcomqgzCD3k4ljQs/tjlAnk964SxW6hPX5tsMbjmWGchDh6ptJgoB/nNSDY6GZSav2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739548286; c=relaxed/simple;
	bh=vjnuBrumtfsgor7A614WXlzdEEf3Hl7TFnCVC3KT2wE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PRJw0Mh/gq2y++5Ik3N1WheCKhgC/3jkX6j6n9gXyxOANbV7uqH0R0jlxb6KJ1SgKx4n8GfU9WoWCpOQOQScjbzefcVl9ca2t+COaDBLS8dDCt7dIZXmHwwSbXv8ZeL/p/nAEBtoXGbOeBB1tst4daCtmR/UGgFBubh3R82BnQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Yvc201Rc8z6HJgB;
	Fri, 14 Feb 2025 23:50:00 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id E0C4F1401F1;
	Fri, 14 Feb 2025 23:51:21 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 14 Feb
 2025 16:51:21 +0100
Date: Fri, 14 Feb 2025 15:51:20 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Robert Richter <rrichter@amd.com>
CC: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>
Subject: Re: [PATCH v3 04/18] cxl/pci: Add comments to cxl_hdm_decode_init()
Message-ID: <20250214155120.00004461@huawei.com>
In-Reply-To: <20250211095349.981096-5-rrichter@amd.com>
References: <20250211095349.981096-1-rrichter@amd.com>
	<20250211095349.981096-5-rrichter@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 11 Feb 2025 10:53:34 +0100
Robert Richter <rrichter@amd.com> wrote:

> There are various configuration cases of HDM decoder registers causing
> different code paths. Add comments to cxl_hdm_decode_init() to better
> explain them.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Tested-by: Gregory Price <gourry@gourry.net>
> ---
>  drivers/cxl/core/pci.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index c49efc419285..6333a01e4f19 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -416,9 +416,17 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
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
> +	 */
> +
>  	/*
>  	 * Per CXL 2.0 Section 8.1.3.8.3 and 8.1.3.8.4 DVSEC CXL Range 1 Base
>  	 * [High,Low] when HDM operation is enabled the range register values
> @@ -426,7 +434,8 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
>  	 * DVSEC Range 1,2 to HDM Decoder Range 0,1. So, non-zero info->ranges
>  	 * are expected even though Linux does not require or maintain that
>  	 * match. If at least one DVSEC range is enabled and allowed, skip HDM
> -	 * Decoder Capability Enable.
> +	 * Decoder Capability Enable. Else, use the HDM Decoder Capability and
> +	 * enable it.

As per previous.  Having an 'else' comment that refers to what happens if the
following if is true, just adds to confusion :(

So if you are going to move the comment it needs a more substantial rewrite
to reflect that we care 'here' about that last bit only.

>  	 */
>  	if (!info->mem_enabled) {
>  		rc = devm_cxl_enable_hdm(&port->dev, cxlhdm);

