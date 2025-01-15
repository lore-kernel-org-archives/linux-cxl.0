Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E6124A7D2
	for <linux-cxl@vger.kernel.org>; Wed, 15 Jan 2025 13:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736948685; cv=none; b=heiZL51y4XN6OkdJNxNMPL0SdnwFX6XwevcxulkW/iRRIUMxbWrGlW2HTycoVN2/bc/Ua2mrTRmtTiWJpbFHhAqr5qcb23Mcq5pfm8YaEVR4+n71rWW2kqeVQrczRJdMI0sJD5vY/QqKkj9dXyfLrHk6Jjf33215th0fhnZqucI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736948685; c=relaxed/simple;
	bh=bIiDmg7tVpMVy687oreDM6UubiOty4oP3/DUi3XoS/Q=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GUClVZd3CBFGltDw2t6Hyit0qmrKWcfIosW0yY83k0+KXZyiXBb0c8JqB7BCdwP6S1YbzeBAzpevZCL2LaxMVqDOwfyF4E+NScTnnSGrJlHL5enJJF4cm8DBw6ETWHkE2m704TASmTXsBIu5u7FjLLjRiaD5C9ov8p0XKIgjVAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YY6dT6WJCz6K5Xg;
	Wed, 15 Jan 2025 21:43:09 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 2AF30140257;
	Wed, 15 Jan 2025 21:44:40 +0800 (CST)
Received: from localhost (10.122.19.247) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 15 Jan
 2025 14:44:39 +0100
Date: Wed, 15 Jan 2025 13:44:38 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Li Zhijian <lizhijian@fujitsu.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, Fan Ni
	<fan.ni@samsung.com>, <mst@redhat.com>
Subject: Re: [PATCH v3] hw/cxl: Fix msix_notify: Assertion `vector <
 dev->msix_entries_nr`
Message-ID: <20250115134438.00006563@huawei.com>
In-Reply-To: <20250115075834.167504-1-lizhijian@fujitsu.com>
References: <20250115075834.167504-1-lizhijian@fujitsu.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 15 Jan 2025 15:58:34 +0800
Li Zhijian <lizhijian@fujitsu.com> wrote:

> This assertion always happens when we sanitize the CXL memory device.
> $ echo 1 > /sys/bus/cxl/devices/mem0/security/sanitize
> 
> It is incorrect to register an MSIX number beyond the device's capability.
> 
> Increase the device's MSIX number to cover the mailbox msix number(9).
> 
> Fixes: 43efb0bfad2b ("hw/cxl/mbox: Wire up interrupts for background completion")
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>

Thanks.  I'll carry this on my tree and include it in next set I send to Michael.

Michael, feel free to pick this one up directly if you prefer.
Its a silly mistake I made reordering a couple of series.
A nice cleanup to avoid this problem happening again will follow.

Jonathan

> ---
> V3:
>   Just increate the device's msix number, A new enumeration will be introduced in later patch. # Jonathan
> 
> V2:
>   Just increase msix number and add enum to maintainer their values # Jonathan
> ---
>  hw/mem/cxl_type3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index bd7652740f4b..0ae1704a345c 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -843,7 +843,7 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
>      ComponentRegisters *regs = &cxl_cstate->crb;
>      MemoryRegion *mr = &regs->component_registers;
>      uint8_t *pci_conf = pci_dev->config;
> -    unsigned short msix_num = 6;
> +    unsigned short msix_num = 10;
>      int i, rc;
>      uint16_t count;
>  

