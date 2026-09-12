Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC13332610
	for <linux-cxl@vger.kernel.org>; Sat, 12 Sep 2026 07:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789198513; cv=none; b=bODR1BNG4RlLam148cGj7EkMJtJ5PCHLD7aKAmeX7oRCjLa+PpU7J+qqAA70fXkAozfbbukiZ9RYuZS52t/zldTzOBR3ISigVCuFVHar/o+rsvtPQvQdSRaw44aQYMVmdKEFZg7bp5hevBFS2HrSry8fVACtxzm03MJozQWpJ68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789198513; c=relaxed/simple;
	bh=Yly7Wd72kSJl9Ai0tvRW81I7u0yLMuWY1ZFrut2I/9E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GygI2vgUGOn+zp34fBzfnSSQcI3fFKjBRBUzXIuLnr3zbVfbFiytHsFhzSSdLRk84TcwZrqk+laAFuCiuOnDIlPcU5r5P4JBrweFF4aLZP/40+rmGifx2DrvpfZ2sjb3xd1RYMzTwdxp6fAYI+qc3ltcE27HjoGjQSKncEo5eEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HcPok5AL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HcPok5AL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789198511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v4il07WnelfQAacPaGox1eoQq+k6ZMm81RGQtSdm/8U=;
	b=HcPok5ALTgQg/OLBrNdaMzrN4ngW2OpoYoV3plTm5jIlSKJCSsy1UEpPX2RDJvWZQY9Wco
	JUfUZYwQlYVlaek0lkRgGB195M518l4iDYMSpzVnKM0UAPzFtKWBuJjdieX0WlL0tihwJM
	ClLWh17mHZ/fEO+xg0/ScDM+8klva2I=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-317-vKT7G3BMPSK65s1OChCOjQ-1; Sat,
 12 Sep 2026 03:35:06 -0400
X-MC-Unique: vKT7G3BMPSK65s1OChCOjQ-1
X-Mimecast-MFC-AGG-ID: vKT7G3BMPSK65s1OChCOjQ_1789198505
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D3F221802647;
	Sat, 12 Sep 2026 07:35:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CF96F18004D4;
	Sat, 12 Sep 2026 07:35:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 749DA21E6A04; Sat, 12 Sep 2026 09:35:01 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  qemu-block@nongnu.org,  Kevin Wolf
 <kwolf@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>,  Eric
 Blake <eblake@redhat.com>,  Jonathan Cameron <jic23@kernel.org>,  Lukas
 Straub <lukasstraub2@web.de>,  Paolo Bonzini <pbonzini@redhat.com>,  Zhao
 Liu <zhao1.liu@intel.com>,  linux-cxl@vger.kernel.org,  Jason Wang
 <jasowangio@gmail.com>,  Hanna Reitz <hreitz@redhat.com>,  Fabiano Rosas
 <farosas@suse.de>,  Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH 4/6] qapi: convert remaining simple intros for
 block-core.json
In-Reply-To: <20260911172200.227914-5-jsnow@redhat.com> (John Snow's message
	of "Fri, 11 Sep 2026 13:21:58 -0400")
References: <20260911172200.227914-1-jsnow@redhat.com>
	<20260911172200.227914-5-jsnow@redhat.com>
Date: Sat, 12 Sep 2026 09:35:01 +0200
Message-ID: <87fqze3ot6.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: dh6KfjR6R5SaFS3MnYooSqsq9sF1E_bgyYapFPURMCE_1789198505
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

John Snow <jsnow@redhat.com> writes:

> These are either structs or unions that are used in an inlinable
> context: i.e. the generated documentation is likely to feature a
> version of this documentation block that does not include the intro in
> context of another command, event, or structure.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  qapi/block-core.json | 45 +++++++++++++++++++-------------------------
>  1 file changed, 19 insertions(+), 26 deletions(-)
>
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 1ca147285e7..88218e38d02 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -4462,9 +4462,8 @@
>  
>  ##
>  # @BlockdevOptionsCurlHttp:
> -#
> -# Driver specific block device options for HTTP connections over the
> -# curl backend.  URLs must start with "http://".
> +#     Driver specific block device options for HTTP connections over
> +#     the curl backend.  URLs must start with "http://".
>  #
>  # @cookie: List of cookies to set; format is "name1=content1;
>  #     name2=content2;" as explained by CURLOPT_COOKIE(3).  Defaults to

