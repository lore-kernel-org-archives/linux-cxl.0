Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB33A2C08DC
	for <linux-cxl@vger.kernel.org>; Sun, 14 Jun 2026 19:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781464208; cv=none; b=D8ooPTlMcB10DqNV3ZR3B6ob9WTTEEWnxewhkz5d4+vmcKn8cfK8d53NaKDg31vmtJnpOGSwkP9H5HswgngW8g5PiVg1GuE5Scw3GCrClSyQDjlG0Kl2X7JmPJfMEd1/xlde9izJ0e2EivsNemtvzt1pHquR0N4IF4K+5Ln1lbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781464208; c=relaxed/simple;
	bh=CUXIhLrrnBhrlL7sLbn8zIcyFh7dhlI839Th9WDBLG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Mw9MVzW97FtT1vqkEvS55sNLOKhJnE+bcdl3EYyz/TWPbfNXxe85PSin29RitVrv+tESSkPc5Pb5XmLnhyqllfKYmRmlZX+HTtJUr7Y9dn98okYdrJgdsBnj8TqgMbHBw3w0VKq4sEevJfMg5DUVO9zKRbWRv192GJfZdqJOvx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RpH65SSs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RpH65SSs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781464205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FFLyL6q6f1wgZeDPSCW9Y0Lt5P1U/oslDNetNFUEjzE=;
	b=RpH65SSs3Xqmg1nH9EsuoH5smgDpQIiuxih8vfcnlZVt1JjtjQeNzk+CNSXiL7L2tc6jPs
	b67FwWjICv9QcgbMtNa1JbOiG+Y5Ep5sGf6xWLqE/+FWt7Oevle7pld/B+w/cI/jbMdXZW
	G95g42fXyVKqLJcWH+qW0/i91WFhqyI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-Dx3lpoCMOSm1N-liNp7wUw-1; Sun, 14 Jun 2026 15:10:02 -0400
X-MC-Unique: Dx3lpoCMOSm1N-liNp7wUw-1
X-Mimecast-MFC-AGG-ID: Dx3lpoCMOSm1N-liNp7wUw_1781464201
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-45ef3aeeb41so1609161f8f.1
        for <linux-cxl@vger.kernel.org>; Sun, 14 Jun 2026 12:10:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781464201; x=1782069001;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FFLyL6q6f1wgZeDPSCW9Y0Lt5P1U/oslDNetNFUEjzE=;
        b=TXIoUjJpaeclkNKrJj1jPBTxyNfLm1b5TJSvABPKqoj7afWgmZSRejm0RDlq+WJuzM
         LR4QY0Mi84ivKxy2nKno9tcdoyOfUR6JEq34Kp8d92Y1PufSlESsfiVBCV4hlBwgpvyA
         RJOaHDnYWuVaGCI4Kt3oX3/5gvv2PblXnl0evyUkEVruBrBKjpREgqikuGJ0wFo1jpyF
         SxRRDxKFYxtWR50C2H7d/EwYYR4wCX6WL2K3I5EaHITlwDLhTiPX2Kr2e4yizJJBPmf/
         pn44WDTpM5Gt0KRzFAXNGtN4lawHOtd7wiqgvVLmBCg3sKb+jpCXZP8dH/oiKQjXBtQ+
         BDpQ==
X-Forwarded-Encrypted: i=1; AFNElJ8OKoCdbnzk4ERtgd8qp1kStuTfNyzG8VlLDBzmzAao7F9RGuJ1tpN61he8o2BOoH9e9ILlgQNJ4PI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/BN3lkNZE6aAi3yCWnFnKCd7QWk5LF5fAi5mqcc8JRa3/D6Jz
	xgNYnHiAs2wt0/UoUpF7e6kM12S+/e05f1+feqYcrjhholeo9t2kgwnu8JY1skelI8g2DY/gDkZ
	zPSoq/0IFfUGOQZZ8awJUBSCAMCSFI+467HGlKRBVqi6mYv9bGBnSduSoKbvbNA==
X-Gm-Gg: Acq92OGV3CwzVcih9bnFa/E05pjp9lGNwMFTOMafd9ecqltoe9Yk8avZr4Z3P0FcF6e
	bF5Y6WkwRb3aKT6ilbTdFnMrjkp68/2FOTf0rWVDpFErvQ0WDlh+4D2yIuM79BVvmp3HaeFi/bg
	6gXarKcku0fKdX3n3Ec3lVuAhNFS3FWH1v7NpM6IXwvi9l7S06AiRSlR11a446u41OkfEQ153mM
	T/fd5RmQioSgdkEumtnxA9CyInO80af9rd62V8RdNXrIIEXBTRDdjl+qOfI3uc//gO6W3AccLBl
	ABlk7ZuxTU04KPxtXdfr+QhBGH8q3UcSmMoN7hQ5Z9FdpLbxSYamFcpA/RDoYDq8nXR2DQ5Eca+
	uxADWNlXSnLsNXF1Q9FfqQk6ZozImY3cpVTvC0gU/j6w=
