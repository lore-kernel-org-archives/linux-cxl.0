Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C6E25B085
	for <linux-cxl@vger.kernel.org>; Sun, 20 Sep 2026 09:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789895660; cv=none; b=od8lM+Vv/rkQjRa+9zhZei2bnDMUwGe6nZl/4vDkDOdgWljukBpO+uWiv7zU9nvoiLaFrcnfiv+Dln4KKVBWDvY3cotKjS4bKndcAyz002sT7HkSx5eC38yMYnmL7to1NX2Og5Hum9sz6FP5/DjQIVqVQVFh+nAZkVaM8gCsX0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789895660; c=relaxed/simple;
	bh=v2rtAa7OnoLGt7yC9nrc7236Ndj29tw5GLmsPQj3eMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IUZPbebckRR65fBBObGToY++ctlQs8Flqonh6oALbvOqacf0KIl2Qcz0/NDRkmYtMZHlCwtxBgwNZ2zxtrgJP93388MM0q605wOGUVTAv+1pQHzxX13X3P9g6cdU0nxjBPPJyVwTpNW1qxpoyICykKgww0U/KORABxkbNvGYtXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZrVMLymB; arc=none smtp.client-ip=192.198.163.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZrVMLymB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789895658; x=1821431658;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v2rtAa7OnoLGt7yC9nrc7236Ndj29tw5GLmsPQj3eMw=;
  b=ZrVMLymBqNW/cmSjbwktNBVfNX4uoKf+n0VXRyUwYlJIchDGytfNVz2q
   5whzSTkn5cv0Tl85lbAez8T0t8EItaGV8ESQxE8IC4aiwxZVc+xzUdR+I
   Dw7t7LQgOV3eA0V8/zI2AovvvxiOl6BP/YCPBHdsaF6cHbPS9RbkA+hJZ
   O0Q/f2Atei4TOLpdVftrMZKwasIf5uANTZzWqGA+jkkyhFpcKUy3hzyAY
   u4oUhYjUa4E8Xut7Q5Je8pCi6qratWwPQpfLSepzWJT/KBBoRzgCKke3A
   BJlo2WQrKs9tTfYx20UPhuy1MH0keE8cuW0uX+cNVyWUbRdOevtG4siZW
   A==;
X-CSE-ConnectionGUID: DhAApulSR16Jzbx1BOvV+g==
X-CSE-MsgGUID: OFcv3jc9QFux9zDT4Cs9pQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11910"; a="905943"
X-IronPort-AV: E=Sophos;i="6.27,111,1787036400"; 
   d="scan'208";a="905943"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa115.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2026 02:14:18 -0700
X-CSE-ConnectionGUID: B+ViNU7pTSSOhzNDpcDBEw==
X-CSE-MsgGUID: hekfD3bbTq+2qIGMHzRWvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,111,1787036400"; 
   d="scan'208";a="271357721"
Received: from junjie-desk-dev.bj.intel.com ([10.238.152.71])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2026 02:14:12 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: Manish Honap <mhonap@nvidia.com>
Cc: alex@shazbot.org,
	ankita@nvidia.com,
	jic23@kernel.org,
	dave.jiang@intel.com,
	alejandro.lucero-palau@amd.com,
	smadhavan@nvidia.com,
	pierrick.bouvier@oss.qualcomm.com,
	mst@redhat.com,
	imammedo@redhat.com,
	anisinha@redhat.com,
	pbonzini@redhat.com,
	eric.auger@redhat.com,
	peter.maydell@linaro.org,
	richard.henderson@linaro.org,
	clg@redhat.com,
	cohuck@redhat.com,
	kjaju@nvidia.com,
	vsethi@nvidia.com,
	zhiw@nvidia.com,
	qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 07/10] hw/vfio/pci: Map the CXL memory on the guest decoder commit
Date: Sun, 20 Sep 2026 17:14:03 +0800
Message-ID: <20260920091403.716987-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260916184412.3825713-8-mhonap@nvidia.com>
References: <20260916184412.3825713-8-mhonap@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 17 Sep 2026 00:14:09 +0530, Manish Honap wrote:
> +     * Record the base the guest programs into a decoder so the commit handler
> +     * can reject a base other than the device's CFMWS window. The base low
[...]
> +        vdev->cxl.guest_base_lo = (uint32_t)data & VFIO_CXL_HDM_BASE_LOW_MASK;
> +        vdev->cxl.guest_base_written = true;

This answered my v1 question for the kernel v4 FSM model.  With v5
(20/27) the kernel gives a live read-only view and leaves any write
virtualization to the VMM, and what QEMU shows the guest is a
committed, locked decoder at the window base.  A locked decoder
ignores a base write, but here it is recorded, and if it differs from
the window base the next rescan unmaps while reads still return
Committed at the window base.  That is the mismatch the check was
meant to prevent.  A current Linux guest never writes a locked
decoder, so it won't trip this.

Is the guest-written base still meant to matter in this model?  If
not, guest_base_{lo,hi,written} can go.

> +     * The kernel runs the lock-on-commit FSM in the write above, so the
> +     * committed state is settled by now; a control write on any decoder can

Stale now that the kernel no longer acts on the write?

Junjie
