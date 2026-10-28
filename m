Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793207748;
	b=voPSankrCAIPKNeS91/erT8W481gsNQlUQQIig1USWwyENLp0u6nB0IU6eUq/KkTvE/6
	 ufHfy5G6QRxw0PVmqY3nClLOdBA5R9atL+bVIRfWw1iLsY60hH4M3qLbpqk/Vdme2nMML
	 yhEUj112+Ej773N0Owds31ry+4UbqV38EbP1DC8JW43ayCw41Z5YMiNywFl3ND4dHuQYE
	 qmSQtZFsoc5BPklN0hwP8FbGTqc2RlXEZT4Q36buFZduOyJBdUA95KmRLjLzcTi6g+/Ni
	 Wad3fJvuddUe6o6XaWd+3CAUl9cHXhFNLT7lYjlv7lI+U4hsTE97ZhdXVHOyzMR9BLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793207748;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mailer:X-Mutt-Fcc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding;
	bh=Tw+CVCUsPnLtaPci+OIuURX45h98/jNrsEdIgRJ87Qc=;
	b=dIvnjvZyzzP38++tXT7poCwLetc7gYclqyVjSzmeRt95r3BRdRBBFr5edVo/a7h/CI+T
	 q/rJYRqSMoRlro6gTOj06rzGhnD9bX60YfE4ojcB8UdM46uMjZtpkO4HNI9HxnGvn8QgO
	 Ww4XCcetJUvVLBGIHZJyS/HgkSPKPG0ta6+h501KXCKNLAtOUx6HQR41+6EN2tF4Pa9mB
	 nK8jxinHxPYI1FvTv5wTREhuXjJbra9EnoTkenaf0lKNfvI3MfQ9rMt/hlP3fEmxDCbE0
	 PQiFe4m1TbLgSLLeOb5iWsIxBfu4Bg+P1IUWs0SnqUmH7P7ZPZ/mSZAe78v27Ja9/MQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="NjR1e/1p";
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037F6606A324
	for <linux-cxl@vger.kernel.org>; Wed, 28 Oct 2026 17:15:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 037F6606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NjR1e/1p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793207746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tw+CVCUsPnLtaPci+OIuURX45h98/jNrsEdIgRJ87Qc=;
	b=NjR1e/1pUoFUWoVMF/cl6SLfgpETNBph90Z7OUHbFf2moI3sJuI2CCNCn3+4gSinFtm1Mv
	XzykXVF+MwGY3/lIBuZKxbCK5gdLXEhR/C1s/2G19Xsob7oizwqZo4KuNBM6DEoDQmxBdp
	E+gV0oiBVeWxq+SRofizOHAuved+4nA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-hNM2W_-EMKKU6Iv6oEXjew-1; Wed, 28 Oct 2026 13:15:45 -0400
X-MC-Unique: hNM2W_-EMKKU6Iv6oEXjew-1
X-Mimecast-MFC-AGG-ID: hNM2W_-EMKKU6Iv6oEXjew_1793207744
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48dea677afcso727689f8f.1
        for <linux-cxl@vger.kernel.org>; Wed, 28 Oct 2026 10:15:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793207744; x=1793812544;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Tw+CVCUsPnLtaPci+OIuURX45h98/jNrsEdIgRJ87Qc=;
        b=xzYTSDhLZWP6jBH6ynOp+IQoLL87iQvV9Xfs+DH9D4uOu6H7oMTSHKFKj9xqpRxMWd
         ic6YZjqRufrlAH0mWZal31b1OjRIwwZNOX4tKxwblW2ldcCZpf48esmeTF/KbBPlRYcQ
         USWyquvkEiCSXDkl5PLVzz4EMxKSWm/j+Mf9FGj5TwNOx6Q4uG+QzCp+A5NR1249RPlp
         jzPwqgH8q0t97sgponCwgdrAppsCW7yCdVx8K6snN6uSoyy8wUoYAqbgOqIxlsAM8khv
         GOPJ/33jo6mXRKSEJ6B/U3Tb7LpiZ2gPwAdwOomzLrqBPueKCkR6ZYsh7KWQJrLlNPfb
         lgiw==
X-Forwarded-Encrypted: i=1; AKwUvBzBWd5+f3CPCSrRA0j6ABRCNNscVZL4U3R1cY2fcDL/Ue/ChKiLpRpNH6r1+iPwBByiN6VfnHhutCE=@vger.kernel.org
X-Gm-Message-State: AFq9FYI2VTlinMR0uUm3+zuTCsQnRRfHOs1ekmovQ0cRLk9zSJa0Ddz1
	V8GHaXCK+HN7VwXeO5HRSLr9cFdGdzMhVwgWvlHHfDUMvTJyp47nOJDs7Vd/5l2zql+oFNpgBJK
	YDGEgaL8tlfFBPbf5hZ/XhROCxy6zjuJ2o5kkDP+DsyiTWMyb81s61kLYGMkiLQ==
