Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDDD3218B
	for <linux-cxl@vger.kernel.org>; Fri, 12 Apr 2024 07:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712907675; cv=none; b=WGTMWnDTNmOmvdLg2ci8EXzyKLFfn2shBpi/NU+jou4QbLzRI/DJnvSFKuL/2grmEiMgzv65maa8S2yx9AcpDoqpRX3qIA+s+oEmvS5C7WOeV0mIGXMm2h1sldv5wmBbCO00SBCzGu/5Ur036HQf2r6dvc0w7mYa+W9U5EUVH80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712907675; c=relaxed/simple;
	bh=fkT160FcodsgHreutSD9b+4ZNNdZN9OPIOXEmSJsNE0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jr4TcuYkzTGwZbd/hxFLtj8c0l6t4xPO1NqTSRvrfiV4VQXab3zsPdnX8ptMcQzgo7nJmVdy4oc5DBZLmW+Zz2BEV9C7ytjMNZFmmJwmhb3k/tlrjnC+XbPeXbFxAZrQ4T/ecDcZhUjdBcXSiu0BxELw0oFgXUmB99sqOB9r/oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=COihdozx; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="COihdozx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712907674; x=1744443674;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=fkT160FcodsgHreutSD9b+4ZNNdZN9OPIOXEmSJsNE0=;
  b=COihdozxs/aFfrS2mdey9WQKDUzRQqUmGcNvcrNpXedPe57dcViRFhQp
   mwJrh0nx3Mf2MnqKK7nZH0B3kT93SxuiRlAMvCOcT/56Fi5E3/pKGWVUv
   KL2+CTi+igT9G/CNaoYM2s4HS9uYh2VfE618GeQF9v4Pub71UAUTR4Qko
   5C1dhiLVcT7/oXO5VuVExCWSXvn1L1Fty9f63Bx0L06py284/wYCWOPcs
   pgx3EKP0ljM/dZfdckj5rzOWE/+/+VdTV7nC5a0wAwAFReo0Pnhamr+Ra
   rNmk0gV7cg5W/h+6aB+bNxfnzMiiSf5rbzTn4IyP/2j2aAS4Ftogx2+9Q
   A==;
X-CSE-ConnectionGUID: NbNiAQAbQ/CzfXYjh6bTDQ==
X-CSE-MsgGUID: 5EKb3cjgRMW+CrOBkDHTLA==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="19505244"
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="19505244"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 00:41:13 -0700
X-CSE-ConnectionGUID: XHVRESQPQEikUULHY6yOmQ==
X-CSE-MsgGUID: pO6oeWWtTR+iT2W0x4aLFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="25825579"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 00:41:08 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: <ankita@nvidia.com>,  <marcel.apfelbaum@gmail.com>,
  <philmd@linaro.org>,  <mst@redhat.com>,  <qemu-devel@nongnu.org>,  Dave
 Jiang <dave.jiang@intel.com>,  Paolo Bonzini <pbonzini@redhat.com>,
  <eduardo@habkost.net>,  <imammedo@redhat.com>,
  <linux-cxl@vger.kernel.org>,  <linuxarm@huawei.com>,  Markus Armbruster
 <armbru@redhat.com>,  Michael Roth <michael.roth@amd.com>,  Ani Sinha
 <anisinha@redhat.com>
Subject: Re: [PATCH 0/6 qemu] acpi: NUMA nodes for CXL HB as GP + complex
 NUMA test.
In-Reply-To: <20240403102927.31263-1-Jonathan.Cameron@huawei.com> (Jonathan
	Cameron's message of "Wed, 3 Apr 2024 11:29:21 +0100")
References: <20240403102927.31263-1-Jonathan.Cameron@huawei.com>
Date: Fri, 12 Apr 2024 15:39:16 +0800
Message-ID: <878r1j58t7.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Hi, Jonathan,

Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:

> ACPI 6.5 introduced Generic Port Affinity Structures to close a system
> description gap that was a problem for CXL memory systems.
> It defines an new SRAT Affinity structure (and hence allows creation of an
> ACPI Proximity Node which can only be defined via an SRAT structure)
> for the boundary between a discoverable fabric and a non discoverable
> system interconnects etc.
>
> The HMAT data on latency and bandwidth is combined with discoverable
> information from the CXL bus (link speeds, lane counts) and CXL devices
> (switch port to port characteristics and USP to memory, via CDAT tables
> read from the device).  QEMU has supported the rest of the elements
> of this chain for a while but now the kernel has caught up and we need
> the missing element of Generic Ports (this code has been used extensively
> in testing and debugging that kernel support, some resulting fixes
> currently under review).
>
> Generic Port Affinity Structures are very similar to the recently
> added Generic Initiator Affinity Structures (GI) so this series
> factors out and reuses much of that infrastructure for reuse
> There are subtle differences (beyond the obvious structure ID change).
>
> - The ACPI spec example (and linux kernel support) has a Generic
>   Port not as associated with the CXL root port, but rather with
>   the CXL Host bridge. As a result, an ACPI handle is used (rather
>   than the PCI SBDF option for GIs). In QEMU the easiest way
>   to get to this is to target the root bridge PCI Bus, and
>   conveniently the root bridge bus number is used for the UID allowing
>   us to construct an appropriate entry.
>
> A key addition of this series is a complex NUMA topology example that
> stretches the QEMU emulation code for GI, GP and nodes with just
> CPUS, just memory, just hot pluggable memory, mixture of memory and CPUs.
>
> A similar test showed up a few NUMA related bugs with fixes applied for
> 9.0 (note that one of these needs linux booted to identify that it
> rejects the HMAT table and this test is a regression test for the
> table generation only).
>
> https://lore.kernel.org/qemu-devel/2eb6672cfdaea7dacd8e9bb0523887f13b9f85ce.1710282274.git.mst@redhat.com/
> https://lore.kernel.org/qemu-devel/74e2845c5f95b0c139c79233ddb65bb17f2dd679.1710282274.git.mst@redhat.com/
>

Thanks a lot for your work!

I need this to test some memory tiering kernel patches.  I found the
following git branch,

https://gitlab.com/jic23/qemu/-/commits/cxl-2024-03-05/?ref_type=heads

Can I use that branch directly?

And, can you share an example qemu command line to setup Genport, CDAT,
and HMAT?

--
Best Regards,
Huang, Ying
