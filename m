Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6252412D1F1
	for <linux-cxl@vger.kernel.org>; Wed, 26 Aug 2026 19:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787773208; cv=none; b=VdokXnSRq7MkS7AXeDEmMI+ARXe8w00ajJHGJegV0s65kRjWTIFJoA3XC0SgWSp2IzJ6o3WHMopb2nUBATEsqJWe/mZAgj6OC5ixfx4TsoLnM0QweIZjpCjMpQg3+Rao93hKM9K9572/v5/6uYPb3M0a+mGBSXb7YSVxxozPpmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787773208; c=relaxed/simple;
	bh=VnSlooIFHdVuogjQngzvJfnPE46UezVuckaIq1TlFdw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=gSUwz8McVBv6KGatUfZ2X4j6TUh9HdGJDq5hGjh+DsdidMGYBBqy11okt+znMcNPVlnLu+q9RGsaFTADzrKE1BZ/MUnkJ5TL2mw3as1DRpu+AZcJy42VDBQTnv7gPygCWiqIHij0OTSg/mEppJ/MQUxyHC4tj7Zc9tz2UQmCYcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X/iTeOT2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X/iTeOT2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787773182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wffPVCvszX/U31azigwXEqCRZFarXIHCtsWE3o10AB0=;
	b=X/iTeOT2n5Nvzfy4cDw8ruFlr9Y97KO56ogJkqAkwKoXQ0ERiFIsWn7U42JWVyo5WjeZra
	KqPJJCPz1h9GXVKOoHcT7s/NFEZI6box89lJ8Y9ClwDOaj/GkJIHVplQGluB8pMezUoxwk
	2LhgJqMhHygEQQLvmeH+I53he6cr7y4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-214-YO1alSZxMpSiZtjWvD4uzg-1; Wed,
 26 Aug 2026 15:39:36 -0400
X-MC-Unique: YO1alSZxMpSiZtjWvD4uzg-1
X-Mimecast-MFC-AGG-ID: YO1alSZxMpSiZtjWvD4uzg_1787773173
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6EEB219772FA;
	Wed, 26 Aug 2026 19:39:33 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.99])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 578051800598;
	Wed, 26 Aug 2026 19:39:24 +0000 (UTC)
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
Subject: [PATCH v3 04/43] qapi: convert trivial intro sections for compat.json
Date: Wed, 26 Aug 2026 15:38:01 -0400
Message-ID: <20260826193840.2152000-5-jsnow@redhat.com>
In-Reply-To: <20260826193840.2152000-1-jsnow@redhat.com>
References: <20260826193840.2152000-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: aSqgBBrmLKa3cR52XU80DHh9m5ZRKAwy2vyDMpf6lsQ_1787773173
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/compat.json | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/qapi/compat.json b/qapi/compat.json
index 90b8d51cf27..ef1853b9acd 100644
--- a/qapi/compat.json
+++ b/qapi/compat.json
@@ -9,8 +9,7 @@
 
 ##
 # @CompatPolicyInput:
-#
-# Policy for handling "funny" input.
+#     Policy for handling "funny" input.
 #
 # @accept: Accept silently
 #
@@ -25,8 +24,7 @@
 
 ##
 # @CompatPolicyOutput:
-#
-# Policy for handling "funny" output.
+#     Policy for handling "funny" output.
 #
 # @accept: Pass on unchanged
 #
-- 
2.55.0

