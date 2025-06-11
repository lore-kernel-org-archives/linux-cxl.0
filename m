Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7C21E485;
	Wed, 11 Jun 2025 13:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749648550; cv=none; b=tPOeqqVvQ1NaYNdEVXX0DMqaEnRQRWeKIaG8mvnZYmw6zTO5R+HHg1Udn0w+eovL/QJTwGPupzcgbhOD+0tkZlZhIirs62OPTU/NLpB8nHcHz6OAVW4h7eOwyJZaTKPhHbmNrNgK2LW8DNy9TC+1lHpfVjU2UC6BoQwiSAWfW+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749648550; c=relaxed/simple;
	bh=MzKTTjwQLF+OacywlNa7xEiLACFrII4fS3xBw3RL6jw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=COnfj6BPCbAG6RMjp9UtskHVIoXlLLwQZ85LzEitg5obMn43l05rO8zpUkC38en1lgL0oPpuPpsPb8MkmE4E6Bx47TaTgxvODCWM+rhzUw/xi4isAWVmw7v7Tv5UUXVOs00K+6W1eLYq0phDJpHaaLSZVVFeimC0rZG/QTQjtcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bHRKF4t9hz6J9dh;
	Wed, 11 Jun 2025 21:27:13 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 577491402EC;
	Wed, 11 Jun 2025 21:29:06 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 11 Jun
 2025 15:29:05 +0200
Date: Wed, 11 Jun 2025 14:29:04 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Nai-Chen Cheng <bleach1827@gmail.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Corbet <corbet@lwn.net>,
	<linux-cxl@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel-mentees@lists.linux.dev>, Shuah Khan
	<skhan@linuxfoundation.org>
Subject: Re: [PATCH] Documentation: fix typo in CXL driver documentation
Message-ID: <20250611142904.00007a48@huawei.com>
In-Reply-To: <20250610173152.33566-1-bleach1827@gmail.com>
References: <20250610173152.33566-1-bleach1827@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 11 Jun 2025 01:31:52 +0800
Nai-Chen Cheng <bleach1827@gmail.com> wrote:

> Fix typo 'enumates' to 'enumerate' in CXL driver operation
> documentation to improve readability.
> 
> Signed-off-by: Nai-Chen Cheng <bleach1827@gmail.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
>  Documentation/driver-api/cxl/linux/cxl-driver.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/driver-api/cxl/linux/cxl-driver.rst b/Documentation/driver-api/cxl/linux/cxl-driver.rst
> index 9759e90c3cf1..dd6dd17dc536 100644
> --- a/Documentation/driver-api/cxl/linux/cxl-driver.rst
> +++ b/Documentation/driver-api/cxl/linux/cxl-driver.rst
> @@ -20,7 +20,7 @@ The CXL driver is split into a number of drivers.
>  * cxl_port  - initializes root and provides port enumeration interface.
>  * cxl_acpi  - initializes root decoders and interacts with ACPI data.
>  * cxl_p/mem - initializes memory devices
> -* cxl_pci   - uses cxl_port to enumates the actual fabric hierarchy.
> +* cxl_pci   - uses cxl_port to enumerate the actual fabric hierarchy.
>  
>  Driver Devices
>  ==============

