Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0904C4332F
	for <linux-cxl@archiver.kernel.org>; Wed, 30 Nov 2022 14:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbiK3Onh (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 30 Nov 2022 09:43:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiK3Ong (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 30 Nov 2022 09:43:36 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5850927905
        for <linux-cxl@vger.kernel.org>; Wed, 30 Nov 2022 06:43:34 -0800 (PST)
Received: from fraeml741-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NMhhb22kpz67M3D;
        Wed, 30 Nov 2022 22:40:47 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml741-chm.china.huawei.com (10.206.15.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 30 Nov 2022 15:43:32 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 30 Nov
 2022 14:43:31 +0000
Date:   Wed, 30 Nov 2022 14:43:30 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <alison.schofield@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/5] cxl/memdev: Add support for the Clear Poison
 mailbox command
Message-ID: <20221130144330.00002709@Huawei.com>
In-Reply-To: <091f50b2644f220f0607633a4a953184e9c88b53.1669781852.git.alison.schofield@intel.com>
References: <cover.1669781852.git.alison.schofield@intel.com>
        <091f50b2644f220f0607633a4a953184e9c88b53.1669781852.git.alison.schofield@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 29 Nov 2022 20:34:34 -0800
alison.schofield@intel.com wrote:

> From: Alison Schofield <alison.schofield@intel.com>
> 
> CXL devices optionally support the CLEAR POISON mailbox command. Add
> a sysfs attribute and memdev driver support for clearing poison.
> 
> When a Device Physical Address (DPA) is written to the clear_poison
> sysfs attribute send a clear poison command to the device for the
> specified address.
> 
> Per the CXL Specification (8.2.9.8.4.3), after receiving a valid clear
> poison request, the device removes the address from the device's Poison
> List and writes 0 (zero) for 64 bytes starting at address. If the device
> cannot clear poison from the address, it returns a permanent media error
> and ENXIO is returned to the user.

-ENXIO

> 
> Additionally, and per the spec also, it is not an error to clear poison
> of an address that is not poisoned. No error is returned and the address
> is not overwritten. The memdev driver performs basic sanity checking on
> the address, however, it does not go as far as reading the poison list to
> see if the address is poisoned before clearing. That discovery is left to
> the device. The device safely handles that case.
> 
> Implementation note: Although the CXL specification defines the clear
> command to accept 64 bytes of 'write-data' to be used when clearing
> the poisoned address, this implementation always uses 0 (zeros) for
> the write-data.

Maybe put a * above to refer to this note given the spec is referenced
for stuff different from what you are doing with it.  Nice to flag
up to anyone reading this that they shouldn't write a 'no that's not
what it says' comment before reading on. (who would do something
silly like that? :)

> 
> The clear_poison attribute is only visible for devices supporting the
> capability.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Otherwise, a few really trivial things inline + it made me notice I'd missread
the code for patch 1, hence the reply to my reply.

With this stuff tweaked.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  Documentation/ABI/testing/sysfs-bus-cxl | 17 +++++++++
>  drivers/cxl/core/memdev.c               | 47 +++++++++++++++++++++++++
>  drivers/cxl/cxlmem.h                    |  6 ++++
>  3 files changed, 70 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 20db97f7a1aa..9d2b0fa07e17 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -435,3 +435,20 @@ Description:
>  		poison into an address that already has poison present and no
>  		error is returned. The inject_poison attribute is only visible
>                  for devices supporting the capability.
> +
> +
> +What:		/sys/bus/cxl/devices/memX/clear_poison
> +Date:		December, 2022
> +KernelVersion:	v6.2
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(WO) When a Device Physical Address (DPA) is written to this
> +		attribute the memdev driver sends a clear poison command to the
> +		device for the specified address. Clearing poison removes the
> +		address from the device's Poison List and writes 0 (zero)
> +		for 64 bytes starting at address. It is not an error to clear
> +		poison from an address that does not have poison set, and if
> +		poison was not set, the address is not overwritten. If the
> +		device cannot clear poison from the address, ENXIO is returned.

-ENXIO ?

> +		The clear_poison attribute is only visible for devices
> +		supporting the capability.
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 71130813030f..85caffd5a85c 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -187,6 +187,44 @@ static ssize_t inject_poison_store(struct device *dev,
>  }
>  static DEVICE_ATTR_WO(inject_poison);
>  
> +static ssize_t clear_poison_store(struct device *dev,
> +				  struct device_attribute *attr,
> +				  const char *buf, size_t len)
> +{
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_mbox_clear_poison *pi;
> +	u64 dpa;
> +	int rc;
> +
> +	rc = kstrtou64(buf, 0, &dpa);
> +	if (rc)
> +		return rc;
> +	rc = cxl_validate_poison_dpa(cxlds, dpa);
> +	if (rc)
> +		return rc;
Trivial:
blank line here.  Kind of make sense to keep the string parser and validation in
one block, but good to then separate that from the next bit of code.

> +	pi = kzalloc(sizeof(*pi), GFP_KERNEL);
> +	if (!pi)
> +		return -ENOMEM;
> +	/*
> +	 * In CXL 3.0 Spec 8.2.9.8.4.3, the Clear Poison mailbox command
> +	 * is defined to accept 64 bytes of 'write-data', along with the
> +	 * address to clear. The device writes 'write-data' into the DPA,
> +	 * atomically, while clearing poison if the location is marked as
> +	 * being poisoned.
> +	 *
> +	 * Always use '0' for the write-data.
> +	 */
> +	pi->address = cpu_to_le64(dpa);
> +	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_CLEAR_POISON, pi,
> +			       sizeof(*pi), NULL, cxlds->payload_size);
> +	if (rc)
> +		return rc;
> +
> +	return len;
> +}
> +static DEVICE_ATTR_WO(clear_poison);
...



