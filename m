Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD60E366057
	for <linux-cxl@vger.kernel.org>; Sun, 26 Jul 2026 08:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785054310; cv=none; b=WNjdKqGQDM/xBb6ZXGNFlZtpF2OdBrYoB3rqctAk9msVMT9u1SWayH3nCUI/A6yaETVWwTC8bvvY84dN7tNknhn4Nt/lrNzP17DzcY7NhahBMUWUtsvMjfxHvzGs3hfk2sldYEY/l5Arl5m/QIOhZolbbGMFJq0R3zxxPvrG7Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785054310; c=relaxed/simple;
	bh=BIxi9ibkkG2KO1bsuNaXuIOxSiGPHl4+H2q1MiYgfQo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=huhvFOfoENpB08nMMHazajisDRompt2vpdErDFswDvssDnbbO5mioEQYduUP0sk3XmMMS+QzTpz5JeGUnRJTbLbJJ1xxfz8pBdZpo3MCVLABKirR1jr3lQBlFJSAIIActzyqh0829Lr5ihAXgyy796LOHoJeTTO6kyVakV7wSc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S0C7D8h8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S0C7D8h8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785054307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=59Uybs0g6O/CDfAjukMQvmYRMAOMU/3wHIKQ8fqpR7U=;
	b=S0C7D8h84Vlyq+10ZEhze9pMJvEuYqU31gN2eoItpnt6SWtco9BvtASS7+oDJnDgPskdTD
	+tRkRfVfSZC3vxNu+FU4DrfSPFObHub7DjbbNDZS+jc7fYa4uvwiLymColqHFPRzUHwYeP
	Bm4mMt9Q4wkIZ5mFsijvajxp+CKV5FQ=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-u28G7suPMmy44EP4mPXNBw-1; Sun, 26 Jul 2026 04:25:05 -0400
X-MC-Unique: u28G7suPMmy44EP4mPXNBw-1
X-Mimecast-MFC-AGG-ID: u28G7suPMmy44EP4mPXNBw_1785054304
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cea6a46766so30328525ad.0
        for <linux-cxl@vger.kernel.org>; Sun, 26 Jul 2026 01:25:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785054304; x=1785659104;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=59Uybs0g6O/CDfAjukMQvmYRMAOMU/3wHIKQ8fqpR7U=;
        b=a825Q0nixkIkUGK0tM4myIyhcHTbEZn+/vCBc09+WV32o0url5byqskY3UlQiEOEoY
         wlf01e2cO2up65ZC7daQGA/lYZH/2o68XI3ysx+Ar32GzcnMCnXGhhbd/YncP2qQ1u+N
         nOHEn03bX8RXDrC7PIKLggZZ/OrOm1f+ngjFTsbpjygnTHQUKwuKzGwtVFayc47CXUX1
         7Z+3sx+VYV+Y0yOBuMsvFM7QEVO11i72aAfI9wt0XA5MOoEeZQ7w9E6kk855kvSJQ8p0
         WE+lyL0UfHbiNlY5ygzlip+CFSwqnqwqRYQqfQhE2U5vsrmDlXkiufgIX+w29lOKLy9r
         go9w==
X-Forwarded-Encrypted: i=1; AHgh+Ro6hiQckAtNSJt30gXeQOkcV2qPsZkflek3DpgaPRfiUCow+p/Zfg9nPQSNHtLcRgRusMp2LNnrmTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+KwvOXzy7Ny+Jc4dncts5KxI2zEoFVqLA+bDGPnQ/e90Cxyy3
	WUUnCJDO/wzLtvbbB8USrfhZQFkBdQru048r3eENUwp4p8P0cUK8vGtwvLSmDjAA5UOSjmqlNmf
	cEY5Q6sQNc0GyPPybYOMEAhX9K/jKnOmzHCZbguWdN4ZZX5s+yI8TKm9dT29k980z44hCAr+C4H
	z1WRl/Zq+RFvxChZSe9Y+FW5HljL4pOD6YpDbx
X-Gm-Gg: AR+sD10AjtErR0eDnAEgMc8nIlzJQlY054Q3g0LWPHa2+UW7Xu1GSjQ9PQsldqAqr6/
	ZH0/1ACk1/HbJM60/YudlrG09/TPDO2OW0j7GFhckT3IJD/AB9swnNIcdd46DyLSe9b7Rb4MHuD
	ghS0EN6h3iOIOm/LYJaaJGDHJ2lYro+C8nVBivXTaLM2XVH4/2mStb+3F8W9zu+PNztUNhAUaK3
	lCal0ehYVcsYE1X+A9al+vpTjf4JDbMSDjD32dDh8oN0wPeIQ/e0VdBaOtZ0vf2CFAjsrRXsxcG
	eg==
