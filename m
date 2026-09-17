Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7165854706C
	for <linux-cxl@vger.kernel.org>; Thu, 17 Sep 2026 18:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789671117; cv=none; b=UEX9kvGyaD+vp2r1la5tM0IsBt0EF3W+y+Jjl2f5DMGp37Qcyod1xhKNIky6US7TKlivoFckh7nkWSHnoJGyVKKxfWaHJIhBNAMTdcqoCb7HCIe3YHBCiYR5lFbWjbwewSmuznBzzOsyJ4Ndry4TTQvoqzn58f60/tXBYcvr3nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789671117; c=relaxed/simple;
	bh=ZUFRAK4hzgQhZU0Q8jUvVKfNF0cAM1JNvUHWVMm1YGg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KqTyPdHHYqg3QuXYvtmfcfLx7cBvJViRA/edverfWCIwYzyGw3Pr4gUg/FngzMHRF43Fgg4XiQqlI68Xnn7rCh16EDsRjexOEvN4obcTtO1zGHn7lSgX7KGIlnWMmNS/XRTlrt8eq4P7WFm2aqKb2yvcNc6JfB7eD4tQMkIZxn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jKqUPKJG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jKqUPKJG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789671114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FxBbXNM4cRzWRyxM/CvJcZ+dcO+Bk3VgtUkJsWvgt5k=;
	b=jKqUPKJGj8j15MhrcRAzLREslcQqWFYhK1JtNyd2sls4djCw6tJhtNZKUtKslKxX7uuZ6Z
	UDcovMoRYExZQJerzCJXSY7nZ1ddx0YssKtGwG1392usxUllI0GGa+ZwAGbl0hdz8oe4//
	WAi+LWugWXOqTFJDp4oSE7oRg9m8Zz8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-84-IbHGdlh-MEqZV6G03_UWdw-1; Thu,
 17 Sep 2026 14:51:50 -0400
X-MC-Unique: IbHGdlh-MEqZV6G03_UWdw-1
X-Mimecast-MFC-AGG-ID: IbHGdlh-MEqZV6G03_UWdw_1789671109
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D970A1912C4C;
	Thu, 17 Sep 2026 18:51:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E2DB530001A2;
	Thu, 17 Sep 2026 18:51:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 7A32021E6A04; Thu, 17 Sep 2026 20:51:45 +0200 (CEST)
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
In-Reply-To: <CAFn=p-YbywppYTRUj9K9ncrue8b9NTgqXtcjWzMYiiJwTgYCpA@mail.gmail.com>
	(John Snow's message of "Thu, 17 Sep 2026 13:50:59 -0400")
References: <20260916135841.3614495-1-jsnow@redhat.com>
	<20260916135841.3614495-8-jsnow@redhat.com>
	<877bkl6p5s.fsf@pond.sub.org>
	<CAFn=p-YbywppYTRUj9K9ncrue8b9NTgqXtcjWzMYiiJwTgYCpA@mail.gmail.com>
Date: Thu, 17 Sep 2026 20:51:45 +0200
Message-ID: <87ld8zr9ry.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: mwGcTHahUV16O9Fe2uUWG5ydaXdWXxiYTyXC2TZ9IsY_1789671109
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

John Snow <jsnow@redhat.com> writes:

> On Wed, Sep 16, 2026 at 2:13=E2=80=AFPM Markus Armbruster <armbru@redhat.=
com> wrote:
>>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > These provide a rather natural cutoff point, but technically this does
>> > introduce a new intro/details split to these documentation blocks.
>>
>> Not sure what you mean by "technically".
>
> As a German, when an American says "technically", you can just omit
> that word from the sentence.
> I think, translating for you: "I don't expect these changes to have
> any immediate effect, but it's possible they might".
> You found the case where they might - a case where we probably
> actually did want a "TODO:" but never added it.
>
>>
>> >
>> > Signed-off-by: John Snow <jsnow@redhat.com>
>> > ---
>> >  qapi/machine.json   |  5 ++---
>> >  qapi/migration.json | 15 +++++++--------
>> >  qapi/misc.json      |  3 +--
>> >  qapi/run-state.json |  7 +++----
>> >  4 files changed, 13 insertions(+), 17 deletions(-)
>> >
>> > diff --git a/qapi/machine.json b/qapi/machine.json
>> > index 84d95c8d87f..276258d9e5c 100644
>> > --- a/qapi/machine.json
>> > +++ b/qapi/machine.json
>> > @@ -1209,9 +1209,8 @@
>> >
>> >  ##
>> >  # @HV_BALLOON_STATUS_REPORT:
>> > -#
>> > -# Emitted when the hv-balloon driver receives a "STATUS" message from
>> > -# the guest.
>> > +#     Emitted when the hv-balloon driver receives a "STATUS" message
>> > +#     from the guest.
>> >  #
>> >  # .. note:: This event is rate-limited.
>> >  #
>>    # Since: 8.2
>>
>> The patch splits the first section between after the first paragraph,
>> i.e. before the note.
>>
>> This matters, because we insert generated argument documentation after
>> the first section.  Rendered documentation changes like this
>>
>>     Emitted when the hv-balloon driver receives a "STATUS" message from
>>     the guest.
>>
>> +   Members:
>> +      * The members of "HvBalloonInfo".
>> +
>>     Note:
>>
>>       This event is rate-limited.
>>
>> -   Members:
>> -      * The members of "HvBalloonInfo".
>> -
>>     Example::
>>
>>        <- { "event": "HV_BALLOON_STATUS_REPORT",

Improvement, actually.

>> > diff --git a/qapi/migration.json b/qapi/migration.json
>> > index d571c06fc20..a272e701385 100644
>> > --- a/qapi/migration.json
>> > +++ b/qapi/migration.json
>> > @@ -1254,10 +1254,10 @@
>> >
>> >  ##
>> >  # @migrate_cancel:
>> > -#
>> > -# Cancel the currently executing migration process.  Allows a new
>> > -# migration to be started right after.  When postcopy-ram is in use,
>> > -# cancelling is not allowed after the postcopy phase has started.
>> > +#     Cancel the currently executing migration process.  Allows a new
>> > +#     migration to be started right after.  When postcopy-ram is in
>> > +#     use, cancelling is not allowed after the postcopy phase has
>> > +#     started.
>> >  #
>> >  # .. note:: This command succeeds even if there is no migration
>> >  #    process running.
>>
>> Similar split, but rendered documentation doesn't change, because
>> nothing gets inserted.
>>
>> Same for the remaining hunks.
>>
>> Should the one hunk that changes rendered documentation be in the "qapi:
>> convert/split remaining QAPI/QMP intro sections" series?
>
> If you should so please. I was splitting by semantics and not effect,
> but I can split this one out for you.

It's an honest question!

If you think it fits here at least as well as in the next series, keep
it here, and mention how it affects rendered documentation in the commit
message.

>
>>
>> [...]
>>

