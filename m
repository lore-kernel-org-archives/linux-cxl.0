Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BCD1D89FA
	for <linux-cxl@vger.kernel.org>; Tue, 24 Dec 2024 16:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735056423; cv=none; b=neTHg3lon+GcYcRXrRaNyEUxTEFx9brvCqscFrGfGbTNOPbvPuWdSziR3aMGzVRz9ibf2CwXh/0lRx4GsGH1387BgbvJ37B1qisvUHI3Ir4wRDlttY3hT27zzOpJldNXmE9hIVIaEhkRxKlq+ZkmKMWQjEKrefmxzTyIiJcb3cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735056423; c=relaxed/simple;
	bh=geTsEfDLyLNJ+BGkdNihzecdM2fIz3/171hkPY8ggDE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sW6WEbdde6HoBRP9zuNq+88QkvYNg3tFxHUUvLVMRn7mCkzxprQ/bjk/JJR7jsJi5eN0VCMzzeR87lSyJIev9ubmtQuJJTucUhNqNP8TfjCjMjBsidW5XvYEjw+x+HQh9+hgVljCKkRInYUcEA29TCMoX0oPqWQkf5Z34febzWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YHfsC12qYz6K6Nl;
	Wed, 25 Dec 2024 00:06:39 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 39487140133;
	Wed, 25 Dec 2024 00:06:59 +0800 (CST)
Received: from localhost (10.48.156.150) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 24 Dec
 2024 17:06:58 +0100
Date: Tue, 24 Dec 2024 16:06:57 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
CC: <devel@edk2.groups.io>, <Benjamin.Cheatham@amd.com>,
	<marcin.juszkiewicz@linaro.org>, <ardb+tianocore@kernel.org>,
	<quic_llindhol@quicinc.com>, <chenbaozi@phytium.com.cn>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [edk2-devel] [RFC PATCH edk2-platforms v4 0/1] add basic
 support for CXL on sbsa-ref
Message-ID: <20241224160657.000040ca@huawei.com>
In-Reply-To: <Z2JASa3YURiPmeuo@phytium.com.cn>
References: <20241210103632.95960-1-wangyuquan1236@phytium.com.cn>
	<46b1b4e4-8588-46ae-8331-1ccb40a069ac@amd.com>
	<Z1pd2nyOs2ryoZXt@phytium.com.cn>
	<Z2JASa3YURiPmeuo@phytium.com.cn>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 18 Dec 2024 11:23:53 +0800
"Yuquan Wang" <wangyuquan1236@phytium.com.cn> wrote:

> On Thu, Dec 12, 2024 at 11:51:54AM +0800, Yuquan Wang wrote:
> > On Wed, Dec 11, 2024 at 03:40:03PM +0000, Alejandro Lucero Palau wrote:  
> > > 
> > > On 12/10/24 10:36, Yuquan Wang wrote:  
> > > > v3 -> v4:
> > > > - Align base addresses of CXL relevant Windows
> > > > 
> > > > v2 -> v3:
> > > > - PCDs values of pio, mmio32, mmio64 & ecam space for the independent cxl host
> > > > - CXL Bus range: 0x00 ~ 0xff
> > > > - Mcfg ecam structure for cxl
> > > > - Iort RC node for cxl
> > > > 
> > > > RFC because
> > > > - Many contents are ported from Jonathan' patch on qemu virt design
> > > > 
> > > > - Bring plenty of PCDs values
> > > > 
> > > > - Less experience and not particularly confident in ACPI area
> > > > 
> > > > This series leverages Jonathan's patches[1] to add acpi0016 & acpi0017 objects into the
> > > > previous DSDT table of sbsa-ref. Since my latest acpi0016 implementation model on qemu
> > > > side is a new host bridge qemu object rather than pxb-cxl, the cxl host(Segment 0001)
> > > > would have its own ECAM sapce. Meanwhile, this adds exclusive pio, mmio32 & mmio64 space
> > > > for cxl host.  
> > > 
> > > 
> > > Hi Yuquan,
> > > 
> > > 
> > > Is there a roadmap for edk2 supporting other CXL features?
> > >   
> > Hi, Alejandro
> > 
> > Emmm. I have not find such edk2 roadmap (docs/webs/blog) yet. According to
> > what I've learnd, the edk2 upstream only support some head files which
> > define cxl registers structs and no cxl drivers have merged into upstream
> > now, and mostly system software's work haved been done in linux kernel.
> > 
> > Regard to cxl patches in edk2, there is a series of patches in reviewing to
> > support enabling cxl-type3 device as memory expander on Arm/RD platform[1].
> > 
> > Link:
> > [1]: https://edk2.groups.io/g/devel/message/109488  
> > > 
> > > I have noticed UEFI extensions are not supported yet, specifically
> > > EFI_ADAPTER_INFO_CDAT_TYPE_GUID as an instance of
> > > EFI_ADAPTER_INFORMATION_PROTOCOL.
> > > 
> > > 
> > > Any feedback would be welcome.
> > > 
> > > 
> > > Thanks
> > > 
> > >   
> >  
> Hi, Jonathan & Ben
> 
> Recently I am trying to test EINJ for cxl error on sbsa-ref based on Ben
> Cheatham's patches, but there seems no sample for cxl EINJ table in edk2.
> Hence, I manage to write the EINJ table by what I have learnd in ACPI
> SPEC, but I am struggling with which error injection actions need me to
> build.
> 
> Do you know some limitations on this mechanism in QEMU or any suggestions?
Sorry no idea.

For error injection I've always focused on doing it from QEMU, not in firmware
and on arm/virt not sbsa-ref so I have complete control of the ACPI tables.

Not sure what's needed to make the EDK2 / SBSAref version work.

Jonathan

> 
> Many thanks
> Yuquan
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Groups.io Links: You receive all messages sent to this group.
> View/Reply Online (#120909): https://edk2.groups.io/g/devel/message/120909
> Mute This Topic: https://groups.io/mt/110023229/1895510
> Group Owner: devel+owner@edk2.groups.io
> Unsubscribe: https://edk2.groups.io/g/devel/unsub [jonathan.cameron@huawei.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 
> 

