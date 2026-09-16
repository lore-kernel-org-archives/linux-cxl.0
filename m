Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E6D233929
	for <linux-cxl@vger.kernel.org>; Wed, 16 Sep 2026 13:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789567154; cv=none; b=TjZfnCtQ90brvnTYxM052TQZOunbtTtBw9Qqe/Xcv5Cv3uEn3uMs13j8iQgSZgzl4q6Dc/FlS6WSNAGYMnDO9lHHO/SlS6+d5LaGLsiAWK3bjIGfevJohigrytvkK9PqcgY9CcmRDXiReNAjih95JhlQWiTNgAy4I1NBGz6pFFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789567154; c=relaxed/simple;
	bh=H3P4SC3MUohqyrA25rofFFzKpQih/U9UWvaO8gUOGGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=fw3hIF7p37Qqhg2I8T7fWL6zd25MjalkvAaF8JXYuhHMVQfTkmVAvlX6sHIfn6PM+ncg5JVxaqBrpc5YvsafKkb630svH53ABelbrXF5qDlUIa8lHzLJ+RlZvYbteX7WkC50oFGNIjTcp88sDs5SGDcy35o8ST2HWCzljXTTBmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qdqavc8F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qdqavc8F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789567152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NKPSpHSAdUW0sNBcwRZtBbtyHQtLc8C/jg53CK8yBGQ=;
	b=Qdqavc8FGQOHSs9wKV3rfCMN7CNNlqyohECigqXDbpH1rxQjQ8j4hBSYCYviv+IoqASliS
	dyz+azsV/zgHLyXZhc6DWwccqPtR87EeTJB8ZEt+VERmQOf0ws4EnzU93Ap+SrlTAYZs7H
	PHA8h7VKa1yBRo3htFTmzDEtzdY6yr0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-523-iemWHBXhNGmQXNDnL1lVJQ-1; Wed,
 16 Sep 2026 09:59:07 -0400
X-MC-Unique: iemWHBXhNGmQXNDnL1lVJQ-1
X-Mimecast-MFC-AGG-ID: iemWHBXhNGmQXNDnL1lVJQ_1789567146
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BE2BD185588F;
	Wed, 16 Sep 2026 13:59:05 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.46])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6CF8F1956055;
	Wed, 16 Sep 2026 13:59:00 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Peter Xu <peterx@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Eric Blake <eblake@redhat.com>,
	Fabiano Rosas <farosas@suse.de>,
	Kevin Wolf <kwolf@redhat.com>,
	Michael Roth <michael.roth@amd.com>,
	linux-cxl@vger.kernel.org,
	qemu-block@nongnu.org,
	Junjie Cao <junjie.cao@intel.com>,
	Lukas Straub <lukasstraub2@web.de>,
	Hanna Reitz <hreitz@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	John Snow <jsnow@redhat.com>
Subject: [PATCH v4 3/7] qapi: convert remaining simple intros for machine.json
Date: Wed, 16 Sep 2026 09:58:37 -0400
Message-ID: <20260916135841.3614495-4-jsnow@redhat.com>
In-Reply-To: <20260916135841.3614495-1-jsnow@redhat.com>
References: <20260916135841.3614495-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: CxDC8kKxTRVVFTRXsu9ygvOo7GhmLO-mAeWIhjrRivk_1789567146
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

These are either structs or unions that are used in an inlinable
context: i.e. the generated documentation is likely to feature a
version of this documentation block that does not include the intro in
context of another command, event, or structure.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/machine.json | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index f1f2c393824..a58e373dd70 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -449,8 +449,7 @@
 
 ##
 # @NumaOptions:
-#
-# A discriminated record of NUMA options.  (for OptsVisitor)
+#     A discriminated record of NUMA options.  (for OptsVisitor)
 #
 # @type: NUMA option type
 #
-- 
2.55.0

