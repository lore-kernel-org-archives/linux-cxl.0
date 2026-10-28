Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793207738;
	b=21jS2agmvPuiVfxfPlEwBcu++/iGSgxlbWlfEZyelYFvsH+mMY3L8k6+2phtCg7i80ut
	 CHpL12egKMwuSn3FXpRLX5fpSGcCMc+afSlL26nbSuM5wVQr04tpwQ7N3ehY2BryyvLDZ
	 w8NdWwv2xK33yZXohZ9Agej3wzWDordQHdhT4bKtc+DwDlwjj7OoE8DyC+fFjpevhAVSY
	 JCl6E9VqhsXwfg/8y+5e8RAFQpkDgpMuOkjF9OnTnSe/NmMP18A2UeqQT2VL/VTLKhCft
	 tOlgbZomzC+FOBaLgMS5cET+8W+IPW/vXRaHWLgEY4hqwnKk5Jcain0LzMQi2MGyXrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793207738;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mailer:X-Mutt-Fcc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding;
	bh=pf8PmGwR2YJ387k0YNnxAMREMMMwLfksgc13IZc+PLg=;
	b=5FpIUJAzBXQTvcv14x0NrgmtaCCW+IqKupaiuzJWdOSI5mqlr4CXWWTzQoBU02+iDBB/
	 xFQgR1XQt1cTprsJ/TU4Nwv8h4kQl9igETrItzEffmVBpczZ1bDgtYQc8wkd+wcPzWSMG
	 e9xk9LJgBnouW4Swqjl+tbIZlqQw9S3PMVhTvCcl48YG81AqHJmzA8XVFCuQjCjGIToKQ
	 9fRK9WJiDGY/dQDN5P2p8My7bIIHvNpom0/YcF817H6BIgpoKHIAXG34gzqLc9niCfsoJ
	 pjaW2b/N1xixQpWRoYb4E3yUa7GYi1KZ6C3L6zB/gvEkg6YE+CE1JeJvzj1oekWdYYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=E0hrX6ZZ;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46CE606A31D
	for <linux-cxl@vger.kernel.org>; Wed, 28 Oct 2026 17:15:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D46CE606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=E0hrX6ZZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793207736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pf8PmGwR2YJ387k0YNnxAMREMMMwLfksgc13IZc+PLg=;
	b=E0hrX6ZZ/o++knG5z7jfdP3//YqTV8lDKXtg/itrKpTQo9YUDYlENfBMlZMJ0PSoPyv5DI
	NI5xhXP5giazasR3bT/24AsYz39H3MF6hpT4ZVo+d6fLARfTGL+Lycq+kFDM5r+q65JRpT
	sUCQ2Eh7BZECZs+gK2ydLKI3+m1PJ7E=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-hrRaEAvjPZWOzuzQGW7OKQ-1; Wed, 28 Oct 2026 13:15:35 -0400
X-MC-Unique: hrRaEAvjPZWOzuzQGW7OKQ-1
X-Mimecast-MFC-AGG-ID: hrRaEAvjPZWOzuzQGW7OKQ_1793207734
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48afcecb035so373315f8f.0
        for <linux-cxl@vger.kernel.org>; Wed, 28 Oct 2026 10:15:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793207734; x=1793812534;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pf8PmGwR2YJ387k0YNnxAMREMMMwLfksgc13IZc+PLg=;
        b=hrR/cGTV2ePfx9S8z7Q0e85m++QHRYWVV3buFjsx1hCnbSa0Mb+emeECWpKIndi8J4
         Wvij3Eym4umKMLQidAMoGuvSDX8BoE8vyNzu9lDgKzrxXaV+uZdTIyQzX1p8jROOupRj
         yx5t/j6o0bTdVKUz10ek/uSjwCpRHFy2By7oG7K3U5Fr2jFk8m/+vJGY2xdADJFaEIZI
         4NWdKYPmzwrLEBr5+DkN6tFpqpsjkY5OJrcGNnjENgOBTXTEKwMGiAZjw4ZHewIAgy7J
         Spys0w+uc6OL88VwVOVDSK4F7IbKGfpHpzZoMwzeuEFDExQ0PzNiC79/4V4DGIjzl3VA
         8nOw==
X-Forwarded-Encrypted: i=1; AKwUvByGOSpw3/Scj5G7hbIAWvG9JLj4R6hbnXgJh6d/tDDLcjMz3Oq7qxYA7UWViqTiJjPhR3OFONhwlrY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIJiFB405SR8+zH2sAl4l4q+1iHk528CYGoI3XlTqizfwWDteEb
	6d95inQccSIWlFxgoZoqjcYqvYgZ2yVDGtBSBQlb8VrTUq5aLhCoO2CW1z+qmcWyK6OjjrlN8XW
	QJN9pTspR4z9KwanhoTXneF1t3h5GD4mxtcHTIFRrTLH5HCRKRWBqtjr6gtWm1g==
