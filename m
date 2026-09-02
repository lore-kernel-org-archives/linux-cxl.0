Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D26471D13
	for <linux-cxl@vger.kernel.org>; Wed,  2 Sep 2026 10:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788346696; cv=none; b=Pwn1OuBEDVLtFnFtmC9UAZKeocNYVcvSucgq1SbF04ZDmRNhwMHy9S65746qAVf1TqmrNouj3FVGZ2BzoRSyOyjKTkYaJ3qZNT9DsIxrd88mmQZAUBj6eFQ93lZiZDaQOWJngIKJqiTwH5zht+Y02blT1PRnM+JiimOs2heL38M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788346696; c=relaxed/simple;
	bh=kNCeF8+9GvqHUa3SAWM80y7gQXpjhYweKCS2WBd5mnE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gXFRGjyXS4ofFmcmD8EahFgC/lL3BGY/yJ5DS1PR/pE8OeW1iawsoJd96hIKKOav0Tky7DtLXoCcql/DpYWI/rLfK4mVnKjlBolWqDFuAXlKUFvfOn87g6N06wtOKbWAHOT+6kpfJ4ke2e6NDp6q8TT9lghI/nBu59Y02KYzjT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hGG+hdji; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hGG+hdji"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788346693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7+UEKLtsaCzDnBKoVmouTtNhyD+702Q9U72xApd5tiU=;
	b=hGG+hdjiJH/29gAu9wW6C1WrKjCMnFFdrUCBS2CQilsve83VB/IHLHJT3QYzRBz406QF4x
	AhwrRL+Zke1HurqL5MudX2fQrmIdpgovyxX67NPA5eCYikVZcWhTTHonqhaXJTRLHcaORz
	IchbgQsA0kwpTd84klzVg45T16TVf+Y=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-27-Q6nYtSvfOam0ZIwu0RxKew-1; Wed,
 02 Sept 2026 06:58:10 -0400
X-MC-Unique: Q6nYtSvfOam0ZIwu0RxKew-1
X-Mimecast-MFC-AGG-ID: Q6nYtSvfOam0ZIwu0RxKew_1788346687
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AEDA81800A30;
	Wed,  2 Sep 2026 10:58:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 841C31800577;
	Wed,  2 Sep 2026 10:58:02 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 1383721E682B; Wed, 02 Sep 2026 12:58:00 +0200 (CEST)
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
In-Reply-To: <CAFn=p-YBpsxy-3tr0SZ0CBfXUYnb6eg6AxNWpwUQmsuY5ZuykA@mail.gmail.com>
	(John Snow's message of "Tue, 1 Sep 2026 13:01:49 -0400")
References: <20260831201945.287730-1-jsnow@redhat.com>
	<871pbd9qpy.fsf@pond.sub.org>
	<CAFn=p-YBpsxy-3tr0SZ0CBfXUYnb6eg6AxNWpwUQmsuY5ZuykA@mail.gmail.com>
Date: Wed, 02 Sep 2026 12:58:00 +0200
Message-ID: <874ig7539j.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: YLgexfXlBFQOZYIajFP4HwlvBAdo3rm-WxBuiJ5YzKg_1788346687
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

John Snow <jsnow@redhat.com> writes:

> On Tue, Sep 1, 2026 at 7:05=E2=80=AFAM Markus Armbruster <armbru@redhat.c=
om> wrote:
>>
>> Series
>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>>
>
> Thank you for your suffering :)

You're welcome; it's my job[*]!

> So, I think there's actually no real problem in checking in a partial
> conversion as the infrastructure was coded specifically to allow it,
> however you're the maintainer so I will follow your lead. I'm more
> interested in moving forward than telling you how to do your job ;)
>
> The series will eventually enforce strict ordering, so there is no
> chance we will miss anything. If we send a PR now, we also don't have
> to keep rebasing the partial series against master. If you don't want
> to submit a PR, please create a branch I can track and submit patches
> against, and please periodically rebase it against origin/master.

I worry a bit that having intros split about half between two styles
would cause confusion and friction.  I'd much prefer to get to >90%
fairly quickly.  If we think that's possible, I'm happy to queue up
things in my tree, and take care of the rebasing.


[*] Some days my compensation is compensation for suffering ;)

