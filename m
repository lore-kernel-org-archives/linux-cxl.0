Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D105E3932D5
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jul 2026 04:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784782387; cv=none; b=hHlBNVtQNR+Cx0RMlD/ngz7LaQEVMpLCR5ebJXToPAHUHaQjs54sa2fFbwocHkuQG+R/ZZUPSXyvfSZYGfwSZtEtROAuUuHoTFK4+N2b+sP5yj2jnh8dN36+M1Q2bVS2SuE+4mTxNGPtB5gfpya+vBG56Ds52Hiljq252Axtjys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784782387; c=relaxed/simple;
	bh=ISdsTBKyh5/yfZIF+B4NVAQpEYcluqerKm79YKQ6QIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=AHqePWla+9MfEqMkyf2/BKH0MUv8abwtwUJe5BsPtEu4tn6NzZMadKD3wjDBze6yq8q+gOzRqJsdkozxZaEILcgRKM22OPMRu+XlCIzXjTwHyiX5C27PNC/HjDbAfOQ/4jlmpeXu1c3wQvVMmOXmK/+Otkz5YMYAWJArsNrc4fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pj0fNBP3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pj0fNBP3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784782373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=94ztoHJSekPaBu9gQO06nFEY6BVwCOp3ZmuxtD8vWVs=;
	b=Pj0fNBP3DLCHBT6azf5EDSVKr1Hfo4iD3AQSi7bHvsQOQV1tP46bRO5ia8bgk9dSq/dPGa
	noqRBQiZnCzPmZ9CPyFj84wutVfFRw1FpAN7l6IA7Vl0a1uduUyyYE174e3WAr5JG0n3jj
	XeEWZY9NSqNQ7Q0GcyFL0BbtrX1R+eM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-28-eyNaZrN6Oli8Es0NTKYNFQ-1; Thu,
 23 Jul 2026 00:52:50 -0400
X-MC-Unique: eyNaZrN6Oli8Es0NTKYNFQ-1
X-Mimecast-MFC-AGG-ID: eyNaZrN6Oli8Es0NTKYNFQ_1784782367
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3D7A21977517;
	Thu, 23 Jul 2026 04:52:47 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.44])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 528D3180029D;
	Thu, 23 Jul 2026 04:52:39 +0000 (UTC)
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
Subject: [PATCH v2 27/44] qapi: convert trivial intro sections for introspect.json
Date: Thu, 23 Jul 2026 00:47:48 -0400
Message-ID: <20260723044805.527643-28-jsnow@redhat.com>
In-Reply-To: <20260723044805.527643-1-jsnow@redhat.com>
References: <20260723044805.527643-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: m7OVrZdLiPHPYgVLqLJgLV-gFD5cTwd-jTRfC4YzaZI_1784782367
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

(Trivial)

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/introspect.json | 45 ++++++++++++++++----------------------------
 1 file changed, 16 insertions(+), 29 deletions(-)

diff --git a/qapi/introspect.json b/qapi/introspect.json
index c8432c8ed8e..bd42aac3358 100644
--- a/qapi/introspect.json
+++ b/qapi/introspect.json
@@ -55,9 +55,8 @@
 
 ##
 # @SchemaMetaType:
-#
-# This is a `SchemaInfo`'s meta type, i.e. the kind of entity it
-# describes.
+#     This is a `SchemaInfo`'s meta type, i.e. the kind of entity it
+#     describes.
 #
 # @builtin: a predefined type such as 'int' or 'bool'.
 #
@@ -112,8 +111,7 @@
 
 ##
 # @SchemaInfoBuiltin:
-#
-# Additional `SchemaInfo` members for meta-type 'builtin'.
+#     Additional `SchemaInfo` members for meta-type 'builtin'.
 #
 # @json-type: the JSON type used for this type on the wire.
 #
@@ -124,10 +122,9 @@
 
 ##
 # @JSONType:
-#
-# The four primitive and two structured types according to RFC 8259
-# section 1, plus 'int' (split off 'number'), plus the obvious top
-# type 'value'.
+#     The four primitive and two structured types according to RFC
+#     8259 section 1, plus 'int' (split off 'number'), plus the
+#     obvious top type 'value'.
 #
 # @string: JSON string
 #
@@ -153,8 +150,7 @@
 
 ##
 # @SchemaInfoEnum:
-#
-# Additional `SchemaInfo` members for meta-type 'enum'.
+#     Additional `SchemaInfo` members for meta-type 'enum'.
 #
 # @members: the enum type's members, in no particular order.
 #     (since 6.2)
@@ -178,8 +174,7 @@
 
 ##
 # @SchemaInfoEnumMember:
-#
-# An object member.
+#     An object member.
 #
 # @name: the member's name, as defined in the QAPI schema.
 #
@@ -193,8 +188,7 @@
 
 ##
 # @SchemaInfoArray:
-#
-# Additional `SchemaInfo` members for meta-type 'array'.
+#     Additional `SchemaInfo` members for meta-type 'array'.
 #
 # @element-type: the array type's element type.
 #
@@ -207,8 +201,7 @@
 
 ##
 # @SchemaInfoObject:
-#
-# Additional `SchemaInfo` members for meta-type 'object'.
+#     Additional `SchemaInfo` members for meta-type 'object'.
 #
 # @members: the object type's (non-variant) members, in no particular
 #     order.
@@ -232,8 +225,7 @@
 
 ##
 # @SchemaInfoObjectMember:
-#
-# An object member.
+#     An object member.
 #
 # @name: the member's name, as defined in the QAPI schema.
 #
@@ -257,8 +249,7 @@
 
 ##
 # @SchemaInfoObjectVariant:
-#
-# The variant members for a value of the type tag.
+#     The variant members for a value of the type tag.
 #
 # @case: a value of the type tag.
 #
@@ -272,8 +263,7 @@
 
 ##
 # @SchemaInfoAlternate:
-#
-# Additional `SchemaInfo` members for meta-type 'alternate'.
+#     Additional `SchemaInfo` members for meta-type 'alternate'.
 #
 # @members: the alternate type's members, in no particular order.  The
 #     members' wire encoding is distinct, see
@@ -288,8 +278,7 @@
 
 ##
 # @SchemaInfoAlternateMember:
-#
-# An alternate member.
+#     An alternate member.
 #
 # @type: the name of the member's type.
 #
@@ -300,8 +289,7 @@
 
 ##
 # @SchemaInfoCommand:
-#
-# Additional `SchemaInfo` members for meta-type 'command'.
+#     Additional `SchemaInfo` members for meta-type 'command'.
 #
 # @arg-type: the name of the object type that provides the command's
 #     parameters.
@@ -322,8 +310,7 @@
 
 ##
 # @SchemaInfoEvent:
-#
-# Additional `SchemaInfo` members for meta-type 'event'.
+#     Additional `SchemaInfo` members for meta-type 'event'.
 #
 # @arg-type: the name of the object type that provides the event's
 #     parameters.
-- 
2.55.0

