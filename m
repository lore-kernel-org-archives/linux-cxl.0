Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0DB23A994
	for <linux-cxl@vger.kernel.org>; Thu, 18 Dec 2025 16:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766075502; cv=none; b=douXv4+iHI7K84unhstJb3vgEGeOKoWr8jz8dqVMVl7CN6IwyO6So2pyFOli0nPVnN+F9KQ2IoKjaKq9TpqpUfO+tAE8oizm8hKr7i2jAXHrO+31r4+iw9XwxlJiDmeW+lriQKujinxSDn2sMGtThuoJEXy3lOLHOl69TgSR+oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766075502; c=relaxed/simple;
	bh=VS5KFYPIS+eQgEE0IFUSNffB0kWBDBXEfLfjhwtLTIc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F/uKtr0eLMufesFnTegHLN9HNpXcaz1HNHmNgcbHDTKB9wLG5hh657+dgftj4PirWjJZUzOV3yzxEuuMxWb+UO4JsdZU2Ygy+wJNJBN67VgFanpdnVb0FbTlUSieJiQZ1MukDnIBRkiB/38Dec/L0bJJ1+u9vPeLUteaDTzpS2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dXGPj6zGqzJ46CX;
	Fri, 19 Dec 2025 00:31:05 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 35A0A40086;
	Fri, 19 Dec 2025 00:31:37 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 18 Dec
 2025 16:31:36 +0000
Date: Thu, 18 Dec 2025 16:31:34 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <ira.weiny@intel.com>, <alucerop@amd.com>, <a.manzanares@samsung.com>,
	<dongjoo.seo1@samsung.com>, <mst@redhat.com>, <marcel.apfelbaum@gmail.com>,
	<armbru@redhat.com>, <linux-cxl@vger.kernel.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH 1/5] hw/pcie: Support enabling flit mode
Message-ID: <20251218163134.000002e4@huawei.com>
In-Reply-To: <20251103195209.1319917-2-dave@stgolabs.net>
References: <20251103195209.1319917-1-dave@stgolabs.net>
	<20251103195209.1319917-2-dave@stgolabs.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Mon,  3 Nov 2025 11:52:05 -0800
Davidlohr Bueso <dave@stgolabs.net> wrote:

> PCIe Flit Mode, introduced with the PCIe 6.0 specification, is a
> fundamental change in how data is transmitted over the bus to
> improve transfer rates. It shifts from variable-sized Transaction
> Layer Packets (TLPs) to fixed 256-byte Flow Control Units (FLITs).
> 
> As with the link speed and width training, have ad-hoc property for
> setting the flit mode and allow CXL components to make use of it.
> 
> For the CXL root port and dsp cases, always report flit mode but
> the actual value after 'training' will depend on the downstream
> device configuration.
> 
> Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Tested-by: Dongjoo Seo <dongjoo.seo1@samsung.com>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

One small question inline.


> diff --git a/hw/pci-bridge/gen_pcie_root_port.c b/hw/pci-bridge/gen_pcie_root_port.c
> index d9078e783bf0..6b97da0b4cbb 100644
> --- a/hw/pci-bridge/gen_pcie_root_port.c
> +++ b/hw/pci-bridge/gen_pcie_root_port.c
> @@ -145,6 +145,7 @@ static const Property gen_rp_props[] = {
>                                  speed, PCIE_LINK_SPEED_16),
>      DEFINE_PROP_PCIE_LINK_WIDTH("x-width", PCIESlot,
>                                  width, PCIE_LINK_WIDTH_32),
> +    DEFINE_PROP_BOOL("x-256b-flit", PCIESlot, flitmode, false),
Do we need this given we only care about this mode for CXL devices?

Will default to false anyway and seems unwise to add infrastructure
when nothing that can be connected below this uses it yet.

>  };
>  
>  static void gen_rp_dev_class_init(ObjectClass *klass, const void *data)


