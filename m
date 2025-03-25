Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A66B78F24;
	Tue, 25 Mar 2025 10:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742898458; cv=none; b=FRHkr44dagxRw5DrtIi5yuq4iVExRXv/DfuOk50WpvkxCgx4PPqp6YCuu7VBC8X5C0z07d76QWIom3rWs7ADaPDP0iWpNb8/gSQ6Tua33JuoQRlsIV7M8jzh6in/ylNmozPwJYhKD6tXRcjMOF7XMTnjI+1DliFghcob7WDEYwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742898458; c=relaxed/simple;
	bh=uCtiD23hiy6exa4WkWcAxmNnfzsg5Pv9P7zBclUTfjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kID8Hd52vRspvH/bP2UWqlyigKaXiuEXeDbZASh75samimccWb5JJnxQ4o5iTwOvWwwzDsb7QZzwB2+l4011QdNlxy6OcEq5ktaT2KZOJSTMBDbhLTPhwMZVyLiCt0+awP+UXXY6GxUfAapY82bVawyblF68xjVMp7LAwwZ4XJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-c5-67e2850a5ab2
From: Rakie Kim <rakie.kim@sk.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	kernel_team@skhynix.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	David Hildenbrand <david@redhat.com>,
	Gregory Price <gourry@gourry.net>,
	Honggyu Kim <honggyu.kim@sk.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Yunjeong Mun <yunjeong.mun@sk.com>,
	Rakie Kim <rakie.kim@sk.com>,
	linux-mm@kvack.org,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v3 1/3] mm/mempolicy: Fix memory leaks in weighted interleave sysfs
Date: Tue, 25 Mar 2025 19:27:09 +0900
Message-ID: <20250325102718.1009-1-rakie.kim@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <fca457c2-f0af-4fb8-9771-06916737f9db@web.de>
References: 
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJLMWRmVeSWpSXmKPExsXC9ZZnoS5X66N0gy9HtSzmrF/DZjF96gVG
	i6/rfzFb/Lx7nN1i1cJrbBbHt85jtzg/6xSLxeVdc9gs7q35z2rxf9ZzVovVazIcuD12zrrL
	7tHddpndo+XIW1aPxXteMnls+jSJ3ePEjN8sHjsfWnq833eVzePzJjmP28+2sQRwRXHZpKTm
	ZJalFunbJXBlvL04mb3gEnPFxFUnmBoYm5i7GDk5JARMJLY/7YSzl8y6xNbFyMHBJqAkcWxv
	DIgpIqAl8fSxSRcjFwezQA+LxIkf55lA4sIC4RKtM0RBOlkEVCVWXmsAm8ILNOXqbJASkIma
	Eg2X7oHZnAJWEkevrASrERLgkXi1YT8jRL2gxMmZT1hAbGYBeYnmrbOZQXZJCHxmk7i77jY7
	xCBJiYMrbrBMYOSfhaRnFpKeBYxMqxiFMvPKchMzc0z0MirzMiv0kvNzNzECI2BZ7Z/oHYyf
	LgQfYhTgYFTi4Q0If5guxJpYVlyZe4hRgoNZSYT3GCtQiDclsbIqtSg/vqg0J7X4EKM0B4uS
	OK/Rt/IUIYH0xJLU7NTUgtQimCwTB6dUAyObs1P+x9SbZ/9KmbUJzn91XWivTVRh7//lXlyV
	ql9W6OYzRnyfpCmtZtY88b7fysW5pkWTT56uN/1wrs/Md3FJ5q6OU1vnpK3L0tPRCdcxP+t9
	SK6zzpGF9f2NBFa5Ky43Hl95fZb39vKneVcXTp2S/GLPJ9VfqZJ7Way/zHzpH546YbJ5SZoS
	S3FGoqEWc1FxIgCgK5r4fAIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMLMWRmVeSWpSXmKPExsXCNUNNS5er9VG6wcF/MhZz1q9hs5g+9QKj
	xdf1v5gtft49zm7x+dlrZotVC6+xWRzfOo/d4vDck6wW52edYrG4vGsOm8W9Nf9ZLf7Pes5q
	cegakFi9JsPi97YVbA78Hjtn3WX36G67zO7RcuQtq8fiPS+ZPDZ9msTucWLGbxaPnQ8tPd7v
	u8rm8e22h8fiFx+YPD5vkvO4/WwbSwBPFJdNSmpOZllqkb5dAlfG24uT2QsuMVdMXHWCqYGx
	ibmLkZNDQsBEYsmsS2xdjBwcbAJKEsf2xoCYIgJaEk8fm3QxcnEwC/SwSJz4cZ4JJC4sEC7R
	OkMUpJNFQFVi5bUGsCm8QFOuzgYpAZmoKdFw6R6YzSlgJXH0ykqwGiEBHolXG/YzQtQLSpyc
	+YQFxGYWkJdo3jqbeQIjzywkqVlIUgsYmVYximTmleUmZuaY6hVnZ1TmZVboJefnbmIEBv2y
	2j8TdzB+uex+iFGAg1GJhzci7mG6EGtiWXFl7iFGCQ5mJRHeY6xAId6UxMqq1KL8+KLSnNTi
	Q4zSHCxK4rxe4akJQgLpiSWp2ampBalFMFkmDk6pBsZd2t2LHshs+rEwVIlLb/W+4NcPjf2S
	qwpX16UyL5sUszGYb1NHc5fO5JPZOmvO/Vla+ZvvkkxbqnruA6kG9pWXXn1589zk9bLNPTdD
	ks7xaj16Pk2Q9aXZ3Nv/7Vq+NhlMW5g225/t/Gn997w2h/xWy7CmL2dQ64hkSEuOP73X58Xt
	ChuTLS+UWIozEg21mIuKEwEl7pTfdgIAAA==
X-CFilter-Loop: Reflected

On Mon, 24 Mar 2025 17:40:10 +0100 Markus Elfring <Markus.Elfring@web.de> wrote:
> =E2=80=A6
> > This patch resolves the issue =E2=80=A6
> 
> See also:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
> e/Documentation/process/submitting-patches.rst?h=3Dv6.14#n94
> 
> Regards,
> Markus

Hi Markus

Thank you for your response regarding this patch.
I plan to submit this once the related patches are completed.

Rakie

