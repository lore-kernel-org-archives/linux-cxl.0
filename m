Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B51197501
	for <linux-cxl@vger.kernel.org>; Thu,  6 Jun 2024 14:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717684819; cv=none; b=g+63yIVKfiWqHCS3kjtkRurV2kyYIq7sV4Y7gzGjYpgxZbwL3X13zxdLrzUBlHZ+OT1+mWfh4W099uXp2B1UPlR94AGsx5HqlHDjCoc9X0SXaLZJ85YJt7YQLHHEy3itWd56143nqpvU5N2ArfcScovSpFKChsFfhMYQIzWjjRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717684819; c=relaxed/simple;
	bh=aKT71ot+afh4AG64oRlELAfBRlC8gw/EGz5nP45IZNE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ApnbtX9AVShOub7VauraBRfX9ypawgb5OaIIwBw97nZkjdyOYBBM2x62Jclwiazc6Ik2UpbtkEW/QG+PU4BoxcmZCmKvzzX9qwLG/cLGnRIRKeH8oy03y9ldQPMDZhP8yiIfvhVbOrZjXgAWn9T/AywbB8hO61rMPjJpwqcO4Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Vw6Lt2cgJz6K6hm;
	Thu,  6 Jun 2024 22:35:34 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id C304E140CB1;
	Thu,  6 Jun 2024 22:40:13 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 6 Jun
 2024 15:40:02 +0100
Date: Thu, 6 Jun 2024 15:40:01 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave.jiang@intel.com>, Adam Manzanares
	<a.manzanares@samsung.com>
Subject: Re: [PATCH] Documentation: CXL Maturity Map
Message-ID: <20240606154001.00000507@Huawei.com>
In-Reply-To: <171659842954.843002.8140957498380360424.stgit@dwillia2-xfh.jf.intel.com>
References: <171659842954.843002.8140957498380360424.stgit@dwillia2-xfh.jf.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 24 May 2024 17:53:49 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Provide a survey of the work-in-progress maturity (implementation
> status) of various aspects of the CXL subsystem.
> 
> Clarify that in addition to ongoing upkeep relative to specification
> updates, there are some long running themes in the driver that respond
> to the discovery of new corner cases (bugs) and new use cases (feature
> extensions).
> 
> The primary audience is distribution maintainers, but it also serves as
> a guide for kernel developers to understand what aspects of the CXL
> subsystem need more help. It is a landing page to document ongoing
> progress, and a guide to discern exposure to work-in-progress features.
> 
> Help wanted / welcome to expand on the "Details" section.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
This feels like a really bit opportunity for bikeshedding..

Ah well, a few comments inline. I've tried restrain my natural tendency
to argue about number assignments.

Adam's email address was garbled in my email client - fixed up.

> ---
>  Documentation/driver-api/cxl/index.rst        |    2 
>  Documentation/driver-api/cxl/maturity-map.rst |  173 +++++++++++++++++++++++++
>  MAINTAINERS                                   |    1 
>  3 files changed, 176 insertions(+)
>  create mode 100644 Documentation/driver-api/cxl/maturity-map.rst
> 
> diff --git a/Documentation/driver-api/cxl/index.rst b/Documentation/driver-api/cxl/index.rst
> index 036e49553542..12b82725d322 100644
> --- a/Documentation/driver-api/cxl/index.rst
> +++ b/Documentation/driver-api/cxl/index.rst
> @@ -9,4 +9,6 @@ Compute Express Link
>  
>     memory-devices
>  
> +   maturity-map
> +
>  .. only::  subproject and html
> diff --git a/Documentation/driver-api/cxl/maturity-map.rst b/Documentation/driver-api/cxl/maturity-map.rst
> new file mode 100644
> index 000000000000..9c5bff6484dd
> --- /dev/null
> +++ b/Documentation/driver-api/cxl/maturity-map.rst
> @@ -0,0 +1,173 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +.. include:: <isonum.txt>
> +
> +===========================================
> +Compute Express Link Subsystem Maturity Map
> +===========================================
> +
> +The Linux CXL subsystem tracks the dynamic `CXL specification
> +<https://computeexpresslink.org/cxl-specification-landing-page>`_ that
> +continues to respond to new use cases with new features, capability
> +updates and fixes. At any given point some aspects of the subsystem are
> +more mature than others. While the periodic pull requests summarize the
> +`work being incorporated each merge window
> +<https://lore.kernel.org/linux-cxl/?q=s%3APULL+s%3ACXL+tc%3Atorvalds+NOT+s%3ARe>`_,
> +those do not always convey progress relative to a starting point and a
> +future end goal.
> +
> +What follows is a coarse breakdown of the subsystem's major
> +responsibilities along with a maturity score. The expectation is that
> +the change-history of this document provides an overview summary of the
> +subsystem maturation over time.
> +
> +The maturity scores are:
> +
> +- [3] Mature: Work in this area is complete and no changes on the horizon.
> +  Note that this score can regress from one kernel release to the next
> +  based on new test results or end user reports.
> +
> +- [2] Stabilizing: Major functionality operational, common cases are
> +  mature, but known corner cases are still a work in progress.
> +
> +- [1] Initial: Capability that has exited the Proof of Concept phase, but
> +  may still have significant gaps to close and fixes to apply as real
> +  world testing occurs.
> +
> +- [0] Known gap: Feature is on a medium to long term horizon to
> +  implement.  If the specification has a feature that does even have a '0'
> +  score in this document, there is a good chance that no one in the
> +  linux-cxl@vger.kernel.org community has started to look at it.
> +
> +- X: Out of scope for kernel enabling, or kernel enabling not required
> +
> +Feature and Capabilities
> +========================
> +
> +Enumeration / Provisioning
> +--------------------------
> +All of the fundamental enumeration an object model of the subsystem is
> +in place, but there are several corner cases that are pending closure.
> +

