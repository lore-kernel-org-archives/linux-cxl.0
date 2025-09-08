Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87873101D1
	for <linux-cxl@vger.kernel.org>; Mon,  8 Sep 2025 15:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757346181; cv=none; b=RKfm+sC2jR/5XV7/HoVYSjIvnRg/4Ov/9umuYN+EPUJEgmzybTRhJoZpIS6Z9/zpeZQe69S9GZd6tdvmQ9MdUJ4hAYz+icd0T1vLLCzlgxRHgRA3wNDVFqVhHWdNz3Qump4FvXBwVEOVHLGBmNBBC2Nacx5w4LPuuEbgOoMwF3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757346181; c=relaxed/simple;
	bh=nt0uFPMwnk2Z89pwjhvB+hZl/SkIWUIZqNZ+KxixKJE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IVYybfHQnf8x1C/7GOepjmQKs9dNIi2ZGI7yRRr8j+owUHRkf0iKuislFrd/BDsyxvvlThH/n6Nh0XeCC2e+rvQxYj8rS2wkxPIYEnp6k2ONcXsWaXIQu1dsIvKe9sh2UwL/F4PNDsngB0CgJquJmJ4TMV2clcVdDvTQrKPf5QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=eKS8C34Q; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="eKS8C34Q"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45de287cc11so7695035e9.1
        for <linux-cxl@vger.kernel.org>; Mon, 08 Sep 2025 08:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1757346178; x=1757950978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HsQNyx2buTgcuAnYXGlibIEqRm5CUhOE47xkEcvNAhE=;
        b=eKS8C34QbVu/X7whJutdlP6HYxl0vkx/GR3dfkoOrseUthPwBlF4LxV9LcBMxiK3T3
         KjYSc9AEuA2lvnAnnJQdiJWsi3gx0gCPS5Y2Oh4AKothcoLV/FfrA1A/esFWFz+ezmxR
         wSZWpvC4+/Yf1xW3ZPyUtFY5zzohlyNfhEPaQvPsguTIb+UZSURlpN43+NCgnAEW6EJi
         25q8mpdeGK3j1RNyYP7XsVLyQQbGEAx/U2vkaLk0QvqUdH3oOgD0Aajt8pOFLxFcE0JU
         aHF72p/96nR/z+qdozOzoKhpQVgfU5J3KVYnXY8ePXbItuokGBTR4sJYOGedr/mAqD0L
         +1IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757346178; x=1757950978;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HsQNyx2buTgcuAnYXGlibIEqRm5CUhOE47xkEcvNAhE=;
        b=DVi0yMntoJT6l40y3BUzC5KLCdYsi2bVejOWVYu1mi58oP55ghRTyfeDJ2y1rZB5sA
         TzASRpDGnfbR+h4hEP/w+q0DPiPTZw7gpL0a98vOE2/uKvUSQic16dNsf9gl4tdn8gB+
         l3d7DPKQEdORdwwgv9eE3g8w1geuO94p1aVpOGkrx4bzn7hTq/CAxMf1xk094/qdscfv
         GChDbmzRuezRbnFKKhfdEZi599dkVz0SdBcN8lFf9tq0gfOj+MgczfS8cz1FGxMHp3ay
         PKFpzk4JoXSlRHhfrr5ERWhodniT9QYxb9oL9WEQ+cn9x9UMdd5qWyWBIr4X1c5cl/H8
         yoBA==
X-Gm-Message-State: AOJu0YwAXpsh7avV66dPW/dyC5d8epp0YHEM4dEbQdk1SxFw0U7Qs8bB
	cvWlZa/8O/zwRUmJENxH9IAP6S97YnSSwhte43qyAdBWrdGldUvPG+y1DpLAdg==
X-Gm-Gg: ASbGnctUbMS93XUmfl1hdbefG3pwOFEGe5owHLHCVqPfPY9/9iwCGFZESBF34q5ePaW
	MuUL4Q4+w547uBcweZfGeXgX8OiUre58rUMm73mUzimb4J5IZsHCWXkVHp6yY+M1v2B1k454vTM
	cPsxTbjUUISGLGLTqLXKVWTzm/RT2YkCtaWY0g0kt6BayGlOUKC5j6Ba/0/d55BQhPV+5AzRM5I
	/rI3RFX6kk6H/fmnM4OYeM6SaztspfLrTDxFjKk4UFmeDISAvXY3xP1uDlVVDyUPYOtsf9K3cNp
	vUdi56i+eYf/ukKBbOHHK8wExmjRVRW0LfDXYhXp6wcGBijuaTvJG/7aoAAczdrmCAxdF4Lbjru
	TYllLAK3fur2X0mingS13VlOHQxkNYatF1hw5QO3CDjtOyukNObjXSFrrHvhmTXGzZgPY
