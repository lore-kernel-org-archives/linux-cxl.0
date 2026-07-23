Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0C5257435
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jul 2026 04:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784782152; cv=none; b=m5rBDkRlpf6haGFma56gfjHhVTWTP/pE5JlFlIqoRPvzLHAzFb4r1kJXyT12E9K2Ca2wJwBM+sAhhPmGgfynpjmGDHyeYmOwyswbX0YB8olFnadQt2PkIJS4gZYaAeP9sjA0hqTvGTmzX36btjLH1gWODguRjuLwT29N8Hdf+Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784782152; c=relaxed/simple;
	bh=DlT0603oOx+k3hPD0c15F/LknX5BsjoQ5+rCXZ1zohE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=AV874uNoYBGUIhptdIlcokZTCIs6pT0smlQUFp3VCHDLwMKisl+opl4vHWa9oNEAN/ZsTjmbhV2y6TCk7qJO743fOE7+aVp6cVQjZIeP3lIF0OJnvYefxepAtmSB4OjBtLc60+H0cIaJgMRAzZ/up3BdTztyx6p9/sZZGy/Edz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BVSkbya9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BVSkbya9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784782137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NSEF3Y3+ufb+xLGwy5XyD2M1KREl2XGjKup2Cecdxwg=;
	b=BVSkbya9HmdwPPPiccOcnrbZMH1hsnqyNov8ZcE0Wk3AJPWB0Nj/g0gY4uSENnokLWGKaG
	qW6TIFkPOGbX26UC4xzWnu8PH7RlElBh2iQf7S7DgA813dYFtU1b1UVgIJLt7R+KF66Pti
	eEGMgpg0qt+5u3F/4SwF+1gEw2CMnv0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-235-5koa4SSgPwmIuwVIehVJAA-1; Thu,
 23 Jul 2026 00:48:52 -0400
X-MC-Unique: 5koa4SSgPwmIuwVIehVJAA-1
X-Mimecast-MFC-AGG-ID: 5koa4SSgPwmIuwVIehVJAA_1784782130
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 895981800759;
	Thu, 23 Jul 2026 04:48:49 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.44])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E8BB018002AE;
	Thu, 23 Jul 2026 04:48:39 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Lukas Straub <lukasstraub2@web.de>,
	Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
	Zhao Liu <zhao1.liu@intel.com>,
	Laurent Vivier <laurent@vivier.eu>,
	Markus Armbruster <armbru@redhat.com>,
	"Gonglei (Arei)" <arei.gonglei@huawei.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
	Alex Williamson <alex@shazbot.org>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hanna Reitz <hreitz@redhat.com>,
	Ani Sinha <anisinha@redhat.com>,
	qemu-block@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Peter Xu <peterx@redhat.com>,
	Kevin Wolf <kwolf@redhat.com>,
	linux-cxl@vger.kernel.org,
	Jiri Pirko <jiri@resnulli.us>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Stefan Berger <stefanb@linux.vnet.ibm.com>,
	Fabiano Rosas <farosas@suse.de>,
	John Snow <jsnow@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Michael Tokarev <mjt@tls.msk.ru>,
	Igor Mammedov <imammedo@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-edac@vger.kernel.org,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Eric Blake <eblake@redhat.com>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	qemu-trivial@nongnu.org,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v2 03/44] qapi: convert intro sections for ebpf.json
Date: Thu, 23 Jul 2026 00:47:24 -0400
Message-ID: <20260723044805.527643-4-jsnow@redhat.com>
In-Reply-To: <20260723044805.527643-1-jsnow@redhat.com>
References: <20260723044805.527643-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: 736ZYB0QnxYktN4-AiuT69Wk_LG4gJilVd6MSmiUDdw_1784782130
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

(Trivial)

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/ebpf.json | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/qapi/ebpf.json b/qapi/ebpf.json
index f0257955fa2..1f7a4d5c126 100644
--- a/qapi/ebpf.json
+++ b/qapi/ebpf.json
@@ -20,8 +20,7 @@
 
 ##
 # @EbpfObject:
-#
-# An eBPF ELF object.
+#     An eBPF ELF object.
 #
 # @object: the eBPF object encoded in base64
 #
@@ -33,8 +32,7 @@
 
 ##
 # @EbpfProgramID:
-#
-# The eBPF programs that can be gotten with `request-ebpf`.
+#     The eBPF programs that can be gotten with `request-ebpf`.
 #
 # @rss: Receive side scaling, technology that allows steering traffic
 #     between queues by calculation hash.  Users may set up
@@ -49,10 +47,10 @@
 
 ##
 # @request-ebpf:
-#
-# Retrieve an eBPF object that can be loaded with libbpf.  Management
-# applications (e.g. libvirt) may load it and pass file descriptors to
-# QEMU, so they can run running QEMU without BPF capabilities.
+#     Retrieve an eBPF object that can be loaded with libbpf.
+#     Management applications (e.g. libvirt) may load it and pass file
+#     descriptors to QEMU, so they can run running QEMU without BPF
+#     capabilities.
 #
 # @id: The ID of the program to return.
 #
-- 
2.55.0

