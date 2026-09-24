Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CD63DC4C2
	for <linux-cxl@vger.kernel.org>; Thu, 24 Sep 2026 03:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790221713; cv=none; b=k8Q5lpw3Bw5GlE3VRl7plDqXYC2yvq23+zDForgep1fg6gvE7nIqLgsNmLKbjAeUCoJQCpP7xW6bxACzK8ddBcOGpUo8mXiEIR5RxLd0mznE3yjeJOWZIpz2zodJb+3OjITkVnD59Hd+xJD7NIqG1sqx3MYXgm1l/v+akj9PumM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790221713; c=relaxed/simple;
	bh=hVCyrlHup9ZYSiEoAl3UlKLrv1uBBCbtlNUaCidc6dk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fZYFgKB7XrijZfOJeLqUSK0ubMZ6lp6NvLVAfwivQihJWPjzZhvUn/ZscDZhG5Rf3j2y/pwdCzIqNivzUy7tLp54IJZ2ZVPy6LviAznNj9Pb0ps1Hut/sOcnjAwxdgajfmM1+87X9QOHtnynl+dMu+Kn+OuPmgorLbJBTi5hVeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FpnR2az8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FpnR2az8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A037F1F000FF;
	Thu, 24 Sep 2026 03:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790221707;
	bh=Er/Bf14qpX/svJS4pie2q6xUQX8ts6SNJCR/PHgEsRQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FpnR2az8jbE7HvjdX46j9Mk19/Hjp3FsaP3ajxwZBkz26p1Rn6cHI+ekaTP0y/ZOY
	 n5mC+y6XQ5y0YWYDrunnfPr+5Vpkci43Gr6ro8hXcCmVTwhTUVDZBXIR+QhXEF6R0+
	 Kp1O/0AvDQvN0mEXcE6xI9h01Up+OdaKEDd1XpV5rMEA+OERskGtjI5qTl161jzurC
	 4SQNc/wkGCxtjHZvYmTPfnq1kIBX0nzCtLsvTSj1qdlHV4GkyBGKeQ1OJCHpDd2Skh
	 tzIjSaAV8Tx+5YNZAT06Imu64+jmIPps32Cb17R82Nt9jpmTohp5o9M4o3K9cjvxJu
	 c6ZC8RYj+GrGg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] checkpatch: don't flag ACQUIRE_ERR() assignments in
 if conditions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guixin Liu" <kanie@linux.alibaba.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260924033923.4140210-1-kanie@linux.alibaba.com>
References: <20260924033923.4140210-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 03:48:27 +0000
Message-Id: <20260924034827.A037F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] checkpatch: trailing arithmetic after ACQUIRE_ERR bypasses ASSIG=
N_IN_IF
- [Medium] checkpatch: mixed compound assignment and ACQUIRE_ERR bypasses c=
heck
--

commit 82d84894b0a64b92c72367ea66d4270c5cb9cc86
Author: Guixin Liu <kanie@linux.alibaba.com>

checkpatch: don't flag ACQUIRE_ERR() assignments in if conditions

This commit updates checkpatch to skip the ASSIGN_IN_IF warning when the
assignments inside the condition are strictly from the ACQUIRE_ERR family of
macros. It attempts to ensure that plain assignments, compound assignments,
and mixed conditions still trigger the warning.

Link: https://lore.kernel.org/all/20260916020921.3480730-1-kanie@linux.alib=
aba.com/
Link: https://lore.kernel.org/linux-cxl/20250815010645.2980846-1-alison.sch=
ofield@intel.com/

> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 3614cfe4dcbb4..598e3ed743bd9 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
[ ... ]
> @@ -5787,7 +5787,21 @@ sub process {
>  			my ($s, $c) =3D ($stat, $cond);
>  			my $fixed_assign_in_if =3D 0;
> =20
> +			# ACQUIRE_ERR() and its wrappers, e.g. PM_RUNTIME_ACQUIRE_ERR()
> +			# and IIO_DEV_ACQUIRE_FAILED(), are meant to be evaluated in an
> +			# if condition, with the error assigned in the condition:
> +			#	if ((rc =3D ACQUIRE_ERR(name, &lock)))
> +			# Allow that only when every assignment in the condition assigns
> +			# the result of such a call, so that a mixed condition keeps
> +			# getting flagged:
> +			#	if ((rc =3D regular_function()) || (ret =3D ACQUIRE_ERR(name, &lock=
)))
> +			my $assign_in_if =3D 0;
>  			if ($c =3D~ /\bif\s*\(.*[^<>!=3D]=3D[^=3D].*/s) {
> +				my $has_assignment =3D $c =3D~ /\b$Lval\s*=3D\s*[^,)&|=3D]+/;
> +				my $has_other_assignment =3D $c =3D~ /\b$Lval\s*=3D\s*(?!\s*\w*ACQUI=
RE_(?:ERR|FAILED)\s*\()[^,)&|=3D]+/;

[Severity: Medium]
Does this regex allow trailing arithmetic to bypass the check?

Because the regex only checks the prefix of the right-hand side of the
assignment, a condition like if ((rc =3D ACQUIRE_ERR(...) + 1)) seems to st=
art
with the allowed macro. This causes the negative lookahead to fail, prevent=
ing
it from being flagged as an other assignment.

This appears to contradict the commit message's claim about arithmetic on t=
he
call result still triggering the check.

> +				$assign_in_if =3D !$has_assignment || $has_other_assignment;

[Severity: Medium]
Does this logic silently allow compound assignments when they are mixed wit=
h a
valid ACQUIRE_ERR() assignment?

An expression like if ((rc =3D ACQUIRE_ERR(...)) || (a +=3D 1)) satisfies t=
he
$has_assignment check, which disables the fail-safe. However, the compound
assignment does not trigger the $has_other_assignment check because it does
not match the strict equals sign in the regex.

This seems to contradict the commit message's statement that compound
assignments are not silently allowed.

> +			}
> +			if ($assign_in_if) {
>  				if (ERROR("ASSIGN_IN_IF",
>  					  "do not use assignment in if condition\n" . $herecurr) &&
>  				    $fix && $perl_version_ok) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924033923.4140=
210-1-kanie@linux.alibaba.com?part=3D1
