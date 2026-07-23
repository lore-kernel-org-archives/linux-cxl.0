Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECDD4C9571
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jul 2026 13:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784811634; cv=none; b=a0NPr9V8BBtUhfIts4vp8CZBPJznlFlqZIM+yJQK5uDL+CTGkSxuZvjSZwudk56PUW013mOJTnUVP8ceYs291++856hwvPy5BV0vh4OeqkSMACFzhZTnS5ZEGLo25bYR3KurxJtQ2NkiESG+U2mXEJ81atAm84H5uOR2qV8bNso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784811634; c=relaxed/simple;
	bh=Nj6B89vg/eoHwi/V9n7xJy13riEwGjFKsFi9MFJik7U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tNvF4T5c/SuF6hvXcokrPhiIMWNvDWsu1eF8YU0w4KcHUf6G2XVyu9KzDDNqyvg20z8yrA76li9aFIhq4VwW+wUSga6vhemtK9hUGKre4eEynaVXLrW+RGLxVBNICTEH/LoDuCmL6ETnlMKdAQP85GOvSzzzaDorm178RLVwx6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AnKpHZca; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AnKpHZca"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784811630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=89DEW0SPOYiqkUuOJY9WVCQSswmWOgRitvn9m60FuLc=;
	b=AnKpHZcaGkMpScMp1B4XhNMHuwZiIRmAMYhruK54AapmYTw/lW0Kv4TP9/BfceHoWR+AJV
	Uk+TjCoHpBAz0xKA1A0KOjW2IcH2UvijihD0YLS7gFhfTBuwiAvPtnnmoQF8rdwpeUN6rr
	sU1uRMj27auKfREApw1pwpOSiNivbT0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-163-3P_yM97RMQeKjSrAeHkiEA-1; Thu,
 23 Jul 2026 09:00:26 -0400
X-MC-Unique: 3P_yM97RMQeKjSrAeHkiEA-1
X-Mimecast-MFC-AGG-ID: 3P_yM97RMQeKjSrAeHkiEA_1784811623
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 49C8D197764B;
	Thu, 23 Jul 2026 13:00:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 67094180034C;
	Thu, 23 Jul 2026 13:00:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 1016A21E6920; Thu, 23 Jul 2026 15:00:19 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  Lukas
 Straub <lukasstraub2@web.de>,  Vladimir Sementsov-Ogievskiy
 <vsementsov@yandex-team.ru>,  Zhao Liu <zhao1.liu@intel.com>,  Laurent
 Vivier <laurent@vivier.eu>,  "Gonglei (Arei)" <arei.gonglei@huawei.com>,
  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,  Alex
 Williamson
 <alex@shazbot.org>,  zhenwei pi <zhenwei.pi@linux.dev>,  Hanna Reitz
 <hreitz@redhat.com>,  Ani Sinha <anisinha@redhat.com>,
  qemu-block@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Peter Xu
 <peterx@redhat.com>,  Kevin Wolf <kwolf@redhat.com>,
  linux-cxl@vger.kernel.org,  Jiri Pirko <jiri@resnulli.us>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Stefan Berger
 <stefanb@linux.vnet.ibm.com>,  Fabiano Rosas <farosas@suse.de>,  Stefan
 Hajnoczi <stefanha@redhat.com>,  Michael Tokarev <mjt@tls.msk.ru>,  Igor
 Mammedov <imammedo@redhat.com>,  "Michael S. Tsirkin" <mst@redhat.com>,
  Gerd Hoffmann <kraxel@redhat.com>,  Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>,  linux-edac@vger.kernel.org,  =?utf-8?Q?Marc?=
 =?utf-8?Q?-Andr=C3=A9?=
 Lureau <marcandre.lureau@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Eric Blake <eblake@redhat.com>,
  =?utf-8?Q?C=C3=A9dric?=
 Le Goater <clg@redhat.com>,  Jason Wang <jasowangio@gmail.com>,
  qemu-trivial@nongnu.org,  Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v2 40/44] qapi: convert trivial intro sections for qom.json
In-Reply-To: <20260723044805.527643-41-jsnow@redhat.com> (John Snow's message
	of "Thu, 23 Jul 2026 00:48:01 -0400")
References: <20260723044805.527643-1-jsnow@redhat.com>
	<20260723044805.527643-41-jsnow@redhat.com>
Date: Thu, 23 Jul 2026 15:00:19 +0200
Message-ID: <87fr19g8t8.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: 4fJikkaIlDrZOnXZrF5iQEOVQ1rqCHzq3DUd3YRiShc_1784811623
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

John Snow <jsnow@redhat.com> writes:

> (Trivial)
>
> Signed-off-by: John Snow <jsnow@redhat.com>

I think you missed a few:

diff --git a/qapi/qom.json b/qapi/qom.json
index 79ac8c2add..44845e552a 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -1148,8 +1148,7 @@
 
 ##
 # @MonitorProperties:
-#
-# Properties for all monitors
+#     Properties for all monitors
 #
 # @chardev: ID of the character device providing the monitor transport
 #
@@ -1160,8 +1159,7 @@
 
 ##
 # @MonitorHMPProperties:
-#
-# Properties for the HMP monitor
+#     Properties for the HMP monitor
 #
 # @readline: whether to enable readline for line editing
 #      (default: true)
@@ -1175,8 +1173,7 @@
 
 ##
 # @MonitorQMPCloseAction:
-#
-# Action to take when the character device backend is closed.
+#     Action to take when the character device backend is closed.
 #
 # @none: take no action
 #
@@ -1190,8 +1187,7 @@
 
 ##
 # @MonitorQMPProperties:
-#
-# Properties for the QMP monitor
+#     Properties for the QMP monitor
 #
 # @pretty: whether to pretty print JSON responses (default: false)
 #

