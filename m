Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682AA39C00F
	for <linux-cxl@vger.kernel.org>; Mon, 31 Aug 2026 20:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788207879; cv=none; b=G+9mCi0ZIWYpyEi8lX2L9MXl2si2N73nXeDge0pruqRRufcxMogG8bwKNZkq5XJSz6qVSGfwbvUkWwOH8Sjqi/SlveJTA3pQRaW3aQv10ZYrMbsBrMj5Yr2iqEUAgm3Jtqlr008V6FaEA1vlTxi+8G43L7cRzZEm2NY8bh5ptaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788207879; c=relaxed/simple;
	bh=p3FhXLnwe/1mCMulEEzmUxogYzaHLuBrFKx7bVWuCoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=rKrpunvUFtzuKY8zKvbsGOm4WX8KqM7pR//mS1O0xpv+IL6EdJs3mASWHmicelMZ4izLadunmor/IrM/rqzAibh80izg0WWP/q3GFQOddRc7GZy3MoSD+6owyBeWYt/gjV9qzTBLQUbO6i3c6BLfQSvIP4PdSKStZwBF2pYJDP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bP0ciVif; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bP0ciVif"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788207876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z3E4l/9ZBojjapKTPoc2rkBnvoRHsP4FarABuj8M8OA=;
	b=bP0ciVifW1lsUNU247C2IHI/9VPuS2SObM1MFa3Z+PP2XfG/l85E2PE8iSeA7wkJLYh2gF
	3J1o6VVi0wM4JLBHChlt3GUYN4l/Cc8UcAMBI/eyl87qF/YG/0H7HvzHpDPI9ueD4vk9Yi
	57qi9LFJ4yY1uUb8qucUq415GIcsrPo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-113-oZbFfP_-PC-tN--Gv2Rq1Q-1; Mon,
 31 Aug 2026 16:24:31 -0400
X-MC-Unique: oZbFfP_-PC-tN--Gv2Rq1Q-1
X-Mimecast-MFC-AGG-ID: oZbFfP_-PC-tN--Gv2Rq1Q_1788207869
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 277AE184A08C;
	Mon, 31 Aug 2026 20:24:29 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.63])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 818D11800577;
	Mon, 31 Aug 2026 20:24:22 +0000 (UTC)
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
Subject: [PATCH v4 30/43] qapi: convert trivial intro sections for audio.json
Date: Mon, 31 Aug 2026 16:19:32 -0400
Message-ID: <20260831201945.287730-31-jsnow@redhat.com>
In-Reply-To: <20260831201945.287730-1-jsnow@redhat.com>
References: <20260831201945.287730-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: ObnNheX2r5uADuH4GaNM422qhRU3Mn3gwE1-u6zbxkc_1788207869
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/audio.json | 88 ++++++++++++++++++-------------------------------
 1 file changed, 32 insertions(+), 56 deletions(-)

diff --git a/qapi/audio.json b/qapi/audio.json
index 2df87b97101..72190f20993 100644
--- a/qapi/audio.json
+++ b/qapi/audio.json
@@ -14,9 +14,8 @@
 
 ##
 # @AudiodevPerDirectionOptions:
-#
-# General audio backend options that are used for both playback and
-# recording.
+#     General audio backend options that are used for both playback
+#     and recording.
 #
 # @mixing-engine: use QEMU's mixing engine to mix all streams inside
 #     QEMU and convert audio formats when not supported by the
@@ -53,8 +52,7 @@
 
 ##
 # @AudiodevGenericOptions:
-#
-# Generic driver-specific options.
+#     Generic driver-specific options.
 #
 # @in: options of the capture stream
 #
@@ -69,8 +67,7 @@
 
 ##
 # @AudiodevDBusOptions:
-#
-# Options of the D-Bus audio backend.
+#     Options of the D-Bus audio backend.
 #
 # @in: options of the capture stream
 #
@@ -89,9 +86,8 @@
 
 ##
 # @AudiodevAlsaPerDirectionOptions:
-#
-# Options of the ALSA backend that are used for both playback and
-# recording.
+#     Options of the ALSA backend that are used for both playback and
+#     recording.
 #
 # @dev: the name of the ALSA device to use (default 'default')
 #
@@ -111,8 +107,7 @@
 
 ##
 # @AudiodevAlsaOptions:
-#
-# Options of the ALSA audio backend.
+#     Options of the ALSA audio backend.
 #
 # @in: options of the capture stream
 #
@@ -130,8 +125,7 @@
 
 ##
 # @AudiodevSndioOptions:
-#
-# Options of the sndio audio backend.
+#     Options of the sndio audio backend.
 #
 # @in: options of the capture stream
 #
@@ -152,9 +146,8 @@
 
 ##
 # @AudiodevCoreaudioPerDirectionOptions:
