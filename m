Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6B23C76A6
	for <linux-cxl@vger.kernel.org>; Fri, 24 Jul 2026 08:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784882435; cv=none; b=INDWAU3fsX9u2LPvQn7sm/g6qxRY2OMEu640EuJtQFTDVLf9KxsqsHJljn/agvw6gEh5oMy4f3SFTF17d1Nb64JJY/hglblulHtIyhIrRzRNscNIewLjNfSLwoE0tgi6ByRAuqzy0wiXBbf66CsQksoqWkYqcox1LmUk9GpMxqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784882435; c=relaxed/simple;
	bh=nfdN5p6fif9L4eToDUcoOof9/gg2TjcGQcB6nHUNG4M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=P1pwQHZV214xWx2/4q/zHNRq5+CuLUm5bi8uivZCKqRI+TyM/NZTa9YvvE95XbWB8rXdxTsduX7QWe4cwVQerf4HVJiD+anyhbno3+EWD3DIWHdd53btGGGjREP3my2YRmrJgfuXXKQC+tUk2tsYr4NYAShH9PsHpGFQI88+/vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eF8JEtE4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eF8JEtE4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784882431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dgIBRmicN9h4bBiDRn0VGIqHOycUo/puoDIVi8avihQ=;
	b=eF8JEtE46j9/mommEb7zQSBdj7D4jPMBRS7Jy2FpsLquB1RV51ihljQVCSmztyM4PiYnNb
	vJ5RrqFCx//hBMX40rt4VuX+V2u9sO8qUsVRwXgdbufWztouIY9yJ3aDjuUHaHTaZPHRdS
	dnbCmLLSiWAl2PfOutcW83DZVyu6PgM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-547-VOcuL-kPNjCLML9EkW7tAw-1; Fri,
 24 Jul 2026 04:38:21 -0400
X-MC-Unique: VOcuL-kPNjCLML9EkW7tAw-1
X-Mimecast-MFC-AGG-ID: VOcuL-kPNjCLML9EkW7tAw_1784882299
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A6393195DBA3;
	Fri, 24 Jul 2026 08:38:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 071A815A5;
	Fri, 24 Jul 2026 08:38:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 98ED021E6920; Fri, 24 Jul 2026 10:38:12 +0200 (CEST)
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
Subject: Re: [PATCH v2 44/44] qapi: convert trivial intro sections for
 block-core.json
In-Reply-To: <20260723044805.527643-45-jsnow@redhat.com> (John Snow's message
	of "Thu, 23 Jul 2026 00:48:05 -0400")
References: <20260723044805.527643-1-jsnow@redhat.com>
	<20260723044805.527643-45-jsnow@redhat.com>
Date: Fri, 24 Jul 2026 10:38:12 +0200
Message-ID: <87y0f0aikr.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: BqayC9TZaGVu8zI1JR2xGGsiCGX_PtjauMaTvU7B97c_1784882299
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

John Snow <jsnow@redhat.com> writes:

> (Trivial)
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  qapi/block-core.json | 646 +++++++++++++++++--------------------------
>  1 file changed, 255 insertions(+), 391 deletions(-)
>
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 1f87b078505..bd98af2f298 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json

[...]

> @@ -422,10 +417,9 @@
>  
>  ##
>  # @BlockGraphInfo:
> -#
> -# Information about all nodes in a block (sub)graph in the form of
> -# `BlockNodeInfo` data.  The base `BlockNodeInfo` struct contains the
> -# information for the (sub)graph's root node.
> +#     Information about all nodes in a block (sub)graph in the form of
> +#     `BlockNodeInfo` data.  The base `BlockNodeInfo` struct contains
> +#     the information for the (sub)graph's root node.
>  #
>  # @children: Array of links to this node's child nodes' information
>  #

The first sentence is clearly overview, but the second caught my eye.
What would we want the inliner to do with it?

Looks like the inliner isn't going to do anything with it right now,
because BlockGraphInfo is only used as member type.

[...]

> @@ -1378,10 +1355,9 @@
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

The first sentence is clearly overview, but the second caught my eye.

Because this is an enum type, and we're not going to inline these, we
can leave it as is.

[...]

> @@ -1636,9 +1605,8 @@
>  
>  ##
>  # @BackupPerf:
> -#
> -# Optional parameters for backup.  These parameters don't affect
> -# functionality, but may significantly affect performance.
> +#     Optional parameters for backup.  These parameters don't affect
> +#     functionality, but may significantly affect performance.

The first sentence is clearly overview.  What would we want the inliner
to do with the second?

Looks like the inliner isn't going to do anything with it right now,
because BackupPerf is only used as member type.

Aside: this only user BackupCommon member x-perf has been @unstable for
more than five years.  That's a long time to sit on a fence.

>  #
>  # @use-copy-range: Use copy offloading.  Default false.
>  #