X-Gm-Gg: AYBFou382Yb1DYW8bUN75zBP9M9oGICDcP04T4QfODEzqVv4xlJSiS1qWzdud7vS9RZ
	7FB+pWB0Yf0PkF/ZF/2rmQpgS75oiLmXghBRG0ZQAjb7DbSTEHGWglzjgP6ANYZ/V9vPN/R5QNg
	s7yGkUN0yQIA/38ah2Ps77bFB8xvBjMZwcAXe2aXx40NLz1fM6DU8Np059wR9WYHDd1wbPjPGTI
	pjrkRvVKZZOMGXd6fm01PHO2QyOyF2ufvVTXppQmg5Q5qpLam3V7NvDz4vNfGuD4e87cKzv9oVA
	GY9DK/x5i8n9eJeduN8OS/XJo4arw8ngwWxI883v1uFwQtDzqcCETRRZ9JKtEjH2/tCIXvx1u6z
	BYC26+usq26DVr7M/e5d3f7BXXQhAE94lJYm6yFyk
X-Received: by 2002:a05:6000:98b:b0:48c:6756:dab3 with SMTP id ffacd0b85a97d-48e64945b11mr627103f8f.3.1793207744231;
        Wed, 28 Oct 2026 10:15:44 -0700 (PDT)
X-Received: by 2002:a05:6000:98b:b0:48c:6756:dab3 with SMTP id ffacd0b85a97d-48e64945b11mr627004f8f.3.1793207743665;
        Wed, 28 Oct 2026 10:15:43 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecd354asm28340850f8f.43.2026.10.28.10.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 10:15:43 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:15:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Junjie Cao <junjie.cao@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Junjie Cao <junjie.cao@linux.dev>, Anisa Su <anisa.su@samsung.com>,
	linux-cxl@vger.kernel.org
Subject: [PULL 39/78] hw/cxl: clear poison lists and feature transfer state
 on reset
Message-ID: <4ec0aba480960b90cd0acf2ff08ebbcb71b1973e.1793207602.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: dUQK1pJ4znwzxcT2SirJcTdOyZcrr8RkF4J6ZCa0hKU_1793207744
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

From: Junjie Cao <junjie.cao@intel.com>

The poison lists (active, backup, and scan-media results), their
associated overflow tracking, and the Set Feature partial-transfer
state are all device-internal dynamic state that accumulates during
the device's lifetime.

Per CXL r4.0 Table 8-309 (Identify Memory Device), the "Injects
Persistent Poison" capability bit (offset 41h, Bit[0]) controls poison
retention across reset.  When cleared — the QEMU default — "a
Conventional Reset or CXL Reset shall automatically clear the injected
poison."  Clear all poison lists accordingly, reusing the existing
cxl_clear_poison_list_overflowed() helper for the overflow tracking.

For the Set Feature transfer state, CXL r4.0 Section 8.2.10.6.3 (Set
Feature) requires: "If the Feature data transfer is interrupted by a
Conventional Reset or a CXL Reset, the Feature data transfer shall be
aborted by the device [...] the device shall require the Feature data
transfer to be started from the beginning."  Zero set_feat_info on
reset so any partially transferred Set Feature is abandoned and must
restart from the beginning.

Both clears run after the RESET_TYPE_WAKEUP early-return added in the
previous patch, so this state is preserved across a suspend-to-RAM
wakeup.

Signed-off-by: Junjie Cao <junjie.cao@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260729144645.1552511-8-junjie.cao@intel.com>
---
 hw/mem/cxl_type3.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 26c3773dc0..1ff01121f8 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1327,6 +1327,16 @@ MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
     return address_space_write(as, dpa_offset, attrs, &data, size);
 }
 
+static void ct3d_clear_poison_list(CXLPoisonList *list)
+{
+    CXLPoison *ent, *next;
+
+    QLIST_FOREACH_SAFE(ent, list, node, next) {
+        QLIST_REMOVE(ent, node);
+        g_free(ent);
+    }
+}
+
 static void ct3d_reset_hold(Object *obj, ResetType type)
 {
     CXLType3Dev *ct3d = CXL_TYPE3(obj);
@@ -1377,6 +1387,14 @@ static void ct3d_reset_hold(Object *obj, ResetType type)
         ct3d->cxl_dstate.event_logs[i].irq_enabled = false;
     }
     ct3d->scan_media_hasrun = false;
+
+    ct3d_clear_poison_list(&ct3d->poison_list);
+    ct3d_clear_poison_list(&ct3d->poison_list_bkp);
+    ct3d_clear_poison_list(&ct3d->scan_media_results);
+    ct3d->poison_list_cnt = 0;
+    cxl_clear_poison_list_overflowed(ct3d);
+
+    memset(&ct3d->set_feat_info, 0, sizeof(ct3d->set_feat_info));
 }
 
 static const Property ct3_props[] = {
-- 
MST

