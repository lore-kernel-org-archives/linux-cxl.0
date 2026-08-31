Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815CF286D56
	for <linux-cxl@vger.kernel.org>; Mon, 31 Aug 2026 20:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788207634; cv=none; b=NgCwu0+p0wdVRGmBMN6s3U38q9kv0r+rU7Q5ze3SqXnSWCx82zhfT8QETroW4hi3glPdL9/4hJ4HkaQ3BlXBv7YwJiiKJZkQN/GIUJRTaxCJ3gyR+hMPREcqvEtui5cD0vrtkOHEGhvut+g14UI5Dqeyy+58UZ5XdMtv2Dr/lJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788207634; c=relaxed/simple;
	bh=Rc6FUa9u1sCNe5slEXLQVQBoTIsFVUwcNBS6UfM5qlA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=EYtVfW2J+N5qBgJQ7urcPLAGa3XVsbDpS543ULv9lzH4/41ZvHtkTbkS62mY2bKCrZ6Ih5RNZkWY8Nf9YED/LCUd/O9Cz3kt/WQk9Bx7Och1dvtGsIt3G0VgR8NKp5zYXkW2p9GEyU9taDeuIrFazfp/2ailwIhIMrygRd6gTOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NHW4SmKb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NHW4SmKb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788207632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=anz2t9BFt0L27a1+w3KFmtX2Yur1ocqcJJFRnKyPZho=;
	b=NHW4SmKboRlxo0Yl464GAVTr1Vsyo31IkheZtE0c4N3QTvhgjyV8XUItkmW1ZqsF/tGBX4
	ah4ObNptBGGh4FnYvjBj7/XHN0fB7mU9hDnXNCHnGZNbecbkLqYF6QHlb6/MGy2pvh2Fcm
	jAHcgoabtNJnaTUCT9c58NRG6Z1SvGs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-118-1qSihBPXN2SD3BJRMBBajA-1; Mon,
 31 Aug 2026 16:20:25 -0400
X-MC-Unique: 1qSihBPXN2SD3BJRMBBajA-1
X-Mimecast-MFC-AGG-ID: 1qSihBPXN2SD3BJRMBBajA_1788207621
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 87881184B3BA;
	Mon, 31 Aug 2026 20:20:19 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.63])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0822D18005B0;
	Mon, 31 Aug 2026 20:20:08 +0000 (UTC)
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
Subject: [PATCH v4 02/43] qapi: convert trivial intro sections for acpi-hest.json
Date: Mon, 31 Aug 2026 16:19:04 -0400
Message-ID: <20260831201945.287730-3-jsnow@redhat.com>
In-Reply-To: <20260831201945.287730-1-jsnow@redhat.com>
References: <20260831201945.287730-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: C_Gj-yQtP0TczWpBQpXLwlxLJRyRHd_WuzRwq5d5z3E_1788207621
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

