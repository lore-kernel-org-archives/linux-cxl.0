Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B1A30DD05
	for <linux-cxl@vger.kernel.org>; Thu, 17 Sep 2026 05:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789621990; cv=none; b=tuHQvwyC4WXazGa/jdfCE1Ke5lxrz7DLHaiZxTI6JS6Chx6fCA49vtIpEjSLEQOOBOM9Qfui/jnLA/+4mOTi+ZYNJszKyOyrrjZ3Cs6FQqAAyOrsLsKkwqV6rX6fDm9bE1hP0mRzPHneK3DYMOABYPr7PfbtvD8T543D84BD4hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789621990; c=relaxed/simple;
	bh=jPo1MVderc6RxnzpCkqzIjPmJDcJeigwBbSB/Td3SeI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VVqvzaW7MoqZy0n0CUhigjKHcIAoe53kB+ZNxDpaunz/QCDzh3XROKNa36znzDKkjaOgMGylErs6azdVL/vC9KvXZ00uDuYOKAr8UIIQe9Ee9hJy/MMVVlmU8cMz8FbjDze63xnjaUnQDONEsEoEdw/KMgY8Pln903VBUqiRLWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XaqaTDRa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XaqaTDRa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789621988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jfQ/mY3e+olZ8ms/kI9wh6jlmsk0LZgXGMrmk0hb/Y8=;
	b=XaqaTDRacpPXNuHtoDuRfX73vVIJSB6BFmlz7du3Q/sww+w0/qBgDQ5ck+lopk+y18Prl0
	1EBvCyGOC50qd6KKmk2XJpKovAjVSvdEOA5l+ukrlKbqilcfNW16LZbnGm0f51RF6iPN3N
	9mM01HNJUt7aEGd46/UA1f7dFUFXR8U=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-n2s7ei2NPLmUJTPEJZOGwg-1; Thu,
 17 Sep 2026 01:13:04 -0400
X-MC-Unique: n2s7ei2NPLmUJTPEJZOGwg-1
X-Mimecast-MFC-AGG-ID: n2s7ei2NPLmUJTPEJZOGwg_1789621982
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F134518007F8;
	Thu, 17 Sep 2026 05:13:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E39371956086;
	Thu, 17 Sep 2026 05:13:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 98C4E21E6A04; Thu, 17 Sep 2026 07:12:58 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Zhao Liu <zhao1.liu@intel.com>,  Peter Xu
 <peterx@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,  Jonathan Cameron
 <jic23@kernel.org>,  Eric Blake <eblake@redhat.com>,  Fabiano Rosas
 <farosas@suse.de>,  Kevin Wolf <kwolf@redhat.com>,  Michael Roth
 <michael.roth@amd.com>,  linux-cxl@vger.kernel.org,
  qemu-block@nongnu.org,  Junjie Cao <junjie.cao@intel.com>,  Lukas Straub
 <lukasstraub2@web.de>,  Hanna Reitz <hreitz@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Jason Wang <jasowangio@gmail.com>
Subject: Re: [PATCH v4 5/7] qapi/parser: fix intermediate "intro" detection
In-Reply-To: <20260916135841.3614495-6-jsnow@redhat.com> (John Snow's message
	of "Wed, 16 Sep 2026 09:58:39 -0400")
References: <20260916135841.3614495-1-jsnow@redhat.com>
	<20260916135841.3614495-6-jsnow@redhat.com>
Date: Thu, 17 Sep 2026 07:12:58 +0200
Message-ID: <87tsno5ulh.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: I25H-i2Tt26C--bQbs9R7Ur3xWsESWmwDTw8DMetE38_1789621982
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

John Snow <jsnow@redhat.com> writes:

> In 43e7ad1a3fa5, I adjusted the insertion algorithm for inserting
> something after the "introduction" to cope with both the old and new
> syntax while we converted QAPI to the new syntax. There's a bug in
> that code that only shows up in a handful of cases and only when using
> the new syntax while this affordance/flex code is still enabled.
>
> In the case that we do actually have a real bona-fide intro section,
> we want to insert directly after that real-deal intro section, not
> after any plaintext sections that may follow it. This code adjusts the
> temporary code to strongly prefer inserting after the actual intro
> section if it exists.
>
> Once again: once conversion is done, you will be delighted by how much
> of this ugly code goes away.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  scripts/qapi/parser.py | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
> index 9e14c2f7921..6a9a5589c14 100644
> --- a/scripts/qapi/parser.py
> +++ b/scripts/qapi/parser.py
> @@ -845,6 +845,14 @@ def _insert_after_intro(
>          needed and ``_insert_near_kind(QAPIDoc.Kind.INTRO, ...)`` will
>          be sufficient.
>          """
> +        first = self.all_sections[0]
> +        if first.text and first.kind == QAPIDoc.Kind.INTRO:
> +            # First section is introduction and is non-empty: insert here.
> +            # Rest assured all of this ugliness will very soon go away.
> +            # Pinkie-swear.
> +            self._insert_near_kind(QAPIDoc.Kind.INTRO, section, after=True)

Isn't this a roundabout way to do

               self.all_sections.insert(1, section)

?

> +            return
> +
>          index = 0
>          for index, ref_section in enumerate(self.all_sections):
>              if ref_section.kind.name in ("PLAIN", "INTRO"):
                   continue
               break
           else:
               index += 1

           self.all_sections.insert(index, section)

