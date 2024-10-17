Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347501DBB3A;
	Thu, 17 Oct 2024 12:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729167913; cv=none; b=pkyp27pHJXEPOh4mYokIjoB+0btsoq+5kvOEQMOxjnaoSoFTeL+dbFrRpM06BHshLV3Yd7HyURlo85wz95Fpah00/AqQEtkVxAYiMq2O1goUvdXDPJybGX2oxjlNUBZ6xDpmxYe1gAaiHOIr1vKQ2a9l4C83n3TVRHJIkkqeuTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729167913; c=relaxed/simple;
	bh=HOAc7i52uw9GM5U6hFKf2IyVcmV5ukFbRD8mDU3Iick=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rSPvgTsswIp270lVRxc0QhPF7P+Z+6trcvMSTGODud7OYZRNV68JCHojiiT+PdDQGgkyyEeNKlpbRNdNtTZu8HhcvIRp9K40TqOTBC6olW6Tqmen9nukrQfJ1Aib/UQhUSbqfmz1mR+tWvggRuvytfutBXUVK/1KavzJbo0wJJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XTn8C618Jz6JB2C;
	Thu, 17 Oct 2024 20:24:27 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 10C2F1400DB;
	Thu, 17 Oct 2024 20:25:08 +0800 (CST)
Received: from localhost (10.126.174.164) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 17 Oct
 2024 14:25:07 +0200
Date: Thu, 17 Oct 2024 13:25:05 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <shiju.jose@huawei.com>
CC: <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>
Subject: Re: [RFC PATCH 2/4] cxl/events: Updates for CXL General Media Event
 Record
Message-ID: <20241017132505.00004cf4@Huawei.com>
In-Reply-To: <20241016163349.1210-3-shiju.jose@huawei.com>
References: <20241016163349.1210-1-shiju.jose@huawei.com>
	<20241016163349.1210-3-shiju.jose@huawei.com>
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
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 16 Oct 2024 17:33:47 +0100
<shiju.jose@huawei.com> wrote:

> From: Shiju Jose <shiju.jose@huawei.com>
> 
> CXL spec rev 3.1 section 8.2.9.2.1.1 Table 8-45, General Media Event
> Record has updated with following new fields and new types for Memory
> Event Type and Transaction Type fields.
> 1. Advanced Programmable Corrected Memory Error Threshold Event Flags
> 2. Corrected Memory Error Count at Event
> 3. Memory Event Sub-Type
> 
> The component identifier format has changed (CXL spec 3.1 section
> 8.2.9.2.1 Table 8-44).
> 
> Add updates for the above spec changes in the CXL events record and CXL
> general media trace event implementations.
> 
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>

It might be worth breaking out the component ID formatting as
a separate patch.  That comes in 3.1 along with the other fields
but is perhaps more controversial?

It's a good change, but will change what is printed. I 'think'
tracepoint printing is typically not considered ABI though (unlike
the tracepoint which is!) so should be fine.

Split or not I like the component ID formatting and the reset LGTM
I also slight prefer the fact you inserted new fields in logical
places (so disagree with Alison if that's what she meant).
Good to call that out in the patch description though to highlight
it as something people might want to consider.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


> ---
> Question:
> Want more abbreviations for the long lines of code in
> show_mem_event_sub_type() and for similar in other patches?
I raised this in internal review, but don't think it matters
that much either way :)

