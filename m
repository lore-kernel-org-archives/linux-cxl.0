Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C79F33555F
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jul 2026 04:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784782182; cv=none; b=I5FYu/+wo18X9nJl1ymqQhgwziTA7eKKHbIlKfWVNLk2mRHnPzxAoUaxXz/WxlPYIZGzIydyhTDHE+xYWNo9Zwdy8gRLTmQBvn4gJJRX3RNECTHHatsknpblVk86t5OuxsYfqmtE8M27dZ6M7f6jcDe0PvEnlYlJ/CWWRAbBUcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784782182; c=relaxed/simple;
	bh=xqwDPKj0o8A54rR/HF1F96ZYfbp+RTQ9fry6kiwydqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=oCriueRevMruZ2Ep69blfF3pRwXv1OtmFB3r6NLuSZ5uoOKOx1HTUzmthZpiI12QC79j0csSjVafKKnRT0taAdxDqDz3k63XmtIaHQZMtppz+hZdMFTvL38Te2HW+ZrQOyXxW6EG3eRZA2YxvLHxSibFzX2t4YBUUI39xnF5qpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AzidpEwK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AzidpEwK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784782166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9YsSN3/iGxSVcvdhM8+DcbeqiCtrl9C1vt5VQz7+650=;
	b=AzidpEwKxZN+1HvQ+Q17f5Rb8duuNYCj50athLkexYkA62nq4AC/6bHvaq5RElDcD/0KrE
	J9YZtTT/wrmsDdkkls8nJHbdjAEvrhdl5UVI1FwVv+UHDZJ7+hayivEzjH3AD0NjUHvf3x
	r35eHvYWioXwEDxg6Zel1ohEiqxrqgU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-66-UqXSW5nBMtCY2XisYh-prQ-1; Thu,
 23 Jul 2026 00:49:22 -0400
X-MC-Unique: UqXSW5nBMtCY2XisYh-prQ-1
X-Mimecast-MFC-AGG-ID: UqXSW5nBMtCY2XisYh-prQ_1784782159
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AE5EC1800764;
	Thu, 23 Jul 2026 04:49:19 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.44])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1B23D18002AE;
	Thu, 23 Jul 2026 04:49:09 +0000 (UTC)
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
Subject: [PATCH v2 06/44] qapi: convert intro sections for vfio.json
Date: Thu, 23 Jul 2026 00:47:27 -0400
Message-ID: <20260723044805.527643-7-jsnow@redhat.com>
In-Reply-To: <20260723044805.527643-1-jsnow@redhat.com>
References: <20260723044805.527643-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: a8kHF5t6MO804EW4EnQHcDeHR1c_7jWtR4VyyGVroAc_1784782159
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

(Trivial)

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/vfio.json | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/qapi/vfio.json b/qapi/vfio.json
index 17b60468712..47fff8b979d 100644
--- a/qapi/vfio.json
+++ b/qapi/vfio.json
@@ -10,14 +10,13 @@
 
 ##
 # @QapiVfioMigrationState:
-#
-# An enumeration of the VFIO device migration states.  In addition to
-# the regular states, there are prepare states (with 'prepare' suffix)
-# which indicate that the device is just about to transition to the
-# corresponding state.  Note that seeing a prepare state for state X
-# doesn't guarantee that the next state will be X, as the state
-# transition can fail and the device may transition to a different
-# state instead.
+#     An enumeration of the VFIO device migration states.  In addition
+#     to the regular states, there are prepare states (with 'prepare'
+#     suffix) which indicate that the device is just about to
+#     transition to the corresponding state.  Note that seeing a
+#     prepare state for state X doesn't guarantee that the next state
+#     will be X, as the state transition can fail and the device may
+#     transition to a different state instead.
 #
 # @stop: The device is stopped.
 #
@@ -49,8 +48,8 @@
 
 ##
 # @VFIO_MIGRATION:
-#
-# This event is emitted when a VFIO device migration state is changed.
+#     This event is emitted when a VFIO device migration state is
+#     changed.
 #
 # @device-id: The device's id, if it has one.
 #
-- 
2.55.0

