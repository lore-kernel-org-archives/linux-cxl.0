Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A1BDC77B60
	for <linux-cxl@archiver.kernel.org>; Sun, 23 Apr 2023 15:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjDWPHI (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 23 Apr 2023 11:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjDWPHE (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 23 Apr 2023 11:07:04 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1FFE77
        for <linux-cxl@vger.kernel.org>; Sun, 23 Apr 2023 08:07:03 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Q4BQz4GJFz67M5Q;
        Sun, 23 Apr 2023 23:05:47 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Sun, 23 Apr
 2023 16:07:01 +0100
Date:   Sun, 23 Apr 2023 16:07:00 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <ira.weiny@intel.com>,
        <lukas@wunner.de>
Subject: Re: [PATCH] cxl/port: Fix port to pci device assumptions in
 read_cdat_data()
Message-ID: <20230423160700.00007340@huawei.com>
In-Reply-To: <168213190748.708404.16215095414060364800.stgit@dwillia2-xfh.jf.intel.com>
References: <becaf70e8faf9681d474200117d62d7eaac46cca.1678543498.git.lukas@wunner.de>
        <168213190748.708404.16215095414060364800.stgit@dwillia2-xfh.jf.intel.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 21 Apr 2023 19:51:47 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Not all CXL ports are associated with PCI devices. Host-bridge and
> cxl_test ports are hosted by platform devices. Teach read_cdat_data() to
> be careful about non-pci hosted cxl_memdev instances. Otherwise,
> cxl_test crashes with this signature:

This is crossing two paths.  One memdevs that aren't hosted by
PCI devices, two the other port cases.  Right now this code assumes
a memdev, so calling out the other case is problematic.

I'd just drop the mention of host bridges or mention that we only
call this for memdev ports today. 

> 
>  RIP: 0010:xas_start+0x6d/0x290
>  [..]
>  Call Trace:
>   <TASK>
>   xas_load+0xa/0x50
>   xas_find+0x25b/0x2f0
>   xa_find+0x118/0x1d0
>   pci_find_doe_mailbox+0x51/0xc0
>   read_cdat_data+0x45/0x190 [cxl_core]
>   cxl_port_probe+0x10a/0x1e0 [cxl_port]
>   cxl_bus_probe+0x17/0x50 [cxl_core]
> 
> Some other cleanups are included like removing the single-use @uport
> variable, and removing the indirection through 'struct cxl_dev_state' to
> lookup the device that registered the memdev and may be a pci device.
> 
> Fixes: af0a6c3587dc ("cxl/pci: Use CDAT DOE mailbox created by PCI core")
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Makes sense. If it's not a PCI device no config space so no DOE instance
(+ the wrong device types etc).

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/pci.c |   13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 25b7e8125d5d..bdbd907884ce 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -536,17 +536,18 @@ static int cxl_cdat_read_table(struct device *dev,
>   */
>  void read_cdat_data(struct cxl_port *port)
>  {
> -	struct pci_doe_mb *cdat_doe;
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport);

Given you talk about host bridges above, this would not be safe

I don't think we call this on host bridges though so perhaps the
patch description needs to not mention them to avoid confusion.

> +	struct device *host = cxlmd->dev.parent;

>  	struct device *dev = &port->dev;
> -	struct device *uport = port->uport;
> -	struct cxl_memdev *cxlmd = to_cxl_memdev(uport);
> -	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> -	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
> +	struct pci_doe_mb *cdat_doe;
>  	size_t cdat_length;
>  	void *cdat_table;
>  	int rc;
>  
> -	cdat_doe = pci_find_doe_mailbox(pdev, PCI_DVSEC_VENDOR_ID_CXL,
> +	if (!dev_is_pci(host))
> +		return;
> +	cdat_doe = pci_find_doe_mailbox(to_pci_dev(host),
> +					PCI_DVSEC_VENDOR_ID_CXL,
>  					CXL_DOE_PROTOCOL_TABLE_ACCESS);
>  	if (!cdat_doe) {
>  		dev_dbg(dev, "No CDAT mailbox\n");
> 

