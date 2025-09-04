Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9513286D57
	for <linux-cxl@vger.kernel.org>; Thu,  4 Sep 2025 09:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756976637; cv=none; b=tKeJjChhZ/Uwo9D/KbmaCau0FgrPkxmbsVZkkIBLtN4FR92JmwiTWIXVqb8iY0JRq1XJc03df4mlK+EHF/IAuVqFEdb9yuGTZEm30OU+a5qu2rpyvbDsSlIoUEYdQ3ZS8TqpnM9mJLxDjip1b+0gL0zsS0ygTHtx/MNFaX1BVrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756976637; c=relaxed/simple;
	bh=lj68DGUg3a3XjTVCjmdWrnRoixi/KzTIP7J/zhi5sZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o8SAvRv3Io9bCrXOGeNtuQI6BUGgtlp6+JwEDwb7LnUSI8s8eSvCATfrNvIKzj7rRlzvinrjLBfGQBmOVZLo0FGXQ+s3e/PA/ysXaDV9n57d0MAMR0Kd5EafBPa8A69CjDYpF6aptLBdTZMMAKMiloxSNu4Q77XZAyowmZX4VMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=QTfimo+X; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="QTfimo+X"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45b7da4101fso2498415e9.3
        for <linux-cxl@vger.kernel.org>; Thu, 04 Sep 2025 02:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1756976633; x=1757581433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uy1zdFUPgEn6cfiZIBLCTaadeEyM1a4xkC9unBWQrSU=;
        b=QTfimo+Xl8Uyh6gfBr/9EiQn8wfsgI5efngUHwtxULh2VLzMxL2+POqIvBnVURcwY5
         MyPwRjJATgCxVecdgRCYxxORAXrRJqCzvpCcG2n7MdGPP2WGhcijSC86gizaFMkiise5
         T8Q1YH+Vv16hlgfc+v/Jh5jq6u4mFzUJmBn8D7kG/leLuP6WVn1hfNrmzxY8ZrQuVkS7
         QiyPgX5UVJ/QWxXnv4ayC81ydsaaPDB3uFkGNSlVtEMqz+R6Hm9bFhpcWJVGjcZB/54B
         XGz74I9l3UWUTHLU8bb8aczSctGkbJePM2Z+IxbXfOosfmTin0Bl+PB7mjrwVB43yGvP
         JgWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756976633; x=1757581433;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uy1zdFUPgEn6cfiZIBLCTaadeEyM1a4xkC9unBWQrSU=;
        b=HkAGQbYVI4MmpPzxsaxSzLou0dgzL2h4Tci94GsJ9BwimNSYvArC9B4SXRXse0DZyM
         OQgvqSZKqw/EPEKMZDvdIRScKY2R1PBcvMhw3yOzL/YcnbmTZftRY5TVKUTdrj7FNlnq
         EhNkOP076VyjzYWA/zLyyaxwaOEMwABFiOfoifj31Gf7jQ47vJgtEwOVSNp+Re+3J0cF
         PBLDiygGNpXmXOFJPWuArOj298ENB5CZRwbyYGrq2YraUYl/6w9h8dhsVRT2ejQ0+4vG
         iYnwUPSrU0joOB9Es0dEcFe/XAaAWiD5B66kM2ASAlChTOnw9yjHmtvjh16UJWfbtOJK
         v9KA==
X-Gm-Message-State: AOJu0YwuVnP/LUhcWcyvlQWqJsOczW3GOrAAH/FaEazkEZYeuGvzxS3x
	MSanFeDpww8oep0/VeF7k7FGzbG5ARMO/PqPE3mq0SvrEirRGr68Mxs8XKCbBXFb
X-Gm-Gg: ASbGncsF6pzZ9h/VMSxqUw7VPiNcgStmEr/RAsFVxPeewVq/0Z62SKJfRwiDVymmrgf
	/llitVDuFI4Vfy4JWTk+9FoyNtj7XYNg3YT62Waz2ibFuN5mlZ8KIG3HKP3gkMWMPFkk3t6TTeP
	fPvcI6AXGaAxgxwgYwQvBS3m26pScka+L/WDYql4ne8LDjQTlnSDYbkqwIl5B9kClrbyMLJzGoM
	Zmx7DuZCjLhHPO69Ul8RpY+RzvW3eLtQJK+Qm0un97FNEGKMzKVo16+VsuMIgvZVr7serpverwN
	HonZ6FAMUUx5rA5bAHH1Ci2O772DirEyR+gPiHatchoGcR4D2Qg0jTC1EW2Gf4lcVt0P2xlMCSc
	WgLNL9/I1R/Bp81p0Xg84v4VCw9OSKCag8/I+bBpgExJ/ow==
X-Google-Smtp-Source: AGHT+IHNL72pCFAUEajnaJKxrDm0JHT1NsdRDboY34JId/PevQKFYkwqwusZGVQ/UT+wFVf+Je3qEw==
X-Received: by 2002:a05:600c:314c:b0:45d:d356:c358 with SMTP id 5b1f17b1804b1-45dd3a26584mr4109005e9.16.1756976632564;
        Thu, 04 Sep 2025 02:03:52 -0700 (PDT)
Received: from node1.manccluster.local ([130.88.198.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6f0c6dc1sm359579605e9.1.2025.09.04.02.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 02:03:52 -0700 (PDT)
From: Joshua Lant <joshualant@googlemail.com>
X-Google-Original-From: Joshua Lant <joshualant@gmail.com>
To: linux-cxl@vger.kernel.org
Cc: Jonathan.Cameron@huawei.com,
	Joshua Lant <joshualant@gmail.com>
Subject: [QEMU- PATCH 0/1] cxl_type3: segfault in cxl_destroy_dc_regions
Date: Thu,  4 Sep 2025 10:02:21 +0100
Message-ID: <20250904090346.884649-1-joshualant@gmail.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi there,

A typo[1] in a qemu command[2] of mine is causing a segfault[3] in qemu during
boot, due to cxl_destroy_dc_regions being called inside what looks like a
hot-remove event. I realise my command is not correct more generally, as it does not
achieve what I want. However, the issue appears to be in qemu, due to the 
use of CXL_TYPE3_CLASS() rather than CXL_TYPE3_GET_CLASS(), as the input is
the device rather than the class (introduced in ef730035567). 

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

