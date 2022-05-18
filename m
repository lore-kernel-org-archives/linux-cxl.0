Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32005C433EF
	for <linux-cxl@archiver.kernel.org>; Wed, 18 May 2022 17:22:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240871AbiERRWS (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 18 May 2022 13:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240847AbiERRWS (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 18 May 2022 13:22:18 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16231A0D10
        for <linux-cxl@vger.kernel.org>; Wed, 18 May 2022 10:22:17 -0700 (PDT)
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4L3KTr1J5qz6H78H;
        Thu, 19 May 2022 01:19:12 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 18 May 2022 19:22:14 +0200
Received: from localhost (10.202.226.42) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 18 May
 2022 18:22:14 +0100
Date:   Wed, 18 May 2022 18:22:13 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <ben.widawsky@intel.com>,
        <ira.weiny@intel.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>
Subject: Re: [PATCH 02/14] cxl/pci: Consolidate wait_for_media() and
 wait_for_media_ready()
Message-ID: <20220518182213.0000458a@Huawei.com>
In-Reply-To: <165237926697.3832067.1507642241143366624.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <165237925642.3832067.15995008431029494571.stgit@dwillia2-desk3.amr.corp.intel.com>
        <165237926697.3832067.1507642241143366624.stgit@dwillia2-desk3.amr.corp.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhreml753-chm.china.huawei.com (10.201.108.203) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 12 May 2022 11:14:27 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Now that wait_for_media() does nothing supplemental to
> wait_for_media_ready() just promote wait_for_media_ready() to a common
> helper and drop wait_for_media().
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/mem.c |   19 +------------------
>  drivers/cxl/pci.c |    4 ++--
>  2 files changed, 3 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index c2d9dadf4a2e..7622cfefa1b0 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -24,23 +24,6 @@
>   * in higher level operations.
>   */
>  
> -static int wait_for_media(struct cxl_memdev *cxlmd)
> -{
> -	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> -	int rc;
> -
> -	rc = cxlds->wait_media_ready(cxlds);
> -	if (rc)
> -		return rc;
> -
> -	/*
> -	 * We know the device is active, and enabled, if any ranges are non-zero
> -	 * we'll need to check later before adding the port since that owns the
> -	 * HDM decoder registers.
> -	 */
> -	return 0;
> -}
> -
>  static int create_endpoint(struct cxl_memdev *cxlmd,
>  			   struct cxl_port *parent_port)
>  {
> @@ -157,7 +140,7 @@ static int cxl_mem_probe(struct device *dev)
>  	if (work_pending(&cxlmd->detach_work))
>  		return -EBUSY;
>  
> -	rc = wait_for_media(cxlmd);
> +	rc = cxlds->wait_media_ready(cxlds);
>  	if (rc) {
>  		dev_err(dev, "Media not active (%d)\n", rc);
>  		return rc;
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index e7ab9a34d718..435f9f89b793 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -423,7 +423,7 @@ static int wait_for_valid(struct cxl_dev_state *cxlds)
>   * Wait up to @mbox_ready_timeout for the device to report memory
>   * active.
>   */
> -static int wait_for_media_ready(struct cxl_dev_state *cxlds)
> +static int cxl_await_media_ready(struct cxl_dev_state *cxlds)
>  {
>  	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
>  	int d = cxlds->cxl_dvsec;
> @@ -593,7 +593,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  		dev_warn(&pdev->dev,
>  			 "Device DVSEC not present, skip CXL.mem init\n");
>  
> -	cxlds->wait_media_ready = wait_for_media_ready;
> +	cxlds->wait_media_ready = cxl_await_media_ready;
>  
>  	rc = cxl_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
>  	if (rc)
> 

