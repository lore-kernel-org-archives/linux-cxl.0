Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6A73D8122;
	Thu, 24 Sep 2026 17:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790270099; cv=none; b=rkefMLAv0CpZ6O0bnoadjY4ghIxhaDOvq0W97EgLtj5H0DcVYLyJeFecoqpVbKlBnp21wKNHHn4qSlxWmoRMp8LW/dFdwJvz9yqtG0Q6YHv4zz0d1s9PFxRBuw/d6L0UjZJlzQhJUKGcwBFEQ3kQIdmbP953nP0IvRGRVuALUOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790270099; c=relaxed/simple;
	bh=JDOqA9647s0CbjvLTs1DO4z0udNARZPkCxebgG/HoW8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Rk3XoEAtoal99bDIA5uVAlz9ym02LjEO6bNzG+eREdpkTG53NqlAlU7EMkUZpS8jCnyyiJ/cIce1M30zIbGY1zxgdRasNmTcTZ0F7sDKiiUkQqYn8hwdkxFLMeWgbn3HFYxDLWBO5aCsudui8miwOCapmSS9G+6grt3OhSa2k68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf02.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id F1781C044D;
	Thu, 24 Sep 2026 17:09:28 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf02.hostedemail.com (Postfix) with ESMTPA id 1F8B280011;
	Thu, 24 Sep 2026 17:09:25 +0000 (UTC)
Message-ID: <6595ac9f640a3796f34f58ba6d97d61bc0c07558.camel@perches.com>
Subject: Re: [PATCH v2] checkpatch: don't flag ACQUIRE_ERR() assignments in
 if conditions
From: Joe Perches <joe@perches.com>
To: Guixin Liu <kanie@linux.alibaba.com>, Andy Whitcroft
 <apw@canonical.com>,  Jonathan Cameron	 <jic23@kernel.org>, Alison
 Schofield <alison.schofield@intel.com>, Andrew Morton
 <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Date: Thu, 24 Sep 2026 10:09:24 -0700
In-Reply-To: <20260924033923.4140210-1-kanie@linux.alibaba.com>
References: <20260924033923.4140210-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Stat-Signature: tqfxd6up1j46rfi63kk4s6jc54tdepsa
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 1F8B280011
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+DSww5OxxxLCzqeHV0GUsIxtm6SADd11Q=
X-HE-Tag: 1790269765-928210
X-HE-Meta: U2FsdGVkX18cazg6m/kgQwUVdNwkMYWOUOblu/6JTHxPjGmDtTbBSQa2BY4s/nHCMxOVuHIqWHasjHKAQYeP0WXa+Rv74NbC/unGxpsqdmXXl00ZiOtXqPw0DQqqwwy8Bl13Tt5zVZ7ETL7XvYBWCNzlyeY4xB63Ov/nvzCWp8MvVKTl+O4B+/DaeZnDSAJXxEfguWTQoTc141zUXxzA+xiWLebRgwoYF8H6RuT0yjgWRO+XQUJ6prh2E/iig8rGYYw2gK1FxYRn1xwJ7BFTsj1ICwvB1+HyckAp+WP8XuTySqLuG4la5VulBsOTBtQoCflkvnD2/IgE5tbQqlUdCA2c0m0TZ6jjC656aN/KlkbA2OuxbiaahYJ+QefwdaPeZ/XLpDz7ImACtxhtZZvtCLZwLo/4YI2DHFLI5TtVETLJ/i1ZhZHfrPYIZ+oF9To5+xbbmNor1vSOOqJPe7vTYOxsBVKrEa58

On Thu, 2026-09-24 at 11:39 +0800, Guixin Liu wrote:
> ACQUIRE_ERR() and its wrappers, PM_RUNTIME_ACQUIRE_ERR() and
> IIO_DEV_ACQUIRE_FAILED(), report whether a conditional cleanup.h guard
> was acquired, and drivers consume the result directly in an if
> condition:
>=20
> 	if ((rc =3D ACQUIRE_ERR(mutex_intr, &lock)))
> 		return rc;
>=20
> That combined form is the established style at the 49 in-tree call
> sites under drivers/cxl and drivers/pci/tsm.c, so ASSIGN_IN_IF fires
> there only as a false positive, and every patch touching those lines
> carries noise that reviewers have to wave off manually.
>=20
> Skip the check only when every assignment in the condition assigns the
> result of such a call, matched by the *_ACQUIRE_ERR() /
> *_ACQUIRE_FAILED() naming convention of its wrappers. Plain
> assignments, mixed conditions and near-miss identifiers still get
> flagged.
>=20
> Suggested-by: Alison Schofield <[alison.schofield@intel.com](mailto:aliso=
n.schofield@intel.com)>
> Cc: [linux-cxl@vger.kernel.org](mailto:linux-cxl@vger.kernel.org)
> Assisted-by: LLM
> Signed-off-by: Guixin Liu <[kanie@linux.alibaba.com](mailto:kanie@linux.a=
libaba.com)>

Acked-by: Joe Perches <joe@perches.com>

>=20
> ---
> Changes since v1 [1]:
>=20
> - Check each assignment in the condition instead of the condition as a
>   whole, so a mixed condition such as
>   "if ((rc =3D regular_function()) || (ret =3D ACQUIRE_ERR(...)))" keeps
>   getting flagged (Alison Schofield).
> - Match the assigned-to expression with $Lval, as Joe Perches
>   suggested on Alison's earlier attempt at this exception [2].
> - Cc linux-cxl, where most users of this form live.
>=20
> Two deviations from [2]: the assigned expression capture excludes '=3D',
> so an '=3D=3D' comparison in a mixed condition is not mistaken for a bad
> assignment, and the check requires an assignment the $Lval match can
> see, so compound assignments like '+=3D', which it cannot see, are not
> silently allowed.
>=20
> Testing: ran checkpatch on a test file with the allowed forms (bare
> macro and both wrappers, member and array element lhs, multiple
> ACQUIRE family assignments in one condition, an '=3D=3D' comparison
> alongside, no spaces around '=3D') and with 14 cases that must still
> trigger (plain assignments, near-miss identifiers, arithmetic on the
> call result, ACQUIRE_ERR in a comment, indirect assignment, mixed
> conditions in both orders). All allowed forms pass, all 14 still
> trigger. The 49 in-tree call sites under drivers/cxl and
> drivers/pci/tsm.c no longer report ASSIGN_IN_IF, and checkpatch output
> is unchanged for fs/namei.c, kernel/sched/core.c, mm/vmscan.c and
> net/core/dev.c.
>=20
> [1] [https://lore.kernel.org/all/20260916020921.3480730-1-kanie@linux.ali=
baba.com/](https://lore.kernel.org/all/20260916020921.3480730-1-kanie@linux=
.alibaba.com/)
> [2] [https://lore.kernel.org/linux-cxl/20250815010645.2980846-1-alison.sc=
hofield@intel.com/](https://lore.kernel.org/linux-cxl/20250815010645.298084=
6-1-alison.schofield@intel.com/)
> ---
>  scripts/checkpatch.pl | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>=20
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 8a7787d228a6..eee06ac6737f 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -5777,7 +5777,21 @@ sub process {
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
> +				$assign_in_if =3D !$has_assignment || $has_other_assignment;
> +			}
> +			if ($assign_in_if) {
>  				if (ERROR("ASSIGN_IN_IF",
>  					  "do not use assignment in if condition\n" . $herecurr) &&
>  				    $fix && $perl_version_ok) {
>=20
