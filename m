Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF48C18A6B0
	for <linux-cxl@vger.kernel.org>; Thu, 21 Nov 2024 17:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732211275; cv=none; b=BG4hSZ5seoE8eGdArRTHT19hsvbmXs4djAh2jJxa8YAxtrnwzF1NP4O9pPIEuCn3u/7HVYstmGBobXycdQZd3Z6eBh/HSJPEyGkaJ4jdJYSwJGBlJN5if1RJS5aUz4V9DWvfEy4wlhuFyJfZGZkyuU/ESULn4hyOFwsE11f7Two=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732211275; c=relaxed/simple;
	bh=POj3UoitnwqNd+KQio20dvRsRtvfxFEvvZ/J5M6QysU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IuUXC5SVLBni3QE/IeD1LRj942HXJA81O86YV1+A9OAOqeZQUBcSjGIfH8JUPPK5xa/+LML75TppVmK9I0IWPssFNg9So8CudcmNCuLz+yAjgiikCmhudB8frQ68PHbRpYLFHXgUbSbueGCpvPNFdFYKRDDeUjNGcc2LC+59E2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XvQb344L1z6K6gk;
	Fri, 22 Nov 2024 01:44:15 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id BE3E914038F;
	Fri, 22 Nov 2024 01:47:50 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 21 Nov
 2024 18:47:50 +0100
Date: Thu, 21 Nov 2024 17:47:48 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [RFC PATCH v2 05/20] cxl: Add Get Feature command support for
 user submission
Message-ID: <20241121174748.000046ce@huawei.com>
In-Reply-To: <20241115212745.869552-6-dave.jiang@intel.com>
References: <20241115212745.869552-1-dave.jiang@intel.com>
	<20241115212745.869552-6-dave.jiang@intel.com>
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

On Fri, 15 Nov 2024 14:25:38 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Add enumeration of Get Feature mailbox command for the kernel to recognize
> the command being passed in from user space.
> 
> CXL spec r3.1 8.2.9.6.2 Get Feature (Opcode 0501h)
> 
> The feature requested is identified by specific UUID.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Hmm. Should we push this into Shiju's series if thought is that will land
first?  Seems harmless but I find it hard to care that much ;)

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/cxl/core/mbox.c      | 1 +
>  include/uapi/linux/cxl_mem.h | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index f70bd7d28ff8..f49665d3b4d6 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -68,6 +68,7 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
>  	CXL_CMD(GET_SCAN_MEDIA_CAPS, 0x10, 0x4, 0),
>  	CXL_CMD(GET_TIMESTAMP, 0, 0x8, 0),
>  	CXL_CMD(GET_SUPPORTED_FEATURES, 0x8, CXL_VARIABLE_PAYLOAD, 0),
> +	CXL_CMD(GET_FEATURE, 0x15, CXL_VARIABLE_PAYLOAD, 0),
>  };
>  
>  /*
> diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
> index bd2535962f70..90dcb9723997 100644
> --- a/include/uapi/linux/cxl_mem.h
> +++ b/include/uapi/linux/cxl_mem.h
> @@ -51,6 +51,7 @@
>  	___C(CLEAR_LOG, "Clear Log"),					  \
>  	___C(GET_SUP_LOG_SUBLIST, "Get Supported Logs Sub-List"),	  \
>  	___C(GET_SUPPORTED_FEATURES, "Get Supported Features"),		  \
> +	___C(GET_FEATURE, "Get Feature"),				  \
>  	___C(MAX, "invalid / last command")
>  
>  #define ___C(a, b) CXL_MEM_COMMAND_ID_##a

