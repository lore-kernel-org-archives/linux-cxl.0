Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA1F2EB859
	for <linux-cxl@vger.kernel.org>; Sat, 25 Jul 2026 14:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784988036; cv=none; b=XRpQjjw+aPLQyhuqEO2fllDpgO4wBzbc9cweQ6k8u9EzZ0WWfl+5SsVTYfb3fxdV3zPFHloCV4ikho+OQsdL8jFG7a+0OTAjfmBa/P3AWpo5P0U+TiXgrvmfxKOmjfN/wOBHEZfIgL30unuJuZ1IB48tn0sWdVIMlMw+c3t/NPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784988036; c=relaxed/simple;
	bh=mk7xOY7MrP6hzIZ9/rwfiY5pmK/wzv9sLr3O7waARAo=;
	h=From:Date:Subject:MIME-Version:Message-Id:References:In-Reply-To:
	 To:Cc:Content-Type; b=MX8gKRHsqXbFPrp7XGvcHF4yWmD313PBKoA4IF7Ef1QvtrtWscq198/Qd8qp0m9YLxqCr4kD11EV6kStog3aC8L42HYzqcimhSajhR1zCdgOpy8E0GE+9EsRftIfBYU8mITDohDIx0dYyLGu9upD/lb2n3/sAEBSbaQDPBykb3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L1ZQkqnA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L1ZQkqnA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784988034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZqYGAMQYTE7NgCivyeQuW01dQY8Lzslgx4hiMYj0PE0=;
	b=L1ZQkqnA4lin83+q5n+nhYJYOVMhUu/IbjYvAfKQ4DmTWloPNfKjMT7lD+6qPa6wIJHV6g
	rB/tPcgorgnm4e1eA5n914LB2cHyKEL98A0Dfv72/6tZVkAy/HxMex5a3s0V6ciTIP9LPN
	MzoG0MuQ1cBH6yn5oYFd37kUvj4YU8E=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-155-RXRoJnUNOCi3x4xGMBHJ7A-1; Sat,
 25 Jul 2026 10:00:29 -0400
X-MC-Unique: RXRoJnUNOCi3x4xGMBHJ7A-1
X-Mimecast-MFC-AGG-ID: RXRoJnUNOCi3x4xGMBHJ7A_1784988027
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1EE8A18002A2;
	Sat, 25 Jul 2026 14:00:27 +0000 (UTC)
Received: from localhost (unknown [10.44.22.7])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7A216195422A;
	Sat, 25 Jul 2026 14:00:23 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 25 Jul 2026 18:00:03 +0400
Subject: [PATCH 2/7] block/blkio: fix error return value on getlength()
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <20260725-fix2-v1-2-5c9a6ce7b96a@redhat.com>
References: <20260725-fix2-v1-0-5c9a6ce7b96a@redhat.com>
In-Reply-To: <20260725-fix2-v1-0-5c9a6ce7b96a@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org, 
 Jonathan Cameron <jic23@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 Fam Zheng <fam@euphon.net>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>, 
 Phil Dennis-Jordan <phil@philjordan.eu>, Wei Liu <wei.liu@kernel.org>, 
 linux-cxl@vger.kernel.org, Brian Cain <brian.cain@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1054;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=mk7xOY7MrP6hzIZ9/rwfiY5pmK/wzv9sLr3O7waARAo=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqZMFl3l+pb8+oFbJ8vFGbzbVFnDmVOYYa1trpI
 EI5hHN9bT2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCamTBZQAKCRDa6OEJdZac
 5SF6D/9Fbz48ox7+C5SOvyXLlKChpwF+aIQtuyeE7dl1B+1zJ3hR6HBf9Ur7fotHIwFuzTbybjq
 ePsAqcsWTP4X1PfTTvMRmjU9MeTFmfFO5kPaxF/DpTGZwish/jZgcbg5/MP6BDS7kr2Hs05v21s
 zIT3vgQrzXkeD5pVIG4q/qzDoFm1mwdNMPteUstuo1GnG29/sQMmfAaw9WRPN09tMBi586pUn2R
 AlmX2LczK0mgxjVvh0+5zpx6yOL0uiXqWTZ5+2BY5H44Wx5rRm5Dg6easLcXccix+PyLP1dIbU8
 67BifWKhf4vHoiJbownhFmP0iLpZaos/J8qYwrGn5E38hmxroFTU9v2zbn1BuP5S5ONU/39UDh0
 13CMv7kZk/2KlEeymGvlTbChRorkgxXlrutYqTQRymTzNxBuPKyuL+O4VDR7flCrf2PM02SclYa
 0wwqgJ5iDdT0ov/Jo6ZfucWWJ2Y8FArGg+2wQLPIARKEgC7e8YLsW5IsKYu4O1+w45eBocINcGj
 6rcV0dMVY09KdEJdGVwwFZvL9aX9ucwLUNOj73nZIn28DTBKvt0uLhffLhRFXlDNlP/28HtBdl7
 ZbOYr+oRp7G7QDbxvW9+inZRNEa77v7qhyuYuNpB1x5+NfMOfeEaUMdo3ZD3nvy4oa85ATckw+m
 8gSLleNfUYrVPCA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: lDy1QkA7cPJNMOVFy71qr2fYTFohE4svoBUTQR1h_94_1784988027
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Negative values should be return for errors.

It also helps with GCC false-positives:
../block/blkio.c: In function ‘blkio_co_getlength’:
../block/blkio.c:943:8: error: ‘ret’ may be used uninitialized [-Werror=maybe-uninitialized]
  943 |     if (ret < 0) {
      |        ^

Fixes: fd66dbd424 ("blkio: add libblkio block driver")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 block/blkio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blkio.c b/block/blkio.c
index fb8bec27d71a..d2ba2a4d58dc 100644
--- a/block/blkio.c
+++ b/block/blkio.c
@@ -935,13 +935,13 @@ static int64_t coroutine_fn blkio_co_getlength(BlockDriverState *bs)
 {
     BDRVBlkioState *s = bs->opaque;
     uint64_t capacity;
-    int ret;
+    int ret = -1;
 
     WITH_QEMU_LOCK_GUARD(&s->blkio_lock) {
         ret = blkio_get_uint64(s->blkio, "capacity", &capacity);
     }
     if (ret < 0) {
-        return -ret;
+        return ret;
     }
 
     return capacity;

-- 
2.55.0

