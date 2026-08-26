Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814CB479885
	for <linux-cxl@vger.kernel.org>; Wed, 26 Aug 2026 19:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787773297; cv=none; b=sGicaPH009YZnCbpcxZ2YkK3r9vZQ/4mSuD7OItuqoUj/x2hGuA6YVT88oZEKSgqn4LmvwpFbtyJjfYIGZCelzVw2cOGadb9Qd9n23vPHw8HG1icKUjYfT/w9iRwxsL970MFUSwxAwrbJ1dfWtlBxyJzrS8i9+Ck9EAs6MR34P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787773297; c=relaxed/simple;
	bh=+AXY0uUWwhZG12AN/TOSad7BAkxJwQDpnPD5ZysC1ow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=kfSpbCGfEIR1kxNX2Y7GfLzvLsTYfmpRQX2GOtlxJHMNTVeivEkAD10U2efdiNMR9Pp46pDiYn7UrOzfRI0wWJixbvR3TJJBdjf8syJhyEithomnVLyIzrq7/6aEiOnGlIzteRUVxQDpY4+7upHspIgN6IN2rbv9Ynr1kBmh4WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eOgB/PS4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eOgB/PS4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787773285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=53kJeaXAGXWbWgaUWrPPbMnvvgjeb4ogml1Llx3Dmyw=;
	b=eOgB/PS43znMBextdaC8/nUUd2eALHn45P//SFjaP1YWFvBi/idtpy0ExVjz9/eEkYOxeF
	c8Ir2qNt3CqL8IR6RK73iaR7eAO3goyN6yMk/vKPff8A5656VFjd+cA43QN/gGCTnkMyXG
	2z6m53IH3D+VsH2qmFCrheDXPzEUraQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-156-QxcOtTN2MnO5K11xoKHofQ-1; Wed,
 26 Aug 2026 15:41:21 -0400
X-MC-Unique: QxcOtTN2MnO5K11xoKHofQ-1
X-Mimecast-MFC-AGG-ID: QxcOtTN2MnO5K11xoKHofQ_1787773277
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C1670191FCFE;
	Wed, 26 Aug 2026 19:41:17 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.99])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 00ECB1800577;
	Wed, 26 Aug 2026 19:41:09 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	John Snow <jsnow@redhat.com>,
	linux-cxl@vger.kernel.org,
	Markus Armbruster <armbru@redhat.com>,
	Michael Tokarev <mjt@tls.msk.ru>,
	Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
	Peter Xu <peterx@redhat.com>,
	Eric Blake <eblake@redhat.com>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	qemu-trivial@nongnu.org,
	Fabiano Rosas <farosas@suse.de>,
	Kevin Wolf <kwolf@redhat.com>,
	Laurent Vivier <laurent@vivier.eu>,
	Jiri Pirko <jiri@resnulli.us>,
	qemu-block@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefan Berger <stefanb@linux.vnet.ibm.com>,
	linux-edac@vger.kernel.org,
	"Gonglei (Arei)" <arei.gonglei@huawei.com>,
	Igor Mammedov <imammedo@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Jonathan Cameron <jic23@kernel.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Zhao Liu <zhao1.liu@intel.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Hanna Reitz <hreitz@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Ani Sinha <anisinha@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
	Lukas Straub <lukasstraub2@web.de>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v3 16/43] qapi: convert trivial intro sections for tpm.json
Date: Wed, 26 Aug 2026 15:38:13 -0400
Message-ID: <20260826193840.2152000-17-jsnow@redhat.com>
In-Reply-To: <20260826193840.2152000-1-jsnow@redhat.com>
References: <20260826193840.2152000-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: J-mjZ3_-x_CSoaSCid6lEsoadGnwJH0ejyqfLXmiHrM_1787773277
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/tpm.json | 29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/qapi/tpm.json b/qapi/tpm.json
index 3f2850a5733..6d94be656ae 100644
--- a/qapi/tpm.json
+++ b/qapi/tpm.json
@@ -10,8 +10,7 @@
 
 ##
 # @TpmModel:
-#
-# An enumeration of TPM models
+#     An enumeration of TPM models
 #
 # @tpm-tis: TPM TIS model
 #
@@ -26,8 +25,7 @@
 
 ##
 # @query-tpm-models:
-#
-# Return a list of supported TPM models
+#     Return a list of supported TPM models
 #
 # Since: 1.5
 #
@@ -41,8 +39,7 @@
 
 ##
 # @TpmType:
-#
-# An enumeration of TPM types
+#     An enumeration of TPM types
 #
 # @passthrough: TPM passthrough type
 #
@@ -55,8 +52,7 @@
 
 ##
 # @query-tpm-types:
-#
-# Return a list of supported TPM types
+#     Return a list of supported TPM types
 #
 # Since: 1.5
 #
@@ -70,8 +66,7 @@
 
 ##
 # @TPMPassthroughOptions:
-#
-# Information about the TPM passthrough type
+#     Information about the TPM passthrough type
 #
 # @path: string describing the path used for accessing the TPM device
 #
@@ -87,8 +82,7 @@
 
 ##
 # @TPMEmulatorOptions:
-#
-# Information about the TPM emulator type
+#     Information about the TPM emulator type
 #
 # @chardev: Name of a unix socket chardev
 #
@@ -121,9 +115,8 @@
 
 ##
 # @TpmTypeOptions:
-#
-# A union referencing different TPM backend types' configuration
-# options
+#     A union referencing different TPM backend types' configuration
+#     options
 #
 # @type:
 #     - 'passthrough' The configuration options for the TPM
@@ -142,8 +135,7 @@
 
 ##
 # @TPMInfo:
-#
-# Information about the TPM
+#     Information about the TPM
 #
 # @id: The Id of the TPM
 #
@@ -161,8 +153,7 @@
 
 ##
 # @query-tpm:
-#
-# Return information about the TPM device
+#     Return information about the TPM device
 #
 # Since: 1.5
 #
-- 
2.55.0

