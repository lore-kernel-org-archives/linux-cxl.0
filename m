Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 663D5E7849A
	for <linux-cxl@archiver.kernel.org>; Mon,  2 Oct 2023 09:55:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236215AbjJBJzY (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 2 Oct 2023 05:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236112AbjJBJzX (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 2 Oct 2023 05:55:23 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6FB8E
        for <linux-cxl@vger.kernel.org>; Mon,  2 Oct 2023 02:55:19 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Rzbsn1fGmz67L0F;
        Mon,  2 Oct 2023 17:55:09 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 2 Oct
 2023 10:55:15 +0100
Date:   Mon, 2 Oct 2023 10:55:14 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <ira.weiny@intel.com>
Subject: Re: [PATCH v2 1/4] cxl/pci: Remove unnecessary device reference
 management in sanitize work
Message-ID: <20231002105514.00006e8e@Huawei.com>
In-Reply-To: <169602897366.904193.9449207727775648546.stgit@dwillia2-xfh.jf.intel.com>
References: <169602896768.904193.11292185494339980455.stgit@dwillia2-xfh.jf.intel.com>
        <169602897366.904193.9449207727775648546.stgit@dwillia2-xfh.jf.intel.com>
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

On Fri, 29 Sep 2023 16:09:33 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Given that any particular put_device() could be the final put of the
> device, the fact that there are usages of cxlds->dev after
> put_device(cxlds->dev) is a red flag. Drop the reference counting since
> the device is pinned by being registered and will not be unregistered
> without triggering the driver + workqueue to shutdown.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Makes sense

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/pci.c |    5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 44a21ab7add5..aa1b3dd9e64c 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -152,8 +152,6 @@ static void cxl_mbox_sanitize_work(struct work_struct *work)
>  	mutex_lock(&mds->mbox_mutex);
>  	if (cxl_mbox_background_complete(cxlds)) {
>  		mds->security.poll_tmo_secs = 0;
> -		put_device(cxlds->dev);
> -
>  		if (mds->security.sanitize_node)
>  			sysfs_notify_dirent(mds->security.sanitize_node);
>  
> @@ -296,9 +294,6 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_memdev_state *mds,
>  		 */
>  		if (mbox_cmd->opcode == CXL_MBOX_OP_SANITIZE) {
>  			if (mds->security.poll) {
> -				/* hold the device throughout */
> -				get_device(cxlds->dev);
> -
>  				/* give first timeout a second */
>  				timeout = 1;
>  				mds->security.poll_tmo_secs = timeout;
> 

