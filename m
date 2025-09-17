Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24377341361
	for <linux-cxl@vger.kernel.org>; Wed, 17 Sep 2025 15:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758124543; cv=none; b=T7rLDxiVUD/AtEQOjCSf7tW4SXgjjQs0ne+a1IhrLhKjz1YI+xsYvrbfwDBiIPPttNaU98VZAZzZsXW3pWQAA5+YyIIcaJDxtpTEGG84E+aQrFfpfQrKwU5FE0emj39TteoQNQHUO7wPcHYsAua1vxE75/eTIq6DpD2XJ9JJgWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758124543; c=relaxed/simple;
	bh=VklywoAfxYKhbEDFedhzapapiw41XzP7UklMrTtPhvw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mVFCysyK3vx7dg5IbyoC42VXHfOFKFcLIfjjC/AJdyvryXe+hI7mpPuzs74TchVp607C7pIEG9Kgxw6/QNSNTERUdUKiD9rsNILvHY0C+6V2nBMO1jmVr3xy5P4SEzm3rzKtJyt/pXkWMCRVtZakVNLYPb3Z5ZIAc34T4HK4iXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cRjt10Ptzz6L621;
	Wed, 17 Sep 2025 23:51:05 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id C415A1400D4;
	Wed, 17 Sep 2025 23:55:37 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 17 Sep
 2025 17:55:37 +0200
Date: Wed, 17 Sep 2025 16:55:35 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Arpit Kumar <arpit1.kumar@samsung.com>
CC: <qemu-devel@nongnu.org>, <gost.dev@samsung.com>,
	<linux-cxl@vger.kernel.org>, <dave@stgolabs.net>, <vishak.g@samsung.com>,
	<krish.reddy@samsung.com>, <a.manzanares@samsung.com>,
	<alok.rathore@samsung.com>, <cpgs@samsung.com>
Subject: Re: [PATCH v4 1/2] hw/cxl: Refactored Identify Switch Device & Get
 Physical Port State
Message-ID: <20250917165535.000021b1@huawei.com>
In-Reply-To: <20250916080736.1266083-2-arpit1.kumar@samsung.com>
References: <20250916080736.1266083-1-arpit1.kumar@samsung.com>
	<CGME20250916080803epcas5p1cd11689108b259f21908d9779993cc0f@epcas5p1.samsung.com>
	<20250916080736.1266083-2-arpit1.kumar@samsung.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 16 Sep 2025 13:37:35 +0530
Arpit Kumar <arpit1.kumar@samsung.com> wrote:

> -Storing physical ports info during enumeration.
> -Refactored changes using physical ports info for
>  Identify Switch Device (Opcode 5100h) & Get Physical Port State
>  (Opcode 5101h) physical switch FM-API command set.
> 
> Signed-off-by: Arpit Kumar <arpit1.kumar@samsung.com>

Hi Arpit.  One question inline, and one comment on code I've moved
around whilst queue this up.  I'll push out a tree to gitlab
(probably tomorrow) and when I do please check I didn't mess that up!

Jonathan


> +static CXLRetCode cxl_set_port_type(CXLUpstreamPort *ports, int pnum,
> +                                    CXLCCI *cci)
> +{
> +    uint8_t current_port_config_state;
> +    uint8_t connected_device_type;
> +    uint8_t supported_ld_count;
> +    uint16_t lnkcap, lnkcap2, lnksta;
> +    PCIBus *bus;
> +    PCIDevice *port_dev;
> +    PCIEPort *usp = PCIE_PORT(cci->d);
> +
> +    if (usp->port == pnum) {
> +        port_dev = PCI_DEVICE(usp);
> +        current_port_config_state = CXL_PORT_CONFIG_STATE_USP;
> +        connected_device_type = CXL_PORT_CONNECTED_DEV_TYPE_NONE;
> +        supported_ld_count = 0;
> +    } else {
> +        bus = &PCI_BRIDGE(cci->d)->sec_bus;
> +        port_dev = pcie_find_port_by_pn(bus, pnum);
> +        if (port_dev) { /* DSP */
> +            PCIDevice *ds_dev = pci_bridge_get_sec_bus(PCI_BRIDGE(port_dev))
> +                ->devices[0];
> +            current_port_config_state = CXL_PORT_CONFIG_STATE_DSP;
> +            if (ds_dev) {
> +                if (object_dynamic_cast(OBJECT(ds_dev), TYPE_CXL_TYPE3)) {
> +                    /* To-do: controllable */

In what sense controllable?  It should always match what the downstream device
is presenting as.  Do you ultimately mean if we mess with the alternate modes
and reset the port to have it come up as a PCI only device?
This will need to be more complex as we add different CXL type 3 device support
of course, but I'd still expect to auto detect it rather that control it directly.

> +                    connected_device_type = CXL_PORT_CONNECTED_DEV_TYPE_3_SLD;
> +                } else {
> +                    connected_device_type = CXL_PORT_CONNECTED_DEV_TYPE_PCIE;
> +                }
> +            } else {
> +                connected_device_type = CXL_PORT_CONNECTED_DEV_TYPE_NONE;
> +            }
> +            supported_ld_count = 3;
> +        } else {
> +            return CXL_MBOX_INVALID_INPUT;
> +        }
> +    }

>  void cxl_initialize_mailbox_swcci(CXLCCI *cci, DeviceState *intf,
>                                    DeviceState *d, size_t payload_max)
>  {
> @@ -4691,6 +4706,7 @@ void cxl_initialize_mailbox_swcci(CXLCCI *cci, DeviceState *intf,
>      cci->d = d;
>      cci->intf = intf;
>      cxl_init_cci(cci, payload_max);
> +    cxl_set_phy_port_info(cci);
>  }
>  
>  void cxl_initialize_mailbox_t3(CXLCCI *cci, DeviceState *d, size_t payload_max)
> @@ -4777,4 +4793,5 @@ void cxl_initialize_usp_mctpcci(CXLCCI *cci, DeviceState *d, DeviceState *intf,
>      cci->d = d;
>      cci->intf = intf;
>      cxl_init_cci(cci, payload_max);
> +    cxl_set_phy_port_info(cci);

I'll shift this to a later patch whilst picking this up for my staging tree.
I want this ahead of where we introduce cxl_initialize_usp_mctpcci.
 
>  }
