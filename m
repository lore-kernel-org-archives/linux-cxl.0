Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C00319860;
	Thu, 14 Aug 2025 19:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755201461; cv=none; b=E7nSpM9n6t2ri9DFwj3uEwl3ninRY3k8DEBiDqSgX7zImLazMlf26vwYoh/6+uNs5I3A4e1pfr4l51Ly38lvOst1kYnnkxunGLOY/VFyV2dndbCI5pgtoan1BzL8UeSqGDRsZNz8ayPgwhF1okuS99EQcsz2IGN8bMEvrlaFrYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755201461; c=relaxed/simple;
	bh=jwr1D/M/D6J8UXOLpfzxnHBTHqKQx+aPFWGFdoCo7Fo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dTJSGGAKP6y3A2Ht1spch8by6Haj7WHWCwtvDluDTRkS++EdVbFtgyb7iSL5Oz34FSFQWbF6GB6c2JmwZpOY6S6QU6/vBTZVV0QUGrLULc01/BYuHFrkAMsAAEZP0R82VZs4IVMjcwpFyi4NBNYn46pXC1hj4iAvEmvVqlnPhgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=FKOxemmD; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="FKOxemmD"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 29D1E40AD8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1755201459; bh=1gbvYz4GsU0PNtrxGdC8PGv96PBc4YyIP2GPO/NWKI8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=FKOxemmD5CAy8tadlQ6sNqF708V3koVuyEThfv5Ekr86q+wCll0KEaEy2uOrMArXN
	 gXrJibg6o+iVyQpZzy0rO+iwI8mXBepq1hQIwXwhdsc3Y9/iPrRcrz0giYzM4jPwEu
	 6DIVZ147pP5etHteMDoJ/Zc2df6ZAWwpRUABPRTtBrx8AkQDQoPPRRfHwVHi6nvf11
	 Z13Iryqoo1w4NMHj3xbFlavQs9R6HNe5fXo+M6pIbhDdRGc4P/BG2+w2HMUOSmy9DI
	 PfC5zyXc5e2mPOeAI+0jkbqZUlN9iijK8CP7yD3DYo9+402PmOiRKIkfZa+bOvQJdA
	 tmnqHbnm73icg==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 29D1E40AD8;
	Thu, 14 Aug 2025 19:57:39 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Ranganath V N <vnranganath.20@gmail.com>, alison.schofield@intel.com
Cc: alim.akhtar@samsung.com, dave@stgolabs.net, linux-cxl@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel-mentees@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 rafael@kernel.org, skhan@linuxfoundation.org, vishal.l.verma@intel.com,
 vnranganath.20@gmail.com, linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v2] Documentation: Fix driver-api typos
In-Reply-To: <20250814184304.20448-1-vnranganath.20@gmail.com>
References: <aJ4KEKHn351vQXe_@aschofie-mobl2.lan>
 <20250814184304.20448-1-vnranganath.20@gmail.com>
Date: Thu, 14 Aug 2025 13:57:38 -0600
Message-ID: <87wm75ekwd.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ranganath V N <vnranganath.20@gmail.com> writes:

> Corrected a few spelling mistakes
>
> v2:
> * corrected as per suggestions.
> * improved the phrasing.

For future reference, this information should go below the "---" line so
that the person applying the patch does not have to edit it out.  I can
take care of it this time, no need to resend.

Thanks,

jon
