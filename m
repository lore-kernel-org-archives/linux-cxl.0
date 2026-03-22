Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38361A267
	for <linux-cxl@vger.kernel.org>; Sun, 22 Mar 2026 05:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774158580; cv=pass; b=P4DUqcKEIJe1I/ysfaZpSpPTiuCuzOqK/I2NVYR9FQG0H2hOvgmMUX9ne8R3wio3ZUCC2LswqShM+ZFvhFTDmb8RFeL/+FV7hYuTfq/ktGc9NwBr/Dcd5gz3FFfD3EJ+MOQcEH6Eio09y7WKoY9YG1/GzAVte/nn3KmCkkaMCaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774158580; c=relaxed/simple;
	bh=JdrQGPrIl5kc5XC8VfMEtQDy7VeidPsiGnjeWUmUztM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=rY0mASNXgKi8Z6r4HrkA4ogE+0UfBuA/0kHEjyfunu9QwFDjBPLnGXKFixn5POFyQdWfXXpPW0qbTK/TbxegkdwLvB34RcFa9U4/iWmXBINTke/zj/zHM+XOe33iAwmBFdA1hOuv5CShxGCR6QWE/RmDAoz6yjiqmM7CuDp8rX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=iRfIwmmD; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="iRfIwmmD"
ARC-Seal: i=1; a=rsa-sha256; t=1774158564; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=eKoQrLjr14G8bYeYYF4HDA3B4QriTKJMSvmErVcrwas3XH3QjZY55ROsNkeFyklEMpZ7HGWZkY2ykauKW6pPI6L/1bz0540raHpfla8dPPpJybVcjP+qezd2YtSUMGDmwUDT0sOhDU1xh021VaWOw6Q/OzhWjun+zn+rClwfrns=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1774158564; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=6o6bBpCocH45Wo/Gv/hO1GPZHn0BZZn4GmfTpVDe6Oo=; 
	b=hfRgdjQWsU37frxf7zXopwbO7DvQa2MPyYSJw7yXbJ7k6v/wfSwdIBMdQyWiSZQw/Rdr9NqibikknsrHt6+CtV3izP/+W6ZrPoTBp+8CdQ8uQ+byB8FbXPPBblBUm7rWV03pXs8K0qoX1l/KYooMMJOFlyPlFJPPtctyGANSWvM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774158564;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=6o6bBpCocH45Wo/Gv/hO1GPZHn0BZZn4GmfTpVDe6Oo=;
	b=iRfIwmmD1c2GAoeP2IYIqURn/B0/ilw5vVYCrhH/TVQ1t/JGb8Dzof1IWzzuuWzz
	Dhi6VyAxmsnwJkkmg9KJek0ogYuAod9vJQClqqmpZURxHpYi241/f8Cg2iiW/zjgBEv
	Psx9bO7XoenZ0JDqAAWoHR55PyBCptIjZxJ7EN+0=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1774158562915609.4080264699327; Sat, 21 Mar 2026 22:49:22 -0700 (PDT)
Date: Sun, 22 Mar 2026 13:49:22 +0800
From: Li Chen <me@linux.beauty>
To: "Jonathan Cameron" <jonathan.cameron@huawei.com>
Cc: "Fan Ni" <fan.ni@samsung.com>, "qemu-devel" <qemu-devel@nongnu.org>,
	"alireza.sanaee" <alireza.sanaee@huawei.com>,
	"linux-cxl" <linux-cxl@vger.kernel.org>
Message-ID: <19d14174653.62e333dc1235182.8831443129363062828@linux.beauty>
In-Reply-To: <20260317165702.00003c98@huawei.com>
References: <20260317033304.3185291-1-me@linux.beauty> <20260317165702.00003c98@huawei.com>
Subject: Re: [PATCH 0/3] cxl: avoid KVM internal error for fixed memory
 windows
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

Hi Jonathan,

 ---- On Wed, 18 Mar 2026 00:57:02 +0800  Jonathan Cameron <jonathan.cameron@huawei.com> wrote --- 
 > On Tue, 17 Mar 2026 11:33:00 +0800
 > Li Chen <me@linux.beauty> wrote:
 > 
 > > CXL fixed memory windows are currently modeled as an I/O MemoryRegion.
 > > When running under KVM, this makes the entire window look like MMIO.
 > > If Linux onlines the window as system RAM (e.g. for a CXL Type-3
 > > volatile memdev), normal CPU stores into the window trigger KVM
 > > instruction emulation. Instructions like XSAVEC are not supported by
 > > the emulator and abort the VM with a KVM internal error.
 > > 
 > > Repro:
 > >   - Boot a guest with a CXL Type-3 volatile memdev and a fixed memory window.
 > >   - In the guest, create a RAM region and online it as system RAM:
 > >       cxl create-region -m -t ram -d decoder0.0 -w 1 -g 4096 mem0
 > >   - QEMU exits with a KVM internal error.
 > 
 > Hi Li Chen,
 > 
 > At least at first look this looks very like:
 > 
 > https://lore.kernel.org/qemu-devel/20260306121151.883-1-alireza.sanaee@huawei.com/

