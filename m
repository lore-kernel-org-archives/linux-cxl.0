Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD628340DA6
	for <linux-cxl@vger.kernel.org>; Fri, 20 Feb 2026 12:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771592338; cv=none; b=l1B1pPgOd3NfCG4ov00dRQwXT/HvUSgbsCslHLRw1LjAVGOK7pigyksw9zOwEcJlzYXO1otKp9wyjSQ5yzT0KYTRHJ0FLiERM3hOZ3Vhj0Tgq2gQIrDRAjtK8tTffvlDGxB7XRYz3kQq7EuPW3iu3lmcQ3edAbPf/j6EoF4IknU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771592338; c=relaxed/simple;
	bh=K1IOQCkyvfGc/izL60Ju6R0tbrdgrRTlOmraJJaNHmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=txg78k0lF9stp6srVMPWFRVGUJoaF4BaWCcMF7N1gXCzp/6figGWdxFa+q8+O/t+mMJxhkx9NT+o2QdwIbLUKzjeT+oZ62oDYamGFfR97Avlvwt6t7SQBYAovt0+GUlKRPm7ib92DJ3YL87nz2t41t5RcwjNseRC+ZkTaTA2Wyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CnR7wmxV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CnR7wmxV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771592335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vkSNI3uLN6KRJsGjKA6J4qpWg+yqDGZlKCoW+0IJCbs=;
	b=CnR7wmxVMGdADfp8tXr+wh0/1TtTtl/yFWFrEADdpoD7oK/fu+uZmmQxXM65IWJftQUXnV
	DnLJgjW54y+rvXdeRf5AoWpoWAAtcoHzvLk1Jp47ckZ6PMhiwdjE7M3ym6aRKEBXy+puDs
	r0CGxlT2yE5WTnr6XTDq+6CntcrDbuA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-ZhktzvquOp68LTEkKuflJw-1; Fri, 20 Feb 2026 07:58:54 -0500
X-MC-Unique: ZhktzvquOp68LTEkKuflJw-1
X-Mimecast-MFC-AGG-ID: ZhktzvquOp68LTEkKuflJw_1771592333
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48071615686so22006345e9.1
        for <linux-cxl@vger.kernel.org>; Fri, 20 Feb 2026 04:58:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771592333; x=1772197133;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vkSNI3uLN6KRJsGjKA6J4qpWg+yqDGZlKCoW+0IJCbs=;
        b=Utv0Xtd7MiuVnse0gUXJ1Dd06WhKaL0pHbHbzsrQeFjIldEGgnqa5DpHPOFkEnUU4M
         drGYCW/PDTKp7S6/WaIneumvtakJZ8C/GkpqC2I/so1yzaSty28HNBvW15AptWszlISR
         D7G9pQixxy2nu1La/AcpgQX0iZ+xkxE7i+HS2bmf2hLXQSbF7WMx2FvInXhqXnb8WkkD
         uPgWsEownSJ5f1Qe1BTjbtF9zubARI+wWXpTrsMrdR3BtA68QSBlmDNJPASC8ZwmrLZC
         NAHs5hI0JS07zqYmKmwSrGpeId/8XoIWbFJO61xMOCdCGWPUPvwmGVeNX12LB0fQRH3n
         RwEw==
X-Forwarded-Encrypted: i=1; AJvYcCVfSVm6cO/47ghhiP9OWtxhQ+WLjkWHcs9n6cM88xVzfYlnik2KG47HoL+9bb3ZL1MeumVnhd8s+Vg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ7SYaCzU92LT9va6D+3Sd9WkHxqkCAStDnQXU7hPgV59s1Gjw
	A6P6IKVHXexh66lcZZ5vUMs2+Be3HaCWhEft5gHkdXSZXY8GwoL8YPLsZSoaafj3fxxtfixWDsn
	qF8oTEp2hgsOoHyZjfB+xyx7AqjI2/rfXBl+3nyQJWqovnVikK2iGawv/I1HeFA==
X-Gm-Gg: AZuq6aIXaYO+ID6py6sa1sgDLHUY8kCtmHZVe0J1uZrZWWkCEL4lzg3N9gv6fpV8Z7u
	6QFyJ/MH+mYUZPrsobcS8Y2BNdvnBoiM0qqkUJJRSPCAJqfsxukm7XZzNpZPpFtLDyk/1/xQKuF
	la7Gn/L0iwRryaFzhcQ3XgiOHa9jR9o2UHSM9znG2WUk4OJqf7pgXX4EwnFwwR0pw+SSqfNlSPs
	StO3ddrCxwlMiKUt7zQ1zBR7/WxXbnOuCZG1Zr5us8GxtKA/uu8j0Fdkh2MGUltij8gC3+0Yuid
	RdZLskLN6X2X0RghxNnmg7SJ97ozJAANoGjPSMeDvH51tZmRHFID1CgHkVs9EJikcC1KN0uK7nJ
	XDqfV9rf+T6tpWex9kF/DspdPxCkqkA53EsPaUHVVrkVr3g==
X-Received: by 2002:a05:600c:608a:b0:480:1e9e:f9b with SMTP id 5b1f17b1804b1-48398a58488mr187082575e9.16.1771592333243;
        Fri, 20 Feb 2026 04:58:53 -0800 (PST)
X-Received: by 2002:a05:600c:608a:b0:480:1e9e:f9b with SMTP id 5b1f17b1804b1-48398a58488mr187082105e9.16.1771592332720;
        Fri, 20 Feb 2026 04:58:52 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796ac7d91sm58035586f8f.26.2026.02.20.04.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 04:58:52 -0800 (PST)
