Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83572848BA
	for <linux-cxl@vger.kernel.org>; Sun, 14 Jun 2026 19:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781464203; cv=none; b=gUa7vqsk9BrLGUjZmvbTzneoo9weQ3yo+7sUMREhfA8dbSuls5ZMLhLgiUmltt1xY4hYEzIUkKBQSUhJYmB4mGk7Cs/Z0Z16qqijUYpHCFeg/aK959pMHlaq6//0IjUULZoM4IIlggP13LveuSgRN/nhNuSo7Q4q0W/8XM66OFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781464203; c=relaxed/simple;
	bh=UelFTiBgLSUckXceYzhdnK3o3/oUzEw+GtlZVYqHbzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=cpd3i6eAcX8/l0jtTkZEIQnrWjXLxYkLrl/fgWLMBnnmVGBdgBwFPQoYdsLqQMkypNebhLbrJlC9LYA8R9wt23jLhYStP8RAGZugMwJRbIXNMxY+xR3B6R27sH0OWZ8rYfETy4xUviifBGoeVNHjkw0HgnU1b2TQbYMDBtx5JAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WrombQG7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WrombQG7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781464201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/C87857Tl8XFyJTpzE0YZrg6mxeNYh3lpIo3oiRAqwg=;
	b=WrombQG7wXQugfXPuMYCRGtMffMG8qzjFqQ3mXY7pR50dN9ZjY71VvdZAp5JAKdNTczwwY
	XuGFVRZ3TX6iyHUZfcvccr8fZ19/2/pAJSj/fDVJm47CoAClV3JNgCv/D6TcvzL/aXXbD9
	rNDtNPW0aIihzE4U2wohOkWyn7Y93r8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-xpZlGqTIN9eyQavgD-LAJA-1; Sun, 14 Jun 2026 15:09:59 -0400
X-MC-Unique: xpZlGqTIN9eyQavgD-LAJA-1
X-Mimecast-MFC-AGG-ID: xpZlGqTIN9eyQavgD-LAJA_1781464199
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-45ef55779d1so1830121f8f.0
        for <linux-cxl@vger.kernel.org>; Sun, 14 Jun 2026 12:09:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781464198; x=1782068998;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/C87857Tl8XFyJTpzE0YZrg6mxeNYh3lpIo3oiRAqwg=;
        b=N6O5SRXlgqI6c3x4qSf8c1UG+Cxii90kJWi6A8X2qE2TGRACOZlPEnxZdQL6NEMj5G
         vgGKvMk5ULIKusHwCn5YizuRa5y+Z1PVOy6fyYPWTr69xNLkTrz1JSJ7SJaja/fSOL+/
         2+QgCmmLz7Rga9gsOOtbLhRfbynWN6IBjH31EP3k4s4wYZ467AMKj9UEwPIOdMAt0qPX
         APuStyl6/dhWZsro9AVcTruJK89zGMhVIlgvoXtnfeuh+iYW12jhvNr9yLtjlLDGDgzh
         U7Xeyd66s0EgRJJjOmOCR0lcAueOwTT3JeWKevCJM1bR9tJ/32GgpBmSGoxrNS43ZP5X
         hzIA==
X-Forwarded-Encrypted: i=1; AFNElJ9TBwGxknVmDOKt9dazLUtscEmPf2L12dkM2YV0z+Hz++cBakHTaCG/b42IpnRMotIUySf2Fv9f1SY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4g0+Ud8IGBPn2Ncj7STGsiFydAUXXPWqC+tBtPAOZkTqiW3P6
	LNhD/NubO++Kmv50rgjdvh8sueiL2WEa4ccZJXQx1UF88nAhgQ/VuvM+zxJDEfSuNYkaYrJuG2c
	XKRDC7SKv8X+MogOIzZUOlZJ9y1HNGofhSoMIJvtppvNrbc0/Piqz9NUh/XvWbe0Vq1rF8A==
X-Gm-Gg: Acq92OEfCHUqdZpcTE4g/hMLfamWbqYNG4uElTD4tV+B622oBtlywJ/b7r2zQCvpjgl
	QSrgG5LyGYOdkA2y8chkY/mvLm7c3k/lf4oXUeXx8+GuJ8NeZtKGNCSrG0s6pLu2eAK5lljI/Gz
	MqksMNAtRCxLBEkRmpxv6O8HILlHpOt1+X3ua1fxPiBu+xqQFOQCmTFFvh8PdqJrFXL9aga65jl
	TugzGDXYRlyBLv6HRzKSYHL0nozUQ3Z/N8Rzn+j9uXT15UpnaCJ3/N9gwX/6TTn6f1mVWh+beVV
	D/qq27fuzYsDXWI+yJgzg1yOD7XtJ6gDqKsRMpMlMu5wNKqGdU6Cuy07Wj1WO9twYGro184xkG2
	8bBmc7qM1Mt5Ylmg7NYrGyZliqAejwZwmOqZMq1UOfN8=
X-Received: by 2002:a05:6000:4615:b0:43b:5b25:67f8 with SMTP id ffacd0b85a97d-4606dbdf91emr14863212f8f.20.1781464198501;
        Sun, 14 Jun 2026 12:09:58 -0700 (PDT)
X-Received: by 2002:a05:6000:4615:b0:43b:5b25:67f8 with SMTP id ffacd0b85a97d-4606dbdf91emr14863187f8f.20.1781464197925;
        Sun, 14 Jun 2026 12:09:57 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f26434dsm28020996f8f.1.2026.06.14.12.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 12:09:57 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:09:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Li Zhijian <lizhijian@fujitsu.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Gregory Price <gourry@gourry.net>,
	Alireza Sanaee <alireza.sanaee@huawei.com>,
	Jonathan Cameron <jic23@kernel.org>, linux-cxl@vger.kernel.org