X-Received: by 2002:a05:6000:288f:b0:460:3234:4472 with SMTP id ffacd0b85a97d-4606dbe5c41mr14337374f8f.40.1781464200747;
        Sun, 14 Jun 2026 12:10:00 -0700 (PDT)
X-Received: by 2002:a05:6000:288f:b0:460:3234:4472 with SMTP id ffacd0b85a97d-4606dbe5c41mr14337339f8f.40.1781464200165;
        Sun, 14 Jun 2026 12:10:00 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2c3782sm23716815f8f.25.2026.06.14.12.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 12:09:59 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:09:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Li Zhijian <lizhijian@fujitsu.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Gregory Price <gourry@gourry.net>,
	Alireza Sanaee <alireza.sanaee@huawei.com>,
	Jonathan Cameron <jic23@kernel.org>, linux-cxl@vger.kernel.org
Subject: [PULL 103/106] hw/cxl: Add a performant (and correct) path for the
 non interleaved cases
Message-ID: <c7f16b110a833482eb99a153cfb5c0c630338f65.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: EKS_OYVVeo-TkoUrkPXonFKxmOLGwyiLRVrepQ5j-QQ_1781464201
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

From: Alireza Sanaee via qemu development <qemu-devel@nongnu.org>

The CXL address to device decoding logic is complex because of the need to
correctly decode fine grained interleave. The current implementation
prevents use with KVM where executed instructions may reside in that memory
and gives very slow performance even in TCG.

In many real cases non interleaved memory configurations are useful and for
those we can use a more conventional memory region alias allowing similar
performance to other memory in the system.

Whether this fast path is applicable can be established once the full set
of HDM decoders has been committed (in whatever order the guest decides to
commit them). As such a check is performed on each commit/uncommit of HDM
decoder to establish if the alias should be added or removed.

Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
Co-developed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Tested-by: Gregory Price <gourry@gourry.net>
Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260318171918.146-4-alireza.sanaee@huawei.com>
---
 hw/cxl/cxl-component-utils.c |   6 ++
 hw/cxl/cxl-host.c            | 201 +++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3.c           |   4 +
 include/hw/cxl/cxl.h         |   1 +
 include/hw/cxl/cxl_device.h  |   4 +
 5 files changed, 216 insertions(+)

diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
index 07aabe331c..a624357978 100644
--- a/hw/cxl/cxl-component-utils.c
+++ b/hw/cxl/cxl-component-utils.c
@@ -143,6 +143,12 @@ static void dumb_hdm_handler(CXLComponentState *cxl_cstate, hwaddr offset,
         value = FIELD_DP32(value, CXL_HDM_DECODER0_CTRL, COMMITTED, 0);
     }
     stl_le_p((uint8_t *)cache_mem + offset, value);
