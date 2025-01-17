Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DFC1F754C
	for <linux-cxl@vger.kernel.org>; Fri, 17 Jan 2025 11:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737112602; cv=none; b=k2hulDgKcD5gXvY7Aq7/ufPdu7EcM6yje/PnWnFyf5HnKkeQ5mEAFFIdIaBkMjiwspG78Wf8JVOh3EvF7A1FOjtnNY6qwViq9G31nJf3G0iaPthkRJtT56cKQsMTYVJJCB0oYObyamfhx9vgrZZbIWydNaxcQrg3CPjlunYRhIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737112602; c=relaxed/simple;
	bh=VWUNaDPVlG0kgP3PoFg+i3GsS5IhLHJmPWe6udx1S1E=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ExrQTIhOfqMfDEjtU0T6Shk5ZgDDDwwMvVjXUgFjwNHlnHP+hQjRxyfBRu/hxcShvMcejMIr9Q4srDqIp2nUyEeFnBG8+umghDP3z1y52Q4SuCLVWzPopveqADyfEDQ3ifUgXzKYKA8fB1GQTD/zqLTA8mCtNRVCI6PLGYQoxmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YZHFP5HLnz6M4QF;
	Fri, 17 Jan 2025 19:14:49 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id AF77F140CB9;
	Fri, 17 Jan 2025 19:16:37 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 17 Jan
 2025 12:16:37 +0100
Date: Fri, 17 Jan 2025 11:16:35 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Michael Tokarev <mjt@tls.msk.ru>
CC: Li Zhijian <lizhijian@fujitsu.com>, <qemu-devel@nongnu.org>,
	<linux-cxl@vger.kernel.org>, Fan Ni <fan.ni@samsung.com>, qemu-stable
	<qemu-stable@nongnu.org>
Subject: Re: [PATCH v3] hw/cxl: Fix msix_notify: Assertion `vector <
 dev->msix_entries_nr`
Message-ID: <20250117111635.00004e94@huawei.com>
In-Reply-To: <9c06632b-751b-4a2f-aa87-e07691bebfba@tls.msk.ru>
References: <20250115075834.167504-1-lizhijian@fujitsu.com>
	<9c06632b-751b-4a2f-aa87-e07691bebfba@tls.msk.ru>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 17 Jan 2025 10:20:44 +0300
Michael Tokarev <mjt@tls.msk.ru> wrote:

> 15.01.2025 10:58, Li Zhijian via wrote:
> > This assertion always happens when we sanitize the CXL memory device.
> > $ echo 1 > /sys/bus/cxl/devices/mem0/security/sanitize
> > 
> > It is incorrect to register an MSIX number beyond the device's capability.
> > 
> > Increase the device's MSIX number to cover the mailbox msix number(9).  
> 
> This seems to be like a qemu-stable material (8.2+), is it not?

It is.
Thanks


> 
> Thanks,
> 
> /mjt
> 
> > Fixes: 43efb0bfad2b ("hw/cxl/mbox: Wire up interrupts for background completion")
> > Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> > ---
> > V3:
> >    Just increate the device's msix number, A new enumeration will be introduced in later patch. # Jonathan
> > 
> > V2:
> >    Just increase msix number and add enum to maintainer their values # Jonathan
> > ---
> >   hw/mem/cxl_type3.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> > index bd7652740f4b..0ae1704a345c 100644
> > --- a/hw/mem/cxl_type3.c
> > +++ b/hw/mem/cxl_type3.c
> > @@ -843,7 +843,7 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
> >       ComponentRegisters *regs = &cxl_cstate->crb;
> >       MemoryRegion *mr = &regs->component_registers;
> >       uint8_t *pci_conf = pci_dev->config;
> > -    unsigned short msix_num = 6;
> > +    unsigned short msix_num = 10;
> >       int i, rc;
> >       uint16_t count;
> >     
> 

