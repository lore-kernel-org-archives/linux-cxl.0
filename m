Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2419F324B38
	for <linux-cxl@vger.kernel.org>; Fri,  5 Dec 2025 14:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764943479; cv=none; b=Kbot8vLIrCVKU7Q0mTyOM5Ocg9WonuzwUSH/3K0ert6lu409dGXs1gEoUQasDEc+m5Tv1w++PDNhqOvBLuiiyAgRsvbKX3hiZWBo/2JKxrd69xC7n/hmChM9dhRdNxIdw2iZKpgy5ezhJR+SGQU/iRsoSII1RoemNyvpDGptw9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764943479; c=relaxed/simple;
	bh=nAVAxoHX/3e1FKrZCqyYcLI3Fthw7pp8eAz/Thl+ioo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jx7nhHfDNP7BQqDoWLNfQTKYmwjC3qokGWhaZTEMDOVOTg6RAG18+/gpOMuo1kUMMC36g+P1Z7abgc86+a0hsVUl5DLixhGAXMM/sI9kKiNJ5M3eJOc3USgxYuV11XfIIsENQk9tNZzXXiWNvBCqqgm+0km/uT5Ct8juv0T5LYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g/3SuInp; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/3SuInp"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4775ae77516so25565585e9.1
        for <linux-cxl@vger.kernel.org>; Fri, 05 Dec 2025 06:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764943473; x=1765548273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=teTVx5FpRgNHugLjgv6DpdjOhCLIoi1m57Z9UXxEvdU=;
        b=g/3SuInpBjGuw0q43u1+HaA6WOZln3EhHfb62nAlJ1hG1njO8BOczLz1XBqmrIGqQo
         uSBgREX6cw4NhInWEuNV+QlbLgs8XWyfKLFz1DSlRM9Le3iJsPnFzKS36KJ4vlldv+vb
         3sBnINJiNSmJxaBRVgHT7z5HyBayCKbpF9aV8x7iKdHs7MMz8MSx+YTuHhuZaOFFvq3c
         h7Gw1q6Do6egeilV966SFIcBW/R5ydx04UoWsgpSmohcCADge6bo2db5L+rfKZJifWE4
         OPGdGuA8xUMoXS+Tn0wwvoC27DmD8LfoHPNnCT3uzFy+RXEOAOJhq2/t3qXq55zku3CH
         2hog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764943473; x=1765548273;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=teTVx5FpRgNHugLjgv6DpdjOhCLIoi1m57Z9UXxEvdU=;
        b=ajwXZjR4Gw+5lqk+NL79kp31P0/1RCHAjMBCuPcm24zm22+zzyPrhPLKJLa6982k0S
         YgZosRzfBw8GicSS130I5JRg+ZclOtBCCe6v2/w7DDgJTA15myzaKU4CvZH4edc8JWSy
         xNaK/ZyrNG76gYhBIB0pjXsNOAtsoAt9DGDhrwXeXM5H6/PkHWVacfgb5SmZKCGvpdtz
         D2z9ufp6SUot3SLtHIGSTAFUgS4cAQLviaMAJ5TbrdgKV3LaBs91TZM4bdMpZkZtB6ds
         W/YVgIXgHQRZyLI75zD/ZIIEJyHBVu1cTJ+wsQHf3W9KpXR+yR1oeVM048yDVQvBj2XW
         jVSA==
X-Gm-Message-State: AOJu0YzHlAQ8HpiAqACMNeMlX/c5Rpof5D22d2GaR2qHodvPcoSTWdBb
	giC4VUrp3lvA/uxelAL3xr9WvNl+6vsSYka8uW6phwgFSAOQ1aNGdyZjPrJExpSWn64=
X-Gm-Gg: ASbGnct92GvuKQz+YNbAs3Ct/K+XAMGQ62BopZhdGAX8xqbIOSvFH5p8LiymzJbjCeq
	4CCSoMLP/3OJUeuf/yt3JKx2VGzoM3geGtoq2/k8l90kwhWnhtc+I/11VyuhHrLmV9s4Lsju1Cf
	7P33Gc50aIu2A+eIrWAQ9rfJQdrhyR7uyXryhyswHIPOTc41v9mpAMhkk9VsbAUqPW8O4k1TwAe
	KNr0h8Qlx7CMuI8BJyqoa+jahVv2yKuEjgNjaYL0dXevg2QSjhgN7TeNHxced76ITAvqPAC5yJ9
	DZ9qGvLjDVJfkr9N6lEzemC6eBA6zGgJIWCSTvaF4/Y00KaVOMi5xgad4wsK3zCdwsJO/o5Ulth
	GYkij4d8jFb+ctRkkJRGXQIfJ+kj93i7cwxhCwulqT60p39s7wlfNtx3X/xm2lXTEKuB68Bp5yL
	tScsvncz4RYCZEWcivFrvYJPvdtnT2dGEb/FF1VVa6mFTcJcReuA==
