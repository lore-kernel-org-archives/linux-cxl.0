Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA9E471D10
	for <linux-cxl@vger.kernel.org>; Thu,  3 Sep 2026 10:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788429853; cv=none; b=nuUKygngH1vKP5icBCyPUSyxvs5wQmUuo0oQwYKzw1Y95rtKEhG1F/c12TYLKmRRhLPkjimwKdjJZDkl5OOAvj9uyJ8348FfRhYmz2JyKLKN2riEaxIOabm5khh58cdWb3YMlObwvsZQGpvqJ+dkTHdFim+ZIT6H0xMOcpbSqoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788429853; c=relaxed/simple;
	bh=gdB4aDPcHnrT8svi12znDnIpqbHHU9JkNo6yjP6CSc4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k3MsqtN6t3STAMN45LeXi7Db6Ovl+aaxihyTbNaNQCH/BTdD/gD4x1CYKXnYyV1DePchbSO6YqGHidzwvQA55IVt/OwW8LkFi/Efm+eB/8aMGwnoCXwZaaXGdvi9R0YhVJbg+Faiq6WyLqmZZpMWFZTxNIQv9Qx0ZGBIkBPJs1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QM1oOp6l; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QM1oOp6l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788429846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BOx5UsBcpJ107C2izhbZpmNC0abVl9+Uxw26Tqjp5i8=;
	b=QM1oOp6lPingm83nv316qdZzQu+2VdeDKrSKZkiqWEVpjE3pKvdSh0IebwXMQp1enh1Rf4
	/tcdDU9azsKOPRqEZhMA8KLBbYk2c44xQ/U7ZTn6TFVomPems7iwaGNS4wcYKbCezPJxMz
	k4AJ+0uD+5Hluri+GDhAUuD1RENO3Fw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-615-d3WSQXZSPseAsWF0hiW_Hw-1; Thu,
 03 Sep 2026 06:04:02 -0400
X-MC-Unique: d3WSQXZSPseAsWF0hiW_Hw-1
X-Mimecast-MFC-AGG-ID: d3WSQXZSPseAsWF0hiW_Hw_1788429839
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 88B941964CEE;
	Thu,  3 Sep 2026 10:03:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E4D543000223;
	Thu,  3 Sep 2026 10:03:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 6713821E682E; Thu, 03 Sep 2026 12:03:52 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
  Lukas Straub <lukasstraub2@web.de>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  Richard Henderson
 <richard.henderson@linaro.org>,  zhenwei pi <zhenwei.pi@linux.dev>,
  Jonathan Cameron <jic23@kernel.org>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Stefan Hajnoczi <stefanha@redhat.com>,  Vladimir
 Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,  Jiri Pirko
 <jiri@resnulli.us>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>,
  qemu-block@nongnu.org,  Ani Sinha <anisinha@redhat.com>,  Jason Wang
 <jasowangio@gmail.com>,  linux-cxl@vger.kernel.org,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Igor Mammedov <imammedo@redhat.com>,  Hanna Reitz
 <hreitz@redhat.com>,  Alex Williamson <alex@shazbot.org>,  Stefan Berger
 <stefanb@linux.vnet.ibm.com>,  "Michael S. Tsirkin" <mst@redhat.com>,
  Laurent Vivier <laurent@vivier.eu>,  linux-edac@vger.kernel.org,  Michael
 Tokarev <mjt@tls.msk.ru>,  Fabiano Rosas <farosas@suse.de>,  Zhao Liu
 <zhao1.liu@intel.com>,  "Gonglei (Arei)" <arei.gonglei@huawei.com>,  Eric
 Blake <eblake@redhat.com>,  Peter Xu <peterx@redhat.com>,  Gerd Hoffmann
 <kraxel@redhat.com>,  Kevin Wolf <kwolf@redhat.com>,  Mauro Carvalho
 Chehab <mchehab+huawei@kernel.org>,  qemu-trivial@nongnu.org,
  =?utf-8?Q?C=C3=A9dric?= Le
 Goater <clg@redhat.com>
Subject: Re: [PATCH v4 00/43] qapi: convert (very) trivial intro sections
In-Reply-To: <CAFn=p-ZMj03qA0tvLU34FHLcwBJjU0c2q2Ex1p06FJfZpwyuJA@mail.gmail.com>
	(John Snow's message of "Wed, 2 Sep 2026 13:24:36 -0400")
References: <20260831201945.287730-1-jsnow@redhat.com>
	<871pbd9qpy.fsf@pond.sub.org>
	<CAFn=p-YBpsxy-3tr0SZ0CBfXUYnb6eg6AxNWpwUQmsuY5ZuykA@mail.gmail.com>
	<874ig7539j.fsf@pond.sub.org>
	<CAFn=p-ZMj03qA0tvLU34FHLcwBJjU0c2q2Ex1p06FJfZpwyuJA@mail.gmail.com>
Date: Thu, 03 Sep 2026 12:03:52 +0200
Message-ID: <874ig6y7lj.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: Yhb5daN4Iq6Ef94zboGrkxwQ-QMVF7Hjc8yRC-scLyE_1788429839
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

John Snow <jsnow@redhat.com> writes:

> On Wed, Sep 2, 2026 at 6:58=E2=80=AFAM Markus Armbruster <armbru@redhat.c=
om> wrote:
>>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > On Tue, Sep 1, 2026 at 7:05=E2=80=AFAM Markus Armbruster <armbru@redha=
t.com> wrote:
>> >>
>> >> Series
>> >> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>> >>
>> >
>> > Thank you for your suffering :)
>>
>> You're welcome; it's my job[*]!
>>
>> > So, I think there's actually no real problem in checking in a partial
>> > conversion as the infrastructure was coded specifically to allow it,
>> > however you're the maintainer so I will follow your lead. I'm more
>> > interested in moving forward than telling you how to do your job ;)
>> >
>> > The series will eventually enforce strict ordering, so there is no
>> > chance we will miss anything. If we send a PR now, we also don't have
>> > to keep rebasing the partial series against master. If you don't want
>> > to submit a PR, please create a branch I can track and submit patches
>> > against, and please periodically rebase it against origin/master.
>>
>> I worry a bit that having intros split about half between two styles
>> would cause confusion and friction.  I'd much prefer to get to >90%
>> fairly quickly.  If we think that's possible, I'm happy to queue up
>> things in my tree, and take care of the rebasing.
>
> Everything up until the "convert multi-paragraph intros" patch (#44 in
> my pending work) is approximately 87% of the total volume of
> conversions. In the most recent off-list mail I sent you, that's
> Sections 1-7 -- which is essentially all of the stuff that was
> factored out as "semi-trivial"/"simple", plus the "TODO" conversions.
> I believe these are pretty trivial to burn through, but would require
> a bit of dedicated time. We could probably do it in a week if we
> really pushed ...

Let's try!

> Existing volume of what you have reviewed and accepted is 55%.
>
> Well, either way, I just don't want to have to juggle so many patches
> in the interim, so I am pushing a bit to just merge it to make
> subsequent series easier to rebase and juggle so that e.g. I don't
> have to have increasingly long "based-on" tags.
>
> (Makes sad, pouting noises.)

I'm queuing up this series.

If the Based-on become too unwieldy for anyone involved, let me know.

>> [*] Some days my compensation is compensation for suffering ;)

