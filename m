Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA92496D47
	for <linux-cxl@vger.kernel.org>; Thu, 10 Sep 2026 20:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789071100; cv=none; b=dzrmYF0L9QfwFXVHOQGyK0O3RiVrRGaSQJVIc1dXrMbaAUhl7sYUOIjqzLG2ZBmtLMNyJ6TdUbnIvVAylulr5L1YuOP9ySUEacEYVkINpozvx7aQaIGMvss0F5dMy3dip32tx1HyvzEEMS5WUMciLFeJnyJ358tMXIlF/uChduY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789071100; c=relaxed/simple;
	bh=3QrjgQJivG5s9QsEN9Y6Vh5AjfLJSo/U5juzrXa6X2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=BqGa+hYZmK5saCAn+0xGckdhkugyDeDagOFkZkWNyKYdY0wGa4pW+QDdFAicD770nl4yr9dWPGSqCpT6vAw6HhWwEMXlDcxzF/4+3CDmGyWtvbdW7P0rn3xZUIL9g4/EQBLyO9Yk3/KuwmeDSk7wt0q24uyeqdgILtak0qyXWuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CQ3GukWG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CQ3GukWG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789071096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=duT8sfy/1vmAKnbU6GKLoZk3/IV53fEkN7T7OylyeSg=;
	b=CQ3GukWGn7mlYOSvum7WSAD1gFlPyHBKCldirr5EHocFDMFzarcfLIQT/ui3SknZ51TAy2
	UEANWbAuPFmIMpNky7XH2qJsmMmOEareByBnscsiqpgsmMaFHcXTv3xea3wtE9WSkzbiBV
	CXcGHtm9JKC6ABeBIqsU8F/F7N/nUpw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-_9qziqEJPAa_i22YxUA_RQ-1; Thu, 10 Sep 2026 16:11:35 -0400
X-MC-Unique: _9qziqEJPAa_i22YxUA_RQ-1
X-Mimecast-MFC-AGG-ID: _9qziqEJPAa_i22YxUA_RQ_1789071094
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-486e830c6fdso75981f8f.3
        for <linux-cxl@vger.kernel.org>; Thu, 10 Sep 2026 13:11:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789071094; x=1789675894;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=duT8sfy/1vmAKnbU6GKLoZk3/IV53fEkN7T7OylyeSg=;
        b=n77TCTseOPB/U/yGHpOXlnp1px4o4PjSn7QGfHIDbYePKYjz9pVXs0wdKPs1FRU2sL
         mlEQYxTYNpUW+gQ+zYYKzCDjIOkHgDGkXa5ok7AJUBECwxbjGm0D6F40IoZZc5PwCZsa
         7QlvGC7O7iTbCIyho0nuT3MLsb6YDSV2Wp71Nsa+yg5YUTsXCDmgi/zgI+3UBx+VzXwg
         RzA8etS88u4eSyLyOazKhcKdPFuAEB5aIlGH0xZokhRh1Wxf77qIBCFdfMKSsvH85Or8
         G+c1xxYEIoqFAz+C1j7+lz8a6can6jxL1PIPEiKLDo+and+Xo3npdRKHNC9LXYqxEhve
         XolA==
X-Forwarded-Encrypted: i=1; AKwUvBzLL4UDc1MWXeNNzd/JwJuCFLIGWm2/P6TdcMeiY3PfCgCSL6Poagiul2TKzkHadV1QGKO/xdK9NGI=@vger.kernel.org
X-Gm-Message-State: AFuF++lf6OL2gm6vpPls4T/ulLXQKSpnknDAD3qpMuECOSqtKvGaKSZf
	0G6B4KZygMNZIFTmIOTrFZ+BWc8iso5CjYoXVOvNoKa/yrPjrXZYm7OjA2jqKoolxqtsaM3N5pD
	NGgZeKvpwgpcYHXnhKbaWVdS1mDBt2wKblETCPiPW0Ak5uREk7nsuXOYvq2K2Ew==
X-Gm-Gg: AYBFou1mkq9e5BZwSasIupqsSzsAXq69oNXyzXZJuNxq9ukv4slMIchO9E5XVpJv8Ds
	D9hE3SooWYKz85S+jmAhf7RP5cm/0y0U51NGS9jfkeEJl2qHweKNA0NV4WgDpD90Do+BBU+T8Ur
	X6cI6JG6Y/nsQV0xtfWDkDLSDjv8GxvZkfG7T6P3wlwzccdkrIYVsi4tIn8Wz3uZnn9gU8Fauq6
	g9bBn3TwjHd1NnltHClP+tdtuclbyBRtt4fJw/EmDi93IAz1yYWja+ed8490s1nY4V6qPi/3Yft
	pw0tJ7kbmv59vr5hOdBG9H5Jw93dw3O1yOm/yKzyd6xE79w50rux1mnx94mwJvhn4WlsDOCbwrM
	+xkLvao50Ot/LBl6v7hf9wyA=
X-Received: by 2002:a05:6000:4541:b0:47f:9254:d453 with SMTP id ffacd0b85a97d-486eb2db733mr1044064f8f.8.1789071093704;
        Thu, 10 Sep 2026 13:11:33 -0700 (PDT)
X-Received: by 2002:a05:6000:4541:b0:47f:9254:d453 with SMTP id ffacd0b85a97d-486eb2db733mr1044003f8f.8.1789071093177;
        Thu, 10 Sep 2026 13:11:33 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb32e7f5sm839873f8f.9.2026.09.10.13.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 13:11:32 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:11:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Junjie Cao <junjie.cao@intel.com>, qemu-stable@nongnu.org,
	Jonathan Cameron <jic23@kernel.org>, linux-cxl@vger.kernel.org
Subject: [PULL 04/90] hw/cxl: Fix guest-triggerable QEMU exit on reserved
 interleave ways
Message-ID: <713e7e85a2b43e9d4e58d91643aef230d2c30b07.1789071042.git.mst@redhat.com>
References: <cover.1789071042.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1789071042.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9g9DWM-_-y2mxdsv_3JoPYnRPiKSSpLO5VEclclR4Bc_1789071094
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