X-Received: by 2002:a17:903:2f4d:b0:2cb:3f5b:6663 with SMTP id d9443c01a7336-2cfde78b5ecmr43282235ad.11.1785054304147;
        Sun, 26 Jul 2026 01:25:04 -0700 (PDT)
X-Received: by 2002:a17:903:2f4d:b0:2cb:3f5b:6663 with SMTP id
 d9443c01a7336-2cfde78b5ecmr43282045ad.11.1785054303714; Sun, 26 Jul 2026
 01:25:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260725-fix2-v1-0-5c9a6ce7b96a@redhat.com> <20260725-fix2-v1-1-5c9a6ce7b96a@redhat.com>
 <d6876e8f-1414-4e7d-b6e2-1b59a18e8288@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <d6876e8f-1414-4e7d-b6e2-1b59a18e8288@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Sun, 26 Jul 2026 12:24:52 +0400
X-Gm-Features: AUfX_mxsuLpmI5MChTjzmAUkWas6IA0ZKyKEPoJZBwiBSb22LoL6dZfqqD3Ui-U
Message-ID: <CAMxuvawR=TiF4r+wdVCDF3Hyu-ND9neFHjUEZn5_YnSbxweXhg@mail.gmail.com>
Subject: Re: [PATCH 1/7] hw/display/virtio-gpu-rutabaga: zero-init capset info response
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
	"P. Berrange, Daniel" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
	Dmitry Osipenko <dmitry.osipenko@collabora.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org, 
	Jonathan Cameron <jic23@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
	Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>, 
	Phil Dennis-Jordan <phil@philjordan.eu>, Wei Liu <wei.liu@kernel.org>, linux-cxl@vger.kernel.org, 
	Brian Cain <brian.cain@oss.qualcomm.com>, 
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
	Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
	Haotian Jiang <jianghaotian.sunday@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CsXGpPEM55w3u9Th5uTsehHIvciK9QbD29IIv_r6QIU_1785054304
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Sun, Jul 26, 2026 at 11:33=E2=80=AFAM Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> On 2026/07/25 23:00, Marc-Andr=C3=A9 Lureau wrote:
> > rutabaga_cmd_get_capset_info() only fills in capset_id,
> > capset_max_version and capset_max_size before sending the response to
> > the guest. The remaining fields of struct virtio_gpu_resp_capset_info,
> > including hdr.fence_id, hdr.ctx_id and hdr.ring_idx, are left with
> > stack garbage and leaked to the guest, including host pointers useful
> > for an ASLR bypass.
> >
> > Zero the response first, matching virgl_cmd_get_capset_info().
> >
> > Not a real risk thanks to -ftrivial-auto-var-init=3Dzero.
>
> GCC only added -ftrivial-auto-var-init=3Dzero in GCC 12, while QEMU still
> supports GCC 10.4/11.
>

Good point, may be we should update:
https://patchew.org/QEMU/20260723094622.1515831-1-berrange@redhat.com/

ack otherwise?

> Regards,
> Akihiko Odaki
>
> >
> > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3609
> > Fixes: 1dcc6adbc168 ("gfxstream + rutabaga: add initial support for gfx=
stream")
> > Reported-by: Haotian Jiang <jianghaotian.sunday@gmail.com>
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   hw/display/virtio-gpu-rutabaga.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-r=
utabaga.c
> > index 4d7d7b245929..95a19eed7eda 100644
> > --- a/hw/display/virtio-gpu-rutabaga.c
> > +++ b/hw/display/virtio-gpu-rutabaga.c
> > @@ -555,6 +555,8 @@ rutabaga_cmd_get_capset_info(VirtIOGPU *g, struct v=
irtio_gpu_ctrl_command *cmd)
> >
> >       VIRTIO_GPU_FILL_CMD(info);
> >
> > +    memset(&resp, 0, sizeof(resp));
> > +
> >       result =3D rutabaga_get_capset_info(vr->rutabaga, info.capset_ind=
ex,
> >                                         &resp.capset_id, &resp.capset_m=
ax_version,
> >                                         &resp.capset_max_size);
> >
>

