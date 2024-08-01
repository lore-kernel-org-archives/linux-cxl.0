Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net (zg8tmja5ljk3lje4ms43mwaa.icoremail.net [209.97.181.73])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC1C19478
	for <linux-cxl@vger.kernel.org>; Thu,  1 Aug 2024 07:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.181.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722498842; cv=none; b=cjIkEyllKhw49re7b9tZoJQkDU1GqTTmHE3O3oztBTVJgv9khWvgpv1tBdKjTUjOrrIV//qHKvvPSbLetvNVH3cSHi8a0BjcBa96sf5wx1xrYgxlbIkF038uYXRyPsC8MZmeJ2VRdoMiAnh83ZuR/EOZbF8tNAHk5mn5f6pkkwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722498842; c=relaxed/simple;
	bh=AsIPOxCPXFJcU5RP09Qaapmgurq/zc09KVJZGk4cM9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aMmQF+hEu1eQZagLwCcWBYFWCWHMQXgnlSUN/tmY5VYxtWdgtSmXn0D78MW5Lj3igRIIR3bH55XvR17s7sBZQ872QAcFlZZluiRDXL3eDaZqEWWmox00tO6VKsE0SHrKaYTMdZJ7dz7BOmrA7D4eYI7GagXPo9KCD1TInRWFteY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=209.97.181.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwA3mPEKP6tmlX4RBA--.10418S2;
	Thu, 01 Aug 2024 15:53:46 +0800 (CST)
Received: from localhost (unknown [123.150.8.50])
	by mail (Coremail) with SMTP id AQAAfwAnVbUIP6tmOC8KAA--.15303S2;
	Thu, 01 Aug 2024 15:53:44 +0800 (CST)
Date: Thu, 1 Aug 2024 15:53:43 +0800
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: dan.j.williams@intel.com, linux-cxl@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, chenbaozi@phytium.com.cn
Subject: Re: [RFC PATCH 4/8] arch_numa: Avoid onlining empty NUMA nodes
Message-ID: <Zqs/BxETto/y2pZW@phytium.com.cn>
References: <20240529171236.32002-1-Jonathan.Cameron@huawei.com>
 <20240529171236.32002-5-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529171236.32002-5-Jonathan.Cameron@huawei.com>
X-CM-TRANSID:AQAAfwAnVbUIP6tmOC8KAA--.15303S2
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAEAWaqm98E1AAHsb
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvdXoW7XFW8CF1UGrWDKF1xCw17ZFb_yoWkKrbE9F
	W8Xa4fWr1qgasavFsrt3Z8ZrWSyr1UWF1YgF97tay7A343t3ZYgFWq9F98Jr95Xr48CrZF
	yrs8Zw1Syr47ZjkaLaAFLSUrUUUU1b8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrnU
	Uv73VFW2AGmfu7jjvjm3AaLaJ3UjIYCTnIWjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRUUUUU
	UUUU=

On Wed, May 29, 2024 at 06:12:32PM +0100, Jonathan Cameron wrote:
> ACPI can declare NUMA nodes for memory that will be along later.
> CXL Fixed Memory Windows may also be assigned NUMA nodes that
> are initially empty.  Currently the generic arch_numa handling will
> online these empty nodes. This is both inconsistent with x86 and
> with itself as if we add memory and remove it again the node goes
> away.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/base/arch_numa.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/base/arch_numa.c b/drivers/base/arch_numa.c
> index 5b59d133b6af..0630efb696ab 100644
> --- a/drivers/base/arch_numa.c
> +++ b/drivers/base/arch_numa.c
> @@ -363,6 +363,11 @@ static int __init numa_register_nodes(void)
>  		unsigned long start_pfn, end_pfn;
>  
>  		get_pfn_range_for_nid(nid, &start_pfn, &end_pfn);
> +		if (start_pfn >= end_pfn &&
> +		    !node_state(nid, N_CPU) &&
> +		    !node_state(nid, N_GENERIC_INITIATOR))
> +			continue;
> +
>  		setup_node_data(nid, start_pfn, end_pfn);
>  		node_set_online(nid);
>  	}
> -- 
> 2.39.2
>

Tested-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>

