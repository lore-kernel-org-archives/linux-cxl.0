Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A13C6FD1D
	for <linux-cxl@archiver.kernel.org>; Thu, 30 Mar 2023 18:58:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbjC3S6T (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 30 Mar 2023 14:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjC3S6S (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 30 Mar 2023 14:58:18 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5057D8C
        for <linux-cxl@vger.kernel.org>; Thu, 30 Mar 2023 11:58:10 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PnXdq1ny4z6J9X5;
        Fri, 31 Mar 2023 02:54:23 +0800 (CST)
Received: from localhost (10.195.247.161) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 30 Mar
 2023 19:58:08 +0100
Date:   Thu, 30 Mar 2023 19:58:07 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <alison.schofield@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v5 05/12] cxl/mem: Add debugfs attributes for poison
 inject and clear
Message-ID: <20230330195807.00007404@Huawei.com>
In-Reply-To: <b3844e5e940a100f32363f4a2e722ab6e415a96e.1679892337.git.alison.schofield@intel.com>
References: <cover.1679892337.git.alison.schofield@intel.com>
        <b3844e5e940a100f32363f4a2e722ab6e415a96e.1679892337.git.alison.schofield@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.195.247.161]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Sun, 26 Mar 2023 22:03:11 -0700
alison.schofield@intel.com wrote:

> From: Alison Schofield <alison.schofield@intel.com>
> 
> Inject and Clear Poison commands are optionally supported by CXL
> memdev devices and are intended for use in debug environments only.
> Add debugfs attributes for user access.
> 
> Documentation/ABI/testing/debugfs-cxl describes the usage.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  Documentation/ABI/testing/debugfs-cxl | 36 +++++++++++++++++++++++++++
>  drivers/cxl/mem.c                     | 26 +++++++++++++++++++
>  2 files changed, 62 insertions(+)
>  create mode 100644 Documentation/ABI/testing/debugfs-cxl
> 
> diff --git a/Documentation/ABI/testing/debugfs-cxl b/Documentation/ABI/testing/debugfs-cxl
> new file mode 100644
> index 000000000000..3f1624f95f11
> --- /dev/null
> +++ b/Documentation/ABI/testing/debugfs-cxl
> @@ -0,0 +1,36 @@
> +What:		/sys/kernel/debug/cxl/memX/inject_poison
> +Date:		April, 2023
> +KernelVersion:	v6.4
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(WO) When a Device Physical Address (DPA) is written to this
> +		attribute, the memdev driver sends an inject poison command to
> +		the device for the specified address. The DPA must be 64-byte
> +		aligned and the length of the injected poison is 64-bytes. If
> +		successful, the device returns poison when the address is
> +		accessed through the CXL.mem bus. Injecting poison adds the
> +		address to the device's Poison List and the error source is set
> +		to Injected. In addition, the device adds a poison creation
> +		event to its internal Informational Event log, updates the
> +		Event Status register, and if configured, interrupts the host.
> +		It is not an error to inject poison into an address that
> +		already has poison present and no error is returned. The
> +		inject_poison attribute is only visible for devices supporting
> +		the capability.
> +
> +
> +What:		/sys/kernel/debug/memX/clear_poison
> +Date:		April, 2023
> +KernelVersion:	v6.4
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(WO) When a Device Physical Address (DPA) is written to this
> +		attribute, the memdev driver sends a clear poison command to
> +		the device for the specified address. Clearing poison removes
> +		the address from the device's Poison List and writes 0 (zero)
> +		for 64 bytes starting at address. It is not an error to clear
> +		poison from an address that does not have poison set, and if
> +		poison was not set, the address is not overwritten. If the
As in earlier patch. I don't think this statement is true.  The 64 bytes
at the address are always overwritten, whether or not there is poison.

Otherwise makes sense to hide these in debugfs given they are definitely for debug.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> +		device cannot clear poison from the address, -ENXIO is returned.
> +		The clear_poison attribute is only visible for devices
> +		supporting the capability.
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 576f5b691589..ff67ecf07001 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -94,6 +94,22 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
>  	return 0;
>  }
>  
> +static int cxl_debugfs_poison_inject(void *data, u64 dpa)
> +{
> +	return cxl_inject_poison(data, dpa);
> +}
> +
> +DEFINE_DEBUGFS_ATTRIBUTE(cxl_poison_inject_fops, NULL,
> +			 cxl_debugfs_poison_inject, "%llx\n");
> +
> +static int cxl_debugfs_poison_clear(void *data, u64 dpa)
> +{
> +	return cxl_clear_poison(data, dpa);
> +}
> +
> +DEFINE_DEBUGFS_ATTRIBUTE(cxl_poison_clear_fops, NULL,
> +			 cxl_debugfs_poison_clear, "%llx\n");
> +
>  static int cxl_mem_probe(struct device *dev)
>  {
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> @@ -117,6 +133,16 @@ static int cxl_mem_probe(struct device *dev)
>  
>  	dentry = cxl_debugfs_create_dir(dev_name(dev));
>  	debugfs_create_devm_seqfile(dev, "dpamem", dentry, cxl_mem_dpa_show);
> +
> +	if (test_bit(CXL_MEM_COMMAND_ID_INJECT_POISON,
> +		     to_cxl_memdev(dev)->cxlds->enabled_cmds))
> +		debugfs_create_file("inject_poison", 0200, dentry, dev,
> +				    &cxl_poison_inject_fops);
> +	if (test_bit(CXL_MEM_COMMAND_ID_CLEAR_POISON,
> +		     to_cxl_memdev(dev)->cxlds->enabled_cmds))
> +		debugfs_create_file("clear_poison", 0200, dentry, dev,
> +				    &cxl_poison_clear_fops);
> +
>  	rc = devm_add_action_or_reset(dev, remove_debugfs, dentry);
>  	if (rc)
>  		return rc;

