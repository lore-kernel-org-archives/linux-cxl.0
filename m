Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793207743;
	b=V4Z4FHeC3uyzf4oWOPBhCu26uTyh4p5/1md3O2WSdc76CaH8auoRtBlL/x4GVEn4vtJj
	 mxER1P0ZFXUwo3+R7H0SR0T435oA2AOXfq14UarQMEnjak9NOdH5FervTIIr27ezmbPeH
	 SZeCZcVQzQvE7VgXP1AZNbVVvdXCxEsftFYc95ooPzbInZiG1EZh53KhApUsU3nGMsJM3
	 QaNiduqJsndzHIrciv2FhtA5oYKBl5CTs4qE9pPXm8JLtULJTqM7RcQh2g0O4gXPmSlj+
	 YFV4nxbgvXXxLMShttzHUAlwS7G20l+Ri4F2Mp7sKdja/mcBQFVz8vsAdWJqCb5n/lA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793207743;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mailer:X-Mutt-Fcc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding;
	bh=hfdjEyoG61tuakbg4/yBZZhWaC5HdS0ABbWHQxKkv70=;
	b=WoT9TdDr90OaAd4q7jiE5tzf0Dar1OF9nEWlMw6VjW+X7raqWJVVZ6maEKKXb+uVcPFo
	 EZ6xokA0l5KZzRDJSi0NXffvgo8D43OWsQB/hzRFNeKXpPEUevWx8haKq4t/Q70CBngV1
	 BtmweEBi6e9DxEqpDMJUeUUp/zPC5sdXvEmkpyZjTjOmwA0CwSS25q51P5hTKRFJWoaju
	 4e/7nrCFgeNPPEN5fMawEQkH0TyNA0o0wlXyJwVGsyIBtKv4zdpuf2vLcAfZV4Bfb0GLO
	 iUBCVCaNE3g4J9q5XPWvuNq4yZfFKwjI9VE/xKMgHnGfw79anJZThA3uwXbA6F5YYrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OuhV02KZ;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FE3606A33A
	for <linux-cxl@vger.kernel.org>; Wed, 28 Oct 2026 17:15:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86FE3606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OuhV02KZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793207741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hfdjEyoG61tuakbg4/yBZZhWaC5HdS0ABbWHQxKkv70=;
	b=OuhV02KZJ8/uq62vS9RhyYAF4EYLkVqkZDQ2gwrQ3Xl8td2cZwadClt2FTd5xiDXosycGh
	JTbw1IW+ufBS6TeKYsCIrPpk4YwmSMRgb+XbCLf7qtBBHnm3hkXUdDd9nNGmvXLP0N+g/+
	C1qH58bVTRGj/Gp4XA4SGHrvYKrZKg0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-UdXpE6PHNBOPGQm0NqIzPQ-1; Wed, 28 Oct 2026 13:15:40 -0400
X-MC-Unique: UdXpE6PHNBOPGQm0NqIzPQ-1
X-Mimecast-MFC-AGG-ID: UdXpE6PHNBOPGQm0NqIzPQ_1793207739
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a70b42bab0so11490695e9.1
        for <linux-cxl@vger.kernel.org>; Wed, 28 Oct 2026 10:15:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793207739; x=1793812539;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=hfdjEyoG61tuakbg4/yBZZhWaC5HdS0ABbWHQxKkv70=;
        b=jRb2HGBmnLcBLc4/ND1m2mVyRgV6L9cvr9tUplW20QlM736tH3R6+gNVxvTgZiHv2U
         KOAx60xfXQYH+mYaKc8/QItM2kYNPfcCpdgF1BlPT+MmQ9PgERmvf/lexSxM4yHlvPzu
         tjSZeWVfY05DBPjqk+Ui00QjIp8atxVJesw8GpxdJvADBYEcuBlRfLu6Te7RGV72t72+
         Ex+NQB4Y7O8cDrd4taCo7h+lKx0Kl6SDaY+yMG44nHXTf4wBL5PKvq0ogXAHoHTVeqRv
         1I1dCklbNPJ9ISNrJ2xZADvEvxPLCmkOm0AyN8jCPUK4wEpOOjQoMxPTCuHDMu5+u5nA
         Z3nQ==
X-Forwarded-Encrypted: i=1; AKwUvBypblZ/anPXB8exMey2o33fWeJ26gXdsQHKKJ7ub3+hV7JB2p4HNezprZ0rRdEQ6jMgajk6qO5mLMM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIl4Pq60kAFxa0eSBm+OMY+QN997LWqbthRbhxNvXm92Z8z0AL4
	KbOKpfnRFhEZ5HhNHdFNbuwwcCGiadOgqLsWssWWxP/XZhXbKZh86dafuAME0/ieYZRTg4WrjVr
	yhBGN9EQbM/ZOgm7Cy84fTZAzskUlXUXLoZLljxNuvCx5P8iSyXRfajDBd+diQA==
