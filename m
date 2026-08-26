Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569E647D455
	for <linux-cxl@vger.kernel.org>; Wed, 26 Aug 2026 19:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787773331; cv=none; b=KbzQ4QVoElbblmhikdAea1/u8Q+xoB2+LWZJTUof3Nv8IQtEDe+8M01g0vcnCaTU7yOmxFkDWNa4x8agicJkDIed4OFgkfCBrYd0NrHAh+xmQJBbVP4mNpem6Vw4oY3gAhxkKdXmO3+D+aCez+Ce1CX1PbBrFBByzMk07x4VY2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787773331; c=relaxed/simple;
	bh=jIoEXhfg3T5FbpS85BDVzA2NIGSIWpX9vSusWDNKkcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=TLq9wiBsyysy99IqBnSTKcW+fDEVihkKrl2vIxmp36+Pi4pU/bXfEH1rW6QwoxstmpWy98MNKcekpFZjm+5PhLGAyvL47uYo6y0ykyWeP3uIRbaVqaGvxogvKp9GwDwoh1wbpswk6D+NlaTzLqPEHl99schbp1m6KFq4p9uPbjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fSyitxYA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fSyitxYA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787773317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=paUL78gCdpaCrvbsmed4HTHvmj42cb8WXYX01ka0V0s=;
	b=fSyitxYAgyax3bv2oZu4fFinzqdDdF3oyHbpO9g66QK/YV43pMqJigi4RkEnnUCMplTrXm
	a1t/PpQvEdJuomFYRe5Fd22IF8dMBz8PiGIRHFIdKKQ4eCA2o6mlZncgzTaceP2k+WwST5
	jWAdjpoO04lFaBdTv2lzg+knkxAHN10=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-39mPIoSKPS2Uc-paTFkwOw-1; Wed,
 26 Aug 2026 15:41:53 -0400
X-MC-Unique: 39mPIoSKPS2Uc-paTFkwOw-1
X-Mimecast-MFC-AGG-ID: 39mPIoSKPS2Uc-paTFkwOw_1787773311
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F09311955DCC;
	Wed, 26 Aug 2026 19:41:50 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.99])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D79B91800577;
	Wed, 26 Aug 2026 19:41:43 +0000 (UTC)
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
Subject: [PATCH v3 20/43] qapi: convert trivial intro sections for common.json
Date: Wed, 26 Aug 2026 15:38:17 -0400
Message-ID: <20260826193840.2152000-21-jsnow@redhat.com>
In-Reply-To: <20260826193840.2152000-1-jsnow@redhat.com>
References: <20260826193840.2152000-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: oth4IDNNfgUCT_k6Z12U4p1pxgxZND2wDg7GxlgMFgY_1787773311
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/common.json | 29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/qapi/common.json b/qapi/common.json
index af7e3d618a7..c1bbed21e7f 100644
--- a/qapi/common.json
+++ b/qapi/common.json
@@ -9,8 +9,7 @@
 
 ##
 # @IoOperationType:
-#
-# An enumeration of the I/O operation types
+#     An enumeration of the I/O operation types
 #
 # @read: read operation
 #
@@ -23,8 +22,7 @@
 
 ##
 # @OnOffAuto:
-#
-# An enumeration of three options: on, off, and auto
+#     An enumeration of three options: on, off, and auto
 #
 # @auto: QEMU selects the value between on and off
 #
@@ -39,8 +37,7 @@
 
 ##
 # @OnOffSplit:
-#
-# An enumeration of three values: on, off, and split
+#     An enumeration of three values: on, off, and split
 #
 # @on: Enabled
 #
@@ -72,8 +69,7 @@
 
 ##
 # @OffAutoPCIBAR:
-#
-# An enumeration of options for specifying a PCI BAR
+#     An enumeration of options for specifying a PCI BAR
 #
 # @off: The specified feature is disabled
 #
@@ -98,8 +94,7 @@
 
 ##
 # @PCIELinkSpeed:
-#
-# An enumeration of PCIe link speeds in units of GT/s
+#     An enumeration of PCIe link speeds in units of GT/s
 #
 # @2_5: 2.5GT/s
 #
@@ -120,8 +115,7 @@
 
 ##
 # @PCIELinkWidth:
-#
-# An enumeration of PCIe link width
+#     An enumeration of PCIe link width
 #
 # @1: x1
 #
@@ -144,8 +138,7 @@
 
 ##
 # @HostMemPolicy:
-#
-# Host memory policy types
+#     Host memory policy types
 #
 # @default: restore default policy, remove any nondefault policy
 #
@@ -164,9 +157,8 @@
 
 ##
 # @NetFilterDirection:
-#
-# Indicates whether a netfilter is attached to a netdev's transmit
-# queue or receive queue or both.
+#     Indicates whether a netfilter is attached to a netdev's transmit
+#     queue or receive queue or both.
 #
 # @all: the filter is attached both to the receive and the transmit
 #     queue of the netdev (default).
@@ -184,8 +176,7 @@
 
 ##
 # @GrabToggleKeys:
-#
-# Key combinations to toggle input-linux between host and guest.
+#     Key combinations to toggle input-linux between host and guest.
 #
 # @ctrl-ctrl: left and right control key
 #
-- 
2.55.0

