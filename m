Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5033B8BD9;
	Tue, 11 Aug 2026 16:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786466453; cv=none; b=I5buq1MAmDzj9G1NGPKT9bi6pv8sRrKazUpA7/k7aq/OMPxt4In0nki7+lq3Up4aVNYZCarmtpP1c7j+Zed283oDPlc204B4C4GfAW/p+GRnAyZ2ZsBBOseNPKWcZ1Yhkd2fBq72Gv3OnipqINFLE6oV2yqO3h+q4LBeMIM7p28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786466453; c=relaxed/simple;
	bh=8zP8ASstD+Iijj03IwOHHZdBBa/S+RlH677gIpQsmx4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qW+I590qg06CvO5DqS+NUTjWhIDI02pNUFvHMpAJ8mfmyo47ynATHku4G0pDOPtRyF42AohArOdJy1hyvKX5DbXdfRQr4PYGeyr7KuLe0d5q33JvtGFtNhP2+h+B4JP2vPzm3LLMhvy4S6JFr5kCvPAb0S7faSQFDdiUulB5UQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=VEAjqy7t; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="VEAjqy7t"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 4D5B5408B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1786466451; bh=0Jwo4AvCuLqyzbHAmYxlXGHlYItltet5O2YdnQ6WjWM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=VEAjqy7tQFuNoE30nWlvK0IhAunMp+SD/BrZoejXAEW/V0mCDDPz+BuXEluZiGXul
	 CAkB/G+BiUzrexCrAtfXWvHwzj3j6ZrJIl7PEUjXqWNirvhcZI9yj0Qq8gCYvE/o4l
	 dYD2rHYQyF0v1MKQn2Nby1fsvdz7Jp2KFSoKfrYRU/j9X6Ks1hLeaJNeBGfcYklaRE
	 SBKlfd2iIeiQgonSF0zr8KYy1DVA7ipk0gJOH9EvbtX/SrhIy0BFT3Ja+LQTT4ZjGg
	 Q4zO3uRJ04RAtAWDmC7h4v85Ax0zcDNfwULoyBlyu6mFaFDYXBeTBSvSJyVlk9oUMU
	 l2ESrsS6UJKJQ==
Received: from localhost (unknown [IPv6:2601:280:4600:27b::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 4D5B5408B2;
	Tue, 11 Aug 2026 16:40:51 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Alison Schofield <alison.schofield@intel.com>, Shuah Khan
 <skhan@linuxfoundation.org>
Cc: Alison Schofield <alison.schofield@intel.com>,
 linux-doc@vger.kernel.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 2/2] docs: python: abi_regex: convert adjacent index
 placeholders
In-Reply-To: <cc893dca3aaa3ec833ba70d1f32c3e7342b7faf2.1786139549.git.alison.schofield@intel.com>
References: <9f6fa7a9aa6ba9a26b484b911976713356b3fd44.1786139549.git.alison.schofield@intel.com>
 <cc893dca3aaa3ec833ba70d1f32c3e7342b7faf2.1786139549.git.alison.schofield@intel.com>
Date: Tue, 11 Aug 2026 10:40:50 -0600
Message-ID: <87ldacliel.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alison Schofield <alison.schofield@intel.com> writes:

> While validating recent CXL ABI documentation updates with
> get_abi.py, every decoderX.Y entry was reported as undocumented.
>
> The placeholder conversion mishandles adjacent index placeholders,
> producing patterns that cannot match the corresponding sysfs paths.
> As a result, valid ABI entries are reported as undocumented.
>
> Handle adjacent placeholders independently so generated patterns match
> the documented paths. This fixes decoderX.Y entries in the CXL ABI and
> other ABI documentation that uses the same naming convention.
>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>
> Changes in v2:
> - No changes
>
>
>  tools/lib/python/abi/abi_regex.py | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/tools/lib/python/abi/abi_regex.py b/tools/lib/python/abi/abi_regex.py
> index 69d8507b7382..198ecbf49c51 100644
> --- a/tools/lib/python/abi/abi_regex.py
> +++ b/tools/lib/python/abi/abi_regex.py
> @@ -65,8 +65,7 @@ class AbiRegex(AbiParser):
>          (re.compile(r"\[[^\]]+\]"), "\\\\w\xf7"),
>  
>          (re.compile(r"XX+"), "\\\\w\xf7"),
> -        (re.compile(r"([^A-Z])[XYZ]([^A-Z])"), "\\1\\\\w\xf7\\2"),
> -        (re.compile(r"([^A-Z])[XYZ]$"), "\\1\\\\w\xf7"),
> +        (re.compile(r"(?<![A-Z])[XYZ](?![A-Z])"), "\\\\w\xf7"),
>          (re.compile(r"_[AB]_"), "_\\\\w\xf7_"),

Sigh ... these regexes are absolutely unreadable.  Not your fault, of
course, and I've applied the patch, but it sure would be nice to get
some documentation in there at some point.

Thanks,

jon
