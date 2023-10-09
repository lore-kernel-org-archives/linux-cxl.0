Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06ED038BB6
	for <linux-cxl@vger.kernel.org>; Mon,  9 Oct 2023 16:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278B299
	for <linux-cxl@vger.kernel.org>; Mon,  9 Oct 2023 09:42:26 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S44XF0GBTz6K6Wv;
	Tue, 10 Oct 2023 00:40:29 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 9 Oct
 2023 17:42:23 +0100
Date: Mon, 9 Oct 2023 17:42:22 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH v3 06/10] cxl/pci: Fix sanitize notifier setup
Message-ID: <20231009174222.00006286@Huawei.com>
In-Reply-To: <169657719381.1491153.1571837747024067070.stgit@dwillia2-xfh.jf.intel.com>
References: <169657715790.1491153.3612164287133860191.stgit@dwillia2-xfh.jf.intel.com>
	<169657719381.1491153.1571837747024067070.stgit@dwillia2-xfh.jf.intel.com>
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

On Fri, 06 Oct 2023 00:26:33 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Fix a race condition between the mailbox-background command interrupt
> firing and the security-state sysfs attribute being removed.
> 
> The race is difficult to see due to the awkward placement of the
> sanitize-notifier setup code and the multiple places the teardown calls
> are made, cxl_memdev_security_init() and cxl_memdev_security_shutdown().
> 
> Unify setup in one place, cxl_sanitize_setup_notifier(). Arrange for
> the paired cxl_sanitize_teardown_notifier() to safely quiet the notifier
> and let the cxl_memdev + irq be unregistered later in the flow.
> 
> Note: The special wrinkle of the sanitize notifier is that it interacts
> with interrupts, which are enabled early in the flow, and it interacts
> with memdev sysfs which is not initialized until late in the flow. Hence
> why this setup routine takes an @cxlmd argument, and not just @mds.

