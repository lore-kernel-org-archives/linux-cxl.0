Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44618269AFA;
	Wed, 23 Apr 2025 20:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745441467; cv=none; b=bInfIGZykIBCBrO9Mb+onZuhe/bJLqEORCXnEJvPNMaaSYVhDOSFk+Rh+e7UjyAKYpcumfX0zRhoCoze6bbiHb5Lz0C7bNwVlc0fQsjAd9yWEj8kL0GIVLG/3r3vptnJ40aE9yxcQ6dZ8fKPGryVCYEnhbOfeYgQS3F7kv99TwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745441467; c=relaxed/simple;
	bh=VHbbMJuX7r40zHS6tBiWqdLTzFu3joUoRD0NBWIpb7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DtkojRfSW/1lp3OT5YJ0r/M3Xv3hUO9LJEUExLiDh9aUvHX96w806knYiGir83wV5Om3GMZbqVJKVB9BKjZC2H7302/VYygU+txcuk1RQVVid63SrpG3ToqWxyyMbmIHKsIF38pngKMdA8OQBuxXDMvnPklWfiPGq7l5bpAZfoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Umtv4eSG; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Umtv4eSG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745441465; x=1776977465;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VHbbMJuX7r40zHS6tBiWqdLTzFu3joUoRD0NBWIpb7M=;
  b=Umtv4eSGxW82MIwtqOsnVcDznZHaOwthuEvdB3SH6F7TCNXLYewpNhgz
   eyG5ukF5i0FDgwT4QyJaoLcb8H//KOihlZv1hh5R8YiPkHa+zWYRagZkc
   EVii2f3xahfzYGvUYLLAnKQPsZy4SDlnlmc5mz/kQCyquvgmpq9yaLXBK
   EaVoE67LlNIcGNDe4Kzp4t7ad6R0g0VCjPi2mIRA8ej3Cy31OUdg9ZlTo
   CalpLjA9U8pMVYkitT66s2vu2bWLsqzObsucJ6wDWAsXBeIO9dmyE2/W5
   ZdXrsPGVAadxNH8hEjKZ+MrFdyeUoVcSqPb/ha0MjAKfZnPIBkhd6PMrb
   w==;
X-CSE-ConnectionGUID: RWaBJpimQV+g73DwNPKr5g==
X-CSE-MsgGUID: Ot5S2w15SAiCe81eqM43ng==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="58425542"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="58425542"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 13:51:04 -0700
X-CSE-ConnectionGUID: RneCpuWfQa6UZI6oCOn4Nw==
X-CSE-MsgGUID: cYVhTSwBSCKy2d6MtIyFBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="132261423"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.245.246.208])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 13:51:01 -0700
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Robert Richter <rrichter@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gregory Price <gourry@gourry.net>, Terry Bowman <terry.bowman@amd.com>,
 Robert Richter <rrichter@amd.com>
Subject:
 Re: [PATCH v4 12/14] cxl/region: Add a dev_err() on missing target list
 entries
Date: Wed, 23 Apr 2025 22:50:57 +0200
Message-ID: <39842992.VHbPRQshPE@fdefranc-mobl3>
In-Reply-To: <20250306164448.3354845-13-rrichter@amd.com>
References:
 <20250306164448.3354845-1-rrichter@amd.com>
 <20250306164448.3354845-13-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Thursday, March 6, 2025 5:44:46=E2=80=AFPM Central European Summer Time =
Robert Richter wrote:
> Broken target lists are hard to discover as the driver fails at a
> later initialization stage. Add an error message for this.
>=20
> Example log messages:
>=20
>   cxl_mem mem1: failed to find endpoint6:0000:e0:01.3 in target list of d=
ecoder1.1
>   cxl_port endpoint6: failed to register decoder6.0: -6
>   cxl_port endpoint6: probe: 0
>=20
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Tested-by: Gregory Price <gourry@gourry.net>
> ---

Reviewed-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>



