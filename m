Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD4A20B1E6
	for <linux-cxl@vger.kernel.org>; Fri,  4 Apr 2025 17:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743786494; cv=none; b=YLN8fPWzKwXgPXwgzCQWNnQLPkAahy78x2kdCvwUNroR35epNWUvXW7aKns6Te71T+0Ws2NCaTZwaBvkGFQby4f8DvotVJnODIDoKrFtgVw6D6SiMqxUy+WQ86KOGCMOqeX0/uhSa/DJsra9pqf4EygJvYmmijeeyNsSo/38GOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743786494; c=relaxed/simple;
	bh=KOrzHWhCvHpbgstrk3WF8Bu/xMDEcDZU9cOsd34kqeI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e+Qau0Muy8UQENn3AuvklBnxVPIYAdtClFRShkIUeK2Ujo56f5wVtqIMPn46kwLXgt5E6l0uYtLPSc9zZKdVJEYfPhdrPXVSWAl8+htweluvM+2Oa3tlgS2/xVJVjJDFtAQp0mqMfR7VS5GPZrkPbsPtoivW3GR6L7K2lbikoRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZTlMH4zGLz6M4ZC;
	Sat,  5 Apr 2025 01:04:27 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id BBE9A140625;
	Sat,  5 Apr 2025 01:08:09 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 4 Apr
 2025 19:08:09 +0200
Date: Fri, 4 Apr 2025 18:08:08 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>,
	<alison.schofield@intel.com>, <ira.weiny@intel.com>,
	<danj.williams@intel.com>, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] cxl: Remove always true condition for
 cxlctl_validate_hw_command()
Message-ID: <20250404180808.00004850@huawei.com>
In-Reply-To: <20250404165418.3032414-1-dave.jiang@intel.com>
References: <20250404165418.3032414-1-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 4 Apr 2025 09:54:18 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> smatch warnings:
> drivers/cxl/core/features.c:441 cxlctl_validate_hw_command() warn: always true condition '(scope >= 0) => (0-u32max >= 0)'
> 
> Remove the check entirely as it has no effect. Expectation is both of these
> operations should be allowed for all check levels. They are read only and
> have no change effects.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202504041033.2HBboAZR-lkp@intel.com/
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/features.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
> index caf92e9cea21..594f290042e9 100644
> --- a/drivers/cxl/core/features.c
> +++ b/drivers/cxl/core/features.c
> @@ -614,11 +614,7 @@ static bool cxlctl_validate_hw_command(struct cxl_features_state *cxlfs,
>  	switch (opcode) {
>  	case CXL_MBOX_OP_GET_SUPPORTED_FEATURES:
>  	case CXL_MBOX_OP_GET_FEATURE:
> -		if (cxl_mbox->feat_cap < CXL_FEATURES_RO)
> -			return false;
> -		if (scope >= FWCTL_RPC_CONFIGURATION)
> -			return true;
> -		return false;
> +		return cxl_mbox->feat_cap >= CXL_FEATURES_RO;
>  	case CXL_MBOX_OP_SET_FEATURE:
>  		if (cxl_mbox->feat_cap < CXL_FEATURES_RW)
>  			return false;

