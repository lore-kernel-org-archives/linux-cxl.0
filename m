Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E801F12ED
	for <linux-cxl@vger.kernel.org>; Tue, 11 Feb 2025 09:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739266024; cv=none; b=G/lfebQVfthJlMMTAgRc+yOtMi/4Yd35rriigPqTjlEBr6ALu/CW5sa+Aw+my/WCA1VK5b/fU9GdRAJHtFzEos0T4ATlD2rghuARL10s8o3faMIAwlF1iwC4LIUJeTumM7dGyOQAIxxWGT+N64jVr1kdz/ok6TrjBDaNFQjY9rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739266024; c=relaxed/simple;
	bh=KdVY8knFXWt0qvn0uzQR/Mu9Mt7Lgjc2WJf8HNzF5K0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aHCX2OTnHIKFFetOahf53iwl1BFrOh2oaXBnwmJQaZ3L4plCtKeDkMGhr5dWalfSHD1AQ05o33VDIpVtZLQsISD2xtBmsXcp9FcPjcMTT3HNYTfnOVkvdgSd4keO4DZogphCM0IqI71twMI94CG0Av2O5RzUZzOWCXDz+EHU3KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Ysbf13vhdz6K9Js;
	Tue, 11 Feb 2025 17:25:45 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id EBAF3140442;
	Tue, 11 Feb 2025 17:26:57 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 11 Feb
 2025 10:26:57 +0100
Date: Tue, 11 Feb 2025 09:26:55 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
CC: <fan.ni@samsung.com>, <qemu-devel@nongnu.org>, <chenbaozi@phytium.com.cn>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 1/1] mem/cxl-type3: Add a default value of sn
Message-ID: <20250211092655.00004310@huawei.com>
In-Reply-To: <20250211022413.80842-2-wangyuquan1236@phytium.com.cn>
References: <20250211022413.80842-1-wangyuquan1236@phytium.com.cn>
	<20250211022413.80842-2-wangyuquan1236@phytium.com.cn>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 11 Feb 2025 10:24:13 +0800
Yuquan Wang <wangyuquan1236@phytium.com.cn> wrote:

> The previous default value of sn is UI64_NULL which would cause the
> cookie of nd_interleave_set be '0' and the "invalid interleave-set
> -cookie" failure in label validation.
Hi Yuquan,

Maybe we should harden the nd_interleave_set code to fail
to set the cookie in the event of no serial number. That is a
device not compliant with the spec, but none the less it is not
implausible with test devices etc.

> 
> As many users maybe not know how to set a unique sn for cxl-type3
> device and perhaps be confuesd by the failure of label validation,
> so this defines '1' as the default value of serial number to fix the
> problem.

That magic value is specifically chosen to be 'undefined' to trigger
clean handling of the failure and not provide the serial number
capability. 

If you have multiple devices and provide a 'valid' default then
there are circumstances in which the device will be seen as a multiheaded
single device attached to two places in the PCI topology.

So I'm not keen to change this.  Ideally we'd have made this a required
parameter from the start, but we didn't and doing so now would result
in a backwards compatibility problem.

So I think this is kind of a 'won't fix' situation on the qemu side.

Jonathan

> 
> Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
> ---
>  hw/mem/cxl_type3.c | 17 ++++-------------
>  1 file changed, 4 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 0ae1704a34..a6b5a9f74e 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -310,12 +310,6 @@ static void ct3d_config_write(PCIDevice *pci_dev, uint32_t addr, uint32_t val,
>      pcie_aer_write_config(pci_dev, addr, val, size);
>  }
>  
> -/*
> - * Null value of all Fs suggested by IEEE RA guidelines for use of
> - * EU, OUI and CID
> - */
> -#define UI64_NULL ~(0ULL)
> -
>  static void build_dvsecs(CXLType3Dev *ct3d)
>  {
>      CXLComponentState *cxl_cstate = &ct3d->cxl_cstate;
> @@ -856,12 +850,9 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
>      pci_config_set_prog_interface(pci_conf, 0x10);
>  
>      pcie_endpoint_cap_init(pci_dev, 0x80);
> -    if (ct3d->sn != UI64_NULL) {
> -        pcie_dev_ser_num_init(pci_dev, 0x100, ct3d->sn);
> -        cxl_cstate->dvsec_offset = 0x100 + 0x0c;
> -    } else {
> -        cxl_cstate->dvsec_offset = 0x100;
> -    }
> +
> +    pcie_dev_ser_num_init(pci_dev, 0x100, ct3d->sn);
> +    cxl_cstate->dvsec_offset = 0x100 + 0x0c;
>  
>      ct3d->cxl_cstate.pdev = pci_dev;
>      build_dvsecs(ct3d);
> @@ -1225,7 +1216,7 @@ static const Property ct3_props[] = {
>                       TYPE_MEMORY_BACKEND, HostMemoryBackend *),
>      DEFINE_PROP_LINK("lsa", CXLType3Dev, lsa, TYPE_MEMORY_BACKEND,
>                       HostMemoryBackend *),
> -    DEFINE_PROP_UINT64("sn", CXLType3Dev, sn, UI64_NULL),
> +    DEFINE_PROP_UINT64("sn", CXLType3Dev, sn, 0x1),
>      DEFINE_PROP_STRING("cdat", CXLType3Dev, cxl_cstate.cdat.filename),
>      DEFINE_PROP_UINT8("num-dc-regions", CXLType3Dev, dc.num_regions, 0),
>      DEFINE_PROP_LINK("volatile-dc-memdev", CXLType3Dev, dc.host_dc,