X-Gm-Gg: AYBFou00bKmOoOKTzUHHoLvD/QKJy1PULtKu8u51180zjExLfpGE4XlKsc9C19dbvKP
	oHVVXllUmGuWWl7hzo4DTxkCUq0GOdmeYE9yuj2zqW5lMsF0aRgG+GMgvvLRgn7+8KiMUmcpZJc
	cNOGk2kKjUL9/JL4A0mu62xjelS8oodzcMkh3UfgDYMF4mv3XpggPkHNyJlRroQEkCW/ulpsPRN
	RSVQY7/Ay3vdTg11XZIcOygjXzw7/em1b3Tb+UEUZe1fPogf3mYOrC9hWbMIqqLdCyGFTzjVns8
	FfylxtYc4M8enwRjlRAU0yOtRCDOvT0wgIWBrYyMcPGAgddLE9igUMurGbmpHuGvH4MBxgwqjO5
	JNYfxwc2j1O/joAzlZGOy4tuLvVgCILV1LqpEijJB
X-Received: by 2002:a05:6000:2285:b0:48d:ed0e:6bb4 with SMTP id ffacd0b85a97d-48e6494c244mr494894f8f.4.1793207733965;
        Wed, 28 Oct 2026 10:15:33 -0700 (PDT)
X-Received: by 2002:a05:6000:2285:b0:48d:ed0e:6bb4 with SMTP id ffacd0b85a97d-48e6494c244mr494832f8f.4.1793207733364;
        Wed, 28 Oct 2026 10:15:33 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecd3705sm35312066f8f.45.2026.10.28.10.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 10:15:32 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:15:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Junjie Cao <junjie.cao@intel.com>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Junjie Cao <junjie.cao@linux.dev>, Anisa Su <anisa.su@samsung.com>,
	linux-cxl@vger.kernel.org
Subject: [PULL 35/78] hw/cxl: convert cxl-type3 to three-phase reset
Message-ID: <a59e80eb792ade6efc48aac5bf0589587e02a5e6.1793207602.git.mst@redhat.com>
References: <cover.1793207602.git.mst@redhat.com>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <cover.1793207602.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: itVoggSHAd-VpJy-F9XjDVf8o91L1pxTvWMxlX9Rglc_1793207734
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

From: Junjie Cao <junjie.cao@intel.com>

Replace the deprecated device_class_set_legacy_reset() registration
with the three-phase resettable interface, following the pattern
already established by the CXL root port (cxl_rp_reset_hold).

Only the hold phase is needed; enter and exit are left NULL.  The
parent hold phase is chained for correctness: TYPE_PCI_DEVICE installs
no hold phase today, so parent_phases.hold is currently NULL and the
chained call is a no-op, but capturing and invoking it is the correct
forward-compatible pattern and mirrors cxl_rp_reset_hold().

No functional change — the reset body is identical; only the
registration path and function signature change.

Signed-off-by: Junjie Cao <junjie.cao@intel.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260729144645.1552511-4-junjie.cao@intel.com>
---
 include/hw/cxl/cxl_device.h |  2 ++
 hw/mem/cxl_type3.c          | 16 ++++++++++++----
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index ba551fa5f9..b7e20e3fe4 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -805,6 +805,8 @@ struct CXLType3Class {
     /* Private */
     PCIDeviceClass parent_class;
 
+    ResettablePhases parent_phases;
+
     /* public */
     uint64_t (*get_lsa_size)(CXLType3Dev *ct3d);
 
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 363ac632f9..734397da62 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1329,13 +1329,18 @@ MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
     return address_space_write(as, dpa_offset, attrs, &data, size);
 }
 
-static void ct3d_reset(DeviceState *dev)
+static void ct3d_reset_hold(Object *obj, ResetType type)
 {
-    CXLType3Dev *ct3d = CXL_TYPE3(dev);
+    CXLType3Dev *ct3d = CXL_TYPE3(obj);
+    CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(obj);
     uint32_t *reg_state = ct3d->cxl_cstate.crb.cache_mem_registers;
     uint32_t *write_msk = ct3d->cxl_cstate.crb.cache_mem_regs_write_mask;
 
-    pcie_cap_fill_link_ep_usp(PCI_DEVICE(dev), ct3d->width, ct3d->speed,
+    if (cvc->parent_phases.hold) {
+        cvc->parent_phases.hold(obj, type);
+    }
+
+    pcie_cap_fill_link_ep_usp(PCI_DEVICE(obj), ct3d->width, ct3d->speed,
                               ct3d->flitmode);
     cxl_component_register_init_common(reg_state, write_msk,
                                        CXL2_TYPE3_DEVICE, ct3d->hdmdb);
@@ -2467,6 +2472,7 @@ static void ct3_class_init(ObjectClass *oc, const void *data)
     DeviceClass *dc = DEVICE_CLASS(oc);
     PCIDeviceClass *pc = PCI_DEVICE_CLASS(oc);
     CXLType3Class *cvc = CXL_TYPE3_CLASS(oc);
+    ResettableClass *rc = RESETTABLE_CLASS(oc);
 
     pc->realize = ct3_realize;
     pc->exit = ct3_exit;
@@ -2480,9 +2486,11 @@ static void ct3_class_init(ObjectClass *oc, const void *data)
 
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
     dc->desc = "CXL Memory Device (Type 3)";
-    device_class_set_legacy_reset(dc, ct3d_reset);
     device_class_set_props(dc, ct3_props);
 
+    resettable_class_set_parent_phases(rc, NULL, ct3d_reset_hold, NULL,
+                                       &cvc->parent_phases);
+
     cvc->get_lsa_size = get_lsa_size;
     cvc->get_lsa = get_lsa;
     cvc->set_lsa = set_lsa;
-- 
MST

