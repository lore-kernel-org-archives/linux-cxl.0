Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AA13EB102
	for <linux-cxl@vger.kernel.org>; Thu, 17 Sep 2026 19:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789674392; cv=none; b=HvXtNtPXOUHpFYKelDXRWQthyxC2h4Nw1gwIkBgRv3PgkxYkqlZfw4SV2NMbTKIklzpjsxAARMg1Vr83Fpo89VtKN5rn/QF75arwEMdKXgpdj0YKOJgkoeddFY6cZW+ILPXQKZnNkCZnXoIq5aGLgcxMhexCOsJsv4JlfdbLI7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789674392; c=relaxed/simple;
	bh=FLMpObrNFi9IClkRd1Kc6eOo73FJWnKKrgI2yNAfRZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Z4apvx1Jbr02E4cE4Gs3KQV0YZk3FpSewIMumx9IcnkvLbIUAy+aw/itTJf3GGwfrFIRZ+A+FG04uKaa3tcJNmJ6lDt7mNQ4p2aTjL51eXdijbSq3v4dOQQ37xD7AYyQpErxAs5nZxL1A2lXHEJvKZj1RB5f9O2QY0+hnQIkeCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AN07HHHv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AN07HHHv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789674389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6rV63i5zLz4J/LUzf54w3p9IiUX+skDQOv9c6EGZuIE=;
	b=AN07HHHv93QFDyunJTjojqIj9uPtkp+ZYGfUPR+sZawLqdQW0onatp6kC6dIDwvu7EBFbQ
	Uxcefwc02m4mKBm4mjiIjcTmfvatryv9CCooHBg75y0hRgYPGBaus2oZOYDiOlxaJAq35B
	fAIDMdSpqiTgmhMLB9edaANbwOWDqq8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-280-PdhAthoqOdWjbpDEjjtTlQ-1; Thu,
 17 Sep 2026 15:46:25 -0400
X-MC-Unique: PdhAthoqOdWjbpDEjjtTlQ-1
X-Mimecast-MFC-AGG-ID: PdhAthoqOdWjbpDEjjtTlQ_1789674383
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F290418052DA;
	Thu, 17 Sep 2026 19:46:22 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.85])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2BD3D19AC048;
	Thu, 17 Sep 2026 19:46:20 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
	Peter Xu <peterx@redhat.com>,
	Junjie Cao <junjie.cao@intel.com>,
	Michael Roth <michael.roth@amd.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	linux-cxl@vger.kernel.org,
	Jason Wang <jasowangio@gmail.com>,
	Eric Blake <eblake@redhat.com>,
	Fabiano Rosas <farosas@suse.de>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
	Kevin Wolf <kwolf@redhat.com>,
	Hanna Reitz <hreitz@redhat.com>,
	qemu-block@nongnu.org,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
	Lukas Straub <lukasstraub2@web.de>,
	Jonathan Cameron <jic23@kernel.org>,
	John Snow <jsnow@redhat.com>
Subject: [PATCH v5 1/7] qapi: convert remaining simple intros for block-export.json
Date: Thu, 17 Sep 2026 15:46:08 -0400
Message-ID: <20260917194614.549584-2-jsnow@redhat.com>
In-Reply-To: <20260917194614.549584-1-jsnow@redhat.com>
References: <20260917194614.549584-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: vDLA639cuIEthvHqKjD1tiPVpVnredAvSrIB0HwFOx8_1789674383
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

These are either structs or unions that are used in an inlinable
context: i.e. the generated documentation is likely to feature a
version of this documentation block that does not include the intro in
context of another command, event, or structure.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/block-export.json | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/qapi/block-export.json b/qapi/block-export.json
index 2893c6456d5..e9f7e72c8ee 100644
--- a/qapi/block-export.json
+++ b/qapi/block-export.json
@@ -37,10 +37,9 @@
 
 ##
 # @NbdServerOptions:
-#
-# Keep this type consistent with the `NbdServerOptionsLegacy` type.
-# The only intended difference is using `SocketAddress` instead of
-# `SocketAddressLegacy`.
+#     Keep this type consistent with the `NbdServerOptionsLegacy`
+#     type.  The only intended difference is using `SocketAddress`
+#     instead of `SocketAddressLegacy`.
 #
 # @addr: Address on which to listen (since 4.2).
 ##
@@ -50,10 +49,9 @@
 
 ##
 # @NbdServerOptionsLegacy:
-#
-# Keep this type consistent with the `NbdServerOptions` type.  The
-# only intended difference is using `SocketAddressLegacy` instead of
-# `SocketAddress`.
+#     Keep this type consistent with the `NbdServerOptions` type.  The
+#     only intended difference is using `SocketAddressLegacy` instead
+#     of `SocketAddress`.
 #
 # @addr: Address on which to listen (since 1.3).
 ##
@@ -339,9 +337,8 @@
 
 ##
 # @BlockExportOptions:
-#
-# Describes a block export, i.e. how single node should be exported on
-# an external interface.
+#     Describes a block export, i.e. how single node should be
+#     exported on an external interface.
 #
 # @type: Block export type
 #
-- 
2.55.0

