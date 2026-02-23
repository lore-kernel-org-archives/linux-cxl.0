Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41CA2E63C
	for <linux-cxl@vger.kernel.org>; Mon, 23 Feb 2026 11:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771844483; cv=none; b=bQ9QCHTp9cuqWAvbQQ3oEliB2TQrnjw9x+EsOFKU8Y1l9/6efusZNgGZM/29/Vsn+M+IjZD4kMi1+d0GfxMturcKVrR7vguGoSyEe65gPvchkVbJx54H2y7SIIjm6xwoaZW/J1jKtEZWLYcv6KLDLhu705p26VhM7bk72k3L+sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771844483; c=relaxed/simple;
	bh=7kVZxD9S+H1GWtBc5sUZE5wEKsFKUvQVVB/Ew0acbmc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gP7p3pwJ3VX+vp/n6q6YpT+k5DNeMjzR7H+B9YIfw1THo3/4DdrXBkjMLAWbZncUVEa98hsQso318wtshqaWZrqWiVCHTipe3XkVgls3+yjf8ehQPviCXODN60e1Uo89YwOBa4cuqNDBKoJZNLucd18hP3Z9fzpkFxwL3h5K0JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fKHvQ08qDzHnGgC;
	Mon, 23 Feb 2026 19:00:34 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id D183F40584;
	Mon, 23 Feb 2026 19:01:11 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 23 Feb
 2026 11:01:10 +0000
Date: Mon, 23 Feb 2026 11:01:09 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: <qemu-devel@nongnu.org>, Arpit Kumar <arpit1.kumar@samsung.com>,
	<linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>, Ravi Shankar
	<venkataravis@micron.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
	Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH qemu v5 0/3] hw/cxl: FM-API Physical Switch Command Set
 Support.
Message-ID: <20260223110109.00007691@huawei.com>
In-Reply-To: <20260220075818-mutt-send-email-mst@kernel.org>
References: <20260204173223.44122-1-Jonathan.Cameron@huawei.com>
	<20260220075818-mutt-send-email-mst@kernel.org>
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
 dubpeml500005.china.huawei.com (7.214.145.207)

On Fri, 20 Feb 2026 07:58:49 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Wed, Feb 04, 2026 at 05:32:20PM +0000, Jonathan Cameron wrote:
> > Changes since v4:
> > https://lore.kernel.org/qemu-devel/20250916080736.1266083-1-arpit1.kumar@samsung.com/
> > - Dropped initial refactor. Reason being that it is not static enough
> >   for caching at boot to be appropriate.  Kept the spec update part
> >   of this.
> > - Added a patch to make sure the new flip mode stuff is reported in
> >   the Get Physical Port State command.
> > - Rebased Arpit's Physical Control Control FMAPI Command given drop
> >   of the major refactor from v4 patch 1.
> > 
> > I had taken this into my cxl staging tree thinking it only needed a few
> > minor tweaks.  Then whilst testing I realized it didn't work with hotplug
> > and that made me consider if Arpit's original approach made sense.
> > 
> > So this is my proposal on how to take this forwards. Note that this is
> > not ready for merge (probably) just yet as I'd like Arpit to take a
> > look at the changes.  
> 
> I'd appreciate it if you add rfc in the subject in such cases.
> Thanks!

Will do.

Arpit is happy with this, so now I think main thing it needs is review of the
PCI interactions and the resets.  They seem fine to me but I'm not that
familiar with that stuff so am relying on PCI / reset experts.

That part is all in patch 3.  If you are happy with that part, then I'm
very much in favor of merging this.

Jonathan

