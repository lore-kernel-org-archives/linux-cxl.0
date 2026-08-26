Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7167F47A883
	for <linux-cxl@vger.kernel.org>; Wed, 26 Aug 2026 19:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787773184; cv=none; b=Yv+nkjIJGAZ0xEqVz93kH2avwcdiIWoByZdsHTH0CGFIAzCqN91Ub2iI1JxGtCh49ZmChYGgQ9BuCyc1Shb6a6z/wUzSzrnBq6thGXcyablOvT1AmMaZbNwwvPbi9CV1kv6Adps1wRT4Kp0jjYRA2i/bKNdB3UWFlrZ1sI+zuiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787773184; c=relaxed/simple;
	bh=YqXwRKnnyVgFZG/BawllyDY2kEFjudhtQ1OWCqy/Zlk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=HahfsDIFNwUKSyM+lpLERs2YTu3Iet+y1vo5GKT+933D/cdNOdnOz4jfUoUUI1QCNbUtRhX7+eN6bgz/9ejXwaWpEdjtZFR9ZUhwkSIh3as0gPS4IvpGoCGjHBStZR3FEAfcxAjLQELu3VA2JLWumzkKDF0AFs3RgqQYdy+nIbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fWqoy0PD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fWqoy0PD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787773171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mlhVSIuYfO98pyz9Sq3hbEesOQSLV/LUPwoZZKF//5o=;
	b=fWqoy0PDOxm6lapEkNx1Cu1IITsSD6cu3DtWILTdI+uZLljFVuWRdQNfFprT7DetRFDIvd
	Sxu88mn7o6NnfszbmlhPGfX0cWj0VpysMl44k70ZxGRo3I5zce6WucPQ/8l64wVFBSO5zV
	+RTAw0qo/kV5OQc7QlLH5VcTNp9qqbA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-287-fo56A73DOWaS7OEAE9kJ4w-1; Wed,
 26 Aug 2026 15:39:28 -0400
X-MC-Unique: fo56A73DOWaS7OEAE9kJ4w-1
X-Mimecast-MFC-AGG-ID: fo56A73DOWaS7OEAE9kJ4w_1787773164
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E0BDA1801A0C;
	Wed, 26 Aug 2026 19:39:23 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.99])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 84B9F18005AC;
	Wed, 26 Aug 2026 19:39:16 +0000 (UTC)
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
Subject: [PATCH v3 03/43] qapi: convert trivial intro sections for ebpf.json
Date: Wed, 26 Aug 2026 15:38:00 -0400
Message-ID: <20260826193840.2152000-4-jsnow@redhat.com>
In-Reply-To: <20260826193840.2152000-1-jsnow@redhat.com>
References: <20260826193840.2152000-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: q4TWZZV36KIEGboLjO3GLyPVnn7NvlpgcrTbuhZlXN0_1787773164
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/ebpf.json | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/qapi/ebpf.json b/qapi/ebpf.json
index f0257955fa2..951516b121f 100644
--- a/qapi/ebpf.json
+++ b/qapi/ebpf.json
@@ -20,8 +20,7 @@
 
 ##
 # @EbpfObject:
-#
-# An eBPF ELF object.
+#     An eBPF ELF object.
 #
 # @object: the eBPF object encoded in base64
 #
@@ -33,8 +32,7 @@
 
 ##
 # @EbpfProgramID:
-#
-# The eBPF programs that can be gotten with `request-ebpf`.
+#     The eBPF programs that can be gotten with `request-ebpf`.
 #
 # @rss: Receive side scaling, technology that allows steering traffic
 #     between queues by calculation hash.  Users may set up
-- 
2.55.0

