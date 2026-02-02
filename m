Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3E42472AA
	for <linux-cxl@vger.kernel.org>; Mon,  2 Feb 2026 15:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770047587; cv=none; b=VOxCL+elfqiA94HXTt0iR67sxiH5diznYOMU01b8GergsYXlnAiGJBW12MdlZnkbrD94MTZ9j6ZfEeE3CPh/9ez6Tj1GGrgb5RWBimiki/SZEpBhSpIROiQUlTRRcRbFv474hjXVNpEyIqwvzEsqmPSB7BtP8Dhw5YY5B9Amu6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770047587; c=relaxed/simple;
	bh=V5+j4bIGVmYICVMQ6Lxu5Mi+Cz6SP1jXIUSXHjC/+QE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XWN4cUKjRsfhmiJ8owJ1riqfQxBpUXiTWGAlKMNu6iJELYjsxyLnV8IcD7K0rA4X+u1H9Gt9wnDtt0yZmTzp+Adlrdvhz/V3RPSqt6VBY9oPKFV1d+oSf3QktBlC95GlTELleWkwDOvVevypgGUyZ1nP+R84N4z30BxTgi0w17w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f4WMS0TWdzHnGdn;
	Mon,  2 Feb 2026 23:52:04 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id AEA9D4056B;
	Mon,  2 Feb 2026 23:53:01 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 2 Feb
 2026 15:53:01 +0000
Date: Mon, 2 Feb 2026 15:52:59 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: RFC: CXL Isolation Support
Message-ID: <20260202155259.00003a0e@huawei.com>
In-Reply-To: <b4f7a760-5cf4-4343-8f7e-9698ba435fa4@amd.com>
References: <b4f7a760-5cf4-4343-8f7e-9698ba435fa4@amd.com>
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
 dubpeml500005.china.huawei.com (7.214.145.207)


> Possible Solutions
> ------------------
> There's a couple of things we could do here. First is to restrict isolation to when
> the CXL core is built-in (CXL_BUS=y && depends on PCIEPORTBUS). I'm not particularly
> happy about this approach since it removes the modularity of the CXL driver(s), but I
> won't gripe if that's what's settled on.

It's the sort of constraint we can relax later if that becomes possible.

> 
> Another approach would be to move the CXL register mapping code in cxl/core/regs.c to a
> library, or always make the file built-in when CXL_BUS is selected. This is more palatable
> (imo) but splits the CXL code up in a potentially weird way.
> 
> Last one is to rework the PCIe port bus driver to allow for re-allocating MSI/-X interrupts.
> Jonathan Cameron sent out a series where there was some discussion on this. This support
> would be limited to MSI-X interrupts only due to the PCI maintainers not wanting to add
> more support for MSI [4].

> This wouldn't work for AMD platforms because we use MSI interrupts
> for this support. There is still a way to make this work, however. AMD server platforms
> use the same MSI vector for all PCIe interrupts, so we could introduce a quirk to use that
> same vector as another PCIe interrupt for CXL isolation. That would require no register mapping
> code in the PCIe portdrv code but would introduce a platform quirk instead. I doubt anyone would
> be happy about introducing a quirk but I thought I'd throw it out as an option.

That whole approach (I failed to follow up so far) in [4] never took shared interrupts into account.
So might well have been quirk territory even with that rework done (with MSI as a possible
controversial follow up to the MSI-X version).

Jonathan



> 
> Thanks for reading,
> Ben

> 

