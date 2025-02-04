Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066C520C039
	for <linux-cxl@vger.kernel.org>; Tue,  4 Feb 2025 11:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738668609; cv=none; b=oiLRbClhIlfmNSu9yS/mFYjskGYujfj1A06U4fjRIlxtfjwgGZcakqxf7xNmo5SHmUze0eevI9TRDw4v1fxT88FllEleVmpdV3drPp24Fotm8rwib9SNHlLMnh1VUbU+4J6t/XEXz3p5FrvCSufR7Jss0bWcCwR7de8RMNjtUgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738668609; c=relaxed/simple;
	bh=9eQYshaNv6ig7T8+0GXYVeIKV/TYirBjgxYv3tcoIpw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ClBBSxkTNteRFEQqrSWrdIZGtpwGnWAhCfrQcTgXISG3SDYCiu0z8qYf6oOfX5c8fabfaF6BRKJTXNQahGjvh/7cgC9XGpCWnBbIc5s3RZ9B0fTxKTAVL4/4OX36hLCTO0AnDIy1lrFHqffKu1iImCy/JyHPaj9LrBmikH7dx/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YnLjg07Bqz6HJdl;
	Tue,  4 Feb 2025 19:29:11 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 6DB24140A71;
	Tue,  4 Feb 2025 19:30:03 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 4 Feb
 2025 12:30:03 +0100
Date: Tue, 4 Feb 2025 11:30:01 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, Alejandro Lucero <alucerop@amd.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH v3 2/6] cxl: Introduce to_{ram,pmem}_{res,perf}()
 helpers
Message-ID: <20250204113001.0000228c@huawei.com>
In-Reply-To: <173864305238.668823.16553986866633608541.stgit@dwillia2-xfh.jf.intel.com>
References: <173864304059.668823.3914867296781664103.stgit@dwillia2-xfh.jf.intel.com>
	<173864305238.668823.16553986866633608541.stgit@dwillia2-xfh.jf.intel.com>
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

On Mon, 03 Feb 2025 20:24:12 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> In preparation for consolidating all DPA partition information into an
> array of DPA metadata, introduce helpers that hide the layout of the
> current data. I.e. make the eventual replacement of ->ram_res,
> ->pmem_res, ->ram_perf, and ->pmem_perf with a new DPA metadata array a  
> no-op for code paths that consume that information, and reduce the noise
> of follow-on patches.
> 
> The end goal is to consolidate all DPA information in 'struct
> cxl_dev_state', but for now the helpers just make it appear that all DPA
> metadata is relative to @cxlds.
> 
> As the conversion to generic partition metadata walking is completed,
> these helpers will naturally be eliminated, or reduced in scope.
> 
> Cc: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

One observation inline. I don't care much either way.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/cdat.c      |   71 +++++++++++++++++++++++++++---------------
>  drivers/cxl/core/hdm.c       |   26 ++++++++-------
>  drivers/cxl/core/mbox.c      |   18 ++++++-----
>  drivers/cxl/core/memdev.c    |   42 +++++++++++++------------
>  drivers/cxl/core/region.c    |   10 ++++--
>  drivers/cxl/cxlmem.h         |   58 ++++++++++++++++++++++++++++++----
>  drivers/cxl/mem.c            |    2 +
>  tools/testing/cxl/test/cxl.c |   25 ++++++++-------
>  8 files changed, 162 insertions(+), 90 deletions(-)
> 
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index 8153f8d83a16..797baad483cb 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -258,27 +258,36 @@ static void update_perf_entry(struct device *dev, struct dsmas_entry *dent,
>  static void cxl_memdev_set_qos_class(struct cxl_dev_state *cxlds,
>  				     struct xarray *dsmas_xa)
>  {
> -	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
>  	struct device *dev = cxlds->dev;
> -	struct range pmem_range = {
> -		.start = cxlds->pmem_res.start,
> -		.end = cxlds->pmem_res.end,
> -	};
> -	struct range ram_range = {
> -		.start = cxlds->ram_res.start,
> -		.end = cxlds->ram_res.end,
> -	};
>  	struct dsmas_entry *dent;
>  	unsigned long index;
> +	const struct resource *partition[] = {
> +		to_ram_res(cxlds),
> +		to_pmem_res(cxlds),
> +	};
> +	struct cxl_dpa_perf *perf[] = {
> +		to_ram_perf(cxlds),
> +		to_pmem_perf(cxlds),
> +	};
>  
>  	xa_for_each(dsmas_xa, index, dent) {
> -		if (resource_size(&cxlds->ram_res) &&
> -		    range_contains(&ram_range, &dent->dpa_range))
> -			update_perf_entry(dev, dent, &mds->ram_perf);
> -		else if (resource_size(&cxlds->pmem_res) &&
> -			 range_contains(&pmem_range, &dent->dpa_range))
> -			update_perf_entry(dev, dent, &mds->pmem_perf);
> -		else
> +		bool found = false;

> +
> +		for (int i = 0; i < ARRAY_SIZE(partition); i++) {
> +			const struct resource *res = partition[i];
> +			struct range range = {
> +				.start = res->start,
> +				.end = res->end,
> +			};
> +
> +			if (range_contains(&range, &dent->dpa_range)) {
> +				update_perf_entry(dev, dent, perf[i]);
> +				found = true;
> +				break;
> +			}
> +		}
> +
> +		if (!found)

Could use check on whether we got to end of array check if you expand scope of i
outside loop.
		if (i == ARRAY_SIZE(partition))
			dev_dbg(dev, "no partition for dsmas dpa: %pra\n",
  				&dent->dpa_range);

I don't care much either way.
		
>  			dev_dbg(dev, "no partition for dsmas dpa: %pra\n",
>  				&dent->dpa_range);
>  	}