> 
> >  I went through a version that had major refactors
> > to push the logic of building the records to the ports themselves, but
> > in the end don't think that brings enough benefits for the complexity.
> > 
> > Based on:
> > https://lore.kernel.org/qemu-devel/20260204170936.43959-1-Jonathan.Cameron@huawei.com/T/#t
> > (with all it's precursors, though hopefully they will all be in Michael's
> > next pull request)
> > 
> > I'll note this is an enormous foot gun as it lets you effectively trigger
> > surprise device resets.  However, it's only accessible if you are using
> > a configuration with the fabric management parts of the CXL emulation.
> > For now that is a switch-cci (MCTP over USB support is near the top
> > of my list of things to get ready for upstram.  I tested this with a
> > custom driver and if nothing else it exposed some gaps in Linux's
> > ability to rescan PCI buses after a perst event (even with drivers
> > unbound etc to make it safe).
> > 
> > Original cover letter:
> > 
> > This patch series refactor existing support for Identify Switch Device
> > and Get Physical Port State by utilizing physical ports (USP & DSP)
> > information stored during enumeration.
> > 
> > Additionally, it introduces new support for Physical Port Control
> > of Physical Switch Command Set as per CXL spec r3.2 Section 7.6.7.1.3.
> > It primarily constitutes two logic:
> >     -Assert-Deassert PERST: Assert PERST involves physical port to be in
> >      hold reset phase for minimum 100ms. No other physical port control
> >      request are entertained until Deassert PERST command for the given
> >      port is issued.
> >     -Reset PPB: cold reset of physical port (completing enter->hold->exit
> >      phases).
> > 
> > Tested using libcxl-mi interface[1]:
> > All active ports and all opcodes per active port is tested. Also, tested
> > against possible edge cases manually since the interface currently dosen't
> > support run time input.
> > 
> > Typical Qemu topology
> > (1 USP + 3 DSP's in a switch with 2 CXLType3 devices connected to the 2 DSP's):
> > FM="-object memory-backend-file,id=cxl-mem1,mem-path=$TMP_DIR/t3_cxl1.raw,size=256M \
> >     -object memory-backend-file,id=cxl-lsa1,mem-path=$TMP_DIR/t3_lsa1.raw,size=1M \
> >     -object memory-backend-file,id=cxl-mem2,mem-path=$TMP_DIR/t3_cxl2.raw,size=512M \
> >     -object memory-backend-file,id=cxl-lsa2,mem-path=$TMP_DIR/t3_lsa2.raw,size=512M \
> >     -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1,hdm_for_passthrough=true \
> >     -device cxl-rp,port=0,bus=cxl.1,id=cxl_rp_port0,chassis=0,slot=2 \
> >     -device cxl-upstream,port=2,sn=1234,bus=cxl_rp_port0,id=us0,addr=0.0,multifunction=on, \
> >     -device cxl-switch-mailbox-cci,bus=cxl_rp_port0,addr=0.1,target=us0 \
> >     -device cxl-downstream,port=0,bus=us0,id=swport0,chassis=0,slot=4 \
> >     -device cxl-downstream,port=1,bus=us0,id=swport1,chassis=0,slot=5 \
> >     -device cxl-downstream,port=3,bus=us0,id=swport2,chassis=0,slot=6 \
> >     -device cxl-type3,bus=swport0,memdev=cxl-mem1,id=cxl-pmem1,lsa=cxl-lsa1,sn=3 \
> >     -device cxl-type3,bus=swport2,memdev=cxl-mem2,id=cxl-pmem2,lsa=cxl-lsa2,sn=4 \
> >     -machine cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=1k \
> >     -device i2c_mctp_cxl,bus=aspeed.i2c.bus.0,address=4,target=us0 \
> >     -device i2c_mctp_cxl,bus=aspeed.i2c.bus.0,address=5,target=cxl-pmem1 \
> >     -device i2c_mctp_cxl,bus=aspeed.i2c.bus.0,address=6,target=cxl-pmem2 \
> >     -device virtio-rng-pci,bus=swport1"
> > 
> > Tested multiple Qemu topologies:
> >         -without any devices connected to downstream ports.
> >         -with virtio-rng-pci devices connected to downstream ports.
> >         -with CXLType3 devices connected to downstream ports.
> >         -with different unique values of ports (both upstream and downstream).
> > 
> > Changes from v3 (https://lore.kernel.org/qemu-devel/20250909160316.00000190@huawei.com/T/):
> >         -Namespaced the defines with cleaner prefix for Get Physical Port State 
> >          Port Information Block members.
> >         -switch CCI implementation instead of switch FM interface as per
> >          Jonathan's review comments, hence moved perst members initializations
> >          from: cxl_initialize_usp_mctpcci() -> cxl_initialize_mailbox_swcci().
> > 
> > [1] https://github.com/computexpresslink/libcxlmi/commit/35fe68bd9a31469f832a87694d7b18d2d50be5b8
> > 
> > 
> > Arpit Kumar (2):
> >   hw/cxl: Physical Port Info FMAPI - update to current spec and add
> >     defines.
> >   hw/cxl: Add Physical Port Control FMAPI Command (Opcode 5102h)
> > 
> > Jonathan Cameron (1):
> >   hw/cxl: Get Physical Port State - update for PCIe flit mode
> > 
> >  include/hw/cxl/cxl_port.h                   |  73 ++++++++
> >  include/hw/pci-bridge/cxl_downstream_port.h |  12 ++
> >  include/hw/pci-bridge/cxl_upstream_port.h   |   2 +
> >  hw/cxl/cxl-mailbox-utils.c                  | 183 ++++++++++++++++++--
> >  hw/pci-bridge/cxl_downstream.c              |   9 +
> >  hw/pci-bridge/cxl_upstream.c                |   1 +
> >  6 files changed, 268 insertions(+), 12 deletions(-)
> >  create mode 100644 include/hw/cxl/cxl_port.h
> >  create mode 100644 include/hw/pci-bridge/cxl_downstream_port.h
> > 
> > -- 
> > 2.51.0  
> 
> 
> 

