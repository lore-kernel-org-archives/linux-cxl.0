Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4223D4B0496
	for <linux-cxl@vger.kernel.org>; Fri,  7 Aug 2026 00:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786061027; cv=none; b=Y4Y/M/Bg+7fvGHbJk0h6t5mLdv47HxFWJmO7lHfJFsJmgXXnhG3bEk9nIziZcTT7/Bor1/fTZmjgkHy6t485UXi3/PTMh/eq+N20KnowwkML+8ZAvhscDvYqlFnaifFIDOFA6g52XmSxTOVqaGcpjBc/tXiySW7GgbkK9nX6bgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786061027; c=relaxed/simple;
	bh=BIb9LlEVJhd8MZu5wQmRPKuUFlAyGqXvgE82RXf0TZk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NDtccumiG3AZNG+OAbQy9sZeaQwK9D6LLxyOcy0v7nHisImZ68YpjRyBv4uEF5UsUeNYhbwALD83e+TkuKTvceJ14KzeISf4bf5iXyiJd2/Q6HiQ9dk/fnFuyyG5YWE/zT2NKSMrK9LF7jB0PoBKk7jZC58kk6xOK0/W8Ik+358=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SnfIO32e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SnfIO32e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86D851F000E9;
	Fri,  7 Aug 2026 00:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786061025;
	bh=6JwOKTrzNYQLfHoTmAg5GoKaxnTO/0I8jv2QtVk9vzk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SnfIO32eA/2MU1o4e+7EQ6I5Ty5wrwuX9qwXBUe8rdX6lS6GVua4PH1SLekGeErB9
	 Fl+YuVzdPKKY2KauRa85ERfx0l3qgba2IplySHzG+HS/z5JtiiOwlznp+K4j3tWO2M
	 Jytd6NzFWPfalcjwq+yppwpR/kqrP/BnM8XPYLsPrWUGsnuXlooAuocpBbhz46hElc
	 7YK8kAwK78mqcv74SzXTRFpT0rCiR+hpx9SlQK02zFuhLgMAfFyVGnsJG9ThRYYN1e
	 u+zqyxvZ7YgXBYy35w06pir5wNv2vEcfwa9ojeQK0hwuRCep+VTjW9eVMizI/TrcwY
	 CVS7WBKuRs7SA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] docs: python: abi_regex: catch the right exception
 for a bad regex
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alison Schofield" <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <d57d3ddc0d7d883bd61ad07c6d3969b622fd446f.1786058698.git.alison.schofield@intel.com>
References: <d57d3ddc0d7d883bd61ad07c6d3969b622fd446f.1786058698.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 00:03:44 +0000
Message-Id: <20260807000345.86D851F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch replaces `re.PatternError` with `re.error` rather than=
 catching both, directly contradicting the commit message and exposing a mi=
sunderstanding of standard Python.
--

--- Patch [1]: [PATCH 1/2] docs: python: abi_regex: catch the right excepti=
on for a bad regex ---
commit ed601931671f151d8ef4f1bbd0e817520a34f3c5
Author: Alison Schofield <alison.schofield@intel.com>

docs: python: abi_regex: catch the right exception for a bad regex

This commit updates the exception handling in abi_regex.py to prevent the
script from aborting on invalid regular expressions. It aims to support
both older and newer Python releases by handling regex errors correctly.

> Older Python releases raise re.error, while newer releases expose
> re.PatternError. Catching only the newer name causes the scan to
> abort when an invalid expression is encountered.
>=20
> Catch both names so the scan continues and reports the remaining
> results.

[Severity: Medium]
Does the commit message accurately reflect the changes?=20

The text states it will "Catch both names", but the patch replaces=20
re.PatternError with re.error entirely. While standard Python uses re.error=
,=20
if newer releases actually exposed re.PatternError as stated in the commit=
=20
message, wouldn't replacing the handler cause newer Python releases to abor=
t?

> diff --git a/tools/lib/python/abi/abi_regex.py b/tools/lib/python/abi/abi=
_regex.py
> --- a/tools/lib/python/abi/abi_regex.py
> +++ b/tools/lib/python/abi/abi_regex.py
> @@ -155,7 +155,7 @@ class AbiRegex(AbiParser):
>              if self.search_string:
>                  if what.find(self.search_string) >=3D 0:
>                      print(f"What: {what}")
> -        except re.PatternError:
> +        except re.error:

[Severity: Medium]
Is it intentional to only catch re.error here in regex_append(), rather
than catching both as described in the commit message?

[ ... ]

> @@ -194,7 +194,7 @@ class AbiRegex(AbiParser):
> =20
>                  try:
>                      self.re_string =3D re.compile(self.search_string)
> -                except re.PatternError as e:
> +                except re.error as e:

[Severity: Medium]
Does this __init__() block also need to catch both exceptions, or is
replacing re.PatternError with re.error sufficient?

[ ... ]

> @@ -223,9 +223,9 @@ class AbiRegex(AbiParser):
>                  for r, s in self.re_whats:
>                      try:
>                          new =3D r.sub(s, new)
> -                    except re.PatternError as e:
> +                    except re.error as e:
>                          # Help debugging troubles with new regexes
> -                        raise re.PatternError(f"{e}\nwhile re.sub('{r.pa=
ttern}', {s}, str)") from e
> +                        raise re.error(f"{e}\nwhile re.sub('{r.pattern}'=
, {s}, str)") from e

[Severity: Medium]
Similar to the other locations, parse_abi() replaces the exception class
instead of catching both. Does this match the intended behavior?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/d57d3ddc0d7d883bd61=
ad07c6d3969b622fd446f.1786058698.git.alison.schofield@intel.com?part=3D1
