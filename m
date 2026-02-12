Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B27912CD8B
	for <linux-cxl@vger.kernel.org>; Mon, 16 Feb 2026 03:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771213095; cv=none; b=RZIqwewEAAyWm1pNkrYF3HOwNV9Z52/Q/Mp4HP+VajZKpam6l4WkLPRSPMdBGFBBlJxi4FaCOxJaUTVtw+Vc8BMdhedEXH2lO98d1oENn5JlO4QQ5dJuDMCNhsMBB0pdiObS1pGyNASk7LpCGUwQ829h4pZeErAFPSvJOIsum1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771213095; c=relaxed/simple;
	bh=eaO4mh7eXX+z6Tfb4u6klLOvG95el/ihIJM1XwVHdP4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=FOpy1FrQIRccLDBnaLeHeoyz8pftBksHvUZO8PZbD621uuR8SO5SMzftqwgmx5wA+t3RTApHXhE6+/zADJt3Wzk0fxGDcE2koYv+gzF01itat0bOaION56eC53G0h0c1A4tp/x32AfPShc25b4jMN6zuExuyqRoC1Kgt+22qy/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=DFRG3zb+; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="DFRG3zb+"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20260216033803epoutp0172caa875e75e0b7c9888b1a01928d7e0~UnOpJVsNC3185331853epoutp01D
	for <linux-cxl@vger.kernel.org>; Mon, 16 Feb 2026 03:38:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20260216033803epoutp0172caa875e75e0b7c9888b1a01928d7e0~UnOpJVsNC3185331853epoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1771213083;
	bh=pe9N10QZ1PgdodPdS9MuiyL7sz4CczU1cVJ7wS2DTBQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DFRG3zb+ApDjiELTqdE+podN/WZp1vOEC+Sc3rnA9Csv9XA/ICOaxY07RPMeDJ4sS
	 y584sGqP7TNcBaC7zm9oyvAjMhZSE1+uC4yIr+xm9A6T93FsVusNdpq036snx31+Rq
	 Xm1k2dUfoAhWkqRaSBsS0n+B/0CGWNrO1yeSYybs=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20260216033802epcas5p14c2bb6d81cbb45aa6c1a8e94537d7080~UnOoXnMl02067920679epcas5p1I;
	Mon, 16 Feb 2026 03:38:02 +0000 (GMT)