[...]

> @@ -1845,12 +1812,12 @@
>  
>  ##
>  # @change-backing-file:
> -#
> -# Change the backing file in the image file metadata.  This does not
> -# cause QEMU to reopen the image file to reparse the backing filename
> -# (it may, however, perform a reopen to change permissions from r/o ->
> -# r/w -> r/o, if needed).  The new backing file string is written into
> -# the image file metadata, and the QEMU internal strings are updated.
> +#     Change the backing file in the image file metadata.  This does
> +#     not cause QEMU to reopen the image file to reparse the backing
> +#     filename (it may, however, perform a reopen to change
> +#     permissions from r/o -> r/w -> r/o, if needed).  The new backing
> +#     file string is written into the image file metadata, and the
> +#     QEMU internal strings are updated.

This is an example of a first paragraph I might flag for review if it
was a struct or union type.

>  #
>  # @image-node-name: The name of the block driver state node of the
>  #     image to modify.  The "device" argument is used to verify

[...]

> @@ -2746,11 +2700,10 @@
>  
>  ##
>  # @ThrottleLimits:
> -#
> -# Limit parameters for throttling.  Since some limit combinations are
> -# illegal, limits should always be set in one transaction.  All fields
> -# are optional.  When setting limits, if a field is missing the
> -# current value is not changed.
> +#     Limit parameters for throttling.  Since some limit combinations
> +#     are illegal, limits should always be set in one transaction.
> +#     All fields are optional.  When setting limits, if a field is
> +#     missing the current value is not changed.

The first sentence is clearly overview, but what would we want the
inliner to do with the remainder?

Looks like the inliner isn't going to do anything with it right now,
because ThrottleLimits is only used as member type.

>  #
>  # @iops-total: limit total I/O operations per second
>  #

[...]

> @@ -3548,12 +3486,11 @@
>  
>  ##
>  # @Qcow2OverlapCheckFlags:
> -#
> -# Structure of flags for each metadata structure.  Setting a field to
> -# 'true' makes QEMU guard that Qcow2 format structure against
> -# unintended overwriting.  See Qcow2 format specification for detailed
> -# information on these structures.  The default value is chosen
> -# according to the template given.
> +#     Structure of flags for each metadata structure.  Setting a field
> +#     to 'true' makes QEMU guard that Qcow2 format structure against
> +#     unintended overwriting.  See Qcow2 format specification for
> +#     detailed information on these structures.  The default value is
> +#     chosen according to the template given.
>  #
>  # @template: Specifies a template mode which can be adjusted using the
>  #     other flags, defaults to 'cached'

The first sentence is clearly overview, but what would we want the
inliner to do with the remainder?

Looks like the inliner isn't going to do anything with it right now,
because Qcow2OverlapCheckFlags is only used as member type.


[...]

> @@ -4550,9 +4460,8 @@
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

The first sentence is clearly overview, but what about the second?
"URLs" are actually member @url of base type BlockdevOptionsCurlBase.
What would we want the inliner to do with it?

BlockdevOptionsCurlBase is the base type of BlockdevOptionsCurlHttps and
a branch type of BlockdevOptions, where this will get inlined.

> @@ -4576,9 +4485,8 @@
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

Likewise.

> @@ -4591,9 +4499,8 @@
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

Likewise.

> @@ -4603,9 +4510,8 @@
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

Likewise.


[...]

> @@ -4735,14 +4637,13 @@
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

What would we want the inliner to do with this one?

BlockdevOptionsCbw is a branch type of BlockdevOptions, where this will
get inlined.

> @@ -4778,9 +4679,8 @@
>  
>  ##
>  # @BlockdevOptions:
> -#
> -# Options for creating a block device.  Many options are available for
> -# all block devices, independent of the block driver:
> +#     Options for creating a block device.  Many options are available
> +#     for all block devices, independent of the block driver:
>  #
>  # @driver: block driver name
>  #

What would we want the inliner to do with this one?

BlockdevOptions is used as argument of blockdev-add, where it will be
inlined.


[...]

> @@ -5587,9 +5465,8 @@
>  
>  ##
>  # @BlockdevAmendOptionsQcow2:
> -#
> -# Driver specific image amend options for qcow2.  For now, only
> -# encryption options can be amended
> +#     Driver specific image amend options for qcow2.  For now, only
> +#     encryption options can be amended
>  #
>  # @encrypt: Encryption options to be amended
>  #

What would we want the inliner to do with this one?

BlockdevAmendOptionsQcow2 is used as branch of BlockdevAmendOptions,
where it will be inlined.

[...]

I believe all the problematic first paragraphs consist of more than one
sentence.  What about splitting "trivial" into "very trivial" (just one
paragraph, no sentence-ending punctuation in the middle) and "hopefully
trivial" (just one paragraph, remainder)?

