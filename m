Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63539C77B75
	for <linux-cxl@archiver.kernel.org>; Fri, 12 May 2023 15:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241173AbjELPeC (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 12 May 2023 11:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241702AbjELPd4 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 12 May 2023 11:33:56 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C43C5B83
        for <linux-cxl@vger.kernel.org>; Fri, 12 May 2023 08:33:33 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QHt3K5xD6z6J6sv;
        Fri, 12 May 2023 23:29:17 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 12 May
 2023 16:33:15 +0100
Date:   Fri, 12 May 2023 16:33:14 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>
Subject: Re: [PATCH v5 13/14] cxl: Export sysfs attributes for memory device
 QoS class
Message-ID: <20230512163314.00002782@Huawei.com>
In-Reply-To: <168357889098.2756219.3746540473463747491.stgit@djiang5-mobl3>
References: <168357873843.2756219.5839806150467356492.stgit@djiang5-mobl3>
        <168357889098.2756219.3746540473463747491.stgit@djiang5-mobl3>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 08 May 2023 13:48:10 -0700
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

Reading this patch made me notice the whole issue of we may be exporting
a useless QTG for the device due to a missmatch of memory type and CFMWS
(as not using the full list provided by the _DSM)

> ---
> v5:
> - Change qtg_id to qos_class
> v4:
> - Change kernel version for documentation to v6.5
> v3:
> - Expand description of qtg_id. (Alison)
> ---
>  Documentation/ABI/testing/sysfs-bus-cxl |   32 +++++++++++++++++++++++++++++++
>  drivers/cxl/core/memdev.c               |   26 +++++++++++++++++++++++++
>  2 files changed, 58 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 2f24e42ef36d..c13ae49dd9aa 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -28,6 +28,22 @@ Description:
>  		Payload in the CXL-2.0 specification.
>  
>  
> +What:		/sys/bus/cxl/devices/memX/ram/qos_class
> +Date:		May, 2023
> +KernelVersion:	v6.5
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) For CXL host platforms that support "QoS Telemmetry"
> +		this attribute conveys a platform specific cookie that
> +		identifies a QoS performance class for the volatile
> +		partition of the CXL mem device. This class-id can be
> +		compared against a similar "qos_class" published for
> +		a root decoder. While it is not required that the endpoints
> +		map their local memory-class to a matching platform class,
> +		mismatches are not recommended and there are platform specific
> +		side-effects that may result.

I think this needs to be the full ordered list from the _DSM with text suggesting
that a compatible CFMWS matching the earliest entry possible should be used.



