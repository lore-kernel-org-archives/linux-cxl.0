Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32D040489A
	for <linux-cxl@vger.kernel.org>; Wed, 16 Sep 2026 07:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789542625; cv=none; b=XxvLbCodpsxka8js1kyoFgEIJYQXNBPRggmDoJuEjpbMfazsrUNkXwze66SilmtHQQRdt8WiCLQjDn01PE/rCVextiQUWEgQYn9t/qsNVRX9EBoKQeexGFM8dMo1ANOdGwMpcV40Vl5w/uoC4Y2CbYPc8s5NsZt8+OS3kFjY2fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789542625; c=relaxed/simple;
	bh=9A/EiEDDr3FDg4+17Z6NYE6a6o8/j+X23fxFPSuMtzA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ghGTdAR/l7JCId6No6tx/8l5h6QhjPK7E+rto3REyxAeZBYibaFmFbVG+VJWAOHuBmuBnb3EIlHdNf+lYSxm6Kurp4byqK0NrHYFfVPyv4Ac3mdqCzT5q7/XWErq3i4UJrh2dVgOqXgLMwK5t3rslW0UWAz1Kr6I3oNEUhowNPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MKi1l0vb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MKi1l0vb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789542613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1/gaTwawDlLuf14wEB4bYVu+faTFd3wc+Gqm1sgWtic=;
	b=MKi1l0vbP+TIe9RpcwoVrLMhNhiCLoK/vg00BqWVX4eVGyh3sOEAR6yWVwuw34QnQtI4yD
	oHczU/STsHgRQzv8qppRFSCBIJO0nDUANPjWQBtbxq8cJBC+zbi/5E2GDARY0XHqVlKxXi
	vkJS114Al8pBz3CHCVcq6Zx+z2VztzU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-52-2Bn_dHJHOMKjnrfJ-Sf7ZA-1; Wed,
 16 Sep 2026 03:10:09 -0400
X-MC-Unique: 2Bn_dHJHOMKjnrfJ-Sf7ZA-1
X-Mimecast-MFC-AGG-ID: 2Bn_dHJHOMKjnrfJ-Sf7ZA_1789542607
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5AA7418A5A0E;
	Wed, 16 Sep 2026 07:10:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A54351800345;
	Wed, 16 Sep 2026 07:10:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 5AD6521E6A04; Wed, 16 Sep 2026 09:10:04 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Fabiano Rosas <farosas@suse.de>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>,  Hanna Reitz <hreitz@redhat.com>,
  qemu-block@nongnu.org,  Zhao Liu <zhao1.liu@intel.com>,
  linux-cxl@vger.kernel.org,  Lukas Straub <lukasstraub2@web.de>,  Jonathan
 Cameron <jic23@kernel.org>,  Paolo Bonzini <pbonzini@redhat.com>,  Peter
 Xu <peterx@redhat.com>,  Michael Roth <michael.roth@amd.com>,  Jason Wang
 <jasowangio@gmail.com>,  Eric Blake <eblake@redhat.com>,  Kevin Wolf
 <kwolf@redhat.com>,  Junjie Cao <junjie.cao@intel.com>
Subject: Re: [PATCH v3 5/7] qapi/parser: fix intermediate "intro" detection
In-Reply-To: <20260915211434.3511110-6-jsnow@redhat.com> (John Snow's message
	of "Tue, 15 Sep 2026 17:14:32 -0400")
References: <20260915211434.3511110-1-jsnow@redhat.com>
	<20260915211434.3511110-6-jsnow@redhat.com>
Date: Wed, 16 Sep 2026 09:10:04 +0200
Message-ID: <87bj9xekoj.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: md0hxV-Tey5Wmny2vI7c_yN8B3Sj9Go_lZpb9RLlYII_1789542607
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
>  scripts/qapi/parser.py | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
> index 9e14c2f7921..79f03062eea 100644
> --- a/scripts/qapi/parser.py
> +++ b/scripts/qapi/parser.py
> @@ -845,6 +845,13 @@ def _insert_after_intro(
>          needed and ``_insert_near_kind(QAPIDoc.Kind.INTRO, ...)`` will
>          be sufficient.
>          """
> +        first = self.all_sections[0]
> +        if first.text and first.kind == QAPIDoc.Kind.INTRO:
> +            # First section is introduction and is non-empty: insert here.
> +            # Rest assured all of this ugliness will very soon go away.
> +            # Pinkie-swear.
> +            self._insert_near_kind(QAPIDoc.Kind.INTRO, section, after=True)
> +
>          index = 0
>          for index, ref_section in enumerate(self.all_sections):
>              if ref_section.kind.name in ("PLAIN", "INTRO"):

This seems to insert generated sections twice, but only sometimes.

Two examples:

   Command query-status (Since: 0.14)

      Query the run status of the VM

      Return:
         "StatusInfo"

  +   Return:
  +      "StatusInfo"
  +
      Example::

         -> { "execute": "query-status" }
         <- { "return": { "running": true,
                          "status": "running" } }

and

   Enum DisplayProtocol (Since: 7.0)

      Display protocols which support changing password options.

      Values:
         * **vnc** -- Not documented

  +      * **vnc** -- Not documented
  +
         * **spice** -- Not documented

