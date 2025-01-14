Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692FC20AF8F
	for <linux-cxl@vger.kernel.org>; Tue, 14 Jan 2025 20:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736886651; cv=none; b=DmbhLlkWEnEJ6SaEg6drVDVCVEKN7jJPy1IkH/M6tE02lkJF2NeZR4LrQaNmRoiHWzGIFjIPRQfrEFAdo/EdbIofG731NPJoOv9EbzzyDhMV+xQuNtjuO7CPu9BPd3/WFmGul1syeXk1DDPNDsFXbLPC36gTwjSYirl1W6ib81U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736886651; c=relaxed/simple;
	bh=Toc0A+TzSE+FxG6ajnHgtpJ9IibyQZlkqWCrC1uAsGM=;
	h=From:Date:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=h1x+I92OX4tsrwoAy51ivqBgb0i+PRSr8KnP9SeYoVblUtp4mUwqesgQ8Xu3cy29DfNMAhcP4kYCPKXE8wUnEY8iPAWu21zkxCWdmPki75sTbhSRkzTGZoi0zzs0FEQz5qTp9rQSg9/O8Bf4+/MHubSh/MjNl6BHRQ8z+/CODLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LdOBDzrx; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LdOBDzrx"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e5773c5901aso307052276.1
        for <linux-cxl@vger.kernel.org>; Tue, 14 Jan 2025 12:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736886648; x=1737491448; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SPRPm87DXRLusb2FH5q+lErvZ8BzG4Als+1lIxhnTy0=;
        b=LdOBDzrxxA6pp3hH1NlOvMUB1XJQsdfpWS5vf0/+olsYoMF0Bv6LaFDFBu98Uh3G1Q
         T4kg53D4xxyAUKC9Ayn4/n193/FcxaYdp/7MtCTigXoPyrGdhtgCPYW70jv/ApDT/Jfj
         TDCF3sbPBlccy19qDXyBix8K7vd4nawmphNey2TA/HQE55iS0FoLJWJtB6BVrqsan5bm
         6mOBcFL2Qit82kMfxUTlHFKuUKadczyue5GXBOWvhVB/ukEHHqmlwmRq5dTkqCgUcTfm
         ChfZ/Pngmz24FXLpu/bdIC2Yw98yPQV26eLqXWHar/FXYzOV9MD8eSLvaY984sK7zVF0
         LR8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736886648; x=1737491448;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SPRPm87DXRLusb2FH5q+lErvZ8BzG4Als+1lIxhnTy0=;
        b=Ps69oE2X0REF7/m18iHLtxKKMLUUyVRzgdc4DcM35xRikrtZV2HNu1Ftozoic11UuC
         oY5AytykxqudgYOG6Uyg5zTNAnKPIQAnlX5IDzQBPYkQzS3en2uePK/vhW1VkZ09N6Wr
         mAuNAfvuwN59AZuo0QV6JY5lElZOkcogqtTGLJhmdpYplwn7ItLSI3D90A1yGO6GDRla
         tIBuTG8V+wUenpn7BVjwWz8m9QXB1YG9YqQRI9pV6W8ThJIPyDc2f8pSHMENuhIf0VK6
         tN9OGZzaBAO+343k5pAepEV0sw0qHOnRoZNpCwFMuO6kOwZMzMCjIdGae5krhdg6II0U
         FEHw==
X-Gm-Message-State: AOJu0YyuzwMMVt6LIAiUtTXzSdCvTorpLlU65ncDLWTgzhuoWUK4UbDs
	Yo6CAZwvN+LzBKqpd1I9N+y6nPk76jUTs8hekbTDS0IsZiOq37P2ljDvOw==
X-Gm-Gg: ASbGncvCoxWv9nufxm3OgVjIjO1nMS/GNF+5F3uxAjJYwEGIpscpEojaTxHsvQhNcwS
	ZmpiOkpEaoBd5pR/vCRCZa74ZU24TPC7pHY3NIXGVLUprT8ALoP2xoV9r6LuHcMCh+TJLEswq0X
	7WoAyL60xzpYho+7ECffEKb4TwkfUQHTmkH7tB4wOkqQ1PeZRigh9OnwERAZEACU3vF5JgYfCra
	uK7uw6r7NrIZMTd912Ve050jUoNlnpzxjgxmzhCtw==
X-Google-Smtp-Source: AGHT+IF1uATIZbVz2bKEzNCNIQPbpL6cepYmy3IN5+loU73YgtSjUw3l5MQ9G0H9izryEQvb9fWBzg==
X-Received: by 2002:a05:690c:7305:b0:6ef:f1be:5b5f with SMTP id 00721157ae682-6f6c9a8f619mr3753547b3.5.1736886647766;
        Tue, 14 Jan 2025 12:30:47 -0800 (PST)