-#
-# Options of the Core Audio backend that are used for both playback
-# and recording.
+#     Options of the Core Audio backend that are used for both
+#     playback and recording.
 #
 # @buffer-count: number of buffers
 #
@@ -167,8 +160,7 @@
 
 ##
 # @AudiodevCoreaudioOptions:
-#
-# Options of the coreaudio audio backend.
+#     Options of the coreaudio audio backend.
 #
 # @in: options of the capture stream
 #
@@ -183,8 +175,7 @@
 
 ##
 # @AudiodevDsoundOptions:
-#
-# Options of the DirectSound audio backend.
+#     Options of the DirectSound audio backend.
 #
 # @in: options of the capture stream
 #
@@ -203,9 +194,8 @@
 
 ##
 # @AudiodevJackPerDirectionOptions:
-#
-# Options of the JACK backend that are used for both playback and
-# recording.
+#     Options of the JACK backend that are used for both playback and
+#     recording.
 #
 # @server-name: select from among several possible concurrent server
 #     instances (default: environment variable $JACK_DEFAULT_SERVER if
@@ -237,8 +227,7 @@
 
 ##
 # @AudiodevJackOptions:
-#
-# Options of the JACK audio backend.
+#     Options of the JACK audio backend.
 #
 # @in: options of the capture stream
 #
@@ -253,9 +242,8 @@
 
 ##
 # @AudiodevOssPerDirectionOptions:
-#
-# Options of the OSS backend that are used for both playback and
-# recording.
+#     Options of the OSS backend that are used for both playback and
+#     recording.
 #
 # @dev: file name of the OSS device (default '/dev/dsp')
 #
@@ -275,8 +263,7 @@
 
 ##
 # @AudiodevOssOptions:
-#
-# Options of the OSS audio backend.
+#     Options of the OSS audio backend.
 #
 # @in: options of the capture stream
 #
@@ -305,9 +292,8 @@
 
 ##
 # @AudiodevPaPerDirectionOptions:
-#
-# Options of the Pulseaudio backend that are used for both playback
-# and recording.
+#     Options of the Pulseaudio backend that are used for both
+#     playback and recording.
 #
 # @name: name of the sink/source to use
 #
@@ -330,8 +316,7 @@
 
 ##
 # @AudiodevPaOptions:
-#
-# Options of the PulseAudio audio backend.
+#     Options of the PulseAudio audio backend.
 #
 # @in: options of the capture stream
 #
@@ -349,9 +334,8 @@
 
 ##
 # @AudiodevPipewirePerDirectionOptions:
-#
-# Options of the PipeWire backend that are used for both playback and
-# recording.
+#     Options of the PipeWire backend that are used for both playback
+#     and recording.
 #
 # @name: name of the sink/source to use
 #
@@ -374,8 +358,7 @@
 
 ##
 # @AudiodevPipewireOptions:
-#
-# Options of the PipeWire audio backend.
+#     Options of the PipeWire audio backend.
 #
 # @in: options of the capture stream
 #
@@ -390,9 +373,8 @@
 
 ##
 # @AudiodevSdlPerDirectionOptions:
-#
-# Options of the SDL audio backend that are used for both playback and
-# recording.
+#     Options of the SDL audio backend that are used for both playback
+#     and recording.
 #
 # @buffer-count: number of buffers (default 4)
 #
@@ -405,8 +387,7 @@
 
 ##
 # @AudiodevSdlOptions:
-#
-# Options of the SDL audio backend.
+#     Options of the SDL audio backend.
 #
 # @in: options of the recording stream
 #
@@ -421,8 +402,7 @@
 
 ##
 # @AudiodevWavOptions:
-#
-# Options of the wav audio backend.
+#     Options of the wav audio backend.
 #
 # @in: options of the capture stream
 #
@@ -440,8 +420,7 @@
 
 ##
 # @AudioFormat:
-#
-# An enumeration of possible audio formats.
+#     An enumeration of possible audio formats.
 #
 # @u8: unsigned 8 bit integer
 #
@@ -464,8 +443,7 @@
 
 ##
 # @AudiodevDriver:
-#
-# An enumeration of possible audio backend drivers.
+#     An enumeration of possible audio backend drivers.
 #
 # @jack: JACK audio backend (since 5.1)
 #
@@ -488,8 +466,7 @@
 
 ##
 # @Audiodev:
-#
-# Options of an audio backend.
+#     Options of an audio backend.
 #
 # @id: identifier of the backend
 #
@@ -534,8 +511,7 @@
 
 ##
 # @query-audiodevs:
-#
-# Return information about audiodev configuration
+#     Return information about audiodev configuration
 #
 # Since: 8.0
 ##
-- 
2.55.0