+
+    if (should_commit) {
+        cfmws_update_non_interleaved(true);
+    } else if (should_uncommit) {
+        cfmws_update_non_interleaved(false);
+    }
 }
 
 static void bi_handler(CXLComponentState *cxl_cstate, hwaddr offset,
diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index 2dc9f77007..7e744312f1 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -264,6 +264,207 @@ static PCIDevice *cxl_cfmws_find_device(CXLFixedWindow *fw, hwaddr addr,
     return d;
 }
 
+typedef struct CXLDirectPTState {
+    CXLType3Dev *ct3d;
+    hwaddr decoder_base;
+    hwaddr decoder_size;
+    hwaddr dpa_base;
+    unsigned int hdm_decoder_idx;
+} CXLDirectPTState;
+
+static void cxl_fmws_direct_passthrough_setup(CXLDirectPTState *state,
+                                              CXLFixedWindow *fw)
+{
+    CXLType3Dev *ct3d = state->ct3d;
+    MemoryRegion *mr = NULL;
+    uint64_t vmr_size = 0, pmr_size = 0, offset = 0;
+    MemoryRegion *direct_mr;
+    g_autofree char *direct_mr_name;
+    unsigned int idx = state->hdm_decoder_idx;
+
+    if (ct3d->hostvmem) {
+        MemoryRegion *vmr = host_memory_backend_get_memory(ct3d->hostvmem);
+
+        vmr_size = memory_region_size(vmr);
+        if (state->dpa_base < vmr_size) {
+            mr = vmr;
+            offset = state->dpa_base;
+        }
+    }
+    if (!mr && ct3d->hostpmem) {
+        MemoryRegion *pmr = host_memory_backend_get_memory(ct3d->hostpmem);
+
+        pmr_size = memory_region_size(pmr);
+        if (state->dpa_base - vmr_size < pmr_size) {
+            mr = pmr;
+            offset = state->dpa_base - vmr_size;
+        }
+    }
+    if (!mr) {
+        return;
+    }
+
+    if (ct3d->direct_mr_fw[idx]) {
+        return;
+    }
+
+    direct_mr = &ct3d->direct_mr[idx];
+    direct_mr_name = g_strdup_printf("cxl-direct-mapping-alias-%u", idx);
+    if (!direct_mr_name) {
+        return;
+    }
+
+    memory_region_init_alias(direct_mr, OBJECT(ct3d), direct_mr_name, mr,
+                             offset, state->decoder_size);
+    memory_region_transaction_begin();
+    memory_region_add_subregion(&fw->mr,
+                                state->decoder_base - fw->base, direct_mr);
+    memory_region_transaction_commit();
+    ct3d->direct_mr_fw[idx] = fw;
+}
+
+static void cxl_fmws_direct_passthrough_remove(CXLType3Dev *ct3d,
+                                               uint64_t decoder_base,
+                                               unsigned int idx)
+{
+    CXLFixedWindow *owner_fw = ct3d->direct_mr_fw[idx];
+    MemoryRegion *direct_mr = &ct3d->direct_mr[idx];
+
+    if (!owner_fw) {
+        return;
+    }
+
+    if (!memory_region_is_mapped(direct_mr)) {
+        return;
+    }
+
+    if (cxl_cfmws_find_device(owner_fw, decoder_base, false)) {
+        return;
+    }
+
+    memory_region_transaction_begin();
+    memory_region_del_subregion(&owner_fw->mr, direct_mr);
+    object_unparent(OBJECT(direct_mr));
+    memory_region_transaction_commit();
+    ct3d->direct_mr_fw[idx] = NULL;
+}
+
+static int cxl_fmws_direct_passthrough(Object *obj, void *opaque)
+{
+    CXLDirectPTState *state = opaque;
+    CXLFixedWindow *fw;
+
+    if (!object_dynamic_cast(obj, TYPE_CXL_FMW)) {
+        return 0;
+    }
+
+    fw = CXL_FMW(obj);
+
+    /* Verify not interleaved */
+    if (!cxl_cfmws_find_device(fw, state->decoder_base, false)) {
+        return 0;
+    }
+
+    cxl_fmws_direct_passthrough_setup(state, fw);
+
+    return 0;
+}
+
+static int update_non_interleaved(Object *obj, void *opaque)
+{
+    const int hdm_inc = R_CXL_HDM_DECODER1_BASE_LO - R_CXL_HDM_DECODER0_BASE_LO;
+    bool commit = *(bool *)opaque;
+    CXLType3Dev *ct3d;
+    uint32_t *cache_mem;
+    unsigned int hdm_count, i;
+    int interleave_ways_dec;
+    uint32_t cap;
+    uint64_t dpa_base = 0;
+
+    if (!object_dynamic_cast(obj, TYPE_CXL_TYPE3)) {
+        return 0;
+    }
+
+    ct3d = CXL_TYPE3(obj);
+    cache_mem = ct3d->cxl_cstate.crb.cache_mem_registers;
+    cap = ldl_le_p(cache_mem + R_CXL_HDM_DECODER_CAPABILITY);
+    hdm_count = cxl_decoder_count_dec(FIELD_EX32(cap,
+                                                 CXL_HDM_DECODER_CAPABILITY,
+                                                 DECODER_COUNT));
+    for (i = 0; i < hdm_count; i++) {
+        uint64_t decoder_base, decoder_size, skip;
+        uint32_t hdm_ctrl, low, high;
+        int iw, committed;
+
+        hdm_ctrl = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL + i * hdm_inc);
+        committed = FIELD_EX32(hdm_ctrl, CXL_HDM_DECODER0_CTRL, COMMITTED);
+
+        /*
+         * Optimization: Looking for a fully committed path; if the type 3 HDM
+         * decoder is not commmitted, it cannot lie on such a path.
+         */
+        if (commit && !committed) {
+            return 0;
+        }
+
+        low = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_DPA_SKIP_LO +
+                       i * hdm_inc);
+        high = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_DPA_SKIP_HI +
+                        i * hdm_inc);
+        skip = ((uint64_t)high << 32) | (low & 0xf0000000);
+        dpa_base += skip;
+
+        low = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_SIZE_LO + i * hdm_inc);
+        high = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_SIZE_HI + i * hdm_inc);
+        decoder_size = ((uint64_t)high << 32) | (low & 0xf0000000);
+
+        low = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_BASE_LO + i * hdm_inc);
+        high = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_BASE_HI + i * hdm_inc);
+        decoder_base = ((uint64_t)high << 32) | (low & 0xf0000000);
+
+        iw = FIELD_EX32(hdm_ctrl, CXL_HDM_DECODER0_CTRL, IW);
+
+        if (iw == 0) {
+            if (!commit) {
+                cxl_fmws_direct_passthrough_remove(ct3d, decoder_base, i);
+            } else {
+                CXLDirectPTState state = {
+                    .ct3d = ct3d,
+                    .decoder_base = decoder_base,
+                    .decoder_size = decoder_size,
+                    .dpa_base = dpa_base,
+                    .hdm_decoder_idx = i,
+                };
+
+                object_child_foreach_recursive(object_get_root(),
+                                               cxl_fmws_direct_passthrough,
+                                               &state);
+            }
+        }
+
+        interleave_ways_dec = cxl_interleave_ways_dec(iw, &error_fatal);
+        if (interleave_ways_dec == 0) {
+            return 0;
+        }
+
+        dpa_base += decoder_size / interleave_ways_dec;
+    }
+
+    return 0;
+}
+
+void cfmws_update_non_interleaved(bool commit)
+{
+    /*
+     * Walk endpoints to find both committed and uncommitted decoders,
+     * then check if they are not interleaved (but the path is fully set up).
+     */
+    object_child_foreach_recursive(object_get_root(),
+                                   update_non_interleaved, &commit);
+
+    return;
+}
+
 static MemTxResult cxl_read_cfmws(void *opaque, hwaddr addr, uint64_t *data,
                                   unsigned size, MemTxAttrs attrs)
 {
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 03a5d1751f..cba05ec57d 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -427,6 +427,8 @@ static void hdm_decoder_commit(CXLType3Dev *ct3d, int which)
     ctrl = FIELD_DP32(ctrl, CXL_HDM_DECODER0_CTRL, COMMITTED, 1);
 
     stl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL + which * hdm_inc, ctrl);
