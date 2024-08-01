Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1B719478
	for <linux-cxl@vger.kernel.org>; Thu,  1 Aug 2024 07:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722498931; cv=none; b=q6ZSWy6PEHHXvImxveMdp0lu1L+BZj12jq5hZktTciMdZ+Cgpyg9Z9UCn8kGhGItyHKFuZeX+/d+CBGTFdBrvnbowkfyAmi/ndLKrLpGgPejmsqBpnmtyZlmGM65osu4JXyGD5QcxgBpHyOgmtf1WjMXq/hrSNHtLyGC7pdESm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722498931; c=relaxed/simple;
	bh=HaUS0CwFwiukpCEY/j80/P8QoCh3MDluSXEdtb1Wsyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SsPljGaLJeRU0UsU+tEsSk7djhDQGFtkeYbOlZF1RZnpqjjCUS2yqiXghTNl+45Bw+B7nySlZ6OMYPnVZ+GUVErh1iZOFgK5r9+yAavfnnJng/aJCtYbiaJhSSWelKbUFyI436R1Md2LMZkJOm/LIc6LHbHFFTZaNUkjndyTUwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwBHT8tlP6tmqI0RBA--.26178S2;
	Thu, 01 Aug 2024 15:55:17 +0800 (CST)
Received: from localhost (unknown [123.150.8.50])
	by mail (Coremail) with SMTP id AQAAfwAHNLRjP6tmTC8KAA--.15296S2;
	Thu, 01 Aug 2024 15:55:16 +0800 (CST)
Date: Thu, 1 Aug 2024 15:55:15 +0800
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: dan.j.williams@intel.com, linux-cxl@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, chenbaozi@phytium.com.cn
Subject: Re: [RFC PATCH 7/8] acpi: srat: cxl: Skip zero length CXL fixed
 memory windows.
Message-ID: <Zqs/Y70KfV+B0h7L@phytium.com.cn>
References: <20240529171236.32002-1-Jonathan.Cameron@huawei.com>
 <20240529171236.32002-8-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529171236.32002-8-Jonathan.Cameron@huawei.com>
X-CM-TRANSID:AQAAfwAHNLRjP6tmTC8KAA--.15296S2
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAEAWaqm98E1AANsR
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvdXoW7Xr1xJF43Ww4fGFWfur4xXrb_yoWkGwcE9F
	s7Xrn7JF12gF1IvFsrGFy3XryrKrnFgF95X3ZYqFyxAas7Xw18CFWDur93Awn8CF48trsx
	GwsxAryrAw43XjkaLaAFLSUrUUUU1b8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrnU
	Uv73VFW2AGmfu7jjvjm3AaLaJ3UjIYCTnIWjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRUUUUU
	UUUU=

On Wed, May 29, 2024 at 06:12:35PM +0100, Jonathan Cameron wrote:
> One reported platform uses this nonsensical entry to represent
> a disable CFWMS. The acpi_cxl driver already correctly errors
> out on seeing this, but that leaves an additional confusing node
> in /sys/devices/system/nodes/possible plus wastes some space.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/acpi/numa/srat.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> index e3f26e71637a..28c963d5c51f 100644
> --- a/drivers/acpi/numa/srat.c
> +++ b/drivers/acpi/numa/srat.c
> @@ -329,6 +329,11 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
>  	int node;
>  
>  	cfmws = (struct acpi_cedt_cfmws *)header;
> +
> +	/* At least one firmware reports disabled entries with size 0 */
> +	if (cfmws->window_size == 0)
> +		return 0;
> +
>  	start = cfmws->base_hpa;
>  	end = cfmws->base_hpa + cfmws->window_size;
>  
> -- 
> 2.39.2
>

Tested-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>

