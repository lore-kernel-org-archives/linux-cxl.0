Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DBE38F656
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jul 2026 04:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784782365; cv=none; b=Q/Eg9kUcAVqEz8GuutO5o6uURiRtTte3l03gkATx9ynv0tEVDC7RTZ2TwWm0tx3gvttngJL9pXBn5ERyryP6ce+NKLSRgXl9TpByEVIowvQZvckPpxeI2ZF+2dkgiZpRxw1cmldADP27suyZ9TxGvoWeB9M2WPn79UeIeIeciD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784782365; c=relaxed/simple;
	bh=Md4ZvvR33YxLPGpIdmu9UsMquEsI0mm3HeXjzNp4Ydo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=KsZI/1OoIC958mH0fGYMXBC1TAmdQ8kJhWEmTZS8BOPv5GyJ/lGgC5UnYMnoIXc6+5mQfNCrqF7cO6RLZIC2bavQC+gQg7dHscJgIIY0jkexOKa7oMlkpTX/CwfvY38PDshpDn7Vqwgj3zU+fjWpXCXaGMqUVCV1muGhdv65Vb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KEwFI6tU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KEwFI6tU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784782355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ieD8d7uIFceTxEjKltR0VJrAkmqKTvXxTTZUmuZaZws=;
	b=KEwFI6tUqUMYvg4iw0Z5ahgatEDummOjqTUz0VHx5pWDu/0dURxSRgqq6k6VCTQ61f2ve8
	q7HJMeRzAQ5JlFnobH/GPfbCOh+TY4nIpkmh9NGJIb0EwBZhkrYhx/87GW549uqZMuTQil
	CLH6I/pi+q2m3E955OnZ+LNrUWzj5t4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-eeCSOB1aOsS8UW4jt6eH7w-1; Thu,
 23 Jul 2026 00:52:31 -0400
X-MC-Unique: eeCSOB1aOsS8UW4jt6eH7w-1
X-Mimecast-MFC-AGG-ID: eeCSOB1aOsS8UW4jt6eH7w_1784782348
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C89AB19775B0;
	Thu, 23 Jul 2026 04:52:28 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.44])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4947318002B5;
	Thu, 23 Jul 2026 04:52:21 +0000 (UTC)
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
Subject: [PATCH v2 25/44] qapi: convert trivial intro sections for job.json
Date: Thu, 23 Jul 2026 00:47:46 -0400
Message-ID: <20260723044805.527643-26-jsnow@redhat.com>
In-Reply-To: <20260723044805.527643-1-jsnow@redhat.com>
References: <20260723044805.527643-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: e5D3E9wN4AZAOrD1aEhmDo9ps9YHqSG3pcWOVh31CZ0_1784782348
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

(Trivial)

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/job.json | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/qapi/job.json b/qapi/job.json
index 31618e6ebcc..b68d7292423 100644
--- a/qapi/job.json
+++ b/qapi/job.json
@@ -9,8 +9,7 @@
 
 ##
 # @JobType:
-#
-# Type of a background job.
+#     Type of a background job.
 #
 # @commit: block commit job type, see `block-commit`
 #
@@ -42,8 +41,7 @@
 
 ##
 # @JobStatus:
-#
-# Indicates the present state of a given job in its lifetime.
+#     Indicates the present state of a given job in its lifetime.
 #
 # @undefined: Erroneous, default state.  Should not ever be visible.
 #
@@ -90,8 +88,7 @@
 
 ##
 # @JobVerb:
-#
-# Represents command verbs that can be applied to a job.
+#     Represents command verbs that can be applied to a job.
 #
 # @cancel: see `job-cancel`
 #
@@ -117,8 +114,7 @@
 
 ##
 # @JOB_STATUS_CHANGE:
-#
-# Emitted when a job transitions to a different status.
+#     Emitted when a job transitions to a different status.
 #
 # @id: The job identifier
 #
@@ -259,8 +255,7 @@
 
 ##
 # @JobInfo:
-#
-# Information about a job.
+#     Information about a job.
 #
 # @id: The job identifier
 #
@@ -294,8 +289,7 @@
 
 ##
 # @query-jobs:
-#
-# Return information about jobs.
+#     Return information about jobs.
 #
 # Returns: a list with info for each active job
 #
-- 
2.55.0

