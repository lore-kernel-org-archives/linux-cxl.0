Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4249C224B05
	for <linux-cxl@vger.kernel.org>; Tue,  1 Sep 2026 17:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788282127; cv=none; b=bgfPzVR0T8PZCv5I7gSF4EYCMoe5RYM4MKMxzfn/qyu41/rb40HJEg52OKFtDH8jhCpmyFdiu5ybwvs1QifdbvWDynGe/5Ybj7BvskVQiBppQSeYcLx2ztYHUcMGaiUfCH0kg1kMPZyWQbsJRZML1kCGH8aj75yOSoTBVPmghOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788282127; c=relaxed/simple;
	bh=60T+l3AlwkUKJ6uA4fVa+g+7QEfq9adnME/zrJKlEjU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RXaF/rM7xFs7Q0g2gpJJttyDym/99N8BBW1kwf8iTMeZUKWXowfJTR+r/sb87IE2BQCGgHspTG5Qj+SVJziLqSfjgG4R4zc2eIhh5KlLyqkuoZ6HUAtRhrzwizNOu5NzYCw2mIn+jcGyo/omMTNzcOcLQaEybeN8kmLFXe4ABig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lh/oY6PA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lh/oY6PA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788282125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=60T+l3AlwkUKJ6uA4fVa+g+7QEfq9adnME/zrJKlEjU=;
	b=Lh/oY6PAs2d3ju2rQ/E4G9Xk/cLvQkYD3gX+3AtrBho60Iy8ADYw+ENp9jP32C0NLwc/qV
	/uAfJGfYd8Fas/SVSz7lPGpjB2gMfYzIeO5ohqZFkQUGG7oNmPCb9+JyKWHNoLmPBgEVe3
	+QPuRidzPDOmN3bloiUfbZQvehYZNOg=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-D_zcz3RWNSmBJW3RwZtyWg-1; Tue, 01 Sept 2026 13:02:03 -0400
X-MC-Unique: D_zcz3RWNSmBJW3RwZtyWg-1
X-Mimecast-MFC-AGG-ID: D_zcz3RWNSmBJW3RwZtyWg_1788282122
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-66d309b367dso62981d50.3
        for <linux-cxl@vger.kernel.org>; Tue, 01 Sep 2026 10:02:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788282122; x=1788886922;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=60T+l3AlwkUKJ6uA4fVa+g+7QEfq9adnME/zrJKlEjU=;
        b=nnyHwNn4h7MIU3rxreb3qWkuaPi4kh6o2H+mSLM37UBb0agQWmN/7x9D9RpdzdKDTE
         TVKn0CVYQzYimNZ/0gZlF2pdHcgsPk4hY0xIX0+rmDbLyg/kaDGGVquijfIdPJEr/9fa
         L1ym76gQWte3iHYqFADW2HYvmLjYPq2sqw9lTfv3lv2IK618UDZWZr6PrL3jlFJk+pSg
         vakyep/libGSX6L1h6ycJLHDu52NcjZU2KbNoKrzfr6AxVeO/A6TCPOJZXXU4C4AOSpP
         RmGXowYzG7oCwB82nBHBo5eBrjFbzJszmRdJhZeapkt3PCy/DYfEx0dSUUIev5ERjwoE
         oeUw==
X-Forwarded-Encrypted: i=1; AKwUvBwUNGDEoEAvb5QKkNnZtyhxnLRYImZQzrbh647sOfd8F3zwbRVVvVYsh/sXhiCUcLpEa7F/6AwWSZ0=@vger.kernel.org
X-Gm-Message-State: AFuF++mdFMafczfsoSI31wUxu8mWLHLB6AbiFM3j2kDs/YTREEynvWuk
	d8gNNh1f/WNcdhiGlka4UMWyG+flPeHA3/iiaFGqbgyyHdw7QYeDX4hETmGQR2q5hMISKvpV6zX
	NsO2ZxbPTPtgoiqyCGlm4po88zZO1JOi0wVmQQIyRaXxXm0CJHQ3d+yFAkS7RpuO5R+vIG6Udjd
	CxKEOuVcg+NEbbQ48wxk+ADSglBGvFlqvKUtw3
