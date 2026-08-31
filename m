Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8E24A013E
	for <linux-cxl@vger.kernel.org>; Mon, 31 Aug 2026 14:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788186437; cv=none; b=EumyG/fpopFB3n+QR6JfoGR9IIK880J6C6VE0xw5b69T1WommSsO4fSdClsUbgcFcdmoKFntWu61QoHrYl0EtdsixIynDeo0VVQW3SM1FREodQxBYSJ6O6NjQwCISSwm0lTo+bVFrIOZLlmyiXkCe10zDQ3LIRHbK1lh7PLwmio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788186437; c=relaxed/simple;
	bh=4wZqQyFq1qdVFPr/8CRkP8i0ygfeBygDfw6Ts6Gc1mM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MaLuoqoUXV/VgkrLdkKHLXi2n2T1phf+HEBM/84LhLvoP0z0vkcnddDeYBJNCQL11+6n43x0aURtnK9ye2wlp6UQiIaRq7P3dTZ+JmGgaT/nzV5N2Oyr/WkCfnyOiwncMUbjEC8dNQGdJhDz45ILnAjzAIBp0RuwITGx12CweEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FE/Jgy1V; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FE/Jgy1V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788186435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HCozuPAg1cr/zk+7RZYGGy+oIIzMfSunUSVRYIRDg+0=;
	b=FE/Jgy1VtqluOeHkFs2nQMjOfmHLBQ56l6/dTM423jIYujQDN9+QzifbAU078A6u8LvMnq
	y6b4BRs//3Rr08IdRBn9B7DFrcKT3DMra7yQT+T1CXtEfzJq8vIkW0fJQemgG3La1eLZoR
	hon7JyQJ5Wk/Si87ycYYW7iH7Byjn1E=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-9-8rxvVzleOh2OI-99uu497g-1; Mon,
 31 Aug 2026 10:27:11 -0400
X-MC-Unique: 8rxvVzleOh2OI-99uu497g-1
X-Mimecast-MFC-AGG-ID: 8rxvVzleOh2OI-99uu497g_1788186428
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 777EF187078B;
	Mon, 31 Aug 2026 14:27:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9C03A18005BD;
	Mon, 31 Aug 2026 14:27:05 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 272D221E6832; Mon, 31 Aug 2026 16:27:03 +0200 (CEST)
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
Subject: Re: [PATCH v3 00/43] qapi: convert (very) trivial intro sections
In-Reply-To: <20260826193840.2152000-1-jsnow@redhat.com> (John Snow's message
	of "Wed, 26 Aug 2026 15:37:57 -0400")
References: <20260826193840.2152000-1-jsnow@redhat.com>
Date: Mon, 31 Aug 2026 16:27:03 +0200
Message-ID: <87pkyycqmg.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: nQuY4BtgEkHt94UtrVzS-PyXZFY0asBXhR95XGj_nX4_1788186428
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

John Snow <jsnow@redhat.com> writes:

> v3:
>    As per Markus' request, the intro section conversion has been split
>    even further into the *very* trivial; leaving the semi-trivial and
>    not-trivial conversions for later consideration.
>
>    If you are a non-qapi/non-docs maintainer being CC'd on this patch,
>    there is **very likely** nothing for you to do here; we are only
>    changing spacing and syntax, but not modifying content in any way
>    in this series in particular. Please feel free to mark-as-read and
>    move on with your day.
> -
>
> Hi, this patchset converts trivial "introductory" sections in the QAPI
> documentation to use the new, explicit intro section syntax.
>
> This is being done primarily for the benefit of the forthcoming
> "inliner", a feature for the rendered HTML QMP documentation that
> seeks to "inline" QMP command argument documentation into the argument
> list for each command.
>
> There are two main motives here:
>
> (1) We want the split between the "introduction" and "details"
>     sections to be mechanically obvious, so that auto-generated or
>     inlined documentation has a well-defined, obvious spot to go.
>
> (2) We do not want to inline irrelevant, introductory text describing
>     structures to be copied into command documentation.
>
> This patchset tackles "very trivial" conversions: cases where the
> existing leading plaintext is only a single sentence and is
> immediately followed by a tagged section, the end of the documentation
> block, or some other pre-existing syntactical delineation. (i.e.: not
> more plaintext.)

I checked whether the converted intros are indeed all "very trivial".
Only a few that aren't have crept in.  I replied to the patches.

I eye-balled whether these intros actually contain only introductory
text.  Looks like it (but I'm only human, and the checking is
t-e-d-i-o-u-s).  Many of them could use polish.  Not today.

With the few conversions that aren't "very trivial" dropped, series
Reviewed-by: Markus Armbruster <armbru@redhat.com>

> NOTE: This series *may* miss some conversions; future QAPI changes will
> enforce the new syntax and any cases that have appeared since v1 will
> be identified and corrected at that time; we are concerned with the
> bulk and ease-of-review here, not completeness. This is precisely why
> the new intro syntax and parser were carefully designed to allow
> gradual conversion.

Partial conversion is undesirable.  We need to finish the job.  We'll
need more than one series to have a chance at actually reviewing it.
I'm debating whether to keep them on a branch until we finish.

If I count correctly, roughly 70% of all intros are "very trivial".
Good to get them out of the way.

> NOTE2: Future patches that may require more scrutiny will handle the
> remaining conversions - There are some very subtle concerns that are
> not readily apparent in the very minor textual changes that will be
> spelled out for reviewers in the cover letters for those series.
>
> This is enough for today, don't you think?

Yes!

