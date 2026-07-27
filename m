Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3E442BEB7
	for <linux-cxl@vger.kernel.org>; Mon, 27 Jul 2026 17:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785172590; cv=none; b=I9rtUByMS49bxTUcMPPFqvx//ETJxwLxKx9OouFMnLxn0OZfQkBqB4EpEXw2Pzg5nPwbRxh1xaXPi5mV3a815FIwpFkEoNmPr8Tm3JHFC+M7Z7XFr53HyBgexf4ceBUsT25kBnwx4zHf8DQy/V9dWuVsAR/bZsdOWuKhAHI2kyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785172590; c=relaxed/simple;
	bh=hFH4zZBkUuQuXO51qpxPQA7VKLl2bwS5UMexaJYtPqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NYQaMz4oRVRm/AuiVVGlEYsRMG+WmCmKjkTU8L+B0Djb8sPcBkUq24MDr/6D0phPSG773I8ziATeRcgtYm73AEZbOzQiJax0BXES/AKsCOd6HyPNpUKP+x6HH4gN1Mh9vIaHl20pZnZutviCtQIy+5ERZF5NYuK6yzSGwPq/a8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CJR5dYLn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CJR5dYLn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785172587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W3mGFXZevARNc878mJv43Auua4IFTv4YphZThywYfhE=;
	b=CJR5dYLnLcVYHErYGDBAts50/28pD1j53NHXhOjNr0YjdgdiW+5BegcnE86/woW6///wjg
	Yw4YySq5GFUL/NlQXEvHLNc6FvwdMUDzTjsIOFIqr8D+pcEHFfwiI3JoDkurzhYzTF617q
	mVmO33KF7lGhUElBOU50gkRefwxvcqU=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-19hDuU2FNsq2q2zD16cUPg-1; Mon, 27 Jul 2026 13:16:25 -0400
X-MC-Unique: 19hDuU2FNsq2q2zD16cUPg-1
X-Mimecast-MFC-AGG-ID: 19hDuU2FNsq2q2zD16cUPg_1785172585
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-668beae641bso6185220d50.3
        for <linux-cxl@vger.kernel.org>; Mon, 27 Jul 2026 10:16:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785172585; x=1785777385;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W3mGFXZevARNc878mJv43Auua4IFTv4YphZThywYfhE=;
        b=S8qj/mo/iaE4+jVOtFsplzAvv34onjMyOBZhcYU7o1PTP+zcEQjnLBkteW6pwCz4Gz
         96PQfRClEDXRNYzfz9pZ95E7pnNf7TwIweuhhUfrSLne/1KRDWztmFOrKHP0LRYKflCn
         ObE0jTc6EL52CFyQ8VVlqSY6LnOdEY1A3UWL1VFa15UY8LTiYkUlumP8AAbGOgIOFpSj
         AESFaC0hASfTMxDcVoWlY7xv5rZCkZpRK2GaobY/Vfi1rliPD1k0/7NQzId+iHI7es7T
         gTNU6GnX7QUN9LdQy3NZgaJHGOQZypenV0OBmk3Fo9go441b1geOL6YYuXsTQ9J9Mgh+
         j+7A==
X-Forwarded-Encrypted: i=1; AHgh+RpbTti3kQ/iYhgJ6JWFgBEzzQrgmQpLDvmmRjeqY2PQvM2OQ69lgLIZqlT5NdGCdcQVXhX4oRDPuxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVGtSqInd769peNTXfoECOS1HT7eRiZfTqGuAiQuD4KLneuuBG
	0hJtLJlbR2PHWRl78Q1NJAhCuQgHwvg71qHv2hvZIQYibFtmobZWg7YTzUiu8kK95EOaa38aISv
	3lmSXRrr8t/E4Z7gPGdGyHAgnG6M+XoE9z2vRBuYZRyeRAKhIe5uL6uYi/uMDMMlyIh+n/TQ1u5
	UxOwL/CNQC+67RBw2MwFyKo0iCfHPH1GQzvmbc
X-Gm-Gg: AR+sD11zP7LGux831dVm9O6ZVCpG9xE8LcQWw6gIVZIdCPCXEqkVsQaPFCSpVTMUuR0
	C+Lg6YiIjrb0DQwHy/akAC2CAKA4nBfUQxR24BT1BUJhtVAhyLEVfNwrCXUE1SaLHGG0feKynsH
	uMP2MArkIjtVgnERQ+7XnV+1RsGJx1sF+IzxVZGLFBIH1E7pidqy4YZ2NIBhYDD3xu1snQL8TiV
	Rpz1YLeEcuk9ujj
X-Received: by 2002:a53:d94e:0:b0:667:af58:8d68 with SMTP id 956f58d0204a3-668ffdf6f05mr48371d50.61.1785172584868;
        Mon, 27 Jul 2026 10:16:24 -0700 (PDT)
X-Received: by 2002:a53:d94e:0:b0:667:af58:8d68 with SMTP id
 956f58d0204a3-668ffdf6f05mr48336d50.61.1785172584382; Mon, 27 Jul 2026
 10:16:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723044805.527643-1-jsnow@redhat.com> <87ik65g8xm.fsf@pond.sub.org>
 <87h5lobypc.fsf@pond.sub.org>
In-Reply-To: <87h5lobypc.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Mon, 27 Jul 2026 13:16:13 -0400
X-Gm-Features: AUfX_mxQww8G_sDN4rPtGqGYLANzGPwYtpBIHqm73aQVX56k63-nE7PKd7bUCQA
Message-ID: <CAFn=p-Z0Ys6FoUqRPY7d5CaN4YfHE4DUN6VLtMeWRJgUk3Khkg@mail.gmail.com>
Subject: Re: [PATCH v2 00/44] qapi: convert trivial intro sections
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
X-Mimecast-MFC-PROC-ID: hO2VFSlO-RCQ-xaGRIDdJXVvbykEV_gSo8dBqxjXc1M_1785172585
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 4:04=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Markus Armbruster <armbru@redhat.com> writes:
>
> [...]
>
> > Converting single first paragraps is mechanical.  For it to be correct,
> > this single paragraph must actually be the overview, and not some other
> > crap.  I expect it to be almost always overview.  Not sure how to best
> > look for the exceptions.
>
> The separation truly matters only when the inliner inlines the doc
> comment.  It potentially matters when it would inline it if the type was
> used differently.

It also (potentially) matters for auto-generated docs, such as
undocumented members, return types, features*, errors*. The break
point is where these fields get inserted.

(*Not currently performed. Not asserting that it will be performed, or
that it is necessarily valuable to do so. Just fleshing out the
category.)

>
> If I remember correctly, the inliner inlines doc of struct / union base
> type, union branch type, command / event argument type.
>
> Argument can only be struct or union.  Base and branch can only be
> struct.
>
> We talked about maybe inlining return types some day.  This would be
> struct, union, or array of struct or union.
>
> So, for anything other than struct and union, the inliner doesn't get
> involved, and separating the overview cleanly is just a matter of
> writing style.  I'm not sure we care.  Even if we elect to care,
> cleaning it up is hardly this series' business.  In short, your
> mechanical conversion of single first paragraphs to overview syntax
> should be fine even where a paragraph's contents isn't clearly overview.

Except in cases where stub positioning matters, see also the former
"TODO:" syntax used to delineate intro/details.

>
> Structs and unions, however, could use an eye-over.
>
> [...]
>

