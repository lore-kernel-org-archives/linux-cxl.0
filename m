Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98901C691
	for <linux-cxl@vger.kernel.org>; Tue, 19 Dec 2023 14:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SvftV35W3z6JB5y;
	Tue, 19 Dec 2023 22:57:22 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 2D29F140DB0;
	Tue, 19 Dec 2023 22:58:24 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 19 Dec
 2023 14:58:08 +0000
Date: Tue, 19 Dec 2023 14:58:07 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>, <brice.goglin@gmail.com>,
	<nifan.cxl@gmail.com>
Subject: Re: [PATCH v2 2/3] cxl/region: Add sysfs attribute for locality
 attributes of CXL regions
Message-ID: <20231219145807.000016a8@Huawei.com>
In-Reply-To: <170268216573.1381493.1848451783927736490.stgit@djiang5-mobl3>
References: <170268206638.1381493.3891165173978942658.stgit@djiang5-mobl3>
	<170268216573.1381493.1848451783927736490.stgit@djiang5-mobl3>
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

On Fri, 15 Dec 2023 16:16:05 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Add read/write latencies and bandwidth sysfs attributes for the enabled CXL
> region. The bandwidth is the aggregated bandwidth of all devices that
> contribute to the CXL region. The latency is the worst latency of the
> device amongst all the devices that contribute to the CXL region.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
A few comments inline.

Jonathan

> ---
> v2:
> - Add units for documentation (Brice, Dan)
> - Add explanation initiator/target relation. (Brice)
> - Fix issue in commit log (Fan)
> ---
>  Documentation/ABI/testing/sysfs-bus-cxl |   56 +++++++++++++++++++++++++++++++
>  drivers/cxl/core/region.c               |   24 +++++++++++++
>  2 files changed, 80 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index fff2581b8033..e859f466a6b5 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -552,3 +552,59 @@ Description:
>  		attribute is only visible for devices supporting the
>  		capability. The retrieved errors are logged as kernel
>  		events when cxl_poison event tracing is enabled.
> +
> +
> +What:		/sys/bus/cxl/devices/regionZ/read_bandwidth
> +Date:		Apr, 2023
> +KernelVersion:	v6.8
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) The aggregated read bandwidth of the region. The number is
> +		the accumulated read bandwidth of all CXL memory devices that
> +		contributes to the region in MB/s. Should be equivalent to
> +		attributes in /sys/devices/system/node/nodeX/accessY/. See
> +		Documentation/ABI/stable/sysfs-devices-node.
> +		The host bus latency in the calculation is from proximity
> +		domain 0 to the host bus proximity domain.

If it's equivalent to /sys/devices/system/node/nodeX/accessY then it isn't
the domain 0 value it's the domain Y one. (IIRC how that works!)

> +
> +
> +What:		/sys/bus/cxl/devices/regionZ/write_bandwidth
> +Date:		Apr, 2023
> +KernelVersion:	v6.8
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) The aggregated write bandwidth of the region. The number is
> +		the accumulated write bandwidth of all CXL memory devices that
> +		contributes to the region in MB/s. Should be equivalent to
> +		attributes in /sys/devices/system/node/nodeX/accessY/. See
> +		Documentation/ABI/stable/sysfs-devices-node.
> +		The host bus latency in the calculation is from proximity
> +		domain 0 to the host bus proximity domain.
> +
> +
> +What:		/sys/bus/cxl/devices/regionZ/read_latency
> +Date:		Apr, 2023
> +KernelVersion:	v6.8
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) The read latency of the region. The number is
> +		the worst read latency of all CXL memory devices that
> +		contributes to the region in nanoseconds. Should be
> +		equivalent to attributes in /sys/devices/system/node/nodeX/accessY/.
> +		See Documentation/ABI/stable/sysfs-devices-node.
> +		The host bus latency in the calculation is from proximity
> +		domain 0 to the host bus proximity domain.
> +
> +
> +What:		/sys/bus/cxl/devices/regionZ/write_latency
> +Date:		Apr, 2023
> +KernelVersion:	v6.8
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) The write latency of the region. The number is
> +		the worst write latency of all CXL memory devices that
> +		contributes to the region in nanoseconds. Should be
> +		equivalent to attributes in /sys/devices/system/node/nodeX/accessY/.
> +		See Documentation/ABI/stable/sysfs-devices-node.
> +		The host bus latency in the calculation is from proximity
> +		domain 0 to the host bus proximity domain.
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index be7383e74ef5..d97fa5f32e86 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -645,6 +645,26 @@ static ssize_t size_show(struct device *dev, struct device_attribute *attr,
>  }
>  static DEVICE_ATTR_RW(size);
>  
> +#define ACCESS_ATTR(attrib)					\
> +static ssize_t attrib##_show(struct device *dev,		\
> +			   struct device_attribute *attr,	\
> +			   char *buf)				\
> +{								\
> +	struct cxl_region *cxlr = to_cxl_region(dev);		\
> +								\
> +	if (cxlr->coord.write_bandwidth == 0)			\

Fun questions for long run.  Does a RO DC region ever supply a write bandwidth?
Also, I'd prefer returning an error to say it's not provided than
returning that it is, but the length of the string is 0.
coord.attrib seems better in general.

I'd prefer to hide these attributes entirely if the value isn't available.
Is that tricky to do for some reason?  There is already a cxl_region_visible()
callback.

> +		return 0;					\
> +								\
> +	return sysfs_emit(buf, "%u\n",				\
> +			  cxlr->coord.attrib);			\

Oddly short line wrap.

> +}								\
> +static DEVICE_ATTR_RO(attrib)
> +
> +ACCESS_ATTR(read_bandwidth);
> +ACCESS_ATTR(read_latency);
> +ACCESS_ATTR(write_bandwidth);
> +ACCESS_ATTR(write_latency);
> +
>  static struct attribute *cxl_region_attrs[] = {
>  	&dev_attr_uuid.attr,
>  	&dev_attr_commit.attr,
> @@ -653,6 +673,10 @@ static struct attribute *cxl_region_attrs[] = {
>  	&dev_attr_resource.attr,
>  	&dev_attr_size.attr,
>  	&dev_attr_mode.attr,
> +	&dev_attr_read_bandwidth.attr,
> +	&dev_attr_write_bandwidth.attr,
> +	&dev_attr_read_latency.attr,
> +	&dev_attr_write_latency.attr,
>  	NULL,
>  };
>  
> 
> 

