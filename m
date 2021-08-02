Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7CF4C4338F
	for <linux-cxl@archiver.kernel.org>; Mon,  2 Aug 2021 15:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF6CD610FC
	for <linux-cxl@archiver.kernel.org>; Mon,  2 Aug 2021 15:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234281AbhHBPFF (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 2 Aug 2021 11:05:05 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3551 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234362AbhHBPFF (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 2 Aug 2021 11:05:05 -0400
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GdhB441xsz6F8Fm;
        Mon,  2 Aug 2021 23:04:44 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 2 Aug 2021 17:04:53 +0200
Received: from localhost (10.47.9.82) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 2 Aug 2021
 16:04:52 +0100
Date:   Mon, 2 Aug 2021 16:04:24 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Ben Widawsky <ben.widawsky@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>
Subject: Re: [PATCH v3 5/6] cxl/pci: Introduce cdevm_file_operations
Message-ID: <20210802160424.0000641b@Huawei.com>
In-Reply-To: <162767564242.3322476.16483313353240361673.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <162767561501.3322476.716972045397140827.stgit@dwillia2-desk3.amr.corp.intel.com>
        <162767564242.3322476.16483313353240361673.stgit@dwillia2-desk3.amr.corp.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.9.82]
X-ClientProxiedBy: lhreml743-chm.china.huawei.com (10.201.108.193) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 30 Jul 2021 13:07:22 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> In preparation for moving cxl_memdev allocation to the core, introduce
> cdevm_file_operations to coordinate file operations shutdown relative to
> driver data release.
> 
> The motivation for moving cxl_memdev allocation to the core (beyond
> better file organization of sysfs attributes in core/ and drivers in
> cxl/), is that device lifetime is longer than module lifetime. The cxl_pci
> module should be free to come and go without needing to coordinate with
> devices that need the text associated with cxl_memdev_release() to stay
> resident. The move will fix a use after free bug when looping driver
> load / unload with CONFIG_DEBUG_KOBJECT_RELEASE=y.
> 
> Another motivation for passing in file_operations to the core cxl_memdev
> creation flow is to allow for alternate drivers, like unit test code, to
> define their own ioctl backends.
> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Hi Dan / Ben,

One utterly trivial question inline, otherwise looks good.

> ---
>  drivers/cxl/mem.h |   15 ++++++++++++
>  drivers/cxl/pci.c |   65 +++++++++++++++++++++++++++++++----------------------
>  2 files changed, 53 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/cxl/mem.h b/drivers/cxl/mem.h
> index 8f02d02b26b4..77f4411c7c6a 100644
> --- a/drivers/cxl/mem.h
> +++ b/drivers/cxl/mem.h
> @@ -34,6 +34,21 @@
>   */
>  #define CXL_MEM_MAX_DEVS 65536
>  
> +/**
> + * struct cdevm_file_operations - devm coordinated cdev file operations
> + * @fops: typical file operations

Why typical? Seems that simply saying "file operations" conveys the same
information.  What is atypical here?

> + * @shutdown: disconnect driver data
> + *
> + * @shutdown is invoked in the devres release path to disconnect any
> + * driver instance data from @dev. It assumes synchronization with any
> + * fops operation that requires driver data. After @shutdown an
> + * operation may only reference @device data.
> + */
> +struct cdevm_file_operations {
> +	struct file_operations fops;
> +	void (*shutdown)(struct device *dev);
> +};
> +
>  /**
>   * struct cxl_memdev - CXL bus object representing a Type-3 Memory Device
>   * @dev: driver core device object
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 4cf351a3cf99..e20a643ee0c0 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -806,13 +806,30 @@ static int cxl_memdev_release_file(struct inode *inode, struct file *file)
>  	return 0;
>  }
>  
> -static const struct file_operations cxl_memdev_fops = {
> -	.owner = THIS_MODULE,
> -	.unlocked_ioctl = cxl_memdev_ioctl,
> -	.open = cxl_memdev_open,
> -	.release = cxl_memdev_release_file,
> -	.compat_ioctl = compat_ptr_ioctl,
> -	.llseek = noop_llseek,
> +static struct cxl_memdev *to_cxl_memdev(struct device *dev)
> +{
> +	return container_of(dev, struct cxl_memdev, dev);
> +}
> +
> +static void cxl_memdev_shutdown(struct device *dev)
> +{
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +
> +	down_write(&cxl_memdev_rwsem);
> +	cxlmd->cxlm = NULL;
> +	up_write(&cxl_memdev_rwsem);
> +}
> +
> +static const struct cdevm_file_operations cxl_memdev_fops = {
> +	.fops = {
> +		.owner = THIS_MODULE,
> +		.unlocked_ioctl = cxl_memdev_ioctl,
> +		.open = cxl_memdev_open,
> +		.release = cxl_memdev_release_file,
> +		.compat_ioctl = compat_ptr_ioctl,
> +		.llseek = noop_llseek,
> +	},
> +	.shutdown = cxl_memdev_shutdown,
>  };
>  
>  static inline struct cxl_mem_command *cxl_mem_find_command(u16 opcode)
> @@ -1161,11 +1178,6 @@ static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
>  	return ret;
>  }
>  
> -static struct cxl_memdev *to_cxl_memdev(struct device *dev)
> -{
> -	return container_of(dev, struct cxl_memdev, dev);
> -}
> -
>  static void cxl_memdev_release(struct device *dev)
>  {
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> @@ -1281,24 +1293,22 @@ static const struct device_type cxl_memdev_type = {
>  	.groups = cxl_memdev_attribute_groups,
>  };
>  
> -static void cxl_memdev_shutdown(struct cxl_memdev *cxlmd)
> -{
> -	down_write(&cxl_memdev_rwsem);
> -	cxlmd->cxlm = NULL;
> -	up_write(&cxl_memdev_rwsem);
> -}
> -
>  static void cxl_memdev_unregister(void *_cxlmd)
>  {
>  	struct cxl_memdev *cxlmd = _cxlmd;
>  	struct device *dev = &cxlmd->dev;
> +	struct cdev *cdev = &cxlmd->cdev;
> +	const struct cdevm_file_operations *cdevm_fops;
> +
> +	cdevm_fops = container_of(cdev->ops, typeof(*cdevm_fops), fops);
> +	cdevm_fops->shutdown(dev);
>  
>  	cdev_device_del(&cxlmd->cdev, dev);
> -	cxl_memdev_shutdown(cxlmd);
>  	put_device(dev);
>  }
>  
> -static struct cxl_memdev *cxl_memdev_alloc(struct cxl_mem *cxlm)
> +static struct cxl_memdev *cxl_memdev_alloc(struct cxl_mem *cxlm,
> +					   const struct file_operations *fops)
>  {
>  	struct pci_dev *pdev = cxlm->pdev;
>  	struct cxl_memdev *cxlmd;
> @@ -1324,7 +1334,7 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_mem *cxlm)
>  	device_set_pm_not_required(dev);
>  
>  	cdev = &cxlmd->cdev;
> -	cdev_init(cdev, &cxl_memdev_fops);
> +	cdev_init(cdev, fops);
>  	return cxlmd;
>  
>  err:
> @@ -1332,15 +1342,16 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_mem *cxlm)
>  	return ERR_PTR(rc);
>  }
>  
> -static struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
> -					      struct cxl_mem *cxlm)
> +static struct cxl_memdev *
> +devm_cxl_add_memdev(struct device *host, struct cxl_mem *cxlm,
> +		    const struct cdevm_file_operations *cdevm_fops)
>  {
>  	struct cxl_memdev *cxlmd;
>  	struct device *dev;
>  	struct cdev *cdev;
>  	int rc;
>  
> -	cxlmd = cxl_memdev_alloc(cxlm);
> +	cxlmd = cxl_memdev_alloc(cxlm, &cdevm_fops->fops);
>  	if (IS_ERR(cxlmd))
>  		return cxlmd;
>  
> @@ -1370,7 +1381,7 @@ static struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>  	 * The cdev was briefly live, shutdown any ioctl operations that
>  	 * saw that state.
>  	 */
> -	cxl_memdev_shutdown(cxlmd);
> +	cdevm_fops->shutdown(dev);
>  	put_device(dev);
>  	return ERR_PTR(rc);
>  }
> @@ -1611,7 +1622,7 @@ static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		return rc;
>  
> -	cxlmd = devm_cxl_add_memdev(&pdev->dev, cxlm);
> +	cxlmd = devm_cxl_add_memdev(&pdev->dev, cxlm, &cxl_memdev_fops);
>  	if (IS_ERR(cxlmd))
>  		return PTR_ERR(cxlmd);
>  
> 

