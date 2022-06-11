Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91AB8C43334
	for <linux-cxl@archiver.kernel.org>; Sat, 11 Jun 2022 04:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbiFKEDa (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 11 Jun 2022 00:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348496AbiFKED1 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sat, 11 Jun 2022 00:03:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86012D97
        for <linux-cxl@vger.kernel.org>; Fri, 10 Jun 2022 21:03:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 218F260B82
        for <linux-cxl@vger.kernel.org>; Sat, 11 Jun 2022 04:03:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D6CAC34116;
        Sat, 11 Jun 2022 04:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654920203;
        bh=JPutf8Got+6Bjmcvn15mSf7H/cY4Lq5YB/25fBhOd0w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ETx5fEjGWGTkOn9QdKbn/1oTVUEv6+k7x/l1yxu5lznd1vc2oCY++LB/SHj5wdtah
         jK/AVVe30j7MtXojv1KyAch7hmlRfDJ1k0ULTPqH0X3ZlvYgLEJFYNIBstEdVsgp5Z
         mSZre22qusWMmC8ZqhkkyDMFIYHPMiWOSJY97+J9QUS2SMC2ahIBA3rn3XRdURJ0Ml
         H926a1ikW0x5orMWdSXSydiPj6/Eny6tvjs0ePZAMEESLxfgoDr/lHY90sEXW4VSro
         0BKUJWy2z1fw06eFz/WwmfdJrz8h/tryAufWs3WOKV3KfgGmNbU0c00isltRlfF7Hd
         0DF1HXDZwNC1g==
Date:   Fri, 10 Jun 2022 21:03:21 -0700
From:   Ben Widawsky <bwidawsk@kernel.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, a.manzanares@samsung.com
Subject: Re: [PATCH] cxl/port: Check for sane CXL.io values for device DVSEC
Message-ID: <20220611040321.gmjyddcyb4q73o4e@bwidawsk-mobl5>
References: <20220611020246.140637-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220611020246.140637-1-dave@stgolabs.net>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 22-06-10 19:02:46, Davidlohr Bueso wrote:
> These must always be set in the capability and control words.
> Explicitly check for these and identify any bogus setups
> while doing cxl_hdm_decode_init().
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  drivers/cxl/core/pci.c | 14 ++++++++++++--
>  drivers/cxl/cxlpci.h   |  2 ++
>  2 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index c4c99ff7b55e..c69be8f120fc 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -367,12 +367,22 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm)
>  	if (rc)
>  		return rc;
>  
> +	if (!(cap & CXL_DVSEC_IO_CAPABLE)) {
> +		dev_dbg(dev, "Not IO Capable\n");
> +		return -ENXIO;
> +	}

I don't know if it's worth doing this. We wouldn't have gotten to the registers
if it wasn't CXL.io capable.

> +
> +	if (!(cap & CXL_DVSEC_MEM_CAPABLE)) {
> +		dev_dbg(dev, "Not MEM Capable\n");
> +		return -ENXIO;
> +	}
> +
>  	rc = pci_read_config_word(pdev, d + CXL_DVSEC_CTRL_OFFSET, &ctrl);
>  	if (rc)
>  		return rc;
>  
> -	if (!(cap & CXL_DVSEC_MEM_CAPABLE)) {
> -		dev_dbg(dev, "Not MEM Capable\n");
> +	if (!(ctrl & CXL_DVSEC_IO_ENABLE)) {
> +		dev_dbg(dev, "Not IO Enable\n");
>  		return -ENXIO;
>  	}
>  
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index fce1c11729c2..845f59288dc3 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -18,9 +18,11 @@
>  /* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
>  #define CXL_DVSEC_PCIE_DEVICE					0
>  #define   CXL_DVSEC_CAP_OFFSET		0xA
> +#define     CXL_DVSEC_IO_CAPABLE	BIT(1)
>  #define     CXL_DVSEC_MEM_CAPABLE	BIT(2)
>  #define     CXL_DVSEC_HDM_COUNT_MASK	GENMASK(5, 4)
>  #define   CXL_DVSEC_CTRL_OFFSET		0xC
> +#define     CXL_DVSEC_IO_ENABLE		BIT(1)
>  #define     CXL_DVSEC_MEM_ENABLE	BIT(2)
>  #define   CXL_DVSEC_RANGE_SIZE_HIGH(i)	(0x18 + (i * 0x10))
>  #define   CXL_DVSEC_RANGE_SIZE_LOW(i)	(0x1C + (i * 0x10))
> -- 
> 2.36.1
> 
