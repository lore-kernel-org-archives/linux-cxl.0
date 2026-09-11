Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C409A4A3D37
	for <linux-cxl@vger.kernel.org>; Fri, 11 Sep 2026 17:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789147339; cv=none; b=aiwpknOJkJquYlrJ3KjyMHQeuNQJa1Pu2mCESGhhssS+6Gb9NsIGyFJfI8I/6RpcJR4xXKZxpB5NBJ9bV24aE1nB2SBFVdHQWJKtDKW3cNl0Lz2GeclCfwjXKmEgbKtdsInou29l4OglbA8qP1DDAzvJyAcZhIcvDABFCIFdfmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789147339; c=relaxed/simple;
	bh=FLMpObrNFi9IClkRd1Kc6eOo73FJWnKKrgI2yNAfRZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=T04xAmKukkNwEbnpNx+orFaLURqIwhJKLc0QWRIDrT28K25eYxrVgrAR2a9en8tKO6Szz1mQLjvc/dV8ItTFy5IuT2u0vmxp3H3lvFNUkA8/EMYBb8BdiVYt9KkEFznITjPml31kFW0xTz4VBkGOfCsjPhAZJDzidS7snk0GJJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YpQOx51g; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YpQOx51g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789147336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6rV63i5zLz4J/LUzf54w3p9IiUX+skDQOv9c6EGZuIE=;
	b=YpQOx51gpCU9O7p/vB8ZvCaf0l1Z0kuWC191KzFIb5eYJX0oOSMH8vWXhZWg2+ZtPLZp+4
	tm/rftz2er80i5gwNxXBltkrmjPvNkReWVmK2qVkihskgw2i+zyBF5tJBC/HYDwPjMW1hX
	vUmcnJHpDXaD+rL1oY+44+tpfBIW4Aw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-223-QYSSMvJbOPCq-kGEp_FrtQ-1; Fri,
 11 Sep 2026 13:22:11 -0400
X-MC-Unique: QYSSMvJbOPCq-kGEp_FrtQ-1
X-Mimecast-MFC-AGG-ID: QYSSMvJbOPCq-kGEp_FrtQ_1789147330
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E89A118009CF;
	Fri, 11 Sep 2026 17:22:09 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.222])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1A46F1956095;
	Fri, 11 Sep 2026 17:22:05 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
	Kevin Wolf <kwolf@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
	Eric Blake <eblake@redhat.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lukas Straub <lukasstraub2@web.de>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	linux-cxl@vger.kernel.org,
	Jason Wang <jasowangio@gmail.com>,
	Hanna Reitz <hreitz@redhat.com>,
	Markus Armbruster <armbru@redhat.com>,
	Fabiano Rosas <farosas@suse.de>,
	Peter Xu <peterx@redhat.com>,
	John Snow <jsnow@redhat.com>
Subject: [PATCH 1/6] qapi: convert remaining simple intros for block-export.json
Date: Fri, 11 Sep 2026 13:21:55 -0400
Message-ID: <20260911172200.227914-2-jsnow@redhat.com>
In-Reply-To: <20260911172200.227914-1-jsnow@redhat.com>
References: <20260911172200.227914-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: Ll89-GNKQUgXlQOreYvRyvNz0pJNWNY0gwjiAAn9u7w_1789147330
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

