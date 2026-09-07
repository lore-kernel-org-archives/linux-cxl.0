Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B86337F8BA
	for <linux-cxl@vger.kernel.org>; Mon,  7 Sep 2026 05:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788759024; cv=none; b=q1CFTCJ1FvhGJZAk1yXMlcuxtD4Ib78ZxHOM+QMNMTkqAfde1mWJZaEDfDIqklVUEmjp18yM235aOF6IhktOYxj789iN+mvlio3X61ESD0XQvXZ+PyoxcTHkZbhpLV4EwdB+ODuOdVs5vlmPh970KBNVJakjwhzHRyZ8sdT2IrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788759024; c=relaxed/simple;
	bh=6ZDv3Om01XI+QkbEWENmYj++uCiBnmrdevOiv9w/LFs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IV9nx9xHmsNZ83N2J906W2e/dt3+PMfMyzq6KHC8BZEfGpIqcCP6uUmAteKXlo7jxrJ2qlS5y2nzclR6zdPTilcLxoAp2R97PQrjN6EkufcjQlpt329FQ8vGH0vrHh7Kyt2qxfs5xA2JxBpxZPiZQCvQyFKG5RYoJOqYr3MPXrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FSmSevZJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FSmSevZJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788759021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iLKyhCgZnS5leX/8OwC5gt17mIiInrIaiWDga2Lovt8=;
	b=FSmSevZJ8L47Nk7Ar+8UoT51zl1dL63rTq801TCVCzFsVg4ZvM2xA6ujoAIae2F03DB8b7
	OJ3P12QR1AoQz12jlng5LBoy3eSvciXzKtKX4DP3RI1rnQ/4HLNVUbFIlcKwm22fDoOivW
	N2KGEWUv/LTLUYt0MiDzTojS77Jaia4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-14-j-BNVtMuO1aGAgD59z9dIA-1; Mon,
 07 Sep 2026 01:30:17 -0400
X-MC-Unique: j-BNVtMuO1aGAgD59z9dIA-1
X-Mimecast-MFC-AGG-ID: j-BNVtMuO1aGAgD59z9dIA_1788759015
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2902719774E1;
	Mon,  7 Sep 2026 05:30:15 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 90A6E423;
	Mon,  7 Sep 2026 05:30:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 2922521E6A04; Mon, 07 Sep 2026 07:30:11 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  Hanna Reitz <hreitz@redhat.com>,
  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,  Ani Sinha
 <anisinha@redhat.com>,  Qemu-block <qemu-block@nongnu.org>,  Paolo Bonzini
 <pbonzini@redhat.com>,  linux-cxl@vger.kernel.org,  Jonathan Cameron
 <jic23@kernel.org>,  Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
  Kevin Wolf
 <kwolf@redhat.com>,  Lukas Straub <lukasstraub2@web.de>,  Fabiano Rosas
 <farosas@suse.de>,  Eric Blake <eblake@redhat.com>,  =?utf-8?Q?Marc-Andr?=
 =?utf-8?Q?=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Zhao Liu <zhao1.liu@intel.com>,  Peter Xu
 <peterx@redhat.com>
Subject: Re: [PATCH 12/12] qapi: convert simple command intros for
 block-core.json
