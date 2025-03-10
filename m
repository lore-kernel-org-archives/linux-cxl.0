Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8487E380;
	Mon, 10 Mar 2025 09:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741597458; cv=none; b=IEvUe+IIyL7NNCBEvMecS/XUUkiwpT5SSvRlcBBrOwkfguISlr3AY8aF5uZfBnADpBuzks5xtyOksjslNZDfUDboURK8aHK3YOqS1viHPKQYywggjo8iB1Xxvi+eg4A9ISBmYBB95/Lo4Pub15f9zYZsIuxBJAbil5igoIjo7RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741597458; c=relaxed/simple;
	bh=duiR4O3nFUCNISuaOrIEF/tyyPMnLqTtkPJbP8POQ78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oAmOdk01ptWLEqt9UU5eKw43DWHEBW0EiAVDiUvPLLt/LW4uRIYYm1ZWb6sjpx+KPJtNIzjThx8SO2kxM8fQiY0Z02184a4w+N/dsyc3IYtbp8ZRqoPxqI3nTWJbFTEaVabyLb8fkd2G9pSzqNSzGbX4EjklTHUBO99voTs35Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3c9ff7000001d7ae-24-67ceab0c1a25
From: Rakie Kim <rakie.kim@sk.com>
To: Gregory Price <gourry@gourry.net>
Cc: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	joshua.hahnjy@gmail.com,
	dan.j.williams@intel.com,
	ying.huang@linux.alibaba.com,
	kernel_team@skhynix.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com,
	Rakie Kim <rakie.kim@sk.com>
Subject: Re: [PATCH 0/4] mm/mempolicy: Add memory hotplug support in weighted interleave
Date: Mon, 10 Mar 2025 18:03:59 +0900
Message-ID: <20250310090407.631-1-rakie.kim@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <Z8trXFxJVlYI9LAF@gourry-fedora-PF4VCD3F>
References: 
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDLMWRmVeSWpSXmKPExsXC9ZZnkS7P6nPpBluu8lvMWb+GzWL61AuM
	Fj/vHme3OL51HrvF+VmnWCwu75rDZnFvzX9Wi9VrMhw4PHbOusvu0d12md1j8Z6XTB6bPk1i
	9zgx4zeLx86Hlh6fN8kFsEdx2aSk5mSWpRbp2yVwZXw9t5Gx4AR/xbYXF9gbGNfzdDFyckgI
	mEis2LGWGca+1PGTqYuRg4NNQEni2N4YEFNEQFWi7Yp7FyMXB7PAeiaJ15tmsYGUCwtESDw9
	08IKYrMA1ex4+40RxOYVMJa4/PspG8RITYmGS/eYQGxOATOJvfdOgtULCfBIvNqwH6peUOLk
	zCcsIDazgLxE89bZzCDLJATOsEmc+P4LapCkxMEVN1gmMPLPQtIzC0nPAkamVYxCmXlluYmZ
	OSZ6GZV5mRV6yfm5mxiBYbys9k/0DsZPF4IPMQpwMCrx8D6YdzZdiDWxrLgy9xCjBAezkgiv
	2vZT6UK8KYmVValF+fFFpTmpxYcYpTlYlMR5jb6VpwgJpCeWpGanphakFsFkmTg4pRoYVa/y
	vgo/P/eawbS9bxvr9VZXTSjYzBp8Iu129Wap6mdsx5/taRAuKl+xNLBT9sVP86J10ofn8Bdm
	bY07uo/jRP3fsJL1k/+p/y7nXjD5yxuL/U+YFjZ4MG96/LT8AE/TbeXHdk/t7BYL6fj4K9z5
	2y67QJjFeOGJMnGxTF8XfYavrB6rj39cocRSnJFoqMVcVJwIAAfAdq5fAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGLMWRmVeSWpSXmKPExsXCNUNNS5dn9bl0g+WLWS3mrF/DZjF96gVG
	i593j7NbfH72mtni+NZ57BaH555ktTg/6xSLxeVdc9gs7q35z2px6NpzVovVazIsfm9bwebA
	47Fz1l12j+62y+wei/e8ZPLY9GkSu8eJGb9ZPHY+tPT4dtvDY/GLD0wenzfJBXBGcdmkpOZk
	lqUW6dslcGV8PbeRseAEf8W2FxfYGxjX83QxcnJICJhIXOr4ydTFyMHBJqAkcWxvDIgpIqAq
	0XbFvYuRi4NZYD2TxOtNs9hAyoUFIiSenmlhBbFZgGp2vP3GCGLzChhLXP79lA1ipKZEw6V7
	TCA2p4CZxN57J8HqhQR4JF5t2A9VLyhxcuYTFhCbWUBeonnrbOYJjDyzkKRmIUktYGRaxSiS
	mVeWm5iZY6pXnJ1RmZdZoZecn7uJERi6y2r/TNzB+OWy+yFGAQ5GJR7eB/POpguxJpYVV+Ye
	YpTgYFYS4VXbfipdiDclsbIqtSg/vqg0J7X4EKM0B4uSOK9XeGqCkEB6YklqdmpqQWoRTJaJ
	g1OqgfHgtZ9b1jdt3vLHfc9ivtD06UeWCPreKeqzs3myzrhA6vja2dPWOc0+8mNT9h8l67+S
	Ey591Y7/PG/Vm673+x61amzL5dpq8WhH714BieZA7TitJZNiNvTcD/To0s9wPdBubvfqmsCH
	b5Muvez7+DPoQPSb71zGc+wT+ZTfvhda473R1dlkYudsJZbijERDLeai4kQAkS/YWFkCAAA=
X-CFilter-Loop: Reflected

On Fri, 7 Mar 2025 16:55:40 -0500 Gregory Price <gourry@gourry.net> wrote:
> On Fri, Mar 07, 2025 at 10:56:04AM -0500, Gregory Price wrote:
> > 
> > I think the underlying issue you're dealing with is that the system is
> > creating more nodes for you than it should.
> > 
> 
> Looking into this for other reasons, I think you are right that multiple
> numa nodes can exist that cover the same memory - just different
> regions.
> 

I understand your concerns, and I agree that the most critical issue at the
moment is that the system is generating more nodes than necessary.
We need to conduct a more thorough analysis of this problem, but a detailed
investigation will require a significant amount of time. In this context,
these patches might offer a quick solution to address the issue.

Additionally, it's important to note that not many CXL devices have been
developed yet, and their operations are not entirely optimized. Therefore,
we might encounter behaviors from CXL devices and servers that differ from
our expectations. I hope these patches can serve as a solution for
unforeseen issues.

> I can see why you would want to hide the nodes that don't actively have
> memory online, but i still have concerns for nodes that may come and
> go and hiding this configuration from the user until memory arrives.
> 
> An example would be a DCD device where a node could add or remove memory
> at any time.  If you removed the last block of memory, the node would
> disappear - but the block could come back at any time.  That seems
> problematic, as you might want to manage that node while no memory is
> present.
> 
> ~Gregory

Of course, the patches may need further refinements. Therefore, I plan to
simplify the patches and remove any unnecessary modifications in the upcoming
version 2 update. Once it's ready, I would be very grateful if you could take
the time to review version 2 and share any further feedback you might have.

Rakie