X-Google-Smtp-Source: AGHT+IGeZAzl37ilQvEQ6Kz78+6gk2JWXEA9zXHzuKlJkMkd1O+24t4ra5qUBb7OJxZpOA3phZc1/A==
X-Received: by 2002:a05:600c:5252:b0:477:58af:a91d with SMTP id 5b1f17b1804b1-4792aedfbddmr97473225e9.5.1764943473320;
        Fri, 05 Dec 2025 06:04:33 -0800 (PST)
Received: from node1.manccluster.local (revolution.cs.man.ac.uk. [130.88.198.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4793093ac44sm90256165e9.8.2025.12.05.06.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 06:04:32 -0800 (PST)
From: Joshua Lant <joshualant@gmail.com>
To: linux-cxl@vger.kernel.org
Cc: jonathan.cameron@huawei.com,
	Joshua Lant <joshualant@gmail.com>
Subject: [QEMU PATCH 0/1] cpmu: segfault issue with hotplug event
Date: Fri,  5 Dec 2025 14:03:28 +0000
Message-ID: <20251205140427.3532906-1-joshualant@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

The CXL device topology shown below casues a hotplug event at some
point during boot. This triggers a segfault in cpmu_timer_update due
to a dangling pointer. The teardown of the pci devices has already
happened at this point. However, the associated CPMU timers remain in
the timer_list. We need to remove them before the rest of the device
teardown happens. This should not cause any issue, since if a hot-add
happens the realize function for the corresponding device will be called 
and the timers will be set up once again (although I have not tested 
this scenario. Only that I can now complete the boot process correctly).

Many thanks,

Josh

qemu: https://gitlab.com/jic23/qemu -b cxl-2025-10-03-draft
kernel: https://github.com/weiny2/linux-kernel.git -b dcd-v6-2025-04-13 
device topology:

-device usb-ehci,id=ehci \
-object memory-backend-file,id=cxl-mem1,share=on,mem-path=/tmp/t3_cxl1.raw,size=8G \
-object memory-backend-file,id=cxl-lsa1,share=on,mem-path=/tmp/t3_lsa1.raw,size=1M \
-object memory-backend-file,id=cxl-mem2,share=on,mem-path=/tmp/t3_cxl2.raw,size=8G \
-object memory-backend-file,id=cxl-lsa2,share=on,mem-path=/tmp/t3_lsa2.raw,size=1M \
-device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.0,hdm_for_passthrough=true \
-device pxb-cxl,bus_nr=48,bus=pcie.0,id=cxl.1,hdm_for_passthrough=true \
-device cxl-rp,port=0,bus=cxl.0,id=root_port1,chassis=0,slot=1 \
-device cxl-rp,port=1,bus=cxl.1,id=root_port2,chassis=1,slot=1 \
-device cxl-upstream,port=0,sn=1234,bus=root_port1,id=us0,addr=0.0,multifunction=on, \
-device cxl-upstream,port=0,sn=5678,bus=root_port2,id=us1,addr=0.1,multifunction=on, \
-device cxl-switch-mailbox-cci,bus=root_port1,addr=0.3,target=us0 \
-device cxl-downstream,port=0,bus=us0,id=swport0,slot=3 \
-device cxl-downstream,port=0,bus=us1,id=swport1,slot=4 \
-device cxl-type3,bus=swport0,volatile-dc-memdev=cxl-mem1,id=cxl-dcd0,lsa=cxl-lsa1,num-dc-regions=8,sn=99 \
-device cxl-type3,bus=swport1,volatile-dc-memdev=cxl-mem2,id=cxl-dcd1,lsa=cxl-lsa2,num-dc-regions=8,sn=100 \
-machine cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=8G,cxl-fmw.1.targets.0=cxl.1,cxl-fmw.1.size=8G"

Joshua Lant (1):
  cpmu: teardown cpmu timers on device exit

 hw/cxl/cxl-cpmu.c              | 8 ++++++++
 hw/mem/cxl_type3.c             | 5 +++++
 hw/pci-bridge/cxl_downstream.c | 2 ++
 hw/pci-bridge/cxl_upstream.c   | 4 ++++
 include/hw/cxl/cxl_cpmu.h      | 1 +
 5 files changed, 20 insertions(+)

-- 
2.47.3