+
+    cfmws_update_non_interleaved(true);
 }
 
 static void hdm_decoder_uncommit(CXLType3Dev *ct3d, int which)
@@ -442,6 +444,8 @@ static void hdm_decoder_uncommit(CXLType3Dev *ct3d, int which)
     ctrl = FIELD_DP32(ctrl, CXL_HDM_DECODER0_CTRL, COMMITTED, 0);
 
     stl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL + which * hdm_inc, ctrl);
+
+    cfmws_update_non_interleaved(false);
 }
 
 static int ct3d_qmp_uncor_err_to_cxl(CxlUncorErrorType qmp_err)
diff --git a/include/hw/cxl/cxl.h b/include/hw/cxl/cxl.h
index 998f495a98..d8cd8359d2 100644
--- a/include/hw/cxl/cxl.h
+++ b/include/hw/cxl/cxl.h
@@ -71,4 +71,5 @@ CXLComponentState *cxl_usp_to_cstate(CXLUpstreamPort *usp);
 typedef struct CXLDownstreamPort CXLDownstreamPort;
 DECLARE_INSTANCE_CHECKER(CXLDownstreamPort, CXL_DSP, TYPE_CXL_DSP)
 
+void cfmws_update_non_interleaved(bool commit);
 #endif
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 393f312217..ba551fa5f9 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -685,6 +685,8 @@ typedef struct CXLSetFeatureInfo {
     size_t data_size;
 } CXLSetFeatureInfo;
 
+typedef struct CXLFixedWindow CXLFixedWindow;
+
 struct CXLSanitizeInfo;
 
 typedef struct CXLAlertConfig {
@@ -712,6 +714,8 @@ struct CXLType3Dev {
     uint64_t sn;
 
     /* State */
+    MemoryRegion direct_mr[CXL_HDM_DECODER_COUNT];
+    CXLFixedWindow *direct_mr_fw[CXL_HDM_DECODER_COUNT];
     AddressSpace hostvmem_as;
     AddressSpace hostpmem_as;
     CXLComponentState cxl_cstate;
-- 
MST

