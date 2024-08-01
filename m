Received: from sgoci-sdnproxy-4.icoremail.net (sgoci-sdnproxy-4.icoremail.net [129.150.39.64])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98812157A5C
	for <linux-cxl@vger.kernel.org>; Thu,  1 Aug 2024 07:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.150.39.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722498866; cv=none; b=ZrMpSGZCkcIDxr1XrgttozSfZCd/iiMsipD6cfmMiphvMqqOWsmbpr989n5BkZbMBokEMZsX/c3ylxBPCRvCPvERAKQt52gVYXZXJKVQJFVCZ1Mu7hSf1wq30eWHcfb1P5x6y7WFTT8IR/xDRGne8CZNBY42LGBusdiYbtPi5iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722498866; c=relaxed/simple;
	bh=lqBI4vGzyFw4CUI63RZkIpQLMccnM9LZbychYudxL3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uu7aav8XemGplQPjMXBaYl7wN9c35IHD74WguODE20OqRzEjecCUtPYt0bmmxabNV4x3Ky25FJhinJzELpFqc5ln2Q8rBljFA7wa2GrvHI86RPhgD7u1gebL3tTzRKLjzWi4vUTk9T+bIk/B7UiNtMBbTeX5Tx0AexWGBkvQy3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=129.150.39.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwCX9_AnP6tmLIMRBA--.10393S2;
	Thu, 01 Aug 2024 15:54:15 +0800 (CST)
Received: from localhost (unknown [123.150.8.50])
	by mail (Coremail) with SMTP id AQAAfwBHc7MlP6tmQS8KAA--.12829S2;
	Thu, 01 Aug 2024 15:54:13 +0800 (CST)
Date: Thu, 1 Aug 2024 15:54:13 +0800
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: dan.j.williams@intel.com, linux-cxl@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, chenbaozi@phytium.com.cn
Subject: Re: [RFC PATCH 5/8] arch_numa: Make numa_add_memblk() set nid for
 memblock.reserved regions
Message-ID: <Zqs/JZLDyVOtO0n1@phytium.com.cn>
References: <20240529171236.32002-1-Jonathan.Cameron@huawei.com>
 <20240529171236.32002-6-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529171236.32002-6-Jonathan.Cameron@huawei.com>
X-CM-TRANSID:AQAAfwBHc7MlP6tmQS8KAA--.12829S2
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAEAWaqm98E1AAJsV
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvdXoWrtF1kCw4UKw4UuFyrXF13Jwb_yoWkGrg_Ga
	10g3s3WFn8GF4v9F47Ar9xZrWFka1DWF1aqF93ta13uw45JF1kKrWq9rn8ArWDGr48JrZx
	Ar9xZrySyrnxZjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrnU
	Uv73VFW2AGmfu7jjvjm3AaLaJ3UjIYCTnIWjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRUUUUU
	UUUU=

On Wed, May 29, 2024 at 06:12:33PM +0100, Jonathan Cameron wrote:
> Setting the reserved region entries to the appropriate Node ID means
> that they can be used to establish the node to which we should add
> hotplugged CXL memory within a CXL fixed memory window.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/base/arch_numa.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/base/arch_numa.c b/drivers/base/arch_numa.c
> index 0630efb696ab..568dbabeb636 100644
> --- a/drivers/base/arch_numa.c
> +++ b/drivers/base/arch_numa.c
> @@ -208,6 +208,13 @@ int __init numa_add_memblk(int nid, u64 start, u64 end)
>  			start, (end - 1), nid);
>  		return ret;
>  	}
> +	/* Also set reserved nodes nid */
> +	ret = memblock_set_node(start, (end - start), &memblock.reserved, nid);
> +	if (ret < 0) {
> +		pr_err("memblock [0x%llx - 0x%llx] failed to add on node %d\n",
> +			start, (end - 1), nid);
> +		return ret;
> +	}
>  
>  	node_set(nid, numa_nodes_parsed);
>  	return ret;
> -- 
> 2.39.2
>

Tested-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>

