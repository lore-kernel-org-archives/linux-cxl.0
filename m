Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAE665198
	for <linux-cxl@vger.kernel.org>; Fri, 12 Jan 2024 11:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TBJsv2GXtz6D8YR;
	Fri, 12 Jan 2024 19:17:39 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 8B1DD14058E;
	Fri, 12 Jan 2024 19:20:04 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 12 Jan
 2024 11:20:03 +0000
Date: Fri, 12 Jan 2024 11:20:03 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>, <dave.jiang@intel.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] cxl/core: use sysfs_emit() for attr's _show()
Message-ID: <20240112112003.00000e46@Huawei.com>
In-Reply-To: <20240112062709.2490947-1-ruansy.fnst@fujitsu.com>
References: <20240112062709.2490947-1-ruansy.fnst@fujitsu.com>
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
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 12 Jan 2024 14:27:09 +0800
Shiyang Ruan <ruansy.fnst@fujitsu.com> wrote:

> sprintf() is deprecated for sysfs, use preferred sysfs_emit() instead.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
FWIW this looks fine to me.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/memdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 2f43d368ba07..dae8802ecdb0 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -114,7 +114,7 @@ static DEVICE_ATTR_RO(serial);
>  static ssize_t numa_node_show(struct device *dev, struct device_attribute *attr,
>  			      char *buf)
>  {
> -	return sprintf(buf, "%d\n", dev_to_node(dev));
> +	return sysfs_emit(buf, "%d\n", dev_to_node(dev));
>  }
>  static DEVICE_ATTR_RO(numa_node);
>  

