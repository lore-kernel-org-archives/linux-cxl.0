Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C41F7C433FE
	for <linux-cxl@archiver.kernel.org>; Wed,  3 Nov 2021 16:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB17660F58
	for <linux-cxl@archiver.kernel.org>; Wed,  3 Nov 2021 16:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbhKCQLD (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 3 Nov 2021 12:11:03 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:4058 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232509AbhKCQLD (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 3 Nov 2021 12:11:03 -0400
Received: from fraeml741-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Hks6h2J6Vz67kws;
        Thu,  4 Nov 2021 00:05:00 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml741-chm.china.huawei.com (10.206.15.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Wed, 3 Nov 2021 17:08:24 +0100
Received: from localhost (10.52.126.31) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Wed, 3 Nov
 2021 16:08:23 +0000
Date:   Wed, 3 Nov 2021 16:08:21 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>,
        Chet Douglas <chet.r.douglas@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [RFC PATCH v2 15/28] cxl/core: Introduce API to scan switch
 ports
Message-ID: <20211103160821.0000479e@Huawei.com>
In-Reply-To: <20211022183709.1199701-16-ben.widawsky@intel.com>
References: <20211022183709.1199701-1-ben.widawsky@intel.com>
        <20211022183709.1199701-16-ben.widawsky@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.126.31]
X-ClientProxiedBy: lhreml734-chm.china.huawei.com (10.201.108.85) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 22 Oct 2021 11:36:56 -0700
Ben Widawsky <ben.widawsky@intel.com> wrote:

> The CXL drivers encapsulate the components that direct memory traffic in
> an entity known as a cxl_port. Compute Express Link specifies three such
> components: hostbridge (ie. a collection of root ports), switches, and
> endpoints. There are currently drivers that create these ports for the
> hostbridges and the endpoints (cxl_acpi and cxl_mem). The new API
> introduced allows callers to initiate a scan down from the hostbridge
> and create ports for switches in the CXL topology.
> 
> The intended user of this API is for endpoint devices. An endpoint
> device will need to determine if it is CXL.mem capable, which requires
> all components in the path from hostbridge to the endpoint to be CXL.mem
> capable. Once an endpoint device determines it's connected to a CXL
> capable root port, it can call this API to fill in all the ports in
> between the hostbridge and itself.
> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>

This is an unusual enough thing to be doing on PCI that I'd suggest
making sure to cc linux-pci + Bjorn for next version of this...
Shall we say, this makes me nervous and more eyes might be good :)

One trivial inline.
> ---
>  .../driver-api/cxl/memory-devices.rst         |   6 +
>  drivers/cxl/core/Makefile                     |   1 +
>  drivers/cxl/core/bus.c                        | 145 ++++++++++++++++++
>  drivers/cxl/core/pci.c                        |  99 ++++++++++++
>  drivers/cxl/cxl.h                             |   2 +
>  drivers/cxl/pci.h                             |   6 +
>  drivers/cxl/port.c                            |   2 +-
>  tools/testing/cxl/Kbuild                      |   1 +
>  8 files changed, 261 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/cxl/core/pci.c
> 
...

> diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
> index c7e1894d503b..f10e7d5b22a4 100644
> --- a/drivers/cxl/core/bus.c
> +++ b/drivers/cxl/core/bus.c
...
> +static struct cxl_port *find_cxl_port(struct pci_dev *usp)
> +{
> +	struct device *port_dev;
> +
> +	if (!pci_is_pcie(usp) || pci_pcie_type(usp) != PCI_EXP_TYPE_UPSTREAM)
> +		return NULL;
> +
> +	port_dev = bus_find_device(&cxl_bus_type, NULL, usp, match_port);
> +	if (port_dev)
> +		return to_cxl_port(port_dev);

Flip this logic to make it more readable.
	if (!port_dev)
		return NULL;

> +
> +	return NULL;
> +}
> +
