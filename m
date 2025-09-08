Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9D74A06
	for <linux-cxl@vger.kernel.org>; Mon,  8 Sep 2025 13:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757337747; cv=none; b=vALIihwSFBVTx3RtaCR8sdX9YweloLkBN8QbYpg9TlUpMmU/pmc9buRjPMMgisPUI+0tdNbWcoQ0kH7W5UVMRBk2kWBZq3T5fDDP6u1M6Tc5oeXmXAvBHs5jtqMdY3ZQbZeEHj+bbK+CPN//fHSug6lLF5KD9NgWJSYzgLuSTfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757337747; c=relaxed/simple;
	bh=dq0WjseikkQdLCONyEqbNgvzqGXvFhMJ7fDHWpYB9fo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=t6Ul/nGWzDkexRe9+RWlnCJUZCXgN3Tz4kIaHaZORK+ZBw9lHyYSS9IwjruPZT2e2DRw8ld0ihOw18+9bDV6dCGOk5P9t6gx4+rxeqSRIOmhRz0AQKllNMjeQvOTYBiy/8mjh/8tN2uxVDrN7XRu6WT/MZhqWqs3m+riYAautwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=vg63lgP9; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="vg63lgP9"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250908132220epoutp02fbe36d47741f0a37e4bd09e9e0697635~jUV1UhMgf1031610316epoutp02B
	for <linux-cxl@vger.kernel.org>; Mon,  8 Sep 2025 13:22:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250908132220epoutp02fbe36d47741f0a37e4bd09e9e0697635~jUV1UhMgf1031610316epoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1757337740;
	bh=knrzU4zTXN/S8XJVF6YHpcWSR50Tq3TSEQe5tajVzvg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vg63lgP9m5WtBYvjTpQZjdoWot1Rud8rC1IufjiJ6KqqdCULvHXaSjoOGvQ0ZOK2m
	 qkXEm7XpzID+l/mQ4eqx49neXjGqduTPqfPJWv+89rMJwJTRtrpnTIjnLRqNDL1vWl
	 AEYdN0pfz9spkqG+LZq1t7t6u5QfG1aOqZnzp4HU=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20250908132220epcas5p1ffbdbb4c9ef7992a034859d65dc0e254~jUV03-xw00535705357epcas5p1I;
	Mon,  8 Sep 2025 13:22:20 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.95]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4cL70W3RM7z3hhT8; Mon,  8 Sep
	2025 13:22:19 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250908132218epcas5p3d3ed20009f5c6b0dd6d09a3797ad734f~jUVzfyrT90755907559epcas5p3v;
	Mon,  8 Sep 2025 13:22:18 +0000 (GMT)
