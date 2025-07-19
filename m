Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECD11865EE;
	Sat, 19 Jul 2025 23:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752967906; cv=none; b=tXSVXEUIrbKWpgiKAGhD9/3r8qcnU2Al3D+q8ITtGoHlFqQZ6ANkgI3X5FyuoNRzZUWz3UYk2PtKE9QCBOgUgLllOe6n+hCtm+VF8EAfNytFxHS03+J0oIeSE71gvrQ6EQ/UB2EMhIdN2DRKa8TzyADoivFzewLR7+pjwhK8BaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752967906; c=relaxed/simple;
	bh=x5acVK0X+1fl80Wk5rd9pSWsaqEkVEV7BHB3UIEq0LU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=o19YeT/Fz3Nh9LOmOGnsVu0v6rA6wr1Pl0vKEywDI0gTuj0kVQYQ4tT+hXPYGoPYTPMKMpXaqEy4NcFQpVuy/VwDil22yR2ukLi2t0x6NZu/3z3B3/m9PC9Pe68X8S2EIhNkP2Gmv1yQJhFqTOjK2Qxs1XEUK5v2KpCgXzYbIX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=VQ/natX4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VQ/natX4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 483F6C4CEE3;
	Sat, 19 Jul 2025 23:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1752967905;
	bh=x5acVK0X+1fl80Wk5rd9pSWsaqEkVEV7BHB3UIEq0LU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VQ/natX4GtEc4H+kpnHQ8StlbiRpjBzGiZAQpKgVfd73T1zK+raAmclXfxT1XllbT
	 LcWUar2fYYHTeNu5QvMKV7NqJgxFSXVKmKxsgLah0ip+c1beNDOIl0ccSD19HhP5qs
	 kSBGbOxHZhzlHb+OOPyQ9reTOGYT6e2AKq/8Gpes=
Date: Sat, 19 Jul 2025 16:31:44 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH] resource: fix false warning in __request_region()
Message-Id: <20250719163144.7524cfec1fe2041742608f80@linux-foundation.org>
In-Reply-To: <20250719112604.25500-1-akinobu.mita@gmail.com>
References: <20250719112604.25500-1-akinobu.mita@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 19 Jul 2025 20:26:04 +0900 Akinobu Mita <akinobu.mita@gmail.com> wrote:

> A warning is raised when __request_region() detects a conflict with a
> resource whose resource.desc is IORES_DESC_DEVICE_PRIVATE_MEMORY.
> 
> But this warning is only valid for iomem_resources.
> The hmem device resource uses resource.desc as the numa node id, which can
> cause spurious warnings.
> 
> This change fixes this by restricting the warning to only iomem_resource.
> This also adds a missing new line to the warning message.

What are the circumstance which cause this warning?  Are real world
users hitting this?  If so, should we backport this fix into earlier
kernels?
