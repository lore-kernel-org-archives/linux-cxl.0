Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5734734D394
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jun 2026 21:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780695272; cv=none; b=Osq3CgkIEO5ATtc0ecUju1ctrSc8+FlZ8doOOhi2M8jct+Mskjf0xNFRj3fzu7/IUVs7RQUGbT99HBZ4tHvt9a7+Q4hstZXyz8uQGErvAlFFvLQBJO9eAUyECxLOv72tQ/DY/f0BE90goZk6rO0pf5a8DJwPEZJUKplkKx0PAC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780695272; c=relaxed/simple;
	bh=6AzyZBQiadleFZxzNOrjMYPT5+hRKVNNTGME5TJpXf4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ki+LWo7siJx1cZg12q4bGAURqBPM8fBXEAqc12xnxoF4AnBmjIvMvIHerIStEC/dLLeQzitU7tPYLhuu+hCTWU5ewKnr+Rv/dd56cJM5s5uwp+6Ld2lAtE+d7Z+wdMvzd/19ICbUrLAS3AWxd14vB3wPyGMSE1jvM1RPUC2iFqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FPEQoJYf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FPEQoJYf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5CBC1F00893;
	Fri,  5 Jun 2026 21:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780695271;
	bh=MB8nKkFUroiBvxqM/HwnkOMdiNHYCPhMLy/85pEoCZg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FPEQoJYfKlml1DXQgbhRQHc7GBg8YLcRWhxGmglfHHZmieTpX+jqgdZdV6eaQ1Pju
	 QxDO59Qws0V/EbB1FlBlfMPGR5YCLLfwaXwL7/eaDtzrjYZRZcvpgNXY+NPe4xQVKG
	 Oxih0JLIk+d7d473/SzjGNBLdiEEVivREg3cDBB+5uIcfX73au1JpukOH7qvOYiJ+p
	 782hY9PbEq6d9ynhII7C856D7DyP3FleB/tfvAWnfvJ+akmKl073gwq/ksy1P6sWx+
	 MBzMcw2MZ4opTqdxsbZQHGM6+72TCAFXtDnj3I6wZ6WwpqblQCFYgxITKzuPDbAiDN
	 chMKkSlDxDtPQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 9/9] selftests/dax: add dax/kmem hotplug sysfs
 regression test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gregory Price" <gourry@gourry.net>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260605211911.2160954-10-gourry@gourry.net>
References: <20260605211911.2160954-10-gourry@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 21:34:30 +0000
Message-Id: <20260605213430.D5CBC1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Skipped unplug test causes a cascading spurious failure in the s=
ubsequent `online_kernel` test.
- [Medium] The test script modifies system-wide DAX device hotplug state bu=
t lacks a `trap` to ensure restoration on unexpected termination.
--

commit eaf4726251fa25a05d2dfac099a7956bef58a48a
Author: Gregory Price <gourry@gourry.net>

selftests/dax: add dax/kmem hotplug sysfs regression test

This commit adds a kselftest to validate the whole-device hotplug sysfs
attribute for dax/kmem devices. It verifies transitions between unplugged,
online, and online_movable states, ensuring memory is properly added and
removed.

> diff --git a/tools/testing/selftests/dax/dax-kmem-hotplug.sh b/tools/test=
ing/selftests/dax/dax-kmem-hotplug.sh
> new file mode 100755
> index 0000000000000..e43cda8ba1274
> --- /dev/null
> +++ b/tools/testing/selftests/dax/dax-kmem-hotplug.sh

[ ... ]

> +DAX=3D$(find_kmem_dax)
> +if [ -z "$DAX" ]; then
> +	ktap_skip_all "no kmem-bound dax device with a hotplug attribute"
> +	exit "$KSFT_SKIP"
> +fi
> +HP=3D$DAX_BASE/$DAX/hotplug
> +ORIG=3D$(get_state)

[Severity: Medium]
Does this script ensure the original state is restored if execution is
aborted early?

Since the original state is recorded here but no shell trap is established,
an unexpected exit or user interrupt could bypass the manual restoration
at the end of the script. Would adding an exit trap handler right after
recording the state ensure reliable cleanup?

[ ... ]

> +# The online -> unplug -> online_movable -> unplug cycle once regressed:=
 a
> +# re-online failed to re-reserve the per-range resources, so this final =
unplug
> +# reported success while leaving the memory online.  Assert it is really=
 freed.
> +set_state unplugged; rc=3D$?
> +mt=3D$(memtotal_kb)
> +if [ "$rc" !=3D 0 ]; then
> +	ktap_test_skip "unplug from movable not accepted (memory in use?) rc=3D=
$rc"
> +elif [ "$(get_state)" =3D unplugged ] && [ "$mt" -lt "$mt_mov" ]; then
> +	ktap_test_pass "unplug from online_movable removed memory: $mt_mov -> $=
mt kB"
> +else
> +	ktap_test_fail "unplug success but memory remained: $(get_state) $mt_mo=
v -> $mt kB"
> +fi
> +
> +set_state online_kernel; rc=3D$?

[Severity: Medium]
If the preceding unplug transition fails and execution enters the skip
branch, will this subsequent state transition fail spuriously?

Because the driver rejects direct transitions between different online stat=
es
without an intervening unplug, falling through to the online_kernel test
while the device is still in the online_movable state seems like it will
unconditionally fail instead of safely skipping the rest of the checks.

> +mt=3D$(memtotal_kb)
> +if [ "$rc" =3D 0 ] && [ "$(get_state)" =3D online_kernel ] && [ "$mt" -g=
t "$mt_unplugged" ]; then
> +	ktap_test_pass "online_kernel: MemTotal $mt_unplugged -> $mt kB"
> +else
> +	ktap_test_fail "online_kernel: rc=3D$rc state=3D$(get_state) MemTotal=
=3D$mt"
> +fi
> +set_state unplugged

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605211911.2160=
954-1-gourry@gourry.net?part=3D9
