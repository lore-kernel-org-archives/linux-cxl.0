Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB5E3346A8
	for <linux-cxl@vger.kernel.org>; Sun, 26 Jul 2026 20:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785098988; cv=none; b=XDJDY/mOkSB5mpbGEFdYa5GdafhjLIqVO1qQndD4qR+iNa19OG6txgtSMKKR04CS4gEEihSa00UM9l8L6tIlQZAdg44NQVLBNn3Ty/bLW0VLiZdm47cZTrqiEvgxdrLtVif80oGi6bVo2vKwVl6YPIy/F09N6ksa8VvEerJ8tHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785098988; c=relaxed/simple;
	bh=mWboKmFEVOTgptkYnfgwi01dUJXrWJkaM86S5xSW8vk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Z+lc0/ey5uEJ8x3ceYyILTvjjRyI/GmD/TVn7DoxFR5a5dFpcQIlh0Mz4QxxbtDKkezYA3JogNapp1ZQ5s1C3Blm4mXd9MeBisyS25SaKybMgjG98JjvvPG80Ya5bn6qF50JN0Cj1sZoI9zLDvx0uV3eYMvepjRn7Gfx3y69MQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fjl5oN6N; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fjl5oN6N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785098986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O/Tm9yhkqwWEhTtYSumLxou7IC247EQO+9etCC0bbB4=;
	b=Fjl5oN6N7riAUh1M/KkUfalMUriwNcPhNpfuEMykbrW4y/oUeZlkGw0q4zLAPtSthT7pSv
	Zta78wUbmIlXbK95zqCLyG4ljC7EQvYbQcPU6CX/fB5fdxTWbSi5Hwl0Q1FiYhYQfyWPM1
	E640/PLQoA9X9FNvTFGbo5dYcj47EZA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-pvMqsbCRPmq-VTM4E9J17Q-1; Sun, 26 Jul 2026 16:49:44 -0400
X-MC-Unique: pvMqsbCRPmq-VTM4E9J17Q-1
X-Mimecast-MFC-AGG-ID: pvMqsbCRPmq-VTM4E9J17Q_1785098983
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4956c1655c3so9679975e9.0
        for <linux-cxl@vger.kernel.org>; Sun, 26 Jul 2026 13:49:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785098983; x=1785703783;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=O/Tm9yhkqwWEhTtYSumLxou7IC247EQO+9etCC0bbB4=;
        b=jM0HGhbqEQHVoi7Ld+tp2NdS900gI/IizXNrHxs9C3X93dnNV5o8bKyOvwjICkTUex
         2sDyYbEcyrRRQFZFnlHKfDq+TY2VuVQYJ3T5L9HG1b1sAobjUbkmWXgiU+iDVbtuBczv
         mfvA2m0HK8QTRxgN1oA75RnrPD3ZII/TA/yrYJiutfPhXpLE9KgEzksnOlAShbcUrvHH
         WNJ7MPZ3oZUrm/7lHawSgnyURHNZeJJCE9SiZ3oPrXPiea0+9cqmAx4v9KzCE20uk7Zm
         d7kxH3xPGPvSFS8w0cJS/NEsCNzECmJKixFN9VDwVKaUTxrm431jPEVP5SCqN3w1X2au
         MM8A==
X-Forwarded-Encrypted: i=1; AHgh+Rp0aCCB/bJuZd1LsncQ+P7bRq+VjXkewJzZ6qdLNPlRlGFyLVsjZU8tm1PCrsy46Rk/bmbGX/8rqBM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/fGf9h44NyTwkNzPXfNY6YgaVIMT++mxEN0O08ZaeQ5GA0rEP
	tGtIgnGVcu+BoTHNWGbQ2qYNXpAUHugOQG9uvHq2FOOoVt723pO6r5HRuZjTs/lXzVC73Ir14Fn
	iSrdGNGvS8925e7H2lH1lz36rkGDyjkcaXODjmQwpp8ibGoueQD6cKEFDZPyE/A==
X-Gm-Gg: AR+sD11lJeUY2vtDt/59Y10PKjxRjXmPd+9M4MCrA1p+EsbS8s6YulupP+cZdeyA9yK
	7uXqLilqyYKz+bhlRmHoJZGUr8iUripR+7IwQHyQUVY0imXs13NIkylvdtnm69qMGCZ6l5qKSN+
	BHKogljDFAldyk35HYNzBc8YjFKh++U2whrfCoyKDBrz7N99QCl7gyCBXDPMSMFzzSBjesEKuP3
	wiMb1ZnuCS1dkldS/g9aEXCfTb1/ot3F1HRgFWUlhARXUknYJkD5hiJvRPKeSvOBuRsoqVkqvWg
	qYSfF/uw/ZUNSfGrGek/Qoolnt3fbL8FRK8QUs27HmlX9baAzAK0qyCroO5RFRcMJFL7gfV/1Ma
	VvhdGa8r566i3+ujWzPIetw==
