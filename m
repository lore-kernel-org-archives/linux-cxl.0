Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31700377ED9
	for <linux-cxl@vger.kernel.org>; Sun, 26 Jul 2026 20:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785098689; cv=none; b=pWLsPwGG4+ZDpVSLWIE/DKy61ug3sb9cCrwk6bL6HFiIknThPvNERsXpucc81TsIPYpHUboYDhaOXucRuSE3C943xmKtf/axqbzHgnHGUSwQfEWJIz7cbL1eQZFGsloGx6L3pSlOZIopfwx9jsjxQS+H9L4JmxfknEah3Gisrqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785098689; c=relaxed/simple;
	bh=FrHzIsDpkWChX+K7JOQIlcwNZG9jTUeVV/tUOTaHIVo=;
	h=From:Date:Subject:MIME-Version:Message-Id:References:In-Reply-To:
	 To:Cc:Content-Type; b=bXPlCmPLlW4DhhkvWp19G6bseyE8+Mm1q6Tf/EEsxdGu5R5QtS1vSXQG3+W0BorjEk93Hp3Vn/Kd+kTNcHDxumOnVesMKFwVqEIfRB+4OPvCkUNaNjUnpW1bAXCRGNTb+bpNEqbJccefMA686d7WQkv8pRA+Cf6VEJeXO+rpoPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YXQhJsE1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YXQhJsE1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785098687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3BDR4lCetSgPYsi2iCxOJ+ghjRU3eO1cdueUfdeq7eM=;
	b=YXQhJsE1jbg0FlkEJB7w3vmnq3owP7zrkXfMVPUlNyVRzq+LaMbEur51gAbITlyDOj20hf
	1U0F9Vlndn5mB/hc0wKPpQ/CxFF0xSQdfV8v50XYtH7ELTafpE2dHiHEd8UdY4JjCd+FfK
	Hbq64+xPygiWb1U754Z0x6SBZqp3was=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-272-JWdTkM33PvexWva_5tj5CA-1; Sun,
 26 Jul 2026 16:44:42 -0400
X-MC-Unique: JWdTkM33PvexWva_5tj5CA-1
X-Mimecast-MFC-AGG-ID: JWdTkM33PvexWva_5tj5CA_1785098680
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B4C2F1956071;
	Sun, 26 Jul 2026 20:44:39 +0000 (UTC)
Received: from localhost (unknown [10.44.24.5])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 509E142C;
	Sun, 26 Jul 2026 20:44:36 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Jul 2026 00:44:02 +0400
Subject: [PATCH v2 03/12] block/blkio: fix compiler false-positive warning
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <20260727-fix2-v2-3-d0c4831ed7ea@redhat.com>
References: <20260727-fix2-v2-0-d0c4831ed7ea@redhat.com>
In-Reply-To: <20260727-fix2-v2-0-d0c4831ed7ea@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1098;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=FrHzIsDpkWChX+K7JOQIlcwNZG9jTUeVV/tUOTaHIVo=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqZnGXxYBcWQtZJhWSeAtprOzrLPhE7ldi+fXY8
 bstbq2PYW2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCamZxlwAKCRDa6OEJdZac
 5VzmD/wJ+Uf764IPoo1uhCLJ7gOmtO25e/GAV+QqhufUlYTMiECisWjhidpfOa7aokUrKKXr1Up
 WzQsXFw+8kJdgrbUVqHrSzKDoUgEpTFdosi6kLaSbbcG6dVd6EBh3p3MUOX54O33sZm0edSGnO2
 fEXAVXRFfjAD//rpc74YP0JscqafPDjhFFyxm4/ASjChpZBuksPo38e/f91fIZVHqd0Vog6qNIs
 kg3LD3HjXOqBqNM6BbmiJezvp0Kx3n3S5zp+i52WCjy3QSxv8Wqp9AsVRqPzoa5bkQ5MSMDR4Et
 kqQAH6qc33bkRK/AuzOBJHAmNrTRhRsUQegYKB8yR69pxEgCL8qbOWud2bdCJq+P1MhVK0Wj3aB
 aFiMPe3u0lBqXa5GMLZIXhw0b3hwPO/5t03104aD/G7H+ZTRSS5H+iOWay8jk/EOPr4gwpNYQj9
 p0Cm7X2792+1rdVlgHs0IhpFRpVPi3zt7zHhek2Td0zxf7CTQB413Sm/Md9brIx/B2qrdEJpW5R
 COQ3F9kj341+pZ5q1DBnyto91kQPFq4wNT8bL8rndWBo6+hdtqJycurWc7v7LlOXpBWgP7/FKsh
 YCBdiubkWaGfLEWbcF/dsp8x7fr+PF6L3l6jwv75Y8L7gRh/HFJSKZ6u9b099kpBVR/hvgSIG/N
 dXNcRGr1QTjhD4w==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: mpsE2tcDYpsta2zE9EspG0Wt6e3DRO6yKISK4J8y0hQ_1785098680
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Under some optimization, gcc produces a false-positive:
    ../block/blkio.c: In function ‘blkio_co_getlength’:
    ../block/blkio.c:943:8: error: ‘ret’ may be used uninitialized [-Werror=maybe-uninitialized]
      943 |     if (ret < 0) {
          |        ^

Replace WITH_QEMU_LOCK_GUARD with the simpler QEMU_LOCK_GUARD.

Suggested-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 block/blkio.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/block/blkio.c b/block/blkio.c
index 52a8be220d1c..4801339f98b2 100644
--- a/block/blkio.c
+++ b/block/blkio.c
@@ -937,9 +937,8 @@ static int64_t coroutine_fn blkio_co_getlength(BlockDriverState *bs)
     uint64_t capacity;
     int ret;
 
-    WITH_QEMU_LOCK_GUARD(&s->blkio_lock) {
-        ret = blkio_get_uint64(s->blkio, "capacity", &capacity);
-    }
+    QEMU_LOCK_GUARD(&s->blkio_lock);
+    ret = blkio_get_uint64(s->blkio, "capacity", &capacity);
     if (ret < 0) {
         return ret;
     }

-- 
2.55.0

