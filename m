Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E704737A4A1
	for <linux-cxl@vger.kernel.org>; Thu, 12 Mar 2026 15:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773327627; cv=none; b=D9epQ9lkRv1DKp4ge4K44Kso7JfN2FiXJw6hxTmbDfSfo4zSTIx1d7sa/guae4Ha4zhqxAdTkLUQ5MHw28WapfaN3+aipYSeXKWoiXYdha/P2U9GZ0rXTw3sdxgvjnj24XIlESVNGstBzXDcUBAo0p3y3KwitKVqQkLYeCKKAhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773327627; c=relaxed/simple;
	bh=pWUbhL2zoGO87RRhtrhVc8jBxHda6fWQH+gtdvXkW4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=htSOHtU1bkOjxFrrdRO+roDIK4DuuqJNbV4M3QoB0XlSXrWV0aV04y94bmFdvoVD61hSmFpgjWzeaGR2a/Ua7kWVKGsxbumeMBHo8rVX6L2T+jTWnxkwx/aXoVgTIOiC+Bkwhtm3JCQDbomY6PAvnBrI02PnAeyT9YXhJQ4uqnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JLjDAmaA; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JLjDAmaA"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-40f0e14b9f9so805771fac.1
        for <linux-cxl@vger.kernel.org>; Thu, 12 Mar 2026 08:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773327625; x=1773932425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zZGtiJN9y4ZZ4JfI9NE8H692/RL57MUDkhcDsED4q1E=;
        b=JLjDAmaAUEhTK6978cavZF4TY/7sj1L8VloEgXpcTD157sXaG8Q2HxNsSTxqdNhywM
         t4jnEWM1JO9J/PGu1xqKRBi5WwYJekAAnPPKSx+qRwP/pkXeZg/1piCh1DMS/z3uBWxW
         V8Hre82qU8c1K5oVpD9JfPrB5OzN77TNX8cCDByNIL/CZBUSlXwHFbEoW1jfrDrua60M
         tUqeNHfg8MJRjRlFrOf1GKuYt1+AjQl7rTafV8+f8eOTZvTedWA359xT+vfbvdb7NfP5
         EtfnJ1nEfRW5kKgdJIz/oBN++UwvqKiN35iJi9Eg5ExEhataLlQHI6jcGRgL7AncLDEb
         fQ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773327625; x=1773932425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zZGtiJN9y4ZZ4JfI9NE8H692/RL57MUDkhcDsED4q1E=;
        b=dMbr8kH9HVqrVU4+4oC8wylX/kJD8SJmkccK/v7njRQED/YewU56xH0laQn8BdSjdh
         RDrwcN52/fPCLYxkb7IsEwlFCSh2CtiykXmCRLI9iary+WHVYGHtSIoB0YflJ+KMtVH/
         irX1m8rx5EseGbPNiycogloJe4iTaLJ203Kjl3E4DejKHrvf7RtVzozcGd7SjXdo/NPz
         bfvpkmPNz3keFlS2/jFmgujOpgsQq6VdeS/rpIAYN/X5mDFr65iPezMhatC0CcI+cS3T
         CE4mCNIHj6c1l11MWyPhtHiMUkEqAlKzOXst9wpU0QtSjfn9WokMinGAO/tl8Y3jfxIn
         vUMw==
X-Forwarded-Encrypted: i=1; AJvYcCXh4aQO55V7LKH/hJ57OtosW+vnBMKk1QkAu7iB9DPvDlA5plASCBUMHVHv5cL0wLVm3Ro3HAwoC70=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg+n26R3oW7wRzdCySe3pjTmNJdZajB3U+3RmisQW/6dDskqP+
	Mo4WCPRhRUy/ROYOMd4uM6e5a34z+PosTlEplEDGxSKyItPlGGWF0uohsFsXRw==
