Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16FA4071F9
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jun 2026 21:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780694957; cv=none; b=tw+R7/xQySxA3+NnnNHcm71cFqoS/WznWwCfM9575y1PVCrUWp/xU3mgl5Uw6Z+o3ExWXYvRgfQozQNnN8uc9SefJsTl/8wZMZ3eAlRR2WCjb60jIdZjxO1rv1oeyCBipX5z1Wv7MU2MFj9mqQAI4emBsj6aoNGsoSgNeqZiFh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780694957; c=relaxed/simple;
	bh=AUfeA7X/a4gH+TyTqTy9dD1AolUe2pFRk/hU4JgBiC8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=niOTOzIkWBdMFlUaJPhHPVC24+CS2cdwCjC9C7RqePK5kH+ghHUZpS/2H2JV3MsfmUSbYMnnHMPiRAO3lHz73/AgLA/9aWUcw3NUzM9MfNu3LscJvNwrfxAKCbqzoEHX76rrX7wcO2bcEONCyzB/2zYehrAwz/ZqRTACbBftd6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ei5T/Kqx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ei5T/Kqx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B3591F00893;
	Fri,  5 Jun 2026 21:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780694956;
	bh=6rCHSOtowEQq9VcKg/jGty4/6DETqe35WZuxqYDa0bA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ei5T/KqxA9+K2LUgceY/rCwf98Y+nX4OJmDeBrWATLFXewnfSP6UUAo3mmA4uQtFz
	 8/mHq+yQWyvfuV9FLE1wkVva29uva57czwxWXXiZrwkZ46R1h+2OoSPwgBYX8ZYJUE
	 o0guvNtOo5ovkU7aKb6TRftb1hNsiwe/pxiPTbK7vw8g6Dr4hlDlnEfg8fEucgl3Gk
	 kddetgqc3eQ8mvHyTWWElOWYJkVly6ayBKe0LYX5AjxRngGZdaTWNUa/QknU8ON/PE
	 l9/QX7vPZcMqQHE85ftNdDCXOaBR1j8fSQBP096NT5isi/AN40sWrvmAIAqIXB673b
	 RfqTxWWS8QIMQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/9] mm/memory_hotplug: export
 mhp_get_default_online_type
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gregory Price" <gourry@gourry.net>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260605211911.2160954-4-gourry@gourry.net>
References: <20260605211911.2160954-4-gourry@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 21:29:16 +0000
Message-Id: <20260605212916.7B3591F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Lazy initialization of `mhp_default_online_type` can race with sys=
fs updates, silently clobbering the user-specified hotplug policy.
--

commit 7d00f30f087affb00391db7c7b27504af6cf3ac3
Author: Gregory Price <gourry@gourry.net>

mm/memory_hotplug: export mhp_get_default_online_type

Drivers which may pass hotplug policy down to DAX need MMOP_ symbols
and the mhp_get_default_online_type function for hotplug use cases.
This commit exports the mhp_get_default_online_type function to allow
these drivers to build and function when hotplug is disabled.

> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 6833208cc17cb..4942570540956 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
[ ... ]
> @@ -239,6 +239,7 @@ enum mmop mhp_get_default_online_type(void)
> =20
>  	return mhp_default_online_type;
>  }
> +EXPORT_SYMBOL_GPL(mhp_get_default_online_type);

[Severity: High]
This isn't a bug introduced by this patch, but exporting this function for
asynchronous driver module initialization paths significantly increases the
probability of a data race with sysfs updates.

Can this lazy initialization clobber a user-specified hotplug policy?

If a driver calls mhp_get_default_online_type() and reads the uninitialized
state just as userspace writes to /sys/devices/system/memory/auto_online_bl=
ocks,
could the following sequence occur?

CPU1 (Driver init calling mhp_get_default_online_type):
    if (mhp_default_online_type >=3D 0) // reads -1

CPU2 (Sysfs write calling auto_online_blocks_store in drivers/base/memory.c=
):
    mhp_set_default_online_type(online_type); // sets user policy

CPU1 (Continuing in mhp_get_default_online_type):
    if (IS_ENABLED(CONFIG_MHP_DEFAULT_ONLINE_TYPE_OFFLINE))
        mhp_default_online_type =3D MMOP_OFFLINE; // clobbers user policy

Does this unprotected check-and-set sequence on a global configuration
variable need serialization to prevent the user-specified policy from being
silently lost?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605211911.2160=
954-1-gourry@gourry.net?part=3D3
