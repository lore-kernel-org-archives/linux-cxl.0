Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9D715E5DC
	for <linux-cxl@vger.kernel.org>; Sun, 26 Jul 2026 20:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785098727; cv=none; b=IBgk206ghGYV+J5kqTWAvQNCJQsQSYKcj3vEPDobdnM8XmGjWIJ55ETLtLee3LzPAGY/FMx8fztqQN3G/96q9aK5a3/P+SvW/MvrVLmB2nrc1cilzwuVC9D+uIxGuqiWAb1bk0l+pMJbjSvP2HYnRSy9N5wucUZiIdyEYaS0qV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785098727; c=relaxed/simple;
	bh=sIBVNLsGCOna3Hd2Wy4wJ32pRVDvMFiol07f6gVUCMU=;
	h=From:Date:Subject:MIME-Version:Message-Id:References:In-Reply-To:
	 To:Cc:Content-Type; b=vA1vgE/4jG2DaNG3FohU0aPaY4KF0WFx38at1fxe/wU124SksjL9CrGfBFTC+NFcnnaw42sLHkCmVV9xbQMnvyrbSYw4eH9WPgrem/1a4Dvr8Aqz6yFg6163ZtNfBeGypzG9b8FzF1u5gpHj81eamUdAYk89psUUo6566TK2be4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aZFHpBTZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aZFHpBTZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785098725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+TTlcmViaW/jr0GgH0ehJXptanXZXliFPnYWOw9ddzY=;
	b=aZFHpBTZgq50zpH5AKfpj5Jm1PaWEs5zovfkTt44vEozHCzzsSCAmNZFhWFdpX+h9QemUP
	iWsb3G6gT9o/klLfGonHtFGBht4gfxNi43q0HI+pw1PQcMgs/1tRF5yan5dezuKO3AlgQx
	VxQKAZ5QGNawzMnSsOZPTLbyCjAte2c=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-4FWo0WPTPb6Hu_l50vZDeA-1; Sun,
 26 Jul 2026 16:45:21 -0400
X-MC-Unique: 4FWo0WPTPb6Hu_l50vZDeA-1
X-Mimecast-MFC-AGG-ID: 4FWo0WPTPb6Hu_l50vZDeA_1785098719
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AA331195607B;
	Sun, 26 Jul 2026 20:45:19 +0000 (UTC)
Received: from localhost (unknown [10.44.24.5])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A9A3630001BE;
	Sun, 26 Jul 2026 20:45:17 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Jul 2026 00:44:09 +0400
Subject: [PATCH v2 10/12] hw/core/machine: free machine->fdt in
 machine_finalize()
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <20260727-fix2-v2-10-d0c4831ed7ea@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=816;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=sIBVNLsGCOna3Hd2Wy4wJ32pRVDvMFiol07f6gVUCMU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqZnGXv6fr/VusynUuJj+7991gNH6KtKVK0aAzQ
 YHC1MBl1J2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCamZxlwAKCRDa6OEJdZac
 5Z5QD/4wWnnfTAOKE1y1toBi/3+xqSlAbzCU1yNo25LhIFeg6ovEG7WRWFtpS1JS40df1o4yInL
 u7AWArOtmKtK4+t8eahOiXoYNo/xoE1P9MGX1pPIv8knrfCrNS2WLr/4mTy+gZVdWJDYkKMNxPc
 0wpRzr/a8VT9Mkmb03NFoPR8sNFYq0KpQmd26ItLvA39hBxcpzZjM02PRtg3tUH4EsQnoiv971g
 u+438RwibEet6RdZXNsaYn0/kzo3D1a6tKguF8mrk9q4zaP54UblrAbgl2jhtBYSunT+IFKlCDj
 fe3aRKKtNYYKXQEQ26YaoYAJVaupRiRUUNqqcdI4t/fvg/nFfwDsIrQcndIXyafN6DFn++DPnJC
 hBZILSGXx2rZoYC77dlYghbp53qgYPGzYB8O1R/OHhVUs5MJM2dA4wgoGwlDrrrTCPLzFMZI0fv
 Yjt/vtrDAjj0Q4NNVnWDnC/OOTcG4dRqBf07sXJS0EFFXN/kWUKVFIfDm4AavoxS+mTs4J91pUH
 yjQTnw5zTcpdVOldmjZm8Wzcujc2xZyovTdxEuhGkMlH/S3zvWcUSxE6kJLCZNYOjeTpSR+Uc9J
 hYDXC/aSs6wA/G9M7O8pc/ahqo98Y/BhIT7FozEnQ73laditARDQoPio9M2pSW1Q6SsjdtucKKD
 yUIrMAEUkf0q+UQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: DLhw79K8IiZlBkYeuRYyAiNu3Hv_E0r5Gq31DoV7EN0_1785098719
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

machine->fdt is a plain g_malloc0() buffer (see create_device_tree())
that boards populate during MachineClass::init, but machine_finalize()
never freed it, unlike the other boot-time buffers (dtb, dumpdtb,
kernel_filename, ...). Free it for consistency.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/core/machine.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 805148678d57..2b24d711d76f 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1301,6 +1301,7 @@ static void machine_finalize(Object *obj)
     g_free(ms->kernel_cmdline);
     g_free(ms->dtb);
     g_free(ms->dumpdtb);
+    g_free(ms->fdt);
     g_free(ms->dt_compatible);
     g_free(ms->firmware);
     g_free(ms->device_memory);

-- 
2.55.0

