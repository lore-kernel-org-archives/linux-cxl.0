Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D67495523
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jul 2026 13:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784811609; cv=none; b=pygy8UVFtyJl5nvcDfI6QlTa0UiFjHDBGUM/pQKN62zB9fb45XdZTPZhEoYGGTxDWHgujWV2CzFwlQ0ZTVmJocSDRobRvFS3KJlEVkqiuH00Io9l5vWea8sj54bKjaX1cbVtsAawNebtIM+FXRXANTVnqR+hMnVTfj6Kb6H3oSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784811609; c=relaxed/simple;
	bh=iygl00/Qvb+oocf4Uvc05TTIAL4ZEzxy9CIjHDTNai4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IX82zyqTLlXl8jl1jYt5orOMvEMJUBQyEB9tdlWM5QJGd3AaKVM7SyM6qFzv0Ptwf/e+IYpU5lbGsDZaO3yt7wE2lQ1pN751n/x82or5gich88qGS71/VO9rXVJ3SXLLX9HK84QVHpg1VTEtS5M5Cm0nr/iZgfeHCu6aZ+5k/gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hwt/hyxf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hwt/hyxf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784811605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GADRi87lplCebx047fRHg6xdjxr7u1cKInWP1QxO6Xs=;
	b=hwt/hyxfI8Om+0BnQp+8VvGdcShcWhS43uKTUbkByqXHOX64Rxc37infPnEHs1+lgQjUDj
	GssYlKDvvZjonPQzOVayp+P738jaV2uu71C2W7WKYI414JrdFpOvEBbfqa4UVE2aT4uBEX
	ictK+sG0qGBDtTWVqBYGwll5ow+VzcA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-178-q9E0hjDhNdqBtwrnj90qkQ-1; Thu,
 23 Jul 2026 09:00:02 -0400
X-MC-Unique: q9E0hjDhNdqBtwrnj90qkQ-1
X-Mimecast-MFC-AGG-ID: q9E0hjDhNdqBtwrnj90qkQ_1784811599
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 86EAB182FA2E;
	Thu, 23 Jul 2026 12:59:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 23E95196B0A8;
	Thu, 23 Jul 2026 12:59:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id B4E0A21E6920; Thu, 23 Jul 2026 14:59:53 +0200 (CEST)
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
Subject: Re: [PATCH v2 41/44] qapi: convert trivial intro sections for ui.json
In-Reply-To: <20260723044805.527643-42-jsnow@redhat.com> (John Snow's message
	of "Thu, 23 Jul 2026 00:48:02 -0400")
References: <20260723044805.527643-1-jsnow@redhat.com>
	<20260723044805.527643-42-jsnow@redhat.com>
Date: Thu, 23 Jul 2026 14:59:53 +0200
Message-ID: <87h5lpg8ty.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: YRgdyyJXKcWKgY0kYXSNcGh3sfu2Aefm45E0HT9MzQQ_1784811599
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

John Snow <jsnow@redhat.com> writes:

> (Trivial)
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  qapi/ui.json | 215 ++++++++++++++++++---------------------------------
>  1 file changed, 75 insertions(+), 140 deletions(-)
>
> diff --git a/qapi/ui.json b/qapi/ui.json
> index b2c42a7f578..b4122b2fa9f 100644
> --- a/qapi/ui.json
> +++ b/qapi/ui.json

[...]

> @@ -850,10 +814,9 @@
>  
>  ##
>  # @QKeyCode:
> +#     An enumeration of key name.
>  #
> -# An enumeration of key name.
> -#
> -# This is used by the `send-key` command.
> +#     This is used by the `send-key` command.
>  #
>  # @unmapped: since 2.0
>  #

This one is two paragraphs.

Let's drop the hunk to keep the series single paragraph only.

[...]

