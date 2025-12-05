Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5245A31327A
	for <linux-cxl@vger.kernel.org>; Fri,  5 Dec 2025 14:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764943481; cv=none; b=O26c1LEakUGHV7Ps7yGrneQDK+YA3B1bpdLv5rj9QMStCE/QZMe33syo4WhHsOAguBFZ2jtqDT9jHGIe/KkFnq7hD0mNUWlFwqghzQLwe9cVMjNtelJ+NkGVEDyMT610yA7IYpPEe8pO5VI8d+o9HKOs8Vc3KydjT8y1JpvnkB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764943481; c=relaxed/simple;
	bh=dTEZQsVp2VD6OkEi28sDh9ioAE2rW7fOusM4DlMMtCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mPuNJKHA3yMQ9svsTI0nhLETZcgrnWhPMiS9jRLMdUTadqRanVgzNzeArbUai42C9CKjZMNmmjBfs1XTO3EA7+56h1jnih6x+5qVu5SjLSxTP+6ycneLCv7Ee7vs6SQqQSjf3m8jLAW5xKLKeiZabdu4YgVyUtgpwPFJ2iXI9Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hIs9Z3Ox; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hIs9Z3Ox"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47778b23f64so13776465e9.0
        for <linux-cxl@vger.kernel.org>; Fri, 05 Dec 2025 06:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764943476; x=1765548276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gTd3UcMoajqs8LGdhUx5KmHHLOp8tWLP3U5Czddq25E=;
        b=hIs9Z3OxCzT3DvPmN8TbiPCIWC9JG1S59AVOkVc0fbXa63m6QdVU7VOhkgFuS4KIad
         AOvRPmJLlbj+ALY4O1M5Fhi30Y78F/86i9z5203aJa7zEJ96oCwkj3QscL7fML8ltbB7
         0yq1qoeYY45VXAhUkjekcM+6GCQjp0DLGte++eKsLeRkH+H9+V0eeK3b9KMwZgK1ZSPf
         QZHjc7rHfaEy2vwPf/rzPo/t+G6UGLS5kooi4/H/Zi1qDkl8lkcU/WuhrjanB0IOil1q
         BYo1HFrx+5p9oVe1Yhh/UHqVdLRKRLX4C8L8vyG4bJQ2y2B+sIvMs4jM6xtcB47luqDo
         8zZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764943476; x=1765548276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gTd3UcMoajqs8LGdhUx5KmHHLOp8tWLP3U5Czddq25E=;
        b=uV3shvAtzNflk43R45rvkGw+KodQVJLZfBGoceSUOUG/Pi7gusKf1AXC79xj3SUdhy
         Df7HI4oGoG0IcTdlJwt3XFNvQ4iueDKuFjUKsaigtooN557vqdED2GDvESAKiL97Bufq
         X6NpdUTg928daKHW5/gSPAFqwIOrCmOcdfct3u8hbzPQX7rOGmjg4FzYO8qYGVwDnGdW
         g24+8RS14GoHSK3GLNLq8mpgrZhbD0TM5r7ecAzcF9EOBbCX1Nqyel37ALrlq0YVihCD
         aD2cVaCPdTA+IQR/mguf1US95gaeUmcP9UVz2++/FQToD8EbbKBU2VUrQSJlIrY+wG59
         tuAw==
X-Gm-Message-State: AOJu0YzDEtb3gsizQ90QdtoGOCRZI+Sg3hVKezVsM+G3p4UkuEGzKhrQ
	VfFs1/znN6Y20GcGq2Kstw8ll6AA6CNIIMKSdbbp3qRvaFn64XMYVpuIE6REstO0uA4=
X-Gm-Gg: ASbGncvr6F9ufAronIDvLK6CYgqQLbQk0voER5NhJfWCgXUsPuMb+UbTq1q/Zq3XlRG
	Dvo3qsvJ7nG0OvrUURasXQPyP3NFUh84SI+rMOQ2kqMCbR6Yer8wa/NpLVUC+rEjLVO+0wzKZvY
	FU7iCzqCiKW9JiZXdNhFTqNoD3WZvIy+5Cs5sSKNvJV8QngHu8Wh6rs7+c+vB1VUV88m/nAPJCk
	LgLyixVSDGPCNjQ15gLQsEp++HL32zmnXM6Q2a+SD+hduYgwmdA5gfBiL3r0xVV0XpEHy1ckbAH
	gvUqYctweyJmyqk2twM8ZqrL4evFLC4gZNunpTgeD8JmosxOtGqKQ3EXOqjnY3XE4lpn3B+N9jB
	PES0UFqwV27caQ6sF2vp0KL4N04HTOBeCwjUUrmiUhB6fNJb5tNfWDNlzOr2Se74pU621qhtwCV
	ILYGRojMexv9eSEoPm+IspDBRtnCUBelfrv13gFpqBZxPb7E6KjA==
X-Google-Smtp-Source: AGHT+IFzNX457WRrwrHY6kVALCID62TLsPTPsSXJ+oY7+CncWinDeMcJdvBzC+66wdp8sqNlVA06WQ==
X-Received: by 2002:a05:600c:458d:b0:477:7af8:c8ad with SMTP id 5b1f17b1804b1-4792af413e3mr117437575e9.31.1764943475424;
        Fri, 05 Dec 2025 06:04:35 -0800 (PST)
