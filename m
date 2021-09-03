Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE5FC433F5
	for <linux-cxl@archiver.kernel.org>; Fri,  3 Sep 2021 15:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB3DD60FC4
	for <linux-cxl@archiver.kernel.org>; Fri,  3 Sep 2021 15:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349680AbhICPc1 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 3 Sep 2021 11:32:27 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3739 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349605AbhICPcZ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 3 Sep 2021 11:32:25 -0400
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4H1MDB5XFZz67b23;
        Fri,  3 Sep 2021 23:29:46 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 3 Sep 2021 17:31:24 +0200
Received: from localhost (10.52.121.127) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.8; Fri, 3 Sep 2021
 16:31:23 +0100
Date:   Fri, 3 Sep 2021 16:31:25 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH 08/13] cxl/mem: Add memdev as a port
Message-ID: <20210903163125.00001da3@Huawei.com>
In-Reply-To: <20210902195017.2516472-9-ben.widawsky@intel.com>
References: <20210902195017.2516472-1-ben.widawsky@intel.com>
        <20210902195017.2516472-9-ben.widawsky@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.121.127]
X-ClientProxiedBy: lhreml703-chm.china.huawei.com (10.201.108.52) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 2 Sep 2021 12:50:12 -0700
Ben Widawsky <ben.widawsky@intel.com> wrote:

> CXL endpoints contain HDM decoders that are architecturally the same as
> a CXL switch, or a CXL hostbridge. While some restrictions are in place
> for endpoints, they will require the same enumeration logic to determine
> the number and abilities of the HDM decoders.
> 
> Utilizing the existing port APIs from cxl_core is the simplest way to
> gain access to the same set of information that switches and hostbridges
> have.
> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
In of itself seems sensible.  (note I'm reviewing these one at a time but
reserve the right to throw my hands up in horror at the end result ;)

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/cxl/core/bus.c |  5 ++++-
>  drivers/cxl/mem.c      | 10 +++++++++-
>  2 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
> index 56f57302d27b..f26095b40f5c 100644
> --- a/drivers/cxl/core/bus.c
> +++ b/drivers/cxl/core/bus.c
> @@ -377,7 +377,10 @@ struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
>  
>  	dev = &port->dev;
>  	if (parent_port)
> -		rc = dev_set_name(dev, "port%d", port->id);
> +		if (host->type == &cxl_memdev_type)
> +			rc = dev_set_name(dev, "devport%d", port->id);
> +		else
> +			rc = dev_set_name(dev, "port%d", port->id);
>  	else
>  		rc = dev_set_name(dev, "root%d", port->id);
>  	if (rc)
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index b6dc34d18a86..9d5a3a29cda1 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -63,6 +63,7 @@ static int cxl_mem_probe(struct device *dev)
>  	struct device *pdev_parent = cxlm->dev->parent;
>  	struct pci_dev *pdev = to_pci_dev(cxlm->dev);
>  	struct device *port_dev;
> +	int rc;
>  
>  	if (!is_cxl_mem_enabled(pdev))
>  		return -ENODEV;
> @@ -72,7 +73,14 @@ static int cxl_mem_probe(struct device *dev)
>  	if (!port_dev)
>  		return -ENODEV;
>  
> -	return 0;
> +	/* TODO: Obtain component registers */
> +	rc = PTR_ERR_OR_ZERO(devm_cxl_add_port(&cxlmd->dev, &cxlmd->dev,

oh. Nasty / efficient depending on how you look at it.

> +					       CXL_RESOURCE_NONE,
> +					       to_cxl_port(port_dev)));
> +	if (rc)
> +		dev_err(dev, "Unable to add devices upstream port");
> +
> +	return rc;
>  }
>  
>  static void cxl_mem_remove(struct device *dev)

