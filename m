Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C3D2DC35A
	for <linux-cxl@vger.kernel.org>; Wed, 17 Sep 2025 16:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758126552; cv=none; b=XXvzvnlpMwiRCdJBrOe3Z+L89Fufsmmr+UPpvlxHQB9Ixji60GSOjFm/3VM+cBK30rwPO63oG+73ktm9e+FySkt33K9DmsAFy5YR42tUWReRZPy7GZXZ3K3qc2ViGUUmeThHKBz6J7IstyjiAQNIYHTSpQZ63rGI/rAicGa5uhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758126552; c=relaxed/simple;
	bh=QFtwa9syp74SZM+6g2L16cpfMEOWJq532GGai5xWHw8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FkuK5ZeIFAHuNVL8TTeQ5sVwWxeQfU4aINfks0LLAj2EhS1cTJ3WSe9of5t4zFvoC355kw9kHjIbIL6ByfpA0LbMvBDFH32GFCIe5ibglGNpTU9wH/M+h03n2czUdu9663lewqIwt5Rj7+3osI0Rv6msIpl/oRshWfYe8K/psn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cRkff1b2Mz6M5JB;
	Thu, 18 Sep 2025 00:26:18 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 1010F14033F;
	Thu, 18 Sep 2025 00:29:07 +0800 (CST)
Received: from localhost (10.122.19.247) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 17 Sep
 2025 18:29:06 +0200
Date: Wed, 17 Sep 2025 17:29:05 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Arpit Kumar <arpit1.kumar@samsung.com>
CC: <qemu-devel@nongnu.org>, <gost.dev@samsung.com>,
	<linux-cxl@vger.kernel.org>, <dave@stgolabs.net>, <vishak.g@samsung.com>,
	<krish.reddy@samsung.com>, <a.manzanares@samsung.com>,
	<alok.rathore@samsung.com>, <cpgs@samsung.com>
Subject: Re: [PATCH v4 2/2] hw/cxl: Add Physical Port Control (Opcode 5102h)
Message-ID: <20250917172905.00005fa3@huawei.com>
In-Reply-To: <20250916080736.1266083-3-arpit1.kumar@samsung.com>
References: <20250916080736.1266083-1-arpit1.kumar@samsung.com>
	<CGME20250916080808epcas5p23113551a9a0719d68a8c3efff15209cc@epcas5p2.samsung.com>
	<20250916080736.1266083-3-arpit1.kumar@samsung.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 16 Sep 2025 13:37:36 +0530
Arpit Kumar <arpit1.kumar@samsung.com> wrote:

> -added assert-deassert PERST implementation
>  for physical ports (both USP and DSP's).
> -assert PERST involves bg operation for holding 100ms.
> -reset PPB implementation for physical ports.
> 
> Signed-off-by: Arpit Kumar <arpit1.kumar@samsung.com>

> @@ -4702,11 +4818,34 @@ static CXLRetCode cxl_set_phy_port_info(CXLCCI *cci)
>  void cxl_initialize_mailbox_swcci(CXLCCI *cci, DeviceState *intf,
>                                    DeviceState *d, size_t payload_max)
>  {
> +    CXLUpstreamPort *pp;
> +    uint8_t pn = 0;
> +
>      cxl_copy_cci_commands(cci, cxl_cmd_set_sw);
>      cci->d = d;
>      cci->intf = intf;
>      cxl_init_cci(cci, payload_max);
>      cxl_set_phy_port_info(cci);
> +    /* physical port control */
> +    pp = CXL_USP(cci->d);
This bit feels like it is wrongly located.  I ran into this whilst
trying to add back the mctp variant as part of shuffling my cxl staging tree.

Whilst this only gets used for the CCI commands, it is a USP thing not
a mailbox thing as we only want this called once per USP, not once per CCI on the
USP.

Could we move this to a call from cxl_usp_realize?

If something like that works would you mind sending me a patch on top of this
series to do so? I'm not yet set up to test this series so better you do it.

We don't need that upstream until the first MCTP support on USP so this doesn't
block us on that front.

 
Thanks,
Jonathan

> +    for (int byte_index = 0; byte_index < (CXL_MAX_PHY_PORTS / BITS_PER_BYTE);
> +         byte_index++) {
> +        unsigned char byte = pp->pports.active_port_bitmask[byte_index];
> +
> +        for (int bit_index = 0; bit_index < 8; bit_index++, pn++) {
> +            if (((byte) & (1 << bit_index)) != 0) {
> +                qemu_mutex_init(&pp->pports.perst[pn].lock);
> +                pp->pports.perst[pn].issued_assert_perst = false;
> +                /*
> +                 * Assert PERST involves physical port to be in
> +                 * hold reset phase for minimum 100ms. No other
> +                 * physical port control requests are entertained
> +                 * until Deassert PERST command.
> +                 */
> +                pp->pports.perst[pn].asrt_time = ASSERT_WAIT_TIME_MS;
> +            }
> +        }
> +    }
>  }
>  
