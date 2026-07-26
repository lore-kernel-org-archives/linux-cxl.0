Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AA9218AB9
	for <linux-cxl@vger.kernel.org>; Sun, 26 Jul 2026 21:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785100123; cv=pass; b=mCUNT0kHfdKqNvLx7CU5xRhWObNaThhPK1R5uroYW65mbF/zLZkFDwwiSkQrY1VJyjNRNFc8yaSC+gam7eioxeikTiCBGetSDT2ySZv2gTFaCla9Jnt/+tpHZQL4G0qfG+zBwcksDLND1VviT/PcrS5LA0LAL5nchHEU3jQFb4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785100123; c=relaxed/simple;
	bh=zUxGnR3HZUwJ+Mae7B4pX3Qb8WqN8yH3yg4xW6sZ/Sc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T+EAATesHlvkUEOM/KqvIRFq37jEtfE8+JxaqybhxGZteGvHUByvJZUSL1PInSZNwd70EzBBk/IwB8uVTBWcYsQ+RLciyK5bJaEBzPPsUTe11QrhhK24XbMSkKgOwQTwcfWmD2TNCd87so3YbuV+J0LxvXxfKjFufCbBGxUzaJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bXHwYFCP; arc=pass smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bXHwYFCP"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38dcbade417so2155712a91.1
        for <linux-cxl@vger.kernel.org>; Sun, 26 Jul 2026 14:08:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785100122; cv=none;
        d=google.com; s=arc-20260327;
        b=Ns5lvmvVwThw18Quh9p5PaaSR1+uLeuXvWi37CA19ONCw42jMOotFVcIuJOuCEgd0t
         JMArZxZjVcRLVgI3mTwGNTy14RRvik23P9Usy/mvdSRrZGj2QSDcKoVqtt96nXJfDuOs
         YGDiaG+0WXankSztlSVvkKPQy2H+wIhSxYH9niLWpSzwLaTS8lcFqNUdiZUc6m6PVnME
         MQrer5xfws+O9dFj10AcUizwRBtlPs5BUPMQwk1z8pO4f6cXrjghI+7FBCUUyrJhxvuM
         +5kZSO8zhUD7UlESyrW04I287HWG2FfQlQH/2CIOQmnbzgznuAfGm7TDOi6zFvUaokZ3
         m7vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3Rp8HAAPCsWVJammpH6MnWmCqSIAb+JYc0EJRNZOl2c=;
        fh=vU9ihjgIppsrQgubaEc3UZZmH4kl43KdXT6m6zvCWRE=;
        b=qYHj4fPbD9d4BKA1//I1wZT10G03H4cqay2U5MzInpvjwyX0W9/lsV38SbM7Xvxja1
         VP4Z27bzNDFdtRUnm+eF5ODckd8h41HaeVas6mldkYXS5cv9lroGBKhDj6H1OSmt4MOP
         EooK8BaiF48Hfs/Twddkdw1JotMePqXjLVpS6Q29fefTKxmOx3v2kihXfJzdqqek6nv6
         7HqlioS3iAYR5WSbF4HtRjgPNhxDojOhILtz9pHPgGY57ZcqfJI1W32uIMBwpKbx2KIN
         sVMSBia/lrXbc4fU/M33UukGQBHFrhmWa3k8dFg4hak5dagoz3j0KMu1EYE/PpuBOm2x
         /HZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785100122; x=1785704922; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3Rp8HAAPCsWVJammpH6MnWmCqSIAb+JYc0EJRNZOl2c=;
        b=bXHwYFCP3BkDqy9LsWbC5/moDuDE7XNknNBztqJ2jYFgCRA7URnk38HoSVMb0yc1pz
         JDOAG0+o2Q94k1G02xTPhs7ca6AwQdxodrLZjY96xlipn4jj3Oi200/aB5CXsipTQF0B
         eYAlxrIe0VLR+hxIVm6l2lHbRrtwUstXWNfzDYWINYBFCIBa+zXVaTrXCm4RnE58Cs+/
         cM7RB+emIWu6RDYXglKVG0kd8WogZCDa/J0oeRUuQrda4mHU4OmkeUg6WxU/gtBXouK5
         M3cumT5I5zjLdS4SS2T44C3J9s6VTW08obKNMOoD0RtBl3XKJuL6vhQJDp/5MoG6yw1X
         doMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785100122; x=1785704922;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3Rp8HAAPCsWVJammpH6MnWmCqSIAb+JYc0EJRNZOl2c=;
        b=MIpOj8Kwaw6w1m6nq9ReI6ByurB8hBvZNP4Nurckpu/90nKbb7qFmVRotjbvrvSUlN
         B4FcWY1HWWO+E08FzatlhqGSCG+uw7PGj8hjJ0JYEWqvLZXb7ytW96HVwUDnge7yMUm9
         IY6y6XoPrpeKa0Bi7fXr9LKD7JMeEv6+Lvb08Be3ID/0rzy2uCioAH/aSuvk5qrbZoCO
         OsEq1URLN5bi4UW11TJPl6KaHWnKtVIG5pm/3325tbG/1t7g0u8KD5/7qkAz7mdTUBhe
         8wY8fbwI5HYKhC5T0b2CpDkt3VOQqGIQY2VVvoy79VluXgYAuH5U5lj9XqhUPipm5+ny
         ZYpg==
