Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEC341B8F7
	for <linux-cxl@vger.kernel.org>; Mon, 31 Aug 2026 13:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788183157; cv=none; b=PC3HPoU3i78tzxMTj2G7uM3R/A5Z94cv31+3byoYNICLsYJCmf/7sSf2Fr4QZZstQtqq/Qo5sJuP2Y3PoJZeREP2Vzh96wbGr+nuse9ziN33S+Hue0/fmGycTHsJo7lU/OT6IDCtH9VqEceIVpVGkWEvDlbBm1u8Pys13of9SZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788183157; c=relaxed/simple;
	bh=G2jE7SmXjf1MePd2tXrXYLyEh02Uf42XS9dfx73nZug=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eFlsMTIJoEcndVRQPDTS+ia8HGYscftcGbSQdoiFZ5wcMiVyfbI1nhZl+PYPDP3xk1FlRtAe7DD3YmPXCu9wJgqM+Fh/C41Tr62UbeVGLnWu1W99NK/ickqct3hEZipxaJVZqwhhugstgFGaSXJTVQxE7V/eQs/ibDDv7rzeQtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FFITdy/E; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FFITdy/E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788183154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xGQZE89u+mmoSryvOFDpEKXotLmex/GnUzcEVHRI6xc=;
	b=FFITdy/EHvFQJI2LGZCoUOug0dSNLsWVlXLGKfwUb5dGuvLOQljNnhITB69uOqlnLVZskc
	3GskMKmqbrSeiQLxGosBzuJkQ7sw0y885vZENekd+qepE47VjHijPysmkYqyOf/AuISHDs
	b4ULeDd+0d81OkVhl+chOHU0v6Ko/lc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-32-PzpVHGEgMgGFF9oPr1lNXA-1; Mon,
 31 Aug 2026 09:32:29 -0400
X-MC-Unique: PzpVHGEgMgGFF9oPr1lNXA-1
X-Mimecast-MFC-AGG-ID: PzpVHGEgMgGFF9oPr1lNXA_1788183145
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1130119344BC;
	Mon, 31 Aug 2026 13:32:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F171E1955F05;
	Mon, 31 Aug 2026 13:32:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 6E69B21E682E; Mon, 31 Aug 2026 15:32:17 +0200 (CEST)
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
Subject: Re: [PATCH v3 43/43] qapi: convert trivial intro sections for
 block-core.json
In-Reply-To: <20260826193840.2152000-44-jsnow@redhat.com> (John Snow's message
	of "Wed, 26 Aug 2026 15:38:40 -0400")
References: <20260826193840.2152000-1-jsnow@redhat.com>
	<20260826193840.2152000-44-jsnow@redhat.com>
Date: Mon, 31 Aug 2026 15:32:17 +0200
Message-ID: <87tsoae7q6.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: RRoo5-1tagwvP8rU2z-04gSh6PiEBZtP78Gd1T2Qaq4_1788183145
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

John Snow <jsnow@redhat.com> writes:

> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  qapi/block-core.json | 448 ++++++++++++++++---------------------------
>  1 file changed, 164 insertions(+), 284 deletions(-)
>
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 199efc1e008..bed736d86f9 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json

[...]

> @@ -1378,10 +1357,9 @@
>  
>  ##
>  # @BlockdevOnError:
> -#
> -# An enumeration of possible behaviors for errors on I/O operations.
> -# The exact meaning depends on whether the I/O was initiated by a
> -# guest or by a block job
> +#     An enumeration of possible behaviors for errors on I/O
> +#     operations.  The exact meaning depends on whether the I/O was
> +#     initiated by a guest or by a block job
>  #
>  # @report: for guest operations, report the error to the guest; for
>  #     jobs, cancel the job

Two sentences, i.e. not "very trivial".

[...]

> @@ -4780,9 +4692,8 @@
>  
>  ##
>  # @BlockdevOptions:
> -#
> -# Options for creating a block device.  Many options are available for
> -# all block devices, independent of the block driver:
> +#     Options for creating a block device.  Many options are available
> +#     for all block devices, independent of the block driver:

Likewise.

>  #
>  # @driver: block driver name
>  #

[...]

> @@ -5589,9 +5479,8 @@
>  
>  ##
>  # @BlockdevAmendOptionsQcow2:
> -#
> -# Driver specific image amend options for qcow2.  For now, only
> -# encryption options can be amended
> +#     Driver specific image amend options for qcow2.  For now, only
> +#     encryption options can be amended

Likewise.

>  #
>  # @encrypt: Encryption options to be amended
>  #

[...]

