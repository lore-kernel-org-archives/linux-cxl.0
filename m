Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BAF375ADC
	for <linux-cxl@vger.kernel.org>; Mon, 27 Jul 2026 19:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785180038; cv=none; b=NgRrygjJ1J3mbFHY4BHil5FDrJxm7Lt23q+PhCPaNK8Me4Wpt/umvqK2JEbwBgELjL5xs/KaLGd0ay3hJVjZz632w6bNYdCpdoDZ0FwEqRl/Ao8HPnKOR01i2OaktRCBu7YkOb+8YwZvTvWdRr09Ke3RBL6y65OctnsoCRU6GXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785180038; c=relaxed/simple;
	bh=gsfwHDBL3Ajjd4WLPCETroICOfycJZVmoqYo5DQ4vvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=TzfyVzL3a2JWX9/S4PEIL2f/clpPzRG37lxLOeaCGGkj1nvHxH9hSPgIZYkRmmZXUtTzqOd6wv0HGihyWOhIl2FBWxUGShLQYsDTt1gaCDArqy9wz9gYFo2Jlc2cNjtaqGdcgrU+XRehwK9SfiNsGVet0dQEMMdPCFUbYe6FhTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZFE08BzV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZFE08BzV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785180035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SmGEwUN6ZoBQwWGEsj9lWjkAqkITIK5CY/izBuC1F/k=;
	b=ZFE08BzVp2CfOJ1XLPSiVVd0pB1OFJO0fhGT8ATchi4ftb1M4CWuXRzrPoEu/IsbLCri2j
	aHIldtJWjeCy0VJtr2gFCqELXnYUCH3Aee9VeHbDYmdBOpTw8z94MrvKL0gy0GknIFxx1w
	7Pp/OpXj09Nrbaw9sEo1/e2fPWGl/MA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-OwJdXJG-Pkepn4bGTwG0dQ-1; Mon, 27 Jul 2026 15:20:34 -0400
X-MC-Unique: OwJdXJG-Pkepn4bGTwG0dQ-1
X-Mimecast-MFC-AGG-ID: OwJdXJG-Pkepn4bGTwG0dQ_1785180033
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-472c330e555so1795494f8f.1
        for <linux-cxl@vger.kernel.org>; Mon, 27 Jul 2026 12:20:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785180033; x=1785784833;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SmGEwUN6ZoBQwWGEsj9lWjkAqkITIK5CY/izBuC1F/k=;
        b=P+xnVzLdbJ7cUmZnthqPou8WMrAGoXwEU63CP8Tu2DnvtITSlhiBcsPSgvbxWTMYX3
         edKoYcDXcQ+GvXx64GDqhC4e3WoeUKo3s0sqPuF4i57bfUATP5YBaY0IrmIlNBgh4Djh
         kH+38j7xChtzXYiMX5Sr1CxAEl/yr/ulpUj62cp/CeXCzFA2qy7+Im+7MG020Pj4Zni3
         YU7rEYXi0D7mngNkAgQ6qoab4xqSpqVtXJhFhRs3G1961sBjwxM4UUz2chqnKb9/xGCe
         BKz483+OUh/3GBvWuiVQnvCPhpn2SBppv8BAKTJ5RBCEcsNguD1cw8wOsenadbY5UN7M
         C/bQ==
X-Forwarded-Encrypted: i=1; AHgh+RraW7xamkdBUInrUd/vyt8ByyrEefGM03w9D5Ki4xmiQ8HyGwNVioXdLP9twfLN0CDNCEqaiH3xUT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvYP1/6XqiGPyyKMFu3kaHp1GKKVwXYcHD+KRT5WfdkQeBCRh4
	b4dj5svvQB/ohUVChINEmw6QZ55AHRYlOUwwe/TmpGKxEdp0Ugn5z+Me9d44OyGjYABlCAHDKap
	DOU9SPTUoHCBopgC1c9eQqfGrfP/yKRke1OsBISllrWA3jqbj/3766NcxRK8Chg==
X-Gm-Gg: AR+sD11EffCfQrpv6mkwk6wfHPuI2ZR2GkWmy8Nc1DbuyEGzR1fINF3uC/sdDcv9ban
	/zRXXYYsP+T9M6xFGcI2oVZKSGpnCANya/84sToM2ia0t5jG+ny7GLURSer6hA67iu7PF3LAvFb
	R0oyQEpjEFB1dteA0CEOJAodTqdq2++hztsQXzWhDIU9ftU9Og1qGyOzbFrREHjVYITSBXj/F4I
	V3w9hehtKxOJT1htu1PUtO9whVXuKLF2YlVxN+j7hNVxgByawvEeSGTDy4/9TymAbQOpcUbuq2r
	5P+J075eP7AQ3K1kDGUuAV19a94+4bLHgUSOZNejGKgyO8c9grGJZhB/I1XFc5Axw5b2nmfjDOf
	18oRMrqIR0hwR7rHjXPyd0g==