X-Forwarded-Encrypted: i=1; AHgh+RqwiJ/Msfxg0PGKI75zgePbMTx7iyRcPKEbO1s+PIRHV23ONgi83TBY5IW6jH7nCcOWUHGbdsOgeEo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD1WKbKJXYlx21z/Br7ehMQbNhWPBrjR9jfRXgJzE912/GR4G2
	ylBtsULM7qnSx6JYoN6qPzcwqGBHcAa2+f7euVg1HEycJKkz7H0++0KvW8zpV9VBuWtVrQXmnLu
	rFhCc9sVH/0z26dLQZUAgOFn8Td0KRyM=
X-Gm-Gg: AR+sD12wxDUgcVXupA6pzYCKoHvVaH2g82PBsV/nTGEnZSe5R8mhAUDR8fFlWXkg4M9
	ylsY7JXRQJmFXrLpolppQadcDnJfBY2PmsXBPAaA/fXscKtde7wII9bGM/jLZW0IfhmxA1QHnqt
	OSVy78VVeRgBZ3+GjVK2Z4CylFH6XXB0G4cuhw9dygk4QfPSSXGZeN8bpztxS82KkiB0bdzxUGv
	sx0wd5jUV8fN7cucIxi6T/O0gY52lAXMO5v9RwuDYg69p3vREA+31u6np7VYcpxlhfsIm82r8MC
	+x+iNL1xQVkxiSg8tA==
X-Received: by 2002:a17:90b:2701:b0:38d:e658:5959 with SMTP id
 98e67ed59e1d1-38f293cff43mr5572450a91.5.1785100121685; Sun, 26 Jul 2026
 14:08:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727-fix2-v2-0-d0c4831ed7ea@redhat.com> <20260726164912-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260726164912-mutt-send-email-mst@kernel.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Jul 2026 01:08:28 +0400
X-Gm-Features: AUfX_mwdOjQjgAriyvr_4G-3RpsS6Vdo9nLW5Pzqi6pYb1OWJfbiy3twwqvDpWM
Message-ID: <CAJ+F1CKGxeSiRR6YWvYNUHYhO9kgfASUTPsA9HC4QBDhm_TZQw@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] Fixes for 11.1
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
	Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
	Dmitry Osipenko <dmitry.osipenko@collabora.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org, 
	Jonathan Cameron <jic23@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
	=?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
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

On Mon, Jul 27, 2026 at 12:50=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Mon, Jul 27, 2026 at 12:43:59AM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > Here are some assorted patches worth considering for the 11.1 freeze
> > bug-fix period.
>
> why are these in a single patchset? who is expected to merge it?

Given that they are kind of general coding fixes, I think I can send a
PR once the patch are reviewed.

>
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> > Changes in v2, after Akihiko comments:
> > - split the "Fix many -Werror=3Dmaybe-uninitialized" patch
> > - qdev-monitor: add drain_rcu parameter to avoid deadlock from virtio-n=
et
> > - rewrite WITH_QEMU_LOCK_GUARD/WITH_RCU_READ_LOCK_GUARD macros to suppr=
ess
> >   GCC false-positive warnings (new patch)
> > - block/blkio: use QEMU_LOCK_GUARD instead of WITH_QEMU_LOCK_GUARD in
> >   getlength() to avoid false-positive (new patch)
> > - hw/cxl: split invalid-free fix into its own patch
> > - hw/i3c: fix default return value of d2_i3c_send() (new patch)
> > - hw/ppc: fix dangling machine->fdt reference after spapr fdt updates (=
new patch)
> > - Link to v1: https://lore.kernel.org/qemu-devel/20260725-fix2-v1-0-5c9=
a6ce7b96a@redhat.com
> >
> > ---
> > Marc-Andr=C3=A9 Lureau (12):
> >       hw/display/virtio-gpu-rutabaga: zero-init capset info response
> >       block/blkio: fix error return value on getlength()
> >       block/blkio: fix compiler false-positive warning
> >       include/qemu: adjust LOCK_GUARD macros to avoid potential warning
> >       hw/cxl: fix invalid free on early return
> >       hw/i3c: fix default return value of d2_i3c_send()
> >       Fix some -Werror=3Dmaybe-uninitialized
> >       hw/hexagon: fix machine->fdt leak in qom-test
> >       hw/ppc: fix dangling fdt reference
> >       hw/core/machine: free machine->fdt in machine_finalize()
> >       migration/multifd: fix Error leak in multifd_recv_terminate_threa=
ds()
> >       qdev-monitor: drain RCU callbacks in qdev_device_add_from_qdict
> >
> >  include/monitor/qdev.h           |  3 ++-
> >  include/qemu/lockable.h          | 19 +++++++++++-------
> >  include/qemu/rcu.h               | 17 ++++++++++------
> >  block/blkio.c                    |  7 +++----
> >  hw/audio/intel-hda.c             |  2 +-
> >  hw/core/machine.c                |  1 +
> >  hw/cxl/cxl-host.c                |  2 +-
> >  hw/display/virtio-gpu-rutabaga.c |  2 ++
> >  hw/hexagon/virt.c                |  9 +--------
> >  hw/i3c/dw-i3c.c                  |  2 +-
> >  hw/net/virtio-net.c              |  2 +-
> >  hw/ppc/spapr.c                   |  1 +
> >  hw/ppc/spapr_hcall.c             |  1 +
> >  migration/multifd.c              |  1 +
> >  system/qdev-monitor.c            | 42 +++++++++++++++-----------------=
--------
> >  target/i386/cpu.c                |  3 ++-
> >  target/i386/emulate/x86_mmu.c    |  4 ++--
> >  17 files changed, 59 insertions(+), 59 deletions(-)
> > ---
> > base-commit: 300438ffbb8d9430cac2fcc15cba6f482b2c0587
> > change-id: 20260725-fix2-6e51d231794b
> >
> > Best regards,
> > --
> > Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
>
