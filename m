Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CE14766A3
	for <linux-cxl@vger.kernel.org>; Mon, 31 Aug 2026 13:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788184355; cv=none; b=mGm1ec2V2jjM1Lzm5WDea0x/e6O9JjZZ4TSgLsABpXREtHoHy5t345xKksE3vR0LPITXSYsYl0MTVD4Z6kWilVIgPq3Qud20AF5UXvoXefWpvKr1n7XvB13oiHfqOVIkiXriL4dWIQttzOy9q0mMe8Br4fg5/Or2uatpdhLjnSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788184355; c=relaxed/simple;
	bh=Ve7MRRuWcN9TRgPgeR/6VZzW8GEfO4U++Arc24hcJHo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PFq/v718X7kTqsgvE/aI4/OYY9GSeUkt4g4Jbu1w0HxmaA1iwX5chgVFlMZhVJNEdGCkcDTtoeiF1xAlzWie6wdp2KXip1Fi+hlT9WZ3If3wgs3Oe9WKA22JwO0eyKKXxsd57PxETz4a8BLIiRzmh6Bq3iyDna+UffkRPA3ZjZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dby4UrI0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dby4UrI0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788184352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fM/jasSe3RaD7bHRh//RSYuvXakBhQNV9sgzJ5NFReY=;
	b=Dby4UrI0a7Sk8+xjxfn/yy7qXce7cRrQuOU0p3kXf1P21Pgip8d7rrKEk0RjN7Rxp2cMRo
	f83uS+cBpKbnLQcQn91fusSgm9tInXCrYteTBcn7DQB1NWZfTf5pnsBUjJzVUR4QpmXWTV
	U6hi6zNmzvikzrSzVO+8NNd+luT3ldA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-217-AYkLWFXePkewEoERRKh88g-1; Mon,
 31 Aug 2026 09:52:30 -0400
X-MC-Unique: AYkLWFXePkewEoERRKh88g-1
X-Mimecast-MFC-AGG-ID: AYkLWFXePkewEoERRKh88g_1788184348
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6D772180ACFB;
	Mon, 31 Aug 2026 13:52:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9764E1955F04;
	Mon, 31 Aug 2026 13:52:25 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 3C68A21E6837; Mon, 31 Aug 2026 15:52:23 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Alex Williamson <alex@shazbot.org>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,
  linux-cxl@vger.kernel.org,  Michael
 Tokarev <mjt@tls.msk.ru>,  Vladimir Sementsov-Ogievskiy
 <vsementsov@yandex-team.ru>,  Peter Xu <peterx@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
  zhenwei pi <zhenwei.pi@linux.dev>,  qemu-trivial@nongnu.org,  Fabiano
 Rosas <farosas@suse.de>,  Kevin Wolf <kwolf@redhat.com>,  Laurent Vivier
 <laurent@vivier.eu>,  Jiri Pirko <jiri@resnulli.us>,
  qemu-block@nongnu.org,  Stefan Hajnoczi <stefanha@redhat.com>,  Stefan
 Berger <stefanb@linux.vnet.ibm.com>,  linux-edac@vger.kernel.org,
  "Gonglei (Arei)" <arei.gonglei@huawei.com>,  Igor Mammedov
 <imammedo@redhat.com>,  Gerd Hoffmann <kraxel@redhat.com>,  Jonathan
 Cameron <jic23@kernel.org>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  Zhao
 Liu <zhao1.liu@intel.com>,  Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>,  "Michael S. Tsirkin" <mst@redhat.com>,
  Hanna Reitz <hreitz@redhat.com>,  Jason Wang <jasowangio@gmail.com>,
  Richard Henderson <richard.henderson@linaro.org>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Ani Sinha <anisinha@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,  Lukas Straub
 <lukasstraub2@web.de>,
  =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PATCH v3 31/43] qapi: convert trivial intro sections for
 block.json
In-Reply-To: <20260826193840.2152000-32-jsnow@redhat.com> (John Snow's message
	of "Wed, 26 Aug 2026 15:38:28 -0400")
References: <20260826193840.2152000-1-jsnow@redhat.com>
	<20260826193840.2152000-32-jsnow@redhat.com>
Date: Mon, 31 Aug 2026 15:52:23 +0200
Message-ID: <877bl6e6so.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: uGCEJNPjjynk34w3DMajOetSYsvPp6RNt1sWCBFnf9A_1788184348
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

John Snow <jsnow@redhat.com> writes:

> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  qapi/block.json | 41 +++++++++++++++++------------------------
>  1 file changed, 17 insertions(+), 24 deletions(-)
>
> diff --git a/qapi/block.json b/qapi/block.json
> index 46955bbb3e3..189f2e28204 100644
> --- a/qapi/block.json
> +++ b/qapi/block.json

[...]

> @@ -314,12 +310,11 @@
>  
>  ##
>  # @blockdev-change-medium:
> -#
> -# Changes the medium inserted into a block device by ejecting the
> -# current medium and loading a new image file which is inserted as the
> -# new medium (this command combines `blockdev-open-tray`,
> -# `blockdev-remove-medium`, `blockdev-insert-medium` and
> -# `blockdev-close-tray`).
> +#     Changes the medium inserted into a block device by ejecting the
> +#     current medium and loading a new image file which is inserted as
> +#     the new medium (this command combines `blockdev-open-tray`,
> +#     `blockdev-remove-medium`, `blockdev-insert-medium` and
> +#     `blockdev-close-tray`).
>  #
>  # @device: Block device name
>  #

Not sure the parenthesis belongs into the intro.

I'm okay with keeping this hunk anyway.

[...]

