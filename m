Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85205377AAD
	for <linux-cxl@vger.kernel.org>; Mon, 31 Aug 2026 20:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788207906; cv=none; b=uXw4Kjs3rIQhZ4+wFuxMw4p/2QmXWMWBOFxxWdjmVt+JqN7SW8jPaQUFfirm10xnyDn1g2TGVYI7TyISW2e+Sxg/12NQuS+cRebdxVcwv8yhnJnupzkwgH90tHZ+q/Bj2SW8Ry9UCn9aTMsKrgdIY6sRFAUE7vKUXeuVotVe1SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788207906; c=relaxed/simple;
	bh=SHvKt/iwCHs40hkH7EY6waUBZi4y7wo12zLJaw4loxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=PGbsgKNvkR+lyeg4g/mHmtJiLUFFIfdPeHBnaEvw6kEu7asfRr8Y9eC729pawzawkg9Ba6SHKi3s81Aun+IBhQ6SHEVPxh0Q12BJgx1WouBJiylXLwRSrIF3otFD1AI2NA8h6qV/dPFRUcQybV6hNtLGHBvBug9BQSbhgTECu4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H8YYxPeM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H8YYxPeM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788207904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ld5g/j6L0lxSwaRZjY3pcA3TM2VpEohq25svIVL3ldM=;
	b=H8YYxPeM+3fDn5M9MR81bmOXfI6/CoBN2p1Tpd92PrBr2m/tkSty/JgctK8bFnTlcLWgYa
	FSIWYDY+kLH/BHbCKyMMBHwVXp2l1q9nprFtZcCGoKjdH10SEmKxHeAkmWmJhMN3oGGR7B
	EVe6+oqMu9qZeVAsTDRRqi70cJ1yjJ8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-471-p1RpSxUbM7urPmhdWjBNnQ-1; Mon,
 31 Aug 2026 16:25:01 -0400
X-MC-Unique: p1RpSxUbM7urPmhdWjBNnQ-1
X-Mimecast-MFC-AGG-ID: p1RpSxUbM7urPmhdWjBNnQ_1788207898
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 422B9184A090;
	Mon, 31 Aug 2026 20:24:58 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.63])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EBF4B1800577;
	Mon, 31 Aug 2026 20:24:51 +0000 (UTC)
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
Subject: [PATCH v4 34/43] qapi: convert trivial intro sections for cxl.json
Date: Mon, 31 Aug 2026 16:19:36 -0400
Message-ID: <20260831201945.287730-35-jsnow@redhat.com>
In-Reply-To: <20260831201945.287730-1-jsnow@redhat.com>
References: <20260831201945.287730-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: kDi0IY9NeqaZTzE3345PD6TY3PcZMV3hfelKVZF5Et4_1788207898
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/cxl.json | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/qapi/cxl.json b/qapi/cxl.json
index 81d6198ba03..aef849a4c2a 100644
--- a/qapi/cxl.json
+++ b/qapi/cxl.json
@@ -365,8 +365,7 @@
 
 ##
 # @CXLUncorErrorRecord:
-#
-# Record of a single error including header log.
+#     Record of a single error including header log.
 #
 # @type: Type of error
 #
@@ -399,8 +398,7 @@
 
 ##
 # @CxlCorErrorType:
-#
-# Type of CXL correctable error to inject
+#     Type of CXL correctable error to inject
 #
 # @cache-data-ecc: Data ECC error on CXL.cache
 #
-- 
2.55.0

