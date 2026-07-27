Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7692F872
	for <linux-cxl@vger.kernel.org>; Mon, 27 Jul 2026 08:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785142327; cv=none; b=J7i/x3nFlJ32BRYXL7W8syyTyGqu7v35gob2GCGH+3donBOJFV6aOp7UIc8Zn2tAzpWEa4LbSeO+w5pSEGW1Tx8afg81xh2uyNtCT3Ur6l6EueWoyr6Z1NeCe0bp66h/8yo+b3h+Vv/LWnRpY0Ct9Hjd6xQNf8cOnnSWkXJefx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785142327; c=relaxed/simple;
	bh=Vl9GMVTVKaaromgUbmEJGn9WS9dAz0FAublPVxyPOFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=dn1r7eoIKjzpMH9bc8jY0smp/CEl/KyN75bBjlaQEm7ZHPfpY+q6LWqnmyZIkzvAYoDl5pE3ZzwZQj+e9/GMlXEOT3s/dtuXR9FmvAnHAqRomyQBSXy4h11C94BRrsT2yyBt7hS89l9TlqE1QDT+Aq9HZwuK6LblxO3+D5FCOIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bwqPa7+X; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bwqPa7+X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785142325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EGmPWZb+BE6aa3oUZZXhdk8ZQlf6vpMUZMjM2NnD8uc=;
	b=bwqPa7+XjsOtUT8Q3D0OikAAT2Wd40PiDgpcpVFEA9tePK4FfRJkuCY6ggOvXyInWQabbv
	LpMygh3xlLqhDtW9PoRnIbedUHjxXk6EM6hf3tAYMfC+pZohER8ZR+Ze2KEwzHgTU3JamI
	8sK5MjxNRTSciGMOYY6jN3ndOlmPNak=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-6bfGZ5YzM7yr8zW4FjaXdQ-1; Mon, 27 Jul 2026 04:52:04 -0400
X-MC-Unique: 6bfGZ5YzM7yr8zW4FjaXdQ-1
X-Mimecast-MFC-AGG-ID: 6bfGZ5YzM7yr8zW4FjaXdQ_1785142323
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-47f753a0aa0so1503740f8f.3
        for <linux-cxl@vger.kernel.org>; Mon, 27 Jul 2026 01:52:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785142322; x=1785747122;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=EGmPWZb+BE6aa3oUZZXhdk8ZQlf6vpMUZMjM2NnD8uc=;
        b=jLYPPdsY1RV5/FKUEoBXSVBYM+4C/9uERkf/4XwBu6Yr6mjjQVvbK5Tn/0NUw57vW7
         pz7o9ME6aiFlAQr3FD1HlaRRmLaiFBadYkAdX1d5qyWxPK8KxbhjkHlK85vNppox10BM
         cGIlnfpzTY8NPEykgpYAvFi9M9OfOW8kpSwx5owM8ucvZKKubObOjus9bA6Q4ed8h9Po
         FtvfOlN2Mbc2JhHTD4FX5Hdd8OKsQb4HQSflOR33rxMHvIrg6kZsqp3W4NXI2edZtYO5
         fkKgP1/+Vl7Oc69OEicaWjKEgAchwk7lnW5qmGWgEDeQsmZ+jkJ1lEtON8pC4EfxDwfk
         L4vQ==
X-Forwarded-Encrypted: i=1; AHgh+RoWyu61Iy5IIO2ta1ycC8dSX6IM7gyXD1CeWVn3Jyu0TD9g9k2BeVBXnZ81MAVvJCXPSNt17//68/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaajOGutFPZdG4Vgeu53H9FhCDk5mT7ZvxsRYmzg3QGEVFrnDV
	rui5WyHYjy+RrhYuWo0JRJzdewfn3rPr9fnTiLDTqKJ5iS87jClDJJOzCc/526WyJU1hRvFP227
	fdgYuqIFrDFXfxa6i6gT88dn9CuAK6MsRUbKyQQqbsQc1HQcalZktvW3Jl2391w==
X-Gm-Gg: AR+sD10Q30e/52YN/Q60PsOgutiHwhijMrj71vC2xdFS2tYYbK9GHbqZgsuziXlwa01
	af48GPS/g2WJBd2an3sHh1mBh0se5u/hCNDT6D8x1bn5JmaoTv36EZ0KyYOUuI+TjQkj7YRVUuG
	MAdoE4RlO2fvT14+eQNIhtKRDd4ThIfVLoXIwg0NGzLJFl5oT1PsywSrtkvtwDdT5ThoHBnAl3s
	NEYCRlQ5Ru5pNbzcf1CpDaBmDGSIwwfUKImzcGGreShJCbEVx5SW2jv4m/z5obPHxnEWqR7NeoD
	LMlNfpxHnVDpem945hzh0OZsocTygBG4Zluk+Y0AaYu92HI1HnNgfkqwXIX3YyFVv8yy6rwdI7d
	UzhCgo2FCep2qzOVjkYUKUA==
X-Received: by 2002:a05:6000:1883:b0:47f:9447:62bf with SMTP id ffacd0b85a97d-47f9fc8665bmr9304566f8f.2.1785142322446;
        Mon, 27 Jul 2026 01:52:02 -0700 (PDT)
