Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F03C4167B
	for <linux-cxl@archiver.kernel.org>; Mon, 19 Dec 2022 17:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbiLSRfR (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 19 Dec 2022 12:35:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbiLSRfQ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 19 Dec 2022 12:35:16 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE800DEE7
        for <linux-cxl@vger.kernel.org>; Mon, 19 Dec 2022 09:35:14 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NbRdS0PxSz6H6jV;
        Tue, 20 Dec 2022 01:33:48 +0800 (CST)
Received: from localhost (10.81.210.222) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 19 Dec
 2022 17:35:11 +0000
Date:   Mon, 19 Dec 2022 17:35:10 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>, <rrichter@amd.com>,
        <terry.bowman@amd.com>
Subject: Re: [RFC PATCH 7/8] cxl: suppress component register discovery
 failure warning for RCD
Message-ID: <20221219173510.000003ed@Huawei.com>
In-Reply-To: <166984997536.2805382.16376618769262720267.stgit@djiang5-desk3.ch.intel.com>
References: <166984987659.2805382.17264896576424996856.stgit@djiang5-desk3.ch.intel.com>
        <166984997536.2805382.16376618769262720267.stgit@djiang5-desk3.ch.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.210.222]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 30 Nov 2022 16:12:55 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> For an RCD, it is expected that component register won't be discovered by
> cxl_pci. Suppress warning if RCD.

I've lost track a bit on where this ended up in the RCD series
but from a spec point of view 8.2.2 in CXL 3.0 makes it clear
that it's fine for component registers to be in a BAR and hence
the register block locator.  Hence does the "expected" want relaxing
to an "allowed" or even "likely".  Expected kind of implies the
opposite isn't expected.

> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/pci.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 73ff6c33a0c0..d808da838909 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -486,7 +486,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	 */
>  	cxlds->component_reg_phys = CXL_RESOURCE_NONE;
>  	rc = cxl_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
> -	if (rc)
> +	if (rc && !cxlds->rcd)
>  		dev_warn(&pdev->dev, "No component registers (%d)\n", rc);
>  
>  	cxlds->component_reg_phys = cxl_regmap_to_base(pdev, &map);
> 
> 

