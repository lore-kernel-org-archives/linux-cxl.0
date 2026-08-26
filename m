Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E053A7F66
	for <linux-cxl@vger.kernel.org>; Wed, 26 Aug 2026 19:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787773168; cv=none; b=fLTzONQkMwXXOAO1+diLUOLTQTsiyndsIJ94PCnMAsR14UWUevH+9p5WpWjxpL7qV/3PjsPxmgMnk+VwskPX60iyCnZYGQzkiB6Zx4dNC7Ot36M83hLznro/zSEe2KZKEk5QyQQBk8KNeWn9i0FJ6mPVD5TIjYlwaZF+pDXWZrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787773168; c=relaxed/simple;
	bh=xrOxuADJghP/hTmU5OGdYlrYsdNXYqF9CL1+/9JALHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=BJql3LdbkW6e+sd5Wd68vER+FVykqLhJS3qTqgBMtr9bb48YgeuVVFUkEJpoVkJwnmcSqpKuA0S2JuRtumIM74hkVNe0xjpe2BJHZO8w345GzE2p1bHccJIqa6StliW1tUG5EkefxDRutWm1aLbQ5dOmNTapSsCl63ZC4EbOGcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bGL2yqlt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bGL2yqlt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787773153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A/OW6263CQjLXDYtbi1db4zwKaOEWfAdiemnH4xV/ww=;
	b=bGL2yqlt9Edn2zxN2sO5qS37kOaIHGW4PEmv/yrc+Jf53FpFbZ88yncphvLMyiaDDagBqh
	YaTeNpzKsSdO//7Ai1RJapklrLioJv1B1ju74wdNryk3WMHGrKnDwkyXJrc9yoN/QnbyqU
	wR4fWLiLLcKB3x/xJAbtTMwapcoPLq8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-400-77TLEYeuO5eQMH60bBh4jQ-1; Wed,
 26 Aug 2026 15:39:10 -0400
X-MC-Unique: 77TLEYeuO5eQMH60bBh4jQ-1
X-Mimecast-MFC-AGG-ID: 77TLEYeuO5eQMH60bBh4jQ_1787773145
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0040818009D7;
	Wed, 26 Aug 2026 19:39:04 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.99])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 098061800598;
	Wed, 26 Aug 2026 19:38:54 +0000 (UTC)
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
Subject: [PATCH v3 01/43] qapi: convert trivial intro sections for error.json
Date: Wed, 26 Aug 2026 15:37:58 -0400
Message-ID: <20260826193840.2152000-2-jsnow@redhat.com>
In-Reply-To: <20260826193840.2152000-1-jsnow@redhat.com>
References: <20260826193840.2152000-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: 0bgukCNRR107oG2MqeSzDKGCXAGmSEOECmDfN79phqA_1787773145
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/error.json | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/qapi/error.json b/qapi/error.json
index 54cb02fb880..a53b13e55c9 100644
--- a/qapi/error.json
+++ b/qapi/error.json
@@ -9,8 +9,7 @@
 
 ##
 # @QapiErrorClass:
-#
-# QEMU error classes
+#     QEMU error classes
 #
 # @GenericError: this is used for errors that don't require a specific
 #     error class.  This should be the default case for most errors
-- 
2.55.0

