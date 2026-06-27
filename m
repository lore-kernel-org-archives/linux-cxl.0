Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA14D9463
	for <linux-cxl@vger.kernel.org>; Sat, 27 Jun 2026 07:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782546111; cv=none; b=OeZ7kTnWQRxx8W8e/9iU42hLJFkWR3fE9mAMrWaWkWjwZIVzB+8Vv1x5QoUx5QCnnV3z/5mtO7nqKlhNGlIDzeuBvRKhoCpxAl8cOQqtHbkrkyjJ4yBMWzU+spah5NihZQQRvNLkK9BbC5zM3MaEmRgbnlBnQVaDExBBHmfHpsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782546111; c=relaxed/simple;
	bh=kyS2JW/fT0oBSgPRU8AjQ3rqpFmJSD5dHk1iyp/e7Po=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=a5Cr/SJx9bEN99+4x6h4KH3x0e1TWGnsxwMnYoa/V+u3aNGtICTBonZc6/FocLjr+9vhwZV2LcDvcSaWF6rsOTFMffQfvjy84qEpXGLQGVVHZ4eS7z5Iz7NlUygAnhhNN8DLBtkPTAQKBdinReY6vpky0tqpUrABRT+pSfzKDTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YK7ygzpH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YK7ygzpH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66F9E1F000E9;
	Sat, 27 Jun 2026 07:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782546109;
	bh=xTqcS06Quoww3+NLCj+C2MguAzQyREC46jlaauznJOw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YK7ygzpHS5AbiT/hgCISuPQ3d6NkVSaD1oDfve8QXB+qF+zEuaEzB9Plv8lwSuZhB
	 S9USiPs/5aFIlEgRaXzP4vJ1RMIWj2MZaBXz5U+v3VtKGg2Xxs8Dumls7/qK0zw82V
	 FUsj1bTxisdpN4E5DGE3aVbZtNAt63Ty++DjbxShjhXO2OtGSYmeKb5vfquH2vdeCk
	 Xigz4q0XWzSkyTFsz/E7SSrHtq5N6Dgq5c2JoiQWQkU85S/SLkuka9xe1/ylKlA6GA
	 TO1YZJeT2r6YPWkI6xYQRRt4X5ZwANCSYXNLSQWuUDeY0+RRHY4WuWNKcmPBkuk5Ao
	 N1s/Lj4Zrr2/g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mm/vmstat: flush per-cpu node stats when a node goes
 offline
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gregory Price" <gourry@gourry.net>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260627073107.523499-1-gourry@gourry.net>
References: <20260627073107.523499-1-gourry@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Jun 2026 07:41:48 +0000
Message-Id: <20260627074149.66F9E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Recursive acquisition of `cpus_read_lock()` causes a wait-die (AB-=
BA) reader-writer deadlock with CPU hotplug operations.
- [Medium] Ignoring the `-ENOMEM` return value of `schedule_on_each_cpu()` =
causes a silent failure, leaving stats permanently orphaned under memory pr=
essure.
--

commit 195f8756c6e31f6d21c338743702f407e4ff93d1
Author: Gregory Price <gourry@gourry.net>

mm/vmstat: flush per-cpu node stats when a node goes offline

This patch flushes per-cpu vmstat deltas to global counters before a node
is offlined. It aims to prevent orphaned statistics that cause throttling
issues by using per-cpu work to synchronize the stats.

> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index f534972f517de..ad77343212d37 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -941,6 +941,16 @@ void cpu_vm_stats_fold(int cpu)
>  	fold_diff(global_zone_diff, global_node_diff);
>  }
> =20
> +static void vmstat_fold_work(struct work_struct *w)
> +{
> +	refresh_cpu_vm_stats(false);
> +}
> +
> +void sync_vm_stats(void)
> +{
> +	schedule_on_each_cpu(vmstat_fold_work);

[Severity: High]
Can this cause a reader-writer deadlock with CPU hotplug operations?

In the memory hot-remove path, try_remove_memory() acquires the
cpu_hotplug_lock for read via mem_hotplug_begin() before calling
try_offline_node():

mm/memory_hotplug.c:try_remove_memory() {
        mem_hotplug_begin();
        ...
        try_offline_node(nid);
}

Then try_offline_node() calls sync_vm_stats(), which bridges into
schedule_on_each_cpu(). The issue is that schedule_on_each_cpu()
unconditionally attempts to acquire the cpu_hotplug_lock for read again:

kernel/workqueue.c:schedule_on_each_cpu() {
        ...
        cpus_read_lock();
}

If a concurrent CPU hotplug operation takes the lock for write between the
first and second read lock acquisitions, it sets the writer-pending flag.
The second read lock attempt will then block waiting for the writer, while
the writer is blocked indefinitely waiting for the first read lock to be
released.

[Severity: Medium]
Does this silently ignore allocation failures?

Under memory pressure, schedule_on_each_cpu() can fail to allocate
the per-cpu work items and return -ENOMEM:

kernel/workqueue.c:schedule_on_each_cpu() {
        works =3D alloc_percpu(struct work_struct);
        if (!works)
                return -ENOMEM;
        ...
}

Since sync_vm_stats() returns void, this failure is swallowed. If this
allocation fails during try_offline_node(), the stats will not be flushed
and the per-CPU deltas will be permanently orphaned on a later online,
which is the original bug this patch aims to fix.

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260627073107.5234=
99-1-gourry@gourry.net?part=3D1