X-Gm-Gg: ATEYQzwOChAwSuusrkoLRDpc4WgyklvjEaGwQN3o1WXClp4q/IZA4ydWPyOvOMFaClQ
	I1KQItsqv5Q9BhS3eFthg9ZDZDc7MC1t6TFX//F7LdsbdWkGfXGMWNr6M/GvpBqCaQGuONw1fW0
	Wp3d32XNr0/NUCQgl2MGLwYgGEC9E5kJ8JUfvbjZRAM6Jhln/Y/PQNhRfu/eYB6MVh3MLgeDlSP
	rxi1/VG9Q1HvHaeIuEAyUnal2LBPbFqZmMnQc979SkrpfuxV8DDRBQabmSKOqJYUJbQhGwruIvR
	gx8FH8Jz57C0SmLz5KUt9rL7dIoCXJHkovNplpOdcw6mAPOZza120+zJRFZbYBL6paqFRpLexuC
	nwCBsSwoLi0F3dDZz38pJHX7HqN4jVcmgrW72PifwvmRvBHiirKNeCwg78OMnOSGHCiRj60qwxI
	HItttDBQ9AJ9UgKjD1xLFt+6mi0w4VR3I=
X-Received: by 2002:a05:6870:798d:b0:409:9a0b:b733 with SMTP id 586e51a60fabf-4177c5d49d7mr4215501fac.10.1773327624652;
        Thu, 12 Mar 2026 08:00:24 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:6::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e5e9f53sm5583147fac.13.2026.03.12.08.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 08:00:24 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: YeeLi <seven.yi.lee@gmail.com>
Cc: akpm@linux-foundation.org,
	david@kernel.org,
	dan.j.williams@intel.com,
	ying.huang@linux.alibaba.com,
	linux-mm@kvack.org,
	joshua.hahnjy@gmail.com,
	linux-kernel@vger.kernel.org,
	Jonathan.Cameron@huawei.com,
	linux-cxl@vger.kernel.org,
	dave.jiang@intel.com,
	gourry@gourry.next
Subject: Re: [PATCH] mm/mempolicy: add sysfs interface to override NUMA node bandwidth
Date: Thu, 12 Mar 2026 08:00:21 -0700
Message-ID: <20260312150022.1373486-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260312091207.2016518-1-seven.yi.lee@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 12 Mar 2026 17:12:07 +0800 YeeLi <seven.yi.lee@gmail.com> wrote:

Hello YeeLi,

I hope you are doing well! Thank you for the patch, I think it is an
interesting and helpful debugging tool.

> Automatic tuning for weighted interleaving [1] provides real benefits on
> systems with CXL support. However, platforms that lack HMAT or CDAT
> information cannot make use of this feature.

Thank you for the kind words : -) I'm also CCing Gregory Price, who
is the original author of the weighted interleave mempolicy.

> If the bandwidth reported by firmware or the device deviates from the
> actual measured bandwidth, administrators also lack a clear way to adjust
> the per-node weight values.

I just wanted to touch on this. Is this true? Weighted interleave already
exposes sysfs that lets the user set the weights they want. On one hand
I think it would be helpful for there to be a tool to see what the
effects of setting bandwidth information on a system could be, if it
had other side effects. I'm not sure if there is a strong case to do this
purely for weighted interleave auto-tuning, which already has a manual
weight override and pretty simple calculations : -)

> This patch introduces an optional Kconfig option,
> CONFIG_NUMA_BW_MANUAL_OVERRIDE (default n), which exposes node bandwidth
> R/W sysfs attributes under:
> 
>   /sys/kernel/mm/mempolicy/weighted_interleave/bw_nodeN
> 
> The sysfs files are created and removed dynamically on node hotplug
> events, in sync with the existing weighted_interleave/nodeN attributes.
> 
> Userspace can write a single bandwidth value (in MB/s) to override both
> read_bandwidth and write_bandwidth for the corresponding NUMA node. The
> value is then propagated to the internal node_bw_table via
> mempolicy_set_node_perf().
> 
> This interface is intended for debugging and experimentation only.

Thank you for the helpful clarification. Just to be sure, are there
other intended things that the user can test other than what weights
weighted interleave would resolve to?

Thank you again for the patch, I hope you have a great day!
Joshua

> [1] Link:
> https://lkml.kernel.org/r/20250505182328.4148265-1-joshua.hahnjy@gmail.com
> 
> Signed-off-by: yeeli <seven.yi.lee@gmail.com>
> ---
>  mm/Kconfig     |  20 +++++++
>  mm/mempolicy.c | 148 +++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 168 insertions(+)