Yes, I have tested the patchset, and it can addresses my issue. 
Thank you very much for the information!

Regards,
Li

 > Which was ready for merge as far as I was concerned, but missed getting queued for
 > 11.0 (as last PCI pull request had gone) and is currently ready to go in next cycle.
 > 
 > Please see if that works for your case. If there are improvements I'd prefer
 > to see them applied on top of that series than reinventing what I think
 > is the same thing.
 > 
 > It's not KVM specific as linear mappings (when valid) bring huge performance
 > benefits on TCG as well as correctness for KVM.
 > 
 > Jonathan
 > 
 > +CC linux-cxl which is where CXL folk tend to hang out in larger numbers
 > than on the qemu list.
 > 
 > 
 > 
 > > 
 > > Serial output excerpt:
 > >   KVM internal error. Suberror: 1
 > >   extra data[0]: 0x0000000000000001
 > >   extra data[1]: 0xc0314061c70f480f
 > >   extra data[2]: 0x024080f610478b48
 > >   extra data[3]: 0x0000000000000400
 > >   extra data[4]: 0x000000010000000f
 > >   extra data[5]: 0x00000004a0003140
 > >   extra data[6]: 0x0000000000000000
 > >   extra data[7]: 0x0000000000000000
 > >   emulation failure
 > >   RAX=0000000000000007 RBX=ffff8eace0001a40 RCX=ffff8eace0003100 RDX=0000000000000000
 > >   RSI=0000000000000007 RDI=ffff8eace00030c0 RBP=ffffd48ac1747c08 RSP=ffffd48ac1747bc8
 > >   R8 =0000000000000007 R9 =0000000000000007 R10=000000000000000d R11=0000000000000000
 > >   R12=ffff8ea945b51a40 R13=ffffd48ac166c000 R14=0000000000000000 R15=0000000001200000
 > >   RIP=ffffffffaf77a14d RFL=00000256 [---ZAP-] CPL=0 II=0 A20=1 SMM=0 HLT=0
 > >   ES =0000 0000000000000000 00000000 00000000
 > >   CS =0010 0000000000000000 ffffffff 00a09b00 DPL=0 CS64 [-RA]
 > >   SS =0018 0000000000000000 ffffffff 00c09300 DPL=0 DS   [-WA]
 > >   DS =0000 0000000000000000 00000000 00000000
 > >   FS =0000 00007f997da3fec0 00000000 00000000
 > >   GS =0000 ffff8eab0535d000 00000000 00000000
 > >   LDT=0000 fffffe7600000000 00000000 00000000
 > >   TR =0040 fffffe767cf8f000 00004087 00008b00 DPL=0 TSS64-busy
 > >   GDT=     fffffe767cf8d000 0000007f
 > >   IDT=     fffffe0000000000 00000fff
 > >   CR0=80050033 CR2=000055fd193a6468 CR3=000000010930c000 CR4=00350ef0
 > >   DR0=0000000000000000 DR1=0000000000000000 DR2=0000000000000000 DR3=0000000000000000
 > >   DR6=00000000ffff0ff0 DR7=0000000000000400
 > >   EFER=0000000000001d01
 > >   Code=0f 1f 44 00 00 48 8b 4f 10 48 8b 41 08 48 89 c2 48 c1 ea 20 <48> 0f c7 61 40 31 c0 48 8b 47 10 f6 80 40 02 00 00 c0 74 1e 48 8b 05 98 f8 e8 01 48 89 47
 > > 
 > > This series keeps the existing MMIO dispatcher, but turns the fixed
 > > window into a container and (when the window maps linearly to a Type-3
 > > volatile memdev) overlays a RAM alias so KVM can create a memslot for
 > > the range. The mapping is updated when HDM decoders are
 > > committed/uncommitted by the guest.
 > > 
 > > This patchset is based on master branch 559919ce54927d59b215a4665eda7ab6118a48aa
 > > 
 > > Local validation on this base confirmed that the issue reproduces
 > > without the series and is fixed with the 3 patches below.
 > > 
 > > Li Chen (3):
 > >   cxl/type3: expose vmem mapping for fixed windows
 > >   cxl: alias fixed memory windows to RAM under KVM
 > >   cxl: update fixed window mappings on decoder programming
 > > 
 > >  hw/cxl/cxl-component-utils.c |   2 +
 > >  hw/cxl/cxl-host-stubs.c      |   1 +
 > >  hw/cxl/cxl-host.c            | 189 ++++++++++++++++++++++++++++++++++-
 > >  hw/mem/cxl_type3.c           |  59 +++++++++++
 > >  include/hw/cxl/cxl.h         |   5 +
 > >  include/hw/cxl/cxl_device.h  |   3 +
 > >  include/hw/cxl/cxl_host.h    |   1 +
 > >  7 files changed, 258 insertions(+), 2 deletions(-)
 > > 
 > 
 > 

