Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA9519F127;
	Mon, 21 Apr 2025 21:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745270512; cv=none; b=H+YRLJHhou9nMJyxOXFKvptkty1h4vGFW8SiD2uFDbXVzn4xKfrSWm3HiQAC+orxwOb1rVWZokal8yc9SpnokrqbGGy2NDM6QooHdpeRJrA4If+8OkaWkaNXM87ZvAbEoYR8xolqx+P4dwn6J/ZefYorGWlJ6VQgdqUU+inxCkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745270512; c=relaxed/simple;
	bh=xO4hJqtW3nhfpJm4/YvtzVvkxDSKomYlRulbwgEvP3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nMWZ2ZT5tlBbaQSQ/f/lMJ35iZ50z7N7mDus5p7OwEIodgSDy6EX++YA6TynvmzTbMcnQK4PJHz9RhMWG1b1SyBe9LTdt+PU/AY9od6JRbx63QzJbnJpBbUsk0Or3jc27BDrgIJlulbJZNB9IF49a8UD0LzPI3MGfNwJIiG94V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YZLXA/ZN; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YZLXA/ZN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745270511; x=1776806511;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xO4hJqtW3nhfpJm4/YvtzVvkxDSKomYlRulbwgEvP3k=;
  b=YZLXA/ZNJKkbk0lETqJ+mO+87YhqbTtVKWsXpq4YiIFDI+wc/ZXfAFy1
   0wZ6b4BXBwOTba2Ulf40WJxpeMZveANyJ7exqDOb7n7O+UgtWi1G+l1sg
   ufLzS3jhyi7qPz9t1BINyGJrQ417MInHeWz9o35nrOvUf23LbfkAkugIs
   jtIRxBaT2fexjgaBt6wAhhlNedQNgE433yrujTk/V4q8yzG6Us2a5CtI9
   OSQ3F4b28dOIzCvpuPqwwJJjYKoaXs6bQXBXo0XB7EnAw87KaTz29nViY
   XqyXYAyDWZIXwu2neL8QzHQ/0yCcf6T/0hRmFhvELLWJ0w/spSHMEu5/9
   Q==;
X-CSE-ConnectionGUID: 5cjGkEZwQ7y8h4FePbJkzw==
X-CSE-MsgGUID: rtADCSKNQfaG73HX7lRyUQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11410"; a="50611611"
X-IronPort-AV: E=Sophos;i="6.15,229,1739865600"; 
   d="scan'208";a="50611611"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2025 14:21:50 -0700
X-CSE-ConnectionGUID: p7jXhTI1RmGsHe/jZMvrcA==
X-CSE-MsgGUID: AzhsdTJxQYqu6qLJL7ncyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,229,1739865600"; 
   d="scan'208";a="132780280"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.245.246.70])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2025 14:21:47 -0700
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
 Re: [PATCH v4 07/14] cxl/region: Move find_cxl_root() to cxl_add_to_region()
Date: Mon, 21 Apr 2025 23:21:44 +0200
Message-ID: <4624465.M3a2QDmDih@fdefranc-mobl3>
In-Reply-To: <20250306164448.3354845-8-rrichter@amd.com>
References:
 <20250306164448.3354845-1-rrichter@amd.com>
 <20250306164448.3354845-8-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Thursday, March 6, 2025 5:44:41=E2=80=AFPM Central European Summer Time =
Robert Richter wrote:
> When adding an endpoint to a region, the root port is determined
> first. Move this directly into cxl_add_to_region(). This is in
> preparation of the initialization of endpoints that iterates the port
> hierarchy from the endpoint up to the root port.
>=20
> As a side-effect the root argument is removed from the argument lists
> of cxl_add_to_region() and related functions. Now, the endpoint is the
> only parameter to add a region. This simplifies the function
> interface.
>=20
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Tested-by: Gregory Price <gourry@gourry.net>
> ---

Reviewed-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>



