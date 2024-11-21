Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF5D155CBF
	for <linux-cxl@vger.kernel.org>; Thu, 21 Nov 2024 17:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732211382; cv=none; b=Z4glkEpIb+spNVlXpHzNHUVrlHAvqGTxd65V1F7sMSeeUHY8/VCYQP/rq9jkJrzrvZH5Rt4CQvEW1T1Ng/8TTsS2R37n3iHwgK9olC4lZXitG7+bfE9zqQPn58eeG7I4gzVOTS+iZDE2chy9TjdVXEC8Q5KkSYclmmciYUmEJGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732211382; c=relaxed/simple;
	bh=GUhZmblUcAz2e32y6LzDWByU6d04OOHb4Q44pJoOFb4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=axOQhKLOKo4I9wnYhA09FT8jipvaC14cPRPa7dXhDm5VuglZXpRl/zUdX4fsbGLDMbfuKgifERG71111C5gGlPELO3UJztPsEHS6IcLnqPL7FEInRcnjTwykl4aK9HxY3uCBhIFZh5jus2ZMO58yvwzKFH/xYZJ7fN22YKOX830=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XvQhn06L7z6883d;
	Fri, 22 Nov 2024 01:49:13 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 4FF4C1404F4;
	Fri, 22 Nov 2024 01:49:37 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 21 Nov
 2024 18:49:36 +0100
Date: Thu, 21 Nov 2024 17:49:35 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [RFC PATCH v2 07/20] cxl: Add Set Feature command support for
 user submission
Message-ID: <20241121174935.00003e2b@huawei.com>
In-Reply-To: <20241115212745.869552-8-dave.jiang@intel.com>
References: <20241115212745.869552-1-dave.jiang@intel.com>
	<20241115212745.869552-8-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 15 Nov 2024 14:25:40 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Add enumeration of Set Feature mailbox command for the kernel to recognize
> the command being passed in from user space.

This looks unwise to make available on the ioctl. 

> 
> CXL spec r3.1 8.2.9.6.3 Set Feature (Opcode 0502h)
> 
> The feature requested is identified by specific UUID.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/mbox.c      | 1 +
>  include/uapi/linux/cxl_mem.h | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 4b9abf9a5b2b..739444d34130 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -69,6 +69,7 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
>  	CXL_CMD(GET_TIMESTAMP, 0, 0x8, 0),
>  	CXL_CMD(GET_SUPPORTED_FEATURES, 0x8, CXL_VARIABLE_PAYLOAD, 0),
>  	CXL_CMD(GET_FEATURE, 0x15, CXL_VARIABLE_PAYLOAD, 0),
> +	CXL_CMD(SET_FEATURE, CXL_VARIABLE_PAYLOAD, 0, 0),
>  };
>  
>  /*
> diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
> index 90dcb9723997..469dd481795f 100644
> --- a/include/uapi/linux/cxl_mem.h
> +++ b/include/uapi/linux/cxl_mem.h
> @@ -52,6 +52,7 @@
>  	___C(GET_SUP_LOG_SUBLIST, "Get Supported Logs Sub-List"),	  \
>  	___C(GET_SUPPORTED_FEATURES, "Get Supported Features"),		  \
>  	___C(GET_FEATURE, "Get Feature"),				  \
> +	___C(SET_FEATURE, "Set Feature"),				  \
>  	___C(MAX, "invalid / last command")
>  
>  #define ___C(a, b) CXL_MEM_COMMAND_ID_##a