Received: from fan ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f546c3dfb3sm22801147b3.30.2025.01.14.12.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 12:30:47 -0800 (PST)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Tue, 14 Jan 2025 12:30:44 -0800
To: linux-cxl@vger.kernel.org
Cc: a.manzanares@samsung.com, fan.ni@samsung.com, anisa.su887@gmail.com,
	dave@stgolabs.net
Subject: [ISSUE] memdev cannot be enabled after reboot due to failed dvsec
 range check [QEMU setup]
Message-ID: <Z4bJdCliETI_t2DL@fan>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Recently, while testing cxl with qemu setup, I found the memdev cannot
be enabled successfully after reboot. 

Here is the setup and the steps I have tried.

QEMU:
https://gitlab.com/qemu-project/qemu.git
branch: master
commit: 8032c78e556cd0baec111740a6c636863f9bd7c8

Kernel:
https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/
branch: next
2f84d072bdcb7d6ec66cc4d0de9f37a3dc394cd2

Steps to reproduce the issue.
1.  start the vm with cxl pmem device attached directly to RP.
2. Load the cxl drivers cxl_acpi cxl_core cxl_pci cxl_port cxl_mem, etc.
Everyting works expected, the memory is corrected enabled and shown with
cxl list.
3. Reboot the VM (run reboot command inside vm, no shutdown);
4. Load the cxl drivers as in step 2. the cxl pmem is not correctly enabled. 

dmesg shows some error as below:
-------------------------------
[   17.131729] cxl_core:cxl_hdm_decode_init:443: cxl_pci 0000:0d:00.0: DVSEC Range0 denied by platform
[   17.135267] cxl_pci 0000:0d:00.0: Range register decodes outside platform defined CXL ranges.
[   17.138428] cxl_core:cxl_bus_probe:2073: cxl_port endpoint2: probe: -6
[   17.141104] cxl_core:devm_cxl_add_port:936: cxl_mem mem0: endpoint2 added to port1
[   17.143703] cxl_mem mem0: endpoint2 failed probe
[   17.145324] cxl_core:cxl_bus_probe:2073: cxl_mem mem0: probe: -6
[   17.171416] cxl_core:cxl_detach_ep:1499: cxl_mem mem0: disconnect mem0 from port1
------------------------------
Compare the step 2 and 4 with debug info. we can see,
In step 2, when entry function: cxl_hdm_decode_init().

(gdb) p *info
$2 = {mem_enabled = false, ranges = 0, port = 0xffff8881097eac00, dvsec_range = {{start = 0, end = 0}, {start = 0, end = 0}}}

The info struct is from cxl_dvsec_rr_decode(), where if mem_enabled is
not enabled, it will return directly without reading dvsec range, so
ranges == 0.
This is what happened in step 2: no dvsec ranges are provided to the function for checking.

When init the hdm decoder in cxl_hdm_decode_init function, the memory enable bit will be set.

In step 4, after reboot, the enabled memory enable bit sustained and the dvsec range
register will be read from the device in cxl_dvsec_rr_decode. 
So when entrying cxl_hdm_decode_init(), 
------------------------------------
$2 = {mem_enabled = true, ranges = 1, port = 0xffff888103c77400, dvsec_range = {{start = 0, end = 536870911}, {start = 0, end = 0}}}
Breakpoint 2 at 0xffffffffc0657bbe: file drivers/cxl/core/pci.c, line 416.
------------------------------------
It will cause the dvsec_range_allowed() failing as the range from dvsec range
registers starts at address zero [0, 512], which does not match the hpa range
stored in cxld->hpa_range, causing the issue.

------------------------------------
Thread 1 hit Breakpoint 4, dvsec_range_allowed (dev=0xffff888108af9848,
    arg=0xffffc9000059f9b0) at drivers/cxl/core/pci.c:265
265		if (!(cxld->flags & CXL_DECODER_F_RAM))
(gdb) b 268
Breakpoint 5 at 0xffffffffc0657d31: file drivers/cxl/core/pci.c, line 271.
(gdb) p /x cxld->hpa_range
$5 = {start = 0xa90000000, end = 0xb8fffffff}
(gdb) p /x *dev_range
$7 = {start = 0x0, end = 0x1fffffff}
(gdb)
------------------------------------
The hpa_range is set when parsing the cfmws in __cxl_parse_cfmws.

Any throughts?

Open question: do we need to update the dvsec range register after we parse the
cfmws to make the two above match.
-- 
Fan Ni
