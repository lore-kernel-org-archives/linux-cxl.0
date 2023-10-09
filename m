Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952DD38BC5
	for <linux-cxl@vger.kernel.org>; Mon,  9 Oct 2023 16:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D81DAF
	for <linux-cxl@vger.kernel.org>; Mon,  9 Oct 2023 09:41:26 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S44Tr4NYZz685Td;
	Tue, 10 Oct 2023 00:38:24 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 9 Oct
 2023 17:41:22 +0100
Date: Mon, 9 Oct 2023 17:41:21 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v3 05/10] cxl/pci: Clarify devm host for memdev relative
 setup
Message-ID: <20231009174121.000011a0@Huawei.com>
In-Reply-To: <169657718805.1491153.2457900463470349092.stgit@dwillia2-xfh.jf.intel.com>
References: <169657715790.1491153.3612164287133860191.stgit@dwillia2-xfh.jf.intel.com>
	<169657718805.1491153.2457900463470349092.stgit@dwillia2-xfh.jf.intel.com>
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
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 06 Oct 2023 00:26:28 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> It is all too easy to get confused about @dev usage in the CXL driver
> stack. Before adding a new cxl_pci_probe() setup operation that has a
> devm lifetime dependent on @cxlds->dev binding, but also references
> @cxlmd->dev, and prints messages, rework the devm_cxl_add_memdev() and
> cxl_memdev_setup_fw_upload() function signatures to make this
> distinction explicit. I.e. pass in the devm context as an @host argument
> rather than infer it from other objects.
> 
> This is in preparation for adding a devm_cxl_sanitize_setup_notifier().
> 
> Note the whitespace fixup near the change of the devm_cxl_add_memdev()
> signature. That uncaught typo originated in the patch that added
> cxl_memdev_security_init().
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Definitely an improvement in readability. Nice.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/memdev.c    |   16 ++++++++--------
>  drivers/cxl/cxlmem.h         |    5 +++--
>  drivers/cxl/pci.c            |    4 ++--
>  tools/testing/cxl/test/mem.c |    4 ++--
>  4 files changed, 15 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 6efe4e2a2cf5..63353d990374 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -960,12 +960,12 @@ static const struct fw_upload_ops cxl_memdev_fw_ops = {
>          .cleanup = cxl_fw_cleanup,
>  };
>  
> -static void devm_cxl_remove_fw_upload(void *fwl)
> +static void cxl_remove_fw_upload(void *fwl)
>  {
>  	firmware_upload_unregister(fwl);
>  }
>  
> -int cxl_memdev_setup_fw_upload(struct cxl_memdev_state *mds)
> +int devm_cxl_setup_fw_upload(struct device *host, struct cxl_memdev_state *mds)
>  {
>  	struct cxl_dev_state *cxlds = &mds->cxlds;
>  	struct device *dev = &cxlds->cxlmd->dev;
> @@ -978,10 +978,9 @@ int cxl_memdev_setup_fw_upload(struct cxl_memdev_state *mds)
>  				       &cxl_memdev_fw_ops, mds);
>  	if (IS_ERR(fwl))
>  		return PTR_ERR(fwl);
> -
> -	return devm_add_action_or_reset(cxlds->dev, devm_cxl_remove_fw_upload, fwl);
> +	return devm_add_action_or_reset(host, cxl_remove_fw_upload, fwl);
>  }
> -EXPORT_SYMBOL_NS_GPL(cxl_memdev_setup_fw_upload, CXL);
> +EXPORT_SYMBOL_NS_GPL(devm_cxl_setup_fw_upload, CXL);
>  
>  static const struct file_operations cxl_memdev_fops = {
>  	.owner = THIS_MODULE,
> @@ -1019,9 +1018,10 @@ static int cxl_memdev_security_init(struct cxl_memdev *cxlmd)
>  	}
>  
>  	return devm_add_action_or_reset(cxlds->dev, put_sanitize, mds);
> - }
> +}
>  
> -struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
> +struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
> +				       struct cxl_dev_state *cxlds)
>  {
>  	struct cxl_memdev *cxlmd;
>  	struct device *dev;
> @@ -1053,7 +1053,7 @@ struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
>  	if (rc)
>  		goto err;
>  
> -	rc = devm_add_action_or_reset(cxlds->dev, cxl_memdev_unregister, cxlmd);
> +	rc = devm_add_action_or_reset(host, cxl_memdev_unregister, cxlmd);
>  	if (rc)
>  		return ERR_PTR(rc);
>  	return cxlmd;
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 55f00ad17a77..fdb2c8dd98d0 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -84,9 +84,10 @@ static inline bool is_cxl_endpoint(struct cxl_port *port)
>  	return is_cxl_memdev(port->uport_dev);
>  }
>  
> -struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds);
> +struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
> +				       struct cxl_dev_state *cxlds);
>  struct cxl_memdev_state;
> -int cxl_memdev_setup_fw_upload(struct cxl_memdev_state *mds);
> +int devm_cxl_setup_fw_upload(struct device *host, struct cxl_memdev_state *mds);
>  int devm_cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>  			 resource_size_t base, resource_size_t len,
>  			 resource_size_t skipped);
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index dc665b12be8f..7c117eb62750 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -867,11 +867,11 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		return rc;
>  
> -	cxlmd = devm_cxl_add_memdev(cxlds);
> +	cxlmd = devm_cxl_add_memdev(&pdev->dev, cxlds);
>  	if (IS_ERR(cxlmd))
>  		return PTR_ERR(cxlmd);
>  
> -	rc = cxl_memdev_setup_fw_upload(mds);
> +	rc = devm_cxl_setup_fw_upload(&pdev->dev, mds);
>  	if (rc)
>  		return rc;
>  
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index 464fc39ed277..68118c37f0b5 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -1450,11 +1450,11 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
>  	mdata->mes.mds = mds;
>  	cxl_mock_add_event_logs(&mdata->mes);
>  
> -	cxlmd = devm_cxl_add_memdev(cxlds);
> +	cxlmd = devm_cxl_add_memdev(&pdev->dev, cxlds);
>  	if (IS_ERR(cxlmd))
>  		return PTR_ERR(cxlmd);
>  
> -	rc = cxl_memdev_setup_fw_upload(mds);
> +	rc = devm_cxl_setup_fw_upload(&pdev->dev, mds);
>  	if (rc)
>  		return rc;
>  
> 
> 

