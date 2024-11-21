Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760CA157490
	for <linux-cxl@vger.kernel.org>; Thu, 21 Nov 2024 16:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732208167; cv=none; b=d5JsEePjntem+Xv2uzMZO8wWlKCe7V/09ENTNUri8roEhC8MEhHFsZVb9gjLM1H7a3ZHurqROMnPKtQqJw28dXrb8I8HTItlCqP/6I2d7xlxIiomcG22FKkJf+D6Wf39nEk7X1JizS60+Zrs7iqYCWKb3yxXOn3CCM9M0mU4PLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732208167; c=relaxed/simple;
	bh=SWqEnFj7pAOTtg/1B4LO6LT9GqmosnKVmIRJ+G6VzRA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ya8ahp41A71pPhE4NcnBejE/BLJT1xIdAOXITdFa2tgriRuAzyVmpyk6oW3ie9hU/SqTNyFcluq9yKAq08JaUZeaLgaZ/7gHUkL5lcTxA3ZumR4MKesBeJZqU/Tq5txiam9wwi+yqZV81zjbEV5k6oWq8W8ufFiOtvEgAhXTZqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XvPSh2RXrz6K5qR;
	Fri, 22 Nov 2024 00:53:40 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id ADDA7140A70;
	Fri, 22 Nov 2024 00:56:00 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 21 Nov
 2024 17:56:00 +0100
Date: Thu, 21 Nov 2024 16:55:58 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
CC: Yuquan Wang <wangyuquan1236@phytium.com.cn>, <devel@edk2.groups.io>,
	<ardb+tianocore@kernel.org>, <quic_llindhol@quicinc.com>,
	<peter.maydell@linaro.org>, <chenbaozi@phytium.com.cn>,
	<linux-cxl@vger.kernel.org>, <asa-dev@op-lists.linaro.org>,
	<qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
Subject: Re: [edk2-devel] [RFC PATCH v2 1/1] hw/arm/sbsa-ref: Support CXL
 Host Bridge & CFMW
Message-ID: <20241121165558.00005f1b@huawei.com>
In-Reply-To: <90513bfa-0888-44fe-8cd0-7b2e7518a41f@linaro.org>
References: <20241105104346.417102-1-wangyuquan1236@phytium.com.cn>
	<20241105104346.417102-2-wangyuquan1236@phytium.com.cn>
	<20241107120457.00006024@Huawei.com>
	<90513bfa-0888-44fe-8cd0-7b2e7518a41f@linaro.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 12 Nov 2024 18:10:56 +0100
Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org> wrote:

> W dniu 7.11.2024 o=A013:04, Jonathan Cameron pisze:
> > On Tue,  5 Nov 2024 18:43:46 +0800
> > "Yuquan Wang"<wangyuquan1236@phytium.com.cn> wrote:
> >  =20
> >> This creates a default pxb-cxl (bus_nr=3D0xc0) bridge with two
> >> cxl root ports on sbsa-ref. And the memory layout places 64K
> >> space for the cxl host bridge register regions(CHBCR) in the
> >> sbsa-ref memmap.
> >>
> >> In addition, this support indepentent mmio32(32M) & mmio64(1M)
> >> space for cxl components. =20
>=20
> > Those are too small.  Might work today but not sustainable.
> >=20
> > I'm a bit surprised it was this simple to move the MMIO Space away
> > from what is normally done for PXBs.
> > I think it might work because the GPEX memory windows are effectively
> > unlimited in size but I'd like some more eyes on this from people
> > familiar with how all that works and whether there might be some
> > corner cases that you haven't seen yet. =20
>=20
> I see the same problem as with multiple PCIe buses (for NUMA systems):
>=20
> pci 0000:c0:00.0: bridge window [io  size 0x1000]: can't assign; no space
> pci 0000:c0:00.0: bridge window [io  size 0x1000]: failed to assign
> pci 0000:c0:01.0: bridge window [io  size 0x1000]: can't assign; no space
> pci 0000:c0:01.0: bridge window [io  size 0x1000]: failed to assign
>=20
> I do not know how it looks on real hardware (all my systems have one
> PCIe bus) but shouldn't each host bridge have own separate resource
> windows for config space, buses, mmio etc.?
>=20
> Now we squeeze all pcie buses as pcie-pxb devices and this patch adds
> cxl to the combo.

In theory fine to break them up because each can have a smaller window
they just happen to be next to each other in this configuration.

CXL PXB (maybe the pcie one was well) doesn't IIRC support IO regions
in general.  So that above is kind of normal and shouldn't matter
unless you emulate an ancient PCI device.

Jonathan

