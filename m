Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3008B3905E7
	for <linux-cxl@vger.kernel.org>; Mon, 31 Aug 2026 20:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788207792; cv=none; b=YvpQJRc/3hsDykYvlYdLlLX77GG7E+qUyKHksXLAvB7MsMr9c6XpaoH127Ij5NDlD85zCFXf9rLu4j5tPP/OrH2onIBf7MZdVpvpRgRCR15R8vIGFF+SXQEA4tlwu2AnPlMd+ehebZud4R7miq+4++trwWhK7bEzm5e5QY0upkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788207792; c=relaxed/simple;
	bh=ZcZXzcooLnhtT0WLB9Uprc5E5Mm/ckVcmXj0Rpgml5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=ROmOL7hXKyDVo25L8U7PO/xYA0SquvOs4P7J66zkwHg5+tzbfGyGE73S1MYSC1E7wrAqi0Qf1hPQLoBDcrh+Pnm/qPO6/5QHVXeIffc9ihmuZx9RrzSQU3WFDvaeVj8/wOGuyOF77yDpmXqgfay8sq5LpZsK6C4Mem8Ykdli8kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PdPr2nHM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PdPr2nHM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788207789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rLnw42K1+V+Fl4KQBW783G0VH8D6uwH+UAZ7SFG2AyA=;
	b=PdPr2nHMtqHbCy8fCloOR8ee5yfBihaqVIt934oklZEhF0A9LjdDLMGn736p54JiGuFwxL
	LOYZT8qvC6dag2PuwDcynTZkV7gvw1Jy9o8y5fKFGHlSO9Je+lXMHEJgnOHxSPBlriS1f5
	PlVlMkzzMRiPJ6W0wLVrxOrimjOXBos=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-359-TzF6fO6QNbSEh8CEQsUTuQ-1; Mon,
 31 Aug 2026 16:23:04 -0400
X-MC-Unique: TzF6fO6QNbSEh8CEQsUTuQ-1
X-Mimecast-MFC-AGG-ID: TzF6fO6QNbSEh8CEQsUTuQ_1788207781
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 925FA18E021F;
	Mon, 31 Aug 2026 20:22:17 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.63])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 633DD1800577;
	Mon, 31 Aug 2026 20:22:09 +0000 (UTC)
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
Subject: [PATCH v4 13/43] qapi: convert trivial intro sections for replay.json
Date: Mon, 31 Aug 2026 16:19:15 -0400
Message-ID: <20260831201945.287730-14-jsnow@redhat.com>
In-Reply-To: <20260831201945.287730-1-jsnow@redhat.com>
References: <20260831201945.287730-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: YrPAFWLTbicZXXALJxbh4NqDC6AfZnj8rtzZMoAQ4sw_1788207781
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/replay.json | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/qapi/replay.json b/qapi/replay.json
index ccf84da68ef..66dff797553 100644
--- a/qapi/replay.json
+++ b/qapi/replay.json
@@ -12,8 +12,7 @@
 
 ##
 # @ReplayMode:
-#
-# Mode of the replay subsystem.
+#     Mode of the replay subsystem.
 #
 # @none: normal execution mode.  Replay or record are not enabled.
 #
@@ -30,8 +29,7 @@
 
 ##
 # @ReplayInfo:
-#
-# Record/replay information.
+#     Record/replay information.
 #
 # @mode: current mode.
 #
-- 
2.55.0