Received: from test-PowerEdge-R740xd (unknown [107.99.41.79]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250908132217epsmtip138506816a6dccb23b458d72e1d5a945d~jUVxyjzD82205422054epsmtip1D;
	Mon,  8 Sep 2025 13:22:16 +0000 (GMT)
Date: Mon, 8 Sep 2025 18:52:11 +0530
From: Arpit Kumar <arpit1.kumar@samsung.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: qemu-devel@nongnu.org, gost.dev@samsung.com, linux-cxl@vger.kernel.org,
	dave@stgolabs.net, vishak.g@samsung.com, krish.reddy@samsung.com,
	a.manzanares@samsung.com, alok.rathore@samsung.com, cpgs@samsung.com
Subject: Re: [PATCH v3 0/2] FM-API Physical Switch Command Set Support
Message-ID: <20250908132211.tusasxcwx45d474x@test-PowerEdge-R740xd>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250905171252.00004c72@huawei.com>
X-CMS-MailID: 20250908132218epcas5p3d3ed20009f5c6b0dd6d09a3797ad734f
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----6Bw0j5KOoRaxZeQKOp2dAcC2OKT3No9WZFWhMG37wfGsvvbi=_f7f1f_"
CMS-TYPE: 105P
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250904131926epcas5p2a363cf0604a4801038d32e7da5397da1
References: <CGME20250904131926epcas5p2a363cf0604a4801038d32e7da5397da1@epcas5p2.samsung.com>
	<20250904131904.725758-1-arpit1.kumar@samsung.com>
	<20250905171252.00004c72@huawei.com>

------6Bw0j5KOoRaxZeQKOp2dAcC2OKT3No9WZFWhMG37wfGsvvbi=_f7f1f_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 05/09/25 05:12PM, Jonathan Cameron wrote:
>On Thu,  4 Sep 2025 18:49:02 +0530
>Arpit Kumar <arpit1.kumar@samsung.com> wrote:
>
>> This patch series refactor existing support for Identify Switch Device
>> and Get Physical Port State by utilizing physical ports (USP & DSP)
>> information stored during enumeration.
>>
>> Additionally, it introduces new support for Physical Port Control
>> of FM-API based physical switch command set as per CXL spec r3.2
>> Table 8-230:Physical Switch. It primarily constitutes two logic:
>> -Assert-Deassert PERST: Assert PERST involves physical port to be in
>>  hold reset phase for minimum 100ms. No other physical port control
>>  request are entertained until Deassert PERST command for the given
>>  port is issued.
>> -Reset PPB: cold reset of physical port (completing enter->hold->exit phases).
>>
>> Tested using libcxl-mi interface[1]:
>> All active ports and all opcodes per active port is tested. Also, tested
>> against possible edge cases manually since the interface currently dosen't
>> support run time input.
>>
>> Example topology (1 USP + 3 DSP's->switch with 2 CXLType3 devices connected
>> to 2 DSP's):
>> FM="-object memory-backend-file,id=cxl-mem1,mem-path=$TMP_DIR/t3_cxl1.raw,size=256M \
>>     -object memory-backend-file,id=cxl-lsa1,mem-path=$TMP_DIR/t3_lsa1.raw,size=1M \
>>     -object memory-backend-file,id=cxl-mem2,mem-path=$TMP_DIR/t3_cxl2.raw,size=512M \
>>     -object memory-backend-file,id=cxl-lsa2,mem-path=$TMP_DIR/t3_lsa2.raw,size=512M \
>>     -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1,hdm_for_passthrough=true \
>>     -device cxl-rp,port=0,bus=cxl.1,id=cxl_rp_port0,chassis=0,slot=2 \
>>     -device cxl-upstream,port=2,sn=1234,bus=cxl_rp_port0,id=us0,addr=0.0,multifunction=on, \
>>     -device cxl-switch-mailbox-cci,bus=cxl_rp_port0,addr=0.1,target=us0 \
>>     -device cxl-downstream,port=0,bus=us0,id=swport0,chassis=0,slot=4 \
>>     -device cxl-downstream,port=1,bus=us0,id=swport1,chassis=0,slot=5 \
>>     -device cxl-downstream,port=3,bus=us0,id=swport2,chassis=0,slot=6 \
>>     -device cxl-type3,bus=swport0,memdev=cxl-mem1,id=cxl-pmem1,lsa=cxl-lsa1,sn=3 \
>>     -device cxl-type3,bus=swport2,memdev=cxl-mem2,id=cxl-pmem2,lsa=cxl-lsa2,sn=4 \
>>     -machine cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=1k \
>>     -device i2c_mctp_cxl,bus=aspeed.i2c.bus.0,address=4,target=us0 \
>>     -device i2c_mctp_cxl,bus=aspeed.i2c.bus.0,address=5,target=cxl-pmem1 \
>>     -device i2c_mctp_cxl,bus=aspeed.i2c.bus.0,address=6,target=cxl-pmem2 \
>>     -device virtio-rng-pci,bus=swport1"
>>
>> Multiple Qemu Topologies tested:
>> -without any devices connected to downstream ports.
>> -with virtio-rng-pci devices connected to downstream ports.
>> -with CXLType3 devices connected to downstream ports.
>> -with different unique values of ports (both upstream and downstream).
>>
>> Changes from v2->v3:
>> -cxl_set_port_type(): optimized storing of strucutre members.
>> -namespace defines instead of enum.
>> -Calculating size for active_port_bitmask than hardcoding to 0x20.
>> -Defined struct phy_port directly inside struct CXLUpstreamPort as pports.
>> -Renamed struct pperst to struct CXLPhyPortPerst.
>> -Optimized perst member initializations for ports inside
>>  cxl_initialize_usp_mctpcci() using active_port_bitmask.
>>
>> [1] https://github.com/computexpresslink/libcxlmi/commit/35fe68bd9a31469f832a87694d7b18d2d50be5b8
>>
>> The patches are generated against the Johnathan's tree
>> https://gitlab.com/jic23/qemu.git and branch cxl-2025-07-03.
>>
>> Signed-off-by: Arpit Kumar <arpit1.kumar@samsung.com>
>
>Hi Arpit,
>
>I'll have a go (probably next week) at rebasing this rather earlier in my tree as I'd
>like to get this upstream without it having a dependency on the MCTP support.
>
>That means bring it up with the switch-cci / pcie mailbox CCI and squashing
>the MCTP bit into the patch that brings that support up later in my tree.
>
>I do plan to fix up the remaining 'feature' gap on the FMAPI/MCTP/USB
>emulation which is that it's ignoring the MTU to the host and so not
>breaking messages up as it should.  Linux doesn't care but maybe some other
>OS will. Not entirely sure when I'll get to that though and I'd like to
>move your work forward before that.
>
>Jonathan
>
>
Hi Jonathan,
Thanks for the review comments!

As per my understanding from CXL spec r3.2 Table 8-215: Physical Port Control
request is allowed only for switch FM interface and is prohibited for
switch-cci/pcie mailbox CCI. However, if possible, should I be using
cxl_initialize_mailbox_swcci() to initialize my perst members?

Thanks,
Arpit.
>>
>> Arpit Kumar (2):
>>   hw/cxl: Refactored Identify Switch Device & Get Physical Port State
>>   hw/cxl: Add Physical Port Control (Opcode 5102h)
>>
>>  hw/cxl/cxl-mailbox-utils.c                | 368 +++++++++++++++-------
>>  include/hw/cxl/cxl_device.h               |  76 +++++
>>  include/hw/cxl/cxl_mailbox.h              |   1 +
>>  include/hw/pci-bridge/cxl_upstream_port.h |   9 +
>>  4 files changed, 347 insertions(+), 107 deletions(-)
>>
>

------6Bw0j5KOoRaxZeQKOp2dAcC2OKT3No9WZFWhMG37wfGsvvbi=_f7f1f_
Content-Type: text/plain; charset="utf-8"


------6Bw0j5KOoRaxZeQKOp2dAcC2OKT3No9WZFWhMG37wfGsvvbi=_f7f1f_--
