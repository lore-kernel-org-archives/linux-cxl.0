Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7AE46AA60
	for <linux-cxl@vger.kernel.org>; Fri, 11 Sep 2026 09:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789117296; cv=none; b=h8N10VR5FC8h/ZMnXYucrIX9IVbKHmbVEQfWdh5fpfh0BYDWSVlLh6bPWChr51aNXwKnEZHap9WfiRWcMWbJfhdQOifV1pDddEtfy2gSJ1dqgfkecHbLEgJWCBb5sEMAKzCToWLNrQc94GzuLePdWvdU+lA3MwTuaD+xloWja10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789117296; c=relaxed/simple;
	bh=3QrjgQJivG5s9QsEN9Y6Vh5AjfLJSo/U5juzrXa6X2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=nVYJUwJ6001kzRGdEEjmFY9KJc9Ed6NW8dDlLFN+EwWOmT0rqIb6AMvhpTHsIWhtniuMZnu7J/Ka/ephpil/ZpqUgoTnYrfSfPfUh8dggLzyOYrk6Eu0eJqsxS2bUIA+TJbGg5QRQ/Ksp75w+LG3rhCdTdLEdWxGEhGjFaXWn6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fahyY/lv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fahyY/lv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789117293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=duT8sfy/1vmAKnbU6GKLoZk3/IV53fEkN7T7OylyeSg=;
	b=fahyY/lvZ8FptJTsZw7hnl8pslfmZmY+iDk6FQPFRHXaXJ22EJYshEnU5+7aR6409turam
	M3R168HyuRDWWDdSK6XXYvhpO28uO+yZBtZZ1JQ+ye0v4geLwII3crRnBLUI7Hvy3CkCtx
	iG2QGutk4ak1dwDWEFxnAReY1s5W38g=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-n1Ce9XvnN2OetytTSl3Elg-1; Fri, 11 Sep 2026 05:01:29 -0400
X-MC-Unique: n1Ce9XvnN2OetytTSl3Elg-1
X-Mimecast-MFC-AGG-ID: n1Ce9XvnN2OetytTSl3Elg_1789117288
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49d0ae342b9so5172525e9.1
        for <linux-cxl@vger.kernel.org>; Fri, 11 Sep 2026 02:01:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789117288; x=1789722088;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=duT8sfy/1vmAKnbU6GKLoZk3/IV53fEkN7T7OylyeSg=;
        b=ITBjvATHFYKp27MGvJk7iREX+WCzcCwcEgYs1mcW3nQIfAQ0jQnOczycmKt2ReAVwB
         2T3ng2+bfjcjfT6m4QqaJta3v7F4LSOpk69Tzsf6r6ojioDQlIWWcT40Yz4nXFdXx6B5
         BU+WMrFniMiOV8Y0HL4/SSiT3hAbxsmaDRk3fOq+Q3TanUroYTZXqxZPEnTLfJlDmEvX
         u9uRCGe/kMTOwMLIqY5fIk6MjtXP7gSHAKSyWvGSyZ0yGy3NsADM3dx99+6X/6Gc320f
         axBL4ogIT9qy+bEowptmD3qToMaVXfCnehCqzn0S1o7CP9dvc0fKD9vLFfLC/+L6FwmD
         DJ5Q==
X-Forwarded-Encrypted: i=1; AKwUvBwwSrg+tg7+5MPhW0ehz++F6IL8049kan+A5eo9kv6+80IwQmOflU7T60nV4a/1btNt09qgwVQGbtw=@vger.kernel.org
X-Gm-Message-State: AFuF++kjgh1MOusCC/pOSkr9n8FGQ/aow3mJ0rtjJ84PjrC8hj8Zsl9D
	sXNn09XjVork0D03ptFyikgQjfPRjkG4W5NTJvK3eyK/3J1SQmKK3kr6ZXR2hpTonLyxE8iH1jC
	P5jibOlr6bCMp1F0npmuIJMKbFG6Qq36PRYssOdHd1hIZiZkGlBDJpOwqlj/ngA==
