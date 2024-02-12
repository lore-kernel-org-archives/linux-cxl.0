Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A17524D1
	for <linux-cxl@vger.kernel.org>; Mon, 12 Feb 2024 16:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707755512; cv=none; b=ZvysoNpU9QWAqo8MxkXNbu2DbnZ1E9fpnEzX3EI0kDY+Pkv+8+YzMz2KhlQqMyiwR2XHU3LyQIOx1e78JW8leR8ENkveQ9D3RXXoxk2L8z8lNkKdOpFBU6/2n84Dk9LJxQrB2ZhL2MAV+8iycg9Lezb/cuOUqVtqspw7+o9vrWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707755512; c=relaxed/simple;
	bh=3cskJbe6H5SjmJD6mPEdczsL2/gauj7TchMeywDmcWk=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type; b=l/hPEG8Aoj09RfOsFxBREXsrtRNpxu7+86hRCxzdEm8qJoQ8TpDUUxhmfYMJnxdxSsqMtP8kPYqvYOueD8jytdl3ZHaokY4KD0Cq6/3jl7PxaW6UrpPGzDl5v9uqElkfC4jvuhTMeiZSQth6VjQlJL38XTV/R4N05ONP83AvlFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TYVHt0Swxz689sn;
	Tue, 13 Feb 2024 00:28:10 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 321A5140B73;
	Tue, 13 Feb 2024 00:31:45 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 12 Feb
 2024 16:31:44 +0000
Date: Mon, 12 Feb 2024 16:31:43 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <linuxarm@huawei.com>, <qemu-devel@nongnu.org>, Paolo Bonzini
	<pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, David Hildenbrand
	<david@redhat.com>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
	<philmd@linaro.org>, <linux-cxl@vger.kernel.org>
CC: Mattias Nissler <mnissler@rivosinc.com>
Subject: Bug: physmem: address_space_read_cached_slow() accesses wrong
 MemoryRegion on latter part of large reads.
Message-ID: <20240212163143.0000690a@huawei.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

Hi All,

The continuing saga of a getting CXL emulation to play well with using the
memory as normal RAM ran into (hopefully) a last issue.

When running my boot image via virtio-blk-pci and having deliberately forced some
buffers to end up in the CXL memory via
$ numactl --membind=1 ls
then on shut down I was getting a failure to allocate a large enough DMA buffer
even with Mattias' set to increase the size and an extra patch to apply that to
the main system memory (as virtio ignores iommu and PCI address space).
gdb/bt pointed at virtqueue_split_pop() bt pointed later than the actual problem
as descriptors were loaded but corrupt here:
https://elixir.bootlin.com/qemu/latest/source/hw/virtio/virtio.c#L1573
https://elixir.bootlin.com/qemu/latest/source/hw/virtio/virtio.c#L306

After a chase (via a highly suspicious read size of 0xffffffff it turns
out it was issuing a 16 byte read via address_space_read_cached_slow() and
getting a very odd answer.

The first 8 bytes was the correct virtio descriptor content the second 8
were coming from the flash region at physical address 0 onwards on arm-virt.

With those breadcrumbs the problem was (I think) easy to find.

https://elixir.bootlin.com/qemu/latest/source/include/exec/memory.h#L3029
address_space_read_cached_slow() operates on a MemoryRegionCache with the
hwaddr being relative to the start of that cached region.

However it calls flatview_read_continue()  That's fine as long as we can
do the read in one go.


For normal memory flatview_read_continue() will deal with splitting a read up
but on each iteration it loads the mr via
mr = flatview_translate(fv, addr, &addr1, &l, false, attrs);
to cope with reads that cross MemoryRegions.
https://elixir.bootlin.com/qemu/latest/source/system/physmem.c#L2737

Unfortunately the addr passed in here is the one addressing into the
MemoryRegionCache offset by whatever we already read.
Which for this bug example that was 0x8 (in the flash memory).

Assuming I have correctly identified the problem.
One potential fix is to define a new

MemtxResult address_space_read_cached_continue(MemoryRegionCache *cache,
                                               hwaddr addr, MemTxAttr attrs,
                                               void *ptr, hwaddr len,
                                               hwaddr addr1, hwaddr l,
                                               MemoryRegion *mr)

That is nearly identical to flatview_read_continue() but with the 
mr = flatview_translate() replaced with
mr = address_space_translate_cached(cache, addr, &addr1, &l, false, attrs)

That's a bit ugly though given the duplicated code but any other change
is going to involve some more invasive splitting out of utility functions
to share all but the outer loop.

I don't currently have a test hitting it but assume
flatview_write_continue() in address_space_write_cached_slow() has the
same problem.

Jonathan

p.s. Will tidy this and the rest of my house of cards up then post it.
I suspect we'll carry on hitting QEMU limitations with the CXL emulation
but for now I have x86 and ARM setups that work with TCG.
Hmm. Need to spend some time getting regressions tests in place :(
