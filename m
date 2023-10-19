Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDE42FE08
	for <linux-cxl@vger.kernel.org>; Thu, 19 Oct 2023 14:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF2B114
	for <linux-cxl@vger.kernel.org>; Thu, 19 Oct 2023 07:38:47 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SB9HD51r5z6HJdn;
	Thu, 19 Oct 2023 22:35:20 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 19 Oct
 2023 15:38:44 +0100
Date: Thu, 19 Oct 2023 15:38:43 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, Jim Harris <jim.harris@samsung.com>, "Dan
 Williams" <dan.j.williams@intel.com>, <dave@stgolabs.net>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>
Subject: Re: [PATCH v3 2/2] cxl: Add decoders_committed sysfs attribute to
 cxl_port
Message-ID: <20231019153843.00007850@Huawei.com>
In-Reply-To: <169747907439.272156.10261062080830155662.stgit@djiang5-mobl3>
References: <169747906849.272156.1729290904857372335.stgit@djiang5-mobl3>
	<169747907439.272156.10261062080830155662.stgit@djiang5-mobl3>
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
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected

On Mon, 16 Oct 2023 10:57:54 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> This attribute allows cxl-cli to determine whether there are decoders
> committed to a memdev.  This is only a snapshot of the state, and
> doesn't offer any protection or serialization against a concurrent
> disable-region operation.
> 
> Reviewed-by: Jim Harris <jim.harris@samsung.com>
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Seems reasonable, but it is adding ABI so the docs are missing.
Documentation/ABI/testing/sysfs-bus-cxl



> ---
> v2:
> - Use cxl_region_rwsem to protect reading of decoder info. (Dan)
> ---
>  drivers/cxl/core/port.c |   25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index d0ed98a6bade..0adee1e406ec 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -534,8 +534,33 @@ static void cxl_port_release(struct device *dev)
>  	kfree(port);
>  }
>  
> +static ssize_t decoders_committed_show(struct device *dev,
> +				       struct device_attribute *attr, char *buf)
> +{
> +	struct cxl_port *port = to_cxl_port(dev);
> +	int rc;
> +
> +	down_read(&cxl_region_rwsem);
> +	rc = sysfs_emit(buf, "%d\n", cxl_num_decoders_committed(port));
> +	up_read(&cxl_region_rwsem);
> +
> +	return rc;
> +}
> +
> +static DEVICE_ATTR_RO(decoders_committed);
> +
> +static struct attribute *cxl_port_attrs[] = {
> +	&dev_attr_decoders_committed.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group cxl_port_attribute_group = {
> +	.attrs = cxl_port_attrs,
> +};
> +
>  static const struct attribute_group *cxl_port_attribute_groups[] = {
>  	&cxl_base_attribute_group,
> +	&cxl_port_attribute_group,
>  	NULL,
>  };
>  
> 
> 
> 

