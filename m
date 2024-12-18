Received: from sgoci-sdnproxy-4.icoremail.net (sgoci-sdnproxy-4.icoremail.net [129.150.39.64])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F178414E2CF
	for <linux-cxl@vger.kernel.org>; Wed, 18 Dec 2024 03:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.150.39.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734492293; cv=none; b=BhuMdLSTpwT+WRRtOJukkdhZlesM2+dLXP+VHerdt8ceebWFOa1xX+HvDO2SMHMraevDy3F5hwYW/hM/iyU+cMgQI5GN9reEtdxBxr7P7py0rOQipavEjIa3dSHhh3XwOHfoTZ+lJjFHHo12RPdEWh1j4oPio7fCzIK5JkJlnek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734492293; c=relaxed/simple;
	bh=fNoISuI0FNVie05AmbHzn+rk6OMEYgHKeQGvDtcIKuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ua+tralQaiyAyMhLBLBCpjsgC/yvrewImppFcZLj151FKu2BpoxUdhnYrSfX1bDpJZl0HdxM6A7B2/uCe9ORnhdGcetVtCmNL35Tnd+FeMjCCiLdw+ltmpHrPyvmiU2pFSeiIq1Eyqz2tKcZPomdtTnXSfdqhS0pAs5ZzrB3orA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=129.150.39.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwDHvGtvQGJn5QNICw--.8785S2;
	Wed, 18 Dec 2024 11:24:31 +0800 (CST)
Received: from localhost (unknown [123.150.8.50])
	by mail (Coremail) with SMTP id AQAAfwDnOXZZQGJnm_hqAA--.2769S2;
	Wed, 18 Dec 2024 11:24:23 +0800 (CST)
Date: Wed, 18 Dec 2024 11:23:53 +0800
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: jonathan.cameron@huawei.com, Benjamin.Cheatham@amd.com
Cc: marcin.juszkiewicz@linaro.org, ardb+tianocore@kernel.org,
	quic_llindhol@quicinc.com, Jonathan.Cameron@huawei.com,
	chenbaozi@phytium.com.cn, devel@edk2.groups.io,
	linux-cxl@vger.kernel.org
Subject: Re: [RFC PATCH edk2-platforms v4 0/1] add basic support for CXL on
 sbsa-ref
Message-ID: <Z2JASa3YURiPmeuo@phytium.com.cn>
References: <20241210103632.95960-1-wangyuquan1236@phytium.com.cn>
 <46b1b4e4-8588-46ae-8331-1ccb40a069ac@amd.com>
 <Z1pd2nyOs2ryoZXt@phytium.com.cn>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1pd2nyOs2ryoZXt@phytium.com.cn>
X-CM-TRANSID:AQAAfwDnOXZZQGJnm_hqAA--.2769S2
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQADAWdh1gwAZgABs4
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7Zr4fZF1fCryxZw1xWFyxuFg_yoW8tw15pF
	WYgF1qyFWktr1UuwnFv348Xw4rtws5ZFW8Zr98Z348K3ZF93WaqFW7tayY9a47GFn5Cw43
	Ca1jv3s7Xayjy3DanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU

On Thu, Dec 12, 2024 at 11:51:54AM +0800, Yuquan Wang wrote:
> On Wed, Dec 11, 2024 at 03:40:03PM +0000, Alejandro Lucero Palau wrote:
> > 
> > On 12/10/24 10:36, Yuquan Wang wrote:
> > > v3 -> v4:
> > > - Align base addresses of CXL relevant Windows
> > > 
> > > v2 -> v3:
> > > - PCDs values of pio, mmio32, mmio64 & ecam space for the independent cxl host
> > > - CXL Bus range: 0x00 ~ 0xff
> > > - Mcfg ecam structure for cxl
> > > - Iort RC node for cxl
> > > 
> > > RFC because
> > > - Many contents are ported from Jonathan' patch on qemu virt design
> > > 
> > > - Bring plenty of PCDs values
> > > 
> > > - Less experience and not particularly confident in ACPI area
> > > 
> > > This series leverages Jonathan's patches[1] to add acpi0016 & acpi0017 objects into the
> > > previous DSDT table of sbsa-ref. Since my latest acpi0016 implementation model on qemu
> > > side is a new host bridge qemu object rather than pxb-cxl, the cxl host(Segment 0001)
> > > would have its own ECAM sapce. Meanwhile, this adds exclusive pio, mmio32 & mmio64 space
> > > for cxl host.
> > 
> > 
> > Hi Yuquan,
> > 
> > 
> > Is there a roadmap for edk2 supporting other CXL features?
> > 
> Hi, Alejandro
> 
> Emmm. I have not find such edk2 roadmap (docs/webs/blog) yet. According to
> what I've learnd, the edk2 upstream only support some head files which
> define cxl registers structs and no cxl drivers have merged into upstream
> now, and mostly system software's work haved been done in linux kernel.
> 
> Regard to cxl patches in edk2, there is a series of patches in reviewing to
> support enabling cxl-type3 device as memory expander on Arm/RD platform[1].
> 
> Link:
> [1]: https://edk2.groups.io/g/devel/message/109488
> > 
> > I have noticed UEFI extensions are not supported yet, specifically
> > EFI_ADAPTER_INFO_CDAT_TYPE_GUID as an instance of
> > EFI_ADAPTER_INFORMATION_PROTOCOL.
> > 
> > 
> > Any feedback would be welcome.
> > 
> > 
> > Thanks
> > 
> > 
>
Hi, Jonathan & Ben

Recently I am trying to test EINJ for cxl error on sbsa-ref based on Ben
Cheatham's patches, but there seems no sample for cxl EINJ table in edk2.
Hence, I manage to write the EINJ table by what I have learnd in ACPI
SPEC, but I am struggling with which error injection actions need me to
build.

Do you know some limitations on this mechanism in QEMU or any suggestions?

Many thanks
Yuquan

