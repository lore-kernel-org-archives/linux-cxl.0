Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A9C18A95E
	for <linux-cxl@vger.kernel.org>; Fri, 23 Aug 2024 15:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724425424; cv=none; b=RHHY/okRpYZV5pS8I8NaQOXke/OZ0pFBzuULHP+qJA7IP5QeCTYVHYfLzq0bCdGQ6kQc1f2RmiXx9NR3AZPOAKC2qQfZMrJRrOxxe+VsP4na/JB3IUbLQgm4y8H8eOjiHZgKdNfwyE/fcKDRYrqGamIcsSY7lRAp8FlgmjN7iGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724425424; c=relaxed/simple;
	bh=f/9Ssj+0/r/335G2uqu5WrVWRk8lGG+1C+NcmVxz8rQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DoEVf+49EgAskQhchMxQabH4KHKCUCNP03UNCuh3qXUIjpEIv3GA52+9CQDMpJMOtTbEhc4Zbh1Zm0HvhZ9IMcNu+ynli7iNSgEibMhHkwgSIwfqSi46cwXOh/XZT8vfODEbXlED6FfJtZGeQz0sTwMGLKbb6d/rkBBpDHtMg5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Wr3Bv4zxHz6GBsm;
	Fri, 23 Aug 2024 22:59:51 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 1A3061400DB;
	Fri, 23 Aug 2024 23:03:37 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 23 Aug
 2024 16:03:36 +0100
Date: Fri, 23 Aug 2024 16:03:35 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: peng guo <engguopeng@buaa.edu.cn>
CC: <fan.ni@samsung.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2] hw/cxl: fix physical address field in get scan media
 results output
Message-ID: <20240823160335.000068ea@Huawei.com>
In-Reply-To: <20240819154206.16456-1-engguopeng@buaa.edu.cn>
References: <20240819154206.16456-1-engguopeng@buaa.edu.cn>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 19 Aug 2024 23:42:06 +0800
peng guo <engguopeng@buaa.edu.cn> wrote:

> When using the mailbox command get scan media results, the scan media 
> restart physical address field in the ouput palyload is not 64-byte 
> aligned.
> 
> This patch removed the error source of the restart physical address. 
> 
> The Scan Media Restart Physical Address is the location from which the 
> host should restart the Scan Media operation. [5:0] bits are reserved.
> Refer to CXL spec r3.1 Table 8-146
> 
> Fixes: 89b5cfcc31e6 ("hw/cxl: Add get scan media results cmd support")
> Signed-off-by: peng guo <engguopeng@buaa.edu.cn>

For qemu patches, definitely need to include the qemu-devel list.
For this please also +CC Michael Tsirkin <mst@redhat.com>

I guess this is a cut and paste issue from the poison code.

Send a v3 with
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
but include a link tag to
Link: https://lore.kernel.org/linux-cxl/20240819154206.16456-1-engguopeng@buaa.edu.cn/

So MST  + qemu list readers can find this thread.

Thanks,

Jonathan

> ---
> v1 -> v2: Add module name to title
> 
>  hw/cxl/cxl-mailbox-utils.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 3ebbd32e1028..9258e48f95ee 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -2076,7 +2076,7 @@ static CXLRetCode cmd_media_get_scan_media_results(const struct cxl_cmd *cmd,
>  
>          start = ROUND_DOWN(ent->start, 64ull);
>          stop = ROUND_DOWN(ent->start, 64ull) + ent->length;
> -        stq_le_p(&out->records[i].addr, start | (ent->type & 0x7));
> +        stq_le_p(&out->records[i].addr, start);
>          stl_le_p(&out->records[i].length, (stop - start) / CXL_CACHE_LINE_SIZE);
>          i++;
>  

