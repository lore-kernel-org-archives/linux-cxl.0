Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22418388895
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jul 2026 04:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784782284; cv=none; b=bfhiy8OkM6WEj9Wf8ky2u7AY6UjYaOoPCSLtqIuvX4qpl4XrMpO+R0j1mPXmBj4YLuxZIKoXEag0hkJ/l3xIommhuovqXhVVxQVVdXR2ASft0Z1z1szAS290sOp3KIu6TbO11KdQv6w74Dx0w83ItLzEKBs1W6JDYPRwP5p26GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784782284; c=relaxed/simple;
	bh=HblQql1yvVn6VeamW0ZrJWHaA8vpkIM6QQPUOan9Kao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=AlowSZ9gj1wL/YdyLr7iYs/02AbX3guh2TMspa02IoCgSxbaAoZ2HPpcrG9izlwDASKxezWC0HV0Ta0LXFxPvoKhd8JII2XnCRKK62HGJVG8UY1zG1P0aw0sOaCroe8y3rGiAwVvhfcmmRnHATstdSjk6PjuYlEjAy2rlbxIXIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fJ10cK6U; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fJ10cK6U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784782265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9YoGAoaYe1zPbiR9886orVUbPO3VRJkQv0eqUa1lksA=;
	b=fJ10cK6UEHV2F8aeNaOmda1233tMEhVyDseUokpsUR8dMD8akwJlSaFZ1HYrpCPoH7ZCSx
	huN6uEhYCtu1lU48KwzR6xiMMSR79aNzLX64cK0KG2GnrEy2pS0yKgu6QR5tbdPYAuTIfl
	+wD9ASF47DAZ9WCzuWvLfHuOcSUACAQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-270-4z4sKMMpPoyuzGxko269Sw-1; Thu,
 23 Jul 2026 00:51:01 -0400
X-MC-Unique: 4z4sKMMpPoyuzGxko269Sw-1
X-Mimecast-MFC-AGG-ID: 4z4sKMMpPoyuzGxko269Sw_1784782259
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E5A9F1954B26;
	Thu, 23 Jul 2026 04:50:58 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.44])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D053618002B5;
	Thu, 23 Jul 2026 04:50:47 +0000 (UTC)
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
Subject: [PATCH v2 16/44] qapi: convert trivial intro sections for acpi.json
Date: Thu, 23 Jul 2026 00:47:37 -0400
Message-ID: <20260723044805.527643-17-jsnow@redhat.com>
In-Reply-To: <20260723044805.527643-1-jsnow@redhat.com>
References: <20260723044805.527643-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: 3_HV1eb_92MZv4KvvzzysAsvWQUWj9W1ymKYgWyJ85M_1784782259
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

(Trivial)

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/acpi.json | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/qapi/acpi.json b/qapi/acpi.json
index 906b3687a55..291a04a7ea4 100644
--- a/qapi/acpi.json
+++ b/qapi/acpi.json
@@ -81,10 +81,9 @@
 
 ##
 # @ACPIOSTInfo:
-#
-# OSPM Status Indication for a device.  For description of possible
-# values of @source and @status fields see "_OST (OSPM Status
-# Indication)" chapter of ACPI5.0 spec.
+#     OSPM Status Indication for a device.  For description
+#     of possible values of @source and @status fields see "_OST (OSPM
+#     Status Indication)" chapter of ACPI5.0 spec.
 #
 # @device: device ID associated with slot
 #
@@ -107,9 +106,8 @@
 
 ##
 # @query-acpi-ospm-status:
-#
-# Return a list of `ACPIOSTInfo` for devices that support status
-# reporting via ACPI _OST method.
+#     Return a list of `ACPIOSTInfo` for devices
+#     that support status reporting via ACPI _OST method.
 #
 # Since: 2.1
 #
@@ -126,8 +124,7 @@
 
 ##
 # @ACPI_DEVICE_OST:
-#
-# Emitted when guest executes ACPI _OST method.
+#     Emitted when guest executes ACPI _OST method.
 #
 # @info: OSPM Status Indication
 #
-- 
2.55.0

