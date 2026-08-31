Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED4F3783B4
	for <linux-cxl@vger.kernel.org>; Mon, 31 Aug 2026 18:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788202554; cv=none; b=RbNiXIqzB8CdWfANT5chP3jTnKElPYmxRfc0prozIdiIqftRjkfs5uFdjMVUYjHgbvJgH0HCBjhj9hwH4mKDO5TaHooK3EMl2wL24aY45SgfNuixsSDD6kJ2C1qyzYwkoAJ67cZo+CgB79hZnwfjE5661OKoJC0oLpwN1F5+NGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788202554; c=relaxed/simple;
	bh=u87RqAAa657Hmf7s5lZFEasHBmwfl8p3xVrE6rj4W0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IaO9DkKktVxTg6A8O6QT/atQGLvrWm4YfRtjE/NkFGyZZ5Z7+B1ZJ8E+Nq2xZ7JUUnsnGZdFcLKJJSTr0piYUQ8xb+uuHLK8d6JLt2SExeh0rtvGiducwFFelDT+0LFow+GE5z42WG6ziKjTCQLpAx22rllrbx2hUq7rzE+ea1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PVQ3Yp25; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PVQ3Yp25"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788202552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xJ5EPZcsW3BeU/Du4PIisPviXsXnrKzOxO6xL0idyrw=;
	b=PVQ3Yp25xZL9EFcQyi0v/NnZr3AamV+IF7A7nYiN6tBNxtHqbh27d25jTrGeq1eN3o+B7B
	j+u7OuOrwXAn9gKDGHfAQdehar06Iat7ts/3flnbuFZzY/8ZhoR9SOcBcYLEImuu0JTNxy
	Er5jHKs0UQhWm6dpsdQttaetKLsG9z0=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-ud2yYwtsOjygwEZwRBDVDg-1; Mon, 31 Aug 2026 14:55:51 -0400
X-MC-Unique: ud2yYwtsOjygwEZwRBDVDg-1
X-Mimecast-MFC-AGG-ID: ud2yYwtsOjygwEZwRBDVDg_1788202551
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-66c70fa2ba4so4289266d50.2
        for <linux-cxl@vger.kernel.org>; Mon, 31 Aug 2026 11:55:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788202550; x=1788807350;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xJ5EPZcsW3BeU/Du4PIisPviXsXnrKzOxO6xL0idyrw=;
        b=nSeHY5WL8Uchkg+PXV00r8pQXUJy7rZrjnTyrG0VusjUt1lWfGKWaeqGdOJRFzsFtk
         7f0/Z1NYZx1yPoZUWdiYiQux/o0tVFc3d378bLYdjUw1ADmMYuHQ3tUJD3cZS5IdmuaI
         aXCrDu8TsXnNTL8PS2fX4LC0y22zQCCc0UE9LYP77SoTic+oLEbWVfOaXBkx2lihqKUX
         pl2vokx028fSOvmfvpjOgVXZQbVCrrzzONq8O002xN7kzgiAEyqLQrh9q1HQygSOiTqc
         T2W4BFjfcDuaANUFXe0KqyhHuFSp8niETfm/S6PbmF2x0kN+2jMhYblHj7vtwnV4OOVP
         Xl9g==
X-Forwarded-Encrypted: i=1; AKwUvBzv2yMbxe+oevm5t+kx25dmD38GU/Ij90wha3qf1MZNoT9kerg+5YFDxewbot5Sg3FWJnpXUMrd8ng=@vger.kernel.org
X-Gm-Message-State: AFuF++mRHqOpBthkhFd7fgo8CBk3t5ZVgTWRx/Rnd4YUArpZQflDALJl
	1l7FV220bGzQ+oVZX4jn1SmMfbOD1DhGU8qrvLrObYSHXOhAi0axFewVEIpOXaWnkhYuFBvosJG
	Xfn7jLMegKaSEK61kQZYzcD1ZqX31kfmb+stgh7sVHQ3/klFd5kigGIxCGnw78lHw0zu+/7WWfM
	nhdCfEw4TA3kAmppEbrzyNsRlxHbRejFWFMmXS