X-Received: by 2002:a05:600c:5487:b0:495:503f:cf9a with SMTP id 5b1f17b1804b1-496b57170aamr112105235e9.9.1785180032830;
        Mon, 27 Jul 2026 12:20:32 -0700 (PDT)
X-Received: by 2002:a05:600c:5487:b0:495:503f:cf9a with SMTP id 5b1f17b1804b1-496b57170aamr112105055e9.9.1785180032344;
        Mon, 27 Jul 2026 12:20:32 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-28-14.inter.net.il. [80.230.28.14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496c45ba4b0sm15597205e9.6.2026.07.27.12.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 12:20:31 -0700 (PDT)
Date: Mon, 27 Jul 2026 15:20:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Haotian Jiang <jianghaotian.sunday@gmail.com>,
	qemu-stable@nongnu.org, Jonathan Cameron <jic23@kernel.org>,
	linux-cxl@vger.kernel.org
Subject: [PULL v2 25/30] hw/cxl: fix OOB access in cxl_doe_cdat_rsp via
 entry_handle
Message-ID: <292902ae4e93dcf33414ec3c6951e02d497cc850.1785179875.git.mst@redhat.com>
References: <cover.1785179875.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1785179875.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dOcU9u-5EzZjUhqwkjwVbt2wahCq4gYvEWxOdseEvR8_1785180033
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

From: Haotian Jiang <jianghaotian.sunday@gmail.com>

cxl_doe_cdat_rsp() takes ent = req->entry_handle (uint16_t, fully
guest-controlled, 0..0xFFFF) and directly indexes cdat->entry[ent]
without checking ent < cdat->entry_len. For a default cxl-type3 with
one volatile memory region, entry_len = 1 + CT3_CDAT_NUM_ENTRIES = 7,
so any entry_handle >= 7 reads past the CDATEntry array into host heap.

The OOB-read base/length are then used in
memcpy(read_mbox + offset, base, len) at cxl_type3.c:298-299, leaking
host heap memory to the guest via PCI_EXP_DOE_RD_DATA_MBOX, and
potentially overflowing the 1 MiB read_mbox heap buffer when the OOB
length field is large.

The same bug exists in the cxl-upstream implementation.

Existing checks do not bound ent: assert(cdat->entry_len) only ensures
the table is loaded; the minimum-length check only guards against a
truncated CDATReq; the entry_handle ternary at line 293 only decides
the next-handle echo, not the current access; pcie_doe_get_obj_len
reads header.length, not entry_handle.

Reproduce: build QEMU with CONFIG_CXL, boot
  -M q35,cxl=on -device pxb-cxl,bus_nr=52 ... -device cxl-type3,...
then send a CDATReq with entry_handle=0xFFFF via the DOE mailbox at
config offset 0x190. Under ASAN this reports SEGV in cxl_doe_cdat_rsp
at cxl_type3.c:281.

Fixes: f5ee7413d5 ("hw/mem/cxl-type3: Add CXL CDAT Data Object Exchange")
Fixes: 882877fc35 ("hw/pci-bridge/cxl-upstream: Add a CDAT table access DOE")
Signed-off-by: Haotian Jiang <jianghaotian.sunday@gmail.com>
Cc: qemu-stable@nongnu.org
Reviewed-by: Jonathan Cameron <jic23@kernel.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260713072336.623604-2-jianghaotian.sunday@gmail.com>
---
 hw/mem/cxl_type3.c           | 3 +++
 hw/pci-bridge/cxl_upstream.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index cba05ec57d..28f41fa623 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -278,6 +278,9 @@ static bool cxl_doe_cdat_rsp(DOECap *doe_cap)
     }
 
     ent = req->entry_handle;
+    if (ent >= cdat->entry_len) {
+        return false;
+    }
     base = cdat->entry[ent].base;
     len = cdat->entry[ent].length;
 
diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
index b6281cbd4c..69773ff163 100644
--- a/hw/pci-bridge/cxl_upstream.c
+++ b/hw/pci-bridge/cxl_upstream.c
@@ -158,6 +158,9 @@ static bool cxl_doe_cdat_rsp(DOECap *doe_cap)
     }
 
     ent = req->entry_handle;
+    if (ent >= cdat->entry_len) {
+        return false;
+    }
     base = cdat->entry[ent].base;
     len = cdat->entry[ent].length;
 
-- 
MST

