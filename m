Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CC143991B
	for <linux-cxl@vger.kernel.org>; Tue, 28 Jul 2026 14:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785247324; cv=none; b=WNP0v5HHBYrg+IhXw7OCcqxNiwiyarHBqhAGpgIid8XPbwizOOyyRj/7xDfCuT0aYnra0WYZdp+YDB3fkbLUuSTm1u8V996e9xYT6RZa1sRhTsxoT9S34lCGbjyXbdGU6ey+fIo/F7kxHDLB1rdmXhS6w5hypM7KfMWIDIk9U8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785247324; c=relaxed/simple;
	bh=uBxTWvPGhq5pVnvM4Y5z2Jar1dW3Hk+Ps+fxusSL1vk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QR0Qz5MaEojej25mHj3dbe6tDFUFDReXdDfiKAt7yih3CPK/wHBXnJXvwzIYOO4qCtcF0d/sFXWxKQFmbQgN4FQ/5+elYV26AHE4ImMFw0+eoTE9SpHUwDw0BIqqbqU2QUnlkwHDQ2n3WSsLeC5lwYN3pS/bVsboRQzbbgJyQ4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RxlOukUj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RxlOukUj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785247320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rGC8K64Yob8r2JvUgCNx/wrbN79uNJ24+jQ74+JG3cU=;
	b=RxlOukUjgIYVmRcpSK6e5osk9SNlc4Rhs5j/obcN9NDgjA+hMNaIdFqhhZIrdFretCH95s
	f6DspxEOeSIqiIh02y5Zcz9KwP2DqPbmmn94w7SAqqtRr4Iib5oHGpu0msTBccvVWXPNhi
	lyGlt4P5LitpViSxj+bp6OBh7Gu5ZAU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-435-m5lm208sPei4GLoitcWCsg-1; Tue,
 28 Jul 2026 10:01:55 -0400
X-MC-Unique: m5lm208sPei4GLoitcWCsg-1
X-Mimecast-MFC-AGG-ID: m5lm208sPei4GLoitcWCsg_1785247313
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DE54118001EE;
	Tue, 28 Jul 2026 14:01:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8EC9B180044F;
	Tue, 28 Jul 2026 14:01:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 388B921E6920; Tue, 28 Jul 2026 16:01:45 +0200 (CEST)
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
In-Reply-To: <CAFn=p-axhB-ezhfD2F8EoFhWT0h92d6oWP6Li1-JdhiXUGbsdA@mail.gmail.com>
	(John Snow's message of "Mon, 27 Jul 2026 13:20:09 -0400")
References: <20260723044805.527643-1-jsnow@redhat.com>
	<20260723044805.527643-45-jsnow@redhat.com>
	<87y0f0aikr.fsf@pond.sub.org>
	<CAFn=p-axhB-ezhfD2F8EoFhWT0h92d6oWP6Li1-JdhiXUGbsdA@mail.gmail.com>
Date: Tue, 28 Jul 2026 16:01:45 +0200
Message-ID: <87qzkntdpy.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: QtsS8KglTiOmpA_2nrfALJCGtr43I9CpHoL1EYQ87Iw_1785247313
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

John Snow <jsnow@redhat.com> writes:

> On Fri, Jul 24, 2026 at 4:38=E2=80=AFAM Markus Armbruster <armbru@redhat.=
com> wrote:

[...]

>> I believe all the problematic first paragraphs consist of more than one
>> sentence.  What about splitting "trivial" into "very trivial" (just one
>> paragraph, no sentence-ending punctuation in the middle) and "hopefully
>> trivial" (just one paragraph, remainder)?
>
> That's tricky to automate, and doing it by hand doesn't sound much fun
> either... can we just power through one-by-one?
>
> Unless you have a script or a trick you believe will help, and then I
> am happy to oblige.

By hand would clearly be a bad use of your time.

I'll look into automating it.