X-Gm-Gg: AYBFou2l5PmX0dy/YI2L5tf7m8AyjK6q4KfTAf/V3UbbaATgUsInM3UaZpMPgjTVk1J
	dHpvIYTvcWOZY8AXtaJl24XdlQsXYHEv/llFCu7VpP52heyivQX/RLrWRBIAD4HC4gdpW9YFo4Q
	jA4YYW6XL4ajwThNV4kDR3sNY923cNfFHzCLIAKhpzI8qSzmWhuG8z1TKn1sYosqjBtSkqU2MMI
	tZZSotb3yUJF1lnd5/wslb97Lgb5Pa5j7N41lmKRm3PJ+8hpnoCEOH2W/RPPH+tN1yLJG7HxlrQ
	weugCWgdJJdg7WCyh0BPYTMg43wZN8dhH3PgIgzINnShdK7ZrNQNC5CqTmEAAouGsi2qKmYDekt
	dhCYgngttmAB6jZpeKyDQ+oE=
X-Received: by 2002:a05:600d:8490:20b0:49d:e0c:e560 with SMTP id 5b1f17b1804b1-49e61983771mr26335495e9.4.1789117287997;
        Fri, 11 Sep 2026 02:01:27 -0700 (PDT)
X-Received: by 2002:a05:600d:8490:20b0:49d:e0c:e560 with SMTP id 5b1f17b1804b1-49e61983771mr26334855e9.4.1789117287535;
        Fri, 11 Sep 2026 02:01:27 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e6576122bsm36196675e9.2.2026.09.11.02.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 02:01:27 -0700 (PDT)
Date: Fri, 11 Sep 2026 05:01:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Junjie Cao <junjie.cao@intel.com>, qemu-stable@nongnu.org,
	Jonathan Cameron <jic23@kernel.org>, linux-cxl@vger.kernel.org
Subject: [PULL v2 04/75] hw/cxl: Fix guest-triggerable QEMU exit on reserved
 interleave ways
Message-ID: <713e7e85a2b43e9d4e58d91643aef230d2c30b07.1789117222.git.mst@redhat.com>
References: <cover.1789117222.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1789117222.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ND8cKX88Ja8FS2uckkAzb4rRsyGJOCqntZ1SoIvjTbw_1789117288
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

From: Junjie Cao <junjie.cao@intel.com>

A buggy or malicious guest can program a committed HDM decoder with a
reserved Interleave Ways encoding (e.g. 0x5-0x7, 0xb-0xf).  Two call
sites pass &error_fatal to cxl_interleave_ways_dec(), which calls
exit(1) on the reserved encoding before the subsequent decoded_iw == 0
guards can run:

  - cxl-host.c update_non_interleaved(): called at commit time from
    hdm_decoder_commit() via cfmws_update_non_interleaved(), so a guest
    writing COMMIT with a reserved IW terminates QEMU immediately.  This
    is the primary trigger on the current tree.

  - cxl_type3.c cxl_type3_dpa(): called on memory access while iterating
    past committed decoders to accumulate dpa_base.  Once the commit-time
    exit is removed, the decoder stays committed with the reserved
    encoding, so a later guest access outside that decoder's range would
    otherwise hit this second &error_fatal; both are fixed here.

Pass NULL instead of &error_fatal at both sites so that the reserved
encoding returns zero and the existing guards handle it gracefully.

This can be reproduced by writing the HDM Decoder 0 Control register
with a reserved IW encoding and the COMMIT bit set (e.g. IW=0x5,
COMMIT=1).

Cc: qemu-stable@nongnu.org
Fixes: 680935c9a6ff ("hw/cxl: Add a performant (and correct) path for the non interleaved cases")
Fixes: 48461825af1b ("hw/mem/cxl_type3: Fix potential divide by zero reported by coverity")
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260618104316.557306-1-junjie.cao@intel.com>
---
 hw/cxl/cxl-host.c  | 2 +-
 hw/mem/cxl_type3.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index eba13c9e7c..369a985f9b 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -442,7 +442,7 @@ static int update_non_interleaved(Object *obj, void *opaque)
             }
         }
 
-        interleave_ways_dec = cxl_interleave_ways_dec(iw, &error_fatal);
+        interleave_ways_dec = cxl_interleave_ways_dec(iw, NULL);
         if (interleave_ways_dec == 0) {
             return 0;
         }
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 28f41fa623..6f44770db6 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1200,7 +1200,7 @@ static bool cxl_type3_dpa(CXLType3Dev *ct3d, hwaddr host_addr, uint64_t *dpa)
         }
         if (((uint64_t)host_addr < decoder_base) ||
             (hpa_offset >= decoder_size)) {
-            int decoded_iw = cxl_interleave_ways_dec(iw, &error_fatal);
+            int decoded_iw = cxl_interleave_ways_dec(iw, NULL);
 
             if (decoded_iw == 0) {
                 return false;
-- 
MST

