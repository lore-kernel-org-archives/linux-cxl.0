Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82DC21D3D3
	for <linux-cxl@vger.kernel.org>; Fri, 30 May 2025 13:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748611027; cv=none; b=AF/TkkqUCcl+GHEtwIlp24w8mBgZgLBvAxfLpxu2UGe1G1JrHnKWaQW7u2H2v0y6qrUIcDcr3Y79uDN0QLcQiG4hfGWE91WzSj0weDnI9ji2e6X6iJDHHnbnArPWMVCx3wm5vW0ijznQGnjeRk4znb5nkns8UuLiWNQomPHfOpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748611027; c=relaxed/simple;
	bh=nCe9TEQn5QLj9L4R7BBd3uh46cFJZFfokTOJvbsu1dg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a5407IBvNaIX+8mHLQTTfzbvAPgxc4hF74dvtX9gg58rA94FcNWPUdi/0t3BcmqkfpsdRneDXJul0JeMCKGU4KT9laaeRqychaS7ebELmmw8D+HU71VYkNGmxR2Zr5C7wSm9b2mCvrrQbSVTIhLhLoLGN6rYacXAjrBvuqYC06k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b83fw4PB4z6M4hH;
	Fri, 30 May 2025 21:16:56 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 3BF0214027A;
	Fri, 30 May 2025 21:17:02 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 30 May
 2025 15:17:01 +0200
Date: Fri, 30 May 2025 14:17:00 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mst@redhat.com"
	<mst@redhat.com>, Fan Ni <fan.ni@samsung.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linuxarm@huawei.com" <linuxarm@huawei.com>
Subject: Re: [PATCH qemu] hw/cxl: Fix register block locator size
Message-ID: <20250530141700.00005619@huawei.com>
In-Reply-To: <e7050a05-3349-46c6-9ac5-60b621f54a0b@fujitsu.com>
References: <20250529134828.403049-1-Jonathan.Cameron@huawei.com>
	<e7050a05-3349-46c6-9ac5-60b621f54a0b@fujitsu.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 30 May 2025 02:59:40 +0000
"Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com> wrote:

> On 29/05/2025 21:48, Jonathan Cameron via wrote:
> > This has been wrong from day 1.  For now we only have
> > two entries (component and device registers).  
> 
> Wow, I finally understood this.
> 
> 
> > 
> > The wrong size could lead to arbitrary data off the stack being presented
> > in PCIe config space.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >   include/hw/cxl/cxl_pci.h | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/hw/cxl/cxl_pci.h b/include/hw/cxl/cxl_pci.h
> > index d0855ed78b..3bb882ce89 100644
> > --- a/include/hw/cxl/cxl_pci.h
> > +++ b/include/hw/cxl/cxl_pci.h
> > @@ -31,7 +31,7 @@
> >   #define PCIE_CXL3_FLEXBUS_PORT_DVSEC_LENGTH 0x20
> >   #define PCIE_CXL3_FLEXBUS_PORT_DVSEC_REVID  2
> >   
> > -#define REG_LOC_DVSEC_LENGTH 0x24
> > +#define REG_LOC_DVSEC_LENGTH 0x1C  
> 
> IMHO, REG_LOC_DVSEC_LENGTH is device specific, that mean we shouldn't put it in
> a general header with a general name
> 
> try:
> $ git grep REG_LOC_DVSEC_LENGTH
> 
> we got another REG_LOC_DVSEC_LENGTH, shouldn't its value (0x1C - 0x8)?
> 
> 
>   51     regloc_dvsec = &(CXLDVSECRegisterLocator) {
>   52         .rsvd         = 0,
>   53         .reg0_base_lo = RBI_CXL_DEVICE_REG | 0,
>   54         .reg0_base_hi = 0,
>   55     };
>   56     cxl_component_create_dvsec(cxl_cstate, CXL3_SWITCH_MAILBOX_CCI,
>   57                                REG_LOC_DVSEC_LENGTH, REG_LOC_DVSEC,
>   58                                REG_LOC_DVSEC_REVID, (uint8_t *)regloc_dvsec);
> 
Ah.  This isn't a bug at all.  I clearly needed more caffeine.

We are fine because at least in 3.2 the register block identifier of 0 is reserved and
I misread the code completely.  It is odd to have empty entries but not a bug.

Jonathan

> 
> Thanks
> Zhijian
> 
> 
> 
> >   #define REG_LOC_DVSEC_REVID  0
> >   
> >   enum   

