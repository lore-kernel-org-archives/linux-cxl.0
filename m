Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C574A21364
	for <linux-cxl@vger.kernel.org>; Fri, 26 Jul 2024 17:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722014971; cv=none; b=XBwIohNSY2Emj00vqTbP5QU8q091oJ0WpOSIAWgEoX8QEaszZRKHLwVE2g/Pa6XjFj9yoMbhKdDgDO4AdR0RPGSy/f08e1aA2lyP1TGyK2lWsFDZzLSsdlyNXh3kIQZfifvYNysZuObhdcaDJDz0u6IWQ/3TFZs1jT0PDthLptQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722014971; c=relaxed/simple;
	bh=CyMOs75Zjais8uvFJJxXT7C3jBQP9J3MQ2Aql28UC2E=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lyTylxtNBpvFFrJUJDWbexJZdEoDfmcVRTCdAZrxqvPR94m1bDxiETtc5NBA9OcS3UbGssjvPSyTP3eAVOQOGGe+/axyczFZTobbUSnqWfh0QrOxIlkwD9TDfy6fEyGHcicTtlzMa9vYWtUvbrYwZvpfqf/m0kW40Tg2pPnKsD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WVvpR0N4tz6K5rH;
	Sat, 27 Jul 2024 01:27:43 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 9979E140B2A;
	Sat, 27 Jul 2024 01:29:27 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 26 Jul
 2024 18:29:27 +0100
Date: Fri, 26 Jul 2024 18:29:26 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [RFC PATCH 02/13] cxl: Fix comment regarding cxl_query_cmd()
 return data
Message-ID: <20240726182926.000050b7@Huawei.com>
In-Reply-To: <20240718213446.1750135-3-dave.jiang@intel.com>
References: <20240718213446.1750135-1-dave.jiang@intel.com>
	<20240718213446.1750135-3-dave.jiang@intel.com>
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

On Thu, 18 Jul 2024 14:32:20 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> The code indicates that the min of n_commands and total commands
> is returned. The comment incorrectly says it's the max(). Correct
> comment to min().
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Send this one separately.
> ---
>  drivers/cxl/core/mbox.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 783cb5ed823f..433819ac36b7 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -547,7 +547,7 @@ int cxl_query_cmd(struct cxl_memdev *cxlmd,
>  		return put_user(ARRAY_SIZE(cxl_mem_commands), &q->n_commands);
>  
>  	/*
> -	 * otherwise, return max(n_commands, total commands) cxl_command_info
> +	 * otherwise, return min(n_commands, total commands) cxl_command_info
>  	 * structures.
>  	 */
>  	cxl_for_each_cmd(cmd) {

