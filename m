Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A59033E1
	for <linux-cxl@vger.kernel.org>; Thu, 24 Jul 2025 07:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753343046; cv=none; b=rTSvLXKf0BUhxXwcU7PN0nAjsbZZPHYy/dfVe3BBmy4Ix+0sjpyL7zbCeJUgFK6YRPVMmuKkqYD//UmR0W74gz8Be0XfniotCaO1TUEtfwwHBKTB+38Dzlk+46Vu8fKzhU6wk+fXUdsdzbZoizaOEchiyubBBf3pC906NqmhSAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753343046; c=relaxed/simple;
	bh=xrqpgO12MdKX5AzqqGN3l+/f0VBMtP6poKYYpDDMVvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=UC8BZYwhz1EswAfxeKj4DMwNBlXgCS40y4GbPJCqFjUjA6gJH4RIyxqRShuHA/PIR+BfK9Q8ulfKu65SwObCcJTrJc14ZYJGj0CLa1S32v08Djf3vCFYNMsyXeE8ugf+y8nd4cAQxNNZg8aKEfQhOux0XK9cfPzVFw3up5VlC68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bxjcDhQd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bxjcDhQd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753343043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AsMs+hTXpOhnnm2IoD38T+4FAzcrBd+o6vY4v5w8Q3Q=;
	b=bxjcDhQdzEVxepCMzcGqiMz2GdnHG9++SGAVFCbQtE1Zvi7zJ1OvGNpgNZ2DEtBwhfBG4c
	aOvFpDVsgtNhK3fIJGDt3zsMhUV67twE8j4g5Mc0eUd2vNKJZpiNVbtwmUDszSA/i3df6e
	z4P7Lw+D4kfF85mb2otDsc+1xoLMigk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-EUIMOhJBPeKmnkReI6ru6Q-1; Thu, 24 Jul 2025 03:44:01 -0400
X-MC-Unique: EUIMOhJBPeKmnkReI6ru6Q-1
X-Mimecast-MFC-AGG-ID: EUIMOhJBPeKmnkReI6ru6Q_1753343040
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-456175dba68so3603895e9.2
        for <linux-cxl@vger.kernel.org>; Thu, 24 Jul 2025 00:44:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753343040; x=1753947840;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AsMs+hTXpOhnnm2IoD38T+4FAzcrBd+o6vY4v5w8Q3Q=;
        b=STSLM1jNXtxD7/hFN9kdXvdy0SkFsVg37IVljxQECOOXe4MwCHJrT2dCn4uDKYPtsv
         32YeVqqx32kK/UFfp/u4EahwF3Iv4HF2z3kxppfRd4o7tw1Wt8OoreRkv0aI0oqjO36f
         5Ze67E2xXkwcs4jmRjaWUlEWKImE0hPYyne/NOD4j9BYa03jn+UC4iyJ0Qt96GZgJknW
         U8OCEVN/RAKZyxj/Lh2JTYJmXz4ZgJp1z4x/3uf7k2hp42T4VkAmgkSL3I9epZiOTgmE
         BpbL2mosS7TMfZxhgnNK3fm+NjtH3Q9fAotB316gMNEu5Rf9ugfhsaUdOm1maBJGcQSq
         H5Jg==
X-Forwarded-Encrypted: i=1; AJvYcCUSCA9KHJq4dkVUXqVcPpmmzUJAq0UsSjj3rUXvzCfVT6jW8QacPdxFTchPcjckd9ZT85N5mIYShDM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4yvIxVCMRYeuSkN3bZ7LVJhu8JM+Qb2iDg8FB15f5nC4pVCtN
	SyoUp2DOxnp+f4rn8JeAy1w+atpZn0d6Gg7OGr/dX3VJnsWLKBE2ipuqWh+h2DHHmRvCrSgfiqH
	c9EITrAoZIJswVvTLKQEiroWWe2FC4uPf8hzqQ1Sho+t09auTvGlNV7Xzs/4tjw==
X-Gm-Gg: ASbGncuUpI8AtiGoQwuf9cMPUs/+aOHO/tQv3mOQrcxZxbf6+n+4SF4cMCPsWZ8ZcrV
	qQ+X3cTlYmRmOW9sGM50PzDbPSij8uwSbQJ9jtwyu+kcU367UvExI3fAHw7ooVugvi3bPKXfhDW
	KszSmlOu3YSpd7N58SnUy3RZNTXgjOWnKBMUXt+U6qClSA14BQ5tFt4Pdy7ZVO1TxZdXF2FPkCY
	u8KwVxNJorgvfXwHwtZ6T6pErAb17sQDHWIVdFsi2X2lZ/r+pPs99JrjVlzUYd7A3ckFpPY8RJB
	VVh1LjC5oss98Vfi/w3U4WoBFnpOJdrdvgo=
X-Received: by 2002:a05:600c:1c22:b0:455:eda0:8a8e with SMTP id 5b1f17b1804b1-45868d22a5dmr50546725e9.27.1753343040316;
        Thu, 24 Jul 2025 00:44:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUwhURWyMtQLQaEKbzpcAd6IbEiR7/GvDVakSMVnMwZuQouWq1Sn5gifZh2kC45cJaxFdmpw==
X-Received: by 2002:a05:600c:1c22:b0:455:eda0:8a8e with SMTP id 5b1f17b1804b1-45868d22a5dmr50546525e9.27.1753343039850;
        Thu, 24 Jul 2025 00:43:59 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:153d:b500:b346:7481:16b2:6b23])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b76fcc43c2sm1246772f8f.83.2025.07.24.00.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 00:43:59 -0700 (PDT)
Date: Thu, 24 Jul 2025 03:43:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: peng guo <engguopeng@buaa.edu.cn>
Cc: marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
	richard.henderson@linaro.org, eduardo@habkost.net,
	qemu-devel@nongnu.org, linux-cxl@vger.kernel.org, wyguopeng@163.com,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] hw/i386/pc: Avoid overlap between CXL window and PCI
 64bit BARs in QEMU
Message-ID: <20250724034335-mutt-send-email-mst@kernel.org>
References: <20250718133545.5261-1-engguopeng@buaa.edu.cn>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250718133545.5261-1-engguopeng@buaa.edu.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IU0KVz1zk8xzTI_VutVmhmhpbE7rn1ZTeqAf0Bm8v9s_1753343040
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 18, 2025 at 09:35:45PM +0800, peng guo wrote:
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

Cc Jonathan.
Any input on this?


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
> -- 
> 2.43.0

