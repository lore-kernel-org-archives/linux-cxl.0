Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F30D37F33B
	for <linux-cxl@vger.kernel.org>; Wed, 26 Aug 2026 19:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787773381; cv=none; b=VFFFmDa060fhOrfVdHA4Bu6HLeRbrpYEjTOLK47gIX2aT2rLVmUclcHOWaq0ZH9ndJtkA6CdkxFwMm1nXUp00PBh2L9wSeABaTttYiFEgmcqcfua6nVdD9B7zTa/rTSwaNnNzkECwpzVGaL/k7BYahwCg0F1EuSdL/51N5WUIbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787773381; c=relaxed/simple;
	bh=2SeE1xs8joRyT3nDEMnnKIoLQEGaEj0QND1QI5FYm6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=OF9QIaiI/2grX2GyMfSTbbUrGdqyYFJqLsYWpzMeR4A3S30vcL6kypthd9mS7bOXxDUfEMjR5IH8/+SSx2frXNjbGzaSIAt2H3VerskBp8etaoYCoC9nLRlzB1HhLcZUMyfwuMqTj5PI1tEIxk8grRHm9WTzW6o8rpNBs0luUsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U7ylw3W7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U7ylw3W7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787773367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RQLl9Fz/e90VKbZH8iPZEXrmE8EWsrDRt4hVfZ8Hrwo=;
	b=U7ylw3W7H/3cvwlCcXr5cDWmEviQds/s41zq6zxRrvhW4cwIDV0EJBGXsrrU5gUBQY8/of
	4W9wbLADVlV3yjemnIDlJwyvN8bVkDecAelogK7QwOrfX0zdieUtM4uVeNZ2cznge2BscB
	/0tG8+vsRgyOFy7mIesj0YXiqLVnkV4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-xjXzKdKiNsqqhXlL2uTMtw-1; Wed,
 26 Aug 2026 15:42:43 -0400
X-MC-Unique: xjXzKdKiNsqqhXlL2uTMtw-1
X-Mimecast-MFC-AGG-ID: xjXzKdKiNsqqhXlL2uTMtw_1787773360
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C4F5D19541B5;
	Wed, 26 Aug 2026 19:42:40 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.99])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CCBE31800577;
	Wed, 26 Aug 2026 19:42:32 +0000 (UTC)
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
Subject: [PATCH v3 26/43] qapi: convert trivial intro sections for introspect.json
Date: Wed, 26 Aug 2026 15:38:23 -0400
Message-ID: <20260826193840.2152000-27-jsnow@redhat.com>
In-Reply-To: <20260826193840.2152000-1-jsnow@redhat.com>
References: <20260826193840.2152000-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: 8sEn4Xwp-qy0drm5E-wF8iOIFqZoQPb1gPcLjVTWSv8_1787773360
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/introspect.json | 40 ++++++++++++++--------------------------
 1 file changed, 14 insertions(+), 26 deletions(-)

diff --git a/qapi/introspect.json b/qapi/introspect.json
index c8432c8ed8e..172ed389997 100644
--- a/qapi/introspect.json
+++ b/qapi/introspect.json
@@ -112,8 +112,7 @@
 
 ##
 # @SchemaInfoBuiltin:
-#
-# Additional `SchemaInfo` members for meta-type 'builtin'.
+#     Additional `SchemaInfo` members for meta-type 'builtin'.
 #
 # @json-type: the JSON type used for this type on the wire.
 #
@@ -124,10 +123,9 @@
 
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
@@ -153,8 +151,7 @@
 
 ##
 # @SchemaInfoEnum:
-#
-# Additional `SchemaInfo` members for meta-type 'enum'.
+#     Additional `SchemaInfo` members for meta-type 'enum'.
 #
 # @members: the enum type's members, in no particular order.
 #     (since 6.2)
@@ -178,8 +175,7 @@
 
 ##
 # @SchemaInfoEnumMember:
-#
-# An object member.
+#     An object member.
 #
 # @name: the member's name, as defined in the QAPI schema.
 #
@@ -193,8 +189,7 @@
 
 ##
 # @SchemaInfoArray:
-#
-# Additional `SchemaInfo` members for meta-type 'array'.
+#     Additional `SchemaInfo` members for meta-type 'array'.
 #
 # @element-type: the array type's element type.
 #
@@ -207,8 +202,7 @@
 
 ##
 # @SchemaInfoObject:
-#
-# Additional `SchemaInfo` members for meta-type 'object'.
+#     Additional `SchemaInfo` members for meta-type 'object'.
 #
 # @members: the object type's (non-variant) members, in no particular
 #     order.
@@ -232,8 +226,7 @@
 
 ##
 # @SchemaInfoObjectMember:
-#
-# An object member.
+#     An object member.
 #
 # @name: the member's name, as defined in the QAPI schema.
 #
@@ -257,8 +250,7 @@
 
 ##
 # @SchemaInfoObjectVariant:
-#
-# The variant members for a value of the type tag.
+#     The variant members for a value of the type tag.
 #
 # @case: a value of the type tag.
 #
@@ -272,8 +264,7 @@
 
 ##
 # @SchemaInfoAlternate:
-#
-# Additional `SchemaInfo` members for meta-type 'alternate'.
+#     Additional `SchemaInfo` members for meta-type 'alternate'.
 #
 # @members: the alternate type's members, in no particular order.  The
 #     members' wire encoding is distinct, see
@@ -288,8 +279,7 @@
 
 ##
 # @SchemaInfoAlternateMember:
-#
-# An alternate member.
+#     An alternate member.
 #
 # @type: the name of the member's type.
 #
@@ -300,8 +290,7 @@
 
 ##
 # @SchemaInfoCommand:
-#
-# Additional `SchemaInfo` members for meta-type 'command'.
+#     Additional `SchemaInfo` members for meta-type 'command'.
 #
 # @arg-type: the name of the object type that provides the command's
 #     parameters.
@@ -322,8 +311,7 @@
 
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

