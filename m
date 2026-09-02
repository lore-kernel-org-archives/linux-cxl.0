Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71024AD4AC
	for <linux-cxl@vger.kernel.org>; Wed,  2 Sep 2026 17:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788369897; cv=none; b=LBl5gYZ0n0Yc05q0144F3OplRk39V6hzDTkSO5V7CRvAmRRWmwTf8aldywd0xXwnGm5JAMbNvQVD++DeUGEpZ8Orh5mKIAcgCaOskNiMU+hR1hjDXAcTgTcxWh0orlESwgadflVB1VICiSn5mGqaLhOHOQXEyYV+HJJiP5JLABQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788369897; c=relaxed/simple;
	bh=N5itlC390yfvl6p6qW4Tuf3E23PRHdkct42mfOBzo6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZWjCcMB+nHjVYpDFOZ7ZrjR7OdZpZZgRG1AtI6L1B51gCPgjPnfGfeqKzAkMOFSMQB4JCfZMOF9HRzoQmxrDd1Pysb/6aoADC97OYmwV8vbLDNOTcF5cLPrEeE+QV5xxTUgoP/EnrVNbVCw7JkOO45dj/d8rE/xzJcfqRf7Cwts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i6FDsv//; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i6FDsv//"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788369894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JtfXQonqbMU0qfMOMFckgTdI7kxhGi1jaT13EBgtRUU=;
	b=i6FDsv//FDOJhBw5HQd2LhSl5NZON+ywm5Qwz8yAVJ3Y4TA/FOFtqehWCU0Bhee7++jc2Q
	0KXyoIVg9QaSJbvCYH17R0yof+U/KtsVS90Xu5J2QaZauBGQvvTwHYjApI7JnmKKKVPQbo
	+IZEC59Pdbjsg3zyKRTeNXvDvyzv19k=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-248-KRAT4dvcO1yNHXrn9jAREw-1; Wed, 02 Sep 2026 13:24:53 -0400
X-MC-Unique: KRAT4dvcO1yNHXrn9jAREw-1
X-Mimecast-MFC-AGG-ID: KRAT4dvcO1yNHXrn9jAREw_1788369893
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-66c767e23f6so1316301d50.0
        for <linux-cxl@vger.kernel.org>; Wed, 02 Sep 2026 10:24:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788369893; x=1788974693;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JtfXQonqbMU0qfMOMFckgTdI7kxhGi1jaT13EBgtRUU=;
        b=pOrUqaALhNmFDJCd4x1wBpuCSpHemd4TyqjMN+WmE2koTM8cv9J+ndFikrtHCT2Ypu
         e9DqVzS+XbEfSIN9PH7gguegdVEIf3iwC/4WZtOXQgPz6khypcaqSnU6efvREkFz6cH1
         g/DxF0ueuydf6gORTiWf43pQmVzBLbTfiMQcg54x19K5VNVVVyeQIZREV68hTZAhHe9q
         Ux1IBDG+thYIpVWv3EGmhmNtQV8NfcecOfyT0wUgh9fGn1vAbtU7bfHVOzjKfcdZi5vW
         aIhyhI9KVV9yrAXw5KIaauCWNzsboiL5t++OUW6GWOul45MCvriqnkmGhaR1xifzz2Wo
         QKWA==
X-Forwarded-Encrypted: i=1; AKwUvBwa3NhO/N/KuQz3q0FQXg1GQ0Rt6jcQps2CZj3S71cotpa9FKKJKwh3hKOf81dp6YtwBqmG+9NGT5E=@vger.kernel.org
X-Gm-Message-State: AFuF++lScNHBc3CP2I8oUH69WrqrFZouWXCn7wizW7jWEF9Zg6YokmDq
	6OozAbnIM4YBb/0CdFYDkpqRVMeCwB+TFXoaTsPEKJEejnQbgPl291+409EXAitbTI+IPZR0WaA
	17L8hkaaP5kwnkgts6vFTYGB+nUxf1fDoahuDqPIQt8dlCROqy9MhDI+SQ8/DKBRF/kWYg6JPLF
	GTvL02UXn20dGJW7CkPNZ3ZSY+4nLuUUrDVRKL
