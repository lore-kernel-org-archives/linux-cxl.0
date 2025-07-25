Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C23714EC46
	for <linux-cxl@vger.kernel.org>; Fri, 25 Jul 2025 13:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753451625; cv=none; b=tiuoQMGcHEgmNEFRX8hx9Mismq67ja9Glm/ESLzxOzFA4ZQj8/JJ684sx1B09XXLcvkKpmmUJrC3STcv8OwoTIVMJNFUt9yl8tkNMKNjbqzQycoZeYzXZWLBlrlG6CixiD1lClmSoaK20eU7C0cqfc5Z9mSNpUFibInD6p7zRE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753451625; c=relaxed/simple;
	bh=zB72H28upRk2Vhj0fAwsrPAYYYvVn0UdPgnlylEdutM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IhDA7QTT/Ckax4yBMQvtxlwmxlgRnxOUBVTimFxX6ohBVAAKANAYjHNxM2eWAdmFUBgIiGgU1tI5SVUqKN8XpjfXAHhwJHdGbiru6GQWyu2NRFaX4uwYuWXC5iaCEeQGMoexTh2x/JDv4aRqkpYLcqEBSVbB8PlrcvdZQ9pjKU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bpTkr48Yqz6HJdJ;
	Fri, 25 Jul 2025 21:49:40 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 626BA1400DC;
	Fri, 25 Jul 2025 21:53:39 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 25 Jul
 2025 15:53:38 +0200
Date: Fri, 25 Jul 2025 14:53:37 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: peng guo <engguopeng@buaa.edu.cn>
CC: <mst@redhat.com>, <marcel.apfelbaum@gmail.com>, <pbonzini@redhat.com>,
	<richard.henderson@linaro.org>, <eduardo@habkost.net>,
	<qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, <wyguopeng@163.com>
Subject: Re: [PATCH] hw/i386/pc: Avoid overlap between CXL window and PCI
 64bit BARs in QEMU
Message-ID: <20250725145337.00003c91@huawei.com>
In-Reply-To: <20250718133545.5261-1-engguopeng@buaa.edu.cn>
References: <20250718133545.5261-1-engguopeng@buaa.edu.cn>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 18 Jul 2025 21:35:45 +0800
peng guo <engguopeng@buaa.edu.cn> wrote:

> When using a CXL Type 3 device together with a virtio 9p device in QEMU, the
> 9p device fails to initialize properly. The kernel reports the following:
> 
>     virtio: device uses modern interface but does not have VIRTIO_F_VERSION_1
>     9pnet_virtio virtio0: probe with driver 9pnet_virtio failed with error -22
> 
> Further investigation revealed that the 64-bit BAR space assigned to the 9pnet
> device was overlapped by the memory window allocated for the CXL devices. As a
> result, the kernel could not correctly access the BAR region, causing the
> virtio device to malfunction.
> 
> An excerpt from /proc/iomem shows:
> 
>     480010000-cffffffff : CXL Window 0
>       480010000-4bfffffff : PCI Bus 0000:00
>       4c0000000-4c01fffff : PCI Bus 0000:0c
>         4c0000000-4c01fffff : PCI Bus 0000:0d
>       4c0200000-cffffffff : PCI Bus 0000:00
>         4c0200000-4c0203fff : 0000:00:03.0
>           4c0200000-4c0203fff : virtio-pci-modern
> 
> To address this issue, this patch uses the value of `cxl_resv_end` to reserve
> sufficient address space and ensure that CXL memory windows are allocated
> beyond all PCI 64-bit BARs. This prevents overlap with 64-bit BARs regions such 
> as those used by virtio or other pcie devices, resolving the conflict.
> 
> QEMU Build Configuration:
> 
>     ./configure --prefix=/home/work/qemu_master/build/ \
>                 --target-list=x86_64-softmmu \
>                 --enable-kvm \
>                 --enable-virtfs
> 
> QEMU Boot Command:
> 
>     sudo /home/work/qemu_master/qemu/build/qemu-system-x86_64 \
>         -nographic -machine q35,cxl=on -enable-kvm -m 16G -smp 8 \
>         -hda /home/work/gp_qemu/rootfs.img \
>         -virtfs local,path=/home/work/gp_qemu/share,mount_tag=host0,security_model=passthrough,id=host0 \
>         -kernel /home/work/linux_output/arch/x86/boot/bzImage \
>         --append "console=ttyS0 crashkernel=256M root=/dev/sda rootfstype=ext4 rw loglevel=8" \
>         -object memory-backend-ram,id=vmem0,share=on,size=4096M \
>         -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
>         -device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \
>         -device cxl-type3,bus=root_port13,volatile-memdev=vmem0,id=cxl-vmem0,sn=0x123456789 \
>         -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G
> 
> Tested in a QEMU setup with a CXL Type 3 device and a 9pnet virtio device.
> 
> Signed-off-by: peng guo <engguopeng@buaa.edu.cn>
Analysis looks good.

For the patch I wonder if we should match the check that follows
for pcms->cxl_devices_state.is_enabled rather than checking cxl_resv_end
(which is only set to non 0 if that is_enabled is set).

Probably better to use a consistent condition for checking if CXL is
there or not.

We also ideally need a suitable fixes tag.  I couldn't immediately find one
so maybe it goes a long way back.

> ---
>  hw/i386/pc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 2f58e73d3347..180bc615f3f0 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -975,7 +975,7 @@ void pc_memory_init(PCMachineState *pcms,
>  
>      rom_set_fw(fw_cfg);
>  
> -    if (machine->device_memory) {
> +    if (machine->device_memory || cxl_resv_end) {
>          uint64_t *val = g_malloc(sizeof(*val));
>          uint64_t res_mem_end;
>  

