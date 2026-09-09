Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495EF2D0C7E
	for <linux-cxl@vger.kernel.org>; Wed,  9 Sep 2026 04:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788927447; cv=none; b=pqZEnr9HV/G98vJVPKU/2fRQuzUPVewq36GHSvYD/53xGnIIE2fRJrlCYJRQqShxpupzGca3rcX6y1wkHs0IFFeCsVgIF7Q9MquKjgVbAvCCIm7+flDgCPsSzmFl8y/Lo+UT99WqBwKwXise88Mxk3q7j48o07Q0BlsYalARS0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788927447; c=relaxed/simple;
	bh=ufBtFqvgk19JnkhhSpBeiRKK3nqR958JpySyrNd28BI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=cTknzAUzXzG6f2KBFJI6usgW65M0LUGFE64bBH6ufH1r6hnkKjQU8YwQ2/A9vNpSIB08sEW/NN97UnhEy2BcNSLS+2/CYrNu3Is9yh/EX0o2l4dn0uMSEGoJS2XPK6CjmyFwiQKEyXOGxjlhYJBqY1wrAa/inYLMMDXfkzzQ3vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bSReHuK8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bSReHuK8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788927445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RcT4JxcKAptQJDXwIObxS9B3ZXX76p2BU0n37WuyVP0=;
	b=bSReHuK8F8AsqolDhp1tcNQcMl8LZ+8RuFo9hf45jUOlRyqSIM0ttYfxdjhWyPEey5KAeG
	fBCYxRtDhUnJAqCl/E7F4K+An6s88H4Htv6SAMTJUfrhbGTpiMyPyloznhnawa0YKvAIDs
	nOYB2/pNUCojhALNU6PXR6KQcIJi+AQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-265-VGnsDxYCPX6rIuWZ7LgTaw-1; Wed,
 09 Sep 2026 00:17:22 -0400
X-MC-Unique: VGnsDxYCPX6rIuWZ7LgTaw-1
X-Mimecast-MFC-AGG-ID: VGnsDxYCPX6rIuWZ7LgTaw_1788927441
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E07F81955F3B;
	Wed,  9 Sep 2026 04:17:20 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.38])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8EDB51800473;
	Wed,  9 Sep 2026 04:17:17 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
	Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>,
	qemu-block@nongnu.org,
	Eric Blake <eblake@redhat.com>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
	Alex Williamson <alex@shazbot.org>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lukas Straub <lukasstraub2@web.de>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Hanna Reitz <hreitz@redhat.com>,
	linux-cxl@vger.kernel.org,
	Kevin Wolf <kwolf@redhat.com>,
	John Snow <jsnow@redhat.com>
Subject: [PATCH 09/10] qapi: convert simple enum intros for machine.json
Date: Wed,  9 Sep 2026 00:16:39 -0400
Message-ID: <20260909041640.69080-10-jsnow@redhat.com>
In-Reply-To: <20260909041640.69080-1-jsnow@redhat.com>
References: <20260909041640.69080-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: 70uCCAXflgtMNcS5q3NETS3arxE7oTHO1p7KPvmIshI_1788927441
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/machine.json | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index cf905afd4f1..942d35d7275 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -15,12 +15,11 @@
 
 ##
 # @SysEmuTarget:
-#
-# The comprehensive enumeration of QEMU system emulation ("softmmu")
-# targets.  Run "./configure --help" in the project root directory,
-# and look for the \*-softmmu targets near the "--target-list" option.
-# The individual target constants are not documented here, for the
-# time being.
+#     The comprehensive enumeration of QEMU system emulation
+#     ("softmmu") targets.  Run "./configure --help" in the project
+#     root directory, and look for the \*-softmmu targets near the
+#     "--target-list" option.  The individual target constants are not
+#     documented here, for the time being.
 #
 # @rx: since 5.0
 #
@@ -382,9 +381,8 @@
 
 ##
 # @LostTickPolicy:
-#
-# Policy for handling lost ticks in timer devices.  Ticks end up
-# getting lost when, for example, the guest is paused.
+#     Policy for handling lost ticks in timer devices.  Ticks end up
+#     getting lost when, for example, the guest is paused.
 #
 # @discard: throw away the missed ticks and continue with future
 #     injection normally.  The guest OS will see the timer jump ahead
@@ -1926,9 +1924,8 @@
 
 ##
 # @CpuModelCompareResult:
-#
-# An enumeration of CPU model comparison results.  The result is
-# usually calculated using e.g. CPU features or CPU generations.
+#     An enumeration of CPU model comparison results.  The result is
+#     usually calculated using e.g. CPU features or CPU generations.
 #
 # @incompatible: If model A is incompatible to model B, model A is not
 #     guaranteed to run where model B runs and the other way around.
-- 
2.55.0

