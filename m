Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3600C4332F
	for <linux-cxl@archiver.kernel.org>; Tue, 18 Oct 2022 13:44:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbiJRNn7 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 18 Oct 2022 09:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbiJRNn6 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 18 Oct 2022 09:43:58 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6307BCC82E
        for <linux-cxl@vger.kernel.org>; Tue, 18 Oct 2022 06:43:57 -0700 (PDT)
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MsFQq6tNlz688hK;
        Tue, 18 Oct 2022 21:42:11 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Tue, 18 Oct 2022 15:43:54 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 18 Oct
 2022 14:43:54 +0100
Date:   Tue, 18 Oct 2022 14:43:53 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <shiju.jose@huawei.com>,
        <rrichter@amd.com>
Subject: Re: [PATCH RFC v2 3/9] cxl/pci: Kill cxl_map_regs()
Message-ID: <20221018144353.00003339@huawei.com>
In-Reply-To: <166336987163.3803215.16274917380401720231.stgit@djiang5-desk3.ch.intel.com>
References: <166336972295.3803215.1047199449525031921.stgit@djiang5-desk3.ch.intel.com>
        <166336987163.3803215.16274917380401720231.stgit@djiang5-desk3.ch.intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 16 Sep 2022 16:11:11 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> From: Dan Williams <dan.j.williams@intel.com>
> 
> The component registers are currently unused by the cxl_pci driver.
> Only the physical address base of the component registers is conveyed to
> the cxl_mem driver. Just call cxl_map_device_registers() directly.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

These first 3 impact the CPMU driver code. So I'd very much like
to have these at least upstream asap even if the rest takes a while
to follow.

Thanks,

Jonathan


> ---
>  drivers/cxl/pci.c |   23 +----------------------
>  1 file changed, 1 insertion(+), 22 deletions(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index faeb5d9d7a7a..82023cf0cdcf 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -347,27 +347,6 @@ static int cxl_probe_regs(struct pci_dev *pdev, struct cxl_register_map *map)
>  	return 0;
>  }
>  
> -static int cxl_map_regs(struct cxl_dev_state *cxlds, struct cxl_register_map *map)
> -{
> -	struct device *dev = cxlds->dev;
> -	struct pci_dev *pdev = to_pci_dev(dev);
> -
> -	switch (map->reg_type) {
> -	case CXL_REGLOC_RBI_COMPONENT:
> -		cxl_map_component_regs(pdev, &cxlds->regs.component, map);
> -		dev_dbg(dev, "Mapping component registers...\n");
> -		break;
> -	case CXL_REGLOC_RBI_MEMDEV:
> -		cxl_map_device_regs(pdev, &cxlds->regs.device_regs, map);
> -		dev_dbg(dev, "Probing device registers...\n");
> -		break;
> -	default:
> -		break;
> -	}
> -
> -	return 0;
> -}
> -
>  static int cxl_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>  			  struct cxl_register_map *map)
>  {
> @@ -461,7 +440,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		return rc;
>  
> -	rc = cxl_map_regs(cxlds, &map);
> +	rc = cxl_map_device_regs(pdev, &cxlds->regs.device_regs, &map);
>  	if (rc)
>  		return rc;
>  
> 
> 

