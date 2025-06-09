Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC17E2561AE
	for <linux-cxl@vger.kernel.org>; Mon,  9 Jun 2025 10:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749466524; cv=none; b=Wik3qE6R09UfSDS0l9s9VZBBJYnZ39xmd55vU0oDNhxwOCEqla/RmBYUft2Y6QHIyGzLoJ2/k+55rkTCPnW8nYSDtSrqABLaKlxsR++xys9T21yJ+6sdh32a9MjMry6emqHSAbcvAs/x2jBYl+IvmA0b+PdO7uI3PNdn8vveBkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749466524; c=relaxed/simple;
	bh=qpYsbWnkCfmrMxo41kVD1aM2hwIb+HBRlqr2c6GdwZk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qpr2f2W/i/skOI2mt/uu2bWgavrpd954hg+qVP8WiqjO4maO7RY2BkB+fPKhVA8fy5S/LsolpGNgQFY1pXL6Xz2HxqLliqovFvxJT4Ebbizy4i7L7ZKWs0N/gmfO0Gy2WqSfD74GjoE8lJfnj/0t24ojAmB9Zrrx+e7qZ0ceZMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bG82V0VDwz6M4q3;
	Mon,  9 Jun 2025 18:54:58 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 46CCF1404D8;
	Mon,  9 Jun 2025 18:55:19 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 9 Jun
 2025 12:55:18 +0200
Date: Mon, 9 Jun 2025 11:55:17 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave.jiang@intel.com>,
	<fabio.m.de.francesco@linux.intel.com>, <rrichter@amd.com>
Subject: Re: [PATCH] Documentation/driver-api/cxl: Introduce conventions.rst
Message-ID: <20250609115517.00000ad4@huawei.com>
In-Reply-To: <20250603185254.3730099-1-dan.j.williams@intel.com>
References: <20250603185254.3730099-1-dan.j.williams@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 3 Jun 2025 11:52:54 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> There exists shipping platforms that bend, break, or otherwise lean on
> ambiguities in the CXL specification. Without driver changes to accommodate
> these deviations, end users are left without CXL subsystem RAS features.
> Specifically, provisioning, error translation, and other flows require the
> CXL subsystem to understand the platforms CXL topology beyond undecorated
> memory address ranges.
> 
> Those isolated compatibility problems risk growing into deeper upstream
> maintenance burden if different platform vendors arrive at diverging
> solutions. For example, there are multiple options for resolving
> low-memory-mmio intersecting large-interleave-ways CXL windows. Linux
> should only entertain one solution to that problem.
> 
> Now, with the ACPI Specification Working Group, situations like this would
> be resolved with the "Code First ECN" process to codify Linux expectations
> in a specification. In the absence of such a process for the CXL
> specification, create a file in Linux documentation to detail the
> motivations, assumptions, tradeoffs, and proposals for amending
> specification language.
> 
> The goal is to capture the issues such that platform vendors arrive at
> compatible solutions for these problems and serve as a repository for
> potential specification updates. The expectation is to update
> conventions.rst along with CXL subsystem code changes to accommodate the
> platform topology.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Seems like a good way to get things going.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
