Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0DB3515D9
	for <linux-cxl@vger.kernel.org>; Wed, 26 Aug 2026 19:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787773233; cv=none; b=GMBKEscVmGtnCkLsaCsN2KXM5G05inzIY1TWjMNBHFI0AcDvnHH9KkaxN0Aru6J6UknXLQ7DZAWeLTsSEqnCSikKBl1pBQE1Lb8Pa47lPbsEX6Q5dMDksjky3NIjd4ucCpbBawdQJsyyjSeNTuv5M5x6feVVg/zPF7HRDYXGBK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787773233; c=relaxed/simple;
	bh=K+3mbVdH8oSa9Hwbjy5sYNWefrITF+2y/K8zXITd66Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=sIPRXATabUiA9fxqncoL2o4JBMjE6iXDONqZ/xtczSM4Cup2O+2x4NrShDiZrMZos0ZqCjjjMA6J50kJTZg/KapiF5zfAx9YT+3cL3dq6gV0SDuGbyiM1hvYzKlJLir0qyXSqsjwM13IQv84QWjfPZlg2b0Uc1kd4/78piHKQOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fk3TLSxA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fk3TLSxA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787773218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lt8Io7cWByPIErcfVsv8eiRTyjtcP7E9KBqJ4x3KU5A=;
	b=Fk3TLSxA8OA5k3qlFuBHTCYMrAFE+kXR6lS0uepU3jS5lki834ZHsV2l702f9FFX0tNyli
	lu9op2vhwp169KTIFgb9bDBwy75k1u2hTNQPR7lnY+eBkh2RrWXqlLqoUXhHuDBzwk4sB2
	N14XLyjSsTJyscbNOzf2+KjAKRvsFe8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-290-7646R0g6MYaamv_TQErG9w-1; Wed,
 26 Aug 2026 15:40:14 -0400
X-MC-Unique: 7646R0g6MYaamv_TQErG9w-1
X-Mimecast-MFC-AGG-ID: 7646R0g6MYaamv_TQErG9w_1787773210
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0106D184407E;
	Wed, 26 Aug 2026 19:40:10 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.99])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B170D1800577;
	Wed, 26 Aug 2026 19:40:01 +0000 (UTC)
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
Subject: [PATCH v3 08/43] qapi: convert trivial intro sections for cryptodev.json
Date: Wed, 26 Aug 2026 15:38:05 -0400
Message-ID: <20260826193840.2152000-9-jsnow@redhat.com>
In-Reply-To: <20260826193840.2152000-1-jsnow@redhat.com>
References: <20260826193840.2152000-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: sOHE0VdoO0cFrUcoCDBZnKPiheOmi4gSIv8EMaAGNk4_1787773210
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/cryptodev.json | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/qapi/cryptodev.json b/qapi/cryptodev.json
index eb309c22f86..d0c1e6c8944 100644
--- a/qapi/cryptodev.json
+++ b/qapi/cryptodev.json
@@ -12,8 +12,7 @@
 
 ##
 # @QCryptodevBackendAlgoType:
-#
-# The supported algorithm types of a crypto device.
+#     The supported algorithm types of a crypto device.
 #
 # @sym: symmetric encryption
 #
@@ -26,8 +25,7 @@
 
 ##
 # @QCryptodevBackendServiceType:
-#
-# The supported service types of a crypto device.
+#     The supported service types of a crypto device.
 #
 # @cipher: Symmetric Key Cipher service
 #
@@ -46,8 +44,7 @@
 
 ##
 # @QCryptodevBackendType:
-#
-# The crypto device backend type
+#     The crypto device backend type
 #
 # @builtin: the QEMU builtin support
 #
@@ -62,8 +59,7 @@
 
 ##
 # @QCryptodevBackendClient:
-#
-# Information about a queue of crypto device.
+#     Information about a queue of crypto device.
 #
 # @queue: the queue index of the crypto device
 #
@@ -77,8 +73,7 @@
 
 ##
 # @QCryptodevInfo:
-#
-# Information about a crypto device.
+#     Information about a crypto device.
 #
 # @id: the id of the crypto device
 #
@@ -95,8 +90,7 @@
 
 ##
 # @query-cryptodev:
-#
-# Return information about current crypto devices.
+#     Return information about current crypto devices.
 #
 # Since: 8.0
 ##
-- 
2.55.0