X-Received: by 2002:a05:6000:1883:b0:47f:9447:62bf with SMTP id ffacd0b85a97d-47f9fc8665bmr9304504f8f.2.1785142321791;
        Mon, 27 Jul 2026 01:52:01 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c6e9a2sm49073219f8f.35.2026.07.27.01.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 01:52:01 -0700 (PDT)
Date: Mon, 27 Jul 2026 04:51:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,
	Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
	Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
	qemu-block@nongnu.org, Jonathan Cameron <jic23@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
	Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Roman Bolshakov <rbolshakov@ddn.com>,
	Phil Dennis-Jordan <phil@philjordan.eu>,
	Wei Liu <wei.liu@kernel.org>, linux-cxl@vger.kernel.org,
	Brian Cain <brian.cain@oss.qualcomm.com>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@mailo.com>,
	Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
	Haotian Jiang <jianghaotian.sunday@gmail.com>
Subject: Re: [PATCH v2 00/12] Fixes for 11.1
Message-ID: <20260727045129-mutt-send-email-mst@kernel.org>
References: <20260727-fix2-v2-0-d0c4831ed7ea@redhat.com>
 <20260726164912-mutt-send-email-mst@kernel.org>
 <CAJ+F1CKGxeSiRR6YWvYNUHYhO9kgfASUTPsA9HC4QBDhm_TZQw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CKGxeSiRR6YWvYNUHYhO9kgfASUTPsA9HC4QBDhm_TZQw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _1zLvoOCGM7YA8V8teR0lrkX8JR4o31yHUwoXuAeCO4_1785142323
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Jul 27, 2026 at 01:08:28AM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Mon, Jul 27, 2026 at 12:50 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Jul 27, 2026 at 12:43:59AM +0400, Marc-André Lureau wrote:
> > > Hi
> > >
> > > Here are some assorted patches worth considering for the 11.1 freeze
> > > bug-fix period.
> >
> > why are these in a single patchset? who is expected to merge it?
> 
> Given that they are kind of general coding fixes, I think I can send a
> PR once the patch are reviewed.

I have no problem with that just pls mention this down the road
when it's ready.

> >
> > > Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> > > ---
> > > Changes in v2, after Akihiko comments:
> > > - split the "Fix many -Werror=maybe-uninitialized" patch
> > > - qdev-monitor: add drain_rcu parameter to avoid deadlock from virtio-net
> > > - rewrite WITH_QEMU_LOCK_GUARD/WITH_RCU_READ_LOCK_GUARD macros to suppress
> > >   GCC false-positive warnings (new patch)
> > > - block/blkio: use QEMU_LOCK_GUARD instead of WITH_QEMU_LOCK_GUARD in
> > >   getlength() to avoid false-positive (new patch)
> > > - hw/cxl: split invalid-free fix into its own patch
> > > - hw/i3c: fix default return value of d2_i3c_send() (new patch)
> > > - hw/ppc: fix dangling machine->fdt reference after spapr fdt updates (new patch)
> > > - Link to v1: https://lore.kernel.org/qemu-devel/20260725-fix2-v1-0-5c9a6ce7b96a@redhat.com
> > >
> > > ---
> > > Marc-André Lureau (12):
> > >       hw/display/virtio-gpu-rutabaga: zero-init capset info response
> > >       block/blkio: fix error return value on getlength()
> > >       block/blkio: fix compiler false-positive warning
> > >       include/qemu: adjust LOCK_GUARD macros to avoid potential warning
> > >       hw/cxl: fix invalid free on early return
> > >       hw/i3c: fix default return value of d2_i3c_send()
> > >       Fix some -Werror=maybe-uninitialized
> > >       hw/hexagon: fix machine->fdt leak in qom-test
> > >       hw/ppc: fix dangling fdt reference
> > >       hw/core/machine: free machine->fdt in machine_finalize()
> > >       migration/multifd: fix Error leak in multifd_recv_terminate_threads()
> > >       qdev-monitor: drain RCU callbacks in qdev_device_add_from_qdict
> > >
> > >  include/monitor/qdev.h           |  3 ++-
> > >  include/qemu/lockable.h          | 19 +++++++++++-------
> > >  include/qemu/rcu.h               | 17 ++++++++++------
> > >  block/blkio.c                    |  7 +++----
> > >  hw/audio/intel-hda.c             |  2 +-
> > >  hw/core/machine.c                |  1 +
> > >  hw/cxl/cxl-host.c                |  2 +-
> > >  hw/display/virtio-gpu-rutabaga.c |  2 ++
> > >  hw/hexagon/virt.c                |  9 +--------
> > >  hw/i3c/dw-i3c.c                  |  2 +-
> > >  hw/net/virtio-net.c              |  2 +-
> > >  hw/ppc/spapr.c                   |  1 +
> > >  hw/ppc/spapr_hcall.c             |  1 +
> > >  migration/multifd.c              |  1 +
> > >  system/qdev-monitor.c            | 42 +++++++++++++++-------------------------
> > >  target/i386/cpu.c                |  3 ++-
> > >  target/i386/emulate/x86_mmu.c    |  4 ++--
> > >  17 files changed, 59 insertions(+), 59 deletions(-)
> > > ---
> > > base-commit: 300438ffbb8d9430cac2fcc15cba6f482b2c0587
> > > change-id: 20260725-fix2-6e51d231794b
> > >
> > > Best regards,
> > > --
> > > Marc-André Lureau <marcandre.lureau@redhat.com>
> >
> >

