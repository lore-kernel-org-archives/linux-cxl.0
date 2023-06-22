Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08819EB64D8
	for <linux-cxl@archiver.kernel.org>; Thu, 22 Jun 2023 13:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbjFVN2K (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 22 Jun 2023 09:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjFVN2J (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 22 Jun 2023 09:28:09 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B385D1995
        for <linux-cxl@vger.kernel.org>; Thu, 22 Jun 2023 06:28:07 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Qn1MT6YxFz687PR;
        Thu, 22 Jun 2023 21:25:25 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 22 Jun
 2023 14:28:05 +0100
Date:   Thu, 22 Jun 2023 14:28:04 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>
Subject: Re: [PATCH v7 10/11] cxl: Export sysfs attributes for memory device
 QoS class
Message-ID: <20230622142804.000011b4@Huawei.com>
In-Reply-To: <168695175866.3031571.16844903696610491673.stgit@djiang5-mobl3>
References: <168695160531.3031571.4875512229068707023.stgit@djiang5-mobl3>
        <168695175866.3031571.16844903696610491673.stgit@djiang5-mobl3>
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

On Fri, 16 Jun 2023 14:42:38 -0700
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
> 

I argue with myself inline. In the end I think you made right trade off
of complexity vs corner case handling.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 057a43267290..89b8858f72b6 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -77,6 +77,37 @@ static ssize_t ram_size_show(struct device *dev, struct device_attribute *attr,
>  static struct device_attribute dev_attr_ram_size =
>  	__ATTR(size, 0444, ram_size_show, NULL);
>  
> +static int qos_class_sysfs_emit(struct qos_class *qos_class, char *buf)
> +{
> +	int count, i;
> +
> +	if (!qos_class)
> +		return 0;
> +
> +	for (i = 0, count = 0; i < qos_class->nr; i++) {
> +		count += sysfs_emit_at(buf, count, "%d", qos_class->entries[i]);
> +		count += sysfs_emit_at(buf, count, ", ");
> +	}
> +
> +	count -= 2;
> +	count += sysfs_emit_at(buf, count, "\n");
Corner case fun.
If
count += sysfs_emit_at() butts up against the end of the buffer (would otherwise
overflow by 1) then you just pasted the \n one character earlier than desired and
ended up using only 4095 bytes of the 4k page.

Trivial but ugly ;)

I can see the complexity is here to avoid missing the \n in overflow condition
(which we don't expect on a sane system).

I guess it a fair trade off to loose a byte in the corner case.

> +
> +	return count;
> +}

