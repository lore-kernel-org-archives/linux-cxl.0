Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80B630BBB3
	for <linux-cxl@vger.kernel.org>; Mon, 15 Dec 2025 14:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765809874; cv=none; b=lLCKi9nE17mrzyt4vYshY6JrBx9eNNfCYFWIWsgICEoJi6EJ2ZI1SZ99BcThJzN3ZmM0sc0RAuV8ssX7WePUdvurq+qlDGwBWVDiLuhj1Dlmtdglh+cSQQ/K/uoBH3+QteYYIWTy6HGDk4j8BMkBjs07MwF78ptvXDQ7p9ktaNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765809874; c=relaxed/simple;
	bh=YwRRPytlzA2JA+rfoy0gpY6Sy+2HRgCS/tw0pdPmmZg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qQ4IRBEf16qXNr9L9qReH/xjrybk2cExKdG0PVfDjTreCe/GMZBSouRItYJTcryErk5tVKq1OXiYqpW6XXG1rfksS5/6fvvZKFK+VcuDhgTv8BjVRmGeEwYaRl54j3SXAEaL6BjNcu/tfpHxDyN8ssl/EKBvmLjQsI9X8c9M8o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dVN9f6MMXzHnGhH
	for <linux-cxl@vger.kernel.org>; Mon, 15 Dec 2025 22:44:06 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 51BB440565
	for <linux-cxl@vger.kernel.org>; Mon, 15 Dec 2025 22:44:28 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 15 Dec
 2025 14:44:27 +0000
Date: Mon, 15 Dec 2025 14:44:26 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Joshua Lant <joshualant@gmail.com>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: [QEMU PATCH 0/1] cpmu: segfault issue with hotplug event
Message-ID: <20251215144426.00002c68@huawei.com>
In-Reply-To: <20251205140427.3532906-1-joshualant@gmail.com>
References: <20251205140427.3532906-1-joshualant@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Fri,  5 Dec 2025 14:03:28 +0000
Joshua Lant <joshualant@gmail.com> wrote:

> Hi,
> 
> The CXL device topology shown below casues a hotplug event at some
> point during boot. This triggers a segfault in cpmu_timer_update due
> to a dangling pointer. The teardown of the pci devices has already
> happened at this point. However, the associated CPMU timers remain in
> the timer_list. We need to remove them before the rest of the device
> teardown happens. This should not cause any issue, since if a hot-add
> happens the realize function for the corresponding device will be called 
> and the timers will be set up once again (although I have not tested 
> this scenario. Only that I can now complete the boot process correctly).
> 
> Many thanks,
> 
> Josh
> 
> qemu: https://gitlab.com/jic23/qemu -b cxl-2025-10-03-draft
> kernel: https://github.com/weiny2/linux-kernel.git -b dcd-v6-2025-04-13 

I'm curious what is triggering the hotplug to occur, but indeed this is
clearly a bug. I'll squash the changes into the relevant CPMU patches.

So applied in across relevant 3ish patches.  I tweaked it a bit to reduce
the use of local variables that were only used once.

Given we are near the QEMU 10.2 release, I'll wait for that before pushing
out a new tree incorporating this fix.

Thanks,

Jonathan


> device topology:
> 
> -device usb-ehci,id=ehci \
> -object memory-backend-file,id=cxl-mem1,share=on,mem-path=/tmp/t3_cxl1.raw,size=8G \
> -object memory-backend-file,id=cxl-lsa1,share=on,mem-path=/tmp/t3_lsa1.raw,size=1M \
> -object memory-backend-file,id=cxl-mem2,share=on,mem-path=/tmp/t3_cxl2.raw,size=8G \
> -object memory-backend-file,id=cxl-lsa2,share=on,mem-path=/tmp/t3_lsa2.raw,size=1M \
> -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.0,hdm_for_passthrough=true \
> -device pxb-cxl,bus_nr=48,bus=pcie.0,id=cxl.1,hdm_for_passthrough=true \
> -device cxl-rp,port=0,bus=cxl.0,id=root_port1,chassis=0,slot=1 \
> -device cxl-rp,port=1,bus=cxl.1,id=root_port2,chassis=1,slot=1 \
> -device cxl-upstream,port=0,sn=1234,bus=root_port1,id=us0,addr=0.0,multifunction=on, \
> -device cxl-upstream,port=0,sn=5678,bus=root_port2,id=us1,addr=0.1,multifunction=on, \
> -device cxl-switch-mailbox-cci,bus=root_port1,addr=0.3,target=us0 \
> -device cxl-downstream,port=0,bus=us0,id=swport0,slot=3 \
> -device cxl-downstream,port=0,bus=us1,id=swport1,slot=4 \
> -device cxl-type3,bus=swport0,volatile-dc-memdev=cxl-mem1,id=cxl-dcd0,lsa=cxl-lsa1,num-dc-regions=8,sn=99 \
> -device cxl-type3,bus=swport1,volatile-dc-memdev=cxl-mem2,id=cxl-dcd1,lsa=cxl-lsa2,num-dc-regions=8,sn=100 \
> -machine cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=8G,cxl-fmw.1.targets.0=cxl.1,cxl-fmw.1.size=8G"
> 
> Joshua Lant (1):
>   cpmu: teardown cpmu timers on device exit
> 
>  hw/cxl/cxl-cpmu.c              | 8 ++++++++
>  hw/mem/cxl_type3.c             | 5 +++++
>  hw/pci-bridge/cxl_downstream.c | 2 ++
>  hw/pci-bridge/cxl_upstream.c   | 4 ++++
>  include/hw/cxl/cxl_cpmu.h      | 1 +
>  5 files changed, 20 insertions(+)
> 

