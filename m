Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0415034DB41
	for <linux-cxl@vger.kernel.org>; Fri, 24 Jul 2026 10:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784889492; cv=none; b=JwHZpiMxaDRtOnj0GLE7wOK+nUJtvGVdulNoCZI0L4+G8f6r14KAdmm5rAHb6nVxN1NwZNcOIdFx66uHJsqQd4Cm/3X8hvJsJlUCZQs91IZA8QDxIvt0jGFBnpR0USBNbbFAbQsDOfWKtY0a/PJvRrSQ/RfLOfbk1PROXDCQ2dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784889492; c=relaxed/simple;
	bh=SsDywP4rywReLAK6ZrLEd+ZAPvj3dC56ZhGDGzSQlnM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hFVV9AbT9mumfrigr7Ay19xI42/VgA6VCuT1IBsWXIOdXH5y5uDNBMNHmn02tQA/mwlN46PW+iENWYdkJtBO8BI/HS5xb4swvfpMLfaaxjqu6oWQd4h8fhhg7EmJ2P7t+Oy5w9MW42oPlUe7Mv+lOCrSRqfpgK3iPMSz6UgGpxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hqbyCvNa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hqbyCvNa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784889488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OWjrYIeYwmpjJ1Ej8RflnyzFYAlRgloM4zHRRFTOgq0=;
	b=hqbyCvNaoMVl2Nu+nM/6OcIK44SI7ArKXjIUN2cUv2w1d30K0hUTnhc64nGBNl8Chp6O4U
	bgNY/GU79SYqbsi78Ba8jsyxoEBtCubf1Arm/luAOay2bMVlwHbfODOr45aZI+lbY3tbw0
	B9mxHVlzyYS0fwrhaxCdyFvr2eSzSEY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-153-7oi8HimiPt2yxjaNJw_88Q-1; Fri,
 24 Jul 2026 06:38:03 -0400
X-MC-Unique: 7oi8HimiPt2yxjaNJw_88Q-1
X-Mimecast-MFC-AGG-ID: 7oi8HimiPt2yxjaNJw_88Q_1784889480
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E5F22197766C;
	Fri, 24 Jul 2026 10:37:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 40C18195605F;
	Fri, 24 Jul 2026 10:37:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id E027B21E6920; Fri, 24 Jul 2026 12:37:52 +0200 (CEST)
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
Subject: Re: [PATCH v2 43/44] qapi: convert trivial intro sections for
 machine.json
In-Reply-To: <20260723044805.527643-44-jsnow@redhat.com> (John Snow's message
	of "Thu, 23 Jul 2026 00:48:04 -0400")
References: <20260723044805.527643-1-jsnow@redhat.com>
	<20260723044805.527643-44-jsnow@redhat.com>
Date: Fri, 24 Jul 2026 12:37:52 +0200
Message-ID: <87jyqkad1b.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: qljFsjRtHTwq9KeVtR5SCyoq6qKwiuLBoG-VbxI23_8_1784889480
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

John Snow <jsnow@redhat.com> writes:

> (Trivial)
>
> Signed-off-by: John Snow <jsnow@redhat.com>

I think you missed

diff --git a/qapi/machine.json b/qapi/machine.json
index 2b0b975764..cb2ec93e18 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1370,8 +1370,7 @@
 
 ##
 # @SpMemDeviceInfo:
-#
-# sp-mem device state information
+#     sp-mem device state information
 #
 # @id: device's ID
 #

