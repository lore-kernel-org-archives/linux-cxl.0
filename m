Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8DB43148E
	for <linux-cxl@vger.kernel.org>; Mon, 27 Jul 2026 17:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785172841; cv=none; b=apKTIiy9NqDb4TIK1JZ4GhbEP6Q8ww6Y35kHQKA3kQsd9sfvkT7ect6Jt5i2zwQ3OjoOhdMH/Myv6Ew31PvoQtTzlxSQmZ/Q7aT6XKU+Sn+jRgvjtz0VDC3QtumNADHQrtbvGKuW0ExVuh29iAjW5U/bgkxRUWnnH2h0TifpW8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785172841; c=relaxed/simple;
	bh=MbGhLaPtnlkcDFHbeJnQLCOxp+QpCvfPQkf5eXQ9u3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rJhkIuAmm4qKTLsynFLxcvbjCbTGzrt6vqKCEH4mA+4OPdZArcx723rs7rIvH+xx/XreRFyaG2BOo4s5D0Hf8KUVYqdHw4CaUP01zuYZ7JtyBIZi77Xhuqq3ZDHe50sciDOtrBajwmhNGe87NPkQh/Iug/mJWarOdMYbKCFG+ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BVNA5RIc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BVNA5RIc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785172825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u6afx08wKd6RvWFzCzuO54Zssef71NPh6fis+puWjoE=;
	b=BVNA5RIcG3x8rWreo8/D2Re7VV7qtMZ6gjs4VuRNNR8mSBiplut1BxZjHnwSMUFBUgkQVt
	IkWZynSgL6FWq0kiAXV3YftPgtUTwmr2jetzNdX73XFVRF78q8jNh/8X0pXd9XVPC80lv+
	tJHmDfvPmhX53lulrYKdbjRWQKvLXnk=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-NA-Lk4LtNTyDUpk3hPQTfA-1; Mon, 27 Jul 2026 13:20:21 -0400
X-MC-Unique: NA-Lk4LtNTyDUpk3hPQTfA-1
X-Mimecast-MFC-AGG-ID: NA-Lk4LtNTyDUpk3hPQTfA_1785172821
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-668a55b1809so4818813d50.3
        for <linux-cxl@vger.kernel.org>; Mon, 27 Jul 2026 10:20:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785172821; x=1785777621;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u6afx08wKd6RvWFzCzuO54Zssef71NPh6fis+puWjoE=;
        b=kF+Phc7TN5PnnBZ7UrWduqmJgqCTrHUpG3j4nIZ53CLoCUwO9GcEsDbcJK/Crijf6C
         OgeCVXr3oRLiupaSqZBOBXfM5kZDIXSE6xiGLS//81UFcrba9Wr4og4eib0Mlu6TWsNn
         tQFNjbbiFOHxVT5LxN/gI2XHkDPahcMeh/Q6Ykwc02Ya6UimSMJUG0iOySERRm0Lhi2G
         usHskV85PF3Y0/c+v/dySubUySstubLcsXRJ1DilfdxXzGs818hsb5PqPv2FIFU8p/jW
         0VDuLOjrk+PxAagNfQv/s4Y/foKB8oF+5Dnb2qA6pUIOMRL67XNM2H43vL0nIvi+sJuM
         pVgA==
X-Forwarded-Encrypted: i=1; AHgh+Rrdkk4nnWU8VtECtcuMLwMgC9eP09zBr7XS/I2UMDZJ+c7R0G8x09FJFb5MdOyWcg4V8p/yZvtvcSk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+7W5RmpOImG7PlXIJL1GYR7f42UsFQE+A3IUCBOsv9WCXAu1u
	OzDTL3FxnonYU03y3ps8Rq40kPxTEenn/sCVHMonSawnKpUT6COvt3ZhPZR7tZsHiZhvgmWoGne
	Zdradu59X0Z/KXvkA+WXAa1wloIWjlP+7lyJ2X2Uktzqqx0VdfpuO/JX8nmCU/P0phH2fZvrvpl
	aIe1sAwh1GJa7hU0y3Src/j4vC8rE7pSgToKLZ
X-Gm-Gg: AR+sD12naTM/+ua5OW/Z9co9VjFjFh/pIAhWrmCPYsMQErxtM5+AxHz8zg0+oD1gz5Q
	YsOTrGCYzdMEvic+W+jQxu9ioER9dG1ba+Y41daA2PR/Q9xKJ40CuiWRAfBMKT6JqKLHUHZAgao
	J/BHafE5nRFo7ewLuzEUaq9j0c4o8smjRm0LgSW3dFsSE6fYt69EhTQUWL1S8+i3RtOG2VFLpSf
	6OFZpwo+QRcs7mk
