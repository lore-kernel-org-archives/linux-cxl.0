Received: from sg-1-102.ptr.blmpb.com (sg-1-102.ptr.blmpb.com [118.26.132.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2127036D4EF
	for <linux-cxl@vger.kernel.org>; Tue, 20 Jan 2026 06:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768890577; cv=none; b=g/6ngaIMiVsDb12gj1M/tCiStt6Cv5lB5XcJdHEGO/Xvd8L3R3bjV9vZEKCEvFlqy2gywaRq7HA5fawq1aE/xtDZhU3nmSCtJCV6lXQYq6/tULZOfHa9EheznO3TOBqjydwZUgOhSeZ4Jk7GzpEGuD0nYsAv8iQ6j5PNE6RqBxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768890577; c=relaxed/simple;
	bh=D1TQMPSXv5PjTxr6RBKljUmzcShoTJ2wcS+IGRnPiEo=;
	h=From:Date:Message-Id:Mime-Version:To:Cc:Subject:In-Reply-To:
	 References:Content-Type; b=poif8KtxLLDh1NqZuH3pDSJnb/aMZuzbi4DQ9udQzI/oUWCCOczFBAp1tt66bS//7T0kjvfcPHPBbuBDUNoWe0Yjy+mOExPLBWep1y5p34+58wT7p5IZRdS4JehW7sNH1w7evgrWIAUOCdoi8phitAnA3BFQvXVf+L4YuOdJDTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=CH2la0no; arc=none smtp.client-ip=118.26.132.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="CH2la0no"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1768890448; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=D1TQMPSXv5PjTxr6RBKljUmzcShoTJ2wcS+IGRnPiEo=;
 b=CH2la0noBDTfmNxG1mvb65RbwKCp2kcAoyUGrNBcRMGP5unjqoJp3Z4MI8Rh6tLNPXiDJD
 HRfqwtc9IW4GNVkZXGC4pdEANZAbV9jVKburZ8o/Kt9hoO8ZGcJWDRgTes0MdhoVC2DJ34
 MaV0D8+GDs8hgtF6jmanDNt0WTGXUVEkE5ongYYTcFDEjK29t9uT9/XnO221pVD88hOfMC
 UrDShaPzVyv5paKgf7vEdjIEl6e8E8d7oASD057HsxV914OSpZiBzcgLkDJTl6FODSX2+h
 FIdRAa2Xhi4TLf824nAr1OGdJyCXCZw/iPyQfYW53q/RU91eA608F3Lnjmh1jw==
From: "Li Zhe" <lizhe.67@bytedance.com>
Date: Tue, 20 Jan 2026 14:27:06 +0800
Message-Id: <20260120062706.91078-1-lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+2696f204e+67f270+vger.kernel.org+lizhe.67@bytedance.com>
To: <david@kernel.org>
Cc: <akpm@linux-foundation.org>, <dan.j.williams@intel.com>, 
	<dave@stgolabs.net>, <ankur.a.arora@oracle.com>, <fvdl@google.com>, 
	<gourry@gourry.net>, <joao.m.martins@oracle.com>, 
	<jonathan.cameron@huawei.com>, <linux-cxl@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, 
	<lizhe.67@bytedance.com>, <mhocko@suse.com>, <mjguzik@gmail.com>, 
	<muchun.song@linux.dev>, <osalvador@suse.de>, <raghavendra.kt@amd.com>, 
	<wangzhou1@hisilicon.com>, <zhanjie9@hisilicon.com>
Subject: Re: [PATCH v2 0/8] Introduce a huge-page pre-zeroing mechanism
Content-Transfer-Encoding: 7bit
In-Reply-To: <87wm1ih5kb.fsf@oracle.com>
References: <87wm1ih5kb.fsf@oracle.com>
X-Mailer: git-send-email 2.45.2
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
Content-Type: text/plain; charset=UTF-8

In light of the preceding discussion, we appear to have reached the
following understanding:

(1) At present we prefer to mitigate slow application startup (e.g.,
VM creation) by zeroing huge pages at the moment they are freed
(init_on_free). The principal benefit is that user space gains the
performance improvement without deploying any additional user space
daemon.

(2) Deferring the zeroing from allocation to release may occasionally
cause the thread that frees the page to differ from the one that
originally allocates it, so the clearing cost is not charged to the
allocating thread. Because this situation is rare and the existing
init_on_free mechanism in the kernel already exhibits the same
behavior, we deem the consequence acceptable.

(3) The function __unmap_hugepage_range() employs the MMU-gather
mechanism, which refrains from dropping the page reference while
holding the PTL (spinlock). This allows huge-page zeroing to be
performed in a non-atomic context.

(4) Given that, in the vast majority of cases, the same thread that
allocates a huge page also frees it, and the exceptions highlighted
by David are genuinely rare[1]. We can achieve faster application
startup by implementing an init_on_free-style mechanism.

(5) Going forward we can further optimize the zeroing process by
leveraging a DMA engine.

If the foregoing is accurate, I propose we add a new hugetlbfs mount
option to achieve the init-on-free behavior.

Thanks,
Zhe

[1]: https://lore.kernel.org/all/83798495-915b-4a5d-9638-f5b3de913b71@kernel.org/#t
