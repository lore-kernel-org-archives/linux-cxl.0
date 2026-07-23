Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB4123D7F4
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jul 2026 04:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784782289; cv=none; b=lp3WIU2Z81z9vb7HlwgSLqVxFt9Gzlw0DnIJYJgYE+JOXgWzMyAMs0N3nxjyVX6qa73W8RvpplN0oZFjWA5Zs6NGCD32/EFQRWi5vUlxXpbBqeuExTcerGekMXo7aIZS0yup4G4N5YDe39DtwpWtg3S9LkpwqNJHVvmujZfYJBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784782289; c=relaxed/simple;
	bh=ZjIdTTmOaltM+a7tID0CEbV+bz1zXDJVKnSDUU45k7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=I/Qfe2lB4aWdNxKHpjyJ7OkBSyNjKdXyb5fcqbOl4l+1R2KYhVNzxmOuTzzooESMbFssyNcW58KzX3lb5kDoFz+7YgCFTX12KczzfPtkgrpEt4+zbRSi3oB/kfcPnuYILKXCh5hNIJu3eRqMphjBou6cWoPdsIRZQ8k0qiumapg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fzIwRFAy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fzIwRFAy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784782276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BLReHKiKZLrcMhTJHEtDrbs61uxUo1HyBJxoZBg4t+Q=;
	b=fzIwRFAyiNY+Jt39wzDig532s9GRZOGqA6yQQZ9z7lMSQnI8qWsKu78ECbCJSRMtQr9I+O
	nIbZvKN0Q/EGQGhbFeoigCP84AARDAS/AgFHqV0xr7QFpLTWTGdSOAeLLgWa6SP2V95jPm
	dUeiIqGhAxqa0fZJXMRUuVd4yUfMHQU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-BZq-vpapOaiUMw0l_FqGng-1; Thu,
 23 Jul 2026 00:51:11 -0400
X-MC-Unique: BZq-vpapOaiUMw0l_FqGng-1
X-Mimecast-MFC-AGG-ID: BZq-vpapOaiUMw0l_FqGng_1784782269
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DD7811944F05;
	Thu, 23 Jul 2026 04:51:08 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.44])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 679A6180029D;
	Thu, 23 Jul 2026 04:50:59 +0000 (UTC)
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
Subject: [PATCH v2 17/44] qapi: convert intro sections for tpm.json
Date: Thu, 23 Jul 2026 00:47:38 -0400
Message-ID: <20260723044805.527643-18-jsnow@redhat.com>
In-Reply-To: <20260723044805.527643-1-jsnow@redhat.com>
References: <20260723044805.527643-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: 0wwJNNAVnJJKKURAEJR9JxPbCxAjfO218Cb9ZbRs3Mk_1784782269
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

(Trivial)

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