Date: Fri, 20 Feb 2026 07:58:49 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, Arpit Kumar <arpit1.kumar@samsung.com>,
	linuxarm@huawei.com, linux-cxl@vger.kernel.org,
	Ravi Shankar <venkataravis@micron.com>,
	Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
	Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH qemu v5 0/3] hw/cxl: FM-API Physical Switch Command Set
 Support.
Message-ID: <20260220075818-mutt-send-email-mst@kernel.org>
References: <20260204173223.44122-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260204173223.44122-1-Jonathan.Cameron@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MS3HT1sZMiU82aDftUTdsVZq8Yu4BkTkzA_vkAMTx48_1771592333
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 04, 2026 at 05:32:20PM +0000, Jonathan Cameron wrote:
> Changes since v4:
> https://lore.kernel.org/qemu-devel/20250916080736.1266083-1-arpit1.kumar@samsung.com/
> - Dropped initial refactor. Reason being that it is not static enough
>   for caching at boot to be appropriate.  Kept the spec update part
>   of this.
> - Added a patch to make sure the new flip mode stuff is reported in
>   the Get Physical Port State command.
> - Rebased Arpit's Physical Control Control FMAPI Command given drop
>   of the major refactor from v4 patch 1.
> 
> I had taken this into my cxl staging tree thinking it only needed a few
> minor tweaks.  Then whilst testing I realized it didn't work with hotplug
> and that made me consider if Arpit's original approach made sense.
> 
> So this is my proposal on how to take this forwards. Note that this is
> not ready for merge (probably) just yet as I'd like Arpit to take a
> look at the changes.

I'd appreciate it if you add rfc in the subject in such cases.
Thanks!

>  I went through a version that had major refactors
> to push the logic of building the records to the ports themselves, but
> in the end don't think that brings enough benefits for the complexity.
> 
> Based on:
> https://lore.kernel.org/qemu-devel/20260204170936.43959-1-Jonathan.Cameron@huawei.com/T/#t
> (with all it's precursors, though hopefully they will all be in Michael's
> next pull request)
> 
> I'll note this is an enormous foot gun as it lets you effectively trigger
> surprise device resets.  However, it's only accessible if you are using
> a configuration with the fabric management parts of the CXL emulation.
> For now that is a switch-cci (MCTP over USB support is near the top
> of my list of things to get ready for upstram.  I tested this with a
> custom driver and if nothing else it exposed some gaps in Linux's
> ability to rescan PCI buses after a perst event (even with drivers
> unbound etc to make it safe).
> 
> Original cover letter:
> 
> This patch series refactor existing support for Identify Switch Device
> and Get Physical Port State by utilizing physical ports (USP & DSP)
> information stored during enumeration.
> 
> Additionally, it introduces new support for Physical Port Control
> of Physical Switch Command Set as per CXL spec r3.2 Section 7.6.7.1.3.
> It primarily constitutes two logic:
>     -Assert-Deassert PERST: Assert PERST involves physical port to be in
>      hold reset phase for minimum 100ms. No other physical port control
>      request are entertained until Deassert PERST command for the given
>      port is issued.
>     -Reset PPB: cold reset of physical port (completing enter->hold->exit
>      phases).
> 
> Tested using libcxl-mi interface[1]:
> All active ports and all opcodes per active port is tested. Also, tested
> against possible edge cases manually since the interface currently dosen't
> support run time input.
> 
> Typical Qemu topology
> (1 USP + 3 DSP's in a switch with 2 CXLType3 devices connected to the 2 DSP's):
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
> Tested multiple Qemu topologies:
>         -without any devices connected to downstream ports.
>         -with virtio-rng-pci devices connected to downstream ports.
>         -with CXLType3 devices connected to downstream ports.
>         -with different unique values of ports (both upstream and downstream).
> 
> Changes from v3 (https://lore.kernel.org/qemu-devel/20250909160316.00000190@huawei.com/T/):
>         -Namespaced the defines with cleaner prefix for Get Physical Port State 
>          Port Information Block members.
>         -switch CCI implementation instead of switch FM interface as per
>          Jonathan's review comments, hence moved perst members initializations
>          from: cxl_initialize_usp_mctpcci() -> cxl_initialize_mailbox_swcci().
> 
> [1] https://github.com/computexpresslink/libcxlmi/commit/35fe68bd9a31469f832a87694d7b18d2d50be5b8
> 
> 
> Arpit Kumar (2):
>   hw/cxl: Physical Port Info FMAPI - update to current spec and add
>     defines.
>   hw/cxl: Add Physical Port Control FMAPI Command (Opcode 5102h)
> 
> Jonathan Cameron (1):
>   hw/cxl: Get Physical Port State - update for PCIe flit mode
> 
>  include/hw/cxl/cxl_port.h                   |  73 ++++++++
>  include/hw/pci-bridge/cxl_downstream_port.h |  12 ++
>  include/hw/pci-bridge/cxl_upstream_port.h   |   2 +
>  hw/cxl/cxl-mailbox-utils.c                  | 183 ++++++++++++++++++--
>  hw/pci-bridge/cxl_downstream.c              |   9 +
>  hw/pci-bridge/cxl_upstream.c                |   1 +
>  6 files changed, 268 insertions(+), 12 deletions(-)
>  create mode 100644 include/hw/cxl/cxl_port.h
>  create mode 100644 include/hw/pci-bridge/cxl_downstream_port.h
> 
> -- 
> 2.51.0

