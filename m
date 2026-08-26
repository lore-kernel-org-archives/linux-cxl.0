Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FAC357CFA
	for <linux-cxl@vger.kernel.org>; Wed, 26 Aug 2026 19:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787773349; cv=none; b=jHIt73uNsqCQUot5ywuvwlfNkjmQbc0Fpfa90IV3wWMI4mZtZxmJVLCoNfHckmlFGNwNXZycPnYoRvXr1pPY2BRlA9hx26079RqHu9at4oUZFG5x5boEVtgZTgB1oRydn15XN4VGf6lAg1loPWSfkPOUABSEuAbY+HpIBYeHYG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787773349; c=relaxed/simple;
	bh=VEfOx7DWPVqAUE8BqOEyhUTl01T82RFViwPhAgBmVf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=RFkCmpM5N9iJ+bd7SLZHMigRVMUReXjkQqshifmWWvk1gTa+GR7b7FhlhygARtXiu3RmIXpAHWPf5KhGeqUmbA0PpqBJb/5LMmgKbLSHqfZXTNGCg1ko5ORb2yE7sl7NfVwWFQTRWzsFPmp/DEkoZOieQX4RWmqUCw2I4Gjoeck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iszn18Rp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iszn18Rp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787773335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K8AG+94F77edoTiPAI8IPsNpOPrIzUtI0R/Rih5SccE=;
	b=iszn18RpKSDY7P6sHUug8/+vtmrMQbQzEXoVTn0Dolp5c4N09oL59wSvLHo98cPKwmVrGE
	c3wKix0/bk3swMFS1mriiSxbR7cL5UfKZqFJrLFTIqVOj4XKw5s24rbczZKmLzs3cqYc7o
	aDsmrIQx/QWj+g5cx2LGC0z2gOjtKpM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-196-sEoSFFzFPkOn52pLKxESyQ-1; Wed,
 26 Aug 2026 15:42:11 -0400
X-MC-Unique: sEoSFFzFPkOn52pLKxESyQ-1
X-Mimecast-MFC-AGG-ID: sEoSFFzFPkOn52pLKxESyQ_1787773327
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3F27F1954AE1;
	Wed, 26 Aug 2026 19:42:07 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.99])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 89AE41800577;
	Wed, 26 Aug 2026 19:41:59 +0000 (UTC)
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
Subject: [PATCH v3 22/43] qapi: convert trivial intro sections for transaction.json
Date: Wed, 26 Aug 2026 15:38:19 -0400
Message-ID: <20260826193840.2152000-23-jsnow@redhat.com>
In-Reply-To: <20260826193840.2152000-1-jsnow@redhat.com>
References: <20260826193840.2152000-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: qMtSu3Jo_R4p_dnzwQrL8sVoMjEKotriT7xC7B1hzzM_1787773327
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/transaction.json | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/qapi/transaction.json b/qapi/transaction.json
index 4b4eb09bf38..c0dc811ba61 100644
--- a/qapi/transaction.json
+++ b/qapi/transaction.json
@@ -12,8 +12,7 @@
 
 ##
 # @Abort:
-#
-# This action can be used to test transaction failure.
+#     This action can be used to test transaction failure.
 #
 # Since: 1.6
 ##
@@ -22,8 +21,7 @@
 
 ##
 # @ActionCompletionMode:
-#
-# An enumeration of transactional completion modes.
+#     An enumeration of transactional completion modes.
 #
 # @individual: Do not attempt to cancel any other Actions if any
 #     Actions fail after the Transaction request succeeds.  All
@@ -156,9 +154,8 @@
 
 ##
 # @TransactionAction:
-#
-# A discriminated record of operations that can be performed with
-# `transaction`.
+#     A discriminated record of operations that can be performed with
+#     `transaction`.
 #
 # @type: the operation to be performed
 #
@@ -184,8 +181,7 @@
 
 ##
 # @TransactionProperties:
-#
-# Optional arguments to modify the behavior of a Transaction.
+#     Optional arguments to modify the behavior of a Transaction.
 #
 # @completion-mode: Controls how jobs launched asynchronously by
 #     Actions will complete or fail as a group.  See
-- 
2.55.0

