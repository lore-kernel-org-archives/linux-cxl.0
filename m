Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47D330C150
	for <linux-cxl@vger.kernel.org>; Sun, 26 Jul 2026 20:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785098722; cv=none; b=IcRDpnLfeDgQVFspT/CXS3GLr5nU1OIPv7zf42U0OHUD+qk1apU+6/vO5bUGH7o6S+NdJ9I3IGW13j5fHuZy98BUaYbgrlMa3fAFTjda2Mo+VLlfQinTV3q46arVYb/UNXGocjmS6Z6M8xyVO4kIkHj3JaX6tsNTW8LNz0yELD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785098722; c=relaxed/simple;
	bh=xVw6bhj6Lyb5iaDKjsHTyu75/0clDHHxVE1UNjqqjMw=;
	h=From:Date:Subject:MIME-Version:Message-Id:References:In-Reply-To:
	 To:Cc:Content-Type; b=ZGkMxtv6aIpoqGgYyygtGKN5OlnTJnd5Llh7kLn5SNV4dCiiU4vRxWoy5ZwqXyCMHR9AaBYfJiNIwGXABw7uZH2mMf4zLWG0LxHIbzJwkZC7odG6COnk6ZLp60cQJBrYMDf5KtXNVqvYUAcVdpJCTMM8vC8RG9vAgxGp/00Bs8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z4vZL6Lp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z4vZL6Lp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785098719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s7WPHlfybK9wgT6X16AjorCstp8vZ/94rL5kznfJWio=;
	b=Z4vZL6LpWH+cvkJbgkk30wPqx8zWI5SzDxvpzvlGLeETIZmzWXZOLz2H4vBMd8ji06/S4X
	QTZjwVk3zk7xY1+utLSrFHqGNKdVAbZ1csaT42q5hdI8N6Ok7XUEw9jFqubxIrUWBUmHeX
	uBE3pgcsHQmQs+ussff8/jevHE+v8a4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-sq1FeV81PO6gnCoRPG_YDA-1; Sun,
 26 Jul 2026 16:45:16 -0400
X-MC-Unique: sq1FeV81PO6gnCoRPG_YDA-1
X-Mimecast-MFC-AGG-ID: sq1FeV81PO6gnCoRPG_YDA_1785098714
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A82EB1956068;
	Sun, 26 Jul 2026 20:45:13 +0000 (UTC)
Received: from localhost (unknown [10.44.24.5])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B835A180049F;
	Sun, 26 Jul 2026 20:45:11 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Jul 2026 00:44:08 +0400
Subject: [PATCH v2 09/12] hw/ppc: fix dangling fdt reference
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <20260727-fix2-v2-9-d0c4831ed7ea@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1191;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=xVw6bhj6Lyb5iaDKjsHTyu75/0clDHHxVE1UNjqqjMw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqZnGX2Y+rWTiYiQt1e+yf1EHsB+qZXRe7kZsoO
 SpPByrEy0mJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCamZxlwAKCRDa6OEJdZac
 5RB/EACr+9Kc6bCEszt9T3iHIwv94R/fghtv5Kp9Yh1KBXH0pg2Up9jaSZldWAwW3Uk8hkCs1YZ
 p3J864iaDVaiulOz91BUVcXWc+lf4i5J0CcldHsrMqNVEp5ugXAUnbIkHdFQ3IEYeqiCRzETpzl
 2jbjAIIABmyQyqp+QWG7w7fHnAl+BTWk3/NilkDd1UJFPUGLWtazpVrBkExzRm0Cn6mW3YNh+vY
 O4PEmtY6OxCkVx+c8HLg7y4uHS1daWlcC3QThwKl7ayMkL2D+eO8Kupom7OUAvpxrlTxkTQVPsv
 8vEB0jOXYriXcL7eazHDL0u/F/XU4zsQMevwM8B4/ZaacGIJDScRA4LTRCpH28t1wZF29aW0nIG
 7rKEYuGcTIW1+ZgIefsC5gXWcUeLGPSIzrEPZ+19JCgKKhGLwd2Om27/KLTvic3qoYoD/WeKbXP
 aDUk9jCQZss/2F3WoxR7w/wk4l4QfbjA7NYgiUmceBhWk/T+xGC/DTwq+vUGuEsFlS33wLAK2X6
 y7q8dlu/CWQQCAjafpoBdbVBq6hShuLeR4mISm01dM99TVtmTSHxnX44sWPXFn4QXHukX2+osk4
 qDx3OxmmNzlB/6QsnafaeVhIYJqSRnIIQLsjXe1aINRgwHAYwk0zZLKFntXG0Iii3145tIOcNbg
 /2/VKc7644O4fUw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: 7wPakeOWPnvDOY5rS9uJ0b8MtLf5SuiPe89ufD1sqFE_1785098714
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

machine->fdt is aliasing fdt_blob. We need to make sure it is cleared
or updated when we free fdt_blob.

Fixes: d890f2fa9f1e ("hw/ppc: set machine->fdt in spapr machine")
Reported-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/ppc/spapr.c       | 1 +
 hw/ppc/spapr_hcall.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index b79828b4e90c..2fa4db3d493a 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2137,6 +2137,7 @@ static int spapr_dtb_pre_load(void *opaque)
     g_free(spapr->fdt_blob);
     spapr->fdt_blob = NULL;
     spapr->fdt_size = 0;
+    MACHINE(spapr)->fdt = NULL;
 
     return 0;
 }
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 23bcd788daf6..2ed063279200 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1511,6 +1511,7 @@ static target_ulong h_update_dt(PowerPCCPU *cpu, SpaprMachineState *spapr,
     g_free(spapr->fdt_blob);
     spapr->fdt_size = cb;
     spapr->fdt_blob = fdt;
+    MACHINE(spapr)->fdt = fdt;
     trace_spapr_update_dt(cb);
 
     return H_SUCCESS;

-- 
2.55.0