X-Received: by 2002:a05:600c:5487:b0:495:641a:fffe with SMTP id 5b1f17b1804b1-496ba3b1b10mr45832355e9.39.1785098983369;
        Sun, 26 Jul 2026 13:49:43 -0700 (PDT)
X-Received: by 2002:a05:600c:5487:b0:495:641a:fffe with SMTP id 5b1f17b1804b1-496ba3b1b10mr45832185e9.39.1785098982899;
        Sun, 26 Jul 2026 13:49:42 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957b5f35a1sm179200355e9.0.2026.07.26.13.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 13:49:42 -0700 (PDT)
Date: Sun, 26 Jul 2026 16:49:37 -0400
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
Message-ID: <20260726164912-mutt-send-email-mst@kernel.org>
References: <20260727-fix2-v2-0-d0c4831ed7ea@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260727-fix2-v2-0-d0c4831ed7ea@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Ah3Dz63AlmI7BHv8z2JzU5ojspqnT39u9FoABqUbUqk_1785098983
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Jul 27, 2026 at 12:43:59AM +0400, Marc-André Lureau wrote:
> Hi
> 
> Here are some assorted patches worth considering for the 11.1 freeze
> bug-fix period.

why are these in a single patchset? who is expected to merge it?

> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
> Changes in v2, after Akihiko comments:
> - split the "Fix many -Werror=maybe-uninitialized" patch
> - qdev-monitor: add drain_rcu parameter to avoid deadlock from virtio-net
> - rewrite WITH_QEMU_LOCK_GUARD/WITH_RCU_READ_LOCK_GUARD macros to suppress
>   GCC false-positive warnings (new patch)
> - block/blkio: use QEMU_LOCK_GUARD instead of WITH_QEMU_LOCK_GUARD in
>   getlength() to avoid false-positive (new patch)
> - hw/cxl: split invalid-free fix into its own patch
> - hw/i3c: fix default return value of d2_i3c_send() (new patch)
> - hw/ppc: fix dangling machine->fdt reference after spapr fdt updates (new patch)
> - Link to v1: https://lore.kernel.org/qemu-devel/20260725-fix2-v1-0-5c9a6ce7b96a@redhat.com
> 
> ---
> Marc-André Lureau (12):
>       hw/display/virtio-gpu-rutabaga: zero-init capset info response
>       block/blkio: fix error return value on getlength()
>       block/blkio: fix compiler false-positive warning
>       include/qemu: adjust LOCK_GUARD macros to avoid potential warning
>       hw/cxl: fix invalid free on early return
>       hw/i3c: fix default return value of d2_i3c_send()
>       Fix some -Werror=maybe-uninitialized
>       hw/hexagon: fix machine->fdt leak in qom-test
>       hw/ppc: fix dangling fdt reference
>       hw/core/machine: free machine->fdt in machine_finalize()
>       migration/multifd: fix Error leak in multifd_recv_terminate_threads()
>       qdev-monitor: drain RCU callbacks in qdev_device_add_from_qdict
> 
>  include/monitor/qdev.h           |  3 ++-
>  include/qemu/lockable.h          | 19 +++++++++++-------
>  include/qemu/rcu.h               | 17 ++++++++++------
>  block/blkio.c                    |  7 +++----
>  hw/audio/intel-hda.c             |  2 +-
>  hw/core/machine.c                |  1 +
>  hw/cxl/cxl-host.c                |  2 +-
>  hw/display/virtio-gpu-rutabaga.c |  2 ++
>  hw/hexagon/virt.c                |  9 +--------
>  hw/i3c/dw-i3c.c                  |  2 +-
>  hw/net/virtio-net.c              |  2 +-
>  hw/ppc/spapr.c                   |  1 +
>  hw/ppc/spapr_hcall.c             |  1 +
>  migration/multifd.c              |  1 +
>  system/qdev-monitor.c            | 42 +++++++++++++++-------------------------
>  target/i386/cpu.c                |  3 ++-
>  target/i386/emulate/x86_mmu.c    |  4 ++--
>  17 files changed, 59 insertions(+), 59 deletions(-)
> ---
> base-commit: 300438ffbb8d9430cac2fcc15cba6f482b2c0587
> change-id: 20260725-fix2-6e51d231794b
> 
> Best regards,
> --  
> Marc-André Lureau <marcandre.lureau@redhat.com>

