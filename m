Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F7CC4332F
	for <linux-cxl@archiver.kernel.org>; Mon, 19 Dec 2022 16:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbiLSQLI (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 19 Dec 2022 11:11:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiLSQLH (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 19 Dec 2022 11:11:07 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302C321A4
        for <linux-cxl@vger.kernel.org>; Mon, 19 Dec 2022 08:11:06 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NbPmN0C0nz67Zm0;
        Tue, 20 Dec 2022 00:09:40 +0800 (CST)
Received: from localhost (10.81.210.222) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 19 Dec
 2022 16:11:03 +0000
Date:   Mon, 19 Dec 2022 16:11:01 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>, <rrichter@amd.com>,
        <terry.bowman@amd.com>
Subject: Re: [RFC PATCH 2/8] cxl: export cxl_dvsec_rr_decode() to cxl_port
Message-ID: <20221219161101.00000180@Huawei.com>
In-Reply-To: <166984994667.2805382.3598594737505566629.stgit@djiang5-desk3.ch.intel.com>
References: <166984987659.2805382.17264896576424996856.stgit@djiang5-desk3.ch.intel.com>
        <166984994667.2805382.3598594737505566629.stgit@djiang5-desk3.ch.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.210.222]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 30 Nov 2022 16:12:26 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Call cxl_dvsec_rr_decode() in the beginning of cxl_port_probe() and
> preserve the decoded information in the 'struct cxl_endpoint_dvsec_info'.
This confused me a little as it already stores info in such a structure.
Perhaps reword as

preserve the decoded information in a local 'struct cxl_endpoint_dvsec_info'.

> This info can be passed to various functions later on in order to support
> the HDM decoder emulation. The invocation of cxl_dvsec_rr_decode() in
> cxl_hdm_decode_init() is removed and a pointer to the 'struct
> cxl_endpoint_dvsec_info' is passed in.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

A few comments inline.  Whilst this is an RFC, given I'm reading it
I'll give it a fullish review.

Jonathan

> ---
>  drivers/cxl/core/pci.c |   17 ++++++-----------
>  drivers/cxl/cxl.h      |   14 ++++++++++++++
>  drivers/cxl/cxlmem.h   |   12 ------------
>  drivers/cxl/cxlpci.h   |    3 ++-
>  drivers/cxl/port.c     |   15 +++++++++++----
>  5 files changed, 33 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index d674ddfe141c..7196b1fcdcfc 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -335,8 +335,8 @@ static bool __cxl_hdm_decode_init(struct cxl_dev_state *cxlds,
>  }
>  
>  
> -static int cxl_dvsec_rr_decode(struct pci_dev *pdev, int d,
> -			       struct cxl_endpoint_dvsec_info *info)
> +int cxl_dvsec_rr_decode(struct pci_dev *pdev, int d,
> +			struct cxl_endpoint_dvsec_info *info)
>  {
>  	int hdm_count, rc, i, ranges = 0;
>  	struct device *dev = &pdev->dev;
> @@ -431,6 +431,7 @@ static int cxl_dvsec_rr_decode(struct pci_dev *pdev, int d,
>  	info->ranges = ranges;
>  	return 0;
>  }
> +EXPORT_SYMBOL_NS_GPL(cxl_dvsec_rr_decode, CXL);
>  
>  /**
>   * cxl_hdm_decode_init() - Setup HDM decoding for the endpoint
> @@ -439,23 +440,17 @@ static int cxl_dvsec_rr_decode(struct pci_dev *pdev, int d,
>   *
>   * Try to enable the endpoint's HDM Decoder Capability
>   */
> -int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm)
> +int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
> +			struct cxl_endpoint_dvsec_info *info)

Update the docs for the new parameter.

>  {
>  	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
> -	struct cxl_endpoint_dvsec_info info = { 0 };
> -	int rc;
>  	struct device *dev = &pdev->dev;
> -	int d = cxlds->cxl_dvsec;
> -
> -	rc = cxl_dvsec_rr_decode(pdev, d, &info);
> -	if (rc < 0)
> -		return rc;
>  
>  	/*
>  	 * If DVSEC ranges are being used instead of HDM decoder registers there
>  	 * is no use in trying to manage those.
>  	 */
> -	if (!__cxl_hdm_decode_init(cxlds, cxlhdm, &info)) {
> +	if (!__cxl_hdm_decode_init(cxlds, cxlhdm, info)) {
>  		dev_err(dev,
>  			"Legacy range registers configuration prevents HDM operation.\n");
>  		return -EBUSY;

...


>  void read_cdat_data(struct cxl_port *port);
>  #endif /* __CXL_PCI_H__ */
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index 5453771bf330..f899d62a91af 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -32,7 +32,10 @@ static void schedule_detach(void *cxlmd)
>  
>  static int cxl_port_probe(struct device *dev)
>  {
> +	struct cxl_endpoint_dvsec_info info = { 0 };
>  	struct cxl_port *port = to_cxl_port(dev);
> +	struct cxl_dev_state *cxlds;
> +	struct cxl_memdev *cxlmd;
>  	struct cxl_hdm *cxlhdm;
>  	int rc;
>  
> @@ -43,6 +46,13 @@ static int cxl_port_probe(struct device *dev)
>  			return rc;
>  		if (rc == 1)
>  			return devm_cxl_add_passthrough_decoder(port);
> +	} else {

I'd suggest flipping logic of the if so we have
two clearly matched
	if (is_cxl_endpoint(port)
blocks. That should make it more obvious that we are safe
in setting cxlmd and cxlds here and using it the later one.

I don't think a compiler can tell that is_cxl_endpoint(port)
will return the same in both cases so you might want to use
a local bool so that is only called once.  Otherwise static
analysis might throw up a false positive. 



> +		cxlmd = to_cxl_memdev(port->uport);
> +		cxlds = cxlmd->cxlds;
> +		rc = cxl_dvsec_rr_decode(to_pci_dev(cxlds->dev),
> +					 cxlds->cxl_dvsec, &info);
> +		if (rc < 0)
> +			return rc;
>  	}
>  
>  	cxlhdm = devm_cxl_setup_hdm(port);
> @@ -50,9 +60,6 @@ static int cxl_port_probe(struct device *dev)
>  		return PTR_ERR(cxlhdm);
>  
>  	if (is_cxl_endpoint(port)) {
> -		struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport);
> -		struct cxl_dev_state *cxlds = cxlmd->cxlds;
> -
>  		/* Cache the data early to ensure is_visible() works */
>  		read_cdat_data(port);
>  
> @@ -61,7 +68,7 @@ static int cxl_port_probe(struct device *dev)
>  		if (rc)
>  			return rc;
>  
> -		rc = cxl_hdm_decode_init(cxlds, cxlhdm);
> +		rc = cxl_hdm_decode_init(cxlds, cxlhdm, &info);
>  		if (rc)
>  			return rc;
>  
> 
> 

