Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2622DA742
	for <linux-cxl@vger.kernel.org>; Fri,  6 Feb 2026 15:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770393195; cv=none; b=gXBJt2291a5EdUmYL+sPEoqaiQ1WhMzYa+YoPWoss3te1l3pxqfS+dXC+ZcluFqUBUMK6z/HyUXq8FZ52yZHyi1MoUWFQ0ZoqacqCbv6UQdUe1PYcMtrDfheixjtQJJ1Iv0+A10sUlQLj+mqWqlKBe2vrCPayUQ8oPEFwjy4590=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770393195; c=relaxed/simple;
	bh=4wWjMagyUrHFa6ykvR013drrWBoFX5wJB108jihgH2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LA5nYUKUGUrtCQINECms2V9P7MU5hZ8gvFjQOJp416YJjtzwqtQz7ZwAsjoC0oSUTSquJykP6SDZ+Q8VHEBiwRjdZY0ytfF64hLOHQ9U4ONAKmrsZF+9wY2y5iY2Hha8TycVZGG4CfaL4utGpfFEUCSF46krqnih39yqa70h3Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Af6TyqE6; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Af6TyqE6"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8c70daf9c94so80471385a.0
        for <linux-cxl@vger.kernel.org>; Fri, 06 Feb 2026 07:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1770393194; x=1770997994; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7podOaUCjU/O3I21k18RXk2UZLq1mKBY8Ro47wlihIQ=;
        b=Af6TyqE67CUBGVHxevIzSz+gmT1txQK41kf+3haMSoQ1HwC/tmtFGiW5EGT3AziPxo
         ovuO0PZpRATsVOQeLrK3tvNQm31yrepj789o+bvH9o3/d+DDrj/HUzkTXAvqEUffxYFi
         Xs1vp9T1osOFSuMtXXgfuf+8uC+eWZB1R6hbtKDl2sljMUEU9C6m1GBR4C2NmyoZpzmZ
         6gUCGeH3CxJ9NDQYIcA+FsppWo4N3gCTq1jRhLXIlgY9BKQ/1ResZNfIcqBFFsRMZ60r
         z3KwJiSmW9SqDIc/S8OPT5N7yZZWPnjlPblwSvgsPww6BUvSNKDRJrdnzjBAxG64skyJ
         UFgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770393194; x=1770997994;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7podOaUCjU/O3I21k18RXk2UZLq1mKBY8Ro47wlihIQ=;
        b=GT57K4AQGQ5tSLxJshrG/YyTT8Bm0c8PHnlt0VWLwanZ2piok28Hjxbk3MBu0FoXfS
         B9PH0XpdB+GlLxB3Ok4xTgQf9GXc8Co+EWnO6UHdeCs3QyprnlPwJdJOU/5pDiQJZtIw
         fKTLlSrLnTdyiFImz691d/X/dJuWo8mTfbOgoMPT4/L49HPmn24LRTcYduS7SfGgYosl
         Q582JbIGlvOuz+DzK5zoGfcKYIMOQdE1+pEUNpqPk3fP2rG+3iFGvJioTmbVXKS8wi0J
         BpiHgVaA6YFTu/XKzAFdJ3Wr1dRQoiUIXhuAhk8bg2Ro3T6xUIW4PVyyFBcPAk3QxuD/
         oaLA==
X-Forwarded-Encrypted: i=1; AJvYcCWc7fciOq2xCA5QGt6jVI/0NPupTzVpEl7PzbivuiFeDJtKJZAB3I5RDlq+MbrhjivUaP4NsRvQmAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzokdjrO1/22RgeQtwjDnjrBrY9LBYbkq6Zl+WbO112SUn5bJOA
	HhBRI9NKmAGX3DOWbp4R3NpVm4+jK15utiGRx2gkIWe/mC337bnBi8hjQFaiFZq5Ouo=
X-Gm-Gg: AZuq6aKwnDoT5u8GUx9TNSczIhPZl1BhwxobAtxiNIZHlRge1PpNXUi2kd6CSVQWpjd
	Y1fh5Z7fGOn57IY8800/HR6CqRYLBa8Aj73lOckxsEkWSEhRY1GZGFuoUcPU3YmRX/QuHyPmUCl
	sziRcLnoAjCytNawqtbyeaH4nkuuym6zXraxtjC94wN+PFOMIAqETbTT+ygpMeSR9EK5vV/hCM2
	MWi3A/rO5TFl2vcYi7HT0m7jjElruhuCUeHASB/fPyvtYkFKfXlEgg3ER88cMHbOZGni9nyH0Kl
	3Mi0iP73i9vmcLzlKDiwa/jLnLsqu+cpxoRA9M7VPpluJurgem2VTRbLBo6KRQRVwgnpoK2WHPs
	0TPvJ03/Tujqyp1/eASqa036JzKS866hSSTxUt9mbk2IED38Q4lJdXnyr8TPdE4V655LPMEe/3D
	XRGoSMkJiz5yE8jVgNSBpr758aRzCgpaCuk6Jx4ZnFZR64QrEsXY1z5mrOzHT1U9qo2wygik/KB
	tQNxKKfNA==
