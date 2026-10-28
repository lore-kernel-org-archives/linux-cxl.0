Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793207746;
	b=v7mGuy3flCdGzSgFpJezmEKDjaPlgvWyeyzOTiR3UA4waWaS3K+3hHlN2jGPViR01NG1
	 OXlapUjksaBTfGm1pr3rle2hLjBkpGH2r3+GcR6qTcCk9kgMu0XtRJraRZ/pU0VCBSPmI
	 g4bGk89YPg5N0fjmBcTryDpx77Y22gUEfk5JSUiYVVKr9crxfAUMJZG54FGbTW3/DIlK3
	 Tvc+H/Dl3NaWFAC7vTpSy8884eXKmR7HKpRpO1BT4h+lzSpJyThIpe7BK7t3ccqa4Hjjc
	 2Bfp4bk1sYaCV/mam/V0IVsF5b0XPRQZDdtOy0UYJaw2khKqphLidpP9A2YT5XgLU/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793207746;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mailer:X-Mutt-Fcc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Disposition;
	bh=pbKioKf7eRKWzM2JXaJWvZSryHLaVe5ykt2zdqy8CVk=;
	b=jcKlRph8+iFR8HHDbkpaCmrzO4yyws4/v2uSpA+g8+++ATd3lVmPPKiDa0aluI9LV1tc
	 U5rvOYfwmzPTOja90bPIDWVc+GGLbRZU2R1TnfLZdEFK5aT2uqTTro5LDdYi3G5TjItAK
	 qMpdKldJOjO15m/IOVvi2qodE2KT1fdFNaoG7ciQhY82AWa73xlgrS/ZHUrKD39db5OJ1
	 rhhXSpU4qRK+tiN2cVbHu1BtT7YRhbfjt4UzFFetGNKIIw4hyPWXJ8Z5TRCY3/k+M4W8f
	 FctbAbZqJddjB940WfEf9QP1kw4XBo7s+YaxqFQKMQ60kWdgpV9ZkKO8HA1hFPTxiMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gHstaVWI;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E81606A31C
	for <linux-cxl@vger.kernel.org>; Wed, 28 Oct 2026 17:15:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7E81606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gHstaVWI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793207744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pbKioKf7eRKWzM2JXaJWvZSryHLaVe5ykt2zdqy8CVk=;
	b=gHstaVWIVDOIevJPVltxVtuEOz+u0x8Zg3rwQ06kcosBjmS5lrpTN8gm2xZkjr5XfRwO6B
	2XxGEcMEg3BYFzO84c1Mcg0HN4H3kExjVBkWdwRBWPp/xuAq6m0ZiyYn8Crvef3/K4O3Pw
	X5cfFo5cUEPtl28N2hY3ETuK99sVWKo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-3rTVOwznNYet0SG819u52A-1; Wed, 28 Oct 2026 13:15:43 -0400
X-MC-Unique: 3rTVOwznNYet0SG819u52A-1
X-Mimecast-MFC-AGG-ID: 3rTVOwznNYet0SG819u52A_1793207742
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48e0af48c18so939679f8f.2
        for <linux-cxl@vger.kernel.org>; Wed, 28 Oct 2026 10:15:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793207742; x=1793812542;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pbKioKf7eRKWzM2JXaJWvZSryHLaVe5ykt2zdqy8CVk=;
        b=fM8/dbVgr7ATdG95y1mLPfIV83KAFpLCvembiMfA6q7JiqnA0SzCBcxaQj7cvMKwiW
         47xhzHbDZsNThxg/TtIOrjrxsif9SN45WAvS+Bkh7yYvgXVox68xO9jZl2ocQAsLEwVr
         UtaHM72Qzsei0XdKL+3lEci2ADLsAIBXVSbcFFAnFxsS5P4nCSib3ZPhI5WrxL/6mbdg
         2raTnj706E9s7I90QREOOu/kC2psNcvCwyVn15E2TEV5g7ODAgaGPoD/uvrA+VZBSzkp
         19j8x4d2isoYXjhNa0A/gkeRFBZuluNIIMbNI5p8ms2umwNjNJyJdoRC0KTEtbPD3SPl
         1TAQ==
X-Forwarded-Encrypted: i=1; AKwUvBzaunyVGbKlBndGCpNhf+4n4x8NPoD76cINXrNsvaW0IewTRRxIl+nWLpyBurlletmoJAfzpaM+C0o=@vger.kernel.org
X-Gm-Message-State: AFq9FYImtGAjZ06GFkcLg57QqfD3tyz3TyvFL+ntCG3J/+7J3RcJ8PPl
	FAvBOxS+/dT2Ara84je+2DNbhLe0GVwwc6DkwIGoyW7n6aijqaWHRRsdyvJBeVmCDb6manWUu6N
	hu79+RRa0qJTL+EAQtjRvcRI0OdKH9JIWmnj7JdkTNJ0eFUKocsgExOz7AiK8wA==