In-Reply-To: <CAFn=p-bd1EOw8aQQn+CUSEWLTNz98MP5z77rAn3jt02bbRNYbA@mail.gmail.com>
	(John Snow's message of "Fri, 4 Sep 2026 12:45:05 -0400")
References: <20260901194324.458482-1-jsnow@redhat.com>
	<20260901194324.458482-13-jsnow@redhat.com>
	<87mrtyr1gz.fsf@pond.sub.org>
	<CAFn=p-bd1EOw8aQQn+CUSEWLTNz98MP5z77rAn3jt02bbRNYbA@mail.gmail.com>
Date: Mon, 07 Sep 2026 07:30:10 +0200
Message-ID: <877bkx1vdp.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: pQCr4W1FuLdDgod509boMu8JHZGpLIXGeMhEQaRXCGg_1788759015
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

John Snow <jsnow@redhat.com> writes:

> On Thu, Sep 3, 2026, 7:58=E2=80=AFAM Markus Armbruster <armbru@redhat.com=
> wrote:
>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > Signed-off-by: John Snow <jsnow@redhat.com>
>> > ---
>> >  qapi/block-core.json | 96 +++++++++++++++++++++----------------------=
-
>> >  1 file changed, 46 insertions(+), 50 deletions(-)
>> >
>> > diff --git a/qapi/block-core.json b/qapi/block-core.json
>> > index 33e1147792b..29f011dc209 100644
>> > --- a/qapi/block-core.json
>> > +++ b/qapi/block-core.json
>> > @@ -1816,12 +1816,12 @@
>> >
>> >  ##
>> >  # @change-backing-file:
>> > -#
>> > -# Change the backing file in the image file metadata.  This does not
>> > -# cause QEMU to reopen the image file to reparse the backing filename
>> > -# (it may, however, perform a reopen to change permissions from r/o -=
>
>> > -# r/w -> r/o, if needed).  The new backing file string is written int=
o
>> > -# the image file metadata, and the QEMU internal strings are updated.
>> > +#     Change the backing file in the image file metadata.  This does
>> > +#     not cause QEMU to reopen the image file to reparse the backing
>> > +#     filename (it may, however, perform a reopen to change
>> > +#     permissions from r/o -> r/w -> r/o, if needed).  The new backin=
g
>> > +#     file string is written into the image file metadata, and the
>> > +#     QEMU internal strings are updated.
>> >  #
>> >  # @image-node-name: The name of the block driver state node of the
>> >  #     image to modify.  The "device" argument is used to verify
>> > @@ -1957,12 +1957,12 @@
>> >
>> >  ##
>> >  # @drive-backup:
>> > -#
>> > -# Start a point-in-time copy of a block device to a new destination.
>> > -# The status of ongoing `drive-backup` operations can be checked with
>> > -# `query-block-jobs` where the `BlockJobInfo`.type field has the valu=
e
>> > -# 'backup'.  The operation can be stopped before it has completed
>> > -# using the `job-cancel` or `block-job-cancel` command.
>> > +#     Start a point-in-time copy of a block device to a new
>> > +#     destination.  The status of ongoing `drive-backup` operations
>> > +#     can be checked with `query-block-jobs` where the
>> > +#     `BlockJobInfo`.type field has the value 'backup'.  The operatio=
n
>> > +#     can be stopped before it has completed using the `job-cancel` o=
r
>> > +#     `block-job-cancel` command.
>> >  #
>> >  # Features:
>> >  #
>> > @@ -1988,12 +1988,12 @@
>> >
>> >  ##
>> >  # @blockdev-backup:
>> > -#
>> > -# Start a point-in-time copy of a block device to a new destination.
>> > -# The status of ongoing `blockdev-backup` operations can be checked
>> > -# with `query-block-jobs` where the `BlockJobInfo`.type field has the
>> > -# value 'backup'.  The operation can be stopped before it has
>> > -# completed using the `job-cancel` or `block-job-cancel` command.
>> > +#     Start a point-in-time copy of a block device to a new
>> > +#     destination.  The status of ongoing `blockdev-backup` operation=
s
>> > +#     can be checked with `query-block-jobs` where the
>> > +#     `BlockJobInfo`.type field has the value 'backup'.  The operatio=
n
>> > +#     can be stopped before it has completed using the `job-cancel` o=
r
>> > +#     `block-job-cancel` command.
>> >  #
>> >  # Errors:
>> >  #     - If @device is not a valid block device, DeviceNotFound
>> > @@ -2185,13 +2185,13 @@
>> >
>> >  ##
>> >  # @drive-mirror:
>> > -#
>> > -# Start mirroring a block device's writes to a new destination.
>> > -# target specifies the target of the new image.  If the file exists,
>> > -# or if it is a device, it will be used as the new destination for
>> > -# writes.  If it does not exist, a new file will be created.  @format
>> > -# specifies the format of the mirror image, default is to probe if
>> > -# mode=3D'existing', else the format of the source.
>> > +#     Start mirroring a block device's writes to a new destination.
>> > +#     target specifies the target of the new image.  If the file
>>
>> @target, I think.
>>
>> > +#     exists, or if it is a device, it will be used as the new
>> > +#     destination for writes.  If it does not exist, a new file will
>> > +#     be created.  @format specifies the format of the mirror image,
>> > +#     default is to probe if mode=3D'existing', else the format of th=
e
>>
>> @mode
>>
>> Where there are two, there are almost certainly more.
>>
>
> You reviewed the series, does this mean changes for later?

No.  My "leave that for another day" below applies.

>> > +#     source.
>>
>> Text that refers to arguments should probably go below the argument
>> descriptions.  I.e. this "intro" should probably be split.
>>
>> Let's leave that for another day, just take note of future work:
>>
>> 1. Add missing markup to argument / member / feature references.
>>
>> 2. Review and improve doc comments where the intro refers to arguments /
>> members / features.
>>
>> Not noting any of this again for this series.
>>
>
> OK.
>
>
>> >  #
>> >  # Errors:
>> >  #     - If @device is not a valid block device, GenericError
>> > @@ -2387,10 +2387,9 @@
>> >
>> >  ##
>> >  # @block-dirty-bitmap-remove:
>> > -#
>> > -# Stop write tracking and remove the dirty bitmap that was created
>> > -# with `block-dirty-bitmap-add`.  If the bitmap is persistent, remove
>> > -# it from its storage too.
>> > +#     Stop write tracking and remove the dirty bitmap that was create=
d
>> > +#     with `block-dirty-bitmap-add`.  If the bitmap is persistent,
>> > +#     remove it from its storage too.
>> >  #
>> >  # Errors:
>> >  #     - If @node is not a valid block device or node, DeviceNotFound
>> > @@ -4937,10 +4936,9 @@
>> >
>> >  ##
>> >  # @blockdev-del:
>> > -#
>> > -# Deletes a block device that has been added using `blockdev-add`.
>> > -# The command will fail if the node is attached to a device or is
>> > -# otherwise being used.
>> > +#     Deletes a block device that has been added using `blockdev-add`=
.
>> > +#     The command will fail if the node is attached to a device or is
>> > +#     otherwise being used.
>>
>> Perhaps the "will fail" part should be in an Errors: section.
>>
>> The intros above use imperative mode, this one doesn't.  Elsewhere in
>> this series, I even saw "Command to <do stuff>".
>>
>> More notes:
>>
>> 3. Review and improve doc comments where the intro talks about failure
>> modes.
>>
>> 4. Consistently use imperative mood for command intros.
>>
>> Not noting any of this again for this series.
>>
>
> Are you keeping a log of future changes, or should I write them down?

Both :)

My notes so far:

    Noted in review of intro conversions:

    1. Add missing markup to argument / member / feature references.

    2. Review and improve doc comments where the intro refers to arguments =
/
    members / features.

    3. Review and improve doc comments where the intro talks about failure
    modes.

    4. Consistently use imperative mood for command intros.

    5. Implement markup for non-local argument / member / feature
    references, and put it to use.

>> >  #
>> >  # @node-name: Name of the graph node to delete.
>> >  #
>>
>> [...]
>>
>>

