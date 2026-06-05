Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C6430566F
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jun 2026 21:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780695038; cv=none; b=BQEN+qqXu3br4E25k1vPoOxC26UZ6mNU1mLRc2yI7k3YgdKC2Zh7MMAmRYFiel+oYd0Qt9QpNpKrvjI9ltgD78SWaNHxZjrGFGQVAqZYp6ryELB+AYiYPhH/Hs2rXIMiuYzWBFw0B9SxWy1fdANkY+CEDw8PlLOk5BPMFFGw7pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780695038; c=relaxed/simple;
	bh=QqaHK/JYDe4z6MZLaxMDsS0i4WFgBpA9JvEogTV74MY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=C8M6LstNI/GLSZPlRyOcw90VykiWwtpd77Urm7HRcGU5UPX0fveIK9XB0CD1RFke7NhCTKOX05ekFey/KI9gU2bGjBgPUmyOYzTJxVWpzjncOUDFFgXC4aLZTXaQf4tqzf3iCh0h2M1CmwvviHeJU2mouK31QElHJ8gwOGC1Rgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Igfy61Wk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Igfy61Wk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46CA71F00898;
	Fri,  5 Jun 2026 21:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780695037;
	bh=cFnvNi0i55W0aFh18onNlOBrw8ZMaGcGgUwsJusvAwo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Igfy61WkNlayQc5iHRSvZUZZw6TGak9QQ0GT0ekUgYu4qKq+EwWUIeR8udARe+HY0
	 a+zeFBbhbNoGOok7jIG+/La8NleDe8GtshvDIU2EgFZuhF0YFtmz0fsGozGEKKX1Ne
	 Ahe5mKIt3YiokIZKxnnTJDyTTkHOX8f5y05u4OxzqJfDmj4A3ib6ajvwvKnAMUBt5j
	 1RuA+PgCQUDGAFjJ/5ToBzXKkvUHvzKgWJ3t/QZvMzNj1LktU6Vc8ILhupRAxiAU8g
	 J2lPOFrJlwACVh6n1wDYC6MOoFvYJkWBZCLE9ZAYbJ2LZ1nSotJafzKnG4ei9CtKKW
	 EielFq/ro0fLw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 5/9] mm/memory_hotplug: add multi-range hotunplug
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gregory Price" <gourry@gourry.net>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260605211911.2160954-6-gourry@gourry.net>
References: <20260605211911.2160954-6-gourry@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 21:30:36 +0000
Message-Id: <20260605213037.46CA71F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] If `try_remove_memory()` fails during Phase 2, the rollback phase =
irrevocably corrupts the state array and breaks the 'all-or-nothing' guaran=
tee.
--

commit 8e30dd8a7c852dc51179b28a0c0a3841cc1be525
Author: Gregory Price <gourry@gourry.net>

mm/memory_hotplug: add multi-range hotunplug

This commit adds offline_and_remove_memory_ranges() to offline and remove
multiple memory ranges atomically. It offlines all ranges in phase 1, and
removes them in phase 2, falling back to restoring online types if failures
occur.

> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 7d145217adc6b..e486d35c22b2c 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c

[ ... ]

> +	/*
> +	 * Phase 2: only once everything is offline, remove it.  This cannot
> +	 * fail as the memory can no longer be onlined in the meantime.
> +	 */
> +	if (!rc) {
> +		for (i =3D 0; i < nr_ranges; i++) {
> +			rc =3D try_remove_memory(ranges[i].start,
> +					       range_len(&ranges[i]));
> +			if (rc) {
> +				pr_err("%s: Failed to remove memory: %d",
> +				       __func__, rc);
> +				break;
> +			}
> +		}
> +	}

[Severity: High]
The comment states that this cannot fail, but try_remove_memory() can return
errors, for example if memory_blocks_have_altmaps() returns -EINVAL.

If try_remove_memory() succeeds for the first range but fails for a subsequ=
ent
range, the blocks for the first range are irrevocably removed. Does this le=
ave
the system in a partially removed state, breaking the all-or-nothing guaran=
tee?

> +
> +	/*
> +	 * Roll back the offlining if anything failed.  Blocks we never offlined
> +	 * are marked MMOP_OFFLINE and skipped by try_reonline_memory_block().
> +	 */
> +	if (rc) {
> +		tmp =3D online_types;
> +		for (i =3D 0; i < nr_ranges; i++)
> +			walk_memory_blocks(ranges[i].start,
> +					   range_len(&ranges[i]), &tmp,
> +					   try_reonline_memory_block);
> +	}

[Severity: High]
If we enter this rollback path after a partial failure in phase 2, will the
state array tracking become corrupted?

Since the first range was physically removed, memory_block_get() inside
walk_memory_blocks() will return NULL and skip try_reonline_memory_block().
Because the callback is skipped, the tmp pointer will not be advanced for
those blocks.

When the rollback loop moves to the next range, it will read from the begin=
ning
of tmp, incorrectly applying the saved states of the first range to the blo=
cks
of the second range. Can this desynchronization be avoided?

> +	unlock_device_hotplug();
> +
> +	kfree(online_types);
> +	return rc;
> +}
> +EXPORT_SYMBOL_GPL(offline_and_remove_memory_ranges);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605211911.2160=
954-1-gourry@gourry.net?part=3D5