Fair enough.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> 
> This fix is also needed as a preparation fix for a memdev unregistration
> crash.
> 
> Reported-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Closes: http://lore.kernel.org/r/20230929100316.00004546@Huawei.com
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Fixes: 0c36b6ad436a ("cxl/mbox: Add sanitization handling machinery")
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/core/memdev.c |   86 +++++++++++++++++++++++----------------------
>  drivers/cxl/cxlmem.h      |    2 +
>  drivers/cxl/pci.c         |    4 ++
>  3 files changed, 50 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 63353d990374..4c2e24a1a89c 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -556,20 +556,11 @@ void clear_exclusive_cxl_commands(struct cxl_memdev_state *mds,
>  }
>  EXPORT_SYMBOL_NS_GPL(clear_exclusive_cxl_commands, CXL);
>  
> -static void cxl_memdev_security_shutdown(struct device *dev)
> -{
> -	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> -	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> -
> -	cancel_delayed_work_sync(&mds->security.poll_dwork);
> -}
> -
>  static void cxl_memdev_shutdown(struct device *dev)
>  {
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>  
>  	down_write(&cxl_memdev_rwsem);
> -	cxl_memdev_security_shutdown(dev);
>  	cxlmd->cxlds = NULL;
>  	up_write(&cxl_memdev_rwsem);
>  }
> @@ -991,35 +982,6 @@ static const struct file_operations cxl_memdev_fops = {
>  	.llseek = noop_llseek,
>  };
>  
> -static void put_sanitize(void *data)
> -{
> -	struct cxl_memdev_state *mds = data;
> -
> -	sysfs_put(mds->security.sanitize_node);
> -}
> -
> -static int cxl_memdev_security_init(struct cxl_memdev *cxlmd)
> -{
> -	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> -	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> -	struct device *dev = &cxlmd->dev;
> -	struct kernfs_node *sec;
> -
> -	sec = sysfs_get_dirent(dev->kobj.sd, "security");
> -	if (!sec) {
> -		dev_err(dev, "sysfs_get_dirent 'security' failed\n");
> -		return -ENODEV;
> -	}
> -	mds->security.sanitize_node = sysfs_get_dirent(sec, "state");
> -	sysfs_put(sec);
> -	if (!mds->security.sanitize_node) {
> -		dev_err(dev, "sysfs_get_dirent 'state' failed\n");
> -		return -ENODEV;
> -	}
> -
> -	return devm_add_action_or_reset(cxlds->dev, put_sanitize, mds);
> -}
> -
>  struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>  				       struct cxl_dev_state *cxlds)
>  {
> @@ -1049,10 +1011,6 @@ struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>  	if (rc)
>  		goto err;
>  
> -	rc = cxl_memdev_security_init(cxlmd);
> -	if (rc)
> -		goto err;
> -
>  	rc = devm_add_action_or_reset(host, cxl_memdev_unregister, cxlmd);
>  	if (rc)
>  		return ERR_PTR(rc);
> @@ -1069,6 +1027,50 @@ struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>  }
>  EXPORT_SYMBOL_NS_GPL(devm_cxl_add_memdev, CXL);
>  
> +static void sanitize_teardown_notifier(void *data)
> +{
> +	struct cxl_memdev_state *mds = data;
> +	struct kernfs_node *state;
> +
> +	/*
> +	 * Prevent new irq triggered invocations of the workqueue and
> +	 * flush inflight invocations.
> +	 */
> +	mutex_lock(&mds->mbox_mutex);
> +	state = mds->security.sanitize_node;
> +	mds->security.sanitize_node = NULL;
> +	mutex_unlock(&mds->mbox_mutex);
> +
> +	cancel_delayed_work_sync(&mds->security.poll_dwork);
> +	sysfs_put(state);
> +}
> +
> +int devm_cxl_sanitize_setup_notifier(struct device *host,
> +				     struct cxl_memdev *cxlmd)
> +{
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> +	struct kernfs_node *sec;
> +
> +	if (!test_bit(CXL_SEC_ENABLED_SANITIZE, mds->security.enabled_cmds))
> +		return 0;
> +
> +	/*
> +	 * Note, the expectation is that @cxlmd would have failed to be
> +	 * created if these sysfs_get_dirent calls fail.
> +	 */
> +	sec = sysfs_get_dirent(cxlmd->dev.kobj.sd, "security");
> +	if (!sec)
> +		return -ENOENT;
> +	mds->security.sanitize_node = sysfs_get_dirent(sec, "state");
> +	sysfs_put(sec);
> +	if (!mds->security.sanitize_node)
> +		return -ENOENT;
> +
> +	return devm_add_action_or_reset(host, sanitize_teardown_notifier, mds);
> +}
> +EXPORT_SYMBOL_NS_GPL(devm_cxl_sanitize_setup_notifier, CXL);
> +
>  __init int cxl_memdev_init(void)
>  {
>  	dev_t devt;
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index fdb2c8dd98d0..fbdee1d63717 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -86,6 +86,8 @@ static inline bool is_cxl_endpoint(struct cxl_port *port)
>  
>  struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>  				       struct cxl_dev_state *cxlds);
> +int devm_cxl_sanitize_setup_notifier(struct device *host,
> +				     struct cxl_memdev *cxlmd);
>  struct cxl_memdev_state;
>  int devm_cxl_setup_fw_upload(struct device *host, struct cxl_memdev_state *mds);
>  int devm_cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 7c117eb62750..9955871e9ec1 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -875,6 +875,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		return rc;
>  
> +	rc = devm_cxl_sanitize_setup_notifier(&pdev->dev, cxlmd);
> +	if (rc)
> +		return rc;
> +
>  	pmu_count = cxl_count_regblock(pdev, CXL_REGLOC_RBI_PMU);
>  	for (i = 0; i < pmu_count; i++) {
>  		struct cxl_pmu_regs pmu_regs;
> 
> 

