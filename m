Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060BD495AF7
	for <linux-cxl@vger.kernel.org>; Wed, 16 Sep 2026 18:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789582396; cv=none; b=qyWKQAMtO+6YfeArV5HxNWwM0rCrR3qoROxJT32vu+z1gEFOAM66hYwP850jbhZQ91/3tIikGvZe6pAXjKIIVsjqdUI9tChv20cx3sIhrsWblY4wRW+sZJ4LrUkEIblVme1WT1aw2AE8wvxbD5u0UQn29ZoR75wwmFxjR5YjQJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789582396; c=relaxed/simple;
	bh=VzcxmNFV96mgcMjJL++NZ7Yu1Ds6UF4P69WXTZfXGmg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X0hURJOPySSpsVHDrJwtc5XOEODj8g8AUtDkJTWQQgHFuthxleDCoIAu04mBpZ0SLIMuqAQ/dEwnge8Dx5+oAbiOy5g0c7pEKsQ3R9AyUUebikw95fcxlMvutqGQTHAsncV1qFEz6d41JBBgPdddoZSNup26UAJ4LzzDmyLHs98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O9FDjV1G; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O9FDjV1G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789582379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QXH7k6JNHTLZhRW14ruEsP3wRtHT0wa1ys334Qv3x1I=;
	b=O9FDjV1GY2ERXYbCgZQynl8yQZJtdaOdHzcgKQrP9dI/6snCiGihFKWD+x1hDY4Vstvg2d
	DHbBGlXxa2I6+Zbx/vsg9eXYJF7GoXd2TJ6HRQmeZ0BD/8wldqNEzY/Sbms7qr1XT2wVok
	axKOmQcXEVbQAB3ehuGd4BCULN7smkk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-22-w5dPXNaWO5GdxH5nCepoJg-1; Wed,
 16 Sep 2026 14:12:56 -0400
X-MC-Unique: w5dPXNaWO5GdxH5nCepoJg-1
X-Mimecast-MFC-AGG-ID: w5dPXNaWO5GdxH5nCepoJg_1789582371
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4E11218A6970;
	Wed, 16 Sep 2026 18:12:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6E543300418B;
	Wed, 16 Sep 2026 18:12:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 1F58B21E6A04; Wed, 16 Sep 2026 20:12:47 +0200 (CEST)
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
Subject: Re: [PATCH v4 7/7] qapi: convert intro sections followed by
 notes/examples
In-Reply-To: <20260916135841.3614495-8-jsnow@redhat.com> (John Snow's message
	of "Wed, 16 Sep 2026 09:58:41 -0400")
References: <20260916135841.3614495-1-jsnow@redhat.com>
	<20260916135841.3614495-8-jsnow@redhat.com>
Date: Wed, 16 Sep 2026 20:12:47 +0200
Message-ID: <877bkl6p5s.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: 0szj5HsEM4G1kUWHTNtDw4vKS14G71zekQ2lwqixM9Y_1789582371
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

John Snow <jsnow@redhat.com> writes:

> These provide a rather natural cutoff point, but technically this does
> introduce a new intro/details split to these documentation blocks.

Not sure what you mean by "technically".

>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  qapi/machine.json   |  5 ++---
>  qapi/migration.json | 15 +++++++--------
>  qapi/misc.json      |  3 +--
>  qapi/run-state.json |  7 +++----
>  4 files changed, 13 insertions(+), 17 deletions(-)
>
> diff --git a/qapi/machine.json b/qapi/machine.json
> index 84d95c8d87f..276258d9e5c 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -1209,9 +1209,8 @@
>  
>  ##
>  # @HV_BALLOON_STATUS_REPORT:
> -#
> -# Emitted when the hv-balloon driver receives a "STATUS" message from
> -# the guest.
> +#     Emitted when the hv-balloon driver receives a "STATUS" message
> +#     from the guest.
>  #
>  # .. note:: This event is rate-limited.
>  #
   # Since: 8.2

The patch splits the first section between after the first paragraph,
i.e. before the note.

This matters, because we insert generated argument documentation after
the first section.  Rendered documentation changes like this

    Emitted when the hv-balloon driver receives a "STATUS" message from
    the guest.
 
+   Members:
+      * The members of "HvBalloonInfo".
+
    Note:
 
      This event is rate-limited.
 
-   Members:
-      * The members of "HvBalloonInfo".
-
    Example::
 
       <- { "event": "HV_BALLOON_STATUS_REPORT",

> diff --git a/qapi/migration.json b/qapi/migration.json
> index d571c06fc20..a272e701385 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -1254,10 +1254,10 @@
>  
>  ##
>  # @migrate_cancel:
> -#
> -# Cancel the currently executing migration process.  Allows a new
> -# migration to be started right after.  When postcopy-ram is in use,
> -# cancelling is not allowed after the postcopy phase has started.
> +#     Cancel the currently executing migration process.  Allows a new
> +#     migration to be started right after.  When postcopy-ram is in
> +#     use, cancelling is not allowed after the postcopy phase has
> +#     started.
>  #
>  # .. note:: This command succeeds even if there is no migration
>  #    process running.

Similar split, but rendered documentation doesn't change, because
nothing gets inserted.

Same for the remaining hunks.

Should the one hunk that changes rendered documentation be in the "qapi:
convert/split remaining QAPI/QMP intro sections" series?

[...]

