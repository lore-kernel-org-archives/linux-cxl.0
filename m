Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B91D2C433F5
	for <linux-cxl@archiver.kernel.org>; Tue, 26 Apr 2022 19:39:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354228AbiDZTmH (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 26 Apr 2022 15:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345512AbiDZTmH (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 26 Apr 2022 15:42:07 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB65F99C9
        for <linux-cxl@vger.kernel.org>; Tue, 26 Apr 2022 12:38:57 -0700 (PDT)
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KnsZH5rmmz67J0f;
        Wed, 27 Apr 2022 03:36:23 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Tue, 26 Apr 2022 21:38:54 +0200
Received: from localhost (10.81.205.200) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 26 Apr
 2022 20:38:54 +0100
Date:   Tue, 26 Apr 2022 20:38:50 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Ben Widawsky <ben.widawsky@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>
Subject: Re: CXL type 3 which doesn't have cxl mem enabled.
Message-ID: <20220426203850.00006538@Huawei.com>
In-Reply-To: <CAPcyv4gjn7MAo-kzW40EAc9J6zQaOKh0a-42GyV1X5Efac_W_Q@mail.gmail.com>
References: <20220426180832.00005f0b@Huawei.com>
        <CAPcyv4i+=ArjE7uH_jKGS+B9-dLJ3An_T+NgWB2xqC-7Zh-VYA@mail.gmail.com>
        <20220426190615.000063ed@Huawei.com>
        <CAPcyv4gjn7MAo-kzW40EAc9J6zQaOKh0a-42GyV1X5Efac_W_Q@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.205.200]
X-ClientProxiedBy: lhreml725-chm.china.huawei.com (10.201.108.76) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 26 Apr 2022 12:00:41 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> On Tue, Apr 26, 2022 at 11:06 AM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Tue, 26 Apr 2022 10:19:55 -0700
> > Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > > On Tue, Apr 26, 2022 at 10:09 AM Jonathan Cameron
> > > <Jonathan.Cameron@huawei.com> wrote:
> > > >
> > > > Hi All,
> > > >
> > > > I ran into this whilst debugging why on the current QEMU code
> > > > we now get a probe failure for CXL mem due to the range 1 size being
> > > > non 0.
> > > >
> > > > The conditions for whether we have legacy ranges programmed don't
> > > > take into account if Mem_Enable = 1.  That is if the
> > > > DVSEC CXL Control Mem_Enable bit is set on the type 3 device.
> > > > If it's not then there is no existing user of the CXL memory
> > > > setup by firmware or similar so we can switch over to HDM
> > > > decoders and it doesn't matter what is in the range registers.
> > > >
> > > > Unfortunately the QEMU code was bringing the device up with
> > > > Mem_Enabled already set.  So I fixed that.  After all default
> > > > value of that bit should be 0.
> > > >
> > > > A few problems then showed up.
> > > >
> > > > 1. Nothing in the Linux code actually sets Mem_Enabled to 1.
> >
> > Sorry - my mistake, that should be Mem_Enable. Though that doesn't
> > actually clarify things much...
> >
> > >
> > > That's because the device is supposed to, I though, set it of its own
> > > accord as a result of link training. It's an RO field in the spec, so
> > > Linux can't set it:
> > >
> > > 8.2.1.3.3 DVSEC Flex Bus Port Status (Offset 0Eh)
> > > "Mem_Enabled: When set, indicates that CXL.mem protocol operation has
> > > been enabled as a result of PCIe alternate protocol negotiation for
> > > Flex Bus."
> >
> > Agreed with that statement.
> >
> > Ah. Nothing like confusing register field names that are very similar....
> > A Mem_Enable is in DVSEC for CXL Device 8.1.3.2 and is RWL.
> > Just for giggles there is also a Mem_Enable in the Flex Bus Port Control
> > but the range registers comment isn't about that one (I hope anyway!).
> 
> Not sure whether to laugh or cry at that, sorry for the mix up on my part.
> 
> > The kernel currently sets the value of info->mem_enabled using
> > the Mem_Enable field of the DVSEC for CXL Device.
> > https://elixir.bootlin.com/linux/v5.18-rc4/source/drivers/cxl/pci.c#L501
> >
> > So I think wrong name and wrong DVSEC for that particular condition.
> 
> Yeah, I don't even see a need to cache that value, so something like
> the attached? Note that the intent was to only have cxl_mem worry
> about MMIO mapped register details and not require the 'struct
> pci_dev' which makes things easier for cxl_test in the near term.
> 
Hi Dan,

That fixes this problem (I'll test tomorrow but it looks right), but...

I think we still run into the problem I was debugging in the
first place which is whether the Device DVSEC Range 1 size is non 0.
https://elixir.bootlin.com/linux/v5.18-rc4/source/drivers/cxl/pci.c#L541
(ranges ends up > 0 and hence we conclude firmware already programmed the
 device and fail the probe).

As far as I can tell a CXL 2.0 type 3 device is allowed to provide
the option to use ranges or HDM decoders (or it can be HDM decoder only).
See the comment at end of 8.1.3.8.4 :

"A CXL.mem capable device that implements CXL HDM Decoder Capability registers
follows the above behavior as long as HDM Decoder Enable bit in CXL HDM Decoder
Global Control register is zero."

As such we can't use the range size alone to check if
the Range registers are in use (it's a RO value, not something previously
configured)  We need to perform the full check as described which
includes checking Mem_Enable (which is in the above behavior that comment
is directing us towards).

As the below patch has already set Mem_Enable hardware field unconditionally
we don't have the necessary info by the time we reach the relevant code.
https://elixir.bootlin.com/linux/v5.18-rc4/source/drivers/cxl/mem.c#L107

So you could cache the current value (perhaps with a more meaningful
name than the spec gives it!) of Device DVSEC Mem_Enable
at the point where you have it written in this patch and add a check
on the cached value at the point in the reference above.

That's still a little ugly as ideally we shouldn't transition through
a somewhat invalid state - though it is harmless as no traffic
will be sent by the host (probably - though I suspect hardware folk
would tell me we can't assume it...).
The invalid state being:
- Mem_Enable set
- Range registers in use because global HDM Decoder enable not yet set.
- Range registers were programmed by firmware to something that actually
  works but not enabled for some odd reason. I think they might even be
  technically valid with the defaults even though the base is 0 (imagine
  a very large CXL memory - some of it might overlap with a region being
  routed by the host to the CXL host bridges).

Ideally we wouldn't set that Mem_Enable until we have switched
to the HDM decoders.  To avoid that we probably need another callback
from cxl_mem into cxl_pci.

Agreed on the laughing or crying. I'm off to find a beer.

Jonathan



> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 7235d2f976e5..ef6950a2a4fd 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -150,12 +150,10 @@ static inline int cxl_mbox_cmd_rc2errno(struct cxl_mbox_cmd *mbox_cmd)
>  
>  /**
>   * struct cxl_endpoint_dvsec_info - Cached DVSEC info
> - * @mem_enabled: cached value of mem_enabled in the DVSEC, PCIE_DEVICE
>   * @ranges: Number of active HDM ranges this device uses.
>   * @dvsec_range: cached attributes of the ranges in the DVSEC, PCIE_DEVICE
>   */
>  struct cxl_endpoint_dvsec_info {
> -	bool mem_enabled;
>  	int ranges;
>  	struct range dvsec_range[2];
>  };
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 401b0fbe21db..c2d9dadf4a2e 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -27,12 +27,8 @@
>  static int wait_for_media(struct cxl_memdev *cxlmd)
>  {
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> -	struct cxl_endpoint_dvsec_info *info = &cxlds->info;
>  	int rc;
>  
> -	if (!info->mem_enabled)
> -		return -EBUSY;
> -
>  	rc = cxlds->wait_media_ready(cxlds);
>  	if (rc)
>  		return rc;
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index e7ab9a34d718..5c8f933bbece 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -463,6 +463,17 @@ static int wait_for_media_ready(struct cxl_dev_state *cxlds)
>  	return 0;
>  }
>  
> +static void cxl_disable_mem(void *pdev)
> +{
> +	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> +	int d = cxlds->cxl_dvsec;
> +	u16 ctrl;
> +
> +	pci_read_config_word(pdev, d + CXL_DVSEC_CTRL_OFFSET, &ctrl);
> +	ctrl &= ~CXL_DVSEC_MEM_ENABLE;
> +	pci_write_config_word(pdev, d + CXL_DVSEC_CTRL_OFFSET, ctrl);
> +}
> +
>  /*
>   * Return positive number of non-zero ranges on success and a negative
>   * error code on failure. The cxl_mem driver depends on ranges == 0 to
> @@ -486,13 +497,26 @@ static int __cxl_dvsec_ranges(struct cxl_dev_state *cxlds,
>  	if (rc)
>  		return rc;
>  
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
> -		return -ENXIO;
> +	if (!(ctrl & CXL_DVSEC_MEM_ENABLE)) {
> +		ctrl |= CXL_DVSEC_MEM_ENABLE;
> +		rc = pci_write_config_word(pdev, d + CXL_DVSEC_CTRL_OFFSET,
> +					   ctrl);
> +		if (rc)
> +			return rc;
> +
> +		rc = devm_add_action_or_reset(&pdev->dev, cxl_disable_mem,
> +					      pdev);
> +		if (rc)
> +			return rc;
>  	}
>  
>  	/*
> @@ -511,8 +535,6 @@ static int __cxl_dvsec_ranges(struct cxl_dev_state *cxlds,
>  		return rc;
>  	}
>  
> -	info->mem_enabled = FIELD_GET(CXL_DVSEC_MEM_ENABLE, ctrl);
> -
>  	for (i = 0; i < hdm_count; i++) {
>  		u64 base, size;
>  		u32 temp;
> @@ -585,6 +607,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	cxlds = cxl_dev_state_create(&pdev->dev);
>  	if (IS_ERR(cxlds))
>  		return PTR_ERR(cxlds);
> +	pci_set_drvdata(pdev, cxlds);
>  
>  	cxlds->serial = pci_get_dsn(pdev);
>  	cxlds->cxl_dvsec = pci_find_dvsec_capability(
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index b6b726eff3e2..44d01224734a 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -250,10 +250,6 @@ static void label_area_release(void *lsa)
>  
>  static void mock_validate_dvsec_ranges(struct cxl_dev_state *cxlds)
>  {
> -	struct cxl_endpoint_dvsec_info *info;
> -
> -	info = &cxlds->info;
> -	info->mem_enabled = true;
>  }
>  
>  static int cxl_mock_mem_probe(struct platform_device *pdev)