Subject: [PULL 102/106] hw/cxl: Allow cxl_cfmws_find_device() to filter on
 whether interleaved paths are accepted
Message-ID: <57d96c7b8527d60bca37c742ebe418040dbb2fcd.1781463125.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: wYdDf_4fD-oKJu0nkeARPTRyfpA0nUbt-fsthaoZ0GQ_1781464199
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

From: Alireza Sanaee via qemu development <qemu-devel@nongnu.org>

Extend cxl_cfmws_find_device() with a parameter that filters on whether the
address lies in an interleaved range. For now all callers accept
interleave configurations so no functional changes.

Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Tested-by: Gregory Price <gourry@gourry.net>
Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260318171918.146-3-alireza.sanaee@huawei.com>
---
 hw/cxl/cxl-host.c | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index a94b893e99..2dc9f77007 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -104,7 +104,7 @@ void cxl_fmws_link_targets(Error **errp)
 }
 
 static bool cxl_hdm_find_target(uint32_t *cache_mem, hwaddr addr,
-                                uint8_t *target)
+                                uint8_t *target, bool *interleaved)
 {
     int hdm_inc = R_CXL_HDM_DECODER1_BASE_LO - R_CXL_HDM_DECODER0_BASE_LO;
     unsigned int hdm_count;
@@ -138,6 +138,11 @@ static bool cxl_hdm_find_target(uint32_t *cache_mem, hwaddr addr,
         found = true;
         ig_enc = FIELD_EX32(ctrl, CXL_HDM_DECODER0_CTRL, IG);
         iw_enc = FIELD_EX32(ctrl, CXL_HDM_DECODER0_CTRL, IW);
+
+        if (interleaved) {
+            *interleaved = iw_enc != 0;
+        }
+
         target_idx = (addr / cxl_decode_ig(ig_enc)) % (1 << iw_enc);
 
         if (target_idx < 4) {
@@ -157,7 +162,8 @@ static bool cxl_hdm_find_target(uint32_t *cache_mem, hwaddr addr,
     return found;
 }
 
-static PCIDevice *cxl_cfmws_find_device(CXLFixedWindow *fw, hwaddr addr)
+static PCIDevice *cxl_cfmws_find_device(CXLFixedWindow *fw, hwaddr addr,
+                                        bool allow_interleave)
 {
     CXLComponentState *hb_cstate, *usp_cstate;
     PCIHostState *hb;
@@ -165,9 +171,13 @@ static PCIDevice *cxl_cfmws_find_device(CXLFixedWindow *fw, hwaddr addr)
     int rb_index;
     uint32_t *cache_mem;
     uint8_t target;
-    bool target_found;
+    bool target_found, interleaved;
     PCIDevice *rp, *d;
 
+    if ((fw->num_targets > 1) && !allow_interleave) {
+        return NULL;
+    }
+
     rb_index = (addr / cxl_decode_ig(fw->enc_int_gran)) % fw->num_targets;
     hb = PCI_HOST_BRIDGE(fw->target_hbs[rb_index]->cxl_host_bridge);
     if (!hb || !hb->bus || !pci_bus_is_cxl(hb->bus)) {
@@ -187,11 +197,16 @@ static PCIDevice *cxl_cfmws_find_device(CXLFixedWindow *fw, hwaddr addr)
 
         cache_mem = hb_cstate->crb.cache_mem_registers;
 
-        target_found = cxl_hdm_find_target(cache_mem, addr, &target);
+        target_found = cxl_hdm_find_target(cache_mem, addr, &target,
+                                           &interleaved);
         if (!target_found) {
             return NULL;
         }
 
+        if (interleaved && !allow_interleave) {
+            return NULL;
+        }
+
         rp = pcie_find_port_by_pn(hb->bus, target);
         if (!rp) {
             return NULL;
@@ -223,11 +238,15 @@ static PCIDevice *cxl_cfmws_find_device(CXLFixedWindow *fw, hwaddr addr)
 
     cache_mem = usp_cstate->crb.cache_mem_registers;
 
-    target_found = cxl_hdm_find_target(cache_mem, addr, &target);
+    target_found = cxl_hdm_find_target(cache_mem, addr, &target, &interleaved);
     if (!target_found) {
         return NULL;
     }
 
+    if (interleaved && !allow_interleave) {
+        return NULL;
+    }
+
     d = pcie_find_port_by_pn(&PCI_BRIDGE(d)->sec_bus, target);
     if (!d) {
         return NULL;
@@ -251,7 +270,7 @@ static MemTxResult cxl_read_cfmws(void *opaque, hwaddr addr, uint64_t *data,
     CXLFixedWindow *fw = opaque;
     PCIDevice *d;
 
-    d = cxl_cfmws_find_device(fw, addr + fw->base);
+    d = cxl_cfmws_find_device(fw, addr + fw->base, true);
     if (d == NULL) {
         *data = 0;
         /* Reads to invalid address return poison */
@@ -268,7 +287,7 @@ static MemTxResult cxl_write_cfmws(void *opaque, hwaddr addr,
     CXLFixedWindow *fw = opaque;
     PCIDevice *d;
 
-    d = cxl_cfmws_find_device(fw, addr + fw->base);
+    d = cxl_cfmws_find_device(fw, addr + fw->base, true);
     if (d == NULL) {
         /* Writes to invalid address are silent */
         return MEMTX_OK;
-- 
MST

