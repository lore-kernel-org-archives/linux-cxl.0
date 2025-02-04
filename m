Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F317F185E4A
	for <linux-cxl@vger.kernel.org>; Tue,  4 Feb 2025 12:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738671824; cv=none; b=VRmJkVAmjusUJthkuW7aN6PVBN8O/kVZ1wO/TZmLDmGekPVF0S7DdpvGzygOyBswf73hr4ciYjlJBzWTGIydOdLv5ZRcspnbf+g+Wau07Wy0TU+NAZMtomXU5tsp3RrCUgoHuqMwlpy4GjmGKMrw2pL4dgMQXDRlVZw/qqw6aCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738671824; c=relaxed/simple;
	bh=9ZA0e4MdZf3F3Iv+2kst0wnI/MBO0PqL3r0Bocfh87k=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J53DjIkh404xDBDQFRIGLzl7hv9cSkM69AUvTo8Bga+x+2IGEDuDKs3bD6uzuhujPU3OvuK77H4G5kMPr6FWvGkx4AybbtyzvFqEA90rhZK1oJov2uQl1czxy0fmuoLusJVuJDiwVuWluve7tQsXOOmAo+IHMfqCKEfVrsx9GCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YnMsX5gLJz67npl;
	Tue,  4 Feb 2025 20:21:04 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id DC0FD140B3C;
	Tue,  4 Feb 2025 20:23:39 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 4 Feb
 2025 13:23:39 +0100
Date: Tue, 4 Feb 2025 12:23:38 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>, "Alejandro
 Lucero" <alucerop@amd.com>, Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH v3 5/6] cxl: Kill enum cxl_decoder_mode
Message-ID: <20250204122338.0000284b@huawei.com>
In-Reply-To: <173864306972.668823.3327008645125276726.stgit@dwillia2-xfh.jf.intel.com>
References: <173864304059.668823.3914867296781664103.stgit@dwillia2-xfh.jf.intel.com>
	<173864306972.668823.3327008645125276726.stgit@dwillia2-xfh.jf.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 03 Feb 2025 20:24:29 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> Now that the operational mode of DPA capacity (ram vs pmem... etc) is
> tracked in the partition, and no code paths have dependencies on the
> mode implying the partition index, the ambiguous 'enum cxl_decoder_mode'
> can be cleaned up, specifically this ambiguity on whether the operation
> mode implied anything about the partition order.
> 
> Endpoint decoders simply reference their assigned partition where the
> operational mode can be retrieved as partition mode.
> 
> With this in place PMEM can now be partition0 which happens today when
> the RAM capacity size is zero. Dynamic RAM can appear above PMEM when
> DCD arrives, etc. Code sequences that hard coded the "PMEM after RAM"
> assumption can now just iterate partitions and consult the partition
> mode after the fact.
> 
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

One trivial equality check inline to tidy up otherwise nice.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/cdat.c   |   18 ++----
>  drivers/cxl/core/core.h   |    4 +
>  drivers/cxl/core/hdm.c    |   68 ++++++++++--------------
>  drivers/cxl/core/memdev.c |   15 +----
>  drivers/cxl/core/port.c   |   21 ++++++-
>  drivers/cxl/core/region.c |  127 +++++++++++++++++++++++++--------------------
>  drivers/cxl/cxl.h         |   37 +++----------
>  drivers/cxl/cxlmem.h      |   19 -------
>  8 files changed, 134 insertions(+), 175 deletions(-)


> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 78ecb88bad7e..d705dec1471e 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -359,7 +359,6 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,

> -int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
> -		     enum cxl_decoder_mode mode)
> +int cxl_dpa_set_part(struct cxl_endpoint_decoder *cxled,
> +		     enum cxl_partition_mode mode)
>  {
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  	struct device *dev = &cxled->cxld.dev;
> -
> -	switch (mode) {
> -	case CXL_DECODER_RAM:
> -	case CXL_DECODER_PMEM:
> -		break;
> -	default:
> -		dev_dbg(dev, "unsupported mode: %d\n", mode);
> -		return -EINVAL;
> -	}
> +	int part;
>  
>  	guard(rwsem_write)(&cxl_dpa_rwsem);
>  	if (cxled->cxld.flags & CXL_DECODER_F_ENABLE)
>  		return -EBUSY;
>  
> -	/*
> -	 * Only allow modes that are supported by the current partition
> -	 * configuration
> -	 */
> -	if (mode == CXL_DECODER_PMEM && !cxl_pmem_size(cxlds)) {
> -		dev_dbg(dev, "no available pmem capacity\n");
> -		return -ENXIO;
> +	for (part = 0; part < cxlds->nr_partitions; part++)
> +		if (cxlds->part[part].mode == mode)
> +			break;
> +
> +	if (part >= cxlds->nr_partitions) {

How would it be greater?

> +		dev_dbg(dev, "unsupported mode: %d\n", mode);
> +		return -EINVAL;
>  	}
> -	if (mode == CXL_DECODER_RAM && !cxl_ram_size(cxlds)) {
> -		dev_dbg(dev, "no available ram capacity\n");
> +
> +	if (!resource_size(&cxlds->part[part].res)) {
> +		dev_dbg(dev, "no available capacity for mode: %d\n", mode);
>  		return -ENXIO;
>  	}
>  
> -	cxled->mode = mode;
> +	cxled->part = part;
>  	return 0;
>  }
>
