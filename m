Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6BD13AA2E;
	Fri, 14 Mar 2025 06:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741934160; cv=none; b=sEKJ/+rZR5cm6jA4/ROM32sdRJi4+hK2Ukar8e4pWr0pgkuaizlg0NnnzFW25hbwAQ3V08QjMDUOphQmV4JweyDm54xw7JX1GI6ICbuWG/we8XFou8KUeroHUjChzIEnxUg2VvpZVXNlTTxmWRZ18Fbd8RJ9OykkyzDyqsFxxm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741934160; c=relaxed/simple;
	bh=mFDtmYZsMJ3f91VrML5go1J6TKHkulMHxYAi5Y5fuRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J/rYpo1dJoNfXZ04IzI1S67RaBcu6sGtW/V9KpfXMrf3QqsbjKPGYIZeTvBQ33T4rTzHxaP//SZV9aNX3kPf5IhkQwo0ocBlr9LsZ0gm3OZ7uYCFDL1uEV4FpS4bDP57wyznDXFQvJ/yzPcfh7M2O60vTo2rslnMP9FB+jkhNxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-51-67d3ce4a1a60
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
Subject: Re: [PATCH v2 4/4] mm/mempolicy: Fix duplicate node addition in sysfs for weighted interleave
Date: Fri, 14 Mar 2025 15:35:40 +0900
Message-ID: <20250314063547.765-1-rakie.kim@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <Z9MK235uVDmK1oYB@gourry-fedora-PF4VCD3F>
References: 
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDLMWRmVeSWpSXmKPExsXC9ZZnka7XucvpBrM2SVnMWb+GzWL61AuM
	Fj/vHme3OL51HrvF+VmnWCwu75rDZnFvzX9Wi9VrMhw4PHbOusvu0d12md1j8Z6XTB6bPk1i
	9zgx4zeLx86Hlh6fN8kFsEdx2aSk5mSWpRbp2yVwZUw7eJ+54Cp7Rcufz0wNjH1sXYycHBIC
	JhJNJ3azwNivm/YDxTk42ASUJI7tjQExRQRUJdquuHcxcnEwC6xnkni9aRZYq7BAmsTxY8dZ
	QWwWoJqLn1ayg9i8AsYSDXtaGSFGako0XLrHBGJzCphJvPv6FKxXSIBH4tWG/YwQ9YISJ2c+
	ATuBWUBeonnrbGaQZRICJ9gkDvfMZ4YYJClxcMUNlgmM/LOQ9MxC0rOAkWkVo1BmXlluYmaO
	iV5GZV5mhV5yfu4mRmAYL6v9E72D8dOF4EOMAhyMSjy8G3ZdShdiTSwrrsw9xCjBwawkwrva
	9kK6EG9KYmVValF+fFFpTmrxIUZpDhYlcV6jb+UpQgLpiSWp2ampBalFMFkmDk6pBkbnx/er
	PnXzSt3ecGlF8ff352t3xyV9zgoumf/0Sfgjg6ALcz6a/trl9HxPLaPF/cZNi2yOvzBuLpwz
	e4vKTfFjO1PEexYK50nKis/+Vu3noOrYsKV+9eNpZ70ObSg8sFJmrpPPhsboqPyZk4LmLYue
	EXi6rcOi1el8glgv2+3b1juDHjFLVHYqsRRnJBpqMRcVJwIAG1HM9l8CAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGLMWRmVeSWpSXmKPExsXCNUNNS9fr3OV0g1O3uSzmrF/DZjF96gVG
	i593j7NbfH72mtni+NZ57BaH555ktTg/6xSLxeVdc9gs7q35z2px6NpzVovVazIsfm9bwebA
	47Fz1l12j+62y+wei/e8ZPLY9GkSu8eJGb9ZPHY+tPT4dtvDY/GLD0wenzfJBXBGcdmkpOZk
	lqUW6dslcGVMO3ifueAqe0XLn89MDYx9bF2MnBwSAiYSr5v2A9kcHGwCShLH9saAmCICqhJt
	V9y7GLk4mAXWM0m83jQLrFxYIE3i+LHjrCA2C1DNxU8r2UFsXgFjiYY9rYwQIzUlGi7dYwKx
	OQXMJN59fQrWKyTAI/Fqw35GiHpBiZMzn7CA2MwC8hLNW2czT2DkmYUkNQtJagEj0ypGkcy8
	stzEzBxTveLsjMq8zAq95PzcTYzA0F1W+2fiDsYvl90PMQpwMCrx8G7YdSldiDWxrLgy9xCj
	BAezkgjvatsL6UK8KYmVValF+fFFpTmpxYcYpTlYlMR5vcJTE4QE0hNLUrNTUwtSi2CyTByc
	Ug2MvLE9qRVvTOqX6y3Ndz5jz39xxSHVpdq+nB2PHp+rj3Tlvcf2bvPRzca9x30P/E+vaP5q
	sc3+/K8zP6ac/SZx8yiLpAZbjMTdj8f+2sVXS5y4x9j7+Ren1DTvajnNha0mL9n436xr/JN5
	5nz4IetsG/+H2vcuXhXj1NnA+9OtSnWF0ISbx5ROKrEUZyQaajEXFScCAKBQDMRZAgAA
X-CFilter-Loop: Reflected

On Thu, 13 Mar 2025 12:42:03 -0400 Gregory Price <gourry@gourry.net> wrote:
> On Wed, Mar 12, 2025 at 04:56:27PM +0900, Rakie Kim wrote:
> > Sysfs attributes for interleave control were registered both at initialization
> > and when new nodes were detected via hotplug, leading to potential duplicates.
> > 
> > This patch ensures that each node is registered only once, preventing conflicts
> > and redundant sysfs entries.
> >
> 
> After looking more closely at patch 2, this seems to suggest we're not
> understanding the OFFLINE/ONLINE events well enough to use for this
> purpose.  I think this patch won't be needed once we address the
> concerns in patch 2 - and more generally if we discover it is needed
> this should just be rolled into patch 2 rather than kept separate.
> 
> ~Gregory

For this patch, it might be beneficial to merge it with another patch
or change its form. I will consider the changes, including the feedback
from Joshua.

Rakie
