Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1469B20E023
	for <linux-cxl@vger.kernel.org>; Sun, 26 Jul 2026 20:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785098699; cv=none; b=M7ih0udR7knjYxpFF+zg5YqvtTzQg4m1juzofaCkZAcDPX/hSiTnzdrd0q52GTqrx53rdVHkPdvSMZN/Ql9mn8dL639Vcw4K4EtHsYFVdtGagttJtyiLGabjXOQuENUGbU8KD6DviN9qwOcCz48yqaoksSdhaP/pGIyro/Kgt/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785098699; c=relaxed/simple;
	bh=BvH11bAGqVafjw/9JvRuhekLdJbHoBFg9BIf/wU6vRM=;
	h=From:Date:Subject:MIME-Version:Message-Id:References:In-Reply-To:
	 To:Cc:Content-Type; b=rwahtuIWPAmWJn36Ks6fDTJOwlyNQN9Wvye3jDay66v5UpDgIi04uzzvmjbn4cnOezgAHYC2bmEOysyO2+6mJVXTfuRjOURfZz9osCfCJCT0LxYAFWbiYDS77nHU7OZv+GKDV6bl3VlywzOoErDclBevhtm5I4blgLrTqS47Reo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wh7de3EE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wh7de3EE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785098697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E/POaYwIz7h1//1YrnKweU5fHiZe4sgfVD5NET1i974=;
	b=Wh7de3EERW3FuFple8rpmu/KfK1H/AEE+a81XO7T7wySEDxtwwfKbGniYayNHUUGDGpQs6
	KEnIQF7YENLIcixRp8BCBJyMLfeq/peS+HMLVBxFPBOFOoddNLsR8HMRXcK4kUN0MnDr5/
	7KGZUkKZbjh3Dda9YJgocg4M4rmG1NM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-458-BjhnSJ1GPq6lxd1wDejhgQ-1; Sun,
 26 Jul 2026 16:44:53 -0400
X-MC-Unique: BjhnSJ1GPq6lxd1wDejhgQ-1
X-Mimecast-MFC-AGG-ID: BjhnSJ1GPq6lxd1wDejhgQ_1785098691
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 99C671800590;
	Sun, 26 Jul 2026 20:44:50 +0000 (UTC)
Received: from localhost (unknown [10.44.24.5])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0495318001E0;
	Sun, 26 Jul 2026 20:44:48 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Jul 2026 00:44:04 +0400
Subject: [PATCH v2 05/12] hw/cxl: fix invalid free on early return
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <20260727-fix2-v2-5-d0c4831ed7ea@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=778;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=BvH11bAGqVafjw/9JvRuhekLdJbHoBFg9BIf/wU6vRM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqZnGXHbn11IZQ/CDpUaKI05AbxWrb9OZgBYekD
 XuyRkyAFmWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCamZxlwAKCRDa6OEJdZac
 5TYkEAC0/2zRf5blPzTCAoJEW0pHJuoT9U8kH4ZlWJmNB3kkCelOXhj4bOA+ruA/vDQ84R1H6DB
 naJaP6PBqRfjYiDIzb11fNEqGIvqeo3GpQZfgDwn0UYjrBmQxNLzPst8NURBymGu75UmKEiYIWz
 l89a4uaSsUqPRlXyOmzjxDUL2c6OqMSJkCVx9WaDVRqhIlMaW8MkdUCsW8ezdLScTWNSJnQw0yJ
 7SpNkb9o/iTFiV0Txec3oqoxoSaQD2foMqM8V8a4AQMyUNA6ug0i3v4L8sgfDadt1pO6GR/2eA+
 yL5uzreMw/jotkO8M11vR/GlsvmYa0Uj7knOrCBTs37cy+axWflxBK3/k0V2RdpywlfMwHz9O9K
 w9jwOiaYELCwHcWmfZObOWAt9m31trcUeJ8iskULfPBrMKef2sR1a/bUcfhBTnuLjWTHaJQq84h
 946xKgjQ0zPiEE+dywIZQAukm83YoIekyQDTjZNLmV7SNfurUs778wu9H/x8nnLYO8DVgBa1COu
 3+6PYOWkNEvxzy6I1XvrRzjsKbYYlxKeNZ+VJ08v5Nc79pjtYsFi+jDIEb8e6rlb86AblPrin4E
 K4Wk2O5MzpHmPZtOC2/RwmnpXwIKWrDqtfib+1taDAHhnY0C1+1yZn+eK0qSJQZgVvRHqKjvDrg
 AQ5C84uCth0eyJQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: HMOKRyCk0QSwCHHuU-XpOFZowQiXp52HRCkowp3DZPk_1785098691
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Fixes: 680935c9a6ff ("hw/cxl: Add a performant (and correct) path for the non interleaved cases")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/cxl/cxl-host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index 7e744312f1d8..eba13c9e7cba 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -279,7 +279,7 @@ static void cxl_fmws_direct_passthrough_setup(CXLDirectPTState *state,
     MemoryRegion *mr = NULL;
     uint64_t vmr_size = 0, pmr_size = 0, offset = 0;
     MemoryRegion *direct_mr;
-    g_autofree char *direct_mr_name;
+    g_autofree char *direct_mr_name = NULL;
     unsigned int idx = state->hdm_decoder_idx;
 
     if (ct3d->hostvmem) {

-- 
2.55.0