X-Received: by 2002:a53:cac1:0:b0:667:d5e0:1c69 with SMTP id 956f58d0204a3-668c7a13057mr1982216d50.31.1785172821141;
        Mon, 27 Jul 2026 10:20:21 -0700 (PDT)
X-Received: by 2002:a53:cac1:0:b0:667:d5e0:1c69 with SMTP id
 956f58d0204a3-668c7a13057mr1982197d50.31.1785172820614; Mon, 27 Jul 2026
 10:20:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723044805.527643-1-jsnow@redhat.com> <20260723044805.527643-45-jsnow@redhat.com>
 <87y0f0aikr.fsf@pond.sub.org>
In-Reply-To: <87y0f0aikr.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Mon, 27 Jul 2026 13:20:09 -0400
X-Gm-Features: AUfX_mz_Ii50MiumBfvXVZr6OIQ9ljsx38tHDtxPXG0jyiKi4V8B_BK1TGjrT7g
Message-ID: <CAFn=p-axhB-ezhfD2F8EoFhWT0h92d6oWP6Li1-JdhiXUGbsdA@mail.gmail.com>
Subject: Re: [PATCH v2 44/44] qapi: convert trivial intro sections for block-core.json
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
	Lukas Straub <lukasstraub2@web.de>, 
	Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, Zhao Liu <zhao1.liu@intel.com>, 
	Laurent Vivier <laurent@vivier.eu>, "Gonglei (Arei)" <arei.gonglei@huawei.com>, 
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
	Alex Williamson <alex@shazbot.org>, zhenwei pi <zhenwei.pi@linux.dev>, Hanna Reitz <hreitz@redhat.com>, 
	Ani Sinha <anisinha@redhat.com>, qemu-block@nongnu.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
	linux-cxl@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	=?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
	Stefan Berger <stefanb@linux.vnet.ibm.com>, Fabiano Rosas <farosas@suse.de>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, 
	Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, linux-edac@vger.kernel.org, 
	=?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
	Richard Henderson <richard.henderson@linaro.org>, Eric Blake <eblake@redhat.com>, 
	=?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
	Jason Wang <jasowangio@gmail.com>, qemu-trivial@nongnu.org, 
	Jonathan Cameron <jic23@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CFSEkLUy9Uyrztx9oyRSy5VvhhACJvmOEv8I23qJtGo_1785172821
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 4:38=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> John Snow <jsnow@redhat.com> writes:
>
> > (Trivial)
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  qapi/block-core.json | 646 +++++++++++++++++--------------------------
> >  1 file changed, 255 insertions(+), 391 deletions(-)
> >
> > diff --git a/qapi/block-core.json b/qapi/block-core.json
> > index 1f87b078505..bd98af2f298 100644
> > --- a/qapi/block-core.json
> > +++ b/qapi/block-core.json
>
> [...]
>
> > @@ -422,10 +417,9 @@
> >
> >  ##
> >  # @BlockGraphInfo:
> > -#
> > -# Information about all nodes in a block (sub)graph in the form of
> > -# `BlockNodeInfo` data.  The base `BlockNodeInfo` struct contains the
> > -# information for the (sub)graph's root node.
> > +#     Information about all nodes in a block (sub)graph in the form of
> > +#     `BlockNodeInfo` data.  The base `BlockNodeInfo` struct contains
> > +#     the information for the (sub)graph's root node.
> >  #
> >  # @children: Array of links to this node's child nodes' information
> >  #
>
> The first sentence is clearly overview, but the second caught my eye.
> What would we want the inliner to do with it?
>
> Looks like the inliner isn't going to do anything with it right now,
> because BlockGraphInfo is only used as member type.
>
> [...]
>
> > @@ -1378,10 +1355,9 @@
> >
> >  ##
> >  # @BlockdevOnError:
> > -#
> > -# An enumeration of possible behaviors for errors on I/O operations.
> > -# The exact meaning depends on whether the I/O was initiated by a
> > -# guest or by a block job
> > +#     An enumeration of possible behaviors for errors on I/O
> > +#     operations.  The exact meaning depends on whether the I/O was
> > +#     initiated by a guest or by a block job
> >  #
> >  # @report: for guest operations, report the error to the guest; for
> >  #     jobs, cancel the job
>
> The first sentence is clearly overview, but the second caught my eye.
>
> Because this is an enum type, and we're not going to inline these, we
> can leave it as is.
>
> [...]
>
> > @@ -1636,9 +1605,8 @@
> >
> >  ##
> >  # @BackupPerf:
> > -#
> > -# Optional parameters for backup.  These parameters don't affect
> > -# functionality, but may significantly affect performance.
> > +#     Optional parameters for backup.  These parameters don't affect
> > +#     functionality, but may significantly affect performance.
>
> The first sentence is clearly overview.  What would we want the inliner
> to do with the second?
>
> Looks like the inliner isn't going to do anything with it right now,
> because BackupPerf is only used as member type.
>
> Aside: this only user BackupCommon member x-perf has been @unstable for
> more than five years.  That's a long time to sit on a fence.
>
> >  #
> >  # @use-copy-range: Use copy offloading.  Default false.
> >  #
>
> [...]
>
> > @@ -1845,12 +1812,12 @@
> >
> >  ##
> >  # @change-backing-file:
> > -#
> > -# Change the backing file in the image file metadata.  This does not
> > -# cause QEMU to reopen the image file to reparse the backing filename
> > -# (it may, however, perform a reopen to change permissions from r/o ->
> > -# r/w -> r/o, if needed).  The new backing file string is written into
> > -# the image file metadata, and the QEMU internal strings are updated.
> > +#     Change the backing file in the image file metadata.  This does
> > +#     not cause QEMU to reopen the image file to reparse the backing
> > +#     filename (it may, however, perform a reopen to change
> > +#     permissions from r/o -> r/w -> r/o, if needed).  The new backing
> > +#     file string is written into the image file metadata, and the
> > +#     QEMU internal strings are updated.
>
> This is an example of a first paragraph I might flag for review if it
> was a struct or union type.
>
> >  #
> >  # @image-node-name: The name of the block driver state node of the
> >  #     image to modify.  The "device" argument is used to verify
>
> [...]
>
> > @@ -2746,11 +2700,10 @@
> >
> >  ##
> >  # @ThrottleLimits:
> > -#
> > -# Limit parameters for throttling.  Since some limit combinations are
> > -# illegal, limits should always be set in one transaction.  All fields
> > -# are optional.  When setting limits, if a field is missing the
> > -# current value is not changed.
> > +#     Limit parameters for throttling.  Since some limit combinations
> > +#     are illegal, limits should always be set in one transaction.
> > +#     All fields are optional.  When setting limits, if a field is
> > +#     missing the current value is not changed.
>
> The first sentence is clearly overview, but what would we want the
> inliner to do with the remainder?
>
> Looks like the inliner isn't going to do anything with it right now,
> because ThrottleLimits is only used as member type.
>
> >  #
> >  # @iops-total: limit total I/O operations per second
> >  #
>
> [...]
>
> > @@ -3548,12 +3486,11 @@
> >
> >  ##
> >  # @Qcow2OverlapCheckFlags:
> > -#
> > -# Structure of flags for each metadata structure.  Setting a field to
> > -# 'true' makes QEMU guard that Qcow2 format structure against
> > -# unintended overwriting.  See Qcow2 format specification for detailed
> > -# information on these structures.  The default value is chosen
> > -# according to the template given.
> > +#     Structure of flags for each metadata structure.  Setting a field
> > +#     to 'true' makes QEMU guard that Qcow2 format structure against
> > +#     unintended overwriting.  See Qcow2 format specification for
> > +#     detailed information on these structures.  The default value is
> > +#     chosen according to the template given.
> >  #
> >  # @template: Specifies a template mode which can be adjusted using the
> >  #     other flags, defaults to 'cached'
>
> The first sentence is clearly overview, but what would we want the
> inliner to do with the remainder?
>
> Looks like the inliner isn't going to do anything with it right now,
> because Qcow2OverlapCheckFlags is only used as member type.
>
>
> [...]
>
> > @@ -4550,9 +4460,8 @@
> >
> >  ##
> >  # @BlockdevOptionsCurlHttp:
> > -#
> > -# Driver specific block device options for HTTP connections over the
> > -# curl backend.  URLs must start with "http://".
> > +#     Driver specific block device options for HTTP connections over
> > +#     the curl backend.  URLs must start with "http://".
> >  #
> >  # @cookie: List of cookies to set; format is "name1=3Dcontent1;
> >  #     name2=3Dcontent2;" as explained by CURLOPT_COOKIE(3).  Defaults =
to
>
> The first sentence is clearly overview, but what about the second?
> "URLs" are actually member @url of base type BlockdevOptionsCurlBase.
> What would we want the inliner to do with it?
>
> BlockdevOptionsCurlBase is the base type of BlockdevOptionsCurlHttps and
> a branch type of BlockdevOptions, where this will get inlined.
>
> > @@ -4576,9 +4485,8 @@
> >
> >  ##
> >  # @BlockdevOptionsCurlHttps:
> > -#
> > -# Driver specific block device options for HTTPS connections over the
> > -# curl backend.  URLs must start with "https://".
> > +#     Driver specific block device options for HTTPS connections over
> > +#     the curl backend.  URLs must start with "https://".
> >  #
> >  # @sslverify: Whether to verify the SSL certificate's validity
> >  #     (defaults to true)
>
> Likewise.
>
> > @@ -4591,9 +4499,8 @@
> >
> >  ##
> >  # @BlockdevOptionsCurlFtp:
> > -#
> > -# Driver specific block device options for FTP connections over the
> > -# curl backend.  URLs must start with "ftp://".
> > +#     Driver specific block device options for FTP connections over
> > +#     the curl backend.  URLs must start with "ftp://".
> >  #
> >  # Since: 2.9
> >  ##
>
> Likewise.
>
> > @@ -4603,9 +4510,8 @@
> >
> >  ##
> >  # @BlockdevOptionsCurlFtps:
> > -#
> > -# Driver specific block device options for FTPS connections over the
> > -# curl backend.  URLs must start with "ftps://".
> > +#     Driver specific block device options for FTPS connections over
> > +#     the curl backend.  URLs must start with "ftps://".
> >  #
> >  # @sslverify: Whether to verify the SSL certificate's validity
> >  #     (defaults to true)
>
> Likewise.
>
>
> [...]
>
> > @@ -4735,14 +4637,13 @@
> >
> >  ##
> >  # @BlockdevOptionsCbw:
> > -#
> > -# Driver specific block device options for the copy-before-write
> > -# driver, which does so called copy-before-write operations: when data
> > -# is written to the filter, the filter first reads corresponding
> > -# blocks from its file child and copies them to @target child.  After
> > -# successfully copying, the write request is propagated to file child.
> > -# If copying fails, the original write request is failed too and no
> > -# data is written to file child.
> > +#     Driver specific block device options for the copy-before-write
> > +#     driver, which does so called copy-before-write operations: when
> > +#     data is written to the filter, the filter first reads
> > +#     corresponding blocks from its file child and copies them to
> > +#     @target child.  After successfully copying, the write request is
> > +#     propagated to file child.  If copying fails, the original write
> > +#     request is failed too and no data is written to file child.
> >  #
> >  # @target: The target for copy-before-write operations.
> >  #
>
> What would we want the inliner to do with this one?
>
> BlockdevOptionsCbw is a branch type of BlockdevOptions, where this will
> get inlined.
>
> > @@ -4778,9 +4679,8 @@
> >
> >  ##
> >  # @BlockdevOptions:
> > -#
> > -# Options for creating a block device.  Many options are available for
> > -# all block devices, independent of the block driver:
> > +#     Options for creating a block device.  Many options are available
> > +#     for all block devices, independent of the block driver:
> >  #
> >  # @driver: block driver name
> >  #
>
> What would we want the inliner to do with this one?
>
> BlockdevOptions is used as argument of blockdev-add, where it will be
> inlined.
>
>
> [...]
>
> > @@ -5587,9 +5465,8 @@
> >
> >  ##
> >  # @BlockdevAmendOptionsQcow2:
> > -#
> > -# Driver specific image amend options for qcow2.  For now, only
> > -# encryption options can be amended
> > +#     Driver specific image amend options for qcow2.  For now, only
> > +#     encryption options can be amended
> >  #
> >  # @encrypt: Encryption options to be amended
> >  #
>
> What would we want the inliner to do with this one?
>
> BlockdevAmendOptionsQcow2 is used as branch of BlockdevAmendOptions,
> where it will be inlined.
>
> [...]
>
> I believe all the problematic first paragraphs consist of more than one
> sentence.  What about splitting "trivial" into "very trivial" (just one
> paragraph, no sentence-ending punctuation in the middle) and "hopefully
> trivial" (just one paragraph, remainder)?

That's tricky to automate, and doing it by hand doesn't sound much fun
either... can we just power through one-by-one?

Unless you have a script or a trick you believe will help, and then I
am happy to oblige.