X-Google-Smtp-Source: AGHT+IGd8BTrSmGL8KpjIi7fWs012qn94DdFguRju0hxcgtmZEhIpux0DuTdT98retqsFJvywH/IBg==
X-Received: by 2002:a05:6000:250c:b0:3e0:b982:ca49 with SMTP id ffacd0b85a97d-3e627a7cc9bmr7443645f8f.2.1757346177455;
        Mon, 08 Sep 2025 08:42:57 -0700 (PDT)
Received: from node1.manccluster.local (revolution.cs.man.ac.uk. [130.88.198.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d6cf485eb7sm32151677f8f.3.2025.09.08.08.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 08:42:57 -0700 (PDT)
From: Joshua Lant <joshualant@googlemail.com>
X-Google-Original-From: Joshua Lant <joshualant@gmail.com>
To: linux-cxl@vger.kernel.org
Cc: Jonathan.Cameron@huawei.com,
	Joshua Lant <joshualant@gmail.com>
Subject: [QEMU- PATCH v2 0/1] cxl_type3: segfault in cxl_destroy_dc_regions
Date: Mon,  8 Sep 2025 16:30:19 +0100
Message-ID: <20250908154251.904229-1-joshualant@gmail.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes for v2: fix tags block and hash in commit message

Hi there,

A typo[1] in a qemu command[2] of mine is causing a segfault[3] in qemu
during boot, due to cxl_destroy_dc_regions being called inside what looks like
a hot-remove event. I realise my command is not correct more generally, as
it does not achieve what I want. However, the issue appears to be in qemu, due to
the use of CXL_TYPE3_CLASS() rather than CXL_TYPE3_GET_CLASS(), as the input
is the device rather than the class (introduced in ef73003556).

Josh

[1] Issue in my command

Causes segfault:
-device
cxl-upstream,port=0,sn=5678,bus=cxl_rp_port1,id=us1,addr=0.1,multifunction=on,
Boots okay:
-device
cxl-upstream,port=0,sn=5678,bus=cxl_rp_port1,id=us1,addr=0.0,multifunction=on,

[2] System Setup

QEMU- https://gitlab.com/jic23/qemu.git origin/cxl-2025-07-03

Kernel- https://github.com/weiny2/linux-kernel.git origin/dcd-v6-2025-04-13

Command-

...
-device usb-ehci,id=ehci \
-object memory-backend-file,id=cxl-mem1,share=on,mem-path=/tmp/t3_cxl1.raw,size=4G \
-object memory-backend-file,id=cxl-mem2,share=on,mem-path=/tmp/t3_cxl2.raw,size=4G \
-object memory-backend-file,id=cxl-lsa1,share=on,mem-path=/tmp/t3_lsa1.raw,size=1M \
-object memory-backend-file,id=cxl-lsa2,share=on,mem-path=/tmp/t3_lsa2.raw,size=1M \
-device pxb-cxl,bus_nr=11,bus=pcie.0,id=cxl.1,hdm_for_passthrough=true \
-device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.2,hdm_for_passthrough=true \
-device cxl-rp,port=0,bus=cxl.1,id=cxl_rp_port0,chassis=0,slot=2 \
-device cxl-rp,port=1,bus=cxl.2,id=cxl_rp_port1,chassis=1,slot=2 \
-device cxl-upstream,port=0,sn=1234,bus=cxl_rp_port0,id=us0,addr=0.0,multifunction=on, \
-device cxl-upstream,port=0,sn=5678,bus=cxl_rp_port1,id=us1,addr=0.1,multifunction=on, \
-device cxl-switch-mailbox-cci,bus=cxl_rp_port0,addr=0.3,target=us0 \
-device cxl-switch-mailbox-cci,bus=cxl_rp_port1,addr=0.3,target=us1 \
-device cxl-downstream,port=0,bus=us0,id=swport0,slot=4 \
-device cxl-downstream,port=0,bus=us1,id=swport1,slot=5 \
-device cxl-type3,bus=swport0,volatile-dc-memdev=cxl-mem1,id=cxl-dcd0,lsa=cxl-lsa1,num-dc-regions=2,sn=99 \
-device cxl-type3,bus=swport1,volatile-dc-memdev=cxl-mem2,id=cxl-dcd1,lsa=cxl-lsa2,num-dc-regions=2,sn=100 \
-device usb-cxl-mctp,bus=ehci.0,id=usb0,target=us0 \
-device usb-cxl-mctp,bus=ehci.0,id=usb1,target=us1 \
-device usb-cxl-mctp,bus=ehci.0,id=usb2,target=cxl-dcd0 \
-device usb-cxl-mctp,bus=ehci.0,id=usb3,target=cxl-dcd1 \
-machine cxl-fmw.0.targets.0=cxl.2,cxl-fmw.1.targets.0=cxl.1,cxl-fmw.0.size=2G,cxl-fmw.1.size=2G,cxl-fmw.0.interleave-granularity=1k,cxl-fmw.1.interleave-granularity=1k

[3] Backtrace

#0  object_class_dynamic_cast  at ../qom/object.c:966
#1  0x0000555555f593c7 in object_class_dynamic_cast_assert (class=0x7ffbcf4f7010, typename=0x5555562385d4 "cxl-type3",
    file=0x555556238580 "include/hw/cxl/cxl_device.h", line=865, func=0x555556238f60 <__func__.44683> "CXL_TYPE3_CLASS") at ../qom/object.c:1016
#2  CXL_TYPE3_CLASS  at include/hw/cxl/cxl_device.h:865
#3  cxl_destroy_dc_regions  at ../hw/mem/cxl_type3.c:922
#4  ct3_exit  at ../hw/mem/cxl_type3.c:1309
#5  pci_qdev_unrealize  at ../hw/pci/pci.c:1445
#6  device_set_realized  at ../hw/core/qdev.c:583
#7  property_set_bool  at ../qom/object.c:2375
#8  object_property_set  at ../qom/object.c:1450
#9  object_property_set_qobject  at ../qom/qom-qobject.c:28
#10 object_property_set_bool  at ../qom/object.c:1520
#11 qdev_unrealize  at ../hw/core/qdev.c:290
#12 bus_set_realized  at ../hw/core/bus.c:205
#13 property_set_bool  at ../qom/object.c:2375
#14 object_property_set  at ../qom/object.c:1450
#15 object_property_set_qobject  at ../qom/qom-qobject.c:28
#16 object_property_set_bool  at ../qom/object.c:1520
#17 qbus_unrealize  at ../hw/core/bus.c:179
#18 device_set_realized  at ../hw/core/qdev.c:577
#19 property_set_bool  at ../qom/object.c:2375
#20 object_property_set  at ../qom/object.c:1450
#21 object_property_set_qobject  at ../qom/qom-qobject.c:28
#22 object_property_set_bool  at ../qom/object.c:1520
#23 qdev_unrealize  at ../hw/core/qdev.c:290
#24 bus_set_realized  at ../hw/core/bus.c:205
#25 property_set_bool  at ../qom/object.c:2375
#26 object_property_set  at ../qom/object.c:1450
#27 object_property_set_qobject  at ../qom/qom-qobject.c:28
#28 object_property_set_bool  at ../qom/object.c:1520
#29 qbus_unrealize  at ../hw/core/bus.c:179
#30 device_set_realized  at ../hw/core/qdev.c:577
#31 property_set_bool  at ../qom/object.c:2375
#32 object_property_set  at ../qom/object.c:1450
#33 object_property_set_qobject  at ../qom/qom-qobject.c:28
#34 object_property_set_bool  at ../qom/object.c:1520
#35 qdev_unrealize  at ../hw/core/qdev.c:290
#36 pcie_cap_slot_unplug_cb  at ../hw/pci/pcie.c:574
#37 hotplug_handler_unplug  at ../hw/core/hotplug.c:56
#38 pcie_unplug_device  at ../hw/pci/pcie.c:585
#39 pci_for_each_device_under_bus  at ../hw/pci/pci.c:2017
#40 pcie_cap_slot_do_unplug  at ../hw/pci/pcie.c:595
#41 pcie_cap_slot_write_config  at ../hw/pci/pcie.c:890
#42 cxl_rp_write_config  at ../hw/pci-bridge/cxl_root_port.c:295
#43 pci_host_config_write_common  at ../hw/pci/pci_host.c:96
#44 pci_data_write  at ../hw/pci/pci_host.c:138
#45 pci_host_data_write  at ../hw/pci/pci_host.c:188
#46 memory_region_write_accessor  at ../system/memory.c:488
#47 access_with_adjusted_size  at ../system/memory.c:564
#48 memory_region_dispatch_write  at ../system/memory.c:1544
#49 flatview_write_continue_step  at ../system/physmem.c:2977
#50 flatview_write_continue  at ../system/physmem.c:3007
#51 flatview_write  at ../system/physmem.c:3038
#52 address_space_write  at ../system/physmem.c:3158
#53 address_space_rw  at ../system/physmem.c:3168
#54 kvm_handle_io  at ../accel/kvm/kvm-all.c:2814
#55 kvm_cpu_exec  at ../accel/kvm/kvm-all.c:3213
#56 kvm_vcpu_thread_fn  at ../accel/kvm/kvm-accel-ops.c:51
#57 qemu_thread_start  at ../util/qemu-thread-posix.c:393
#58 start_thread  from /lib64/libpthread.so.0
#59 clone () from /lib64/libc.so.6

Joshua Lant (1):
  cxl_type3: fix segfault in cxl_destroy_dc_regions

 hw/mem/cxl_type3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.43.7