Feels like we should in passing mention that we support none of the
bits of CXL fabrics that are host visible (so mainly G-FAM I think).

[0] Fabrics / G-FAM (chapter 7)
[0] Global Access Enpoint

> +
> +* [2] CXL Window Enumeration
> +
> +  * [0] :ref:`Extended-linear memory-side cache <extended-linear>`
> +  * [0] Low Memory-hole
> +  * [0] Hetero-interleave
> +
> +* [2] Switch Enumeration
> +
> +  * [0] CXL register enumeration link-up dependency
> +
> +* [2] HDM Decoder Configuration
> +
> +  * [0] Decoder target and granularity constraints

Feels like you added this one just so we can tick it off ;)

> +
> +2 Performance enumeration
> +
> +  * [3] Endpoint CDAT
> +  * [3] Switch CDAT
> +  * [1] CDAT to Core-mm integration

[1] x86
[0] Arm64
[0] All other arch.

I guess could argue that's a core-mm problem, but the CEDT code
just all functions that are only implemented on x86.

> +  * [1] Shared link

[0] Shared link. We've not merged that one yet though getting closer.

> +
> +* [2] Hotplug
> +  (see CXL Window Enumeration)
> +
> +  * [0] Handle Soft Reserved conflicts
> +
> +* [0] :ref:`RCH link status <rch-link-status>`
> +
> +RAS
> +---
> +In many ways CXL can be seen as a standardization of what would normally
> +be handled by custom EDAC drivers. The open development here is
> +mainly caused by the enumeration corner cases above.
> +
> +* [3] Component events (OS)
> +* [2] Component events (FFM)
> +* [1] Endpoint protocol errors (OS)
> +* [1] Endpoint protocol errors (FFM)
> +* [0] Switch protocol errors (OS)
> +* [1] Switch protocol errors (FFM)
> +* [2] DPA->HPA Address translation
> +
> +    * [1] XOR Interleave translation
> +      (see CXL Window Enumeration)
> +
> +* [1] Memory Failure coordination
> +* [0] Scrub control

[0] PPR
[0] Sparing 
[0] Device built in test

> +* [2] ACPI error injection EINJ
> +
> +  * [0] EINJ v2
> +  * [X] Compliance DOE
> +
> +* [2] Native error injection
> +* [3] RCH error handling
> +* [1] VH error handling
> +
> +Mailbox commands
> +----------------
> +
> +* [3] Firmware update
> +* [3] Health / Alerts
> +* [1] :ref:`Background commands <background-commands>`
> +* [3] Santization
> +* [3] Security commands
> +* [3] RAW Command Debug Passthrough
> +* [0] CEL-only-validtion Passthrough
> +* [0] Switch CCI
> +* [3] Timestamp
> +* [1] PMU

Not mailbox, plus breakdown into switch vs type3 - see below.

> +* [1] PMEM labels
> +* [0] PMEM GPF / Dirty Shutdown
> +

PMU
---

[1] Type 3 PMU
[0] Switch USP/ DSP, Root Port

> +Security
> +--------
> +
> +* [X] CXL Trusted Execution Environment Security Protocol (TSP)
> +* [X] CXL IDE (subsumed by TSP)
> +
> +Multi-host memory
> +-----------------
> +
> +* [0] Dynamic Capacity Device Support
> +* [0] Sharing

Break this one up

Memory-pooling
--------------

[1] Hotplug of LDs (via PCI hotplug)
[0] Dynamic Capacity Device (DCD) Support

Multi-host sharing
------------------

Requires DCD support.
[0] Hardware coherent shared memory
[0] Software managed coherency shared memory

> +
> +Accelerator
> +-----------
> +
> +* [0] Accelerator memory enumeration HDM-D (CXL 1.1/2.0 Type-2)
> +* [0] Accelerator memory enumeration HDM-DB (CXL 3.0 Type-2)
> +* [0] CXL.cache 68b (CXL 2.0)
> +* [0] CXL.cache 256b Cache IDs (CXL 3.0)
> +
> +User Flow Support
> +-----------------
> +
> +* [0] HPA->DPA Address translation (need xormaps export solution)