X-Gm-Gg: AYBFou0z3MiRF6Gepc3kx3P6LpWlSSCwxT8evtSXwYUozA6n1mmg1QvSw9XXaA4usqO
	OGshZQwQC3EO5HLMwpa2L6Fj1kJ5rRT/dlL7W0+DPKv9ggKR/FCIseYrPBAoJO37SFPPdpaMgT9
	5mq+s4VrJm8E/5tqUOvWC9iuAH9mpeF0Fw5r+abi8NwerwyIbhE/52aJjKXGzsrpbOp4FaqqgCu
	N27ucs8aWSsnD5H2I6lAXN9U5O+3YMlLaDLHcABMC/GbOvcRJrywFtDU+rjj0EAN0RVMxzq5Cc7
	MZ05gECv3dvUigvKXU+zv/c4c1S97XqQGNWB139I8wE4wybV0Dbbn2yawg7AUwkIYCoVJeLSxpB
	s7c+qPMjikxAEseD9TSdXF88k3TWnpKk4+UIvi5r9
X-Received: by 2002:a05:600c:4ece:b0:4a1:6c0c:ab93 with SMTP id 5b1f17b1804b1-4a9674e69dcmr67241995e9.28.1793207741890;
        Wed, 28 Oct 2026 10:15:41 -0700 (PDT)
X-Received: by 2002:a05:600c:4ece:b0:4a1:6c0c:ab93 with SMTP id 5b1f17b1804b1-4a9674e69dcmr67241355e9.28.1793207741312;
        Wed, 28 Oct 2026 10:15:41 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa7ee57589sm7095275e9.2.2026.10.28.10.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 10:15:40 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:15:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Junjie Cao <junjie.cao@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Junjie Cao <junjie.cao@linux.dev>, Anisa Su <anisa.su@samsung.com>,
	linux-cxl@vger.kernel.org
Subject: [PULL 38/78] hw/cxl: clear event logs, scan media and interrupt
 policy on reset
Message-ID: <a82f0c08fd564fb1e6195849e560b335996b5b97.1793207602.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: sLqKRn8VP6ou_bZnIE_g7rxyuO-gyyFiFFmfVZinuls_1793207742
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

From: Junjie Cao <junjie.cao@intel.com>

Event records, scan media results and event interrupt settings are
device-internal dynamic state that should not survive a device reset.

Per CXL r4.0 Section 8.2.10.9.4.6 (Get Scan Media Results), "If the
Scan Media command has not been called since the last Conventional
Reset, the device shall return the Unsupported return code."  This
explicitly invalidates scan media results across reset, so clear the
scan_media_hasrun flag.

Per CXL r4.0 Section 8.2.10.2.5 (Set Event Interrupt Policy), "All
event log interrupt settings shall be reset to 00b (No Interrupts) by
the device on Conventional Reset."  Clear irq_enabled for every event
log accordingly.

For the event records there is no direct spec mandate to drop the
stored records on reset; the Event Status register (Table 8-203) is
non-sticky and resets to zero per Section 9.7, and no reset flavor
requires the already-reported records to persist.  Draining the queues
is therefore a reasonable modelling choice that keeps the records
consistent with the freshly-reset status register, rather than a spec
requirement.  Call the existing cxl_discard_all_event_records() helper
to drain all event queues.  The event log infrastructure itself
(mutexes, IRQ vectors) remains intact as it is initialized once during
device realize.

This is also where reset-type gating begins: a wakeup from suspend-to-RAM
(RESET_TYPE_WAKEUP) is not a Conventional or CXL Reset and must retain
device-internal state, so the hold phase returns early for that type
before discarding any records.  This mirrors the RESET_TYPE_WAKEUP
shortcut in virtio-mem and virtio-balloon.  Only the unconditional
mailbox interface re-initialization and the in-flight sanitize free
(whose backing timer was already destroyed) run on a wakeup.

Signed-off-by: Junjie Cao <junjie.cao@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260729144645.1552511-7-junjie.cao@intel.com>
---
 hw/mem/cxl_type3.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 04558a114f..26c3773dc0 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1360,6 +1360,23 @@ static void ct3d_reset_hold(Object *obj, ResetType type)
     }
     cxl_initialize_t3_ld_cci(&ct3d->ld0_cci, DEVICE(ct3d), DEVICE(ct3d),
                              512); /* Max payload made up */
+
+    /*
+     * A wakeup from suspend-to-RAM is not a Conventional or CXL Reset.  The
+     * device-internal dynamic state cleared below (event logs, scan media
+     * results, and the poison/feature-transfer state cleared in subsequent
+     * patches) must be preserved across resume, so stop here for a wakeup.
+     * virtio-mem and virtio-balloon take the same RESET_TYPE_WAKEUP shortcut.
+     */
+    if (type == RESET_TYPE_WAKEUP) {
+        return;
+    }
+
+    cxl_discard_all_event_records(&ct3d->cxl_dstate);
+    for (int i = 0; i < CXL_EVENT_TYPE_MAX; i++) {
+        ct3d->cxl_dstate.event_logs[i].irq_enabled = false;
+    }
+    ct3d->scan_media_hasrun = false;
 }
 
 static const Property ct3_props[] = {
-- 
MST

