Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA7846AED3
	for <linux-cxl@vger.kernel.org>; Wed, 26 Aug 2026 19:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787773188; cv=none; b=CGMXKip307xWJXEjkPKc9QF5IWQfnugES9b/AHsv7vdSuofd2HrgWcfRS42kZb43kj1suULJ3iVh2RxUdD0nD8ENh4q5Xjy64lv5CGiwVvBVyFrcb1rOp1BmDW589F6dsS0c3+ad4MplgTyiyc86aICZ55a3G4+iIW5Q6XurSEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787773188; c=relaxed/simple;
	bh=Rc6FUa9u1sCNe5slEXLQVQBoTIsFVUwcNBS6UfM5qlA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=DbbtgIvGqw2nBKlk24+l+527P5XVIyf75GkSst5m52c5mmJH15gvQTf2+F04ubEcT+yhWYwOW5HnZbfJTurisk8YKitzYmWZalRFqYQgNoWy2iQxaYr/gyAIRR1soFR8YsLcc6wv0f+0D7Dp1EbrVKn1Q1wPZQG8dKOpFfcmlsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PNUG+bHU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PNUG+bHU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787773163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=anz2t9BFt0L27a1+w3KFmtX2Yur1ocqcJJFRnKyPZho=;
	b=PNUG+bHU3p5V1wU6Oa1uzAhCS7SG+HZMxCYsQyl3T3LFoRFj60ZXMpm4ynhdIVIEC5edrW
	J3Xuf/nbW5eXjX3JcXLPTXGBH5JBtTXmG644LgN5lvXdcaC8QI7/ukmB9gJ9WkZh+JwmJo
	p0dlZbT9M89xcH2R5Dmt8dVtlUNcObc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-330-n-eNOBK0N82FvBwYewdG6A-1; Wed,
 26 Aug 2026 15:39:20 -0400
X-MC-Unique: n-eNOBK0N82FvBwYewdG6A-1
X-Mimecast-MFC-AGG-ID: n-eNOBK0N82FvBwYewdG6A_1787773157
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2434C18052D9;
	Wed, 26 Aug 2026 19:39:16 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.99])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9820D1800577;
	Wed, 26 Aug 2026 19:39:04 +0000 (UTC)
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
Subject: [PATCH v3 02/43] qapi: convert trivial intro sections for acpi-hest.json
Date: Wed, 26 Aug 2026 15:37:59 -0400
Message-ID: <20260826193840.2152000-3-jsnow@redhat.com>
In-Reply-To: <20260826193840.2152000-1-jsnow@redhat.com>
References: <20260826193840.2152000-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: _nVtdBsEOsM6Fq-4-JyxpnGrjAKEM7uF7NIKJQbd1vQ_1787773157
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/acpi-hest.json | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/qapi/acpi-hest.json b/qapi/acpi-hest.json
index a01f1dee095..8db804df197 100644
--- a/qapi/acpi-hest.json
+++ b/qapi/acpi-hest.json
@@ -13,8 +13,8 @@
 
 ##
 # @inject-ghes-v2-error:
-#
-# Inject an error with additional ACPI 6.1 GHESv2 error information
+#     Inject an error with additional ACPI 6.1 GHESv2 error
+#     information
 #
 # @cper: contains a base64 encoded string with raw data for a single
 #     CPER record with Generic Error Status Block, Generic Error Data
-- 
2.55.0