X-Gm-Gg: AYBFou0ORwZPhareALDrUvKyQFBPWt7+mRylowvGdIU2EJU0NyBpS+LHGgotAUEKuBf
	y1eL1f8322KeWMrUq1/oF4pVCIBnou8+XkkvjtcPxnAeM7Va2kqPya1fahvR4CgIeyKtvlsltwC
	Fj3zBxyoRxGU6kLOKk6XYDEPzZo/eAzkK4slfnzs5nT9Tarmp91X89JlytTOMO3p8ZXxuHUtMXi
	/5Hdiuh1i/7p3Yc
X-Received: by 2002:a53:c30f:0:b0:66f:8731:8d1 with SMTP id 956f58d0204a3-66f87311ba5mr991262d50.39.1788202550350;
        Mon, 31 Aug 2026 11:55:50 -0700 (PDT)
X-Received: by 2002:a53:c30f:0:b0:66f:8731:8d1 with SMTP id
 956f58d0204a3-66f87311ba5mr991075d50.39.1788202544932; Mon, 31 Aug 2026
 11:55:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826193840.2152000-1-jsnow@redhat.com> <20260826193840.2152000-32-jsnow@redhat.com>
 <877bl6e6so.fsf@pond.sub.org>
In-Reply-To: <877bl6e6so.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Mon, 31 Aug 2026 14:55:33 -0400
X-Gm-Features: AcwNN1UG_VbNhAzp5JMRR0NLbU9hcA9dfPYFAhsnI6iviTHK2XjRUfYMif3KYDc
Message-ID: <CAFn=p-Y7AO1QRXGHFsahnWtiERbDuBtFtAj0c6wphrLdZmy4_g@mail.gmail.com>
Subject: Re: [PATCH v3 31/43] qapi: convert trivial intro sections for block.json
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>, 
	=?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
	linux-cxl@vger.kernel.org, Michael Tokarev <mjt@tls.msk.ru>, 
	Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, Peter Xu <peterx@redhat.com>, 
	Eric Blake <eblake@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
	zhenwei pi <zhenwei.pi@linux.dev>, qemu-trivial@nongnu.org, 
	Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <laurent@vivier.eu>, 
	Jiri Pirko <jiri@resnulli.us>, qemu-block@nongnu.org, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, 
	linux-edac@vger.kernel.org, "Gonglei (Arei)" <arei.gonglei@huawei.com>, 
	Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Jonathan Cameron <jic23@kernel.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
	Zhao Liu <zhao1.liu@intel.com>, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Ani Sinha <anisinha@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
	Lukas Straub <lukasstraub2@web.de>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CpcIolBCsR-Od8m1oYdTM0wG4fnDPGUMyNoQIVTBlQ0_1788202551
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 9:52=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> John Snow <jsnow@redhat.com> writes:
>
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  qapi/block.json | 41 +++++++++++++++++------------------------
> >  1 file changed, 17 insertions(+), 24 deletions(-)
> >
> > diff --git a/qapi/block.json b/qapi/block.json
> > index 46955bbb3e3..189f2e28204 100644
> > --- a/qapi/block.json
> > +++ b/qapi/block.json
>
> [...]
>
> > @@ -314,12 +310,11 @@
> >
> >  ##
> >  # @blockdev-change-medium:
> > -#
> > -# Changes the medium inserted into a block device by ejecting the
> > -# current medium and loading a new image file which is inserted as the
> > -# new medium (this command combines `blockdev-open-tray`,
> > -# `blockdev-remove-medium`, `blockdev-insert-medium` and
> > -# `blockdev-close-tray`).
> > +#     Changes the medium inserted into a block device by ejecting the
> > +#     current medium and loading a new image file which is inserted as
> > +#     the new medium (this command combines `blockdev-open-tray`,
> > +#     `blockdev-remove-medium`, `blockdev-insert-medium` and
> > +#     `blockdev-close-tray`).
> >  #
> >  # @device: Block device name
> >  #
>
> Not sure the parenthesis belongs into the intro.
>
> I'm okay with keeping this hunk anyway.

In this case, it will be fine as this is a command and the precise
split between intro and details is a lot less crucial. It can be
adjusted later at our leisure.

--js

