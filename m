Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0AB3F787F;
	Tue, 11 Aug 2026 16:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786466447; cv=none; b=sDJFW+pQ14fXd3i1+uiADq55XFK6jHqlz5eaDomKrzKsvVlKuk5uYSpMqnDdls5YYVkm6+edFZ3lrYPWDaodo0KnIGyLNDmndO3DxXLnjia25gzF6fBDsnt1pF6QS5W8D2cN7L1/7WX8Ih+GBeKpBfr7MN9q2ZymNN8ItVS2o+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786466447; c=relaxed/simple;
	bh=2XLSZF7PamH8q63XJARXQZxXNgGZDrxg6vbTO2X6s/U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=izC0a3qaxKiYRRPSMwxiqQ2WIKy9AKVbU2NfLtSgQ0MAlTbaQ6onQXH0Wc/OLAPSXgwTsy7EkreXI5hyreT8n1ku/GYEUTxXi+nMjr+s6za2Eiih5yr3urfWfs7SSt8cbpojBVVGknxLVhOZ/tpGhN9VXSygXuSitfimF/ic1mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=ROwF3S7X; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="ROwF3S7X"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E3C94408B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1786466445; bh=lYF54d33IqBzPOl/q/L7gZTwuExjTV9WQr6fd+g09g0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ROwF3S7XI+L0FdUIENKoPn7NLZG0xuGBgV0/oJH9suEN73uurKdq8GR/nF+QHcobo
	 ap3rxVcVI35wU/D9Q8r1YEVqaqFV58mN0YZa9Vw2pMm37fcoL7QV3AsWp42AwhF4De
	 8SZzycq36FLgOxR/At1ajWd7TT7UBwqrtx4kSfVYm85nKHhCy3U48EKt3zxNWtlmAk
	 8FR1+J8E7S1BE3FMR39fdEswmsTp+qdglrLCwFCaJHmaVyCIUOlcRTeM4r2bfJxLhi
	 Bk8BXzD/O79G9J65WOBbt3c9DmP4IUM14oktTubc4mR/p6OhdAy1WS7JrqVPRx1em4
	 7H+zhbLMDYYVQ==
Received: from localhost (unknown [IPv6:2601:280:4600:27b::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id E3C94408B2;
	Tue, 11 Aug 2026 16:40:44 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Alison Schofield <alison.schofield@intel.com>, Shuah Khan
 <skhan@linuxfoundation.org>
Cc: Alison Schofield <alison.schofield@intel.com>,
 linux-doc@vger.kernel.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 1/2] docs: python: abi_regex: catch the right
 exception for a bad regex
In-Reply-To: <9f6fa7a9aa6ba9a26b484b911976713356b3fd44.1786139549.git.alison.schofield@intel.com>
References: <9f6fa7a9aa6ba9a26b484b911976713356b3fd44.1786139549.git.alison.schofield@intel.com>
Date: Tue, 11 Aug 2026 10:40:44 -0600
Message-ID: <87mruslier.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alison Schofield <alison.schofield@intel.com> writes:

> While validating recent CXL ABI documentation updates with
> get_abi.py, the 'undefined' mode was found to abort instead of
> reporting undocumented ABI entries.
>
> Older Python releases raise re.error, while newer releases expose
> re.PatternError. Catching the compatible re.error exception handles
> both cases.
>
> Use re.error so the scan continues and reports the remaining
> results.
>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>
> Changes in v2:
> - Update commit msg to say catches the compatible re.error (Sashiko)
> - No code change
>
>
>  tools/lib/python/abi/abi_regex.py | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Applied, thanks.

jon
