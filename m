Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E941919258E;
	Mon, 15 Dec 2025 11:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765798085; cv=none; b=GnwmYRZ2BJ/dBRw2+13nJm7JcADLFQaOsZ4rlEfnw49+sZqTu9o8v8yIJ3YGp97GthTgqbXWh9dwNaroNVqzJ+LGOgftH4soE2fRNVS4+u2MJUXk+VgawqCUklh8i1emBE9d/7HSzwojR02cXwm0+n09gYR/OwqUKgcEMyUd12U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765798085; c=relaxed/simple;
	bh=nbUf8xDOnos5NcqpZpUZp9DSA4UWKx1n2yLfBpL9pr0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vh0OL5BWU/MEDlqbeV5FuDCVJmDLQw9Dj9+Mv+HdxZs4eSMMZWTjlIuRNn1awJc6u/TZJVxwYhPPZC9YVgW/eCaISCNIjKW+dn7YL85q1MNq/qnR1vvX7o1V/yPYMVmNwRqSt1I2rxaC+4pgjSXUYM5Pj2botDTogzVAEiKJNiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dVHpx57QQzHnH5p;
	Mon, 15 Dec 2025 19:27:37 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id D976540570;
	Mon, 15 Dec 2025 19:27:58 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 15 Dec
 2025 11:27:58 +0000
Date: Mon, 15 Dec 2025 11:27:56 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Robert Richter <rrichter@amd.com>
CC: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, Jonathan Corbet <corbet@lwn.net>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Randy Dunlap <rdunlap@infradead.org>,
	<linux-doc@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] Documentation/driver-api/cxl: ACPI PRM Address
 Translation Support and AMD Zen5 enablement
Message-ID: <20251215112756.000068cc@huawei.com>
In-Reply-To: <20251209181959.210533-2-rrichter@amd.com>
References: <20251209181959.210533-1-rrichter@amd.com>
	<20251209181959.210533-2-rrichter@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Tue, 9 Dec 2025 19:19:56 +0100
Robert Richter <rrichter@amd.com> wrote:

> This adds a convention document for the following patch series:
> 
>  cxl: ACPI PRM Address Translation Support and AMD Zen5 enablement
> 
> Version 7 and later:
> 
>  https://patchwork.kernel.org/project/cxl/cover/20251114213931.30754-1-rrichter@amd.com/

Can we make that a Link: tag as part of the main tag block? Perhaps
better to refer to lore.kernel.org rather than patchwork? 


> 
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Signed-off-by: Robert Richter <rrichter@amd.com>

A few minor things inline around constraining the explanation a little so
as not to imply more general CXL restrictions.

Thanks,

Jonathan


> ---
> v2:
>  * updated sob-chain,
>  * spell fix in patch description (Randy),
>  * made small changes as suggested by Randy,
>  * Removed include:: <isonum.txt> line (Jon).
> ---
> ---
>  Documentation/driver-api/cxl/conventions.rst  |   1 +
>  .../driver-api/cxl/conventions/cxl-atl.rst    | 174 ++++++++++++++++++
>  2 files changed, 175 insertions(+)
>  create mode 100644 Documentation/driver-api/cxl/conventions/cxl-atl.rst
> 
> diff --git a/Documentation/driver-api/cxl/conventions.rst b/Documentation/driver-api/cxl/conventions.rst
> index 53f31a229c8d..cf427afac58b 100644
> --- a/Documentation/driver-api/cxl/conventions.rst
> +++ b/Documentation/driver-api/cxl/conventions.rst
> @@ -8,4 +8,5 @@ Compute Express Link: Linux Conventions
>     :caption: Contents
>  
>     conventions/cxl-lmh.rst
> +   conventions/cxl-atl.rst
>     conventions/template.rst
> diff --git a/Documentation/driver-api/cxl/conventions/cxl-atl.rst b/Documentation/driver-api/cxl/conventions/cxl-atl.rst
> new file mode 100644
> index 000000000000..955263dcbb3a
> --- /dev/null
> +++ b/Documentation/driver-api/cxl/conventions/cxl-atl.rst
> @@ -0,0 +1,174 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +ACPI PRM CXL Address Translation
> +================================
> +
> +Document
> +--------
> +
> +CXL Revision 3.2, Version 1.0
> +
> +License
> +-------
> +
> +SPDX-License Identifier: CC-BY-4.0
> +
> +Creator/Contributors
> +--------------------
> +
> +- Robert Richter, AMD
> +
> +Summary of the Change
> +---------------------
> +
> +The CXL Fixed Memory Window Structure (CFMWS) describes zero or more
Structures describe (plural given zero or more)

Really trivial but why the short wrap?  Isn't it 80 chars for documentation?

> +Host Physical Address (HPA) windows that are associated with each CXL
> +Host Bridge. The HPA ranges of a CFMWS may include addresses that are

Hmm. This is a simplistic description of CFMWS given it's a many to many
relationship.  So in general would be something like

Host Physical Address (HPA) windows that are associated with a set of CXL
Host Bridges.

However, if this particular convention only applies to cases not interleaving
across multiple host bridges, perhaps state that at the top then this text
would be fine as it's a special case.

> +currently assigned to CXL.mem devices, or an OS may assign ranges from
> +an address window to a device.
