Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79240239E69
	for <linux-cxl@vger.kernel.org>; Fri,  1 Aug 2025 12:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754050476; cv=none; b=nzQKi3xpjZ5aJNidyGLIEmSEyjXPN5VZgN+YMp5zbZDTuRlc+arknDH1yt5U287vcvTVJ8ytiUVlhMB1+k5xL/xWof7ADtqB5Dj2mDpbb+FV3XLhnIMr/kRMq1iBGW9IEuZYBGzCrgLziPqQ0wNGhrBC2dmnn+pkdwf8OD6XOI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754050476; c=relaxed/simple;
	bh=J2dJSLruedBlAkWcNha81k/K9/k9Ap9WsdnAziK7m4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=DhxP+ysNInPdY11xNnjG4rNGsWj++JVaHHIemxcJr2WEi0gfvocxOOw8nXP/G11LkE8OvBkVBEAjgvBuq5/zBQICX9y04vO1/T8sAzzWE2eIUztFMvY3uUUUR1zlFdD/c8UbUoadYStklWrxNZIqzc1auo2kV5+JLUh3Un59HS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KgH/F9XG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KgH/F9XG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754050473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p5DxPr+Lt12YB86ZIw/7sgJOe6TrzxX/xm3c2q428kg=;
	b=KgH/F9XGZ/f4ATxZF4ZaBcThWfXskJ9Iy4lnEDMx1QpSwMujVk7wkrIgcLpRuBfcGAqbmn
	rsTAimsmbSnuf0kAY9iSl9UetFu4ychkdzrB5KbGaCB8QhlXFJBowQdaVz+WSl/5f5s05N
	WHnzrz/xbmphiaV70FoCjMx/cfkd5jM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-mNPV8pa6PeOzfPju_TJsCQ-1; Fri, 01 Aug 2025 08:14:32 -0400
X-MC-Unique: mNPV8pa6PeOzfPju_TJsCQ-1
X-Mimecast-MFC-AGG-ID: mNPV8pa6PeOzfPju_TJsCQ_1754050471
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-456175dba68so5494805e9.2
        for <linux-cxl@vger.kernel.org>; Fri, 01 Aug 2025 05:14:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754050471; x=1754655271;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p5DxPr+Lt12YB86ZIw/7sgJOe6TrzxX/xm3c2q428kg=;
        b=XNCQycNDvwXCEzTh2X0AqKqa0/vHY3mlCpcENEpL+qYeyEHyWF3p8d6o3HLDGM2xay
         zhEKPuxewfyzVJW4lRaxwGlrSTzZuETegx4FqVrTSn0iykVIGJm8Ov1dkZPIgMmxeovC
         GBOxMslYzREUhk5MIPvdOwVJyFshnT/d2Ra25iHgLhk5ribIBK15/YMrHFFrF+s4s4D1
         gyBfsd8PGpJK+SlBmA6QHCmVTVSbzVkMyQ5W4ncyATqyl2LGKr8J6cDBFyoQrDt1saa4
         5JHrLjVNAC3p65cNIfUxg1LSF4lg53Msaj3+2pV1H8nQwvWo4UQREbidVWTFwSvs/ScA
         0udw==
X-Forwarded-Encrypted: i=1; AJvYcCVwV73VVI5+XPF1NAExCRhYjd3JWBhTIiMmHIY2hH8HDR7QmiXpEP7A63eLZ7PGqeRBvcM7NDJfR8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgVBcCamgTz3Eug4qUEUNWJa2TuZ0M+U2gV65WLoMVJS4ndXfs
	MoQeWB0fF/4GLqOoNMi1k8NqKJQ/03BeS/FbIWOQPXGTP7DuX2e0sb1KrGgSnnOd2vyfx6MfThj
	rkVURYRuDbw+gjpn4x87UOmUzj2kp5mjHTa3SiSg6BN5I0r0rE3JfDLMU48PM1w==
X-Gm-Gg: ASbGncunD5rKJtlupONnvCzUoa2ZPbF1WkbN52h6rzMwuN/mmbH6dCtpBW+H+rWOoeJ
	zxi4/YlxZQ0K5BcBTBMQWtGFFATkm1Vf3TlJkfJ+UvL1/7qWaENYyubvVTgbTYD/Ylz6VmjKjWb
	4yaoURFl4IIoYDLFVn4ETZcFectwAiW1bHnIcghpUcxCrS9s+qswreWWwEXiZ/BZTU36UdAWjcO
	9+ZoWJvg0fIlBw0h2Oy7872pFd4MPtLaIe0Lazh11QLZOOzERvX99n7WQzPvfQJ8Nt+fNKQYeF/
	KCdZneCKwBTmYdrZGBSKowO3lmDIaGKU
X-Received: by 2002:a05:600d:108:20b0:456:26ad:46d2 with SMTP id 5b1f17b1804b1-45893943cefmr60740245e9.6.1754050471201;
        Fri, 01 Aug 2025 05:14:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHf/uN8giiXWsyE8MRI1JdmXzBuptgXe0qs6y0z4fBmaFxeSJp5O8RxtgWgJSOwmMUJSdr6TQ==
X-Received: by 2002:a05:600d:108:20b0:456:26ad:46d2 with SMTP id 5b1f17b1804b1-45893943cefmr60740085e9.6.1754050470790;
        Fri, 01 Aug 2025 05:14:30 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c469093sm5824610f8f.51.2025.08.01.05.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 05:14:30 -0700 (PDT)
Date: Fri, 1 Aug 2025 08:14:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: peng guo <engguopeng@buaa.edu.cn>
Cc: marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
	richard.henderson@linaro.org, eduardo@habkost.net,
	qemu-devel@nongnu.org, linux-cxl@vger.kernel.org, wyguopeng@163.com
Subject: Re: [PATCH] hw/i386/pc: Avoid overlap between CXL window and PCI
 64bit BARs in QEMU
Message-ID: <20250801081408-mutt-send-email-mst@kernel.org>
References: <20250718133545.5261-1-engguopeng@buaa.edu.cn>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250718133545.5261-1-engguopeng@buaa.edu.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: u5u3O3k-UtQphq_CRk9Cv5DPurX7NyU1i3M0EzlwSp8_1754050471
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


To clarify I am expecting a new version of this.

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

