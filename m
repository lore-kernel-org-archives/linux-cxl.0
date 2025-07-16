Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACF42C158E
	for <linux-cxl@vger.kernel.org>; Wed, 16 Jul 2025 12:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752670422; cv=none; b=sShBEuKgF8cZpMjdDWUx1zUpGzdfgtTDdwtjhsfJw9rlb+bC6cqL8MFwvjtn/7byF6LIYFNW7N4aiTbnBWrGQkE3MtWiSSZYmLhNoWVFrnC2CJTRjB0wlsPCg4B5L1wWg4jQY+F8+SpAdG1LlGs9bhcHF9emLKSIQ+cfhMybxIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752670422; c=relaxed/simple;
	bh=6C74I9mLxmJ1NWQbKnlVhtXI69JJYlngeDx5unr9ziY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ivj54Pc2Ol14fj+5E4s1lIuYKNjEmi03goA3JGDEWZzYCF/3ZF0lS+hTGMFOD99cHLx8GJodZtW9dSPFClD3wwkEQbwmDUt8TFBkPMo6R5PUpH4k96x7AYYmHWQsgjy4Du9T+87gTkxljDYCBii/sa44yXAeWiHTN9bKWwTraOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bhwtw5Dkcz6L59p;
	Wed, 16 Jul 2025 20:52:24 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 9CDC314033C;
	Wed, 16 Jul 2025 20:53:35 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 16 Jul
 2025 14:53:35 +0200
Date: Wed, 16 Jul 2025 13:53:33 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <shiju.jose@huawei.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>, <dave@stgolabs.net>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <tanxiaofei@huawei.com>,
	<prime.zeng@hisilicon.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH 1/4] cxl/events: Update Common Event Record to CXL spec
 rev 3.2
Message-ID: <20250716135333.00001670@huawei.com>
In-Reply-To: <20250716104945.2002-2-shiju.jose@huawei.com>
References: <20250716104945.2002-1-shiju.jose@huawei.com>
	<20250716104945.2002-2-shiju.jose@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 16 Jul 2025 11:49:42 +0100
<shiju.jose@huawei.com> wrote:

> From: Shiju Jose <shiju.jose@huawei.com>
> 
> CXL spec 3.2 section 8.2.10.2.1 Table 8-55, Common Event Record format
> defined new fields LD-ID and Head ID.
> 
> LD-ID: ID of logical device from where the event originated, which is
> valid only if LD-ID valid flag is set to 1.
> CXL spec 3.2 Section 2.4 describes, a Type 3 Multi-Logical Device (MLD)
> can partition its resources into up to 16 isolated Logical Devices.
> Each Logical Device is identified by a Logical Device Identifier (LD-ID)
> in CXL.mem and CXL.io protocols. LD-ID is a 16-bit Logical Device
> identifier applicable for CXL.io and CXL.mem requests and responses.
> CXL.mem supports only the lower 4 bits of LD-ID and therefore can support
> up to 16 unique LD-ID values over the link. Requests and responses
> forwarded over an MLD Port are tagged with LD-ID.
> 
> Head ID: ID of the device head, from where the event originated, which is
> valid only if head valid flag is set to 1.
> 
> Add updates for the above spec changes in the CXL events record and CXL
> common trace event implementation.
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
