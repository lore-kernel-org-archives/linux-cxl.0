Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AF83F0778
	for <linux-cxl@vger.kernel.org>; Tue, 17 Mar 2026 16:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773766632; cv=none; b=EvTPgupg+j4R6k320CG1oX3vx1TB9KlawhRhdlzjqzW3akvVN4kTiqxQ7gQWBTCazQTYsTr4m41NeDCX+22n8UN34bWUCQE2dKOGN8C09yiiLLLb1Kd+3z6Y4dLwYOwCts3UqIT5Y4iUVeIqZwPk3Ao1R5EWv3fXG1h6jR8d5kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773766632; c=relaxed/simple;
	bh=zd5Z9cnZnXc5oNwZsG2tNjBCzkxgZg8j84nXoaVPZJ0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jk9bH3VsbETLpBN+6+HpnZkH6/SsUUFiq0Zl3YdYKvMRfwIrWiyvgNMqPpSXMLeG1ld0nj8WfgFXQJW1RTK4GDsIZZDtZHoA9gGwq39w38m43i6U3bJvEhfmk7BSY6+Wh1ynXwPmg6w00wTBw3jrbJobZyq1OJqEHVW3dF+LmoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fZymG6TDrzHnGcW;
	Wed, 18 Mar 2026 00:56:46 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id C67F640587;
	Wed, 18 Mar 2026 00:57:06 +0800 (CST)
Received: from localhost (10.48.149.62) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 17 Mar
 2026 16:57:06 +0000
Date: Tue, 17 Mar 2026 16:57:02 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Li Chen <me@linux.beauty>
CC: Fan Ni <fan.ni@samsung.com>, <qemu-devel@nongnu.org>,
	<alireza.sanaee@huawei.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 0/3] cxl: avoid KVM internal error for fixed memory
 windows
Message-ID: <20260317165702.00003c98@huawei.com>
In-Reply-To: <20260317033304.3185291-1-me@linux.beauty>
References: <20260317033304.3185291-1-me@linux.beauty>
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
 dubpeml500005.china.huawei.com (7.214.145.207)

On Tue, 17 Mar 2026 11:33:00 +0800
Li Chen <me@linux.beauty> wrote:

> CXL fixed memory windows are currently modeled as an I/O MemoryRegion.
> When running under KVM, this makes the entire window look like MMIO.
> If Linux onlines the window as system RAM (e.g. for a CXL Type-3
> volatile memdev), normal CPU stores into the window trigger KVM
> instruction emulation. Instructions like XSAVEC are not supported by
> the emulator and abort the VM with a KVM internal error.
> 
> Repro:
>   - Boot a guest with a CXL Type-3 volatile memdev and a fixed memory window.
>   - In the guest, create a RAM region and online it as system RAM:
>       cxl create-region -m -t ram -d decoder0.0 -w 1 -g 4096 mem0
>   - QEMU exits with a KVM internal error.

Hi Li Chen,

At least at first look this looks very like:

https://lore.kernel.org/qemu-devel/20260306121151.883-1-alireza.sanaee@huawei.com/

Which was ready for merge as far as I was concerned, but missed getting queued for
11.0 (as last PCI pull request had gone) and is currently ready to go in next cycle.

Please see if that works for your case. If there are improvements I'd prefer
to see them applied on top of that series than reinventing what I think
is the same thing.

It's not KVM specific as linear mappings (when valid) bring huge performance
benefits on TCG as well as correctness for KVM.

Jonathan

+CC linux-cxl which is where CXL folk tend to hang out in larger numbers
than on the qemu list.



> 
> Serial output excerpt:
>   KVM internal error. Suberror: 1
>   extra data[0]: 0x0000000000000001
>   extra data[1]: 0xc0314061c70f480f
>   extra data[2]: 0x024080f610478b48
>   extra data[3]: 0x0000000000000400
>   extra data[4]: 0x000000010000000f
>   extra data[5]: 0x00000004a0003140
>   extra data[6]: 0x0000000000000000
>   extra data[7]: 0x0000000000000000
>   emulation failure
>   RAX=0000000000000007 RBX=ffff8eace0001a40 RCX=ffff8eace0003100 RDX=0000000000000000
>   RSI=0000000000000007 RDI=ffff8eace00030c0 RBP=ffffd48ac1747c08 RSP=ffffd48ac1747bc8
>   R8 =0000000000000007 R9 =0000000000000007 R10=000000000000000d R11=0000000000000000
>   R12=ffff8ea945b51a40 R13=ffffd48ac166c000 R14=0000000000000000 R15=0000000001200000
>   RIP=ffffffffaf77a14d RFL=00000256 [---ZAP-] CPL=0 II=0 A20=1 SMM=0 HLT=0
>   ES =0000 0000000000000000 00000000 00000000
>   CS =0010 0000000000000000 ffffffff 00a09b00 DPL=0 CS64 [-RA]
>   SS =0018 0000000000000000 ffffffff 00c09300 DPL=0 DS   [-WA]
>   DS =0000 0000000000000000 00000000 00000000
>   FS =0000 00007f997da3fec0 00000000 00000000
>   GS =0000 ffff8eab0535d000 00000000 00000000
>   LDT=0000 fffffe7600000000 00000000 00000000
>   TR =0040 fffffe767cf8f000 00004087 00008b00 DPL=0 TSS64-busy
>   GDT=     fffffe767cf8d000 0000007f
>   IDT=     fffffe0000000000 00000fff
>   CR0=80050033 CR2=000055fd193a6468 CR3=000000010930c000 CR4=00350ef0
>   DR0=0000000000000000 DR1=0000000000000000 DR2=0000000000000000 DR3=0000000000000000
>   DR6=00000000ffff0ff0 DR7=0000000000000400
>   EFER=0000000000001d01
>   Code=0f 1f 44 00 00 48 8b 4f 10 48 8b 41 08 48 89 c2 48 c1 ea 20 <48> 0f c7 61 40 31 c0 48 8b 47 10 f6 80 40 02 00 00 c0 74 1e 48 8b 05 98 f8 e8 01 48 89 47
> 
> This series keeps the existing MMIO dispatcher, but turns the fixed
> window into a container and (when the window maps linearly to a Type-3
> volatile memdev) overlays a RAM alias so KVM can create a memslot for
> the range. The mapping is updated when HDM decoders are
> committed/uncommitted by the guest.
> 
> This patchset is based on master branch 559919ce54927d59b215a4665eda7ab6118a48aa
> 
> Local validation on this base confirmed that the issue reproduces
> without the series and is fixed with the 3 patches below.
> 
> Li Chen (3):
>   cxl/type3: expose vmem mapping for fixed windows
>   cxl: alias fixed memory windows to RAM under KVM
>   cxl: update fixed window mappings on decoder programming
> 
>  hw/cxl/cxl-component-utils.c |   2 +
>  hw/cxl/cxl-host-stubs.c      |   1 +
>  hw/cxl/cxl-host.c            | 189 ++++++++++++++++++++++++++++++++++-
>  hw/mem/cxl_type3.c           |  59 +++++++++++
>  include/hw/cxl/cxl.h         |   5 +
>  include/hw/cxl/cxl_device.h  |   3 +
>  include/hw/cxl/cxl_host.h    |   1 +
>  7 files changed, 258 insertions(+), 2 deletions(-)
> 

