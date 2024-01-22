Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E78DEBB
	for <linux-cxl@vger.kernel.org>; Mon, 22 Jan 2024 02:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705891814; cv=none; b=ASwoyiaFjZ9QjgVo4S9Iudulg0Y66SfXjJuLG5LWPMCFxXB0Z+TMxbibZ3t+V91aP3d3LmvA+jrRwQwD6ukXmZFq42rC5I7htBIEuyMLspwyWub05yc6BboBFBy1wLrAn3VGp7OCFZy1KTSaVvGfRuMDFv00nyh5k8wS3D23760=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705891814; c=relaxed/simple;
	bh=kcqxd0BJofHhT1Q7abQIK75/KFiDTylErvekUNOOdz0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uuIOUXlDW+8u+X24Bv1cq+BBusCIj3v6Up1R+bEKMc5/WLcxYL0slM4GRL2xeCp6LTshqNiSunlfJrnoyDppnk1qsVzaErWYkHINTNguP3QyNsGQxugRf4wTydcH1PzatvZGZtVSRFceEEpnVjoZbEppn5r/HS45fXvcZMhG0Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mpVTs3p7; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mpVTs3p7"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-7d2df9d1976so271674241.1
        for <linux-cxl@vger.kernel.org>; Sun, 21 Jan 2024 18:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705891812; x=1706496612; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+cXLgPXYA5Fe6az71hac21hiFb2mTxJdrHHMfSV7PMA=;
        b=mpVTs3p7GpTd7+Ge7TBrCKLlIvHS/SrulhAPo+NK7AckbTOQH2gUbypasqFqaU5HG5
         RBSR0i+D/AFzqwrPVz7VSQkn43miquDzSTTbnjccbuJih9UTI8PxbnJB1UP+K1nnbJ9n
         sdbWGVk5aCbHzey+XYrTUkqvR0vqhsxUST5GI6iwe4aRfqBez6cAbJIprKtNEfnmYMUN
         t0uTzMpheJbyYX3oHRbeKjvNwY3eJfZCwsVrKw9kqR9m7qxfPTnQ0dJlBJoRVkd5iDg2
         q/Bh0pK7akNSAH2k9n8nZdLJRzXL/zaRkRcsityPcGG7+jCYB0H2FCpdV03Gsdym3mJU
         YWAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705891812; x=1706496612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+cXLgPXYA5Fe6az71hac21hiFb2mTxJdrHHMfSV7PMA=;
        b=Qhq53cdfdmdMXwY8Ohif8Jj44gr7LFQ7jMAotCYEaGjHENqb+EyWuLm4XIMaHwO2Ud
         6IdQbVu3yepOjVY7pPlsKwMmcFCosFsfVUIzl6nuCvzZL1DJD2UWnNGVDv0PDcA4nYr1
         p/F1umN1Si78r1Q5we9Kfv0CxKB9bpMdIKt9S9P8Cym0KVnz2ny8cl5SS3sBUHd9tYzM
         vd92nt1TDFJSz1D0HSw71hF46C+lffoO2qJ0jNdQxMhAfgNlYNNBnLnQ6WxhSG7Tc0vs
         G03CndLWDzY/FPoOHD0IM4F1vyNykPLwIiVY8eAC3OVIF3T390fJeK6GP+iPeyo9erj4
         le7g==
X-Gm-Message-State: AOJu0YyPYyo5o/gpHhMAaMq/vkbh/9LLyKSMwgkeUwOylayuvj8bwIUE
	91/MOk4XhH0YFrYvfXA+8tHWTKachnk4wAesOKM6x67hp4dFHnKhG32wCxSiJ0F1alZ/dHtuXFT
	AO+j6gel8KiejUWCX3wasvoV68oE=
X-Google-Smtp-Source: AGHT+IEnsKtgEXI0mfVZDlHugltUuL7oafebGrrUgHYsrFVtdmNBjZVTMno7dA7/Qbi3SUy17YEEsz9hIJ12GXa4p14=
X-Received: by 2002:a1f:ee47:0:b0:4b6:f0c7:62e4 with SMTP id
 m68-20020a1fee47000000b004b6f0c762e4mr542083vkh.12.1705891811766; Sun, 21 Jan
 2024 18:50:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231222090051.3265307-1-42.hyeyoo@gmail.com> <20231222090051.3265307-4-42.hyeyoo@gmail.com>
 <20240109175358.00007c48@Huawei.com>
In-Reply-To: <20240109175358.00007c48@Huawei.com>
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date: Sun, 21 Jan 2024 21:50:00 -0500
Message-ID: <CAB=+i9QrmMMazcNvEhuwTNF+UZMHPQE=yT=RE+MJCUQO+QY27A@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] hw/cxl/mbox: replace sanitize_running() with cxl_dev_media_disabled()
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Fan Ni <fan.ni@samsung.com>, 
	"Michael S . Tsirkin" <mst@redhat.com>, linux-cxl@vger.kernel.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 9, 2024 at 12:54=E2=80=AFPM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Fri, 22 Dec 2023 18:00:50 +0900
> Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:
>
> > The spec states that reads/writes should have no effect and a part of
> > commands should be ignored when the media is disabled, not when the
> > sanitize command is running.qq
> >
> > Introduce cxl_dev_media_disabled() to check if the media is disabled an=
d
> > replace sanitize_running() with it.
> >
> > Make sure that the media has been correctly disabled during sanitation
> > by adding an assert to __toggle_media(). Now, enabling when already
> > enabled or vice versa results in an assert() failure.
> >
> > Suggested-by: Davidlohr Bueso <dave@stgolabs.net>
> > Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
>
> This applies to
>
> hw/cxl: Add get scan media capabilities cmd support.
>
> Should I just squash it with that patch in my tree?
> For now I'm holding it immediately on top of that, but I'm not keen to
> send messy code upstream unless there is a good reason to retain the
> history.

Oh, while the diff looks like the patch touches scan_media_running(), it's =
not.

The proper Fixes: tag will be:
Fixes: d77176724422 ("hw/cxl: Add support for device sanitation")

> If you are doing this sort of fix series in future, please call out
> what they fix explicitly.  Can't use fixes tags as the commit ids
> are unstable, but can mention the patch to make my life easier!

Okay, next time I will either add the Fixes tag or add a comment on
what it fixes.

By the way I guess your latest, public branch is still cxl-2023-11-02, righ=
t?
https://gitlab.com/jic23/qemu/-/tree/cxl-2023-11-02

I assume you adjusted my v2 series, but please let me know if you prefer
sending v3 against your latest tree.

Thanks,
Hyeonggon
