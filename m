Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDD4762F0
	for <linux-cxl@vger.kernel.org>; Thu,  8 Feb 2024 12:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707397044; cv=none; b=bQ6zj2jTmBe5yx3R+2dOMb3gBHJJnblnhf28mjbtvPsgK5kOnGzzxRee8eyHj73gfQVJgMMc7/vaIaqtpxP9B1t92oBiMKJdKeMvFnA+CD0tP1XsW3Gs0rudc1u7xtnAMJNXeOVdBYKeLE8LOc9lsg5TOu8SKVeET4wrIGM7tFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707397044; c=relaxed/simple;
	bh=Z1AhRTX2glwI4fl9saz3BjYoY6LyjAzuxv6ks/m1kwQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FQIQLbUImgEiptXiV/mpYrIv8vmqrkGL7rDfqerXHeRwTkU4WEOsZBy3pXvdop4+5vnSPstbPnuvel8gjyKvFhaPlG1MNtwoikfy3S1/T8GyJwyTeYTDLSGpYoenuZ6ieWo7dE5rt9Y/n+AEKx9+hQnaThGIlcijGfbv/v3oOQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TVxkY6xmJz6K99q;
	Thu,  8 Feb 2024 20:53:57 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id F1FE5140B73;
	Thu,  8 Feb 2024 20:57:15 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 8 Feb
 2024 12:57:15 +0000
Date: Thu, 8 Feb 2024 12:57:13 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <sthanneeru.opensrc@micron.com>
CC: <linux-cxl@vger.kernel.org>, <linux-mm@kvack.org>,
	<dan.j.williams@intel.com>, <john@jagalactic.com>, <emirakhur@micron.com>,
	<ajayjoshi@micron.com>, <Ravis.OpenSrc@micron.com>, <sthanneeru@micron.com>,
	<shiju.jose@huawei.com>
Subject: Re: [PATCH] cxl/mbox: Add Get Log Capabilities, Clear Log and Get
 Supported Logs Sub-List commands
Message-ID: <20240208125713.00004776@Huawei.com>
In-Reply-To: <20240207103634.199-1-sthanneeru.opensrc@micron.com>
References: <20240207103634.199-1-sthanneeru.opensrc@micron.com>
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
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 7 Feb 2024 16:06:34 +0530
<sthanneeru.opensrc@micron.com> wrote:

> From: Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>
> 
> Adding UAPI support for
> 1. CXL r3.1 8.2.9.5.3 Get Log Capabilities.
> 2. CXL r3.1 8.2.9.5.4 Clear Log commands.
> 3. CXL r3.1 8.2.9.5.6 Get Supported Logs Sub-List.
> 
> Signed-off-by: Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>

Hi Srinivasulu,

Whilst I can conjecture some valid reasons to expose these to
userspace, can you add some examples to this patch description?

We might want to filter the clear in particular to avoid a clash
with the driver log handling. That is only allow it for vendor
logs.

Perhaps split the patch into 2 parts. The less controversial
GET_LOG_CAPS and GET_LOG_SUBLIST, followed by a patch for the
destructive clear log.

The memory scrub handling might well
access the ECS log for example (I don't think the current proposal
yet does this).

Jonathan


> ---
>  drivers/cxl/core/mbox.c      | 3 +++
>  drivers/cxl/cxlmem.h         | 3 +++
>  include/uapi/linux/cxl_mem.h | 3 +++
>  3 files changed, 9 insertions(+)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 27166a411705..64a44e286488 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -64,6 +64,9 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
>  	CXL_CMD(SET_SHUTDOWN_STATE, 0x1, 0, 0),
>  	CXL_CMD(GET_SCAN_MEDIA_CAPS, 0x10, 0x4, 0),
>  	CXL_CMD(GET_TIMESTAMP, 0, 0x8, 0),
> +	CXL_CMD(GET_LOG_CAPS, 0x10, 0x4, 0),
> +	CXL_CMD(CLEAR_LOG, 0x10, 0, 0),
> +	CXL_CMD(GET_LOG_SUBLIST, 0x2, CXL_VARIABLE_PAYLOAD, 0),
>  };
>  
>  /*
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 5303d6942b88..4128c810051c 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -529,6 +529,9 @@ enum cxl_opcode {
>  	CXL_MBOX_OP_SET_TIMESTAMP	= 0x0301,
>  	CXL_MBOX_OP_GET_SUPPORTED_LOGS	= 0x0400,
>  	CXL_MBOX_OP_GET_LOG		= 0x0401,
> +	CXL_MBOX_OP_GET_LOG_CAPS	= 0x0402,
> +	CXL_MBOX_OP_CLEAR_LOG		= 0x0403,
> +	CXL_MBOX_OP_GET_LOG_SUBLIST     = 0x0405,

Name should include something to make it clear this is getting
sublist of 'supported' logs.  Not the log.
 
>  	CXL_MBOX_OP_IDENTIFY		= 0x4000,
>  	CXL_MBOX_OP_GET_PARTITION_INFO	= 0x4100,
>  	CXL_MBOX_OP_SET_PARTITION_INFO	= 0x4101,
> diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
> index 42066f4eb890..d2df9782a5ef 100644
> --- a/include/uapi/linux/cxl_mem.h
> +++ b/include/uapi/linux/cxl_mem.h
> @@ -47,6 +47,9 @@
>  	___DEPRECATED(SCAN_MEDIA, "Scan Media"),                          \
>  	___DEPRECATED(GET_SCAN_MEDIA, "Get Scan Media Results"),          \
>  	___C(GET_TIMESTAMP, "Get Timestamp"),                             \
> +	___C(GET_LOG_CAPS, "Get Log Capabilities"),			  \
> +	___C(CLEAR_LOG, "Clear Log"),					  \
> +	___C(GET_LOG_SUBLIST, "Get Log Sublist"),			  \

Likewise, mention it's list of supported logs.

>  	___C(MAX, "invalid / last command")
>  
>  #define ___C(a, b) CXL_MEM_COMMAND_ID_##a

