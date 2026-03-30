Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703A8382F01;
	Mon, 30 Mar 2026 08:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774859317; cv=none; b=LXDkn9jL7hxbC6emxv5aB1Ed6SuldiTjST/Q9BianYVMxij5pn+7+v3nH2gqqaqus6bL/vul86YyebWAMsKbqiwrm6fKtEbOeQRmopceaxqM8misCt5Vt/D6tvJWgAGT+73O4t+lirOP7WfjNDr4yq69SQt3Umji34v5Kp/pzgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774859317; c=relaxed/simple;
	bh=YDpASFjQCOTzlfzy12YCa/9uHlCwjv7msQ8S/X88ue8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iqWodS/6ZIe2rMTM5sS489fQ8v0ZxsqSo//VH+8rtiE2BBo1/vpgBLVqjg4L2AGVF+aGxXqk4Iou/HpdECGawFuZMTkNnTVBe0VzxBI4SaxLJeu++xRxtKo9zh0Z2+PY/lxolnbt1c4h6lK/lt1qtceSM1dHLsm2AvYj/CtVSEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d/4p3R1G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d/4p3R1G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA442C4CEF7;
	Mon, 30 Mar 2026 08:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774859317;
	bh=YDpASFjQCOTzlfzy12YCa/9uHlCwjv7msQ8S/X88ue8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d/4p3R1GMvblqdxQVSK1PTCXpFz/7tDlceet4ZrIV8tf0mn/u3mVVLnjdsL5VDrh8
	 jo3fLS04eUYvcFZqmLfdBtf8MD13Em2sZsUK/kIkkmZTG3+7aiIzS/UI6Y5tBGBSGU
	 mbxJ/yTEEPYeL+Ogvyrj5JupUu6gMrqge6alNhL4LEAO244nAvln3SOP3R8ORZKHlS
	 4GlR2Fy7HQJOm/nF28b1zWSSJkVBt7ggPkenY/PcYUD0VwlX3aPTq2eE1DE6YjSHMn
	 HQGY8/7/1+1bo+L5gRrzVqmuRkWbx6agXcgCsgzPnlg4FtWg7uN99jtUPCBEPpVabu
	 qbgzTBbfK+lTw==
Date: Mon, 30 Mar 2026 17:28:34 +0900
From: "Harry Yoo (Oracle)" <harry@kernel.org>
To: Hao Li <hao.li@linux.dev>
Cc: david@kernel.org, osalvador@suse.de, akpm@linux-foundation.org,
	vbabka@suse.cz, joshua.hahnjy@gmail.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2] mm/memory_hotplug: maintain N_NORMAL_MEMORY during
 hotplug
Message-ID: <aco0MtqpysMXMZdy@hyeyoo>
References: <20260330035941.518186-1-hao.li@linux.dev>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330035941.518186-1-hao.li@linux.dev>

On Mon, Mar 30, 2026 at 11:57:49AM +0800, Hao Li wrote:
> N_NORMAL_MEMORY is initialized from zone population at boot, but memory
> hotplug currently only updates N_MEMORY. As a result, a node that gains
> normal memory via hotplug can remain invisible to users iterating over
> N_NORMAL_MEMORY, while a node that loses its last normal memory can stay
> incorrectly marked as such.
> 
> Restore N_NORMAL_MEMORY maintenance directly in online_pages() and
> offline_pages(). Set the bit when a node that currently lacks normal
> memory onlines pages into a zone <= ZONE_NORMAL, and clear it when
> offlining removes the last present pages from zones <= ZONE_NORMAL.
> 
> This restores the intended semantics without bringing back the old
> status_change_nid_normal notifier plumbing which was removed in
> 8d2882a8edb8.
> 
> Current users that benefit include list_lru, zswap, nfsd filecache,
> hugetlb_cgroup, and has_normal_memory sysfs reporting.
> 
> Fixes: 8d2882a8edb8 ("mm,memory_hotplug: remove status_change_nid_normal and update documentation")

The Fixes: tag indeed looks correct to me.

By the way, MM needs an explicit Cc: stable@vger.kernel.org for backporting.

Since this commit was introduced in v6.17 and we have v6.18 as LTS,
this should to be backported to v6.18.

> Signed-off-by: Hao Li <hao.li@linux.dev>
> ---

Otherwise looks good to me,
Reviewed-by: Harry Yoo (Oracle) <harry@kernel.org>

-- 
Cheers,
Harry / Hyeonggon
