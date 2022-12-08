Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A3BDC3A5A7
	for <linux-cxl@archiver.kernel.org>; Thu,  8 Dec 2022 11:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbiLHLFz (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 8 Dec 2022 06:05:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbiLHLDj (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 8 Dec 2022 06:03:39 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79563C38
        for <linux-cxl@vger.kernel.org>; Thu,  8 Dec 2022 03:01:55 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NSWRN6Z1dz67GrG;
        Thu,  8 Dec 2022 19:01:04 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 8 Dec
 2022 11:01:53 +0000
Date:   Thu, 8 Dec 2022 11:01:52 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <dave.jiang@intel.com>,
        <ira.weiny@intel.com>
Subject: Re: [PATCH 2/4] cxl/mbox: Enable cxl_mbox_send_cmd() users to
 validate output size
Message-ID: <20221208110152.000011d0@Huawei.com>
In-Reply-To: <167030055370.4044561.17788093375112783036.stgit@dwillia2-xfh.jf.intel.com>
References: <167030054261.4044561.2164047490200738083.stgit@dwillia2-xfh.jf.intel.com>
        <167030055370.4044561.17788093375112783036.stgit@dwillia2-xfh.jf.intel.com>
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

On Mon, 05 Dec 2022 20:22:33 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> Internally cxl_mbox_send_cmd() converts all passed-in parameters to a
> 'struct cxl_mbox_cmd' instance and sends that to cxlds->mbox_send(). It
> then teases the possibilty that the caller can validate the output size.
> However, they cannot since the resulting output size is not conveyed to
> the called. Fix that by making the caller pass in a constructed 'struct
> cxl_mbox_cmd'. This prepares for a future patch to add output size
> validation on a per-command basis.
> 
> Given the change in signature, also change the name to differentiate it
> from the user command submission path that performs more validation
> before generating the 'struct cxl_mbox_cmd' instance to execute.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

I'm with Ira on ordering in structure alignment. Other trivial things inline.

Usual moans about slipping in unrelated tidy up.  All good stuff, but
would have preferred them separated out.  In interests of speed though
I'm fine with it as it stands

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

>  static int __cxl_pmem_security_disable(struct nvdimm *nvdimm,
> @@ -83,15 +95,21 @@ static int __cxl_pmem_security_disable(struct nvdimm *nvdimm,
>  	struct cxl_memdev *cxlmd = cxl_nvd->cxlmd;
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  	struct cxl_disable_pass dis_pass;
> -	int rc;
> +	struct cxl_mbox_cmd mbox_cmd;
>  
> -	dis_pass.type = ptype == NVDIMM_MASTER ?
> -		CXL_PMEM_SEC_PASS_MASTER : CXL_PMEM_SEC_PASS_USER;
> +	dis_pass = (struct cxl_disable_pass) {
> +		.type = ptype == NVDIMM_MASTER ? CXL_PMEM_SEC_PASS_MASTER :
> +						 CXL_PMEM_SEC_PASS_USER,
> +	};

Unrelated change as far as I can see. Perhaps reasonable to keep a common
approach, but should really be in a precusor patch.


> @@ -140,14 +167,22 @@ static int cxl_pmem_security_passphrase_erase(struct nvdimm *nvdimm,
>  	struct cxl_nvdimm *cxl_nvd = nvdimm_provider_data(nvdimm);
>  	struct cxl_memdev *cxlmd = cxl_nvd->cxlmd;
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_mbox_cmd mbox_cmd;
>  	struct cxl_pass_erase erase;
>  	int rc;
>  
> -	erase.type = ptype == NVDIMM_MASTER ?
> -		CXL_PMEM_SEC_PASS_MASTER : CXL_PMEM_SEC_PASS_USER;
> +	erase = (struct cxl_pass_erase) {
> +		.type = ptype == NVDIMM_MASTER ? CXL_PMEM_SEC_PASS_MASTER :
> +						 CXL_PMEM_SEC_PASS_USER,
> +	};

Unrelated change?  Meh trivial though so fair enough rolling it in here.


>  	memcpy(erase.pass, key->data, NVDIMM_PASSPHRASE_LEN);
> -	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_PASSPHRASE_SECURE_ERASE,
> -			       &erase, sizeof(erase), NULL, 0);
> +	mbox_cmd = (struct cxl_mbox_cmd) {
> +		.opcode = CXL_MBOX_OP_PASSPHRASE_SECURE_ERASE,
> +		.size_in = sizeof(erase),
> +		.payload_in = &erase,
> +	};
> +
> +	rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
>  	if (rc < 0)
>  		return rc;
>  
> 

