Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF761A76DE;
	Mon,  2 Feb 2026 14:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770043270; cv=none; b=Lk9ThnA5kwFoReXcm5yC4damEVqyEr3tNOYVQ6jA0XdDoGNuoEcocTu7huHzg42BetiT/Z3kB5e4Rl/p9R0ND8VnaFRlUETTmSUZowC+y5cti94AQL8TGfxN+BB0WjmsVQVlSS/qpqGnM35ByhoZj4mmHFsh6zalhQyOTFGEIc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770043270; c=relaxed/simple;
	bh=mQDHgU7zXJmGUHiy0+GotokYDe9fzjqtjElT1EgawB0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b5lo05DBP1B06/gqPnUWbAA1rkPvmNL1VVc7CiVLH7AdGj/utl9ndkFjSGHcvOJce8nAAZs207s5w7MvCjM3JG9xP6qaIhL4TGt/0QezphZZ2zOexeHqunWzrseVjhJjbUriWK/5MAJiY/EycnCvCK3lwLSE72pq/CpeRpTDOm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f4Tmg40YXzJ46DC;
	Mon,  2 Feb 2026 22:40:19 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 6B8F140572;
	Mon,  2 Feb 2026 22:41:05 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 2 Feb
 2026 14:41:04 +0000
Date: Mon, 2 Feb 2026 14:41:03 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Li Ming <ming.li@zohomail.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] cxl/core: Set cxlmd->endpoint to NULL by default
Message-ID: <20260202144103.000016cb@huawei.com>
In-Reply-To: <20260201093002.1281858-2-ming.li@zohomail.com>
References: <20260201093002.1281858-1-ming.li@zohomail.com>
	<20260201093002.1281858-2-ming.li@zohomail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Sun,  1 Feb 2026 17:30:01 +0800
Li Ming <ming.li@zohomail.com> wrote:

> CXL testing environment can trigger following trace
> 
>  Oops: general protection fault, probably for non-canonical address 0xdffffc0000000092: 0000 [#1] SMP KASAN NOPTI
>  KASAN: null-ptr-deref in range [0x0000000000000490-0x0000000000000497]
>  RIP: 0010:cxl_dpa_to_region+0x105/0x1f0 [cxl_core]
>  Call Trace:
>   <TASK>
>   cxl_event_trace_record+0xd1/0xa70 [cxl_core]
>   __cxl_event_trace_record+0x12f/0x1e0 [cxl_core]
>   cxl_mem_get_records_log+0x261/0x500 [cxl_core]
>   cxl_mem_get_event_records+0x7c/0xc0 [cxl_core]
>   cxl_mock_mem_probe+0xd38/0x1c60 [cxl_mock_mem]
>   platform_probe+0x9d/0x130
>   really_probe+0x1c8/0x960
>   __driver_probe_device+0x187/0x3e0
>   driver_probe_device+0x45/0x120
>   __device_attach_driver+0x15d/0x280
> 
> commit 29317f8dc6ed ("cxl/mem: Introduce cxl_memdev_attach for CXL-dependent operation")
> initializes cxlmd->endpoint to ERR_PTR(-ENXIO) in cxl_memdev_alloc().
> However, cxl_dpa_to_region() treats a non-NULL cxlmd->endpoint as a
> valid endpoint.
> 
> Across the CXL core, endpoint availability is generally determined by
> checking whether it is NULL. Align with this convention by initializing
> cxlmd->endpoint to NULL by default.

I had a look at whether it made sense to use use IS_ERR_OR_NULL() to check
for validity of the endpoint, but it would be somewhat fiddly and I think
you are correct that convention here seems to be NULL means not set.
We don't need the error code.  One comment inline.

Either way nice catch
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>


> 
> Fixes: 29317f8dc6ed ("cxl/mem: Introduce cxl_memdev_attach for CXL-dependent operation")
> Signed-off-by: Li Ming <ming.li@zohomail.com>
> ---
>  drivers/cxl/core/memdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index af3d0cc65138..41a507b5daa4 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -675,7 +675,7 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
>  	cxlmd->id = rc;
>  	cxlmd->depth = -1;
>  	cxlmd->attach = attach;
> -	cxlmd->endpoint = ERR_PTR(-ENXIO);
> +	cxlmd->endpoint = NULL;
cxlmd has just been allocated with kzalloc so I'd argue we don't need this to be explicitly
set at all.  Seems like a natural and safe default.

>  
>  	dev = &cxlmd->dev;
>  	device_initialize(dev);

