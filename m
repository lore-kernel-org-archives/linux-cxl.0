Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B9437DEA1
	for <linux-cxl@vger.kernel.org>; Sun, 26 Jul 2026 20:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785098705; cv=none; b=pvOeJ+A/V7MwauHKVkA5nZNdaK6hYEE/pBQ3YW+jwdahY0sSuMGogHmMaNs293Yatrx5jgRwI+IH/YLWKFWZxZRCgqT11zvFo3eKf2tl4URI+5GZK/LKssq3n7JH1ajoU6o5NkPRqCueIoa0MoT5JDCVsFhMndxY4fUeR9G3vLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785098705; c=relaxed/simple;
	bh=yLUYCOVVGOOzvkcMBJDU+EkijY7q7UFVkrLi3+nOZyw=;
	h=From:Date:Subject:MIME-Version:Message-Id:References:In-Reply-To:
	 To:Cc:Content-Type; b=GAtwlpBWErQBulsNwiuUhs0SKrlCmP3LcvAbyNHglR7Z2fnA5V1+VWDAylzj1ft7eaYtiU/ffFhUvDENRk15PkgAqM1o6fUPvA7mUtItQmec1iXRqUYfUVYVxB60RILo/kO7RCjoM/jwM+FE1iQXvvc3ZcyylKk8h7jFsKt+YPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M8f113dq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M8f113dq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785098703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u5JdBKnDUC0tRVlexJlfFKHyzLpG60H+XeK97IeZmTM=;
	b=M8f113dqdt370q5164Q2ar30XGHFPkcUuH4x0SYAyrJAa0zysKtDrVuWwMB2RruHU++gmi
	KCM3+eQ20hSkvKQBiL9p4Oe2KmB09JlglaO/5Vp1Gn6ArDShM5B3UPcsiOIqn3BGwPPTyr
	I+4zjw5bhGTQuhFF0Y4tEBS+3YUrWk4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-508-P7Uo06K4NSC0igOr9KJzpw-1; Sun,
 26 Jul 2026 16:44:59 -0400
X-MC-Unique: P7Uo06K4NSC0igOr9KJzpw-1
X-Mimecast-MFC-AGG-ID: P7Uo06K4NSC0igOr9KJzpw_1785098696
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C7E3418005BA;
	Sun, 26 Jul 2026 20:44:56 +0000 (UTC)
Received: from localhost (unknown [10.44.24.5])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 71EA61956047;
	Sun, 26 Jul 2026 20:44:54 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Jul 2026 00:44:05 +0400
Subject: [PATCH v2 06/12] hw/i3c: fix default return value of d2_i3c_send()
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <20260727-fix2-v2-6-d0c4831ed7ea@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=671;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=yLUYCOVVGOOzvkcMBJDU+EkijY7q7UFVkrLi3+nOZyw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqZnGXzCOsJ4UKngjdieqOOoqYb+7p0YsyJGWAa
 zSctAlLU+mJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCamZxlwAKCRDa6OEJdZac
 5U6SD/9ZiIj1kKHx72+YPi6++0gcQKFWDo07L8J/vSGP9PLw1OjpJsYO1+JSP3ZhSDUg+IavGLW
 xB1LZ/VrZVDy8vG9It1Y9GJYpHX95IfJuJAuSgVhvUQJ5qZTxYF9w+rc30pZwrExeUzo8g9oCUX
 EPBuS7iaa9OF+SpEcc33UvW/bprKIKm+ltBVMF0U6Laq5FvJYhljDEnY54cW8U6uTbGb8AGAimy
 YLCp9bPAghEgfLCZY+UXVrydpYKA/mQNOwLMZmNbLtH7rN0+euH0w2+aMxZ20ULGz+9IT1wgqYS
 jBpAf5u0Ymt12hq3wxguch6LiMB/C3RhQ9AbruW6JgkxW5s6FkxB/OJRgJacq75KGdkhY8MLjPN
 3ODGX950kl+zpsoGH3Bd2BK14XzPXtygb2bGrUjO7WgDKZ38Gbo1jSzlQX9NIGesgOCrhBfdg99
 F8wHNbcKJH23L+LvJbMnTmsa7hcSPxz5P0yNNE01B0SLNR2m/pNQ7z2NBJx6eX6HaM3leBnFFFf
 OwVD5nj2ULMMg3lv9qddX7dGgsCsDYPhgoT80OM3nGW+Ts58dgtGD6m1RwSx2RZU1mxD2hDvUAX
 KLogy3MGtIJv/LDpqgcZPMRIDSOFZntq7YNDxgKUWhhm57maFkhKh2QVc6Cq7h19Nol6ttMTCWd
 2GJmNIwb0el05jg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: pgNlqVD_k6ojbJCoMdowbxjUQm_N7_NxPoTdLUZcR94_1785098696
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Fixes: 208772a189f9 ("hw/i3c/dw-i3c: Add data TX and RX")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/i3c/dw-i3c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c
index 6386499dd9fc..7b887fbd60cb 100644
--- a/hw/i3c/dw-i3c.c
+++ b/hw/i3c/dw-i3c.c
@@ -430,7 +430,7 @@ static int dw_i3c_send_start(DWI3C *s, uint8_t addr, bool is_recv, bool is_i2c)
 static int dw_i3c_send(DWI3C *s, const uint8_t *data, uint32_t num_to_send,
                        uint32_t *num_sent, bool is_i2c)
 {
-    int ret;
+    int ret = 0;
     uint32_t i;
 
     *num_sent = 0;

-- 
2.55.0

