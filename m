Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D62C77B75
	for <linux-cxl@archiver.kernel.org>; Mon, 15 May 2023 12:54:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241455AbjEOMyB (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 15 May 2023 08:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238913AbjEOMyA (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 15 May 2023 08:54:00 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFBB199F
        for <linux-cxl@vger.kernel.org>; Mon, 15 May 2023 05:53:59 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QKfRd036Xz67Lff;
        Mon, 15 May 2023 20:53:00 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 15 May
 2023 13:53:57 +0100
Date:   Mon, 15 May 2023 13:53:56 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     <dan.j.williams@intel.com>, <fan.ni@samsung.com>,
        <a.manzanares@samsung.com>, <dave.jiang@intel.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 5/5] cxl/type3: Remove superfluous statements
Message-ID: <20230515135356.00004784@Huawei.com>
In-Reply-To: <20230418172337.19207-6-dave@stgolabs.net>
References: <20230418172337.19207-1-dave@stgolabs.net>
        <20230418172337.19207-6-dave@stgolabs.net>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 18 Apr 2023 10:23:37 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> Simple cleanup while going through the code, remove the
> bogus return statements from end of void returning
> functions.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

LGTM
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

I'll pick up this version if its the appropriate one when
I next update my qemu tree.  Might make minimal tweaks as per
feedback if I remember to do so. I'll let you know if I do
anything more significant.

Thanks,

Jonathan

> ---
>  hw/mem/cxl_type3.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 707bdc263f03..415a8c8a3973 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -864,7 +864,6 @@ err_address_space_free:
>      if (ct3d->hostvmem) {
>          address_space_destroy(&ct3d->hostvmem_as);
>      }
> -    return;
>  }
>  
>  static void ct3_exit(PCIDevice *pci_dev)
> @@ -1290,8 +1289,6 @@ void qmp_cxl_inject_uncorrectable_errors(const char *path,
>  
>      stl_le_p(reg_state + R_CXL_RAS_UNC_ERR_STATUS, unc_err);
>      pcie_aer_inject_error(PCI_DEVICE(obj), &err);
> -
> -    return;
>  }
>  
>  void qmp_cxl_inject_correctable_error(const char *path, CxlCorErrorType type,
> @@ -1564,7 +1561,6 @@ void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log, uint8_t flags,
>      if (cxl_event_insert(cxlds, enc_log, (CXLEventRecordRaw *)&dram)) {
>          cxl_event_irq_assert(ct3d);
>      }
> -    return;
>  }
>  
>  void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,

