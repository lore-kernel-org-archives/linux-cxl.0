Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2756A13AD03
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jan 2025 18:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737655477; cv=none; b=VwRsBEOV/hRnTTo+29DI67y6V8rKsonBDpzb3IDO2f4miqBF562cBfKGGkVdyBhlBYi7RyvgPPh48AeZ04MwDK0Ol0qq5MLBtrkZPx2JHjkpHT1JH315wZx/iyyZePzR917XKyrJnrnV4AMdBGZUlBBK3XZrhTNqfSFlhAgScak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737655477; c=relaxed/simple;
	bh=D7jRonq0+0hmtiv9v9tvJt7tTPdF4Lh0uB78uG+F4vs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NWICy0VSgrPCM3VeA+neRLYf8aYNe1gk8C5XMeGzD7wNW8Ah4cdSCjNB7iDzMcXTN9mbjlzTUR6Dj5djTpQCZUJsaxjakN22fpnhfxTFPXIhEYyqo8KpilVN/LqhBbxPUi59dnJidaKVZz2vjgjVeTrr0DvFErwaKff9d0LaP/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Yf8164ypCz6M4NH;
	Fri, 24 Jan 2025 02:02:34 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 1F87B1400C8;
	Fri, 24 Jan 2025 02:04:32 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 23 Jan
 2025 19:04:31 +0100
Date: Thu, 23 Jan 2025 18:04:30 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [PATCH v1 10/19] cxl: Add FWCTL support to the CXL features
 driver
Message-ID: <20250123180430.00006070@huawei.com>
In-Reply-To: <20250122235159.2716036-11-dave.jiang@intel.com>
References: <20250122235159.2716036-1-dave.jiang@intel.com>
	<20250122235159.2716036-11-dave.jiang@intel.com>
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
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 22 Jan 2025 16:50:41 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Add fwctl support code to allow sending of CXL feature commands from
> userspace through as ioctls via FWCTL. Provide initial setup bits.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> diff --git a/include/uapi/fwctl/fwctl.h b/include/uapi/fwctl/fwctl.h
> index f9b27fb5c161..2c3817592308 100644
> --- a/include/uapi/fwctl/fwctl.h
> +++ b/include/uapi/fwctl/fwctl.h
> @@ -43,6 +43,7 @@ enum {
>  enum fwctl_device_type {
>  	FWCTL_DEVICE_TYPE_ERROR = 0,
>  	FWCTL_DEVICE_TYPE_MLX5 = 1,
> +	FWCTL_DEVICE_TYPE_CXL,
Seems we are giving explicit numbers but not for CXL?
I don't greatly care either way but we should be consistent.  Jason?
>  };
>  
>  /**

