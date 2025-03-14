Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEC41F3FEC;
	Fri, 14 Mar 2025 11:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741951654; cv=none; b=tzGZESEPkLvMqrbA8WpEbyCs5nH7i50AfPpiGURPywq2tsdfXxCKnz1zYhnsRJKswvgVRorrv/CNI7TKoFtxVs4OaDrv4wDGwbloJe9H+UXbSepnUurPgKkN8PKLpKTdJycJyKi0wfxCOO7nvFMlqKXDpMrzyqCoiRmudbw8Aso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741951654; c=relaxed/simple;
	bh=QVHuSQlXBCGbAZQ9QohjLP02TO8pE9iXLkvWb0CCV2s=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lrZCSrJBbeWhn+Y17ewDwAaf+9LwnBGuYBvBotHXv1sjmwb7sbEeCoHK3XjpRrkTZNQ0YZ+52g5nOV0P0OOhfoN1UCobRqKuQh6TbQIMBtV1VtoiGY4y373OmDQ2qrYgdh6kvLFv0Ox/TMvc7ZsuQnwawXU7veAv81ZbIfIOj5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZDhmt2BHbz6K6VH;
	Fri, 14 Mar 2025 19:22:54 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 14195140B39;
	Fri, 14 Mar 2025 19:27:29 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 14 Mar
 2025 12:27:28 +0100
Date: Fri, 14 Mar 2025 11:27:27 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Robert Richter <rrichter@amd.com>
CC: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>
Subject: Re: [PATCH v4 01/14] cxl: Remove else after return
Message-ID: <20250314112727.00003a2e@huawei.com>
In-Reply-To: <20250306164448.3354845-2-rrichter@amd.com>
References: <20250306164448.3354845-1-rrichter@amd.com>
	<20250306164448.3354845-2-rrichter@amd.com>
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

On Thu, 6 Mar 2025 17:44:35 +0100
Robert Richter <rrichter@amd.com> wrote:

> Remove unnecessary 'else' after return. Improves readability of code.
> It is easier to place comments. Check and fix all occurrences under
> drivers/cxl/.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Tested-by: Gregory Price <gourry@gourry.net>

Dave, if you see this in time, can we sneak this one in for the
merge window? It's the sort of cleanup that just distracts (a little)
from more substantial rest of this series and is good in it's
own right.

> ---
>  drivers/cxl/core/cdat.c   | 2 +-
>  drivers/cxl/core/pci.c    | 3 ++-
>  drivers/cxl/core/region.c | 4 +++-
>  3 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index edb4f41eeacc..0ccef2f2a26a 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -28,7 +28,7 @@ static u32 cdat_normalize(u16 entry, u64 base, u8 type)
>  	 */
>  	if (entry == 0xffff || !entry)
>  		return 0;
> -	else if (base > (UINT_MAX / (entry)))
> +	if (base > (UINT_MAX / (entry)))
>  		return 0;
>  
>  	/*
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 96fecb799cbc..33c3bdd35b24 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -415,7 +415,8 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
>  	 */
>  	if (global_ctrl & CXL_HDM_DECODER_ENABLE || (!hdm && info->mem_enabled))
>  		return devm_cxl_enable_mem(&port->dev, cxlds);
> -	else if (!hdm)
> +
> +	if (!hdm)
>  		return -ENODEV;
>  
>  	root = to_cxl_port(port->dev.parent);
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 8537b6a9ca18..cbe762abf6b3 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1940,7 +1940,9 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  	if (p->state > CXL_CONFIG_INTERLEAVE_ACTIVE) {
>  		dev_dbg(&cxlr->dev, "region already active\n");
>  		return -EBUSY;
> -	} else if (p->state < CXL_CONFIG_INTERLEAVE_ACTIVE) {
> +	}
> +
> +	if (p->state < CXL_CONFIG_INTERLEAVE_ACTIVE) {
>  		dev_dbg(&cxlr->dev, "interleave config missing\n");
>  		return -ENXIO;
>  	}

