Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABCA381B0A
	for <linux-cxl@vger.kernel.org>; Mon, 31 Aug 2026 20:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788207764; cv=none; b=gMpNgduF0Eess/AV8PBmyyOYJLrt0hlEZkyhOx/74vk0kjwYO6A0Hrb5M0TdGt0CDI4QG65pygkntQYU8kd+8uWmeBzSJc6E4hGMlwD6iN4rybqL4LL951casCJGx22JC0GVwTGTqR20hy0oZZWEIK9soBdB9X3pyoYfJtJwrAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788207764; c=relaxed/simple;
	bh=6dQ5x45qmLdttQA6/aULS4AHNJ5dbSORLZq2SROUO3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=KXmdDH6/KXN7SfdiwfMOXNeYdy1pIh6shHlnKDRdNLmj0xkVOsP9g3ffQoQ/5h871SA4QPLu2Oa7AMV/UE9uuYCQcNXmGI0iWCkIn8rAYYUOiIwDQBuyNAYy1r3+4/VGKRkboHfP13pRYu+ZCxnjvp1MrVLlrNmy1PTXK+l1igo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G+XgIEvG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G+XgIEvG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788207761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YyMOc6fNO8ZdqDV2gIzSN+VkTBXIJrB1icvyY+sOx3Y=;
	b=G+XgIEvGWmEn53FbKBFhM1rOkFcVCdNXxN8n+hBKTQrXOJozR5AdQQr7R1VfIYJpBaaas7
	A7J8QpJq6ODTmlQKj01JFZVlroWTH6eC3XyUcGWAyHF+Sm6WApZB+i/bKIEk9RCOi865nz
	YMxTo+/WN1mygY3zW+IfT4+QKq97V6k=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-494-NqWVYzucPsitsaQxtuwhYw-1; Mon,
 31 Aug 2026 16:22:37 -0400
X-MC-Unique: NqWVYzucPsitsaQxtuwhYw-1
X-Mimecast-MFC-AGG-ID: NqWVYzucPsitsaQxtuwhYw_1788207753
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 064C41863EC8;
	Mon, 31 Aug 2026 20:21:53 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.63])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3461F18009BC;
	Mon, 31 Aug 2026 20:21:42 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	Lukas Straub <lukasstraub2@web.de>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Jonathan Cameron <jic23@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Markus Armbruster <armbru@redhat.com>,
	Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
	Jiri Pirko <jiri@resnulli.us>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
	qemu-block@nongnu.org,
	Ani Sinha <anisinha@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	linux-cxl@vger.kernel.org,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Igor Mammedov <imammedo@redhat.com>,
	Hanna Reitz <hreitz@redhat.com>,
	Alex Williamson <alex@shazbot.org>,
	Stefan Berger <stefanb@linux.vnet.ibm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Laurent Vivier <laurent@vivier.eu>,
	linux-edac@vger.kernel.org,
	Michael Tokarev <mjt@tls.msk.ru>,
	John Snow <jsnow@redhat.com>,
	Fabiano Rosas <farosas@suse.de>,
	Zhao Liu <zhao1.liu@intel.com>,
	"Gonglei (Arei)" <arei.gonglei@huawei.com>,
	Eric Blake <eblake@redhat.com>,
	Peter Xu <peterx@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Kevin Wolf <kwolf@redhat.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	qemu-trivial@nongnu.org,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v4 11/43] qapi: convert trivial intro sections for authz.json
Date: Mon, 31 Aug 2026 16:19:13 -0400
Message-ID: <20260831201945.287730-12-jsnow@redhat.com>
In-Reply-To: <20260831201945.287730-1-jsnow@redhat.com>
References: <20260831201945.287730-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: 97YpoPABsbfPhrHgSbLHmGCdf5KFhLsgrLmwCuWGlyA_1788207753
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/authz.json | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/qapi/authz.json b/qapi/authz.json
index bc1123cc053..b76c39c53af 100644
--- a/qapi/authz.json
+++ b/qapi/authz.json
@@ -9,8 +9,7 @@
 
 ##
 # @QAuthZListPolicy:
-#
-# The authorization policy result
+#     The authorization policy result
 #
 # @deny: deny access
 #
@@ -24,8 +23,7 @@
 
 ##
 # @QAuthZListFormat:
-#
-# The authorization policy match format
+#     The authorization policy match format
 #
 # @exact: an exact string match
 #
@@ -39,8 +37,7 @@
 
 ##
 # @QAuthZListRule:
-#
-# A single authorization rule.
+#     A single authorization rule.
 #
 # @match: a string or glob to match against a user identity
 #
@@ -57,8 +54,7 @@
 
 ##
 # @AuthZListProperties:
-#
-# Properties for authz-list objects.
+#     Properties for authz-list objects.
 #
 # @policy: Default policy to apply when no rule matches (default:
 #     deny)
@@ -73,8 +69,7 @@
 
 ##
 # @AuthZListFileProperties:
-#
-# Properties for authz-listfile objects.
+#     Properties for authz-listfile objects.
 #
 # @filename: File name to load the configuration from.  The file must
 #     contain valid JSON for `AuthZListProperties`.
@@ -93,8 +88,7 @@
 
 ##
 # @AuthZPAMProperties:
-#
-# Properties for authz-pam objects.
+#     Properties for authz-pam objects.
 #
 # @service: PAM service name to use for authorization
 #
@@ -105,8 +99,7 @@
 
 ##
 # @AuthZSimpleProperties:
-#
-# Properties for authz-simple objects.
+#     Properties for authz-simple objects.
 #
 # @identity: Identifies the allowed user.  Its format depends on the
 #     network service that authorization object is associated with.
-- 
2.55.0