Received: from node1.manccluster.local (revolution.cs.man.ac.uk. [130.88.198.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4793093ac44sm90256165e9.8.2025.12.05.06.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 06:04:34 -0800 (PST)
From: Joshua Lant <joshualant@gmail.com>
To: linux-cxl@vger.kernel.org
Cc: jonathan.cameron@huawei.com,
	Joshua Lant <joshualant@gmail.com>
Subject: [QEMU PATCH 1/1] cpmu: teardown cpmu timers on device exit
Date: Fri,  5 Dec 2025 14:03:29 +0000
Message-ID: <20251205140427.3532906-2-joshualant@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251205140427.3532906-1-joshualant@gmail.com>
References: <20251205140427.3532906-1-joshualant@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hot-remove events on CXL devices cause a segfault in QEMU
in the function "cpmu_timer_update" in cxl-cpmu.c,
when casting the input opaque to the CPMUState structure.
This is caused by a dangling pointer to opaque, since the pointer
has been previously freed at some other point during the teardown
of the pci device from the hot-remove.
In order to fix this we need to remove the timers at the start of the
exit functions for the relevant devices, so they never get called
again by qemu_clock_run_all_timers after teardown has happened.
Note that this should not be required for the root port since
it is not hot-pluggable.

Signed-off-by: Joshua Lant <joshualant@gmail.com>
---
 hw/cxl/cxl-cpmu.c              | 8 ++++++++
 hw/mem/cxl_type3.c             | 5 +++++
 hw/pci-bridge/cxl_downstream.c | 2 ++
 hw/pci-bridge/cxl_upstream.c   | 4 ++++
 include/hw/cxl/cxl_cpmu.h      | 1 +
 5 files changed, 20 insertions(+)

diff --git a/hw/cxl/cxl-cpmu.c b/hw/cxl/cxl-cpmu.c
index 2f863d14f6..a25e6fa554 100644
--- a/hw/cxl/cxl-cpmu.c
+++ b/hw/cxl/cxl-cpmu.c
@@ -281,6 +281,14 @@ static void cpmu_counter_update(void *opaque)
     }
 }
 
+void cxl_cpmu_timer_destroy(CPMUState *cpmu) {
+    if (cpmu->timer) {
+        timer_del(cpmu->timer);
+        timer_free(cpmu->timer);
+        cpmu->timer = NULL;
+    }
+}
+
 void cxl_cpmu_register_block_init(Object *obj, CXLDeviceState *cxl_dstate,
                                   int id, uint8_t msi_n)
 {
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 305525c5f7..d07c877ca2 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1299,7 +1299,12 @@ void ct3_exit(PCIDevice *pci_dev)
     CXLType3Dev *ct3d = CXL_TYPE3(pci_dev);
     CXLComponentState *cxl_cstate = &ct3d->cxl_cstate;
     ComponentRegisters *regs = &cxl_cstate->crb;
+    CPMUState *cpmu;
 
+    for(int i = 0; i < CXL_NUM_CPMU_INSTANCES; i++) {
+        cpmu = &ct3d->cxl_dstate.cpmu[i];
+        cxl_cpmu_timer_destroy(cpmu);
+    }
     pcie_aer_exit(pci_dev);
     cxl_doe_cdat_release(cxl_cstate);
     msix_uninit_exclusive_bar(pci_dev);
diff --git a/hw/pci-bridge/cxl_downstream.c b/hw/pci-bridge/cxl_downstream.c
index 6aa8586f01..de256c5abb 100644
--- a/hw/pci-bridge/cxl_downstream.c
+++ b/hw/pci-bridge/cxl_downstream.c
@@ -244,7 +244,9 @@ static void cxl_dsp_realize(PCIDevice *d, Error **errp)
 static void cxl_dsp_exitfn(PCIDevice *d)
 {
     PCIESlot *s = PCIE_SLOT(d);
+    CPMUState *cpmu = &CXL_DSP(d)->cpmu;
 
+    cxl_cpmu_timer_destroy(cpmu);
     pcie_aer_exit(d);
     pcie_chassis_del_slot(s);
     pcie_cap_exit(d);
diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
index c2150afff3..f21b9e41be 100644
--- a/hw/pci-bridge/cxl_upstream.c
+++ b/hw/pci-bridge/cxl_upstream.c
@@ -420,6 +420,10 @@ err_bridge:
 
 static void cxl_usp_exitfn(PCIDevice *d)
 {
+    CXLUpstreamPort *usp = CXL_USP(d);
+    CPMUState *cpmu = &usp->cpmu;
+
+    cxl_cpmu_timer_destroy(cpmu);
     pcie_aer_exit(d);
     pcie_cap_exit(d);
     msi_uninit(d);
diff --git a/include/hw/cxl/cxl_cpmu.h b/include/hw/cxl/cxl_cpmu.h
index 872a75ccc9..6f3b191a7d 100644
--- a/include/hw/cxl/cxl_cpmu.h
+++ b/include/hw/cxl/cxl_cpmu.h
@@ -99,4 +99,5 @@ void cxl_cpmu_register_block_init(Object *obj,
 void cxl_cpmu_register_block_init2(Object *obj, CPMUState *cpmu,
                                    MemoryRegion *registers,
                                    int id, uint8_t msi_n);
+void cxl_cpmu_timer_destroy(CPMUState *cpmu);
 #endif
-- 
2.47.3

