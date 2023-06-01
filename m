Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 229C9C7EE23
	for <linux-cxl@archiver.kernel.org>; Thu,  1 Jun 2023 14:30:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233318AbjFAOaa (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 1 Jun 2023 10:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbjFAOaZ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 1 Jun 2023 10:30:25 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6AA98
        for <linux-cxl@vger.kernel.org>; Thu,  1 Jun 2023 07:30:24 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QX7p46qRvz6J6nK;
        Thu,  1 Jun 2023 22:30:20 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 1 Jun
 2023 15:30:22 +0100
Date:   Thu, 1 Jun 2023 15:30:21 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>
Subject: Re: [PATCH v6 10/11] cxl: Export sysfs attributes for memory device
 QoS class
Message-ID: <20230601153021.000022bd@Huawei.com>
In-Reply-To: <168451605449.3470703.14744276101463857790.stgit@djiang5-mobl3>
References: <168451588868.3470703.3527256859632103687.stgit@djiang5-mobl3>
        <168451605449.3470703.14744276101463857790.stgit@djiang5-mobl3>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 19 May 2023 10:07:34 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Export qos_class sysfs attributes for the CXL memory device. The QoS clas
> should show up as /sys/bus/cxl/devices/memX/ram/qos_class for the volatile
> partition and /sys/bus/cxl/devices/memX/pmem/qos_class for the persistent
> partition. The QTG ID is retrieved via _DSM after supplying the
> calculated bandwidth and latency for the entire CXL path from device to
> the CPU. This ID is used to match up to the root decoder QoS class to
> determine which CFMWS the memory range of a hotplugged CXL mem device
> should be assigned under.
> 
> While there may be multiple DSMAS exported by the device CDAT, the driver
> will only expose the first QTG ID per partition in sysfs for now. In the
> future when multiple QTG IDs are necessary, they can be exposed. [1]
> 
> [1]: https://lore.kernel.org/linux-cxl/167571650007.587790.10040913293130712882.stgit@djiang5-mobl3.local/T/#md2a47b1ead3e1ba08f50eab29a4af1aed1d215ab
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

A few minor suggestions inline.
In particular some code duplication that looks easy to avoid.

Jonathan

> 
> ---
> v6:
> - Provide full ordered QTG IDs from _DSM. (Jonathan)
> v5:
> - Change qtg_id to qos_class
> v4:
> - Change kernel version for documentation to v6.5
> v3:
> - Expand description of qtg_id. (Alison)
> ---
>  Documentation/ABI/testing/sysfs-bus-cxl |   34 +++++++++++++++++++
>  drivers/cxl/core/memdev.c               |   55 +++++++++++++++++++++++++++++++
>  2 files changed, 89 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index ccfc7ecc61f5..7a4cacd382f9 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -28,6 +28,23 @@ Description:
>  		Payload in the CXL-2.0 specification.
>  
>  
> +What:		/sys/bus/cxl/devices/memX/ram/qos_class
> +Date:		May, 2023
> +KernelVersion:	v6.5
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) For CXL host platforms that support "QoS Telemmetry"
> +		this attribute conveys a comma delimited list of platform
> +		specific cookies that identifies a QoS performance class
> +		for the volatile partition of the CXL mem device. These
> +		class-ids can be compared against a similar "qos_class"
> +		published for a root decoder. While it is not required
> +		that the endpoints map their local memory-class to a
> +		matching platform class, mismatches are not recommended
> +		and there are platform specific side-effects that may
> +		result.

That sounds scary - perhaps "platform specific performance related
side-effects that may result."

> +
> +
>  What:		/sys/bus/cxl/devices/memX/pmem/size
>  Date:		December, 2020
>  KernelVersion:	v5.12
> @@ -38,6 +55,23 @@ Description:
>  		Payload in the CXL-2.0 specification.
>  
>  
> +What:		/sys/bus/cxl/devices/memX/pmem/qos_class
> +Date:		May, 2023
> +KernelVersion:	v6.5
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) For CXL host platforms that support "QoS Telemmetry"
> +		this attribute conveys a comma delimited list of platform
> +		specific cookies that identifies a QoS performance class
> +		for the persistent partition of the CXL mem device. These
> +		class-ids can be compared against a similar "qos_class"
> +		published for a root decoder. While it is not required
> +		that the endpoints map their local memory-class to a
> +		matching platform class, mismatches are not recommended
> +		and there are platform specific side-effects that may
> +		result.
> +
> +
>  What:		/sys/bus/cxl/devices/memX/serial
>  Date:		January, 2022
>  KernelVersion:	v5.18
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 057a43267290..9366257e3183 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -77,6 +77,32 @@ static ssize_t ram_size_show(struct device *dev, struct device_attribute *attr,
>  static struct device_attribute dev_attr_ram_size =
>  	__ATTR(size, 0444, ram_size_show, NULL);
>  
> +static ssize_t ram_qos_class_show(struct device *dev,
> +				  struct device_attribute *attr, char *buf)
> +{
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct qos_class *qos_class = cxlds->ram_qos_class;
> +	int count, i;
> +
> +	if (!qos_class)
> +		return 0;
> +
> +	for (i = 0, count = 0; i < qos_class->nr; i++) {
> +		count += sysfs_emit_at(buf, count, "%d",
> +				       qos_class->entries[i]);
> +		if (i + 1 == qos_class->nr)
> +			count += sysfs_emit_at(buf, count, "\n");
> +		else
> +			count += sysfs_emit_at(buf, count, ", ");
> +	}
> +
> +	return count;
> +}
> +
> +static struct device_attribute dev_attr_ram_qos_class =
> +	__ATTR(qos_class, 0444, ram_qos_class_show, NULL);
> +
>  static ssize_t pmem_size_show(struct device *dev, struct device_attribute *attr,
>  			      char *buf)
>  {
> @@ -90,6 +116,33 @@ static ssize_t pmem_size_show(struct device *dev, struct device_attribute *attr,
>  static struct device_attribute dev_attr_pmem_size =
>  	__ATTR(size, 0444, pmem_size_show, NULL);
>  
> +static ssize_t pmem_qos_class_show(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
> +{
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct qos_class *qos_class = cxlds->pmem_qos_class;
> +	int count, i;
> +
> +	if (!qos_class)
> +		return 0;
> +
> +	for (i = 0, count = 0; i < qos_class->nr; i++) {
> +		count += sysfs_emit_at(buf, count, "%d",
> +				       qos_class->entries[i]);
> +
> +		if (i + 1 == qos_class->nr)
> +			count += sysfs_emit_at(buf, count, "\n");
> +		else
> +			count += sysfs_emit_at(buf, count, ", ");
> +	}

Bunch of shred code here with the volatile case.
Add a little utility function to avoid that?

> +
> +	return count;
> +}
> +
> +static struct device_attribute dev_attr_pmem_qos_class =
> +	__ATTR(qos_class, 0444, pmem_qos_class_show, NULL);
> +
>  static ssize_t serial_show(struct device *dev, struct device_attribute *attr,
>  			   char *buf)
>  {
> @@ -344,11 +397,13 @@ static struct attribute *cxl_memdev_attributes[] = {
>  
>  static struct attribute *cxl_memdev_pmem_attributes[] = {
>  	&dev_attr_pmem_size.attr,
> +	&dev_attr_pmem_qos_class.attr,
>  	NULL,
>  };
>  
>  static struct attribute *cxl_memdev_ram_attributes[] = {
>  	&dev_attr_ram_size.attr,
> +	&dev_attr_ram_qos_class.attr,
>  	NULL,
>  };
>  
> 
> 

