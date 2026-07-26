Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8AA20E023
	for <linux-cxl@vger.kernel.org>; Sun, 26 Jul 2026 20:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785098681; cv=none; b=nBsGdHDY2/HW5YBhtYwxPb2fv5MplDSMYMWww0j3juwhE+wv9DxdMmyDK/9IRkIlCmsuUpScVfqaIyH7xFc+RIa4DVW/TSDice+SuajXYgeXdoRQp03pqHQdfs26OLrBRlYQcpIBEJJw5ZhiNcVUxS7Sy/JVqir3kmTYCDPAJy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785098681; c=relaxed/simple;
	bh=KUwdh4qWkjrixCjRkFzF1AESBuEqtaV7DKeiZd1uFaU=;
	h=From:Date:Subject:MIME-Version:Message-Id:References:In-Reply-To:
	 To:Cc:Content-Type; b=DNZUfzlUvybF8s8eLamRWsHZ5AMiXc/5Uv2m0YARbz/UZdE7RxS4dZ5jgAQ2IvNNUkUGDcsgVFpdd1yjTP0PLt6AFq22n+WtYtRshlWsyGZCfZKGbIqu6iFeLXrZnefFBz3vX8McoHDrUM+k4i4fgoONNtwxOiV4pxahuBuZyJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TUP1SKsh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TUP1SKsh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785098678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZD9c+t7MILB/tiCBpv52ymj4SpFNv8fK+VqJytjmOdk=;
	b=TUP1SKsh0UhC0eSbtaCNYqH8Czjuxyt2XgHvl1pQtk0pnPvfZF9dSLNA3ljK2liOZEyeQv
	VJuZJTuLcn478RvfmuRRDrhKxkOTzC9J8HBGg+OeNTUg2HPrArjmEjsqvFw63iWiip44Xo
	7Q3opCLa5I510ejr6mDIJimCpypck30=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-225-Ugweij-7MW6f7RU7UILbNA-1; Sun,
 26 Jul 2026 16:44:35 -0400
X-MC-Unique: Ugweij-7MW6f7RU7UILbNA-1
X-Mimecast-MFC-AGG-ID: Ugweij-7MW6f7RU7UILbNA_1785098673
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 13F5B1956053;
	Sun, 26 Jul 2026 20:44:33 +0000 (UTC)
Received: from localhost (unknown [10.44.24.5])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7A33C18001E0;
	Sun, 26 Jul 2026 20:44:29 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Jul 2026 00:44:01 +0400
Subject: [PATCH v2 02/12] block/blkio: fix error return value on
 getlength()
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <20260727-fix2-v2-2-d0c4831ed7ea@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=656;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=KUwdh4qWkjrixCjRkFzF1AESBuEqtaV7DKeiZd1uFaU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqZnGX7YpxQWXaaGmDfwVLM1l+jDrPKhzdn7f+i
 DybceyvvueJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCamZxlwAKCRDa6OEJdZac
 5fDJD/0X6NzR1k+kircKGc+Criog16ENyjwtcAo4cq+m7UNuaNHJ2+o2YmFdO41zEn/eS8MKVZJ
 c69+HhlSLjM7hU5EdcklCJoSl4v5TwZGVQeAJuGBsH/ezGTi07YKlmRh8iFUHWInZrX7PuoxFbU
 1cxFkqz1NwvmWmwlnp37t5RfjsDHbHgHFFBGXuQOLXjsA1RehMVWEyshVyONXeIp/69YJEd1O/M
 NsfNuHYGeDNBlPY49uHCSyDt2o8OtnU5ex+v8VL3W8u64X++RLmSqstlGL46ZdTlXGPZiKRF43+
 FRehK14fBGDW2MeV6hMfrMFCOT9eKOl1bYyu6Gt5SII5FWc1nOcXhNTRli1EfSK5VKdmFxobUEw
 e6kx+IU5h09/onPe2bQIu1zhWtJOfdC1tuFl5pq0mrZJPCBf1eC6wRuM1aXgGetF1pGWvl1MlPZ
 skrYenapjTYwjyqhKZbDn9PLc7yXht64XwfVhLq7JDINu67BhYEjFFs4Wbsj7FlOgs1qPwHcXBF
 QdIDpGtCJz1LXBWMFhnm3fUaQc6pNqXXkq4WasvfI9srvIKx4U5ygjkDPke0PNg6B7ZDYhcFDTx
 8XZ3rGr27+wBSNYlVKsNKfAaxy8Pftk0Qdx//GfhkcXpSYomBCWOl/OUE4omtLNfrghWB26AWgv
 JusPeLjgfzl8qiw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: vB7SC7UIcUlo3eSXx2ItnS-XOP5lcxY_zVIbgnfYWq4_1785098673
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Negative values should be returned for errors.

Fixes: fd66dbd424 ("blkio: add libblkio block driver")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 block/blkio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blkio.c b/block/blkio.c
index fb8bec27d71a..52a8be220d1c 100644
--- a/block/blkio.c
+++ b/block/blkio.c
@@ -941,7 +941,7 @@ static int64_t coroutine_fn blkio_co_getlength(BlockDriverState *bs)
         ret = blkio_get_uint64(s->blkio, "capacity", &capacity);
     }
     if (ret < 0) {
-        return -ret;
+        return ret;
     }
 
     return capacity;

-- 
2.55.0