X-Gm-Gg: AYBFou2g8UWTbQTFFm5lVract0LmEQ2xYqKEJ6Z4nhCtsvNNWBKUrfpXQzI1rjOq+vX
	jufN0vISNslqMpkzWkQfEXv7VN/KTSxYpOD1AGLLFHrLBHetaBBFCnb6VRV1K0/PSyKUcy60AdA
	xxQbBRnBGLYJ/jW77EtqXRmTn18s7mWvkVTUXNQJ2tDH019D6Ki9Y8TK6oQASo0FgdJmHM1dVlc
	arbKK6Nuudv3I+x
X-Received: by 2002:a53:c051:0:20b0:66d:2c09:fb70 with SMTP id 956f58d0204a3-66f9b6c6c7emr1993905d50.0.1788369888100;
        Wed, 02 Sep 2026 10:24:48 -0700 (PDT)
X-Received: by 2002:a53:c051:0:20b0:66d:2c09:fb70 with SMTP id
 956f58d0204a3-66f9b6c6c7emr1993889d50.0.1788369887644; Wed, 02 Sep 2026
 10:24:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831201945.287730-1-jsnow@redhat.com> <871pbd9qpy.fsf@pond.sub.org>
 <CAFn=p-YBpsxy-3tr0SZ0CBfXUYnb6eg6AxNWpwUQmsuY5ZuykA@mail.gmail.com> <874ig7539j.fsf@pond.sub.org>
In-Reply-To: <874ig7539j.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Wed, 2 Sep 2026 13:24:36 -0400
X-Gm-Features: AcwNN1XBjb54T3mVZMsXOfq2ujX90-DJwsczseD1fmwpMjm1p4yXf5IyvbishUI
Message-ID: <CAFn=p-ZMj03qA0tvLU34FHLcwBJjU0c2q2Ex1p06FJfZpwyuJA@mail.gmail.com>
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
X-Mimecast-MFC-PROC-ID: WJgyrmoiwWBPdCZXap61qnWM5GxGcAl7eZejEs9cXCY_1788369893
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 6:58=E2=80=AFAM Markus Armbruster <armbru@redhat.com=
> wrote:
>
> John Snow <jsnow@redhat.com> writes:
>
> > On Tue, Sep 1, 2026 at 7:05=E2=80=AFAM Markus Armbruster <armbru@redhat=
.com> wrote:
> >>
> >> Series
> >> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> >>
> >
> > Thank you for your suffering :)
>
> You're welcome; it's my job[*]!
>
> > So, I think there's actually no real problem in checking in a partial
> > conversion as the infrastructure was coded specifically to allow it,
> > however you're the maintainer so I will follow your lead. I'm more
> > interested in moving forward than telling you how to do your job ;)
> >
> > The series will eventually enforce strict ordering, so there is no
> > chance we will miss anything. If we send a PR now, we also don't have
> > to keep rebasing the partial series against master. If you don't want
> > to submit a PR, please create a branch I can track and submit patches
> > against, and please periodically rebase it against origin/master.
>
> I worry a bit that having intros split about half between two styles
> would cause confusion and friction.  I'd much prefer to get to >90%
> fairly quickly.  If we think that's possible, I'm happy to queue up
> things in my tree, and take care of the rebasing.

Everything up until the "convert multi-paragraph intros" patch (#44 in
my pending work) is approximately 87% of the total volume of
conversions. In the most recent off-list mail I sent you, that's
Sections 1-7 -- which is essentially all of the stuff that was
factored out as "semi-trivial"/"simple", plus the "TODO" conversions.
I believe these are pretty trivial to burn through, but would require
a bit of dedicated time. We could probably do it in a week if we
really pushed ...

Existing volume of what you have reviewed and accepted is 55%.

Well, either way, I just don't want to have to juggle so many patches
in the interim, so I am pushing a bit to just merge it to make
subsequent series easier to rebase and juggle so that e.g. I don't
have to have increasingly long "based-on" tags.

(Makes sad, pouting noises.)

>
>
> [*] Some days my compensation is compensation for suffering ;)
>

