Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4C921146E
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jan 2025 15:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737647861; cv=none; b=d50PyyYUf7usC5HKyjCdeNoZApMZCD9owhQFdTiZPxa8eD3VGJ92OY1IN9xRZbgeGw4A/t2ec8P1yv5vV463DYCUkKSHJ5lmWcpsrWHmtWGQi4GGFr2nW1bKPYmtwIvvT3JoZ7t92g0SrORDL9yRRC13p71nwU5ifazmx9Ii96M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737647861; c=relaxed/simple;
	bh=3Ur8UfNx1/MeuSqqmgpD1dZ9n3S5S+Bjb49yuQxdePM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LigItKc9XFGOPntWUBiXirRS8lj0f6rRo/vvnpxyfCmqsD7aZFVN9zUBqTuYHJWt4YP+VCNwJeZVOy16b45TFOvfkYZ96Whz+q5qwmfuBE+XoC5dr6OXgtEEEEwJh6Brn5EojC+BQjq+c2vfx66DwMvB/fbAM1qAXGl9jDcD2VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Yf5Bg5QQTz6L4tm;
	Thu, 23 Jan 2025 23:55:39 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 03FC7140136;
	Thu, 23 Jan 2025 23:57:36 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 23 Jan
 2025 16:57:35 +0100
Date: Thu, 23 Jan 2025 15:57:34 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>, "Alejandro
 Lucero" <alucerop@amd.com>, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH v2 2/5] cxl: Introduce to_{ram,pmem}_{res,perf}()
 helpers
Message-ID: <20250123155734.00002ff7@huawei.com>
In-Reply-To: <173753636159.3849855.512949598685608224.stgit@dwillia2-xfh.jf.intel.com>
References: <173753635014.3849855.17902348420186052714.stgit@dwillia2-xfh.jf.intel.com>
	<173753636159.3849855.512949598685608224.stgit@dwillia2-xfh.jf.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 22 Jan 2025 00:59:21 -0800
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
> Note that a follow-on patch also cleans up the temporary placeholders of
> @ram_res, and @pmem_res in the qos_class manipulation code,
> cxl_dpa_alloc(), and cxl_mem_create_range_info().
> 
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Alejandro Lucero <alucerop@amd.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/core/cdat.c      |   70 +++++++++++++++++++++++++-----------------
>  drivers/cxl/core/hdm.c       |   26 ++++++++--------
>  drivers/cxl/core/mbox.c      |   18 ++++++-----
>  drivers/cxl/core/memdev.c    |   42 +++++++++++++------------
>  drivers/cxl/core/region.c    |   10 ++++--
>  drivers/cxl/cxlmem.h         |   58 ++++++++++++++++++++++++++++++-----
>  drivers/cxl/mem.c            |    2 +
>  tools/testing/cxl/test/cxl.c |   25 ++++++++-------
>  8 files changed, 159 insertions(+), 92 deletions(-)
> 
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index 8153f8d83a16..b177a488e29b 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -258,29 +258,33 @@ static void update_perf_entry(struct device *dev, struct dsmas_entry *dent,
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
> -			dev_dbg(dev, "no partition for dsmas dpa: %pra\n",
> -				&dent->dpa_range);
> +		for (int i = 0; i < ARRAY_SIZE(partition); i++) {
> +			const struct resource *res = partition[i];
> +			struct range range = {
> +				.start = res->start,
> +				.end = res->end,
> +			};
> +
> +			if (range_contains(&range, &dent->dpa_range))
> +				update_perf_entry(dev, dent, perf[i]);
> +			else
> +				dev_dbg(dev,
> +					"no partition for dsmas dpa: %pra\n",
> +					&dent->dpa_range);

This else branch looks less than helpful if I read the code right.
It will fire at least once for every dsmas entry implying no partition when
in reality it is it probably matched on next partition.
Probably want to break out on match and check if i == ARRAY_SIZE(partition)
after the for loop and only then print the message.


> +		}
>  	}
>  }
>  
> @@ -304,6 +308,9 @@ static int match_cxlrd_qos_class(struct device *dev, void *data)




