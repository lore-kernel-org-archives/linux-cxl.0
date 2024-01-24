Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F267C0B7
	for <linux-cxl@vger.kernel.org>; Wed, 24 Jan 2024 14:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706108083; cv=none; b=UGzZZbmo4p/OCn3CP7dnXgy1BkguW/u0Mb/JX4Olwzn281RCYnfCewTRzHfoH8ZNtAd7ywRq8rAyEYUndXTJIVyFKxJz3DQvSb55OaW6fox6K8xz9brl1rmrcYH7DINg61fOFewEzxOBNb5TMbu9WWK7jKbFaT9JTtxEckv4Hco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706108083; c=relaxed/simple;
	bh=i57L4Kq2U3fVRf4ljVVYOm4cEpeRPyyH772pe9WreT4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gqz/3qR9DhkREhLmqrEGP/F0Z1vAcDF37pzNngfxUTJ9jrcCRcStJQRP7eat2+OgEi22aw9Tv0O5u5IwXbtWL00mf8xed7rdXfrauTC7rftYUM1FgdPK5Q/Jt1lLl8qf9AyS8oM34Yc4T9lcN9erRCsfMsMwHrm+hxyTtiz+iE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TKn3l6yKZz6K6DR;
	Wed, 24 Jan 2024 22:52:03 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id C524F140684;
	Wed, 24 Jan 2024 22:54:38 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Jan
 2024 14:54:38 +0000
Date: Wed, 24 Jan 2024 14:54:37 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <nifan.cxl@gmail.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>,
	<a.manzanares@samsung.com>, <dave@stgolabs.net>, <nmtadam.samsung@gmail.com>,
	<nifan@outlook.com>, <jim.harris@samsung.com>, "Fan Ni" <fan.ni@samsung.com>
Subject: Re: [PATCH v3 3/9] include/hw/cxl/cxl_device: Rename mem_size as
 static_mem_size for type3 memory devices
Message-ID: <20240124145437.00006522@Huawei.com>
In-Reply-To: <20231107180907.553451-4-nifan.cxl@gmail.com>
References: <20231107180907.553451-1-nifan.cxl@gmail.com>
	<20231107180907.553451-4-nifan.cxl@gmail.com>
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
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue,  7 Nov 2023 10:07:07 -0800
nifan.cxl@gmail.com wrote:

> From: Fan Ni <fan.ni@samsung.com>
> 
> Rename mem_size as static_mem_size for type3 memdev to cover static RAM and
> pmem capacity, preparing for the introduction of dynamic capacity to support
> dynamic capacity devices.
> 
> Signed-off-by: Fan Ni <fan.ni@samsung.com>
Hi Fan,

One trivial comment inline.

> ---
>  hw/cxl/cxl-mailbox-utils.c  | 4 ++--
>  hw/mem/cxl_type3.c          | 8 ++++----
>  include/hw/cxl/cxl_device.h | 2 +-
>  3 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index f80dd6474f..707fd9fe7f 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -774,7 +774,7 @@ static CXLRetCode cmd_identify_memory_device(const struct cxl_cmd *cmd,
>      snprintf(id->fw_revision, 0x10, "BWFW VERSION %02d", 0);
>  
>      stq_le_p(&id->total_capacity,
> -             cxl_dstate->mem_size / CXL_CAPACITY_MULTIPLIER);
> +            cxl_dstate->static_mem_size / CXL_CAPACITY_MULTIPLIER);
Indent ended up one space short.

>      stq_le_p(&id->persistent_capacity,
>               cxl_dstate->pmem_size / CXL_CAPACITY_MULTIPLIER);
>      stq_le_p(&id->volatile_capacity,
> @@ -1149,7 +1149,7 @@ static CXLRetCode cmd_media_clear_poison(const struct cxl_cmd *cmd,
>      struct clear_poison_pl *in = (void *)payload_in;
>  
>      dpa = ldq_le_p(&in->dpa);
> -    if (dpa + CXL_CACHE_LINE_SIZE > cxl_dstate->mem_size) {
> +    if (dpa + CXL_CACHE_LINE_SIZE > cxl_dstate->static_mem_size) {
>          return CXL_MBOX_INVALID_PA;
>      }
>  