X-Received: by 2002:a05:620a:44cf:b0:8c6:a1d5:47e1 with SMTP id af79cd13be357-8caeeb4e117mr380491485a.9.1770393193829;
        Fri, 06 Feb 2026 07:53:13 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8caf9fdf739sm176815485a.41.2026.02.06.07.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 07:53:13 -0800 (PST)
Date: Fri, 6 Feb 2026 10:53:11 -0500
From: Gregory Price <gourry@gourry.net>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Cui Chao <cuichao1753@phytium.com.cn>, dan.j.williams@intel.com,
	Mike Rapoport <rppt@kernel.org>,
	Wang Yinfeng <wangyinfeng@phytium.com.cn>,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, qemu-devel@nongnu.org,
	"David Hildenbrand (Arm)" <david@kernel.org>
Subject: Re: [PATCH v2 1/1] mm: numa_memblks: Identify the accurate NUMA ID
 of CFMW
Message-ID: <aYYOZ1TK5dpX_h_Q@gourry-fedora-PF4VCD3F>
References: <20260115101858.85fd7b8e837c1c92a4fdc5f0@linux-foundation.org>
 <696944eca1837_34d2a10056@dwillia2-mobl4.notmuch>
 <2d1e23ad-7ec1-483b-88b3-70ce19b69106@phytium.com.cn>
 <aXOl9CN_66HywIjZ@gourry-fedora-PF4VCD3F>
 <a90bc6f2-105c-4ffc-99d9-4fa5eaa79c45@phytium.com.cn>
 <20260205145842.efb90572a902ae4c481e6ef6@linux-foundation.org>
 <aYUjf0OrD8f_bJCy@gourry-fedora-PF4VCD3F>
 <20260206110305.00001fbb@huawei.com>
 <aYXtHa4Y2y_5xgcS@gourry-fedora-PF4VCD3F>
 <20260206150941.000028ae@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206150941.000028ae@huawei.com>

On Fri, Feb 06, 2026 at 03:09:41PM +0000, Jonathan Cameron wrote:
> On Fri, 6 Feb 2026 08:31:09 -0500
> Gregory Price <gourry@gourry.net> wrote:
> 
> Now a fun corner is that a node isn't created unless there is something
> in it - the whole SRAT is the source of truth for what nodes exist
> - so we need 'something' in it - a cpu will do, or a GI, probably a GP.
> Otherwise memory ends up in node0.  However, fallback lists etc happen
> as normal when first mem in a node is added.
> 
...
> For now I 'suspect' we could hack things to provide lots of waiting numa nodes
> and merrily assign HPA into them as we like whatever SRAT provides
> in the way of 'hints' :) 
> 

look at ACPI MSCT - "Maximum Proximity Domain Information Structure" ;]

I don't remember reading anything in the ACPI spec that says something
has to be ON any of these PXMs for it to be accounted for in the MSCT.

Platforms can just say "Reserve that many Nodes".

(Linux does not read this value, and on my existing systems, this number
always reflects the number of actually present PXMs)

---

We probably want to ignore that and just add this:

CONFIG_ACPI_NUMA_NODES_PER_CFMWS
    int
    range 1 4
    help
        This option determines the number of NUMA nodes that will be
	added for each CEDT CFMWS entry.

	By default ACPI reserves 1 per unique PXM entry in the SRAT,
	or 1 for a CXL Fixed Memory Window without SRAT mappings.

	This will reserve up to N nodes per CEDT entry, even if that
	CEDT has one or more SRAT entries.

then in the acpi/numa/srat.c code that parses srat/cedt, just track
the number of nodes over a CEDT range.

for each srat:
   account_unique_pxm(pxm, srat_range)

for each cedt:
   nr_nodes = unique_pxms(cedt_range)
   while (nr_nodes < CONFIG_ACPI_NUMA_NODES_PER_CFMWS)
      node = acpi_map_pxm_to_node(*fake_pxm++);
      if (node == NUMA_NO_NODE):
      	err("Unable to reserve additional nodes for CXL windows")
	break;
      node_set(node, numa_nodes_parsed);
      nr_nodes++

This should fall out cleanly.

The additional nodes won't be associated with anything, but could be
used for hotplug - I imagine.

~Gregory