Not this patch's problem, but here goes anyway.

"URLs must start" applies to BlockdevOptionsCurlBase member @url.  We
should turn this into a proper link eventually.

Pattern: the base type's documentation needs to be amended somehow.
Here, we need to amend it to restrict the values os the base's member
@url.

This splits the documentation for @url.  Amendments are easy to miss.
At some point, we might want to think of ways to avoid this.

> @@ -4488,9 +4487,8 @@
>  
>  ##
>  # @BlockdevOptionsCurlHttps:
> -#
> -# Driver specific block device options for HTTPS connections over the
> -# curl backend.  URLs must start with "https://".
> +#     Driver specific block device options for HTTPS connections over
> +#     the curl backend.  URLs must start with "https://".
>  #
>  # @sslverify: Whether to verify the SSL certificate's validity
>  #     (defaults to true)
> @@ -4503,9 +4501,8 @@
>  
>  ##
>  # @BlockdevOptionsCurlFtp:
> -#
> -# Driver specific block device options for FTP connections over the
> -# curl backend.  URLs must start with "ftp://".
> +#     Driver specific block device options for FTP connections over
> +#     the curl backend.  URLs must start with "ftp://".
>  #
>  # Since: 2.9
>  ##
> @@ -4515,9 +4512,8 @@
>  
>  ##
>  # @BlockdevOptionsCurlFtps:
> -#
> -# Driver specific block device options for FTPS connections over the
> -# curl backend.  URLs must start with "ftps://".
> +#     Driver specific block device options for FTPS connections over
> +#     the curl backend.  URLs must start with "ftps://".
>  #
>  # @sslverify: Whether to verify the SSL certificate's validity
>  #     (defaults to true)
> @@ -4643,14 +4639,13 @@
>  
>  ##
>  # @BlockdevOptionsCbw:
> -#
> -# Driver specific block device options for the copy-before-write
> -# driver, which does so called copy-before-write operations: when data
> -# is written to the filter, the filter first reads corresponding
> -# blocks from its file child and copies them to @target child.  After
> -# successfully copying, the write request is propagated to file child.
> -# If copying fails, the original write request is failed too and no
> -# data is written to file child.
> +#     Driver specific block device options for the copy-before-write
> +#     driver, which does so called copy-before-write operations: when
> +#     data is written to the filter, the filter first reads
> +#     corresponding blocks from its file child and copies them to
> +#     @target child.  After successfully copying, the write request is
> +#     propagated to file child.  If copying fails, the original write
> +#     request is failed too and no data is written to file child.
>  #
>  # @target: The target for copy-before-write operations.
>  #
> @@ -4686,9 +4681,8 @@
>  
>  ##
>  # @BlockdevOptions:
> -#
> -# Options for creating a block device.  Many options are available for
> -# all block devices, independent of the block driver:
> +#     Options for creating a block device.  Many options are available
> +#     for all block devices, independent of the block driver:

Intro ends with colon, which is unusual, and doesn't really work with
the way documentation gets rendered:

   Options for creating a block device.  Many options are available
   for all block devices, independent of the block driver:

   Members:
      * driver ("BlockdevDriver") -- block driver name

      [More non-variant members...]

      * force-share ("boolean", *optional*) -- force share all
        permission on added nodes.  Requires read-only=true.  (Since
        2.10)

      * When "driver" is "blkdebug": The members of
        "BlockdevOptionsBlkdebug".

      [More variants...]

>  #
>  # @driver: block driver name
>  #
> @@ -5473,9 +5467,8 @@
>  
>  ##
>  # @BlockdevAmendOptionsQcow2:
> -#
> -# Driver specific image amend options for qcow2.  For now, only
> -# encryption options can be amended
> +#     Driver specific image amend options for qcow2.  For now, only
> +#     encryption options can be amended

The second sentence lacks a period.

Let's leave both of these for another day, just take note of future
work:

7. Clean up intros to consist of sentences.  Sentences start with a
capital letter and end with a period.

>  #
>  # @encrypt: Encryption options to be amended
>  #

