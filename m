Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E795D1BD01F
	for <linux-cxl@vger.kernel.org>; Wed, 12 Mar 2025 18:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741803513; cv=none; b=lP2oAmxGiB0ihhAkUkmLP4fd6vntalkDHgbctZ6MZ/zs+xwVoUeDgrHn3EYgysWZf84slxGHnjJYVFC0NrVy6W5DTGOPO3qB1w/ohzrQAK3NFVYwkDmT15KOi6dzxZXhsM0Xhbv3D1KZmYr8ZHmgYw/h0YVnkirs9unqep2BGi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741803513; c=relaxed/simple;
	bh=ovcJOkbgm785WszM94USHPbv5uo5gWHR2B5ksyoaAko=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oEx/9meCpI8+TI4GTfMXAVruXxSU9kdfILT9E8UTc3l0oineaL+P5e0OJw4k+73rAKzMx+2Xf0ab1l0Q48lSdQdrikfA9N0QCEHZxOBBvd8gxTugISOhka3UUv2J2JNVIyyt23HDsmm1B8PNlzaG6IvmXuYKyj6qpQzkUZ+95a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZCf1h0T7kz6M4KQ;
	Thu, 13 Mar 2025 02:15:20 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id A1D65140736;
	Thu, 13 Mar 2025 02:18:28 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 12 Mar
 2025 19:18:28 +0100
Date: Wed, 12 Mar 2025 18:18:26 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Gerd Hoffmann <kraxel@redhat.com>
CC: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	<qemu-devel@nongnu.org>, <pbonzini@redhat.com>, <mtosatti@redhat.com>,
	<mst@redhat.com>, <marcel.apfelbaum@gmail.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <vasant.hegde@amd.com>, <Wei.Huang2@amd.com>,
	<bsd@redhat.com>, <berrange@redhat.com>, <ddutile@redhat.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] pci-ids.rst: Add Red Hat pci-id for AMD IOMMU device
Message-ID: <20250312181826.0000473d@huawei.com>
In-Reply-To: <o4swru5qsoemfs3acxcsifrzy45n4mptxh2vg3ulvnfwgirbv7@6iqvfqb76nh7>
References: <20250304183747.639382-1-suravee.suthikulpanit@amd.com>
	<20250310135731.00005b1f@huawei.com>
	<o4swru5qsoemfs3acxcsifrzy45n4mptxh2vg3ulvnfwgirbv7@6iqvfqb76nh7>
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

On Tue, 11 Mar 2025 09:08:06 +0100
Gerd Hoffmann <kraxel@redhat.com> wrote:

>   Hi,
> 
> > As a heads up, I believe we have a similar problem with a few of the CXL IDs.
> > The root port and type 3 device both use Intel IDs that were not reserved
> > for this purpose.  VID=0x8086, DID=0x7075 and DID=0x0d93  
> 
> Essentially we have two kinds of PCI devices in qemu.
> 
>  * The ones which try to mimic existing hardware, they usually have the
>    PCI ID of the device they are emulating (and use the qemu subsystem ID).
>    The classic example is the cirrus vga.  There are also many intel
>    chipset devices for piix4 ('pc' machine type) and ich9 ('q35' machine
>    type) with intel IDs.
> 
>  * The ones which are PCI class implementations and do not need a
>    specific ID for drivers to accept them.  Most of them have a
>    PCI device ID from the 1b36 vendor ID range.
> 
> The former tend to be older devices (before hardware standardization was
> a thing, also before we got a range from 1b36 for qemu), and the latter
> tend to be newer devices.  There are also a bunch of exceptions for
> historical reasons.  The ahci emulation has a ich9 id.  xhci even has
> two variants (one mimicking a NEC host adapter, one with qemu device id).
> 
> So, in short, using the intel IDs is not necessarily a problem.  Depends
> a bit on what kind of device we are talking about.  For PCI class
> devices it usually is more useful to have a qemu ID though.

They are not valid IDs, so they may get used in future for real
hardware of an entirely different type. We don't want these to
correspond to real hardware either because the aim is to test
out corners of the spec, so we may well implement completely different
sets of features to any real implementation.

> 
> > Switch ports and switch-cci are using valid Hisilicon IDs that are for
> > emulation of these device only and are registered in our tracker
> > for these IDs so won't get 'reused'.  
> 
> That is perfectly fine.  There is no need to change IDs, although it
> makes sense to document that fact in docs/specs/pci-ids.rst

Ah. I wasn't aware of the ID space reserved for QEMU or that doc.

We can leave the HiSilicon ones alone.  I'll sort a docs patch for
the 3 of those soon.

For the Intel ones can I have a pair for the root port and the CXL
type 3 device (so 2 IDs)?  We will probably need one shortly for
the type2 emulation test device as well.

Thanks,

Jonathan


> 
> Moving them to qemu pci id range is an option too if you prefer that.
> Your choice.
> 
> take care,
>   Gerd
> 
> 

