Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E99446D2BA
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jul 2026 13:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784811690; cv=none; b=QLiNK/nMAa9KQqbNI3yWq2DgFGmYmjPaFek4WSR/1QspPjI/ez1RW8JlWmIRa+4SLA5Fg5h/13WDaoBn4aznypUUUWl/zTw+1RBpLogE/3t52ROMNUqpHbkItP40E2LzUPcA/viGQDx7oeOvQ2zoVbQPkkZTx0etWWC82EnPo5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784811690; c=relaxed/simple;
	bh=Jca/pcJKGiK402dCkOJO7iUK3SNE3m/eWcPrGYrUiSA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VoYvrTEDyjMc0yPYnaBaCcm8RxC/wj2jlQwdx/Pei88Arvc6dUr3QNt4VdK2WxIaSpPDByYa9besbqCEckdtT06ZeiKBRqOd+1RGc3PZoXFClrXVHSWjPj3tKHUfwpxswottGy7m8jUNzRV8l87dDBWLnKMahbwWLY+VfhP3TnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MJ21kLwD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MJ21kLwD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784811688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xy+7a6eZK+ojmfMOcpNV21XUG+/7yzFNRjjodlGqMaM=;
	b=MJ21kLwDsrvBFQnz3arJHebay+vW8DV5c3/nCoTfnOz3aWrhxHwJd4r9FJIQBo9agfCAJm
	RBkgA8JESvAvyQmNlnxmT1IGg1dIee2CDTV2Xwzvh5Y4+FmOLLROOvMQ2blYNKkb2/lILW
	AOCN0vLAChm1L2dk3h+txP2RiU71Pnk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-327-TgHcgvvWPKiI1MiWK14ZGA-1; Thu,
 23 Jul 2026 09:01:25 -0400
X-MC-Unique: TgHcgvvWPKiI1MiWK14ZGA-1
X-Mimecast-MFC-AGG-ID: TgHcgvvWPKiI1MiWK14ZGA_1784811683
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 47183180A970;
	Thu, 23 Jul 2026 13:01:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E8C4918002B5;
	Thu, 23 Jul 2026 13:01:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 8C1B421E6920; Thu, 23 Jul 2026 15:01:18 +0200 (CEST)
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
Subject: Re: [PATCH v2 44/44] qapi: convert trivial intro sections for
 block-core.json
In-Reply-To: <20260723044805.527643-45-jsnow@redhat.com> (John Snow's message
	of "Thu, 23 Jul 2026 00:48:05 -0400")
References: <20260723044805.527643-1-jsnow@redhat.com>
	<20260723044805.527643-45-jsnow@redhat.com>
Date: Thu, 23 Jul 2026 15:01:18 +0200
Message-ID: <87ecgtg8rl.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: ycUX6pomj52wwX-N2E7j4VlcADPSZ90-XBMs9DJFpU8_1784811683
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

John Snow <jsnow@redhat.com> writes:

> (Trivial)
>
> Signed-off-by: John Snow <jsnow@redhat.com>

Here's the one single paragraph you didn't convert (as far as I can
see):

diff --git a/qapi/block-core.json b/qapi/block-core.json
index bd98af2f29..9c30890ae5 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1563,8 +1563,7 @@
 
 ##
 # @BlockdevSnapshotSync:
-#
-# Either @device or @node-name must be set but not both.
+#     Either @device or @node-name must be set but not both.
 #
 # @device: the name of the device to take a snapshot of.
 #

It's not overview.  Worth a mention in the commit message?

