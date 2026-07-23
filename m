Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E6D47DD62
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jul 2026 12:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784811479; cv=none; b=Y36etzaHI4NBkYgRmbM0OlegIEXHCmwKqNG7Y3Y2ZoWQK7+mGsTMrES+Y4PXSCNOz4WFL0xBAgzl7JKHwZu/XF4QDbE19pCd2H4ACduWu0FpImM+CwitabWnQiB4V3Ba0Re1U/lcDbg5YSfi6wt27tIgJIqwwE/onkAFbfHo30w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784811479; c=relaxed/simple;
	bh=Il08Rg6qkg/1Lsdk0GiEJaYLt6Z36jguiw9uQAtNF/Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z3nS40jnhEwVA3MCXErhq6chjYpR5RbSR1+tCRElqt3qToUYzXJKfAuW3azHh3FqUNyzCpeco3GhXb+NdOTh+Iulw8pdeR98Da3aRPuIQnrN0L8nbfkhm+Lhu08tWLcbm0/xeHK+BQyDkFb2gCUg645iOEsN98MM6p90/KM/K04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uo7aED/I; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uo7aED/I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784811475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xh791XMNZ2xgXLQL8lfLW+JBeKd2Y0/8ifrPwfkyRUs=;
	b=Uo7aED/IKjbcGW8VX3eDr1UPLowWTgtvg242K1VCtR6q/ov3ZGNuhdP13BlaNDEfRO6W24
	e2mVIhtosI1VGxfFlgtHKsyPt6XDYimQKa8sZksN5yYtR77qxqYUBR2b3TOwJtaJgD/tA3
	O5jO/dz01sWcWxklYVHoJRHcMJ/DUcc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-513-yWYKGLyHPpeB9uaZg_Nlaw-1; Thu,
 23 Jul 2026 08:57:52 -0400
X-MC-Unique: yWYKGLyHPpeB9uaZg_Nlaw-1
X-Mimecast-MFC-AGG-ID: yWYKGLyHPpeB9uaZg_Nlaw_1784811469
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0909719540DC;
	Thu, 23 Jul 2026 12:57:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0B6791956053;
	Thu, 23 Jul 2026 12:57:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id A065821E6920; Thu, 23 Jul 2026 14:57:41 +0200 (CEST)
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
Subject: Re: [PATCH v2 00/44] qapi: convert trivial intro sections
In-Reply-To: <20260723044805.527643-1-jsnow@redhat.com> (John Snow's message
	of "Thu, 23 Jul 2026 00:47:21 -0400")
References: <20260723044805.527643-1-jsnow@redhat.com>
Date: Thu, 23 Jul 2026 14:57:41 +0200
Message-ID: <87ik65g8xm.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: kzaObaNBwUSqdE03ShI30zf7kcYItAhMWUvoqPSOg5Y_1784811469
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

John Snow <jsnow@redhat.com> writes:

> GitLab CI: https://gitlab.com/jsnow/qemu/-/pipelines/2699067787
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

docs/devel/qapi-code-gen.rst until recently:

    Definition documentation starts with a line naming the definition,
    followed by an optional overview, a description of each argument (for
    commands and events), member (for structs and unions), branch (for
    alternates), or value (for enums), a description of each feature (if
    any), and finally optional tagged sections.

Recent commit ebb49d4bb6 (qapi: add doc comment "Intro" section parsing)
changed it to

    Definition documentation starts with a description naming the
    definition with an optional indented overview, a description of each
    argument (for commands and events), member (for structs and unions),
    branch (for alternates), or value (for enums), a description of each
    feature (if any), and finally optional tagged sections.

It didn't actually update the schema for this change.  This series does,
but only where it's "trivial":

> This patchset tackles "trivial" conversions: cases where the
> introduction is only a single paragraph and is immediately followed by
> a tagged section, the end of the documentation block, or some other
> pre-existing syntactical delineation.

I see the following right after conversions:

* A member description "# @name: ..."

* A "Features:" line

* A tagged section like "Returns: ...", "Since: ..."

End of documentation block ("##") also makes sense, but doesn't actually
occur, because we always have a Since: somewhere after the first
paragraph.

Converting single first paragraps is mechanical.  For it to be correct,
this single paragraph must actually be the overview, and not some other
crap.  I expect it to be almost always overview.  Not sure how to best
look for the exceptions.

When there's more than one paragraph, it could still all be overview.
But the risk of "other crap" is higher.  For instance:

    ##
    # @SecretProperties:
    #
    # Properties for secret objects.
    #
    # Either @data or @file must be provided, but not both.
    #
    # @data: the associated with the secret from
    #
    # @file: the filename to load the data associated with the secret from
    #
    # Since: 2.6
    ##

Two paragraphs, only the first is "overview".

That's why you leave checking and disentangling multiple paragraphs for
later.  Makes sense.

> Future patches that may require more scrutiny will handle the
> remaining conversions - I think this is enough for today, don't you?

Oh yes, it is.

