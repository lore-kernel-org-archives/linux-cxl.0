Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726F12F2C71;
	Thu, 26 Jun 2025 14:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750949764; cv=none; b=UcyGqtvpSL9j/ZHpYJ6oAJwn/tMz/w4+IFFEhSPw9uWGvcU/sC9Mo3c3SDbtdPjKiEPF7F7DWhZbLFfmfiDHlb3pvE8lT99iFC4/oc0ssiZ/VhvfM81TtFvBID6rsL7qrv3mjRqmIuEJCcDzG0sD61NaUekCheetc/fY04jeb5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750949764; c=relaxed/simple;
	bh=kwigQarPwdv7elUMeHsoAvAPGoqYiG3M/o1e8eBgb7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BU6BCg4yPRX8A5c6VyjW+k6uYjKOiHi/B5dr0Iyl+F5KwSYxQZx3W6yh3iHzaUVJLy9ogZpU5tPJIVBdK5AVUfQNJv3OGjZEGqRPwH7HyFkEeBUK+BOf8K07cDD1Tl8rQYuZ/Qug/MupU388pGJ3TdQXa+lSg4mFDSdc9gSuFrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x//+AGVh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x//+AGVh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AC42C4CEEB;
	Thu, 26 Jun 2025 14:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750949763;
	bh=kwigQarPwdv7elUMeHsoAvAPGoqYiG3M/o1e8eBgb7I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=x//+AGVh46oucnoKR3oZDVxLSJV2P+EFPcreJlmNricURVE7IMsishL3Hq/KDX2NO
	 3dQarzypIjQmZ11w16mxiTtVJAy1wH5ihIxcCN0GiAk1AJ//stJrND5ID64MHJOY/R
	 T+sGbnpkKA2Rs5JNR0PPr87jgREl8JjZlN0gxwPA=
Date: Thu, 26 Jun 2025 15:55:52 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Pranav Tyagi <pranav.tyagi03@gmail.com>
Cc: Robert Richter <rrichter@amd.com>, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	ming.li@zohomail.com, peterz@infradead.org,
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v2] cxl/memdev: automate cleanup with __free()
Message-ID: <2025062615-footpath-plank-b84f@gregkh>
References: <20250623083841.364002-1-pranav.tyagi03@gmail.com>
 <aFrBeCn-j_AB1yzv@rric.localdomain>
 <CAH4c4jLAfMTn6wN3wJSOQZ3mAoYC3uhswDu6c+c6v-wv8mSifQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH4c4jLAfMTn6wN3wJSOQZ3mAoYC3uhswDu6c+c6v-wv8mSifQ@mail.gmail.com>

On Thu, Jun 26, 2025 at 08:02:10PM +0530, Pranav Tyagi wrote:
> Thank you for the feedback. I understand your concerns and completely
> agree with your reasoning. Please pardon my misjudgment in sending this
> patch. I am still a beginner with kernel development and learning to
> better assess what makes a meaningful contribution.

I suggest you start in drivers/staging/ which is specifically designed
for beginners to get involved without having to bother other maintainers :)

thanks,

greg k-h
