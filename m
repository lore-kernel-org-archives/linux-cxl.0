Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B213EFFD1
	for <linux-cxl@vger.kernel.org>; Mon, 27 Jul 2026 11:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785151256; cv=pass; b=L0BFbhMmzep590/WUqNZS2q4ybjFWYcJBFes2tXqEBdFBZEcgeWrc5Dr+QEkSbtR0i8neeuRLtLS4V4i0EwVkUhAkleeio7BAbqf5Z4QyRWNs/ajMFPqW/NPvk5tXQJ+xLAREQQij35RwyUs7j6PMYQh82RoJEu3slUDoLKLc1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785151256; c=relaxed/simple;
	bh=OxMIjWJS/rZ1f6ZXQCj2Q/VH1aiXss5sWM8qdJYBSpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pt+RPbJo3nMMIB446f8Z8uyLOGdrV9uwNe4XAVjWW8F8Ck9Il5z6kVb0Op4RuPjyosqoiPV3bp1ZVJ5b1szdP6dcPTtKU+bvLx/q6Mv0Oe1nIdL+9JD58h308IGv0UzBKdmumHqgBBS8v46FD0mw7vYA5171DR6MCRpHlbRBKOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QhwfK3CO; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="QhwfK3CO"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso2303118a91.3
        for <linux-cxl@vger.kernel.org>; Mon, 27 Jul 2026 04:20:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785151254; cv=none;
        d=google.com; s=arc-20260327;
        b=e9G2vUzBs6xzhcoCGPmPiNOrtt7wlQ8qi6w4pu7dq62GAV5IXt/gxdaLnZ2nj4pAoV
         +OfDmg6jQO6PHpDObF3t4SCVlO5ITE3T3K/gYxUcCVpNztJiHFPM17Ut59M8rdV+puI1
         D8daPVEn93NMNE0pId635onOJ2oBu4wwtdgfH0V4E4yOptr2dacw6RiXN9NOZ1GZVveK
         Jx7fA9AfEtjx7fjw69P7I8QPpdfABXUBIYAk4JP9oRgTQOQDjQz9gyOhFByAziVprbGL
         C9IeB641SC5iYOsoiLvJRsfNXxHOb8ySYpjz3n6N6lXWSpotLahZen+oAshCLl6c17cj
         A1Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SxuFWpLUIIRucz4RDzwijrmPwByqoC27gCPg7Xmmi0U=;
        fh=XotEY5iWK5nGthp3t8vhJ3014GdJMbSatlzxE9+AD9Q=;
        b=sdu7hDo+t3IImW7RWMxdHjphn7Bq2p1bB7qzY+rUFh7LqJ5Q8TvMV6R3+FnElhAUvq
         SxQolRoY9MxQQRl9hKDpI6Xs5XInmvu/AWWQWPCiN7I556EdDGvHsB4YK4adj98YsahM
         0a1Y8uRwDfe/m1Z6LNe97ZL/5rvZoEkXUm0IcZgYOyXTUeFqMEE0HnsVrGyuX8ru1mbw
         4DHu1GCvihQufj9bbJpv+e29w1Lj729fXidqq6vIdySSG7CD3atqjxOq632AkcZrobWz
         PwKCOQT8m59V7ufZ2B7HqIah9YPXFpkngMyAIBJctrGwsXy4CjqlrMNT2ZpXjUE9o9Ze
         HX3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785151254; x=1785756054; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SxuFWpLUIIRucz4RDzwijrmPwByqoC27gCPg7Xmmi0U=;
        b=QhwfK3COjAC1y7fJEMo9b1wtoLAvDLzBqKVBluSG9xOqU30NMngys/eHekZaOF6wGY
         JfPCwh36eK2uAfUhAvwF5F/Qmgbf1GZ5XosB7y4xvRkCJUzhAvlv1AKqZ6ZJLmSk3dMj
         wajynVugJJvKT+8KXjDHKqqpXLrBAth/N+rFwQOPHgilt9c6efPKGKIDCFzKD55139XU
         P+CBaMJRTNdFGrd0zTsoLR+l77G8MAIfhWY678h3OqVc7bwe8iPnpl3UnuwdvftoLcTW
         M+BgnT5aUibFR9M83r480ZyewjZN4BhzDDqXfIZKqCvBUYIx0NzvF/1ZSpwGxvjdfn0D
         sRTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785151254; x=1785756054;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SxuFWpLUIIRucz4RDzwijrmPwByqoC27gCPg7Xmmi0U=;
        b=mWdQNm7v7+091U9vcV6M2DP4aNbEXTGUIPYxSxfaeXw5MifbC8XY2iado9BFwFlENZ
         jqHeymjUY0KnXXVHoSeVw1qcgtRnPHhGHFo+NuC2FT33xl2S2Nf0hIyc892bxR8QFPRz
         6E+BWnP7tjSevVuSOVpGWYgJCJcw920F4N5QUk61EmE4asY8MSsblAMEbI/dGyuwe9+n
         6q84sCiYWQJkhbANXC/j/IFlFEIolgsdJUFTkt5CYjSzrUPhE9jU9vo1gaZyZmCxSyjK
         HDNmoSs8pYaA66VU7ZhOZQK2r0LCoz9aEsBUw3xzJV1LJa2Qru8RMpPZSeA6+LOp3L6w
         3wew==