X-Gm-Gg: AYBFou2XWABS38DJWYn3Erc4T1H5cp4dIUhy7i3mmQ3i2rByOgkm2sEr5JoUi8/5k6d
	EpfsAPE8ocIK8dtIUkSVz5UC89kH/6fxo3hm5ESGrnqQr8vrllrktQ5bzsFUJV5NNRW/O9y6UoC
	X9REMK+TUgU9bcNd16h+hv77qP04ZaUHLn93pMu6mfwWshjG8Pn+BtBMbCnruKKrjKFclGuP+py
	AVJ+Z2aE2NAwbIC
X-Received: by 2002:a05:690e:134b:b0:66e:5def:7fb with SMTP id 956f58d0204a3-66f873db286mr2861675d50.9.1788282122129;
        Tue, 01 Sep 2026 10:02:02 -0700 (PDT)
X-Received: by 2002:a05:690e:134b:b0:66e:5def:7fb with SMTP id
 956f58d0204a3-66f873db286mr2861611d50.9.1788282121503; Tue, 01 Sep 2026
 10:02:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831201945.287730-1-jsnow@redhat.com> <871pbd9qpy.fsf@pond.sub.org>
In-Reply-To: <871pbd9qpy.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Tue, 1 Sep 2026 13:01:49 -0400
X-Gm-Features: AcwNN1WwY9KhOHhEffsoAqUdDjHzsfzGhf3WCZkKFn57tI6T-m4ZzTC2sD0ecwY
Message-ID: <CAFn=p-YBpsxy-3tr0SZ0CBfXUYnb6eg6AxNWpwUQmsuY5ZuykA@mail.gmail.com>
Subject: Re: [PATCH v4 00/43] qapi: convert (very) trivial intro sections
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
	Lukas Straub <lukasstraub2@web.de>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
	Richard Henderson <richard.henderson@linaro.org>, zhenwei pi <zhenwei.pi@linux.dev>, 
	Jonathan Cameron <jic23@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, 
	Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, Jiri Pirko <jiri@resnulli.us>, 
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
	qemu-block@nongnu.org, Ani Sinha <anisinha@redhat.com>, 
	Jason Wang <jasowangio@gmail.com>, linux-cxl@vger.kernel.org, 
	=?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
	Igor Mammedov <imammedo@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
	Alex Williamson <alex@shazbot.org>, Stefan Berger <stefanb@linux.vnet.ibm.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <laurent@vivier.eu>, linux-edac@vger.kernel.org, 
	Michael Tokarev <mjt@tls.msk.ru>, Fabiano Rosas <farosas@suse.de>, Zhao Liu <zhao1.liu@intel.com>, 
	"Gonglei (Arei)" <arei.gonglei@huawei.com>, Eric Blake <eblake@redhat.com>, 
	Peter Xu <peterx@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, qemu-trivial@nongnu.org, 
	=?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3VmH4QCMs9yyc6veIxxw_ET7IdZrDzECxa051OGWcmM_1788282122
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026 at 7:05=E2=80=AFAM Markus Armbruster <armbru@redhat.com=
> wrote:
>
> Series
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>

Thank you for your suffering :)

So, I think there's actually no real problem in checking in a partial
conversion as the infrastructure was coded specifically to allow it,
however you're the maintainer so I will follow your lead. I'm more
interested in moving forward than telling you how to do your job ;)

The series will eventually enforce strict ordering, so there is no
chance we will miss anything. If we send a PR now, we also don't have
to keep rebasing the partial series against master. If you don't want
to submit a PR, please create a branch I can track and submit patches
against, and please periodically rebase it against origin/master.

Thanks,
--js

