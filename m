Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF88C3A5A7
	for <linux-cxl@archiver.kernel.org>; Thu,  8 Dec 2022 11:00:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbiLHLAF (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 8 Dec 2022 06:00:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbiLHK7l (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 8 Dec 2022 05:59:41 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE5C92FD9
        for <linux-cxl@vger.kernel.org>; Thu,  8 Dec 2022 02:52:08 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NSW9d4dvgz6J7SM;
        Thu,  8 Dec 2022 18:49:09 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 8 Dec
 2022 10:52:05 +0000
Date:   Thu, 8 Dec 2022 10:52:04 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>,
        <ira.weiny@intel.com>
Subject: Re: [PATCH 1/4] cxl/security: Fix Get Security State output payload
 endian handling
Message-ID: <20221208105204.00004c63@Huawei.com>
In-Reply-To: <167030054822.4044561.4917796262037689553.stgit@dwillia2-xfh.jf.intel.com>
References: <167030054261.4044561.2164047490200738083.stgit@dwillia2-xfh.jf.intel.com>
        <167030054822.4044561.4917796262037689553.stgit@dwillia2-xfh.jf.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 05 Dec 2022 20:22:28 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> Multi-byte integer values in CXL mailbox payloads are little endian. Add
> a definition of the Get Security State output payload and convert the
> value before testing flags.
> 
> Fixes: 328281155539 ("cxl/pmem: Introduce nvdimm_security_ops with ->get_flags() operation")
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Ah. Missed this one. Good catch.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


> ---
>  drivers/cxl/security.c |    6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/security.c b/drivers/cxl/security.c
> index 5484d4eecfd1..ebb78b8944f5 100644
> --- a/drivers/cxl/security.c
> +++ b/drivers/cxl/security.c
> @@ -16,14 +16,18 @@ static unsigned long cxl_pmem_get_security_flags(struct nvdimm *nvdimm,
>  	struct cxl_memdev *cxlmd = cxl_nvd->cxlmd;
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  	unsigned long security_flags = 0;
> +	struct cxl_get_security_output {
> +		__le32 flags;
> +	} out;
>  	u32 sec_out;
>  	int rc;
>  
>  	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_GET_SECURITY_STATE, NULL, 0,
> -			       &sec_out, sizeof(sec_out));
> +			       &out, sizeof(out));
>  	if (rc < 0)
>  		return 0;
>  
> +	sec_out = le32_to_cpu(out.flags);
>  	if (ptype == NVDIMM_MASTER) {
>  		if (sec_out & CXL_PMEM_SEC_STATE_MASTER_PASS_SET)
>  			set_bit(NVDIMM_SECURITY_UNLOCKED, &security_flags);
> 

