Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E2E296BD1
	for <linux-cxl@vger.kernel.org>; Fri,  5 Sep 2025 16:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757088779; cv=none; b=luDHSvDsbNo1QWQ8jbg14Gq4uEq9GuIJ4wGUdMqcivysfVQ3mi7pkosVaXTzLuNBrKfmRxYv1lOJUNTbWXBvteP1d5ya5mVcGplrsSfRbtBf1mXqWgECUhfZo70xEKeYT9c4h/8mwqKtZTD/FXMe7jXn8ugpFsLTtZ/fwtX33vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757088779; c=relaxed/simple;
	bh=MeDnUccs0jXuWHkKBgfKoxxTdl/BC/MdNg91y59cM5A=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cSf657PGWbjZUVTr1ISiicsodqk9SWjP83vIxHdR8excMk+d9DdP2IQVk5oh46sXnqjbPXCM4eGaQ/RtcdeziV/4Ci6dlCE77P3aSt4WQFCsF67kXAa8XWhmXPeuNo3RAfLh5gUBwdcHXN0K85bdXdKX30oeUJE+6SiYdi+bxdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cJLsp6Nj1z6M54c;
	Sat,  6 Sep 2025 00:10:22 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 57554140159;
	Sat,  6 Sep 2025 00:12:54 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 5 Sep
 2025 18:12:53 +0200
Date: Fri, 5 Sep 2025 17:12:52 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Arpit Kumar <arpit1.kumar@samsung.com>
CC: <qemu-devel@nongnu.org>, <gost.dev@samsung.com>,
	<linux-cxl@vger.kernel.org>, <dave@stgolabs.net>, <vishak.g@samsung.com>,
	<krish.reddy@samsung.com>, <a.manzanares@samsung.com>,
	<alok.rathore@samsung.com>, <cpgs@samsung.com>
Subject: Re: [PATCH v3 0/2] FM-API Physical Switch Command Set Support
Message-ID: <20250905171252.00004c72@huawei.com>
In-Reply-To: <20250904131904.725758-1-arpit1.kumar@samsung.com>
References: <CGME20250904131926epcas5p2a363cf0604a4801038d32e7da5397da1@epcas5p2.samsung.com>
	<20250904131904.725758-1-arpit1.kumar@samsung.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu,  4 Sep 2025 18:49:02 +0530
Arpit Kumar <arpit1.kumar@samsung.com> wrote:

> This patch series refactor existing support for Identify Switch Device
> and Get Physical Port State by utilizing physical ports (USP & DSP)
> information stored during enumeration. 
> 
> Additionally, it introduces new support for Physical Port Control
> of FM-API based physical switch command set as per CXL spec r3.2 
> Table 8-230:Physical Switch. It primarily constitutes two logic:
> -Assert-Deassert PERST: Assert PERST involves physical port to be in 
>  hold reset phase for minimum 100ms. No other physical port control
>  request are entertained until Deassert PERST command for the given 
>  port is issued.
> -Reset PPB: cold reset of physical port (completing enter->hold->exit phases).
> 
> Tested using libcxl-mi interface[1]:
> All active ports and all opcodes per active port is tested. Also, tested
> against possible edge cases manually since the interface currently dosen't
> support run time input.
> 
> Example topology (1 USP + 3 DSP's->switch with 2 CXLType3 devices connected
> to 2 DSP's):
> FM="-object memory-backend-file,id=cxl-mem1,mem-path=$TMP_DIR/t3_cxl1.raw,size=256M \
>     -object memory-backend-file,id=cxl-lsa1,mem-path=$TMP_DIR/t3_lsa1.raw,size=1M \
>     -object memory-backend-file,id=cxl-mem2,mem-path=$TMP_DIR/t3_cxl2.raw,size=512M \
>     -object memory-backend-file,id=cxl-lsa2,mem-path=$TMP_DIR/t3_lsa2.raw,size=512M \
>     -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1,hdm_for_passthrough=true \
>     -device cxl-rp,port=0,bus=cxl.1,id=cxl_rp_port0,chassis=0,slot=2 \
>     -device cxl-upstream,port=2,sn=1234,bus=cxl_rp_port0,id=us0,addr=0.0,multifunction=on, \
>     -device cxl-switch-mailbox-cci,bus=cxl_rp_port0,addr=0.1,target=us0 \
>     -device cxl-downstream,port=0,bus=us0,id=swport0,chassis=0,slot=4 \
>     -device cxl-downstream,port=1,bus=us0,id=swport1,chassis=0,slot=5 \
>     -device cxl-downstream,port=3,bus=us0,id=swport2,chassis=0,slot=6 \
>     -device cxl-type3,bus=swport0,memdev=cxl-mem1,id=cxl-pmem1,lsa=cxl-lsa1,sn=3 \
>     -device cxl-type3,bus=swport2,memdev=cxl-mem2,id=cxl-pmem2,lsa=cxl-lsa2,sn=4 \
>     -machine cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=1k \
>     -device i2c_mctp_cxl,bus=aspeed.i2c.bus.0,address=4,target=us0 \
>     -device i2c_mctp_cxl,bus=aspeed.i2c.bus.0,address=5,target=cxl-pmem1 \
>     -device i2c_mctp_cxl,bus=aspeed.i2c.bus.0,address=6,target=cxl-pmem2 \
>     -device virtio-rng-pci,bus=swport1"
> 
> Multiple Qemu Topologies tested:
> -without any devices connected to downstream ports.
> -with virtio-rng-pci devices connected to downstream ports.
> -with CXLType3 devices connected to downstream ports.
> -with different unique values of ports (both upstream and downstream).
> 
> Changes from v2->v3:
> -cxl_set_port_type(): optimized storing of strucutre members.
> -namespace defines instead of enum.
> -Calculating size for active_port_bitmask than hardcoding to 0x20.
> -Defined struct phy_port directly inside struct CXLUpstreamPort as pports.
> -Renamed struct pperst to struct CXLPhyPortPerst.
> -Optimized perst member initializations for ports inside
>  cxl_initialize_usp_mctpcci() using active_port_bitmask.
> 
> [1] https://github.com/computexpresslink/libcxlmi/commit/35fe68bd9a31469f832a87694d7b18d2d50be5b8
> 
> The patches are generated against the Johnathan's tree
> https://gitlab.com/jic23/qemu.git and branch cxl-2025-07-03.
> 
> Signed-off-by: Arpit Kumar <arpit1.kumar@samsung.com>

Hi Arpit,

I'll have a go (probably next week) at rebasing this rather earlier in my tree as I'd
like to get this upstream without it having a dependency on the MCTP support.

That means bring it up with the switch-cci / pcie mailbox CCI and squashing
the MCTP bit into the patch that brings that support up later in my tree.

I do plan to fix up the remaining 'feature' gap on the FMAPI/MCTP/USB 
emulation which is that it's ignoring the MTU to the host and so not
breaking messages up as it should.  Linux doesn't care but maybe some other
OS will. Not entirely sure when I'll get to that though and I'd like to
move your work forward before that.

Jonathan


> 
> Arpit Kumar (2):
>   hw/cxl: Refactored Identify Switch Device & Get Physical Port State
>   hw/cxl: Add Physical Port Control (Opcode 5102h)
> 
>  hw/cxl/cxl-mailbox-utils.c                | 368 +++++++++++++++-------
>  include/hw/cxl/cxl_device.h               |  76 +++++
>  include/hw/cxl/cxl_mailbox.h              |   1 +
>  include/hw/pci-bridge/cxl_upstream_port.h |   9 +
>  4 files changed, 347 insertions(+), 107 deletions(-)
> 

