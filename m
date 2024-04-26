Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B89152511
	for <linux-cxl@vger.kernel.org>; Fri, 26 Apr 2024 16:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714147364; cv=none; b=iIna9LZHhNn1qNqo73dUDofTHeu/ZJctJa1ZbuuObh0xZtTEBWKp/x3vh1r9wjZ0GQa0OEkIfTVEtRuV7gMm4W/KhJBV9P+SLV3LIgbYC0zSqQ3hGKaZI+Qy3fJj/0PN+8y2lIGJQJCM3cWra4XrLFY4edudqNGIqcpPwQhXl90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714147364; c=relaxed/simple;
	bh=4YuI+878WC1Vau3AOTJYw2vopsJ1ENCcHHO3umNl6xI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ban2u5tOsrDOEbAr6atQoxND+8TRxh1i6402TgquyQ1DZ1Mvj4hc4e15h4GB3WfV0EwhzXKD9xICap4BNy96KqmTckRkiXaDPNWeQsgW/0+BjqpJZJMi2B6shRobJ7g//CFGdwn4VGQ+zVQIf1lKS8IwNoeBq4vtDrU7viXivws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VQyD30jRHz6DBD8;
	Sat, 27 Apr 2024 00:02:27 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id DCC4414011D;
	Sat, 27 Apr 2024 00:02:38 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 26 Apr
 2024 17:02:38 +0100
Date: Fri, 26 Apr 2024 17:02:37 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <sthanneeru.opensrc@micron.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<john@jagalactic.com>, <emirakhur@micron.com>, <ajayjoshi@micron.com>,
	<Ravis.OpenSrc@micron.com>, <sthanneeru@micron.com>
Subject: Re: [PATCH v3 1/2] cxl/mbox: Add Get Log Capabilities and Get
 Supported Logs Sub-List commands
Message-ID: <20240426170237.000048f1@Huawei.com>
In-Reply-To: <20240313071218.729-2-sthanneeru.opensrc@micron.com>
References: <20240313071218.729-1-sthanneeru.opensrc@micron.com>
	<20240313071218.729-2-sthanneeru.opensrc@micron.com>
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
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 13 Mar 2024 12:42:17 +0530
<sthanneeru.opensrc@micron.com> wrote:

> From: Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>
> 
> Adding UAPI support for
> 1. CXL r3.1 8.2.9.5.3 Get Log Capabilities.
> 2. CXL r3.1 8.2.9.5.6 Get Supported Logs Sub-List.
> 
> Signed-off-by: Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>
Seems harmless to me and potentially useful.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/mbox.c      | 2 ++
>  drivers/cxl/cxlmem.h         | 2 ++
>  include/uapi/linux/cxl_mem.h | 2 ++
>  3 files changed, 6 insertions(+)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 27166a411705..30bd8264292f 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -56,6 +56,8 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
>  	CXL_CMD(GET_LSA, 0x8, CXL_VARIABLE_PAYLOAD, 0),
>  	CXL_CMD(GET_HEALTH_INFO, 0, 0x12, 0),
>  	CXL_CMD(GET_LOG, 0x18, CXL_VARIABLE_PAYLOAD, CXL_CMD_FLAG_FORCE_ENABLE),
> +	CXL_CMD(GET_LOG_CAPS, 0x10, 0x4, 0),
> +	CXL_CMD(GET_SUP_LOG_SUBLIST, 0x2, CXL_VARIABLE_PAYLOAD, 0),
>  	CXL_CMD(SET_PARTITION_INFO, 0x0a, 0, 0),
>  	CXL_CMD(SET_LSA, CXL_VARIABLE_PAYLOAD, 0, 0),
>  	CXL_CMD(GET_ALERT_CONFIG, 0, 0x10, 0),
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 5303d6942b88..671e46538baa 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -529,6 +529,8 @@ enum cxl_opcode {
>  	CXL_MBOX_OP_SET_TIMESTAMP	= 0x0301,
>  	CXL_MBOX_OP_GET_SUPPORTED_LOGS	= 0x0400,
>  	CXL_MBOX_OP_GET_LOG		= 0x0401,
> +	CXL_MBOX_OP_GET_LOG_CAPS	= 0x0402,
> +	CXL_MBOX_OP_GET_SUP_LOG_SUBLIST = 0x0405,
>  	CXL_MBOX_OP_IDENTIFY		= 0x4000,
>  	CXL_MBOX_OP_GET_PARTITION_INFO	= 0x4100,
>  	CXL_MBOX_OP_SET_PARTITION_INFO	= 0x4101,
> diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
> index 42066f4eb890..49c25056c222 100644
> --- a/include/uapi/linux/cxl_mem.h
> +++ b/include/uapi/linux/cxl_mem.h
> @@ -47,6 +47,8 @@
>  	___DEPRECATED(SCAN_MEDIA, "Scan Media"),                          \
>  	___DEPRECATED(GET_SCAN_MEDIA, "Get Scan Media Results"),          \
>  	___C(GET_TIMESTAMP, "Get Timestamp"),                             \
> +	___C(GET_LOG_CAPS, "Get Log Capabilities"),			  \
> +	___C(GET_SUP_LOG_SUBLIST, "Get Supported Logs Sub-List"),	  \
>  	___C(MAX, "invalid / last command")
>  
>  #define ___C(a, b) CXL_MEM_COMMAND_ID_##a