X-Gm-Gg: AYBFou207FEhC0FvsaQrI/YDV64FNrNtWiASuHrAFUPiwHT00OwSsFrmA1j95VwwxQu
	f6rEy8AJNRCH8RgiIw9C3IjdzQqk06saFgo0o/RoeFoNnDfsLDOJWb4VJdf3fUdiTTCp+KEtZTm
	w5s7ee3snL7Xflm58egnLHZ0jb8L+WFd9LCJlwlXxABXv9WYmgMLTdiT8kPA0cKVER3jFTK+KfS
	r5pJ4adoLW9IGuw5z1Xp31oQOhv6UXIwoQvSdHk0eD3YlWFoC7KqBlP02Ea1b+zJM0amy2UWMTZ
	UT2jbnuf9rFLmQ7jTH8RlkvKNLzpB1ff22zSIbIKsEnwXten/UkMZBYp02kMz8rw4MElG1I2NOn
	T2FGEDkM7DHz7ywlRPdn5l6mV6iibc1KMcQhnIBlx
X-Received: by 2002:a05:600c:34ce:b0:49f:c5aa:9ef4 with SMTP id 5b1f17b1804b1-4aa871e8bf8mr4457495e9.8.1793207738889;
        Wed, 28 Oct 2026 10:15:38 -0700 (PDT)
X-Received: by 2002:a05:600c:34ce:b0:49f:c5aa:9ef4 with SMTP id 5b1f17b1804b1-4aa871e8bf8mr4456515e9.8.1793207738373;
        Wed, 28 Oct 2026 10:15:38 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a94f5311bdsm72122205e9.5.2026.10.28.10.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 10:15:37 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:15:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Junjie Cao <junjie.cao@intel.com>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Junjie Cao <junjie.cao@linux.dev>, Anisa Su <anisa.su@samsung.com>,
	linux-cxl@vger.kernel.org
Subject: [PULL 37/78] hw/cxl: discard in-flight sanitize state on mailbox
 teardown
Message-ID: <1f5103eb7b2a24e8b5340052ff860ce17dbe59e8.1793207602.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: t9fwHy6EcCmy8cHq_F79KbVjf4QFS6Qr61vlPkTU2vM_1793207739
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

From: Junjie Cao <junjie.cao@intel.com>

Per CXL r4.0 Section 8.2.9.4, "Background commands do not continue to
execute across Conventional Resets."  If a Media Operations sanitize is
in progress when the device is reset, the background timer is cancelled
and freed via cxl_destroy_cci(), but the per-operation state
(media_op_sanitize) is heap-allocated separately and would be leaked.

Free it from cxl_destroy_mailbox_t3(): the timer that advances the
operation lives in the CCI torn down there, so the operation can never
complete once the mailbox is gone; preserving the heap state has no
benefit and would leak it the next time media_op_sanitize is assigned.
Routing the discard through the mailbox teardown also covers device
unrealize, where ct3_exit() previously leaked an in-flight sanitize.

The completion path in __do_sanitize() frees the same state; factor the
free into a cxl_discard_media_op_sanitize() helper used by both places,
so the whole media_op_sanitize lifecycle now stays within
cxl-mailbox-utils.c.

Note that Section 8.2.10.9.5.1 additionally requires a device whose
Sanitize was interrupted by reset to remain in the Media Disabled state
until a successful Sanitize completes.  That latch is not modelled here
(reset re-enables media via memdev_reg_init_common()) and is left for
future work; this patch only addresses the resource leak.

Suggested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260729144645.1552511-6-junjie.cao@intel.com>
---
 hw/cxl/cxl-mailbox-utils.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index bc00fec9f8..cbd6ebf9fe 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -2636,6 +2636,12 @@ static int sanitize_range(CXLType3Dev *ct3d, uint64_t dpa_addr, size_t length,
     return address_space_set(as, dpa_addr, fill_value, length, mem_attrs);
 }
 
+static void cxl_discard_media_op_sanitize(CXLType3Dev *ct3d)
+{
+    g_free(ct3d->media_op_sanitize);
+    ct3d->media_op_sanitize = NULL;
+}
+
 /* Perform the actual device zeroing */
 static void __do_sanitize(CXLType3Dev *ct3d)
 {
@@ -2653,8 +2659,7 @@ static void __do_sanitize(CXLType3Dev *ct3d)
         }
     }
 exit:
-    g_free(ct3d->media_op_sanitize);
-    ct3d->media_op_sanitize = NULL;
+    cxl_discard_media_op_sanitize(ct3d);
     return;
 }
 
@@ -4848,6 +4853,12 @@ void cxl_destroy_mailbox_t3(CXLType3Dev *ct3d)
     if (ct3d->cci.initialized) {
         cxl_destroy_cci(&ct3d->cci);
     }
+    /*
+     * An in-flight Media Operations sanitize is only advanced by this CCI's
+     * background timer; with the CCI gone the operation can never complete,
+     * so its state would otherwise be leaked (CXL r4.0 Section 8.2.9.4).
+     */
+    cxl_discard_media_op_sanitize(ct3d);
 }
 
 static const struct cxl_cmd cxl_cmd_set_t3_ld[256][256] = {
-- 
MST

