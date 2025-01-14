Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6159F232428;
	Tue, 14 Jan 2025 20:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736887541; cv=none; b=Vr+S+OJqaIVbrEpheZ4IAi4cu2YaJGTUDSStdUWNckhyzpTJoPyzdaQTCc0ejAhAXhWu/yCm5esiePzJ6Ax/VP29sQ75PHE6+uvRkFVnJwP9NZWe8KU20tcs0EFnNxco056YkfxRkiIhLgdudLXTga7a/iwjc/fJ7xOzeBS+vm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736887541; c=relaxed/simple;
	bh=+WD3mM6ruMgKXcwFnlw0JTBj1qracjD6ERgGf2kNQqU=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=u1Cf0Ve/zNuHoxaArgq/8JBHUjcjLqvjBxDMRpmPWmE7TB2MIYyM+rVsnUyFEV9JExprZGuwxy5Q56xw8atrG/xo2watzPssV68hf1tM0hRm1nwoYeoGPq4Sjvs2WQRhh/ekkTJ72c4jA9ho0pFalSBmnLPyiS6efN7MxV0ouKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UJeSN67U; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UJeSN67U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736887539; x=1768423539;
  h=message-id:subject:from:to:cc:in-reply-to:references:
   content-transfer-encoding:date:mime-version;
  bh=+WD3mM6ruMgKXcwFnlw0JTBj1qracjD6ERgGf2kNQqU=;
  b=UJeSN67USZYQwoZ9QeeY56Q4q/Q49H+luioYrBPkpKwWvy06yAunAJsG
   h/z/ia31rhMbO17X0Yc5wp/JKa3vMfnLauctvY3bKprgAD1i54pv4OArg
   YhMgatlOrXzZKz9ch1xeVCsGJS0UrrXftuXs0ojTCEPBF1+8sAj65IFwp
   U5Apo2INVmOYVdTCF6yP9uLR9jDYQUudESCk+ffnNw3gexkjbgCOPAbTZ
   AnF7AXOOnrALvOBN3aWLKx0fN9Ta9uZBkx+V9qCHlDXBHu7fjZxg1ENpl
   8RMtK3Jf9ORjQjI4HvYisPh8I8MvlceI0jY+MKVovF/Asu0FYWhSH3FJP
   w==;
X-CSE-ConnectionGUID: x6x76J0PRjOmqr+E52IcZQ==
X-CSE-MsgGUID: Ajli3ifMSRaojzpp4gM8AQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="54622522"
X-IronPort-AV: E=Sophos;i="6.12,315,1728975600"; 
   d="scan'208";a="54622522"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 12:45:39 -0800
X-CSE-ConnectionGUID: QL1CL+qbTLuD9loHXod2hw==
X-CSE-MsgGUID: 8aRTnLjVQnC89HAR/52jMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,315,1728975600"; 
   d="scan'208";a="104761679"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO [10.245.244.88]) ([10.245.244.88])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 12:45:34 -0800
Message-ID: <06a3a2f18b276ee1a0d7e4c11388b6b2d265ae00.camel@linux.intel.com>
Subject: Re: [PATCH 0/4] cxl/core: Enable Region creation on x86 with Low
 Mem Hole
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
 <jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, Alison
 Schofield <alison.schofield@intel.com>, Vishal Verma
 <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
 <dan.j.williams@intel.com>
Cc: Robert Richter <rrichter@amd.com>, ming.li@zohomail.com, 
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20250114203136.31704-1-fabio.m.de.francesco@linux.intel.com>
References: <20250114203136.31704-1-fabio.m.de.francesco@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jan 2025 21:45:32 +0100
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 

-----Original Message-----
From: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, Alison
Schofield <alison.schofield@intel.com>, Vishal Verma
<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
<dan.j.williams@intel.com>
Cc: Robert Richter <rrichter@amd.com>, ming.li@zohomail.com,
linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org, Fabio M. De France=
sco
<fabio.m.de.francesco@linux.intel.com>
Subject: [PATCH 0/4] cxl/core: Enable Region creation on x86 with Low Mem H=
ole
Date: 01/14/2025 09:31:00 PM

This series is missing the v2 tag. Please ignore it.V2 is at https://lore.k=
ernel.org/all/20250114203432.31861-1-
fabio.m.de.francesco@linux.intel.com/

Fabio