X-Forwarded-Encrypted: i=1; AHgh+RoNyrEaThD0Y9enFXGBhlHZFL0c30FCsKME/5dq2e74jWsPvinclprGrQzKt7xqcMtOig9uyjJS+34=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw3IDMsEk0OdYIXk6tsYXhTa0IvScndUZe66s8C4yS+GZu6fwn
	eXfv1FK3G+PiB6590XDi9kFTMGX+MS92XuZva2lCey/4DP00SxM0jn/nn4WkeLQ1rsNuEJ9dJHC
	EfgB6kXEezncBgbwBqZf0GgiG65p/9As=
X-Gm-Gg: AR+sD13si/+4WBC65AMguYmqTSNz3QUuCFznPgEJto95dQmtkcYIc5W6OkQlLuZoyoF
	V2g9KSBQKy4saGX/Qd656X5iDG29rkXABzNapfLqc4bAXcQRB9tQ8DS4/q4FWGHimE5wpwZkmIb
	QmzddgWr7VINfeVVe+MUZZ7QKpFxA8KlIAHCkgY9e3ZNpspsKcq4iTlSwkV17hXBDAgnhyp7UIt
	pVAcNAf4Xgw7GU+v5KD5NVGaY8vLvWh9Sps38wmeQI3on7xrSMC0FprT4/APE8HRVhtkbO4JFYn
	9LfnisUnUi9oW/f9gA==
X-Received: by 2002:a17:90b:1f85:b0:387:e0db:3fae with SMTP id
 98e67ed59e1d1-38f298bc8e2mr7941153a91.39.1785151254036; Mon, 27 Jul 2026
 04:20:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260725-fix2-v1-0-5c9a6ce7b96a@redhat.com> <20260725-fix2-v1-1-5c9a6ce7b96a@redhat.com>
 <d6876e8f-1414-4e7d-b6e2-1b59a18e8288@rsg.ci.i.u-tokyo.ac.jp>
 <CAMxuvawR=TiF4r+wdVCDF3Hyu-ND9neFHjUEZn5_YnSbxweXhg@mail.gmail.com> <amc7i7-2N5fgXt39@redhat.com>
In-Reply-To: <amc7i7-2N5fgXt39@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Jul 2026 15:20:41 +0400
X-Gm-Features: AUfX_mxOVrbUuUSv0c33dlx5by0nJHsS7uHAnBJxGVX1I1lAQT2jjBank9y2usE
Message-ID: <CAJ+F1CLAX7YrOQhRzA+a6W7gTeCZNqOhVqN+A8YhhywMx80kHw@mail.gmail.com>
Subject: Re: [PATCH 1/7] hw/display/virtio-gpu-rutabaga: zero-init capset info response
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Mon, Jul 27, 2026 at 3:07=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Sun, Jul 26, 2026 at 12:24:52PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Sun, Jul 26, 2026 at 11:33=E2=80=AFAM Akihiko Odaki
> > <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
> > >
> > > On 2026/07/25 23:00, Marc-Andr=C3=A9 Lureau wrote:
> > > > rutabaga_cmd_get_capset_info() only fills in capset_id,
> > > > capset_max_version and capset_max_size before sending the response =
to
> > > > the guest. The remaining fields of struct virtio_gpu_resp_capset_in=
fo,
> > > > including hdr.fence_id, hdr.ctx_id and hdr.ring_idx, are left with
> > > > stack garbage and leaked to the guest, including host pointers usef=
ul
> > > > for an ASLR bypass.
> > > >
> > > > Zero the response first, matching virgl_cmd_get_capset_info().
> > > >
> > > > Not a real risk thanks to -ftrivial-auto-var-init=3Dzero.
> > >
> > > GCC only added -ftrivial-auto-var-init=3Dzero in GCC 12, while QEMU s=
till
> > > supports GCC 10.4/11.
>
> Opps, I thought we had new enough versions already.
>
> >
> > Good point, may be we should update:
> > https://patchew.org/QEMU/20260723094622.1515831-1-berrange@redhat.com/
>
> I'm inclined to bump our min GCC/Clang versions so we can assume
> zero-init.
>
> We picked 10.5 due to NetBSD, and CentOS 9 still has 11.x
>
> In both those cases, however, Clang is available in new enough
> version to support -ftrivial-auto-var-init=3Dzero. In NetBSD
> there are also many new versions of GCC  available, only the
> base system GCC is 10.5.

Apparently it needs clang 16 from Mar 2023
(https://releases.llvm.org/18.1.6/tools/clang/docs/ReleaseNotes.html#remove=
d-compiler-flags)

>
>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>
>
