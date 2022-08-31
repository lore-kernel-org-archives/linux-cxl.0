Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5072BECAAD4
	for <linux-cxl@archiver.kernel.org>; Wed, 31 Aug 2022 11:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbiHaL6i (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 31 Aug 2022 07:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbiHaL6f (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 31 Aug 2022 07:58:35 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B73D275C;
        Wed, 31 Aug 2022 04:58:34 -0700 (PDT)
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MHjNf59Twz67mg9;
        Wed, 31 Aug 2022 19:57:54 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Wed, 31 Aug 2022 13:58:32 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 31 Aug
 2022 12:58:32 +0100
Date:   Wed, 31 Aug 2022 12:58:30 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Robert Richter <rrichter@amd.com>
CC:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 12/15] cxl/acpi: Skip devm_cxl_port_enumerate_dports()
 when in RCD mode
Message-ID: <20220831125830.00005105@huawei.com>
In-Reply-To: <20220831081603.3415-13-rrichter@amd.com>
References: <20220831081603.3415-1-rrichter@amd.com>
        <20220831081603.3415-13-rrichter@amd.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 31 Aug 2022 10:16:00 +0200
Robert Richter <rrichter@amd.com> wrote:

> RCD mode has a different enumeration scheme other than in CXL VH mode.
> An RCD is directly connected to an RCH without downstream and upstream
> ports showing up in between in the PCI hierarchy. Skip dport
> enumeration for RCHs. Upstream and downstream ports of RCH and RCD
> will be setup separately in a later patch.
> 
> Introduce the function is_rch_uport() to detect an RCH port. For RCHs
> the parent root port is not the "ACPI0017" device and instead does not
> have a fw node connected to it.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/core/pci.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 0dbbe8d39b07..86ed112eb262 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -65,6 +65,15 @@ static int match_add_dports(struct pci_dev *pdev, void *data)
>  	return 0;
>  }
>  
> +/*
> + * A parent of an RCH (CXL 1.1 host) is a plain platform device while
> + * a 2.0 host links to the ACPI0017 root device.
> + */
> +static inline bool is_rch_uport(struct cxl_port *port)
> +{
> +	return is_cxl_port(&port->dev) && !port->dev.parent->fwnode;

I'm not keen on the presence of fwnode being used to distinguish anything.
That's the sort of thing that gets 'fixed' by later patches.

Can we check something more specific?

> +}
> +
>  /**
>   * devm_cxl_port_enumerate_dports - enumerate downstream ports of the upstream port
>   * @port: cxl_port whose ->uport is the upstream of dports to be enumerated
> @@ -74,10 +83,19 @@ static int match_add_dports(struct pci_dev *pdev, void *data)
>   */
>  int devm_cxl_port_enumerate_dports(struct cxl_port *port)
>  {
> -	struct pci_bus *bus = cxl_port_to_pci_bus(port);
> +	struct pci_bus *bus;
>  	struct cxl_walk_context ctx;
>  	int type;
>  
> +	/*
> +	 * Skip enumeration in Restricted CXL Device mode as the
> +	 * device has been already registered at the host's dport
> +	 * during host discovery.
> +	 */
> +	if (is_rch_uport(port))
> +		return 0;
> +
> +	bus = cxl_port_to_pci_bus(port);
>  	if (!bus)
>  		return -ENXIO;
>  