Received: from epcpadp2new (unknown [182.195.40.142]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4fDpQ24hXfz3hhT7; Mon, 16 Feb
	2026 03:38:02 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20260212151259epcas5p2364104fe9a48c7673863df040dacbfef~TiIQ6K-bF0346603466epcas5p2K;
	Thu, 12 Feb 2026 15:12:59 +0000 (GMT)
Received: from test-PowerEdge-R740xd (unknown [107.99.41.79]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260212151258epsmtip29706fcaa531403086d5f8b2e2e56080a~TiIPkR8-T1642816428epsmtip27;
	Thu, 12 Feb 2026 15:12:58 +0000 (GMT)
Date: Thu, 12 Feb 2026 20:42:48 +0530
From: Arpit Kumar <arpit1.kumar@samsung.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Michael Tsirkin <mst@redhat.com>, qemu-devel@nongnu.org,
	linuxarm@huawei.com, linux-cxl@vger.kernel.org, Ravi Shankar
	<venkataravis@micron.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
	Michael Roth <michael.roth@amd.com>, Arpit Kumar <arpit.sysdev@gmail.com>,
	cpgs@samsung.com
Subject: Re: [PATCH qemu v5 0/3] hw/cxl: FM-API Physical Switch Command Set
 Support.
Message-ID: <1983025922.01771213082649.JavaMail.epsvc@epcpadp2new>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260204173223.44122-1-Jonathan.Cameron@huawei.com>
X-CMS-MailID: 20260212151259epcas5p2364104fe9a48c7673863df040dacbfef
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----f7ViTShqWaH4cwb2QsCnImCOZYtOsWzJ0r_VhhicrZgGstIh=_1e05f_"
CMS-TYPE: 105P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20260212151259epcas5p2364104fe9a48c7673863df040dacbfef
References: <20260204173223.44122-1-Jonathan.Cameron@huawei.com>
	<CGME20260212151259epcas5p2364104fe9a48c7673863df040dacbfef@epcas5p2.samsung.com>

------f7ViTShqWaH4cwb2QsCnImCOZYtOsWzJ0r_VhhicrZgGstIh=_1e05f_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 04/02/26 05:32PM, Jonathan Cameron wrote:
>Changes since v4:
>https://lore.kernel.org/qemu-devel/20250916080736.1266083-1-arpit1.kumar@samsung.com/
>- Dropped initial refactor. Reason being that it is not static enough
>  for caching at boot to be appropriate.  Kept the spec update part
>  of this.
>- Added a patch to make sure the new flip mode stuff is reported in
>  the Get Physical Port State command.
>- Rebased Arpit's Physical Control Control FMAPI Command given drop
>  of the major refactor from v4 patch 1.
>
>I had taken this into my cxl staging tree thinking it only needed a few
>minor tweaks.  Then whilst testing I realized it didn't work with hotplug
>and that made me consider if Arpit's original approach made sense.
>
>So this is my proposal on how to take this forwards. Note that this is
>not ready for merge (probably) just yet as I'd like Arpit to take a
>look at the changes.  I went through a version that had major refactors
>to push the logic of building the records to the ports themselves, but
>in the end don't think that brings enough benefits for the complexity.
>

Hi Jonathan,
Thanks for the patch series. I have reviewed the changes in detail, and
the approach looks good to me. Thanks for the rework and keeping me in
the loop.

>Based on:
>https://lore.kernel.org/qemu-devel/20260204170936.43959-1-Jonathan.Cameron@huawei.com/T/#t
>(with all it's precursors, though hopefully they will all be in Michael's
>next pull request)
>
>I'll note this is an enormous foot gun as it lets you effectively trigger
>surprise device resets.  However, it's only accessible if you are using
>a configuration with the fabric management parts of the CXL emulation.
>For now that is a switch-cci (MCTP over USB support is near the top
>of my list of things to get ready for upstram.  I tested this with a
>custom driver and if nothing else it exposed some gaps in Linux's
>ability to rescan PCI buses after a perst event (even with drivers
>unbound etc to make it safe).
>
>Original cover letter:
>
>This patch series refactor existing support for Identify Switch Device
>and Get Physical Port State by utilizing physical ports (USP & DSP)
>information stored during enumeration.
>
>Additionally, it introduces new support for Physical Port Control
>of Physical Switch Command Set as per CXL spec r3.2 Section 7.6.7.1.3.
>It primarily constitutes two logic:
>    -Assert-Deassert PERST: Assert PERST involves physical port to be in
>     hold reset phase for minimum 100ms. No other physical port control
>     request are entertained until Deassert PERST command for the given
>     port is issued.
>    -Reset PPB: cold reset of physical port (completing enter->hold->exit
>     phases).
>
>Tested using libcxl-mi interface[1]:
>All active ports and all opcodes per active port is tested. Also, tested
>against possible edge cases manually since the interface currently dosen't
>support run time input.
>
>Typical Qemu topology
>(1 USP + 3 DSP's in a switch with 2 CXLType3 devices connected to the 2 DSP's):
>FM="-object memory-backend-file,id=cxl-mem1,mem-path=$TMP_DIR/t3_cxl1.raw,size=256M \
>    -object memory-backend-file,id=cxl-lsa1,mem-path=$TMP_DIR/t3_lsa1.raw,size=1M \
>    -object memory-backend-file,id=cxl-mem2,mem-path=$TMP_DIR/t3_cxl2.raw,size=512M \
>    -object memory-backend-file,id=cxl-lsa2,mem-path=$TMP_DIR/t3_lsa2.raw,size=512M \
>    -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1,hdm_for_passthrough=true \
>    -device cxl-rp,port=0,bus=cxl.1,id=cxl_rp_port0,chassis=0,slot=2 \
>    -device cxl-upstream,port=2,sn=1234,bus=cxl_rp_port0,id=us0,addr=0.0,multifunction=on, \
>    -device cxl-switch-mailbox-cci,bus=cxl_rp_port0,addr=0.1,target=us0 \
>    -device cxl-downstream,port=0,bus=us0,id=swport0,chassis=0,slot=4 \
>    -device cxl-downstream,port=1,bus=us0,id=swport1,chassis=0,slot=5 \
>    -device cxl-downstream,port=3,bus=us0,id=swport2,chassis=0,slot=6 \
>    -device cxl-type3,bus=swport0,memdev=cxl-mem1,id=cxl-pmem1,lsa=cxl-lsa1,sn=3 \
>    -device cxl-type3,bus=swport2,memdev=cxl-mem2,id=cxl-pmem2,lsa=cxl-lsa2,sn=4 \
>    -machine cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=1k \
>    -device i2c_mctp_cxl,bus=aspeed.i2c.bus.0,address=4,target=us0 \
>    -device i2c_mctp_cxl,bus=aspeed.i2c.bus.0,address=5,target=cxl-pmem1 \
>    -device i2c_mctp_cxl,bus=aspeed.i2c.bus.0,address=6,target=cxl-pmem2 \
>    -device virtio-rng-pci,bus=swport1"
>
>Tested multiple Qemu topologies:
>        -without any devices connected to downstream ports.
>        -with virtio-rng-pci devices connected to downstream ports.
>        -with CXLType3 devices connected to downstream ports.
>        -with different unique values of ports (both upstream and downstream).
>
>Changes from v3 (https://lore.kernel.org/qemu-devel/20250909160316.00000190@huawei.com/T/):
>        -Namespaced the defines with cleaner prefix for Get Physical Port State
>         Port Information Block members.
>        -switch CCI implementation instead of switch FM interface as per
>         Jonathan's review comments, hence moved perst members initializations
>         from: cxl_initialize_usp_mctpcci() -> cxl_initialize_mailbox_swcci().
>
>[1] https://github.com/computexpresslink/libcxlmi/commit/35fe68bd9a31469f832a87694d7b18d2d50be5b8
>
>
>Arpit Kumar (2):
>  hw/cxl: Physical Port Info FMAPI - update to current spec and add
>    defines.
>  hw/cxl: Add Physical Port Control FMAPI Command (Opcode 5102h)
>
>Jonathan Cameron (1):
>  hw/cxl: Get Physical Port State - update for PCIe flit mode
>
> include/hw/cxl/cxl_port.h                   |  73 ++++++++
> include/hw/pci-bridge/cxl_downstream_port.h |  12 ++
> include/hw/pci-bridge/cxl_upstream_port.h   |   2 +
> hw/cxl/cxl-mailbox-utils.c                  | 183 ++++++++++++++++++--
> hw/pci-bridge/cxl_downstream.c              |   9 +
> hw/pci-bridge/cxl_upstream.c                |   1 +
> 6 files changed, 268 insertions(+), 12 deletions(-)
> create mode 100644 include/hw/cxl/cxl_port.h
> create mode 100644 include/hw/pci-bridge/cxl_downstream_port.h
>
>-- 
>2.51.0
>

------f7ViTShqWaH4cwb2QsCnImCOZYtOsWzJ0r_VhhicrZgGstIh=_1e05f_
Content-Type: text/plain; charset="utf-8"


------f7ViTShqWaH4cwb2QsCnImCOZYtOsWzJ0r_VhhicrZgGstIh=_1e05f_--

