Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684E343786A
	for <linux-cxl@vger.kernel.org>; Tue, 28 Jul 2026 14:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785247435; cv=none; b=SmzCeSE3n7Z5rsdBzKfhwmk1TrAss2G2zsgu+o8hzzMwM0+nKapKtXoJ/WTKFBYFMNtrry0wKJjxEkt7JU/b2O+enUIQdYLBLjKxDxIGlgMgtppD8uGfcDoEo979WKzap0PRSAL28ZaVt9prM9qcLxpbTCe+pdk3aV0D7lLtm3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785247435; c=relaxed/simple;
	bh=+9H1qAywL1I8PXhl7hj6NlwA057hjwZ5cOP+S1R+Mho=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=L+d8ua7vTbK369kgrkbGcF2bnwaUMHmMo0M4yvi+iMJMRi6kcQDaRihxkuc/00WDp7S1kmO9XMV+BuxoLgWmSzozwQvCn0J1uQ0VG1ITxinBeUa+Q7+dXuwwuS3h25jSsJ9OoeW4L7JggIWv9utABy1vTHhlYGS/K8Da4DoXkl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DZzSKQwK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DZzSKQwK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785247433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZTcUYJR3ZkqlI+K293x1cuKvm9R4enTMB4xoVxh0vgg=;
	b=DZzSKQwK7cLvv7YllKj0UMEUjvbWnfSANycVRz03/elm1OZ8Sf1nCNhIYY8Z+F01xj02dR
	czhJ+rIraqGW/+9RxwwsSNb/gf4Jz4X/uvDw8yzRsFG5ZTasEvK0fp9/jRCPqqdfX5i26d
	aorHMPpBzRWvfolmipfeFxHt2q7aJd8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-269-JnQILyFeNDG833Mv4P6lVw-1; Tue,
 28 Jul 2026 10:03:47 -0400
X-MC-Unique: JnQILyFeNDG833Mv4P6lVw-1
X-Mimecast-MFC-AGG-ID: JnQILyFeNDG833Mv4P6lVw_1785247423
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CE94019560BE;
	Tue, 28 Jul 2026 14:03:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D4DF21800480;
	Tue, 28 Jul 2026 14:03:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 6D74D21E6920; Tue, 28 Jul 2026 16:03:38 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,  qemu-devel@nongnu.org,  Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,  Lukas Straub
 <lukasstraub2@web.de>,
  Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,  Zhao Liu
 <zhao1.liu@intel.com>,  Laurent Vivier <laurent@vivier.eu>,  "Gonglei
 (Arei)" <arei.gonglei@huawei.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>,  Alex Williamson <alex@shazbot.org>,  zhenwei pi
 <zhenwei.pi@linux.dev>,  Hanna Reitz <hreitz@redhat.com>,  Ani Sinha
 <anisinha@redhat.com>,  qemu-block@nongnu.org,  Paolo Bonzini
 <pbonzini@redhat.com>,  Peter Xu <peterx@redhat.com>,  Kevin Wolf
 <kwolf@redhat.com>,  linux-cxl@vger.kernel.org,  Jiri Pirko
 <jiri@resnulli.us>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Stefan
 Berger <stefanb@linux.vnet.ibm.com>,  Fabiano Rosas <farosas@suse.de>,
  Stefan Hajnoczi <stefanha@redhat.com>,  Michael Tokarev <mjt@tls.msk.ru>,
  Igor Mammedov <imammedo@redhat.com>,  "Michael S. Tsirkin"
 <mst@redhat.com>,  Gerd Hoffmann <kraxel@redhat.com>,  Mauro Carvalho
 Chehab <mchehab+huawei@kernel.org>,  linux-edac@vger.kernel.org,
  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,  Richard
 Henderson
 <richard.henderson@linaro.org>,  Eric Blake <eblake@redhat.com>,
  =?utf-8?Q?C=C3=A9dric?=
 Le Goater <clg@redhat.com>,  Jason Wang <jasowangio@gmail.com>,
  qemu-trivial@nongnu.org,  Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v2 00/44] qapi: convert trivial intro sections
In-Reply-To: <CAFn=p-Z0Ys6FoUqRPY7d5CaN4YfHE4DUN6VLtMeWRJgUk3Khkg@mail.gmail.com>
	(John Snow's message of "Mon, 27 Jul 2026 13:16:13 -0400")
References: <20260723044805.527643-1-jsnow@redhat.com>
	<87ik65g8xm.fsf@pond.sub.org> <87h5lobypc.fsf@pond.sub.org>
	<CAFn=p-Z0Ys6FoUqRPY7d5CaN4YfHE4DUN6VLtMeWRJgUk3Khkg@mail.gmail.com>
Date: Tue, 28 Jul 2026 16:03:38 +0200
Message-ID: <87mrvbtdmt.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: Xo4O7g5uadh7Ay7ef8A1DM13kKH7xNydMBbvZx76WHQ_1785247423
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

John Snow <jsnow@redhat.com> writes:

> On Fri, Jul 24, 2026 at 4:04=E2=80=AFAM Markus Armbruster <armbru@redhat.=
com> wrote:
>>
>> Markus Armbruster <armbru@redhat.com> writes:
>>
>> [...]
>>
>> > Converting single first paragraps is mechanical.  For it to be correct=
,
>> > this single paragraph must actually be the overview, and not some othe=
r
>> > crap.  I expect it to be almost always overview.  Not sure how to best
>> > look for the exceptions.
>>
>> The separation truly matters only when the inliner inlines the doc
>> comment.  It potentially matters when it would inline it if the type was
>> used differently.
>
> It also (potentially) matters for auto-generated docs, such as
> undocumented members, return types, features*, errors*. The break
> point is where these fields get inserted.

Right, I forgot about this.  There goes my review shortcut...

> (*Not currently performed. Not asserting that it will be performed, or
> that it is necessarily valuable to do so. Just fleshing out the
> category.)
>
>>
>> If I remember correctly, the inliner inlines doc of struct / union base
>> type, union branch type, command / event argument type.
>>
>> Argument can only be struct or union.  Base and branch can only be
>> struct.
>>
>> We talked about maybe inlining return types some day.  This would be
>> struct, union, or array of struct or union.
>>
>> So, for anything other than struct and union, the inliner doesn't get
>> involved, and separating the overview cleanly is just a matter of
>> writing style.  I'm not sure we care.  Even if we elect to care,
>> cleaning it up is hardly this series' business.  In short, your
>> mechanical conversion of single first paragraphs to overview syntax
>> should be fine even where a paragraph's contents isn't clearly overview.
>
> Except in cases where stub positioning matters, see also the former
> "TODO:" syntax used to delineate intro/details.
>
>>
>> Structs and unions, however, could use an eye-over.
>>
>> [...]
>>

