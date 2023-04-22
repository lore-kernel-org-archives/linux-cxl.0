Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D350CC7618E
	for <linux-cxl@archiver.kernel.org>; Sat, 22 Apr 2023 08:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjDVIoE (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 22 Apr 2023 04:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjDVIoD (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sat, 22 Apr 2023 04:44:03 -0400
X-Greylist: delayed 537 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 22 Apr 2023 01:44:01 PDT
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2BE19AD
        for <linux-cxl@vger.kernel.org>; Sat, 22 Apr 2023 01:44:01 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 09B541003D098;
        Sat, 22 Apr 2023 10:35:03 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id C824817BA46; Sat, 22 Apr 2023 10:35:02 +0200 (CEST)
Date:   Sat, 22 Apr 2023 10:35:02 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, ira.weiny@intel.com
Subject: Re: [PATCH] cxl/port: Fix port to pci device assumptions in
 read_cdat_data()
Message-ID: <20230422083502.GA31480@wunner.de>
References: <becaf70e8faf9681d474200117d62d7eaac46cca.1678543498.git.lukas@wunner.de>
 <168213190748.708404.16215095414060364800.stgit@dwillia2-xfh.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168213190748.708404.16215095414060364800.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Apr 21, 2023 at 07:51:47PM -0700, Dan Williams wrote:
> Not all CXL ports are associated with PCI devices. Host-bridge and
> cxl_test ports are hosted by platform devices. Teach read_cdat_data() to
> be careful about non-pci hosted cxl_memdev instances. Otherwise,
> cxl_test crashes with this signature:
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

Reviewed-by: Lukas Wunner <lukas@wunner.de>

Take my Reviewed-by with a grain of salt as I'm absolutely not an
expert on the cxl struct hierarchy, nevertheless this looks sane to me.

I note however that before af0a6c3587dc, xa_for_each() was run on an
xarray which was not initialized with xa_init() on non-pci cxl ports.
(xa_init() was run from cxl_pci_probe() -> devm_cxl_pci_create_doe()
but xa_for_each() was run from read_cdat_data() -> find_cdat_doe()
for non-pci cxl ports as well.)

Hence can't this crash prior to af0a6c3587dc as well?  If it can,
the Fixes tag would rather have to point to c97006046c79 ("cxl/port:
Read CDAT table"), though this patch wouldn't apply cleanly to
pre-6.4 kernels.  c97006046c79 went into v6.0 and there's one stable
kernel between it and v6.4 (for which af0a6c3587dc is queued).
So if the missing xa_init() can indeed cause crashes, you may want to
base your fix on v6.3 and fold it in at the front of cxl/next,
then rebase af0a6c3587dc on top of it.  Let me know if you need help
or want me to look into it.

Thanks for fixing this and sorry for not spotting it myself!

Lukas

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
