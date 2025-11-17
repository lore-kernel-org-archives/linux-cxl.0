Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59EA29BDA3
	for <linux-cxl@vger.kernel.org>; Mon, 17 Nov 2025 15:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763395022; cv=none; b=X9mQ1D8zEMxX5xWh8wgAXaoH2Ninx49lwH+dInPBF+U1OwAPyX4RI7JXGAl1+d9LIS9/pEpnrO1iRqjt8txsofmSisftcrsoB0xSY8bj7Xuh3rR3hGIWN3N/jIYpzF86cTR+j5XemvAeoCOa/YZoa5oYF1/OCR2oxhMF0bTIIEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763395022; c=relaxed/simple;
	bh=kG9ahOgVW8HrfEpPUPfLyzL6YCJ2nhs2NOGTwpK1S/U=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LA41pDlsSY4cV5JFBm5DkdpGLOAZrEI1Ipm4cwrLxLXsjJWd+WAJ9/isjGAJz1e2fYGcP/i/ZaIEZhctFlFGy0LagXQG19ThmoDaYHuwe9vFWm3OhnE37m0+cB08ayfyvh6UPXH4qkHhBn/naHn0zc/T2W3T6A98OOCxaEGVQkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d9C650cZjzHnH4s;
	Mon, 17 Nov 2025 23:56:29 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 3692514011A;
	Mon, 17 Nov 2025 23:56:58 +0800 (CST)
Received: from localhost (10.126.172.135) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 17 Nov
 2025 15:56:57 +0000
Date: Mon, 17 Nov 2025 15:56:56 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 01/17] cxl/port: Arrange for always synchronous endpoint
 attach
Message-ID: <20251117155656.000071cb@huawei.com>
In-Reply-To: <20251111214032.8188-2-Benjamin.Cheatham@amd.com>
References: <20251111214032.8188-1-Benjamin.Cheatham@amd.com>
	<20251111214032.8188-2-Benjamin.Cheatham@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Tue, 11 Nov 2025 15:40:16 -0600
Ben Cheatham <Benjamin.Cheatham@amd.com> wrote:

> From: Dan Williams <dan.j.williams@intel.com>
> 
> Make it so that upon return from devm_cxl_add_endpoint() that cxl_mem_probe() can
> assume that the endpoint has had a chance to complete cxl_port_probe().
> I.e. cxl_port module loading has completed prior to device registration.
> 
> MODULE_SOFTDEP() is not sufficient for this purpose, but a hard link-time
> dependency is reliable.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
> 
> This patch is just for context, I'm aware that Smita is picking this up
> in her soft reserve set.
Even so, add your SoB if posting work of others to the list.

