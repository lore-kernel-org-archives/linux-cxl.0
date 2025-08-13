Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008E82D5C6F;
	Wed, 13 Aug 2025 07:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755069483; cv=none; b=eDkwViFHTQvp6PkIHDlYjhi7ZzH8/E4IxqfxzxYwmp9wSSHpfkAMEaoB3ceSzsnz44VT4gNYGYt29r4MW/ADJsspe/7qGymCh8lSdu6iwOV66LWA7UX4LFZw2z2PrpMt309ZG9kY1pjfZD9FaV4ccq7SgpqSdNHdmAPxqKjxJaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755069483; c=relaxed/simple;
	bh=hcmI7iAMYwE97uti/1GOOMzj/QiwGNxvvy2bu3eStqM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SD/njZK4YtGnjC8KnsXRoh9WTUm7jzQyjqiKKMrVU4MhL9ZC+ykfW5bzTz23rjAVfoBe0NHN6LufkwokaRc8ezWRao41xQ4RR+07Mx12a7OBE7RAgWUVpuvUDGpYG6YLVB+fw9/tfLRGj9X85Je9gPUYNBV19P9LAFtSoXlZ6Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id F1F971A0243;
	Wed, 13 Aug 2025 07:17:54 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf08.hostedemail.com (Postfix) with ESMTPA id 8207720025;
	Wed, 13 Aug 2025 07:17:52 +0000 (UTC)
Message-ID: <9afd4c898a194cd576f1aaa08b72c67d4e538cc7.camel@perches.com>
Subject: Re: [PATCH] checkpatch: allow an assignment in if condition for
 ACQUIRE_ERR()
From: Joe Perches <joe@perches.com>
To: alison.schofield@intel.com, Andy Whitcroft <apw@canonical.com>, 
 Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn
 <lukas.bulwahn@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Dan Williams
	 <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 13 Aug 2025 00:17:51 -0700
In-Reply-To: <20250813003821.2891532-1-alison.schofield@intel.com>
References: <20250813003821.2891532-1-alison.schofield@intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 8207720025
X-Stat-Signature: rwoky5ctg8r9qqy3xznak4toecm35udm
X-Rspamd-Server: rspamout02
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18am+B5Hnc2pdpMW7J6uT1k3dulQ6IVQds=
X-HE-Tag: 1755069472-731564
X-HE-Meta: U2FsdGVkX18PNOcji16s5vY1l/BFYK8y5dYG9rydl/TgSQw7dMTQeSeiVtJjeEYj0qhZpgyg+W2vgak94c87JLOIIZMYp7wUbtyMnqrbgZVHEPbbBIc5Ilg9yc7Mdr7OgU7JO+93wVwMyHpnPEsDQYYOoeiD2SXHyL43v6Tw0an9vIPYsQGWLB5aVJXNh5MLG7Ok+qkZ3/zpSIDi8or/VCpmH415AHldOSuEGg5PdmKNLlnGlNh3gKloW+oHThnf6vI8W7mYcIbPb0Oxe6d4RLc22wN2qRkNBZS3dyPLeVAyNo9n/zXb8kmMcwdzRwF2xjlhc61osVcKewOM54krrpUrkqzEVCEQ

On Tue, 2025-08-12 at 17:38 -0700, alison.schofield@intel.com wrote:
> From: Alison Schofield <alison.schofield@intel.com>
>=20
> New helpers, ACQUIRE() and ACQUIRE_ERR(), were recently introduced to
> clean up conditional locking paths [1].
[]
> That compact format was a deliberate choice by the authors. By making
> this a checkpatch exception, existing ERRORs are quieted, and future
> users of the macro will not be dissuaded by checkpatch from using the
> preferred compact format.

not stylish IMO.

> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -5696,7 +5696,14 @@ sub process {
>  			my ($s, $c) =3D ($stat, $cond);
>  			my $fixed_assign_in_if =3D 0;
> =20
> -			if ($c =3D~ /\bif\s*\(.*[^<>!=3D]=3D[^=3D].*/s) {
> +			if ($c =3D~ /\bif\s*\((.*[^<>!=3D]=3D[^=3D].*)\)/s) {
> +				my $expr =3D $1;
> +
> +				# Allow ACQUIRE_ERR() macro syntax
> +				if ($expr =3D~ /\w+\s*=3D\s*ACQUIRE_ERR\s*\(/) {
> +					next;
> +				}

nak.

Using next would not do any additional checks on this line.
Likely use basic block or a constuct like

			if ($c =3D~ /\bif\s*\((.*[^<>!=3D]=3D[^=3D].*)/s &&
			    $1 !~ /\bACQUIRE_ERR\b/) {


and perhaps the \w+ should be $Lval

> +
>  				if (ERROR("ASSIGN_IN_IF",
>  					  "do not use assignment in if condition\n" . $herecurr) &&
>  				    $fix && $perl_version_ok) {

