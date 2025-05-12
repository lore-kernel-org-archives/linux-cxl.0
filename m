Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC5C258CDE;
	Mon, 12 May 2025 08:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747038251; cv=none; b=ePodEbCTH65rCCx5ksdwL7FsEQGDlWLNuD9VmP4gtvDQ+lDXXnvJF4Lba6nHgZqEM5RH02i4cMQWwl5peiRqWYHGovykqu9IxR4cvXh9dTkgdXAxo464SGR6hAgpilw8CSmFEqvvUWwzPBRWYTulCL/ABchVsSe0CSGmcx4KgYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747038251; c=relaxed/simple;
	bh=MS0NFFRw924pnwMwbLeUEDTmXVxiKYxOyHWYyTxzUBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iuhlh303/PiIpjUFMsYVZxwvj0qQttbMSzwoIN9OQIrrWBd5hZYTXpfiYCKbTBEKDLcFJ8+pu/LyXcyJsCQzBhB9ATnM8b7pbF4Uh2fjSSAaQphIx+nP7IbC1FgadQd1XOfW9KEIEoyEyXvqPb/sVHGNU5Z+jBzBMZ4v3JXzm70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-0f-6821b0269d8f
From: Rakie Kim <rakie.kim@sk.com>
To: Gregory Price <gourry@gourry.net>
Cc: Rakie Kim <rakie.kim@sk.com>,
	joshua.hahnjy@gmail.com,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	dan.j.williams@intel.com,
	ying.huang@linux.alibaba.com,
	kernel_team@skhynix.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com,
	Keith Busch <kbusch@kernel.org>,
	Jerome Glisse <jglisse@google.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [RFC] Add per-socket weight support for multi-socket systems in weighted interleave
Date: Mon, 12 May 2025 17:23:55 +0900
Message-ID: <20250512082402.285-1-rakie.kim@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <aB4tgSP2r-2s-1ce@gourry-fedora-PF4VCD3F>
References: 
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJLMWRmVeSWpSXmKPExsXC9ZZnka7aBsUMg7sftCzmrF/DZjF96gVG
	i593j7Nb/Dy8g8Vi1cJrbBbHt85jt5h06BqjxflZp1gsLu+aw2Zxb81/VovVazIcuD12zrrL
	7rFgU6lHd9tldo+WI29ZPRbvecnksWlVJ5vHpk+T2D1OzPjN4rHzoaXH501yAVxRXDYpqTmZ
	ZalF+nYJXBmn529lLOjirri09x1zA+N7ji5GTg4JAROJX7e+MMHYk1p/AdkcHGwCShLH9saA
	mCICqhJtV9y7GLk4mAVWMUu8P7sbrFxYIEHi1LxLzCA2C1DNufPXweK8AsYSb1c3MkKM1JRo
	uHQPLM4pYCbx9uVxsHohAR6JVxv2M0LUC0qcnPmEBcRmFpCXaN46mxlkmYTAZzaJjd3voW6T
	lDi44gbLBEb+WUh6ZiHpWcDItIpRKDOvLDcxM8dEL6MyL7NCLzk/dxMjMAKW1f6J3sH46ULw
	IUYBDkYlHt6EtQoZQqyJZcWVuYcYJTiYlUR4pzLIZwjxpiRWVqUW5ccXleakFh9ilOZgURLn
	NfpWniIkkJ5YkpqdmlqQWgSTZeLglGpgXDBvadt39nXpvRNPzL3y1+bNsvh/+99V79s1df7f
	6aveskUssVuYPatgm4+mVuWqE7U5F52ND3+7dvkB79oc27S8PzGOL9+8Dqyb9MCQc8d1o/nm
	OnfNzx9h/ed1T0ztgMBvoyk8//lZ914+y97PM08m8nnY/mtZd7MCeed2NNfG/nm6Y+WVP55K
	LMUZiYZazEXFiQBOGpsFfAIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMLMWRmVeSWpSXmKPExsXCNUNNS1dtg2KGwcIvMhZz1q9hs5g+9QKj
	xc+7x9ktPj97zWzx8/AOFotVC6+xWRzfOo/dYtKha4wWh+eeZLU4P+sUi8XlXXPYLO6t+c9q
	cejac1aL1WsyLH5vW8HmwO+xc9Zddo8Fm0o9utsus3u0HHnL6rF4z0smj02rOtk8Nn2axO5x
	YsZvFo+dDy09vt328Fj84gOTx+dNcgE8UVw2Kak5mWWpRfp2CVwZp+dvZSzo4q64tPcdcwPj
	e44uRk4OCQETiUmtv5i6GDk42ASUJI7tjQExRQRUJdquuHcxcnEwC6xilnh/djcTSLmwQILE
	qXmXmEFsFqCac+evg8V5BYwl3q5uZIQYqSnRcOkeWJxTwEzi7cvjYPVCAjwSrzbsZ4SoF5Q4
	OfMJC4jNLCAv0bx1NvMERp5ZSFKzkKQWMDKtYhTJzCvLTczMMdUrzs6ozMus0EvOz93ECAz6
	ZbV/Ju5g/HLZ/RCjAAejEg+vhL9ihhBrYllxZe4hRgkOZiUR3qkM8hlCvCmJlVWpRfnxRaU5
	qcWHGKU5WJTEeb3CUxOEBNITS1KzU1MLUotgskwcnFINjBv+z2WclX4oaIJW5bYgXqdo81AJ
	WbNWjS7NwBda3841n1n7TEKk89p3Jeedp29s7qyxE8iMUfgu8XnGHq/aICX7HzPXxW33ujx1
	2pSDL6ZJpXDMrtSUFzCpuWV36fXVNvXmAu5ekS9uuxctyo/8zOH/itn61jVdyR9/yyOLWljd
	UzT+u06dr8RSnJFoqMVcVJwIAKkpSYN2AgAA
X-CFilter-Loop: Reflected

On Fri, 9 May 2025 12:29:53 -0400 Gregory Price <gourry@gourry.net> wrote:
> On Fri, May 09, 2025 at 12:31:31PM +0100, Jonathan Cameron wrote:
> > Anyhow, short term I'd like us to revisit what info we present from HMAT
> > (and what we get from CXL topology descriptions which have pretty much everything we
> > might want).
> > 
> 
> Generally I think if there is new data to enrich the environment, we
> should try to collect that first before laying down requirements for new
> interfaces / policies.  So tl;dr: "This first, please!"
> 
> (I know we discussed this at LSFMM, dropped out of my memory banks)
> 
> ~Gregory
> 

Thank you for your response and for providing clear direction.

I fully agree with your suggestion that we should first focus on gathering
and exposing the relevant data before moving forward with new policies or
interfaces.

In practice, I believe many of the proposed enhancements can only function
meaningfully if we have a solid understanding of the memory topology and
interconnect structure?and if that information is reliably accessible in
userspace.

Without such data, there is a risk that even well-intentioned policies may
end up diverging from real hardware behavior, or possibly degrading system
performance.

Thank you again for pointing us in the right direction. I'll continue to
revisit my ideas along this path.

Best regards,
Rakie

