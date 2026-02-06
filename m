Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CEC308F3B
	for <linux-cxl@vger.kernel.org>; Fri,  6 Feb 2026 12:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770381055; cv=none; b=EUkZ2Wh7Ibm3CzFZSuCC6NmmRtg4MmKxxVgYIS6wJJYBJe0kFiX3Hsr1hvM9ALtJwIXld+2hJbhCXD8ABpwsZSNhRLBRseeMmqw0zBebSky5KeUJDPWhMvNDbEHFa51vUu+rFXai6BeT8/zjnoHjKgZcXjOuePlePvhGDR3iz4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770381055; c=relaxed/simple;
	bh=lq47P17PiHQBXadN4pd3sq6Da8cVCmoeKeFqC9ibOQQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i2nh6Ru6ktBAEDqav7txx42XsI0jDDQ57aqxbA3r5m9aTDq9YWK3vhSwVxIIKaYgDw5t2rb2TYX5Yb0HZlXPXqiqG54DnvpcdDeZwDc2FKRQt3ZrpUJzLLUi4tCSig0SQW+wp9bgFz+HWuqq9hkQiqFsz5rzXvBBxTNsePwygU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f6thS4ZblzJ46Cf;
	Fri,  6 Feb 2026 20:30:00 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id E633240584;
	Fri,  6 Feb 2026 20:30:52 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 6 Feb
 2026 12:30:51 +0000
Date: Fri, 6 Feb 2026 12:30:50 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Alireza Sanaee <alireza.sanaee@huawei.com>
CC: <qemu-devel@nongnu.org>, <linuxarm@huawei.com>, <eblake@redhat.com>,
	<armbru@redhat.com>, <berrange@redhat.com>, <pbonzini@redhat.com>,
	<mst@redhat.com>, <lizhijian@fujitsu.com>, <anisa.su@samsung.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [RFC PATCH 3/7] hw/cxl: Change Extent add/remove APIs for lazy
 memory backend.
Message-ID: <20260206123050.00000ddb@huawei.com>
In-Reply-To: <20251127225526.700-4-alireza.sanaee@huawei.com>
References: <20251127225526.700-1-alireza.sanaee@huawei.com>
	<20251127225526.700-4-alireza.sanaee@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Thu, 27 Nov 2025 22:55:21 +0000
Alireza Sanaee <alireza.sanaee@huawei.com> wrote:

> Add extra information in each extent about fix memory window and

fixed

> memory backend, because extent might be backed by different memory
because each extent might be backed by a different memory backend

(under new scheme they are one to one)

> backends, thus such information must be stored in the extent object.
> Consequently, APIs should be changes to support extra members.
> 
> Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
> ---
>  hw/cxl/cxl-host.c           |  2 ++
>  hw/cxl/cxl-mailbox-utils.c  | 42 ++++++++++++++++++++++++-------------
>  hw/mem/cxl_type3.c          | 23 +++++++++++++++-----
>  include/hw/cxl/cxl_device.h | 17 ++++++++++++---
>  4 files changed, 61 insertions(+), 23 deletions(-)
> 
> diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
> index 3a563af3bc..7c8fde4646 100644
> --- a/hw/cxl/cxl-host.c
> +++ b/hw/cxl/cxl-host.c
> @@ -365,6 +365,8 @@ static int cxl_fmws_direct_passthrough(Object *obj, void *opaque)
>          return 0;
>      }
>  
> +    ct3d->dc.fw = fw;
> +
>      if (state->commit) {
>          MemoryRegion *mr = NULL;
>          uint64_t vmr_size = 0, pmr_size = 0;
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 68c7cc9891..ae723c03ec 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -2840,10 +2840,13 @@ CXLDCRegion *cxl_find_dc_region(CXLType3Dev *ct3d, uint64_t dpa, uint64_t len)
>  }
>  
>  void cxl_insert_extent_to_extent_list(CXLDCExtentList *list,
> +                                             HostMemoryBackend *host_mem,
> +                                             struct CXLFixedWindow *fw,
>                                               uint64_t dpa,
>                                               uint64_t len,
>                                               uint8_t *tag,
> -                                             uint16_t shared_seq)
> +                                             uint16_t shared_seq,
> +                                             int rid)

I'm not sure what rid is...  Maybe there is a better name?
The dynamic capacity region index?



