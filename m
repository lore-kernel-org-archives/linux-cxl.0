Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DFFCC4321E
	for <linux-cxl@archiver.kernel.org>; Fri,  2 Dec 2022 17:00:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234231AbiLBRAR (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 2 Dec 2022 12:00:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234228AbiLBQ7d (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 2 Dec 2022 11:59:33 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0258EDA7F5
        for <linux-cxl@vger.kernel.org>; Fri,  2 Dec 2022 08:59:10 -0800 (PST)
Received: from frapeml500007.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NNzbf0NWTz67dBN;
        Sat,  3 Dec 2022 00:55:58 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 2 Dec 2022 17:59:07 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 2 Dec
 2022 16:59:07 +0000
Date:   Fri, 2 Dec 2022 16:59:06 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Robert Richter <rrichter@amd.com>
Subject: Re: [PATCH] tools/testing/cxl: Add bridge mocking support
Message-ID: <20221202165906.000041ce@Huawei.com>
In-Reply-To: <166845667383.1449826.14492184009399164787.stgit@dwillia2-xfh.jf.intel.com>
References: <20221018132341.76259-6-rrichter@amd.com>
        <166845667383.1449826.14492184009399164787.stgit@dwillia2-xfh.jf.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 14 Nov 2022 12:11:13 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> In preparation for cxl_acpi walking pci_root->bus->bridge, add that
> association to the mock pci_root instances.
> 
> Note that the missing 3rd entry in mock_pci_root[] was not noticed until
> now given that the test version of to_cxl_host_bridge()
> (tools/testing/cxl/mock_acpi.c), obviated the need for that entry.
> However, "cxl/acpi: Improve debug messages in cxl_acpi_probe()" [1]
> needs pci_root->bus->bridge to be populated.
> 
> Link: https://lore.kernel.org/r/20221018132341.76259-6-rrichter@amd.com [1]
> Cc: Robert Richter <rrichter@amd.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  tools/testing/cxl/test/cxl.c |   10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index a5146d80ecc4..facfcd11cb67 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -439,14 +439,18 @@ mock_acpi_evaluate_integer(acpi_handle handle, acpi_string pathname,
>  	return AE_OK;
>  }
>  
> -static struct pci_bus mock_pci_bus[NR_CXL_HOST_BRIDGES];
> -static struct acpi_pci_root mock_pci_root[NR_CXL_HOST_BRIDGES] = {
> +static struct pci_bus mock_pci_bus[NR_CXL_HOST_BRIDGES + NR_CXL_SINGLE_HOST];
> +static struct acpi_pci_root mock_pci_root[ARRAY_SIZE(mock_pci_bus)] = {
>  	[0] = {
>  		.bus = &mock_pci_bus[0],
>  	},
>  	[1] = {
>  		.bus = &mock_pci_bus[1],
>  	},
> +	[2] = {
> +		.bus = &mock_pci_bus[2],
> +	},
> +
Ahah. Here's the stray space that gets cleaned up in the RCH series.  Guessing you
don't want to rebase to fix it here? 

>  };
