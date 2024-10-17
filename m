Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B3B190663;
	Thu, 17 Oct 2024 06:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729146768; cv=none; b=o04ntsd9lSsTDZV2PvEW1IMsKaLmtczjdjEZ2cWMcQroDUagVeTeeLFv9Hi+dz8fu1kTIrC+9JJIVeyh0mF9NGwJksGTHJPYCxJe0DEhlWjkHdLd9CmLwemSpuKoCmg1Q+j6ajAIQ6mluj/ixjVoGw5XHNPQSEPXrSuJ3F6n4aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729146768; c=relaxed/simple;
	bh=AU3canff2bgumgXQ4yKpv4UIhuEquhiwX0SDqsXzeC8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K0ZEQ40dLX4qKrqIAtoFI3z6Nq3yjh0S97WNNYlIrfZPPuDKKSawEWZY9kgir+cvc/63ejpAEpzS/U1QwfpJWphQBMRGHHpy2sgiWIdd0FI/9lKG48iehmP2FUiuF2E4p+PrkBLd6bSy5ITxrgOif/6OF5Hjx7UODeJLyXlBO3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MOP4ZkqG; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MOP4ZkqG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729146766; x=1760682766;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=AU3canff2bgumgXQ4yKpv4UIhuEquhiwX0SDqsXzeC8=;
  b=MOP4ZkqGpfUfytky0SophCYj9dxSHVdKyJhuGjT2HLUF2ND8HwSoVP74
   7rXfQT6qZFAT0FrUEYXcHJsc5IesIlC453Fz4DH0zCx6KczxVGjdoi9y5
   8DHnbKyBIlzTFhZ6rKANU+MPfv0/VNph6ixy+FSkb7Ekd/ncp/0GLqAU/
   UoBOlOjtBeTWIRBPbXSRIEnex5VUCaZCAcqRI94qlDS5TN2cM9mJFOxIO
   tXolDWzt9f71wZpG80Fdg6e7de7zaibSGMkZ4EeMdybPlGayN6Md4PUuV
   UzkDQsfPy8T225OduFQnS/p+ceofnnOhcm/ykiYjhprFOyUuFvgnvQNm/
   g==;
X-CSE-ConnectionGUID: AUv94k2eROW+4T0KfyI9Eg==
X-CSE-MsgGUID: ezJJSrHGQreVpYLbgcmN3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11227"; a="28709075"
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; 
   d="scan'208";a="28709075"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 23:32:44 -0700
X-CSE-ConnectionGUID: JsnFeipfSCic5h1rzlEEvQ==
X-CSE-MsgGUID: rD4x1GDtSfKARj7HBXz5Zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; 
   d="scan'208";a="83229180"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 23:32:41 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Alejandro Lucero Palau <alucerop@amd.com>
Cc: Dan Williams <dan.j.williams@intel.com>,  Dave Jiang
 <dave.jiang@intel.com>,  <linux-cxl@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  Gregory Price <gourry@gourry.net>,
  Davidlohr Bueso <dave@stgolabs.net>,  Jonathan Cameron
 <jonathan.cameron@huawei.com>,  Alison Schofield
 <alison.schofield@intel.com>,  Vishal Verma <vishal.l.verma@intel.com>,
  Ira Weiny <ira.weiny@intel.com>,  "Ben Cheatham"
 <benjamin.cheatham@amd.com>
Subject: Re: [PATCH 5/5] cxl: Avoid to create dax regions for type2
 accelerators
In-Reply-To: <d5233135-9d70-9080-c7eb-0906f07e5104@amd.com> (Alejandro Lucero
	Palau's message of "Tue, 15 Oct 2024 09:51:17 +0100")
References: <20241015065713.308671-1-ying.huang@intel.com>
	<20241015065713.308671-6-ying.huang@intel.com>
	<d5233135-9d70-9080-c7eb-0906f07e5104@amd.com>
Date: Thu, 17 Oct 2024 14:29:08 +0800
Message-ID: <87jze76y4r.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Hi, Alejandro,

Alejandro Lucero Palau <alucerop@amd.com> writes:

> I did comment on this some time ago and I'm doing it again.
>
>
> This is originally part of the type2 patchset, and I'm keeping it in
> V4. I do not understand why you pick code changes (you explicitly said
> that in the first RFC) from there and use it here, and without
> previous discussion about this necessity in the list. I do not think
> this is usual, at least in other kernel subsystems I'm more familiar
> with, so I will raise this in today's cxl open source collaboration
> sync.

No.  I picked this change from Dan's series as follows,

https://eclists.intel.com/sympa//arc/linux-bkc/2024-10/msg00018.html

So, I added co-developed-by and signed-off-by of Dan.

IIUC, your picked this change from Dan's series too?

Feel free to include this change in your series.  If your patchset is
merged firstly, I will rebase on yours and drop this change.

[snip]

--
Best Regards,
Huang, Ying
