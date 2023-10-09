Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081A438BC5
	for <linux-cxl@vger.kernel.org>; Mon,  9 Oct 2023 16:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060A4BA
	for <linux-cxl@vger.kernel.org>; Mon,  9 Oct 2023 09:38:22 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S44QL701jz6D8XN;
	Tue, 10 Oct 2023 00:35:22 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 9 Oct
 2023 17:38:20 +0100
Date: Mon, 9 Oct 2023 17:38:19 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v3 04/10] cxl/pci: Remove inconsistent usage of
 dev_err_probe()
Message-ID: <20231009173819.00004d76@Huawei.com>
In-Reply-To: <169657718224.1491153.11083952431204965077.stgit@dwillia2-xfh.jf.intel.com>
References: <169657715790.1491153.3612164287133860191.stgit@dwillia2-xfh.jf.intel.com>
	<169657718224.1491153.11083952431204965077.stgit@dwillia2-xfh.jf.intel.com>
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

On Fri, 06 Oct 2023 00:26:22 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> If dev_err_probe() is to be used it should at least be used consistently
> within the same function. It is also worth questioning whether
> every potential -ENOMEM needs an explicit error message.
> 
> Remove the cxl_setup_fw_upload() error prints for what are rare /
> hardware-independent failures.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Vanishingly unlikely this would ever fail under anything approach
a normal situation, so fair enough to drop the error message.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/cxl/core/memdev.c |   13 ++-----------
>  1 file changed, 2 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 2a7a07f6d165..6efe4e2a2cf5 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -970,7 +970,6 @@ int cxl_memdev_setup_fw_upload(struct cxl_memdev_state *mds)
>  	struct cxl_dev_state *cxlds = &mds->cxlds;
>  	struct device *dev = &cxlds->cxlmd->dev;
>  	struct fw_upload *fwl;
> -	int rc;
>  
>  	if (!test_bit(CXL_MEM_COMMAND_ID_GET_FW_INFO, mds->enabled_cmds))
>  		return 0;
> @@ -978,17 +977,9 @@ int cxl_memdev_setup_fw_upload(struct cxl_memdev_state *mds)
>  	fwl = firmware_upload_register(THIS_MODULE, dev, dev_name(dev),
>  				       &cxl_memdev_fw_ops, mds);
>  	if (IS_ERR(fwl))
> -		return dev_err_probe(dev, PTR_ERR(fwl),
> -				     "Failed to register firmware loader\n");
> -
> -	rc = devm_add_action_or_reset(cxlds->dev, devm_cxl_remove_fw_upload,
> -				      fwl);
> -	if (rc)
> -		dev_err(dev,
> -			"Failed to add firmware loader remove action: %d\n",
> -			rc);
> +		return PTR_ERR(fwl);
>  
> -	return rc;
> +	return devm_add_action_or_reset(cxlds->dev, devm_cxl_remove_fw_upload, fwl);
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_memdev_setup_fw_upload, CXL);
>  
> 
> 

