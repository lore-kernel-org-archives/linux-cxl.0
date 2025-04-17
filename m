Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C961F8937;
	Thu, 17 Apr 2025 08:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744877478; cv=none; b=akVmlUHtvQv6q0cRcb5g2NjGG32RJjTU1alpjEJawQATMc3ceLsRr6uwyaBQoYkPv1nA174FIWukr1Np2IzAQO9GOncKsbF8M0bbZw1pT3rMr1qs7u+Y7qZ06QoQX6cUvvvgovQnVFrPiajq41/KDbxWsmOOaoOOq6mU1bRl1l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744877478; c=relaxed/simple;
	bh=Eme8szcr1CADWxFkxXJzZqKX2tXuRHI7rR0yLme1TmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=poS+TWiLkHTSlw7M+gSVEq3EjkbZz3Rqn2Mb+q3yU8otBGqzZ+s3vPuiLkuaFZlD6t/Eo653v98DCTkrts6q56xkXxF1KXsBK5ucnMqv92ByaZHEojYktrxT4mX7LfLHVQ1A9JSr/xq5NN+2IaML/0m7g77pboexSVhLMp200Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-57-6800b79e565a
From: Rakie Kim <rakie.kim@sk.com>
To: akpm@linux-foundation.org
Cc: gourry@gourry.net,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	joshua.hahnjy@gmail.com,
	dan.j.williams@intel.com,
	ying.huang@linux.alibaba.com,
	david@redhat.com,
	Jonathan.Cameron@huawei.com,
	osalvador@suse.de,
	kernel_team@skhynix.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com,
	rakie.kim@sk.com
Subject: Re: [PATCH v9 0/3] Enhance sysfs handling for memory hotplug in weighted interleave
Date: Thu, 17 Apr 2025 17:10:08 +0900
Message-ID: <20250417081106.732-1-rakie.kim@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <20250417072839.711-1-rakie.kim@sk.com>
References: 
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCLMWRmVeSWpSXmKPExsXC9ZZnoe687QwZBg8mcFrMWb+GzWL61AuM
	Fl/X/2K2+Hn3OLvFqoXX2CyOb53HbnF+1ikWi8u75rBZ3Fvzn9XizLQii9VrMhy4PXbOusvu
	0d12md2j5chbVo/Fe14yeWz6NInd48SM3yweOx9aerzfd5XNY/Ppao/Pm+QCuKK4bFJSczLL
	Uov07RK4MlZ9PctScIKnomVdUgPjXq4uRk4OCQETiTm/dzJ1MXKA2fuWm4KYbAJKEsf2xoBU
	iAjISkz9e56li5GLg1ngMZPEo+cvGLsY2TmEBWIkJsuCVLMIqErMOx4PUs0rYCzxaesmdojZ
	mhINl+4xgdicQLOn7W5hBrGFBHgkXm3YzwhRLyhxcuYTFhCbWUBeonnrbGaQTRIC39kkHty7
	ywYxSFLi4IobLBMY+Wch6ZmFpGcBI9MqRqHMvLLcxMwcE72MyrzMCr3k/NxNjMCwX1b7J3oH
	46cLwYcYBTgYlXh4Tyz6ny7EmlhWXJl7iFGCg1lJhPec+b90Id6UxMqq1KL8+KLSnNTiQ4zS
	HCxK4rxG38pThATSE0tSs1NTC1KLYLJMHJxSDYz1G45pHrVn6NhiLjTv7oyenQZ39s1Y8Nra
	8kvmkXnl3pPOv1bg23b77qkjlk45nPpmRv0c8Z1JYbXCafrNS3n2/sxeZuNQzs9oPOv+zRma
	qfMS1tY2BEn5XViyxuxmveh23sX3lkqmma0I2viGVWrbxOTSuT2zNUUidineefmv9eGryOoz
	PfuVWIozEg21mIuKEwEjeGR2dwIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHLMWRmVeSWpSXmKPExsXCNUNNS3fudoYMg+9fzCzmrF/DZjF96gVG
	i6/rfzFb/Lx7nN3i87PXzBarFl5jszi+dR67xeG5J1ktzs86xWJxedccNot7a/6zWpyZVmRx
	6NpzVovVazIsfm9bwebA77Fz1l12j+62y+weLUfesnos3vOSyWPTp0nsHidm/Gbx2PnQ0uP9
	vqtsHt9ue3gsfvGByWPz6WqPz5vkAniiuGxSUnMyy1KL9O0SuDJWfT3LUnCCp6JlXVID416u
	LkYODgkBE4l9y01BTDYBJYlje2O6GDk5RARkJab+Pc/SxcjFwSzwmEni0fMXjF2M7BzCAjES
	k2VBqlkEVCXmHY8HqeYVMJb4tHUTO4gtIaAp0XDpHhOIzQk0e9ruFmYQW0iAR+LVhv2MEPWC
	EidnPmEBsZkF5CWat85mnsDIMwtJahaS1AJGplWMIpl5ZbmJmTmmesXZGZV5mRV6yfm5mxiB
	ob6s9s/EHYxfLrsfYhTgYFTi4T2x6H+6EGtiWXFl7iFGCQ5mJRHec+b/0oV4UxIrq1KL8uOL
	SnNSiw8xSnOwKInzeoWnJggJpCeWpGanphakFsFkmTg4pRoY+TaF7+fv3/lb8nPzxl1ceY7p
	523CS+QSio4Lik0/mbv0b8u8bfFvLk4qfcfkvyP0eZ3oaZlT/5c3mF1O7rFbWb60epb033/n
	Njw7E5zqkLFSY5lvYVr5xOO/5JavLExaZtuXzmcd/0/mj2nb04fdjfma4XeWTj9pozkpZGLV
	DrPksn4Tt5lzlViKMxINtZiLihMBvdXI8nECAAA=
X-CFilter-Loop: Reflected

On Thu, 17 Apr 2025 16:28:34 +0900 Rakie Kim <rakie.kim@sk.com> wrote:
> These patches have been tested under CXL-based memory configurations,
> including hotplug scenarios, to ensure proper behavior and stability.
> 
>  mm/mempolicy.c | 240 ++++++++++++++++++++++++++++++-------------------
>  1 file changed, 148 insertions(+), 92 deletions(-)
> 
> base-commit: 8ffd015db85fea3e15a77027fda6c02ced4d2444
> -- 

To Andrew

I sincerely apologize for causing repeated inconvenience. The series of
patches version v8 that was merged into -mm, mm-new today needs
additional corrections.
Link: https://lore.kernel.org/all/6800742de6315_130fd2949c@dwillia2-mobl3.amr.corp.intel.com.notmuch/
Therefore, I have updated a new version v9, in which the problems have
been addressed.

I would greatly appreciate it if you could drop the existing v8 and
replace it with the new version v9. Below is the information regarding
the v8 patch series that needs to be dropped.
Once again, I truly apologize for the inconvenience.

<1>
The patch titled:
     Subject: mm/mempolicy: fix memory leaks in weighted interleave sysfs
Filename:
     mm-mempolicy-fix-memory-leaks-in-weighted-interleave-sysfs.patch

<2>
The patch titled:
     Subject: mm/mempolicy: prepare weighted interleave sysfs for memory hotplug
Filename:
     mm-mempolicy-prepare-weighted-interleave-sysfs-for-memory-hotplug.patch

<3>
The patch titled:
     Subject: mm/mempolicy: support memory hotplug in weighted interleave
Filename:
     mm-mempolicy-support-memory-hotplug-in-weighted-interleave.patch

Rakie

