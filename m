Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C415289367;
	Wed, 23 Apr 2025 15:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745422369; cv=none; b=dpeKFrxHnaZsXXFD3B07cP7ELbOq14wMiGO0WkV4mB9ECdTnytPm87/6wxwJ4a5o7ip+BlOVwwIRBKrkqM62bRYzpFr8SBGuw5CBAxUNQvgvL8lln5RNduv6urOr6FPm2xcqBo41QVi3v7hMLyUyhTLf8JdK11oDqOr2rOB9hvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745422369; c=relaxed/simple;
	bh=2GHmm17IseTCHBmk68FkRNzafrsvvsR9qWtUqz4tmMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hfZCbopd1bKJx72X43bdi1m04/BTCiZJqHKyw9DpvY4PNea8q0clcGee71N1R6uClFKSGcnQkEcBXz8tqtLwA9s3ZOBf0Qpbg9XL+Ek6gH0P2+cGWzl2F0VVgQEjX1T6r5gHko2A16+SXXdi7CLiynAx2W/hMCihqnTyLBcP+4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CbVD+On4; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CbVD+On4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745422368; x=1776958368;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2GHmm17IseTCHBmk68FkRNzafrsvvsR9qWtUqz4tmMc=;
  b=CbVD+On4LZQ6Oqd12zhHl8poTHCQvEMmiPcZBj8pFjTS0xC4Etci4dHg
   dPPmSSRMf3oIcsLBUtlIVr+Ev3Q/O9/TXjSrGXweXIWF3OhvNDvCwOUXa
   8FccASo1x/buuADSeWGL6hrx6iLPEM65hjxiqyOQF6kpWhevcCbipGlSX
   9Q/imsGY/HAohTV06FGcSXu5A4QSmWezQ6H8QgLmF8eFI+fAp5sd3Rq+D
   /lyQwAM7mE33t1bNDaMUbQk+MyOuDeUz0u5ufXDAcH9i61SauBMpUn1Gv
   bp2nz0vo6TcU9nGFz5LvwtP1LyULhmumJkS8RE5ut+4eqheC5LpEf5zvl
   w==;
X-CSE-ConnectionGUID: WOSXzw99R3q/PFlfUhVBsQ==
X-CSE-MsgGUID: Qz4i85mJRCu0ToXcXPjASQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="46144884"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="46144884"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 08:32:47 -0700
X-CSE-ConnectionGUID: ItjRgvcvQVqdnX+kW4EfkQ==
X-CSE-MsgGUID: EUyrFs4kRI6fgCcWYOeEqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="132651941"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.245.246.196])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 08:32:43 -0700
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
 Re: [PATCH v4 09/14] cxl/region: Factor out code to find a root decoder's
 region
Date: Wed, 23 Apr 2025 17:32:40 +0200
Message-ID: <3120993.CnGb9OGePT@fdefranc-mobl3>
In-Reply-To: <20250306164448.3354845-10-rrichter@amd.com>
References:
 <20250306164448.3354845-1-rrichter@amd.com>
 <20250306164448.3354845-10-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Thursday, March 6, 2025 5:44:43=E2=80=AFPM Central European Summer Time =
Robert Richter wrote:
> In function cxl_add_to_region() there is code to determine a root
> decoder's region. Factor that code out. This is in preparation to
> further rework and simplify function cxl_add_to_region().
>=20
> No functional changes.
>=20
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Tested-by: Gregory Price <gourry@gourry.net>

Reviewed-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>



