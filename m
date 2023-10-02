Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89ECBE7849A
	for <linux-cxl@archiver.kernel.org>; Mon,  2 Oct 2023 10:10:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbjJBKKz (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 2 Oct 2023 06:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjJBKKz (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 2 Oct 2023 06:10:55 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7305FBD
        for <linux-cxl@vger.kernel.org>; Mon,  2 Oct 2023 03:10:50 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Rzc8p5F2vz6HJcT;
        Mon,  2 Oct 2023 18:08:10 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 2 Oct
 2023 11:10:47 +0100
Date:   Mon, 2 Oct 2023 11:10:46 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>,
        "Davidlohr Bueso" <dave@stgolabs.net>, <ira.weiny@intel.com>
Subject: Re: [PATCH v2 3/4] cxl/pci: Fix sanitize notifier setup
Message-ID: <20231002111046.00000f9e@Huawei.com>
In-Reply-To: <169602898447.904193.4454973423100628922.stgit@dwillia2-xfh.jf.intel.com>
References: <169602896768.904193.11292185494339980455.stgit@dwillia2-xfh.jf.intel.com>
        <169602898447.904193.4454973423100628922.stgit@dwillia2-xfh.jf.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 29 Sep 2023 16:09:44 -0700
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
> This fix is also needed as a preparation fix for a memdev unregistration
> crash.
> 
> Reported-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Fixes: 0c36b6ad436a ("cxl/mbox: Add sanitization handling machinery")
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

One trivial question inline about which parameter to pass in from the
many many interlocking state structures...

If you do make the suggested change, it's just complex enough I want another
look so I'm not giving a tag for now.

> ---
>  drivers/cxl/core/memdev.c |   42 ----------------------------------------
>  drivers/cxl/pci.c         |   47 +++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 47 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 2a7a07f6d165..a950091e5640 100644
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
> @@ -1001,35 +992,6 @@ static const struct file_operations cxl_memdev_fops = {
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
> - }
> -
>  struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
>  {
>  	struct cxl_memdev *cxlmd;
> @@ -1058,10 +1020,6 @@ struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
>  	if (rc)
>  		goto err;
>  
> -	rc = cxl_memdev_security_init(cxlmd);
> -	if (rc)
> -		goto err;
> -
>  	rc = devm_add_action_or_reset(cxlds->dev, cxl_memdev_unregister, cxlmd);
>  	if (rc)
>  		return ERR_PTR(rc);
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index ac4e434b0806..b0023e479315 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -165,6 +165,49 @@ static void cxl_mbox_sanitize_work(struct work_struct *work)
>  	mutex_unlock(&mds->mbox_mutex);
>  }
>  
> +static void cxl_sanitize_teardown_notifier(void *data)
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
> +static int cxl_sanitize_setup_notifier(struct cxl_memdev *cxlmd)
> +{

Almost everything in cxl_pci_probe() passes in the mds.
Why not do the same here?

 
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> +	struct device *dev = cxlds->dev;
> +	struct kernfs_node *sec;
> +
> +	if (!test_bit(CXL_SEC_ENABLED_SANITIZE, mds->security.enabled_cmds))
> +		return 0;
> +
> +	sec = sysfs_get_dirent(dev->kobj.sd, "security");
> +	if (!sec) {
> +		dev_err(dev, "sanitize notification setup failure\n");
> +		return -ENOENT;
> +	}
> +	mds->security.sanitize_node = sysfs_get_dirent(sec, "state");
> +	sysfs_put(sec);
> +	if (!mds->security.sanitize_node) {
> +		dev_err(dev, "sanitize notification setup failure\n");
> +		return -ENOENT;
> +	}
> +
> +	return devm_add_action_or_reset(dev, cxl_sanitize_teardown_notifier, mds);
> +}
> +
>  /**
>   * __cxl_pci_mbox_send_cmd() - Execute a mailbox command
>   * @mds: The memory device driver data
> @@ -875,6 +918,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		return rc;
>  
> +	rc = cxl_sanitize_setup_notifier(cxlmd);
> +	if (rc)
> +		return rc;
> +
>  	pmu_count = cxl_count_regblock(pdev, CXL_REGLOC_RBI_PMU);
>  	for (i = 0; i < pmu_count; i++) {
>  		struct cxl_pmu_regs pmu_regs;
> 

